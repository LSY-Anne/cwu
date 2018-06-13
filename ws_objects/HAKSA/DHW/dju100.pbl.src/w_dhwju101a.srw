﻿$PBExportHeader$w_dhwju101a.srw
$PBExportComments$[대학원진급] 진급관리
forward
global type w_dhwju101a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwju101a
end type
type dw_con from uo_dwfree within w_dhwju101a
end type
type uo_1 from uo_imgbtn within w_dhwju101a
end type
type uo_2 from uo_imgbtn within w_dhwju101a
end type
end forward

global type w_dhwju101a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
end type
global w_dhwju101a w_dhwju101a

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

//dw_main.Object.d_hakjuk_gyeyul_id.Protect    = li_chk1
//dw_main.Object.d_hakjuk_gwa_id.Protect       = li_chk2
//dw_main.Object.d_hakjuk_jungong_id.Protect  = li_chk3
end subroutine

on w_dhwju101a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.uo_2
end on

on w_dhwju101a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event open;call super::open;string	ls_hakgi
DataWindowChild ldwc_hjmod

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.getchild('jungong', ldwc_hjmod)
ldwc_hjmod.SetTransObject(sqlca)	
ldwc_hjmod.Retrieve('%')

end event

event ue_retrieve;call super::ue_retrieve;string	ls_gwajung, ls_hakgwa, ls_jungong, ls_gyeyul_id
long		ll_ans

dw_con.AcceptText()

ls_gwajung  =	func.of_nvl(dw_con.Object.gwajung[1], '%') + '%'
ls_gyeyul_id =  func.of_nvl(dw_con.Object.gyeyul_id[1], '%') + '%'
ls_hakgwa   =	func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_jungong   =	func.of_nvl(dw_con.Object.jungong[1], '%') + '%'

ll_ans = dw_main.retrieve(ls_gwajung, ls_gyeyul_id, ls_hakgwa, ls_jungong)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwju101a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwju101a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwju101a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwju101a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwju101a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwju101a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwju101a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwju101a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwju101a
end type

type uc_save from w_condition_window`uc_save within w_dhwju101a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwju101a
end type

type uc_print from w_condition_window`uc_print within w_dhwju101a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwju101a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwju101a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwju101a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwju101a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwju101a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwju101a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwju101a
end type

type dw_main from uo_input_dwc within w_dhwju101a
integer x = 55
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dhwju101a"
end type

type dw_con from uo_dwfree within w_dhwju101a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 170
boolean bringtotop = true
string dataobject = "d_dhwju101a_c1"
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

type uo_1 from uo_imgbtn within w_dhwju101a
integer x = 672
integer y = 40
integer width = 535
integer taborder = 20
boolean bringtotop = true
string btnname = "수업학기진급"
end type

event clicked;call super::clicked;IF MESSAGEBOX("확인","수업학기진급을 실행하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

UPDATE	HAKSA.D_HAKJUK
SET		S_HAKGICHA	=	DECODE(D_HAKGICHA, '6', '6', TO_CHAR(TO_NUMBER(S_HAKGICHA) + 1))
WHERE	SANGTAE_ID	=	'01'
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	COMMIT USING SQLCA ;
	messagebox("확인","작업이 종료되었습니다.")
ELSE
	messagebox("오류","진급중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
	ROLLBACK USING SQLCA ;
	
END IF
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_dhwju101a
integer x = 1234
integer y = 40
integer width = 535
integer taborder = 30
boolean bringtotop = true
string btnname = "등록학기진급"
end type

event clicked;call super::clicked;IF MESSAGEBOX("확인","등록학기진급을 실행하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

UPDATE	HAKSA.D_HAKJUK
SET		D_HAKGICHA	=	DECODE(D_HAKGICHA, '6', '6', TO_CHAR(TO_NUMBER(D_HAKGICHA) + 1))
WHERE	SANGTAE_ID	=	'01'
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	COMMIT USING SQLCA ;
	messagebox("확인","작업이 종료되었습니다.")
ELSE
	messagebox("오류","진급중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
	ROLLBACK USING SQLCA ;
	
END IF
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

