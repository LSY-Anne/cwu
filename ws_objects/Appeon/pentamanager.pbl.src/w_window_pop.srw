$PBExportHeader$w_window_pop.srw
forward
global type w_window_pop from w_default_response
end type
type ddlb_list from dropdownlistbox within w_window_pop
end type
type r_1 from rectangle within w_window_pop
end type
type r_2 from rectangle within w_window_pop
end type
type st_2 from statictext within w_window_pop
end type
type p_search from u_picture within w_window_pop
end type
type ddlb_type from dropdownlistbox within w_window_pop
end type
end forward

global type w_window_pop from w_default_response
integer width = 1774
string title = "Window List"
ddlb_list ddlb_list
r_1 r_1
r_2 r_2
st_2 st_2
p_search p_search
ddlb_type ddlb_type
end type
global w_window_pop w_window_pop

type variables
String is_appname
end variables

forward prototypes
public subroutine wf_insert_pbllist (string as_path, string as_data)
private subroutine wf_pbllist (string as_fullpath, ref string as_pbllist[])
public subroutine wf_getpbllist (ref string as_pbllist[])
public subroutine wf_librarylist ()
end prototypes

public subroutine wf_insert_pbllist (string as_path, string as_data);/*=김영배 수석.=======================================
	V1.9.9.015   - pentamanager.pbl의 w_window_pop 기능 개선
      * wf_librarylist(), wf_getpbllist() 함수 추가.
      * Library List Search 기능 개선.
      * PB Target에서 Library 정보를 읽어낼 경우, Library Path에 한글이 들어가거나 공백 문자가 들어간 경우
         PB Target ( PBT ) 파일에 정보가 잘못 들어간다. 이 경우에 원하는 작업을 할 수가 없다.
      * 이것을 GetLibraryList() 함수를 이용하여 현재 PB Target에 있는 Library 정보를 읽어서 사용할 수 있도록
         변경했다.
=========================================*/
String 			ls_pbllist[], ls_item, ls_filetime
Integer 			li_num, li_x, li_pos, li_lastpos = 1

// Argument 예
// as_path : e:\support\eas41\
// as_data : test.pbt

wf_pbllist( as_path, ls_pbllist )
li_num = UpperBound(ls_pbllist)

FOR li_x = 1 TO li_num
	ls_item = ls_pbllist[li_x]
	
	DO 
		li_pos = Pos(ls_item, "\\", li_lastpos)
		IF li_pos > 0 THEN
			ls_item = Replace(ls_item, li_pos, 2, "\")
			li_lastpos = li_pos + 2
		END IF	
	LOOP UNTIL li_pos = 0  	 	
	
	ddlb_list.additem( ls_item)
	
	li_lastpos = 1 // 찾는위치 초기화!
NEXT
end subroutine

private subroutine wf_pbllist (string as_fullpath, ref string as_pbllist[]);Integer 			li_filenum,  li_loop, li_lastpos, li_pos1, li_pos2, li_x, li_index, li_len
Long 				ll_filelen
String 			ls_filepath, ls_pblinfo, ls_fileseg, ls_liblist
Boolean 			lb_init = True

ll_filelen = FileLength(as_fullpath)
li_filenum = FileOpen(as_fullpath, StreamMode!, Read!, LockWrite!)
IF ll_filelen > 32765 THEN
	IF Mod(ll_filelen, 32765) = 0 THEN
		li_loop = ll_filelen/32765
	ELSE
		li_loop = (ll_filelen/32765) + 1
	END IF
ELSE
	li_loop = 1 
END IF

FOR li_x = 1 TO li_loop
	 FileRead(li_filenum, ls_fileseg)
	 ls_pblinfo = ls_pblinfo + ls_fileseg
NEXT

FileClose(li_filenum)

li_lastpos = Pos(Lower(ls_pblinfo), "appname", 1)
IF li_lastpos = 0 THEN 
	MessageBox("알림!", "Web Target 입니다!")
	Return
END IF

li_pos1 = Pos(ls_pblinfo, '"', li_lastpos)
li_pos2 = Pos(ls_pblinfo, '"', li_pos1 + 1)

is_appname = Mid(ls_pblinfo, li_pos1 + 1, li_pos2 - (li_pos1 + 1) ) //Application 오브젝트명 저장

//LastPos() 함수는 대소문자를 가린다.
li_lastpos = LastPos(Lower(ls_pblinfo), "liblist") //8.0
IF li_lastpos = 0 THEN 
	li_lastpos = LastPos(Lower(ls_pblinfo), "LibList") //9.0
END IF
li_pos1 = Pos(ls_pblinfo, '"', li_lastpos)
li_pos2 = Pos(ls_pblinfo, '"', li_pos1 + 1)

ls_liblist = Mid(ls_pblinfo, li_pos1 + 1, li_pos2 - (li_pos1 + 1) ) //Library List 저장

li_lastpos = 1
li_index = 1
li_len = Len(ls_liblist)
DO 
	li_pos1 = Pos(ls_liblist, ";", li_lastpos)
	IF lb_init = True THEN
		IF li_pos1 = 0 THEN
			as_pbllist[li_index] = Mid(ls_liblist, li_lastpos, li_len)
		ELSE
			as_pbllist[li_index] = Mid(ls_liblist, li_lastpos, li_pos1 - li_lastpos)
		END IF
		lb_init = False
	ELSE
		IF li_pos1 = 0 THEN
			as_pbllist[li_index] = Mid(ls_liblist, li_lastpos, li_len - li_lastpos + 1)
		ELSE
			as_pbllist[li_index] = Mid(ls_liblist, li_lastpos, li_pos1 - li_lastpos)
		END IF
	END IF
	li_index ++
	li_lastpos = li_pos1 + 1
LOOP UNTIL li_pos1 = 0
end subroutine

public subroutine wf_getpbllist (ref string as_pbllist[]);/*=김영배 수석.=======================================
	V1.9.9.015   - pentamanager.pbl의 w_window_pop 기능 개선
      * wf_librarylist(), wf_getpbllist() 함수 추가.
      * Library List Search 기능 개선.
      * PB Target에서 Library 정보를 읽어낼 경우, Library Path에 한글이 들어가거나 공백 문자가 들어간 경우
         PB Target ( PBT ) 파일에 정보가 잘못 들어간다. 이 경우에 원하는 작업을 할 수가 없다.
      * 이것을 GetLibraryList() 함수를 이용하여 현재 PB Target에 있는 Library 정보를 읽어서 사용할 수 있도록
         변경했다.
=========================================*/
Integer 				li_lastpos, li_pos1, li_pos2, li_x, li_index, li_len
String 				ls_librarylist
Boolean 			lb_init = True

ls_librarylist = getlibrarylist()

li_lastpos = 1
li_index = 1
li_len = Len(ls_librarylist)
DO 
	li_pos1 = Pos(ls_librarylist, ",", li_lastpos)
	IF lb_init = True THEN
		IF li_pos1 = 0 THEN
			as_pbllist[li_index] = Mid(ls_librarylist, li_lastpos, li_len)
		ELSE
			as_pbllist[li_index] = Mid(ls_librarylist, li_lastpos, li_pos1 - li_lastpos)
		END IF
		lb_init = False
	ELSE
		IF li_pos1 = 0 THEN
			as_pbllist[li_index] = Mid(ls_librarylist, li_lastpos, li_len - li_lastpos + 1)
		ELSE
			as_pbllist[li_index] = Mid(ls_librarylist, li_lastpos, li_pos1 - li_lastpos)
		END IF
	END IF
	li_index ++
	li_lastpos = li_pos1 + 1
LOOP UNTIL li_pos1 = 0
end subroutine

public subroutine wf_librarylist ();/*=김영배 수석.=======================================
	V1.9.9.015   - pentamanager.pbl의 w_window_pop 기능 개선
      * wf_librarylist(), wf_getpbllist() 함수 추가.
      * Library List Search 기능 개선.
      * PB Target에서 Library 정보를 읽어낼 경우, Library Path에 한글이 들어가거나 공백 문자가 들어간 경우
         PB Target ( PBT ) 파일에 정보가 잘못 들어간다. 이 경우에 원하는 작업을 할 수가 없다.
      * 이것을 GetLibraryList() 함수를 이용하여 현재 PB Target에 있는 Library 정보를 읽어서 사용할 수 있도록
         변경했다.
=========================================*/
String 			ls_pbllist[], ls_item, ls_filetime
Integer 			li_num, li_x, li_pos, li_lastpos = 1

wf_getpbllist( ls_pbllist )
li_num = UpperBound(ls_pbllist)

FOR li_x = 1 TO li_num
	ls_item = ls_pbllist[li_x]
	
	DO 
		li_pos = Pos(ls_item, "\\", li_lastpos)
		IF li_pos > 0 THEN
			ls_item = Replace(ls_item, li_pos, 2, "\")
			li_lastpos = li_pos + 2
		END IF	
	LOOP UNTIL li_pos = 0  	 	
	
	ddlb_list.additem( ls_item)
	
	li_lastpos = 1 // 찾는위치 초기화!
NEXT
end subroutine

on w_window_pop.create
int iCurrent
call super::create
this.ddlb_list=create ddlb_list
this.r_1=create r_1
this.r_2=create r_2
this.st_2=create st_2
this.p_search=create p_search
this.ddlb_type=create ddlb_type
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_list
this.Control[iCurrent+2]=this.r_1
this.Control[iCurrent+3]=this.r_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.p_search
this.Control[iCurrent+6]=this.ddlb_type
end on

on w_window_pop.destroy
call super::destroy
destroy(this.ddlb_list)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.st_2)
destroy(this.p_search)
destroy(this.ddlb_type)
end on

event open;call super::open;//원본.
//is_appname = GetApplication().classname()
//wf_insert_pbllist( getcurrentdirectory() + '\' + is_appname + '.pbt', '' )
//수정본.
wf_librarylist()
end event

type st_1 from w_default_response`st_1 within w_window_pop
integer x = 69
integer y = 72
end type

type uc_insert from w_default_response`uc_insert within w_window_pop
boolean visible = false
end type

type uc_cancel from w_default_response`uc_cancel within w_window_pop
integer x = 1449
end type

event uc_cancel::clicked;call super::clicked;Vector	lvc_data
lvc_data = Create Vector

lvc_data.setProperty('classname', '' )
lvc_data.setProperty('comment', '' )

ClosewithReturn(Parent, lvc_data)
end event

type uc_close from w_default_response`uc_close within w_window_pop
boolean visible = false
end type

type uc_delete from w_default_response`uc_delete within w_window_pop
boolean visible = false
end type

type uc_excel from w_default_response`uc_excel within w_window_pop
boolean visible = false
end type

type uc_ok from w_default_response`uc_ok within w_window_pop
integer x = 1157
end type

event uc_ok::clicked;call super::clicked;String		ls_temp
Long			ll_row
Vector	lvc_data
lvc_data = Create Vector

ll_row = dw_multi.getrow()
IF ll_row > 0 THEN
	ls_temp = dw_multi.GetItemString(ll_row, 'classname')
	if isnull( ls_temp ) then ls_temp = ''
	lvc_data.setProperty('classname', ls_temp)
	
	ls_temp  = dw_multi.GetItemString(ll_row, 'comment')
	if isnull( ls_temp ) then ls_temp = ''
	lvc_data.setProperty('comment', ls_temp)
	
	ClosewithReturn(Parent, lvc_data)
END IF
end event

type uc_print from w_default_response`uc_print within w_window_pop
boolean visible = false
end type

type uc_run from w_default_response`uc_run within w_window_pop
boolean visible = false
end type

type uc_save from w_default_response`uc_save within w_window_pop
boolean visible = false
end type

type uc_retrieve from w_default_response`uc_retrieve within w_window_pop
boolean visible = false
end type

type dw_multi from w_default_response`dw_multi within w_window_pop
integer y = 288
integer width = 1678
integer height = 1260
string dataobject = "d_liblist"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_multi::doubleclicked;call super::doubleclicked;String		ls_temp
Vector	lvc_data
lvc_data = Create Vector

ls_temp = Upper(This.GetItemString(row, 'classname'))
if isnull( ls_temp ) then ls_temp = ''
lvc_data.setProperty('classname', ls_temp)

ls_temp  = This.GetItemString(row, 'comment')
if isnull( ls_temp ) then ls_temp = ''
lvc_data.setProperty('comment', ls_temp)

ClosewithReturn(Parent, lvc_data)
end event

type ln_templeft from w_default_response`ln_templeft within w_window_pop
end type

type ln_tempright from w_default_response`ln_tempright within w_window_pop
end type

type ln_tempstart from w_default_response`ln_tempstart within w_window_pop
end type

type ln_4 from w_default_response`ln_4 within w_window_pop
end type

type ln_temptop from w_default_response`ln_temptop within w_window_pop
end type

type ln_tempbutton from w_default_response`ln_tempbutton within w_window_pop
end type

type ddlb_list from dropdownlistbox within w_window_pop
integer x = 475
integer y = 172
integer width = 1216
integer height = 512
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean autohscroll = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String 				ls_entries, ls_win

ls_entries = LibraryDirectory( This.Text(index), DirWindow!)
dw_multi.reset()
dw_multi.importstring(ls_entries)

end event

type r_1 from rectangle within w_window_pop
long linecolor = 25988236
integer linethickness = 4
long fillcolor = 32106985
integer x = 46
integer y = 164
integer width = 1673
integer height = 96
end type

type r_2 from rectangle within w_window_pop
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 32106985
integer x = 46
integer y = 284
integer width = 1678
integer height = 1268
end type

type st_2 from statictext within w_window_pop
integer x = 69
integer y = 192
integer width = 398
integer height = 48
integer textsize = -8
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 21519471
long backcolor = 32106985
string text = "Library List"
boolean focusrectangle = false
end type

type p_search from u_picture within w_window_pop
boolean visible = false
integer x = 814
integer y = 36
integer width = 265
integer height = 84
string picturename = "..\img\button\topBtn_search.gif"
end type

event clicked;call super::clicked;integer	li_rtn
string	ls_filepath, ls_file

li_rtn = GetFileOpenName("Select File", ls_filepath, ls_file, "PBT", "PBT Files(*.PBT), *.PBT," &
			 + "All Files (*.*), *.*" )


wf_insert_pbllist( ls_filepath, ls_file )

 
end event

type ddlb_type from dropdownlistbox within w_window_pop
boolean visible = false
integer x = 475
integer y = 172
integer width = 393
integer height = 300
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string item[] = {"PBT","PBL"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//String	ls_type
//ls_type = ddlb_type.Text ( index )
//
//
//wf_insert_pbllist( '', '' )
//
end event

