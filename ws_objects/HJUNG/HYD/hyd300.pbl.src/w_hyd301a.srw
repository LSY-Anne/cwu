$PBExportHeader$w_hyd301a.srw
$PBExportComments$연구업적평가대상자생성
forward
global type w_hyd301a from w_window
end type
type dw_main from uo_grid within w_hyd301a
end type
type dw_con from uo_dw within w_hyd301a
end type
type p_1 from picture within w_hyd301a
end type
type st_main from statictext within w_hyd301a
end type
type uo_create from uo_imgbtn within w_hyd301a
end type
end forward

global type w_hyd301a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
uo_create uo_create
end type
global w_hyd301a w_hyd301a

type variables
String	is_evl_year, is_evl_str, is_evl_end, is_jikwi_code, is_aft_jikwi_code
end variables

forward prototypes
public function integer wf_validall ()
public function integer wf_check_con ()
end prototypes

public function integer wf_validall ();Integer	li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

end function

public function integer wf_check_con ();String	ls_evl_year, ls_jikwi_code, ls_str_dt, ls_end_dt, ls_aft_jikwi
Integer li_row

dw_con.AcceptText()

li_row = dw_con.GetRow()
ls_evl_year = dw_con.Object.evl_year[li_row]
ls_jikwi_code = dw_con.Object.jikwi_code[li_row]
ls_str_dt = dw_con.Object.evl_str[li_row]
ls_end_dt = dw_con.Object.evl_end[li_row]
ls_aft_jikwi = dw_con.Object.aft_jikwi_code[li_row]

If ls_evl_year = '' Or IsNull(ls_evl_year) Then
	MessageBox("확인","평가년도를 선택하지 않았습니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('evl_year')
	Return -1
End If
If ls_jikwi_code = '' Or IsNull(ls_jikwi_code) Then
	MessageBox("확인","평가하고자 하는 대상직위를 선택하셔야 합니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('jikwi_code')
	Return -1
End If
If ls_str_dt = '' Or IsNull(ls_str_dt) Or ls_end_dt = '' Or IsNull(ls_end_dt) Then
	MessageBox("확인","평가대상기간의 일자가 올바르지 않습니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('evl_str')
	Return -1
End If
If ls_str_dt > ls_end_dt Then
	MessageBox("확인","평가대상 시작일은 종료일보다 클 수 없습니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('evl_end')
	Return -1
End If

Return 1
end function

on w_hyd301a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.uo_create=create uo_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.uo_create
end on

on w_hyd301a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.uo_create)
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
lvc_data.setProperty('column1', 'jikwi_code')  	//직위코드
lvc_data.setProperty('key1', 'jikwi_code')
lvc_data.setProperty('column2', 'aft_jikwi_code')  	//직위코드
lvc_data.setProperty('key2', 'jikwi_code')

func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)

dw_con.Object.evl_year[dw_con.GetRow()] = func.of_get_sdate('yyyy')
dw_con.Object.evl_end[dw_con.GetRow()] = String(Long(func.of_get_sdate('yyyy')) - 1 , '0000') + '1231'

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

type ln_templeft from w_window`ln_templeft within w_hyd301a
end type

type ln_tempright from w_window`ln_tempright within w_hyd301a
end type

type ln_temptop from w_window`ln_temptop within w_hyd301a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hyd301a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hyd301a
end type

type ln_tempstart from w_window`ln_tempstart within w_hyd301a
end type

type uc_retrieve from w_window`uc_retrieve within w_hyd301a
end type

type uc_insert from w_window`uc_insert within w_hyd301a
end type

type uc_delete from w_window`uc_delete within w_hyd301a
end type

type uc_save from w_window`uc_save within w_hyd301a
end type

type uc_excel from w_window`uc_excel within w_hyd301a
end type

type uc_print from w_window`uc_print within w_hyd301a
end type

type st_line1 from w_window`st_line1 within w_hyd301a
end type

type st_line2 from w_window`st_line2 within w_hyd301a
end type

type st_line3 from w_window`st_line3 within w_hyd301a
end type

type uc_excelroad from w_window`uc_excelroad within w_hyd301a
end type

type dw_main from uo_grid within w_hyd301a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd301a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv

If wf_check_con() = -1 Then
	RETURN -1
End If

ll_rv = THIS.Retrieve(is_evl_year, is_jikwi_code)

RETURN ll_rv

end event

type dw_con from uo_dw within w_hyd301a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd301a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case 'evl_year'
		This.Object.evl_end[row] = String(Long(Data) -1, '0000') + '1231'
End Choose
end event

type p_1 from picture within w_hyd301a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hyd301a
integer x = 114
integer y = 324
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
string text = "평가대상자내역"
boolean focusrectangle = false
end type

type uo_create from uo_imgbtn within w_hyd301a
integer x = 50
integer y = 40
integer taborder = 20
boolean bringtotop = true
string btnname = "평가대상자생성"
end type

event clicked;call super::clicked;If wf_check_con() <= 0 Then
	Return
End If

/* 조건에 맞는 평가대상자 생성
1. 기준조건에 맞는 기 자료가 존재하는지 확인
2. 해당 조건에 맞는 대상자 생성
*/

Integer	li_cnt, rtn

SELECT Count(*)
INTO		:li_cnt
FROM	YGDB.HYD401T
WHERE EVL_YEAR = :is_evl_year
AND		JIKWI_CODE = :is_jikwi_code
USING SQLCA ;

If li_cnt > 0 Then
	rtn = MessageBox("확인","해당 평가년도에 대한 대상직위자에 대하여 기 생성된 자료가 존재합니다. 재생성할까요? ~r~n 재 생성시 연구평가 생성된 기존자료도 모두 삭제됩니다.", Question!, YesNo!)
	If rtn = 1 Then
		// 기 생성된 자료 삭제
		li_cnt = 0
		SELECT Count(*)
		INTO		:li_cnt
		FROM	YGDB.HYD402T
		WHERE EVL_YEAR = :is_evl_year
		AND		MEMBER_NO IN (SELECT MEMBER_NO FROM YGDB.HYD401T WHERE EVL_YEAR = :is_evl_year AND JIKWI_CODE = :is_jikwi_code)
		AND		FIX_YN = 'Y'
		USING SQLCA ;
		
		If li_cnt > 0 Then
			MessageBox("확인","해당 년도, 대상직위에 대한 확정된 평가정보가 존재하여 삭제할 수 없습니다.")
			Return
		End If
		
		DELETE FROM YGDB.HYD402T
		WHERE EVL_YEAR = :is_evl_year
		AND		MEMBER_NO IN (SELECT MEMBER_NO FROM YGDB.HYD401T WHERE EVL_YEAR = :is_evl_year AND JIKWI_CODE = :is_jikwi_code)
		USING SQLCA ;
		
		If Sqlca.Sqlcode < 0 Then
			MessageBox("확인","해당 연구업적 평가에 대한 자료를 삭제시 오류")
			RollBack Using sqlca ;
			Return
		End If
		
		DELETE FROM YGDB.HYD401T
		WHERE EVL_YEAR = :is_evl_year
		AND		JIKWI_CODE = :is_jikwi_code
		USING SQLCA ;
		
		If Sqlca.Sqlcode < 0 Then
			MessageBox("확인","해당 연구업적 평가대상자에 대한 자료를 삭제시 오류")
			RollBack Using sqlca ;
			Return
		End If
		
		// 평가 대상자 생성
		INSERT INTO YGDB.HYD401T
		SELECT :is_evl_year, MEMBER_NO, :is_evl_str, :is_evl_end, GWA, UP_BOJIK_DATE, JIKWI_CODE, :is_aft_jikwi_code, 'Y', :gs_empCode, NULL, sysdate, :gs_empCode, NULL, sysdate
		FROM INDB.HIN001M
		WHERE JIKWI_CODE = to_number(:is_jikwi_code)
		AND JAEJIK_OPT = 1 
		AND NVL(UP_BOJIK_DATE, HAKWONHIRE_DATE) <= :is_evl_str
		USING SQLCA ;
		
		If Sqlca.Sqlcode < 0 Then
			MessageBox("확인","평가 대상자 생성시 오류발생")
			RollBack Using Sqlca ;
		Else
			Commit Using Sqlca ;
			MessageBox("확인","평가 대상자 생성완료")
		End If
	Else
		Return
	End If
End If
	
end event

on uo_create.destroy
call uo_imgbtn::destroy
end on

