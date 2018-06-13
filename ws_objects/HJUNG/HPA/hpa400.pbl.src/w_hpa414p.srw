$PBExportHeader$w_hpa414p.srw
$PBExportComments$new원천징수영수증일괄출력
forward
global type w_hpa414p from w_window
end type
type dw_con from uo_dw within w_hpa414p
end type
type dw_main from uo_dw within w_hpa414p
end type
type st_main from statictext within w_hpa414p
end type
type p_1 from picture within w_hpa414p
end type
end forward

global type w_hpa414p from w_window
dw_con dw_con
dw_main dw_main
st_main st_main
p_1 p_1
end type
global w_hpa414p w_hpa414p

on w_hpa414p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
this.st_main=create st_main
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.st_main
this.Control[iCurrent+4]=this.p_1
end on

on w_hpa414p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.st_main)
destroy(this.p_1)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_dw( dw_con )
//func.of_design_dw( dw_main )

dw_con.insertrow(0)


datawindowchild ldwc_Temp
Long ll_insrow


dw_con.GetChild('jikjong_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
	messagebox('알림', '공통코드[직종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF

String ls_year
ls_year = left(f_today(), 4)
ls_year = STring(long(ls_year) - 1)
dw_con.object.year[1] = ls_year
idw_print = dw_main

//idw_update[1]	= dw_main
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_main

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

event ue_print;//
Vector			lvc_print

		lvc_print = Create Vector
	
		If this.Event ue_printStart(lvc_print) = -1 Then
			Return
		Else
			// 인쇄를 하기전에 해당 인쇄를 하고자 하는 사유를 확인한다.
			OpenWithParm(w_print_reason, gs_pgmid)
			If Message.Longparm <= 0 Then
				Return
			Else
					OpenWithParm(w_print_preview, lvc_print)
			End If
		End If

end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "근로소득원천징수영수증")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_window`ln_templeft within w_hpa414p
end type

type ln_tempright from w_window`ln_tempright within w_hpa414p
end type

type ln_temptop from w_window`ln_temptop within w_hpa414p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hpa414p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hpa414p
end type

type ln_tempstart from w_window`ln_tempstart within w_hpa414p
end type

type uc_retrieve from w_window`uc_retrieve within w_hpa414p
end type

type uc_insert from w_window`uc_insert within w_hpa414p
end type

type uc_delete from w_window`uc_delete within w_hpa414p
end type

type uc_save from w_window`uc_save within w_hpa414p
end type

type uc_excel from w_window`uc_excel within w_hpa414p
end type

type uc_print from w_window`uc_print within w_hpa414p
end type

type st_line1 from w_window`st_line1 within w_hpa414p
end type

type st_line2 from w_window`st_line2 within w_hpa414p
end type

type st_line3 from w_window`st_line3 within w_hpa414p
end type

type uc_excelroad from w_window`uc_excelroad within w_hpa414p
end type

type dw_con from uo_dw within w_hpa414p
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa413a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
s_insa_com	lstr_com
String		ls_KName, ls_member_no
This.accepttext()
ls_KName =  trim(this.object.kor_name[1])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = ''//교직원구분

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kor_name')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.kor_name[1]        = ls_kname					//성명
This.object.member_no[1]     = ls_Member_No				//개인번호
End If
end event

event itemchanged;call super::itemchanged;
//uo_hirfunc	lvc_hirfunc
//vector		lvc_data
String		ls_h01nno	,ls_h01knm

//lvc_data		= create vector
//lvc_hirfunc	= create	uo_hirfunc
This.accepttext()
Choose Case	dwo.name
	Case	'member_no','kor_name'
		If dwo.name = 'member_no' Then	ls_h01nno = data
		If dwo.name = 'kor_name' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
			This.Post SetItem(row, 'kor_name'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_h01nno , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_h01nno || '%'
		OR NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.member_no[row] = ls_h01nno
			This.object.kor_name[row] = ls_h01knm
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			
		End If	
		
	

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

type dw_main from uo_dw within w_hpa414p
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 1844
integer taborder = 11
string dataobject = "d_hpa412a_2_2009"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event type long ue_retrieve();Long ll_rv, ll_row, ll_i
String ls_year, ls_dept_fr, ls_dept_to, ls_k, ls_nno, ls_gu, ls_mm

dw_con.Accepttext()
ll_row = dw_con.Getrow()

ls_year = left(trim(dw_con.GetitemString(ll_row, 'year')), 4)
ls_dept_fr = func.of_nvl( dw_con.GetItemString(ll_row , 'jikjong_code') , '0' )	//부서fr

ls_dept_to		=	func.of_nvl( dw_con.GetItemString(ll_row , 'jikjong_code') , '9') 	//부서to
ls_nno = func.of_nvl(dw_con.GetitemSTring(ll_row, 'member_no'), '') //사번
ls_gu = dw_con.GetitemSTring(ll_row, 'gu')
//ls_mm = dw_con.GetitemString(ll_row, 'mm') //퇴직월

If ls_nno  = '' Or isnull(ls_nno) Then ls_nno  = '%'

If ls_dept_fr = '' Or isnull(ls_dept_fr) Then
	ls_dept_fr = '0'
	ls_dept_to = '9'
	//Messagebox("알림", "부서코드를 입력하세요!")
	//RETURN -1
End If
//
//If ls_dept_to = '' Or isnull(ls_dept_to) Then
//	Messagebox("알림", "부서코드(to)를 입력하세요!")
//	RETURN -1
//End If
//	
//If ls_dept_Fr > ls_dept_to Then
//	Messagebox("알림", "부서 범위를 확인하세요!")
//	RETURN -1
//End IF

//dw_main.setfilter('')
//dw_main.filter()
ll_rv = dw_main.retrieve(ls_year, ls_nno, ls_dept_fr, ls_dept_to, ls_gu)

//If ll_rv > 0 Then
//	If ls_gu <> 'J' Then
//		If ls_mm <> '%' Then
//			dw_main.setfilter("p46gbn = 'J' or (p46gbn = 'T' AND left(cjedt, 6) = '" + ls_year + ls_mm + "')")
//			dw_main.filter()
//			ll_rv = dw_main.FilteredCount()
//		End If
//	End If
//End If


RETURN ll_rv


end event

type st_main from statictext within w_hpa414p
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
string text = "원천징수영수증"
boolean focusrectangle = false
end type

type p_1 from picture within w_hpa414p
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

