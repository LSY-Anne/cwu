$PBExportHeader$w_kch401a.srw
$PBExportComments$사용자관리
forward
global type w_kch401a from w_msheet
end type
type st_31 from statictext within w_kch401a
end type
type sle_sabun from u_sle_find within w_kch401a
end type
type st_20 from statictext within w_kch401a
end type
type dw_jikjong_code from datawindow within w_kch401a
end type
type uo_member from cuo_insa_member within w_kch401a
end type
type st_3 from statictext within w_kch401a
end type
type tab_1 from tab within w_kch401a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_main from uo_grid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_main dw_main
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from uo_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_kch401a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from u_tab within w_kch401a
end type
type sle_name from u_sle_find within w_kch401a
end type
type gb_1 from groupbox within w_kch401a
end type
type gb_2 from groupbox within w_kch401a
end type
end forward

global type w_kch401a from w_msheet
integer width = 4507
string title = "사용자관리"
st_31 st_31
sle_sabun sle_sabun
st_20 st_20
dw_jikjong_code dw_jikjong_code
uo_member uo_member
st_3 st_3
tab_1 tab_1
uo_1 uo_1
sle_name sle_name
gb_1 gb_1
gb_2 gb_2
end type
global w_kch401a w_kch401a

type variables

end variables

forward prototypes
public function integer wf_dup_chk (string as_member_no)
end prototypes

public function integer wf_dup_chk (string as_member_no);// ==========================================================================================
// 기    능 : 	자료중복 Check
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_dup_chk(string	as_member_no)	retuen	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long	ll_cnt

ll_cnt = tab_1.tabpage_1.dw_main.find("user_id = '" + as_member_no + "'", 1, tab_1.tabpage_1.dw_main.rowcount())

if ll_cnt > 0 then
	messagebox('확인', '이미 등록된 사용자입니다.')
	return 1
end if

SELECT	COUNT(*)	INTO	:LL_CNT
FROM		CDDB.KCH002M
WHERE		MEMBER_NO = :AS_MEMBER_NO ;

if ll_cnt > 0 then
	messagebox('확인', '이미 등록된 사용자입니다.')
	return 1
end if

return 0
end function

on w_kch401a.create
int iCurrent
call super::create
this.st_31=create st_31
this.sle_sabun=create sle_sabun
this.st_20=create st_20
this.dw_jikjong_code=create dw_jikjong_code
this.uo_member=create uo_member
this.st_3=create st_3
this.tab_1=create tab_1
this.uo_1=create uo_1
this.sle_name=create sle_name
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_31
this.Control[iCurrent+2]=this.sle_sabun
this.Control[iCurrent+3]=this.st_20
this.Control[iCurrent+4]=this.dw_jikjong_code
this.Control[iCurrent+5]=this.uo_member
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.sle_name
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
end on

on w_kch401a.destroy
call super::destroy
destroy(this.st_31)
destroy(this.sle_sabun)
destroy(this.st_20)
destroy(this.dw_jikjong_code)
destroy(this.uo_member)
destroy(this.st_3)
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.sle_name)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_KName

ls_KName = TRIM(uo_member.sle_kname.Text)

String	ls_JikJongCode

ls_JikJongCode = func.of_nvl(TRIM(dw_jikjong_code.Object.code[1]), '%')

SetPointer(HourGlass!)

wf_SetMsg('조회 처리 중입니다...')

Long	ll_RowCnt

tab_1.tabpage_1.dw_main.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_main.Retrieve(ls_KName,ls_JikJongCode)
tab_1.tabpage_1.dw_main.SetReDraw(TRUE)

//ls_JikJongCode = TRIM(dw_jikjong_code.Object.code_name[1])
tab_1.tabpage_2.dw_print.Object.t_jikjong_nm.Text = ls_JikJongCode

ll_RowCnt = tab_1.tabpage_2.dw_print.Retrieve(ls_KName,ls_JikJongCode)

IF ll_RowCnt = 0 THEN
	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
	sle_sabun.SetFocus()
ELSE
	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	tab_1.tabpage_1.dw_main.SetFocus()
END IF

Return 1

end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
sle_Sabun.Text = ''

tab_1.tabpage_1.dw_main.Reset()

sle_sabun.SetFocus()

end event

event ue_print;call super::ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 조회된 자료를 출력한다.
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
tab_1.SelectTab(2)


end event

event ue_save;// ==========================================================================================
// 작성목정 : data save
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

//f_setpointer('START')

int	li_ans,  ii
dwItemStatus lsStatus
String ls_password,  ls_gubun,  ls_member, ls_encrypt_password
string ls_job_gbn, ls_job_uid, ls_job_add 
datetime ld_job_date


tab_1.tabpage_1.dw_main.AcceptText()

FOR ii = 1 TO tab_1.tabpage_1.dw_main.RowCount()
	lsStatus     = tab_1.tabpage_1.dw_main.GetItemStatus(ii, 0, Primary!)
	
	IF lsStatus   = New! OR lsStatus   = NewModified! THEN
		ls_member    = tab_1.tabpage_1.dw_main.GetItemString(ii, 'member_no')
		ls_password  = tab_1.tabpage_1.dw_main.GetItemString(ii, 'password')
		ls_job_gbn   = tab_1.tabpage_1.dw_main.GetItemString(ii, 'job_gbn')
		ls_job_uid   = tab_1.tabpage_1.dw_main.GetItemString(ii, 'job_uid')
		ls_job_add   = tab_1.tabpage_1.dw_main.GetItemString(ii, 'job_add')
		ld_job_date  = tab_1.tabpage_1.dw_main.GetItemDateTime(ii, 'job_date')
		
		INSERT INTO CDDB.KCH002M  
					( MEMBER_NO,   PASSWORD,   JOB_GBN,   JOB_UID,   JOB_ADD,   JOB_DATE )  
		VALUES 	( :ls_member,  sys.CryptIT.encrypt(:ls_password, 'cwu'),	:ls_job_gbn,
					  :ls_job_uid,	:ls_job_add,	:ld_job_date	)  USING SQLCA;

		IF sqlca.sqlcode   <> 0 THEN
			messagebox("알림", '사용자등록, 비밀번호 저장시 오류 ' + sqlca.sqlerrtext)
			rollback  USING SQLCA;
			return -1
		END IF
	ELSEIF lsStatus     = DataModified! OR lsStatus   = New! OR lsStatus   = NewModified! THEN
		ls_password  = tab_1.tabpage_1.dw_main.GetItemString(ii, 'password')
		ls_member    = tab_1.tabpage_1.dw_main.GetItemString(ii, 'user_id')
	
		update cddb.kch002m
		set password  = sys.CryptIT.encrypt(:ls_password, 'cwu')
		where member_no = :ls_member
		  USING SQLCA;
		
		IF sqlca.sqlcode   <> 0 THEN
			messagebox("알림", '비밀번호 저장시 오류 ' + sqlca.sqlerrtext)
			rollback  USING SQLCA;
			return -1
		END IF
	END IF
NEXT

COMMIT  USING SQLCA;

dw_jikjong_code.setitem(1, 'code', 0)
triggerevent('ue_retrieve')

Return 1

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
string	ls_name, ls_member_no, ls_jumin_no, ls_dept_nm, ls_jikjong_nm, ls_jikwi_nm, ls_duty_nm

ls_name       = uo_member.sle_kname.text
ls_member_no  = uo_member.sle_member_no.text
ls_jumin_no   = uo_member.st_jumin_no.text
ls_dept_nm    = uo_member.st_dept_nm.text
ls_jikjong_nm = uo_member.st_jikjong_nm.text
ls_jikwi_nm   = uo_member.st_jikwi_nm.text
ls_duty_nm    = uo_member.st_duty_nm.text

if	isnull(ls_member_no) or trim(ls_member_no) = '' then
	messagebox('확인', '등록할 교직원을 선택하시기 바랍니다.')
	return
end if

// 자료중복 확인
if wf_dup_chk(ls_member_no) > 0 then return

li_newrow	= tab_1.tabpage_1.dw_main.getrow()
if li_newrow < 1 then li_newrow = 1
tab_1.tabpage_1.dw_main.insertrow(li_newrow)

tab_1.tabpage_1.dw_main.setrow(li_newrow)

tab_1.tabpage_1.dw_main.setitem(li_newrow, 'user_nm', ls_name)
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'user_id', ls_member_no)
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'jumin_no', left(ls_jumin_no,6)+right(ls_jumin_no,7))
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'com_dept_nm', ls_dept_nm)
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'com_jikjong_nm', ls_jikjong_nm)
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'com_jikwi_nm', ls_jikwi_nm)
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'com_duty_nm', ls_duty_nm)
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'member_no', ls_member_no)
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'job_gbn', 'Y')
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'job_uid', gstru_uid_uname.uid)
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'job_add', gstru_uid_uname.address)
tab_1.tabpage_1.dw_main.setitem(li_newrow, 'job_date', f_sysdate())

tab_1.tabpage_1.dw_main.setcolumn('password')
tab_1.tabpage_1.dw_main.setfocus()

end event

event ue_delete;call super::ue_delete;// ==========================================================================================
// 작성목정 : data delete
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
// 보이는 datawindow에서만 삭제하고
// 저장시 완전 삭제한다.
tab_1.tabpage_1.dw_main.deleterow(0)
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_open
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp

idw_print = tab_1.tabpage_2.dw_print

dw_jikjong_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF
dw_jikjong_code.InsertRow(0)
dw_jikjong_code.Object.code.dddw.PercentWidth	= 100

tab_1.tabpage_1.dw_main.ShareData(tab_1.tabpage_2.dw_print)
tab_1.tabpage_2.dw_print.Object.DataWindow.Zoom = 100
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'

sle_name.of_register(tab_1.tabpage_1.dw_main,'user_nm')
sle_sabun.of_register(tab_1.tabpage_1.dw_main,'user_id')

THIS.TRIGGER EVENT ue_init()

end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "사용자리스트")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_kch401a
end type

type ln_tempright from w_msheet`ln_tempright within w_kch401a
end type

type ln_temptop from w_msheet`ln_temptop within w_kch401a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_kch401a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_kch401a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_kch401a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_kch401a
end type

type uc_insert from w_msheet`uc_insert within w_kch401a
end type

type uc_delete from w_msheet`uc_delete within w_kch401a
end type

type uc_save from w_msheet`uc_save within w_kch401a
end type

type uc_excel from w_msheet`uc_excel within w_kch401a
end type

type uc_print from w_msheet`uc_print within w_kch401a
end type

type st_line1 from w_msheet`st_line1 within w_kch401a
end type

type st_line2 from w_msheet`st_line2 within w_kch401a
end type

type st_line3 from w_msheet`st_line3 within w_kch401a
end type

type uc_excelroad from w_msheet`uc_excelroad within w_kch401a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_kch401a
end type

type st_31 from statictext within w_kch401a
integer x = 2501
integer y = 276
integer width = 430
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "성명으로 찾기"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_sabun from u_sle_find within w_kch401a
integer x = 3831
integer y = 260
integer width = 462
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long textcolor = 18751006
integer limit = 7
end type

type st_20 from statictext within w_kch401a
integer x = 1353
integer y = 272
integer width = 201
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "직종명"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_jikjong_code from datawindow within w_kch401a
integer x = 1573
integer y = 260
integer width = 695
integer height = 80
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

type uo_member from cuo_insa_member within w_kch401a
event destroy ( )
integer x = 73
integer y = 264
integer width = 1211
integer taborder = 20
long backcolor = 29802942
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type st_3 from statictext within w_kch401a
integer x = 3392
integer y = 276
integer width = 430
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "사번으로 찾기"
alignment alignment = right!
boolean focusrectangle = false
end type

type tab_1 from tab within w_kch401a
event ue_retrieve ( )
integer x = 50
integer y = 472
integer width = 4384
integer height = 1792
integer taborder = 10
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

event ue_retrieve();//PARENT.TRIGGER EVENT ue_retrieve()
end event

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

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1672
string text = "사용자 관리"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_main dw_main
end type

on tabpage_1.create
this.dw_main=create dw_main
this.Control[]={this.dw_main}
end on

on tabpage_1.destroy
destroy(this.dw_main)
end on

type dw_main from uo_grid within tabpage_1
integer x = 5
integer y = 16
integer width = 4320
integer height = 1632
integer taborder = 20
string dataobject = "d_kch401a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1672
string text = "사용자 리스트"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
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

type dw_print from uo_dw within tabpage_2
integer x = 9
integer y = 16
integer width = 4320
integer height = 1644
integer taborder = 40
string dataobject = "d_kch401a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from u_tab within w_kch401a
event destroy ( )
integer x = 439
integer y = 412
integer taborder = 30
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type sle_name from u_sle_find within w_kch401a
integer x = 2935
integer y = 260
integer width = 503
integer height = 80
integer taborder = 11
boolean bringtotop = true
integer limit = 20
end type

type gb_1 from groupbox within w_kch401a
integer x = 2373
integer y = 168
integer width = 2053
integer height = 228
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "조회된 리스트 검색"
end type

type gb_2 from groupbox within w_kch401a
integer x = 55
integer y = 168
integer width = 2309
integer height = 228
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "조회/입력조건"
end type

