$PBExportHeader$w_hyd210a.srw
$PBExportComments$[w_list] 유형별 실적자료 승인
forward
global type w_hyd210a from w_window
end type
type dw_main from uo_grid within w_hyd210a
end type
type dw_con from uo_dw within w_hyd210a
end type
type p_1 from picture within w_hyd210a
end type
type st_main from statictext within w_hyd210a
end type
type uo_all from uo_imgbtn within w_hyd210a
end type
type uo_norow from uo_imgbtn within w_hyd210a
end type
type ddlb_gu from dropdownlistbox within w_hyd210a
end type
type uo_ok from uo_imgbtn within w_hyd210a
end type
type uo_bo from uo_imgbtn within w_hyd210a
end type
type uo_ban from uo_imgbtn within w_hyd210a
end type
type uo_bul from uo_imgbtn within w_hyd210a
end type
type uo_cancel from uo_imgbtn within w_hyd210a
end type
type sle_sayu from singlelineedit within w_hyd210a
end type
type st_1 from statictext within w_hyd210a
end type
end forward

global type w_hyd210a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
uo_all uo_all
uo_norow uo_norow
ddlb_gu ddlb_gu
uo_ok uo_ok
uo_bo uo_bo
uo_ban uo_ban
uo_bul uo_bul
uo_cancel uo_cancel
sle_sayu sle_sayu
st_1 st_1
end type
global w_hyd210a w_hyd210a

forward prototypes
public function integer wf_validall ()
end prototypes

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

on w_hyd210a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.uo_all=create uo_all
this.uo_norow=create uo_norow
this.ddlb_gu=create ddlb_gu
this.uo_ok=create uo_ok
this.uo_bo=create uo_bo
this.uo_ban=create uo_ban
this.uo_bul=create uo_bul
this.uo_cancel=create uo_cancel
this.sle_sayu=create sle_sayu
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.uo_all
this.Control[iCurrent+6]=this.uo_norow
this.Control[iCurrent+7]=this.ddlb_gu
this.Control[iCurrent+8]=this.uo_ok
this.Control[iCurrent+9]=this.uo_bo
this.Control[iCurrent+10]=this.uo_ban
this.Control[iCurrent+11]=this.uo_bul
this.Control[iCurrent+12]=this.uo_cancel
this.Control[iCurrent+13]=this.sle_sayu
this.Control[iCurrent+14]=this.st_1
end on

on w_hyd210a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.uo_all)
destroy(this.uo_norow)
destroy(this.ddlb_gu)
destroy(this.uo_ok)
destroy(this.uo_bo)
destroy(this.uo_ban)
destroy(this.uo_bul)
destroy(this.uo_cancel)
destroy(this.sle_sayu)
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.settransobject(sqlca)
dw_con.insertrow(0)
dw_con.object.std_ym[1] = func.of_get_sdate('yyyymm')

idw_update[1]	= dw_main

Vector lvc_data
lvc_data = Create Vector

lvc_data.setProperty('column1', 'appr_dvs_cd')  //승인구분
lvc_data.setProperty('key1', 'HYD1400')
func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)



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

event ue_save;call super::ue_save;If ancestorreturnvalue = 1 Then this.event ue_inquiry()

return 1
end event

event ue_button_set;call super::ue_button_set;uo_norow.x = uo_all.x + uo_all.width + 16
sle_sayu.x = uo_cancel.x + uo_cancel.width + 16
end event

type ln_templeft from w_window`ln_templeft within w_hyd210a
end type

type ln_tempright from w_window`ln_tempright within w_hyd210a
end type

type ln_temptop from w_window`ln_temptop within w_hyd210a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hyd210a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hyd210a
end type

type ln_tempstart from w_window`ln_tempstart within w_hyd210a
end type

type uc_retrieve from w_window`uc_retrieve within w_hyd210a
end type

type uc_insert from w_window`uc_insert within w_hyd210a
end type

type uc_delete from w_window`uc_delete within w_hyd210a
end type

type uc_save from w_window`uc_save within w_hyd210a
end type

type uc_excel from w_window`uc_excel within w_hyd210a
end type

type uc_print from w_window`uc_print within w_hyd210a
end type

type st_line1 from w_window`st_line1 within w_hyd210a
end type

type st_line2 from w_window`st_line2 within w_hyd210a
end type

type st_line3 from w_window`st_line3 within w_hyd210a
end type

type uc_excelroad from w_window`uc_excelroad within w_hyd210a
end type

type dw_main from uo_grid within w_hyd210a
event type long ue_retrieve ( )
integer x = 50
integer y = 460
integer width = 4389
integer height = 1804
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd210a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_std_ym, ls_gwa, ls_member_no, ls_yn
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_std_ym = dw_con.object.std_ym[dw_con.GetRow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.GetRow()], '%')
ls_yn = dw_con.object.appr_dvs_cd[dw_con.Getrow()]

If ls_std_ym = '' or isnull(ls_std_ym) Then
	Messagebox("알림", "기준년월을 입력하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('std_ym')
	RETURN -1
End If

If ls_yn = '' or isnull(ls_yn) Then
	Messagebox("알림", "승인구분을 입력하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('appr_dvs_cd')
	RETURN -1
End If


ll_rv = This.Retrieve(ls_std_ym, ls_gwa,  ls_yn)

RETURN ll_rv

end event

event itemchanged;call super::itemchanged;
String		ls_member_no	,ls_kname


This.accepttext()
Choose Case	dwo.name
	Case	'member_no','name'
		If dwo.name = 'member_no' Then	ls_member_no = data
		If dwo.name = 'name' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
			This.Post SetItem(row, 'name'	, '')			
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
			This.object.name[row] = ls_kname
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event doubleclicked(-1, 0, row, This.object.member_no)
			return 1
			
		End If	
		
	

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

event ue_insertend;call super::ue_insertend;String ls_std_ym

dw_con.accepttext()

ls_std_ym = dw_con.object.std_ym[1]

If ls_std_ym = '' or isnull(ls_std_ym) then
	Messagebox("알림", "기준년월을 확인하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('std_ym')
	RETURN -1
End If

This.object.std_ym[al_row] = ls_std_ym
end event

event doubleclicked;call super::doubleclicked;If dwo.name = 'member_no' or dwo.name = 'name' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_member_no
This.accepttext()
ls_KName =  trim(this.object.name[row])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = '1'//교직원구분 -교원

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	THIS.SetFocus()
	THIS.setcolumn('name')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.name[row]        = ls_kname					//성명
This.object.member_no[row]     = ls_Member_No				//개인번호

End If
end event

type dw_con from uo_dw within w_hyd210a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd210a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
This.accepttext()
Choose Case dwo.name
	Case 'gubun'
		
		dw_main.dataobject = 'd_hyd210a_' + data
		
		dw_main.triggerevent(constructor!)
		
		
		Vector lvc_data
		lvc_data = Create Vector
		
		lvc_data.setProperty('column1', 'appr_dvs_cd')  //승인구분
		lvc_data.setProperty('key1', 'HYD1400')
		func.of_dddw( dw_main,lvc_data)
		
		This.object.appr_dvs_cd[row] = '1'
		ddlb_gu.selectitem(2)
		ddlb_gu.event selectionchanged(2)
		
		parent.post event ue_inquiry()
		
		
End Choose
end event

type p_1 from picture within w_hyd210a
integer x = 50
integer y = 368
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hyd210a
integer x = 114
integer y = 352
integer width = 320
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
string text = "실적내역"
boolean focusrectangle = false
end type

type uo_all from uo_imgbtn within w_hyd210a
integer x = 507
integer y = 328
integer taborder = 20
boolean bringtotop = true
string btnname = "전체선택"
end type

event clicked;call super::clicked;If dw_main.rowcount() = 0 then RETURN 

long ll_row

For ll_row = 1 To dw_main.rowcount()
	If dw_main.object.chk[ll_row] = 'N' Then
		dw_main.object.chk[ll_row] = 'Y'
	End If
Next
end event

on uo_all.destroy
call uo_imgbtn::destroy
end on

type uo_norow from uo_imgbtn within w_hyd210a
integer x = 837
integer y = 328
integer taborder = 30
boolean bringtotop = true
string btnname = "선택취소"
end type

event clicked;call super::clicked;If dw_main.rowcount() = 0 then RETURN 

long ll_row

For ll_row = 1 To dw_main.rowcount()
	If dw_main.object.chk[ll_row] = 'Y' Then
		dw_main.object.chk[ll_row] = 'N'
	End If
Next
end event

on uo_norow.destroy
call uo_imgbtn::destroy
end on

type ddlb_gu from dropdownlistbox within w_hyd210a
integer x = 1893
integer y = 328
integer width = 480
integer height = 352
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"승인보류","승인완료","승인반려","승인불가","승인취소"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_gu 



If index = 1 Then 
	uo_ok.visible = false
	uo_bo.visible = true
	uo_ban.visible = false
	uo_bul.visible = false
	uo_cancel.visible = false
	sle_sayu.visible = false
Elseif index = 2 Then
	uo_ok.visible = true
	uo_bo.visible = false
	uo_ban.visible = false
	uo_bul.visible = false
	uo_cancel.visible = false
	sle_sayu.visible = false
Elseif index = 3 Then
	uo_ok.visible = false
	uo_bo.visible = false
	uo_ban.visible = true
	uo_bul.visible = false
	uo_cancel.visible = false
	sle_sayu.visible = false
Elseif index = 4 Then
	uo_ok.visible = false
	uo_bo.visible = false
	uo_ban.visible = false
	uo_bul.visible = true
	uo_cancel.visible = false
	sle_sayu.visible = false
Elseif index = 5 Then
	uo_ok.visible = false
	uo_bo.visible = false
	uo_ban.visible = false
	uo_bul.visible = false
	uo_cancel.visible = true
	sle_sayu.visible = true
End If
	
	
end event

event constructor;This.selectitem( 2)

uo_ok.visible = true
uo_bo.visible = false
uo_ban.visible = false
uo_bul.visible = false
uo_cancel.visible = false
sle_sayu.visible = false
end event

type uo_ok from uo_imgbtn within w_hyd210a
integer x = 2386
integer y = 328
integer taborder = 40
boolean bringtotop = true
string btnname = "승인"
end type

on uo_ok.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;If dw_main.rowcount() = 0 then RETURN 

long ll_row

For ll_row = 1 To dw_main.rowcount()
	If dw_main.object.chk[ll_row] = 'Y' Then
		dw_main.object.APPR_DVS_CD[ll_row] = '3'  //승인완료
		dw_main.object.APPR_DTTM[ll_row] = func.of_get_datetime()
	End If
Next

parent.post event ue_save()
end event

type uo_bo from uo_imgbtn within w_hyd210a
integer x = 2386
integer y = 328
integer taborder = 50
boolean bringtotop = true
string btnname = "승인보류"
end type

on uo_bo.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;If dw_main.rowcount() = 0 then RETURN 

long ll_row

For ll_row = 1 To dw_main.rowcount()
	If dw_main.object.chk[ll_row] = 'Y' Then
		dw_main.object.APPR_DVS_CD[ll_row] = '2'  //승인보류		
	End If
Next

parent.post event ue_save()
end event

type uo_ban from uo_imgbtn within w_hyd210a
integer x = 2386
integer y = 328
integer taborder = 60
boolean bringtotop = true
string btnname = "승인반려"
end type

on uo_ban.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;If dw_main.rowcount() = 0 then RETURN 

long ll_row

For ll_row = 1 To dw_main.rowcount()
	If dw_main.object.chk[ll_row] = 'Y' Then
		dw_main.object.APPR_DVS_CD[ll_row] = '4'  //승인반려
	End If
Next

parent.post event ue_save()
end event

type uo_bul from uo_imgbtn within w_hyd210a
integer x = 2386
integer y = 328
integer taborder = 70
boolean bringtotop = true
string btnname = "승인불가"
end type

on uo_bul.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;If dw_main.rowcount() = 0 then RETURN 

long ll_row

For ll_row = 1 To dw_main.rowcount()
	If dw_main.object.chk[ll_row] = 'Y' Then
		dw_main.object.APPR_DVS_CD[ll_row] = '5'  //승인불가
	End If
Next

parent.post event ue_save()
end event

type uo_cancel from uo_imgbtn within w_hyd210a
integer x = 2386
integer y = 328
integer taborder = 80
boolean bringtotop = true
string btnname = "승인취소"
end type

on uo_cancel.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;If dw_main.rowcount() = 0 then RETURN 

long ll_row
String ls_sayu

ls_sayu = sle_sayu.text

If ls_sayu = '' Or isnull(ls_sayu) then
	Messagebox("알림", "승인취소사유를 입력하세요!")
	sle_sayu.setfocus()
	RETURn 
End If

For ll_row = 1 To dw_main.rowcount()
	If dw_main.object.chk[ll_row] = 'Y' Then
		dw_main.object.APPR_CNCL_DTTM[ll_row] = func.of_get_datetime()
		dw_main.object.APPR_RTRN_CNCL_RSN_CNTN[ll_row] = sle_sayu.text
	End If
Next

parent.post event ue_save()
end event

type sle_sayu from singlelineedit within w_hyd210a
boolean visible = false
integer x = 2706
integer y = 328
integer width = 1637
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "승인취소사유를 입력하세요!"
borderstyle borderstyle = stylelowered!
end type

event getfocus;If This.text = '승인취소사유를 입력하세요!' then
	This.text = ''
End If
end event

type st_1 from statictext within w_hyd210a
integer x = 1582
integer y = 340
integer width = 302
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "승인구분"
boolean focusrectangle = false
end type

