$PBExportHeader$w_hac102a.srw
$PBExportComments$계정과목 설명 관리/출력
forward
global type w_hac102a from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
type uo_acct_class from cuo_acct_class within w_hac102a
end type
type gb_1 from groupbox within w_hac102a
end type
end forward

global type w_hac102a from w_tabsheet
integer height = 2616
string title = "계정과목 설명 관리/출력"
uo_acct_class uo_acct_class
gb_1 gb_1
end type
global w_hac102a w_hac102a

type variables
datawindowchild	idw_child
datawindow			idw_data

integer	ii_acct_class


end variables

forward prototypes
public function integer wf_retrieve ()
public function long wf_dup_chk (long al_row, string as_acct_code)
end prototypes

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()	retuen	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_tab

li_tab  = tab_sheet.selectedtab


if idw_data.retrieve(ii_acct_class) > 0 then
	idw_print.retrieve(ii_acct_class)
else
	idw_print.reset()
end if

return 0
end function

public function long wf_dup_chk (long al_row, string as_acct_code);// ==========================================================================================
// 기    능 : 	중복자료 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_dup_chk(long al_row, string as_acct_code) return long
// 인    수 :	al_row : 현재행, as_acct_code : 현재 계정코드
// 되 돌 림 :  중복 : 1, 없으면 : 0
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long	ll_row

SELECT	COUNT(*)	INTO	:LL_ROW	FROM	ACDB.HAC002M
WHERE		ACCT_CODE = :AS_ACCT_CODE ;

if ll_row > 0 then
	messagebox('확인', '이미 등록된 계정과목입니다.')
	return 1
end if

ll_row = idw_data.find("acct_code = '" + as_acct_code + "'", 1, al_row - 1)

if ll_row > 0 then
	messagebox('확인', '이미 등록된 계정과목입니다.')
	return 1
end if

ll_row = idw_data.find("acct_code = '" + as_acct_code + "'", al_row + 1, idw_data.rowcount())

if ll_row > 0 then
	messagebox('확인', '이미 등록된 계정과목입니다.')
	return 1
end if

return 0
end function

on w_hac102a.create
int iCurrent
call super::create
this.uo_acct_class=create uo_acct_class
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_acct_class
this.Control[iCurrent+2]=this.gb_1
end on

on w_hac102a.destroy
call super::destroy
destroy(this.uo_acct_class)
destroy(this.gb_1)
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

String s_name,s_max_no  
int    i_tab,i_newrow
long   l_max_no

integer	li_newrow

if ii_acct_class < 1 then
	f_messagebox('1', '회계단위를 선택해 주세요.!')
	uo_acct_class.dw_commcode.setfocus()
	return
end if



//idw_data.Selectrow(0, false)	

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setitem(li_newrow, 'worker',		gs_empcode) //gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gs_ip)   //gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setrow(li_newrow)

idw_data.setcolumn('acct_code')

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
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update_tab
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
//
//ii_acct_class 	= uo_acct_class.uf_getcode()
//
//tab_sheet.selectedtab = 1
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
integer			li_findrow



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

idw_data		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_print	=	tab_sheet.tabpage_sheet02.dw_print


ii_acct_class 	= uo_acct_class.uf_getcode()

tab_sheet.selectedtab = 1

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

type ln_templeft from w_tabsheet`ln_templeft within w_hac102a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac102a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac102a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac102a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac102a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac102a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac102a
end type

type uc_insert from w_tabsheet`uc_insert within w_hac102a
end type

type uc_delete from w_tabsheet`uc_delete within w_hac102a
end type

type uc_save from w_tabsheet`uc_save within w_hac102a
end type

type uc_excel from w_tabsheet`uc_excel within w_hac102a
end type

type uc_print from w_tabsheet`uc_print within w_hac102a
end type

type st_line1 from w_tabsheet`st_line1 within w_hac102a
end type

type st_line2 from w_tabsheet`st_line2 within w_hac102a
end type

type st_line3 from w_tabsheet`st_line3 within w_hac102a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac102a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac102a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac102a
integer y = 168
integer width = 4384
integer height = 2144
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		FALSE)
//	case else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
end event

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 2024
string text = "계정과목설명관리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer height = 2024
string dataobject = "d_hac102a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;long			ll_cnt
string		ls_acct_code, ls_acct_name
s_insa_com	lstr_com, lstr_Rtn

setitem(row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
setitem(row, 'job_date',	f_sysdate())

choose case dwo.name
	case 'acct_code'
		ls_acct_code = trim(data) + '%'
		
		select	count(*)	into	:ll_cnt
		from		acdb.hac001m
		where		acct_code	like	:ls_acct_code ;
		
		if ll_cnt < 1 then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			messagebox('확인', '등록되지 않은 계정코드입니다.')
			return 1
		end if
		
		if ll_cnt = 1 then
			if wf_dup_chk(row, trim(data)) <> 0 then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
				return 1
			end if

			select	acct_name	into	:ls_acct_name
			from		acdb.hac001m
			where		acct_code	like	:ls_acct_code ;
			
			setitem(row, 'acct_code', trim(data))
			setitem(row, 'acct_name', trim(ls_acct_name))
		else
			lstr_com.ls_item[1]	=	trim(data)
			lstr_com.ls_item[2]	=	''

			OpenWithParm(w_hac000h, lstr_com)

			lstr_Rtn = Message.PowerObjectParm

			if not isvalid(lstr_rtn) then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
				return 1
			end if

			if wf_dup_chk(row, lstr_Rtn.ls_item[1]) <> 0 then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
				return 1
			end if

			setitem(row, 'acct_code', lstr_Rtn.ls_item[1])
			setitem(row, 'acct_name', lstr_Rtn.ls_item[2])
			setcolumn('acct_explain')
			return 1
		end if
end choose

end event

event dw_update_tab::itemerror;call super::itemerror;return 1
end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

type uo_tab from w_tabsheet`uo_tab within w_hac102a
integer x = 1801
integer y = 184
end type

type dw_con from w_tabsheet`dw_con within w_hac102a
boolean visible = false
integer y = 0
integer height = 36
end type

type st_con from w_tabsheet`st_con within w_hac102a
boolean visible = false
integer x = 55
integer y = 0
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2024
long backcolor = 79741120
string text = "계정과목설명내역"
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
integer width = 4334
integer height = 2024
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hac102a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type uo_acct_class from cuo_acct_class within w_hac102a
boolean visible = false
integer x = 183
integer y = 40
integer taborder = 60
boolean bringtotop = true
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class = uf_getcode()

end event

type gb_1 from groupbox within w_hac102a
boolean visible = false
integer y = 20
integer width = 3881
integer height = 200
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회/입력 조건"
end type

