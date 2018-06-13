$PBExportHeader$w_hyd202a.srw
$PBExportComments$[w_list_master_detail] 연구논문게재실적등록
forward
global type w_hyd202a from w_window
end type
type dw_list from uo_grid within w_hyd202a
end type
type dw_con from uo_dw within w_hyd202a
end type
type dw_main from uo_dw within w_hyd202a
end type
type uc_row_insert from u_picture within w_hyd202a
end type
type uc_row_delete from u_picture within w_hyd202a
end type
type dw_sub from uo_grid within w_hyd202a
end type
type st_main from statictext within w_hyd202a
end type
type st_detail from statictext within w_hyd202a
end type
type p_2 from picture within w_hyd202a
end type
type p_1 from picture within w_hyd202a
end type
type p_3 from picture within w_hyd202a
end type
type st_sub from statictext within w_hyd202a
end type
type uo_app from uo_imgbtn within w_hyd202a
end type
end forward

global type w_hyd202a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
dw_main dw_main
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
dw_sub dw_sub
st_main st_main
st_detail st_detail
p_2 p_2
p_1 p_1
p_3 p_3
st_sub st_sub
uo_app uo_app
end type
global w_hyd202a w_hyd202a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE

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

public function integer wf_validall ();Integer	li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

end function

on w_hyd202a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.dw_main=create dw_main
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.dw_sub=create dw_sub
this.st_main=create st_main
this.st_detail=create st_detail
this.p_2=create p_2
this.p_1=create p_1
this.p_3=create p_3
this.st_sub=create st_sub
this.uo_app=create uo_app
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.uc_row_insert
this.Control[iCurrent+5]=this.uc_row_delete
this.Control[iCurrent+6]=this.dw_sub
this.Control[iCurrent+7]=this.st_main
this.Control[iCurrent+8]=this.st_detail
this.Control[iCurrent+9]=this.p_2
this.Control[iCurrent+10]=this.p_1
this.Control[iCurrent+11]=this.p_3
this.Control[iCurrent+12]=this.st_sub
this.Control[iCurrent+13]=this.uo_app
end on

on w_hyd202a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.dw_sub)
destroy(this.st_main)
destroy(this.st_detail)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.p_3)
destroy(this.st_sub)
destroy(this.uo_app)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )
This.Event ue_resize_dw( st_line1, dw_list )
This.Event ue_resize_dw( st_line2, dw_sub )

dw_con.settransobject(sqlca)
dw_con.insertrow(0)
dw_con.object.std_ym[1] = func.of_get_sdate('yyyy') +  '01'
dw_con.object.std_ym_to[1] = func.of_get_sdate('yyyymm')

dw_main.insertrow(0)
idw_update[1]	= dw_main
idw_update[2]	= dw_sub

Vector lvc_data
lvc_data = Create Vector

lvc_data.setProperty('column1', 'tpi_dvs_cd')  //참여구분코드
lvc_data.setProperty('key1', 'HYD1180')
lvc_data.setProperty('column2', 'posi_cd')  //직급
lvc_data.setProperty('key2', 'HYD2060')
lvc_data.setProperty('column3', 'dgr_dvs_cd')  //학위구분코드
lvc_data.setProperty('key3', 'HYD1240')
func.of_dddw( dw_sub,lvc_data)


lvc_data.setProperty('column1', 'scjnl_dvs_cd')  //학술지구분
lvc_data.setProperty('key1', 'HYD1100')
lvc_data.setProperty('column2', 'ovrs_pblc_yn')  //해외우수학술지게재여부
lvc_data.setProperty('key2', 'HYD1380')
lvc_data.setProperty('column3', 'krf_pblc_yn')  //학진등재게재여부
lvc_data.setProperty('key3', 'HYD1390')
lvc_data.setProperty('column4', 'pblc_ntn_cd')  //발행국가코드
lvc_data.setProperty('key4', 'HYD2000')
lvc_data.setProperty('column5', 'ppr_lang_dvs_cd')  //논문언어구분코드
lvc_data.setProperty('key5', 'HYD2020')
lvc_data.setProperty('column6', 'sphe_cd')  //연구실적학문분야코드
lvc_data.setProperty('key6', 'HYD2040')
lvc_data.setProperty('column7', 'vrfc_dvs_cd')  //검증구분코드
lvc_data.setProperty('key7', 'HYD1420')
func.of_dddw( dw_main,lvc_data)





//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= dw_main
//idw_Toexcel[3]	= dw_sub

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

event ue_delete;call super::ue_delete;Long		ll_row
String		ls_txt

ls_txt = "[삭제] "
If dw_main.RowCount() > 0 Then
	If NOT dw_main.ib_multi_row Then
		If dw_main.Event ue_DeleteRow() > 0 Then
			dw_sub.uf_DeleteAll()
			If Trigger Event ue_save() <> 1 Then
				f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
			Else
				ll_row = dw_list.GetRow()
				If ll_row > 0 Then
					dw_list.DeleteRow(ll_row)
				End If
				f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
			End If
		Else
			f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
		End If
	Else
		ll_row = dw_main.GetRow()
		If ll_row > 0 Then
			dw_main.SetRow(ll_row)
			If dw_main.Event ue_DeleteRow() > 0 Then
				dw_sub.uf_DeleteAll()
				If Trigger Event ue_save() <> 1 Then
					f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
				Else
					ll_row = dw_list.GetRow()
					If ll_row > 0 Then
						dw_list.DeleteRow(ll_row)
					End If
					f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
				End If
			Else
				f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
			End If
		Else
			
		End If
	End If
End If

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
	dw_main.insertrow(0)
	dw_main.object.std_ym[1] = dw_con.object.std_ym[1]
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

event ue_button_set;call super::ue_button_set;If uc_row_insert.Enabled Then
	uc_row_insert.Visible	= TRUE
Else
	uc_row_insert.Visible	= FALSE
End If

If uc_row_delete.Enabled Then
	uc_row_delete.Visible	= TRUE
Else
	uc_row_delete.Visible	= FALSE
End If

end event

event ue_save;call super::ue_save;If Ancestorreturnvalue = 1 Then this.event ue_inquiry()

return Ancestorreturnvalue
end event

type ln_templeft from w_window`ln_templeft within w_hyd202a
end type

type ln_tempright from w_window`ln_tempright within w_hyd202a
end type

type ln_temptop from w_window`ln_temptop within w_hyd202a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hyd202a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hyd202a
end type

type ln_tempstart from w_window`ln_tempstart within w_hyd202a
end type

type uc_retrieve from w_window`uc_retrieve within w_hyd202a
end type

type uc_insert from w_window`uc_insert within w_hyd202a
end type

type uc_delete from w_window`uc_delete within w_hyd202a
end type

type uc_save from w_window`uc_save within w_hyd202a
end type

type uc_excel from w_window`uc_excel within w_hyd202a
end type

type uc_print from w_window`uc_print within w_hyd202a
end type

type st_line1 from w_window`st_line1 within w_hyd202a
end type

type st_line2 from w_window`st_line2 within w_hyd202a
end type

type st_line3 from w_window`st_line3 within w_hyd202a
end type

type uc_excelroad from w_window`uc_excelroad within w_hyd202a
end type

type dw_list from uo_grid within w_hyd202a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4384
integer height = 412
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd202a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_std_ym, ls_gwa, ls_member_no, ls_yn, ls_std_ym_to
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_std_ym = dw_con.object.std_ym[dw_con.GetRow()]
ls_std_ym_to = dw_con.object.std_ym_to[dw_con.GetRow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.GetRow()], '%')
ls_member_no = func.of_nvl(dw_con.object.member_no[dw_con.Getrow()], '%')
ls_yn = func.of_nvl(dw_con.object.appr_dvs_cd[dw_con.Getrow()], '%')

If ls_std_ym = '' or isnull(ls_std_ym) Then
	Messagebox("알림", "기준년월(FR)을 입력하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('std_ym')
	RETURN -1
End If


If ls_std_ym_to = '' or isnull(ls_std_ym_to) Then
	Messagebox("알림", "기준년월(TO)을 입력하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('std_ym_to')
	RETURN -1
End If

If ls_std_ym > ls_std_ym_to Then
	Messagebox("알림", "기준년월 범위를 확인하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('std_ym')
	RETURN -1
End If

dw_main.Reset()
dw_sub.Reset()
ll_rv = This.Retrieve(ls_std_ym, ls_std_ym_to, ls_gwa, ls_member_no, ls_yn)

RETURN ll_rv

end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_rv

This.AcceptText()

ll_rv = Parent.Event ue_row_updatequery() 

If currentrow > 0 And (ll_rv = 1 or ll_rv = 2) Then
	If dw_list.GetItemStatus(currentrow, 0, Primary!) <> New! THEN 
		dw_main.Post Event ue_Retrieve()
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

event ue_deleteend;call super::ue_deleteend;If dw_sub.uf_DeleteAll() >= 0 Then
	RETURN 1
Else
	RETURN -1
End If

end event

event retrieveend;call super::retrieveend;This.setrow(1)
dw_main.Post Event ue_Retrieve()
end event

type dw_con from uo_dw within w_hyd202a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd203a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
String		ls_member_no	,ls_h01knm


This.accepttext()
Choose Case	dwo.name
	Case	'member_no','kname'
		If dwo.name = 'member_no' Then	ls_member_no = data
		If dwo.name = 'kname' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
			This.Post SetItem(row, 'kname'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_member_no , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_member_no || '%'
		AND NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.member_no[row] = ls_member_no
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

type dw_main from uo_dw within w_hyd202a
event type long ue_retrieve ( )
integer x = 50
integer y = 840
integer width = 4375
integer height = 832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd202a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_std_ym, ls_member_no, ls_mng_no
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_std_ym = dw_list.object.std_ym[ll_row]
ls_member_no = dw_list.object.member_no[ll_row]
ls_mng_no = dw_list.object.mng_no[ll_row]

ll_rv = dw_main.Retrieve(ls_std_ym, ls_member_no, ls_mng_no)
If ll_rv > 0 Then
	dw_sub.Retrieve(ls_std_ym, ls_member_no, ls_mng_no, '1')  //참여자명단귀속구분 - 1 : 논문게재실적
Else
	This.insertrow(0)
	dw_sub.Reset()
End If

RETURN ll_rv

end event

event ue_insertrow;call super::ue_insertrow;
If AncestorReturnValue = 1 Then dw_sub.Reset()
	


RETURN AncestorReturnValue

end event

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
	this.SetFocus()
	this.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.kname[1]        = ls_kname					//성명
This.object.member_no[1]     = ls_Member_No				//개인번호

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
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
		
	

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

event ue_insertend;call super::ue_insertend;//String ls_std_ym
//
//dw_con.accepttext()
//
//ls_std_ym = dw_con.object.std_ym[1]
//
//If ls_std_ym = '' or isnull(ls_std_ym) then
//	Messagebox("알림", "기준년월을 확인하세요!")
//	dw_con.setfocus()
//	dw_con.setcolumn('std_ym')
//	RETURN -1
//End If
//
//This.object.std_ym[al_row] = ls_std_ym
RETURN 1
end event

type uc_row_insert from u_picture within w_hyd202a
integer x = 3890
integer y = 1684
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;If dw_main.RowCount() > 0 Then
	dw_sub.PostEvent("ue_InsertRow")
End If

end event

type uc_row_delete from u_picture within w_hyd202a
integer x = 4169
integer y = 1684
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_sub.PostEvent("ue_DeleteRow")

end event

type dw_sub from uo_grid within w_hyd202a
event type long ue_retrieve ( )
integer x = 50
integer y = 1784
integer width = 4375
integer height = 480
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hyd202a_3"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

event ue_insertstart;call super::ue_insertstart;String ls_std_ym, ls_member_no, ls_mng_no

dw_main.accepttext()

ls_std_ym = dw_main.object.std_ym[1]
ls_member_no = dw_main.object.member_no[1]
ls_mng_no = dw_main.object.mng_no[1]

If ls_std_ym = '' or isnull(ls_std_ym) Then
	Messagebox("알림", "기준년월을 입력하세요!")
	dw_main.setfocus()
	dw_main.setcolumn('std_ym')
	return -1
End If

If ls_member_no = '' or isnull(ls_member_no) Then
	Messagebox("알림", "사번을 입력하세요!")
	dw_main.setfocus()
	dw_main.setcolumn('member_no')
	return -1
End If

If ls_mng_no = '' or isnull(ls_mng_no) Then
	Messagebox("알림", "관리번호를 입력하세요!")
	dw_main.setfocus()
	dw_main.setcolumn('mng_no')
	return -1
End If

return 1



end event

event ue_insertend;call super::ue_insertend;String ls_std_ym, ls_member_no, ls_mng_no
Long ll_seq_no

dw_main.accepttext()

ls_std_ym = dw_main.object.std_ym[1]
ls_member_no = dw_main.object.member_no[1]
ls_mng_no = dw_main.object.mng_no[1]

This.object.std_ym[al_row] = ls_std_ym
This.object.member_no[al_row] = ls_member_no
This.object.mng_no[al_row] = ls_mng_no
This.object.include_gb[al_row] = '1'  //논문게재실적 참여자 명단 귀속구분

If al_row = 1 then 
	ll_seq_no = 1
Else
	ll_seq_no = This.object.seq_no[al_row - 1] + 1
End If
This.object.seq_no[al_row] = ll_seq_no

return 1


end event

event itemchanged;call super::itemchanged;
String		ls_h01nno	,ls_h01knm


This.accepttext()
Choose Case	dwo.name
	Case	'pcn_rschr_reg_no','prtcpnt_nm'
		If dwo.name = 'pcn_rschr_reg_no' Then	ls_h01nno = data
		If dwo.name = 'prtcpnt_nm' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'pcn_rschr_reg_no'	, '')
			This.Post SetItem(row, 'prtcpnt_nm'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_h01nno , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_h01nno || '%'
		AND NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.pcn_rschr_reg_no[row] = ls_h01nno
			This.object.prtcpnt_nm[row] = ls_h01knm
			
		Else
			This.Trigger Event doubleclicked(-1, 0, row, This.object.pcn_rschr_reg_no)
			return 1
			
		End If	
		
	

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

event doubleclicked;call super::doubleclicked;If dwo.name = 'pcn_rschr_reg_no' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_member_no
This.accepttext()
ls_KName =  trim(this.object.prtcpnt_nm[1])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = '1'//교직원구분 -교원

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	this.SetFocus()
	this.setcolumn('prtcpnt_nm')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.prtcpnt_nm[1]        = ls_kname					//성명
This.object.pcn_rschr_reg_no[1]     = ls_Member_No				//개인번호

End If
end event

type st_main from statictext within w_hyd202a
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
string text = "연구논문 게재실적 등록"
boolean focusrectangle = false
end type

type st_detail from statictext within w_hyd202a
boolean visible = false
integer x = 1417
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
string text = "detail desc"
boolean focusrectangle = false
end type

type p_2 from picture within w_hyd202a
boolean visible = false
integer x = 1353
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_hyd202a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_hyd202a
integer x = 50
integer y = 1712
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_sub from statictext within w_hyd202a
integer x = 114
integer y = 1700
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
string text = "논문게재실적 참여자명단"
boolean focusrectangle = false
end type

type uo_app from uo_imgbtn within w_hyd202a
integer x = 50
integer y = 36
integer taborder = 20
boolean bringtotop = true
string btnname = "논문게재료신청"
end type

on uo_app.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;Vector	lvc_data
String ls_std_ym, ls_member_no, ls_mng_no

lvc_data = Create Vector

dw_list.accepttext()
If dw_list.rowcount() = 0 Then RETURN 

ls_std_ym = dw_list.object.std_ym[dw_list.getrow()]
ls_member_no = dw_list.object.member_no[dw_list.getrow()]
ls_mng_no = dw_list.object.mng_no[dw_list.getrow()]

lvc_data.setproperty("std_ym", ls_std_ym)
lvc_data.setproperty("member_no", ls_member_no)
lvc_data.setproperty("mng_no", ls_mng_no)
lvc_data.setproperty("support_gb", '1')

OpenWithParm(w_hyd200_pop,lvc_data)

return 


end event

