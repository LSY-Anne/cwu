$PBExportHeader$w_hyd303p.srw
$PBExportComments$연구업적평가자료
forward
global type w_hyd303p from w_window
end type
type dw_con from uo_dwfree within w_hyd303p
end type
type dw_main from datawindow within w_hyd303p
end type
end forward

global type w_hyd303p from w_window
dw_con dw_con
dw_main dw_main
end type
global w_hyd303p w_hyd303p

event ue_postopen;call super::ue_postopen;func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)
dw_main.Modify("DataWindow.Print.Preview=Yes")

dw_con.object.std_ym_fr[dw_con.getrow()] = func.of_get_sdate('yyyy') + '01'
dw_con.object.std_ym_to[dw_con.getrow()] = func.of_get_sdate('yyyymm')

//ib_retrieve_wait = True

idw_print = dw_main
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

on w_hyd303p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hyd303p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_window`ln_templeft within w_hyd303p
end type

type ln_tempright from w_window`ln_tempright within w_hyd303p
end type

type ln_temptop from w_window`ln_temptop within w_hyd303p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hyd303p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hyd303p
end type

type ln_tempstart from w_window`ln_tempstart within w_hyd303p
end type

type uc_retrieve from w_window`uc_retrieve within w_hyd303p
end type

type uc_insert from w_window`uc_insert within w_hyd303p
end type

type uc_delete from w_window`uc_delete within w_hyd303p
end type

type uc_save from w_window`uc_save within w_hyd303p
end type

type uc_excel from w_window`uc_excel within w_hyd303p
end type

type uc_print from w_window`uc_print within w_hyd303p
end type

type st_line1 from w_window`st_line1 within w_hyd303p
end type

type st_line2 from w_window`st_line2 within w_hyd303p
end type

type st_line3 from w_window`st_line3 within w_hyd303p
end type

type uc_excelroad from w_window`uc_excelroad within w_hyd303p
end type

type dw_con from uo_dwfree within w_hyd303p
integer x = 50
integer y = 176
integer width = 4379
integer height = 216
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd303p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String ls_member_no, ls_kname
This.accepttext()

Choose Case dwo.name
	Case 'gubun'
		dw_main.dataobject = 'd_hyd303p_' + data
		dw_main.settransobject(sqlca)
		dw_main.Modify("DataWindow.Print.Preview=Yes")
		parent.post event ue_inquiry()
			
	Case	'member_no','kname'
		If dwo.name = 'member_no' Then	ls_member_no = data
		If dwo.name = 'kname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
			This.Post SetItem(row, 'kname'	, '')			
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
			This.object.kname[row] = ls_kname
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
			
End Choose
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

type dw_main from datawindow within w_hyd303p
event type long ue_retrieve ( )
integer x = 50
integer y = 432
integer width = 4379
integer height = 1820
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hyd303p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();Long ll_rv

String ls_fr_ym, ls_to_ym, ls_member_no, ls_gubun

dw_con.accepttext()

ls_fr_ym = dw_con.object.std_ym_fr[dw_con.getrow()]
ls_to_ym = dw_con.object.std_ym_to[dw_con.getrow()]
ls_member_no = dw_con.object.member_no[dw_con.getrow()]
ls_gubun = dw_con.object.gubun[dw_con.getrow()]

If ls_fr_ym = '' or isnull(ls_fr_ym) Then
	Messagebox("알림", "기준년월을 확인하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('std_ym_fr')
	RETURN -1
End If

If ls_to_ym = '' or isnull(ls_to_ym) Then
	Messagebox("알림", "기준년월을 확인하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('std_ym_to')
	RETURN -1
End If

If ls_member_no = '' or isnull(ls_member_no) Then
	Messagebox("알림", "사번을 확인하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('member_no')
	RETURN -1
End If

If ls_gubun = '3' Then //현재 진행중인 연구
	dw_main.reset()
	dw_main.insertrow(0)
Else
	ll_rv = dw_main.retrieve(ls_fr_ym, ls_to_ym, ls_member_no)
	
	If ll_rv = 0 Then
		dw_main.insertrow(0)
	End If
End If












RETURN ll_rv
end event

event constructor;this.SetTransObject(Sqlca)
end event

