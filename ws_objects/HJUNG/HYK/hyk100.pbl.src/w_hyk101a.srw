$PBExportHeader$w_hyk101a.srw
$PBExportComments$[w_list] 평가영역 반영비율 등록
forward
global type w_hyk101a from w_window
end type
type dw_main from uo_grid within w_hyk101a
end type
type dw_con from uo_dw within w_hyk101a
end type
type p_1 from picture within w_hyk101a
end type
type st_main from statictext within w_hyk101a
end type
end forward

global type w_hyk101a from w_window
boolean visible = false
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
end type
global w_hyk101a w_hyk101a

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

on w_hyk101a.create
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

on w_hyk101a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)

Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'appoint_gb')  //임용구분
lvc_data.setProperty('key1', 'HYK02')
lvc_data.setProperty('column2', 'evl_area')  //평가영역
lvc_data.setProperty('key2', 'HYK01')
func.of_dddw( dw_main,lvc_data)

idw_update[1]	= dw_main

this.post event ue_inquiry()	
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

type ln_templeft from w_window`ln_templeft within w_hyk101a
end type

type ln_tempright from w_window`ln_tempright within w_hyk101a
end type

type ln_temptop from w_window`ln_temptop within w_hyk101a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hyk101a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hyk101a
end type

type ln_tempstart from w_window`ln_tempstart within w_hyk101a
end type

type uc_retrieve from w_window`uc_retrieve within w_hyk101a
end type

type uc_insert from w_window`uc_insert within w_hyk101a
end type

type uc_delete from w_window`uc_delete within w_hyk101a
end type

type uc_save from w_window`uc_save within w_hyk101a
end type

type uc_excel from w_window`uc_excel within w_hyk101a
end type

type uc_print from w_window`uc_print within w_hyk101a
end type

type st_line1 from w_window`st_line1 within w_hyk101a
end type

type st_line2 from w_window`st_line2 within w_hyk101a
end type

type st_line3 from w_window`st_line3 within w_hyk101a
end type

type uc_excelroad from w_window`uc_excelroad within w_hyk101a
end type

type dw_main from uo_grid within w_hyk101a
event type long ue_retrieve ( )
integer x = 50
integer y = 164
integer width = 4389
integer height = 2100
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyk101a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

event type long ue_retrieve();String		ls_arg1
String		ls_arg2
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

//ls_arg1 = dw_con.object.arg1[dw_con.GetRow()]
//ls_arg2 = dw_con.object.arg2[dw_con.GetRow()]

ll_rv = THIS.Retrieve(ls_arg1, ls_arg2)

RETURN ll_rv

end event

type dw_con from uo_dw within w_hyk101a
boolean visible = false
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type p_1 from picture within w_hyk101a
boolean visible = false
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hyk101a
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
string text = "main desc"
boolean focusrectangle = false
end type

