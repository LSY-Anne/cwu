$PBExportHeader$w_dhwsu203a_2.srw
$PBExportComments$[대학원수업] 성적입력(관리자)
forward
global type w_dhwsu203a_2 from w_condition_window
end type
type dw_1 from uo_input_dwc within w_dhwsu203a_2
end type
type dw_main from uo_input_dwc within w_dhwsu203a_2
end type
type st_5 from statictext within w_dhwsu203a_2
end type
type st_6 from statictext within w_dhwsu203a_2
end type
type dw_con from uo_dwfree within w_dhwsu203a_2
end type
end forward

global type w_dhwsu203a_2 from w_condition_window
dw_1 dw_1
dw_main dw_main
st_5 st_5
st_6 st_6
dw_con dw_con
end type
global w_dhwsu203a_2 w_dhwsu203a_2

type variables
string	is_hakbun
end variables

on w_dhwsu203a_2.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_main=create dw_main
this.st_5=create st_5
this.st_6=create st_6
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.st_6
this.Control[iCurrent+5]=this.dw_con
end on

on w_dhwsu203a_2.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_main)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.dw_con)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_prof, ls_hakgwa, ls_jungong, ls_gwamok
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_prof	     = dw_con.Object.prof_no[1]

ll_ans = dw_1.retrieve(ls_year, ls_hakgi, ls_prof)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
elseif ll_ans > 0 then
	
	dw_1.SetFocus()
	dw_1.SetRow(1)
	ls_hakgwa	=	dw_1.object.gwa_id[1]
	ls_jungong	=	dw_1.object.jungong_id[1] + '%'
	ls_gwamok	=	dw_1.object.gwamok_id[1]

	//전공이 없는사람은 스페이스로 받아서 %처리후 스페이스 삭제
	ls_jungong	=	TRIM(ls_jungong)

	dw_main.retrieve(ls_year, ls_hakgi, ls_hakgwa, ls_jungong, ls_gwamok, ls_prof)
end if

Return 1
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
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwsu203a_2
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwsu203a_2
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwsu203a_2
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwsu203a_2
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwsu203a_2
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwsu203a_2
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwsu203a_2
end type

type uc_insert from w_condition_window`uc_insert within w_dhwsu203a_2
end type

type uc_delete from w_condition_window`uc_delete within w_dhwsu203a_2
end type

type uc_save from w_condition_window`uc_save within w_dhwsu203a_2
end type

type uc_excel from w_condition_window`uc_excel within w_dhwsu203a_2
end type

type uc_print from w_condition_window`uc_print within w_dhwsu203a_2
end type

type st_line1 from w_condition_window`st_line1 within w_dhwsu203a_2
end type

type st_line2 from w_condition_window`st_line2 within w_dhwsu203a_2
end type

type st_line3 from w_condition_window`st_line3 within w_dhwsu203a_2
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwsu203a_2
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwsu203a_2
end type

type gb_1 from w_condition_window`gb_1 within w_dhwsu203a_2
end type

type gb_2 from w_condition_window`gb_2 within w_dhwsu203a_2
end type

type dw_1 from uo_input_dwc within w_dhwsu203a_2
integer x = 50
integer y = 372
integer width = 2779
integer height = 1892
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwsu203q_1"
boolean border = true
end type

event doubleclicked;call super::doubleclicked;int li_mod, li_msg
string ls_year, ls_hakgi, ls_hakgwa, ls_jungong, ls_gwamok, ls_prof

if row <= 0 then return

	ls_year		=	this.object.year[row]
	ls_hakgi		=	this.object.hakgi[row]
	ls_hakgwa	=	this.object.gwa_id[row]
	ls_jungong	=	this.object.jungong_id[row] + '%'
	ls_gwamok	=	this.object.gwamok_id[row]
	ls_prof		=	this.object.member_no[row]
	
	//변경된 자료가 있으면 저장여부 check
	li_mod	=	dw_main.ModifiedCount()
	//전공이 없는사람은 스페이스로 받아서 %처리후 스페이스 삭제
	ls_jungong = TRIM(ls_jungong)
	
	if li_mod > 0 then
		li_msg = messagebox("확인","변경된 자료가 있습니다.~r~n저장하시겠습니까?", Question!, YesNO!, 1)
		
		if li_msg = 1 then
			parent.Triggerevent('ue_save')
		end if
		
	end if
	
	dw_main.retrieve(ls_year, ls_hakgi, ls_hakgwa, ls_jungong, ls_gwamok, ls_prof)

end event

type dw_main from uo_input_dwc within w_dhwsu203a_2
integer x = 2843
integer y = 372
integer width = 1591
integer height = 1892
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dhwsu203a_1"
boolean border = true
end type

event itemchanged;call super::itemchanged;double ld_jumsu1, ld_jumsu2, ld_jumsu3, ld_jumsu4, ld_jumsu_tot, ld_pyengjum, ld_hakjum
string ls_hwansan

This.AcceptText()
IF dwo.name = 'd_sugang_trans_jumsu' THEN
	
	ld_jumsu_tot	=	double(data)
	
	ld_hakjum	=	this.object.d_sugang_trans_hakjum[row]
	
	//해당 점수별 부여가능 점수를 체크한다.
	if ld_jumsu_tot > 100 then
		messagebox("오류","100점을 초과할 수 없습니다.")
		
		setnull(ld_jumsu_tot)
		
		this.object.d_sugang_trans_jumsu[row]		= ld_jumsu_tot
		this.object.d_sugang_trans_hwansan[row]	=	''
		this.object.d_sugang_trans_pyengjum[row]	=	ld_jumsu_tot		
		return 1
	end if

	//평점과 환산점수 부여
	if ld_jumsu_tot <= 100 and ld_jumsu_tot >= 95 then
		ld_pyengjum	= 4.5 * ld_hakjum
		ls_hwansan	= 'A+'
	elseif ld_jumsu_tot < 95 and ld_jumsu_tot >= 90 then
		ld_pyengjum = 4.0 * ld_hakjum
		ls_hwansan	= 'A'
	elseif ld_jumsu_tot < 90 and ld_jumsu_tot >= 85 then
		ld_pyengjum = 3.5 * ld_hakjum
		ls_hwansan	= 'B+'
	elseif ld_jumsu_tot < 85 and ld_jumsu_tot >= 80 then
		ld_pyengjum = 3.0 * ld_hakjum
		ls_hwansan	= 'B'
	elseif ld_jumsu_tot < 80 and ld_jumsu_tot >= 75 then
		ld_pyengjum = 2.5 * ld_hakjum
		ls_hwansan	= 'C+'
	elseif ld_jumsu_tot < 75 and ld_jumsu_tot >= 70 then
		ld_pyengjum = 2.0 * ld_hakjum
		ls_hwansan	= 'C'
	elseif ld_jumsu_tot < 70 and ld_jumsu_tot >= 0 then
		ld_pyengjum = 0.0
		ls_hwansan	= 'F'

	end if
	//넣기.
	this.object.d_sugang_trans_hwansan[row]	=	ls_hwansan
	this.object.d_sugang_trans_pyengjum[row]	=	ld_pyengjum

	this.object.d_sugang_trans_job_uid[row]	=	gs_empcode
	this.object.d_sugang_trans_job_add[row]	=	gs_ip
	
END IF
end event

event itemerror;call super::itemerror;return 2
end event

type st_5 from statictext within w_dhwsu203a_2
integer x = 50
integer y = 300
integer width = 2779
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "담 당 교 과 목"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_dhwsu203a_2
integer x = 2843
integer y = 300
integer width = 1591
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "수 강 생 명 단"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_dhwsu203a_2
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_dhwsu203a_c2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

