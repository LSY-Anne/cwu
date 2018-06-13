$PBExportHeader$w_hsg101p.srw
$PBExportComments$[청운대]상담지도
forward
global type w_hsg101p from w_condition_window
end type
type st_5 from statictext within w_hsg101p
end type
type dw_2 from uo_dddw_dwc within w_hsg101p
end type
type dw_1 from uo_search_dwc within w_hsg101p
end type
type em_from_year from editmask within w_hsg101p
end type
type em_to_year from editmask within w_hsg101p
end type
type dw_3 from uo_dddw_dwc within w_hsg101p
end type
type st_1 from statictext within w_hsg101p
end type
type st_2 from statictext within w_hsg101p
end type
type st_3 from statictext within w_hsg101p
end type
end forward

global type w_hsg101p from w_condition_window
st_5 st_5
dw_2 dw_2
dw_1 dw_1
em_from_year em_from_year
em_to_year em_to_year
dw_3 dw_3
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_hsg101p w_hsg101p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hsg101p.create
int iCurrent
call super::create
this.st_5=create st_5
this.dw_2=create dw_2
this.dw_1=create dw_1
this.em_from_year=create em_from_year
this.em_to_year=create em_to_year
this.dw_3=create dw_3
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.em_from_year
this.Control[iCurrent+5]=this.em_to_year
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
end on

on w_hsg101p.destroy
call super::destroy
destroy(this.st_5)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.em_from_year)
destroy(this.em_to_year)
destroy(this.dw_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;wf_setmenu('RETRIEVE', 	TRUE)
wf_setmenu('INSERT', 	TRUE)
wf_setmenu('DELETE', 	TRUE)
wf_setmenu('SAVE', 		TRUE)
wf_setmenu('PRINT', 		FALSE)

//사용자가 교수이면 검색조건의 교수를 ENABLED
if f_enabled_chk(gstru_uid_uname.uid) = 1 then
	dw_2.SetItem(1, 1, gstru_uid_uname.uid)
	dw_2.enabled = false
	
end if
end event

event ue_retrieve;call super::ue_retrieve;int		li_row
string 	ls_gwa, ls_prof_id, ls_from_year, ls_to_year
ls_gwa	=	dw_3.gettext() + '%'
ls_prof_id	=	dw_2.gettext() + '%'
ls_from_year 		=	em_from_year.text
ls_to_year	=	em_to_year.text


li_row = dw_1.retrieve(ls_gwa, ls_prof_id, ls_from_year, ls_to_year)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_1.setfocus()
return 1
end event

type gb_1 from w_condition_window`gb_1 within w_hsg101p
integer x = 0
end type

type gb_2 from w_condition_window`gb_2 within w_hsg101p
integer x = 0
end type

type st_5 from statictext within w_hsg101p
integer x = 1088
integer y = 116
integer width = 187
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "교수"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from uo_dddw_dwc within w_hsg101p
integer x = 1262
integer y = 100
integer width = 571
integer height = 80
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_list_prof"
end type

type dw_1 from uo_search_dwc within w_hsg101p
integer x = 18
integer y = 320
integer width = 3808
integer height = 2164
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_hsg101p"
end type

type em_from_year from editmask within w_hsg101p
integer x = 2258
integer y = 100
integer width = 325
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####"
boolean spin = true
double increment = 1
end type

type em_to_year from editmask within w_hsg101p
integer x = 3150
integer y = 104
integer width = 325
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####"
boolean spin = true
double increment = 1
end type

type dw_3 from uo_dddw_dwc within w_hsg101p
integer x = 210
integer y = 100
integer width = 805
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_list_daepyogwa_coll"
end type

type st_1 from statictext within w_hsg101p
integer x = 64
integer y = 116
integer width = 137
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
string text = "학과"
boolean focusrectangle = false
end type

type st_2 from statictext within w_hsg101p
integer x = 1979
integer y = 116
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "시작년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_hsg101p
integer x = 2807
integer y = 116
integer width = 325
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
string text = "마지막년도"
boolean focusrectangle = false
end type

