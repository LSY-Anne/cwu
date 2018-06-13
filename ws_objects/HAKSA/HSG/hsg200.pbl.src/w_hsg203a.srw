$PBExportHeader$w_hsg203a.srw
$PBExportComments$[청운대]동아리 행사관리
forward
global type w_hsg203a from w_condition_window
end type
type em_1 from uo_em_year within w_hsg203a
end type
type st_1 from statictext within w_hsg203a
end type
type st_3 from statictext within w_hsg203a
end type
type ddlb_1 from uo_ddlb_hakgi within w_hsg203a
end type
type dw_1 from uo_dddw_dwc within w_hsg203a
end type
type st_2 from statictext within w_hsg203a
end type
type dw_main from uo_dwgrid within w_hsg203a
end type
type uo_1 from u_tab within w_hsg203a
end type
type st_4 from statictext within w_hsg203a
end type
end forward

global type w_hsg203a from w_condition_window
em_1 em_1
st_1 st_1
st_3 st_3
ddlb_1 ddlb_1
dw_1 dw_1
st_2 st_2
dw_main dw_main
uo_1 uo_1
st_4 st_4
end type
global w_hsg203a w_hsg203a

on w_hsg203a.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.st_2=create st_2
this.dw_main=create dw_main
this.uo_1=create uo_1
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.ddlb_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_main
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.st_4
end on

on w_hsg203a.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.dw_main)
destroy(this.uo_1)
destroy(this.st_4)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_dongari
int li_ans

//조회조건
ls_year		=	em_1.text
ls_hakgi		=	ddlb_1.text
ls_dongari	= 	dw_1.gettext() + '%'


if ls_year = '' or ls_hakgi = '' then
	messagebox("확인","년도, 학기를 입력하세요.")
	return -1
end if

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_dongari)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_main.setfocus()
end if

return 1
end event

event ue_save;call super::ue_save;int li_ans

li_ans = dw_main.update()

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback;
	return -1
else	
	commit;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if
return 1
end event

event open;call super::open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	TRUE)
//wf_setmenu('DELETE', 	TRUE)
//wf_setmenu('SAVE', 		TRUE)
//wf_setmenu('PRINT', 		FALSE)
//
end event

event ue_insert;call super::ue_insert;long		ll_row, ll_newrow, ll_getrow, i
string	ls_year, ls_hakgi, ls_dongari
string	ls_db_id, ls_dw_id, ls_id, ls_loop

ls_year		=	em_1.text
ls_hakgi		=	ddlb_1.text

if	ls_year = "" or ls_year = ""  then
	messagebox("확인","검색조건을 입력하세요.")
	return
end if

SELECT NVL(MAX(SERIAL), '00000000')
INTO :ls_db_id
FROM	HAKSA.DONGARI_HENGSA	;

ls_dw_id = '00000000'

//Loop를 돌면서 데이타윈도우에 나와 있는 sikpum_id중 가장 큰값을 가져온다.
if dw_main.rowcount() >= 1 then 
	for i = 1 to dw_main.rowcount()
		ls_loop = dw_main.object.serial[i]
		
		if ls_dw_id <= ls_loop then
			ls_dw_id = ls_loop
	
		end if
	next
end if

//DB의 serial와 DW의 serial를 비교하여 값을 정한다.
if ls_db_id >= ls_dw_id then
	ls_id = string(long(ls_db_id) + 1, '00000000')
	
elseif ls_db_id < ls_dw_id then
	ls_id = string(long(ls_dw_id) + 1, '00000000')
	
end if

//dw_1.accepttext()
ll_getrow	=	dw_main.getrow()
ll_newrow		=	dw_main.insertrow(ll_getrow + 1)

if ll_newrow <> -1 then
	dw_main.object.serial[ll_newrow]	= ls_id
	dw_main.object.year[ll_newrow]	= ls_year
	dw_main.object.hakgi[ll_newrow]	= ls_hakgi
	
   dw_main.ScrollToRow(ll_newrow)    //추가된 행에 스크롤
	dw_main.setcolumn('dongari_id')              //추가된 행의 첫번째 컬럼에 커서 위치
	dw_main.setfocus()                //dw_MAIN 포커스 이동
end if
end event

event ue_delete;call super::ue_delete;long	li_ans

dw_main.deleterow(0)

li_ans = dw_main.update()	

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback;
else	
	commit;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

event closequery;call super::closequery;int li_ans
	
li_ans = f_save_before_close(this, dw_main)

if li_ans = 1 then
//	m_main_menu.m_edit.m_f3.triggerevent(clicked!)
	this.triggerevent("ue_save")							/*	window의 저장 이벤트를 트리거*/
	
elseif li_ans = 3 then
	return -1													// 취소
	
end if
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsg203a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsg203a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsg203a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsg203a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsg203a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsg203a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsg203a
end type

type uc_insert from w_condition_window`uc_insert within w_hsg203a
end type

type uc_delete from w_condition_window`uc_delete within w_hsg203a
end type

type uc_save from w_condition_window`uc_save within w_hsg203a
end type

type uc_excel from w_condition_window`uc_excel within w_hsg203a
end type

type uc_print from w_condition_window`uc_print within w_hsg203a
end type

type st_line1 from w_condition_window`st_line1 within w_hsg203a
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_condition_window`st_line2 within w_hsg203a
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_condition_window`st_line3 within w_hsg203a
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsg203a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsg203a
end type

type gb_1 from w_condition_window`gb_1 within w_hsg203a
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
end type

type gb_2 from w_condition_window`gb_2 within w_hsg203a
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
end type

type em_1 from uo_em_year within w_hsg203a
integer x = 462
integer y = 184
integer width = 242
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_1 from statictext within w_hsg203a
integer x = 306
integer y = 200
integer width = 137
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "년도"
boolean focusrectangle = false
end type

type st_3 from statictext within w_hsg203a
integer x = 891
integer y = 196
integer width = 165
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from uo_ddlb_hakgi within w_hsg203a
integer x = 1061
integer y = 184
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_1 from uo_dddw_dwc within w_hsg203a
integer x = 1701
integer y = 184
integer width = 777
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_list_dongari"
end type

type st_2 from statictext within w_hsg203a
integer x = 1481
integer y = 200
integer width = 219
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "동아리"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_main from uo_dwgrid within w_hsg203a
integer x = 55
integer y = 320
integer width = 4375
integer height = 1968
integer taborder = 10
string dataobject = "d_hsg203a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 100)
end event

type uo_1 from u_tab within w_hsg203a
integer x = 2053
integer y = 372
integer height = 148
integer taborder = 40
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "dw_main"
end type

on uo_1.destroy
call u_tab::destroy
end on

type st_4 from statictext within w_hsg203a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 31112622
boolean focusrectangle = false
end type

