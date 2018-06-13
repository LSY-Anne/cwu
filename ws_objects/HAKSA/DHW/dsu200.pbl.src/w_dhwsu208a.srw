$PBExportHeader$w_dhwsu208a.srw
$PBExportComments$[대학원수업] 대체강의신청
forward
global type w_dhwsu208a from w_window
end type
type dw_main from uo_grid within w_dhwsu208a
end type
type dw_con from uo_dw within w_dhwsu208a
end type
type dw_list from uo_grid within w_dhwsu208a
end type
end forward

global type w_dhwsu208a from w_window
string title = "[대학원수업] 대체강의신청"
event type long ue_row_updatequery ( )
dw_main dw_main
dw_con dw_con
dw_list dw_list
end type
global w_dhwsu208a w_dhwsu208a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE

end variables

on w_dhwsu208a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_list
end on

on w_dhwsu208a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.dw_list)
end on

event ue_postopen;call super::ue_postopen;String	ls_year, ls_hakgi

func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )
dw_con.settransobject(sqlca)
dw_con.insertrow(0)

idw_update[1]	= dw_main

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi 

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

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = This.Event ue_updatequery() 
If ll_rv <> 1 And ll_rv <> 2 Then RETURN -1

SetPointer(HourGlass!)
If ib_retrieve_wait Then
	gf_openwait()
End If
ll_rv = dw_list.Event ue_Retrieve()
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

type ln_templeft from w_window`ln_templeft within w_dhwsu208a
end type

type ln_tempright from w_window`ln_tempright within w_dhwsu208a
end type

type ln_temptop from w_window`ln_temptop within w_dhwsu208a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_dhwsu208a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_dhwsu208a
end type

type ln_tempstart from w_window`ln_tempstart within w_dhwsu208a
end type

type uc_retrieve from w_window`uc_retrieve within w_dhwsu208a
end type

type uc_insert from w_window`uc_insert within w_dhwsu208a
end type

type uc_delete from w_window`uc_delete within w_dhwsu208a
end type

type uc_save from w_window`uc_save within w_dhwsu208a
end type

type uc_excel from w_window`uc_excel within w_dhwsu208a
end type

type uc_print from w_window`uc_print within w_dhwsu208a
end type

type st_line1 from w_window`st_line1 within w_dhwsu208a
end type

type st_line2 from w_window`st_line2 within w_dhwsu208a
end type

type st_line3 from w_window`st_line3 within w_dhwsu208a
end type

type uc_excelroad from w_window`uc_excelroad within w_dhwsu208a
end type

type dw_main from uo_grid within w_dhwsu208a
event type long ue_retrieve ( )
integer x = 1874
integer y = 292
integer width = 2555
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwsu208a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event doubleclicked;call super::doubleclicked;Int       li_rtn
String  ls_status

If row < 1 Then Return ;

ls_status = This.Object.status[row]
If ls_status = 'R' Then
	li_rtn = Messagebox('삭제확인', '삭제하시겠습니까?', StopSign!, YesNo! )
	
	If li_rtn = 2 Then Return -1 ;
	
	This.Deleterow(row)
	
	Commit Using sqlca ;
	
Else
	This.Deleterow(row)
End If
end event

type dw_con from uo_dw within w_dhwsu208a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwsu208a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_list from uo_grid within w_dhwsu208a
event type long ue_retrieve ( )
integer x = 50
integer y = 292
integer width = 1810
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dhwsu208a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_year, ls_hakgi, ls_prof
Long		ll_rv,          ll_row

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ll_row = dw_con.GetRow()

ls_year   = dw_con.Object.year[ll_row]
ls_hakgi  = dw_con.Object.hakgi[ll_row]
ls_prof   = dw_con.Object.prof_no[ll_row]

If ls_prof = '' Or Isnull(ls_prof) Then
	Messagebox('확인', '교수를 선택하세요')
	dw_con.SetFocus()
	dw_con.SetColumn("prof_no")
	Return -1
End If

ll_rv = This.Retrieve(ls_year, ls_hakgi, ls_prof)

RETURN ll_rv

end event

event doubleclicked;call super::doubleclicked;String	ls_year, ls_hakgi, ls_member_no, ls_gwamok_id, ls_gwajung_id, ls_gwa_id
Long  ll_irow

If row <= 0 Then Return ;

ls_year			=	This.object.year[row]
ls_hakgi			=	This.object.hakgi[row]
ls_gwajung_id  =	This.object.gwajung_id[row]
ls_gwa_id        =  This.object.gwa_id[row]
ls_gwamok_id	=  This.object.gwamok_id[row]
ls_member_no	=  This.object.member_no[row]

ll_irow = dw_main.InsertRow(0)

dw_main.Object.year[ll_irow]           = ls_year
dw_main.Object.hakgi[ll_irow]          = ls_hakgi
dw_main.Object.gwajung_id[ll_irow] = ls_gwajung_id
dw_main.Object.gwa_id[ll_irow]        = ls_gwa_id
dw_main.Object.gwamok_id[ll_irow]  = ls_gwamok_id
dw_main.Object.member_no[ll_irow] = ls_member_no

dw_main.SetFocus()
dw_main.ScrollTorow(ll_irow)
dw_main.SetColumn("daeche_gwamok_id")



end event

event rowfocuschanged;call super::rowfocuschanged;String	ls_year, ls_hakgi, ls_member_no, ls_gwamok_id, ls_gwajung_id, ls_gwa_id

If This.Getrow() <= 0 Then Return ;

ls_year			=	This.object.year[currentrow]
ls_hakgi			=	This.object.hakgi[currentrow]
ls_gwajung_id  =	This.object.gwajung_id[currentrow]
ls_gwa_id        =  This.object.gwa_id[currentrow]
ls_gwamok_id	=  This.object.gwamok_id[currentrow]
ls_member_no	=  This.object.member_no[currentrow]

dw_main.retrieve(ls_year,	ls_hakgi, ls_gwajung_id, ls_gwa_id, ls_gwamok_id, ls_member_no)

end event

