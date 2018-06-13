$PBExportHeader$w_hsg301a.srw
$PBExportComments$[청운대]학과별MT관리
forward
global type w_hsg301a from w_condition_window
end type
type st_1 from statictext within w_hsg301a
end type
type st_2 from statictext within w_hsg301a
end type
type st_3 from statictext within w_hsg301a
end type
type dw_1 from uo_dddw_dwc within w_hsg301a
end type
type st_4 from statictext within w_hsg301a
end type
type st_5 from statictext within w_hsg301a
end type
type ddlb_1 from uo_ddlb_hakgi within w_hsg301a
end type
type st_6 from statictext within w_hsg301a
end type
type dw_main from uo_dwfree within w_hsg301a
end type
type dw_2 from uo_dwgrid within w_hsg301a
end type
type em_1 from uo_em_year within w_hsg301a
end type
end forward

global type w_hsg301a from w_condition_window
integer width = 4654
st_1 st_1
st_2 st_2
st_3 st_3
dw_1 dw_1
st_4 st_4
st_5 st_5
ddlb_1 ddlb_1
st_6 st_6
dw_main dw_main
dw_2 dw_2
em_1 em_1
end type
global w_hsg301a w_hsg301a

type variables
datawindow idw_dwc

end variables

on w_hsg301a.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_1=create dw_1
this.st_4=create st_4
this.st_5=create st_5
this.ddlb_1=create ddlb_1
this.st_6=create st_6
this.dw_main=create dw_main
this.dw_2=create dw_2
this.em_1=create em_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.dw_main
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.em_1
end on

on w_hsg301a.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.ddlb_1)
destroy(this.st_6)
destroy(this.dw_main)
destroy(this.dw_2)
destroy(this.em_1)
end on

event ue_save;call super::ue_save;int li_ans1 , li_ans2
string ls_title

dw_main.AcceptText( )
li_ans1 = dw_main.update()         //자료의 저장
IF li_ans1 = -1  THEN
	ROLLBACK USING SQLCA;
	messagebox("저장오류","MT 관리의 자료가 저장되지 않았습니다!")            //저장오류 메세지 출력
	return -1
ELSE
	COMMIT USING SQLCA;
END IF

dw_2.AcceptText( )
li_ans2 = dw_2.update()         //자료의 저장
IF li_ans2 = -1  THEN
	ROLLBACK USING SQLCA;
	messagebox("저장오류","지도교수의 자료가 저장되지 않았습니다!")               //저장오류 메세지 출력
	return -1
ELSE
	COMMIT USING SQLCA;
	//저장확인 메세지 출력
END IF
if li_ans1 <> -1 and li_ans2 <> -1 then

uf_messagebox(2)
end if
return 1
end event

event open;call super::open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	FALSE)
//wf_setmenu('DELETE', 	FALSE)
//wf_setmenu('SAVE', 		TRUE)
//wf_setmenu('PRINT', 		FALSE)
//
//
idw_dwc = dw_main

end event

event ue_retrieve;call super::ue_retrieve;string	ls_year, ls_hakgi, ls_hakgwa
long 		ll_row

ls_year	=	em_1.text
ls_hakgi	=	ddlb_1.text
ls_hakgwa	=	dw_1.gettext() + '%'

dw_2.reset()

ll_row = dw_main.retrieve(ls_year, ls_hakgi, ls_hakgwa)

if ll_row = 0 then
	
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)

elseif ll_row = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	

end if
return 1
end event

event closequery;call super::closequery;int li_ans
	
li_ans = f_save_before_close(this, dw_2)

if li_ans = 1 then
//	m_main_menu.m_edit.m_f3.triggerevent(clicked!)
	this.triggerevent("ue_save")							/*	window의 저장 이벤트를 트리거*/
	
elseif li_ans = 3 then
	return -1													// 취소
	
end if
end event

event ue_delete;call super::ue_delete;int li_ans1, li_ans2
string ls_serial

li_ans1 = uf_messagebox(4)      //삭제확인 메세지 출력

if li_ans1 = 1 then
	
	if idw_dwc.classname() = 'dw_main' then
		ls_serial 		= dw_main.object.serial[ dw_main.getrow() ]
		
		if MESSAGEBOX("확인","MT내역을 삭제하시면 해당 지도교수도 삭제됩니다.~r~n~삭제하시겠습나까?", Question!, YesNo!, 2) = 2 then return
	
		//MT내역 삭제에 의한 관련 지도교수 삭제
		DELETE FROM HAKSA.MT_PROF
				WHERE SERIAL = :ls_serial ;
				
		if sqlca.sqlcode = -1 then
			messagebox('user삭제 오류', '지도교수를 삭제할 수 없습니다.' )
			Rollback using sqlca ;
			return
		end if		
	end if
else
	return
end if

idw_dwc.deleterow(0)            //현재 행을 삭제
li_ans2 = idw_dwc.update()      //삭제된 내용을 저장 
if li_ans2 = -1 then        
	uf_messagebox(6)          //삭제오류 메세지 출력
	
	//ROLLBACK USING SQLCA;     
else
   COMMIT USING SQLCA;		  
	
	uf_messagebox(5)          //삭제완료 메시지 출력
end if

idw_dwc.setfocus()
end event

event ue_insert;call super::ue_insert;long ll_newrow
string ls_year, ls_hakgi, ls_serial

if idw_dwc.dataobject = 'd_hsg301a_1' then
	ls_year = em_1.text
	ls_hakgi = ddlb_1.text
	
	if ls_year = '' or isnull(ls_year) or ls_hakgi = '' or isnull(ls_hakgi) then
		messagebox('확인!','년도, 학기를 입력하세요!')
		return
	end if
	
	SELECT	TO_CHAR(TO_NUMBER(MAX(SERIAL)) + 1)
	INTO		:ls_serial
	FROM		HAKSA.MT_MST
	WHERE		YEAR	= :ls_year
	AND		HAKGI	= :ls_hakgi	;
		
	if ls_serial = '' or isnull(ls_serial) then
		ls_serial = ls_year + ls_hakgi + '001'
	
	end if	
elseif idw_dwc.dataobject = 'd_hsg301a_2' then
	if dw_main.getrow() < 1 then
		messagebox('확인!','MT내역을 조회하세요!')
		return
	end if
end if

ll_newrow = idw_dwc.InsertRow(0)     //데이타윈도우의 마지막 행에 추가

if ll_newrow <> -1 then
	idw_dwc.ScrollToRow(ll_newrow)   
	idw_dwc.setcolumn(1)              
	idw_dwc.setfocus()              
end if

if idw_dwc.dataobject = 'd_hsg301a_1' then
	idw_dwc.object.serial[ll_newrow] = ls_serial
	idw_dwc.object.year[ll_newrow] = ls_year
	idw_dwc.object.hakgi[ll_newrow] = ls_hakgi
else
	idw_dwc.object.serial[ll_newrow] = dw_main.object.serial[dw_main.getrow()]
end if
end event

event ue_open;call super::ue_open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	TRUE)
//wf_setmenu('DELETE', 	TRUE)
//wf_setmenu('SAVE', 		TRUE)
//wf_setmenu('PRINT', 		FALSE)
//
idw_dwc = dw_main
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsg301a
long linecolor = 16777215
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsg301a
long linecolor = 16777215
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsg301a
long linecolor = 16777215
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsg301a
long linecolor = 16777215
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsg301a
long linecolor = 16777215
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsg301a
long linecolor = 16777215
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsg301a
end type

type uc_insert from w_condition_window`uc_insert within w_hsg301a
end type

type uc_delete from w_condition_window`uc_delete within w_hsg301a
end type

type uc_save from w_condition_window`uc_save within w_hsg301a
end type

type uc_excel from w_condition_window`uc_excel within w_hsg301a
end type

type uc_print from w_condition_window`uc_print within w_hsg301a
end type

type st_line1 from w_condition_window`st_line1 within w_hsg301a
long textcolor = 16777215
end type

type st_line2 from w_condition_window`st_line2 within w_hsg301a
long textcolor = 16777215
end type

type st_line3 from w_condition_window`st_line3 within w_hsg301a
long textcolor = 16777215
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsg301a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsg301a
long linecolor = 16777215
end type

type gb_1 from w_condition_window`gb_1 within w_hsg301a
boolean underline = true
long textcolor = 16777215
end type

type gb_2 from w_condition_window`gb_2 within w_hsg301a
integer taborder = 90
long textcolor = 16777215
end type

type st_1 from statictext within w_hsg301a
integer x = 146
integer y = 196
integer width = 137
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_hsg301a
integer x = 695
integer y = 196
integer width = 197
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_hsg301a
integer x = 1303
integer y = 196
integer width = 197
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
string text = "학과"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from uo_dddw_dwc within w_hsg301a
integer x = 1495
integer y = 180
integer width = 795
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_list_hakgwa"
end type

type st_4 from statictext within w_hsg301a
integer x = 32
integer y = 312
integer width = 2267
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 32299726
string text = "M   T      관   리"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_hsg301a
integer x = 2322
integer y = 312
integer width = 1527
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 32299726
string text = "지  도  교 수"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from uo_ddlb_hakgi within w_hsg301a
integer x = 882
integer y = 184
integer taborder = 21
boolean bringtotop = true
long textcolor = 0
end type

type st_6 from statictext within w_hsg301a
integer x = 32
integer y = 164
integer width = 4402
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

type dw_main from uo_dwfree within w_hsg301a
integer x = 32
integer y = 392
integer width = 2277
integer height = 1868
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hsg301a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_dw(dw_main)

settransobject(sqlca)
this.insertrow(0)
end event

event clicked;call super::clicked;string ls_temp
idw_dwc = dw_main
if row <= 0 then return

ls_temp = this.GetItemString(row,1)
dw_2.SetTransObject(Sqlca)
dw_2.retrieve(ls_temp)
end event

event getfocus;call super::getfocus;idw_dwc = GetFocus()
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE	'gubun'
		if data = '1' then
			dw_main.object.juya[row] = ''
			dw_main.object.hakyun[row] = ''
		end if
		
END CHOOSE
end event

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 100)
end event

type dw_2 from uo_dwgrid within w_hsg301a
integer x = 2322
integer y = 392
integer width = 1522
integer height = 1864
integer taborder = 70
boolean bringtotop = true
string title = ""
string dataobject = "d_hsg301a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event clicked;call super::clicked;idw_dwc = dw_2
end event

event getfocus;call super::getfocus;idw_dwc = GetFocus()
end event

type em_1 from uo_em_year within w_hsg301a
integer x = 302
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

