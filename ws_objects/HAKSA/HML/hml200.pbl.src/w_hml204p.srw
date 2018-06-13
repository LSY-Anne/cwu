$PBExportHeader$w_hml204p.srw
$PBExportComments$[w_list] 마일리지집행내역현황
forward
global type w_hml204p from w_window
end type
type dw_main from uo_grid within w_hml204p
end type
type dw_con from uo_dw within w_hml204p
end type
type p_1 from picture within w_hml204p
end type
type st_main from statictext within w_hml204p
end type
end forward

global type w_hml204p from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
end type
global w_hml204p w_hml204p

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

on w_hml204p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
end on

on w_hml204p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )
dw_con.settransobject(sqlca)
dw_con.insertrow(0)

// 초기값 Setup
dw_con.Object.budget_year[dw_con.GetRow()] = func.of_get_sdate( 'yyyy')
//datawindowchild dwc
//Long ll_InsRow
//dw_con.GetChild('gwa',dwc)
//dwc.SetTransObject(SQLCA)
//IF dwc.Retrieve('%') = 0 THEN
//	messagebox('알림','부서코드 입력하시기 바랍니다.')
//	dwc.InsertRow(0)
//ELSE
//	ll_InsRow = dwc.InsertRow(0)
//	dwc.SetItem(ll_InsRow,'gwa','9999')
//	dwc.SetItem(ll_InsRow,'fname','없음')
//	dwc.SetSort('code ASC')
//	dwc.Sort()
//END IF
idw_update[1]	= dw_main

idw_print = dw_main

String ls_member_no

SELECT CODE
INTO :ls_member_no
FROM  CDDB.KCH102D
WHERE UPPER(CODE_GB) = 'HML01'
AND  USE_YN = 'Y'
AND CODE = :gs_empcode
USING SQLCA;

If ls_member_no = gs_empcode Then
	dw_con.object.gwa.protect = 0
Else
	dw_con.object.gwa.protect = 1
	dw_con.object.gwa[dw_con.getrow()] = gs_deptcode
End If

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

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1
end event

type ln_templeft from w_window`ln_templeft within w_hml204p
end type

type ln_tempright from w_window`ln_tempright within w_hml204p
end type

type ln_temptop from w_window`ln_temptop within w_hml204p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hml204p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hml204p
end type

type ln_tempstart from w_window`ln_tempstart within w_hml204p
end type

type uc_retrieve from w_window`uc_retrieve within w_hml204p
end type

type uc_insert from w_window`uc_insert within w_hml204p
end type

type uc_delete from w_window`uc_delete within w_hml204p
end type

type uc_save from w_window`uc_save within w_hml204p
end type

type uc_excel from w_window`uc_excel within w_hml204p
end type

type uc_print from w_window`uc_print within w_hml204p
end type

type st_line1 from w_window`st_line1 within w_hml204p
end type

type st_line2 from w_window`st_line2 within w_hml204p
end type

type st_line3 from w_window`st_line3 within w_hml204p
end type

type uc_excelroad from w_window`uc_excelroad within w_hml204p
end type

type dw_main from uo_grid within w_hml204p
event type long ue_retrieve ( )
integer x = 50
integer y = 296
integer width = 4389
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hml204p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

event type long ue_retrieve();String		ls_budget_year, ls_gwa
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_budget_year = dw_con.object.budget_year[dw_con.GetRow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.GetRow()], '%')
ll_rv = THIS.Retrieve(ls_budget_year, ls_gwa)

RETURN ll_rv

end event

type dw_con from uo_dw within w_hml204p
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hml204p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.SetTransObject(Sqlca)
end event

type p_1 from picture within w_hml204p
boolean visible = false
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean enabled = false
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hml204p
boolean visible = false
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
boolean enabled = false
string text = "main desc"
boolean focusrectangle = false
end type

