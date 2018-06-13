$PBExportHeader$w_hml201a.srw
$PBExportComments$[w_list_list] 부처별학생마일리지신청
forward
global type w_hml201a from w_window
end type
type dw_list from uo_grid within w_hml201a
end type
type dw_con from uo_dw within w_hml201a
end type
type dw_main from uo_grid within w_hml201a
end type
type uc_row_insert from u_picture within w_hml201a
end type
type uc_row_delete from u_picture within w_hml201a
end type
type st_main from statictext within w_hml201a
end type
type p_1 from picture within w_hml201a
end type
type p_2 from picture within w_hml201a
end type
type st_detail from statictext within w_hml201a
end type
type uo_all from uo_imgbtn within w_hml201a
end type
type uo_deselect from uo_imgbtn within w_hml201a
end type
end forward

global type w_hml201a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
dw_main dw_main
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
st_main st_main
p_1 p_1
p_2 p_2
st_detail st_detail
uo_all uo_all
uo_deselect uo_deselect
end type
global w_hml201a w_hml201a

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

on w_hml201a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.dw_main=create dw_main
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.st_main=create st_main
this.p_1=create p_1
this.p_2=create p_2
this.st_detail=create st_detail
this.uo_all=create uo_all
this.uo_deselect=create uo_deselect
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.uc_row_insert
this.Control[iCurrent+5]=this.uc_row_delete
this.Control[iCurrent+6]=this.st_main
this.Control[iCurrent+7]=this.p_1
this.Control[iCurrent+8]=this.p_2
this.Control[iCurrent+9]=this.st_detail
this.Control[iCurrent+10]=this.uo_all
this.Control[iCurrent+11]=this.uo_deselect
end on

on w_hml201a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.st_main)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.uo_all)
destroy(this.uo_deselect)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_list )
This.Event ue_resize_dw( st_line2, dw_main )

dw_con.settransobject(sqlca)
dw_con.insertrow(0)

//idw_update[1]	= dw_main//dw_list

dw_con.Object.std_year[dw_con.GetRow()] 	= func.of_get_sdate('yyyy')

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

//idw_update[2]	= dw_main
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= dw_main

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

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_tempright.beginx

If uc_row_delete.Enabled Then
	uc_row_delete.X			= ll_stnd_pos - uc_row_delete.Width
	ll_stnd_pos			= ll_stnd_pos - uc_row_delete.Width - 16
	uc_row_delete.Visible	= TRUE
Else
	uc_row_delete.Visible	= FALSE
End If

If uc_row_insert.Enabled Then
	uc_row_insert.X			= ll_stnd_pos - uc_row_insert.Width
	ll_stnd_pos			= ll_stnd_pos - uc_row_insert.Width - 16
	uc_row_insert.Visible	= TRUE
Else
	uc_row_insert.Visible	= FALSE
End If

ll_stnd_pos    = uo_all.x

If uo_all.Enabled Then
	ll_stnd_pos			= ll_stnd_pos + uo_all.Width + 16
Else
	uo_all.Visible	= FALSE
End If

If uo_deselect.Enabled Then
	uo_deselect.X			= ll_stnd_pos
	ll_stnd_pos			= ll_stnd_pos + uo_deselect.Width + 16
Else
	uo_deselect.Visible	= FALSE
End If


end event

event ue_save;//

Long ll_i, ll_seq, ll_request_point, ll_cnt, ll_total = 0, ll_total_point = 0
String ls_yn, ls_err
String ls_budget_year, ls_gwa, ls_point_item, ls_hakbun, ls_req_dt
dw_main.accepttext()

For ll_i =  1 to dw_main.rowcount()
	ls_yn = dw_main.object.chk[ll_i]
	If ls_yn = 'Y' Then
		ll_total ++
		
		ls_budget_year = dw_main.object.budget_year[ll_i]
		ls_gwa = trim(dw_main.object.gwa[ll_i])
		ls_point_item = dw_main.object.point_item[ll_i]
		ls_hakbun = dw_main.object.hakbun[ll_i]
		ll_seq = dw_main.object.seq[ll_i]
		
		
		ll_request_point = dw_main.object.request_point[ll_i]
		ll_total_point = ll_total_point + ll_request_point
		ls_req_dt = dw_main.object.req_dt[ll_i]
		
		SELECT COUNT(*)
		INTO  :ll_cnt
		FROM HAKSA.POINT_GWA_USE
		WHERE BUDGET_YEAR = :ls_budget_year
		AND GWA = :ls_gwa
		AND POINT_ITEM = :ls_point_item
		AND HAKBUN = :ls_hakbun
		AND SEQ = :ll_seq;
		
		If ll_cnt > 0 Then
		
			UPDATE HAKSA.POINT_GWA_USE
			SET REQ_DT = :ls_req_dt,
			REQUEST_POINT = :ll_request_point,
			JOB_UID = :gs_empcode ,
			JOB_ADD = :gs_ip,
			JOB_DATE = sysdate
			WHERE BUDGET_YEAR = :ls_budget_year
			AND GWA = :ls_gwa
			AND POINT_ITEM = :ls_point_item
			AND HAKBUN = :ls_hakbun
			AND SEQ = :ll_seq
			USING SQLCA;
			
			If SQLCA.SQLCODE <> 0 Then
				ls_err =  SQLCA.SQLERRTEXT
				ROLLBACK USING SQLCA;
				f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
				Messagebox("알림" , ls_err)
				RETURN -1
			End If
		Else
			
			SELECT MAX(SEQ) + 1
			INTO  :ll_seq
			FROM HAKSA.POINT_GWA_USE
			WHERE BUDGET_YEAR = :ls_budget_year
			AND GWA = :ls_gwa
			AND POINT_ITEM = :ls_point_item
			AND HAKBUN = :ls_hakbun ;
			
			If ll_seq = 0 or isnull(ll_seq) Then ll_seq = 1
			
			INSERT INTO HAKSA.POINT_GWA_USE
			(        BUDGET_YEAR      ,GWA	       ,POINT_ITEM       ,HAKBUN       ,SEQ
			       ,REQ_DT       ,REQUEST_POINT       ,APPROVAL_POINT       ,APPROVAL_DT
			       ,APPROVAL_YN	       ,APPROVAL_DELAY_MEMO	
			       ,WORKER       ,IPADDR       ,WORK_DATE       ,JOB_UID       ,JOB_ADD       ,JOB_DATE)
			VALUES 
			(:ls_budget_year,  :ls_gwa,  :ls_point_item, :ls_hakbun,  :ll_seq
			, :ls_req_dt, :ll_request_point, 0, '' 
			, '1', ''
			,:gs_empcode, :gs_ip, sysdate			,:gs_empcode, :gs_ip, sysdate )
			USING SQLCA;
			
			If SQLCA.SQLCODE <> 0 Then
				ls_err =  SQLCA.SQLERRTEXT
				ROLLBACK USING SQLCA;
				f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
				Messagebox("알림" , ls_err)
				RETURN -1
			End If
		End If
	End If
Next	

If ll_total > 0 Then
	UPDATE HAKSA.POINT_GWA_BUDGET
	SET		REQUEST_POINT = (SELECT 	SUM(REQUEST_POINT) 
											FROM 	HAKSA.POINT_GWA_USE 
											WHERE 	BUDGET_YEAR = :ls_budget_year
											AND 		GWA = :ls_gwa
											AND 		POINT_ITEM = :ls_point_item)
	WHERE 	BUDGET_YEAR = :ls_budget_year
	AND 		GWA = :ls_gwa
	AND 		POINT_ITEM = :ls_point_item
	USING SQLCA ;

	If SQLCA.SQLCODE <> 0 Then
		ls_err =  SQLCA.SQLERRTEXT
		ROLLBACK USING SQLCA;
		f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
		Messagebox("알림" , ls_err)
		RETURN -1
	End If
	
	COMMIT USING SQLCA;
	f_set_message("[저장] " + '성공적으로 저장되었습니다.', '', parentwin)
Else
	f_set_message("[저장] " + '변경된 내용이 없습니다.', '', parentwin)
End If

This.Event ue_inquiry()

RETURN 1
end event

type ln_templeft from w_window`ln_templeft within w_hml201a
end type

type ln_tempright from w_window`ln_tempright within w_hml201a
end type

type ln_temptop from w_window`ln_temptop within w_hml201a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hml201a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hml201a
end type

type ln_tempstart from w_window`ln_tempstart within w_hml201a
end type

type uc_retrieve from w_window`uc_retrieve within w_hml201a
end type

type uc_insert from w_window`uc_insert within w_hml201a
end type

type uc_delete from w_window`uc_delete within w_hml201a
end type

type uc_save from w_window`uc_save within w_hml201a
end type

type uc_excel from w_window`uc_excel within w_hml201a
end type

type uc_print from w_window`uc_print within w_hml201a
end type

type st_line1 from w_window`st_line1 within w_hml201a
end type

type st_line2 from w_window`st_line2 within w_hml201a
end type

type st_line3 from w_window`st_line3 within w_hml201a
end type

type uc_excelroad from w_window`uc_excelroad within w_hml201a
end type

type dw_list from uo_grid within w_hml201a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 684
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hml201a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_year, ls_gwa
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.std_year[dw_con.GetRow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.GetRow()], '%') 

If ls_year = '' or isnull(ls_year) Then 
	Messagebox("알림", "년도를 입력하세요!")
	RETURN -1
End If



dw_main.Reset()
ll_rv = THIS.Retrieve(ls_year, ls_gwa)

RETURN ll_rv

end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_rv

This.AcceptText()

ll_rv = Parent.Event ue_row_updatequery() 

If currentrow > 0 and (ll_rv = 1 or ll_rv = 2) Then
	If dw_list.GetItemStatus(currentrow, 0, Primary!) <> New! Then
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

event ue_deletestart;call super::ue_deletestart;Long		ll_cnt

If dw_list.GetRow() > 0 Then

	ll_cnt = dw_main.RowCount()
	
	If ll_cnt > 0 Then
//		gf_message(parentwin, 2, '9999', '알림', '해당 데이터에 대한 자식데이타가 존재합니다. 삭제할 수 없습니다.')
//		RETURN -1
		dw_main.uf_DeleteAll()
		RETURN 1
	Else
		RETURN 1
	End If

Else
	RETURN 1
End If

end event

event retrieveend;call super::retrieveend;If rowcount = 0 Then RETURN -1
This.setrow(1)
dw_main.event ue_retrieve()

end event

type dw_con from uo_dw within w_hml201a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hml201a_con"
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

type dw_main from uo_grid within w_hml201a
event type long ue_retrieve ( )
integer x = 50
integer y = 1236
integer width = 4389
integer height = 1028
integer taborder = 20
string dataobject = "d_hml201a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

event type long ue_retrieve();Long		ll_row
String		ls_year , ls_gwa, ls_hakyun, ls_hakbun
String		ls_point_item
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = trim(dw_list.object.budget_year[ll_row])
ls_gwa = trim(dw_list.object.gwa[ll_row]) 
ls_point_item = trim(dw_list.object.point_item[ll_row])
ls_hakyun = func.of_nvl(dw_con.object.hakyun[dw_con.getrow()]  ,'%')
ls_hakbun = func.of_nvl(dw_con.object.hakbun[dw_con.getrow()] , '%')



ll_rv = dw_main.Retrieve(ls_year, ls_gwa, ls_hakyun, ls_hakbun, ls_point_item)

RETURN ll_rv

end event

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_hname, ls_gwa, ls_hakyun, ls_point_item, ls_year, ls_gwa_nm
Long	ll_seq, ll_find, ll_point

This.accepttext()
Choose Case	dwo.name
	Case 'chk'
		If data = 'Y' Then
			ls_point_item = This.object.point_item[row]
			
			SELECT NVL(STD_POINT, 0)
			INTO :ll_point
			FROM  HAKSA.POINT_RULE 
				WHERE POINT_ITEM = :ls_point_item ;
				
			If isnull(ll_point 	) Then ll_point = 0
			
			this.object.req_dt[row] = func.of_get_sdate('yyyymmdd')	
			this.object.request_point[row] = ll_point
		End If
				
		
		
	Case	'hakbun','hname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'hname' Then	ls_hname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'hname'	, '')			
			This.post Setitem(row, 'su_hakyun', '')
			RETURN
		End If
		
		SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME,
							A.gwa,  A.DR_HAKYUN,
							 (SELECT FNAME FROM CDDB.KCH003M WHERE TRIM(GWA)= TRIM(A.GWA) ) AS GWA_nm  
			INTO :ls_hakbun , :ls_hname	, :ls_gwa, :ls_hakyun, :ls_gwa_nm			
				FROM		HAKSA.JAEHAK_HAKJUK A					
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_hname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			
//			If trim(this.object.gwa[row]) <> left(ls_gwa, 3) Then
//				Messagebox("알림", "해당 학과 소속 학생이 아닙니다!")
//				This.Post SetItem(row, 'hakbun'	, '')
//				This.Post SetItem(row, 'hname'	, '')					
//				This.post Setitem(row, 'su_hakyun', '')
//				RETURN 
//			End If
				
			This.object.hakbun[row] = ls_hakbun
			This.object.hname[row] = ls_hname
			This.object.su_hakyun[row] = ls_hakyun
			This.object.gwa_nm[row] = ls_gwa_nm
			
			ls_year = This.object.budget_year[row]
			ls_gwa = This.object.gwa[row]
			ls_point_item = This.object.point_item[row]
			
			SELECT MAX(SEQ) + 1
			  INTO :LL_SEQ
			  FROM HAKSA.POINT_GWA_USE
			  WHERE BUDGET_YEAR = :ls_year
			  AND GWA = :ls_gwa
			  AND POINT_ITEM = :ls_point_item
			  AND HAKBUN = :ls_hakbun;
			  
			  If isnull(ll_seq) Then ll_seq = 1
			  
			  ll_find = This.find("budget_year = '" + ls_year + "'  and gwa = '" + ls_gwa  + "' and point_item = '" + ls_point_item + &
			                                         "' and hakbun = '" + ls_hakbun + "' and seq = " + string(ll_seq) , this.rowcount(), 1)
							 
			If ll_find  > 0 Then
				ll_seq = this.object.seq[ll_find] + 1
			end if
			this.object.seq[row]  = ll_seq
				
				
							 
			
			
		Else
			This.Trigger Event doubleclicked(-1, 0, row, This.object.hakbun)
			return 1
			
		End If	
End Choose


end event

event doubleclicked;call super::doubleclicked;If dwo.name = 'hakbun'  or dwo.name = 'hname' Then
	
s_insa_com	lstr_com
String		ls_hName, ls_hakbun, ls_gwa, ls_hakyun, ls_year, ls_point_item, ls_gwa_nm
Long		ll_seq, ll_find
This.accepttext()
ls_hname =  trim(this.object.hname[row])



OpenWithParm(w_hsg_hakjuk,ls_hname)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	this.SetFocus()
	this.setcolumn('hname')
	RETURN
END IF

ls_hname               = lstr_com.ls_item[2]	//성명
ls_hakbun            = lstr_com.ls_item[1]	//학번
ls_gwa_nm		= lstr_com.ls_item[4] //학과명
ls_hakyun		= lstr_com.ls_item[5] //학년

String ls_gwa1
ls_gwa1 =  trim(this.object.gwa[row]) 
//If ls_gwa1 <> left(ls_gwa, 3) Then
//	Messagebox("알림", "해당 학과 소속 학생이 아닙니다!")
//	This.Post SetItem(row, 'hakbun'	, '')
//	This.Post SetItem(row, 'hname'	, '')	
//	This.post Setitem(row, 'su_hakyun', '')
//	RETURN 
//End If
//

this.object.hname[row]        = ls_hname					//성명
This.object.hakbun[row]     = ls_hakbun				//개인번호
This.object.su_hakyun[row] = ls_hakyun
This.object.gwa_nm[row] = ls_gwa_nm

ls_year = This.object.budget_year[row]
	ls_point_item = This.object.point_item[row]
			
SELECT MAX(SEQ) + 1
  INTO :LL_SEQ
  FROM HAKSA.POINT_GWA_USE
  WHERE BUDGET_YEAR = :ls_year
  AND GWA = :ls_gwa1
  AND POINT_ITEM = :ls_point_item
  AND HAKBUN = :ls_hakbun;
  
  If isnull(ll_seq) Then ll_seq = 1
  
  ll_find = This.find("budget_year = '" + ls_year + "'  and gwa = '" + ls_gwa1  + "' and point_item = '" + ls_point_item + &
				 "' and hakbun = '" + ls_hakbun + "' and seq = " + string(ll_seq) , this.rowcount(), 1)
				 
If ll_find  > 0 Then
	ll_seq = this.object.seq[ll_find] + 1
end if
this.object.seq[row]  = ll_seq


return 1
End If
end event

event ue_insertstart;call super::ue_insertstart;If dw_list.rowcount() = 0 Then RETURN -1

return 1
end event

event ue_insertend;call super::ue_insertend;Long		ll_row, ll_point
String		ls_year, ls_gwa, ls_point_item
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = trim(dw_list.object.budget_year[ll_row])
ls_gwa = trim(dw_list.object.gwa[ll_row])
ls_point_item = dw_list.object.point_item[ll_row]

SELECT NVL(STD_POINT, 0)
INTO :ll_point
FROM  HAKSA.POINT_RULE 
	WHERE POINT_ITEM = :ls_point_item ;


	
If isnull(ll_point 	) Then ll_point = 0
		
This.object.request_point[al_row] = ll_point
This.object.budget_year[al_row] = ls_year
this.object.gwa[al_row] = ls_gwa
This.object.point_item[al_row] = ls_point_item
This.object.chk[al_row] = 'Y'
this.object.req_dt[al_row] = func.of_get_sdate('YYYYMMDD')


	
			

RETURN 1

end event

event ue_deleterow;If This.rowcount() = 0 Then RETURN -1
Long ll_i, ll_seq
String ls_budget_year, ls_gwa, ls_point_item, ls_hakbun, ls_err

ll_i = This.getrow()

ls_budget_year = dw_main.object.budget_year[ll_i]
ls_gwa = trim(dw_main.object.gwa[ll_i])
ls_point_item = dw_main.object.point_item[ll_i]
ls_hakbun = dw_main.object.hakbun[ll_i]
ll_seq = dw_main.object.seq[ll_i]


DELETE
FROM HAKSA.POINT_GWA_USE
WHERE BUDGET_YEAR = :ls_budget_year
AND GWA = :ls_gwa
AND POINT_ITEM = :ls_point_item
AND HAKBUN = :ls_hakbun
AND SEQ = :ll_seq;


If SQLCA.SQLCODE <> 0 Then
	ls_err =  SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	f_set_message("[삭제] " + '오류가 발생했습니다.', '', parentwin)
	Messagebox("알림" , ls_err)
	RETURN -1
End If

Commit USING SQLCA;

This.deleterow(ll_i)
f_set_message("[삭제] " + '삭제되었습니다.', '', parentwin)


RETURN 1
end event

type uc_row_insert from u_picture within w_hml201a
boolean visible = false
integer x = 3895
integer y = 1124
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;Long	ll_row, ll_assign_point, ll_supply_point, ll_request_point

ll_row = dw_list.GetRow()

If ll_row > 0 Then
	ll_assign_point = dw_list.Object.assign_point[ll_row]
	ll_supply_point = dw_list.Object.supply_point[ll_row]
	ll_request_point = dw_list.Object.request_point[ll_row]
	
	If isNull(ll_assign_point) Then ll_assign_point = 0
	If isNull(ll_supply_point) Then ll_assign_point = 0
	If isNull(ll_request_point) Then ll_request_point = 0
	
	If (ll_assign_point + ll_supply_point - ll_request_point) <= 0 Then
		MessageBox("확인","신청가능한 마일리지가 없습니다.")
		Return -1
	End If
	dw_main.PostEvent("ue_InsertRow")
End If

end event

type uc_row_delete from u_picture within w_hml201a
boolean visible = false
integer x = 4174
integer y = 1124
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_main.PostEvent("ue_DeleteRow")

end event

type st_main from statictext within w_hml201a
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
string text = "학과/부서별 마일리지 예산정보"
boolean focusrectangle = false
end type

type p_1 from picture within w_hml201a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_hml201a
integer x = 50
integer y = 1144
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_hml201a
integer x = 114
integer y = 1132
integer width = 937
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
string text = "학과/부서별 학생마일리지 등록"
boolean focusrectangle = false
end type

type uo_all from uo_imgbtn within w_hml201a
integer x = 1083
integer y = 1132
integer taborder = 20
boolean bringtotop = true
string btnname = "전체선택"
end type

event clicked;call super::clicked;String ls_req_dt, ls_point_item
Long ll_row, ll_point

ls_req_dt = func.of_get_sdate('yyyymmdd')		

For ll_row = 1 to dw_main.rowcount()
	If dw_main.object.chk[ll_row] <> 'Y' Then
		dw_main.object.chk[ll_row] = 'Y'
		dw_main.object.req_dt[ll_row] = ls_req_dt
		ls_point_item = dw_main.object.point_item[ll_row]
			
			SELECT NVL(STD_POINT, 0)
			INTO :ll_point
			FROM  HAKSA.POINT_RULE 
				WHERE POINT_ITEM = :ls_point_item ;
				
			If isnull(ll_point 	) Then ll_point = 0
					
			dw_main.object.request_point[ll_row] = ll_point
	End If
Next


end event

on uo_all.destroy
call uo_imgbtn::destroy
end on

type uo_deselect from uo_imgbtn within w_hml201a
integer x = 1509
integer y = 1136
integer taborder = 40
boolean bringtotop = true
string btnname = "전체선택해제"
end type

event clicked;call super::clicked;Long ll_row


If dw_main.rowcount() = 0 Then return 

For ll_row = 1 To dw_main.rowcount()
	dw_main.object.chk[ll_row] = 'N'
Next
end event

on uo_deselect.destroy
call uo_imgbtn::destroy
end on

