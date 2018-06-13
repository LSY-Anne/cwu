$PBExportHeader$w_hjk221a.srw
$PBExportComments$[청운대]휴학신청승인-신규
forward
global type w_hjk221a from w_window
end type
type dw_main from uo_grid within w_hjk221a
end type
type dw_con from uo_dw within w_hjk221a
end type
type dw_detail from uo_dw within w_hjk221a
end type
type uo_approve from uo_imgbtn within w_hjk221a
end type
end forward

global type w_hjk221a from w_window
event type long ue_row_updatequery ( )
dw_main dw_main
dw_con dw_con
dw_detail dw_detail
uo_approve uo_approve
end type
global w_hjk221a w_hjk221a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE
String     is_sign_nm
uo_comm_send u_comm_send
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
	If ib_list_chk	=	FALSE and ldw_modified[ll_i] = dw_detail Then Continue
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
					If ib_list_chk	=	FALSE and idw_update[ll_i] = dw_detail Then Continue
					idw_update[ll_i].resetUpdate()
				Next
				ll_cnt = UpperBound(idw_modified)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_modified[ll_i] = dw_detail Then Continue
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

public function integer wf_validall ();Integer	li_rtn, i, li_row
String     ls_sign_status, ls_sign_status_nm

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next



end function

on w_hjk221a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.dw_detail=create dw_detail
this.uo_approve=create uo_approve
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_detail
this.Control[iCurrent+4]=this.uo_approve
end on

on w_hjk221a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.dw_detail)
destroy(this.uo_approve)
end on

event ue_postopen;call super::ue_postopen;String	ls_year, ls_hakgi, ls_admin, ls_gwa, ls_bojik_code
Long   ll_cnt = 0

func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )
dw_con.settransobject(sqlca)
dw_con.insertrow(0)

dw_detail.insertrow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMM') + '01'
dw_con.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')

idw_update[1]	= dw_main

u_comm_send = Create uo_comm_send

// 지도교수인지 체크
SELECT COUNT(*)
   INTO :ll_cnt
   FROM HAKSA.SUM210TL A
	      , HAKSA.HAKSA_ILJUNG  B
  WHERE A.YEAR  = B.YEAR
     AND  A.HAKGI = B.HAKGI
	AND  A.MEMBER_NO = :gs_empcode
     AND  B.SIJUM_FLAG = 'Y'
	AND ROWNUM = 1
  USING SQLCA ;
  
If ll_cnt > 0 Then
	is_sign_nm = '1'
End If
  
SELECT GWA,    BOJIK_CODE1
   INTO :ls_gwa, :ls_bojik_code
   FROM INDB.HIN001M
  WHERE MEMBER_NO = :gs_empcode
  USING SQLCA ;

// 학과장
If  ls_bojik_code = '0024' Then
	is_sign_nm = '2'
End If

// 교무처
If ls_gwa = '1100'  Then
	is_sign_nm = '3'
End If

// 테스트시
If  gs_empcode = 'admin'  Then
	is_sign_nm = '1'
	gs_empcode = 'A0039'
End If

dw_con.Object.sign_nm[1] = is_sign_nm
  
// dddw 값 셋팅(공통코드)
//Vector lvc_data
//
//lvc_data = Create Vector
//
//lvc_data.setProperty('column1', 'sayu_id') // 휴학사유
//lvc_data.setProperty('key1', 'B')
//
//func.of_dddw( dw_main,lvc_data)
//func.of_dddw( dw_detail,lvc_data)

DataWindowChild	ldwc_child, ldwc_child1

dw_main.GetChild('sayu_id', ldwc_child)
ldwc_child.SetTransObject(SQLCA)
ldwc_child.Retrieve('B')

dw_detail.GetChild('sayu_id', ldwc_child1)
ldwc_child1.SetTransObject(SQLCA)
ldwc_child1.Retrieve('B')


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

ll_rv = This.Event ue_updatequery() 

If  (ll_rv = 1 Or ll_rv = 2) Then

	ll_rv = dw_main.Event ue_InsertRow()
	
	dw_detail.Reset()
	dw_detail.Event ue_InsertRow()
	
	ls_txt = "[신규] "
	If ll_rv = 1 Then
		f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
	ElseIf ll_rv = 0 Then
		
	Else
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	End If

End If

end event

event ue_delete;call super::ue_delete;Long		ll_rv
String		ls_txt

ll_rv = dw_detail.Event ue_DeleteRow()

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

event ue_savestart;call super::ue_savestart;Long    i,  ll_cnt
String  ls_sign_status, ls_return_remark
dwItemStatus 	l_status

ll_cnt = dw_main.Rowcount()

For i = 1 To ll_cnt
	l_status = dw_main.GetItemStatus(i, 0, Primary!)
	
	If l_status = DataModified! Then
		ls_sign_status = dw_main.Object.sign_status[i]
		
		If ls_sign_status = '9' Then
			ls_return_remark = Trim(dw_main.Object.return_remark[i])
			
			If ls_return_remark = '' Or Isnull(ls_return_remark) Then
				Messagebox('확인', '반려사유를 입력하세요!')
				dw_main.SetFocus()
				dw_main.ScrollToRow(i)
				dw_main.SetRow(i)
				dw_main.SetColumn("return_remark")
				Return -1
			End If
			
		End If
		
	End If
Next

Return 1
end event

event ue_saveend;call super::ue_saveend;Long    i,  ll_cnt, ll_sms_cnt = 0, ll_sms_cnt1 = 0
String  ls_sign_status, ls_return_remark, ls_hakbun
String ls_name, ls_hp_no, ls_dest_info, ls_dest_info1
dwItemStatus 	l_status

ll_cnt = dw_main.Rowcount()

For i = 1 To ll_cnt
	l_status = dw_main.GetItemStatus(i, 0, Primary!)
	
	If l_status = DataModified! Then
		ls_sign_status = dw_main.Object.sign_status[i]
		ls_hakbun       = dw_main.Object.hakbun[i]
		
		// 반려일경우 학생에게 sms발송.
		If ls_sign_status = '9' Then
			// SMS 발송.

			 SELECT HNAME,    HP
				INTO :ls_name, :ls_hp_no
				FROM HAKSA.JAEHAK_HAKJUK
			  WHERE HAKBUN = :ls_hakbun
				USING SQLCA ;
			  
			If sqlca.sqlcode = 0 Then 
				ll_sms_cnt   = ll_sms_cnt + 1
				ls_dest_info = ls_name + "^" + ls_hp_no + "|"
			End If
		
		// 승인(지도교수)일경우 학과장에게 sms발송.
		ElseIf ls_sign_status = '1' Then
			// SMS 발송.
			 SELECT B.NAME, C.CELL_PHONENO1 || C.CELL_PHONENO2 || C.CELL_PHONENO3
				INTO :ls_name, :ls_hp_no
				FROM HAKSA.JAEHAK_HAKJUK A
						, INDB.HIN001M B
						, INDB.HIN011M C
			  WHERE SUBSTR(A.GWA,1,3)  = SUBSTR(B.GWA,1,3)
				  AND B.MEMBER_NO = C.MEMBER_NO
				  AND  A.HAKBUN = :ls_hakbun
				  AND B.BOJIK_CODE1 = '0024'
				  AND ROWNUM = 1
				USING SQLCA ;
				
			If sqlca.sqlcode = 0 Then
				ll_sms_cnt1   = ll_sms_cnt1 + 1
				ls_dest_info1 = ls_name + "^" + ls_hp_no + "|"
			End If

		End If
		
	End If // If l_status = DataModified! Then.....end.
Next

If ll_sms_cnt > 0 Then
	u_comm_send.of_send_sms( 'HJK09', '0002', 'academic', string(ll_sms_cnt), ls_dest_info, '' )
End If
If ll_sms_cnt1 > 0 Then
	u_comm_send.of_send_sms( 'HJK09', '0003', 'academic', string(ll_sms_cnt1), ls_dest_info1, '' )
End If

Return 1
end event

type ln_templeft from w_window`ln_templeft within w_hjk221a
end type

type ln_tempright from w_window`ln_tempright within w_hjk221a
end type

type ln_temptop from w_window`ln_temptop within w_hjk221a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hjk221a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hjk221a
end type

type ln_tempstart from w_window`ln_tempstart within w_hjk221a
end type

type uc_retrieve from w_window`uc_retrieve within w_hjk221a
end type

type uc_insert from w_window`uc_insert within w_hjk221a
end type

type uc_delete from w_window`uc_delete within w_hjk221a
end type

type uc_save from w_window`uc_save within w_hjk221a
end type

type uc_excel from w_window`uc_excel within w_hjk221a
end type

type uc_print from w_window`uc_print within w_hjk221a
end type

type st_line1 from w_window`st_line1 within w_hjk221a
end type

type st_line2 from w_window`st_line2 within w_hjk221a
end type

type st_line3 from w_window`st_line3 within w_hjk221a
end type

type uc_excelroad from w_window`uc_excelroad within w_hjk221a
end type

type dw_main from uo_grid within w_hjk221a
event type long ue_retrieve ( )
integer x = 50
integer y = 312
integer width = 4384
integer height = 648
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk221a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_from_dt, ls_to_dt, ls_sign_gb, ls_sign_status[]
Long		ll_rv,          ll_row

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ll_row = dw_con.GetRow()

ls_from_dt = dw_con.Object.from_dt[ll_row]
ls_to_dt     = dw_con.Object.to_dt[ll_row]
ls_sign_gb = dw_con.Object.sign_gb[ll_row]

Choose Case is_sign_nm
	Case '1'
		If ls_sign_gb = '1' Then
			ls_sign_status[1] = '0'
			ls_sign_status[2] = '1'
			ls_sign_status[3] = '2'
			ls_sign_status[4] = '3'
			ls_sign_status[5] = '9'
		ElseIf ls_sign_gb = '2' Then
			ls_sign_status[1] = '0'
		Else
			ls_sign_status[1] = '1'
			ls_sign_status[2] = '2'
			ls_sign_status[3] = '3'
		End If
		
	Case '2'
		If ls_sign_gb = '1' Then
			ls_sign_status[1] = '1'
			ls_sign_status[2] = '2'
			ls_sign_status[3] = '3'
			ls_sign_status[4] = '9'
		ElseIf ls_sign_gb = '2' Then
			ls_sign_status[1] = '1'
		Else
			ls_sign_status[1] = '2'
			ls_sign_status[2] = '3'
		End If
End Choose

ll_rv = This.Retrieve(ls_from_dt, ls_to_dt, '1', gs_empcode, is_sign_nm, ls_sign_status )

RETURN ll_rv

end event

event rowfocuschanged;call super::rowfocuschanged;String ls_apply_dt, ls_sign_status
Long   ll_apply_seq

If This.GetRow() < 1 Then Return ;

ls_apply_dt  = This.Object.apply_dt[currentrow]
ll_apply_seq = This.Object.apply_seq[currentrow]
ls_sign_status = This.Object.sign_status[currentrow]

dw_detail.Retrieve( ls_apply_dt, '1', ll_apply_seq )

Return 
end event

event itemchanged;call super::itemchanged;String ls_old_sign_status
DateTime   ldt_null

Setnull(ldt_null)

Choose Case dwo.name
	Case 'chk'
		ls_old_sign_status = This.Object.sign_status.Original[row]
		
		If data = 'Y' Then
			If is_sign_nm = '1' Then
				This.Object.sign_status[row] = '1'
			ElseIf is_sign_nm = '2' Then
				This.Object.sign_status[row] = '2'
			End If
			
			This.Object.member_no[row] = gs_empcode
			This.Object.sign_date[row]     = func.of_get_datetime()
		Else
			
			This.Object.sign_status[row] = ls_old_sign_status
			
			This.Object.member_no[row] = ''
			This.Object.sign_date[row]     = ldt_null
			
		End If
		
	Case 'sign_status'
		ls_old_sign_status = This.Object.sign_status.Original[row]
		
		Choose Case is_sign_nm
			Case '1'
				If ls_old_sign_status = '2' Or ls_old_sign_status = '3' Then
					Messagebox('확인', '이미 승인(학과장) 이상 결재가 되었으므로 수정할 수 없습니다..')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End If
				
				If data <> '0' and data <> '1' and data <> '9'  Then
					Messagebox('확인', '해당 결재는 권한이 없습니다.')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End IF
				
				This.Object.member_no[row] = gs_empcode
				This.Object.sign_date[row]    = func.of_get_datetime()
     		Case '2'
				If ls_old_sign_status = '3' Then
					Messagebox('확인', '이미 승인(교무처) 이상 결재가 되었으므로 수정할 수 없습니다..')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End If
				
				If data <> '1' and data <> '2' and data <> '9'  Then
					Messagebox('확인', '해당 결재는 권한이 없습니다.')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End IF
				
				This.Object.member_no[row] = gs_empcode
				This.Object.sign_date[row]    = func.of_get_datetime()
		End Choose
			
End Choose
end event

type dw_con from uo_dw within w_hjk221a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk221a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;String ls_from_dt, ls_to_dt

Choose Case dwo.name
	Case 'p_from_dt'
		ls_from_dt 	= String(This.Object.from_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'from_dt' , ls_from_dt)
		
		ls_from_dt 	= left(ls_from_dt, 4) + mid(ls_from_dt, 6, 2) + right(ls_from_dt, 2)
		This.SetItem(row, 'from_dt',  ls_from_dt)
		
	Case 'p_to_dt'
		ls_to_dt 	= String(This.Object.to_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'to_dt' , ls_to_dt)
		
		ls_to_dt 	= left(ls_to_dt, 4) + mid(ls_to_dt, 6, 2) + right(ls_to_dt, 2)
		This.SetItem(row, 'to_dt',  ls_to_dt)
End Choose
end event

type dw_detail from uo_dw within w_hjk221a
integer x = 50
integer y = 976
integer width = 4384
integer height = 1292
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk221a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_constructor;call super::ue_constructor;func.of_design_dw(dw_detail)
end event

type uo_approve from uo_imgbtn within w_hjk221a
integer x = 352
integer y = 40
integer taborder = 20
boolean bringtotop = true
string btnname = "승인"
end type

event clicked;call super::clicked;Parent.Post Event ue_save()
end event

on uo_approve.destroy
call uo_imgbtn::destroy
end on

