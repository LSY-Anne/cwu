$PBExportHeader$w_hsu605p.srw
$PBExportComments$[청운대]성적대장
forward
global type w_hsu605p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hsu605p
end type
type dw_con from uo_dwfree within w_hsu605p
end type
end forward

global type w_hsu605p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hsu605p w_hsu605p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hsu605p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hsu605p.destroy
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

event ue_retrieve;call super::ue_retrieve;int		li_row
string 	ls_year,	ls_hakgi, ls_hakgwa, ls_hakyun, ls_gubun, ls_chk

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_hakgwa	=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_gubun     =  dw_con.Object.gubun[1]
ls_chk         =  dw_con.Object.chk[1]

if ls_gubun = '1' Then
	dw_main.SetSort('hakbun')
	dw_main.Sort()
else
	dw_main.SetSort('hakbun')
	dw_main.Sort()
end if

if (ls_chk  = 'Y'  and ls_gubun = '2') then
	dw_main.dataobject = 'd_hsu600p_5_jang'
	dw_main.SetTransObject(Sqlca)
	dw_main.Modify("datawindow.print.preview=yes") 	
	
elseif (ls_chk  = 'N'  and ls_gubun = '1') then
	dw_main.dataobject = 'd_hsu600p_5'
	dw_main.SetTransObject(Sqlca)
	dw_main.Modify("datawindow.print.preview=yes") 
	
elseif (ls_chk  = 'N'  and ls_gubun = '2') then
	dw_main.dataobject = 'd_hsu600p_5_sung'
	dw_main.SetTransObject(Sqlca)
	dw_main.Modify("datawindow.print.preview=yes") 	
	
end if

if ls_gubun = '1' Then
	dw_main.SetSort('gwa_sym_order_seq, sungjukgye_hakyun, hakbun')
	dw_main.Sort()
else
	dw_main.SetSort('gwa_sym_order_seq, sungjukgye_hakyun, sungjukgye_sukcha')
	dw_main.Sort()

end if

li_row = dw_main.retrieve(ls_year, ls_hakgi, ls_hakyun, ls_hakgwa)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1

end event

event ue_print;call super::ue_print;//If idw_print.RowCount() < 1 Then Return ;
//
//dw_main.modify("DataWindow.Zoom=82")
//
//// 인쇄를 하기전에 해당 인쇄를 하고자 하는 사유를 확인한다.
//OpenWithParm(w_print_reason, gs_pgmid)
//If Message.Doubleparm < 0 Then
//	Return
//Else
//	OpenWithParm(w_printoption, idw_print)
//End If
//
//dw_main.modify("DataWindow.Zoom=100")
//
//Return 
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu605p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu605p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu605p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu605p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu605p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu605p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu605p
end type

type uc_insert from w_condition_window`uc_insert within w_hsu605p
end type

type uc_delete from w_condition_window`uc_delete within w_hsu605p
end type

type uc_save from w_condition_window`uc_save within w_hsu605p
end type

type uc_excel from w_condition_window`uc_excel within w_hsu605p
end type

type uc_print from w_condition_window`uc_print within w_hsu605p
end type

type st_line1 from w_condition_window`st_line1 within w_hsu605p
end type

type st_line2 from w_condition_window`st_line2 within w_hsu605p
end type

type st_line3 from w_condition_window`st_line3 within w_hsu605p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu605p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu605p
end type

type gb_1 from w_condition_window`gb_1 within w_hsu605p
end type

type gb_2 from w_condition_window`gb_2 within w_hsu605p
end type

type dw_main from uo_search_dwc within w_hsu605p
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hsu600p_5"
end type

type dw_con from uo_dwfree within w_hsu605p
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_hsu605p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gubun'
		If Data = '1' Then
			dw_main.SetSort('hakbun')
			dw_main.Sort()
		Else
			dw_main.SetSort('sungjukgye_sukcha')
			dw_main.Sort()
		End If
End Choose
end event

