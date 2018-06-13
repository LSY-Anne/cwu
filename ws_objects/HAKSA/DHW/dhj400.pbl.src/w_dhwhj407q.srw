$PBExportHeader$w_dhwhj407q.srw
$PBExportComments$[대학원학적] 성적증명서
forward
global type w_dhwhj407q from w_condition_window
end type
type dw_main from uo_search_dwc within w_dhwhj407q
end type
type dw_con from uo_dwfree within w_dhwhj407q
end type
type uo_1 from uo_imgbtn within w_dhwhj407q
end type
end forward

global type w_dhwhj407q from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_dhwhj407q w_dhwhj407q

type variables
string is_hakbun, is_hakgwa, is_hakgicha
end variables

on w_dhwhj407q.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
end on

on w_dhwhj407q.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_hakbun, ls_name, ls_chk
int li_cnt, li_ans

dw_con.AcceptText()

ls_hakbun =	 dw_con.Object.hakbun[1]
ls_name   =	 dw_con.Object.hname[1]

if (ls_hakbun = '' or isnull(ls_hakbun)) and (ls_name = '' or isnull(ls_name) ) then
	messagebox("오류","학번이나 성명을 입력하세요")
	return -1
end if

//성명만으로 검색시
//같은 성명이 있으면 Popup Window를 사용하여 학번을 가져와서 조회
if ls_name <> '' then

	SELECT COUNT(*)
	INTO :li_cnt
	FROM HAKSA.D_HAKJUK
	WHERE HNAME	= :ls_name 
	USING SQLCA; 
	
	if li_cnt >= 2 then
		openwithparm(w_dhw_search, ls_name)
		
		is_hakbun = Message.StringParm
		
	elseif li_cnt = 1 then
		SELECT HAKBUN
		INTO :is_hakbun
		FROM	HAKSA.D_HAKJUK
		WHERE	HNAME	=	:ls_name 
		USING SQLCA; 
		
	else
		messagebox("오류","존재하지 않는 성명입니다.")
		return  -1
	end if

else			// 성명이 입력되어 있지 않으면...학번만으로 검색...

	SELECT HAKBUN
	INTO :is_hakbun
	FROM	HAKSA.D_HAKJUK
	WHERE	HAKBUN		= :ls_hakbun 
	USING SQLCA; 
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","존재하지않는 학번입니다..")
		return -1
	end if
end if

////영문이름과 주소가 입력되지 않으면 popup을 띄운다.
//SELECT HAKBUN
//INTO	:ls_chk
//FROM	HAKSA.D_HAKJUK
//WHERE	HAKBUN	= :is_hakbun
//AND	( ENAME	IS NULL OR E_JUSO IS NULL) ;
//
//if sqlca.sqlcode = 0 then
//	
//end if

li_ans = dw_main.retrieve(is_hakbun )

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
	string ls_jung, ls_gubun, ls_prt_gubun
	
	dw_con.AcceptText()
	ls_gubun      = dw_con.Object.gubun[1]
	ls_prt_gubun = dw_con.Object.prt_gubun[1]
	
	if ls_gubun = '1' Then
		ls_jung = '02'
	else
		ls_jung = '12'
	end if
	
	l_str_parms.s[1]	=	is_hakbun
	l_str_parms.s[2]	=	ls_jung 
	l_str_parms.s[3]	=	ls_prt_gubun
	l_str_parms.dw[1]	=	dw_main
	
	if idw_print.rowcount() > 0 then
		openwithparm(w_dhwhj401pp, l_str_parms)
			
	else
		return
	end if
End If
		




end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwhj407q
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwhj407q
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwhj407q
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwhj407q
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwhj407q
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwhj407q
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwhj407q
end type

type uc_insert from w_condition_window`uc_insert within w_dhwhj407q
end type

type uc_delete from w_condition_window`uc_delete within w_dhwhj407q
end type

type uc_save from w_condition_window`uc_save within w_dhwhj407q
end type

type uc_excel from w_condition_window`uc_excel within w_dhwhj407q
end type

type uc_print from w_condition_window`uc_print within w_dhwhj407q
end type

type st_line1 from w_condition_window`st_line1 within w_dhwhj407q
end type

type st_line2 from w_condition_window`st_line2 within w_dhwhj407q
end type

type st_line3 from w_condition_window`st_line3 within w_dhwhj407q
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwhj407q
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwhj407q
end type

type gb_1 from w_condition_window`gb_1 within w_dhwhj407q
end type

type gb_2 from w_condition_window`gb_2 within w_dhwhj407q
end type

type dw_main from uo_search_dwc within w_dhwhj407q
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dhwhj407q_1"
end type

type dw_con from uo_dwfree within w_dhwhj407q
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_dhwhj407q_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String ls_prt_gubun, ls_gubun

Choose Case dwo.name
	Case 'gubun'
		ls_prt_gubun = This.Object.prt_gubun[row]
		
		If Data = '1' Then
			If ls_prt_gubun = '1' Then
				dw_main.DataObject = 'd_dhwhj407q_3'
			Else
				dw_main.DataObject = 'd_dhwhj407q_1'
			End If
			dw_main.SetTransObject(Sqlca)
			dw_main.Modify("datawindow.print.preview=yes") 
		ElseIf Data = '2' Then
			If ls_prt_gubun = '1' Then
				dw_main.DataObject = 'd_dhwhj407q_4'
			Else
				dw_main.DataObject = 'd_dhwhj407q_2'
			End If

			dw_main.SetTransObject(Sqlca)
			dw_main.Modify("datawindow.print.preview=yes") 
		End IF
		
	Case 'prt_gubun'
		ls_gubun = This.Object.gubun[row]
		
		If Data = '1' Then
			If ls_gubun = '1' Then
				dw_main.DataObject = 'd_dhwhj407q_3'
			Else
				dw_main.DataObject = 'd_dhwhj407q_1'
			End If
			dw_main.SetTransObject(Sqlca)
			dw_main.Modify("datawindow.print.preview=yes") 
		ElseIf Data = '2' Then
			If ls_gubun = '1' Then
				dw_main.DataObject = 'd_dhwhj407q_4'
			Else
				dw_main.DataObject = 'd_dhwhj407q_2'
			End If

			dw_main.SetTransObject(Sqlca)
			dw_main.Modify("datawindow.print.preview=yes") 
		End IF
End Choose
end event

type uo_1 from uo_imgbtn within w_dhwhj407q
integer x = 672
integer y = 40
integer width = 457
integer taborder = 20
boolean bringtotop = true
string btnname = "영문주소입력"
end type

event clicked;call super::clicked;open(w_dhwhj407q_p)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

