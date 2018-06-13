$PBExportHeader$w_hsg103a.srw
$PBExportComments$[w_list] 연도학기정의
forward
global type w_hsg103a from w_window
end type
type dw_main from uo_grid within w_hsg103a
end type
type dw_con from uo_dw within w_hsg103a
end type
type p_1 from picture within w_hsg103a
end type
type st_main from statictext within w_hsg103a
end type
type st_1 from statictext within w_hsg103a
end type
end forward

global type w_hsg103a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
st_1 st_1
end type
global w_hsg103a w_hsg103a

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

on w_hsg103a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.st_1
end on

on w_hsg103a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)

idw_update[1]	= dw_main

Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'hakgi')  //학기
lvc_data.setProperty('key1', 'HSG01')
func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)

dw_con.object.year[dw_con.getrow()] = func.of_get_sdate('yyyy')

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

type ln_templeft from w_window`ln_templeft within w_hsg103a
end type

type ln_tempright from w_window`ln_tempright within w_hsg103a
end type

type ln_temptop from w_window`ln_temptop within w_hsg103a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hsg103a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hsg103a
end type

type ln_tempstart from w_window`ln_tempstart within w_hsg103a
end type

type uc_retrieve from w_window`uc_retrieve within w_hsg103a
end type

type uc_insert from w_window`uc_insert within w_hsg103a
end type

type uc_delete from w_window`uc_delete within w_hsg103a
end type

type uc_save from w_window`uc_save within w_hsg103a
end type

type uc_excel from w_window`uc_excel within w_hsg103a
end type

type uc_print from w_window`uc_print within w_hsg103a
end type

type st_line1 from w_window`st_line1 within w_hsg103a
end type

type st_line2 from w_window`st_line2 within w_hsg103a
end type

type st_line3 from w_window`st_line3 within w_hsg103a
end type

type uc_excelroad from w_window`uc_excelroad within w_hsg103a
end type

type dw_main from uo_grid within w_hsg103a
event type long ue_retrieve ( )
integer x = 46
integer y = 396
integer width = 4389
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg103a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_rv
string     ls_year, ls_hakgi

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.year[dw_con.GetRow()]
ls_hakgi = func.of_nvl(dw_con.object.hakgi[dw_con.GetRow()], '%')

IF isnull(ls_year) OR ls_year = '' THEN
	messagebox("조회", '년도를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

IF isnull(ls_hakgi) OR ls_hakgi = '' THEN
	ls_hakgi = '%'
END IF

ll_rv = THIS.Retrieve(ls_year, ls_hakgi)

RETURN ll_rv

end event

event ue_deletestart;call super::ue_deletestart;string ls_year, ls_hakgi
long ll_cnt, ll_cnt1, cnt

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.year[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.GetRow()]

SELECT COUNT(*) 
into :ll_cnt
FROM HAKSA.SUM120TL 
WHERE YEAR = :ls_year
AND HAKGI = :ls_hakgi
using sqlca;

SELECT COUNT(*) 
into :ll_cnt1
FROM HAKSA.SUM130TL 
WHERE YEAR = :ls_year
AND HAKGI = :ls_hakgi
using sqlca;

cnt = ll_cnt + ll_cnt1
if ll_cnt + ll_cnt1 > 0 then 

 if   MessageBox("알림", "상담내역이 있습니다. 삭제하시겠습니까?",    Exclamation!, YesNo! , 2) = 2 then 	return -1
	
DELETE
FROM HAKSA.SUM120TL 
WHERE YEAR = :ls_year
AND HAKGI = :ls_hakgi
using sqlca;

IF SQLCA.SQLCODE <> 0 THEN
	ROLLBACK USING SQLCA;
	 MessageBox("알림", "SUM120TL를 삭제하는 도중 에러가 발생했습니다.")
	 RETURN -1
END IF

DELETE
FROM HAKSA.SUM130TL 
WHERE YEAR = :ls_year
AND HAKGI = :ls_hakgi
using sqlca;

IF SQLCA.SQLCODE <> 0 THEN
	ROLLBACK USING SQLCA;
	 MessageBox("알림", "SUM130TL를 삭제하는 도중 에러가 발생했습니다.")
	 RETURN -1
END IF

	
end if


return 1
end event

type dw_con from uo_dw within w_hsg103a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg103a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type p_1 from picture within w_hsg103a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hsg103a
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
string text = "연도학기 정의내역"
boolean focusrectangle = false
end type

type st_1 from statictext within w_hsg103a
integer x = 2313
integer y = 316
integer width = 2121
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "사용학기를 선택하시면 해당 선택한 학기가 모든화면의 기본값으로 띄워집니다."
boolean focusrectangle = false
end type

