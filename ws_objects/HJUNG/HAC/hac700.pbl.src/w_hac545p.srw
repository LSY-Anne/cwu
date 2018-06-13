$PBExportHeader$w_hac545p.srw
$PBExportComments$추경 자금예산 수지현황
forward
global type w_hac545p from w_print_form1
end type
type uo_bdgt_class from cuo_bdgt_class within w_hac545p
end type
type st_2 from statictext within w_hac545p
end type
type dw_list from datawindow within w_hac545p
end type
end forward

global type w_hac545p from w_print_form1
string title = "예산 총괄표(예산부서용)"
uo_bdgt_class uo_bdgt_class
st_2 st_2
dw_list dw_list
end type
global w_hac545p w_hac545p

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 회계단위
dw_print.getchild('acct_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('acct_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

dw_print.retrieve(is_bdgt_year, is_bef_bdgt_year, ii_bdgt_class, is_slip_class, is_amt_gubun)

if is_slip_class = '' or is_slip_class = '1'	then
	dw_list.retrieve(is_bdgt_year, is_bef_bdgt_year, '1', ii_bdgt_class, is_amt_gubun)
	dw_print.setitem(1, 'i_amt1', dw_list.getitemnumber(1, 'comp_sum_amt_all'))
	dw_print.setitem(1, 'i_amt2', dw_list.getitemnumber(1, 'comp_sum_bef_amt_all'))
end if
if is_slip_class = '' or is_slip_class = '2'	then
	dw_list.retrieve(is_bdgt_year, is_bef_bdgt_year, '2', ii_bdgt_class, is_amt_gubun)
	dw_print.setitem(1, 'o_amt1', dw_list.getitemnumber(1, 'comp_sum_amt_all'))
	dw_print.setitem(1, 'o_amt2', dw_list.getitemnumber(1, 'comp_sum_bef_amt_all'))
end if


//String	ls_name
//integer	li_cnt
//
//st_back.bringtotop = true
//
//select	count(*)
//into		:li_cnt
//from		acdb.hac011h 
//where		bdgt_year	in	(:is_bdgt_year, :is_bef_bdgt_year)
//and		substr(acct_code, 1, 1)	like	:is_slip_class || '%'
//and		bdgt_class	=	:ii_bdgt_class
//and		decode(:is_amt_gubun, '1', req_amt, '2', adjust_amt, '3', confirm_amt) <> 0	;
//
//if li_cnt < 1 then	return
//
////if dw_print.retrieve(is_bdgt_year, is_bef_bdgt_year, ii_bdgt_class, is_slip_class, is_amt_gubun) > 0 then
////	st_back.bringtotop = false
////end if
//
//// 수입 ---> 미사용전기이월자금(금년/전년)
//// 지출 ---> 미사용차기이월자금(금년/전년)
//string	ls_year, ls_return
//string	ls_year_name[] = {'금년도 ', '전년도 '}
//dec		ld_amt[]
//integer	i
//
//if dw_print.retrieve(is_bdgt_year, is_bef_bdgt_year, ii_bdgt_class, is_slip_class, is_amt_gubun) > 0 then
//	// 미사용전기이월금액을 구한다.
//	if is_slip_class = '%' or is_slip_class = '1' then
//		for i = 1 to 2
//			ls_return	= ''
//			ld_amt[i]	= 0
//			
//			if i = 1 then
//				ls_year = is_bdgt_year
//			else
//				ls_year = is_bef_bdgt_year
//			end if
//			ls_return = f_gettransamt(ls_year, '', '1')
//
//			if left(ls_return, 1) <> '0' then
//				f_messagebox('3', ls_year_name[i] + '이월자금을 구할 수 없습니다.~n~n전산실에 문의하세요.!')
//				return
//			end if	
//			
//			ls_return = mid(ls_return, 2, len(ls_return))
//			
//			ld_amt[i]  = dec(ls_return)
//			
//			dw_print.modify("ad_i_amt" + string(i) + ".expression = '" + string(ld_amt[i]) + "'	")
//		next	
//	end if
//
//	// 미사용차기이월금액을 구한다.(미사용차기이월금액은 0로 넣어준다.)
//	if is_slip_class = '%' or is_slip_class = '2' then
//		for i = 1 to 2
//			ls_return	= ''
//			ld_amt[i]	= 0
////
////			if i = 1 then
////				ls_year = is_bdgt_year
////			else
////				ls_year = is_bef_bdgt_year
////			end if
////			ls_return = f_gettransamt(ls_year, '', '2')
////			
////			if left(ls_return, 1) <> '0' then
////				f_messagebox('3', ls_year_name[i] + '이월자금을 구할 수 없습니다.~n~n전산실에 문의하세요.!')
////				return
////			end if	
////			
////			ls_return = mid(ls_return, 2, len(ls_return))
////			
////			ld_amt[i]  = dec(ls_return)
////	
//			dw_print.modify("ad_o_amt" + string(i) + ".expression = '" + string(ld_amt[i]) + "'	")
//		next	
//	end if
//	st_back.bringtotop = false
//end if
end subroutine

on w_hac545p.create
int iCurrent
call super::create
this.uo_bdgt_class=create uo_bdgt_class
this.st_2=create st_2
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_bdgt_class
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_list
end on

on w_hac545p.destroy
call super::destroy
destroy(this.uo_bdgt_class)
destroy(this.st_2)
destroy(this.dw_list)
end on

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

ii_bdgt_class	=	uo_bdgt_class.uf_getcode()
is_amt_gubun	=	'3'

dw_print.modify("t_univ_name.text = '" + gstru_uid_uname.univ_name + "'	")

//triggerevent('ue_retrieve')

end event

type uo_slip_class from w_print_form1`uo_slip_class within w_hac545p
end type

type rb_3 from w_print_form1`rb_3 within w_hac545p
boolean visible = false
end type

type rb_2 from w_print_form1`rb_2 within w_hac545p
boolean visible = false
end type

type rb_1 from w_print_form1`rb_1 within w_hac545p
boolean visible = false
end type

type gb_1 from w_print_form1`gb_1 within w_hac545p
end type

type uo_bdgt_year from w_print_form1`uo_bdgt_year within w_hac545p
integer x = 69
end type

type gb_3 from w_print_form1`gb_3 within w_hac545p
end type

type st_back from w_print_form1`st_back within w_hac545p
end type

type dw_print from w_print_form1`dw_print within w_hac545p
string dataobject = "d_hac545p_1"
end type

type uo_bdgt_class from cuo_bdgt_class within w_hac545p
event destroy ( )
integer x = 1989
integer y = 52
integer width = 1088
integer taborder = 80
boolean bringtotop = true
end type

on uo_bdgt_class.destroy
call cuo_bdgt_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_bdgt_class	=	uf_getcode()

end event

type st_2 from statictext within w_hac545p
integer x = 3118
integer y = 72
integer width = 736
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "※ 반드시 조회를 해주세요."
boolean focusrectangle = false
end type

type dw_list from datawindow within w_hac545p
boolean visible = false
integer x = 1856
integer y = 40
integer width = 768
integer height = 432
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_hac545p_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

