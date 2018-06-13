$PBExportHeader$w_btnlist.srw
forward
global type w_btnlist from w_default_response
end type
type st_3 from statictext within w_btnlist
end type
type st_4 from statictext within w_btnlist
end type
type dw_pgmrole from datawindow within w_btnlist
end type
type mle_btn from multilineedit within w_btnlist
end type
type p_2 from picture within w_btnlist
end type
type p_3 from picture within w_btnlist
end type
type r_2 from rectangle within w_btnlist
end type
type r_6 from rectangle within w_btnlist
end type
end forward

global type w_btnlist from w_default_response
integer width = 1975
integer height = 1648
string title = "Role 프로그램 선택"
boolean controlmenu = false
st_3 st_3
st_4 st_4
dw_pgmrole dw_pgmrole
mle_btn mle_btn
p_2 p_2
p_3 p_3
r_2 r_2
r_6 r_6
end type
global w_btnlist w_btnlist

type variables

end variables

on w_btnlist.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_4=create st_4
this.dw_pgmrole=create dw_pgmrole
this.mle_btn=create mle_btn
this.p_2=create p_2
this.p_3=create p_3
this.r_2=create r_2
this.r_6=create r_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.dw_pgmrole
this.Control[iCurrent+4]=this.mle_btn
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.p_3
this.Control[iCurrent+7]=this.r_2
this.Control[iCurrent+8]=this.r_6
end on

on w_btnlist.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_pgmrole)
destroy(this.mle_btn)
destroy(this.p_2)
destroy(this.p_3)
destroy(this.r_2)
destroy(this.r_6)
end on

event ue_postopen;call super::ue_postopen;s_row		lstr_data
lstr_data = Message.PowerObjectParm

dw_pgmrole.SetTransObject(sqlca)
dw_multi.SetTransObject(sqlca)

IF Not IsValid(lstr_data) THEN
	Messagebox("Info", "Role No가 없습니다.~r~n종료하겠습니다.")
	Close(THis)
END IF

dw_pgmrole.retrieve(lstr_data.row[1].data[1], lstr_data.row[1].data[2])

end event

type st_1 from w_default_response`st_1 within w_btnlist
end type

type uc_insert from w_default_response`uc_insert within w_btnlist
boolean visible = false
end type

type uc_cancel from w_default_response`uc_cancel within w_btnlist
boolean visible = false
integer x = 3584
integer taborder = 60
end type

type uc_close from w_default_response`uc_close within w_btnlist
integer x = 1664
integer width = 274
integer height = 84
end type

event uc_close::clicked;call super::clicked;s_row		lstr_data

lstr_data.row[1].data[1]		= 	dw_pgmrole.GetItemString(1, 'use_btn')

CloseWithReturn(Parent, lstr_data)
end event

type uc_delete from w_default_response`uc_delete within w_btnlist
boolean visible = false
integer x = 1166
integer width = 274
integer height = 84
integer taborder = 50
boolean originalsize = true
end type

type uc_excel from w_default_response`uc_excel within w_btnlist
boolean visible = false
end type

type uc_ok from w_default_response`uc_ok within w_btnlist
boolean visible = false
integer x = 3072
integer taborder = 40
end type

type uc_print from w_default_response`uc_print within w_btnlist
boolean visible = false
end type

type uc_run from w_default_response`uc_run within w_btnlist
boolean visible = false
end type

type uc_save from w_default_response`uc_save within w_btnlist
integer x = 1381
integer width = 274
integer height = 84
end type

event uc_save::clicked;call super::clicked;Long		ll_rtn, ll_dcnt, ll_mcnt, i, ll_icnt
DWItemStatus		ldwis_temp

dw_pgmrole.AcceptText()

ll_dcnt  = dw_pgmrole.DeletedCount()
ll_mcnt = dw_pgmrole.ModifiedCount()

ll_rtn = dw_pgmrole.rowcount()

FOR i = ll_rtn To 1 Step -1
	ldwis_temp = dw_pgmrole.getItemStatus(i, 0, Primary!	)
	IF ldwis_temp = NewModified! THEN ll_icnt++
NEXT

IF ll_mcnt = 0 AND ll_dcnt = 0 THEN return

ll_rtn = dw_pgmrole.update()
IF ll_rtn < 0 THEN
	RollBack Using sqlca;
	messagebox("Info", "저장 실패")
ELSE
	Commit Using sqlca;
END IF
end event

type uc_retrieve from w_default_response`uc_retrieve within w_btnlist
boolean visible = false
end type

type dw_multi from w_default_response`dw_multi within w_btnlist
integer y = 820
integer width = 1874
integer height = 708
integer taborder = 20
string dataobject = "d_btn_list"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_multi::itemchanged;call super::itemchanged;String		ls_pgmno, ls_btnid, ls_btn
Long			ll_row
		
IF row > 0 THEN
	IF dwo.name = 'checkbox' THEN
		ls_pgmno 	= This.getItemString(row, 'pgm_no')
		ls_btnid		= This.GetItemstring(row, 'btn_id')
		ll_row 		= dw_pgmrole.Find("pgm_no='" + ls_pgmno + "'", 1, dw_multi.rowcount())
		ls_btn		= dw_pgmrole.GetItemString(ll_row, 'use_btn')
		IF IsNull(ls_btn) THEN ls_btn = ''
		IF Long(data) = 0 THEN
			replaceall(ls_btn, "," + ls_btnid , "")
			replaceall(ls_btn, ls_btnid, "")
			dw_pgmrole.setItem(ll_row, 'use_btn', ls_btn)
			mle_btn.text = ls_btn
		ELSE
			IF Len(ls_btn) > 0 THEN ls_btn += ","
			ls_btn += ls_btnid
			dw_pgmrole.setItem(ll_row, 'use_btn', ls_btn)
			mle_btn.text = ls_btn
		END IF	
	END IF
END IF
end event

event dw_multi::doubleclicked;call super::doubleclicked;String	ls_data, ls_data_origin, ls_ColumnName, ls_syntax
String	ls_tkt_no, ls_conj_no
Long		i, ll_cnt, ll_data

ls_ColumnName = dwo.name
IF ls_columnName = "" OR IsNull(ls_columnName) THEN Return
ls_columnName = Left(ls_columnName, Pos(ls_columnName, '_hfx') - 1)

IF ls_columnName = 'checkbox' THEN
	This.SetRedraw(FALSE)
	ls_data_origin = Trim(Describe(dwo.name + ".text"))
	IF IsNull(ls_data_origin) THEN ls_data_origin = ''
	IF ls_data_origin = '√' THEN
		ls_data = '0'
	ELSE
		ls_data = '1'
	END IF

	ll_cnt = This.RowCount()
	FOR i = 1 TO ll_cnt
		This.SetItem(i, ls_columnName, Long(ls_data))
		This.Trigger Event ItemChanged(i, This.Object.CheckBox, ls_data)
	NEXT
	
	This.SetRedraw(TRUE)

	IF ls_data = '0' THEN
		ls_syntax = ls_columnName + "_hfx.text=''~r~n " + ls_columnName + "_nml.text=''"
		//
	ELSE
		ls_syntax = ls_columnName + "_hfx.text='√'~r~n " + ls_columnName + "_nml.text='√'"
		//
	END IF
	ls_syntax = This.Modify(ls_syntax)
END IF
end event

type ln_templeft from w_default_response`ln_templeft within w_btnlist
end type

type ln_tempright from w_default_response`ln_tempright within w_btnlist
end type

type ln_tempstart from w_default_response`ln_tempstart within w_btnlist
end type

type ln_4 from w_default_response`ln_4 within w_btnlist
end type

type ln_temptop from w_default_response`ln_temptop within w_btnlist
end type

type ln_tempbutton from w_default_response`ln_tempbutton within w_btnlist
end type

type st_3 from statictext within w_btnlist
integer x = 114
integer y = 176
integer width = 626
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "Role 등록 프로그램"
boolean focusrectangle = false
end type

type st_4 from statictext within w_btnlist
integer x = 110
integer y = 756
integer width = 626
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "프로그램 버튼 List"
boolean focusrectangle = false
end type

type dw_pgmrole from datawindow within w_btnlist
integer x = 46
integer y = 240
integer width = 1874
integer height = 472
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pgmrole_main"
boolean border = false
end type

event rowfocuschanged;call super::rowfocuschanged;String	ls_pgmno
Long		ll_row
IF currentrow > 0 THEN
	stringtokenizer		lnv_token
	ls_pgmno = This.GetItemString(currentrow, 'pgm_no')
	IF Not IsNull(ls_pgmno) AND ls_pgmno <> '' THEN 
		dw_multi.retrieve(ls_pgmno)
		
		ls_pgmno	= This.GetItemString(currentrow, 'use_btn')
		IF IsNull(ls_pgmno) THEN ls_pgmno = ''
		mle_btn.Text = ls_pgmno
		
		lnv_token.SetTokenizer(ls_pgmno, ',')
		do while lnv_token.hasmoretokens( )
			ls_pgmno	= lnv_token.nexttoken( )
			ll_row	= dw_multi.rowcount()
			ll_row	= dw_multi.Find("btn_id='" + ls_pgmno + "'", 1, ll_row)
			dw_multi.setItem(ll_row, 'checkbox', 1)
		Loop
	END IF
END IF	
end event

type mle_btn from multilineedit within w_btnlist
integer x = 553
integer y = 572
integer width = 1353
integer height = 132
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 23027551
long backcolor = 32896501
boolean border = false
boolean autovscroll = true
boolean displayonly = true
end type

type p_2 from picture within w_btnlist
integer x = 50
integer y = 176
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_btnlist
integer x = 50
integer y = 756
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type r_2 from rectangle within w_btnlist
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 41
integer y = 236
integer width = 1883
integer height = 480
end type

type r_6 from rectangle within w_btnlist
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 41
integer y = 816
integer width = 1883
integer height = 716
end type

