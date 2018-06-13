$PBExportHeader$w_hjk418p.srw
$PBExportComments$[청운대]학적부출력(제적생)
forward
global type w_hjk418p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjk418p
end type
type dw_1 from datawindow within w_hjk418p
end type
type dw_con from uo_dwfree within w_hjk418p
end type
type st_cnt from statictext within w_hjk418p
end type
type uo_1 from uo_imgbtn within w_hjk418p
end type
end forward

global type w_hjk418p from w_condition_window
dw_main dw_main
dw_1 dw_1
dw_con dw_con
st_cnt st_cnt
uo_1 uo_1
end type
global w_hjk418p w_hjk418p

on w_hjk418p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_1=create dw_1
this.dw_con=create dw_con
this.st_cnt=create st_cnt
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.st_cnt
this.Control[iCurrent+5]=this.uo_1
end on

on w_hjk418p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_1)
destroy(this.dw_con)
destroy(this.st_cnt)
destroy(this.uo_1)
end on

event ue_retrieve;string	ls_hakgwa	,&
			ls_hakbun	,&
			ls_year
long		ll_row, ll_tot

dw_con.AcceptText()

ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun 	= func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_year 		= func.of_nvl(dw_con.Object.year[1], '%')

SELECT	COUNT(A.HAKBUN)
INTO		:ll_tot
FROM		HAKSA.JAEHAK_HAKJUK A
WHERE 	A.GWA				like :ls_hakgwa
AND		A.HAKBUN			like :ls_hakbun
AND		A.SANGTAE		= '03'
AND		SUBSTR(A.HJMOD_DATE, 1, 4)	like :ls_year		
USING SQLCA
;

//dw_main.setTransObject(sqlca)
ll_row = dw_main.retrieve( ls_hakgwa, ls_hakbun, ls_year)

st_cnt.text = string(ll_tot) + "명"

if ll_row = 0 then
	uf_messagebox(7)
	
elseif ll_row = -1 then
	uf_messagebox(8)
end if

//	dw_main2.setTransObject(sqlca)

dw_main.setfocus()
dw_1.setfocus()

Return 1
end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]      = func.of_get_sdate( 'YYYY')

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk418p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk418p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk418p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk418p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk418p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk418p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk418p
end type

type uc_insert from w_condition_window`uc_insert within w_hjk418p
end type

type uc_delete from w_condition_window`uc_delete within w_hjk418p
end type

type uc_save from w_condition_window`uc_save within w_hjk418p
end type

type uc_excel from w_condition_window`uc_excel within w_hjk418p
end type

type uc_print from w_condition_window`uc_print within w_hjk418p
end type

type st_line1 from w_condition_window`st_line1 within w_hjk418p
end type

type st_line2 from w_condition_window`st_line2 within w_hjk418p
end type

type st_line3 from w_condition_window`st_line3 within w_hjk418p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk418p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk418p
end type

type gb_1 from w_condition_window`gb_1 within w_hjk418p
end type

type gb_2 from w_condition_window`gb_2 within w_hjk418p
integer y = 248
end type

type dw_main from uo_search_dwc within w_hjk418p
integer x = 55
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk418p_3"
end type

type dw_1 from datawindow within w_hjk418p
boolean visible = false
integer x = 2587
integer y = 792
integer width = 571
integer height = 600
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_hjk418p_3_gai"
boolean border = false
boolean livescroll = true
end type

type dw_con from uo_dwfree within w_hjk418p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hjk418p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_cnt from statictext within w_hjk418p
integer x = 2619
integer y = 184
integer width = 297
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
long backcolor = 16777215
alignment alignment = right!
boolean focusrectangle = false
end type

event constructor;setposition(totop!)
end event

type uo_1 from uo_imgbtn within w_hjk418p
event destroy ( )
integer x = 658
integer y = 44
integer width = 338
integer height = 96
integer taborder = 20
boolean bringtotop = true
string btnname = "인쇄"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string	ls_hakgwa	,&
			ls_hakbun	,&
			ls_hakbun1	,&
			ls_year
			
long		ll_row, li_ans, li_ans1

dw_con.AcceptText()

ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun 	= func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_year 		= func.of_nvl(dw_con.Object.year[1], '%')

IF MESSAGEBOX("확인","인쇄 하겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

SetPointer(HourGlass!)

DECLARE CUR_PRINT CURSOR  FOR

		SELECT	A.HAKBUN
		FROM		HAKSA.JAEHAK_HAKJUK A
		WHERE 	A.GWA				like :ls_hakgwa
		AND		A.HAKBUN			like :ls_hakbun
		AND		A.SANGTAE		= '03'
		AND		SUBSTR(A.HJMOD_DATE, 1, 4)	like :ls_year		
		USING SQLCA
		;

OPEN CUR_PRINT ;
DO 
	
	FETCH CUR_PRINT INTO :ls_hakbun1 ;

	IF SQLCA.SQLCODE <> 0 THEN EXIT;
	
	//dw_main이 성적표가 조회되는 datawindow
	dw_1.setTransObject(sqlca)
	li_ans 	= dw_1.retrieve(ls_hakbun1)

	if li_ans > 0 then
		dw_1.print()
	end if

LOOP  WHILE TRUE
CLOSE CUR_PRINT ;

SetPointer(Arrow!)

MESSAGEBOX("확인","출력완료")

end event

