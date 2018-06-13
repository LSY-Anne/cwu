$PBExportHeader$w_hgj317p.srw
$PBExportComments$[청운대]교원자격증
forward
global type w_hgj317p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hgj317p
end type
type dw_con from uo_dwfree within w_hgj317p
end type
end forward

global type w_hgj317p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hgj317p w_hgj317p

on w_hgj317p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hgj317p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string	ls_year, ls_junhugi, ls_jaguk, ls_pyosi, ls_hakgwa, ls_hakbun, ls_ilja, ls_gubun, ls_text1, ls_text2
long ll_ans

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_junhugi   = dw_con.Object.junhugi[1]
ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = func.of_nvl(dw_con.Object.pyosi_id[1], '%') + '%'
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_hakbun	= func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'
ls_gubun     = dw_con.Object.gubun[1]
ls_ilja         = func.of_get_sdate("yyyymmdd")

if (trim(ls_year) = '' Or Isnull(ls_year)) or (trim(ls_jaguk) = '' Or Isnull(ls_jaguk)) then
	messagebox("확인","사정년도, 자격명을 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("jaguk_id")
	return	 -1
end if

ls_text1 = dw_con.Object.text1[1]
ls_text2 = dw_con.Object.text2[1]

if ls_gubun = '1' Then
	dw_main.object.print_table.visible = false
	dw_main.object.print_1.visible = false
	dw_main.object.print_2.visible = false
	dw_main.object.print_3.visible = false
elseif ls_gubun = '3' Then
	dw_main.object.print_table.visible = true
	dw_main.object.print_1.visible = true
	dw_main.object.print_2.visible = true
	dw_main.object.print_3.visible = true
	
	dw_main.object.print_1.text = '분실로 인하여 재교부함.'
	dw_main.object.print_2.text = mid(ls_ilja, 1, 4) + '년  ' + mid(ls_ilja, 5, 2) + '월  ' + mid(ls_ilja, 7, 2) + '일'
	dw_main.object.print_3.text = '청 운 대 학 교 총 장'
elseif ls_gubun = '2' Then
	dw_main.object.print_table.visible = true
	dw_main.object.print_1.visible = true
	dw_main.object.print_2.visible = true
	dw_main.object.print_3.visible = true
	
	dw_main.object.print_1.text = ls_text1 +' 자 정정함.'
	dw_main.object.print_2.text = mid(ls_ilja, 1, 4) + '년  ' + mid(ls_ilja, 5, 2) + '월  ' + mid(ls_ilja, 7, 2) + '일'
	dw_main.object.print_3.text = '청 운 대 학 교 총 장'
elseif ls_gubun = '4' Then
	dw_main.object.print_table.visible = true
	dw_main.object.print_1.visible = true
	dw_main.object.print_2.visible = true
	dw_main.object.print_3.visible = true
	
	dw_main.object.print_1.text = '교무     -        '
	dw_main.object.print_2.text = mid(ls_ilja, 1, 4) + '년  ' + mid(ls_ilja, 5, 2) + '월  ' +mid(ls_ilja, 7, 2) + '일'
	dw_main.object.print_3.text = ls_text2 + '를 정정함      인'
end if

ll_ans = dw_main.retrieve(ls_year, ls_junhugi, ls_jaguk, ls_pyosi, ls_hakgwa, ls_hakbun)

if ll_ans = 0 then
	uf_messagebox(7)
	
elseif ll_ans = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1
end event

event open;call super::open;String ls_year

idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

ls_year	= f_haksa_iljung_year()

dw_con.Object.year[1]  = ls_year

end event

type ln_templeft from w_condition_window`ln_templeft within w_hgj317p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hgj317p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hgj317p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hgj317p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hgj317p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hgj317p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hgj317p
end type

type uc_insert from w_condition_window`uc_insert within w_hgj317p
end type

type uc_delete from w_condition_window`uc_delete within w_hgj317p
end type

type uc_save from w_condition_window`uc_save within w_hgj317p
end type

type uc_excel from w_condition_window`uc_excel within w_hgj317p
end type

type uc_print from w_condition_window`uc_print within w_hgj317p
end type

type st_line1 from w_condition_window`st_line1 within w_hgj317p
end type

type st_line2 from w_condition_window`st_line2 within w_hgj317p
end type

type st_line3 from w_condition_window`st_line3 within w_hgj317p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hgj317p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hgj317p
end type

type gb_1 from w_condition_window`gb_1 within w_hgj317p
end type

type gb_2 from w_condition_window`gb_2 within w_hgj317p
end type

type dw_main from uo_search_dwc within w_hgj317p
integer x = 50
integer y = 400
integer width = 4384
integer height = 1864
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hgj317p"
end type

type dw_con from uo_dwfree within w_hgj317p
integer x = 50
integer y = 164
integer width = 4384
integer height = 228
integer taborder = 190
boolean bringtotop = true
string dataobject = "d_hgj317p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

