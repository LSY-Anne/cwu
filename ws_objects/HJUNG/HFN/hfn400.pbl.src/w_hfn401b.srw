$PBExportHeader$w_hfn401b.srw
$PBExportComments$일마감관리
forward
global type w_hfn401b from w_msheet
end type
type tab_1 from tab within w_hfn401b
end type
type tabpage_1 from userobject within tab_1
end type
type dw_list from cuo_dwwindow_one_hin within tabpage_1
end type
type dw_update from cuo_dwwindow_one_hin within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_list dw_list
dw_update dw_update
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hfn401b
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_con from uo_dwfree within w_hfn401b
end type
type uo_tab from u_tab within w_hfn401b
end type
type st_1 from statictext within w_hfn401b
end type
type st_6 from statictext within w_hfn401b
end type
type cb_delete from uo_imgbtn within w_hfn401b
end type
type cb_create from uo_imgbtn within w_hfn401b
end type
end forward

global type w_hfn401b from w_msheet
tab_1 tab_1
dw_con dw_con
uo_tab uo_tab
st_1 st_1
st_6 st_6
cb_delete cb_delete
cb_create cb_create
end type
global w_hfn401b w_hfn401b

type variables
datawindowchild	idw_child

DataWindow			idw_list



end variables

forward prototypes
public function boolean wf_chk_condition ()
public subroutine wf_setmenubtn (string as_type)
public function boolean wf_update (string as_fr_date, string as_to_date, string as_worker, string as_ipaddr, datetime adt_workdate)
end prototypes

public function boolean wf_chk_condition ();String ls_fr_date,ls_to_date
dw_con.accepttext()
ls_fr_date =  String(dw_con.object.fr_date[1], 'yyyymmdd')
ls_to_date =  String(dw_con.object.to_date[1], 'yyyymmdd')

If ls_fr_date > ls_to_date Then
	dw_con.SetFocus()
	dw_con.setcolumn('to_date')
	MessageBox('확인', '마감일자의 기간을 올바르게 입력하시기 바랍니다.')
	Return False
End If

Return True
end function

public subroutine wf_setmenubtn (string as_type);////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: wf_setmenubtn
////	기 능 설 명: 메뉴의 기능을 활성화/비활성화 처리
////	기 능 설 명: 
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN lb_Value = TRUE
//	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
//	
//	CHOOSE CASE li_idx
//		CASE 1;ib_insert   = lb_Value
//		CASE 2;ib_update   = lb_Value
//		CASE 3;ib_delete   = lb_Value
//		CASE 4;ib_retrieve = lb_Value
//		CASE 5;ib_print    = lb_Value
//		CASE 6;ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

public function boolean wf_update (string as_fr_date, string as_to_date, string as_worker, string as_ipaddr, datetime adt_workdate);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: wf_update
//	기 능 설 명: 총계정관리 테이블에 자료저장
//	기 능 설 명: 
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Date   Ld_Str_Date, Ld_End_Date
String Ls_Close_Date
Long   Ll_Cnt

// 총계정관리 저장
INSERT	INTO	FNDB.HFN502H
SELECT	A.ACCT_CLASS,
			A.BDGT_YEAR,
			A.ACCT_DATE,
			A.ACCT_CODE,
			NVL(SUM(A.DR_ALT_AMT),0),
			NVL(SUM(A.DR_CASH_AMT),0),
			NVL(SUM(A.CR_ALT_AMT),0),
			NVL(SUM(A.CR_CASH_AMT),0),
			:AS_WORKER,
			:AS_IPADDR,
			:ADT_WORKDATE,
			:AS_WORKER,
			:AS_IPADDR,
			:ADT_WORKDATE
FROM		FNDB.HFN501H A
WHERE 	A.ACCT_CLASS = :gi_acct_CLASS
AND		A.ACCT_DATE BETWEEN :AS_FR_DATE AND :AS_TO_DATE
GROUP BY	A.ACCT_CLASS, A.BDGT_YEAR, A.ACCT_DATE, A.ACCT_CODE ;
			
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('일마감자료 저장처리 중 에러가 발생하였습니다.')
	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN FALSE
END IF

// 일마감정보 저장
Ld_Str_Date = dw_con.object.fr_date[1]
Ld_End_Date = dw_con.object.to_date[1]

DO WHILE Ld_Str_Date <= Ld_End_Date
	Ls_Close_Date = String(Ld_Str_Date,'yyyymmdd')
	
	INSERT	INTO	FNDB.HFN010M
	SELECT	:gi_acct_CLASS,
				A.BDGT_YEAR,
				:LS_CLOSE_DATE,
				'Y',
				:AS_WORKER,
				:AS_IPADDR,
				:ADT_WORKDATE,
				:AS_WORKER,
				:AS_IPADDR,
				:ADT_WORKDATE
	FROM		ACDB.HAC003M A
	WHERE 	:LS_CLOSE_DATE BETWEEN A.FROM_DATE AND A.TO_DATE
	AND		BDGT_CLASS = 0
	AND		STAT_CLASS = 0 ;

	IF SQLCA.SQLCODE <> 0 THEN
		wf_SetMsg('일마감자료 저장처리 중 에러가 발생하였습니다.')
		MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
		RETURN FALSE
	END IF
	
	Ld_Str_Date = RelativeDate(Ld_Str_Date,1)
LOOP

// 전표관리에 마감정보 Update
Update	fndb.hfn201m
set		close_yn = 'Y'
where		acct_class = :gi_acct_class
and		acct_date between :as_fr_date and :as_to_date ;

IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('일마감자료 저장처리 중 에러가 발생하였습니다.')
	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN FALSE
END IF

Return True
end function

on w_hfn401b.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_con=create dw_con
this.uo_tab=create uo_tab
this.st_1=create st_1
this.st_6=create st_6
this.cb_delete=create cb_delete
this.cb_create=create cb_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_tab
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.cb_delete
this.Control[iCurrent+7]=this.cb_create
end on

on w_hfn401b.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_tab)
destroy(this.st_1)
destroy(this.st_6)
destroy(this.cb_delete)
destroy(this.cb_create)
end on

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 일마감처리
////	작 성 인 : 이현수
////	작성일자 : 2002.11
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//String Ls_Sys_Date
//
//idw_update[1] = tab_1.tabpage_1.dw_update   // 보조부관리 생성용
//idw_list   = tab_1.tabpage_1.dw_list     // 마감처리정보
//idw_print  = tab_1.tabpage_2.dw_print    // 마감처리정보출력용
//
////	조회조건
//dw_acct_class.getchild('code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve('acct_class', 1) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//dw_acct_class.reset()
//dw_acct_class.insertrow(0)
//
//idw_child.scrolltorow(1)
//idw_child.setrow(1)
//gi_acct_class	=	idw_child.getitemnumber(1, 'code')
//
//Ls_Sys_date = f_today()
//
//em_fr_date.Text = string(ls_sys_date, '@@@@/@@/@@')
//em_to_date.Text = string(ls_sys_date, '@@@@/@@/@@')
//
//idw_list.ShareData(idw_print)
//idw_print.Object.DataWindow.Print.Preview = 'YES'
//idw_print.Object.DataWindow.zoom = 100
//
end event

event ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
DwItemStatus	ldis_Status
string			ls_base_year
Long				ll_Cnt
String   		Ls_Fr_Date, Ls_To_Date, ls_close_date
Date     		Ld_Date, ld_str_date, ld_end_date
Long				ll_Row			//변경된 행
DateTime			ldt_WorkDate	//등록일자
String			ls_Worker		//등록자
String			ls_IpAddr		//등록단말기

IF idw_update[1].ModifiedCount() + idw_update[1].DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 생성 후 저장하시기 바랍니다')
	RETURN -1
END IF

ls_base_year = idw_list.getitemstring(1, 'bdgt_year')
if f_chk_magam(gi_acct_class, ls_base_year) > 0 then return -1

// 일마감정보 저장
Ld_Str_Date = dw_con.object.fr_date[1]
Ld_End_Date = dW_con.object.to_date[1]

DO WHILE Ld_Str_Date <= Ld_End_Date
	Ls_Close_Date = String(Ld_Str_Date,'yyyymmdd')
	
	if f_chk_magam(gi_acct_class, left(ls_close_date,6)) > 0 then return -1
	
	Ld_Str_Date = RelativeDate(Ld_Str_Date,1)
LOOP

// 저장처리전 체크사항 기술
// 일마감자료 생성 전 삭제여부체크

Ls_Fr_Date = String(dw_con.object.fr_date[1], 'yyyymmdd')
Ls_To_Date = String(dw_con.object.to_date[1], 'yyyymmdd')

SELECT	COUNT(*)
INTO		:ll_Cnt
FROM		FNDB.HFN010M A
WHERE		A.ACCT_CLASS = :gi_acct_CLASS
AND		A.CLOSE_DATE BETWEEN :Ls_Fr_Date AND :Ls_To_Date
AND		A.CLOSE_YN = 'Y' ;

IF ll_Cnt > 0 THEN
	Integer	li_Rtn
	li_Rtn = MessageBox('확인','기존에 생성된자료가 존재합니다.~r~n'+&
										'기존자료를 삭제하고 다시 생성하시겠습니까?',&
										Question!,YesNo!,1)
	IF li_Rtn = 1 THEN

		// 보조부관리 삭제
		DELETE
		FROM		FNDB.HFN501H
		WHERE		ACCT_CLASS = :gi_acct_CLASS
		AND		ACCT_DATE BETWEEN :Ls_Fr_Date AND :Ls_To_Date
		AND		SUBSTR(ACCT_DATE,5,4) <> '0000' ;

		IF SQLCA.SQLCODE <> 0 THEN

			wf_SetMsg('일마감자료 삭제처리 중 에러가 발생하였습니다.')
			MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
									'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN -1
		END IF
	
		// 총계정관리 삭제
		DELETE
		FROM		FNDB.HFN502H
		WHERE		ACCT_CLASS = :gi_acct_CLASS
		AND		ACCT_DATE BETWEEN :Ls_Fr_Date AND :Ls_To_Date
		AND		SUBSTR(ACCT_DATE,5,4) <> '0000';

		IF SQLCA.SQLCODE <> 0 THEN

			wf_SetMsg('일마감자료 삭제처리 중 에러가 발생하였습니다.')
			MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
									'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN -1
		END IF

		// 일마감정보 삭제
		DELETE
		FROM		FNDB.HFN010M A
		WHERE		A.ACCT_CLASS = :gi_acct_CLASS
		AND		A.CLOSE_DATE BETWEEN :Ls_Fr_Date AND :Ls_To_Date
		AND		A.CLOSE_YN = 'Y';

		IF SQLCA.SQLCODE <> 0 THEN

			wf_SetMsg('일마감자료 삭제처리 중 에러가 발생하였습니다.')
			MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
									'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN -1
		END IF
	ELSE
		wf_SetMsg('일마감자료 생성을 취소하였습니다.')
		RETURN -1
	END IF
END IF

// 저장처리
ll_Row = idw_update[1].GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gs_empcode		//등록자
	ls_IpAddr    = gs_ip	//등록단말기
END IF

DO WHILE ll_Row > 0
	ldis_Status = idw_update[1].GetItemStatus(ll_Row,0,Primary!)

	// 수정항목 처리
	idw_update[1].Object.worker   [ll_Row] = ls_Worker		//등록자
	idw_update[1].Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
	idw_update[1].Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
	idw_update[1].Object.job_uid  [ll_Row] = ls_Worker		//등록자
	idw_update[1].Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	idw_update[1].Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = idw_update[1].GetNextModified(ll_Row,primary!)
LOOP

// 자료저장처리
wf_SetMsg('변경된 자료를 저장 중 입니다...')

// 보조부관리 저장
If idw_update[1].Update() <> 1 Then

	wf_SetMsg('일마감자료 저장처리 중 에러가 발생하였습니다.')
	ROLLBACK USING SQLCA;	
	RETURN -1
End If

// 총계정관리 저장
If Not wf_update(Ls_fr_date, Ls_to_date, Ls_worker, Ls_ipaddr, Ldt_workdate) Then

	ROLLBACK USING SQLCA;	
	RETURN -1
End If

// 메세지, 메뉴버튼 활성/비활성화 처리
wf_SetMsg('자료가 저장되었습니다.')

COMMIT USING SQLCA;

//wf_SetMenuBtn('SR')

idw_list.SetFocus()



RETURN 1

end event

event ue_print;call super::ue_print;//tab_1.SelectTab(2)
//f_print(tab_1.tabpage_2.dw_print)
//
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 일마감처리
//	작 성 인 : 이현수
//	작성일자 : 2002.11
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
String Ls_Sys_Date

idw_update[1] = tab_1.tabpage_1.dw_update   // 보조부관리 생성용
idw_list   = tab_1.tabpage_1.dw_list     // 마감처리정보
idw_print  = tab_1.tabpage_2.dw_print    // 마감처리정보출력용

//	조회조건

Ls_Sys_date = f_today()

dw_con.object.fr_date[1] = date(string(ls_sys_date, '@@@@/@@/@@'))
dw_con.object.to_date[1] = date(string(ls_sys_date, '@@@@/@@/@@'))

idw_list.ShareData(idw_print)
idw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print.Object.DataWindow.zoom = 100

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_templeft.beginx

If cb_delete.Enabled Then
	cb_delete.X		= ll_stnd_pos
	ll_stnd_pos		= ll_stnd_pos + cb_delete.Width + 16
Else
	cb_delete.Visible	= FALSE
End If

If cb_create.Enabled Then
	cb_create.X		= ll_stnd_pos
	ll_stnd_pos		= ll_stnd_pos + cb_create.Width + 16
Else
	cb_create.Visible	= FALSE
End If
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

type ln_templeft from w_msheet`ln_templeft within w_hfn401b
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn401b
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn401b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn401b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn401b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn401b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn401b
end type

type uc_insert from w_msheet`uc_insert within w_hfn401b
end type

type uc_delete from w_msheet`uc_delete within w_hfn401b
end type

type uc_save from w_msheet`uc_save within w_hfn401b
end type

type uc_excel from w_msheet`uc_excel within w_hfn401b
end type

type uc_print from w_msheet`uc_print within w_hfn401b
end type

type st_line1 from w_msheet`st_line1 within w_hfn401b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn401b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn401b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn401b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn401b
end type

type tab_1 from tab within w_hfn401b
integer x = 50
integer y = 324
integer width = 4384
integer height = 1972
integer taborder = 60
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

event selectionchanged;if tab_1.tabpage_1.dw_list.rowcount() < 1 Then Return

//if newindex = 1 then
//	wf_SetMenuBtn('S')
//else
//	wf_SetMenuBtn('P')
//end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1852
string text = "일마감 관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list dw_list
dw_update dw_update
end type

on tabpage_1.create
this.dw_list=create dw_list
this.dw_update=create dw_update
this.Control[]={this.dw_list,&
this.dw_update}
end on

on tabpage_1.destroy
destroy(this.dw_list)
destroy(this.dw_update)
end on

type dw_list from cuo_dwwindow_one_hin within tabpage_1
integer x = 5
integer y = 8
integer width = 4347
integer height = 1844
integer taborder = 10
string dataobject = "d_hfn401b_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
end event

type dw_update from cuo_dwwindow_one_hin within tabpage_1
boolean visible = false
integer x = 1975
integer y = 444
integer width = 1586
integer height = 788
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "보조부관리생성용"
string dataobject = "d_hfn401b_2"
boolean controlmenu = true
boolean maxbox = true
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1852
string text = "일마감 내역"
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
integer width = 4347
integer height = 1848
integer taborder = 200
string title = "none"
string dataobject = "d_hfn401b_9"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_con from uo_dwfree within w_hfn401b
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 190
boolean bringtotop = true
string dataobject = "d_hfn306q_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)

This.object.fr_date_t.text = '마감일자'
st_1.setposition(totop!)
st_6.setposition(totop!)
end event

event itemchanged;call super::itemchanged;idw_list.Reset()
idw_update[1].Reset()

end event

type uo_tab from u_tab within w_hfn401b
event destroy ( )
integer x = 878
integer y = 312
integer taborder = 140
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

type st_1 from statictext within w_hfn401b
integer x = 1870
integer y = 168
integer width = 1038
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 일마감취소는 자동 저장합니다."
boolean focusrectangle = false
end type

type st_6 from statictext within w_hfn401b
integer x = 1870
integer y = 224
integer width = 1390
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 일마감처리는 저장으로 완료하여야 합니다."
boolean focusrectangle = false
end type

type cb_delete from uo_imgbtn within w_hfn401b
integer x = 55
integer y = 36
integer taborder = 80
boolean bringtotop = true
string btnname = "일마감취소"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_create
//	기 능 설 명: 일마감자료 생성
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
DateTime	Ldt_sysdatetime
String 	Ls_From_Date, Ls_To_Date, ls_close_date
Date   	Ld_Date, ld_str_date, ld_end_date
integer	li_rtn

// 조회조건 체크
IF NOT wf_chk_condition() THEN RETURN

// 일마감정보 저장
Ld_Str_Date = dw_con.object.fr_date[1]
Ld_End_Date = dw_con.object.to_date[1]

DO WHILE Ld_Str_Date <= Ld_End_Date
	Ls_Close_Date = String(Ld_Str_Date,'yyyymmdd')
	
	if f_chk_magam(gi_acct_class, left(ls_close_date,6)) > 0 then return
	
	if f_chk_magam(gi_acct_class, left(ls_close_date,4)) > 0 then return

	Ld_Str_Date = RelativeDate(Ld_Str_Date,1)
LOOP

// 일마감자료 취소

Ls_From_Date = String(dw_con.object.fr_date[1], 'yyyymmdd')

Ls_To_Date = String(dw_con.object.to_date[1], 'yyyymmdd')

li_Rtn = MessageBox('확인','일마감 취소처리를 하시겠습니까?',Question!,YesNo!,1)

if li_rtn <> 1 then return


// 보조부관리 삭제
DELETE
FROM		FNDB.HFN501H
WHERE		ACCT_CLASS = :gi_acct_CLASS
AND		ACCT_DATE BETWEEN :Ls_From_Date AND :Ls_To_Date
AND		SUBSTR(ACCT_DATE,5,4) <> '0000' ;

IF SQLCA.SQLCODE <> 0 THEN
	ROLLBACK USING SQLCA;	

	wf_SetMsg('일마감자료 삭제처리 중 에러가 발생하였습니다.')
	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN
END IF
	
// 총계정관리 삭제
DELETE
FROM		FNDB.HFN502H
WHERE		ACCT_CLASS = :gi_acct_CLASS
AND		ACCT_DATE BETWEEN :Ls_From_Date AND :Ls_To_Date
AND		SUBSTR(ACCT_DATE,5,4) <> '0000';

IF SQLCA.SQLCODE <> 0 THEN
	ROLLBACK USING SQLCA;	

	wf_SetMsg('일마감자료 삭제처리 중 에러가 발생하였습니다.')
	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN
END IF

// 일마감정보 삭제
DELETE
FROM		FNDB.HFN010M A
WHERE		A.ACCT_CLASS = :gi_acct_CLASS
AND		A.CLOSE_DATE BETWEEN :Ls_From_Date AND :Ls_To_Date
AND		A.CLOSE_YN = 'Y';

IF SQLCA.SQLCODE <> 0 THEN
	ROLLBACK USING SQLCA;	

	wf_SetMsg('일마감자료 삭제처리 중 에러가 발생하였습니다.')
	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN
END IF

// 전표마감정보 Update
UPDATE	FNDB.HFN201M
SET		CLOSE_YN = 'N'
WHERE		ACCT_CLASS = :gi_acct_CLASS
AND		ACCT_DATE BETWEEN :Ls_From_Date AND :Ls_To_Date;

IF SQLCA.SQLCODE <> 0 THEN
	ROLLBACK USING SQLCA;	

	wf_SetMsg('일마감자료 삭제처리 중 에러가 발생하였습니다.')
	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN
END IF

commit using sqlca ;



end event

on cb_delete.destroy
call uo_imgbtn::destroy
end on

type cb_create from uo_imgbtn within w_hfn401b
integer x = 480
integer y = 36
integer taborder = 90
boolean bringtotop = true
string btnname = "일마감처리"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_create
//	기 능 설 명: 일마감자료 생성
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
//DateTime	Ldt_sysdatetime
String 	Ls_From_Date, Ls_To_Date
Date   	Ld_Date
Long   	Ll_Row, Ll_Ins_Row

// 조회조건 체크
IF NOT wf_chk_condition() THEN RETURN



// 일마감자료 생성자료 조회
Ls_From_Date = String(dw_con.object.fr_date[1], 'yyyymmdd')
Ls_To_Date = String(dw_con.object.to_date[1], 'yyyymmdd')

idw_list.SetRedraw(False)
idw_list.Reset()
idw_list.Retrieve(gi_acct_class, Ls_From_Date, Ls_To_Date)
idw_list.SetRedraw(True)

idw_update[1].Reset()
FOR Ll_Row = 1 TO idw_list.RowCount()
    Ll_Ins_Row = idw_update[1].InsertRow(0)
	 
	 // 저장할 Data Move
	 idw_update[1].Object.acct_class [Ll_Ins_Row] = idw_list.Object.com_acct_class [Ll_Row]	// 회계단위
	 idw_update[1].Object.bdgt_year  [Ll_Ins_Row] = idw_list.Object.bdgt_year      [Ll_Row]	// 회계년도
	 idw_update[1].Object.acct_date  [Ll_Ins_Row] = idw_list.Object.com_slip_date  [Ll_Row]	// 회계일자
	 idw_update[1].Object.acct_code  [Ll_Ins_Row] = idw_list.Object.com_acct_code  [Ll_Row]	// 계정과목
	 idw_update[1].Object.mana_code  [Ll_Ins_Row] = idw_list.Object.com_mana_code  [Ll_Row]	// 관리항목코드
	 idw_update[1].Object.mana_data  [Ll_Ins_Row] = idw_list.Object.com_mana_data  [Ll_Row]	// 관리항목자료
	 idw_update[1].Object.dr_alt_amt [Ll_Ins_Row] = idw_list.Object.com_dr_alt_amt [Ll_Row]	// 차변대체액
	 idw_update[1].Object.dr_cash_amt[Ll_Ins_Row] = idw_list.Object.com_dr_cash_amt[Ll_Row]	// 차변현금액
	 idw_update[1].Object.cr_alt_amt [Ll_Ins_Row] = idw_list.Object.com_cr_alt_amt [Ll_Row]	// 대변대체액
	 idw_update[1].Object.cr_cash_amt[Ll_Ins_Row] = idw_list.Object.com_cr_cash_amt[Ll_Row]	// 대변현금액
NEXT

// 메세지처리
IF idw_list.RowCount() > 0 THEN
//   ldt_SysDateTime = f_sysdate()
//   idw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//   idw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

//	wf_SetMenuBtn('S')
	wf_SetMsg('일마감자료가 생성되었습니다. 확인 후 자료를 저장하시기 바랍니다.')
ELSE
	wf_SetMsg('생성할 자료가 없습니다.')
END IF


end event

on cb_create.destroy
call uo_imgbtn::destroy
end on

