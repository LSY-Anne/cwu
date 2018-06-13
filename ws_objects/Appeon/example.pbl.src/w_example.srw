$PBExportHeader$w_example.srw
forward
global type w_example from w_ancsheet
end type
type dw_1 from uo_dwgrid within w_example
end type
type st_1 from statictext within w_example
end type
type dw_2 from uo_dwfree within w_example
end type
type st_2 from statictext within w_example
end type
type tab_1 from tab within w_example
end type
type tabpage_1 from userobject within tab_1
end type
type st_4 from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_4 st_4
end type
type tabpage_2 from userobject within tab_1
end type
type st_5 from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_5 st_5
end type
type tabpage_3 from userobject within tab_1
end type
type st_6 from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
st_6 st_6
end type
type tabpage_4 from userobject within tab_1
end type
type st_7 from statictext within tabpage_4
end type
type tabpage_4 from userobject within tab_1
st_7 st_7
end type
type tab_1 from tab within w_example
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type p_1 from u_picture within w_example
end type
type st_3 from statictext within w_example
end type
type uo_2 from uo_imgbtn within w_example
end type
type em_1 from editmask within w_example
end type
type uo_1 from u_tab within w_example
end type
end forward

global type w_example from w_ancsheet
dw_1 dw_1
st_1 st_1
dw_2 dw_2
st_2 st_2
tab_1 tab_1
p_1 p_1
st_3 st_3
uo_2 uo_2
em_1 em_1
uo_1 uo_1
end type
global w_example w_example

on w_example.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.dw_2=create dw_2
this.st_2=create st_2
this.tab_1=create tab_1
this.p_1=create p_1
this.st_3=create st_3
this.uo_2=create uo_2
this.em_1=create em_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.p_1
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.uo_2
this.Control[iCurrent+9]=this.em_1
this.Control[iCurrent+10]=this.uo_1
end on

on w_example.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.tab_1)
destroy(this.p_1)
destroy(this.st_3)
destroy(this.uo_2)
destroy(this.em_1)
destroy(this.uo_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.setTransobject(sqlca)
dw_1.retrieve()


dw_2.setTransObject(sqlca)
dw_2.insertrow(0)
end event

type ln_templeft from w_ancsheet`ln_templeft within w_example
end type

type ln_tempright from w_ancsheet`ln_tempright within w_example
end type

type ln_temptop from w_ancsheet`ln_temptop within w_example
end type

type ln_tempbuttom from w_ancsheet`ln_tempbuttom within w_example
end type

type ln_tempbutton from w_ancsheet`ln_tempbutton within w_example
end type

type ln_tempstart from w_ancsheet`ln_tempstart within w_example
end type

type dw_1 from uo_dwgrid within w_example
integer x = 46
integer y = 164
integer width = 1842
integer height = 808
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_example"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_1 from statictext within w_example
integer x = 46
integer y = 160
integer width = 1842
integer height = 816
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean border = true
long bordercolor = 29992855
boolean focusrectangle = false
end type

type dw_2 from uo_dwfree within w_example
integer x = 2203
integer y = 164
integer width = 2235
integer height = 788
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_free"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;IF row = 0 THEN Return

IF dwo.name = 'dept_name' THEN
	String ls_date
	ls_date = this.getItemString(row, String(dwo.name))
	IF gf_dwsetdate( This, String(dwo.name), ls_date) THEN
		This.SetItem(row, String(dwo.name), ls_date)
	END IF
END IF
end event

type st_2 from statictext within w_example
integer x = 2203
integer y = 160
integer width = 2235
integer height = 796
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean border = true
long bordercolor = 29992855
boolean focusrectangle = false
end type

type tab_1 from tab within w_example
integer x = 46
integer y = 1080
integer width = 1600
integer height = 932
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
boolean showtext = false
boolean showpicture = false
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 48
integer width = 1563
integer height = 868
long backcolor = 16777215
string text = "탭일"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_4 st_4
end type

on tabpage_1.create
this.st_4=create st_4
this.Control[]={this.st_4}
end on

on tabpage_1.destroy
destroy(this.st_4)
end on

type st_4 from statictext within tabpage_1
integer x = 402
integer y = 176
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "1"
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 48
integer width = 1563
integer height = 868
long backcolor = 16777215
string text = "탭이"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_5 st_5
end type

on tabpage_2.create
this.st_5=create st_5
this.Control[]={this.st_5}
end on

on tabpage_2.destroy
destroy(this.st_5)
end on

type st_5 from statictext within tabpage_2
integer x = 402
integer y = 176
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "2"
boolean focusrectangle = false
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 48
integer width = 1563
integer height = 868
long backcolor = 16777215
string text = "탭삼"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_6 st_6
end type

on tabpage_3.create
this.st_6=create st_6
this.Control[]={this.st_6}
end on

on tabpage_3.destroy
destroy(this.st_6)
end on

type st_6 from statictext within tabpage_3
integer x = 402
integer y = 176
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "3"
boolean focusrectangle = false
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 48
integer width = 1563
integer height = 868
long backcolor = 16777215
string text = "탭사"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_7 st_7
end type

on tabpage_4.create
this.st_7=create st_7
this.Control[]={this.st_7}
end on

on tabpage_4.destroy
destroy(this.st_7)
end on

type st_7 from statictext within tabpage_4
integer x = 402
integer y = 176
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "4"
boolean focusrectangle = false
end type

type p_1 from u_picture within w_example
integer x = 2149
integer y = 1068
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_add.gif"
end type

type st_3 from statictext within w_example
integer x = 2633
integer y = 996
integer width = 402
integer height = 172
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

event clicked;p_1.of_enable(True)

end event

type uo_2 from uo_imgbtn within w_example
integer x = 1769
integer y = 1068
integer width = 357
integer taborder = 30
boolean bringtotop = true
string btnname = "결체처리"
end type

on uo_2.destroy
call uo_imgbtn::destroy
end on

type em_1 from editmask within w_example
integer x = 1806
integer y = 1280
integer width = 411
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
end type

event rbuttondown;IF gf_emsetdate(This) THEN this.setFocus()
end event

type uo_1 from u_tab within w_example
integer x = 279
integer y = 1252
integer taborder = 50
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

