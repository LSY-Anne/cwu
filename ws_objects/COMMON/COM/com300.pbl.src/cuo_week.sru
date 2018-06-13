$PBExportHeader$cuo_week.sru
$PBExportComments$주차조회
forward
global type cuo_week from userobject
end type
type em_week from editmask within cuo_week
end type
type st_2 from statictext within cuo_week
end type
end forward

global type cuo_week from userobject
integer width = 320
integer height = 100
boolean border = true
long backcolor = 80269524
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
em_week em_week
st_2 st_2
end type
global cuo_week cuo_week

forward prototypes
public function integer uf_getweek ()
public subroutine uf_setweek (string as_yy, string as_hakgi, integer ai_month, string as_gubun)
end prototypes

public function integer uf_getweek ();return	integer(em_week.text)

end function

public subroutine uf_setweek (string as_yy, string as_hakgi, integer ai_month, string as_gubun);integer	li_str_week, li_end_week

select	from_weekend, to_weekend
into		:li_str_week, :li_end_week
from		padb.hpa101m
where		year	=	:as_yy
and		hakgi	=	:as_hakgi
and		month	=	:ai_month	;

if sqlca.sqlcode <> 0 then
	f_messagebox('1', string(ai_month) + '월의 주차가 존재하지 않습니다. 확인하시기 바랍니다.!')
	li_str_week = 1
	li_end_week = 4
end if

if as_gubun = 'str' then
	em_week.text = string(li_str_week)
else
	em_week.text = string(li_end_week)
end if	
end subroutine

on cuo_week.create
this.em_week=create em_week
this.st_2=create st_2
this.Control[]={this.em_week,&
this.st_2}
end on

on cuo_week.destroy
destroy(this.em_week)
destroy(this.st_2)
end on

event constructor;em_week.text = ''

end event

type em_week from editmask within cuo_week
integer x = 110
integer width = 197
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
double increment = 1
string minmax = "1~~99"
end type

event modified;parent.triggerevent('ue_itemchange')
end event

type st_2 from statictext within cuo_week
integer y = 20
integer width = 110
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
boolean enabled = false
string text = "주"
alignment alignment = center!
boolean focusrectangle = false
end type

