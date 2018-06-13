$PBExportHeader$w_hjk414pp.srw
$PBExportComments$[청운대]재수강과목입력관리
forward
global type w_hjk414pp from w_popup
end type
type sle_search from uo_sle within w_hjk414pp
end type
type st_2 from statictext within w_hjk414pp
end type
type dw_search from uo_dwfree within w_hjk414pp
end type
end forward

global type w_hjk414pp from w_popup
integer width = 2455
integer height = 1664
string title = "재수강과목입력"
boolean clientedge = true
sle_search sle_search
st_2 st_2
dw_search dw_search
end type
global w_hjk414pp w_hjk414pp

on w_hjk414pp.create
int iCurrent
call super::create
this.sle_search=create sle_search
this.st_2=create st_2
this.dw_search=create dw_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_search
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_search
end on

on w_hjk414pp.destroy
call super::destroy
destroy(this.sle_search)
destroy(this.st_2)
destroy(this.dw_search)
end on

event open;call super::open;string 	ls_hakbun
integer	li_count1, li_count2

idw_update[1] = dw_search

//학번,증명발급종류코드를 넘겨받음//////////////////////////////////////////////////////////////////
str_parms str_search
str_search = Message.PowerObjectParm

ls_hakbun 	= str_search.s[1] 		// 학번

SELECT	count( JAEHAK_HAKJUK.HAKBUN )  
INTO		:li_count1
FROM		HAKSA.JAEHAK_HAKJUK  
WHERE		( JAEHAK_HAKJUK.HAKBUN	LIKE :ls_hakbun)
USING SQLCA ;

SELECT	count( JOLUP_HAKJUK.HAKBUN )  
INTO 		:li_count2
FROM 		HAKSA.JOLUP_HAKJUK  
WHERE 	( JOLUP_HAKJUK.HAKBUN	LIKE :ls_hakbun )
USING SQLCA ;

sle_search.text = ls_hakbun
if li_count1 = 1 then	
	dw_search.dataobject	= 'd_hjk414pp_1'
	dw_search.settransobject(sqlca)
elseif li_count2 = 1 then
	dw_search.dataobject	= 'd_hjk414pp_2'
	dw_search.settransobject(sqlca)
end if	

This.Event ue_inquiry()

dw_search.setfocus()

end event

event ue_inquiry;call super::ue_inquiry;string	ls_search
integer 	li_row = 0, li_count1, li_count2

ls_search	= trim(sle_search.text)

if len(ls_search) = 0 then
	messagebox("확인", "학번을 입력하세요!", Information!)
	sle_search.setfocus()
	return -1
end if

SELECT	count( JAEHAK_HAKJUK.HAKBUN )  
INTO		:li_count1
FROM		HAKSA.JAEHAK_HAKJUK  
WHERE		( JAEHAK_HAKJUK.HAKBUN	LIKE :ls_search)
USING SQLCA ;

SELECT	count( JOLUP_HAKJUK.HAKBUN )  
INTO 		:li_count2
FROM 		HAKSA.JOLUP_HAKJUK  
WHERE 	( JOLUP_HAKJUK.HAKBUN	LIKE :ls_search)
USING SQLCA ;

if li_count1 = 1 then	
	dw_search.dataobject	= 'd_hjk414pp_1'
	dw_search.settransobject(sqlca)
elseif li_count2 = 1 then
	dw_search.dataobject	= 'd_hjk414pp_2'
	dw_search.settransobject(sqlca)
end if	

dw_search.retrieve(ls_search+'%')

if li_row < 1 then 
	li_row = 0
end if
st_msg.text = '건 조회되었습니다.'
//st_row.text = string(li_row) + '건 조회되었습니다.'

Return 1
end event

event ue_ok;call super::ue_ok;Close(This)
end event

type p_msg from w_popup`p_msg within w_hjk414pp
end type

type st_msg from w_popup`st_msg within w_hjk414pp
integer width = 2240
end type

type uc_printpreview from w_popup`uc_printpreview within w_hjk414pp
integer y = 60
end type

type uc_cancel from w_popup`uc_cancel within w_hjk414pp
integer y = 60
end type

type uc_ok from w_popup`uc_ok within w_hjk414pp
integer y = 60
end type

type uc_excelroad from w_popup`uc_excelroad within w_hjk414pp
integer y = 60
end type

type uc_excel from w_popup`uc_excel within w_hjk414pp
integer y = 60
end type

type uc_save from w_popup`uc_save within w_hjk414pp
integer y = 60
end type

type uc_delete from w_popup`uc_delete within w_hjk414pp
integer y = 60
end type

type uc_insert from w_popup`uc_insert within w_hjk414pp
integer y = 60
end type

type uc_retrieve from w_popup`uc_retrieve within w_hjk414pp
integer y = 60
end type

type ln_temptop from w_popup`ln_temptop within w_hjk414pp
integer endx = 2432
end type

type ln_1 from w_popup`ln_1 within w_hjk414pp
integer endx = 2432
end type

type ln_2 from w_popup`ln_2 within w_hjk414pp
end type

type ln_3 from w_popup`ln_3 within w_hjk414pp
integer beginx = 2386
integer endx = 2386
end type

type r_backline1 from w_popup`r_backline1 within w_hjk414pp
end type

type r_backline2 from w_popup`r_backline2 within w_hjk414pp
end type

type r_backline3 from w_popup`r_backline3 within w_hjk414pp
end type

type uc_print from w_popup`uc_print within w_hjk414pp
integer y = 60
end type

type sle_search from uo_sle within w_hjk414pp
integer x = 370
integer y = 68
integer width = 443
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

event modified;integer li_row = 0

li_row = dw_search.retrieve(trim(sle_search.text))

if li_row < 1 then 
	li_row = 0
	this.selecttext(1, len(this.text))
	this.setfocus()
end if

st_msg.text = string(li_row) + '건 조회되었습니다.'

end event

type st_2 from statictext within w_hjk414pp
integer x = 201
integer y = 72
integer width = 165
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 16777215
string text = "학번: "
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_search from uo_dwfree within w_hjk414pp
integer x = 55
integer y = 176
integer width = 2309
integer height = 1256
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hjk414pp_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;STRING	ls_gwamok, ls_id, ls_seq
long		ll_seq


CHOOSE CASE DWO.NAME
	CASE 'gwamok'
		ls_gwamok = data

		ls_id 	= left(ls_gwamok, 7)
		ll_seq 	= long(right(ls_gwamok, 1))
	
		this.object.jesu_gwamok_id[row] = ls_id
		this.object.jesu_gwamok_seq[row] = ll_seq
END CHOOSE
		
end event

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

