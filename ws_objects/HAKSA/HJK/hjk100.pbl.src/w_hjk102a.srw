$PBExportHeader$w_hjk102a.srw
$PBExportComments$[청운대]인정학점관리
forward
global type w_hjk102a from w_condition_window
end type
type st_3 from statictext within w_hjk102a
end type
type dw_con from uo_dwfree within w_hjk102a
end type
type dw_main from uo_dwfree within w_hjk102a
end type
end forward

global type w_hjk102a from w_condition_window
st_3 st_3
dw_con dw_con
dw_main dw_main
end type
global w_hjk102a w_hjk102a

on w_hjk102a.create
int iCurrent
call super::create
this.st_3=create st_3
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_main
end on

on w_hjk102a.destroy
call super::destroy
destroy(this.st_3)
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;string 	ls_gwa, ls_hakbun, ls_year
int 		li_ans, li_cnt

dw_con.AcceptText()

//조회조건
ls_year		= func.of_nvl(dw_con.Object.year[1], '%')
ls_gwa		= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_hakbun 	= func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'

li_ans = dw_main.retrieve(ls_year, ls_gwa, ls_hakbun )
li_cnt =  dw_main.rowcount()

st_3.text = '총인원 : ' + string(li_cnt)

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
end event

event open;call super::open;String ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

ls_year = func.of_get_sdate('YYYY')

dw_con.Object.year[1] = ls_year
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk102a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk102a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk102a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk102a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk102a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk102a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk102a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk102a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk102a
end type

type uc_save from w_condition_window`uc_save within w_hjk102a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk102a
end type

type uc_print from w_condition_window`uc_print within w_hjk102a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk102a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk102a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk102a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk102a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk102a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk102a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk102a
end type

type st_3 from statictext within w_hjk102a
integer x = 59
integer y = 296
integer width = 4370
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 15793151
long backcolor = 8388736
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hjk102a
integer x = 55
integer y = 168
integer width = 4375
integer height = 116
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk102a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hjk102a
integer x = 59
integer y = 396
integer width = 4370
integer height = 1864
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk102a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string	ls_name

CHOOSE CASE dwo.name
		
	CASE 'college_id'
		
		dw_main.accepttext()
		
		This.object.college_name[row] = This.Object.college_id_name[row]
		
	CASE 'college_gwa'
		
		dw_main.accepttext()
		
		This.object.college_gwaname[row] = This.Object.com_gwa[row]
		
END CHOOSE
end event

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

