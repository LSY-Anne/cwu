$PBExportHeader$w_dhwju209q.srw
$PBExportComments$[대학원졸업] 학위수여자 명단
forward
global type w_dhwju209q from w_condition_window
end type
type dw_main from uo_search_dwc within w_dhwju209q
end type
type dw_con from uo_dwfree within w_dhwju209q
end type
end forward

global type w_dhwju209q from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_dhwju209q w_dhwju209q

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
//dw_con.Object.jungong.Protect   = li_chk3

//dw_main.Object.d_hakjuk_gyeyul_id.Protect    = li_chk1
//dw_main.Object.d_hakjuk_gwa_id.Protect       = li_chk2
//dw_main.Object.d_hakjuk_jungong_id.Protect  = li_chk3
end subroutine

on w_dhwju209q.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_dhwju209q.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_gyeyul_id
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwajung  =	func.of_nvl(dw_con.Object.gwajung[1], '%') + '%'
ls_gyeyul_id =  func.of_nvl(dw_con.Object.gyeyul_id[1], '%') + '%'
ls_hakgwa   =	func.of_nvl(dw_con.Object.gwa[1], '%') + '%'

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwajung, ls_gyeyul_id, ls_hakgwa)

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

idw_print = dw_main

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

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwju209q
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwju209q
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwju209q
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwju209q
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwju209q
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwju209q
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwju209q
end type

type uc_insert from w_condition_window`uc_insert within w_dhwju209q
end type

type uc_delete from w_condition_window`uc_delete within w_dhwju209q
end type

type uc_save from w_condition_window`uc_save within w_dhwju209q
end type

type uc_excel from w_condition_window`uc_excel within w_dhwju209q
end type

type uc_print from w_condition_window`uc_print within w_dhwju209q
end type

type st_line1 from w_condition_window`st_line1 within w_dhwju209q
end type

type st_line2 from w_condition_window`st_line2 within w_dhwju209q
end type

type st_line3 from w_condition_window`st_line3 within w_dhwju209q
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwju209q
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwju209q
end type

type gb_1 from w_condition_window`gb_1 within w_dhwju209q
end type

type gb_2 from w_condition_window`gb_2 within w_dhwju209q
end type

type dw_main from uo_search_dwc within w_dhwju209q
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dhwju209q"
end type

type dw_con from uo_dwfree within w_dhwju209q
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 200
boolean bringtotop = true
string dataobject = "d_dhwju208q_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//
//Choose Case dwo.name
//	Case 'gwa'
//		DataWindowChild ldwc_hjmod
//
//		This.getchild('jungong', ldwc_hjmod)
//		ldwc_hjmod.SetTransObject(sqlca)	
//		ldwc_hjmod.Retrieve(data)
//		
//End Choose
end event

