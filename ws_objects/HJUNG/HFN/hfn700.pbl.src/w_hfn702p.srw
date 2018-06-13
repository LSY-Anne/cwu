$PBExportHeader$w_hfn702p.srw
$PBExportComments$일별입출금명세서
forward
global type w_hfn702p from w_hfn_print_form5
end type
end forward

global type w_hfn702p from w_hfn_print_form5
end type
global w_hfn702p w_hfn702p

type variables

end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_getchild ()
end prototypes

public subroutine wf_retrieve ();DateTime	ldt_SysDateTime
  string ls_bdgt_year
    date ld_date
	 long ll_cnt
String ls_str_date, ls_end_date	 
dw_con.accepttext()

ls_str_date = String(dw_con.object.fr_date[1], 'yyyymmdd')
ls_end_date = String(dw_con.object.to_date[1], 'yyyymmdd')

dw_print.Reset()


if ls_str_date > ls_end_date then
	f_messagebox('1', '회계일자의 범위가 올바르지 않습니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return
end if

// 요구기간 설정
select count(*) into :Ll_cnt from acdb.hac003m
 where (:ls_str_date between from_date and to_date
        and bdgt_class = 0
	     and stat_class = 0)
	and (:ls_end_date between from_date and to_date
        and bdgt_class = 0
	     and stat_class = 0);
 
if ll_cnt < 1 then
	f_messagebox('1', '요구기간에 해당하는 일자가 아닙니다.~r~r' + &
	                  '확인 후 조회하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return
end if

// 회계년도 시작일자
select bdgt_year into :ls_bdgt_year from acdb.hac003m
 where :ls_str_date between from_date and to_date
   and bdgt_class = 0
	and stat_class = 0 ;

wf_setMsg('조회중')

dw_print.SetRedraw(False)
dw_print.retrieve(gi_acct_class, ls_bdgt_year, ls_str_date, ls_end_date)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true
end if

wf_setMsg('')

end subroutine

public subroutine wf_getchild ();// ==========================================================================================
// 기    능	:	DatawindowChild Getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
// 회계구분
dw_print.getchild('jagum_gubun', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jagum_gubun', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 예금종류
dw_print.getchild('hfn003m_depo_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('depo_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

on w_hfn702p.create
int iCurrent
call super::create
end on

on w_hfn702p.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//string  ls_sys_date
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//
//ls_sys_date = f_today()
//
//em_fr_date.text = string(ls_sys_date,'@@@@/@@/@@')
//em_to_date.text = string(ls_sys_date,'@@@@/@@/@@')
//
//wf_getchild()
//
//em_fr_date.SetFocus()
end event

event ue_postopen;call super::ue_postopen;string  ls_sys_date



ls_sys_date = f_today()

dw_con.object.fr_date[1] = date(string(ls_sys_date,'@@@@/@@/@@'))
dw_con.object.to_date[1] = date(string(ls_sys_date,'@@@@/@@/@@'))
idw_print = dw_print 

wf_getchild()

dw_con.SetFocus()
dw_con.setcolumn('to_date')
end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "일별 입출금 명세서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn702p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn702p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn702p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn702p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn702p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn702p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn702p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn702p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn702p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn702p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn702p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn702p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn702p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn702p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn702p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn702p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn702p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn702p
boolean visible = false
integer x = 1573
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn702p
boolean visible = false
integer x = 2190
integer taborder = 0
long backcolor = 1073741824
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn702p
integer taborder = 20
string dataobject = "d_hfn702p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn702p
string dataobject = "d_hfn306q_con"
end type

event dw_con::constructor;call super::constructor;this.object.fr_date_t.text = '조회일자'
end event

