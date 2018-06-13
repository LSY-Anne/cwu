$PBExportHeader$w_hsg130p.srw
$PBExportComments$[w_print] 학생환경기록카드출력
forward
global type w_hsg130p from w_window
end type
type dw_con from uo_dwfree within w_hsg130p
end type
type dw_main from datawindow within w_hsg130p
end type
end forward

global type w_hsg130p from w_window
dw_con dw_con
dw_main dw_main
end type
global w_hsg130p w_hsg130p

event ue_postopen;call super::ue_postopen;func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)
dw_main.Modify("DataWindow.Print.Preview=Yes")

ib_retrieve_wait = True

Vector lvc_data
lvc_data = Create Vector



lvc_data.setProperty('column1', 'purpose')  //상담구분
lvc_data.setProperty('key1', 'SUM02')
func.of_dddw( dw_con,lvc_data)


lvc_data.setProperty('column1', 'case_tp')  //상담구분
lvc_data.setProperty('key1', 'SUM05')
func.of_dddw( dw_con,lvc_data)

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

on w_hsg130p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hsg130p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1
end event

type ln_templeft from w_window`ln_templeft within w_hsg130p
end type

type ln_tempright from w_window`ln_tempright within w_hsg130p
end type

type ln_temptop from w_window`ln_temptop within w_hsg130p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hsg130p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hsg130p
end type

type ln_tempstart from w_window`ln_tempstart within w_hsg130p
end type

type uc_retrieve from w_window`uc_retrieve within w_hsg130p
end type

type uc_insert from w_window`uc_insert within w_hsg130p
end type

type uc_delete from w_window`uc_delete within w_hsg130p
end type

type uc_save from w_window`uc_save within w_hsg130p
end type

type uc_excel from w_window`uc_excel within w_hsg130p
end type

type uc_print from w_window`uc_print within w_hsg130p
end type

type st_line1 from w_window`st_line1 within w_hsg130p
end type

type st_line2 from w_window`st_line2 within w_hsg130p
end type

type st_line3 from w_window`st_line3 within w_hsg130p
end type

type uc_excelroad from w_window`uc_excelroad within w_hsg130p
end type

type dw_con from uo_dwfree within w_hsg130p
integer x = 50
integer y = 176
integer width = 4379
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg130p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

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

type dw_main from datawindow within w_hsg130p
event type long ue_retrieve ( )
integer x = 41
integer y = 368
integer width = 4379
integer height = 1884
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hsg130p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();String		ls_hakbun
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_hakbun = dw_con.object.hakbun[dw_con.GetRow()]

IF isnull(ls_hakbun) OR ls_hakbun = '' THEN
	messagebox("조회", '학번을 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

ll_rv = THIS.Retrieve(ls_hakbun)

RETURN ll_rv

end event

event constructor;this.SetTransObject(Sqlca)
end event

