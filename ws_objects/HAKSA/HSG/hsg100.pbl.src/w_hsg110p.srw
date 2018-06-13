$PBExportHeader$w_hsg110p.srw
$PBExportComments$[w_list_tab] 상담 내역 조회(교수/인력개발센터)
forward
global type w_hsg110p from w_window
end type
type dw_list from uo_grid within w_hsg110p
end type
type dw_con from uo_dw within w_hsg110p
end type
type tab_1 from tab within w_hsg110p
end type
type tabpage_1 from userobject within tab_1
end type
type dw_sub from uo_grid within tabpage_1
end type
type dw_tab1 from uo_dw within tabpage_1
end type
type st_tab1_line from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_sub dw_sub
dw_tab1 dw_tab1
st_tab1_line st_tab1_line
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tab2 from uo_dw within tabpage_2
end type
type st_tab2_line from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_tab2 dw_tab2
st_tab2_line st_tab2_line
end type
type tabpage_3 from userobject within tab_1
end type
type st_tab3_line from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
st_tab3_line st_tab3_line
end type
type tab_1 from tab within w_hsg110p
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type uo_1 from u_tab within w_hsg110p
end type
type p_1 from picture within w_hsg110p
end type
type st_main from statictext within w_hsg110p
end type
type p_2 from picture within w_hsg110p
end type
type st_detail from statictext within w_hsg110p
end type
end forward

global type w_hsg110p from w_window
event type long ue_row_updatequery ( )
event type long ue_retrieve ( )
dw_list dw_list
dw_con dw_con
tab_1 tab_1
uo_1 uo_1
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
end type
global w_hsg110p w_hsg110p

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

on w_hsg110p.create
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
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.st_main
this.Control[iCurrent+7]=this.p_2
this.Control[iCurrent+8]=this.st_detail
end on

on w_hsg110p.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_list )


//This.Event ue_resize_dw( tab_1.tabpage_1.st_tab1_line, tab_1.tabpage_1.dw_tab1 )
//This.Event ue_resize_dw( tab_1.tabpage_2.st_tab2_line, tab_1.tabpage_2.dw_tab2 )
//This.Event ue_resize_dw( tab_1.tabpage_3.st_tab3_line, tab_1.tabpage_3.dw_tab3 )
//만일 dw_tab1, dw_tab2, dw_tab3가 Single Row이면 uo_dw를 사용하여
//dw_tab1, dw_tab2, dw_tab3를 만들고
//func.of_design_dw( tab_1.tabpage_1.dw_tab1 )
func.of_design_dw( tab_1.tabpage_2.dw_tab2 )
dw_con.settransobject(sqlca)
//func.of_design_dw( tab_1.tabpage_3.dw_tab3 )

dw_con.insertrow(0)
tab_1.tabpage_1.dw_tab1.insertrow(0)
tab_1.tabpage_2.dw_tab2.insertrow(0)
//tab_1.tabpage_3.dw_tab3.insertrow(0)
//idw_update[1]	= tab_1.tabpage_1.dw_tab1
//idw_update[2]	= tab_1.tabpage_2.dw_tab2
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
//idw_tab[3] = tab_1.tabpage_3.dw_tab3

tab_1.tabpage_1.dw_tab1.iw_parent = This
tab_1.tabpage_2.dw_tab2.iw_parent = This
//tab_1.tabpage_3.dw_tab3.iw_parent = This

//tab_1.tabpage_1.dw_tab1.Width	= tab_1.Width	- 60
//tab_1.tabpage_2.dw_tab2.Width	= tab_1.Width	- 60
//tab_1.tabpage_3.dw_tab3.Width	= tab_1.Width	- 60
//tab_1.tabpage_1.dw_tab1.Height	= tab_1.Height	- 144
//tab_1.tabpage_2.dw_tab2.Height	= tab_1.Height	- 144
//tab_1.tabpage_3.dw_tab3.Height	= tab_1.Height	- 144
//tab_1.tabpage_1.dw_tab1.width = 3543
//tab_1.tabpage_1.dw_tab1.height = 668
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
lvc_data.setProperty('column2', 'case_tp')  //상담구분- 찾은목적
lvc_data.setProperty('key2', 'SUM02')
lvc_data.setProperty('column3', 'step')  //진행단계
lvc_data.setProperty('key3', 'SUM10')
func.of_dddw( dw_con,lvc_data)

lvc_data.setProperty('column2', 'counsel_tp')  //상담구분
lvc_data.setProperty('key2', 'SUM05')
lvc_data.setProperty('column3', 'act_tp')  //결과진행구분
lvc_data.setProperty('key3', 'SUM26')

func.of_dddw( tab_1.tabpage_1.dw_tab1,lvc_data)

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

event ue_savestart;call super::ue_savestart;If idw_tab[1].rowcount() = 0 Then return 1

String		ls_year, ls_hakgi, ls_hakbun,    ls_case_no  , ls_counsel_dt, ls_counseller
String		ls_err
Long		 ll_row


idw_tab[1].accepttext()


ll_row = idw_tab[1].getrow()
ls_year = idw_tab[1].object.year[ll_row]
ls_hakgi = idw_tab[1].object.hakgi[ll_row]
ls_hakbun = idw_tab[1].object.hakbun[ll_row]
ls_case_no = idw_tab[1].object.case_no[ll_row]
ls_counsel_dt = idw_tab[1].object.counsel_dt[ll_row]
ls_counseller = trim(idw_tab[1].object.counseller[ll_row])



//진행단계가 완료가 아닌 건들 중 업데이트함.
UPDATE HAKSA.SUM120TL
SET COUNSEL_DT = :ls_counsel_dt,
       STEP = '6',
       COUNSELLER = :ls_counseller
WHERE YEAR = :ls_year
AND HAKGI = :ls_hakgi
AND CASE_NO = :ls_case_no
AND HAKBUN = :ls_hakbun
AND STEP <> '6' 
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("알림", ls_err)
	RETURN -1
End If
	


RETURN 1
//
end event

type ln_templeft from w_window`ln_templeft within w_hsg110p
end type

type ln_tempright from w_window`ln_tempright within w_hsg110p
end type

type ln_temptop from w_window`ln_temptop within w_hsg110p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hsg110p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hsg110p
end type

type ln_tempstart from w_window`ln_tempstart within w_hsg110p
end type

type uc_retrieve from w_window`uc_retrieve within w_hsg110p
end type

type uc_insert from w_window`uc_insert within w_hsg110p
end type

type uc_delete from w_window`uc_delete within w_hsg110p
end type

type uc_save from w_window`uc_save within w_hsg110p
end type

type uc_excel from w_window`uc_excel within w_hsg110p
end type

type uc_print from w_window`uc_print within w_hsg110p
end type

type st_line1 from w_window`st_line1 within w_hsg110p
end type

type st_line2 from w_window`st_line2 within w_hsg110p
end type

type st_line3 from w_window`st_line3 within w_hsg110p
end type

type uc_excelroad from w_window`uc_excelroad within w_hsg110p
end type

type dw_list from uo_grid within w_hsg110p
event type long ue_retrieve ( )
integer x = 50
integer y = 484
integer width = 4389
integer height = 536
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg110p_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean ib_multi_row = false
end type

event type long ue_retrieve();String		ls_year, ls_hakgi, ls_gwa, ls_fr_dt, ls_to_dt, ls_hakbun
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.hakyear[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.GetRow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.GetRow()], '%')
ls_fr_dt = dw_con.object.fr_dt[dw_con.Getrow()]
ls_to_dt = dw_con.object.to_dt[dw_con.Getrow()]
ls_hakbun = func.of_nvl(trim(dw_con.object.hakbun[dw_con.Getrow()]), '%')


If ls_year = '' or isnull(ls_year) Then 
	Messagebox("알림", "학년도를 입력하세요!")
	RETURN -1
End If

If ls_hakgi = '' or isnull(ls_hakgi) Then 
	Messagebox("알림", "학기를 입력하세요!")
	RETURN -1
End If
//If ls_hakbun = '' or isnull(ls_hakbun) Then 
//	Messagebox("알림", "학번을 입력하세요!")
//	RETURN -1
//End If



//dw_tab1_1.Reset()
//dw_sub.reset()
//tab_1.tabpage_2.dw_tab2.Reset()

tab_1.tabpage_1.dw_tab1.Reset()
tab_1.tabpage_2.dw_tab2.Reset()
//tab_1.tabpage_3.dw_tab3.Reset()

ll_rv = This.Retrieve(ls_year, ls_hakgi, ls_gwa, ls_fr_dt, ls_to_dt , ls_hakbun)



If ll_rv = 0 Then
	
	tab_1.tabpage_1.dw_tab1.insertrow(0)
	tab_1.tabpage_2.dw_tab2.insertrow(0)
	
	
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
		tab_1.tabpage_1.dw_sub.event ue_Retrieve()
		tab_1.tabpage_2.dw_tab2.event ue_Retrieve()

//		tab_1.tabpage_2.dw_tab2.event ue_Retrieve()
//		tab_1.tabpage_3.dw_tab3.event ue_Retrieve()
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
tab_1.tabpage_1.dw_tab1.event ue_Retrieve()
//tab_1.tabpage_2.dw_tab2.event ue_Retrieve()
//tab_1.tabpage_3.dw_tab3.event ue_Retrieve()
End If
end event

type dw_con from uo_dw within w_hsg110p
integer x = 50
integer y = 164
integer width = 4389
integer height = 200
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg111p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_hakbun
This.accepttext()
ls_KName =  trim(this.object.kname[1])



OpenWithParm(w_hsg_hakjuk,ls_kname)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[2]	//성명
ls_hakbun            = lstr_com.ls_item[1]	//학번
this.object.kname[1]        = ls_kname					//성명
This.object.hakbun[1]     = ls_hakbun				//개인번호
Parent.post event ue_inquiry()	
return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_kname

This.accepttext()
Choose Case	dwo.name
	Case	'hakbun','kname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'kname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'kname'	, '')			
			RETURN
		End If
		
		SELECT HAKBUN, HNAME
		INTO :ls_hakbun , :ls_kname
		FROM  (	SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JAEHAK_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JOLUP_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.D_HAKJUK	A	)	A
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_kname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.hakbun[row] = ls_hakbun
			This.object.kname[row] = ls_kname
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
End Choose


end event

type tab_1 from tab within w_hsg110p
integer x = 50
integer y = 1068
integer width = 4379
integer height = 1204
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
	Case 1 
		uc_delete.of_enable(true)
		uc_save.of_enable(true)
	Case Else
		uc_delete.of_enable(false)
		uc_save.of_enable(false)
End Choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4343
integer height = 1092
long backcolor = 16777215
string text = "학생상담 상세 조회"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_sub dw_sub
dw_tab1 dw_tab1
st_tab1_line st_tab1_line
end type

on tabpage_1.create
this.dw_sub=create dw_sub
this.dw_tab1=create dw_tab1
this.st_tab1_line=create st_tab1_line
this.Control[]={this.dw_sub,&
this.dw_tab1,&
this.st_tab1_line}
end on

on tabpage_1.destroy
destroy(this.dw_sub)
destroy(this.dw_tab1)
destroy(this.st_tab1_line)
end on

type dw_sub from uo_grid within tabpage_1
event type long ue_retrieve ( )
integer x = 3566
integer width = 795
integer height = 1104
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hsg105a_3"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no, ls_code
Long		ll_rv

dw_list.accepttext()
ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_hakbun = dw_list.object.hakbun[ll_row]
ls_case_no = dw_list.object.case_no[ll_row]
ls_code = dw_list.object.purpose[ll_row]
ll_rv = dw_sub.Retrieve(ls_year, ls_hakgi, ls_case_no, ls_hakbun, ls_code)


RETURN ll_rv

end event

event constructor;call super::constructor;this.object.datawindow.readonly = 'Yes'
end event

type dw_tab1 from uo_dw within tabpage_1
event type long ue_retrieve ( )
integer x = 5
integer width = 3552
integer height = 1104
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hsg110p_3"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_hakbun = dw_list.object.hakbun[ll_row]
ls_case_no = dw_list.object.case_no[ll_row]

ll_rv = this.Retrieve(ls_year, ls_hakgi, ls_case_no, ls_hakbun)

If ll_rv = 0 Then 
	This.insertrow(0)
End If
RETURN ll_rv

end event

event constructor;call super::constructor;This.object.datawindow.readonly = 'Yes'
settransobject(sqlca)
end event

event retrieveend;call super::retrieveend;If rowcount > 0 Then
tab_1.tabpage_1.dw_sub.event ue_Retrieve()
tab_1.tabpage_2.dw_tab2.event ue_retrieve()
End If
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
integer height = 1092
long backcolor = 16777215
string text = "학생정보 조회"
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

type dw_tab2 from uo_dw within tabpage_2
event type long ue_retrieve ( )
integer width = 4352
integer height = 1108
integer taborder = 10
string dataobject = "d_hsg109a_3"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no
Long		ll_rv

ll_row = dw_list.GetRow()
dw_list.accepttext()

If ll_row <= 0 Then RETURN -1
ls_hakbun = dw_list.object.hakbun[ll_row]

ll_rv = this.Retrieve(ls_hakbun)

If ll_rv = 0 Then 
	This.insertrow(0)
End If
RETURN ll_rv

end event

event constructor;call super::constructor;this.object.datawindow.readonly = 'Yes'
settransobject(sqlca)
end event

event retrieveend;call super::retrieveend;If rowcount = 0 Then return -1
String ls_hakbun

blob lbBmp
int li_cnt, i

int FP, Li_x, Li_count
long LL_size, LL_start, LL_write
blob imagedata, Lblb_part

ls_hakbun = this.object.hakbun[This.getrow()]

If ls_hakbun = '' or isnull(ls_hakbun) then
	 this.SetItem(1, 'bmp_hakbun', 'C:\emp_image\space.jpg')
Else

	IF DirectoryExists ('c:\emp_image') THEN
	ELSE
	   CreateDirectory ('c:\emp_image')
	END IF
	
	
	
	 SELECTBLOB	P_IMAGE
			 INTO :lbBmp
			 FROM HAKSA.PHOTO
			WHERE HAKBUN	= :ls_hakbun;
	 IF sqlca.sqlcode = 0 then
		
		 LL_size = Len(lbBmp)
		 IF LL_size > 32765 THEN
			 IF Mod(LL_size, 32765) = 0 THEN
				 Li_count = LL_size / 32765
			 ELSE
				 Li_count = (LL_size / 32765) + 1
			 END IF
		 ELSE
			 Li_count = 1
		 END IF
		
		 FP = FileOpen("c:\emp_image\" + ls_hakbun + ".jpg", StreamMode!, Write!, Shared!, Replace!)
		
		 FOR i = 1 to Li_count
			  LL_write    = FileWrite(fp,lbBmp )
			  IF LL_write = 32765 THEN
				  lbBmp    = BlobMid(lbBmp, 32766)
			  END IF
		 NEXT
		 FileClose(FP)
		 this.SetItem(1, 'bmp_hakbun', 'C:\emp_image\' + ls_hakbun + '.jpg')
	ELSE
		 this.SetItem(1, 'bmp_hakbun', 'C:\emp_image\space.jpg')
	END IF
End If
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
boolean visible = false
integer x = 18
integer y = 96
integer width = 4343
integer height = 1092
boolean enabled = false
long backcolor = 16777215
string text = "상담신청내역 조회"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_tab3_line st_tab3_line
end type

on tabpage_3.create
this.st_tab3_line=create st_tab3_line
this.Control[]={this.st_tab3_line}
end on

on tabpage_3.destroy
destroy(this.st_tab3_line)
end on

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

type uo_1 from u_tab within w_hsg110p
integer x = 1829
integer y = 792
integer taborder = 30
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type p_1 from picture within w_hsg110p
integer x = 50
integer y = 404
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hsg110p
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
string text = "학생상담 리스트"
boolean focusrectangle = false
end type

type p_2 from picture within w_hsg110p
boolean visible = false
integer x = 50
integer y = 976
integer width = 46
integer height = 44
boolean bringtotop = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_hsg110p
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

