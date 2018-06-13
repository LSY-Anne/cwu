$PBExportHeader$w_hsu413p.srw
$PBExportComments$[청운대]강의실사용현황2
forward
global type w_hsu413p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hsu413p
end type
type dw_con from uo_dwfree within w_hsu413p
end type
end forward

global type w_hsu413p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hsu413p w_hsu413p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hsu413p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hsu413p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

event ue_retrieve;string 	ls_year,	ls_hakgi, ls_hosil_code
string   ls_yoil, ls_gwamok_hname, ls_buil_name, ls_room_no
string   ls_cnt2, ls_prof_name, ls_display
long		ll_cnt1,	ll_cnt2, ll_sigan_to, ll_sigan_from, ll_row

dw_con.AcceptText()

ls_year		  =	 dw_con.Object.year[1]
ls_hakgi		  =	 dw_con.Object.hakgi[1]
ls_hosil_code = dw_con.Object.room_code[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
elseif ls_hosil_code = "" or isnull(ls_hosil_code) then
	messagebox("확인","강의실이 선택되지 않았읍니다.!!!")
	dw_con.SetFocus()
	dw_con.SetColumn("room_code")
	return -1
end if

select	b.buil_name,
			a.room_no
into		:ls_buil_name,
			:ls_room_no
from		stdb.hst242m	a,
			stdb.hst240m	b
where		a.room_code		=	:ls_hosil_code
and		a.buil_no		=	b.buil_no	
USING SQLCA ;


dw_main.object.t_2.text = ls_year + '  학년도  제' + ls_hakgi + ' 학기'
dw_main.object.t_4.text = ls_buil_name + '  ' + ls_room_no
	
for	ll_cnt1	=	1	to	6
		
	ll_row   = dw_main.insertrow(0)
	
	if	ll_cnt1	=	1	then
		ls_yoil	=	'a'
		dw_main.setitem(ll_cnt1,"t1","~r월~r")
	elseif	ll_cnt1	=	2	then
		ls_yoil	=	'b'
		dw_main.setitem(ll_cnt1,"t1","~r화~r")
	elseif	ll_cnt1	=	3	then
		ls_yoil	=	'c'
		dw_main.setitem(ll_cnt1,"t1","~r수~r")
	elseif	ll_cnt1	=	4	then
		ls_yoil	=	'd'
		dw_main.setitem(ll_cnt1,"t1","~r목~r")
	elseif	ll_cnt1	=	5	then
		ls_yoil	=	'e'
		dw_main.setitem(ll_cnt1,"t1","~r금~r")
	elseif	ll_cnt1	=	6	then
		ls_yoil	=	'f'
		dw_main.setitem(ll_cnt1,"t1","~r토~r")
	end if
		
	for	ll_cnt2	=	1	to	14
		
		ls_cnt2		=	string(ll_cnt2)
		
		ls_gwamok_hname	=	' '
		ls_prof_name		=	' '
		
		/* a.member_no 부적합으로 막음
		select 	nvl(b.gwamok_hname,''),
					nvl(c.name,'')
		into		:ls_gwamok_hname,
					:ls_prof_name
		from 		haksa.siganpyo 		a,
					haksa.gwamok_code   	b,
					haksa.prof_sym			c
		where 	a.year 			= 	:ls_year
		and 		a.hakgi 			=	:ls_hakgi
		and		a.hosil_code	=	:ls_hosil_code
		and		a.yoil			=	:ls_yoil
		and		a.sigan			=	:ls_cnt2
		and		a.gwamok_id		=	b.gwamok_id
		and		a.gwamok_seq	=	b.gwamok_seq
		and		a.member_no		=	c.member_no 
		USING SQLCA ; */
		
		ls_display	=	ls_gwamok_hname + '~r' + ls_prof_name
		
		if	ll_cnt2	=	1	then
			dw_main.setitem(ll_cnt1,"a1",ls_display)
		elseif	ll_cnt2	=	2	then
			dw_main.setitem(ll_cnt1,"a2",ls_display)
		elseif	ll_cnt2	=	3	then
			dw_main.setitem(ll_cnt1,"a3",ls_display)
		elseif	ll_cnt2	=	4	then
			dw_main.setitem(ll_cnt1,"b1",ls_display)
		elseif	ll_cnt2	=	5	then
			dw_main.setitem(ll_cnt1,"b2",ls_display)
		elseif	ll_cnt2	=	6	then
			dw_main.setitem(ll_cnt1,"b3",ls_display)
		elseif	ll_cnt2	=	7	then
			dw_main.setitem(ll_cnt1,"c1",ls_display)
		elseif	ll_cnt2	=	8	then
			dw_main.setitem(ll_cnt1,"c2",ls_display)
		elseif	ll_cnt2	=	9	then
			dw_main.setitem(ll_cnt1,"c3",ls_display)
		elseif	ll_cnt2	=	10	then
			dw_main.setitem(ll_cnt1,"d1",ls_display)
		elseif	ll_cnt2	=	11	then
			dw_main.setitem(ll_cnt1,"d2",ls_display)
		elseif	ll_cnt2	=	12	then
			dw_main.setitem(ll_cnt1,"d3",ls_display)
		elseif	ll_cnt2	=	13	then
			dw_main.setitem(ll_cnt1,"e1",ls_display)
		elseif	ll_cnt2	=	14	then
			dw_main.setitem(ll_cnt1,"e2",ls_display)
		end if
	
	next
	
next
	
dw_main.Modify("datawindow.print.preview=yes") 

Return 1

end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu413p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu413p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu413p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu413p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu413p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu413p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu413p
end type

type uc_insert from w_condition_window`uc_insert within w_hsu413p
end type

type uc_delete from w_condition_window`uc_delete within w_hsu413p
end type

type uc_save from w_condition_window`uc_save within w_hsu413p
end type

type uc_excel from w_condition_window`uc_excel within w_hsu413p
end type

type uc_print from w_condition_window`uc_print within w_hsu413p
end type

type st_line1 from w_condition_window`st_line1 within w_hsu413p
end type

type st_line2 from w_condition_window`st_line2 within w_hsu413p
end type

type st_line3 from w_condition_window`st_line3 within w_hsu413p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu413p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu413p
end type

type gb_1 from w_condition_window`gb_1 within w_hsu413p
end type

type gb_2 from w_condition_window`gb_2 within w_hsu413p
end type

type dw_main from uo_search_dwc within w_hsu413p
integer x = 50
integer y = 324
integer width = 4379
integer height = 2144
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu400p_13"
end type

type dw_con from uo_dwfree within w_hsu413p
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hsu411p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

