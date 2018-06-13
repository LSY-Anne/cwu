$PBExportHeader$w_hsu204a.srw
$PBExportComments$[청운대]휴보강신청서
forward
global type w_hsu204a from w_condition_window
end type
type dw_2 from uo_input_dwc within w_hsu204a
end type
type dw_3 from uo_input_dwc within w_hsu204a
end type
type st_4 from statictext within w_hsu204a
end type
type st_5 from statictext within w_hsu204a
end type
type dw_con from uo_dwfree within w_hsu204a
end type
end forward

global type w_hsu204a from w_condition_window
integer width = 4512
dw_2 dw_2
dw_3 dw_3
st_4 st_4
st_5 st_5
dw_con dw_con
end type
global w_hsu204a w_hsu204a

type variables


end variables

on w_hsu204a.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_4=create st_4
this.st_5=create st_5
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.dw_con
end on

on w_hsu204a.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_con)
end on

event open;call super::open;idw_update[1] = dw_3

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

if f_enabled_chk(gs_empcode) = 1 then
	dw_con.Object.prof_no[1] = gs_empcode
    dw_con.Object.prof_no.Protect = 1
end if
end event

event ue_retrieve;string	ls_year, ls_hakgi, ls_member_no
long		li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_member_no	=  dw_con.Object.prof_no[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
elseif ls_member_no = "" or isnull(ls_member_no) then
	messagebox("확인","교수를 입력하지 않았습니다...!")
	dw_con.SetFocus()
	dw_con.SetColumn("prof_no")
	return -1
end if

li_ans	=	dw_2.retrieve(ls_year,	ls_hakgi, ls_member_no)

if li_ans = 0 then
	dw_2.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_2.setfocus()
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu204a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu204a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu204a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu204a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu204a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu204a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu204a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu204a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu204a
end type

type uc_save from w_condition_window`uc_save within w_hsu204a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu204a
end type

type uc_print from w_condition_window`uc_print within w_hsu204a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu204a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu204a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu204a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu204a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu204a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu204a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu204a
integer taborder = 90
end type

type dw_2 from uo_input_dwc within w_hsu204a
integer x = 55
integer y = 380
integer width = 1925
integer height = 1884
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu200a_4"
end type

event clicked;call super::clicked;string		ls_year, ls_hakgi, ls_member_no, ls_gwamok_id
long			ll_gwamok_seq

if row <= 0 then return

ls_year			=	this.object.year[row]
ls_hakgi			=	this.object.hakgi[row]
ls_gwamok_id	=  this.object.gwamok_id[row]
ll_gwamok_seq	=  this.object.gwamok_seq[row]
ls_member_no	=  this.object.member_no[row]

dw_3.retrieve(ls_year,	ls_hakgi, ls_member_no, ls_gwamok_id, ll_gwamok_seq)


end event

event doubleclicked;call super::doubleclicked;string		ls_year, ls_hakgi, ls_member_no, ls_gwamok_id, ls_yoil, ls_sigan, ls_gwa, ls_bunban
long			ll_gwamok_seq, ll_rowcount

if row <= 0 then return

ll_rowcount		=	dw_3.insertrow(0)

ls_year			=	this.object.year[row]
ls_hakgi			=	this.object.hakgi[row]
ls_gwamok_id	=  this.object.gwamok_id[row]
ll_gwamok_seq	=  this.object.gwamok_seq[row]
ls_member_no	=  this.object.member_no[row]
ls_yoil			=  this.object.yoil[row]
ls_sigan			=  this.object.sigan[row]
ls_gwa            =  this.object.gwa[row]
ls_bunban        =  this.object.bunban[row]

dw_3.setitem(ll_rowcount, "year", ls_year)
dw_3.setitem(ll_rowcount, "hakgi", ls_hakgi)
dw_3.setitem(ll_rowcount, "sinchung_member_no", ls_member_no)
dw_3.setitem(ll_rowcount, "sinchung_gwamok_id", ls_gwamok_id)
dw_3.setitem(ll_rowcount, "sinchung_gwamok_seq", ll_gwamok_seq)
dw_3.setitem(ll_rowcount, "sinchung_yoil", ls_yoil)
dw_3.setitem(ll_rowcount, "sinchung_sigan", ls_sigan)
dw_3.setitem(ll_rowcount, "gwa", ls_gwa)
dw_3.setitem(ll_rowcount, "sinchung_bunban", ls_bunban)
end event

type dw_3 from uo_input_dwc within w_hsu204a
integer x = 1993
integer y = 380
integer width = 2441
integer height = 1884
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu200a_4_1"
end type

type st_4 from statictext within w_hsu204a
integer x = 55
integer y = 296
integer width = 1925
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "기존강의"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_hsu204a
integer x = 1993
integer y = 296
integer width = 2441
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "휴보강계획"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hsu204a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hsu204a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

