$PBExportHeader$w_hsg114a.srw
$PBExportComments$[w_list_master] 집단프로그램개설신청
forward
global type w_hsg114a from w_window
end type
type dw_list from uo_grid within w_hsg114a
end type
type dw_con from uo_dw within w_hsg114a
end type
type dw_main from uo_dw within w_hsg114a
end type
type p_1 from picture within w_hsg114a
end type
type st_main from statictext within w_hsg114a
end type
type p_2 from picture within w_hsg114a
end type
type st_detail from statictext within w_hsg114a
end type
end forward

global type w_hsg114a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
dw_main dw_main
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
end type
global w_hsg114a w_hsg114a

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

//For I = 1 To UpperBound(idw_update)
//	If func.of_checknull(idw_update[i]) = -1 Then
//		Return -1
//	End If
//Next

return 1
//
end function

on w_hsg114a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.dw_main=create dw_main
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.st_main
this.Control[iCurrent+6]=this.p_2
this.Control[iCurrent+7]=this.st_detail
end on

on w_hsg114a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )
This.Event ue_resize_dw( st_line1, dw_list )

dw_con.insertrow(0)
dw_main.insertrow(0)

//dw_con.object.hakyear[dw_con.getrow()] = func.of_get_sdate('yyyy')
//dw_con.object.fr_dt[dw_con.getrow()] = func.of_get_sdate('yyyymm') + '01'
//dw_con.object.to_dt[dw_con.getrow()] = func.of_get_sdate('yyyymmdd')


idw_update[1]	= dw_main

String ls_member_no, ls_yn

SELECT CODE
INTO :ls_member_no
FROM  CDDB.KCH102D
WHERE UPPER(CODE_GB) = 'SUM99'
AND  USE_YN = 'Y'
AND CODE = :gs_empcode
USING SQLCA;

If ls_member_no = gs_empcode Then
	dw_con.object.member_no.protect = 0
	dw_con.object.kname.protect = 0
	dw_main.object.member_gb.protect = 0

Else
	dw_con.object.member_no.protect =1
	dw_con.object.kname.protect = 1
	dw_con.object.member_no[dw_con.getrow()] = gs_empcode
	dw_con.object.kname[dw_con.getrow()] = gs_empname
	
//	datawindowchild dwc
//	dw_con.getchild('pgm_tp', dwc)
//	dwc.settransobject(sqlca)
//	dwc.retrieve()
//	dwc.setfilter("cls_cd = 'SUM11' and ecd1 = 'Y'")
//	dwc.filter()
	
	
	dw_main.object.member_gb.protect = 1
	dw_main.object.member_gb.initial = '1'
	dw_main.object.member_gb[dw_main.getrow()] = '1'
	
	SELECT NVL(ETC_CD1, 'N')
	INTO :ls_yn
	FROM  CDDB.KCH102D
	WHERE UPPER(CODE_GB) = 'SUM31'
	AND CODE = '1';
	
	dw_main.object.yn[dw_main.getrow()] = ls_yn
End If



Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'hakgi')  //학기
lvc_data.setProperty('key1', 'HSG01')
//lvc_data.setproperty('subcol1', '')
//lvc_data.setproperty('subkey1', '')

lvc_data.setProperty('column2', 'pgm_tp')  //프로그램구분
lvc_data.setProperty('key2', 'SUM11')
If gs_empcode <> ls_member_no then
	lvc_data.setproperty('subcol2', 'ecd1')
	lvc_data.setproperty('subkey2', 'Y')
End If
func.of_dddw( dw_con,lvc_data)

lvc_data.setProperty('column1', 'pgm_tp')  //프로그램구분
lvc_data.setProperty('key1', 'SUM11')
If gs_empcode <> ls_member_no then
	lvc_data.setproperty('subcol1', 'ecd1')
	lvc_data.setproperty('subkey1', 'Y')
End If
lvc_data.setProperty('column2', 'pgm_cd')  //프로그램명
lvc_data.setProperty('key2', 'SUM24')
lvc_data.setProperty('column3', 'member_gb')  //담당구분
lvc_data.setProperty('key3', 'SUM31')

func.of_dddw( dw_main,lvc_data)

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
Long		ll_row

ll_rv = dw_main.Event ue_DeleteRow()

ls_txt = "[삭제] "
If ll_rv = 1 Then
	If Trigger Event ue_save() <> 1 Then
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	Else
//		ll_row = dw_list.GetRow()
//		If ll_row > 0 Then
//			dw_list.DeleteRow(ll_row)
//		End If
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

event ue_save;call super::ue_save;If ancestorreturnvalue = 1 Then dw_list.event ue_retrieve()

return 1
end event

type ln_templeft from w_window`ln_templeft within w_hsg114a
end type

type ln_tempright from w_window`ln_tempright within w_hsg114a
end type

type ln_temptop from w_window`ln_temptop within w_hsg114a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hsg114a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hsg114a
end type

type ln_tempstart from w_window`ln_tempstart within w_hsg114a
end type

type uc_retrieve from w_window`uc_retrieve within w_hsg114a
end type

type uc_insert from w_window`uc_insert within w_hsg114a
end type

type uc_delete from w_window`uc_delete within w_hsg114a
end type

type uc_save from w_window`uc_save within w_hsg114a
end type

type uc_excel from w_window`uc_excel within w_hsg114a
end type

type uc_print from w_window`uc_print within w_hsg114a
end type

type st_line1 from w_window`st_line1 within w_hsg114a
end type

type st_line2 from w_window`st_line2 within w_hsg114a
end type

type st_line3 from w_window`st_line3 within w_hsg114a
end type

type uc_excelroad from w_window`uc_excelroad within w_hsg114a
end type

type dw_list from uo_grid within w_hsg114a
event type long ue_retrieve ( )
integer x = 50
integer y = 468
integer width = 4384
integer height = 784
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg114a_1"
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





dw_main.Reset()
ll_rv = This.Retrieve(ls_year, ls_hakgi, ls_fr_dt, ls_to_dt , ls_member_no, ls_pgm_tp)

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

event retrieveend;call super::retrieveend;This.setrow(1)
dw_main.Post Event ue_Retrieve()
end event

type dw_con from uo_dw within w_hsg114a
integer x = 50
integer y = 164
integer width = 4389
integer height = 196
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg114a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

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

event clicked;call super::clicked;If dwo.name = 'p_search' Then
If This.object.member_no.protect = '1' Then return 	
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

type dw_main from uo_dw within w_hsg114a
event type long ue_retrieve ( )
integer x = 50
integer y = 1364
integer width = 4384
integer height = 900
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg114a_2"
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

ll_rv = dw_main.Retrieve(ls_year, ls_hakgi, ls_ent_no, ls_member_no)

If ll_rv = 0 Then 
	This.event ue_insertrow()
End If
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
//If ls_member_no <> '' and isnull(ls_member_no) = false Then 
//	This.object.member_no[This.getrow()] = ls_member_no
//	This.object.member_nm[This.getrow()] = ls_hname
//End If
This.object.ent_no[This.getrow()] =   ls_ent_no

If ls_pgm_tp <> '' and isnull(ls_pgm_tp) = false Then
	This.object.pgm_tp[This.getrow()] = ls_pgm_tp
End If

This.object.PRE_ENT_DT[This.getrow()] = func.of_get_sdate('yyyymmdd')  //신청일자


RETURN 1

end event

event itemchanged;call super::itemchanged;
String		ls_member_no	,ls_kname, ls_yn


This.accepttext()
Choose Case	dwo.name
	Case 'pgm_tp'
		If data = '3' Then
			this.object.pgm_cd[row] = '3002'
			this.object.pgm_cd.protect = 1
		ElseIf data = '2' Then
			this.object.pgm_cd[row] = '4001'
			this.object.pgm_cd.protect = 1
		Else
			this.object.pgm_cd[row] = ''
			this.object.pgm_cd.protect = 0
		End If
		
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
		
		
		
	Case	'member_no','member_nm'
		If dwo.name = 'member_no' Then	ls_member_no = data
		If dwo.name = 'member_nm' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
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
			This.object.member_no[row] = ls_member_no
			This.object.member_nm[row] = ls_kname
						
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

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_member_no
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
This.object.member_no[1]     = ls_Member_No				//개인번호

End If
end event

type p_1 from picture within w_hsg114a
integer x = 50
integer y = 392
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hsg114a
integer x = 114
integer y = 376
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

type p_2 from picture within w_hsg114a
integer x = 50
integer y = 1300
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_hsg114a
integer x = 114
integer y = 1288
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
string text = "신청내역등록"
boolean focusrectangle = false
end type

