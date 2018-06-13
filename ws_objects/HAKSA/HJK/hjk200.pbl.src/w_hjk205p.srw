$PBExportHeader$w_hjk205p.srw
$PBExportComments$[청운대]제적자주소출력
forward
global type w_hjk205p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjk205p
end type
type dw_con from uo_dwfree within w_hjk205p
end type
end forward

global type w_hjk205p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hjk205p w_hjk205p

on w_hjk205p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjk205p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string 	ls_hakbun, ls_name, ls_jumin, ls_year, ls_hakgi, ls_from, ls_to, ls_gubun
integer 	li_ans
    
dw_con.AcceptText()

ls_year      = dw_con.Object.year[1]
ls_hakgi     = dw_con.Object.hakgi[1]
ls_hakbun  = func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_name    = func.of_nvl(dw_con.Object.hname[1], '%')
ls_from     = dw_con.Object.from_dt[1]
ls_to         = dw_con.Object.to_dt[1]
ls_gubun    = dw_con.Object.gubun[1]	 		

	// 미복학제적주소스티커출력
	if ls_gubun = '1' Then
	 
		dw_main.dataobject= 'd_hjk205p_1'
		dw_main.settransobject(sqlca)
		dw_main.Modify("datawindow.print.preview=yes")
		li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_name, ls_from, ls_to) 
		
		if li_ans < 1 then
			uf_messagebox(7)
			dw_main.reset()
		end if
		
	// 미등록제적주소스티커출력  
   elseif ls_gubun = '2' Then
		
		dw_main.dataobject= 'd_hjk205p_2'
		dw_main.settransobject(sqlca)
		dw_main.Modify("datawindow.print.preview=yes")
		li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_name, ls_from, ls_to)

		
		if li_ans < 1 then 
			uf_messagebox(7)
			dw_main.reset()
		end if		
		
	// 학사제적주소스티커출력  
	elseif ls_gubun = '3' Then
	
		dw_main.dataobject= 'd_hjk205p_3'
		dw_main.settransobject(sqlca)
		dw_main.Modify("datawindow.print.preview=yes")
		li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_name, ls_from, ls_to)
	
	
		if li_ans < 1 then 
			uf_messagebox(7)
			dw_main.reset()
		end if		
	end if
	
	Return 1
end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1] = func.of_get_sdate('YYYY')
dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk205p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk205p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk205p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk205p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk205p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk205p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk205p
end type

type uc_insert from w_condition_window`uc_insert within w_hjk205p
end type

type uc_delete from w_condition_window`uc_delete within w_hjk205p
end type

type uc_save from w_condition_window`uc_save within w_hjk205p
end type

type uc_excel from w_condition_window`uc_excel within w_hjk205p
end type

type uc_print from w_condition_window`uc_print within w_hjk205p
end type

type st_line1 from w_condition_window`st_line1 within w_hjk205p
end type

type st_line2 from w_condition_window`st_line2 within w_hjk205p
end type

type st_line3 from w_condition_window`st_line3 within w_hjk205p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk205p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk205p
end type

type gb_1 from w_condition_window`gb_1 within w_hjk205p
end type

type gb_2 from w_condition_window`gb_2 within w_hjk205p
end type

type dw_main from uo_search_dwc within w_hjk205p
integer x = 55
integer y = 400
integer width = 4375
integer height = 1864
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjk205p_1"
end type

type dw_con from uo_dwfree within w_hjk205p
integer x = 50
integer y = 164
integer width = 4384
integer height = 220
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk205p_c1"
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

