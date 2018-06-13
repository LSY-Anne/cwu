$PBExportHeader$w_hjj001a.srw
$PBExportComments$[청운대]진급관리
forward
global type w_hjj001a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjj001a
end type
type dw_con from uo_dwfree within w_hjj001a
end type
type uo_1 from uo_imgbtn within w_hjj001a
end type
type uo_2 from uo_imgbtn within w_hjj001a
end type
type uo_3 from uo_imgbtn within w_hjj001a
end type
end forward

global type w_hjj001a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
end type
global w_hjj001a w_hjj001a

on w_hjj001a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.uo_3
end on

on w_hjj001a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
end on

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)
end event

event ue_retrieve;string ls_gwa
long	ll_ans

dw_con.AcceptText()

ls_gwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'

ll_ans = dw_main.retrieve(ls_gwa)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

return 1


end event

type ln_templeft from w_condition_window`ln_templeft within w_hjj001a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjj001a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjj001a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjj001a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjj001a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjj001a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjj001a
end type

type uc_insert from w_condition_window`uc_insert within w_hjj001a
end type

type uc_delete from w_condition_window`uc_delete within w_hjj001a
end type

type uc_save from w_condition_window`uc_save within w_hjj001a
end type

type uc_excel from w_condition_window`uc_excel within w_hjj001a
end type

type uc_print from w_condition_window`uc_print within w_hjj001a
end type

type st_line1 from w_condition_window`st_line1 within w_hjj001a
end type

type st_line2 from w_condition_window`st_line2 within w_hjj001a
end type

type st_line3 from w_condition_window`st_line3 within w_hjj001a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjj001a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjj001a
end type

type gb_1 from w_condition_window`gb_1 within w_hjj001a
end type

type gb_2 from w_condition_window`gb_2 within w_hjj001a
end type

type dw_main from uo_input_dwc within w_hjj001a
integer x = 55
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjj001a_1"
end type

type dw_con from uo_dwfree within w_hjj001a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hjj001a_1_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjj001a
integer x = 334
integer y = 40
integer width = 379
integer taborder = 20
boolean bringtotop = true
string btnname = "수업학년"
end type

event clicked;call super::clicked;IF MESSAGEBOX("확인","수업학년진급을 실행하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

UPDATE	HAKSA.JAEHAK_HAKJUK
SET		SU_HAKYUN	=	DECODE(SU_HAKYUN, '4', '4', TO_CHAR(TO_NUMBER(SU_HAKYUN) + 1))
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

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hjj001a
integer x = 773
integer y = 40
integer width = 379
integer taborder = 20
boolean bringtotop = true
string btnname = "등록학년"
end type

event clicked;call super::clicked;IF MESSAGEBOX("확인","등록학년진급을 실행하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

UPDATE	HAKSA.JAEHAK_HAKJUK
SET		DR_HAKYUN	=	DECODE(DR_HAKYUN, '4', '4', TO_CHAR(TO_NUMBER(DR_HAKYUN) + 1))
WHERE		SANGTAE	=	'01'		
AND		SU_HAKYUN <> DR_HAKYUN
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

type uo_3 from uo_imgbtn within w_hjj001a
integer x = 1221
integer y = 40
integer width = 379
integer taborder = 30
boolean bringtotop = true
string btnname = "취득학년"
end type

event clicked;call super::clicked;string	ls_hakbun, ls_hakyun
long		ll_hakjum, ll_injung_hakjum
IF MESSAGEBOX("확인","취득학년진급을 실행하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

SetPointer(HourGlass!)

DECLARE c_pro PROCEDURE FOR
			HAKSA.SP_HAKJUK_CH_HAKYUN;
EXECUTE c_pro;
CLOSE   c_pro;

//DECLARE 	CUR_CHIDK CURSOR FOR
//
//SELECT 	HAKBUN
//FROM		HAKSA.JAEHAK_HAKJUK
//USING SQLCA ;
//
//OPEN CUR_CHIDK ;
//DO
//	FETCH CUR_CHIDK INTO :ls_hakbun ;
//	
//	IF SQLCA.SQLCODE <> 0 THEN EXIT
//	
//	//취득학점을 가져온다.
////	SELECT	DECODE(SUM(CHIDK_HAKJUM), '', 0,	SUM(CHIDK_HAKJUM))
////	INTO 		:ll_hakjum
////	FROM		HAKSA.SUNGJUKGYE
////	WHERE		INJUNG_YN	=	'Y'
////	AND		HAKBUN		=	:ls_hakbun	;
//										
//
//	SELECT 	DECODE(SUM(A.HAKJUM), '', 0,	SUM(A.HAKJUM)) 
//	INTO 		:ll_hakjum
//	FROM		HAKSA.SUGANG A
//	WHERE	A.SUNGJUK_INJUNG 	='Y'
//	AND		A.HWANSAN_JUMSU	<> 'F'
//	AND		A.HAKBUN like :ls_hakbun
//	USING SQLCA ;
//	
//	SELECT	NVL(INJUNG_HAKJUM, 0)
//	INTO		:ll_injung_hakjum	
//	FROM		HAKSA.JAEHAK_HAKJUK
//	WHERE	HAKBUN		=	:ls_hakbun
//	USING SQLCA ;
//	
//	ll_hakjum = ll_hakjum + ll_injung_hakjum
//	//학점에 따라 학년부여
//	if ll_hakjum <= 34 then
//		ls_hakyun = '0'
//		
//	elseif ll_hakjum > 34 and ll_hakjum <= 69 then
//		ls_hakyun = '1'
//		
//	elseif ll_hakjum > 69 and ll_hakjum <= 104 then
//		ls_hakyun = '2'
//		
//	elseif ll_hakjum > 104 and ll_hakjum <= 139 then
//		ls_hakyun = '3'
//		
//	elseif ll_hakjum > 139 then
//		ls_hakyun = '4'
//		
//	end if
//	
//	//학년 UPDATE
//	UPDATE 	HAKSA.JAEHAK_HAKJUK
//	SET		CH_HAKYUN = :ls_hakyun
//	WHERE		HAKBUN	=	:ls_hakbun
//	USING SQLCA ;
//	
//	IF SQLCA.SQLCODE <> 0 THEN
//		
//		messagebox("오류","진급중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
//		ROLLBACK USING SQLCA ;
//		
//	END IF	
//	
//LOOP WHILE TRUE
//CLOSE CUR_CHIDK ;

COMMIT USING SQLCA ;

SetPointer(Arrow!)

messagebox("확인","작업이 종료되었습니다.")
end event

on uo_3.destroy
call uo_imgbtn::destroy
end on

