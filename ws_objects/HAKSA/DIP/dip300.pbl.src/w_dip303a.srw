$PBExportHeader$w_dip303a.srw
$PBExportComments$[대학원입시] 합격판정
forward
global type w_dip303a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dip303a
end type
type dw_con from uo_dwfree within w_dip303a
end type
type uo_1 from uo_imgbtn within w_dip303a
end type
end forward

global type w_dip303a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_dip303a w_dip303a

on w_dip303a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
end on

on w_dip303a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string	ls_year, ls_hakgi, ls_mojip, ls_jongbyul, ls_gyeyul
long		ll_ans, i

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_mojip  	=	dw_con.Object.mojip_id[1]
ls_jongbyul 	=	dw_con.Object.jongbyul_id[1]
ls_gyeyul 	=	func.of_nvl(dw_con.Object.gyeyul_id[1], '%') + '%'

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
end if

if ls_mojip = ''  or Isnull(ls_mojip) then
	messagebox("확인","모집구분을 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("mojip_id")
	return -1
end if

if ls_jongbyul = ''  or Isnull(ls_jongbyul) then
	messagebox("확인","종별을 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("jongbyul_id")
	return -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_mojip, ls_jongbyul, ls_gyeyul)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;string	ls_hakgi, ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	NEXT_YEAR,      NEXT_HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi

end event

event ue_save;int	li_ans

dw_main.AcceptText()

//저장
li_ans = dw_main.update()
					
if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback using sqlca ;
else	
	commit using sqlca ;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_dip303a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dip303a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dip303a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dip303a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dip303a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dip303a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dip303a
end type

type uc_insert from w_condition_window`uc_insert within w_dip303a
end type

type uc_delete from w_condition_window`uc_delete within w_dip303a
end type

type uc_save from w_condition_window`uc_save within w_dip303a
end type

type uc_excel from w_condition_window`uc_excel within w_dip303a
end type

type uc_print from w_condition_window`uc_print within w_dip303a
end type

type st_line1 from w_condition_window`st_line1 within w_dip303a
end type

type st_line2 from w_condition_window`st_line2 within w_dip303a
end type

type st_line3 from w_condition_window`st_line3 within w_dip303a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dip303a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dip303a
end type

type gb_1 from w_condition_window`gb_1 within w_dip303a
end type

type gb_2 from w_condition_window`gb_2 within w_dip303a
end type

type dw_main from uo_input_dwc within w_dip303a
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dip303a"
end type

type dw_con from uo_dwfree within w_dip303a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 220
boolean bringtotop = true
string dataobject = "d_dip302a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_dip303a
integer x = 585
integer y = 40
integer width = 375
integer taborder = 20
boolean bringtotop = true
string btnname = "초기화"
end type

event clicked;call super::clicked;long i

if dw_main.rowcount() <=0 then
	messagebox("확인","조회후 실행하세요.")
	return
end if

for i = 1 to dw_main.rowcount()
	dw_main.object.hap_id[i]	=	'01'
next
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

