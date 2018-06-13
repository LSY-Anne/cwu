$PBExportHeader$w_hjh101pp.srw
$PBExportComments$[청운대]보훈번호등록
forward
global type w_hjh101pp from w_popup
end type
type st_3 from statictext within w_hjh101pp
end type
type dw_gwa from uo_dddw_dwc within w_hjh101pp
end type
type sle_search from uo_sle within w_hjh101pp
end type
type dw_search from uo_input_dwc within w_hjh101pp
end type
type st_2 from statictext within w_hjh101pp
end type
end forward

global type w_hjh101pp from w_popup
integer width = 3886
integer height = 1652
string title = "보훈대상자 보훈번호등록"
boolean clientedge = true
st_3 st_3
dw_gwa dw_gwa
sle_search sle_search
dw_search dw_search
st_2 st_2
end type
global w_hjh101pp w_hjh101pp

on w_hjh101pp.create
int iCurrent
call super::create
this.st_3=create st_3
this.dw_gwa=create dw_gwa
this.sle_search=create sle_search
this.dw_search=create dw_search
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.dw_gwa
this.Control[iCurrent+3]=this.sle_search
this.Control[iCurrent+4]=this.dw_search
this.Control[iCurrent+5]=this.st_2
end on

on w_hjh101pp.destroy
call super::destroy
destroy(this.st_3)
destroy(this.dw_gwa)
destroy(this.sle_search)
destroy(this.dw_search)
destroy(this.st_2)
end on

event open;call super::open;sle_search.setfocus()

end event

event ue_inquiry;call super::ue_inquiry;string	ls_search,	&
			ls_gwa
integer 	li_row = 0

ls_gwa		= dw_gwa.gettext() + '%'
ls_search	= trim(sle_search.text) +'%'

if len(ls_search) = 0 then
	messagebox("확인", "이름 또는 학번을 입력하세요!", Information!)
	sle_search.setfocus()
	return -1
end if

li_row = dw_search.retrieve(ls_gwa, ls_search)

if li_row < 1 then 
	li_row = 0
end if


Return 1

end event

event ue_ok;call super::ue_ok;close(This) 
end event

type p_msg from w_popup`p_msg within w_hjh101pp
end type

type st_msg from w_popup`st_msg within w_hjh101pp
integer width = 3634
end type

type uc_printpreview from w_popup`uc_printpreview within w_hjh101pp
integer x = 2336
end type

type uc_cancel from w_popup`uc_cancel within w_hjh101pp
integer x = 3287
end type

type uc_ok from w_popup`uc_ok within w_hjh101pp
integer x = 3003
end type

type uc_excelroad from w_popup`uc_excelroad within w_hjh101pp
integer x = 1947
end type

type uc_excel from w_popup`uc_excel within w_hjh101pp
integer x = 1664
end type

type uc_save from w_popup`uc_save within w_hjh101pp
integer x = 1381
end type

type uc_delete from w_popup`uc_delete within w_hjh101pp
integer x = 1097
end type

type uc_insert from w_popup`uc_insert within w_hjh101pp
integer x = 814
end type

type uc_retrieve from w_popup`uc_retrieve within w_hjh101pp
integer x = 530
end type

type ln_temptop from w_popup`ln_temptop within w_hjh101pp
integer endx = 3858
end type

type ln_1 from w_popup`ln_1 within w_hjh101pp
integer endx = 3858
end type

type ln_2 from w_popup`ln_2 within w_hjh101pp
end type

type ln_3 from w_popup`ln_3 within w_hjh101pp
integer beginx = 3799
integer endx = 3799
end type

type r_backline1 from w_popup`r_backline1 within w_hjh101pp
end type

type r_backline2 from w_popup`r_backline2 within w_hjh101pp
end type

type r_backline3 from w_popup`r_backline3 within w_hjh101pp
end type

type uc_print from w_popup`uc_print within w_hjh101pp
integer x = 2720
end type

type st_3 from statictext within w_hjh101pp
integer x = 105
integer y = 208
integer width = 169
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 16777215
string text = "학과: "
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_gwa from uo_dddw_dwc within w_hjh101pp
integer x = 279
integer y = 200
integer width = 800
integer taborder = 30
string dataobject = "d_list_hakgwa"
end type

type sle_search from uo_sle within w_hjh101pp
integer x = 1897
integer y = 200
integer width = 535
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

event modified;integer 	li_row = 0
string	ls_gwa

ls_gwa = dw_gwa.gettext() + '%'

li_row = dw_search.retrieve(ls_gwa, trim(sle_search.text)+'%')

if li_row < 1 then 
	li_row = 0
	this.selecttext(1, len(this.text))
	this.setfocus()
end if

//st_row.text = string(li_row) + '건 조회되었습니다.'

end event

type dw_search from uo_input_dwc within w_hjh101pp
integer x = 50
integer y = 312
integer width = 3744
integer height = 1124
integer taborder = 40
string dataobject = "d_hjh101pp_1"
end type

event doubleclicked;call super::doubleclicked;long i
string ls_hakbun, ls_name, ls_hakyun, ls_hakgi

i = dw_search.getrow()

if i > 0 then
	ls_hakbun = dw_search.object.hakbun[i]
	ls_name = dw_search.object.hname[i]
	ls_hakyun = dw_search.object.hakyun[i]
	ls_hakgi = dw_search.object.hakgi[i]

	closewithreturn(parent, ls_hakbun + ls_hakyun + ls_hakgi + ls_name)
else
	messagebox('확인', "학번 및 이름, 주빈번호를 다시입력하여주세요")
	return 0
	sle_search.setfocus()
end if
end event

event rowfocuschanged;//override
end event

type st_2 from statictext within w_hjh101pp
integer x = 1138
integer y = 208
integer width = 754
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 16777215
string text = "학번/이름/주민번호 검색: "
alignment alignment = center!
boolean focusrectangle = false
end type

