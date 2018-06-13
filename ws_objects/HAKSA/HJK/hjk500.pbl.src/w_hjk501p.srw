$PBExportHeader$w_hjk501p.srw
$PBExportComments$[청운대]주소스티커출력
forward
global type w_hjk501p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjk501p
end type
type dw_con from uo_dwfree within w_hjk501p
end type
end forward

global type w_hjk501p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hjk501p w_hjk501p

event ue_retrieve;string 	ls_hakbun, 	&
			ls_gwa, 	&
			ls_hakyun,&
			ls_year, ls_chk1, ls_chk2
int li_ans

dw_con.AcceptText()

ls_chk1 = dw_con.Object.chk1[1]
ls_chk2 = dw_con.Object.chk2[1]

//재학생 보호자 주소
if ls_chk1 = 'N' and ls_chk2 = 'N' then
	dw_main.dataobject = "d_hjk501p_2" 
elseif ls_chk1 = 'Y'  and ls_chk2= 'N' then
	dw_main.dataobject = "d_hjk501p_1" 
elseif ls_chk1 = 'N' and ls_chk2 = 'Y'  then
	dw_main.dataobject = "d_hjk501p_4"
elseif ls_chk1 = 'Y'  and ls_chk2 = 'Y'  then
	dw_main.dataobject = "d_hjk501p_3"
end if

dw_main.settransobject(sqlca)

ls_hakyun	= func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_gwa    	= func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun 	= func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_year 		= func.of_nvl(dw_con.Object.year[1], '%')

if ls_chk2 = 'Y' then
	
	if ls_year = '' or isnull(ls_year) then
   	messagebox("확인", "졸업생자료 조회시 반드시 졸업년도를 입력하여야 한다.")
		return -1
	end if
	
	li_ans = dw_main.retrieve(ls_hakbun, ls_gwa, ls_hakyun, ls_year)
else
	li_ans = dw_main.retrieve(ls_hakbun, ls_gwa, ls_hakyun)
end if

//조회한 자료가 없을때 처리
if li_ans = 0 then 
	uf_messagebox(7)
elseif li_ans = -1 then
   uf_messagebox (8)
end if

dw_main.setfocus()

Return 1

end event

on w_hjk501p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjk501p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]      = func.of_get_sdate( 'YYYY')

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk501p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk501p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk501p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk501p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk501p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk501p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk501p
end type

type uc_insert from w_condition_window`uc_insert within w_hjk501p
end type

type uc_delete from w_condition_window`uc_delete within w_hjk501p
end type

type uc_save from w_condition_window`uc_save within w_hjk501p
end type

type uc_excel from w_condition_window`uc_excel within w_hjk501p
end type

type uc_print from w_condition_window`uc_print within w_hjk501p
end type

type st_line1 from w_condition_window`st_line1 within w_hjk501p
end type

type st_line2 from w_condition_window`st_line2 within w_hjk501p
end type

type st_line3 from w_condition_window`st_line3 within w_hjk501p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk501p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk501p
end type

type gb_1 from w_condition_window`gb_1 within w_hjk501p
end type

type gb_2 from w_condition_window`gb_2 within w_hjk501p
end type

type dw_main from uo_search_dwc within w_hjk501p
integer x = 55
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk501p_1"
end type

type dw_con from uo_dwfree within w_hjk501p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk501p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

