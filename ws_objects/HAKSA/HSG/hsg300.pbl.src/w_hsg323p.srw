$PBExportHeader$w_hsg323p.srw
$PBExportComments$[청운대]지도교수 배정관리 현황표
forward
global type w_hsg323p from w_condition_window
end type
type em_1 from uo_em_year within w_hsg323p
end type
type st_1 from statictext within w_hsg323p
end type
type st_3 from statictext within w_hsg323p
end type
type dw_1 from uo_dddw_dwc within w_hsg323p
end type
type dw_main from uo_search_dwc within w_hsg323p
end type
type st_2 from statictext within w_hsg323p
end type
type dw_5 from datawindow within w_hsg323p
end type
type st_6 from statictext within w_hsg323p
end type
type dw_4 from uo_dddw_dwc within w_hsg323p
end type
end forward

global type w_hsg323p from w_condition_window
integer width = 3927
em_1 em_1
st_1 st_1
st_3 st_3
dw_1 dw_1
dw_main dw_main
st_2 st_2
dw_5 dw_5
st_6 st_6
dw_4 dw_4
end type
global w_hsg323p w_hsg323p

type variables

end variables

on w_hsg323p.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.st_3=create st_3
this.dw_1=create dw_1
this.dw_main=create dw_main
this.st_2=create st_2
this.dw_5=create dw_5
this.st_6=create st_6
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_main
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_5
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.dw_4
end on

on w_hsg323p.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.dw_main)
destroy(this.st_2)
destroy(this.dw_5)
destroy(this.st_6)
destroy(this.dw_4)
end on

event open;call super::open;wf_setmenu('RETRIEVE', 	TRUE)
wf_setmenu('INSERT', 	FALSE)
wf_setmenu('DELETE', 	FALSE)
wf_setmenu('SAVE', 		FALSE)
wf_setmenu('PRINT', 		TRUE)

idw_print = dw_main

end event

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi,  ls_hakgwa,  ls_member
long   ll_row,  ii,        kk

ls_year    = em_1.text
ls_hakgwa  = dw_1.gettext() + '%'
ls_hakgi   = dw_5.gettext()
ls_member  = dw_4.gettext() + '%'
IF isnull(ls_hakgi) OR ls_hakgi = '' THEN
	messagebox("알림", '학기를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

ll_row     = dw_main.retrieve(ls_year, ls_hakgi, ls_hakgwa, ls_member)
if ll_row = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)

elseif ll_row = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

dw_main.modify("DataWindow.Print.Preview = no")
return 1
end event

event ue_print;dw_main.Object.DataWindow.Zoom = 88

if idw_print.rowcount() > 0 then
	openwithparm(w_printoption,idw_print)
	dw_main.Object.DataWindow.Zoom = 100
else
//	uf_messagebox(7)
	return
end if
end event

event ue_open;call super::ue_open;dw_5.SetTransobject(sqlca)
dw_5.retrieve()

String ls_year,  ls_hakgi

SELECT fname
  INTO :ls_year
  FROM cddb.kch001m
 WHERE type   = 'SUM00'
   AND code   = '10';
	
SELECT fname
  INTO :ls_hakgi
  FROM cddb.kch001m
 WHERE type   = 'SUM00'
   AND code   = '20';
	
em_1.text     = ls_year
dw_5.Settext(ls_hakgi)

end event

type gb_1 from w_condition_window`gb_1 within w_hsg323p
integer height = 264
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsg323p
integer taborder = 90
end type

type em_1 from uo_em_year within w_hsg323p
integer x = 311
integer y = 112
integer width = 242
integer taborder = 10
boolean bringtotop = true
end type

type st_1 from statictext within w_hsg323p
integer x = 146
integer y = 128
integer width = 137
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_hsg323p
integer x = 1454
integer y = 128
integer width = 197
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
string text = "학 과"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from uo_dddw_dwc within w_hsg323p
integer x = 1646
integer y = 112
integer width = 795
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_list_hakgwa"
end type

type dw_main from uo_search_dwc within w_hsg323p
integer x = 27
integer y = 312
integer width = 3826
integer height = 2164
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsg323p"
end type

type st_2 from statictext within w_hsg323p
integer x = 635
integer y = 128
integer width = 174
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
string text = "학 기"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_5 from datawindow within w_hsg323p
integer x = 814
integer y = 112
integer width = 576
integer height = 84
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_list_hakgi"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_hsg323p
integer x = 2546
integer y = 128
integer width = 160
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
string text = "교 수"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_4 from uo_dddw_dwc within w_hsg323p
integer x = 2725
integer y = 112
integer width = 562
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_list_prof"
end type

event itemchanged;call super::itemchanged;parent.triggerevent('ue_retrieve')
end event

