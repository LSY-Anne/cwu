$PBExportHeader$w_dhwhj409q.srw
$PBExportComments$[대학원학적] 휴학증명서
forward
global type w_dhwhj409q from w_condition_window
end type
type dw_main from uo_search_dwc within w_dhwhj409q
end type
type dw_con from uo_dwfree within w_dhwhj409q
end type
end forward

global type w_dhwhj409q from w_condition_window
string title = "휴학증명서"
dw_main dw_main
dw_con dw_con
end type
global w_dhwhj409q w_dhwhj409q

type variables
String is_hakbun
end variables

on w_dhwhj409q.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_dhwhj409q.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;call super::ue_retrieve;string ls_hakbun, ls_name, ls_db_hakbun
int li_cnt, li_ans

dw_con.AcceptText()

ls_hakbun =	 dw_con.Object.hakbun[1]
ls_name   =	 dw_con.Object.hname[1]

is_hakbun = ls_hakbun

if (ls_hakbun = '' or isnull(ls_hakbun)) and (ls_name = '' or isnull(ls_name) ) then
	messagebox("오류","학번이나 성명을 입력하세요")
	return -1
end if

li_ans = dw_main.retrieve(ls_hakbun )

if li_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1

end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)
end event

event ue_print;//S[1] : 학번, S[2] : 학과 S[3] : 학기차, S[4]:증명서 종류

// 인쇄를 하기전에 해당 인쇄를 하고자 하는 사유를 확인한다.
OpenWithParm(w_print_reason, gs_pgmid)
If Message.Doubleparm < 0 Then
	Return
Else
	str_parms l_str_parms
	
	l_str_parms.s[1]	=	is_hakbun
	l_str_parms.s[2]	=	'09'
	l_str_parms.s[3]	=	'1'
	l_str_parms.dw[1]	=	dw_main
	
	if idw_print.rowcount() > 0 then
		openwithparm(w_dhwhj401pp, l_str_parms)
			
	else
		return
	end if
End If
		

end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwhj409q
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwhj409q
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwhj409q
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwhj409q
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwhj409q
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwhj409q
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwhj409q
end type

type uc_insert from w_condition_window`uc_insert within w_dhwhj409q
end type

type uc_delete from w_condition_window`uc_delete within w_dhwhj409q
end type

type uc_save from w_condition_window`uc_save within w_dhwhj409q
end type

type uc_excel from w_condition_window`uc_excel within w_dhwhj409q
end type

type uc_print from w_condition_window`uc_print within w_dhwhj409q
end type

type st_line1 from w_condition_window`st_line1 within w_dhwhj409q
end type

type st_line2 from w_condition_window`st_line2 within w_dhwhj409q
end type

type st_line3 from w_condition_window`st_line3 within w_dhwhj409q
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwhj409q
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwhj409q
end type

type gb_1 from w_condition_window`gb_1 within w_dhwhj409q
end type

type gb_2 from w_condition_window`gb_2 within w_dhwhj409q
end type

type dw_main from uo_search_dwc within w_dhwhj409q
integer x = 50
integer y = 300
integer width = 4384
integer height = 1964
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dhwhj409q_1"
end type

event constructor;this.settransobject(sqlca)
end event

type dw_con from uo_dwfree within w_dhwhj409q
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_dhwhj409q_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String ls_hakbun, ls_hname
vector    lvc_data

lvc_data   = create vector

Choose Case dwo.name
	Case 'gubun'
		If Data = '1' Then
			dw_main.DataObject = 'd_dhwhj409q_1'
			dw_main.SetTransObject(Sqlca)
		ElseIf Data = '2' Then
			dw_main.DataObject = 'd_dhwhj409q_2'
			dw_main.SetTransObject(Sqlca)
		End IF
		
	Case 'hakbun', 'hname'
		If dwo.name = 'hakbun'  Then ls_hakbun = data ;
		If dwo.name = 'hname'  Then ls_hname  = data ;
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'   , '')
			This.Post SetItem(row, 'hname'  ,  '')
			RETURN
		End If
		
		Choose Case  f_d_hakjuk_search(ls_hakbun, ls_hname, lvc_data)
			Case	1
				This.Object.hakbun[row]	 = lvc_data.GetProperty('hakbun'	)
				This.Object.hname[row]  = lvc_data.GetProperty('hname'	)				
					
				Return 2
			Case Else
				This.Trigger Event clicked(-1, 0, row, This.object.p_emp)
		End Choose
		
End Choose
end event

event clicked;call super::clicked;Vector lvc_data

This.AcceptText()
lvc_data = Create Vector

Choose Case dwo.name
	Case 'p_emp'
		 lvc_data.setproperty('parm_cnt' , '1')		
		 lvc_data.setProperty('hakbun'  , This.object.hakbun[row] )
	 	 lvc_data.setProperty('hname'   , This.object.hname[row])
			
		If	openwithparm(w_d_hakjuk_pop, lvc_data) = 1 Then
			lvc_data = message.powerobjectparm
			If isvalid(lvc_data) Then
				If Long(lvc_data.GetProperty("parm_cnt")) = 0 Then RETURN ;		
				This.Object.hakbun[row]	 = lvc_data.GetProperty("hakbun1")
				This.Object.hname[row]	 = lvc_data.GetProperty("hname1")		
			End If
		End If
		
End Choose

Destroy lvc_data
end event

