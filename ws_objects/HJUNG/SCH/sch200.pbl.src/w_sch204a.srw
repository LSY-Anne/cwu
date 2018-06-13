$PBExportHeader$w_sch204a.srw
$PBExportComments$[w_list]입사신청자 점수산정및확정처리
forward
global type w_sch204a from w_window
end type
type dw_main from uo_grid within w_sch204a
end type
type dw_con from uo_dw within w_sch204a
end type
type p_1 from picture within w_sch204a
end type
type st_main from statictext within w_sch204a
end type
type uo_close from uo_imgbtn within w_sch204a
end type
type uo_create from uo_imgbtn within w_sch204a
end type
type uo_down from uo_imgbtn within w_sch204a
end type
end forward

global type w_sch204a from w_window
integer height = 2420
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
uo_close uo_close
uo_create uo_create
uo_down uo_down
end type
global w_sch204a w_sch204a

forward prototypes
public function integer wf_validall ()
end prototypes

public function integer wf_validall ();Integer	li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

end function

on w_sch204a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.uo_close=create uo_close
this.uo_create=create uo_create
this.uo_down=create uo_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.uo_close
this.Control[iCurrent+6]=this.uo_create
this.Control[iCurrent+7]=this.uo_down
end on

on w_sch204a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.uo_close)
destroy(this.uo_create)
destroy(this.uo_down)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)

idw_update[1]	= dw_main
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_update[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_main

//Excel로부터 IMPORT 할 DataWindow가 있으면 지정
//If uc_excelroad.Enabled Then
//	idw_excelload	=	dw_main
//	is_file_name	=	'우편번호'
//	is_col_name[]	=	{'우편번호', '시도명', '시군구명', '읍면동명', '리명', '도서명', '번지', '아파트/건물명', '상세주소'}
//End If

// 공통코드 Setup
Vector lvc_data

lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
//lvc_data.setProperty('column2', 'sex')  		//성별
//lvc_data.setProperty('key2', 'sex_code')
lvc_data.setProperty('column2', 'door_gb')  		//지원실
lvc_data.setProperty('key2', 'SAZ36')
lvc_data.setProperty('column3', 'enter_term')  		//입사기간
lvc_data.setProperty('key3', 'SAZ29')

func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)

// 초기값 Setup
dw_con.Object.std_year[dw_con.GetRow()] 	= func.of_get_sdate('yyyy')

//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

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

event ue_delete;call super::ue_delete;Long		ll_rv
String		ls_txt

ll_rv = dw_main.Event ue_DeleteRow()

ls_txt = "[삭제] "
If ll_rv = 1 Then
	If Trigger Event ue_save() <> 1 Then
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	Else
		f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
	End If
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
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

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_templeft.beginx

If uo_close.Enabled Then
	uo_close.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + uo_close.Width + 16
Else
	uo_close.Visible	= FALSE
End If

If uo_create.Enabled Then
	uo_create.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + uo_create.Width + 16
Else
	uo_create.Visible	= FALSE
End If

If uo_down.Enabled Then
	uo_down.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + uo_down.Width + 16
Else
	uo_down.Visible	= FALSE
End If
end event

type ln_templeft from w_window`ln_templeft within w_sch204a
end type

type ln_tempright from w_window`ln_tempright within w_sch204a
end type

type ln_temptop from w_window`ln_temptop within w_sch204a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch204a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch204a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch204a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch204a
end type

type uc_insert from w_window`uc_insert within w_sch204a
end type

type uc_delete from w_window`uc_delete within w_sch204a
end type

type uc_save from w_window`uc_save within w_sch204a
end type

type uc_excel from w_window`uc_excel within w_sch204a
end type

type uc_print from w_window`uc_print within w_sch204a
end type

type st_line1 from w_window`st_line1 within w_sch204a
end type

type st_line2 from w_window`st_line2 within w_sch204a
end type

type st_line3 from w_window`st_line3 within w_sch204a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch204a
end type

type dw_main from uo_grid within w_sch204a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch204a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_house_gb, ls_std_year, ls_recruit_no
Long			ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_house_gb 	= dw_con.object.house_gb[dw_con.GetRow()]
ls_std_year 	= dw_con.object.std_year[dw_con.GetRow()]
ls_recruit_no 	= dw_con.object.recruit_no[dw_con.GetRow()]

If ls_house_gb = '' Or IsNull(ls_house_gb) Then
	MessageBox("확인","확정처리하고자 하는 기숙사를 선택하셔야 합니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('house_gb')
	Return 0
End If

If ls_std_year = '' Or IsNull(ls_std_year) Then
	MessageBox("확인","확정처리하고자 하는 학년도를 선택하셔야 합니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('std_year')
	Return 0
End If

If ls_recruit_no = '' Or IsNull(ls_recruit_no) Then
	MessageBox("확인","확정처리하고자 하는 모집번호를 선택하셔야 합니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('recruit_no')
	Return 0
End If

ll_rv = THIS.Retrieve(ls_house_gb, ls_std_year, ls_recruit_no)

RETURN ll_rv

end event

type dw_con from uo_dw within w_sch204a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch204a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type p_1 from picture within w_sch204a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_sch204a
integer x = 114
integer y = 312
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
string text = "입사신청내역 및 점수정보"
boolean focusrectangle = false
end type

type uo_close from uo_imgbtn within w_sch204a
event destroy ( )
integer x = 50
integer y = 40
integer taborder = 41
boolean bringtotop = true
string btnname = "신청마감"
end type

on uo_close.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;Integer	I

For I = 1 To dw_main.RowCount()
	dw_main.Object.close_yn[i] = 'Y'
Next


end event

type uo_create from uo_imgbtn within w_sch204a
event destroy ( )
integer x = 407
integer y = 40
integer taborder = 51
boolean bringtotop = true
string btnname = "점수산정"
end type

on uo_create.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;/*
1. 확정된 자료가 존재하는지 확인
2. 기존에 입사평가정보가 존재하는지 확인
3. 평가정보 생성
*/

String ls_house_gb, ls_std_year, ls_recruit_no, ls_err_text
Integer	li_cnt, rtn

ls_house_gb = dw_con.Object.house_gb[dw_con.GetRow()]
ls_std_year = dw_con.Object.std_year[dw_con.GetRow()]
ls_recruit_no = dw_con.Object.recruit_no[dw_con.GetRow()]

SELECT Count(*)
INTO	:li_cnt
FROM	SCH.SAZ220T
WHERE	HOUSE_GB	= :ls_house_gb
AND	STD_YEAR	= :ls_std_year
AND	RECRUIT_NO	= :ls_recruit_no
AND	CLOSE_YN	= 'Y'
USING SQLCA ;

If li_cnt <= 0 Then
	MessageBox("확인","해당 선택한 조건에 준하는 마감자료가 존재하지 않습니다.")
	Return
End If

li_cnt = 0

SELECT Count(*)
INTO	:li_cnt
FROM	SCH.SAZ240T A
WHERE	A.HOUSE_GB	= :ls_house_gb
AND	A.STD_YEAR	= :ls_std_year
AND	A.HOUSE_REQ_NO in (SELECT B.HOUSE_REQ_NO FROM SCH.SAZ220T B WHERE B.HOUSE_GB = :ls_house_gb AND B.STD_YEAR = :ls_std_year AND B.RECRUIT_NO = :ls_recruit_no AND CLOSE_YN = 'Y')
USING SQLCA ;

If li_cnt > 0 Then
	rtn = MessageBox("확인","해당 선택한 조건에 준하는 기 생성된 평가정보가 존재합니다. 무시하고 진행할까요? 진행시 기존자료는 모두 삭제됩니다.", Question!, YesNo!)
	If rtn = 1 Then
		
		DELETE FROM	SCH.SAZ240T A
		WHERE	A.HOUSE_GB	= :ls_house_gb
		AND	A.STD_YEAR	= :ls_std_year
		AND	A.HOUSE_REQ_NO in (SELECT B.HOUSE_REQ_NO FROM SCH.SAZ220T B WHERE B.HOUSE_GB = :ls_house_gb AND B.STD_YEAR = :ls_std_year AND B.RECRUIT_NO = :ls_recruit_no AND CLOSE_YN = 'Y')
		USING SQLCA ;
		
		If SQLCA.SqlCode < 0 Then
			ls_err_text = Sqlca.SqlErrText
			RollBack Using Sqlca ;
			MessageBox("확인","기 생성된 평가자료 삭제시 오류" + ls_err_text)
			Return
		End If
	Else
		Return
	End If
	
	INSERT INTO SCH.SAZ240T
	SELECT 	A.HOUSE_GB,
				A.STD_YEAR,
				A.HOUSE_REQ_NO,
				NVL((SELECT TO_NUMBER(TRIM(ETC_CD1)) FROM CDDB.KCH102D WHERE CODE_GB = 'SYS02' AND CODE = A.AREA_GB), 0),
				0,
				0,
				0,
				0,
				'N',
				:gs_empcode,
				null,
				SYSDATE,
				:gs_empcode,
				null,
				SYSDATE
	FROM		SCH.SAZ220T A
	WHERE		A.HOUSE_GB	= :ls_house_gb
	AND		A.STD_YEAR	= :ls_std_year
	AND		A.RECRUIT_NO	= :ls_recruit_no
	AND		A.CLOSE_YN	= 'Y'
	USING SQLCA ;

	If SQLCA.SqlCode < 0 Then
		ls_err_text = Sqlca.SqlErrText
		RollBack Using Sqlca ;
		MessageBox("확인","점수산정시 오류" + ls_err_text)
		Return
	End If
	
End If

Commit Using Sqlca ;

MessageBox("확인","사생신청자들의 점수가 산정되었습니다.")

end event

type uo_down from uo_imgbtn within w_sch204a
integer x = 837
integer y = 40
integer taborder = 61
boolean bringtotop = true
string btnname = "입사생사진다운"
end type

on uo_down.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;uo_hjfunc lvc_sch

lvc_sch = create uo_hjfunc

Long		ll_rv
string     ls_house_gb, ls_std_year

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN
End If

ls_house_gb = dw_con.object.house_gb[dw_con.GetRow()]
ls_std_year = dw_con.object.std_year[dw_con.GetRow()]


ll_rv = lvc_sch.of_schphoto_down(ls_house_gb, ls_std_year, '%')

IF ll_rv =1 then 
	 messagebox('알림','C:\emp_image\ 사진다운로드 완료')
end if 


destroy lvc_sch
end event

