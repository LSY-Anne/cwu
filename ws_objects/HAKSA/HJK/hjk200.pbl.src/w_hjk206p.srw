$PBExportHeader$w_hjk206p.srw
$PBExportComments$[청운대]제적자 전화번호 출력
forward
global type w_hjk206p from w_condition_window
end type
type dw_con from uo_dwfree within w_hjk206p
end type
type dw_main from uo_search_dwc within w_hjk206p
end type
end forward

global type w_hjk206p from w_condition_window
dw_con dw_con
dw_main dw_main
end type
global w_hjk206p w_hjk206p

on w_hjk206p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hjk206p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;string 	ls_hakbun, ls_name, ls_jumin, ls_year, ls_hakgi, ls_gubun
integer 	li_ans

dw_con.AcceptText()

ls_year  = dw_con.Object.year[1]
ls_hakgi = dw_con.Object.hakgi[1]
ls_hakbun  = func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_name    = func.of_nvl(dw_con.Object.hname[1], '%')
ls_gubun = dw_con.Object.gubun[1]

// 미복학제적 전화번호 출력
if ls_gubun = '1' Then
 
	dw_main.dataobject= 'd_hjk206p_1'
	dw_main.settransobject(sqlca)
	dw_main.Modify("datawindow.print.preview=yes")
	li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_name) 
	
	if li_ans < 1 then
		uf_messagebox(7)
		dw_main.reset()
	end if
	
// 미등록제적 전화번호 출력  
elseif ls_gubun = '2' Then
	
	dw_main.dataobject= 'd_hjk206p_2'
	dw_main.settransobject(sqlca)
	dw_main.Modify("datawindow.print.preview=yes")
	li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_name)

	
	if li_ans < 1 then 
		uf_messagebox(7)
		dw_main.reset()
	end if		
	
// 학사제적 전화번호 출력  
elseif ls_gubun = '3' Then

	dw_main.dataobject= 'd_hjk206p_3'
	dw_main.settransobject(sqlca)
	dw_main.Modify("datawindow.print.preview=yes")
	li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_name)


	if li_ans < 1 then 
		uf_messagebox(7)
		dw_main.reset()
	end if		
end if
	

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_name)
	
if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_main.setfocus()
end if

Return 1
end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1] = func.of_get_sdate('YYYY')
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk206p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk206p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk206p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk206p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk206p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk206p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk206p
end type

type uc_insert from w_condition_window`uc_insert within w_hjk206p
end type

type uc_delete from w_condition_window`uc_delete within w_hjk206p
end type

type uc_save from w_condition_window`uc_save within w_hjk206p
end type

type uc_excel from w_condition_window`uc_excel within w_hjk206p
end type

type uc_print from w_condition_window`uc_print within w_hjk206p
end type

type st_line1 from w_condition_window`st_line1 within w_hjk206p
end type

type st_line2 from w_condition_window`st_line2 within w_hjk206p
end type

type st_line3 from w_condition_window`st_line3 within w_hjk206p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk206p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk206p
end type

type gb_1 from w_condition_window`gb_1 within w_hjk206p
end type

type gb_2 from w_condition_window`gb_2 within w_hjk206p
end type

type dw_con from uo_dwfree within w_hjk206p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk206p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_search_dwc within w_hjk206p
integer x = 50
integer y = 300
integer width = 4384
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjk206p_1"
end type

