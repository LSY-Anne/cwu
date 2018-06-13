$PBExportHeader$w_hyk201a.srw
$PBExportComments$[w_list] 임용구분별 평가대상자생성
forward
global type w_hyk201a from w_window
end type
type dw_main from uo_grid within w_hyk201a
end type
type dw_con from uo_dw within w_hyk201a
end type
type p_1 from picture within w_hyk201a
end type
type st_main from statictext within w_hyk201a
end type
type uo_create from uo_imgbtn within w_hyk201a
end type
type uo_datacreate from uo_imgbtn within w_hyk201a
end type
end forward

global type w_hyk201a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
uo_create uo_create
uo_datacreate uo_datacreate
end type
global w_hyk201a w_hyk201a

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

on w_hyk201a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.uo_create=create uo_create
this.uo_datacreate=create uo_datacreate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.uo_create
this.Control[iCurrent+6]=this.uo_datacreate
end on

on w_hyk201a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.uo_create)
destroy(this.uo_datacreate)
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
lvc_data.setProperty('column1', 'duty_code')  	//직급코드
lvc_data.setProperty('key1', 'jikgub_code')
lvc_data.setProperty('column2', 'appoint_gb')  	//임용구분
lvc_data.setProperty('key2', 'HYK02')
lvc_data.setProperty('column3', 'gus_duty_code')  	//직급코드
lvc_data.setProperty('key3', 'jikgub_code')

func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)

dw_con.Object.evl_ym[dw_con.GetRow()] = func.of_get_sdate('yyyymm')
//dw_con.Object.evl_end[dw_con.GetRow()] = String(Long(func.of_get_sdate('yyyy')) - 1 , '0000') + '1231'
//
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

If uo_create.Enabled Then
	uo_create.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + uo_create.Width + 16
Else
	uo_create.Visible	= FALSE
End If

If uo_datacreate.Enabled Then
	uo_datacreate.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + uo_datacreate.Width + 16
Else
	uo_datacreate.Visible	= FALSE
End If
end event

type ln_templeft from w_window`ln_templeft within w_hyk201a
end type

type ln_tempright from w_window`ln_tempright within w_hyk201a
end type

type ln_temptop from w_window`ln_temptop within w_hyk201a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hyk201a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hyk201a
end type

type ln_tempstart from w_window`ln_tempstart within w_hyk201a
end type

type uc_retrieve from w_window`uc_retrieve within w_hyk201a
end type

type uc_insert from w_window`uc_insert within w_hyk201a
end type

type uc_delete from w_window`uc_delete within w_hyk201a
end type

type uc_save from w_window`uc_save within w_hyk201a
end type

type uc_excel from w_window`uc_excel within w_hyk201a
end type

type uc_print from w_window`uc_print within w_hyk201a
end type

type st_line1 from w_window`st_line1 within w_hyk201a
end type

type st_line2 from w_window`st_line2 within w_hyk201a
end type

type st_line3 from w_window`st_line3 within w_hyk201a
end type

type uc_excelroad from w_window`uc_excelroad within w_hyk201a
end type

type dw_main from uo_grid within w_hyk201a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyk201a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_evl_ym, ls_appoint_gb
Long			ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_evl_ym = dw_con.object.evl_ym[dw_con.GetRow()]
ls_appoint_gb = dw_con.object.appoint_gb[dw_con.GetRow()]

If ls_evl_ym = '' Or IsNull(ls_evl_ym) Then
	MessageBox("확인","평가년월은 반드시 선택하셔야 합니다.")
	dw_con.SetFocus()
	Return -1
End If

If ls_appoint_gb = '' Or IsNull(ls_appoint_gb) Then
	MessageBox("확인","임용구분을 선택하셔야 합니다.")
	dw_con.SetFocus()
	Return -1
End If

ll_rv = THIS.Retrieve(ls_evl_ym, ls_appoint_gb)

RETURN ll_rv

end event

type dw_con from uo_dw within w_hyk201a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyk201a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type p_1 from picture within w_hyk201a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hyk201a
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
string text = "평가대상자 내역"
boolean focusrectangle = false
end type

type uo_create from uo_imgbtn within w_hyk201a
event destroy ( )
integer x = 50
integer y = 40
integer taborder = 30
boolean bringtotop = true
string btnname = "평가대상자생성"
end type

on uo_create.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;/* 조건에 맞는 평가대상자 생성
1. 기준조건에 맞는 기 자료가 존재하는지 확인
2. 해당 조건에 맞는 대상자 생성
*/

String	ls_evl_ym, ls_appoint_gb
Integer	li_cnt, rtn

ls_evl_ym = dw_con.object.evl_ym[dw_con.GetRow()]
ls_appoint_gb = dw_con.object.appoint_gb[dw_con.GetRow()]

If ls_evl_ym = '' Or IsNull(ls_evl_ym) Then
	MessageBox("확인","평가년월은 반드시 선택하셔야 합니다.")
	dw_con.SetFocus()
	Return
End If

If ls_appoint_gb = '' Or IsNull(ls_appoint_gb) Then
	MessageBox("확인","임용구분을 선택하셔야 합니다.")
	dw_con.SetFocus()
	Return
End If

SELECT Count(*)
INTO		:li_cnt
FROM	YGDB.HYK201T
WHERE EVL_YM = :ls_evl_ym
AND		APPOINT_GB = :ls_appoint_gb
USING SQLCA ;

If li_cnt > 0 Then
	rtn = MessageBox("확인","해당 평가년월 임용구분에 대하여 기 생성된 자료가 존재합니다. 재생성할까요? ~r~n 재 생성시 연구평가 생성된 기존자료도 모두 삭제됩니다.", Question!, YesNo!)
	If rtn = 1 Then
		// 기 생성된 자료 삭제
		li_cnt = 0
		SELECT Count(*)
		INTO		:li_cnt
		FROM	YGDB.HYK201T
		WHERE EVL_YM =  :ls_evl_ym
		AND		APPOINT_GB = :ls_appoint_gb
		AND		CLOSE_YN = 'Y'
		USING SQLCA ;
		
		If li_cnt > 0 Then
			MessageBox("확인","해당 년월, 임용구분에 대한 확정된 평가정보가 존재하여 삭제할 수 없습니다.")
			Return
		End If
		
		DELETE FROM YGDB.HYK203T
		WHERE EVL_YM =  :ls_evl_ym
		AND		APPOINT_GB = :ls_appoint_gb
		USING SQLCA ;
		
		If Sqlca.Sqlcode < 0 Then
			MessageBox("확인","해당 평가대상자에 평가자료를 삭제시 오류")
			RollBack Using sqlca ;
			Return
		End If
		
		DELETE FROM YGDB.HYK201T
		WHERE EVL_YM =  :ls_evl_ym
		AND		APPOINT_GB = :ls_appoint_gb
		USING SQLCA ;
		
		If Sqlca.Sqlcode < 0 Then
			MessageBox("확인","해당 평가대상자에 대한 자료를 삭제시 오류")
			RollBack Using sqlca ;
			Return
		End If
	Else
		Return
	End If
End If

// 평가 대상자 생성
INSERT INTO YGDB.HYK201T
SELECT :ls_evl_ym,
			:ls_appoint_gb,
			A.MEMBER_NO,
			TRIM(A.DUTY_CODE),
			A.GWA,
			Decode(TRIM(A.DUTY_CODE),'101',GYOSU_DATE,
												'102',BUGYOSU_DATE,
												'103',JOGYOSU_DATE,
												'104',JUNIM_DATE),
			Decode(TRIM(A.DUTY_CODE),'101',GYOSU_DATE,
												'102',BUGYOSU_DATE,
												'103',JOGYOSU_DATE,
												'104',JUNIM_DATE),
			TO_CHAR((TO_DATE(TO_CHAR(:ls_evl_ym||'01')) - 1), 'YYYYMMDD'),
			B.GUS_DUTY_CODE,
			:ls_evl_ym||'01',
			Null,
			'N',
			:gs_empcode,
			Null,
			Sysdate,
			:gs_empcode,
			Null,
			Sysdate
FROM	INDB.HIN001M A,
			YGDB.HYK104T B
WHERE	B.STD_YM = '201003'
AND		B.APPOINT_GB = :ls_appoint_gb
AND 		TRIM(A.DUTY_CODE) = TRIM(B.DUTY_CODE )
AND		Decode(TRIM(A.DUTY_CODE),'101',GYOSU_DATE,
												'102',BUGYOSU_DATE,
												'103',JOGYOSU_DATE,
												'104',JUNIM_DATE) < TO_CHAR(TO_DATE(TO_CHAR(TO_NUMBER(SUBSTR((:ls_evl_ym||'01'),1,4)) - B.APPOINT_YR)||SUBSTR((:ls_evl_ym||'01'),5,4)), 'YYYYMMDD')

USING SQLCA ;		

If Sqlca.Sqlcode < 0 Then
	MessageBox("확인","평가 대상자 생성시 오류발생")
	RollBack Using Sqlca ;
Else
	Commit Using Sqlca ;
	MessageBox("확인","평가 대상자 생성완료")
End If
	
end event

type uo_datacreate from uo_imgbtn within w_hyk201a
integer x = 389
integer y = 40
integer taborder = 40
boolean bringtotop = true
string btnname = "평가대상자료생성"
end type

on uo_datacreate.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;Long ll_i


dw_main.accepttext()
end event

