$PBExportHeader$w_hfn_sang_data_1.srw
$PBExportComments$관리항목에 의한 상계Data 조회(new)
forward
global type w_hfn_sang_data_1 from window
end type
type st_2 from statictext within w_hfn_sang_data_1
end type
type st_1 from statictext within w_hfn_sang_data_1
end type
type cb_retrieve from commandbutton within w_hfn_sang_data_1
end type
type cb_cancel from commandbutton within w_hfn_sang_data_1
end type
type cb_ok from commandbutton within w_hfn_sang_data_1
end type
type dw_main from cuo_dwwindow_one_hin within w_hfn_sang_data_1
end type
end forward

global type w_hfn_sang_data_1 from window
integer width = 4146
integer height = 2344
boolean titlebar = true
string title = "미결Data 도움말"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
st_2 st_2
st_1 st_1
cb_retrieve cb_retrieve
cb_cancel cb_cancel
cb_ok cb_ok
dw_main dw_main
end type
global w_hfn_sang_data_1 w_hfn_sang_data_1

type variables
integer		ii_acct_class, ii_close_type = 0
string		is_acct_code
long			il_slip_row
DataStore	ids_param_migyul

end variables

event ue_db_retrieve();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
dw_main.SetReDraw(FALSE)
dw_main.Retrieve(ii_acct_class, is_acct_code)
dw_main.setfocus()
dw_main.SetReDraw(TRUE)

end event

on w_hfn_sang_data_1.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_retrieve=create cb_retrieve
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_main=create dw_main
this.Control[]={this.st_2,&
this.st_1,&
this.cb_retrieve,&
this.cb_cancel,&
this.cb_ok,&
this.dw_main}
end on

on w_hfn_sang_data_1.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_retrieve)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_main)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: open
//	기 능 설 명: 거래처 정보 도움말
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_hfn_com	lstr_com

f_centerme(this)

lstr_com = Message.PowerObjectParm

if not isvalid(lstr_com) then close(this)

ii_acct_class = integer(lstr_com.ls_item[1])
is_acct_code  = lstr_com.ls_item[2]
il_slip_row	  = lstr_com.ll_item[1]

ids_param_migyul = Create DataStore
ids_param_migyul.dataobject = lstr_com.ldw_item[1].dataobject
ids_param_migyul.SetTransObject(sqlca)

if isValid(lstr_com.ldw_item[1]) then
	lstr_com.ldw_item[1].RowsCopy(1, lstr_com.ldw_item[1].RowCount(), Primary!, ids_param_migyul, 1, Primary!)
	ids_param_migyul.setFilter("slip_row = "+string(il_slip_row))
	ids_param_migyul.filter()
end if

this.trigger event ue_db_retrieve()


end event

event key;CHOOSE CASE key
	CASE KeyEnter!
		cb_retrieve.POST EVENT clicked()
	CASE KeyEscape!
		cb_cancel.POST EVENT clicked()
END CHOOSE

end event

event close;DataStore	lds_migyul
string		ls_mana_data, ls_mana_data_tmp
long 			ll_find


lds_migyul = Create DataStore    // 메모리에 할당
lds_migyul.DataObject = dw_main.DataObject
lds_migyul.SetTransObject(sqlca)


if ii_close_type = 1 then
	ls_mana_data_tmp = ''
	
	ll_find = dw_main.find("approve_yn = 'Y'", 0, dw_main.rowcount())

	do while ll_find <> 0
		ls_mana_data = trim(dw_main.getitemstring(ll_find, 'mana_data'))
		
		if len(ls_mana_data_tmp) > 0 and ls_mana_data <> ls_mana_data_tmp then
			exit
		elseif len(ls_mana_data_tmp) = 0 and ls_mana_data <> ls_mana_data_tmp then
			ls_mana_data_tmp = ls_mana_data
		end if
		
		dw_main.RowsCopy(ll_find, ll_find, Primary!, lds_migyul, 1, Primary!)
		ll_find = dw_main.find("approve_yn = 'Y'", ll_find+1, dw_main.rowcount())
	loop
	
	CloseWithReturn(this, lds_migyul)
else
	setNull(lds_migyul)
	CloseWithReturn(this, lds_migyul)
end if

end event

type st_2 from statictext within w_hfn_sang_data_1
integer x = 142
integer y = 116
integer width = 1979
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "※ 관리항목이 서로 다른 것을 같이 선택할 수 없습니다."
boolean focusrectangle = false
end type

type st_1 from statictext within w_hfn_sang_data_1
integer x = 142
integer y = 44
integer width = 1979
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "※ 결재(지급)할 관리항목을 선택하신후 확인버튼을 눌러주세요."
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_hfn_sang_data_1
boolean visible = false
integer x = 1381
integer y = 28
integer width = 306
integer height = 116
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "조회"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: p_retrieve::clicked
//	기 능 설 명: 조회처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
parent.trigger event ue_db_retrieve()

end event

type cb_cancel from commandbutton within w_hfn_sang_data_1
integer x = 3653
integer y = 36
integer width = 439
integer height = 144
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "취소"
end type

event clicked;close(parent)

end event

type cb_ok from commandbutton within w_hfn_sang_data_1
integer x = 3205
integer y = 36
integer width = 439
integer height = 144
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "확인"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: cb_ok::clicked
//	기 능 설 명: 확인
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com
Long			ll_GetRow, ll_row, ll_find
double		ldb_amt
string		ls_mana_data, ls_mana_name, ls_mana_data_tmp
integer		li_mana_code

IF dw_main.RowCount() = 0 THEN
	MessageBox('확인','자료를 조회 후 사용하시기 바랍니다.')
	return
END IF

ll_GetRow = dw_main.getrow()
IF ll_GetRow = 0 THEN
	MessageBox('확인','자료를 선택 후 사용하시기 바랍니다.')
	return
END IF

ll_find = dw_main.find("approve_yn = 'Y'", 0, dw_main.rowcount())
if ll_find = 0 then
	MessageBox('확인','결재(지급)할 자료를 선택 후 사용하시기 바랍니다.')
	return
end if


//ldb_amt = 0
//ls_mana_data_tmp = ''
//
//for ll_row = 1 to dw_main.rowcount()
//	if dw_main.getItemString(ll_row, 'approve_yn') = 'Y' then
//		li_mana_code = dw_main.getitemnumber(ll_row, 'mana_code')
//		ls_mana_data = trim(dw_main.getitemstring(ll_row, 'mana_data'))
//		
//		if len(ls_mana_data_tmp) > 0 and ls_mana_data <> ls_mana_data_tmp then
//			exit
//		elseif len(ls_mana_data_tmp) = 0 and ls_mana_data <> ls_mana_data_tmp then
//			ls_mana_data_tmp = ls_mana_data
//		end if
//		
//		ldb_amt += dw_main.getitemnumber(ll_row, 'slip_amt')
//	end if
//next
//
//lstr_com.ls_item[1] = ls_mana_data
//lstr_com.ls_item[2] = trim(f_mana_data_name_proc(li_mana_code, ls_mana_data))
//lstr_com.ls_item[3] = string(ldb_amt)

ii_close_type = 1

//CloseWithReturn(PARENT,lstr_com)

close(parent)

end event

type dw_main from cuo_dwwindow_one_hin within w_hfn_sang_data_1
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 216
integer width = 4087
integer height = 2012
integer taborder = 20
string dataobject = "d_hfn_sang_data_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE


end event

event itemchanged;call super::itemchanged;string		ls_mana_data
long			ll_find

if dwo.name = 'approve_yn' then
	if data = 'Y' then
		ls_mana_data = this.object.mana_data[row]
		
		ll_find = this.find("mana_data <> '"+ls_mana_data+"' and approve_yn = 'Y'", 1, this.rowcount())
		
		if ll_find > 0 then
			messagebox('알림!', '관리Data가 서로 다른 것을 같이 선택할 수 없습니다.')
			this.object.approve_yn[row] = 'N'
			return 1
		end if
	end if
end if


end event

event retrieveend;call super::retrieveend;long		ll_row, ll_find
string	ls_mana_data, ls_slip_date
integer	li_slip_no, li_slip_seq

if isValid(ids_param_migyul) then
	for ll_row = 1 to ids_param_migyul.rowcount()
		ls_mana_data = ids_param_migyul.object.mana_data[ll_row]
		ls_slip_date = ids_param_migyul.object.slip_date[ll_row]
		li_slip_no 	 = ids_param_migyul.object.slip_no[ll_row]
		li_slip_seq  = ids_param_migyul.object.slip_seq[ll_row]
		
		ll_find = this.find("mana_data = '"+ls_mana_data+"' and slip_date = '"+ls_slip_date+"' "+&
								  "and slip_no = "+string(li_slip_no)+"and slip_seq = "+string(li_slip_seq), 0, rowcount)
		
		do while ll_find <> 0
			this.object.approve_yn[ll_find] = 'Y'
			
			ll_find = this.find("mana_data = '"+ls_mana_data+"' and slip_date = '"+ls_slip_date+"' "+&
								  	  "and slip_no = "+string(li_slip_no)+"and slip_seq = "+string(li_slip_seq), ll_find + 1, rowcount)
		loop
	next
end if


end event

event rowfocuschanged;call super::rowfocuschanged;

If currentrow <= 0 Then Return

 this.object.slip_row[currentrow] =il_slip_row

end event

