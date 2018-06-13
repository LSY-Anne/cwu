$PBExportHeader$w_hsu520p.srw
$PBExportComments$[청운대]수강신청 변동내역 명단
forward
global type w_hsu520p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hsu520p
end type
type dw_con from uo_dwfree within w_hsu520p
end type
end forward

global type w_hsu520p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hsu520p w_hsu520p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hsu520p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hsu520p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con.Object.to_dt[1]   = func.of_get_sdate('YYYYMMDD')

end event

event ue_retrieve;call super::ue_retrieve;int		li_row 
string 	ls_year,	ls_hakgi, ls_hakbun, ls_name, ls_from, ls_to

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun	=	func.of_nvl(dw_con.Object.akbun[1], '%')

ls_from	=	dw_con.Object.from_dt[1]
ls_to  	=	dw_con.Object.to_dt[1]
	
li_row = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_name, ls_from, ls_to)

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu520p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu520p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu520p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu520p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu520p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu520p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu520p
end type

type uc_insert from w_condition_window`uc_insert within w_hsu520p
end type

type uc_delete from w_condition_window`uc_delete within w_hsu520p
end type

type uc_save from w_condition_window`uc_save within w_hsu520p
end type

type uc_excel from w_condition_window`uc_excel within w_hsu520p
end type

type uc_print from w_condition_window`uc_print within w_hsu520p
end type

type st_line1 from w_condition_window`st_line1 within w_hsu520p
end type

type st_line2 from w_condition_window`st_line2 within w_hsu520p
end type

type st_line3 from w_condition_window`st_line3 within w_hsu520p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu520p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu520p
end type

type gb_1 from w_condition_window`gb_1 within w_hsu520p
end type

type gb_2 from w_condition_window`gb_2 within w_hsu520p
end type

type dw_main from uo_search_dwc within w_hsu520p
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu520p"
end type

type dw_con from uo_dwfree within w_hsu520p
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_hsu520p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;String ls_from_dt, ls_to_dt

Choose Case dwo.name
	Case 'p_from_dt'
		ls_from_dt 	= String(This.Object.from_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'from_dt' , ls_from_dt)
		
		ls_from_dt 	= left(ls_from_dt, 4) + mid(ls_from_dt, 6, 2) + right(ls_from_dt, 2)
		This.SetItem(row, 'from_dt',  ls_from_dt)
		
	Case 'p_to_dt'
		ls_to_dt 	= String(This.Object.to_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'to_dt' , ls_to_dt)
		
		ls_to_dt 	= left(ls_to_dt, 4) + mid(ls_to_dt, 6, 2) + right(ls_to_dt, 2)
		This.SetItem(row, 'to_dt',  ls_to_dt)
End Choose
end event

