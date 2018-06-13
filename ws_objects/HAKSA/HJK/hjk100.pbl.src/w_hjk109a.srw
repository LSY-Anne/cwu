$PBExportHeader$w_hjk109a.srw
$PBExportComments$[청운대]학적기본사항관리_성적조회
forward
global type w_hjk109a from w_condition_window
end type
type st_1 from statictext within w_hjk109a
end type
type st_4 from statictext within w_hjk109a
end type
type dw_6 from uo_input_dwc within w_hjk109a
end type
type dw_con from uo_dwfree within w_hjk109a
end type
type dw_4 from uo_dwfree within w_hjk109a
end type
end forward

global type w_hjk109a from w_condition_window
integer width = 4521
integer height = 2648
st_1 st_1
st_4 st_4
dw_6 dw_6
dw_con dw_con
dw_4 dw_4
end type
global w_hjk109a w_hjk109a

type variables
long 		il_row, il_seq_no
string 	is_year, is_hakgi, is_gwa,	is_jungong_id, is_hakyun, is_ban, is_juya
string	is_gwamok2, is_member_no,  is_hosil, is_yoil, is_sigan, is_ban_bunhap
string	is_chk, is_gwamok
string	is_hakbun
end variables

on w_hjk109a.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_4=create st_4
this.dw_6=create dw_6
this.dw_con=create dw_con
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.dw_6
this.Control[iCurrent+4]=this.dw_con
this.Control[iCurrent+5]=this.dw_4
end on

on w_hjk109a.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_4)
destroy(this.dw_6)
destroy(this.dw_con)
destroy(this.dw_4)
end on

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.insertrow(0)

end event

event ue_retrieve;call super::ue_retrieve;string	ls_hakbun, ls_gwa, ls_su_hakyun, ls_name, ls_hname, ls_member_gwa
long		li_ans, li_count, li_count1

dw_con.AcceptText()

ls_name		= dw_con.Object.hname[1]
ls_hakbun	= dw_con.Object.hakbun[1]

dw_4.reset()
dw_6.reset()
if	(ls_hakbun = "" or isnull(ls_hakbun)) and (ls_name = "" or isnull(ls_name)) then
	messagebox("확인","학번이나 성명을 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return	 -1
end if

//학적조회
select	a.gwa,
			a.hname
into		:ls_gwa,
			:ls_hname
from		haksa.jaehak_hakjuk a
where		a.HAKBUN	LIKE :ls_hakbun||'%'		
AND		a.HNAME	LIKE :ls_name||'%'	
USING SQLCA
;
	

SELECT	count( JAEHAK_HAKJUK.HAKBUN )  
INTO		:li_count
FROM		HAKSA.JAEHAK_HAKJUK  
WHERE		( JAEHAK_HAKJUK.HAKBUN	LIKE :ls_hakbun||'%'	)	AND
			( JAEHAK_HAKJUK.HNAME	LIKE :ls_name||'%'	)
USING SQLCA
;

if li_count = 0 then
	messagebox("확인", "해당 학생은 존재하지 않습니다.!", Exclamation!)
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return -1

elseif li_count = 1 then
	
		SELECT	JAEHAK_HAKJUK.HAKBUN,
					JAEHAK_HAKJUK.HNAME
		INTO		:is_hakbun,
					:ls_hname
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE		( JAEHAK_HAKJUK.HNAME	like :ls_name||'%'	)
		and		( JAEHAK_HAKJUK.HAKBUN	like :ls_hakbun||'%'	)
		USING SQLCA
		;

	IF mid(ls_gwa, 1, 3) = mid(gs_deptcode, 1, 3) THEN
		dw_con.Object.hname[1] = ls_hname
		li_ans	=	dw_4.retrieve(is_hakbun)			
	ELSE
		MESSAGEBOX('확인', '타과학생은 조회가 불가능합니다.')
		return -1
	END IF
	
elseif li_count >=2 then
	
	OpenWithParm(w_hjk109pp, ls_name)
	
	is_hakbun	= Message.StringParm
	
	IF mid(ls_gwa, 1, 3) = mid(gs_deptcode, 1, 3) THEN
		dw_con.Object.hname[1] = ls_hname
		li_ans	=	dw_4.retrieve(is_hakbun)			
	ELSE
		MESSAGEBOX('확인', '타과학생은 조회가 불가능합니다.')
		return -1
	END IF

end if

if li_ans = 0 then 
	dw_4.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return -1
else
	dw_4.setfocus()
end if
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk109a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk109a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk109a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk109a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk109a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk109a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk109a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk109a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk109a
end type

type uc_save from w_condition_window`uc_save within w_hjk109a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk109a
end type

type uc_print from w_condition_window`uc_print within w_hjk109a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk109a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk109a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk109a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk109a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk109a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk109a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hjk109a
integer taborder = 50
end type

type st_1 from statictext within w_hjk109a
integer x = 55
integer y = 296
integer width = 4375
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 15793151
long backcolor = 8388736
string text = "성   적   내   역"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_hjk109a
integer x = 55
integer y = 1124
integer width = 4375
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 15793151
long backcolor = 8388736
string text = "학    기    별    성    적    내    역"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_6 from uo_input_dwc within w_hjk109a
integer x = 55
integer y = 1208
integer width = 4375
integer height = 1056
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hjk101q_7"
boolean border = true
end type

type dw_con from uo_dwfree within w_hjk109a
integer x = 55
integer y = 168
integer width = 4375
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk109a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_4 from uo_dwfree within w_hjk109a
integer x = 55
integer y = 380
integer width = 4375
integer height = 736
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hjk101q_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;integer 	li_row
string	ls_hakbun, ls_year, ls_hakgi

If row < 1 Then Return -1;

if row > 0 then
	
	ls_hakbun 	= dw_4.object.hakbun[row]
	ls_year 		= dw_4.object.year[row]
	ls_hakgi		= dw_4.object.hakgi[row]
	
end if

li_row = dw_6.retrieve( ls_hakbun, ls_year, ls_hakgi)
	
if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_6.setfocus()	
end event

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

