$PBExportHeader$w_hdr203a.srw
$PBExportComments$[청운대]은행계좌관리
forward
global type w_hdr203a from w_condition_window
end type
type dw_con from uo_dwfree within w_hdr203a
end type
type dw_main from uo_dwfree within w_hdr203a
end type
end forward

global type w_hdr203a from w_condition_window
dw_con dw_con
dw_main dw_main
end type
global w_hdr203a w_hdr203a

on w_hdr203a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hdr203a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;string	ls_gwa
long 		ll_ans

dw_con.AcceptText()

ls_gwa    	=	func.of_nvl(dw_con.Object.gwa[1], '%')

ll_ans = dw_main.retrieve(ls_gwa)

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

event ue_insert;string ls_year, ls_hakgi, ls_dhw, ls_hakgwa, ls_gwajung
long ll_line, ll_row = 0

ll_row = dw_main.getrow()

ll_line = dw_main.insertrow(ll_row + 1)
dw_main.scrolltorow(ll_line)

dw_main.SetColumn('hakbun')
dw_main.setfocus()
end event

event ue_delete;int li_ans

//삭제확인
if uf_messagebox(4) = 2 then return

dw_main.deleterow(0)

end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr203a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr203a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr203a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr203a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr203a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr203a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr203a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr203a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr203a
end type

type uc_save from w_condition_window`uc_save within w_hdr203a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr203a
end type

type uc_print from w_condition_window`uc_print within w_hdr203a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr203a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr203a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr203a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr203a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr203a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr203a
end type

type gb_2 from w_condition_window`gb_2 within w_hdr203a
end type

type dw_con from uo_dwfree within w_hdr203a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_hdr203a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hdr203a
integer x = 50
integer y = 300
integer width = 4379
integer height = 1960
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hdr203a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string	ls_name, ls_gwa, ls_bank, ls_account_name, ls_account_no

this.AcceptText()

CHOOSE CASE	DWO.NAME
		
	CASE	'hakbun'
		
		SELECT	A.HNAME,
					A.GWA,
					A.BANK_ID,
					A.ACCOUNT_NAME,
					A.ACCOUNT_NO
		INTO		:ls_name,
					:ls_gwa,
					:ls_bank,
					:ls_account_name,
					:ls_account_no
		FROM		HAKSA.JAEHAK_HAKJUK	A
		WHERE	A.HAKBUN		=	:data		
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","잘못된 수험번호입니다.~r~n" + sqlca.sqlerrtext)
			this.object.hakbun[row] = ''
			return 1
			
		end if
		
		dw_main.object.gwa[row]				= ls_gwa
		dw_main.object.hname[row]			= ls_name
		dw_main.object.bank_id[row]		= ls_bank
		dw_main.object.account_name[row]	= ls_account_name
		dw_main.object.account_no[row]	= ls_account_no
		dw_main.SetColumn('bank_id')
		
END CHOOSE
end event

event itemerror;call super::itemerror;return 2
end event

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

