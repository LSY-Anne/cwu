$PBExportHeader$cuo_yymmdd.sru
$PBExportComments$금일일자 조회.
forward
global type cuo_yymmdd from userobject
end type
type em_yymmddtoday from editmask within cuo_yymmdd
end type
end forward

global type cuo_yymmdd from userobject
integer width = 457
integer height = 92
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
em_yymmddtoday em_yymmddtoday
end type
global cuo_yymmdd cuo_yymmdd

forward prototypes
public function string uf_getyymmdd ()
end prototypes

public function string uf_getyymmdd ();//////////////////////////////////////////////////////////////////
// 	작성목적 : 금일일자를 리턴한다.
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

String s_data
s_data = f_numbercheck(em_yymmddtoday.text)
return s_data
end function

on cuo_yymmdd.create
this.em_yymmddtoday=create em_yymmddtoday
this.Control[]={this.em_yymmddtoday}
end on

on cuo_yymmdd.destroy
destroy(this.em_yymmddtoday)
end on

event constructor;//////////////////////////////////////////////////////////////////
// 	작성목적 : 금일일자를 나타낸다.
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

em_yymmddtoday.text = f_dateformat(gstru_uid_uname.current_day)
end event

type em_yymmddtoday from editmask within cuo_yymmdd
integer width = 457
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy.mm.dd"
end type

