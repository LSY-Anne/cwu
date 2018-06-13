$PBExportHeader$w_dhwhj401pp.srw
$PBExportComments$[대학원학적] 증명서용 인쇄Popup
forward
global type w_dhwhj401pp from w_popup
end type
type em_3 from editmask within w_dhwhj401pp
end type
type cb_3 from commandbutton within w_dhwhj401pp
end type
type st_6 from statictext within w_dhwhj401pp
end type
type sle_printer from singlelineedit within w_dhwhj401pp
end type
type cb_2 from commandbutton within w_dhwhj401pp
end type
type cb_1 from commandbutton within w_dhwhj401pp
end type
type rb_2 from radiobutton within w_dhwhj401pp
end type
type rb_1 from radiobutton within w_dhwhj401pp
end type
type st_5 from statictext within w_dhwhj401pp
end type
type em_2 from uo_date within w_dhwhj401pp
end type
type em_1 from uo_em_d_year within w_dhwhj401pp
end type
type st_4 from statictext within w_dhwhj401pp
end type
type st_3 from statictext within w_dhwhj401pp
end type
type st_2 from statictext within w_dhwhj401pp
end type
type st_1 from statictext within w_dhwhj401pp
end type
type gb_1 from groupbox within w_dhwhj401pp
end type
type gb_2 from groupbox within w_dhwhj401pp
end type
type gb_3 from groupbox within w_dhwhj401pp
end type
end forward

global type w_dhwhj401pp from w_popup
integer width = 1993
integer height = 1084
string title = "증명서용 인쇄(POPUP)"
em_3 em_3
cb_3 cb_3
st_6 st_6
sle_printer sle_printer
cb_2 cb_2
cb_1 cb_1
rb_2 rb_2
rb_1 rb_1
st_5 st_5
em_2 em_2
em_1 em_1
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_dhwhj401pp w_dhwhj401pp

type variables
datawindow idw_dw
string is_hakbun, is_hakgwa, is_hakgicha, is_jung_id, is_prt_gubun
end variables

on w_dhwhj401pp.create
int iCurrent
call super::create
this.em_3=create em_3
this.cb_3=create cb_3
this.st_6=create st_6
this.sle_printer=create sle_printer
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_5=create st_5
this.em_2=create em_2
this.em_1=create em_1
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_3
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.sle_printer
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.em_2
this.Control[iCurrent+11]=this.em_1
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.gb_3
end on

on w_dhwhj401pp.destroy
call super::destroy
destroy(this.em_3)
destroy(this.cb_3)
destroy(this.st_6)
destroy(this.sle_printer)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_5)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;str_parms l_str_parms

l_str_parms = Message.PowerObjectParm

is_hakbun	=  l_str_parms.s[1]
is_jung_id	=	l_str_parms.s[2]
is_prt_gubun=	l_str_parms.s[3]
idw_dw		=	l_str_parms.dw[1]

em_3.text = '1'

If is_prt_gubun = '1' Then
	rb_1.Checked = True
Else
	rb_2.Checked = True
End If

sle_printer.text = idw_dw.Describe('datawindow.printer')




end event

type p_msg from w_popup`p_msg within w_dhwhj401pp
integer y = 900
end type

type st_msg from w_popup`st_msg within w_dhwhj401pp
integer y = 896
integer width = 1701
end type

type uc_printpreview from w_popup`uc_printpreview within w_dhwhj401pp
end type

type uc_cancel from w_popup`uc_cancel within w_dhwhj401pp
end type

type uc_ok from w_popup`uc_ok within w_dhwhj401pp
end type

type uc_excelroad from w_popup`uc_excelroad within w_dhwhj401pp
end type

type uc_excel from w_popup`uc_excel within w_dhwhj401pp
end type

type uc_save from w_popup`uc_save within w_dhwhj401pp
end type

type uc_delete from w_popup`uc_delete within w_dhwhj401pp
end type

type uc_insert from w_popup`uc_insert within w_dhwhj401pp
end type

type uc_retrieve from w_popup`uc_retrieve within w_dhwhj401pp
end type

type ln_temptop from w_popup`ln_temptop within w_dhwhj401pp
integer endx = 1984
end type

type ln_1 from w_popup`ln_1 within w_dhwhj401pp
integer beginy = 956
integer endx = 1984
integer endy = 956
end type

type ln_2 from w_popup`ln_2 within w_dhwhj401pp
integer endy = 1000
end type

type ln_3 from w_popup`ln_3 within w_dhwhj401pp
integer beginx = 1938
integer endx = 1938
integer endy = 1000
end type

type r_backline1 from w_popup`r_backline1 within w_dhwhj401pp
end type

type r_backline2 from w_popup`r_backline2 within w_dhwhj401pp
end type

type r_backline3 from w_popup`r_backline3 within w_dhwhj401pp
end type

type uc_print from w_popup`uc_print within w_dhwhj401pp
end type

type em_3 from editmask within w_dhwhj401pp
integer x = 503
integer y = 644
integer width = 197
integer height = 84
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
string minmax = "1~~99"
end type

type cb_3 from commandbutton within w_dhwhj401pp
integer x = 1422
integer y = 264
integer width = 347
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "등록정보"
end type

event clicked;PrintSetup()

sle_printer.text = idw_dw.Describe('datawindow.printer')

end event

type st_6 from statictext within w_dhwhj401pp
integer x = 206
integer y = 280
integer width = 146
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "이름"
boolean focusrectangle = false
end type

type sle_printer from singlelineedit within w_dhwhj401pp
integer x = 357
integer y = 264
integer width = 1038
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_dhwhj401pp
integer x = 1463
integer y = 640
integer width = 320
integer height = 124
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "종료"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_dhwhj401pp
integer x = 1463
integer y = 500
integer width = 320
integer height = 124
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "확인"
end type

event clicked;string	ls_yongdo, ls_year, ls_ilja
long		ll_cnt, i
long		ll_max_bunho, ll_bunho , ll_money
integer	li_ans

ls_year	=	em_1.text
ls_ilja		=	string(date(em_2.text), 'yyyymmdd')
ll_cnt		=	long(string(em_3.text))


//확인용이면 매수만큼 인쇄만 한다.
if rb_2.checked = true then
	
	for i = 1 to ll_cnt
		
		idw_dw.Print()
		parent.idw_dw.object.t_bunho.text = '확인용'
				
	next
	
	CLOSE(PARENT)
	return
	
end if

//증명서별 금액을 가져온다.
SELECT	B_MONEY
INTO	:ll_money
FROM	HAKSA.D_JUNGMYUNG_CODE
WHERE	JUNGMYUNG_ID	=	:is_jung_id
USING SQLCA;

//일반용이면 DB에 저장하고 인쇄한다.
SELECT	MAX(to_number(BUNHO))
INTO	:ll_max_bunho
FROM	HAKSA.D_BALGUP_DAEJANG
WHERE	YEAR	=	:ls_year
USING SQLCA;

if isnull(ll_max_bunho) then ll_max_bunho = 0

for i = 1 to ll_cnt
	
	ll_bunho = ll_max_bunho + i
	
	//증명서 호수 입력
	parent.idw_dw.object.t_bunho.text = ls_year + '-' + string(ll_bunho)
	
	//발급대장에 발급내역Insert
	INSERT INTO HAKSA.D_BALGUP_DAEJANG
				(	YEAR,				BUNHO,		JUNGMYUNG_ID,		HAKBUN,		
					B_ILJA,			B_MONEY		)
		VALUES(	:ls_year,		:ll_bunho,	:is_jung_id,		:is_hakbun,
					:ls_ilja,	:ll_money	)	USING SQLCA;
					
	if sqlca.sqlcode <> 0 then
		messagebox("오류","발급내역 작성중 오류가 발생되었습니다.")
		rollback USING SQLCA;
		return
		
	else
		//프린트
		idw_dw.Print()
		
	end if
	
next

////인쇄된 증명서에 이상이 있으면 발급내역을 작성하지 않는다.
//li_ans = messagebox("확인","인쇄된 증명서에 이상이 없습니까?~r~n" + &
//							"NO를 클릭하시면 발급대장이 작성되지 않습니다.",Question!, YesNo!, 1)
							
commit USING SQLCA;

CLOSE(PARENT)
end event

type rb_2 from radiobutton within w_dhwhj401pp
integer x = 855
integer y = 764
integer width = 288
integer height = 64
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "확인용"
end type

type rb_1 from radiobutton within w_dhwhj401pp
integer x = 507
integer y = 764
integer width = 288
integer height = 64
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "발급용"
boolean checked = true
end type

type st_5 from statictext within w_dhwhj401pp
integer x = 713
integer y = 664
integer width = 82
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "매"
boolean focusrectangle = false
end type

type em_2 from uo_date within w_dhwhj401pp
integer x = 503
integer y = 536
integer taborder = 60
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type em_1 from uo_em_d_year within w_dhwhj401pp
integer x = 503
integer y = 428
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
end type

event constructor;//
this.text = string(f_sysdate(), 'yyyy')
end event

type st_4 from statictext within w_dhwhj401pp
integer x = 206
integer y = 660
integer width = 274
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "발급매수"
boolean focusrectangle = false
end type

type st_3 from statictext within w_dhwhj401pp
integer x = 206
integer y = 772
integer width = 274
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "발급용도"
boolean focusrectangle = false
end type

type st_2 from statictext within w_dhwhj401pp
integer x = 206
integer y = 444
integer width = 274
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "발급년도"
boolean focusrectangle = false
end type

type st_1 from statictext within w_dhwhj401pp
integer x = 206
integer y = 556
integer width = 274
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "발급일자"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_dhwhj401pp
integer x = 87
integer y = 380
integer width = 1275
integer height = 488
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 16777215
end type

type gb_2 from groupbox within w_dhwhj401pp
integer x = 87
integer y = 188
integer width = 1746
integer height = 192
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "프린터"
end type

type gb_3 from groupbox within w_dhwhj401pp
integer x = 1394
integer y = 380
integer width = 439
integer height = 488
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 16777215
end type

