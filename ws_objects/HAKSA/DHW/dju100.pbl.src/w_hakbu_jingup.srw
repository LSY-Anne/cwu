$PBExportHeader$w_hakbu_jingup.srw
$PBExportComments$[대학원진급] 진급관리
forward
global type w_hakbu_jingup from w_condition_window
end type
type uo_1 from uo_imgbtn within w_hakbu_jingup
end type
type uo_2 from uo_imgbtn within w_hakbu_jingup
end type
type dw_main from uo_dwfree within w_hakbu_jingup
end type
end forward

global type w_hakbu_jingup from w_condition_window
uo_1 uo_1
uo_2 uo_2
dw_main dw_main
end type
global w_hakbu_jingup w_hakbu_jingup

on w_hakbu_jingup.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.dw_main
end on

on w_hakbu_jingup.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_main)
end on

type ln_templeft from w_condition_window`ln_templeft within w_hakbu_jingup
end type

type ln_tempright from w_condition_window`ln_tempright within w_hakbu_jingup
end type

type ln_temptop from w_condition_window`ln_temptop within w_hakbu_jingup
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hakbu_jingup
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hakbu_jingup
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hakbu_jingup
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hakbu_jingup
end type

type uc_insert from w_condition_window`uc_insert within w_hakbu_jingup
end type

type uc_delete from w_condition_window`uc_delete within w_hakbu_jingup
end type

type uc_save from w_condition_window`uc_save within w_hakbu_jingup
end type

type uc_excel from w_condition_window`uc_excel within w_hakbu_jingup
end type

type uc_print from w_condition_window`uc_print within w_hakbu_jingup
end type

type st_line1 from w_condition_window`st_line1 within w_hakbu_jingup
end type

type st_line2 from w_condition_window`st_line2 within w_hakbu_jingup
end type

type st_line3 from w_condition_window`st_line3 within w_hakbu_jingup
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hakbu_jingup
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hakbu_jingup
end type

type gb_1 from w_condition_window`gb_1 within w_hakbu_jingup
end type

type gb_2 from w_condition_window`gb_2 within w_hakbu_jingup
end type

type uo_1 from uo_imgbtn within w_hakbu_jingup
integer x = 585
integer y = 40
integer width = 453
integer taborder = 20
boolean bringtotop = true
string btnname = "취득학년"
end type

event clicked;call super::clicked;string	ls_hakbun, ls_hakyun
long		ll_hakjum

IF MESSAGEBOX("확인","취득학년진급을 실행하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

SetPointer(HourGlass!)

DECLARE CUR_CHIDK CURSOR FOR
SELECT HAKBUN
FROM	HAKSA.JAEHAK_HAKJUK	
USING SQLCA ;

OPEN CUR_CHIDK ;
DO
	FETCH CUR_CHIDK INTO :ls_hakbun ;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	//취득학점을 가져온다.
	SELECT SUM(CHIDK_HAKJUM)
	INTO :ll_hakjum
	FROM	HAKSA.SUNGJUKGYE
	WHERE	INJUNG_YN = 'Y'	
	USING SQLCA ;
	
	//학점에 따라 학년부여
	if ll_hakjum <= 35 then
		ls_hakyun = '1'
		
	elseif ll_hakjum > 35 and ll_hakjum <= 70 then
		ls_hakyun = '2'
		
	elseif ll_hakjum > 70 and ll_hakjum <= 105 then
		ls_hakyun = '3'
		
	elseif ll_hakjum > 105 then
		ls_hakyun = '4'
		
	end if
	
	//학년 UPDATE
	UPDATE HAKSA.JAEHAK_HAKJUK
	SET	CH_HAKYUN = :ls_hakyun
	WHERE	HAKBUN	=	:ls_hakbun
	USING SQLCA ;
	
	IF SQLCA.SQLCODE <> 0 THEN
		
		messagebox("오류","진급중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
		ROLLBACK USING SQLCA ;
		
	END IF	
	
	
LOOP WHILE TRUE
CLOSE CUR_CHIDK ;
COMMIT USING SQLCA ;


SetPointer(Arrow!)

messagebox("확인","작업이 종료되었습니다.")
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hakbu_jingup
integer x = 1230
integer y = 40
integer width = 453
integer taborder = 30
boolean bringtotop = true
string btnname = "수업학년"
end type

event clicked;call super::clicked;IF MESSAGEBOX("확인","수업학기진급을 실행하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

UPDATE	HAKSA.JAEHAK_HAKJUK
SET	S_HAKGICHA	=	DECODE(SU_HAKYUN, '4', '4', TO_CHAR(TO_NUMBER(SU_HAKYUN) + 1))
WHERE	SANGTAE	=	'01'
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

type dw_main from uo_dwfree within w_hakbu_jingup
integer x = 50
integer y = 288
integer width = 4384
integer height = 1976
integer taborder = 21
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

