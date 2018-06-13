$PBExportHeader$w_hac104a.srw
$PBExportComments$주관부서별 계정 관리/출력
forward
global type w_hac104a from w_tabsheet
end type
type gb_41 from groupbox within tabpage_sheet01
end type
type dw_update_back from cuo_dwwindow within tabpage_sheet01
end type
type uo_find from cuo_search within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
type tabpage_sheet03 from userobject within tab_sheet
end type
type gb_6 from groupbox within tabpage_sheet03
end type
type dw_list003_back from cuo_dwwindow within tabpage_sheet03
end type
type dw_list002_back from cuo_dwwindow within tabpage_sheet03
end type
type gb_5 from groupbox within tabpage_sheet03
end type
type gb_4 from groupbox within tabpage_sheet03
end type
type rb_select from radiobutton within tabpage_sheet03
end type
type rb_all from radiobutton within tabpage_sheet03
end type
type gb_2 from groupbox within tabpage_sheet03
end type
type st_5 from statictext within tabpage_sheet03
end type
type st_6 from statictext within tabpage_sheet03
end type
type st_2 from statictext within tabpage_sheet03
end type
type dw_list002 from uo_dwgrid within tabpage_sheet03
end type
type dw_list003 from uo_dwgrid within tabpage_sheet03
end type
type pb_1 from uo_imgbtn within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
gb_6 gb_6
dw_list003_back dw_list003_back
dw_list002_back dw_list002_back
gb_5 gb_5
gb_4 gb_4
rb_select rb_select
rb_all rb_all
gb_2 gb_2
st_5 st_5
st_6 st_6
st_2 st_2
dw_list002 dw_list002
dw_list003 dw_list003
pb_1 pb_1
end type
end forward

global type w_hac104a from w_tabsheet
integer height = 2808
string title = "주관부서별 계정과목 관리/출력"
end type
global w_hac104a w_hac104a

type variables
datawindowchild	idw_child, idw_child_end_acct
datawindow			idw_data,  idw_create_list, idw_gwa
datawindow			idw_acct_code


string				is_bdgt_year, is_gwa

string				is_str_acct, is_end_acct

string				is_slip_class

end variables

forward prototypes
public function integer wf_retrieve ()
public function integer wf_dup_chk (long al_row, string as_acct_code)
public subroutine wf_authority_check ()
public subroutine wf_retrieve_create_list ()
end prototypes

public function integer wf_retrieve ();String	ls_name
integer	li_tab

li_tab  = tab_sheet.selectedtab

dw_con.accepttext()
is_bdgt_year = string(dw_con.object.year[1] , 'yyyy')
is_gwa = dw_con.object.code[1]
is_slip_class = dw_con.object.slip_class[1]
If is_slip_class = '%' Then is_slip_class = ''


if idw_data.retrieve(is_bdgt_year, is_gwa, gi_acct_class, is_slip_class) > 0 then
	idw_print.retrieve(is_bdgt_year, is_gwa, gi_acct_class, is_slip_class)

else
	idw_print.reset()
end if

return 0
end function

public function integer wf_dup_chk (long al_row, string as_acct_code);// ==========================================================================================
// 기    능 : 	중복자료 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_dup_chk(long al_row, string as_acct_code) return long
// 인    수 :	al_row : 현재행, as_acct_code : 현재 계정코드
// 되 돌 림 :  중복 : 1, 없으면 : 0
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_bdgt_year, ls_gwa, ls_io_gubun
long		ll_row
integer	li_acct_class

ls_bdgt_year  = idw_data.getitemstring(al_row, 'bdgt_year')
ls_gwa        = idw_data.getitemstring(al_row, 'gwa')
li_acct_class = idw_data.getitemnumber(al_row, 'acct_class')
ls_io_gubun   = idw_data.getitemstring(al_row, 'io_gubun')

SELECT	COUNT(*)	INTO	:LL_ROW	FROM	ACDB.HAC005M
WHERE		BDGT_YEAR = :LS_BDGT_YEAR
AND		GWA = :LS_GWA
AND		ACCT_CODE = :AS_ACCT_CODE
AND		ACCT_CLASS = :LI_ACCT_CLASS
AND		IO_GUBUN = :LS_IO_GUBUN ;

if ll_row > 0 then
	messagebox('확인', '이미 등록된 계정코드입니다.')
	return 1
end if

ll_row = idw_data.find("bdgt_year = '" + ls_bdgt_year + "' and " + &
                       "gwa = '" + ls_gwa + "' and " + &
							  "acct_code = '" + as_acct_code + "' and " + &
							  "acct_class = " + string(li_acct_class) + " and " + &
							  "io_gubun = '" + ls_io_gubun + "'", 1, al_row - 1)

if ll_row > 0 then
	messagebox('확인', '이미 등록된 계정코드입니다.')
	return 1
end if

ll_row = idw_data.find("bdgt_year = '" + ls_bdgt_year + "' and " + &
                       "gwa = '" + ls_gwa + "' and " + &
							  "acct_code = '" + as_acct_code + "' and " + &
							  "acct_class = " + string(li_acct_class) + " and " + &
							  "io_gubun = '" + ls_io_gubun + "'", al_row + 1, idw_data.rowcount())

if ll_row > 0 then
	messagebox('확인', '이미 등록된 계정과목입니다.')
	return 1
end if

return 0
end function

public subroutine wf_authority_check ();// ==========================================================================================
// 기    능 : 	로긴부서에 따라 권한을 체크한다.
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_authority_check()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

long	ll_row

idw_gwa.getchild('code', idw_child)
idw_child.settransobject(sqlca)
idw_child.retrieve(1,2)
idw_child.insertrow(1)
idw_child.setitem(1,'dept_code','')
idw_child.setitem(1,'dept_name','전체')

idw_gwa.insertrow(0)

idw_data.getchild('gwa', idw_child)
idw_child.settransobject(sqlca)
idw_child.retrieve(1,2)

if gi_dept_opt = 2 then
	idw_gwa.setitem(1, 'code', gs_DeptCode)
	is_gwa	=	gs_DeptCode //gstru_uid_uname.dept_code
	idw_gwa.enabled	=	false
	idw_gwa.object.code.background.color = 78682240
	tab_sheet.tabpage_sheet03.pb_1.of_enable(false)
	tab_sheet.tabpage_sheet03.rb_all.enabled	=	false
	tab_sheet.tabpage_sheet03.rb_select.enabled	=	false
else
	idw_gwa.setitem(1, 'code', '')
	is_gwa	=	''
	idw_gwa.enabled	=	true
	idw_gwa.object.code.background.color = rgb(255, 255, 255)
	tab_sheet.tabpage_sheet03.pb_1.of_enable(true)
	
	tab_sheet.tabpage_sheet03.rb_all.enabled	=	true
	tab_sheet.tabpage_sheet03.rb_select.enabled	=	true
end if
return 
end subroutine

public subroutine wf_retrieve_create_list ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve_create_list()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

dw_con.accepttext()
is_bdgt_year = string(dw_con.object.year[1] , 'yyyy')
is_gwa = dw_con.object.code[1]
is_slip_class = dw_con.object.slip_class[1]
If is_slip_class = '%' Then is_slip_class = ''

idw_acct_code.retrieve(is_bdgt_year, gi_acct_class, is_slip_class)
idw_create_list.retrieve(is_bdgt_year, is_gwa, gi_acct_class, is_slip_class)

end subroutine

on w_hac104a.create
int iCurrent
call super::create
end on

on w_hac104a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;// ==========================================================================================
// 작성목정 : data retrieve
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================


wf_retrieve()

return 1
end event

event ue_insert;call super::ue_insert;// ==========================================================================================
// 작성목정 : data insert
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

integer	li_newrow

if trim(is_bdgt_year) = '' or is_bdgt_year = '0000' then
	f_messagebox('1', '등록할 예산년도를 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('year')
	return
end if

if idw_gwa.getitemstring(1, 'code') = '' then
	f_messagebox('1', '등록할 부서를 선택하시기 바랍니다.')
	idw_gwa.setfocus()
	return
end if

if trim(is_slip_class) = '' then
	f_messagebox('1', '등록할 수입/지출을 선택하시기 바랍니다.')
	return
end if



//idw_data.Selectrow(0, false)	

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)

idw_data.setitem(li_newrow, 'bdgt_year', 	is_bdgt_year)
idw_data.setitem(li_newrow, 'gwa', 			is_gwa)
idw_data.setitem(li_newrow, 'acct_class', gi_acct_class)
idw_data.setitem(li_newrow, 'io_gubun', 	is_slip_class)
idw_data.setitem(li_newrow, 'use_yn', 		'Y')
idw_data.setitem(li_newrow, 'worker',		gs_empcode)  // gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gs_ip)   // gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setfocus()



end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 : window open
//// 작 성 인 : 이현수
//// 작성일자 : 2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_data				=	tab_sheet.tabpage_sheet01.dw_update
//
//idw_print			=	tab_sheet.tabpage_sheet02.dw_print
//ist_back				=	tab_sheet.tabpage_sheet02.st_back
//
//idw_acct_code		=	tab_sheet.tabpage_sheet03.dw_list002
//idw_create_list	=	tab_sheet.tabpage_sheet03.dw_list003
//
//ii_acct_class 		= 	uo_acct_class.uf_getcode()
//idw_gwa				=	dw_gwa
//
//is_bdgt_year 		=  uo_year.uf_getyy()
//is_slip_class		=	'2'
//
//uo_year.st_title.text = '예산년도'
//tab_sheet.tabpage_sheet01.uo_find.uf_reset(idw_data, 'acct_code', 'com_acct_name')
//
//wf_authority_check()
//
end event

event ue_save;call super::ue_save;// ==========================================================================================
// 작성목정 : data save
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

cuo_dwwindow	dw_name
integer	li_findrow



dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

IF dw_name.Update(true) = 1 THEN
	COMMIT;
	triggerevent('ue_retrieve')
ELSE
  ROLLBACK;
END IF


return 1

end event

event ue_delete;call super::ue_delete;// ==========================================================================================
// 작성목정 : data delete
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

integer		li_deleterow


wf_setMsg('삭제중')

li_deleterow	=	idw_data.deleterow(0)

wf_setMsg('.')

return 

end event

event ue_print;call super::ue_print;//// ==========================================================================================
//// 작성목정 : data print
//// 작 성 인 : 이현수
//// 작성일자 : 2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//IF idw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, idw_print)
//
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 : window open
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_data				=	tab_sheet.tabpage_sheet01.dw_update_tab

idw_print			=	tab_sheet.tabpage_sheet02.dw_print


idw_acct_code		=	tab_sheet.tabpage_sheet03.dw_list002
idw_create_list	=	tab_sheet.tabpage_sheet03.dw_list003


idw_gwa				=	dw_con

//is_bdgt_year 		=  S
is_slip_class		=	'2'


tab_sheet.tabpage_sheet01.uo_find.uf_reset(idw_data, 'acct_code', 'com_acct_name')

wf_authority_check()

end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hac104a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac104a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac104a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac104a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac104a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac104a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac104a
end type

type uc_insert from w_tabsheet`uc_insert within w_hac104a
end type

type uc_delete from w_tabsheet`uc_delete within w_hac104a
end type

type uc_save from w_tabsheet`uc_save within w_hac104a
end type

type uc_excel from w_tabsheet`uc_excel within w_hac104a
end type

type uc_print from w_tabsheet`uc_print within w_hac104a
end type

type st_line1 from w_tabsheet`st_line1 within w_hac104a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac104a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac104a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac104a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac104a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac104a
integer y = 324
integer width = 4384
integer height = 1976
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//	case 2
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//	case 3
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		fALSE)
//end choose
end event

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
this.tabpage_sheet03=create tabpage_sheet03
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
this.Control[iCurrent+2]=this.tabpage_sheet03
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
destroy(this.tabpage_sheet03)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 1856
long backcolor = 1073741824
string text = "주관부서별계정과목관리"
gb_41 gb_41
dw_update_back dw_update_back
uo_find uo_find
end type

on tabpage_sheet01.create
this.gb_41=create gb_41
this.dw_update_back=create dw_update_back
this.uo_find=create uo_find
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_41
this.Control[iCurrent+2]=this.dw_update_back
this.Control[iCurrent+3]=this.uo_find
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_41)
destroy(this.dw_update_back)
destroy(this.uo_find)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 304
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

event dw_list001::clicked;call super::clicked;//String s_memberno
//IF row > 0 then
//	s_memberno = dw_list001.getItemString(row,'member_no')
//	dw_update101.retrieve(s_memberno)
//end IF
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 9
integer y = 168
integer width = 4338
integer height = 1688
string dataobject = "d_hac104a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;string		ls_acct_code, ls_acct_name
long			ll_cnt
s_insa_com	lstr_com, lstr_Rtn

setitem(row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())	

choose case dwo.name
	case 'acct_code'
		ls_acct_code = trim(data) + '%'
		
		select	count(*)	into	:ll_cnt
		from		acdb.hac001m
		where		acct_code	like	:ls_acct_code
		and		jg_gubun = 'Y'
		and		level_class = '4'
		and		decode(:is_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
		
		if ll_cnt < 1 then
			setitem(row, 'acct_code', '')
			setitem(row, 'com_acct_name', '')
			messagebox('확인', '등록되지 않은 자금계정코드입니다.')
			return 1
		end if
		
		if ll_cnt = 1 then
			if wf_dup_chk(row, trim(data)) <> 0 then
				setitem(row, 'acct_code', '')
				setitem(row, 'com_acct_name', '')
				return 1
			end if

			select	decode(:is_slip_class,'1',acct_iname,'2',acct_oname,acct_name)	into	:ls_acct_name
			from		acdb.hac001m
			where		acct_code	like	:ls_acct_code
			and		jg_gubun = 'Y'
			and		level_class = '4'
			and		decode(:is_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
			
			setitem(row, 'acct_code', trim(data))
			setitem(row, 'com_acct_name', trim(ls_acct_name))
		else
			lstr_com.ls_item[1]	=	trim(data)
			lstr_com.ls_item[2]	=	''
			lstr_com.ls_item[3]	=	string(getitemnumber(row,'acct_class'))
			lstr_com.ls_item[4]	=	getitemstring(row,'io_gubun')

			OpenWithParm(w_hac001h, lstr_com)

			lstr_Rtn = Message.PowerObjectParm

			if not isvalid(lstr_rtn) then
				setitem(row, 'acct_code', '')
				setitem(row, 'com_acct_name', '')
				return 1
			end if

			if wf_dup_chk(row, lstr_Rtn.ls_item[1]) <> 0 then
				setitem(row, 'acct_code', '')
				setitem(row, 'com_acct_name', '')
				return 1
			end if

			setitem(row, 'acct_code', lstr_Rtn.ls_item[1])
			setitem(row, 'com_acct_name',	lstr_Rtn.ls_item[2])
			setcolumn('use_yn')
			return 1
		end if
end choose

end event

event dw_update_tab::itemerror;call super::itemerror;return 1
end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then
	dw_con.setfocus()
	dw_con.setcolumn('year')
else
	setfocus()
end if
end event

type uo_tab from w_tabsheet`uo_tab within w_hac104a
integer x = 1586
integer y = 324
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac104a
string dataobject = "d_hac104a_con"
end type

event dw_con::constructor;call super::constructor;this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
is_bdgt_year = left(f_today(), 4)
end event

event dw_con::itemchanged;call super::itemchanged;dw_con.accepttext()
Choose Case dwo.name
	Case 'year'
		is_bdgt_year = left(data, 4)
	Case 'code'
		is_gwa = trim(data)
	Case 'slip_class'
		is_slip_class	=	data

End Choose
end event

type st_con from w_tabsheet`st_con within w_hac104a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_41 from groupbox within tabpage_sheet01
integer y = -20
integer width = 4352
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type dw_update_back from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 9
integer height = 12
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hac104a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;string		ls_acct_code, ls_acct_name
long			ll_cnt
s_insa_com	lstr_com, lstr_Rtn

setitem(row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())	

choose case dwo.name
	case 'acct_code'
		ls_acct_code = trim(data) + '%'
		
		select	count(*)	into	:ll_cnt
		from		acdb.hac001m
		where		acct_code	like	:ls_acct_code
		and		jg_gubun = 'Y'
		and		level_class = '4'
		and		decode(:is_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
		
		if ll_cnt < 1 then
			setitem(row, 'acct_code', '')
			setitem(row, 'com_acct_name', '')
			messagebox('확인', '등록되지 않은 자금계정코드입니다.')
			return 1
		end if
		
		if ll_cnt = 1 then
			if wf_dup_chk(row, trim(data)) <> 0 then
				setitem(row, 'acct_code', '')
				setitem(row, 'com_acct_name', '')
				return 1
			end if

			select	decode(:is_slip_class,'1',acct_iname,'2',acct_oname,acct_name)	into	:ls_acct_name
			from		acdb.hac001m
			where		acct_code	like	:ls_acct_code
			and		jg_gubun = 'Y'
			and		level_class = '4'
			and		decode(:is_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
			
			setitem(row, 'acct_code', trim(data))
			setitem(row, 'com_acct_name', trim(ls_acct_name))
		else
			lstr_com.ls_item[1]	=	trim(data)
			lstr_com.ls_item[2]	=	''
			lstr_com.ls_item[3]	=	string(getitemnumber(row,'acct_class'))
			lstr_com.ls_item[4]	=	getitemstring(row,'io_gubun')

			OpenWithParm(w_hac001h, lstr_com)

			lstr_Rtn = Message.PowerObjectParm

			if not isvalid(lstr_rtn) then
				setitem(row, 'acct_code', '')
				setitem(row, 'com_acct_name', '')
				return 1
			end if

			if wf_dup_chk(row, lstr_Rtn.ls_item[1]) <> 0 then
				setitem(row, 'acct_code', '')
				setitem(row, 'com_acct_name', '')
				return 1
			end if

			setitem(row, 'acct_code', lstr_Rtn.ls_item[1])
			setitem(row, 'com_acct_name',	lstr_Rtn.ls_item[2])
			setcolumn('use_yn')
			return 1
		end if
end choose

end event

event retrieveend;call super::retrieveend;if rowcount < 1 then
	dw_con.setfocus()
	dw_con.setcolumn('year')
else
	setfocus()
end if
end event

event losefocus;call super::losefocus;accepttext()
end event

event itemerror;call super::itemerror;return 1
end event

type uo_find from cuo_search within tabpage_sheet01
integer x = 41
integer y = 44
integer width = 3342
integer taborder = 50
boolean bringtotop = true
end type

on uo_find.destroy
call cuo_search::destroy
end on

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1856
string text = "주관부서별계정과목내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_sheet02.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_sheet02.destroy
destroy(this.dw_print)
end on

type dw_print from cuo_dwprint within tabpage_sheet02
integer width = 4343
integer height = 1828
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hac104a_3"
boolean vscrollbar = true
boolean border = false
end type

type tabpage_sheet03 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1856
string text = "주관부서별계정생성"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_6 gb_6
dw_list003_back dw_list003_back
dw_list002_back dw_list002_back
gb_5 gb_5
gb_4 gb_4
rb_select rb_select
rb_all rb_all
gb_2 gb_2
st_5 st_5
st_6 st_6
st_2 st_2
dw_list002 dw_list002
dw_list003 dw_list003
pb_1 pb_1
end type

on tabpage_sheet03.create
this.gb_6=create gb_6
this.dw_list003_back=create dw_list003_back
this.dw_list002_back=create dw_list002_back
this.gb_5=create gb_5
this.gb_4=create gb_4
this.rb_select=create rb_select
this.rb_all=create rb_all
this.gb_2=create gb_2
this.st_5=create st_5
this.st_6=create st_6
this.st_2=create st_2
this.dw_list002=create dw_list002
this.dw_list003=create dw_list003
this.pb_1=create pb_1
this.Control[]={this.gb_6,&
this.dw_list003_back,&
this.dw_list002_back,&
this.gb_5,&
this.gb_4,&
this.rb_select,&
this.rb_all,&
this.gb_2,&
this.st_5,&
this.st_6,&
this.st_2,&
this.dw_list002,&
this.dw_list003,&
this.pb_1}
end on

on tabpage_sheet03.destroy
destroy(this.gb_6)
destroy(this.dw_list003_back)
destroy(this.dw_list002_back)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.rb_select)
destroy(this.rb_all)
destroy(this.gb_2)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_2)
destroy(this.dw_list002)
destroy(this.dw_list003)
destroy(this.pb_1)
end on

type gb_6 from groupbox within tabpage_sheet03
integer x = 1006
integer y = -20
integer width = 2112
integer height = 184
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type dw_list003_back from cuo_dwwindow within tabpage_sheet03
boolean visible = false
integer x = 1545
integer y = 436
integer width = 101
integer height = 100
integer taborder = 30
string dragicon = "DataPipeline!"
boolean bringtotop = true
boolean titlebar = true
string title = "주관부서별 계정코드"
string dataobject = "d_hac104a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;call super::clicked;This.setrow(row)
This.Drag(Begin!)
end event

event constructor;call super::constructor;this.uf_setClick(true)
end event

event dragdrop;call super::dragdrop;long			ll_row
datawindow	ldw_from, ldw_to

this.Drag(End!)

if source <> this then
	ldw_from	=	source
	ldw_to	=	this

	if ldw_from.getrow() < 1 then return
	
	ll_row = ldw_to.insertrow(0)

	ldw_to.setitem(ll_row, 'bdgt_year', 	is_bdgt_year)
	ldw_to.setitem(ll_row, 'gwa',				is_gwa)
	ldw_to.setitem(ll_row, 'fname',			idw_gwa.getitemstring(idw_gwa.getrow(), 'code_name'))
	ldw_to.setitem(ll_row, 'acct_code', 	ldw_from.getitemstring(ldw_from.getrow(), 'acct_code'))
	ldw_to.setitem(ll_row, 'acct_name',		ldw_from.getitemstring(ldw_from.getrow(), 'acct_name'))
	ldw_to.setitem(ll_row, 'acct_class',	gi_acct_class)
	ldw_to.setitem(ll_row, 'io_gubun',		is_slip_class)
	ldw_to.setitem(ll_row, 'use_yn',			'Y')
	ldw_to.setitem(ll_row, 'worker',			gs_empcode)  // gstru_uid_uname.uid)
	ldw_to.setitem(ll_row, 'ipaddr',			gs_ip)   // gstru_uid_uname.address)
	ldw_to.SetItem(ll_row, 'work_date', 	f_sysdate())
	ldw_to.setitem(ll_row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
	ldw_to.setitem(ll_row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
	ldw_to.SetItem(ll_row, 'job_date', 		f_sysdate())

	ldw_to.sort()
	ldw_from.deleterow(0)
end if	

end event

event itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())

end event

event losefocus;call super::losefocus;accepttext()

end event

event doubleclicked;call super::doubleclicked;string		ls_acct_code, ls_acct_name
long			ll_row
datawindow	ldw_to

ldw_to = idw_acct_code

if row < 1 then return

ll_row = ldw_to.insertrow(0)

ls_acct_code	=	this.getitemstring(row, 'acct_code')
ls_acct_name	=	this.getitemstring(row, 'acct_name')

ldw_to.setitem(ll_row, 'acct_code',		ls_acct_code)
ldw_to.setitem(ll_row, 'acct_name',		ls_acct_name)

ldw_to.sort()
this.deleterow(row)

end event

type dw_list002_back from cuo_dwwindow within tabpage_sheet03
boolean visible = false
integer x = 965
integer y = 452
integer width = 101
integer height = 100
integer taborder = 20
string dragicon = "DataPipeline!"
boolean bringtotop = true
boolean titlebar = true
string title = "전체 계정코드"
string dataobject = "d_hac104a_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;call super::clicked;This.setrow(row)
This.Drag(Begin!)
end event

event constructor;call super::constructor;this.uf_setClick(true)
end event

event doubleclicked;call super::doubleclicked;long			ll_row
datawindow	ldw_to

ldw_to = idw_create_list

if row < 1 then return

ll_row = ldw_to.insertrow(0)

ldw_to.setitem(ll_row, 'bdgt_year', is_bdgt_year)
ldw_to.setitem(ll_row, 'gwa', 		is_gwa)
ldw_to.setitem(ll_row, 'fname', 		idw_gwa.getitemstring(idw_gwa.getrow(), 'code_name'))
ldw_to.setitem(ll_row, 'acct_code', this.getitemstring(row, 'acct_code'))
ldw_to.setitem(ll_row, 'acct_name', this.getitemstring(row, 'acct_name'))
ldw_to.setitem(ll_row, 'acct_class',gi_acct_class)
ldw_to.setitem(ll_row, 'io_gubun', 	is_slip_class)
ldw_to.setitem(ll_row, 'use_yn', 	'Y')
ldw_to.setitem(ll_row, 'worker',		gs_empcode)  // gstru_uid_uname.uid)
ldw_to.setitem(ll_row, 'ipaddr',		gs_ip)   // gstru_uid_uname.address)
ldw_to.SetItem(ll_row, 'work_date', f_sysdate())
ldw_to.setitem(ll_row, 'job_uid',	gs_empcode)  // gstru_uid_uname.uid)
ldw_to.setitem(ll_row, 'job_add',	gs_ip)   // gstru_uid_uname.address)
ldw_to.SetItem(ll_row, 'job_date', 	f_sysdate())

ldw_to.sort()
this.deleterow(row)

end event

event dragdrop;call super::dragdrop;string		ls_acct_code, ls_acct_name
long			ll_row
datawindow	ldw_from, ldw_to

this.Drag(End!)

if source <> this then
	ldw_from	=	source
	ldw_to	=	this

	if ldw_from.getrow() < 1 then return
	
	ll_row = ldw_to.insertrow(0)

	ls_acct_code	=	ldw_from.getitemstring(ldw_from.getrow(), 'acct_code')
	ls_acct_name	=	ldw_from.getitemstring(ldw_from.getrow(), 'acct_name')
	
	ldw_to.setitem(ll_row, 'acct_code',		ls_acct_code)
	ldw_to.setitem(ll_row, 'acct_name',		ls_acct_name)

	ldw_to.sort()
	ldw_from.deleterow(0)
end if	

end event

type gb_5 from groupbox within tabpage_sheet03
integer y = -20
integer width = 1001
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_4 from groupbox within tabpage_sheet03
integer x = 3122
integer y = -20
integer width = 1216
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type rb_select from radiobutton within tabpage_sheet03
integer x = 494
integer y = 60
integer width = 379
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "계정과목별"
boolean checked = true
end type

event clicked;rb_all.textcolor 		= rgb(0, 0, 0)
rb_select.textcolor 	= rgb(0, 0, 255)

if isnull(is_gwa) or trim(is_gwa) = '' then	return
if isnull(is_slip_class) or trim(is_slip_class) = '' then return

setpointer(hourglass!)
wf_retrieve_create_list()
setpointer(arrow!)

end event

type rb_all from radiobutton within tabpage_sheet03
integer x = 151
integer y = 60
integer width = 238
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "전체"
end type

event clicked;long		ll_row, ll_add_row, ll_rowcount

rb_all.textcolor 		= rgb(0, 0, 255)
rb_select.textcolor 	= rgb(0, 0, 0)

if isnull(is_gwa) or trim(is_gwa) = '' then	return
if isnull(is_slip_class) or trim(is_slip_class) = '' then return

setpointer(hourglass!)

wf_retrieve_create_list()

ll_rowcount	=	idw_acct_code.rowcount()
for ll_row = 1 to ll_rowcount
	ll_add_row = idw_create_list.insertrow(0)
	idw_create_list.setitem(ll_add_row, 'bdgt_year',			is_bdgt_year)
	idw_create_list.setitem(ll_add_row, 'gwa',					is_gwa)
	idw_create_list.setitem(ll_add_row, 'fname',					idw_gwa.getitemstring(idw_gwa.getrow(), 'code_name'))
	idw_create_list.setitem(ll_add_row, 'acct_code',			idw_acct_code.getitemstring(ll_row, 'acct_code'))
	idw_create_list.setitem(ll_add_row,	'acct_name',			idw_acct_code.getitemstring(ll_row, 'acct_name'))
	idw_create_list.setitem(ll_add_row,	'acct_class',			gi_acct_class)
	idw_create_list.setitem(ll_add_row,	'io_gubun',				is_slip_class)
	idw_create_list.setitem(ll_add_row, 'use_yn', 				'Y')
	idw_create_list.setitem(ll_add_row, 'worker',				gs_empcode)  // gstru_uid_uname.uid)
	idw_create_list.setitem(ll_add_row, 'ipaddr',				gs_ip)   // gstru_uid_uname.address)
	idw_create_list.SetItem(ll_add_row, 'work_date',			f_sysdate())
	idw_create_list.setitem(ll_add_row, 'job_uid',				gs_empcode)  // gstru_uid_uname.uid)
	idw_create_list.setitem(ll_add_row, 'job_add',				gs_ip)   // gstru_uid_uname.address)
	idw_create_list.SetItem(ll_add_row, 'job_date',				f_sysdate())
next	

idw_acct_code.reset()
idw_create_list.sort()

setpointer(arrow!)

end event

type gb_2 from groupbox within tabpage_sheet03
integer y = 144
integer width = 4338
integer height = 288
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type st_5 from statictext within tabpage_sheet03
integer x = 151
integer y = 212
integer width = 3634
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "※ ~"주관부서별 계정~"생성 : ~"전체 계정코드~"에서 생성할 계정을 클릭한 채 ~"주관부서별 계정코드~"로 마우스를 이동시키거나 더블클릭합니다."
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_sheet03
integer x = 151
integer y = 280
integer width = 3616
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "   ~"주관부서별 계정~"삭제 : ~"주관부서별 계정코드~"에서 계정을 클릭한 후 ~"전체계정코드~"로 마우스를 이동시키거나 더블클릭합니다."
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_sheet03
integer x = 151
integer y = 348
integer width = 3616
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777407
string text = "★ ~"주관부서별 계정코드~"의 자료가 변동되었을 경우 자료를 확인한 후 ~"계정생성처리~" 버튼을 반드시 클릭해 주세요."
boolean focusrectangle = false
end type

type dw_list002 from uo_dwgrid within tabpage_sheet03
integer y = 436
integer width = 1545
integer height = 1416
integer taborder = 40
boolean titlebar = true
string title = "전체 계정코드"
string dataobject = "d_hac104a_4"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event clicked;call super::clicked;This.setrow(row)
This.Drag(Begin!)
end event

event doubleclicked;call super::doubleclicked;long			ll_row
datawindow	ldw_to

ldw_to = idw_create_list

if row < 1 then return

ll_row = ldw_to.insertrow(0)

ldw_to.setitem(ll_row, 'bdgt_year', is_bdgt_year)
ldw_to.setitem(ll_row, 'gwa', 		is_gwa)
ldw_to.setitem(ll_row, 'fname', 		idw_gwa.getitemstring(idw_gwa.getrow(), 'code_name'))
ldw_to.setitem(ll_row, 'acct_code', this.getitemstring(row, 'acct_code'))
ldw_to.setitem(ll_row, 'acct_name', this.getitemstring(row, 'acct_name'))
ldw_to.setitem(ll_row, 'acct_class',gi_acct_class)
ldw_to.setitem(ll_row, 'io_gubun', 	is_slip_class)
ldw_to.setitem(ll_row, 'use_yn', 	'Y')
ldw_to.setitem(ll_row, 'worker',		gs_empcode)  // gstru_uid_uname.uid)
ldw_to.setitem(ll_row, 'ipaddr',		gs_ip)   // gstru_uid_uname.address)
ldw_to.SetItem(ll_row, 'work_date', f_sysdate())
ldw_to.setitem(ll_row, 'job_uid',	gs_empcode)  // gstru_uid_uname.uid)
ldw_to.setitem(ll_row, 'job_add',	gs_ip)   // gstru_uid_uname.address)
ldw_to.SetItem(ll_row, 'job_date', 	f_sysdate())

ldw_to.sort()
this.deleterow(row)

end event

event dragdrop;call super::dragdrop;string		ls_acct_code, ls_acct_name
long			ll_row
datawindow	ldw_from, ldw_to

this.Drag(End!)

if source <> this then
	ldw_from	=	source
	ldw_to	=	this

	if ldw_from.getrow() < 1 then return
	
	ll_row = ldw_to.insertrow(0)

	ls_acct_code	=	ldw_from.getitemstring(ldw_from.getrow(), 'acct_code')
	ls_acct_name	=	ldw_from.getitemstring(ldw_from.getrow(), 'acct_name')
	
	ldw_to.setitem(ll_row, 'acct_code',		ls_acct_code)
	ldw_to.setitem(ll_row, 'acct_name',		ls_acct_name)

	ldw_to.sort()
	ldw_from.deleterow(0)
end if	

end event

type dw_list003 from uo_dwgrid within tabpage_sheet03
integer x = 1545
integer y = 436
integer width = 2789
integer height = 1416
integer taborder = 50
boolean titlebar = true
string title = "주관부서별 계정코드"
string dataobject = "d_hac104a_2"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())

end event

event clicked;call super::clicked;This.setrow(row)
This.Drag(Begin!)
end event

event doubleclicked;call super::doubleclicked;string		ls_acct_code, ls_acct_name
long			ll_row
datawindow	ldw_to

ldw_to = idw_acct_code

if row < 1 then return

ll_row = ldw_to.insertrow(0)

ls_acct_code	=	this.getitemstring(row, 'acct_code')
ls_acct_name	=	this.getitemstring(row, 'acct_name')

ldw_to.setitem(ll_row, 'acct_code',		ls_acct_code)
ldw_to.setitem(ll_row, 'acct_name',		ls_acct_name)

ldw_to.sort()
this.deleterow(row)

end event

event dragdrop;call super::dragdrop;long			ll_row
datawindow	ldw_from, ldw_to

this.Drag(End!)

if source <> this then
	ldw_from	=	source
	ldw_to	=	this

	if ldw_from.getrow() < 1 then return
	
	ll_row = ldw_to.insertrow(0)

	ldw_to.setitem(ll_row, 'bdgt_year', 	is_bdgt_year)
	ldw_to.setitem(ll_row, 'gwa',				is_gwa)
	ldw_to.setitem(ll_row, 'fname',			idw_gwa.getitemstring(idw_gwa.getrow(), 'code_name'))
	ldw_to.setitem(ll_row, 'acct_code', 	ldw_from.getitemstring(ldw_from.getrow(), 'acct_code'))
	ldw_to.setitem(ll_row, 'acct_name',		ldw_from.getitemstring(ldw_from.getrow(), 'acct_name'))
	ldw_to.setitem(ll_row, 'acct_class',	gi_acct_class)
	ldw_to.setitem(ll_row, 'io_gubun',		is_slip_class)
	ldw_to.setitem(ll_row, 'use_yn',			'Y')
	ldw_to.setitem(ll_row, 'worker',			gs_empcode)  // gstru_uid_uname.uid)
	ldw_to.setitem(ll_row, 'ipaddr',			gs_ip)   // gstru_uid_uname.address)
	ldw_to.SetItem(ll_row, 'work_date', 	f_sysdate())
	ldw_to.setitem(ll_row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
	ldw_to.setitem(ll_row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
	ldw_to.SetItem(ll_row, 'job_date', 		f_sysdate())

	ldw_to.sort()
	ldw_from.deleterow(0)
end if	

end event

event losefocus;call super::losefocus;accepttext()

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type pb_1 from uo_imgbtn within tabpage_sheet03
event destroy ( )
integer x = 3479
integer y = 44
integer taborder = 51
boolean bringtotop = true
string btnname = "계정생성처리"
end type

on pb_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;// 주관부서별 계정코드 자료 검색
if idw_create_list.rowcount() < 1 then
	f_messagebox('1', '생성 대상자료가 없습니다.')
	idw_acct_code.setfocus()
	return
end if

if idw_create_list.update()	=	1	then
	commit	;
	f_messagebox('1', '주관부서별 계정코드 일괄생성처리를 성공했습니다.!')
else	
	rollback	;
	f_messagebox('3', '주관부서별 계정코드 일괄생성처리를 실패했습니다.!')
end if

end event

