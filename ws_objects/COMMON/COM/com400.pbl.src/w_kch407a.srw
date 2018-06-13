$PBExportHeader$w_kch407a.srw
$PBExportComments$[청운대]개인별소속부서관리
forward
global type w_kch407a from w_condition_window
end type
type uo_1 from cuo_insa_member within w_kch407a
end type
type cb_1 from commandbutton within w_kch407a
end type
type cb_2 from commandbutton within w_kch407a
end type
type st_con from statictext within w_kch407a
end type
type dw_main from uo_dw within w_kch407a
end type
type dw_main2 from uo_dw within w_kch407a
end type
end forward

global type w_kch407a from w_condition_window
uo_1 uo_1
cb_1 cb_1
cb_2 cb_2
st_con st_con
dw_main dw_main
dw_main2 dw_main2
end type
global w_kch407a w_kch407a

on w_kch407a.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_con=create st_con
this.dw_main=create dw_main
this.dw_main2=create dw_main2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_con
this.Control[iCurrent+5]=this.dw_main
this.Control[iCurrent+6]=this.dw_main2
end on

on w_kch407a.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_con)
destroy(this.dw_main)
destroy(this.dw_main2)
end on

event ue_insert;long		ll_newrow
string	ls_member

ls_member	=	uo_1.sle_member_no.text

ll_newrow	= dw_main.InsertRow(0)//	데이타윈도우의 마지막 행에 추가

dw_main.object.member_no[ll_newrow] = ls_member

IF ll_newrow <> -1 THEN
   dw_main.ScrollToRow(ll_newrow)		//	추가된 행에 스크롤
	dw_main.setcolumn(1)              	//	추가된 행의 첫번째 컬럼에 커서 위치
	dw_main.setfocus()                	//	dw_main 포커스 이동
END IF

end event

event ue_retrieve;integer	li_row
string	ls_member

ls_member	=	uo_1.sle_member_no.text

if isnull(ls_member) or trim(ls_member)='' then 
	messagebox('확인','성명을 입력하세요.')
	return -1
end if

li_row = dw_main.retrieve(ls_member + '%')
li_row = dw_main2.retrieve(ls_member + '%')

if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

Return 1
end event

event ue_delete;call super::ue_delete;int li_ans

//삭제확인
if uf_messagebox(4) = 2 then return

dw_main.deleterow(0)
li_ans = dw_main.update()								

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback using sqlca ;
else	
	commit using sqlca ;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

event ue_postopen;call super::ue_postopen;idw_update[1] = dw_main
end event

type ln_templeft from w_condition_window`ln_templeft within w_kch407a
end type

type ln_tempright from w_condition_window`ln_tempright within w_kch407a
end type

type ln_temptop from w_condition_window`ln_temptop within w_kch407a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_kch407a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_kch407a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_kch407a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_kch407a
end type

type uc_insert from w_condition_window`uc_insert within w_kch407a
end type

type uc_delete from w_condition_window`uc_delete within w_kch407a
end type

type uc_save from w_condition_window`uc_save within w_kch407a
end type

type uc_excel from w_condition_window`uc_excel within w_kch407a
end type

type uc_print from w_condition_window`uc_print within w_kch407a
end type

type st_line1 from w_condition_window`st_line1 within w_kch407a
end type

type st_line2 from w_condition_window`st_line2 within w_kch407a
end type

type st_line3 from w_condition_window`st_line3 within w_kch407a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_kch407a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_kch407a
end type

type gb_1 from w_condition_window`gb_1 within w_kch407a
integer x = 0
end type

type gb_2 from w_condition_window`gb_2 within w_kch407a
end type

type uo_1 from cuo_insa_member within w_kch407a
event destroy ( )
integer x = 128
integer y = 184
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call cuo_insa_member::destroy
end on

type cb_1 from commandbutton within w_kch407a
integer x = 1847
integer y = 964
integer width = 329
integer height = 128
integer taborder = 21
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "◀"
end type

event clicked;long ll_newrow
integer ii, lowcount
string ls_member, ls_gwa, ls_check, ls_fname

lowcount = dw_main2.rowcount()

for ii = 1 to lowcount
	ls_check = dw_main2.object.com_1[ii]
	ls_gwa = dw_main2.object.gwa[ii]
	ls_fname = dw_main2.object.fname[ii]
	
	if ls_check = '1' then
		ls_member	=	uo_1.sle_member_no.text
		ll_newrow	= dw_main.InsertRow(0)//	데이타윈도우의 마지막 행에 추가
		dw_main.object.kch407m_member_id[ll_newrow] = ls_member
		dw_main.object.kch407m_gwa[ll_newrow] = ls_gwa
		dw_main.object.kch003m_fname[ll_newrow] = ls_fname
	end if
	
next

int	li_ans

dw_main.AcceptText()

li_ans = dw_main.update()		//	자료의 저장

IF li_ans = -1  THEN
	ROLLBACK USING SQLCA;
	messagebox("저장 실패","저장하지 못했습니다.")       	//	저장오류 메세지 출력

ELSE
	COMMIT USING SQLCA;
	messagebox("저장 완료","저장했습니다.")       //	저장확인 메세지 출력
END IF

parent.triggerevent("ue_retrieve")
end event

type cb_2 from commandbutton within w_kch407a
integer x = 1847
integer y = 740
integer width = 329
integer height = 128
integer taborder = 31
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "▶"
end type

event clicked;int ii, lowcount
string ls_member, ls_gwa, ls_check

lowcount = dw_main.rowcount()

for ii = 1 to lowcount
	ls_check = dw_main.object.check_yn[ii]
	ls_member	=	uo_1.sle_member_no.text
	ls_gwa = dw_main.object.kch407m_gwa[ii]
	
	if ls_check = '1' then
		delete from cddb.KCH407M
		WHERE	MEMBER_ID = :ls_member
		and	gwa = :ls_gwa;		
	end if
next

int	li_ans

COMMIT USING SQLCA;
messagebox("저장 완료","저장했습니다.")       //	저장확인 메세지 출력

parent.triggerevent("ue_retrieve")
end event

type st_con from statictext within w_kch407a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31112622
boolean focusrectangle = false
end type

type dw_main from uo_dw within w_kch407a
integer x = 55
integer y = 300
integer width = 1696
integer height = 1960
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_kch407a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;int ii, lowcount
string ls_aa
lowcount = dw_main.rowcount()


if row = 0 and dwo.name = 'b_1' then
	for ii = 1 to lowcount
		   if dw_main.object.check_yn[ii] = '1' then
				dw_main.object.check_yn[ii] = '0' 
			elseif dw_main.object.check_yn[ii] = '0' then
				dw_main.object.check_yn[ii] = '1'
			end if
	next
	
elseif row > 0 then
		
	if dwo.name <> 'check_yn' then
		if dw_main.object.check_yn[row] = '1' then
				dw_main.object.check_yn[row] = '0' 
		elseif dw_main.object.check_yn[row] = '0' then
				dw_main.object.check_yn[row] = '1'
		end if
	end if
	
end if
end event

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

type dw_main2 from uo_dw within w_kch407a
integer x = 2290
integer y = 300
integer width = 1696
integer height = 1960
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_kch407a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;int ii, lowcount
lowcount = dw_main2.rowcount()

if row = 0 and dwo.name = 'b_1' then
	for ii = 1 to lowcount
		   if dw_main2.object.com_1[ii] = '1' then
				dw_main2.object.com_1[ii] = '0' 
			elseif dw_main2.object.com_1[ii] = '0' then
				dw_main2.object.com_1[ii] = '1'
			end if
	next
	
elseif row > 0 then
	
	if dwo.name <> 'com_1' then
		if dw_main2.object.com_1[row] = '1' then
			dw_main2.object.com_1[row] = '0'
		elseif	dw_main2.object.com_1[row] = '0' then
			dw_main2.object.com_1[row] = '1'
		end if
	end if
end if

end event

event constructor;call super::constructor;this.setPosition(totop!)
end event

