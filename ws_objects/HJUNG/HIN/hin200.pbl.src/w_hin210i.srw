$PBExportHeader$w_hin210i.srw
$PBExportComments$가족사항관리
forward
global type w_hin210i from w_msheet
end type
type ddlb_gubn from dropdownlistbox within w_hin210i
end type
type st_99 from statictext within w_hin210i
end type
type dw_jaejik_opt from datawindow within w_hin210i
end type
type st_21 from statictext within w_hin210i
end type
type dw_dept_code from datawindow within w_hin210i
end type
type st_19 from statictext within w_hin210i
end type
type dw_duty_code from datawindow within w_hin210i
end type
type st_20 from statictext within w_hin210i
end type
type cbx_seq from checkbox within w_hin210i
end type
type tab_1 from tab within w_hin210i
end type
type tabpage_1 from userobject within tab_1
end type
type p_image from picture within tabpage_1
end type
type dw_update1 from cuo_dwwindow_one_hin within tabpage_1
end type
type tabpage_1 from userobject within tab_1
p_image p_image
dw_update1 dw_update1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_update2 from cuo_dwwindow_one_hin within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_update2 dw_update2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_update3 from cuo_dwwindow_one_hin within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_update3 dw_update3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_update4 from cuo_dwwindow_one_hin within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_update4 dw_update4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_update5 from cuo_dwwindow_one_hin within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_update5 dw_update5
end type
type tabpage_6 from userobject within tab_1
end type
type dw_update6 from cuo_dwwindow_one_hin within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_update6 dw_update6
end type
type tabpage_7 from userobject within tab_1
end type
type dw_update7 from cuo_dwwindow_one_hin within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_update7 dw_update7
end type
type tabpage_8 from userobject within tab_1
end type
type dw_update8 from cuo_dwwindow_one_hin within tabpage_8
end type
type tabpage_8 from userobject within tab_1
dw_update8 dw_update8
end type
type tabpage_11 from userobject within tab_1
end type
type dw_list4 from cuo_dwwindow_one_hin within tabpage_11
end type
type tabpage_11 from userobject within tab_1
dw_list4 dw_list4
end type
type tabpage_9 from userobject within tab_1
end type
type dw_list2 from cuo_dwwindow_one_hin within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_list2 dw_list2
end type
type tabpage_10 from userobject within tab_1
end type
type dw_list3 from cuo_dwwindow_one_hin within tabpage_10
end type
type tabpage_10 from userobject within tab_1
dw_list3 dw_list3
end type
type tab_1 from tab within w_hin210i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_11 tabpage_11
tabpage_9 tabpage_9
tabpage_10 tabpage_10
end type
type dw_list1 from cuo_dwwindow_one_hin within w_hin210i
end type
type uo_member from cuo_insa_member within w_hin210i
end type
type gb_1 from groupbox within w_hin210i
end type
end forward

global type w_hin210i from w_msheet
string title = "가족사항관리"
ddlb_gubn ddlb_gubn
st_99 st_99
dw_jaejik_opt dw_jaejik_opt
st_21 st_21
dw_dept_code dw_dept_code
st_19 st_19
dw_duty_code dw_duty_code
st_20 st_20
cbx_seq cbx_seq
tab_1 tab_1
dw_list1 dw_list1
uo_member uo_member
gb_1 gb_1
end type
global w_hin210i w_hin210i

type variables
DataWindowChild	idwc_DutyCode	//직급코드 DDDW
DataWindowChild	idwc_SalClass	//호봉코드 DDDW
//DataWindow			idw_update[]		//
//세부사항명들
String				is_SubTitle[] = {'[인사기본정보]',&
											  '[신상정보상세]',&
											  '[가족사항]',&
											  '[학력사항]',&
											  '[경력사항]',&
											  '[자격사항]',&
											  '[포상.징계사항]',&
											  '[해외연수사항]',&
											  '[보직사항]',&
											  '[변동이력]',&
											  '[위원회이력]'}


end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

public subroutine wf_setmenubtn (string as_type);//입력
////저장
////삭제
////조회
////검색
//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN
//		CHOOSE CASE ls_Flag[li_idx]
//			CASE 'I' ; IF is_Auth[1] = 'Y' THEN lb_Value = TRUE
//			CASE 'S' ; IF is_Auth[3] = 'Y' THEN lb_Value = TRUE
//			CASE 'D' ; IF is_Auth[2] = 'Y' THEN lb_Value = TRUE
//			CASE 'R' ; IF is_Auth[4] = 'Y' THEN lb_Value = TRUE
//			CASE 'P' ; IF is_Auth[5] = 'Y' THEN lb_Value = TRUE
//		END CHOOSE
//	END IF
//	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
//	
//	CHOOSE CASE ls_Flag[li_idx]
//		CASE 'I' ;ib_insert   = lb_Value
//		CASE 'S' ;ib_update   = lb_Value
//		CASE 'D' ;ib_delete   = lb_Value
//		CASE 'R' ;ib_retrieve = lb_Value
//		CASE 'P' ;ib_print    = lb_Value
//		CASE 'P' ;ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

on w_hin210i.create
int iCurrent
call super::create
this.ddlb_gubn=create ddlb_gubn
this.st_99=create st_99
this.dw_jaejik_opt=create dw_jaejik_opt
this.st_21=create st_21
this.dw_dept_code=create dw_dept_code
this.st_19=create st_19
this.dw_duty_code=create dw_duty_code
this.st_20=create st_20
this.cbx_seq=create cbx_seq
this.tab_1=create tab_1
this.dw_list1=create dw_list1
this.uo_member=create uo_member
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_gubn
this.Control[iCurrent+2]=this.st_99
this.Control[iCurrent+3]=this.dw_jaejik_opt
this.Control[iCurrent+4]=this.st_21
this.Control[iCurrent+5]=this.dw_dept_code
this.Control[iCurrent+6]=this.st_19
this.Control[iCurrent+7]=this.dw_duty_code
this.Control[iCurrent+8]=this.st_20
this.Control[iCurrent+9]=this.cbx_seq
this.Control[iCurrent+10]=this.tab_1
this.Control[iCurrent+11]=this.dw_list1
this.Control[iCurrent+12]=this.uo_member
this.Control[iCurrent+13]=this.gb_1
end on

on w_hin210i.destroy
call super::destroy
destroy(this.ddlb_gubn)
destroy(this.st_99)
destroy(this.dw_jaejik_opt)
destroy(this.st_21)
destroy(this.dw_dept_code)
destroy(this.st_19)
destroy(this.dw_duty_code)
destroy(this.st_20)
destroy(this.cbx_seq)
destroy(this.tab_1)
destroy(this.dw_list1)
destroy(this.uo_member)
destroy(this.gb_1)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 인사기본정보를 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 부서명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
Long					ll_InsRow
dw_dept_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa','9999')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
dw_dept_code.InsertRow(0)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 직급명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_duty_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('직급코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','0')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
dw_duty_code.InsertRow(0)
dw_duty_code.Object.code.dddw.PercentWidth = 100
////////////////////////////////////////////////////////////////////////////////////
// 1.3 조회조건 - 재직구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_jaejik_opt.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
	wf_setmsg('공통코드[재직]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','0')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
dw_jaejik_opt.InsertRow(0)
dw_jaejik_opt.Object.code[1] = '1'
dw_jaejik_opt.Object.code.dddw.PercentWidth = 100

idw_update[01] = tab_1.tabpage_1.dw_update1
idw_update[02] = tab_1.tabpage_2.dw_update2
idw_update[03] = tab_1.tabpage_3.dw_update3
idw_update[04] = tab_1.tabpage_4.dw_update4
idw_update[05] = tab_1.tabpage_5.dw_update5
idw_update[06] = tab_1.tabpage_6.dw_update6
idw_update[07] = tab_1.tabpage_7.dw_update7
idw_update[08] = tab_1.tabpage_8.dw_update8
idw_update[09] = tab_1.tabpage_9.dw_list2
idw_update[10] = tab_1.tabpage_10.dw_list3
idw_update[11] = tab_1.tabpage_11.dw_list4
wf_SetMsg('인사기본정보를 초기화 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 1.1 성별코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_성별구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_성별구분]를 초기화 중입니다...','')
idw_update[01].GetChild('sex_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('sex_code',0) = 0 THEN
	wf_setmsg('공통코드[성별]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.2 국가코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_국가코드]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_국가코드]를 초기화 중입니다...','')
idw_update[01].GetChild('nation_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('kukjuk_code',0) = 0 THEN
	wf_setmsg('공통코드[국가]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.3 재직코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_재직구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_재직구분]를 초기화 중입니다...','')
idw_update[01].GetChild('jaejik_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
	wf_setmsg('공통코드[재직]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.4 조직코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '인사기본정보_조직코드를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'인사기본정보_조직코드를 초기화 중입니다...','')
idw_update[01].GetChild('gwa',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('조직코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.5 직위구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_직위코드]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_직위코드]를 초기화 중입니다...','')
idw_update[01].GetChild('jikwi_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikwi_code',0) = 0 THEN
	wf_setmsg('공통코드[직위]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.6 직급구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '인사기본정보_직급코드를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'인사기본정보_직급코드를 초기화 중입니다...','')
idw_update[01].GetChild('duty_code',idwc_DutyCode)
idwc_DutyCode.SetTransObject(SQLCA)
IF idwc_DutyCode.Retrieve() = 0 THEN
	wf_setmsg('직급코드를 입력하시기 바랍니다.')
	idwc_DutyCode.InsertRow(0)
ELSE
	idwc_DutyCode.SetFilter("NOT(code = '100' OR MID(code,1,1) IN ('6','8'))")
	idwc_DutyCode.Filter()
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.6 직무구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_직무코드]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_직무코드]를 초기화 중입니다...','')
idw_update[01].GetChild('jikmu_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikmu_code',0) = 0 THEN
	wf_setmsg('공통코드[직무]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.7 최상위보직구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '인사기본정보_최상위보직코드를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'인사기본정보_최상위보직코드를 초기화 중입니다...','')
idw_update[01].GetChild('up_bojik_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve(9) = 0 THEN
	wf_setmsg('최상위보직코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.8 보직구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '인사기본정보_보직코드를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'인사기본정보_보직코드를 초기화 중입니다...','')
idw_update[01].GetChild('bojik_code1',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve(9) = 0 THEN
	wf_setmsg('보직코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.9 변동구분DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_변동코드]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_변동코드]를 초기화 중입니다...','')
idw_update[01].GetChild('change_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('change_opt',0) = 0 THEN
	wf_setmsg('공통코드[변동]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.10 최종학력DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_학력구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_학력구분]를 초기화 중입니다...','')
idw_update[01].GetChild('last_school_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('last_school_code',0) = 0 THEN
	wf_setmsg('공통코드[학력]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.11 연봉DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_연봉구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_연봉구분]를 초기화 중입니다...','')
idw_update[01].GetChild('ann_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('ann_opt',0) = 0 THEN
	wf_setmsg('공통코드[연봉]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.12 역종DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_역종코드]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_역종코드]를 초기화 중입니다...','')
idw_update[01].GetChild('work_kind',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('yukjong_code',0) = 0 THEN
	wf_setmsg('공통코드[역종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.13 군별DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_군별코드]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_군별코드]를 초기화 중입니다...','')
idw_update[01].GetChild('army_kind',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('isarmy_code',0) = 0 THEN
	wf_setmsg('공통코드[군별]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.14 계급DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_계급코드]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_계급코드]를 초기화 중입니다...','')
idw_update[01].GetChild('army_rank',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('gegub_code',0) = 0 THEN
	wf_setmsg('공통코드[계급]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.15 호봉DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
String	ls_SysDate
ls_SysDate = f_today()
f_set_message("[알림] " + '인사기본정보_호봉코드를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'인사기본정보_호봉코드를 초기화 중입니다...','')
idw_update[01].GetChild('sal_class',idwc_SalClass)
idwc_SalClass.SetTransObject(SQLCA)
IF idwc_SalClass.Retrieve(MID(ls_SysDate,1,4),'101') = 0 THEN
	wf_setmsg('호봉코드를 입력하시기 바랍니다.')
	idwc_SalClass.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.16 졸업구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[인사기본정보_졸업구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[인사기본정보_졸업구분]를 초기화 중입니다...','')
idw_update[01].GetChild('sal_graduate',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('graduate_opt',0) = 0 THEN
	wf_setmsg('공통코드[졸업]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

idw_update[01].SetReDraw(FALSE)
idw_update[01].Reset()
idw_update[01].InsertRow(0)
idw_update[01].Object.DataWindow.ReadOnly = 'YES'
idw_update[01].SetReDraw(TRUE)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 신상상세정보 DDDW초기화
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('신상상세정보를 초기화 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 2.1 종교 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[신상상세정보_종교코드]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[신상상세정보_종교코드]를 초기화 중입니다...','')
idw_update[02].GetChild('jonggyo_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jonggyo_code',0) = 0 THEN
	wf_setmsg('공통코드[종교]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 2.2 보훈구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[신상상세정보_보훈구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[신상상세정보_보훈구분]를 초기화 중입니다...','')
idw_update[02].GetChild('bohun_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('bohun_opt',0) = 0 THEN
	wf_setmsg('공통코드[보훈구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 2.3 장애구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[신상상세정보_장애구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[신상상세정보_장애구분]를 초기화 중입니다...','')
idw_update[02].GetChild('handicap_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('handicap_opt',0) = 0 THEN
	wf_setmsg('공통코드[장애구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 2.4 관계 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[신상상세정보_관계구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[신상상세정보_관계구분]를 초기화 중입니다...','')
idw_update[02].GetChild('gwangae_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('gwangae_code',0) = 0 THEN
	wf_setmsg('공통코드[관계]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 2.5 특기 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[신상상세정보_특기구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[신상상세정보_특기구분]를 초기화 중입니다...','')
idw_update[02].GetChild('specialty',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('specialty_opt',0) = 0 THEN
	wf_setmsg('공통코드[특기]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 2.6 취미 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[신상상세정보_취미구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[신상상세정보_취미구분]를 초기화 중입니다...','')
idw_update[02].GetChild('hobby',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('hobby_opt',0) = 0 THEN
	wf_setmsg('공통코드[취미]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 2.7 주거 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[신상상세정보_주거구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[신상상세정보_주거구분]를 초기화 중입니다...','')
idw_update[02].GetChild('house_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('house_code',0) = 0 THEN
	wf_setmsg('공통코드[주거]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 2.8 은행 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '신상상세정보_은행코드를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'신상상세정보_은행코드를 초기화 중입니다...','')
idw_update[02].GetChild('bank_cd1',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('bank_code',0) = 0 THEN
	wf_setmsg('은행코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
ldwc_Temp.SetSort('fname ASC')
ldwc_Temp.Sort()
////////////////////////////////////////////////////////////////////////////////////
// 2.9 은행 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '신상상세정보_은행코드를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'신상상세정보_은행코드를 초기화 중입니다...','')
idw_update[02].GetChild('bank_cd2',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('bank_code',0) = 0 THEN
	wf_setmsg('은행코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
ldwc_Temp.SetSort('fname ASC')
ldwc_Temp.Sort()

///////////////////////////////////////////////////////////////////////////////////////
// 3. 가족사항 DDDW초기화
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('가족사항을 초기화 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 3.1 관계 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[가족사항_관계구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[가족사항_관계구분]를 초기화 중입니다...','')
idw_update[03].GetChild('gwangae_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('gwangae_code',0) = 0 THEN
	wf_setmsg('공통코드[관계]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 3.2 장애 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[가족사항_장애구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[가족사항_장애구분]를 초기화 중입니다...','')
idw_update[03].GetChild('handicap_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('handicap_opt',0) = 0 THEN
	wf_setmsg('공통코드[장애]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 4. 학력사항 DDDW초기화
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('학력사항을 초기화 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 4.1 학위취득국가DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[학력사항_국적구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[학력사항_국적구분]를 초기화 중입니다...','')
idw_update[04].GetChild('hakwi_nation',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('kukjuk_code',0) = 0 THEN
	wf_setmsg('공통코드[국적]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 4.2 최종학력DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[학력사항_학력구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[학력사항_학력구분]를 초기화 중입니다...','')
idw_update[04].GetChild('last_school_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('last_school_code',0) = 0 THEN
	wf_setmsg('공통코드[학력]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 4.3 졸업구분DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[학력사항_졸업구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[학력사항_졸업구분]를 초기화 중입니다...','')
idw_update[04].GetChild('sal_graduate',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('graduate_opt',0) = 0 THEN
	wf_setmsg('공통코드[졸업]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 5. 경력사항 DDDW초기화
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('경력사항을 초기화 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 5.1 경력구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[경력사항_경력구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[경력사항_경력구분]를 초기화 중입니다...','')
idw_update[05].GetChild('career_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('career_opt',0) = 0 THEN
	wf_setmsg('공통코드[경력]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 5.2 처리구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[경력사항_처리구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[경력사항_처리구분]를 초기화 중입니다...','')
idw_update[05].GetChild('proces_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('proces_opt',0) = 0 THEN
	wf_setmsg('공통코드[처리]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 6. 자격사항 DDDW초기화
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자격사항을 초기화 중입니다...')

///////////////////////////////////////////////////////////////////////////////////////
// 7. 포상징계 DDDW초기화
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('포상징계사항을 초기화 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 7.1 상벌 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[포상징계사항_상벌]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[포상징계사항_상벌]를 초기화 중입니다...','')
idw_update[07].GetChild('prize_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('prize_code',0) = 0 THEN
	wf_setmsg('공통코드[상벌]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 8. 해외연수사항 DDDW초기화
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('홰외연수사항을 초기화 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 8.1 연수구분DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[해외연수사항_연수구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[해외연수사항_연수구분]를 초기화 중입니다...','')
idw_update[08].GetChild('master_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('master_opt',0) = 0 THEN
	wf_setmsg('공통코드[연수]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 8.2 국가코드DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '공통코드[해외연수사항_국적구분]를 초기화 중입니다...', '', parentwin)
//f_dis_msg(1,'공통코드[해외연수사항_국적구분]를 초기화 중입니다...','')
idw_update[08].GetChild('nation_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('kukjuk_code',0) = 0 THEN
	wf_setmsg('공통코드[국적]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 9. 보직사항 DDDW초기화
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('보직사항을 초기화 중입니다...')

///////////////////////////////////////////////////////////////////////////////////////
// 10. 인사변동DDDW초기화
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사변동사항을 초기화 중입니다...')

///////////////////////////////////////////////////////////////////////////////////////
// 11.  초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 1.1 부서명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_DeptCode
ls_DeptCode = TRIM(dw_dept_code.Object.code[1])
IF LEN(ls_DeptCode) = 0 OR isNull(ls_DeptCode) OR ls_DeptCode = '9999' THEN &
	ls_DeptCode = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.2 직급명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_DutyCode
ls_DutyCode = TRIM(dw_duty_code.Object.code[1])
IF LEN(ls_DutyCode) = 0 OR isNull(ls_DutyCode) OR ls_DutyCode = '0' THEN &
	ls_DutyCode = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.3 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.4 재직구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JaejikOpt
ls_JaejikOpt = TRIM(dw_jaejik_opt.Object.code[1])
IF LEN(ls_JaejikOpt) = 0 OR isNull(ls_JaejikOpt) OR ls_JaejikOpt = '0' THEN &
	ls_JaejikOpt = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.5 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JikJongCode
ls_JikJongCode = MID(ddlb_gubn.Text,1,1)


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_list1.SetReDraw(FALSE)
ll_RowCnt = dw_list1.Retrieve(ls_DeptCode,ls_DutyCode,ls_KName,ls_JaejikOpt,ls_JikJongCode)
dw_list1.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN
//	wf_SetMenuBtn('IR')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 자료추가전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 자료추가전 필수입력사항 체크
////////////////////////////////////////////////////////////////////////////////////
Integer	li_SelectedTab
li_SelectedTab = tab_1.SelectedTab
IF li_SelectedTab = 0 THEN RETURN
IF li_SelectedTab = 9 OR li_SelectedTab = 10 OR li_SelectedTab = 11 THEN
	wf_SetMsg('이력자료는 조회만 가능합니다.')
	MessageBox('확인','이력자료는 조회만 가능합니다.')
	RETURN
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.2 입력조건 체크
////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')
/////////////////////////////////////////////////////////////////////////////////
// 1.2.1 직종명 입력여부 체크
/////////////////////////////////////////////////////////////////////////////////
String	ls_DutyCode
ls_DutyCode = TRIM(dw_duty_code.Object.code[1])
IF LEN(ls_DutyCode) = 0 OR isNull(ls_DutyCode) OR ls_DutyCode = '0' THEN &
	ls_DutyCode = ''
/////////////////////////////////////////////////////////////////////////////////
// 1.2.2 성명 입력여부 체크
/////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)


///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_InsRow
Long		ll_idx
IF li_SelectedTab = 1 THEN
	FOR ll_idx = 1 TO UpperBound(idw_update)
		idw_update[ll_idx].Reset()
	NEXT
	Blob	lbo_Image
	SetNull(lbo_Image)
	tab_1.tabpage_1.p_image.picturename = "../bmp/blank.bmp"
	tab_1.tabpage_1.p_image.SetPicture(lbo_Image)
	
	idw_update[2].InsertRow(0)
	idw_update[2].Object.DataWindow.ReadOnly = 'YES'
END IF
IF li_SelectedTab = 2 THEN idw_update[li_SelectedTab].Reset()

ll_InsRow = idw_update[li_SelectedTab].InsertRow(0)
IF ll_InsRow = 0 THEN RETURN
idw_update[li_SelectedTab].ScrollToRow(ll_InsRow)
// Appeon Deploy 시 오류나서 막음. 사용할 수 없는 Event 임.
//idw_update[li_SelectedTab].Object.DataWindow.HorizontalScrollPosition = 0
////////////////////////////////////////////////////////////////////////////////////
// 2.1 개인번호 자동생성여부 체크
////////////////////////////////////////////////////////////////////////////////////
Boolean	lb_Chk
lb_Chk = cbx_seq.Checked
IF lb_Chk THEN
	idw_update[1].Object.member_no.protect = '1'
	idw_update[1].Object.member_no.background.color = 536870912
ELSE
	idw_update[1].Object.member_no.protect = '0'
	idw_update[1].Object.member_no.background.color = RGB(255,255,255)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_SysDate
Integer	li_ChangeOpt
String	ls_ColName
Integer	li_NationCode

ls_SysDate = f_today()
CHOOSE CASE UPPER(SQLCA.ServerName)
	CASE 'SEWC','KDUC','KPU9'
		li_ChangeOpt  = 11	//발령구분(11:신규임용)
		li_NationCode = 118	//국적코드(118:대한민국)
	CASE 'ORA9'
		li_ChangeOpt  = 1		//발령구분(1:수습)
		li_NationCode = 1		//국적코드(1:대한민국)
END CHOOSE

CHOOSE CASE li_SelectedTab
	CASE 1	//인사기본정보	
		idw_update[li_SelectedTab].Object.name           [ll_InsRow] = ls_KName					//성명
		idw_update[li_SelectedTab].Object.jaejik_opt     [ll_InsRow] = 1							//재직구분(1:재직)
		idw_update[li_SelectedTab].Object.nation_code    [ll_InsRow] = li_NationCode			//국적코드
		idw_update[li_SelectedTab].Object.change_opt     [ll_InsRow] = li_ChangeOpt			//발령구분
		idw_update[li_SelectedTab].Object.sal_year       [ll_InsRow] = MID(ls_SysDate,1,4)	//호봉년도
		
		//당년도 3월부터 9월까지이면 9월1일로 셋팅
		//전년도 9월부터 12월까지, 당년도 1월부터 2월 까지이면 3월1일로 셋팅한다 
		Integer	li_Year
		Integer	li_Month
		li_Year  = Integer(MID(ls_SysDate,1,4))	//년도
		li_Month = Integer(MID(ls_SysDate,5,2))	//월
		CHOOSE CASE li_Month
			CASE IS > 2	
				IF li_Month < 9 THEN
					ls_SysDate = String(li_Year,'0000') + '0901'
				ELSE
					ls_SysDate = String(li_Year + 1,'0000') + '0301'
				END IF
			CASE IS < 3
				ls_SysDate = String(li_Year,'0000') + '0301'
		END CHOOSE
		idw_update[li_SelectedTab].Object.firsthire_date [ll_InsRow] = ls_SysDate	//대학임용일자
		idw_update[li_SelectedTab].Object.hakwonhire_date[ll_InsRow] = ls_SysDate	//학원임용일자
		idw_update[li_SelectedTab].Object.sosok_date     [ll_InsRow] = ls_SysDate	//소속일자
		
		//직급코드가 시간강사인 경우는 소속은 교양과, 직급은 시간강사로 SETTING한다.
		IF ls_DutyCode = '301' THEN
			idw_update[li_SelectedTab].Object.gwa         [ll_InsRow] = '5200'		//소속코드
			idw_update[li_SelectedTab].Object.duty_code   [ll_InsRow] = '301'			//직급코드
		END IF
		
		IF lb_Chk THEN
			ls_ColName = 'name'
		ELSE
			ls_ColName = 'member_no'
		END IF
		idw_update[li_SelectedTab].Object.DataWindow.ReadOnly = 'NO'
	CASE 2	//신상상세정보
		ls_ColName = 'working'
		idw_update[li_SelectedTab].Object.DataWindow.ReadOnly = 'NO'
	CASE 3	//가족사항
		idw_update[li_SelectedTab].Object.sudang_yn      [ll_InsRow] = '0'				//수당여부
		idw_update[li_SelectedTab].Object.gongje_yn      [ll_InsRow] = '0'				//공제여부
		ls_ColName = 'jumin_no'
	CASE 4	//학력사항
		idw_update[li_SelectedTab].Object.from_date      [ll_InsRow] = ls_SysDate		//시작일자
		idw_update[li_SelectedTab].Object.sign_opt       [ll_InsRow] = 3					//결재구분
		idw_update[li_SelectedTab].Object.graduate_opt   [ll_InsRow] = 1					//졸업여부
		idw_update[li_SelectedTab].Object.hakwi_nation   [ll_InsRow] = li_NationCode	//국적코드
		ls_ColName = 'from_date'
	CASE 5	//경력사항
		idw_update[li_SelectedTab].Object.career_gbn     [ll_InsRow] = 1					//교외구분
		idw_update[li_SelectedTab].Object.sign_opt       [ll_InsRow] = 3					//결재구분
		ls_ColName = 'proces_opt'
	CASE 6	//자격사항
		idw_update[li_SelectedTab].Object.decision_opt   [ll_InsRow] = '1'				//인정구분
		ls_ColName = 'certify_no'
	CASE 7	//포상.징계사항
		idw_update[li_SelectedTab].Object.from_date      [ll_InsRow] = ls_SysDate		//시작일자
		ls_ColName = 'prize_code'
	CASE 8	//해외연수사항
		idw_update[li_SelectedTab].Object.from_date      [ll_InsRow] = ls_SysDate		//시작일자
		idw_update[li_SelectedTab].Object.country_opt    [ll_InsRow] = '1'				//국내외구분
		ls_ColName = 'from_date'
END CHOOSE
idw_update[li_SelectedTab].SetItemStatus(ll_InsRow,0,Primary!,NotModified!)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우로 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 추가되었습니다.')
//wf_SetMenuBtn('IDSR')
idw_update[li_SelectedTab].SetColumn(ls_ColName)
idw_update[li_SelectedTab].SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
Integer	li_idx
Integer	li_ChgDw[]	//변경된사항만 저장
Integer	li_Arr

FOR li_idx = 1 TO UpperBound(idw_update)
	IF idw_update[li_idx].AcceptText() = -1 THEN
		idw_update[li_idx].SetFocus()
		RETURN -1
	END IF
	IF idw_update[li_idx].ModifiedCount() + &
		idw_update[li_idx].DeletedCount() > 0 THEN 
		li_Arr++
		li_ChgDw[li_Arr] = li_idx
	END IF
NEXT
IF li_Arr = 0 THEN
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다...')
String	ls_NotNullCol[]
String	ls_Null[]
FOR li_Arr = 1 TO UpperBound(li_ChgDw)
	li_idx = li_ChgDw[li_Arr]
	ls_NotNullCol = ls_Null
	CHOOSE CASE li_idx
		CASE 1	//인사기본정보
			IF cbx_seq.Checked THEN
				ls_NotNullCol[01] = 'name/성명'
				ls_NotNullCol[02] = 'jumin_no/주민번호'
				ls_NotNullCol[03] = 'sex_code/성별'
				ls_NotNullCol[04] = 'gwa/소속코드'
				ls_NotNullCol[05] = 'duty_code/직급코드'
				ls_NotNullCol[06] = 'jaejik_opt/재직구분'
				ls_NotNullCol[07] = 'sosok_date/소속일'
				ls_NotNullCol[08] = 'firsthire_date/대학임용일'
				ls_NotNullCol[09] = 'hakwonhire_date/학원임용일'
			ELSE
				ls_NotNullCol[01] = 'member_no/개인번호'
				ls_NotNullCol[02] = 'name/성명'
				ls_NotNullCol[03] = 'jumin_no/주민번호'
				ls_NotNullCol[04] = 'sex_code/성별'
				ls_NotNullCol[05] = 'gwa/소속코드'
				ls_NotNullCol[06] = 'duty_code/직급코드'
				ls_NotNullCol[07] = 'jaejik_opt/재직구분'
				ls_NotNullCol[08] = 'sosok_date/소속일'
				ls_NotNullCol[09] = 'firsthire_date/대학임용일'
				ls_NotNullCol[10] = 'hakwonhire_date/학원임용일'
			END IF
		CASE 2	//신상상세정보
		CASE 3	//가족사항
			ls_NotNullCol[1] = 'jumin_no/주민번호'
			ls_NotNullCol[2] = 'relation/관계'
			ls_NotNullCol[3] = 'kname/성명'
		CASE 4	//학력사항
			ls_NotNullCol[1] = 'from_date/시작일자'
		CASE 5	//경력사항
			ls_NotNullCol[1] = 'career_opt/경력구분'
		CASE 6	//자격사항
			ls_NotNullCol[1] = 'certify_no/자격번호'
		CASE 7	//포상.징계사항
			ls_NotNullCol[1] = 'prize_code/상벌코드'
		CASE 8	//해외연수사항
			ls_NotNullCol[1] = 'from_date/시작일자'
	END CHOOSE
	IF f_chk_null(idw_update[li_idx],ls_NotNullCol) = -1 THEN
		tab_1.SelectedTab = li_idx
		RETURN -1
	END IF
NEXT

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('저장하시전에 체크사항을 처리 중입니다...')
DwItemStatus ldis_Status
Long		ll_Row				//변경된행
Long		ll_RowCnt
DateTime	ldt_WorkDate		//등록일자
String	ls_Worker			//등록자
String	ls_IpAddr			//등록단말기
Boolean	lb_Start
String	ls_Find
Long		ll_Find

Integer	li_MemberSeq		//개인번호중 일련번호(3자리)
Integer	li_Seq				//순번
String	ls_MemberNo			//개인번호
String	ls_DutyCode			//직급코드
Integer	li_NationCode		//국적코드
Integer	li_JikWiCode		//직위코드
String	ls_SosokDate		//소속일자
String	ls_HakWonHireDate	//학원임용일

String	ls_KName				//성명
Integer	li_BankCd			//은행코드
String	ls_AcctNo			//계좌번호
Integer	li_Loop
dwObject	ldwo_Object	

ls_MemberNo = idw_update[1].Object.member_no[1]	//개인번호
FOR li_Arr = 1 TO UpperBound(li_ChgDw)
	li_Seq    = 0
	lb_Start  = TRUE
	li_idx    = li_ChgDw[li_Arr]
	ll_Row    = idw_update[li_idx].GetNextModified(0,primary!)
	IF ll_Row > 0 THEN
		ldt_WorkDate = f_sysdate()						//등록일자
		ls_Worker    = gstru_uid_uname.uid			//등록자
		ls_IpAddr    = gstru_uid_uname.address		//등록단말기
	END IF
	DO WHILE ll_Row > 0
		ldis_Status = idw_update[li_idx].GetItemStatus(ll_Row,0,Primary!)
		/////////////////////////////////////////////////////////////////////////////////
		// 3.1 항목체크
		/////////////////////////////////////////////////////////////////////////////////
		CHOOSE CASE li_idx
			CASE 1	//인사상세정보
				IF ldis_Status = New! OR ldis_Status = NewModified! AND cbx_seq.Checked THEN
					CHOOSE CASE UPPER(SQLCA.ServerName)
						CASE 'SEWC'
							//////////////////////////////////////////////////////////////////
							// 3.1.1 개인번호 처리
							//			개인번호 = 학원임용년월(4) + 일련번호(3)
							//////////////////////////////////////////////////////////////////
							wf_SetMsg('개인번호중 일련번호 생성 중 입니다...')
							ls_HakWonHireDate = idw_update[li_idx].Object.hakwonhire_date[ll_Row]	//학원임용년월
							ls_MemberNo  = MID(ls_HakWonHireDate,3,4)											//개인번호
							IF lb_Start THEN
								lb_Start = FALSE
								SELECT	NVL(MAX(SUBSTR(A.MEMBER_NO,5,3)),0) + 1
								INTO		:li_MemberSeq
								FROM		INDB.HIN001M A
								WHERE		A.MEMBER_NO LIKE :ls_MemberNo||'%';
								CHOOSE CASE SQLCA.SQLCODE
									CASE 0
									CASE 100
										li_MemberSeq = 1
									CASE ELSE
										wf_SetMsg('개인번호 중 오류가 발생하였습니다.')
										MessageBox('오류',&
														'개인번호 중 일련번호 생성시 전산장애가 발생되었습니다.~r~n' + &
														'하단의 장애번호와 장애내역을~r~n' + &
														'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
														'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
														'장애내역 : ' + SQLCA.SqlErrText)
										ROLLBACK USING SQLCA;
										RETURN -1
								END CHOOSE
							ELSE
								li_MemberSeq++
							END IF
							ls_MemberNo = ls_MemberNo + String(li_MemberSeq,'000')
							idw_update[li_idx].Object.member_no[ll_Row] = ls_MemberNo
						CASE 'ORA9'
							//////////////////////////////////////////////////////////////////
							// 3.1.1 개인번호 처리
							//			개인번호 = 소속일자(4) + 구분코드(1) + 일련번호(4)
							//											P-전임교원이상 = 1
							//											A-조교         = 2
							//											E-직원         > 3
							//											M-학장
							//											T-시간강사,겸임,초빙임 = 3
							//											O-임시,외국인
							//////////////////////////////////////////////////////////////////
							ls_SosokDate  = idw_update[li_idx].Object.sosok_date [ll_Row]	//소속일자
							ls_DutyCode   = idw_update[li_idx].Object.duty_code  [ll_Row]	//직급코드
							// 개인번호 처리 
							CHOOSE CASE MID(ls_DutyCode,1,1)
								CASE '1'
									IF MID(ls_DutyCode,2,1) = '0' THEN
										ls_MemberNo = MID(ls_SosokDate,1,4) + 'P'
									ELSE
										ls_MemberNo = MID(ls_SosokDate,1,4) + 'T'
									END IF
								CASE '2' ; ls_MemberNo = MID(ls_SosokDate,1,4) + 'A'
								CASE '3' ; ls_MemberNo = MID(ls_SosokDate,1,4) + 'T'
								CASE ELSE; ls_MemberNo = MID(ls_SosokDate,1,4) + 'E'
							END CHOOSE
							li_NationCode = idw_update[li_idx].Object.nation_code[ll_Row]	//국적코드
							li_JikWiCode  = idw_update[li_idx].Object.jikwi_code [ll_Row]	//직위코드
							IF NOT(li_NationCode = 118 OR li_NationCode = 1) THEN &
																	 ls_MemberNo = MID(ls_SosokDate,1,4) + 'O'
							IF li_JikWiCode  = 10 THEN ls_MemberNo = MID(ls_SosokDate,1,4) + 'M'
								
							wf_SetMsg('개인번호중 일련번호 생성 중 입니다...')
							IF lb_Start THEN
								lb_Start = FALSE
								SELECT	NVL(MAX(SUBSTR(A.MEMBER_NO,6,4)),0) + 1
								INTO		:li_MemberSeq
								FROM		INDB.HIN001M A
								WHERE		A.MEMBER_NO LIKE :ls_MemberNo||'%';
								CHOOSE CASE SQLCA.SQLCODE
									CASE 0
									CASE 100
										li_MemberSeq = 1
									CASE ELSE
										wf_SetMsg('개인번호 중 오류가 발생하였습니다.')
										MessageBox('오류',&
														'개인번호 중 일련번호 생성시 전산장애가 발생되었습니다.~r~n' + &
														'하단의 장애번호와 장애내역을~r~n' + &
														'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
														'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
														'장애내역 : ' + SQLCA.SqlErrText)
										ROLLBACK USING SQLCA;
										RETURN -1
								END CHOOSE
							ELSE
								li_MemberSeq++
							END IF
							idw_update[li_idx].Object.member_no[ll_Row] = &
											  ls_MemberNo + String(li_MemberSeq,'0000')
							ls_MemberNo = ls_MemberNo + String(li_MemberSeq,'0000')
						CASE 'KDUC','KPU9'
							//////////////////////////////////////////////////////////////////
							// 3.1.1 개인번호 처리
							//			개인번호 = 학원임용년월(6) + 일련번호(2)
							//////////////////////////////////////////////////////////////////
							wf_SetMsg('개인번호중 일련번호 생성 중 입니다...')
							ls_HakWonHireDate = idw_update[li_idx].Object.hakwonhire_date[ll_Row]	//학원임용년월
							ls_MemberNo  = MID(ls_HakWonHireDate,1,6)											//개인번호
							IF lb_Start THEN
								lb_Start = FALSE
								SELECT	NVL(MAX(SUBSTR(A.MEMBER_NO,7,2)),0) + 1
								INTO		:li_MemberSeq
								FROM		INDB.HIN001M A
								WHERE		A.MEMBER_NO LIKE :ls_MemberNo||'%';
								CHOOSE CASE SQLCA.SQLCODE
									CASE 0
									CASE 100
										li_MemberSeq = 1
									CASE ELSE
										wf_SetMsg('개인번호 중 오류가 발생하였습니다.')
										MessageBox('오류',&
														'개인번호 중 일련번호 생성시 전산장애가 발생되었습니다.~r~n' + &
														'하단의 장애번호와 장애내역을~r~n' + &
														'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
														'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
														'장애내역 : ' + SQLCA.SqlErrText)
										ROLLBACK USING SQLCA;
										RETURN -1
								END CHOOSE
							ELSE
								li_MemberSeq++
							END IF
							ls_MemberNo = ls_MemberNo + String(li_MemberSeq,'00')
							idw_update[li_idx].Object.member_no[ll_Row] = ls_MemberNo
					END CHOOSE
				END IF
			CASE 2	//신상상세정보
				idw_update[li_idx].Object.member_no[ll_Row] = ls_MemberNo		//개인번호
				///////////////////////////////////////////////////////////////////////////
				// 3.1.2 신상정보의 은행코드입력시 급여이체은행에 인서트해준다.
				///////////////////////////////////////////////////////////////////////////
				IF ldis_Status = New! OR ldis_Status = NewModified! THEN
					ls_KName  = idw_update[1].Object.name[ll_Row]						//성명
					FOR li_Loop = 1 TO 2
						IF li_Loop = 1 THEN
							li_BankCd = idw_update[li_idx].Object.bank_cd1[ll_Row]			//은행코드
							ls_AcctNo = TRIM(idw_update[li_idx].Object.acct_no1[ll_Row])	//계좌번호
						ELSE
							li_BankCd = idw_update[li_idx].Object.bank_cd2[ll_Row]			//은행코드
							ls_AcctNo = TRIM(idw_update[li_idx].Object.acct_no2[ll_Row])	//계좌번호
						END IF
						IF NOT( isNull(li_BankCd) OR &
								  isNull(ls_AcctNo) OR LEN(ls_AcctNo) = 0 ) THEN
							INSERT	INTO	PADB.HPA020M
							VALUES	(	:ls_MemberNo,
											:ls_AcctNo,
											:li_BankCd,
											:ls_KName,
											0,'9',
											:ls_Worker,
											:ls_IpAddr,
											:ldt_WorkDate,
											:ls_Worker,
											:ls_IpAddr,
											:ldt_WorkDate	);
						END IF
					NEXT
				END IF
				
			CASE 3	//가족사항
				idw_update[li_idx].Object.member_no[ll_Row] = ls_MemberNo		//개인번호
			CASE 4	//학력사항
				idw_update[li_idx].Object.member_no[ll_Row] = ls_MemberNo		//개인번호
			CASE 5	//경력사항
				idw_update[li_idx].Object.member_no[ll_Row] = ls_MemberNo		//개인번호
				///////////////////////////////////////////////////////////////////////////
				// 3.1.5 경력사항 순번처리
				///////////////////////////////////////////////////////////////////////////
				IF ldis_Status = New! OR ldis_Status = NewModified! THEN
					wf_SetMsg('경력사항 순번 생성 중 입니다...')
					IF lb_Start THEN
						lb_Start = FALSE
						SELECT	NVL(MAX(A.CAREER_SEQ),0) + 1
						INTO		:li_Seq
						FROM		INDB.HIN009H A
						WHERE		A.MEMBER_NO = :ls_MemberNo;
						CHOOSE CASE SQLCA.SQLCODE
							CASE 0
							CASE 100
								li_Seq = 1
							CASE ELSE
								wf_SetMsg('경력사항 순번 생성 중 오류가 발생하였습니다.')
								MessageBox('오류',&
												'경력사항 순번 생성시 전산장애가 발생되었습니다.~r~n' + &
												'하단의 장애번호와 장애내역을~r~n' + &
												'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
												'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
												'장애내역 : ' + SQLCA.SqlErrText)
								ROLLBACK USING SQLCA;
								RETURN -1
						END CHOOSE
					ELSE
						li_Seq++
					END IF
					idw_update[li_idx].Object.career_seq[ll_Row] = li_Seq
				END IF
			CASE 6	//자격사항
				idw_update[li_idx].Object.member_no [ll_Row] = ls_MemberNo		//개인번호
			CASE 7	//포상.징계사항
				idw_update[li_idx].Object.member_no [ll_Row] = ls_MemberNo		//개인번호
			CASE 8	//해외연수사항
				idw_update[li_idx].Object.member_no [ll_Row] = ls_MemberNo		//개인번호
		END CHOOSE
		/////////////////////////////////////////////////////////////////////////////////
		// 3.2 수정항목 처리
		/////////////////////////////////////////////////////////////////////////////////
		idw_update[li_idx].Object.worker   [ll_Row] = ls_Worker		//등록자
		idw_update[li_idx].Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
		idw_update[li_idx].Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
		idw_update[li_idx].Object.job_uid  [ll_Row] = ls_Worker		//등록자
		idw_update[li_idx].Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
		idw_update[li_idx].Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
		
		ll_Row = idw_update[li_idx].GetNextModified(ll_Row,primary!)
	LOOP
NEXT
////////////////////////////////////////////////////////////////////////////////////
// 3.3 개인신상정보 삭제시 이미지 삭제처리
////////////////////////////////////////////////////////////////////////////////////
Integer	li_Rtn
IF idw_update[1].DeletedCount() > 0 THEN
	ls_MemberNo = idw_update[1].Object.member_no.delete[1]			//개인번호
	
	DELETE	FROM	INDB.HIN026M
	WHERE		MEMBER_NO = :ls_MemberNo;
	IF SQLCA.SQLCODE <> 0 THEN li_Rtn = -1
END IF
////////////////////////////////////////////////////////////////////////////////////
// 3.4 학력사항 변경시 인사기본에 최종학력사항으로 변경처리
////////////////////////////////////////////////////////////////////////////////////
String	ls_FrDate			//시작일자
String	ls_ToDate			//종료일자
//학력
String	ls_SchoolName		//학교명
String	ls_LastMajor		//전공명
String	ls_HakwiNm			//학위명
Integer	li_LastSchoolCode	//최종학력코드
Integer	li_SalGraduate		//졸업구분
ll_RowCnt = idw_update[4].RowCount()
IF ll_RowCnt > 0 THEN
	ls_MemberNo = idw_update[1].Object.member_no[1]
	ls_FrDate   = idw_update[4].Describe("Evaluate('max(from_date)',1)")
	ls_Find = "member_no = '"+ls_MemberNo+"' AND from_date = '"+ls_FrDate+"'"
	ll_Find = idw_update[4].Find(ls_Find,1,idw_update[4].RowCount())
	IF ll_Find > 0 THEN
		ls_SchoolName     = idw_update[4].Object.school_name     [ll_Find]	//학교명
		ls_LastMajor      = idw_update[4].Object.last_major      [ll_Find]	//전공명
		ls_HakwiNm        = idw_update[4].Object.hakwi_nm        [ll_Find]	//학위명
		li_LastSchoolCode = idw_update[4].Object.last_school_code[ll_Find]	//최종학력코드
		li_SalGraduate    = idw_update[4].Object.sal_graduate    [ll_Find]	//졸업구분
		
		idw_update[1].Object.last_school     [1] = ls_SchoolName					//학교명
		idw_update[1].Object.last_major      [1] = ls_LastMajor					//전공명
		idw_update[1].Object.last_hakwi      [1] = ls_HakwiNm						//학위명
		idw_update[1].Object.last_school_code[1] = li_LastSchoolCode			//최종학력코드
		idw_update[1].Object.sal_graduate    [1] = li_SalGraduate				//졸업구분
		
		li_Arr = UpperBound(li_ChgDw) + 1
		li_ChgDw[li_Arr] = 1
	END IF
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
FOR li_Arr = 1 TO UpperBound(li_ChgDw)
	li_idx = li_ChgDw[li_Arr]
	ls_Msg = is_SubTitle[li_idx]
	wf_SetMsg(ls_Msg + ' 변경된 자료를 저장 중 입니다...')
	li_Rtn = idw_update[li_idx].UPDATE()
	IF li_Rtn <> 1 THEN EXIT
NEXT

IF li_Rtn = 1 THEN
	COMMIT USING SQLCA;
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;
	RETURN -1
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('IDSR')
Integer	li_SelectedTab
li_SelectedTab = tab_1.SelectedTab
idw_update[li_SelectedTab].SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 현재선택된 데이타원도우의 체크.
///////////////////////////////////////////////////////////////////////////////////////
Integer	li_SelectedTab
li_SelectedTab = tab_1.SelectedTab
IF li_SelectedTab = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
IF li_SelectedTab > 2 THEN
	IF li_SelectedTab = 9 OR li_SelectedTab = 10 OR li_SelectedTab = 11 THEN
		wf_SetMsg('이력자료는 조회만 가능합니다.')
		MessageBox('확인','이력자료는 조회만 가능합니다.')
		RETURN
	END IF
	
	ll_GetRow = idw_update[li_SelectedTab].getrow()

	IF ll_GetRow = 0 THEN
		wf_SetMsg('삭제할 자료가 없습니다.')
		RETURN
	END IF
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn

String	ls_MemberNo		//개인번호
String	ls_KName			//성명
String	ls_JuminNo		//주민번호
String	ls_FromDate		//시작일자
String	ls_CertifyNo	//자격번호
String	ls_PrizeCode	//상벌코드
String	ls_AppointCode	//보직코드
Integer	li_SeqNo			//순번

ls_MemberNo = TRIM(idw_update[1].Object.member_no[1])	//개인번호
ls_KName    = TRIM(idw_update[1].Object.name     [1])	//성명
IF LEN(ls_MemberNo) = 0 OR isNull(ls_MemberNo) THEN RETURN
IF LEN(ls_KName) = 0 OR isNull(ls_KName) THEN ls_KName = ''

ls_Msg = is_SubTitle[li_SelectedTab]+' 자료를 삭제하시겠습니까?'

CHOOSE CASE li_SelectedTab
	CASE 1
		ls_Msg += '~r~n~r~n'+&
					 '개인번호 : '+ls_MemberNo+'~r~n'+&
					 '성      명 : '+ls_KName+'~r~n~r~n'+&
					 '인사기본정보 삭제시 관련된 모든자료가 삭제됩니다.~r~n'+&
					 '삭제후 저장하시기 바랍니다.'
	CASE 2			
		ls_Msg += '~r~n~r~n'+&
					 '개인번호 : '+ls_MemberNo+'~r~n'+&
					 '성      명 : '+ls_KName
	CASE ELSE
		IF idw_update[li_SelectedTab].getrow() = 0 THEN
			//////////////////////////////////////////////////////////////////////////////
			// 2.1 삭제전 체크사항 기술
			//////////////////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////////////////
			// 2.2 삭제메세지 처리부분
			//////////////////////////////////////////////////////////////////////////////
			ls_Msg += '~r~n~r~n'+&
						 '개인번호 : '+ls_MemberNo+'~r~n'+&
						 '성      명 : '+ls_KName+'~r~n'
			CHOOSE CASE li_SelectedTab
				CASE 3
					////////////////////////////////////////////////////////////////////////
					// 2.2.2 가족사항
					////////////////////////////////////////////////////////////////////////
					ls_JuminNo = idw_update[li_SelectedTab].Object.jumin_no[ll_GetRow]
					ls_Msg += '주민번호 : ' + String(ls_JuminNo,'@@@@@@-@@@@@@@')
				CASE 4
					////////////////////////////////////////////////////////////////////////
					// 2.2.3 학력사항
					////////////////////////////////////////////////////////////////////////
					ls_FromDate = idw_update[li_SelectedTab].Object.from_date[ll_GetRow]
					ls_Msg += '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')
				CASE 5
					////////////////////////////////////////////////////////////////////////
					// 2.2.4 경력사항
					////////////////////////////////////////////////////////////////////////
					li_SeqNo = idw_update[li_SelectedTab].Object.career_seq[ll_GetRow]
					ls_Msg += '순      번 : ' + String(li_SeqNo)
				CASE 6
					////////////////////////////////////////////////////////////////////////
					// 2.2.5 자격사항
					////////////////////////////////////////////////////////////////////////
					ls_CertifyNo = idw_update[li_SelectedTab].Object.certify_no[ll_GetRow]
					ls_Msg += '자격번호 : ' + ls_CertifyNo
				CASE 7
					////////////////////////////////////////////////////////////////////////
					// 2.2.6 포상.징계사항
					////////////////////////////////////////////////////////////////////////
					ls_PrizeCode = idw_update[li_SelectedTab].&
						Describe("Evaluate('LookUpDisplay(prize_code)',"+String(ll_GetRow)+")")
					ls_FromDate  = idw_update[li_SelectedTab].Object.from_date[ll_GetRow]
					ls_Msg += '상벌구분 : ' + ls_PrizeCode+'~r~n'+&
								 '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')
				CASE 8
					////////////////////////////////////////////////////////////////////////
					// 2.2.7 해외연수사항
					////////////////////////////////////////////////////////////////////////
					ls_FromDate = idw_update[li_SelectedTab].Object.from_date[ll_GetRow]
					ls_Msg += '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')
			END CHOOSE
		ELSE
			ls_Msg = is_SubTitle[li_SelectedTab]+' 자료를 삭제하시겠습니까?'
		END IF
END CHOOSE

li_Rtn = MessageBox('확인',ls_Msg,Question!,YesNo!,2)
IF li_Rtn = 2 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
Long	ll_idx
CHOOSE CASE li_SelectedTab
	CASE 1
		/////////////////////////////////////////////////////////////////////////////////
		// 3.1 인사기본정보 삭제처리
		/////////////////////////////////////////////////////////////////////////////////
		// 3.1.1 신상상세정보 및 세부항목 삭제처리
		//////////////////////////////////////////////////////////////////////////////
		wf_SetMsg(is_SubTitle[02]+' 자료를 삭제처리 중입니다.')
		idw_update[02].SetReDraw(FALSE)
		idw_update[02].DeleteRow(1)
		idw_update[02].InsertRow(0)
		idw_update[02].Object.DataWindow.ReadOnly = 'YES'
		idw_update[02].SetReDraw(TRUE)
		
		Integer	li_Arr
		Long		ll_RowCnt
		FOR li_Arr = 8 TO 3 STEP -1
			wf_SetMsg(is_SubTitle[li_Arr]+' 자료를 삭제처리 중입니다.')
			
			idw_update[li_Arr].SetReDraw(FALSE)
			ll_RowCnt = idw_update[li_Arr].RowCount()
			FOR ll_idx = ll_RowCnt TO 1 STEP -1
				idw_update[li_Arr].DeleteRow(ll_idx)
			NEXT
			idw_update[li_Arr].SetReDraw(TRUE)
		NEXT
		//////////////////////////////////////////////////////////////////////////////
		// 3.1.2 인사이미지 및 인사기본정보 삭제처리
		//////////////////////////////////////////////////////////////////////////////
		Blob	lbo_Image
		SetNull(lbo_Image)
		tab_1.tabpage_1.p_image.picturename = "../bmp/blank.bmp"
		tab_1.tabpage_1.p_image.SetPicture(lbo_Image)
		
		idw_update[01].SetReDraw(FALSE)
		idw_update[01].DeleteRow(1)
		idw_update[01].InsertRow(0)
		idw_update[01].Object.DataWindow.ReadOnly = 'YES'
		idw_update[01].SetReDraw(TRUE)
		wf_SetMsg(is_SubTitle[01]+' 자료를 삭제하였습니다. 저장하시기 바랍니다.')
//		wf_SetMenuBtn('ISR')
	CASE 2
		/////////////////////////////////////////////////////////////////////////////////
		// 3.2 신상상제정보 삭제처리
		/////////////////////////////////////////////////////////////////////////////////
		idw_update[02].SetReDraw(FALSE)
		idw_update[02].DeleteRow(1)
		idw_update[02].InsertRow(0)
		idw_update[02].Object.DataWindow.ReadOnly = 'YES'
		idw_update[02].SetReDraw(TRUE)
		wf_SetMsg(is_SubTitle[02]+' 자료를 삭제하였습니다.')
//		wf_SetMenuBtn('ISR')
	CASE ELSE
		/////////////////////////////////////////////////////////////////////////////////
		// 3.3 각세부사항 삭제처리
		//			선택된 행 만 찾아 삭제처리한다.
		/////////////////////////////////////////////////////////////////////////////////
		Long	ll_SelectRow
		Long	ll_DeleteCnt
		Long	ll_DeleteRow[]
		ll_SelectRow = idw_update[li_SelectedTab].getrow()
		IF ll_SelectRow = 0 THEN RETURN 
		DO WHILE ll_SelectRow > 0 
			ll_DeleteCnt++
			ll_DeleteRow[ll_DeleteCnt] = ll_SelectRow
			
			ll_SelectRow = idw_update[li_SelectedTab].getrow()
		LOOP
		
		idw_update[li_SelectedTab].SetRedraw(FALSE)
		FOR ll_idx = ll_DeleteCnt TO 1 STEP -1
			IF idw_update[li_SelectedTab].DeleteRow(ll_DeleteRow[ll_idx]) = 1 THEN
			END IF
		NEXT
		idw_update[li_SelectedTab].SetRedraw(TRUE)
END CHOOSE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
//wf_SetMenuBtn('IR')
uo_member.sle_kname.SetFocus()

tab_1.SelectTab(3)

dw_list1.Reset()

idw_update[01].SetReDraw(FALSE)
idw_update[01].Reset()
idw_update[01].InsertRow(0)
idw_update[01].Object.DataWindow.ReadOnly = 'YES'
idw_update[01].SetReDraw(TRUE)

idw_update[02].SetReDraw(FALSE)
idw_update[02].Reset()
idw_update[02].InsertRow(0)
idw_update[02].Object.DataWindow.ReadOnly = 'YES'
idw_update[02].SetReDraw(TRUE)

Integer	li_idx
FOR li_idx = 3 TO UpperBound(idw_update)
	idw_update[li_idx].Reset()
NEXT
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

type ln_templeft from w_msheet`ln_templeft within w_hin210i
end type

type ln_tempright from w_msheet`ln_tempright within w_hin210i
end type

type ln_temptop from w_msheet`ln_temptop within w_hin210i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin210i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin210i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin210i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin210i
end type

type uc_insert from w_msheet`uc_insert within w_hin210i
end type

type uc_delete from w_msheet`uc_delete within w_hin210i
end type

type uc_save from w_msheet`uc_save within w_hin210i
end type

type uc_excel from w_msheet`uc_excel within w_hin210i
end type

type uc_print from w_msheet`uc_print within w_hin210i
end type

type st_line1 from w_msheet`st_line1 within w_hin210i
end type

type st_line2 from w_msheet`st_line2 within w_hin210i
end type

type st_line3 from w_msheet`st_line3 within w_hin210i
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin210i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin210i
end type

type ddlb_gubn from dropdownlistbox within w_hin210i
integer x = 1710
integer y = 104
integer width = 379
integer height = 324
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
string item[] = {"1. 교원","2. 직원","3. 전체"}
borderstyle borderstyle = stylelowered!
end type

event constructor;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: constructor
//	기 능 설 명: 활성화되는 시점에 로그인한 사람의 권한그룹을 체크하여
//						교직원구분을 셋팅한다.
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UserID		//로그인사번
Integer	li_JikJongCode	//교직원구분코드
ls_UserID = TRIM(gstru_uid_uname.uid)			//로그인사번
IF LEN(ls_UserID) = 0 THEN
	li_JikJongCode = 1
	RETURN
END IF

String 	ls_GroupID		//권한그굽코드
Boolean	lb_GroupChk = FALSE
SELECT	A.GROUP_ID
INTO		:ls_GroupID
FROM		CDDB.KCH403M A
WHERE		A.MEMBER_NO = :ls_UserID
AND		A.GROUP_ID  IN ('Hin00','Hin01','Hin02','Admin','Mnger','PGMer2')
AND		ROWNUM       = 1;

CHOOSE CASE TRIM(ls_GroupID)
	CASE 'Hin01'
		li_JikJongCode = 2	//사무처
	CASE 'Hin02'
		li_JikJongCode = 1	//교무처
	CASE ELSE
		li_JikJongCode = 3	//관리자
		lb_GroupChk    = TRUE
END CHOOSE

//급여에서 가족사항을 입력하기로 하여. 전체권한을 부여함.
li_JikJongCode = 3	//관리자
lb_GroupChk    = TRUE


THIS.SelectItem(li_JikJongCode)
THIS.Enabled = lb_GroupChk

uo_member.is_JikJongCode = String(li_JikJongCode)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event selectionchanged;uo_member.is_JikJongCode = String(index)

end event

type st_99 from statictext within w_hin210i
integer x = 1371
integer y = 120
integer width = 334
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "교직원구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_jaejik_opt from datawindow within w_hin210i
integer x = 439
integer y = 184
integer width = 695
integer height = 80
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

type st_21 from statictext within w_hin210i
integer x = 165
integer y = 204
integer width = 270
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "재직구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_dept_code from datawindow within w_hin210i
integer x = 439
integer y = 104
integer width = 896
integer height = 80
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_dept_code"
boolean border = false
boolean livescroll = true
end type

type st_19 from statictext within w_hin210i
integer x = 229
integer y = 120
integer width = 210
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "부서명"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_duty_code from datawindow within w_hin210i
integer x = 2341
integer y = 104
integer width = 695
integer height = 80
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_duty_code"
boolean border = false
boolean livescroll = true
end type

type st_20 from statictext within w_hin210i
integer x = 2130
integer y = 120
integer width = 206
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "직급명"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_seq from checkbox within w_hin210i
integer x = 2743
integer y = 200
integer width = 891
integer height = 72
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 67108864
string text = "개인번호 자동 생성시 선택"
boolean checked = true
end type

type tab_1 from tab within w_hin210i
integer x = 18
integer y = 1020
integer width = 3840
integer height = 1584
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 80269524
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_11 tabpage_11
tabpage_9 tabpage_9
tabpage_10 tabpage_10
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_11=create tabpage_11
this.tabpage_9=create tabpage_9
this.tabpage_10=create tabpage_10
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_11,&
this.tabpage_9,&
this.tabpage_10}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_11)
destroy(this.tabpage_9)
destroy(this.tabpage_10)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "인사기본정보"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
p_image p_image
dw_update1 dw_update1
end type

on tabpage_1.create
this.p_image=create p_image
this.dw_update1=create dw_update1
this.Control[]={this.p_image,&
this.dw_update1}
end on

on tabpage_1.destroy
destroy(this.p_image)
destroy(this.dw_update1)
end on

type p_image from picture within tabpage_1
integer x = 18
integer y = 20
integer width = 613
integer height = 644
boolean focusrectangle = false
end type

type dw_update1 from cuo_dwwindow_one_hin within tabpage_1
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 30
string dataobject = "d_hin202i_02"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event buttonclicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: buttonclikced::dw_update1
//	기 능 설 명: 인사정보 이미지처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
IF row = 0 THEN RETURN
IF UPPER(THIS.Object.DataWindow.ReadOnly) = 'YES' THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
ls_ColName = STRING(dwo.name)

CHOOSE CASE ls_ColName
	CASE 'btn_image'
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.1 인사기본사항 저장여부 확인
		/////////////////////////////////////////////////////////////////////////////////
		DwItemStatus ldis_Status
		ldis_Status = dw_update1.GetItemStatus(row,0,Primary!)
		IF ldis_Status = New! OR ldis_Status = NewModified! THEN
			MessageBox('확인','인사기본정보를 저장 후 이미지를 등록하시기 바랍니다.')
			RETURN
		END IF
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.2 화일열기 화면 오픈
		/////////////////////////////////////////////////////////////////////////////////
		Integer	li_Rtn
		String	ls_FullName
		String	ls_FileName
		li_Rtn = GetFileOpenName("", + ls_FullName,&
									ls_FileName, "BMP",&
									"BMP Files (*.BMP),*.BMP," + &
									"ALL Files (*.*), *.*")
		IF li_Rtn <> 1 THEN RETURN
		IF LEN(ls_FullName) = 0 THEN RETURN
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.3 저장하고자하는 이미지화일을 BLOB에 읽어온다.
		/////////////////////////////////////////////////////////////////////////////////
		Blob	lbo_Image	//인사이미지
		lbo_Image = f_blob_read(ls_FullName)
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.4 이미지 정보 추가 및 수정처리
		/////////////////////////////////////////////////////////////////////////////////
		wf_SetMsg('이미지 정보를 저장 중입니다.')
		String	ls_MemberNo	//개인번호
		ls_MemberNo = dw_update1.Object.member_no[row]
		
		SELECT	1
		INTO		:li_Rtn
		FROM		INDB.HIN026M A
		WHERE		A.MEMBER_NO = :ls_MemberNo;
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0
			CASE 100
				INSERT	INTO	INDB.HIN026M
				VALUES	(	:ls_MemberNo,
								''	);
			CASE ELSE
				MessageBox('오류',&
								'인사기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
				RETURN
		END CHOOSE
			
		UPDATEBLOB	INDB.HIN026M
		SET			MEMBER_IMG = :lbo_Image
		WHERE			MEMBER_NO  = :ls_MemberNo;
		IF SQLCA.SQLCODE = 0 THEN
			COMMIT;
			p_image.picturename = ls_FullName
			wf_SetMsg('이미지 정보가 저장되었습니다.')
		ELSE
			MessageBox('오류',&
							'인사기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK;
		END IF
		
	CASE ELSE
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event constructor;call super::constructor;//ib_RowSelect = FALSE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update1
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
wf_SetMsg('')

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
String	ls_Null
Integer	li_Null

ls_ColName = STRING(dwo.name)
ls_ColData = TRIM(data)
SetNull(ls_Null)
SetNull(li_Null)

String	ls_Find
Long		ll_Find

CHOOSE CASE ls_ColName
	CASE 'jumin_no'
		/////////////////////////////////////////////////////////////////////////////////
		//	주민번호 체크
		/////////////////////////////////////////////////////////////////////////////////
		IF NOT f_chk_jumin(ls_ColData) THEN
			ls_Msg = '주민번호 입력오류입니다.'
			wf_SetMsg(ls_Msg)
			MessageBox('확인',ls_Msg)
			RETURN 0
		END IF
		Integer	li_SexCode
		CHOOSE CASE MID(ls_ColData,7,1)
			CASE '1','3'
				li_SexCode = 1
			CASE '2','4'
				li_SexCode = 2
		END CHOOSE
		THIS.Object.sex_code[row] = li_SexCode
		
	CASE 'duty_code'
		/////////////////////////////////////////////////////////////////////////////////
		//	연봉구분 처리
		//		정상급여 : 교원('1') - 직급에 두번째자리 = '0',
		//						조교('2'),시간강사('3'),일반직('4'),기능직('5')
		//		연봉직 : 교원(직급에 두번째자리가 '0'이 아님), 
		//										계약직('6'), 연봉직('8'), 기타직('9')
		/////////////////////////////////////////////////////////////////////////////////
		dwObject	ldwo_Object
		Integer	li_AnnOpt = 1
		CHOOSE CASE MID(ls_ColData,1,1)
			CASE '1','2','3','4','5'
				IF MID(ls_ColData,1,1) = '1' AND MID(ls_ColData,2,1) <> '0' THEN
					li_AnnOpt = 2
				END IF
			CASE ELSE
				li_AnnOpt = 2
		END CHOOSE
		THIS.Object.ann_opt[row] = li_AnnOpt
		ldwo_Object = THIS.Object.ann_opt
		THIS.POST EVENT itemchanged(row,ldwo_Object,String(li_AnnOpt))
		/////////////////////////////////////////////////////////////////////////////////
		//	직급코드변경시 정년퇴직예정일 처리
		//		교원(1)            : 65세
		//		일반직(4)          : 60세
		//		기능직5급이상(5)   : 60세
		//		기능직6급이하(506) : 57세
		//		교직원및 일반직원의 경우는 그정년이 달아는 날이 속하는 
		//				학기의 말에 당연퇴직한다(1학기:03/01 - 08/31, 2학기:09/01 - 02/28)
		/////////////////////////////////////////////////////////////////////////////////
		Long		ll_Schedule			//정년퇴직연령
		CHOOSE CASE MID(ls_ColData,1,1)
			CASE '1' ; ll_Schedule = 650000
			CASE '4' ; ll_Schedule = 600000
			CASE '5'
				IF ls_ColData < '506' THEN
					ll_Schedule = 600000
				ELSE
					ll_Schedule = 570000
				END IF
			CASE ELSE
				THIS.Object.schedule_date[row] = ls_Null
				RETURN
		END CHOOSE
		
		String	ls_JuminNo			//주민번호
		String	ls_ScheduleDate	//정년토직예정일
		Date		ld_ScheduleDate	//정년토직예정일
		ls_JuminNo = TRIM(MID(THIS.Object.jumin_no[row],1,7))
		IF isNull(ls_JuminNo) OR LEN(ls_JuminNo) = 0 OR ls_JuminNo = '0000000' THEN
			THIS.Object.schedule_date[row] = ls_Null
			RETURN
		END IF
		IF MID(ls_JuminNo,7,1) = '3' OR MID(ls_JuminNo,7,1) = '4' THEN
			ls_JuminNo = '20'+MID(ls_JuminNo,1,6)
		ELSE
			ls_JuminNo = '19'+MID(ls_JuminNo,1,6)
		END IF
		ls_ScheduleDate = String(Long(ls_JuminNo) + ll_Schedule,'00000000')
		IF NOT f_isDate(ls_ScheduleDate) THEN
			THIS.Object.schedule_date[row] = ls_Null
			RETURN
		END IF
		
		IF MID(ls_ColData,1,1) = '1' OR MID(ls_ColData,1,1) = '4' THEN
			IF MID(ls_ScheduleDate,5,4) >= '0301' AND MID(ls_ScheduleDate,5,4) <= '0831' THEN
				ls_ScheduleDate = MID(ls_ScheduleDate,1,4) + '0831'
			ELSE
				ls_ScheduleDate = String(Integer(MID(ls_ScheduleDate,1,4)) + 1,'0000') + '0301'
				ld_ScheduleDate = Date(String(ls_ScheduleDate,'@@@@/@@/@@'))
				ls_ScheduleDate = String(RelativeDate(ld_ScheduleDate,-1),'YYYYMMDD')
			END IF
		END IF
		THIS.Object.schedule_date[row] = ls_ScheduleDate
				
	CASE 'sal_class'
		/////////////////////////////////////////////////////////////////////////////////
		//	호봉코드 변경시 호봉액처리
		/////////////////////////////////////////////////////////////////////////////////
		Long		ll_GetRow
		Long		ll_SalAmt
		ll_GetRow = idwc_SalClass.GetRow()
		IF ll_GetRow = 0 THEN
			THIS.Object.sal_amt[row] = li_Null
			RETURN
		END IF
		ll_SalAmt = idwc_SalClass.GetItemNumber(ll_GetRow,'sal_amt')
		THIS.Object.sal_amt[row] = ll_SalAmt
		
	CASE 'ann_opt'
		/////////////////////////////////////////////////////////////////////////////////
		//	연봉구분이 연봉제(2)인경우는 호봉코드DDDW 초기화 처리
		/////////////////////////////////////////////////////////////////////////////////
		String	ls_SalYear
		String	ls_DutyCode
		
		ls_SalYear  = THIS.Object.sal_year [row]
		ls_DutyCode = THIS.Object.duty_code[row]
		IF MID(ls_DutyCode,1,1) = '1' THEN ls_DutyCode = '100'
		IF ls_ColData = '2' THEN ls_DutyCode = '801'
		
		idwc_SalClass.Reset()
		IF idwc_SalClass.Retrieve(ls_SalYear,ls_DutyCode) = 0 THEN
			wf_setmsg('호봉코드를 입력하시기 바랍니다.')
			idwc_SalClass.InsertRow(0)
		END IF
		
	CASE 'firsthire_date','hakwonhire_date','sosok_date',&
			'jikjong_date','duty_date','sal_date',&
			'bojik_date1','change_date',&
			'jaeimyong_start','jaeimyong_end',&
			'junim_date','jogyosu_date','bugyosu_date','gyosu_date',&
			'armyenter_date','armyreturn_date'
		/////////////////////////////////////////////////////////////////////////////////
		//	일자변경시 처리
		/////////////////////////////////////////////////////////////////////////////////
		IF isNull(ls_ColData) OR LEN(ls_ColData) = 0 THEN RETURN 0
		IF NOT f_isdate(ls_ColData) THEN RETURN 1
		
	CASE ELSE
		
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "신상상세정보"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update2 dw_update2
end type

on tabpage_2.create
this.dw_update2=create dw_update2
this.Control[]={this.dw_update2}
end on

on tabpage_2.destroy
destroy(this.dw_update2)
end on

type dw_update2 from cuo_dwwindow_one_hin within tabpage_2
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 11
string dataobject = "d_hin202i_11"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;//ib_RowSelect = FALSE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

event buttonclicked;call super::buttonclicked;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: buttonclikced::dw_update1
//	기 능 설 명: 우편번호 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
IF row = 0 THEN RETURN
IF UPPER(THIS.Object.DataWindow.ReadOnly) = 'YES' THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
ls_ColName = STRING(dwo.name)

CHOOSE CASE ls_ColName
	CASE 'btn_post_bonjuk','btn_post_home'
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1 주소입력여부 확인
		/////////////////////////////////////////////////////////////////////////////////
		String	ls_Addr
		THIS.AcceptText()
		
		IF ls_ColName = 'btn_post_bonjuk' THEN
			ls_Addr = TRIM(THIS.Object.bonjuk_addr1[row])
		ELSE
			ls_Addr = TRIM(THIS.Object.home_addr1  [row])
		END IF
		IF isNull(ls_Addr) OR LEN(ls_Addr) = 0 THEN
			Messagebox("알림",'주소를 입력후에 사용하시기 바랍니다.')
			RETURN
		END IF
		/////////////////////////////////////////////////////////////////////////////////
		// 2.2 주소도움말 오픈
		/////////////////////////////////////////////////////////////////////////////////
		
		vector lvc_data
	
		lvc_data = Create Vector
		
		lvc_data.SetProperty('parm_cnt', '1')
		  lvc_data.SetProperty('parm_str01', ls_addr)
		
		 If  OpenWithParm(w_post_pop, lvc_data) = 1 Then
			   lvc_data = Message.PowerObjectParm
			   If isvalid(lvc_data) Then
			  
				String	ls_Post
				ls_Post =  lvc_data.GetProperty("parm_str01")
				ls_Addr = lvc_data.GetProperty("parm_str03")
				
				IF ls_ColName = 'btn_post_bonjuk' THEN
					THIS.Object.bonjuk_postno[row] = ls_Post
					THIS.Object.bonjuk_addr1 [row] = ls_Addr
				ELSE
					THIS.Object.home_postno  [row] = ls_Post
					THIS.Object.home_addr1   [row] = ls_Addr
				END IF
			End If
		End If
		
		destroy lvc_data

	CASE ELSE
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "가족사항"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update3 dw_update3
end type

on tabpage_3.create
this.dw_update3=create dw_update3
this.Control[]={this.dw_update3}
end on

on tabpage_3.destroy
destroy(this.dw_update3)
end on

type dw_update3 from cuo_dwwindow_one_hin within tabpage_3
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 11
string dataobject = "d_hin202i_03"
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update1
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////

wf_SetMsg('')

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
String	ls_Null
Integer	li_Null

ls_ColName = STRING(dwo.name)
ls_ColData = TRIM(data)
SetNull(ls_Null)
SetNull(li_Null)

String	ls_Find
Long		ll_Find

CHOOSE CASE ls_ColName
	CASE 'handicap_opt'
		/////////////////////////////////////////////////////////////////////////////////
		//	장애구분 변경시처리
		//		장애가 있으면 수당여부 선택처리
		/////////////////////////////////////////////////////////////////////////////////
		IF ls_ColData = '0' THEN
			THIS.Object.sudang_yn[row] ='0'
		ELSE
			THIS.Object.sudang_yn[row] ='1'
		END IF
		
	CASE ELSE
		
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type tabpage_4 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "학력사항"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update4 dw_update4
end type

on tabpage_4.create
this.dw_update4=create dw_update4
this.Control[]={this.dw_update4}
end on

on tabpage_4.destroy
destroy(this.dw_update4)
end on

type dw_update4 from cuo_dwwindow_one_hin within tabpage_4
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 11
string dataobject = "d_hin202i_04"
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

type tabpage_5 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "경력사항"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update5 dw_update5
end type

on tabpage_5.create
this.dw_update5=create dw_update5
this.Control[]={this.dw_update5}
end on

on tabpage_5.destroy
destroy(this.dw_update5)
end on

type dw_update5 from cuo_dwwindow_one_hin within tabpage_5
event type long ue_postitemchanged ( long row,  dwobject dwo,  string data )
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 11
string dataobject = "d_hin202i_05"
end type

event type long ue_postitemchanged(long row, dwobject dwo, string data);////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: ue_postitemchanged::dw_update5
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
String	ls_Null
Integer	li_Null

ls_ColName = STRING(dwo.name)
ls_ColData = TRIM(data)
SetNull(ls_Null)
SetNull(li_Null)

String	ls_Find
Long		ll_Find

String		ls_FrDate			//경력시작일자
String		ls_ToDate			//경력종료일자
Integer		li_CareerOpt		//경력인정구분
Decimal{2}	ldc_WorkYear		//근무년수
Decimal{2}	ldc_DecisionYear	//인정년수
Decimal{1}	ldc_HwanRate		//환산율
Decimal{2}	ldc_HwanYear		//환산년수
Double		ldb_Year
Double		ldb_Months	
Integer		li_Year				//경력누계중 년수
Integer		li_Months			//경력누계중 월수
Integer		li_Division
Decimal{2}	ldc_Mod
Long			ll_DecisionYear	//인정년수

CHOOSE CASE ls_ColName
	CASE 'from_date','to_date','career_opt','work_year'
		/////////////////////////////////////////////////////////////////////////////////
		// 경력종료일자 변경시 근무년수,인정년수 처리
		/////////////////////////////////////////////////////////////////////////////////
		ls_FrDate = TRIM(THIS.Object.from_date[row])			//경력시작일자
		ls_ToDate = TRIM(THIS.Object.to_date  [row])			//경력종료일자
		IF isNull(ls_FrDate) OR LEN(ls_FrDate) = 0 OR &
			isNull(ls_ToDate) OR LEN(ls_ToDate) = 0 OR &
			ls_FrDate > ls_ToDate THEN
			THIS.Object.work_year    [row] = li_Null			//근무년수
			THIS.Object.decision_year[row] = li_Null			//인정년수
		Else
		
			SELECT	FU_RTN_YEAR_MONTH(:ls_FrDate,:ls_ToDate)
			INTO		:ldc_WorkYear
			FROM		DUAL;
			IF isNull(ldc_WorkYear) OR ldc_WorkYear = 0 THEN
				THIS.Object.work_year    [row] = li_Null			//근무년수
				THIS.Object.decision_year[row] = li_Null			//인정년수
			Else
				THIS.Object.work_year    [row] = ldc_WorkYear		//근무년수
				THIS.Object.decision_year[row] = ldc_WorkYear		//인정년수
			
			/////////////////////////////////////////////////////////////////////////////////
			//	경력구분 변경시 환산율 처리
			//		11	승진100% 경력인정
			//		12	위원회 100%
			//		13	보직 100%
			//		14	담당과목 100%
			//		20	90% 인정
			//		30	80% 인정
			//		40	70% 인정
			//		50	60% 인정
			//		60	50% 인정
			//		70	30% 인정		
			/////////////////////////////////////////////////////////////////////////////////
				li_CareerOpt = THIS.Object.career_opt[row]			//경력인정구분
				CHOOSE CASE li_CareerOpt
					CASE IS < 20 ; ldc_HwanRate = 100
					CASE 20 ; ldc_HwanRate = 90
					CASE 30 ; ldc_HwanRate = 80
					CASE 40 ; ldc_HwanRate = 70
					CASE 50 ; ldc_HwanRate = 60
					CASE 60 ; ldc_HwanRate = 50
					CASE 70 ; ldc_HwanRate = 30
					CASE ELSE ; ldc_HwanRate = 0
				END CHOOSE
				THIS.Object.hwan_rate[row] = ldc_HwanRate				//환산율
				
				/////////////////////////////////////////////////////////////////////////////////
				// 환산년수 처리
				//		환산년수 = (인정년수 * 환산율) / 100
				/////////////////////////////////////////////////////////////////////////////////
				SELECT	FU_RTN_HWAN_YEAR(:ldc_WorkYear,:ldc_HwanRate)
				INTO		:ldc_HwanYear
				FROM		DUAL;
				THIS.Object.hwan_year[row] = ldc_HwanYear	//환산년수
			End If
		End If
		
	CASE 'decision_year','hwan_rate'
		/////////////////////////////////////////////////////////////////////////////////
		// 인정년수, 환산율 변경시 환산년수 처리
		//		환산년수 = (인정년수 * 환산율) / 100
		/////////////////////////////////////////////////////////////////////////////////
		ldc_DecisionYear = THIS.Object.decision_year[row]	//인정년수
		ldc_HwanRate     = THIS.Object.hwan_rate    [row]	//환산율
		
		SELECT	FU_RTN_HWAN_YEAR(:ldc_DecisionYear,:ldc_HwanRate)
		INTO		:ldc_HwanYear
		FROM		DUAL;
		THIS.Object.hwan_year[row] = ldc_HwanYear	//환산년수
		
	CASE 'career_gbn'
		/////////////////////////////////////////////////////////////////////////////////
		// 근속구분변경이 처리
		/////////////////////////////////////////////////////////////////////////////////
		
	CASE ELSE
		RETURN 1
		
END CHOOSE

///////////////////////////////////////////////////////////////////////////////////////
// 3. 경력누계 처리
//			경력누계 = 이전행의 경력누계 + 현재행의 환산년수
///////////////////////////////////////////////////////////////////////////////////////
Long			ll_Row
Long			ll_RowCnt
Long			ll_GetRow
Long			ll_GetColumn
String		ls_Str

Integer		li_ProcesOpt	//처리구분
Decimal{2}	ldc_CareerYm	//근속인정년월누계
Decimal{2}	ldc_CarYear		//총경력년월누계

ll_RowCnt = THIS.RowCount()
IF ll_RowCnt > 0 THEN
	ll_GetRow    = row
	ll_GetColumn = GetColumn()
	li_ProcesOpt = THIS.Object.proces_opt[row]			//처리구분
	ls_FrDate    = TRIM(THIS.Object.from_date[row])		//경력시작일자
	ls_ToDate    = TRIM(THIS.Object.to_date  [row])		//경력종료일자
	IF isNull(li_ProcesOpt) OR li_ProcesOpt   = 0 THEN li_ProcesOpt = 0
	IF isNull(ls_FrDate)    OR LEN(ls_FrDate) = 0 THEN ls_FrDate = ''
	IF isNull(ls_ToDate)    OR LEN(ls_ToDate) = 0 THEN ls_ToDate = ''
	
	THIS.SetReDraw(FALSE)
	THIS.SetSort('from_date A, to_date A, proces_opt A')
	THIS.Sort()
	ls_Find = "proces_opt = "+String(li_ProcesOpt)+" AND "+&
				 "from_date = '"+ls_FrDate+"'"
	ll_Find = THIS.Find(ls_Find,1,THIS.RowCount())
	THIS.SetRow(ll_Find)
	THIS.SetColumn(ll_GetColumn)
	THIS.ScrollToRow(ll_Find)
	THIS.SetReDraw(TRUE)
END IF
FOR ll_Row = 1 TO ll_RowCnt
	////////////////////////////////////////////////////////////////////////////////////
	// 3.1 인사기본에 총경력년월누계
	////////////////////////////////////////////////////////////////////////////////////
	ls_Str = "Evaluate('cumulativeSum(hwan_year for all)',"+&
				String(ll_Row)+")"
	ldc_HwanYear = Double(THIS.Describe(ls_Str))
	IF isNull(ldc_HwanYear) OR ldc_HwanYear = 0 THEN CONTINUE
	
	SELECT	FU_RTN_HWAN_YEAR(:ldc_HwanYear,100)
	INTO		:ldc_CarYear
	FROM		DUAL;
	THIS.Object.car_year[ll_Row] = ldc_CarYear
	////////////////////////////////////////////////////////////////////////////////////
	// 3.2 인사기본에 근속인정년월누계
	////////////////////////////////////////////////////////////////////////////////////
	ls_Str = "Evaluate('cumulativeSum(if ( career_gbn = 9, hwan_year, 0) for all)',"+&
				String(ll_Row)+")"
	ldc_HwanYear = Double(THIS.Describe(ls_Str))
	IF NOT ( isNull(ldc_HwanYear) OR ldc_HwanYear = 0 ) THEN
		SELECT	FU_RTN_HWAN_YEAR(:ldc_HwanYear,100)
		INTO		:ldc_CareerYm
		FROM		DUAL;
	ELSE
		ldc_CareerYm = 0
	END IF
	THIS.Object.com_career_ym[ll_Row] = ldc_CareerYm
NEXT
//인사기본에 총경력년월누계
IF ll_RowCnt > 0 AND ldc_CareerYm > 0 THEN
	idw_update[1].Object.car_year [1] = ldc_CarYear
END IF
//인사기본에 근속인정년월누계
IF ll_RowCnt > 0 AND ldc_CarYear > 0 THEN
	idw_update[1].Object.career_ym[1] = ldc_CareerYm
END IF
RETURN 1
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 

//	이 벤 트 명: itemchanged::dw_update5
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
String	ls_Null
Integer	li_Null

ls_ColName = STRING(dwo.name)
ls_ColData = TRIM(data)
SetNull(ls_Null)
SetNull(li_Null)

String	ls_Find
Long		ll_Find

CHOOSE CASE ls_ColName
	CASE 'proces_opt'
		IF ls_ColData = '1' THEN
			MessageBox('확인','군경력은 입력할 수 없습니다.')
			RETURN 1
		END IF
		IF ls_ColData = '2' THEN
			MessageBox('확인','학력은 입력할 수 없습니다.')
			RETURN 1
		END IF
		IF ls_ColData = '3' THEN
			MessageBox('확인','승진경력은 입력할 수 없습니다.')
			RETURN 1
		END IF
		
	CASE 'from_date','to_date'
		IF NOT f_isDate(ls_ColData) THEN RETURN 1
		THIS.POST EVENT ue_postitemchanged(row,dwo,data)
		
	CASe 'career_opt','work_year','decision_year','hwan_rate','hwan_year','career_gbn'
		THIS.POST EVENT ue_postitemchanged(row,dwo,data)
		
	CASE ELSE
		
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event doubleclicked;call super::doubleclicked;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: doubleclicked::dw_update5
//	기 능 설 명: 더블클릭시 경력사항상세관리 화면 오픈처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')

///////////////////////////////////////////////////////////////////////////////////////
// 2. 경력사항변경 여부체크
///////////////////////////////////////////////////////////////////////////////////////
IF THIS.AcceptText() = -1 THEN
	THIS.SetFocus()
	RETURN -1
END IF
IF THIS.ModifiedCount() + THIS.DeletedCount() > 0 THEN
	wf_SetMsg('경력사항이 변경되었습니다. 저장 후 사용하시기 바랍니다.')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 경력사항상세관리 화면 오픈처리
///////////////////////////////////////////////////////////////////////////////////////
IF row = 0 THEN RETURN

s_insa_com	lstr_com
lstr_com.ls_item[01] = THIS.Object.member_no [row]		//개인번호
lstr_com.ls_item[02] = idw_update[1].Object.name[1]	//성명
lstr_com.ll_item[03] = THIS.Object.career_seq[row]		//순번

OpenWithParm(w_hin202p,lstr_com)

lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
END IF

////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type tabpage_6 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "자격사항"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update6 dw_update6
end type

on tabpage_6.create
this.dw_update6=create dw_update6
this.Control[]={this.dw_update6}
end on

on tabpage_6.destroy
destroy(this.dw_update6)
end on

type dw_update6 from cuo_dwwindow_one_hin within tabpage_6
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 11
string dataobject = "d_hin202i_06"
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

type tabpage_7 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "포상·징계"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update7 dw_update7
end type

on tabpage_7.create
this.dw_update7=create dw_update7
this.Control[]={this.dw_update7}
end on

on tabpage_7.destroy
destroy(this.dw_update7)
end on

type dw_update7 from cuo_dwwindow_one_hin within tabpage_7
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 11
string dataobject = "d_hin202i_07"
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

type tabpage_8 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "국외연수"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update8 dw_update8
end type

on tabpage_8.create
this.dw_update8=create dw_update8
this.Control[]={this.dw_update8}
end on

on tabpage_8.destroy
destroy(this.dw_update8)
end on

type dw_update8 from cuo_dwwindow_one_hin within tabpage_8
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 21
string dataobject = "d_hin202i_09"
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

type tabpage_11 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "위원회이력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list4 dw_list4
end type

on tabpage_11.create
this.dw_list4=create dw_list4
this.Control[]={this.dw_list4}
end on

on tabpage_11.destroy
destroy(this.dw_list4)
end on

type dw_list4 from cuo_dwwindow_one_hin within tabpage_11
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 11
string dataobject = "d_hin202i_12"
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

type tabpage_9 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "보직이력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list2 dw_list2
end type

on tabpage_9.create
this.dw_list2=create dw_list2
this.Control[]={this.dw_list2}
end on

on tabpage_9.destroy
destroy(this.dw_list2)
end on

type dw_list2 from cuo_dwwindow_one_hin within tabpage_9
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 11
string dataobject = "d_hin202i_08"
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

type tabpage_10 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3803
integer height = 1468
long backcolor = 80269524
string text = "변동이력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list3 dw_list3
end type

on tabpage_10.create
this.dw_list3=create dw_list3
this.Control[]={this.dw_list3}
end on

on tabpage_10.destroy
destroy(this.dw_list3)
end on

type dw_list3 from cuo_dwwindow_one_hin within tabpage_10
integer x = 9
integer y = 12
integer width = 3785
integer height = 1452
integer taborder = 11
string dataobject = "d_hin202i_10"
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

type dw_list1 from cuo_dwwindow_one_hin within w_hin210i
integer x = 14
integer y = 348
integer width = 3845
integer height = 656
integer taborder = 70
string dataobject = "d_hin202i_01"
end type

event rowfocuschanging;/////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: rowfocuschanging
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
Long		ll_RowCnt
ll_GetRow = newrow
IF ll_GetRow = 0 THEN RETURN
ll_RowCnt = THIS.RowCount()
IF ll_RowCnt = 0 THEN
	idw_update[01].SetReDraw(FALSE)
	idw_update[01].Reset()
	idw_update[01].InsertRow(0)
	idw_update[01].Object.DataWindow.ReadOnly = 'YES'
	idw_update[01].SetReDraw(TRUE)

	idw_update[02].SetReDraw(FALSE)
	idw_update[02].Reset()
	idw_update[02].InsertRow(0)
	idw_update[02].Object.DataWindow.ReadOnly = 'YES'
	idw_update[02].SetReDraw(TRUE)
	RETURN
END IF
///////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo			//개인번호
ls_MemberNo = dw_list1.Object.hin001m_member_no[ll_GetRow]


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('[인사기본정보] 조회중입니다...')
idw_update[01].SetReDraw(FALSE)
idw_update[01].Reset()
ll_RowCnt = idw_update[01].Retrieve(ls_MemberNo)
		

///////////////////////////////////////////////////////////////////////////////////////
// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
	////////////////////////////////////////////////////////////////////////////////////
	//	3.1 호봉코드DDDW 초기화 처리
	////////////////////////////////////////////////////////////////////////////////////
	String	ls_SalYear		//호봉년도
	String	ls_DutyCode		//직급코드
	Integer	li_AnnOpt		//연봉구분
	
	ls_SalYear  = idw_update[01].Object.sal_year [1]
	ls_DutyCode = idw_update[01].Object.duty_code[1]
	li_AnnOpt   = idw_update[01].Object.ann_opt  [1]
	IF MID(ls_DutyCode,1,1) = '1' THEN ls_DutyCode = '100'
	IF li_AnnOpt = 2 THEN ls_DutyCode = '801'
	idwc_SalClass.Reset()
	IF idwc_SalClass.Retrieve(ls_SalYear,ls_DutyCode) = 0 THEN
		wf_setmsg('호봉코드를 입력하시기 바랍니다.')
		idwc_SalClass.InsertRow(0)
	END IF
	////////////////////////////////////////////////////////////////////////////////////
	// 3.2 인사이미지정보 조회처리
	////////////////////////////////////////////////////////////////////////////////////
	Blob	lbo_Image
	SELECTBLOB	A.MEMBER_IMG
	INTO			:lbo_Image
	FROM			INDB.HIN026M A
	WHERE			A.MEMBER_NO = :ls_MemberNo;
	IF SQLCA.SQLCODE <> 0 THEN
		SetNull(lbo_Image)
		tab_1.tabpage_1.p_image.picturename = "../bmp/blank.bmp"
	END IF
	tab_1.tabpage_1.p_image.SetPicture(lbo_Image)
	////////////////////////////////////////////////////////////////////////////////////
	// 3.3 신상상제정보 조회처리
	////////////////////////////////////////////////////////////////////////////////////
	idw_update[02].SetReDraw(FALSE)
	idw_update[02].Reset()
	ll_RowCnt = idw_update[02].Retrieve(ls_MemberNo)
	IF ll_RowCnt > 0 THEN
		idw_update[02].Object.DataWindow.ReadOnly = 'NO'
	ELSE
		idw_update[02].InsertRow(0)
		idw_update[02].Object.DataWindow.ReadOnly = 'YES'
	END IF
	idw_update[02].SetReDraw(TRUE)
	////////////////////////////////////////////////////////////////////////////////////
	// 3.4 각세부자료 조회처리
	////////////////////////////////////////////////////////////////////////////////////
	Integer	li_idx
	String	ls_Msg
	FOR li_idx = 3 TO UpperBound(idw_update)
		ls_Msg = is_SubTitle[li_idx]
		wf_SetMsg(ls_Msg + ' 조회중입니다...')
		idw_update[li_idx].SetReDraw(FALSE)
		ll_RowCnt = idw_update[li_idx].Retrieve(ls_MemberNo)
		idw_update[li_idx].SetReDraw(TRUE)
	NEXT
	////////////////////////////////////////////////////////////////////////////////////
	// 3.5 인사발령사항에 결재건수 한건이라도 있으면 변경불가처리
	////////////////////////////////////////////////////////////////////////////////////
	Integer	li_Cnt	//결재건수
	SELECT	COUNT(A.SEQ_NO)
	INTO		:li_Cnt
	FROM		INDB.HIN007H A
	WHERE		A.MEMBER_NO = :ls_MemberNo
	AND		A.SIGN_OPT  > 1;
	IF li_Cnt > 0 THEN
		wf_SetMsg('결재처리되어 변경할 수가 없습니다.')
		idw_update[01].Object.DataWindow.ReadOnly = 'YES'
//		wf_SetMenuBtn('R')
//////나중에 삭제처리========================================
//		wf_SetMenuBtn('IDSR')
		idw_update[01].Object.DataWindow.ReadOnly = 'NO'
	ELSE
		wf_SetMsg('[인사기본정보] 자료가 조회되었습니다.')
		idw_update[01].Object.DataWindow.ReadOnly = 'NO'
//		wf_SetMenuBtn('IDSR')
	END IF
ELSE
	idw_update[01].InsertRow(0)
	idw_update[01].Object.DataWindow.ReadOnly = 'YES'
	
	idw_update[02].SetReDraw(FALSE)
	idw_update[02].InsertRow(0)
	idw_update[02].Object.DataWindow.ReadOnly = 'YES'
	idw_update[02].SetReDraw(TRUE)

//	wf_SetMenuBtn('R')	
	wf_SetMsg('[인사기본정보] 해당 자료가 존재하지 않습니다.')
END IF
idw_update[01].SetReDraw(TRUE)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event clicked;//Override
String	ls_ColName
ls_ColName = UPPER(dwo.name)
IF ls_ColName = 'DATAWINDOW' THEN RETURN

IF THIS.RowCount() > 0 AND UPPER(RIGHT(ls_ColName,2)) = '_T' AND ib_SortGubn THEN
	THIS.TRIGGER EVENT ue_et_sort()
	
	Long	ll_SelectRow
	ll_SelectRow = THIS.getrow()
	THIS.SetRedraw(FALSE)
	IF ll_SelectRow = 0 THEN ll_SelectRow = 1
	THIS.ScrollToRow(ll_SelectRow)
	THIS.SetRedraw(TRUE)
	RETURN 1
END IF

end event

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

type uo_member from cuo_insa_member within w_hin210i
integer x = 1577
integer y = 192
integer height = 76
integer taborder = 50
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type gb_1 from groupbox within w_hin210i
integer x = 14
integer y = 12
integer width = 3845
integer height = 324
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회조건"
end type

