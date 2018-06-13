$PBExportHeader$w_hfn904a.srw
$PBExportComments$자금이체관리
forward
global type w_hfn904a from w_msheet
end type
type uo_acct_class from cuo_acct_class within w_hfn904a
end type
type tab_1 from tab within w_hfn904a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_update from uo_dwgrid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_update dw_update
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hfn904a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_con from uo_dwfree within w_hfn904a
end type
type uo_tab from u_tab within w_hfn904a
end type
end forward

global type w_hfn904a from w_msheet
string title = "보증금 등록/출력"
uo_acct_class uo_acct_class
tab_1 tab_1
dw_con dw_con
uo_tab uo_tab
end type
global w_hfn904a w_hfn904a

forward prototypes
public function integer wf_dup_chk (long al_row, string as_yyyymmdd, string as_mem_cust_no)
public subroutine wf_getchild ()
end prototypes

public function integer wf_dup_chk (long al_row, string as_yyyymmdd, string as_mem_cust_no);// ==========================================================================================
// 기    능 : 	중복자료 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_dup_chk(long al_row, string as_yyyymmdd, string as_mem_cust_no) return integer
// 인    수 :	al_row : 현재행, as_yyyymmdd : 처리일자, as_mem_cust_no : 코드번호
// 되 돌 림 :  중복 : 1, 없으면 : 0
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long		ll_row

SELECT	COUNT(*)	INTO	:LL_ROW	FROM	FNDB.HFN402H
WHERE		YYYYMMDD = :AS_YYYYMMDD
AND		MEM_CUST_NO = :AS_MEM_CUST_NO	;

if ll_row > 0 then
	messagebox('확인', '이미 등록된 자료입니다.')
	return 1
end if

ll_row = idw_update[1].find("yyyymmdd = '" + as_yyyymmdd + "' and " + &
								 "mem_cust_no = '" + as_mem_cust_no + "'", 1, al_row - 1)

if ll_row > 0 then
	messagebox('확인', '이미 등록된 자료입니다.')
	return 1
end if

ll_row = idw_update[1].find("yyyymmdd = '" + as_yyyymmdd + "' and " + &
								 "mem_cust_no = '" + as_mem_cust_no + "'", al_row + 1, idw_update[1].rowcount())

if ll_row > 0 then
	messagebox('확인', '이미 등록된 자료입니다.')
	return 1
end if

return 0
end function

public subroutine wf_getchild ();// ==========================================================================================
// 기    능	:	DatawindowChild Getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2003.01
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
datawindowchild	ldw_child

// 은행
idw_update[1].getchild('bank_code', ldw_child)
ldw_child.settransobject(sqlca)
if ldw_child.retrieve('bank_code', 1) < 1 then
	ldw_child.reset()
	ldw_child.insertrow(0)
end if
ldw_child.setsort('code')
ldw_child.sort()

idw_print.getchild('bank_code', ldw_child)
ldw_child.settransobject(sqlca)
if ldw_child.retrieve('bank_code', 1) < 1 then
	ldw_child.reset()
	ldw_child.insertrow(0)
end if

end subroutine

on w_hfn904a.create
int iCurrent
call super::create
this.uo_acct_class=create uo_acct_class
this.tab_1=create tab_1
this.dw_con=create dw_con
this.uo_tab=create uo_tab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_acct_class
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_tab
end on

on w_hfn904a.destroy
call super::destroy
destroy(this.uo_acct_class)
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_tab)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 자금이체 자료를 관리한다.
////	작 성 인 : 이현수
////	작성일자 : 2003.01
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//datawindowchild	ldwc_temp
//
//gi_acct_class = uo_acct_class.uf_getcode()
//
//idw_update[1] = tab_1.tabpage_1.dw_update
//idw_print  = tab_1.tabpage_2.dw_print
//
//wf_getchild()
//
//em_date.text = string(f_today(), '@@@@/@@/@@')
//
//idw_print.object.datawindow.print.preview = true
//
end event

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
date		ld_date
string	ls_date
dw_con.accepttext()
ls_date = string(dw_con.object.date[1], 'yyyymmdd')
if not isdate(String(ls_date, '@@@@/@@/@@')) then
	messagebox('확인', '처리일자를 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('date')
	return -1
end if




if idw_update[1].retrieve(ls_date) > 0 then
	idw_print.retrieve(ls_date)
end if

return 1
end event

event ue_delete;call super::ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
long	ll_row

ll_row = idw_update[1].getrow()

if ll_row < 1 then
	messagebox('확인', '삭제할 데이터를 선택하시기 바랍니다.')
	return
end if

idw_update[1].deleterow(ll_row)

wf_SetMsg('자료가 삭제되었습니다. 저장으로 자료 삭제를 완료하시기 바랍니다.')

end event

event ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
long		ll_row
date		ld_date
string	ls_date
dw_con.accepttext()

if not isdate(String(dw_con.object.date[1], 'yyyy/mm/dd')) then
	messagebox('확인', '처리일자를 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('date')
	return 
end if

ls_date = string(dw_con.object.date[1], 'yyyymmdd')

idw_update[1].setfocus()

ll_row = idw_update[1].getrow()

ll_row = idw_update[1].insertrow(ll_row + 1)

idw_update[1].setitem(ll_row, 'yyyymmdd',			ls_date)
idw_update[1].setitem(ll_row, 'mem_cust_gubun',	'1')
idw_update[1].setitem(ll_row, 'worker', 			gs_empcode)
idw_update[1].setitem(ll_row, 'ipaddr', 			gs_ip)
idw_update[1].setitem(ll_row, 'work_date', 		f_sysdate())

wf_SetMsg('자료가 추가되었습니다.')

idw_update[1].setcolumn('mem_cust_gubun')
idw_update[1].scrolltorow(ll_row)
idw_update[1].setfocus()

end event

event ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
string	ls_null[], ls_yymmdd, ls_cust_no
long		ll_row, ll_seq, ll_find

idw_update[1].accepttext()

if idw_update[1].modifiedcount() < 1 and idw_update[1].deletedcount() < 1 then
	wf_SetMsg('변경된 자료가 없습니다.')
	return -1
end if

ls_null[1] = 'mem_cust_no/코드번호'
ls_null[2] = 'trans_amt/금액'
ls_null[3] = 'bank_code/은행'
ls_null[4] = 'acct_no/계좌번호'
ls_null[5] = 'trans_name/예금주'

if f_chk_null(idw_update[1], ls_null) = -1 then return -1

for ll_row = 1 to idw_update[1].rowcount()
	ls_yymmdd	=	idw_update[1].object.yyyymmdd[ll_row]
	ls_cust_no	=	idw_update[1].object.mem_cust_no[ll_row]
	ll_seq		=	idw_update[1].object.seq[ll_row]
	
	if isnull(ll_seq) or ll_seq = 0 then
		SELECT	NVL(MAX(SEQ),0)	INTO	:ll_seq	
		FROM		FNDB.HFN402H
		WHERE		YYYYMMDD 	= :ls_yymmdd
		AND		MEM_CUST_NO = :ls_cust_no	;

		ll_seq = ll_seq + 1
		idw_update[1].object.seq[ll_row] = ll_seq
		
		ll_find = idw_update[1].find("yyyymmdd = '"+ls_yymmdd+"' and mem_cust_no = '"+ls_cust_no+"'", ll_row + 1, idw_update[1].rowcount())

		do while ll_find <> 0
			if isnull(idw_update[1].object.seq[ll_find]) or idw_update[1].object.seq[ll_find] = 0 then
				ll_seq = ll_seq + 1
				idw_update[1].object.seq[ll_find] = ll_seq
			end if

			if ll_find = idw_update[1].rowcount() then exit
			ll_find = idw_update[1].find("yyyymmdd = '"+ls_yymmdd+"' and mem_cust_no = '"+ls_cust_no+"'", ll_find + 1, idw_update[1].rowcount())
		loop
	end if
next



if idw_update[1].update() <> 1 then
	rollback ;
	return -1
end if

commit ;
wf_SetMsg('자료가 저장되었습니다.')

triggerevent('ue_retrieve')



end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//f_print(idw_print)
//
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 자금이체 자료를 관리한다.
//	작 성 인 : 이현수
//	작성일자 : 2003.01
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
datawindowchild	ldwc_temp


idw_update[1] = tab_1.tabpage_1.dw_update
idw_print  = tab_1.tabpage_2.dw_print

wf_getchild()

dw_con.object.date[1] = date(string(f_today(), '@@@@/@@/@@'))

idw_print.object.datawindow.print.preview = true

end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "자금이체내역")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hfn904a
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn904a
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn904a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn904a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn904a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn904a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn904a
end type

type uc_insert from w_msheet`uc_insert within w_hfn904a
end type

type uc_delete from w_msheet`uc_delete within w_hfn904a
end type

type uc_save from w_msheet`uc_save within w_hfn904a
end type

type uc_excel from w_msheet`uc_excel within w_hfn904a
end type

type uc_print from w_msheet`uc_print within w_hfn904a
end type

type st_line1 from w_msheet`st_line1 within w_hfn904a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn904a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn904a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn904a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn904a
end type

type uo_acct_class from cuo_acct_class within w_hfn904a
event destroy ( )
boolean visible = false
integer x = 2537
integer y = 100
integer taborder = 40
boolean bringtotop = true
long backcolor = 1073741824
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;//gi_acct_class	=	uf_getcode()

end event

type tab_1 from tab within w_hfn904a
integer x = 50
integer y = 340
integer width = 4384
integer height = 1932
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;//choose case newindex
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

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1812
string text = "자금이체관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update dw_update
end type

on tabpage_1.create
this.dw_update=create dw_update
this.Control[]={this.dw_update}
end on

on tabpage_1.destroy
destroy(this.dw_update)
end on

type dw_update from uo_dwgrid within tabpage_1
integer width = 4357
integer height = 1820
integer taborder = 50
string dataobject = "d_hfn904a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com, lstr_Rtn
long			ll_cnt, ll_bank_code
string		ls_name, ls_acct_no, ls_depositor, ls_cust_name, ls_cust_no
string		ls_gubun, ls_jol_yn

choose case dwo.name
	case 'mem_cust_no'
		if isnull(data) or trim(data) = '' then return
		
		if getitemstring(row, 'mem_cust_gubun') = '3' then		//학생
			if wf_dup_chk(row, getitemstring(row, 'yyyymmdd'), data) > 0 then
				setitem(row, 'mem_cust_no', '')
				setitem(row, 'mem_cust_name', '')
				setitem(row, 'bank_code', '')
				setitem(row, 'acct_no', '')
				setitem(row, 'trans_name', '')
				return 1
			end if
		end if

		if getitemstring(row, 'mem_cust_gubun') = '1' then
			// 교직원
			select	count(member_no)
			into		:ll_cnt
			from		padb.hpa020m
			where		member_no = :data	;
			
			if ll_cnt < 1 then
				messagebox('확인', '등록된 교직원의 계좌정보가 없습니다.')
				setitem(row, 'mem_cust_no', '')
				setitem(row, 'mem_cust_name', '')
				setitem(row, 'bank_code', '')
				setitem(row, 'acct_no', '')
				setitem(row, 'trans_name', '')
				return 1
			end if
			
			if ll_cnt = 1 then
				select	b.name, 		a.bank_code, 		a.acct_no, 		a.depositor
				into		:ls_name, 	:ll_bank_code, 	:ls_acct_no, 	:ls_depositor
				from		padb.hpa020m a, 
							indb.hin001m b
				where		a.member_no = :data
				and		a.member_no = b.member_no	;
				
				setitem(row, 'mem_cust_name', ls_name)
				setitem(row, 'bank_code', ll_bank_code)
				setitem(row, 'acct_no', ls_acct_no)
				setitem(row, 'trans_name', ls_depositor)
				setcolumn('trans_amt')
			else
				select	a.name	
				into		:ls_name
				from		indb.hin001m a
				where		a.member_no = :data	;

				openwithparm(w_hfn404a_help, ls_name)
		
				lstr_rtn = message.powerobjectparm
			
				if not isvalid(lstr_rtn) then
					setitem(row, 'mem_cust_no', '')
					setitem(row, 'mem_cust_name', '')
					setitem(row, 'bank_code', '')
					setitem(row, 'acct_no', '')
					setitem(row, 'trans_name', '')
					return 1
				end if
		
			/*
				if wf_dup_chk(row, getitemstring(row, 'yyyymmdd'), lstr_rtn.ls_item[1]) > 0 then
					setitem(row, 'mem_cust_no', '')
					setitem(row, 'mem_cust_name', '')
					setitem(row, 'bank_code', '')
					setitem(row, 'acct_no', '')
					setitem(row, 'trans_name', '')
					return 1
				end if
			*/

				setitem(row, 'mem_cust_no', lstr_rtn.ls_item[1])
				setitem(row, 'mem_cust_name', lstr_rtn.ls_item[2])
				setitem(row, 'bank_code', long(lstr_rtn.ls_item[3]))
				setitem(row, 'acct_no', lstr_rtn.ls_item[4])
				setitem(row, 'trans_name', lstr_rtn.ls_item[5])
				setcolumn('trans_amt')
				return 1
			end if
		elseif getitemstring(row, 'mem_cust_gubun') = '2' then
			if len(data) = 7 then		//거래처 코드
				// 거래처
				select	count(cust_no)
				into		:ll_cnt
				from		stdb.hst001m
				where		cust_no = :data	;
				
				if ll_cnt < 1 then
					messagebox('확인', '등록된 거래처가 아닙니다.')
					setitem(row, 'mem_cust_no', '')
					setitem(row, 'mem_cust_name', '')
					setitem(row, 'bank_code', '')
					setitem(row, 'acct_no', '')
					setitem(row, 'trans_name', '')
					return 1
				end if
				
				if ll_cnt = 1 then
					select	cust_name, 	bank_code, 		acct_no, 		depositor
					into		:ls_name, 	:ll_bank_code, :ls_acct_no, 	:ls_depositor
					from		stdb.hst001m
					where		cust_no = :data	;
					
					setitem(row, 'mem_cust_name', ls_name)
					setitem(row, 'bank_code', ll_bank_code)
					setitem(row, 'acct_no', ls_acct_no)
					setitem(row, 'trans_name', ls_depositor)
					setcolumn('trans_amt')
				end if
			elseif len(data) = 10 then		//사업자번호
				// 거래처
				select	count(cust_no)
				into		:ll_cnt
				from		stdb.hst001m
				where		business_no = :data	;
				
				if ll_cnt < 1 then
					messagebox('확인', '등록된 거래처가 아닙니다.')
					setitem(row, 'mem_cust_no', '')
					setitem(row, 'mem_cust_name', '')
					setitem(row, 'bank_code', '')
					setitem(row, 'acct_no', '')
					setitem(row, 'trans_name', '')
					return 1
				end if
				
				if ll_cnt = 1 then
					select	cust_no, 		cust_name, 	bank_code, 		acct_no, 		depositor
					into		:ls_cust_no, 	:ls_name, 	:ll_bank_code, :ls_acct_no, 	:ls_depositor
					from		stdb.hst001m
					where		business_no = :data	;
					
					setitem(row, 'mem_cust_no', ls_cust_no)
					setitem(row, 'mem_cust_name', ls_name)
					setitem(row, 'bank_code', ll_bank_code)
					setitem(row, 'acct_no', ls_acct_no)
					setitem(row, 'trans_name', ls_depositor)
					setcolumn('trans_amt')
					return 1
				end if
			end if
		else
			// 학생
			select	count(member_no)
			into		:ll_cnt
			from		developer.v_login_info
			where		member_no = :data	;
			
			if ll_cnt < 1 then
				messagebox('확인', '등록된 학생이 아닙니다.')
				setitem(row, 'mem_cust_no', '')
				setitem(row, 'mem_cust_name', '')
				setitem(row, 'bank_code', '')
				setitem(row, 'acct_no', '')
				setitem(row, 'trans_name', '')
				return 1
			end if
			
			if ll_cnt = 1 then
				select	upmu_gubun, jol_yn
				into		:ls_gubun, 	:ls_jol_yn
				from		developer.v_login_info
				where		member_no = :data	;
				
				if ls_gubun = '3' then
					if ls_jol_yn = 'Y' then
						select	hname, 		to_number(bank_id), 	account_no, 	account_name
						into		:ls_name, 	:ll_bank_code, 		:ls_acct_no, 	:ls_depositor
						from		haksa.jolup_hakjuk
						where		hakbun = :data	;
					else
						select	hname, 		to_number(bank_id), 	account_no, 	account_name
						into		:ls_name, 	:ll_bank_code, 		:ls_acct_no, 	:ls_depositor
						from		haksa.jaehak_hakjuk
						where		hakbun = :data	;
					end if
				else
					select	hname, 		'', 				''
					into		:ls_name, 	:ls_acct_no, 	:ls_depositor
					from		haksa.d_hakjuk
					where		hakbun = :data	;
	
					setnull(ll_bank_code)
				end if
				
				setitem(row, 'mem_cust_name', ls_name)
				setitem(row, 'bank_code', ll_bank_code)
				setitem(row, 'acct_no', ls_acct_no)
				setitem(row, 'trans_name', ls_depositor)
				setcolumn('trans_amt')
			end if
		end if
	case 'mem_cust_name'
		if isnull(data) or trim(data) = '' then return
		
		if getitemstring(row, 'mem_cust_gubun') = '1' then
			// 교직원
			select	count(a.member_no)
			into		:ll_cnt
			from		padb.hpa020m a, 
						indb.hin001m b
			where		a.member_no = b.member_no
			and		b.name 		like :data||'%'	;
			
			if ll_cnt < 1 then
				messagebox('확인', '등록된 교직원의 계좌정보가 없습니다.')
				setitem(row, 'mem_cust_no', '')
				setitem(row, 'mem_cust_name', '')
				setitem(row, 'bank_code', '')
				setitem(row, 'acct_no', '')
				setitem(row, 'trans_name', '')
				return 1
			end if
			
			if ll_cnt = 1 then
				select	a.member_no, 	a.bank_code, 	a.acct_no, 		a.depositor
				into		:ls_name, 		:ll_bank_code, :ls_acct_no, 	:ls_depositor
				from		padb.hpa020m a, 
							indb.hin001m b
				where		a.member_no = b.member_no
				and		b.name 		like :data||'%'	;
				
				setitem(row, 'mem_cust_no', ls_name)
				setitem(row, 'bank_code', ll_bank_code)
				setitem(row, 'acct_no', ls_acct_no)
				setitem(row, 'trans_name', ls_depositor)
				setcolumn('trans_amt')
			else
				openwithparm(w_hfn404a_help, data)
		
				lstr_rtn = message.powerobjectparm
			
				if not isvalid(lstr_rtn) then
					setitem(row, 'mem_cust_no', '')
					setitem(row, 'mem_cust_name', '')
					setitem(row, 'bank_code', '')
					setitem(row, 'acct_no', '')
					setitem(row, 'trans_name', '')
					return 1
				end if
		
			/*
				if wf_dup_chk(row, getitemstring(row, 'yyyymmdd'), lstr_rtn.ls_item[1]) > 0 then
					setitem(row, 'mem_cust_no', '')
					setitem(row, 'mem_cust_name', '')
					setitem(row, 'bank_code', '')
					setitem(row, 'acct_no', '')
					setitem(row, 'trans_name', '')
					return 1
				end if
			*/

				setitem(row, 'mem_cust_no', lstr_rtn.ls_item[1])
				setitem(row, 'mem_cust_name', lstr_rtn.ls_item[2])
				setitem(row, 'bank_code', long(lstr_rtn.ls_item[3]))
				setitem(row, 'acct_no', lstr_rtn.ls_item[4])
				setitem(row, 'trans_name', lstr_rtn.ls_item[5])
				setcolumn('trans_amt')
				return 1
			end if
		elseif getitemstring(row, 'mem_cust_gubun') = '2' then
			// 거래처
			select	count(cust_no)
			into		:ll_cnt
			from		stdb.hst001m
			where		cust_name like :data||'%'	;
			
			if ll_cnt < 1 then
				messagebox('확인', '등록된 거래처가 아닙니다.')
				setitem(row, 'mem_cust_no', '')
				setitem(row, 'mem_cust_name', '')
				setitem(row, 'bank_code', '')
				setitem(row, 'acct_no', '')
				setitem(row, 'trans_name', '')
				return 1
			end if
			
			if ll_cnt = 1 then
				select	cust_no, 	bank_code, 		acct_no, 		depositor, 		cust_name
				into		:ls_name, 	:ll_bank_code, :ls_acct_no, 	:ls_depositor, :ls_cust_name
				from		stdb.hst001m
				where		cust_name like :data||'%'	;
				
				setitem(row, 'mem_cust_no', ls_name)
				setitem(row, 'mem_cust_name', ls_cust_name)
				setitem(row, 'bank_code', ll_bank_code)
				setitem(row, 'acct_no', ls_acct_no)
				setitem(row, 'trans_name', ls_depositor)
				setcolumn('trans_amt')
				return 1
			else
				openwithparm(w_hfn_cust, data)
				
				lstr_rtn = message.powerobjectparm
			
				if not isvalid(lstr_rtn) then
					setitem(row, 'mem_cust_no', '')
					setitem(row, 'mem_cust_name', '')
					setitem(row, 'bank_code', '')
					setitem(row, 'acct_no', '')
					setitem(row, 'trans_name', '')
					return 1
				end if
		
			/*
				if wf_dup_chk(row, getitemstring(row, 'yyyymmdd'), lstr_rtn.ls_item[1]) > 0 then
					setitem(row, 'mem_cust_no', '')
					setitem(row, 'mem_cust_name', '')
					setitem(row, 'bank_code', '')
					setitem(row, 'acct_no', '')
					setitem(row, 'trans_name', '')
					return 1
				end if
			*/

				setitem(row, 'mem_cust_no', lstr_rtn.ls_item[1])
				setitem(row, 'mem_cust_name', lstr_rtn.ls_item[2])
				setitem(row, 'bank_code', long(lstr_rtn.ls_item[3]))
				setitem(row, 'acct_no', lstr_rtn.ls_item[4])
				setitem(row, 'trans_name', lstr_rtn.ls_item[5])
				setcolumn('trans_amt')
				return 1
			end if
		else
			// 학생
			select	count(member_no)
			into		:ll_cnt
			from		developer.v_login_info
			where		member_name like :data||'%'	;
			
			if ll_cnt < 1 then
				messagebox('확인', '등록된 학생이 아닙니다.')
				setitem(row, 'mem_cust_no', '')
				setitem(row, 'mem_cust_name', '')
				setitem(row, 'bank_code', '')
				setitem(row, 'acct_no', '')
				setitem(row, 'trans_name', '')
				return 1
			end if

			if ll_cnt = 1 then
				select	upmu_gubun, jol_yn
				into		:ls_gubun, 	:ls_jol_yn
				from		developer.v_login_info
				where		member_name like :data||'%'	;
				
				if ls_gubun = '3' then
					if ls_jol_yn = 'Y' then
						select	hname, 		to_number(bank_id), 	account_no, 	account_name
						into		:ls_name, 	:ll_bank_code, 		:ls_acct_no, 	:ls_depositor
						from		haksa.jolup_hakjuk
						where		hname like :data||'%'	;
					else
						select	hname, 		to_number(bank_id), 	account_no, 	account_name
						into		:ls_name, 	:ll_bank_code, 		:ls_acct_no, 	:ls_depositor
						from		haksa.jaehak_hakjuk
						where		hname like :data||'%'	;
					end if
				else
					select	hname, 		'', 				''
					into		:ls_name, 	:ls_acct_no, 	:ls_depositor
					from		haksa.d_hakjuk
					where		hname like :data||'%'	;
	
					setnull(ll_bank_code)
				end if

				setitem(row, 'mem_cust_no', ls_name)
				setitem(row, 'bank_code', ll_bank_code)
				setitem(row, 'acct_no', ls_acct_no)
				setitem(row, 'trans_name', ls_depositor)
				setcolumn('trans_amt')
			else
				openwithparm(w_hfn_hakjuk, data)
				
				lstr_rtn = message.powerobjectparm
			
				if not isvalid(lstr_rtn) then
					setitem(row, 'mem_cust_no', '')
					setitem(row, 'mem_cust_name', '')
					setitem(row, 'bank_code', '')
					setitem(row, 'acct_no', '')
					setitem(row, 'trans_name', '')
					return 1
				end if
		
				if wf_dup_chk(row, getitemstring(row, 'yyyymmdd'), lstr_rtn.ls_item[1]) > 0 then
					setitem(row, 'mem_cust_no', '')
					setitem(row, 'mem_cust_name', '')
					setitem(row, 'bank_code', '')
					setitem(row, 'acct_no', '')
					setitem(row, 'trans_name', '')
					return 1
				end if

				setitem(row, 'mem_cust_no', lstr_rtn.ls_item[1])
				setitem(row, 'mem_cust_name', lstr_rtn.ls_item[2])
				setitem(row, 'bank_code', long(lstr_rtn.ls_item[3]))
				setitem(row, 'acct_no', lstr_rtn.ls_item[4])
				setitem(row, 'trans_name', lstr_rtn.ls_item[5])
				setcolumn('trans_amt')
				return 1
			end if
		end if
end choose

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1812
string text = "자금이체내역"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from datawindow within tabpage_2
integer y = 4
integer width = 4352
integer height = 1808
integer taborder = 50
string title = "none"
string dataobject = "d_hfn904a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_con from uo_dwfree within w_hfn904a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 170
boolean bringtotop = true
string dataobject = "d_hfn701p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)
This.object.date_t.text = '처리일자'
end event

event itemchanged;call super::itemchanged;Accepttext()
Choose Case dwo.name
	Case 'date'
		idw_update[1].reset()
		idw_print.reset()
End Choose

end event

type uo_tab from u_tab within w_hfn904a
event destroy ( )
integer x = 1582
integer y = 312
integer taborder = 160
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

