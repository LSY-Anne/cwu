$PBExportHeader$w_hjk202pp.srw
$PBExportComments$[청운대]도서 미납자조회
forward
global type w_hjk202pp from w_popup
end type
type sle_1 from uo_sle_hakbun within w_hjk202pp
end type
type st_1 from statictext within w_hjk202pp
end type
type dw_1 from uo_input_dwc within w_hjk202pp
end type
end forward

global type w_hjk202pp from w_popup
integer width = 2263
integer height = 1660
string title = "도서 미납자 조회"
sle_1 sle_1
st_1 st_1
dw_1 dw_1
end type
global w_hjk202pp w_hjk202pp

type variables
string 	is_hakbun, is_id, is_gwa, is_hakyun
long 		il_money
datawindow idwc
window iw_win
Transaction SQLBOOK
end variables

on w_hjk202pp.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_hjk202pp.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;string	ls_hakbun

//Transaction 생성
SQLBOOK = Create Transaction
 
// Profile cwulib
//SQLCA1.DBMS = "OLE DB"
//SQLCA1.LogPass = "volcanokey"
//SQLCA1.LogId = "sa"
//SQLCA1.AutoCommit = False
//SQLCA1.DBParm = "PROVIDER='MSDASQL',LOCATION='210.95.165.200',DATASOURCE='volcanoi'"
////SQLCA1.DBParm = "PROVIDER='MSDASQL',DATASOURCE='volcanoi'"

SQLBOOK.DBMS = "OLE DB"
SQLBOOK.LogPass = "skybluekey"
SQLBOOK.LogId = "skybluestaff"
SQLBOOK.AutoCommit = False
SQLBOOK.DBParm = "PROVIDER='MSDASQL',LOCATION='210.95.165.202',DATASOURCE='skyblueopen'"
	
CONNECT USING SQLBOOK ;

IF SQLBOOK.SQLCODE <> 0 THEN
	MessageBox("연결 오류", SQLBOOK.SQLERRTEXT)
	RETURN
END IF


//학번을 넘겨받음//////////////////////////////////////////////////////////////////
str_parms str_balgup
str_balgup = Message.PowerObjectParm

ls_hakbun 	= str_balgup.s[1] 		// 학번

sle_1.text = ls_hakbun

This.Event ue_inquiry()



end event

event ue_inquiry;call super::ue_inquiry;string	ls_hakbun
integer 	li_row = 0, li_i

ls_hakbun 	= sle_1.text

if ls_hakbun = '' or isnull(ls_hakbun) then
	messagebox("확인", "학번을 입력하세요.", Information!)
	sle_1.setfocus()
	return -1
end if

dw_1.settransobject(SQLBOOK)

li_row = dw_1.retrieve(ls_hakbun)

if li_row < 1 then 
	li_row = 0
end if

st_msg.text = string(li_row) + '건 반납하지 않은 도서가 조회되었습니다.'

end event

event ue_ok;call super::ue_ok;Disconnect Using SQLBOOK;

close(This)
end event

type p_msg from w_popup`p_msg within w_hjk202pp
end type

type st_msg from w_popup`st_msg within w_hjk202pp
integer width = 2062
end type

type uc_printpreview from w_popup`uc_printpreview within w_hjk202pp
end type

type uc_cancel from w_popup`uc_cancel within w_hjk202pp
end type

type uc_ok from w_popup`uc_ok within w_hjk202pp
end type

type uc_excelroad from w_popup`uc_excelroad within w_hjk202pp
end type

type uc_excel from w_popup`uc_excel within w_hjk202pp
end type

type uc_save from w_popup`uc_save within w_hjk202pp
end type

type uc_delete from w_popup`uc_delete within w_hjk202pp
end type

type uc_insert from w_popup`uc_insert within w_hjk202pp
end type

type uc_retrieve from w_popup`uc_retrieve within w_hjk202pp
end type

type ln_temptop from w_popup`ln_temptop within w_hjk202pp
integer endx = 2254
end type

type ln_1 from w_popup`ln_1 within w_hjk202pp
integer endx = 2254
end type

type ln_2 from w_popup`ln_2 within w_hjk202pp
end type

type ln_3 from w_popup`ln_3 within w_hjk202pp
integer beginx = 2208
integer endx = 2208
end type

type r_backline1 from w_popup`r_backline1 within w_hjk202pp
end type

type r_backline2 from w_popup`r_backline2 within w_hjk202pp
end type

type r_backline3 from w_popup`r_backline3 within w_hjk202pp
end type

type uc_print from w_popup`uc_print within w_hjk202pp
end type

type sle_1 from uo_sle_hakbun within w_hjk202pp
integer x = 265
integer y = 52
integer width = 439
integer height = 76
integer taborder = 200
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_1 from statictext within w_hjk202pp
integer x = 101
integer y = 56
integer width = 178
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "학번"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from uo_input_dwc within w_hjk202pp
integer x = 50
integer y = 176
integer width = 2144
integer height = 1260
integer taborder = 50
string dataobject = "d_hjk202pp_1"
end type

event constructor;//OVERRIDE

end event

