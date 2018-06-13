$PBExportHeader$w_dip202a.srw
$PBExportComments$[대학원입시] 세부사항입력
forward
global type w_dip202a from w_condition_window
end type
type dw_1 from uo_input_dwc within w_dip202a
end type
type st_4 from statictext within w_dip202a
end type
type st_5 from statictext within w_dip202a
end type
type dw_con from uo_dwfree within w_dip202a
end type
type dw_main from uo_dwfree within w_dip202a
end type
end forward

global type w_dip202a from w_condition_window
dw_1 dw_1
st_4 st_4
st_5 st_5
dw_con dw_con
dw_main dw_main
end type
global w_dip202a w_dip202a

type variables
datawindowchild ldwc_hjmod

end variables

forward prototypes
public subroutine wf_con_protect ()
end prototypes

public subroutine wf_con_protect ();// 계열, 학과, 전공 사용유무를 체크하여 protect한다.
// ls_chk1 : 계열, ls_chk2 : 학과, ls_chk3 : 전공
// Y: 사용, N: 미사용

String ls_chk1, ls_chk2, ls_chk3
Int      li_chk1, li_chk2, li_chk3

SELECT ETC_CD1, ETC_CD2, ETC_CD3
   INTO :ls_chk1, :ls_chk2, :ls_chk3
  FROM CDDB.KCH102D
 WHERE CODE_GB = 'DHW01'
 USING SQLCA ;
 
If  ls_chk1 = 'Y' Then
	li_chk1 = 0
Else
	li_chk1 = 1
End If

If  ls_chk2 = 'Y' Then
	li_chk2 = 0
Else
	li_chk2 = 1
End If

If  ls_chk3 = 'Y' Then
	li_chk3 = 0
Else
	li_chk3 = 1
End If
 
//dw_con.Object.gyeyul_id.Protect = li_chk1
//dw_con.Object.gwa.Protect        = li_chk2
//dw_con.Object.jungong.Protect   = li_chk3

dw_main.Object.gyeyul_id.Protect    = li_chk1
dw_main.Object.gwa_id.Protect       = li_chk2
dw_main.Object.jungong_id.Protect  = li_chk3
end subroutine

on w_dip202a.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_4=create st_4
this.st_5=create st_5
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.dw_con
this.Control[iCurrent+5]=this.dw_main
end on

on w_dip202a.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_mojip, ls_jongbyul, ls_suhum
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_mojip  	=	dw_con.Object.mojip_id[1]
ls_jongbyul 	=	func.of_nvl(dw_con.Object.jongbyul_id[1], '%') + '%'

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
end if

if ls_mojip = ''  or Isnull(ls_mojip) then
	messagebox("확인","모집구분을 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("mojip_id")
	return -1
end if


ll_ans = dw_1.retrieve(ls_year, ls_hakgi, ls_mojip, ls_jongbyul)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
else
	
	ls_suhum	=	dw_1.object.suhum_no[1]
	dw_main.retrieve(ls_year, ls_hakgi, ls_suhum)
end if

Return 1
end event

event open;call super::open;string	ls_hakgi, ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	NEXT_YEAR,      NEXT_HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi

end event

event ue_save;int	li_ans

dw_main.AcceptText()

//저장
li_ans = dw_main.update()
					
if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback USING SQLCA ;
else	
	commit USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if

Return 1
end event

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dip202a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dip202a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dip202a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dip202a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dip202a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dip202a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dip202a
end type

type uc_insert from w_condition_window`uc_insert within w_dip202a
end type

type uc_delete from w_condition_window`uc_delete within w_dip202a
end type

type uc_save from w_condition_window`uc_save within w_dip202a
end type

type uc_excel from w_condition_window`uc_excel within w_dip202a
end type

type uc_print from w_condition_window`uc_print within w_dip202a
end type

type st_line1 from w_condition_window`st_line1 within w_dip202a
end type

type st_line2 from w_condition_window`st_line2 within w_dip202a
end type

type st_line3 from w_condition_window`st_line3 within w_dip202a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dip202a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dip202a
end type

type gb_1 from w_condition_window`gb_1 within w_dip202a
end type

type gb_2 from w_condition_window`gb_2 within w_dip202a
end type

type dw_1 from uo_input_dwc within w_dip202a
integer x = 50
integer y = 376
integer width = 695
integer height = 1888
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dip202a_1"
boolean border = true
boolean usegrid = true
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_suhum
long		ll_row, ll_mod

If row < 1 Then Return ;

//수험생을 조회전에 변경된 자료가 있으면 저장한다.
dw_main.AcceptText()
ll_mod	=	dw_main.ModifiedCount()

if ll_mod > 0 then
	if messagebox("확인","변경된 자료가 존재합니다.~r~n저장하시겠습니까?", Question!, YesNo!, 1) = 1 then
		parent.TriggerEvent('ue_save')
	end if
	
end if

ls_year	=	this.object.year[row]
ls_hakgi	=	this.object.hakgi[row]
ls_suhum	=	this.object.suhum_no[row]

ll_row	=	dw_main.retrieve(ls_year, ls_hakgi, ls_suhum)

if ll_row > 0 then
	dw_main.SetColumn('cname')
	dw_main.setfocus()
end if
end event

type st_4 from statictext within w_dip202a
integer x = 50
integer y = 296
integer width = 695
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "지원자명단"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_dip202a
integer x = 768
integer y = 296
integer width = 3666
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "세 부 내 역"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_dip202a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_dip202a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_dip202a
integer x = 768
integer y = 376
integer width = 3666
integer height = 1888
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dip202a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemerror;call super::itemerror;return 2
end event

event itemchanged;call super::itemchanged;string	ls_juso, ls_temp, ls_sex
boolean	lb_jumin
long		ll_age

CHOOSE CASE DWO.NAME
	CASE	'jumin_no'
		lb_jumin	=	f_chk_jumin_no(data)
				
		if lb_jumin = false then
			if messagebox("오류","잘못된 주민번호가 입력되었습니다.~r~n계속 진행하시겠습니까", Question!, YesNo!, 2) = 2 then
				this.object.jumin_no[row] = ''
				return 1
				
			end if
		end if
		
		//성별
		ls_temp	=	mid(data, 6, 1)
		
		if ls_temp = '1' or ls_temp = '3' then
			ls_sex = '1'
		else 
			ls_sex = '2'
		end if
		
		this.object.sex[row]	=	ls_sex
		
		//나이
		ls_temp = '19' + left(data, 2)
		ll_age	=	long(string(f_sysdate(), 'yyyy')) - long(ls_temp) + 1
		this.object.age[row]	=	ll_age	
		
	CASE	'zip_id'
		SELECT	ZIP_NAME1||' '||ZIP_NAME2||' '||ZIP_NAME3
		INTO	:ls_juso
		FROM	HAKSA.ZIPCODES
		WHERE	ZIP_ID	=	:data	
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			messagebox("오류","존재하지 않는 우편번호입니다.")
			this.object.zip_id[row]	=	''
			return 1
			
		elseif sqlca.sqlcode = 0 then
			this.object.juso[row]	=	ls_juso
			
		end if
		
	CASE	'e_zip_id'
		SELECT	ZIP_NAME1||' '||ZIP_NAME2||' '||ZIP_NAME3
		INTO	:ls_juso
		FROM	HAKSA.ZIPCODES
		WHERE	ZIP_ID	=	:data	
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			messagebox("오류","존재하지 않는 우편번호입니다.")
			this.object.e_zip_id[row]	=	''
			return 1
			
		elseif sqlca.sqlcode = 0 then
			this.object.e_juso[row]	=	ls_juso
		end if

		
	CASE	'bo_zip_id'
		SELECT	ZIP_NAME1||' '||ZIP_NAME2||' '||ZIP_NAME3
		INTO	:ls_juso
		FROM	HAKSA.ZIPCODES
		WHERE	ZIP_ID	=	:data	
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			messagebox("오류","존재하지 않는 우편번호입니다.")
			this.object.bo_zip_id[row]	=	''
			return 1
			
		elseif sqlca.sqlcode = 0 then
			this.object.bo_juso[row]	=	ls_juso
		end if
		
END CHOOSE


end event

event buttonclicked;call super::buttonclicked;//주소 검색하기...
string ls_tot, ls_zip, ls_juso
long ll_len

CHOOSE CASE	DWO.NAME
	CASE 'b_1'
		open(w_zipcode)
		ls_tot	= message.Stringparm
		ll_len	= len(ls_tot)
		ls_zip	= mid(ls_tot, 1, 6)
		ls_juso	= mid(ls_tot, 7, ll_len)
		
		this.object.zip_id[row] = ls_zip
		this.object.juso[row]	= ls_juso
		this.SetColumn("juso")
		
	CASE 'b_2'
		open(w_zipcode)
		ls_tot	= message.Stringparm
		ll_len	= len(ls_tot)
		ls_zip	= mid(ls_tot, 1, 6)
		ls_juso	= mid(ls_tot, 7, ll_len)
		
		this.object.e_zip_id[row]	= ls_zip
		this.object.e_juso[row]		= ls_juso
		this.SetColumn("bo_juso")
		
	CASE	'b_3'
		open(w_zipcode)
		ls_tot	= message.Stringparm
		ll_len	= len(ls_tot)
		ls_zip	= mid(ls_tot, 1, 6)
		ls_juso	= mid(ls_tot, 7, ll_len)
		
		this.object.bo_zip_id[row] = ls_zip
		this.object.bo_juso[row]	= ls_juso
		this.SetColumn("bo_juso")
		
end choose

//Keyboard입력을 동적으로 사용(글로벌함수)
//SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"
//Keybd_event( 35, 1, 0, 0 ) //End Key를 친것과 같음..커서를 주소 맨 마지막에 보낼려고

end event

event constructor;call super::constructor;This.SetTransObject(sqlca)

func.of_design_dw(dw_main)

end event

