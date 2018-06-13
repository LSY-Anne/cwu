$PBExportHeader$w_hsu303a.srw
$PBExportComments$[청운대]개인별성적조회
forward
global type w_hsu303a from w_condition_window
end type
type dw_con from uo_dwfree within w_hsu303a
end type
type dw_main from uo_dwfree within w_hsu303a
end type
type st_name from statictext within w_hsu303a
end type
end forward

global type w_hsu303a from w_condition_window
integer width = 4512
dw_con dw_con
dw_main dw_main
st_name st_name
end type
global w_hsu303a w_hsu303a

type variables
long 		il_row, il_seq_no
string 	is_year, is_hakgi, is_gwa,	is_jungong_id, is_hakyun, is_ban, is_juya
string	is_gwamok2, is_member_no,  is_hosil, is_yoil, is_sigan, is_ban_bunhap
string	is_chk, is_gwamok

end variables

on w_hsu303a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
this.st_name=create st_name
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.st_name
end on

on w_hsu303a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.st_name)
end on

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

st_name.setPosition(totop!)
end event

event ue_retrieve;call super::ue_retrieve;string	ls_year,	ls_hakgi, ls_hakbun, ls_gwa_nm, ls_su_hakyun, ls_hname, ls_dr_hakyun
long		li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  dw_con.Object.hakbun[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1
	
elseif	ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
		
elseif	ls_hakbun = "" or isnull(ls_hakbun) then
	uf_messagebox(15)
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return	 -1
	
end if

//학적조회
select	b.fname,
			a.su_hakyun,
			a.hname,
			a.dr_hakyun
into		:ls_gwa_nm,
			:ls_su_hakyun,
			:ls_hname,
			:ls_dr_hakyun
from		haksa.jaehak_hakjuk	a,
			haksa.gwa_sym			b
where		a.gwa		=	b.gwa
and		a.hakbun	=	:ls_hakbun
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("확인","존재하지 않는 학번입니다.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return -1
end if

st_name.text	=	ls_hname + '   ' + ls_gwa_nm + '   ' + ls_su_hakyun + '학년  '

li_ans	=	dw_main.retrieve(ls_year,	ls_hakgi, ls_hakbun)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return -1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return -1
else
	dw_main.setfocus()
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu303a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu303a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu303a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu303a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu303a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu303a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu303a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu303a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu303a
end type

type uc_save from w_condition_window`uc_save within w_hsu303a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu303a
end type

type uc_print from w_condition_window`uc_print within w_hsu303a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu303a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu303a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu303a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu303a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu303a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu303a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu303a
integer taborder = 90
end type

type dw_con from uo_dwfree within w_hsu303a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hsu303a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hsu303a
integer x = 55
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_hsu300a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

type st_name from statictext within w_hsu303a
integer x = 1902
integer y = 188
integer width = 1888
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 32500968
boolean focusrectangle = false
end type

event constructor;this.setPosition(totop!)
end event

