$PBExportHeader$cuo_display_title.sru
$PBExportComments$각 항목 출력타이틀 Datawindow
forward
global type cuo_display_title from datawindow
end type
end forward

global type cuo_display_title from datawindow
integer width = 1403
integer height = 464
string title = "none"
string dataobject = "d_display_title"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global cuo_display_title cuo_display_title

type variables

end variables

forward prototypes
public subroutine uf_display_title (datawindow adw_1, integer ai_pay_opt)
end prototypes

public subroutine uf_display_title (datawindow adw_1, integer ai_pay_opt);// ==========================================================================================
// 기    능 : 	출력 타이틀을 구한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	uf_display_title(datawindow adw_1, integer ai_pay_opt)
// 인    수 :	adw_1			-	datawindow
//					ai_pay_opt	-	0:정상급여대장, 1:소급금대장(수당명칭만 나온다.)
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_subcnt, li_pay_opt, li_sort
long		ll_rowcount
string	ls_title[] = {'sudang', 'gongje'}

for li_pay_opt = 1 to 2
	if ai_pay_opt	=	0 then
		ll_rowcount = retrieve(string(li_pay_opt))
	else
		ll_rowcount = retrieve(string(ai_pay_opt))
	end if

	for li_subcnt = 1 to ll_rowcount
		li_sort = getitemnumber(li_subcnt, 'sort')
		adw_1.modify(ls_title[li_pay_opt] + '_' + string(li_sort) + "_t.expression = ~"'" + &
					getitemstring(li_subcnt, 'display_name') + "'~"	")
	next
next

end subroutine

on cuo_display_title.create
end on

on cuo_display_title.destroy
end on

