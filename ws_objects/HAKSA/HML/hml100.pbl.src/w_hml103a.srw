$PBExportHeader$w_hml103a.srw
$PBExportComments$[w_list] 마일리지 예산승인
forward
global type w_hml103a from w_window
end type
type dw_main from uo_grid within w_hml103a
end type
type dw_con from uo_dw within w_hml103a
end type
type p_1 from picture within w_hml103a
end type
type st_main from statictext within w_hml103a
end type
type uo_approval from u_picture within w_hml103a
end type
type uo_approval_cancle from u_picture within w_hml103a
end type
type uo_all from uo_imgbtn within w_hml103a
end type
type uo_deselect from uo_imgbtn within w_hml103a
end type
end forward

global type w_hml103a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
uo_approval uo_approval
uo_approval_cancle uo_approval_cancle
uo_all uo_all
uo_deselect uo_deselect
end type
global w_hml103a w_hml103a

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

on w_hml103a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.uo_approval=create uo_approval
this.uo_approval_cancle=create uo_approval_cancle
this.uo_all=create uo_all
this.uo_deselect=create uo_deselect
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.uo_approval
this.Control[iCurrent+6]=this.uo_approval_cancle
this.Control[iCurrent+7]=this.uo_all
this.Control[iCurrent+8]=this.uo_deselect
end on

on w_hml103a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.uo_approval)
destroy(this.uo_approval_cancle)
destroy(this.uo_all)
destroy(this.uo_deselect)
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

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_templeft.beginx

If uo_approval.Enabled Then
	uo_approval.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + uo_approval.Width + 16
Else
	uo_approval.Visible	= FALSE
End If

If uo_approval_cancle.Enabled Then
	uo_approval_cancle.X			= ll_stnd_pos 
	ll_stnd_pos			= ll_stnd_pos + uo_approval_cancle.Width + 16
Else
	uo_approval_cancle.Visible	= FALSE
End If


uo_deselect.x = uo_all.x + uo_all.width + 16
end event

type ln_templeft from w_window`ln_templeft within w_hml103a
end type

type ln_tempright from w_window`ln_tempright within w_hml103a
end type

type ln_temptop from w_window`ln_temptop within w_hml103a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hml103a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hml103a
end type

type ln_tempstart from w_window`ln_tempstart within w_hml103a
end type

type uc_retrieve from w_window`uc_retrieve within w_hml103a
end type

type uc_insert from w_window`uc_insert within w_hml103a
end type

type uc_delete from w_window`uc_delete within w_hml103a
end type

type uc_save from w_window`uc_save within w_hml103a
end type

type uc_excel from w_window`uc_excel within w_hml103a
end type

type uc_print from w_window`uc_print within w_hml103a
end type

type st_line1 from w_window`st_line1 within w_hml103a
end type

type st_line2 from w_window`st_line2 within w_hml103a
end type

type st_line3 from w_window`st_line3 within w_hml103a
end type

type uc_excelroad from w_window`uc_excelroad within w_hml103a
end type

type dw_main from uo_grid within w_hml103a
event type long ue_retrieve ( )
integer x = 50
integer y = 392
integer width = 4389
integer height = 1872
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hml103a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

event type long ue_retrieve();String		ls_budget_year, ls_gwa, ls_yn
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_budget_year = dw_con.object.budget_year[dw_con.GetRow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.GetRow()], '%')
ls_yn = dw_con.object.app_yn[dw_con.Getrow()]

If ls_budget_year = '' or isnull(ls_budget_year) Then 
	Messagebox("알림", "예산년도를 입력하세요!")
	RETURN -1
End If

ll_rv = THIS.Retrieve(ls_budget_year, ls_gwa, ls_yn)

RETURN ll_rv

end event

type dw_con from uo_dw within w_hml103a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hml102a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.SetTransObject(Sqlca)
end event

type p_1 from picture within w_hml103a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hml103a
integer x = 114
integer y = 312
integer width = 562
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
string text = "마일리지 예산승인"
boolean focusrectangle = false
end type

type uo_approval from u_picture within w_hml103a
integer x = 1705
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_app.gif"
end type

event clicked;call super::clicked;Long		ll_row
String		ls_budget_year, ls_gwa, ls_point_item, ls_chk
Long		ll_i, ll_rowcnt, ll_find

//ll_row = dw_main.GetRow()
//If ll_row <= 0 Then RETURN -1

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_budget_year = dw_con.object.budget_year[dw_con.GetRow()]
ls_gwa = trim(dw_con.object.gwa[dw_con.GetRow()])

ll_rowcnt = dw_main.rowcount()

dw_main.accepttext()
for ll_i = 1 to ll_rowcnt
	ls_chk = dw_main.object.chk[ll_i]
	ls_point_item = dw_main.object.point_item[ll_i]
	if ls_chk = 'Y' then 
		dw_main.object.fix_yn[ll_i] = 'Y'
		//dw_main.object.approval_point[ll_i] = dw_main.object.assign_point[ll_i]
	end if

next 

parent.event ue_save()

end event

type uo_approval_cancle from u_picture within w_hml103a
integer x = 2016
integer y = 40
integer width = 393
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_appcancle.gif"
end type

event clicked;call super::clicked;Long		ll_row
String		ls_budget_year, ls_gwa, ls_point_item, ls_chk
Long		ll_i, ll_rowcnt, ll_find

//ll_row = dw_main.GetRow()
//If ll_row <= 0 Then RETURN -1

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_budget_year = dw_con.object.budget_year[dw_con.GetRow()]
ls_gwa = trim(dw_con.object.gwa[dw_con.GetRow()])

ll_rowcnt = dw_main.rowcount()
for ll_i = 1 to ll_rowcnt
	ls_chk = dw_main.object.chk[ll_i]
	ls_point_item = dw_main.object.point_item[ll_i]
	if ls_chk = 'Y' then 
		dw_main.object.fix_yn[ll_i] = 'N'
		//dw_main.object.approval_point[ll_i] = 0
		
	end if

next 

parent.event ue_save()

end event

type uo_all from uo_imgbtn within w_hml103a
integer x = 718
integer y = 300
integer taborder = 20
boolean bringtotop = true
string btnname = "전체선택"
end type

event clicked;call super::clicked;Long ll_row


If dw_main.rowcount() = 0 Then return 

For ll_row = 1 To dw_main.rowcount()
	dw_main.object.chk[ll_row] = 'Y'
Next
end event

on uo_all.destroy
call uo_imgbtn::destroy
end on

type uo_deselect from uo_imgbtn within w_hml103a
integer x = 1152
integer y = 300
integer taborder = 30
boolean bringtotop = true
string btnname = "전체선택해제"
end type

on uo_deselect.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;Long ll_row


If dw_main.rowcount() = 0 Then return 

For ll_row = 1 To dw_main.rowcount()
	dw_main.object.chk[ll_row] = 'N'
Next
end event

