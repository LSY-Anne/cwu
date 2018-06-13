$PBExportHeader$w_hdr104a_1.srw
$PBExportComments$[청운대]납부관리(조회)
forward
global type w_hdr104a_1 from w_condition_window
end type
type dw_con from uo_dwfree within w_hdr104a_1
end type
type dw_main from uo_dwfree within w_hdr104a_1
end type
end forward

global type w_hdr104a_1 from w_condition_window
dw_con dw_con
dw_main dw_main
end type
global w_hdr104a_1 w_hdr104a_1

on w_hdr104a_1.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hdr104a_1.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;string ls_year, ls_hakgi, ls_hakbun, ls_sangtae, ls_hjmod_date, ls_hname, 	ls_jumin
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun   	=	func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_jumin      =	func.of_nvl(dw_con.Object.jumin_no[1], '%')

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi)  then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if


SELECT	A.SANGTAE, A.HJMOD_DATE, A.HNAME
INTO  	:ls_sangtae,
			:ls_hjmod_date,
			:ls_hname
FROM		HAKSA.JAEHAK_HAKJUK A
WHERE	A.HAKBUN	= SUBSTR(:ls_hakbun,1,8)
USING SQLCA ;

if ls_sangtae = '03' then
	IF messagebox('확인', ls_hname + "(" + MID(ls_hakbun,1,8) + ") 이 학생은 " + MID(ls_hjmod_date,1,4) + "년" + MID(ls_hjmod_date,5,2) + "월" + MID(ls_hjmod_date,7,2) + "일" + "에 제적한 학생입니다.", Question!, YesNo!, 2) = 2 then
  return -1
	end if
end if
			
SELECT	A.SANGTAE, A.HJMOD_DATE, A.HNAME
INTO  	:ls_sangtae,
			:ls_hjmod_date,
			:ls_hname
FROM		HAKSA.JOLUP_HAKJUK A
WHERE		A.HAKBUN	= SUBSTR(:ls_hakbun,1,8)
USING SQLCA ;

if ls_sangtae = '04' then
	IF messagebox('확인', ls_hname + "(" + MID(ls_hakbun,1,8) + ") 이 학생은 " + MID(ls_hjmod_date,1,4) + "년" + MID(ls_hjmod_date,5,2) + "월" + MID(ls_hjmod_date,7,2) + "일" + "에 졸업한 학생입니다.", Question!, YesNo!, 2) = 2 then
  return -1
	end if
end if			

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_jumin)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1


end event

event open;call super::open;//idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr104a_1
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr104a_1
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr104a_1
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr104a_1
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr104a_1
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr104a_1
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr104a_1
end type

type uc_insert from w_condition_window`uc_insert within w_hdr104a_1
end type

type uc_delete from w_condition_window`uc_delete within w_hdr104a_1
end type

type uc_save from w_condition_window`uc_save within w_hdr104a_1
end type

type uc_excel from w_condition_window`uc_excel within w_hdr104a_1
end type

type uc_print from w_condition_window`uc_print within w_hdr104a_1
end type

type st_line1 from w_condition_window`st_line1 within w_hdr104a_1
end type

type st_line2 from w_condition_window`st_line2 within w_hdr104a_1
end type

type st_line3 from w_condition_window`st_line3 within w_hdr104a_1
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr104a_1
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr104a_1
end type

type gb_1 from w_condition_window`gb_1 within w_hdr104a_1
end type

type gb_2 from w_condition_window`gb_2 within w_hdr104a_1
end type

type dw_con from uo_dwfree within w_hdr104a_1
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hdr104a_1_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hdr104a_1
integer x = 50
integer y = 296
integer width = 4384
integer height = 1964
integer taborder = 170
boolean bringtotop = true
string dataobject = "d_hdr104a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

