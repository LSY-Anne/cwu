$PBExportHeader$w_dhwhj102a.srw
$PBExportComments$[대학원] 학사일정관리
forward
global type w_dhwhj102a from w_condition_window
end type
type dw_con from uo_dwfree within w_dhwhj102a
end type
type dw_main from uo_dwfree within w_dhwhj102a
end type
end forward

global type w_dhwhj102a from w_condition_window
dw_con dw_con
dw_main dw_main
end type
global w_dhwhj102a w_dhwhj102a

on w_dhwhj102a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_dhwhj102a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

ll_ans = dw_main.retrieve(ls_year, ls_hakgi)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event ue_insert;call super::ue_insert;string ls_year, ls_hakgi, ls_dhw, ls_hakgwa, ls_gwajung
long ll_line

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

ll_line = dw_main.insertrow(0)
dw_main.scrolltorow(ll_line)

dw_main.object.year[ll_line]		=	ls_year
dw_main.object.hakgi[ll_line]		=	ls_hakgi
	

dw_main.SetColumn(1)
dw_main.setfocus()
end event

event ue_delete;call super::ue_delete;int li_ans

//삭제확인
if uf_messagebox(4) = 2 then return

dw_main.deleterow(0)
li_ans = dw_main.update()								

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback USING SQLCA ;
else	
	commit USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

event open;call super::open;string	ls_hakgi, ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi

dw_main.InsertRow(0)
end event

event ue_saveend;call super::ue_saveend;int li_ans
string ls_flag, ls_year, ls_hakgi

dw_main.AcceptText()

ls_year	=	dw_main.object.year[dw_main.getrow()]
ls_hakgi	=	dw_main.object.hakgi[dw_main.getrow()]
ls_flag	=	dw_main.object.sijum_flag[dw_main.getrow()]

//현재학기 flag가 '1'이면 다른 년도/학기의 현재학기 flag를 '0'으로 한다.
if ls_flag = '1' then
	UPDATE HAKSA.D_HAKSA_ILJUNG
	SET	SIJUM_FLAG	=	'0'
	WHERE	YEAR||HAKGI	<> :ls_year||:ls_hakgi
	USING SQLCA ;
			
end if
	
Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwhj102a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwhj102a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwhj102a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwhj102a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwhj102a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwhj102a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwhj102a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwhj102a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwhj102a
end type

type uc_save from w_condition_window`uc_save within w_dhwhj102a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwhj102a
end type

type uc_print from w_condition_window`uc_print within w_dhwhj102a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwhj102a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwhj102a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwhj102a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwhj102a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwhj102a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwhj102a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwhj102a
end type

type dw_con from uo_dwfree within w_dhwhj102a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_dhwhj102a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_dhwhj102a
integer x = 55
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_dhwhj102a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)

func.of_design_dw(dw_main)
end event

