$PBExportHeader$w_hpa416p.srw
$PBExportComments$납부비교명세서
forward
global type w_hpa416p from w_print_form3
end type
end forward

global type w_hpa416p from w_print_form3
end type
global w_hpa416p w_hpa416p

forward prototypes
public function integer wf_retrieve ()
end prototypes

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================
String ls_year , ls_jikjong_code
Integer	li_str_jikjong, li_end_jikjong
dw_con.accepttext()
ls_year = string(dw_con.object.year[1], 'yyyy')
ls_jikjong_code = trim(dw_con.object.jikjong_code[1])

if isnull(ls_jikjong_code) or trim(ls_jikjong_code) = '0' or trim(ls_jikjong_code) = '' then	
			li_str_jikjong	=	0
			li_end_jikjong	=	9
		else
			li_str_jikjong = integer(trim(ls_jikjong_code))
			li_end_jikjong = integer(trim(ls_jikjong_code))
		end if


dw_print.settransobject(sqlca)
dw_print.object.datawindow.print.preview = 'yes'
string ls_jaejik

if dw_print.retrieve(ls_year, li_str_jikjong, li_end_jikjong) > 0 then

else
	dw_print.reset()
end if

return 0
end function

on w_hpa416p.create
int iCurrent
call super::create
end on

on w_hpa416p.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//wf_SetMenu('FIRST', 	TRUE)
//wf_SetMenu('NEXT', 	TRUE)
//wf_SetMenu('PRE', 	TRUE)
//wf_SetMenu('LAST', 	TRUE)
//
end event

event ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//IF dw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, dw_print)
//

Datawindow 	ldw
Vector			lvc_print

lvc_print = Create Vector

If UpperBound(idw_toexcel) = 0 And idw_print = ldw Then
	MessageBox("알림", "출력할 자료가 없습니다.")
Else
	If This.Event ue_printStart(lvc_print) = -1 Then
		Return
	Else
		// 인쇄를 하기전에 해당 인쇄를 하고자 하는 사유를 확인한다.
		OpenWithParm(w_print_reason, gs_pgmid)
		If Message.Longparm < 0 Then
			Return
		Else
				OpenWithParm(w_print_preview, lvc_print)
		End If
	End If
End If


end event

event ue_prior;call super::ue_prior;dw_print.scrollnextpage()
end event

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

event ue_next;call super::ue_next;dw_print.scrollpriorpage()
end event

event ue_last;call super::ue_last;dw_print.scrolltorow(dw_print.rowcount())
end event

event ue_first;call super::ue_first;dw_print.scrolltorow(1)
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc_temp

dw_con.GetChild('jikjong_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
	wf_setmsg('공통코드[직종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF


dw_con.Object.jikjong_code[1] = ''
dw_con.Object.jikjong_code.dddw.PercentWidth = 100
idw_print = dw_print
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "납부비교명세서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_print_form3`ln_templeft within w_hpa416p
end type

type ln_tempright from w_print_form3`ln_tempright within w_hpa416p
end type

type ln_temptop from w_print_form3`ln_temptop within w_hpa416p
end type

type ln_tempbuttom from w_print_form3`ln_tempbuttom within w_hpa416p
end type

type ln_tempbutton from w_print_form3`ln_tempbutton within w_hpa416p
end type

type ln_tempstart from w_print_form3`ln_tempstart within w_hpa416p
end type

type uc_retrieve from w_print_form3`uc_retrieve within w_hpa416p
end type

type uc_insert from w_print_form3`uc_insert within w_hpa416p
end type

type uc_delete from w_print_form3`uc_delete within w_hpa416p
end type

type uc_save from w_print_form3`uc_save within w_hpa416p
end type

type uc_excel from w_print_form3`uc_excel within w_hpa416p
end type

type uc_print from w_print_form3`uc_print within w_hpa416p
end type

type st_line1 from w_print_form3`st_line1 within w_hpa416p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_print_form3`st_line2 within w_hpa416p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_print_form3`st_line3 within w_hpa416p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_print_form3`uc_excelroad within w_hpa416p
end type

type ln_dwcon from w_print_form3`ln_dwcon within w_hpa416p
end type

type uo_year from w_print_form3`uo_year within w_hpa416p
boolean visible = false
integer x = 46
long backcolor = 1073741824
end type

type gb_3 from w_print_form3`gb_3 within w_hpa416p
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type dw_print from w_print_form3`dw_print within w_hpa416p
string dataobject = "d_hpa416p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_1 from w_print_form3`st_1 within w_hpa416p
boolean visible = false
integer x = 1285
integer y = 64
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type dw_head from w_print_form3`dw_head within w_hpa416p
boolean visible = false
integer x = 1842
integer y = 68
integer width = 773
integer height = 156
end type

type uo_dept_code from w_print_form3`uo_dept_code within w_hpa416p
boolean visible = false
integer x = 2281
integer y = 40
long backcolor = 1073741824
end type

type st_2 from w_print_form3`st_2 within w_hpa416p
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_3 from w_print_form3`st_3 within w_hpa416p
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type dw_con from w_print_form3`dw_con within w_hpa416p
string dataobject = "d_hpa416p_con"
end type

event dw_con::constructor;call super::constructor;This.object.year[1]	= date(string(integer(left(String(f_today(), '@@@@/@@/@@'), 4)) - 1) + '/01/01')


end event

event dw_con::itemchanged;call super::itemchanged;accepttext()
Choose Case dwo.name
//	Case 'year'
//		is_year = String(left(data, 4))
//		is_bef_year = string(integer(is_year) - 1)
//	Case 'jikjong_code'
//		if isnull(data) or trim(data) = '0' or trim(data) = '' then	
//			ii_str_jikjong	=	0
//			ii_end_jikjong	=	9
//		else
//			ii_str_jikjong = integer(trim(data))
//			ii_end_jikjong = integer(trim(data))
//		end if
	Case 'jaejik_opt'
		If data = '%' Then	
			dw_print.dataobject = 'd_hpa416p_1'
		Elseif data = '1' Then
			dw_print.dataobject = 'd_hpa416p_2'
			
		Else
			dw_print.dataobject = 'd_hpa416p_3'
		End If
			dw_print.SetTransobject(sqlca)
			

End Choose
end event

