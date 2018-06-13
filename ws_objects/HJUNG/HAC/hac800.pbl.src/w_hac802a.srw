$PBExportHeader$w_hac802a.srw
$PBExportComments$예산통제관리(기타구입건)
forward
global type w_hac802a from w_tabsheet
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
end forward

global type w_hac802a from w_tabsheet
string title = "요구기간 관리/출력"
end type
global w_hac802a w_hac802a

type variables
datawindowchild	idw_child
datawindow			idw_data



//string				is_bdgt_year

end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 통제구분
idw_data.getchild('item_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('ord_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
else
	idw_child.setfilter("code in (1, 3, 7, 999)")
	idw_child.filter()
end if

idw_print.getchild('item_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('ord_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_fr_date, ls_to_date, ls_ok_yn


dw_con.accepttext()

ls_fr_date = string(dw_con.object.fr_date[1], 'yyyymmdd')
ls_to_date = string(dw_con.object.to_date[1], 'yyyymmdd')
ls_ok_yn = dw_con.object.ok_yn[1]



idw_data.retrieve(ls_fr_date, ls_to_date)

If ls_ok_yn = 'Y' Then
	idw_data.setfilter("")
	idw_data.filter()
else
	idw_data.setfilter("item_gbn = 1")
	idw_data.filter()
end if
idw_data.sort()

if idw_print.retrieve(ls_fr_date, ls_to_date) > 0 then

else
	idw_print.reset()
end if

return 0
end function

on w_hac802a.create
int iCurrent
call super::create
end on

on w_hac802a.destroy
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


String ls_fr_date, ls_to_date

dw_con.accepttext()
ls_fr_date = string(dw_con.object.fr_date[1], 'yyyymmdd')
ls_to_date = string(dw_con.object.to_date[1], 'yyyymmdd')

if ls_fr_date > ls_to_date then
	messagebox('확인', '신청기간의 범위를 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return -1
end if



wf_retrieve()

return 1
end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 : window open
//// 작 성 인 : 이현수
//// 작성일자 : 2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//string	ls_sys_date, ls_bdgt_year, ls_from_date
//
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
//
//ls_sys_date = f_today()
//
////예산,회계년도 및 기간...
//SELECT BDGT_YEAR,   		FROM_DATE  
//  INTO :ls_bdgt_year, 	:ls_from_date
//  FROM ACDB.HAC003M  
// WHERE :ls_sys_date between FROM_DATE and TO_DATE 
// 	AND BDGT_CLASS = 0 
//	AND STAT_CLASS = 0   ;
//
////em_year.text = left(ls_sys_date,4)
//em_year.text = ls_bdgt_year
//
////em_fr_date.text = string(ls_sys_date, '@@@@/@@/01')
//em_fr_date.text = string(ls_from_date, '@@@@/@@/01')
//em_to_date.text = string(ls_sys_date, '@@@@/@@/@@')
//
//wf_getchild()
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
string	ls_sys_date, ls_bdgt_year, ls_fr_date

idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_print	=	tab_sheet.tabpage_sheet02.dw_print


ls_sys_date = f_today()

//예산,회계년도 및 기간...
SELECT BDGT_YEAR,   		FROM_DATE  
  INTO :ls_bdgt_year, 	:ls_fr_date
  FROM ACDB.HAC003M  
 WHERE :ls_sys_date between FROM_DATE and TO_DATE 
 	AND BDGT_CLASS = 0 
	AND STAT_CLASS = 0   ;

//em_year.text = left(ls_sys_date,4)
//em_year.text = ls_bdgt_year
dw_con.object.year[1] = date(string(ls_bdgt_year+'0101', '@@@@/@@/@@'))

//em_fr_date.text = string(ls_sys_date, '@@@@/@@/01')

dw_con.object.fr_Date[1] = date(string(ls_fr_date, '@@@@/@@/01'))
dw_con.object.to_Date[1] = date(string(ls_sys_date, '@@@@/@@/@@'))

wf_getchild()

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

type ln_templeft from w_tabsheet`ln_templeft within w_hac802a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac802a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac802a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac802a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac802a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac802a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac802a
end type

type uc_insert from w_tabsheet`uc_insert within w_hac802a
end type

type uc_delete from w_tabsheet`uc_delete within w_hac802a
end type

type uc_save from w_tabsheet`uc_save within w_hac802a
end type

type uc_excel from w_tabsheet`uc_excel within w_hac802a
end type

type uc_print from w_tabsheet`uc_print within w_hac802a
end type

type st_line1 from w_tabsheet`st_line1 within w_hac802a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac802a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac802a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac802a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac802a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac802a
integer y = 324
integer width = 4384
integer taborder = 60
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;choose case newindex
	case 1
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		FALSE)
	case else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
end choose
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
integer height = 1832
long backcolor = 1073741824
string text = "기타구입통제관리"
dw_update dw_update
end type

on tabpage_sheet01.create
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
end type

type uo_tab from w_tabsheet`uo_tab within w_hac802a
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac802a
string dataobject = "d_hac802a_con"
end type

event dw_con::itemchanged;call super::itemchanged;String ls_bdgt_year , ls_from_date
This.accepttext()


Choose Case dwo.name
	Case 'year'
		ls_bdgt_year = left(data, 4)
		
		//예산,회계년도 및 기간...
		SELECT FROM_DATE  
		  INTO :ls_from_date
		  FROM ACDB.HAC003M  
		 WHERE BDGT_YEAR  = :ls_bdgt_year
			AND BDGT_CLASS = 0 
			AND STAT_CLASS = 0   ;
	
	 	This.object.fr_date[1] = date(string(ls_from_date, '@@@@/@@/01'))
End Choose 

end event

type st_con from w_tabsheet`st_con within w_hac802a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
integer width = 4343
integer height = 1832
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hac802a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;string	ls_bdgt_year, ls_gwa, ls_acct_code, ls_from_date, ls_to_date
dec{0}	ldec_used_amt, ldec_temp_amt, ldec_real_amt, ldec_apply_amt
dec{0}	ldec_old_apply_amt, ldec_old_apply_amt1, ldec_old_apply_amt2
dw_con.accepttext()
ls_bdgt_year 	= string(dw_con.object.year[1], 'yyyy')

choose case dwo.name
	case 'item_gbn'
		if long(data) = 3 then
			
			ls_gwa 			= '1301'
			ls_acct_code 	= getitemstring(row, 'acct_code')
			ldec_apply_amt = getitemnumber(row, 'item_amt')
			
			//배정예산합계, 가집행금액, 집행금액...
			select	assn_used_amt, 	assn_temp_amt, 	assn_real_amt
			into		:ldec_used_amt, 	:ldec_temp_amt, 	:ldec_real_amt
			from		acdb.hac012m
			where		bdgt_year 	= :ls_bdgt_year
			and		gwa 			= :ls_gwa
			and		acct_code 	= :ls_acct_code
			and		acct_class 	= 1
			and		io_gubun 	= '2'	;
			
			if isnull(ldec_used_amt) then ldec_used_amt = 0
			if isnull(ldec_temp_amt) then ldec_temp_amt = 0
			if isnull(ldec_real_amt) then ldec_real_amt = 0
			
			
			//물품신청(STDB.HST105H) 예산승인금액 합산...
			//2007-05-16

			//예산,회계년도 및 기간...
			SELECT 	FROM_DATE,			TO_DATE
			INTO 		:ls_from_date, 	:ls_to_date
			FROM 		ACDB.HAC003M  
			WHERE 	BDGT_YEAR	= :ls_bdgt_year
			AND 		BDGT_CLASS 	= 0 
			AND 		STAT_CLASS 	= 0   ;
			
			//물품신청(STDB.HST105H) 예산승인금액
			SELECT 	NVL(SUM(APPLY_AMT),0)
			INTO 		:ldec_old_apply_amt1
			FROM 		STDB.HST105H
			WHERE 	APPLY_GWA 	= :ls_gwa 
			AND 		APPLY_DATE 	BETWEEN :ls_from_date and :ls_to_date
			AND 		ACCT_CODE 	= :ls_acct_code 
			AND 		ORD_CLASS 	IN (3,4,5,6)  ;	//3,4,5,6(입고되기전)
			
			//기타구입 물품신청(STDB.HST317H) 예산승인금액
			SELECT	NVL(SUM(ITEM_AMT),0)
			INTO 		:ldec_old_apply_amt2
			FROM		STDB.HST317H
			WHERE		APPLY_DATE 	BETWEEN :ls_from_date AND :ls_to_date
			AND 		ACCT_CODE 	= :ls_acct_code 
			AND		ITEM_GBN 	IN (3,4,5,6)  ;	//3,4,5,6(입고되기전)
			
			ldec_old_apply_amt = ldec_old_apply_amt1 + ldec_old_apply_amt2
			////////////////////////////////////////////////////////////////
				
			
		//	if ldec_apply_amt > (ldec_used_amt - ldec_temp_amt - ldec_real_amt) then
			//예산승인금액 추가 : 2007.05.16
			if ldec_apply_amt > (ldec_used_amt - ldec_temp_amt - ldec_real_amt - ldec_old_apply_amt) then
				messagebox('확인', '예산잔액보다 예상금액이 더 많습니다~r~r' + &
										 '현재의 예산잔액은 '+String(ldec_used_amt - ldec_temp_amt - ldec_real_amt - ldec_old_apply_amt, '#,###') + ' 원 입니다.')
				setitem(row, 'assn_used_amt', 0)
				setitem(row, 'assn_temp_amt', 0)
				setitem(row, 'assn_real_amt', 0)
				setitem(row, 'item_gbn', 1)
				return 1
			else
				setitem(row, 'assn_used_amt', ldec_used_amt)
				setitem(row, 'assn_temp_amt', ldec_temp_amt)
				setitem(row, 'assn_real_amt', ldec_real_amt)
			end if
		else
			setitem(row, 'assn_used_amt', 0)
			setitem(row, 'assn_temp_amt', 0)
			setitem(row, 'assn_real_amt', 0)
		end if
end choose

end event

event losefocus;call super::losefocus;accepttext()
end event

event itemerror;call super::itemerror;return 1
end event

event doubleclicked;call super::doubleclicked;string		ls_bdgt_year, ls_gwa, ls_acct_code
long			ll_cnt
s_insa_com	lstr_com

if row < 1 then return

dw_con.accepttext()

ls_bdgt_year = string(dw_con.object.year[1], 'yyyy')

ls_gwa = '1301'
ls_acct_code = getitemstring(row, 'acct_code')

//select	count(bdgt_year)
//into		:ll_cnt
//from		acdb.hac011h
//where		bdgt_year = :ls_bdgt_year
//and		gwa = :ls_gwa
//and		acct_code = :ls_acct_code
//and		acct_class = 1
//and		io_gubun = '2'
//and		bdgt_class = 0
//and		stat_class = 41	;

select	count(bdgt_year)
into		:ll_cnt
from		acdb.hac012m
where		bdgt_year 		= 	:ls_bdgt_year
and		gwa 				= 	:ls_gwa
and		acct_code 		= 	:ls_acct_code
and		acct_class 		= 	1
and		io_gubun 		= 	'2'	
and		assn_bdgt_amt 	<> 0 ;

if isnull(ll_cnt) or ll_cnt < 1 then
	messagebox('확인', '현재부서의 계정에는 배정예산이 없습니다.')
	return
end if

lstr_com.ls_item[1] = ls_bdgt_year
lstr_com.ls_item[2] = ls_gwa
lstr_com.ls_item[3] = ls_acct_code

openwithparm(w_hac801a_help, lstr_com)

end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1832
string text = "기타구입통제내역"
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
integer height = 1832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hac802a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

