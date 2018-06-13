$PBExportHeader$w_hjk201pp.srw
$PBExportComments$[청운대]학사제적처리
forward
global type w_hjk201pp from w_popup
end type
type st_2 from statictext within w_hjk201pp
end type
type st_1 from statictext within w_hjk201pp
end type
type ddlb_1 from uo_ddlb_hakgi within w_hjk201pp
end type
type em_1 from uo_em_year within w_hjk201pp
end type
type dw_1 from uo_input_dwc within w_hjk201pp
end type
end forward

global type w_hjk201pp from w_popup
integer width = 2144
integer height = 1840
string title = "학사 제적처리"
st_2 st_2
st_1 st_1
ddlb_1 ddlb_1
em_1 em_1
dw_1 dw_1
end type
global w_hjk201pp w_hjk201pp

type variables
string 	is_hakbun, is_id, is_gwa, is_hakyun
long 		il_money
datawindow idwc
window iw_win
end variables

on w_hjk201pp.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.em_1=create em_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddlb_1
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.dw_1
end on

on w_hjk201pp.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.em_1)
destroy(this.dw_1)
end on

event ue_inquiry;call super::ue_inquiry;string	ls_year, ls_hakgi
integer 	li_row = 0, li_i

ls_year 	= em_1.text
ls_hakgi	= ddlb_1.text

if ls_year = '' or ls_hakgi = ''then
	messagebox("확인", "년도, 학기를 입력하세요.", Information!)
	em_1.setfocus()
	return -1
end if

li_row = dw_1.retrieve(ls_year, ls_hakgi)

if li_row < 1 then 
	li_row = 0
end if

for  li_i = 1 to li_row
	dw_1.object.jaejuk_yn[li_i] = '1'
next

st_msg.text = string(li_row) + '건 조회되었습니다.'

end event

event ue_save;string	ls_ilja, ls_year, ls_hakgi, ls_hakyun, ls_janghak, ls_result
string	ls_hakbun, ls_gwa, ls_max, ls_jhname, ls_sangtae
integer  li_row
long		ll_row, ll_i

ls_year 	= em_1.text
ls_hakgi	= ddlb_1.text

ll_row = dw_1.rowcount()

if ll_row >= 1 then 
	
	SetPointer(HourGlass!)
		
//실질적인 제적생을 학적변동 테이블에 입력하여준다.
	FOR ll_i = 1 TO ll_row
		
		ls_result = dw_1.object.jaejuk_yn[ll_i]
		
		IF ls_result = '1' THEN
			
			ls_hakbun	= dw_1.object.hakbun[ll_i]
			
			SELECT 	SU_HAKYUN,
						SANGTAE
			INTO		:ls_hakyun,
						:ls_sangtae
			FROM		HAKSA.JAEHAK_HAKJUK 
			WHERE		HAKBUN 	= :ls_hakbun
			USING SQLCA ;
			
			if ls_sangtae <> '01' then
				messagebox('확인', ls_hakbun + "번의 학생은 재학생이 아닙니다.", Exclamation!, OK!)
				return -1
			end if
			
			//학적변동 학사제적 생성한다.
				INSERT INTO HAKSA.HAKJUKBYENDONG  
         			( 		HAKBUN, 		HJMOD_ID,	SAYU_ID, 		HJMOD_SIJUM, 		YEAR, 
								SU_HAKYUN, 	HAKGI,		JUPSU_ILJA, 	SUNGJUK_INJUNG,	DUNGROK_INJUNG, 	
								DUNGROK_HAKJUM, 	DUNGROK_INSANG_YN
						)  
				VALUES 
						( 		:ls_hakbun,	'D', 'D11', to_char(sysdate, 'yyyymmdd'), :ls_year,
								:ls_hakyun, :ls_hakgi, to_char(sysdate, 'yyyymmdd'), 'Y', 'N',
								0, 'N'
						) USING SQLCA ;
						
				if sqlca.sqlcode <> 0 then
					rollback USING SQLCA ;
					messagebox("입력오류","입력하신 학생을 다시 확인 하십시요.")
					return 0
				else
					commit USING SQLCA ;
				end if		
				
		END IF

	NEXT
	
else
	
	messagebox("알림", "조회된 내용이 없습니다.")
	return -1
	
end if
end event

type p_msg from w_popup`p_msg within w_hjk201pp
integer y = 1652
end type

type st_msg from w_popup`st_msg within w_hjk201pp
integer y = 1652
integer width = 1938
end type

type uc_printpreview from w_popup`uc_printpreview within w_hjk201pp
end type

type uc_cancel from w_popup`uc_cancel within w_hjk201pp
end type

type uc_ok from w_popup`uc_ok within w_hjk201pp
end type

type uc_excelroad from w_popup`uc_excelroad within w_hjk201pp
end type

type uc_excel from w_popup`uc_excel within w_hjk201pp
end type

type uc_save from w_popup`uc_save within w_hjk201pp
end type

type uc_delete from w_popup`uc_delete within w_hjk201pp
end type

type uc_insert from w_popup`uc_insert within w_hjk201pp
end type

type uc_retrieve from w_popup`uc_retrieve within w_hjk201pp
end type

type ln_temptop from w_popup`ln_temptop within w_hjk201pp
integer endx = 2130
end type

type ln_1 from w_popup`ln_1 within w_hjk201pp
integer beginy = 1712
integer endx = 2130
integer endy = 1712
end type

type ln_2 from w_popup`ln_2 within w_hjk201pp
integer endy = 1748
end type

type ln_3 from w_popup`ln_3 within w_hjk201pp
integer beginx = 2089
integer endx = 2089
integer endy = 1748
end type

type r_backline1 from w_popup`r_backline1 within w_hjk201pp
end type

type r_backline2 from w_popup`r_backline2 within w_hjk201pp
integer x = 210
end type

type r_backline3 from w_popup`r_backline3 within w_hjk201pp
integer x = 274
end type

type uc_print from w_popup`uc_print within w_hjk201pp
end type

type st_2 from statictext within w_hjk201pp
integer x = 594
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
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_hjk201pp
integer x = 114
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
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from uo_ddlb_hakgi within w_hjk201pp
integer x = 777
integer y = 40
integer taborder = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type em_1 from uo_em_year within w_hjk201pp
integer x = 297
integer y = 40
integer width = 242
integer taborder = 150
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_1 from uo_input_dwc within w_hjk201pp
integer x = 55
integer y = 180
integer width = 2021
integer height = 1444
integer taborder = 50
string dataobject = "d_hjk201pp_1"
end type

