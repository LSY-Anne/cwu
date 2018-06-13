$PBExportHeader$w_hsu206a.srw
$PBExportComments$[청운대]수강신청백업자료삭제
forward
global type w_hsu206a from w_no_condition_window
end type
type st_2 from statictext within w_hsu206a
end type
type cb_1 from commandbutton within w_hsu206a
end type
type dw_con from uo_dwfree within w_hsu206a
end type
end forward

global type w_hsu206a from w_no_condition_window
st_2 st_2
cb_1 cb_1
dw_con dw_con
end type
global w_hsu206a w_hsu206a

on w_hsu206a.create
int iCurrent
call super::create
this.st_2=create st_2
this.cb_1=create cb_1
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_con
end on

on w_hsu206a.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.dw_con)
end on

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_hsu206a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hsu206a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hsu206a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hsu206a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hsu206a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hsu206a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hsu206a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hsu206a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hsu206a
end type

type uc_save from w_no_condition_window`uc_save within w_hsu206a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hsu206a
end type

type uc_print from w_no_condition_window`uc_print within w_hsu206a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hsu206a
end type

type st_line2 from w_no_condition_window`st_line2 within w_hsu206a
end type

type st_line3 from w_no_condition_window`st_line3 within w_hsu206a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hsu206a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hsu206a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hsu206a
end type

type st_2 from statictext within w_hsu206a
integer x = 55
integer y = 292
integer width = 4379
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 32500968
string text = "수 강 신 청 백 업 자 료 삭 제"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_hsu206a
integer x = 1842
integer y = 936
integer width = 718
integer height = 292
integer taborder = 10
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;string	ls_year, ls_hakgi
long		ll_cnt

ll_cnt = messagebox("확인", "삭제하시겠읍니까?", Exclamation!, OKCancel!, 2)

if ll_cnt = 2 then
	
	return

end if

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return	

elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
		
end if

DELETE	FROM	HAKSA.SUGANG_HIS
WHERE	YEAR	=	:ls_year
AND	HAKGI	=	:ls_hakgi	
USING SQLCA ;

if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	messagebox("확인","Backup자료가 삭제되었습니다.")
else
	messagebox("확인","삭제중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
end if
end event

type dw_con from uo_dwfree within w_hsu206a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsu206a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

