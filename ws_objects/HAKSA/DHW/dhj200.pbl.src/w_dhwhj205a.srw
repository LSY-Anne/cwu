$PBExportHeader$w_dhwhj205a.srw
$PBExportComments$[대학원학적] 상벌관리
forward
global type w_dhwhj205a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwhj205a
end type
type dw_con from uo_dwfree within w_dhwhj205a
end type
end forward

global type w_dhwhj205a from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_dhwhj205a w_dhwhj205a

on w_dhwhj205a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_dhwhj205a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;call super::ue_retrieve;string ls_hakbun, ls_sangbul
long ll_ans

dw_con.AcceptText()

ls_hakbun =	 func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'
ls_sangbul = func.of_nvl(dw_con.Object.sangbul[1], '%') + '%'

ll_ans = dw_main.retrieve(ls_hakbun, ls_sangbul)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

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

event ue_insert;call super::ue_insert;long ll_line, ll_row, ll_bigo = 0, ll_max

SELECT	NVL(MAX(SERIAL), 0)
INTO	:ll_max
FROM	HAKSA.D_SANGBUL
 USING SQLCA ;

ll_row = dw_main.rowcount()

if ll_row > 0 then
	ll_bigo = dw_main.object.d_sangbul_serial[ll_row]
	
end if

if ll_max >= ll_bigo then
	ll_max = ll_max + 1
else
	ll_max = ll_bigo + 1
end if

ll_line = dw_main.insertrow(0)

dw_main.object.d_sangbul_serial[ll_line] = ll_max

dw_main.scrolltorow(ll_line)
dw_main.setcolumn(1)
dw_main.setfocus()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwhj205a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwhj205a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwhj205a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwhj205a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwhj205a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwhj205a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwhj205a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwhj205a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwhj205a
end type

type uc_save from w_condition_window`uc_save within w_dhwhj205a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwhj205a
end type

type uc_print from w_condition_window`uc_print within w_dhwhj205a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwhj205a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwhj205a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwhj205a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwhj205a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwhj205a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwhj205a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwhj205a
end type

type dw_main from uo_input_dwc within w_dhwhj205a
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwhj205a"
end type

event itemchanged;call super::itemchanged;string ls_name

if dwo.name = 'd_sangbul_hakbun'  then
	SELECT	HNAME
	INTO	:ls_name
	FROM	HAKSA.D_HAKJUK
	WHERE	HAKBUN = :data 
	USING SQLCA ;
	
	if sqlca.sqlcode = 0 then
		this.object.d_hakjuk_hname[row] = ls_name
	else
		messagebox("오류","존재하지 않는 학번입니다.")
		return 1
	end if
	
end if
end event

event itemerror;call super::itemerror;RETURN 2
end event

type dw_con from uo_dwfree within w_dhwhj205a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_dhwhj205a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

