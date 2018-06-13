$PBExportHeader$w_hfn202m_help.srw
$PBExportComments$계정코드도움말(계정코드,계정명)-예산공통으로 자금계정조회시
forward
global type w_hfn202m_help from window
end type
type dw_main from cuo_dwwindow_one_hin within w_hfn202m_help
end type
end forward

global type w_hfn202m_help from window
integer width = 3881
integer height = 928
boolean titlebar = true
string title = "전표내역 조회"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
dw_main dw_main
end type
global w_hfn202m_help w_hfn202m_help

type variables
string	is_acct_code, is_acct_name, is_io_gubun
integer	ii_acct_class
end variables

on w_hfn202m_help.create
this.dw_main=create dw_main
this.Control[]={this.dw_main}
end on

on w_hfn202m_help.destroy
destroy(this.dw_main)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: open
//	기 능 설 명: 전표내역 도움말
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com
integer		li_acct_class,	li_slip_no
string		ls_slip_date

f_centerme(this)

lstr_com = Message.PowerObjectParm

if not isvalid(lstr_com) then close(this)

li_acct_class = integer(lstr_com.ls_item[1])	// 회계단위
ls_slip_date  = lstr_com.ls_item[2]				// 전표일자
li_slip_no	  = integer(lstr_com.ls_item[3])	// 전표번호

dw_main.retrieve(li_acct_class, ls_slip_date, li_slip_no)
dw_main.setfocus()

end event

type dw_main from cuo_dwwindow_one_hin within w_hfn202m_help
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 16
integer width = 3826
integer height = 784
integer taborder = 70
string dataobject = "d_hfn202m_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

