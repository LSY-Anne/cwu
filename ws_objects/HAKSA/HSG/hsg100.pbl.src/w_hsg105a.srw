$PBExportHeader$w_hsg105a.srw
$PBExportComments$[w_list_master_detail] 상담 및 검사 신청(학생)
forward
global type w_hsg105a from w_window
end type
type dw_list from uo_grid within w_hsg105a
end type
type dw_con from uo_dw within w_hsg105a
end type
type uc_row_insert from u_picture within w_hsg105a
end type
type uc_row_delete from u_picture within w_hsg105a
end type
type dw_sub from uo_grid within w_hsg105a
end type
type st_main from statictext within w_hsg105a
end type
type st_detail from statictext within w_hsg105a
end type
type p_2 from picture within w_hsg105a
end type
type p_1 from picture within w_hsg105a
end type
type p_3 from picture within w_hsg105a
end type
type st_sub from statictext within w_hsg105a
end type
type uo_stu from uo_imgbtn within w_hsg105a
end type
type dw_main from uo_dw within w_hsg105a
end type
type dw_print from datawindow within w_hsg105a
end type
end forward

global type w_hsg105a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
dw_sub dw_sub
st_main st_main
st_detail st_detail
p_2 p_2
p_1 p_1
p_3 p_3
st_sub st_sub
uo_stu uo_stu
dw_main dw_main
dw_print dw_print
end type
global w_hsg105a w_hsg105a

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

on w_hsg105a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.dw_sub=create dw_sub
this.st_main=create st_main
this.st_detail=create st_detail
this.p_2=create p_2
this.p_1=create p_1
this.p_3=create p_3
this.st_sub=create st_sub
this.uo_stu=create uo_stu
this.dw_main=create dw_main
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uc_row_insert
this.Control[iCurrent+4]=this.uc_row_delete
this.Control[iCurrent+5]=this.dw_sub
this.Control[iCurrent+6]=this.st_main
this.Control[iCurrent+7]=this.st_detail
this.Control[iCurrent+8]=this.p_2
this.Control[iCurrent+9]=this.p_1
this.Control[iCurrent+10]=this.p_3
this.Control[iCurrent+11]=this.st_sub
this.Control[iCurrent+12]=this.uo_stu
this.Control[iCurrent+13]=this.dw_main
this.Control[iCurrent+14]=this.dw_print
end on

on w_hsg105a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.dw_sub)
destroy(this.st_main)
destroy(this.st_detail)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.p_3)
destroy(this.st_sub)
destroy(this.uo_stu)
destroy(this.dw_main)
destroy(this.dw_print)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )
This.Event ue_resize_dw( st_line1, dw_list )
This.Event ue_resize_dw( st_line2, dw_sub )

dw_con.insertrow(0)
dw_main.insertrow(0)



idw_update[1]	= dw_main
//idw_update[2]	= dw_sub

Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'hakgi')  //학기
lvc_data.setProperty('key1', 'HSG01')
lvc_data.setProperty('column2', 'purpose')  //찾은목적
lvc_data.setProperty('key2', 'SUM02')
lvc_data.setProperty('column3', 'case_tp')  //상담구분
lvc_data.setProperty('key3', 'SUM05')
lvc_data.setProperty('column4', 'monthod')  //찾아온경위
lvc_data.setProperty('key4', 'SUM06')


func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)


String ls_year, ls_hakgi
uo_hsfunc hsfunc

hsfunc = Create uo_hsfunc
// 초기 Value Setup - 해당 상담관리에서 사용하는 최종 연도및학기를 확인한다.
hsfunc.of_get_yearhakgi('SUM', lvc_data)

ls_year = lvc_data.GetProperty('year')
ls_hakgi = lvc_data.GetProperty('hakgi')

If ls_year = '' Or IsNull(ls_year) Then
	dw_con.object.hakyear[dw_con.getrow()] = func.of_get_sdate('yyyy')
Else
	dw_con.object.hakyear[dw_con.getrow()] = ls_year
	dw_con.Object.hakgi[dw_con.getrow()] = ls_hakgi
End If

String ls_today, ls_fr_dt, ls_to_dt, ls_close_dt
ls_today = func.of_get_sdate('YYYYMMDD') 

SELECT HAKGI_STR, HAKGI_END,  NVL(CLOSE_DT, '29991231')
INTO :ls_fr_dt, :ls_to_dt, :ls_close_dt
FROM HAKSA.SUM170TL
WHERE YEAR = :ls_year
AND HAKGI = :ls_hakgi
USING SQLCA;

If ls_close_dt = '' or isnull(ls_close_dt) Then ls_close_dt = '29991231'
If ls_fr_dt <> '' AND isnull(ls_fr_dt)= False then
	If ls_fr_dt > ls_today or ls_today > ls_to_dt  or ls_today > ls_close_dt Then
		uc_insert.of_enable(false)
		uc_delete.of_enable(false)
		uc_save.of_enable(false)
		dw_main.object.datawindow.readonly = 'Yes'
		dw_sub.object.datawindow.readonly = 'Yes'
	End If
End If

String ls_member_no

SELECT CODE
INTO :ls_member_no
FROM  CDDB.KCH102D
WHERE UPPER(CODE_GB) = 'SUM99'
AND  USE_YN = 'Y'
AND CODE = :gs_empcode
USING SQLCA;

If ls_member_no = gs_empcode Then
	dw_con.object.hakbun.protect = 0
	dw_con.object.kname.protect = 0
//	dw_con.object.p_search.visible = 1
Else
	dw_con.object.hakbun.protect = 1
	dw_con.object.kname.protect = 1
//	dw_con.object.p_search.visible = 0
	dw_con.object.hakbun[dw_con.getrow()] = gs_empcode
	dw_con.object.kname[dw_con.getrow()] = gs_empname
End If

dw_con.object.case_tp[dw_con.getrow()] = '1'
dw_con.object.case_tp.protect = 1

//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
idw_modified[1]	=  dw_main
idw_modified[2]	=  dw_sub


idw_print = dw_print
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
	f_set_message("[조회] " + '자료가 없습니다.', '', parentwin)
//	dw_main.insertrow(0)
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

uo_stu.x = ln_tempright.beginx - uo_stu.width
end event

event ue_savestart;call super::ue_savestart;If dw_main.rowcount() = 0 Then return 1
String	ls_yn, ls_counsel_cd, ls_year, ls_hakgi, ls_hakbun, ls_case_no, ls_cname
Long	ll_row, ll_rowcnt, ll_cnt
dw_sub.accepttext()

ls_year = dw_main.object.year[1]
ls_hakgi = dw_main.object.hakgi[1]
ls_hakbun = dw_main.object.hakbun[1]
ls_case_no = dw_main.object.case_no[1]

ll_rowcnt = dw_sub.rowcount()
If ll_rowcnt = 0 Then return 1

For ll_row = 1 To ll_rowcnt
	ls_yn = dw_sub.object.chk[ll_row]
	ls_counsel_cd = dw_sub.object.counsel_cd[ll_row]
	ls_cname = dw_sub.object.counsel_name[ll_row]
	
	SELECT COUNT(*) 
	INTO :ll_cnt
	FROM HAKSA.SUM130TL
	WHERE YEAR = :ls_year
	AND HAKGI = :ls_hakgi
	AND CASE_NO = :ls_case_no
	AND HAKBUN = :ls_hakbun
	AND COUNSEL_CD = :ls_counsel_cd
	USING SQLCA;
	
	If ll_cnt = 0 and ls_yn = 'Y' Then
		INSERT INTO HAKSA.SUM130TL
		(      YEAR	 ,	HAKGI,	CASE_NO ,	HAKBUN ,		COUNSEL_CD
		       ,WORKER       ,IPADDR       ,WORK_DATE       ,JOB_UID       ,JOB_ADD       ,JOB_DATE)
	       VALUES(:ls_year, :ls_hakgi,	:ls_case_no, 	:ls_hakbun, 	:ls_counsel_cd
		, :gs_empcode, :gs_ip, sysdate,         :gs_empcode, :gs_ip, sysdate)
		USING SQLCA;
		
		If SQLCA.SQLCODE <> 0 Then
			Rollback USING SQLCA;
			Messagebox("알림", ls_cname + " SUM130TL INSERT 중 에러 발생!")
			RETURN -1
		End If
	Elseif ll_cnt = 1 and ls_yn = 'N' Then
		
		DELETE FROM HAKSA.SUM130TL
		WHERE YEAR = :ls_year
		AND HAKGI = :ls_hakgi
		AND CASE_NO = :ls_case_no
		AND HAKBUN = :ls_hakbun
		AND COUNSEL_CD = :ls_counsel_cd
		USING SQLCA;
		
		If SQLCA.SQLCODE <> 0 Then
			Rollback USING SQLCA;
			Messagebox("알림", ls_cname + " SUM130TL DELETE 중 에러 발생!")
			RETURN -1
		End If
		
	 End If 
	
	
	
Next


return 1
end event

event ue_save;call super::ue_save;If ancestorreturnvalue = 1 Then dw_list.event ue_retrieve()

return 1
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "상담 및 검사 신청서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_window`ln_templeft within w_hsg105a
end type

type ln_tempright from w_window`ln_tempright within w_hsg105a
end type

type ln_temptop from w_window`ln_temptop within w_hsg105a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hsg105a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hsg105a
end type

type ln_tempstart from w_window`ln_tempstart within w_hsg105a
end type

type uc_retrieve from w_window`uc_retrieve within w_hsg105a
integer x = 2391
integer width = 265
boolean originalsize = true
end type

type uc_insert from w_window`uc_insert within w_hsg105a
integer x = 2670
integer width = 265
boolean originalsize = true
end type

type uc_delete from w_window`uc_delete within w_hsg105a
integer x = 2949
integer width = 265
boolean originalsize = true
end type

type uc_save from w_window`uc_save within w_hsg105a
integer x = 3232
integer width = 265
boolean originalsize = true
end type

type uc_excel from w_window`uc_excel within w_hsg105a
integer x = 3511
integer width = 265
boolean originalsize = true
end type

type uc_print from w_window`uc_print within w_hsg105a
integer width = 265
boolean originalsize = true
end type

type st_line1 from w_window`st_line1 within w_hsg105a
end type

type st_line2 from w_window`st_line2 within w_hsg105a
end type

type st_line3 from w_window`st_line3 within w_hsg105a
end type

type uc_excelroad from w_window`uc_excelroad within w_hsg105a
integer x = 3790
integer width = 366
boolean originalsize = true
end type

type dw_list from uo_grid within w_hsg105a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4384
integer height = 864
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg105a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_year, ls_hakgi, ls_hakbun, ls_case_tp
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = func.of_nvl(dw_con.object.hakyear[dw_con.GetRow()], '')
ls_hakgi = func.of_nvl(dw_con.object.hakgi[dw_con.GetRow()], '')
ls_hakbun = func.of_nvl(dw_con.object.hakbun[dw_con.GetRow()], '%')
ls_case_tp = func.of_nvl(dw_con.object.case_tp[dw_con.getrow()], '%')

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

//If ls_hakbun = '' or isnull(ls_hakbun) Then ls_hakbun = '%'
	

dw_main.Reset()
dw_sub.Reset()
ll_rv = This.Retrieve(ls_year, ls_hakgi, ls_hakbun, ls_case_tp)

If ll_rv = 0 Then
	
	dw_main.event ue_insertrow()
	
End If

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

event retrieveend;call super::retrieveend;If rowcount > 0 Then This.event rowfocuschanged(1)
end event

type dw_con from uo_dw within w_hsg105a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg105a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;

If dwo.name = 'p_search' Then
If this.Describe("hakbun.Protect") = '1' Then return 	-1
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

type uc_row_insert from u_picture within w_hsg105a
integer x = 3890
integer y = 1284
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

type uc_row_delete from u_picture within w_hsg105a
integer x = 4169
integer y = 1284
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_sub.PostEvent("ue_DeleteRow")

end event

type dw_sub from uo_grid within w_hsg105a
event type long ue_retrieve ( )
integer x = 3657
integer y = 1376
integer width = 777
integer height = 888
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

dw_main.accepttext()
ll_row = dw_main.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_main.object.year[ll_row]
ls_hakgi = dw_main.object.hakgi[ll_row]
ls_hakbun = dw_main.object.hakbun[ll_row]
ls_case_no = dw_main.object.case_no[ll_row]
ls_code = dw_main.object.purpose[ll_row]
ll_rv = dw_sub.Retrieve(ls_year, ls_hakgi, ls_case_no, ls_hakbun, ls_code)


RETURN ll_rv

end event

type st_main from statictext within w_hsg105a
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
string text = "상담 신청 및 검사 이력 등록"
boolean focusrectangle = false
end type

type st_detail from statictext within w_hsg105a
integer x = 123
integer y = 1292
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
string text = "상담 신청 및 검사 상세 등록"
boolean focusrectangle = false
end type

type p_2 from picture within w_hsg105a
integer x = 59
integer y = 1308
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_hsg105a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_hsg105a
boolean visible = false
integer x = 3310
integer y = 1272
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_sub from statictext within w_hsg105a
boolean visible = false
integer x = 3374
integer y = 1260
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
string text = "subl desc"
boolean focusrectangle = false
end type

type uo_stu from uo_imgbtn within w_hsg105a
integer x = 4142
integer y = 316
integer taborder = 30
boolean bringtotop = true
string btnname = "학생정보조회"
end type

event clicked;call super::clicked;String		 ls_hakbun
Int    l_cnt

if dw_list.rowcount() = 0 Then return 

ls_hakbun = dw_list.object.hakbun[dw_list.GetRow()]
//If ls_hakbun = '' or isnull(ls_hakbun) Then 
//	Messagebox("알림", "학번을 입력하세요!")
//	RETURN 
//End If


SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM HAKSA.SUM220TL
 WHERE hakbun  = :ls_hakbun;
IF l_cnt       = 0 THEN
	messagebox("알림", '학생환경기록카드의 정보등록이 안되었습니다')
	return
END IF

OpenWithParm(w_hsg102pp, ls_hakbun)

	
end event

on uo_stu.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dw within w_hsg105a
event type long ue_retrieve ( )
integer x = 50
integer y = 1376
integer width = 3579
integer height = 888
integer taborder = 10
string dataobject = "d_hsg105a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no, ls_step
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_hakbun = dw_list.object.hakbun[ll_row]
ls_case_no = dw_list.object.case_no[ll_row]
ls_step = dw_list.object.step1[ll_row]

If ls_step = '2' then //신청
	This.object.datawindow.readonly = 'No'  //수정가능
	dw_sub.object.datawindow.readonly = 'No'  //수정가능
	uc_delete.of_enable(true)
Else
	This.object.datawindow.readonly = 'Yes'  //수정불가능
	dw_sub.object.datawindow.readonly = 'Yes'  //수정불가능
	uc_delete.of_enable(false)
End If

ll_rv = dw_main.Retrieve(ls_year, ls_hakgi, ls_case_no, ls_hakbun)
If ll_rv > 0 Then
	dw_sub.event ue_retrieve()	
	dw_print.Retrieve(ls_year, ls_hakgi, ls_case_no, ls_hakbun)
Else
	dw_sub.Reset()
	dw_print.reset()
End If

RETURN ll_rv

end event

event ue_insertrow;call super::ue_insertrow;
If AncestorReturnValue = 1 Then dw_sub.Reset()

String		ls_year, ls_hakgi, ls_hakbun, ls_tel, ls_hp, ls_email, ls_case_no, ls_hname, ls_sex, ls_su_hakyun
String		ls_gwa, ls_gwa_name, ls_member_no, ls_prof_name, ls_case_tp
Long		ll_rv
Long 		l_case_no

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.hakyear[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.GetRow()]
ls_hakbun = dw_con.object.hakbun[dw_con.GetRow()]
ls_case_tp = dw_con.object.case_tp[dw_con.GetRow()]

SELECT :ls_year || lpad((to_number(nvl(max(substr(case_no,5,10)), 0))) + 1, 6,'0') 
  INTO :l_case_no
  FROM SUM120TL
 where case_no like :ls_year || '%'
  and hakbun = :ls_hakbun;
 
 If isnull(l_case_no ) Then 
	ls_case_no =  ls_year + '000001'
Else
	ls_case_no = String(l_case_no)
End If

//SELECT :ls_year || lpad((to_number(nvl(max(substr(rst_no,5,10)), 0))) + 1, 6,'0') 
//  INTO :l_rst_no
//  from SUM140tl 
// where rst_no like :ls_year || '%';
// 

SELECT TEL,     HP,     EMAIL, GWA, 
 (SELECT  FNAME  FROM 	CDDB.KCH003M  B WHERE B.GWA = A.GWA) , HNAME, SEX, SU_HAKYUN
  INTO :ls_tel, :ls_hp, :ls_email  , :ls_gwa, :ls_gwa_name, :ls_hname, :ls_sex, :ls_su_hakyun
  FROM HAKSA.JAEHAK_HAKJUK A
 WHERE HAKBUN   = :ls_hakbun;
 
SELECT  B.MEMBER_NO, C.NAME 
INTO :ls_member_no, :ls_prof_name
FROM HAKSA.PROF_SYM C , HAKSA.SUM210TL B
WHERE B.MEMBER_NO = C.MEMBER_NO
AND B.YEAR = :ls_year
AND B.HAKGI = :ls_hakgi
AND B.HAKBUN = :ls_hakbun;


This.object.year[This.getrow()] = ls_year
This.object.hakgi[This.getrow()] = ls_hakgi
This.object.hakbun[This.getrow()] = ls_hakbun
This.object.tel[This.getrow()] = ls_tel
This.object.hp[This.getrow()] = ls_hp
This.object.email[This.getrow()] = ls_email
This.object.gwa[This.getrow()] = ls_gwa
This.object.gwa_nm[This.getrow()] = ls_gwa_name
This.object.hname[This.getrow()] = ls_hname
This.object.sex[This.getrow()] = ls_sex
This.object.su_hakyun[This.getrow()] = ls_su_hakyun
This.object.member_no[This.getrow()] = ls_member_no
This.object.prof_name[This.getrow()] = ls_prof_name
This.object.case_no[This.getrow()] = ls_case_no  //상담신청번호
//This.object.counsel_dt[This.getrow()] = func.of_get_sdate('yyyymmdd')
This.object.case_date[This.getrow()] = func.of_get_sdate('yyyymmdd')
This.object.case_tp[This.getrow()] = ls_case_tp

This.object.datawindow.readonly = 'No'
dw_sub.object.datawindow.readonly = 'No'

This.post event itemchanged(This.getrow(), this.object.purpose, '1')

//dw_sub를 재조회한다.(신규시 공통코드정보만 조회됨)
dw_sub.event ue_retrieve()



RETURN AncestorReturnValue

end event

event ue_deletestart;call super::ue_deletestart;Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no

ll_row = dw_main.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_main.object.year[ll_row]
ls_hakgi = dw_main.object.hakgi[ll_row]
ls_hakbun = dw_main.object.hakbun[ll_row]
ls_case_no = dw_main.object.case_no[ll_row]

DELETE FROM HAKSA.SUM130TL A
WHERE A.YEAR = :ls_year
AND A.HAKGI = :ls_hakgi
AND A.CASE_NO = :ls_case_no
AND A.HAKBUN = :ls_hakbun
USING SQLCA;

If SQLCA.SQLCODE <> 0 then
	ROLLBACK USING SQLCA;
	Messagebox("알림" ,"희망상담검사종목 SUM130TL 삭제 중 에러 발생!")
	RETURN -1
End If

return 1
end event

event itemchanged;call super::itemchanged;String ls_h01nno, ls_h01knm
This.accepttext()
Choose Case dwo.name
	Case 'purpose'  //신규 row 시에만 tab 활성화 되므로.. 신규일 경우에만 발생함.
		//dw_sub를 재조회한다.(신규시 공통코드정보만 조회됨)
	//목적에 따라서 상담 종목이  바뀜.
		dw_sub.event ue_retrieve()
		
//		If data = '1' Then  //상담선택시
//			This.object.counseller[row] = This.object.member_no[row]
//			This.object.coun_name[row] = This.object.prof_name[row]
//			this.object.case_tp[row] = '' //reset
//			
//		Else //검사 선택시
			SELECT CODE, FNAME
			   INTO :ls_h01nno, :ls_h01knm
			   FROM  CDDB.KCH102D
			   WHERE UPPER(CODE_GB) = 'SUM99'
			   AND  USE_YN = 'Y'
			   AND ETC_CD1 = 'Y'
			   USING SQLCA;
			   
			   
			This.object.counseller[row] = ls_h01nno
			This.object.coun_name[row] = ls_h01knm
			this.object.case_tp[row] = '1' //인력개발센터
//		End If
//	Case 'case_tp'	
//		If data = '2' Then  //지도교수 - 해당 지도교수를 상담자로 setting한다.
//			This.object.counseller[row] = This.object.member_no[row]
//			This.object.coun_name[row] = This.object.prof_name[row]
//		Else //resest
//			This.object.counseller[row] = ''
//			This.object.coun_name[row] = ''
//		End If
    	Case	'counseller','coun_name'
		If dwo.name = 'counseller' Then	ls_h01nno = data
		If dwo.name = 'coun_name' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'counseller'	, '')
			This.Post SetItem(row, 'coun_name'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_h01nno , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_h01nno || '%'
		AND NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.counseller[row] = ls_h01nno
			This.object.coun_name[row] = ls_h01knm
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	

End Choose
end event

event clicked;call super::clicked;If dwo.name = 'p_search' Then

If This.object.purpose[row] = '1' Then RETURN 1

s_insa_com	lstr_com
String		ls_KName, ls_member_no
This.accepttext()
ls_KName =  trim(this.object.coun_name[1])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = ''

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	this.SetFocus()
	this.setcolumn('coun_name')
	RETURN -1
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.coun_name[1]        = ls_kname					//성명
This.object.counseller[1]     = ls_Member_No				//개인번호
return 1
End If
end event

type dw_print from datawindow within w_hsg105a
boolean visible = false
integer x = 1591
integer y = 1312
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_hsg105a_4"
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

