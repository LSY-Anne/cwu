$PBExportHeader$w_hac801a.srw
$PBExportComments$예산통제관리(구매/수리건)
forward
global type w_hac801a from w_tabsheet
end type
type dw_update from datawindow within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
end forward

global type w_hac801a from w_tabsheet
string title = "요구기간 관리/출력"
end type
global w_hac801a w_hac801a

type variables
datawindowchild	idw_child
datawindow			idw_data



//string				is_bdgt_year
//string				is_from_date, is_to_date


end variables

forward prototypes
public function integer wf_retrieve ()
public subroutine wf_getchild ()
end prototypes

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
string	ls_gwa, ls_from_date, ls_to_date
date		ld_date

dw_con.accepttext()

ls_gwa = dw_con.getitemstring(1, 'code')


ls_from_date = string(dw_con.object.fr_date[1], 'yyyymmdd')
ls_to_date = string(dw_con.object.to_date[1], 'yyyymmdd')



idw_data.retrieve(ls_gwa, ls_from_date, ls_to_date)

if idw_print.retrieve(ls_gwa, ls_from_date, ls_to_date) > 0 then

else
	idw_print.reset()
end if

return 0

end function

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
if idw_data.dataobject = 'd_hac801a_1' then
	idw_data.getchild('hst105h_ord_class', idw_child)
else
	idw_data.getchild('hst030h_stat_class', idw_child)
end if
idw_child.settransobject(sqlca)
if idw_child.retrieve('ord_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
else
	idw_child.setfilter("code in (1, 3, 999)")
	idw_child.filter()
end if

if idw_print.dataobject = 'd_hac801a_3' then
	idw_print.getchild('hst105h_ord_class', idw_child)
else
	idw_print.getchild('hst030h_stat_class', idw_child)
end if
idw_child.settransobject(sqlca)
if idw_child.retrieve('ord_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

on w_hac801a.create
int iCurrent
call super::create
end on

on w_hac801a.destroy
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
//if not isdate(em_fr_date.text) then
//	messagebox('확인', '신청기간(From)을 올바르게 입력하시기 바랍니다.')
//	em_fr_date.setfocus()
//	return -1
//end if
//
//if not isdate(em_to_date.text) then
//	messagebox('확인', '신청기간(To)을 올바르게 입력하시기 바랍니다.')
//	em_to_date.setfocus()
//	return -1
//end if
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

//f_setpointer('START')
wf_retrieve()
//f_setpointer('END')
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
//string	ls_sys_date
//
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
//
//ls_sys_date = f_today()
//
////예산,회계년도 및 기간...
//SELECT BDGT_YEAR,   		FROM_DATE,			TO_DATE
//  INTO :is_bdgt_year, 	:is_from_date, 	:is_to_date
//  FROM ACDB.HAC003M  
// WHERE :ls_sys_date between FROM_DATE and TO_DATE 
// 	AND BDGT_CLASS = 0 
//	AND STAT_CLASS = 0   ;
//
////em_year.text = left(ls_sys_date,4)
//em_year.text = is_bdgt_year
//
////부서/학과
//dw_gwa.getchild('code', idw_child)
//idw_child.settransobject(sqlca)
//idw_child.retrieve(1,3)
//idw_child.insertrow(1)
//idw_child.setitem(1,'dept_code','0')
//idw_child.setitem(1,'dept_name','전체')
//dw_gwa.insertrow(0)
//dw_gwa.setitem(1, 'code', '0')
//
////em_fr_date.text = string(ls_sys_date, '@@@@/@@/01')
//em_fr_date.text = string(is_from_date, '@@@@/@@/01')
//em_to_date.text = string(ls_sys_date, '@@@@/@@/@@')
//
//ddlb_gubun.selectitem(1)
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
string	ls_sys_date, ls_bdgt_year, ls_from_date, ls_to_date

idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_print	=	tab_sheet.tabpage_sheet02.dw_print


ls_sys_date = f_today()

//예산,회계년도 및 기간...
SELECT BDGT_YEAR,   		FROM_DATE,			TO_DATE
  INTO :ls_bdgt_year, 	:ls_from_date, 	:ls_to_date
  FROM ACDB.HAC003M  
 WHERE :ls_sys_date between FROM_DATE and TO_DATE 
 	AND BDGT_CLASS = 0 
	AND STAT_CLASS = 0   ;

//em_year.text = left(ls_sys_date,4)
//em_year.text = is_bdgt_year
dw_con.object.year[1] = date(string(ls_bdgt_year + '0101', '@@@@/@@/@@'))

//부서/학과
dw_con.getchild('code', idw_child)
idw_child.settransobject(sqlca)
idw_child.retrieve(1,3)
idw_child.insertrow(1)
idw_child.setitem(1,'dept_code','0')
idw_child.setitem(1,'dept_name','전체')

dw_con.setitem(1, 'code', '0')

//em_fr_date.text = string(ls_sys_date, '@@@@/@@/01')
dw_con.object.fr_date[1] = date(string(ls_from_date, '@@@@/@@/01'))
dw_con.object.to_date[1] = date(string(ls_sys_date, '@@@@/@@/@@'))


//ddlb_gubun.selectitem(1)

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

type ln_templeft from w_tabsheet`ln_templeft within w_hac801a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac801a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac801a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac801a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac801a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac801a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac801a
end type

type uc_insert from w_tabsheet`uc_insert within w_hac801a
end type

type uc_delete from w_tabsheet`uc_delete within w_hac801a
end type

type uc_save from w_tabsheet`uc_save within w_hac801a
end type

type uc_excel from w_tabsheet`uc_excel within w_hac801a
end type

type uc_print from w_tabsheet`uc_print within w_hac801a
end type

type st_line1 from w_tabsheet`st_line1 within w_hac801a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac801a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac801a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac801a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac801a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac801a
integer y = 320
integer width = 4384
integer height = 1960
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
integer height = 1840
long backcolor = 1073741824
string text = "구매통제관리"
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
integer x = 165
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
boolean visible = false
integer x = 142
integer y = 248
integer width = 4206
integer height = 1592
end type

event dw_update_tab::doubleclicked;call super::doubleclicked;string		ls_bdgt_year, ls_gwa, ls_acct_code
long			ll_cnt
s_insa_com	lstr_com

if row < 1 then return

dw_con.accepttext()
ls_bdgt_year 	= string(dw_con.object.year[1], 'yyyy')

if dataobject = 'd_hac801a_1' then
	ls_gwa = getitemstring(row, 'hst105h_apply_gwa')
	ls_acct_code = getitemstring(row, 'hst105h_acct_code')
else
	ls_gwa = getitemstring(row, 'hst030h_rep_gwa')
	ls_acct_code = getitemstring(row, 'hst030h_acct_code')
end if

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

event dw_update_tab::itemchanged;call super::itemchanged;string	ls_bdgt_year, ls_gwa, ls_acct_code
dec{0}	ldec_used_amt, ldec_temp_amt, ldec_real_amt, ldec_old_apply_amt, ldec_apply_amt, ldec_in_amt, ldec_apply_amt2
integer  li_temp,li_rows,li_class			//2003-12-01
string	ls_gwa_t, ls_acct_code_t			//2003-12-01
string	ls_apply_date							//2004-07-05
integer	li_gian_num								//2004-07-05
string	ls_bdgt_from							//2005.10.10
dwItemStatus	l_status
long		ll_find

String ls_from_date, ls_to_date

dw_con.accepttext()
ls_from_date = string(dw_con.object.fr_date[1], 'yyyymmdd')
ls_to_date = string(dw_con.object.to_date[1], 'yyyymmdd')
ls_bdgt_year 	= string(dw_con.object.year[1], 'yyyy')
choose case dataobject
	case 'd_hac801a_1'
		choose case dwo.name
			case 'hst105h_ord_class'
				if long(data) = 1 or long(data) = 999 then
					setitem(row, 'hst105h_assn_used_amt', 0)
					setitem(row, 'hst105h_assn_temp_amt', 0)
					setitem(row, 'hst105h_assn_real_amt', 0)
				else
					
					ls_gwa 			= getitemstring(row, 'hst105h_apply_gwa')
					ls_acct_code 	= getitemstring(row, 'hst105h_acct_code')
					ldec_apply_amt = getitemnumber(row, 'hst105h_apply_amt')
					ls_apply_date	= getitemstring(row, 'hst105h_apply_date')
					li_gian_num 	= getitemnumber(row, 'hst105h_gian_num')
					
					//2003-12-01
					/*
					li_rows = dw_update.rowcount()
					for li_temp = 1 to li_rows
						if li_temp <> row then
							ls_gwa_t 		= getitemstring(li_temp, 'hst105h_apply_gwa')
							ls_acct_code_t = getitemstring(li_temp, 'hst105h_acct_code')
							li_class 		= getitemnumber(li_temp, 'hst105h_ord_class')
							
							if ls_gwa+ls_acct_code = ls_gwa_t+ls_acct_code_t and li_class=3 then
								ldec_apply_amt = ldec_apply_amt + getitemnumber(li_temp, 'hst105h_apply_amt')
							end if
						end if
					next
					*/
					
					
					//2005.10.10 : 신청 -> 예산승인된 내역의 금액을 검사(동일부서, 동일계정)
					ll_find = this.find("hst105h_apply_gwa = '"+ls_gwa+"' and hst105h_acct_code = '"+ls_acct_code+"' and "+&
											  "hst105h_ord_class = 3", 1, this.rowcount())

					do while ll_find <> 0
						if ll_find <> row then
							l_status = this.GetItemStatus(ll_find, 'hst105h_ord_class', Primary!)
							
							if l_status = DataModified! then
								ldec_apply_amt2 += this.getItemNumber(ll_find, 'hst105h_apply_amt')
							end if
						
						end if
						
						if ll_find <> this.rowcount() then
							ll_find = this.find("hst105h_apply_gwa = '"+ls_gwa+"' and hst105h_acct_code = '"+ls_acct_code+"' and "+&
													  "hst105h_ord_class = 3", ll_find+1, this.rowcount())
						else
							ll_find = 0
						end if
					loop
					

					//2004-07-05
				//	SELECT 	NVL(SUM(APPLY_AMT),0)+:ldec_apply_amt 	INTO :ldec_apply_amt
					SELECT 	NVL(SUM(APPLY_AMT),0) 	INTO :ldec_old_apply_amt
					FROM 		STDB.HST105H  
					WHERE 	APPLY_GWA 		= :ls_gwa 
					AND 		APPLY_DATE 		BETWEEN :ls_from_date and :ls_to_date
					AND 		APPLY_DATE||GIAN_NUM <> :ls_apply_date||:li_gian_num
					AND 		ACCT_CODE 		= :ls_acct_code 
					AND 		ORD_CLASS 		IN (3,4,5,6)  ;	//2005.10.10 : 3 -> 3,4,5,6(입고되기전)을 추가
					


					//예산금액, 가집행금액, 집행금액...
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
					
					
					//입고상태인 물품의 입고금액을 예산잔액 계산에 사용(2005.10.10)...
					//ls_bdgt_from = mid(f_getacctyear(ls_bdgt_year),2,8)	=> 2009.04.14 : 주석처리
					
					SELECT 	NVL(SUM(B.IN_AMT),0)		INTO :ldec_in_amt
					FROM 		STDB.HST105H A, STDB.HST109H B
					WHERE 	A.REQ_NO 		= 	B.REQ_NO 
					AND		A.ORD_NO 		= 	B.ORD_NO 
					AND		A.APPLY_GWA 	=  :ls_gwa
					AND  		A.APPLY_DATE 	BETWEEN :ls_from_date AND lis_to_date
					AND  		A.ACCT_CODE 	=  :ls_acct_code
					AND  		A.ORD_CLASS 	=  7 ;
					

					
					//2005.10.10 : 입고금액을 계산에 사용(승인금액+신청금액+입고금액이 배정예산보다 크면)
				//	if ldec_apply_amt > (ldec_used_amt - ldec_temp_amt - ldec_real_amt) then
					if (ldec_apply_amt2 + ldec_old_apply_amt + ldec_apply_amt + ldec_in_amt) > ldec_used_amt then
						messagebox('확인', '예산잔액보다 예상금액이 더 많습니다~r~r' + '현재의 예산잔액은 ' + &
												 String(ldec_used_amt - (ldec_apply_amt2 + ldec_old_apply_amt + ldec_in_amt), '#,###') + &
												 ' 원 입니다.')
											//	 '현재의 예산잔액은 ' + String(ldec_used_amt - ldec_temp_amt - ldec_real_amt, '#,###') + ' 원 입니다.')
						setitem(row, 'hst105h_assn_used_amt', 0)
						setitem(row, 'hst105h_assn_temp_amt', 0)
						setitem(row, 'hst105h_assn_real_amt', 0)
						setitem(row, 'hst105h_ord_class', 1)
						return 1
					else
						setitem(row, 'hst105h_assn_used_amt', ldec_used_amt)
						setitem(row, 'hst105h_assn_temp_amt', ldec_temp_amt)
						setitem(row, 'hst105h_assn_real_amt', ldec_real_amt)
					end if
				end if
		end choose
	case else
		choose case dwo.name
			case 'hst030h_stat_class'
				if long(data) = 1 or long(data) = 999 then
					setitem(row, 'hst030h_assn_used_amt', 0)
					setitem(row, 'hst030h_assn_temp_amt', 0)
					setitem(row, 'hst030h_assn_real_amt', 0)
				else

					ls_gwa 			= getitemstring(row, 'hst030h_rep_gwa')
					ls_acct_code 	= getitemstring(row, 'hst030h_acct_code')
					ldec_apply_amt = getitemnumber(row, 'hst030h_apply_amt')
					
					//2004-03-05
					li_rows = dw_update_tab.rowcount()
					for li_temp = 1 to li_rows
						if li_temp <> row then
							ls_gwa_t 		= getitemstring(li_temp, 'hst030h_rep_gwa')
							ls_acct_code_t = getitemstring(li_temp, 'hst030h_acct_code')
							li_class 		= getitemnumber(li_temp, 'hst030h_stat_class')
							
							if ls_gwa+ls_acct_code = ls_gwa_t+ls_acct_code_t and li_class=3 then
								ldec_apply_amt = ldec_apply_amt + getitemnumber(li_temp, 'hst030h_apply_amt')
							end if
						end if
					next

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
					
					if ldec_apply_amt > (ldec_used_amt - ldec_temp_amt - ldec_real_amt) then
						messagebox('확인', '예산잔액보다 예상금액이 더 많습니다~r~r' + &
												 '현재의 예산잔액은 ' + String(ldec_used_amt - ldec_temp_amt - ldec_real_amt, '#,###') + ' 원 입니다.')
						setitem(row, 'hst030h_assn_used_amt', 0)
						setitem(row, 'hst030h_assn_temp_amt', 0)
						setitem(row, 'hst030h_assn_real_amt', 0)
						setitem(row, 'hst030h_stat_class', 1)
						return 1
					else
						setitem(row, 'hst030h_assn_used_amt', ldec_used_amt)
						setitem(row, 'hst030h_assn_temp_amt', ldec_temp_amt)
						setitem(row, 'hst030h_assn_real_amt', ldec_real_amt)
					end if
				end if
		end choose
end choose
end event

event dw_update_tab::itemerror;call super::itemerror;return 1
end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

type uo_tab from w_tabsheet`uo_tab within w_hac801a
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac801a
string dataobject = "d_hac801a_con"
end type

event dw_con::itemchanged;call super::itemchanged;String ls_bdgt_year, ls_fr_date, ls_to_date

This.accepttext()


Choose Case dwo.name
	Case 'year'
		ls_bdgt_year = left(data, 4)
		
		//예산,회계년도 및 기간...
		SELECT FROM_DATE,			TO_DATE
		  INTO :ls_fr_date, 	:ls_to_date
		  FROM ACDB.HAC003M  
		 WHERE BDGT_YEAR	= :ls_bdgt_year
			AND BDGT_CLASS = 0 
			AND STAT_CLASS = 0   ;
	
		dw_con.object.fr_date[1]  = date(string(ls_fr_date, '@@@@/@@/01'))
		dw_con.object.to_date[1] = date(string(ls_to_date, 	'@@@@/@@/@@'))

	case 'gubun'
		If data = '1' Then
			tab_sheet.tabpage_sheet01.text = '구매통제관리'
			tab_sheet.tabpage_sheet02.text = '구매통제내역'
			tab_sheet.tabpage_sheet01.dw_update.dataobject = 'd_hac801a_1'
			tab_sheet.tabpage_sheet02.dw_print.dataobject = 'd_hac801a_3'
		else
			tab_sheet.tabpage_sheet01.text = '수리통제관리'
			tab_sheet.tabpage_sheet02.text = '수리통제내역'
			tab_sheet.tabpage_sheet01.dw_update.dataobject = 'd_hac801a_2'
			tab_sheet.tabpage_sheet02.dw_print.dataobject = 'd_hac801a_4'
		end if
		
		//tab_sheet.tabpage_sheet01.dw_update.settransobject(sqlca)
		
		tab_sheet.tabpage_sheet02.dw_print.settransobject(sqlca)
		
		tab_sheet.tabpage_sheet01.dw_update.TriggerEvent(constructor!)
		
		idw_data = tab_sheet.tabpage_sheet01.dw_update
		idw_print = tab_sheet.tabpage_sheet02.dw_print
		
		wf_getchild()


		
End Choose
end event

type st_con from w_tabsheet`st_con within w_hac801a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type dw_update from datawindow within tabpage_sheet01
integer y = 4
integer width = 4338
integer height = 1840
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_hac801a_1"
boolean border = false
boolean livescroll = true
end type

event doubleclicked;string		ls_bdgt_year, ls_gwa, ls_acct_code
long			ll_cnt
s_insa_com	lstr_com

if row < 1 then return

dw_con.accepttext()
ls_bdgt_year 	= string(dw_con.object.year[1], 'yyyy')

if dataobject = 'd_hac801a_1' then
	ls_gwa = getitemstring(row, 'hst105h_apply_gwa')
	ls_acct_code = getitemstring(row, 'hst105h_acct_code')
else
	ls_gwa = getitemstring(row, 'hst030h_rep_gwa')
	ls_acct_code = getitemstring(row, 'hst030h_acct_code')
end if

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

event itemchanged;string	ls_bdgt_year, ls_gwa, ls_acct_code
dec{0}	ldec_used_amt, ldec_temp_amt, ldec_real_amt, ldec_old_apply_amt, ldec_apply_amt, ldec_in_amt, ldec_apply_amt2
integer  li_temp,li_rows,li_class			//2003-12-01
string	ls_gwa_t, ls_acct_code_t			//2003-12-01
string	ls_apply_date							//2004-07-05
integer	li_gian_num								//2004-07-05
string	ls_bdgt_from							//2005.10.10
dwItemStatus	l_status
long		ll_find

String ls_from_date, ls_to_date

dw_con.accepttext()
ls_from_date = string(dw_con.object.fr_date[1], 'yyyymmdd')
ls_to_date = string(dw_con.object.to_date[1], 'yyyymmdd')
ls_bdgt_year 	= string(dw_con.object.year[1], 'yyyy')
choose case dataobject
	case 'd_hac801a_1'
		choose case dwo.name
			case 'hst105h_ord_class'
				if long(data) = 1 or long(data) = 999 then
					setitem(row, 'hst105h_assn_used_amt', 0)
					setitem(row, 'hst105h_assn_temp_amt', 0)
					setitem(row, 'hst105h_assn_real_amt', 0)
				else
					
					ls_gwa 			= getitemstring(row, 'hst105h_apply_gwa')
					ls_acct_code 	= getitemstring(row, 'hst105h_acct_code')
					ldec_apply_amt = getitemnumber(row, 'hst105h_apply_amt')
					ls_apply_date	= getitemstring(row, 'hst105h_apply_date')
					li_gian_num 	= getitemnumber(row, 'hst105h_gian_num')
					
					//2003-12-01
					/*
					li_rows = dw_update.rowcount()
					for li_temp = 1 to li_rows
						if li_temp <> row then
							ls_gwa_t 		= getitemstring(li_temp, 'hst105h_apply_gwa')
							ls_acct_code_t = getitemstring(li_temp, 'hst105h_acct_code')
							li_class 		= getitemnumber(li_temp, 'hst105h_ord_class')
							
							if ls_gwa+ls_acct_code = ls_gwa_t+ls_acct_code_t and li_class=3 then
								ldec_apply_amt = ldec_apply_amt + getitemnumber(li_temp, 'hst105h_apply_amt')
							end if
						end if
					next
					*/
					
					
					//2005.10.10 : 신청 -> 예산승인된 내역의 금액을 검사(동일부서, 동일계정)
					ll_find = this.find("hst105h_apply_gwa = '"+ls_gwa+"' and hst105h_acct_code = '"+ls_acct_code+"' and "+&
											  "hst105h_ord_class = 3", 1, this.rowcount())

					do while ll_find <> 0
						if ll_find <> row then
							l_status = this.GetItemStatus(ll_find, 'hst105h_ord_class', Primary!)
							
							if l_status = DataModified! then
								ldec_apply_amt2 += this.getItemNumber(ll_find, 'hst105h_apply_amt')
							end if
						
						end if
						
						if ll_find <> this.rowcount() then
							ll_find = this.find("hst105h_apply_gwa = '"+ls_gwa+"' and hst105h_acct_code = '"+ls_acct_code+"' and "+&
													  "hst105h_ord_class = 3", ll_find+1, this.rowcount())
						else
							ll_find = 0
						end if
					loop
					

					//2004-07-05
				//	SELECT 	NVL(SUM(APPLY_AMT),0)+:ldec_apply_amt 	INTO :ldec_apply_amt
					SELECT 	NVL(SUM(APPLY_AMT),0) 	INTO :ldec_old_apply_amt
					FROM 		STDB.HST105H  
					WHERE 	APPLY_GWA 		= :ls_gwa 
					AND 		APPLY_DATE 		BETWEEN :ls_from_date and :ls_to_date
					AND 		APPLY_DATE||GIAN_NUM <> :ls_apply_date||:li_gian_num
					AND 		ACCT_CODE 		= :ls_acct_code 
					AND 		ORD_CLASS 		IN (3,4,5,6)  ;	//2005.10.10 : 3 -> 3,4,5,6(입고되기전)을 추가
					


					//예산금액, 가집행금액, 집행금액...
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
					
					
					//입고상태인 물품의 입고금액을 예산잔액 계산에 사용(2005.10.10)...
					//ls_bdgt_from = mid(f_getacctyear(ls_bdgt_year),2,8)	=> 2009.04.14 : 주석처리
					
					SELECT 	NVL(SUM(B.IN_AMT),0)		INTO :ldec_in_amt
					FROM 		STDB.HST105H A, STDB.HST109H B
					WHERE 	A.REQ_NO 		= 	B.REQ_NO 
					AND		A.ORD_NO 		= 	B.ORD_NO 
					AND		A.APPLY_GWA 	=  :ls_gwa
					AND  		A.APPLY_DATE 	BETWEEN :ls_from_date AND lis_to_date
					AND  		A.ACCT_CODE 	=  :ls_acct_code
					AND  		A.ORD_CLASS 	=  7 ;
					

					
					//2005.10.10 : 입고금액을 계산에 사용(승인금액+신청금액+입고금액이 배정예산보다 크면)
				//	if ldec_apply_amt > (ldec_used_amt - ldec_temp_amt - ldec_real_amt) then
					if (ldec_apply_amt2 + ldec_old_apply_amt + ldec_apply_amt + ldec_in_amt) > ldec_used_amt then
						messagebox('확인', '예산잔액보다 예상금액이 더 많습니다~r~r' + '현재의 예산잔액은 ' + &
												 String(ldec_used_amt - (ldec_apply_amt2 + ldec_old_apply_amt + ldec_in_amt), '#,###') + &
												 ' 원 입니다.')
											//	 '현재의 예산잔액은 ' + String(ldec_used_amt - ldec_temp_amt - ldec_real_amt, '#,###') + ' 원 입니다.')
						setitem(row, 'hst105h_assn_used_amt', 0)
						setitem(row, 'hst105h_assn_temp_amt', 0)
						setitem(row, 'hst105h_assn_real_amt', 0)
						setitem(row, 'hst105h_ord_class', 1)
						return 1
					else
						setitem(row, 'hst105h_assn_used_amt', ldec_used_amt)
						setitem(row, 'hst105h_assn_temp_amt', ldec_temp_amt)
						setitem(row, 'hst105h_assn_real_amt', ldec_real_amt)
					end if
				end if
		end choose
	case else
		choose case dwo.name
			case 'hst030h_stat_class'
				if long(data) = 1 or long(data) = 999 then
					setitem(row, 'hst030h_assn_used_amt', 0)
					setitem(row, 'hst030h_assn_temp_amt', 0)
					setitem(row, 'hst030h_assn_real_amt', 0)
				else

					ls_gwa 			= getitemstring(row, 'hst030h_rep_gwa')
					ls_acct_code 	= getitemstring(row, 'hst030h_acct_code')
					ldec_apply_amt = getitemnumber(row, 'hst030h_apply_amt')
					
					//2004-03-05
					li_rows = dw_update.rowcount()
					for li_temp = 1 to li_rows
						if li_temp <> row then
							ls_gwa_t 		= getitemstring(li_temp, 'hst030h_rep_gwa')
							ls_acct_code_t = getitemstring(li_temp, 'hst030h_acct_code')
							li_class 		= getitemnumber(li_temp, 'hst030h_stat_class')
							
							if ls_gwa+ls_acct_code = ls_gwa_t+ls_acct_code_t and li_class=3 then
								ldec_apply_amt = ldec_apply_amt + getitemnumber(li_temp, 'hst030h_apply_amt')
							end if
						end if
					next

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
					
					if ldec_apply_amt > (ldec_used_amt - ldec_temp_amt - ldec_real_amt) then
						messagebox('확인', '예산잔액보다 예상금액이 더 많습니다~r~r' + &
												 '현재의 예산잔액은 ' + String(ldec_used_amt - ldec_temp_amt - ldec_real_amt, '#,###') + ' 원 입니다.')
						setitem(row, 'hst030h_assn_used_amt', 0)
						setitem(row, 'hst030h_assn_temp_amt', 0)
						setitem(row, 'hst030h_assn_real_amt', 0)
						setitem(row, 'hst030h_stat_class', 1)
						return 1
					else
						setitem(row, 'hst030h_assn_used_amt', ldec_used_amt)
						setitem(row, 'hst030h_assn_temp_amt', ldec_temp_amt)
						setitem(row, 'hst030h_assn_real_amt', ldec_real_amt)
					end if
				end if
		end choose
end choose
end event

event losefocus;accepttext()
end event

event itemerror;return 1
end event

event constructor;settransobject(sqlca)
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1840
string text = "구매통제내역"
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
integer width = 4347
integer height = 1840
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hac801a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

