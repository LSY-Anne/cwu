$PBExportHeader$w_sch203a.srw
$PBExportComments$[w_master_detail]입사신청서등록-생활관용
forward
global type w_sch203a from w_window
end type
type dw_con from uo_dw within w_sch203a
end type
type dw_sub from uo_grid within w_sch203a
end type
type uc_row_insert from u_picture within w_sch203a
end type
type uc_row_delete from u_picture within w_sch203a
end type
type p_1 from picture within w_sch203a
end type
type st_main from statictext within w_sch203a
end type
type p_2 from picture within w_sch203a
end type
type st_detail from statictext within w_sch203a
end type
type st_1 from statictext within w_sch203a
end type
type p_image from picture within w_sch203a
end type
type dw_main from uo_dw within w_sch203a
end type
end forward

global type w_sch203a from w_window
dw_con dw_con
dw_sub dw_sub
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
st_1 st_1
p_image p_image
dw_main dw_main
end type
global w_sch203a w_sch203a

type variables
Vector	ivc_data
String	is_bef_cell, is_bef_zipcd, is_bef_addr, is_bef_email
String	is_aft_cell, is_aft_zipcd, is_aft_addr, is_aft_email
end variables

forward prototypes
public function integer wf_validall ()
public function vector wf_hakjuk_data (string as_hakbun)
end prototypes

public function integer wf_validall ();Integer	li_rtn, I, li_row, li_seq
dwItemStatus 	l_status
String	ls_house_gb, ls_year, ls_house_req_no
uo_hjfunc lvc_hjfunc

lvc_hjfunc = Create uo_hjfunc

// 신규자료인 경우, 신청번호를 확인하여 Setup 한다.
li_row				= dw_main.GetRow()
ls_house_gb		= dw_main.Object.house_gb[li_row]
ls_year			= dw_main.Object.std_year[li_row]
l_status 			= func.of_getrowstatus(dw_main, dw_main.GetRow())

If l_status = NewModified! Then
	ls_house_req_no	= lvc_hjfunc.of_get_house_req_no(ls_house_gb, ls_year)
	dw_main.Object.house_req_no[dw_main.GetRow()] = ls_house_req_no
Else
	ls_house_req_no	= dw_main.Object.house_req_no[li_row]
End If

// 해당 등록된 가족사항을 확인하여 신규입력된 자료인 경우, 해당 관련된 Key를 Setup 한다.
For I = 1 To dw_sub.RowCount()
	l_status = func.of_getrowstatus(dw_sub, I)
	
	If l_status = NewModified! Then
		dw_sub.Object.house_gb[i] 			= ls_house_gb
		dw_sub.Object.std_year[i] 			= ls_year
		dw_sub.Object.house_req_no[i] 	= ls_house_req_no
		
		If i > 1 Then
			li_seq = dw_sub.Object.seq[i - 1] + 1
		Else
			li_seq = 1
		End If
		dw_sub.Object.seq[i]					= li_seq
	End If
Next

// Null Value Check
For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

Return 1
end function

public function vector wf_hakjuk_data (string as_hakbun);/* 학번을 받아 해당 학생에 대한 학적등록된 이력내역을 확인한다. */

Vector	lvc_data
String		ls_data[]

lvc_data = Create Vector

SELECT	 Trim(JUMIN_NO)
			,Trim(GWA)
			,Trim(HNAME)
			,Trim(SEX)
			,Trim(DECODE(SUBSTR(JUMIN_NO,1,1),'0','20','19')||SUBSTR(JUMIN_NO, 1, 6))
			,Trim(ZIP_ID)
			,Trim(ADDR)
			,''
			,Trim(TEL)
			,Trim(HP)
			,Trim(EMAIL)
			,''
			,Trim(BANK_ID)
			,Trim(ACCOUNT_NAME)
			,Trim(ACCOUNT_NO)
			,Trim(BO_NAME)
			,Trim(BO_TEL)
			,Trim(HIGH_NAME)
			,Trim(HIGH_JOL_DATE)
			,Trim(JIYUK_ID)
INTO		 :ls_data[1]
			,:ls_data[2]
			,:ls_data[3]
			,:ls_data[4]
			,:ls_data[5]
			,:ls_data[6]
			,:ls_data[7]
			,:ls_data[8]
			,:ls_data[9]
			,:ls_data[10]
			,:ls_data[11]
			,:ls_data[12]
			,:ls_data[13]
			,:ls_data[14]
			,:ls_data[15]
			,:ls_data[16]
			,:ls_data[17]
			,:ls_data[18]
			,:ls_data[19]
			,:ls_data[20]
FROM		HAKSA.JAEHAK_HAKJUK
WHERE	HAKBUN = :as_hakbun
USING SQLCA ;

If Sqlca.Sqlcode = 0 Then
	lvc_data.SetProperty('jumin_no', ls_data[1])
	lvc_data.SetProperty('gwa', ls_data[2])
	lvc_data.SetProperty('hname', ls_data[3])
	lvc_data.SetProperty('sex', ls_data[4])
	lvc_data.SetProperty('birth_dt', ls_data[5])
	lvc_data.SetProperty('zip_cd', ls_data[6])
	lvc_data.SetProperty('zip_addr', ls_data[7])
	lvc_data.SetProperty('addr', ls_data[8])
	lvc_data.SetProperty('home_no', ls_data[9])
	lvc_data.SetProperty('cell_no', ls_data[10])
	lvc_data.SetProperty('per_email', ls_data[11])
	lvc_data.SetProperty('nation_cd', ls_data[12])
	lvc_data.SetProperty('bank_cd', ls_data[13])
	lvc_data.SetProperty('deposit_nm', ls_data[14])
	lvc_data.SetProperty('deposit_no', ls_data[15])
	lvc_data.SetProperty('parent_nm', ls_data[16])
	lvc_data.SetProperty('parent_cell', ls_data[17])
	lvc_data.SetProperty('neis_code', ls_data[18])
	lvc_data.SetProperty('jolup_yy', ls_data[19])
	lvc_data.SetProperty('area_gb', ls_data[20])
Else
	lvc_data.SetProperty('jumin_no', '')
	lvc_data.SetProperty('gwa', '')
	lvc_data.SetProperty('hname', '')
	lvc_data.SetProperty('sex', '')
	lvc_data.SetProperty('birth_dt', '')
	lvc_data.SetProperty('zip_cd', '')
	lvc_data.SetProperty('zip_addr', '')
	lvc_data.SetProperty('addr', '')
	lvc_data.SetProperty('home_no', '')
	lvc_data.SetProperty('cell_no', '')
	lvc_data.SetProperty('per_email', '')
	lvc_data.SetProperty('nation_cd', '')
	lvc_data.SetProperty('deposit_no', '')
	lvc_data.SetProperty('deposit_nm', '')
	lvc_data.SetProperty('bank_cd', '')
	lvc_data.SetProperty('parent_nm', '')
	lvc_data.SetProperty('parent_cell', '')
	lvc_data.SetProperty('neis_code', '')
	lvc_data.SetProperty('jolup_yy', '')
	lvc_data.SetProperty('area_gb', '')
End If

Return lvc_data
end function

on w_sch203a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_sub=create dw_sub
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
this.st_1=create st_1
this.p_image=create p_image
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_sub
this.Control[iCurrent+3]=this.uc_row_insert
this.Control[iCurrent+4]=this.uc_row_delete
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.st_main
this.Control[iCurrent+7]=this.p_2
this.Control[iCurrent+8]=this.st_detail
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.p_image
this.Control[iCurrent+11]=this.dw_main
end on

on w_sch203a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_sub)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.st_1)
destroy(this.p_image)
destroy(this.dw_main)
end on

event ue_postopen;call super::ue_postopen;ivc_data = Create Vector

func.of_design_con( dw_con )
func.of_design_dw( dw_main )
//This.Event ue_resize_dw( st_line1, dw_sub )

dw_con.insertrow(0)
dw_main.InsertRow(0)

idw_update[1]	= dw_main
idw_update[2]	= dw_sub
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_main
//idw_Toexcel[2]	= dw_sub

// 공통코드 Setup
Vector lvc_data

lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
lvc_data.setProperty('column2', 'sex')  		//성별
lvc_data.setProperty('key2', 'sex_code')
lvc_data.setProperty('column3', 'religion_cd')  		//종교코드
lvc_data.setProperty('key3', 'jonggyo_code')
lvc_data.setProperty('column4', 'door_gb')  		//지원실
lvc_data.setProperty('key4', 'SAZ36')
lvc_data.setProperty('column5', 'area_gb')  		//지역구분
lvc_data.setProperty('key5', 'SYS04')
lvc_data.setProperty('column6', 'nation_cd')  		//국적구분
lvc_data.setProperty('key6', 'kukjuk_code')
lvc_data.setProperty('column7', 'enter_term')  		//입사기간
lvc_data.setProperty('key7', 'SAZ29')
lvc_data.setProperty('column8', 'zone1_gb')  		//선택그룹1
lvc_data.setProperty('key8', 'SAZ37')
lvc_data.setProperty('column9', 'zone2_gb')  		//선택그룹2
lvc_data.setProperty('key9', 'SAZ38')
lvc_data.setProperty('column10', 'zone3_gb')  		//선택그룹3
lvc_data.setProperty('key10', 'SAZ39')
lvc_data.setProperty('column11', 'smking_gb')  		//흡연종류
lvc_data.setProperty('key11', 'SAZ22')
lvc_data.setProperty('column12', 'sick_gb')  		//질병종류
lvc_data.setProperty('key12', 'SAZ40')
lvc_data.setProperty('column13', 'sms_gb')  		//SMS 정보 요청종류
lvc_data.setProperty('key13', 'SAZ41')
lvc_data.setProperty('column14', 'bank_cd')  //은행
lvc_data.setProperty('key14', 'bank_code')
func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)

// 초기값 Setup
dw_con.Object.house_gb[dw_con.GetRow()]	= '2'
dw_con.Object.std_year[dw_con.GetRow()] 	= func.of_get_sdate('yyyy')
dw_con.Object.hakbun[dw_con.GetRow()]	= gs_empcode
dw_con.Object.hname[dw_con.GetRow()]	= gs_empname

//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

Post Event ue_inquiry()
end event

event ue_insert;call super::ue_insert;Long		ll_rv
String		ls_txt

ll_rv = dw_main.Event ue_InsertRow()

ls_txt = "[신규] "
If ll_rv = 1 Then
	f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If

end event

event ue_delete;call super::ue_delete;String		ls_txt

ls_txt = "[삭제] "
If dw_main.RowCount() > 0 Then
	If dw_main.Event ue_DeleteRow() > 0 Then
		dw_sub.uf_deleteAll()
		If Trigger Event ue_save() <> 1 Then
			f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
		Else
			f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
		End If
	Else
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	End If
End If

end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = This.Event ue_updatequery() 
If ll_rv <> 1 And ll_rv <> 2 Then RETURN -1

SetPointer(HourGlass!)
If ib_retrieve_wait Then
	gf_openwait()
End If
ll_rv = dw_main.Event ue_Retrieve()
If ll_rv > 0 Then
	f_set_message("[조회] " + String(ll_rv) + '건의 자료가 조회되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	f_set_message("[조회] " + '자료가 없습니다.', '', parentwin)
Else
	f_set_message("[조회] " + '오류가 발생했습니다.', '', parentwin)
End If
If ib_retrieve_wait Then
	gf_closewait()
End If
SetPointer(Arrow!)
ib_excl_yn = FALSE

RETURN ll_rv

end event

event ue_button_set;call super::ue_button_set;If uc_row_insert.Enabled Then
	uc_row_insert.Visible	= TRUE
Else
	uc_row_insert.Visible	= FALSE
End If

If uc_row_delete.Enabled Then
	uc_row_delete.Visible	= TRUE
Else
	uc_row_delete.Visible	= FALSE
End If

end event

event ue_saveend;call super::ue_saveend;/* 
	1. 해당 생활관은 사생이 직접 기숙사를 선택할 수 있으므로 선택한 기숙사의 상세내역에 대한 사항을 임의로 만들어준다.
		- 입사생평가정보 라인생성
		- 기숙사배정인원 정보생성
		- 해당 입사생에 대한 가상계좌부여
	2. 기숙사생의 기본정보중 아래내역에 대한 사항을 확인하여 수정된경우, 학적과 연동하여 처리한다.
		- 핸드폰
		- 주소
		- 이메일
*/

String	ls_hakbun, ls_addr, ls_err_Text
String	ls_house_gb, ls_std_year, ls_house_req_no
String	ls_house_cd, ls_room_cd, ls_door_gb, ls_door_no, ls_name, ls_door_ty
String	ls_enter_term, ls_str, ls_end, ls_cms_bank_cd = '20', ls_cms_deposit_no = '1111111111', ls_cms_deposit_nm = '가상'
Integer	li_cnt

ls_hakbun = dw_main.Object.hakbun[dw_main.GetRow()]
ls_house_gb			= dw_main.Object.house_gb[dw_main.GetRow()]
ls_std_year			= dw_main.Object.std_year[dw_main.GetRow()]
ls_house_req_no	= dw_main.Object.house_req_no[dw_main.GetRow()]
ls_house_cd = dw_main.Object.house_cd[dw_main.GetRow()]
ls_room_cd = dw_main.Object.room_cd[dw_main.GetRow()]
ls_door_gb = dw_main.Object.saz250t_door_gb[dw_main.GetRow()]
ls_door_ty = dw_main.Object.door_gb[dw_main.GetRow()]
ls_door_no = dw_main.Object.door_no[dw_main.GetRow()]
ls_name = dw_main.Object.hname[dw_main.GetRow()]
ls_enter_term = dw_main.Object.enter_term[dw_main.GetRow()]
ls_addr	 = dw_main.Object.zip_addr[dw_main.GetRow()]

SELECT Count(*)
INTO	:li_cnt
FROM	SCH.SAZ240T
WHERE HOUSE_GB	= :ls_house_gb
AND	STD_YEAR	= :ls_std_year
AND	HOUSE_REQ_NO	= :ls_house_req_no
USING SQLCA ;

If li_cnt <= 0 Then
	INSERT INTO SCH.SAZ240T
	(HOUSE_GB, STD_YEAR, HOUSE_REQ_NO, AREA_RATE, RECORD_RATE, DEMERIT_RATE, BEF_GRADE, FINAL_RANK, FINAL_YN, WORKER, IPADDR, WORK_DATE, JOB_UID, JOB_ADD, JOB_DATE)
	VALUES
	(:ls_house_gb, :ls_std_year, :ls_house_req_no, 0, 0, 0, 0, 0, 'Y', :gs_empcode, null, SYSDATE, :gs_empcode, null, SYSDATE)
	USING SQLCA ;
	
	If Sqlca.SqlCode < 0 Then
		ls_err_text = Sqlca.SqlErrText
		
		RollBack Using Sqlca ;
		
		MessageBox("확인","사생에 대한 룸정보를 적용시 오류(1)" + ls_err_text)
		Return -1
	End If
End If

SELECT Count(*)
INTO	:li_cnt
FROM	SCH.SAZ250T
WHERE HOUSE_GB	= :ls_house_gb
AND	STD_YEAR	= :ls_std_year
AND	HOUSE_REQ_NO	= :ls_house_req_no
USING SQLCA ;

If li_cnt <= 0 Then
	
	INSERT INTO SCH.SAZ250T
	(HOUSE_GB, STD_YEAR, ALLOCATE_NO, HOUSE_REQ_NO, HOUSE_CD, ROOM_CD, DOOR_GB, DOOR_NO, STAT_CD, HAKBUN, HNAME, WORKER, IPADDR, WORK_DATE, JOB_UID, JOB_ADD, JOB_DATE)
	VALUES
	(:ls_house_gb, :ls_std_year, :ls_house_req_no, :ls_house_req_no, :ls_house_cd, :ls_room_cd, :ls_door_gb, :ls_door_no, '1', :ls_hakbun, :ls_name, :gs_empcode, null, SYSDATE, :gs_empcode, null, SYSDATE)
	USING SQLCA ;
	
	If Sqlca.SqlCode < 0 Then
		ls_err_text = Sqlca.SqlErrText
		
		RollBack Using Sqlca ;
		
		MessageBox("확인","사생에 대한 룸정보를 적용시 오류(2)" + ls_err_text)
		Return -1
	End If
End If

SELECT Count(*)
INTO	:li_cnt
FROM	SCH.SAZ280T
WHERE HOUSE_GB	= :ls_house_gb
AND	STD_YEAR	= :ls_std_year
AND	HOUSE_REQ_NO	= :ls_house_req_no
USING SQLCA ;

If li_cnt <= 0 Then
	
	INSERT INTO SCH.SAZ280T
	(HOUSE_GB, STD_YEAR, HOUSE_REQ_NO, HAKBUN, FEE_STR, FEE_END, GUARANTEE_AMT, ENTER_AMT, MNG_AMT, FOOD_AMT, DC_AMT, HOUSE_FEE_TOT, CMS_BANK_CD, CMS_DEPOSIT_NO, CMS_DEPOSIT_NM, BILL_PRT_YN, RECEIPT_STATUS, RECEIPT_DATE, WORKER, IPADDR, WORK_DATE, JOB_UID, JOB_ADD, JOB_DATE)
	SELECT :ls_house_gb, 
			 :ls_std_year, 
			 :ls_house_req_no, 
			 :ls_hakbun, 
			 :ls_str, 
			 :ls_end,
			 GUARANTEE_AMT,
			 ENTER_AMT,
			 MNG_AMT,
			 FOOD_AMT,
			 0,
			 (GUARANTEE_AMT + ENTER_AMT + MNG_AMT + FOOD_AMT),
			 :ls_cms_bank_cd,
			 :ls_cms_deposit_no,
			 :ls_cms_deposit_nm,
			 'N',
			 '1',
			 null,
			 :gs_empcode, 
			 null, 
			 SYSDATE, 
			 :gs_empcode, 
			 null, 
			 SYSDATE
	FROM	 SCH.SAZ130M
	WHERE	 HOUSE_GB = :ls_house_gb
	AND	 STD_YEAR = :ls_std_year
	AND	 ENTER_TERM = :ls_enter_term
	AND	 DOOR_GB = :ls_door_ty
	USING SQLCA ;
	
	If Sqlca.SqlCode < 0 Then
		ls_err_text = Sqlca.SqlErrText
		
		RollBack Using Sqlca ;
		
		MessageBox("확인","사생에 대한 룸정보를 적용시 오류(2)" + ls_err_text)
		Return -1
	End If
End If


If (is_bef_cell <> is_aft_cell) Or (is_bef_zipcd <> is_aft_zipcd) Or (is_bef_addr <> is_aft_addr) Or (is_bef_email <> is_aft_email) Then
		
	UPDATE HAKSA.JAEHAK_HAKJUK
	SET	ZIP_ID	= :is_aft_zipcd,
			ADDR		= :ls_addr||' '||:is_aft_addr,
			HP			= :is_aft_cell,
			EMAIL		= :is_aft_email
	WHERE	HAKBUN 	= :ls_hakbun
	USING SQLCA ;

	If Sqlca.SqlCode < 0 Then
		ls_err_text = Sqlca.SqlErrText
		
		RollBack Using Sqlca ;
		
		MessageBox("확인","학적관련 변동사항을 적용시 오류" + ls_err_text)
		Return -1
	End If
End If

Return 1

end event

type ln_templeft from w_window`ln_templeft within w_sch203a
end type

type ln_tempright from w_window`ln_tempright within w_sch203a
end type

type ln_temptop from w_window`ln_temptop within w_sch203a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch203a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch203a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch203a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch203a
end type

type uc_insert from w_window`uc_insert within w_sch203a
end type

type uc_delete from w_window`uc_delete within w_sch203a
end type

type uc_save from w_window`uc_save within w_sch203a
end type

type uc_excel from w_window`uc_excel within w_sch203a
end type

type uc_print from w_window`uc_print within w_sch203a
end type

type st_line1 from w_window`st_line1 within w_sch203a
end type

type st_line2 from w_window`st_line2 within w_sch203a
end type

type st_line3 from w_window`st_line3 within w_sch203a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch203a
end type

type dw_con from uo_dw within w_sch203a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch202a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_hakbun' Then
		
	s_insa_com	lstr_com
	String		ls_KName, ls_hakbun
	
	This.accepttext()
	
	ls_KName =  trim(this.object.hname[1])
		
	OpenWithParm(w_hsg_hakjuk,ls_kname)
	
	lstr_com = Message.PowerObjectParm
	IF NOT isValid(lstr_com) THEN
		dw_con.SetFocus()
		dw_con.setcolumn('hname')
		RETURN -1
	END IF
	
	ls_kname             = lstr_com.ls_item[2]	//성명
	ls_hakbun            = lstr_com.ls_item[1]	//학번
	this.object.hname[1]        = ls_kname					//성명
	This.object.hakbun[1]     = ls_hakbun				//개인번호
	Parent.post event ue_inquiry()	
	return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_kname

This.accepttext()
Choose Case	dwo.name
	Case	'hakbun','hname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'hname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'hname'	, '')			
			RETURN
		End If
		
		SELECT HAKBUN, HNAME
		INTO :ls_hakbun , :ls_kname
		FROM  (	SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JAEHAK_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JOLUP_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.D_HAKJUK	A	)	A
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_kname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.hakbun[row] = ls_hakbun
			This.object.hname[row] = ls_kname
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_hakbun)
			return 1
			
		End If	
End Choose


end event

type dw_sub from uo_grid within w_sch203a
boolean visible = false
integer x = 50
integer y = 1896
integer width = 4389
integer height = 368
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sch202a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean ib_end_add = true
end type

event itemchanged;call super::itemchanged;String	ls_hakbun, ls_house_yn

This.AcceptText()

Choose Case dwo.Name
	Case 'hakbun','house_yn'
		ls_hakbun	= This.Object.hakbun[row]
		ls_house_yn	= This.Object.house_yn[row]
		
		If ls_house_yn = 'Y' Then
			If ls_hakbun = '' Or IsNull(ls_hakbun) Then
				MessageBox("확인","등록한 가족이 본교 기숙사생임을 선택시에는 반드시 해당자 학번을 입력해주세요")
				This.SetFocus()
				This.SetColumn('hakbun')
				Return 1
			End IF
		End If
End Choose
end event

type uc_row_insert from u_picture within w_sch203a
boolean visible = false
integer x = 3890
integer y = 1800
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;If dw_main.RowCount() > 0 Then
	dw_sub.PostEvent("ue_InsertRow")
End If

end event

type uc_row_delete from u_picture within w_sch203a
boolean visible = false
integer x = 4169
integer y = 1800
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_sub.PostEvent("ue_DeleteRow")

end event

type p_1 from picture within w_sch203a
integer x = 50
integer y = 324
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_sch203a
integer x = 114
integer y = 308
integer width = 1051
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "기숙사입사신청정보"
boolean focusrectangle = false
end type

type p_2 from picture within w_sch203a
boolean visible = false
integer x = 50
integer y = 1836
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_sch203a
boolean visible = false
integer x = 114
integer y = 1824
integer width = 1051
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "가족관계정보"
boolean focusrectangle = false
end type

type st_1 from statictext within w_sch203a
boolean visible = false
integer x = 3045
integer y = 280
integer width = 402
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "사진이관"
boolean focusrectangle = false
end type

event clicked;INSERT INTO SCH.SAZ150M
(HAKBUN, WORKER, IPADD, WORK_DATE, JOB_UID, JOB_ADD, JOB_DATE)
SELECT   'admin'
			,:gs_empcode
			,NULL
			,SYSDATE
			,:gs_empcode
			,NULL
			,SYSDATE
FROM HAKSA.PHOTO 
WHERE HAKBUN = '2004175'
USING SQLCA ;

blob lb_data

SELECTBLOB P_IMAGE
INTO	:lb_data
FROM HAKSA.PHOTO
WHERE HAKBUN = '2004175'
USING SQLCA ;

UPDATEBLOB SCH.SAZ150M A
SET A.P_IMAGE = :lb_data
WHERE HAKBUN = 'admin'
USING SQLCA ;

COMMIT ;

			
end event

type p_image from picture within w_sch203a
integer x = 59
integer y = 556
integer width = 425
integer height = 444
string picturename = "..\img\icon\cwu_logo.jpg"
boolean focusrectangle = false
end type

type dw_main from uo_dw within w_sch203a
event type long ue_retrieve ( )
integer x = 50
integer y = 380
integer width = 4384
integer height = 1412
integer taborder = 11
string dataobject = "d_sch203a_1"
boolean border = false
end type

event type long ue_retrieve();String		ls_house_gb, ls_std_year, ls_hakbun, ls_house_req_no
blob 		lb_data
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_house_gb 	= dw_con.Object.house_gb[dw_con.GetRow()]
ls_std_year 	= dw_con.Object.std_year[dw_con.GetRow()]
ls_hakbun 		= dw_con.Object.hakbun[dw_con.GetRow()]

This.SetRedraw(False)
ll_rv = This.Retrieve(ls_house_gb, ls_std_year, ls_hakbun)
If ll_rv > 0 Then
	ls_house_req_no = dw_main.Object.house_req_no[dw_main.GetRow()]
	//dw_sub.Retrieve(ls_house_gb, ls_std_year, ls_house_req_no)
Else
	This.Event ue_insertRow()
	//dw_sub.Reset()
End If
This.SetRedraw(True)

// 해당 학생의 사진을 띄운다.
SELECTBLOB P_IMAGE
INTO	:lb_data
FROM HAKSA.PHOTO
WHERE HAKBUN = :ls_hakbun
USING SQLCA ;

p_image.SetPicture(lb_data)

RETURN ll_rv

end event

event ue_deleteend;call super::ue_deleteend;If dw_sub.uf_DeleteAll() >= 0 Then
	RETURN 1
Else
	RETURN -1
End If

end event

event ue_insertstart;call super::ue_insertstart;uo_hjfunc	hjfunc
String			ls_house_gb, ls_std_year, ls_hakbun, ls_sex
Integer		li_rtn, li_cnt

hjfunc = Create uo_hjfunc

If AncestorReturnValue = 1 Then
	dw_sub.Reset()
Else
	RETURN AncestorReturnValue
End If

ls_house_gb = dw_con.Object.house_gb[dw_con.GetRow()]
ls_hakbun	= dw_con.object.hakbun[dw_con.Getrow()]

If ls_hakbun = '' Or isnull(ls_hakbun) Then RETURN  -1

SELECT SEX
INTO :ls_sex
FROM HAKSA.JAEHAK_HAKJUK
WHERE HAKBUN = :ls_hakbun;

ivc_data.SetProperty('house_gb', ls_house_gb)
ivc_data.SetProperty('sex', ls_sex)
// 현재 신청기간인지 확인
li_rtn = hjfunc.of_check_recruit(ivc_data)
If li_rtn < 1 Then
	Return li_rtn
End If

// 신청하고자 하는 사생의 기존자료가 존재하는지 확인
ls_std_year = ivc_data.GetProperty('std_year')

SELECT 	Count(*)
INTO		:li_cnt
FROM		SCH.SAZ220T
WHERE	HOUSE_GB	= :ls_house_gb
AND		STD_YEAR	= :ls_std_year
AND		HAKBUN		= :gs_empcode
AND		CLOSE_YN	= 'N' 
USING SQLCA ;

If li_cnt > 0 Then
	MessageBox("확인","기 신청한 자료가 존재하므로 신규로 등록할 수 없습니다.")
	Return -1
End If

Return 1
end event

event ue_insertend;call super::ue_insertend;Vector	lvc_data
String		ls_hakbun

lvc_data = Create Vector

ls_hakbun = dw_con.Object.hakbun[dw_con.GetRow()]
lvc_data = wf_hakjuk_data(ls_hakbun)

// 신규 Row에 대한 기본적인 자료를 Setup 한다.
This.Object.house_gb[al_row]		= ivc_data.GetProperty('house_gb')
This.Object.std_year[al_row]		= ivc_data.GetProperty('std_year')
This.Object.recruit_no[al_row]		= ivc_data.GetProperty('recruit_no')
This.Object.house_req_dt[al_row]	= func.of_get_sdate('yyyymmdd')
This.Object.hakbun[al_row]			= ls_hakbun
This.Object.hname[al_row]			= lvc_data.GetProperty('hname')
This.Object.per_email[al_row]		= lvc_data.GetProperty('per_email')
This.Object.sex[al_row]				= lvc_data.GetProperty('sex')
This.Object.gwa[al_row]				= lvc_data.GetProperty('gwa')
This.Object.jumin_no[al_row]		= lvc_data.GetProperty('jumin_no')
This.Object.birth_dt[al_row]		= lvc_data.GetProperty('birth_dt')
This.Object.nation_cd[al_row]	= lvc_data.GetProperty('nation_cd')
This.Object.zip_cd[al_row]			= lvc_data.GetProperty('zip_cd')
This.Object.zip_addr[al_row]		= lvc_data.GetProperty('zip_addr')
This.Object.addr[al_row]			= lvc_data.GetProperty('addr')
This.Object.cell_no[al_row]			= lvc_data.GetProperty('cell_no')
This.Object.home_no[al_row]		= lvc_data.GetProperty('home_no')
This.Object.parent_nm[al_row]	= lvc_data.GetProperty('parent_nm')
This.Object.parent_cell[al_row]	= lvc_data.GetProperty('parent_cell')
This.Object.bank_cd[al_row]		= lvc_data.GetProperty('bank_cd')
This.Object.deposit_no[al_row]	= lvc_data.GetProperty('deposit_no')
This.Object.deposit_nm[al_row]	= lvc_data.GetProperty('deposit_nm')
This.Object.close_yn[al_row]		= 'N'

Return 1
end event

event ue_insertrow;call super::ue_insertrow;If AncestorReturnValue < 0 Then
	This.InsertRow(0)
End If

Return AncestorReturnValue
end event

event clicked;call super::clicked;Long   ll_cnt, ll_i
Vector lvc_data

lvc_data = Create Vector

Choose Case dwo.name
	Case 'p_zipcode'
		lvc_data.SetProperty('parm_cnt', '0')
		lvc_data.SetProperty('parm_str01', This.Object.zip_cd[row])
		
		If 	OpenWithParm(w_post_pop, lvc_data) = 1 Then
			lvc_data = Message.PowerObjectParm
			If isvalid(lvc_data) Then
				This.Object.zip_cd[row]		= lvc_data.GetProperty("parm_str01")
				This.Object.zip_addr[row]  	= lvc_data.GetProperty("parm_str03")
			ENd If
		End IF
	Case 'p_house'
		lvc_data.SetProperty('parm_cnt', '1')
		lvc_data.Setproperty("house_gb",  dw_con.object.house_gb[dw_con.getrow()])
		lvc_data.Setproperty("std_year",  dw_con.object.std_year[dw_con.getrow()])
		lvc_data.Setproperty("hakbun", this.object.hakbun[row])
		lvc_data.Setproperty("sex", this.object.sex[row])
		
		If 	OpenWithParm(w_sch_house_select, lvc_data) = 1 Then
			lvc_data = Message.PowerObjectParm
			If isvalid(lvc_data) Then
				This.Object.house_nm[row] = lvc_data.GetProperty("house_nm")
				This.Object.house_cd[row] = lvc_data.GetProperty("house_cd")
				This.Object.room_cd[row] = lvc_data.GetProperty("room_cd")
				This.Object.saz250t_door_gb[row] = lvc_data.GetProperty("door_gb")
				This.Object.door_no[row] = '01' //lvc_data.GetProperty("door_no")
			ENd If
		End IF
End Choose

end event

event itemchanged;call super::itemchanged;String	ls_addr

Choose Case dwo.Name
	Case 'zip_cd'
		If func.of_get_addr(Data, ls_addr) > 0 Then
			This.Object.zip_addr[row] = ls_addr
		Else
			MessageBox("확인","유요한 우편주소가 아닙니다. 확인후, 다시 입력해주세요.")
			Data = ''
			This.Object.zip_cd[row] = ''
			Return 2
		End If
		is_bef_zipcd = This.GetItemString(row, 'zip_cd')
		is_aft_zipcd = Data
	Case 'addr'
		is_bef_addr = This.GetItemString(row, 'addr')
		is_aft_addr = Data
	Case 'per_email'
		is_bef_email = This.GetItemString(row, 'per_email')
		is_aft_email = Data
	Case 'cell_no'
		is_bef_cell = This.GetItemString(row, 'cell_no')
		is_aft_cell = Data
End Choose

end event

