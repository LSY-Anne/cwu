$PBExportHeader$w_hgj301pp.srw
$PBExportComments$[청운대]자격사정팝업
forward
global type w_hgj301pp from window
end type
type sle_2 from singlelineedit within w_hgj301pp
end type
type st_6 from statictext within w_hgj301pp
end type
type st_4 from statictext within w_hgj301pp
end type
type sle_1 from singlelineedit within w_hgj301pp
end type
type em_2 from editmask within w_hgj301pp
end type
type st_2 from statictext within w_hgj301pp
end type
type em_1 from editmask within w_hgj301pp
end type
type st_1 from statictext within w_hgj301pp
end type
type cb_2 from commandbutton within w_hgj301pp
end type
type cb_1 from commandbutton within w_hgj301pp
end type
type cbx_3 from checkbox within w_hgj301pp
end type
type cbx_2 from checkbox within w_hgj301pp
end type
type cbx_1 from checkbox within w_hgj301pp
end type
type gb_1 from groupbox within w_hgj301pp
end type
end forward

global type w_hgj301pp from window
integer width = 1088
integer height = 1228
boolean titlebar = true
string title = "자격증 항목 부여"
windowtype windowtype = response!
boolean clientedge = true
sle_2 sle_2
st_6 st_6
st_4 st_4
sle_1 sle_1
em_2 em_2
st_2 st_2
em_1 em_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
gb_1 gb_1
end type
global w_hgj301pp w_hgj301pp

on w_hgj301pp.create
this.sle_2=create sle_2
this.st_6=create st_6
this.st_4=create st_4
this.sle_1=create sle_1
this.em_2=create em_2
this.st_2=create st_2
this.em_1=create em_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.gb_1=create gb_1
this.Control[]={this.sle_2,&
this.st_6,&
this.st_4,&
this.sle_1,&
this.em_2,&
this.st_2,&
this.em_1,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1,&
this.gb_1}
end on

on w_hgj301pp.destroy
destroy(this.sle_2)
destroy(this.st_6)
destroy(this.st_4)
destroy(this.sle_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.gb_1)
end on

event open;f_centerme(this)
end event

type sle_2 from singlelineedit within w_hgj301pp
integer x = 494
integer y = 532
integer width = 457
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_hgj301pp
integer x = 178
integer y = 552
integer width = 297
integer height = 48
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
string text = "시작번호 :"
boolean focusrectangle = false
end type

type st_4 from statictext within w_hgj301pp
integer x = 238
integer y = 444
integer width = 251
integer height = 48
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
string text = "기관명 :"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_hgj301pp
integer x = 494
integer y = 424
integer width = 457
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type em_2 from editmask within w_hgj301pp
integer x = 539
integer y = 776
integer width = 421
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
boolean spin = true
double increment = 1
end type

event constructor;this.text = string(today(), 'yyyymmdd')
end event

type st_2 from statictext within w_hgj301pp
integer x = 238
integer y = 796
integer width = 315
integer height = 48
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
string text = "발급일자 :"
boolean focusrectangle = false
end type

type em_1 from editmask within w_hgj301pp
integer x = 539
integer y = 176
integer width = 421
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
boolean spin = true
double increment = 1
end type

event constructor;this.text = string(today(), 'yyyymmdd')
end event

type st_1 from statictext within w_hgj301pp
integer x = 238
integer y = 184
integer width = 315
integer height = 48
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
string text = "검정일자 :"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_hgj301pp
integer x = 517
integer y = 964
integer width = 283
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "취소"
end type

event clicked;s_jaguk_sahang	s_jaguk
s_jaguk.yesno = '0'

closewithreturn(parent, s_jaguk)
end event

type cb_1 from commandbutton within w_hgj301pp
integer x = 215
integer y = 964
integer width = 283
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "확인"
boolean default = true
end type

event clicked;s_jaguk_sahang	s_jaguk

if cbx_1.checked = true then	
	s_jaguk.musihum_yn = 'Y'
	s_jaguk.musihumil = string(date(em_1.text), 'yyyymmdd')
else
	s_jaguk.musihum_yn	= 'N'
	s_jaguk.musihumil		= ''
end if

if cbx_2.checked = true then			
	s_jaguk.jung_yn = 'Y'
	s_jaguk.gigwan = trim(sle_1.text)
else
	s_jaguk.jung_yn = 'N'
end if		

if cbx_3.checked = true then
	s_jaguk.balgup_yn = 'Y'
	s_jaguk.balgupil = string(date(em_2.text), 'yyyymmdd')
else
	s_jaguk.balgup_yn = 'N'
	s_jaguk.balgupil = ''
end if

s_jaguk.yesno = '1'

closewithreturn(parent, s_jaguk)

end event

type cbx_3 from checkbox within w_hgj301pp
integer x = 123
integer y = 692
integer width = 759
integer height = 92
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
string text = "자격증 발급일자 부여"
end type

type cbx_2 from checkbox within w_hgj301pp
integer x = 123
integer y = 316
integer width = 818
integer height = 92
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
string text = "증서번호 및 발급기관 부여"
end type

type cbx_1 from checkbox within w_hgj301pp
integer x = 123
integer y = 80
integer width = 759
integer height = 92
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
string text = "무시험 검정 신청일 부여"
end type

type gb_1 from groupbox within w_hgj301pp
integer x = 27
integer y = 12
integer width = 1006
integer height = 916
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388736
string text = "항목 선택"
end type

