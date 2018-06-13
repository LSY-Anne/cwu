$PBExportHeader$w_ansan.srw
forward
global type w_ansan from w_ancsheet
end type
type dw_1 from uo_dwlv within w_ansan
end type
type dw_2 from uo_dwlv within w_ansan
end type
type dw_3 from uo_dwlv within w_ansan
end type
type dw_4 from uo_dwlv within w_ansan
end type
type dw_5 from uo_dwlv within w_ansan
end type
type dw_6 from uo_dwlv within w_ansan
end type
type dw_7 from uo_dwlv within w_ansan
end type
type dw_8 from uo_dwlv within w_ansan
end type
type dw_9 from uo_dwlv within w_ansan
end type
type dw_10 from uo_dwlv within w_ansan
end type
type dw_11 from uo_dwlv within w_ansan
end type
type dw_12 from uo_dwlv within w_ansan
end type
type dw_13 from uo_dwlv within w_ansan
end type
type dw_14 from uo_dwlv within w_ansan
end type
type dw_15 from uo_dwlv within w_ansan
end type
type dw_16 from uo_dwlv within w_ansan
end type
type st_1 from statictext within w_ansan
end type
end forward

global type w_ansan from w_ancsheet
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
dw_6 dw_6
dw_7 dw_7
dw_8 dw_8
dw_9 dw_9
dw_10 dw_10
dw_11 dw_11
dw_12 dw_12
dw_13 dw_13
dw_14 dw_14
dw_15 dw_15
dw_16 dw_16
st_1 st_1
end type
global w_ansan w_ansan

type variables
long il_time
end variables
on w_ansan.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.dw_6=create dw_6
this.dw_7=create dw_7
this.dw_8=create dw_8
this.dw_9=create dw_9
this.dw_10=create dw_10
this.dw_11=create dw_11
this.dw_12=create dw_12
this.dw_13=create dw_13
this.dw_14=create dw_14
this.dw_15=create dw_15
this.dw_16=create dw_16
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.dw_5
this.Control[iCurrent+6]=this.dw_6
this.Control[iCurrent+7]=this.dw_7
this.Control[iCurrent+8]=this.dw_8
this.Control[iCurrent+9]=this.dw_9
this.Control[iCurrent+10]=this.dw_10
this.Control[iCurrent+11]=this.dw_11
this.Control[iCurrent+12]=this.dw_12
this.Control[iCurrent+13]=this.dw_13
this.Control[iCurrent+14]=this.dw_14
this.Control[iCurrent+15]=this.dw_15
this.Control[iCurrent+16]=this.dw_16
this.Control[iCurrent+17]=this.st_1
end on

on w_ansan.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.dw_8)
destroy(this.dw_9)
destroy(this.dw_10)
destroy(this.dw_11)
destroy(this.dw_12)
destroy(this.dw_13)
destroy(this.dw_14)
destroy(this.dw_15)
destroy(this.dw_16)
destroy(this.st_1)
end on

event open;call super::open;il_time = CPU()
end event

event ue_postopen;call super::ue_postopen;st_1.text = String(CPU() - il_time)
end event

type ln_templeft from w_ancsheet`ln_templeft within w_ansan
end type

type ln_tempright from w_ancsheet`ln_tempright within w_ansan
end type

type ln_temptop from w_ancsheet`ln_temptop within w_ansan
end type

type ln_tempbuttom from w_ancsheet`ln_tempbuttom within w_ansan
end type

type ln_tempbutton from w_ancsheet`ln_tempbutton within w_ansan
end type

type ln_tempstart from w_ancsheet`ln_tempstart within w_ansan
end type

type dw_1 from uo_dwlv within w_ansan
integer x = 69
integer y = 52
integer width = 969
integer height = 440
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_2 from uo_dwlv within w_ansan
integer x = 1088
integer y = 52
integer width = 969
integer height = 440
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_3 from uo_dwlv within w_ansan
integer x = 2089
integer y = 44
integer width = 969
integer height = 440
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_4 from uo_dwlv within w_ansan
integer x = 3118
integer y = 40
integer width = 969
integer height = 440
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_5 from uo_dwlv within w_ansan
integer x = 3118
integer y = 504
integer width = 969
integer height = 440
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_6 from uo_dwlv within w_ansan
integer x = 2089
integer y = 508
integer width = 969
integer height = 440
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_7 from uo_dwlv within w_ansan
integer x = 1088
integer y = 516
integer width = 969
integer height = 440
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_8 from uo_dwlv within w_ansan
integer x = 69
integer y = 516
integer width = 969
integer height = 440
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_9 from uo_dwlv within w_ansan
integer x = 3118
integer y = 968
integer width = 969
integer height = 440
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_10 from uo_dwlv within w_ansan
integer x = 2089
integer y = 972
integer width = 969
integer height = 440
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_11 from uo_dwlv within w_ansan
integer x = 1088
integer y = 980
integer width = 969
integer height = 440
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_12 from uo_dwlv within w_ansan
integer x = 69
integer y = 980
integer width = 969
integer height = 440
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_13 from uo_dwlv within w_ansan
integer x = 3118
integer y = 1432
integer width = 969
integer height = 440
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_14 from uo_dwlv within w_ansan
integer x = 2089
integer y = 1436
integer width = 969
integer height = 440
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_15 from uo_dwlv within w_ansan
integer x = 1088
integer y = 1444
integer width = 969
integer height = 440
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type dw_16 from uo_dwlv within w_ansan
integer x = 69
integer y = 1444
integer width = 969
integer height = 440
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_empcode"
end type

type st_1 from statictext within w_ansan
integer x = 315
integer y = 1920
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

