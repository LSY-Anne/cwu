$PBExportHeader$w_hml202a.srw
$PBExportComments$[w_list] 부처별신청마일리지승인
forward
global type w_hml202a from w_window
end type
type dw_main from uo_grid within w_hml202a
end type
type dw_con from uo_dw within w_hml202a
end type
type p_1 from picture within w_hml202a
end type
type st_main from statictext within w_hml202a
end type
type uo_appall from uo_imgbtn within w_hml202a
end type
type uo_reappall from uo_imgbtn within w_hml202a
end type
end forward

global type w_hml202a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
uo_appall uo_appall
uo_reappall uo_reappall
end type
global w_hml202a w_hml202a

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

on w_hml202a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.uo_appall=create uo_appall
this.uo_reappall=create uo_reappall
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.uo_appall
this.Control[iCurrent+6]=this.uo_reappall
end on

on w_hml202a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.uo_appall)
destroy(this.uo_reappall)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.settransobject(sqlca)
dw_con.insertrow(0)

idw_update[1]	= dw_main

dw_con.object.fr_dt[dw_con.getrow()] = func.of_get_sdate('YYYYMM') + '01'
dw_con.object.to_dt[dw_con.getrow()] = func.of_get_sdate('YYYYMMDD')

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

ll_stnd_pos    = ln_tempright.beginx

If uo_reappall.Enabled Then
	uo_reappall.X			= ll_stnd_pos - uo_reappall.Width
	ll_stnd_pos			= ll_stnd_pos - uo_reappall.Width - 16
Else
	uo_reappall.Visible	= FALSE
End If

If uo_appall.Enabled Then
	uo_appall.X		= ll_stnd_pos - uo_appall.Width
	ll_stnd_pos		= ll_stnd_pos - uo_appall.Width - 16
Else
	uo_appall.Visible	= FALSE
End If

end event

event ue_save;call super::ue_save;If Ancestorreturnvalue = 1 Then
String		ls_fr_dt, ls_to_dt, ls_gwa, ls_yn, ls_err


If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_fr_dt = dw_con.object.fr_dt[dw_con.GetRow()]
ls_to_dt = dw_con.object.to_dt[dw_con.GetRow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.Getrow()], '%') 
ls_yn = dw_con.object.app_yn[dw_con.getrow()]

  UPDATE HAKSA.POINT_GWA_BUDGET C
  SET APPROVAL_POINT = ( SELECT D.POINT FROM  
                                          (                                   
                                          SELECT 
                                                B.BUDGET_YEAR,   
                                                B.GWA,   
                                                B.POINT_ITEM,  
                                                SUM(B.APPROVAL_POINT) AS POINT
                                            FROM HAKSA.JAEHAK_HAKJUK A,   
                                                 HAKSA.POINT_GWA_USE B ,
                                        HAKSA.POINT_RULE C
                                           WHERE (A.HAKBUN =B.HAKBUN ) and  
                                         B.POINT_ITEM = C.POINT_ITEM AND
                                                 ( B.REQ_DT BETWEEN :ls_fr_dt ANd :ls_to_dt ) AND  
                                                 (:ls_gwa = '%' OR TRIM(B.GWA) = :ls_gwa ) AND
                                        (:ls_yn = '%' Or B.APPROVAL_YN = :ls_yn)
                                        GROUP BY B.BUDGET_YEAR, B.GWA, B.POINT_ITEM                                        
                                         ) D
                            WHERE D.BUDGET_YEAR = C.BUDGET_YEAR
                            AND TRIM(D.GWA) = TRIM(C.GWA)
                            AND D.POINT_ITEM = C.POINT_ITEM )                   
WHERE  EXISTS(  SELECT 1 FROM 
                                      (  SELECT 
                                                B.BUDGET_YEAR,   
                                                B.GWA,   
                                                B.POINT_ITEM
                                            FROM HAKSA.JAEHAK_HAKJUK A,   
                                                 HAKSA.POINT_GWA_USE B ,
                                        HAKSA.POINT_RULE C
                                           WHERE (A.HAKBUN =B.HAKBUN ) and  
                                         B.POINT_ITEM = C.POINT_ITEM AND
                                                 ( B.REQ_DT BETWEEN :ls_fr_dt ANd :ls_to_dt ) AND  
                                                 (:ls_gwa = '%' OR TRIM(B.GWA) = :ls_gwa ) AND
                                        (:ls_yn = '%' Or B.APPROVAL_YN = :ls_yn)
                                        GROUP BY B.BUDGET_YEAR, B.GWA, B.POINT_ITEM ) D  
                                  WHERE D.BUDGET_YEAR = C.BUDGET_YEAR
                            AND TRIM(D.GWA) = TRIM(C.GWA)
                            AND D.POINT_ITEM = C.POINT_ITEM     )          
USING SQLCA;		        
                                                                     

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("알림", ls_err)
	RETURN -1
Else
	COMMIT USING SQLCA;	
ENd If
	

	
	
End If

RETURN 1
end event

type ln_templeft from w_window`ln_templeft within w_hml202a
end type

type ln_tempright from w_window`ln_tempright within w_hml202a
end type

type ln_temptop from w_window`ln_temptop within w_hml202a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hml202a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hml202a
end type

type ln_tempstart from w_window`ln_tempstart within w_hml202a
end type

type uc_retrieve from w_window`uc_retrieve within w_hml202a
end type

type uc_insert from w_window`uc_insert within w_hml202a
end type

type uc_delete from w_window`uc_delete within w_hml202a
end type

type uc_save from w_window`uc_save within w_hml202a
end type

type uc_excel from w_window`uc_excel within w_hml202a
end type

type uc_print from w_window`uc_print within w_hml202a
end type

type st_line1 from w_window`st_line1 within w_hml202a
end type

type st_line2 from w_window`st_line2 within w_hml202a
end type

type st_line3 from w_window`st_line3 within w_hml202a
end type

type uc_excelroad from w_window`uc_excelroad within w_hml202a
end type

type dw_main from uo_grid within w_hml202a
event type long ue_retrieve ( )
integer x = 50
integer y = 392
integer width = 4389
integer height = 1800
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hml202a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_fr_dt, ls_to_dt, ls_gwa, ls_yn
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_fr_dt = dw_con.object.fr_dt[dw_con.GetRow()]
ls_to_dt = dw_con.object.to_dt[dw_con.GetRow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.Getrow()], '%') 
ls_yn = dw_con.object.app_yn[dw_con.getrow()]

ll_rv = THIS.Retrieve(ls_fr_dt, ls_to_dt, ls_gwa, ls_yn)

RETURN ll_rv

end event

event itemchanged;call super::itemchanged;String	ls_year, ls_gwa, ls_point_item, ls_err
Long	ll_point
This.accepttext()

Choose Case dwo.name
	Case 'approval_yn'
		If data = '3' Then //승인
			This.object.approval_dt[row] = func.of_get_sdate('YYYYMMDD')
			this.object.approval_point[row] = this.object.request_point[row]
			
//			ls_year = dw_main.object.budget_year[row]
//			ls_gwa = dw_main.object.gwa[row]
//			ls_point_item = dw_main.object.point_item[row]
//			ll_point = dw_main.object.request_point[row]
//			
//			UPDATE HAKSA.POINT_GWA_BUDGET
//			SET APPROVAL_POINT = NVL(APPROVAL_POINT, 0) + :ll_point
//			WHERE BUDGET_YEAR = :ls_year
//			AND GWA = :ls_gwa
//			ANd POINT_ITEM = :ls_point_item
//			USING SQLCA;
//			
//			If SQLCA.SQLCODE <> 0 Then
//				ls_err = SQLCA.SQLERRTEXT
//				ROLLBACK USING SQLCA;
//				Messagebox("알림" , ls_err)
//				RETURN
//			End If
			
		Else
			ll_point = dw_main.object.approval_point[row]
			This.object.approval_dt[row] = ''
			this.object.approval_point[row] = 0
			If data = '2' Then
				Messagebox("알림", "보류사유를 입력하세요!")
//			Else
//				ls_year = dw_main.object.budget_year[row]
//				ls_gwa = dw_main.object.gwa[row]
//				ls_point_item = dw_main.object.point_item[row]
//				
//				
//				UPDATE HAKSA.POINT_GWA_BUDGET
//				SET APPROVAL_POINT = NVL(APPROVAL_POINT, 0) + :ll_point
//				WHERE BUDGET_YEAR = :ls_year
//				AND GWA = :ls_gwa
//				ANd POINT_ITEM = :ls_point_item
//				USING SQLCA;
//				
//				If SQLCA.SQLCODE <> 0 Then
//					ls_err = SQLCA.SQLERRTEXT
//					ROLLBACK USING SQLCA;
//					Messagebox("알림" , ls_err)
//					RETURN
//				End If
			End If
		End If
			
End Choose
end event

type dw_con from uo_dw within w_hml202a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hml202a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type p_1 from picture within w_hml202a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hml202a
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
string text = "부처별 신청마일리지 승인"
boolean focusrectangle = false
end type

type uo_appall from uo_imgbtn within w_hml202a
integer x = 3694
integer y = 296
integer taborder = 20
boolean bringtotop = true
string btnname = "전체승인"
end type

on uo_appall.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;If dw_main.rowcount() = 0 Then RETURN

Long ll_row
String	ls_app_yn
String	ls_point_item, ls_gwa, ls_year, ls_err
Long	ll_point


dw_main.accepttext()
For ll_row = 1 To dw_main.rowcount()
	ls_app_yn = dw_main.object.approval_yn[ll_row]
	
	If ls_app_yn = '1' Then //미승인
		dw_main.object.approval_yn[ll_row] = '3'
		dw_main.object.approval_dt[ll_row] = func.of_get_sdate('YYYYMMDD')
		dw_main.object.approval_point[ll_row] = dw_main.object.request_point[ll_row]	
		
//		ls_year = dw_main.object.budget_year[ll_row]
//		ls_gwa = dw_main.object.gwa[ll_row]
//		ls_point_item = dw_main.object.point_item[ll_row]
//		ll_point = dw_main.object.request_point[ll_row]
//		
//		UPDATE HAKSA.POINT_GWA_BUDGET
//		SET APPROVAL_POINT = NVL(APPROVAL_POINT, 0) + :ll_point
//		WHERE BUDGET_YEAR = :ls_year
//		AND GWA = :ls_gwa
//		ANd POINT_ITEM = :ls_point_item
//		USING SQLCA;
//		
//		If SQLCA.SQLCODE <> 0 Then
//			ls_err = SQLCA.SQLERRTEXT
//			ROLLBACK USING SQLCA;
//			Messagebox("알림" , ls_err)
//			RETURN
//		End If
		
	End If
Next

parent.event ue_save()
end event

type uo_reappall from uo_imgbtn within w_hml202a
integer x = 4050
integer y = 296
integer taborder = 30
boolean bringtotop = true
string btnname = "전체승인해제"
end type

event clicked;call super::clicked;If dw_main.rowcount() = 0 Then RETURN

Long ll_row
String	ls_app_yn
String	ls_year, ls_gwa, ls_point_item, ls_err
Long	ll_point


dw_main.accepttext()
For ll_row = 1 To dw_main.rowcount()
	ls_app_yn = dw_main.object.approval_yn[ll_row]
	
	If ls_app_yn = '3' Then //미승인
		dw_main.object.approval_yn[ll_row] = '1'
		dw_main.object.approval_dt[ll_row] = ''
		
		ll_point = dw_main.object.approval_point[ll_row]
		dw_main.object.approval_point[ll_row] = 0
		
//		ls_year = dw_main.object.budget_year[ll_row]
//		ls_gwa = dw_main.object.gwa[ll_row]
//		ls_point_item = dw_main.object.point_item[ll_row]
//		
//		
//		UPDATE HAKSA.POINT_GWA_BUDGET
//		SET APPROVAL_POINT = NVL(APPROVAL_POINT, 0) - :ll_point
//		WHERE BUDGET_YEAR = :ls_year
//		AND GWA = :ls_gwa
//		ANd POINT_ITEM = :ls_point_item
//		USING SQLCA;
//		
//		If SQLCA.SQLCODE <> 0 Then
//			ls_err = SQLCA.SQLERRTEXT
//			ROLLBACK USING SQLCA;
//			Messagebox("알림" , ls_err)
//			RETURN
//		End If
		
	End If
Next

parent.event ue_save()
end event

on uo_reappall.destroy
call uo_imgbtn::destroy
end on

