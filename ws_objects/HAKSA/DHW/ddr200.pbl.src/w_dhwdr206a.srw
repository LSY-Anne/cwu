$PBExportHeader$w_dhwdr206a.srw
$PBExportComments$[대학원등록] 분납처리
forward
global type w_dhwdr206a from w_condition_window
end type
type dw_con from uo_dwfree within w_dhwdr206a
end type
type uo_1 from uo_imgbtn within w_dhwdr206a
end type
type dw_main from uo_dwfree within w_dhwdr206a
end type
end forward

global type w_dhwdr206a from w_condition_window
dw_con dw_con
uo_1 uo_1
dw_main dw_main
end type
global w_dhwdr206a w_dhwdr206a

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
 
dw_con.Object.gyeyul_id.Protect = li_chk1
dw_con.Object.gwa.Protect        = li_chk2
dw_con.Object.jungong.Protect   = li_chk3

end subroutine

on w_dhwdr206a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.uo_1=create uo_1
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_main
end on

on w_dhwdr206a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_jungong, ls_hakbun, ls_gyeyul_id
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwajung  =	func.of_nvl(dw_con.Object.gwajung[1], '%')
ls_gyeyul_id =  func.of_nvl(dw_con.Object.gyeyul_id[1], '%')
ls_hakgwa   =	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_jungong   =	func.of_nvl(dw_con.Object.jungong[1], '%')
ls_hakbun    =  func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwajung, ls_gyeyul_id, ls_hakgwa, ls_jungong, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1

end event

event open;call super::open;string	ls_hakgi, ls_year
DataWindowChild ldwc_hjmod

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

dw_con.getchild('jungong', ldwc_hjmod)
ldwc_hjmod.SetTransObject(sqlca)	
ldwc_hjmod.Retrieve('%')

end event

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwdr206a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwdr206a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwdr206a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwdr206a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwdr206a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwdr206a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwdr206a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwdr206a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwdr206a
end type

type uc_save from w_condition_window`uc_save within w_dhwdr206a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwdr206a
end type

type uc_print from w_condition_window`uc_print within w_dhwdr206a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwdr206a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwdr206a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwdr206a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwdr206a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwdr206a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwdr206a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwdr206a
end type

type dw_con from uo_dwfree within w_dhwdr206a
integer x = 55
integer y = 168
integer width = 4379
integer height = 204
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_dhwdr206a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gwa'
		DataWindowChild ldwc_hjmod

		This.getchild('jungong', ldwc_hjmod)
		ldwc_hjmod.SetTransObject(sqlca)	
		ldwc_hjmod.Retrieve(data)
		
End Choose
end event

type uo_1 from uo_imgbtn within w_dhwdr206a
integer x = 475
integer y = 40
integer width = 366
integer taborder = 20
boolean bringtotop = true
string btnname = "분납처리"
end type

event clicked;call super::clicked;str_parms s_parms
string ls_hakbun, ls_name, ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_jungong
long	ll_ans

if dw_main.getrow() <= 0 then return

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun	=	dw_main.object.hakbun[dw_main.getrow()]
ls_name		=	dw_main.object.hname[dw_main.getrow()]
ls_gwajung  =	func.of_nvl(dw_con.Object.gwajung[1], '%')
ls_hakgwa   =	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_jungong   =	func.of_nvl(dw_con.Object.jungong[1], '%')

s_parms.s[1]	=	ls_hakbun
s_parms.s[2]	=	ls_year
s_parms.s[3]	=	ls_hakgi
s_parms.s[4]	=	ls_name

OpenWithParm(w_dhwdr206pp, s_parms)

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_jungong, ls_hakbun)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_dhwdr206a
integer x = 50
integer y = 384
integer width = 4384
integer height = 1880
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dhwdr206a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

