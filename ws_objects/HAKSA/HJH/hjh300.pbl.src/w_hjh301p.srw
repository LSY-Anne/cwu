$PBExportHeader$w_hjh301p.srw
$PBExportComments$신,편 및 졸업생 명단출력
forward
global type w_hjh301p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjh301p
end type
type dw_main2 from uo_search_dwc within w_hjh301p
end type
type dw_con from uo_dwfree within w_hjh301p
end type
end forward

global type w_hjh301p from w_condition_window
dw_main dw_main
dw_main2 dw_main2
dw_con dw_con
end type
global w_hjh301p w_hjh301p

type variables
datawindowchild	idw_zip_nm
end variables

on w_hjh301p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_main2=create dw_main2
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_main2
this.Control[iCurrent+3]=this.dw_con
end on

on w_hjh301p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_main2)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.getchild("zip_nm2", idw_zip_nm)
idw_zip_nm.settransobject(sqlca)

idw_zip_nm.Retrieve('%')

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = func.of_get_sdate('YYYY')


end event

event ue_retrieve;call super::ue_retrieve;integer	li_row
string	ls_year, ls_gubun, ls_zip_nm1, ls_zip_nm2

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_gubun     =	dw_con.Object.gubun[1]
ls_zip_nm1  =  func.of_nvl(dw_con.Object.zip_nm1[1], '%')
ls_zip_nm2  =  func.of_nvl(dw_con.Object.zip_nm2[1], '%')

if ls_zip_nm1 = '전체'  Then ls_zip_nm1 = '%' ;

if ls_year =''or isnull(ls_year) then
	messagebox('확인', "신,편입생 및 졸업생 년도와 학기를 입력하세요!")
	return -1 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

if ls_gubun = '1' Then
	dw_main.visible = true
	dw_main2.visible = false
	li_row = dw_main.retrieve(ls_year, ls_zip_nm1, ls_zip_nm2)
else
	dw_main.visible = false
	dw_main2.visible = true
	li_row = dw_main2.retrieve(ls_year, ls_zip_nm1, ls_zip_nm2)
end if

if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjh301p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh301p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh301p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh301p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh301p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh301p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh301p
end type

type uc_insert from w_condition_window`uc_insert within w_hjh301p
end type

type uc_delete from w_condition_window`uc_delete within w_hjh301p
end type

type uc_save from w_condition_window`uc_save within w_hjh301p
end type

type uc_excel from w_condition_window`uc_excel within w_hjh301p
end type

type uc_print from w_condition_window`uc_print within w_hjh301p
end type

type st_line1 from w_condition_window`st_line1 within w_hjh301p
end type

type st_line2 from w_condition_window`st_line2 within w_hjh301p
end type

type st_line3 from w_condition_window`st_line3 within w_hjh301p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh301p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh301p
end type

type gb_1 from w_condition_window`gb_1 within w_hjh301p
end type

type gb_2 from w_condition_window`gb_2 within w_hjh301p
end type

type dw_main from uo_search_dwc within w_hjh301p
integer x = 55
integer y = 304
integer width = 4375
integer height = 1960
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_hjh301a"
end type

type dw_main2 from uo_search_dwc within w_hjh301p
integer x = 55
integer y = 304
integer width = 4375
integer height = 1960
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_hjh301b"
end type

type dw_con from uo_dwfree within w_hjh301p
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 180
boolean bringtotop = true
string dataobject = "dw_hjh301p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String	ls_text

Choose case dwo.name
	Case 'zip_nm1'
		
		If Data = '전체' Then
			ls_text = '%'
		Else
			ls_text = Data
		End If

		If idw_zip_nm.retrieve(ls_text) < 1 Then
			idw_zip_nm.insertrow(0)
		End If
		
End Choose
end event

