$PBExportHeader$w_uploadservice.srw
forward
global type w_uploadservice from w_ancsheet
end type
type dw_1 from uo_dwgrid within w_uploadservice
end type
type st_1 from statictext within w_uploadservice
end type
type p_add from u_picture within w_uploadservice
end type
type p_delete from u_picture within w_uploadservice
end type
type p_checkall from u_picture within w_uploadservice
end type
type p_uncheckall from u_picture within w_uploadservice
end type
type p_addfile from u_picture within w_uploadservice
end type
type uo_1 from uo_imgbtn within w_uploadservice
end type
type st_apt from statictext within w_uploadservice
end type
type st_app from statictext within w_uploadservice
end type
end forward

global type w_uploadservice from w_ancsheet
dw_1 dw_1
st_1 st_1
p_add p_add
p_delete p_delete
p_checkall p_checkall
p_uncheckall p_uncheckall
p_addfile p_addfile
uo_1 uo_1
st_apt st_apt
st_app st_app
end type
global w_uploadservice w_uploadservice

type prototypes

end prototypes

type variables
private:
	DataStore			ids_data
	Vector				ivc_data
	String				is_serverver			= 'Server.xml'
	String				is_serververpath 	= 'ServerVer'
	String				is_clientver			= 'Version.xml'
	String				is_clientverpath		= 'ClientVer'
	String				is_Versionfile			= 'VersionCheck'

	String				is_path
	String				is_current
	String				is_docpath
end variables

forward prototypes
public subroutine wf_check ()
public function integer wf_upload ()
public function integer wf_versionfile ()
public subroutine inputfile ()
public subroutine wf_server ()
end prototypes

public subroutine wf_check ();Long			row, rowcnt
String			ls_path, ls_name	
DateTime	ldt_olddt, ldt_newdt
n_file			ln_file
String			ls_createtime, ls_lastaccestime, ls_lastwritetime

rowcnt = dw_1.rowcount()
FOR row = rowcnt TO 1 Step -1
	dw_1.scrolltorow(row)
	dw_1.setrow(row)
	
	ls_name 	= dw_1.getItemString(row, 'filename')
	ls_path 		=	dw_1.getItemString(row, 'filepath')
	ldt_olddt 	= dw_1.getItemDateTime(row, 'filenewdate')
	
	ls_path = ls_path + "\" + ls_name
	
	IF FileExists(ls_path) THEN
		//time check======================================
		ln_file.getFileTime(ls_path, ls_createtime, ls_lastaccestime, ls_lastwritetime )
		ldt_newdt = DateTime( Date( Left(ls_lastwritetime, 10) ), Time( Right( ls_lastwritetime, 8 ) ) )
		//=============================================
		IF ldt_olddt <> ldt_newdt THEN
			dw_1.setItem(row, 'filesize', FileLength(ls_path))
			dw_1.setItem(row, 'filenewdate', ldt_newdt)
			dw_1.setItem(row, 'checkupdate', 'Y')
		END IF
	ELSE
		dw_1.deleterow(row)
	END IF
NEXT

end subroutine

public function integer wf_upload ();String 		ls_path, ls_name
DateTime	ldt_time
parameters	param

param.serverurl = ivc_data.getProperty( "uploadserver")

param.parameter[1].param = "UPLOAD_FILE_PATH"
param.parameter[1].param_type = 1
param.parameter[1].data = ivc_data.getProperty("application") + "/" + is_Versionfile  //서버 파일 폴더.

param.parameter[2].param = "useftp"
param.parameter[2].param_type = 1
param.parameter[2].data = "false"

Long		i, row, ll_rowcnt, ll_row
row = 1
ll_rowcnt = dw_1.rowcount()

i = 2
do while true
	Yield()
	row = dw_1.Find("checkupdate = 'Y'", row, ll_rowcnt)
	IF row <= 0 THEN Exit
	
	dw_1.setRow(row)
	dw_1.scrolltoRow(row)
	
	i++
	param.parameter[i].param 			= "uploadfile" + String(i)
	param.parameter[i].param_type 	= 2
	param.parameter[i].data 			= dw_1.getItemString(row, 'filepath') + "\" + dw_1.getItemString(row, 'filename')
	param.parameter[i].rename 		= dw_1.getItemString(row, 'filename')
	ldt_time									= dw_1.getItemDateTime(row, 'filenewdate')
	
	ll_row = ids_data.Find("filename = '" + param.parameter[i].rename + "'", 1, ids_data.rowcount() )
	IF ll_row = 0 THEN
		ll_row = ids_data.insertrow(0)
	END IF
	
	ids_data.setItem(ll_row, 'filename'	, param.parameter[i].rename)
	ids_data.setItem(ll_row, 'filetime'		, ldt_time)
	
	row++
	IF row > ll_rowcnt THEN Exit
loop

return fileuploadexprogress(param)


end function

public function integer wf_versionfile ();String 	ls_path
parameters	param

ls_path 	= is_path + "\" + is_clientver

FileDelete(ls_path)
ids_data.saveas(ls_path, XML!, False)

param.serverurl = ivc_data.getProperty('uploadserver')

param.parameter[1].param = "UPLOAD_FILE_PATH"
param.parameter[1].param_type = 1
param.parameter[1].data = ivc_data.getProperty('application') + "/" + is_clientverpath  //서버 파일 폴더.

param.parameter[2].param = "useftp"
param.parameter[2].param_type = 1
param.parameter[2].data = "false"

param.parameter[3].param = "uploadfile1"
param.parameter[3].param_type = 2
param.parameter[3].data = ls_path
param.parameter[3].rename = is_clientver   //변경될 파일 이름

return fileuploadex(param)
end function

public subroutine inputfile ();string 		docpath, docname[]
integer 		i, li_cnt, li_rtn, li_filenum
Long			ll_row
DateTime	ldt_newdt
n_file			ln_file
String			ls_createtime, ls_lastaccestime, ls_lastwritetime

li_rtn = GetFileOpenName("Select File", docpath, docname[], "PBD", "PB File(*.PBD),*.PBD, Library(*.DLL), *.DLL, All Files(*.*), *.*" , is_docpath, 18)
ChangeDirectory(is_current)
li_cnt = UpperBound(docname)
IF li_cnt = 1 THEN
	docpath = Left(docpath, LastPos(docpath, "\") )
END IF

is_docpath = docpath

FOR i = li_cnt TO 1 Step -1
	Yield()
	//filetime
	ln_file.getFileTime(docpath + "\" + docname[i] , ls_createtime, ls_lastaccestime, ls_lastwritetime )
	ldt_newdt = DateTime( Date( Left(ls_lastwritetime, 10) ), Time( Right( ls_lastwritetime, 8 ) ) )
	//=============================================
	
	ll_row = dw_1.insertrow(0)
	dw_1.setItem(ll_row, 'filepath', docpath)
	dw_1.setItem(ll_row, 'filename', docname[i])
	dw_1.setItem(ll_row, 'filesize', FileLength(docpath + "\" + docname[i]))
	dw_1.setItem(ll_row, 'filenewdate', ldt_newdt)
	dw_1.setItem(ll_Row, 'checkupdate', 'Y')
	dw_1.setRow(ll_row)
	dw_1.scrolltorow(ll_row)
NEXT


end subroutine

public subroutine wf_server ();Parameters		param

is_path 	= is_current + "\" + ivc_data.getProperty("application")
IF Not DirectoryExists(is_path) THEN
	CreateDirectory(is_path)
END IF

param.serverurl = ivc_data.getproperty("downloadserver")

param.defaultpath = is_path

param.filename = is_serverver

param.parameter[1].param = "DOWNLOAD_FILE_PATH"
param.parameter[1].param_type = 1
param.parameter[1].data = ivc_data.getProperty("application") + "/" + is_serververpath

param.parameter[2].param = "downloadfile"
param.parameter[2].param_type = 1
param.parameter[2].data = is_serverver

param.parameter[3].param = "useftp"
param.parameter[3].param_type = 1
param.parameter[3].data = "false"

dw_1.reset()
IF DownloadServletProgress(param) > 0 THEN
	IF FileExists(is_path + "\" + is_serverver) THEN
		dw_1.importFile(XML!, is_path + "\" + is_serverver)
	END IF
END IF

param.filename = is_clientver
param.parameter[1].data = ivc_data.getProperty("application") + "/" + is_clientverpath
param.parameter[2].data = is_clientver

ids_data.reset()
IF DownloadServletProgress(param) > 0 THEN
	IF FileExists(is_path + "\" + is_clientver) THEN
		ids_data.importFile(XML!, is_path + "\" + is_clientver)
	END IF
END IF

wf_check()
end subroutine

on w_uploadservice.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.p_add=create p_add
this.p_delete=create p_delete
this.p_checkall=create p_checkall
this.p_uncheckall=create p_uncheckall
this.p_addfile=create p_addfile
this.uo_1=create uo_1
this.st_apt=create st_apt
this.st_app=create st_app
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.p_add
this.Control[iCurrent+4]=this.p_delete
this.Control[iCurrent+5]=this.p_checkall
this.Control[iCurrent+6]=this.p_uncheckall
this.Control[iCurrent+7]=this.p_addfile
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.st_apt
this.Control[iCurrent+10]=this.st_app
end on

on w_uploadservice.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.p_add)
destroy(this.p_delete)
destroy(this.p_checkall)
destroy(this.p_uncheckall)
destroy(this.p_addfile)
destroy(this.uo_1)
destroy(this.st_apt)
destroy(this.st_app)
end on

event ue_postopen;call super::ue_postopen;ivc_data = Create Vector
ivc_data.importfile("application.props")

IF ivc_data.getProperty('application') = "" THEN
	IF MessageBox("Info", "Libarary를 관리할 Applicataion을 등록하여 주시기 바랍니다.", Information!, OKCancel!, 1) = 1 THEN
		uo_1.Trigger Event Clicked()
	ELSE
		Close(this)
		Return
	END IF
END IF

st_app.text = ivc_data.getProperty('application')

is_current 		= getcurrentdir()
is_docpath 	= is_current

ids_data = Create DataStore
ids_data.Dataobject = 'd_clientversion'

wf_server()

end event

type ln_templeft from w_ancsheet`ln_templeft within w_uploadservice
end type

type ln_tempright from w_ancsheet`ln_tempright within w_uploadservice
end type

type ln_temptop from w_ancsheet`ln_temptop within w_uploadservice
end type

type ln_tempbuttom from w_ancsheet`ln_tempbuttom within w_uploadservice
end type

type ln_tempbutton from w_ancsheet`ln_tempbutton within w_uploadservice
end type

type ln_tempstart from w_ancsheet`ln_tempstart within w_uploadservice
end type

type dw_1 from uo_dwgrid within w_uploadservice
integer x = 46
integer y = 164
integer width = 4393
integer height = 1948
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fileservice_data"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_1 from statictext within w_uploadservice
integer x = 46
integer y = 160
integer width = 4393
integer height = 1956
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
boolean border = true
long bordercolor = 29343163
boolean focusrectangle = false
end type

type p_add from u_picture within w_uploadservice
integer x = 2738
integer y = 36
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_add.gif"
end type

event clicked;call super::clicked;Post inputfile()
end event

type p_delete from u_picture within w_uploadservice
integer x = 3022
integer y = 36
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;Long	row, rowcnt, ll_row

row 		= 1
ll_row		= 1
rowcnt 	= dw_1.rowcount()

dw_1.setRedRaw(false)
do while true
	row = dw_1.Find("checkupdate = 'Y'", 1, rowcnt)
	IF row <= 0 THEN Exit
	
	ll_row = ids_data.Find("filename = '" + dw_1.getItemString(row, 'filename') + "'", ll_row, ids_data.rowcount() )
	IF row > 0 THEN	ids_data.deleterow(ll_row)
	
	dw_1.Deleterow(row)
loop
dw_1.setRedRaw(True)

end event

type p_checkall from u_picture within w_uploadservice
integer x = 3305
integer y = 36
integer width = 366
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_allcheck.gif"
end type

event clicked;call super::clicked;String   ls_check
Long	  ll_cnt, i
ls_check = 'Y'

ll_cnt = dw_1.rowcount()
FOR i = ll_cnt TO 1 Step -1
	dw_1.setItem(i, 'checkupdate', ls_check)
Next
end event

type p_uncheckall from u_picture within w_uploadservice
integer x = 3689
integer y = 36
integer width = 366
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_alluncheck.gif"
end type

event clicked;call super::clicked;String   ls_check
Long	  ll_cnt, i
ls_check = 'N'

ll_cnt = dw_1.rowcount()
FOR i = ll_cnt TO 1 Step -1
	dw_1.setItem(i, 'checkupdate', ls_check)
Next
end event

type p_addfile from u_picture within w_uploadservice
integer x = 4073
integer y = 36
integer width = 366
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_fileappend.gif"
end type

event clicked;call super::clicked;String 		ls_path
Long			li_rtn
parameters	param

li_rtn = wf_upload()
IF li_rtn > 0 THEN
	li_rtn = wf_versionfile()
	IF li_rtn > 0 THEN
		p_uncheckall.TriggerEvent(Clicked!)

		ls_path 	= is_path + "\" + is_serverver
		
		FileDelete(ls_path)
		dw_1.saveas(ls_path, XML!, False)
		
		param.serverurl = ivc_data.getProperty('uploadserver')
		
		param.parameter[1].param 		= "UPLOAD_FILE_PATH"
		param.parameter[1].param_type 	= 1
		param.parameter[1].data 			= ivc_data.getProperty('application') + "/" + is_serververpath //서버 파일 폴더.
		
		param.parameter[2].param 		= "useftp"
		param.parameter[2].param_type 	= 1
		param.parameter[2].data 			= "false"
		
		param.parameter[3].param 		= "uploadfile1"
		param.parameter[3].param_type 	= 2
		param.parameter[3].data 			= ls_path
		param.parameter[3].rename 		= is_serverver   //변경될 파일 이름
		
		fileuploadex(param)
	END IF
END IF

end event

type uo_1 from uo_imgbtn within w_uploadservice
integer x = 46
integer y = 36
integer width = 553
integer taborder = 20
boolean bringtotop = true
string btnname = "Get Application"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;Vector		lvc_data

Open(w_application_pop)

lvc_data = Message.Powerobjectparm
IF IsValid(lvc_data) THEN
	ivc_data = lvc_data
END IF

IF ivc_data.getProperty('application') = "" THEN
	IF MessageBox("Info", "Libarary를 관리할 Applicataion을 등록하여 주시기 바랍니다.", Information!, OKCancel!, 1) = 1 THEN
		this.Trigger Event Clicked()
	ELSE
		Close(Parent)
		Return
	END IF
END IF

ivc_data.exportfile( "application.props" )

st_app.text 	= ivc_data.getProperty('application')
is_path			= is_current + "\" + ivc_data.getProperty('application')

IF Not DirectoryExists(is_path ) THEN
	CreateDirectory(is_path)
END IF

filemanager = Create filemanager
Blob		lb_data
lb_data = Blob("application=" + ivc_data.getProperty('application') + "&downloadserver=" + ivc_data.getProperty("downloadserver"))

filemanager.setFile(is_current + "\" + ivc_data.getProperty('application') + "\downloadinformation.pfe", lb_data, filemanager.OTHER)

Destroy filemanager

wf_server()
end event

type st_apt from statictext within w_uploadservice
integer x = 855
integer y = 52
integer width = 503
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 25123896
long backcolor = 16777215
string text = "Application : "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_app from statictext within w_uploadservice
integer x = 1371
integer y = 52
integer width = 1115
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 25123896
long backcolor = 16777215
boolean focusrectangle = false
end type

