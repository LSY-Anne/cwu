$PBExportHeader$w_hsg116a.srw
$PBExportComments$[w_list_tab] 집단상담및프로그램결과등록
forward
global type w_hsg116a from w_window
end type
type dw_list from uo_grid within w_hsg116a
end type
type dw_con from uo_dw within w_hsg116a
end type
type tab_1 from tab within w_hsg116a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_tab1 from uo_dw within tabpage_1
end type
type st_tab1_line from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_tab1 dw_tab1
st_tab1_line st_tab1_line
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tab2 from uo_grid within tabpage_2
end type
type st_tab2_line from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_tab2 dw_tab2
st_tab2_line st_tab2_line
end type
type tabpage_3 from userobject within tab_1
end type
type dw_tab3 from uo_dw within tabpage_3
end type
type st_tab3_line from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_tab3 dw_tab3
st_tab3_line st_tab3_line
end type
type tab_1 from tab within w_hsg116a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type uo_1 from u_tab within w_hsg116a
end type
type p_1 from picture within w_hsg116a
end type
type st_main from statictext within w_hsg116a
end type
type p_2 from picture within w_hsg116a
end type
type st_detail from statictext within w_hsg116a
end type
type uc_row_insert from u_picture within w_hsg116a
end type
type uc_row_delete from u_picture within w_hsg116a
end type
end forward

global type w_hsg116a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
tab_1 tab_1
uo_1 uo_1
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
end type
global w_hsg116a w_hsg116a

type variables
Long				il_rv
Long				il_ret
DataWindow	idw_tab[]
Boolean			ib_list_chk	=	FALSE

end variables

forward prototypes
public function integer wf_validall ()
end prototypes

event type long ue_row_updatequery();Long				ll_rv
Long				ll_cnt = 0
Long				ll_i
DataWindow	ldw_modified[]
Long				ll_dw_cnt

If Not uc_save.Enabled Then RETURN 1

If UpperBound(idw_modified) = 0 Then
	ldw_modified = idw_update
Else
	ldw_modified = idw_modified
End If

ll_dw_cnt = UpperBound(ldw_modified)

For ll_i = 1 To ll_dw_cnt
	If ib_list_chk	=	FALSE and ldw_modified[ll_i] = dw_list Then Continue
	ldw_modified[ll_i].AcceptText()
//	ll_cnt += ldw_modified[ll_i].uf_ModifiedCount()
	ll_cnt += (ldw_modified[ll_i].ModifiedCount() + ldw_modified[ll_i].DeletedCount())
Next

If ll_cnt > 0 Then
	ll_rv = gf_message(parentwin, 2, '0007', '', '')
	Choose Case ll_rv
		Case 1
			If This.Event ue_save() = 1 Then 
				RETURN 1
			Else
				RETURN -1
			End IF
		Case 2
			If ib_updatequery_resetupdate Then
				ll_cnt = UpperBound(idw_update)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_update[ll_i] = dw_list Then Continue
					idw_update[ll_i].resetUpdate()
				Next
				ll_cnt = UpperBound(idw_modified)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_modified[ll_i] = dw_list Then Continue
					idw_modified[ll_i].resetUpdate()
				Next
			End If
			RETURN 2			
		Case 3
			RETURN 3
	End Choose 	
Else
	RETURN 1
End If

RETURN 1

end event

public function integer wf_validall ();//Integer	li_rtn, i
//
//For I = 1 To UpperBound(idw_update)
//	If func.of_checknull(idw_update[i]) = -1 Then
//		Return -1
//	End If
//Next
//
return 1
end function

on w_hsg116a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.tab_1=create tab_1
this.uo_1=create uo_1
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.st_main
this.Control[iCurrent+7]=this.p_2
this.Control[iCurrent+8]=this.st_detail
this.Control[iCurrent+9]=this.uc_row_insert
this.Control[iCurrent+10]=this.uc_row_delete
end on

on w_hsg116a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_list )


//This.Event ue_resize_dw( tab_1.tabpage_1.st_tab1_line, tab_1.tabpage_1.dw_tab1 )
//This.Event ue_resize_dw( tab_1.tabpage_2.st_tab2_line, tab_1.tabpage_2.dw_tab2 )
//This.Event ue_resize_dw( tab_1.tabpage_3.st_tab3_line, tab_1.tabpage_3.dw_tab3 )
//만일 dw_tab1, dw_tab2, dw_tab3가 Single Row이면 uo_dw를 사용하여
//dw_tab1, dw_tab2, dw_tab3를 만들고
func.of_design_dw( tab_1.tabpage_1.dw_tab1 )
//func.of_design_dw( tab_1.tabpage_2.dw_tab2 )
func.of_design_dw( tab_1.tabpage_3.dw_tab3 )

dw_con.insertrow(0)
tab_1.tabpage_1.dw_tab1.insertrow(0)
//tab_1.tabpage_2.dw_tab2.insertrow(0)
tab_1.tabpage_3.dw_tab3.insertrow(0)
idw_update[1]	= tab_1.tabpage_1.dw_tab1
idw_update[2]	= tab_1.tabpage_2.dw_tab2
//idw_update[3]	= tab_1.tabpage_3.dw_tab3
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= tab_1.tabpage_1.dw_tab1
//idw_Toexcel[3]	= tab_1.tabpage_2.dw_tab2
//idw_Toexcel[4]	= tab_1.tabpage_3.dw_tab3

idw_tab[1] = tab_1.tabpage_1.dw_tab1
idw_tab[2] = tab_1.tabpage_2.dw_tab2
idw_tab[3] = tab_1.tabpage_3.dw_tab3

tab_1.tabpage_1.dw_tab1.iw_parent = This
tab_1.tabpage_2.dw_tab2.iw_parent = This
tab_1.tabpage_3.dw_tab3.iw_parent = This

//tab_1.tabpage_1.dw_tab1.Width	= tab_1.Width	- 60
//tab_1.tabpage_2.dw_tab2.Width	= tab_1.Width	- 60
//tab_1.tabpage_3.dw_tab3.Width	= tab_1.Width	- 60
//tab_1.tabpage_1.dw_tab1.Height	= tab_1.Height	- 144
//tab_1.tabpage_2.dw_tab2.Height	= tab_1.Height	- 144
//tab_1.tabpage_3.dw_tab3.Height	= tab_1.Height	- 144
//tab_1.tabpage_1.dw_tab1.width = 4370
//tab_1.tabpage_1.dw_tab1.height = 1108
//tab_1.tabpage_2.dw_tab2.width = 4352
//tab_1.tabpage_2.dw_tab2.height = 1108
//tab_1.tabpage_3.dw_tab3.width = 3552
//tab_1.tabpage_3.dw_tab3.height = 1104


//dw_con.object.hakyear[dw_con.getrow()] = func.of_get_sdate('yyyy')
//dw_con.object.fr_dt[dw_con.getrow()] = func.of_get_sdate('yyyymm') + '01'
//dw_con.object.to_dt[dw_con.getrow()] = func.of_get_sdate('yyyymmdd')


Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'hakgi')  //학기
lvc_data.setProperty('key1', 'HSG01')
lvc_data.setProperty('column2', 'pgm_tp')  //프로그램구분
lvc_data.setProperty('key2', 'SUM11')
func.of_dddw( dw_con,lvc_data)

lvc_data.setProperty('column1', 'pgm_tp')  //프로그램구분
lvc_data.setProperty('key1', 'SUM11')
lvc_data.setProperty('column2', 'pgm_cd')  //프로그램명
lvc_data.setProperty('key2', 'SUM24')
lvc_data.setProperty('column3', 'member_gb')  //담당구분
lvc_data.setProperty('key3', 'SUM31')
func.of_dddw( tab_1.tabpage_1.dw_tab1,lvc_data)



lvc_data.setProperty('column1', 'purpose')  //찾은목적
lvc_data.setProperty('key1', 'SUM02')
lvc_data.setProperty('column2', 'case_tp')  //상담구분
lvc_data.setProperty('key2', 'SUM05')
lvc_data.setProperty('column3', 'monthod')  //찾아온경위
lvc_data.setProperty('key3', 'SUM06')
lvc_data.setProperty('column4', 'member_gb')  //담당구분
lvc_data.setProperty('key4', 'SUM31')
lvc_data.setProperty('column5', 'pgm_tp')  //프로그램구분
lvc_data.setProperty('key5', 'SUM11')
lvc_data.setProperty('column6', 'pgm_cd')  //프로그램명
lvc_data.setProperty('key6', 'SUM24')
func.of_dddw( tab_1.tabpage_3.dw_tab3,lvc_data)

String ls_year, ls_hakgi, ls_str, ls_end
uo_hsfunc hsfunc

hsfunc = Create uo_hsfunc
// 초기 Value Setup - 해당 상담관리에서 사용하는 최종 연도및학기를 확인한다.
hsfunc.of_get_yearhakgi('SUM', lvc_data)

ls_year = lvc_data.GetProperty('year')
ls_hakgi = lvc_data.GetProperty('hakgi')
ls_str = lvc_data.GetProperty('hakgi_str')
ls_end = lvc_data.GetProperty('hakgi_end')

If ls_year = '' Or IsNull(ls_year) Then
	dw_con.object.hakyear[dw_con.getrow()] = func.of_get_sdate('yyyy')
	dw_con.object.fr_dt[dw_con.getrow()] = func.of_get_sdate('yyyymm') + '01'
	dw_con.object.to_dt[dw_con.getrow()] = func.of_get_sdate('yyyymmdd')
Else
	dw_con.object.hakyear[dw_con.getrow()] = ls_year
	dw_con.Object.hakgi[dw_con.getrow()] = ls_hakgi
	dw_con.object.fr_dt[dw_con.getrow()] = ls_str
	dw_con.object.to_dt[dw_con.getrow()] = ls_end
End If


String ls_member_no, ls_yn

SELECT CODE
INTO :ls_member_no
FROM  CDDB.KCH102D
WHERE UPPER(CODE_GB) = 'SUM99'
AND  USE_YN = 'Y'
AND CODE = :gs_empcode
USING SQLCA;

If ls_member_no = gs_empcode Then

	tab_1.tabpage_1.dw_tab1.object.member_gb.protect = 0

Else
	
	tab_1.tabpage_1.dw_tab1.object.member_gb.protect = 1
	tab_1.tabpage_1.dw_tab1.object.member_gb.initial = '1'
	tab_1.tabpage_1.dw_tab1.object.member_gb[tab_1.tabpage_1.dw_tab1.getrow()] = '1'
	
	SELECT NVL(ETC_CD1, 'N')
	INTO :ls_yn
	FROM  CDDB.KCH102D
	WHERE UPPER(CODE_GB) = 'SUM31'
	AND CODE = '1';
	
	tab_1.tabpage_1.dw_tab1.object.yn[tab_1.tabpage_1.dw_tab1.getrow()] = ls_yn
	
End If


//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

end event

event ue_insert;call super::ue_insert;tab_1.tabpage_1.dw_tab1.PostEvent("ue_InsertRow")
tab_1.SelectTab(1)

//tab_1.tabpage_2.dw_tab2.PostEvent("ue_InsertRow")
//tab_1.tabpage_3.dw_tab3.PostEvent("ue_InsertRow")

end event

event ue_delete;call super::ue_delete;Long		ll_row
String		ls_txt

//ls_txt = "[삭제] "
//tab_1.tabpage_1.dw_tab1.uf_DeleteAll()
//tab_1.tabpage_2.dw_tab2.uf_DeleteAll()
//tab_1.tabpage_3.dw_tab3.uf_DeleteAll()
//

tab_1.tabpage_1.dw_tab1.event ue_deleterow()

If Trigger Event ue_save() <> 1 Then
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
Else
	ll_row = dw_list.GetRow()
	If ll_row > 0 Then
		dw_list.DeleteRow(ll_row)
	End If
	f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
End If

end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = THIS.Event ue_updatequery() 
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

event ue_save;call super::ue_save;If ancestorreturnvalue = 1 Then 
	dw_list.event ue_retrieve()
End If

return 1
end event

type ln_templeft from w_window`ln_templeft within w_hsg116a
end type

type ln_tempright from w_window`ln_tempright within w_hsg116a
end type

type ln_temptop from w_window`ln_temptop within w_hsg116a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hsg116a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hsg116a
end type

type ln_tempstart from w_window`ln_tempstart within w_hsg116a
end type

type uc_retrieve from w_window`uc_retrieve within w_hsg116a
end type

type uc_insert from w_window`uc_insert within w_hsg116a
end type

type uc_delete from w_window`uc_delete within w_hsg116a
end type

type uc_save from w_window`uc_save within w_hsg116a
end type

type uc_excel from w_window`uc_excel within w_hsg116a
end type

type uc_print from w_window`uc_print within w_hsg116a
end type

type st_line1 from w_window`st_line1 within w_hsg116a
end type

type st_line2 from w_window`st_line2 within w_hsg116a
end type

type st_line3 from w_window`st_line3 within w_hsg116a
end type

type uc_excelroad from w_window`uc_excelroad within w_hsg116a
end type

type dw_list from uo_grid within w_hsg116a
event type long ue_retrieve ( )
integer x = 50
integer y = 484
integer width = 4389
integer height = 460
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg116a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_year, ls_hakgi, ls_member_no, ls_fr_dt, ls_to_dt, ls_pgm_tp
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.hakyear[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.GetRow()]
ls_member_no = func.of_nvl(dw_con.object.member_no[dw_con.GetRow()], '%')
ls_fr_dt = dw_con.object.fr_dt[dw_con.Getrow()]
ls_to_dt = dw_con.object.to_dt[dw_con.Getrow()]
ls_pgm_tp = func.of_nvl(dw_con.object.pgm_tp[dw_con.Getrow()], '%')

If ls_year = '' or isnull(ls_year) Then 
	Messagebox("알림", "학년도를 입력하세요!")
	RETURN -1
End If

If ls_hakgi = '' or isnull(ls_hakgi) Then 
	Messagebox("알림", "학기를 입력하세요!")
	RETURN -1
End If


tab_1.tabpage_1.dw_tab1.Reset()
tab_1.tabpage_2.dw_tab2.Reset()
tab_1.tabpage_3.dw_tab3.Reset()

ll_rv = This.Retrieve(ls_year, ls_hakgi, ls_fr_dt, ls_to_dt , ls_member_no, ls_pgm_tp)
If ll_rv = 0 Then
	
	tab_1.tabpage_1.dw_tab1.event ue_insertrow()
	tab_1.tabpage_1.dw_tab1.object.datawindow.readonly = 'Yes'
Else
	tab_1.tabpage_1.dw_tab1.object.datawindow.readonly = 'No'
	
End If

RETURN ll_rv

end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_rv
//String		ls_arg1
//String		ls_arg2

This.AcceptText()

ll_rv = Parent.Event ue_row_updatequery() 

If currentrow > 0 And (ll_rv = 1 or ll_rv = 2) Then
	If dw_list.GetItemStatus(currentrow, 0, Primary!) <> New! Then
//		ls_arg1 = This.Object.arg_key1[currentrow]
//		ls_arg2 = This.Object.arg_key2[currentrow]
		tab_1.tabpage_1.dw_tab1.event ue_Retrieve()
		tab_1.tabpage_2.dw_tab2.event ue_Retrieve()
		tab_1.tabpage_3.dw_tab3.event ue_Retrieve()
	Else
		//dw_main.Post Event ue_InsertRow()
	End If
End If

il_rv = 0

end event

event rowfocuschanging;call super::rowfocuschanging;If newrow > 0 Then
	If il_rv = 0 Then
		il_ret = Parent.Event ue_row_updatequery()
		Choose Case il_ret
			Case 3, -1
				il_rv ++
				If il_rv > 1 Then
					il_rv = 0
				End If
				RETURN 1
			Case 2
				il_rv = 0
				RETURN 0
			Case Else
				il_rv = 0
				RETURN 0
		End Choose
	Else
		Choose Case il_ret
			Case 3, -1
				il_rv ++
				If il_rv > 1 Then
					il_rv = 0
				End If
				RETURN 1
			Case 2
				il_rv = 0
				RETURN 0
			Case Else
				il_rv = 0
				RETURN 0
		End Choose
	End If
Else
	il_rv = 0
	RETURN 0
End If

end event

event retrieveend;call super::retrieveend;If rowcount > 0 Then
tab_1.selecttab(1)
//uc_row_delete.of_enable(false)
//uc_row_insert.of_enable(false)
tab_1.tabpage_1.dw_tab1.event ue_Retrieve()
tab_1.tabpage_2.dw_tab2.event ue_Retrieve()
tab_1.tabpage_3.dw_tab3.event ue_Retrieve()
End If
end event

type dw_con from uo_dw within w_hsg116a
integer x = 50
integer y = 164
integer width = 4389
integer height = 200
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg114a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_member_no
This.accepttext()
ls_KName =  trim(this.object.kname[1])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = '1'//교직원구분 -교원

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.kname[1]        = ls_kname					//성명
This.object.member_no[1]     = ls_Member_No				//개인번호
Parent.post event ue_inquiry()	
return 1
End If
end event

event itemchanged;call super::itemchanged;
String		ls_h01nno	,ls_h01knm


This.accepttext()
Choose Case	dwo.name
	Case	'member_no','kname'
		If dwo.name = 'member_no' Then	ls_h01nno = data
		If dwo.name = 'kname' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
			This.Post SetItem(row, 'kname'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_h01nno , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_h01nno || '%'
		AND NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.member_no[row] = ls_h01nno
			This.object.kname[row] = ls_h01knm
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
		
	

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

type tab_1 from tab within w_hsg116a
integer x = 50
integer y = 1044
integer width = 4379
integer height = 1220
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean raggedright = true
boolean showpicture = false
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;Choose Case newindex
	Case 1, 2
		If newindex = 1 Then
			uc_row_delete.of_enable(false)
		Else
			uc_row_delete.of_enable(true)
		End If
		uc_row_insert.of_enable(true)
		
		
	Case Else
		uc_row_delete.of_enable(false)
		uc_row_insert.of_enable(false)
End Choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4343
integer height = 1108
long backcolor = 16777215
string text = "집단프로그램 결과 등록"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab1 dw_tab1
st_tab1_line st_tab1_line
end type

on tabpage_1.create
this.dw_tab1=create dw_tab1
this.st_tab1_line=create st_tab1_line
this.Control[]={this.dw_tab1,&
this.st_tab1_line}
end on

on tabpage_1.destroy
destroy(this.dw_tab1)
destroy(this.st_tab1_line)
end on

type dw_tab1 from uo_dw within tabpage_1
event type long ue_retrieve ( )
integer width = 4347
integer height = 1108
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hsg116a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_member_no, ls_ent_no
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_member_no = dw_list.object.member_no[ll_row]
ls_ent_no = dw_list.object.ent_no[ll_row]

ll_rv = this.Retrieve(ls_year, ls_hakgi, ls_ent_no, ls_member_no)


RETURN ll_rv

end event

event ue_insertrow;call super::ue_insertrow;
String		ls_year, ls_hakgi, ls_member_no, ls_pgm_tp, ls_ent_no, ls_hname
Long		ll_rv, ll_row
Long 		l_ent_no

dw_con.accepttext()
ll_row = dw_con.getrow()

ls_year = dw_con.object.hakyear[ll_row]
ls_hakgi = dw_con.object.hakgi[ll_row]
ls_hname = dw_con.object.kname[ll_row]
ls_pgm_tp = dw_con.object.pgm_tp[ll_row]

SELECT :ls_year || lpad((to_number(nvl(max(substr(ent_no,5,10)), 0))) + 1, 6,'0') 
  INTO :l_ent_no
  from HAKSA.SUM150tl 
 where ent_no like :ls_year || '%' ;

 If isnull(l_ent_no ) Then 
	ls_ent_no =  ls_year + '000001'
Else
	ls_ent_no = String(l_ent_no)
End If



This.object.year[This.getrow()] = ls_year
This.object.hakgi[This.getrow()] = ls_hakgi
 
This.object.ent_no[This.getrow()] =   ls_ent_no

If ls_pgm_tp <> '' and isnull(ls_pgm_tp) = false Then
	This.object.pgm_tp[This.getrow()] = ls_pgm_tp
End If

This.object.PRE_ENT_DT[This.getrow()] = func.of_get_sdate('yyyymmdd')  //신청일자
this.object.ACT_TP[This.getrow()] = '3'	

RETURN 1

end event

event ue_deletestart;call super::ue_deletestart;//
//
//String		ls_year, ls_hakgi, ls_hakbun,    ls_case_no  , ls_counsel_dt
//String		ls_err
//Long		 ll_row
//
//
//idw_tab[1].accepttext()
//
//
//ll_row = idw_tab[1].getrow()
//ls_year = idw_tab[1].object.year[ll_row]
//ls_hakgi = idw_tab[1].object.hakgi[ll_row]
//ls_hakbun = idw_tab[1].object.hakbun[ll_row]
//ls_case_no = idw_tab[1].object.case_no[ll_row]
//ls_counsel_dt = idw_tab[1].object.counsel_dt[ll_row]   //상담일자
//
//
////진행단계가 완료가 아닌 건들 중 업데이트함.
//UPDATE HAKSA.SUM120TL
//SET COUNSEL_DT = '',
//       STEP = '4',
//       COUNSELLER = ''
//WHERE YEAR = :ls_year
//AND HAKGI = :ls_hakgi
//AND CASE_NO = :ls_case_no
//AND HAKBUN = :ls_hakbun
//AND STEP = '6' 
//USING SQLCA;
//
//If SQLCA.SQLCODE <> 0 Then
//	ls_err = SQLCA.SQLERRTEXT
//	ROLLBACK USING SQLCA;
//	Messagebox("알림", ls_err)
//	RETURN -1
//End If
//	



RETURN 1
//
end event

event clicked;call super::clicked;String   ls_ent_no, ls_year
If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_member_no
Long ll_row, l_ent_no
String  ls_hakgi,  ls_pgm_tp


This.accepttext()
ls_KName =  trim(this.object.member_nm[1])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = '1'//교직원구분 -교원

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	this.SetFocus()
	this.setcolumn('member_nm')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.member_nm[1]        = ls_kname					//성명
This.object.rst_member_no[1]     = ls_Member_No				//개인번호
			dw_con.accepttext()
			ll_row = dw_con.getrow()
			
			ls_year = dw_con.object.hakyear[ll_row]
			ls_hakgi = dw_con.object.hakgi[ll_row]
			ls_pgm_tp = dw_con.object.pgm_tp[ll_row]
			
			SELECT :ls_year || lpad((to_number(nvl(max(substr(ent_no,5,10)), 0))) + 1, 6,'0') 
			  INTO :l_ent_no
			  from HAKSA.SUM150tl 
			 where ent_no like :ls_year || '%' ;
			
			 If isnull(l_ent_no ) Then 
				ls_ent_no =  ls_year + '000001'
			Else
				ls_ent_no = String(l_ent_no)
			End If
			
			
			
			This.object.year[row] = ls_year
			This.object.hakgi[row] = ls_hakgi

			This.object.member_no[row] = ls_member_no
				

			This.object.ent_no[row] =   ls_ent_no
			
			If ls_pgm_tp <> '' and isnull(ls_pgm_tp) = false Then
				This.object.pgm_tp[row] = ls_pgm_tp
			End If
			
			This.object.PRE_ENT_DT[row] = func.of_get_sdate('yyyymmdd')  //신청일자
			this.object.ACT_TP[row] = '3'
						

Elseif left(dwo.name,6) = 'p_file' Then  //업로드 버튼
	String ls_file_path
	uo_comm_send  u_comm_send
	Long li_rtn
	String ls_doc_path, ls_doc_name, as_area_gb, as_file_path[], as_file_name[], as_key_value1[], as_key_value2[]
	String  ls_hakbun,  ls_cur_directory

	ls_ent_no = This.object.ent_no[row]
	ls_hakbun = this.object.hakbun[row]
	ls_year = This.object.year[row]
	
	If ls_ent_no = '' or isnull(ls_ent_no) Then RETURN -1
	

	u_comm_send = Create uo_comm_send
	
	If right(dwo.name, 1) = '1' Then
		ls_file_path = this.object.include_file_path[row]
	Elseif right(dwo.name, 1) = '2' Then
		ls_file_path = this.object.include_file_path2[row]
	Elseif right(dwo.name, 1) = '3' Then
		ls_file_path = this.object.include_file_path3[row]
	End If
	
	If ls_file_path = '' or isnull(ls_file_path) Then
	
		   
		ls_cur_directory = GetCurrentDirectory ( )
		
		li_rtn = GetFileOpenName("Select File", &
		   ls_doc_path, ls_doc_name, "DOC", &
		   + "Text Files (*.txt),*.TXT," &
		   + "CSV Files (*.csv),*.CSV," &
		   + "XLS Files (*.xls),*.XLS," &
		   + "All Files (*.*), *.*", &
		   ls_cur_directory, 18)		
		
		ChangeDirectory ( ls_cur_directory )		   
		   
		   
		If li_rtn < 1 Then return -1   
		   
	
	
		as_area_gb         = 'haksa'
		as_file_path[1]    = ls_doc_path
		as_file_name[1]   =ls_doc_name
		as_key_value1[1] = '116' + ls_year+ls_hakbun+ls_ent_no+ right(dwo.name, 1) 
		as_key_value2[1] = ''
		
		u_comm_send.of_file_upload( as_area_gb, as_file_path[], as_file_name[], as_key_value1[], as_key_value2[] )
		
		
		//해당 파일명을 컬럼에 셋팅해준다.
		If right(dwo.name, 1) = '1' Then
			 this.object.include_file_path[row] = ls_doc_name
		Elseif right(dwo.name, 1) = '2' Then
			this.object.include_file_path2[row] = ls_doc_name
		Elseif right(dwo.name, 1) = '3' Then
			this.object.include_file_path3[row] = ls_doc_name
		End If
	ENd If
End If
end event

event itemchanged;call super::itemchanged;
String		ls_member_no	,ls_kname, ls_yn
String ls_year, ls_hakgi, ls_pgm_tp, ls_ent_no
Long ll_row, l_ent_no


This.accepttext()
Choose Case	dwo.name
	case 'member_gb'
		/*담당구분을 선택시 해당 선택한 컬럼의 기타1이 'Y'가 아닌경우, 
		   해당 교직원번호를 찾기위한 Help를 실행하지 않고,
		   교번없이 성명만 입력하도록 한다. */
		   
		  SELECT NVL(ETC_CD1, 'N')
		  INTO :ls_yn
		  FROM CDDB.KCH102D
		  WHERE UPPER(CODE_GB) = 'SUM31' 
		  AND  CODE = :data
		  USING SQLCA;
		  
		 this.object.yn[row] = ls_yn	
	Case	'rst_member_no','member_nm'
		If dwo.name = 'rst_member_no' Then	ls_member_no = data
		If dwo.name = 'member_nm' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'rst_member_no'	, '')
			This.Post SetItem(row, 'member_nm'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_member_no , :ls_kname
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_member_no || '%'
		AND NAME LIKE :ls_kname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.rst_member_no[row] = ls_member_no
			This.object.member_nm[row] = ls_kname
			
			
			
			dw_con.accepttext()
			ll_row = dw_con.getrow()
			
			ls_year = dw_con.object.hakyear[ll_row]
			ls_hakgi = dw_con.object.hakgi[ll_row]
			ls_pgm_tp = dw_con.object.pgm_tp[ll_row]
			
			SELECT :ls_year || lpad((to_number(nvl(max(substr(ent_no,5,10)), 0))) + 1, 6,'0') 
			  INTO :l_ent_no
			  from HAKSA.SUM150tl 
			 where ent_no like :ls_year || '%' ;
			
			 If isnull(l_ent_no ) Then 
				ls_ent_no =  ls_year + '000001'
			Else
				ls_ent_no = String(l_ent_no)
			End If
			
			
			
			This.object.year[row] = ls_year
			This.object.hakgi[row] = ls_hakgi
			This.object.member_no[row] = ls_member_no
			This.object.ent_no[row] =   ls_ent_no
			
			If ls_pgm_tp <> '' and isnull(ls_pgm_tp) = false Then
				This.object.pgm_tp[row] = ls_pgm_tp
			End If
			
			This.object.PRE_ENT_DT[row] = func.of_get_sdate('yyyymmdd')  //신청일자
				this.object.ACT_TP[row] = '3'		

			
		Else
			If this.object.yn[row] = 'Y' Then
				This.Trigger Event clicked(-1, 0, row, This.object.p_search)
				return 1
			End If
			
		End If	
		
	

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

type st_tab1_line from statictext within tabpage_1
boolean visible = false
integer x = 137
integer y = 28
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4343
integer height = 1108
long backcolor = 16777215
string text = "참석자 등록"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab2 dw_tab2
st_tab2_line st_tab2_line
end type

on tabpage_2.create
this.dw_tab2=create dw_tab2
this.st_tab2_line=create st_tab2_line
this.Control[]={this.dw_tab2,&
this.st_tab2_line}
end on

on tabpage_2.destroy
destroy(this.dw_tab2)
destroy(this.st_tab2_line)
end on

type dw_tab2 from uo_grid within tabpage_2
event type long ue_retrieve ( )
integer x = 5
integer y = 16
integer width = 4347
integer height = 1080
integer taborder = 20
string dataobject = "d_hsg116a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_member_no, ls_ent_no
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_member_no = dw_list.object.member_no[ll_row]
ls_ent_no = dw_list.object.ent_no[ll_row]

ll_rv = this.Retrieve(ls_year, ls_hakgi, ls_ent_no, ls_member_no)
end event

event ue_constructor;call super::ue_constructor;iw_parent = Parent.GetParent().GetParent()

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

event ue_insertend;call super::ue_insertend;Long		ll_row
String		ls_year, ls_hakgi, ls_member_no, ls_ent_no, ls_kname
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_member_no = dw_list.object.member_no[ll_row]
ls_ent_no = dw_list.object.ent_no[ll_row]
ls_kname = dw_list.object.kname[ll_row]

This.object.year[al_row] = ls_year
This.object.hakgi[al_row] = ls_hakgi
This.object.member_no[al_row] = ls_member_no
This.object.member_nm[al_row] = ls_kname

This.object.ent_no[al_row] = ls_ent_no
return 1

end event

event doubleclicked;call super::doubleclicked;If dwo.name = 'hakbun' or dwo.name = 'hname' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_hakbun, ls_gwa, ls_hakyun
This.accepttext()
ls_KName =  trim(this.object.hname[row])

OpenWithParm(w_hsg_hakjuk,ls_kname)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	this.SetFocus()
	this.setcolumn('hname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[2]	//성명
ls_hakbun            = lstr_com.ls_item[1]	//학번
this.object.hname[row]        = ls_kname					//성명
This.object.hakbun[row]     = ls_hakbun				//개인번호

SELECT  GWA, DR_HAKYUN
		INTO  :ls_gwa, :ls_hakyun
		FROM  (	SELECT	A.HAKBUN			HAKBUN, 	GWA, DR_HAKYUN,
							A.HNAME			HNAME
				FROM		HAKSA.JAEHAK_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,GWA, DR_HAKYUN,
							A.HNAME			HNAME
				FROM		HAKSA.JOLUP_HAKJUK A
				)	A
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_kname || '%'
		USING SQLCA;

 This.object.gwa[row]     = ls_gwa
 This.object.dr_hakyun[row]     = ls_hakyun 
 


return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_hname, ls_gwa, ls_hakyun

This.accepttext()
Choose Case	dwo.name
	Case	'hakbun','hname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'hname' Then	ls_hname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'hname'	, '')	
			This.Post SetItem(row, 'gwa'	, '')
			This.Post SetItem(row, 'dr_hakyun'	, '')	
			RETURN
		End If
		
		SELECT HAKBUN, HNAME, GWA, DR_HAKYUN
		INTO :ls_hakbun , :ls_hname, :ls_gwa, :ls_hakyun
		FROM  (	SELECT	A.HAKBUN			HAKBUN, 	GWA, DR_HAKYUN,
							A.HNAME			HNAME
				FROM		HAKSA.JAEHAK_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,GWA, DR_HAKYUN,
							A.HNAME			HNAME
				FROM		HAKSA.JOLUP_HAKJUK A
				)	A
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_hname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.hakbun[row] = ls_hakbun
			This.object.hname[row] = ls_hname
			this.object.gwa[row] = ls_gwa
			this.object.dr_hakyun[row] = ls_hakyun
			
		Else
			This.Trigger Event doubleclicked(-1, 0, row, This.object.hname)
			return 1
			
		End If	
End Choose


end event

type st_tab2_line from statictext within tabpage_2
boolean visible = false
integer x = 187
integer y = 32
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4343
integer height = 1108
long backcolor = 16777215
string text = "집단프로그램신청 조회"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab3 dw_tab3
st_tab3_line st_tab3_line
end type

on tabpage_3.create
this.dw_tab3=create dw_tab3
this.st_tab3_line=create st_tab3_line
this.Control[]={this.dw_tab3,&
this.st_tab3_line}
end on

on tabpage_3.destroy
destroy(this.dw_tab3)
destroy(this.st_tab3_line)
end on

type dw_tab3 from uo_dw within tabpage_3
event type long ue_retrieve ( )
integer width = 4352
integer height = 1108
integer taborder = 10
string dataobject = "d_hsg116a_4"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_member_no, ls_ent_no
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_member_no = dw_list.object.member_no[ll_row]
ls_ent_no = dw_list.object.ent_no[ll_row]

ll_rv = this.Retrieve(ls_year, ls_hakgi, ls_ent_no, ls_member_no)
end event

event constructor;call super::constructor;this.object.datawindow.readonly = 'Yes'
end event

type st_tab3_line from statictext within tabpage_3
boolean visible = false
integer x = 155
integer y = 20
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type uo_1 from u_tab within w_hsg116a
integer x = 1573
integer y = 876
integer taborder = 30
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type p_1 from picture within w_hsg116a
integer x = 50
integer y = 404
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hsg116a
integer x = 114
integer y = 388
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
string text = "신청목록"
boolean focusrectangle = false
end type

type p_2 from picture within w_hsg116a
boolean visible = false
integer x = 50
integer y = 976
integer width = 46
integer height = 44
boolean bringtotop = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_hsg116a
boolean visible = false
integer x = 114
integer y = 964
integer width = 1051
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "상담/검사 결과 등록"
boolean focusrectangle = false
end type

type uc_row_insert from u_picture within w_hsg116a
integer x = 3890
integer y = 976
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;Integer		li_selectedtab
String ls_member_no

li_SelectedTab = tab_1.SelectedTab

If li_selectedtab = 1 Then
	idw_tab[li_SelectedTab].PostEvent("ue_InsertRow")
Else

	If dw_list.RowCount() > 0 Then
		ls_member_no = dw_list.object.kname[dw_list.getrow()] 
		If  ls_member_no = '' or isnull(ls_member_no) Then RETURN -1
		
	//	tab_1.Control[li_SelectedTab].PostEvent("ue_InsertRow")
		idw_tab[li_SelectedTab].PostEvent("ue_InsertRow")
	End If
End If

end event

type uc_row_delete from u_picture within w_hsg116a
integer x = 4169
integer y = 976
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;Integer		li_selectedtab

li_SelectedTab = tab_1.SelectedTab

//tab_1.Control[li_SelectedTab].PostEvent("ue_DeleteRow")
idw_tab[li_SelectedTab].PostEvent("ue_DeleteRow")


end event

