$PBExportHeader$w_dip203a.srw
$PBExportComments$[대학원입시] 사정처리
forward
global type w_dip203a from w_condition_window
end type
type dw_con from uo_dwfree within w_dip203a
end type
type uo_1 from uo_imgbtn within w_dip203a
end type
type dw_main from uo_dwfree within w_dip203a
end type
end forward

global type w_dip203a from w_condition_window
dw_con dw_con
uo_1 uo_1
dw_main dw_main
end type
global w_dip203a w_dip203a

on w_dip203a.create
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

on w_dip203a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_mojip, ls_jongbyul, ls_hakgwa
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_mojip  	=	dw_con.Object.mojip_id[1]
ls_jongbyul 	=	func.of_nvl(dw_con.Object.jongbyul_id[1], '%') + '%'
ls_hakgwa 	=	func.of_nvl(dw_con.Object.gwa[1], '%') + '%'

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

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_mojip, ls_jongbyul, ls_hakgwa)

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

type ln_templeft from w_condition_window`ln_templeft within w_dip203a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dip203a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dip203a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dip203a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dip203a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dip203a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dip203a
end type

type uc_insert from w_condition_window`uc_insert within w_dip203a
end type

type uc_delete from w_condition_window`uc_delete within w_dip203a
end type

type uc_save from w_condition_window`uc_save within w_dip203a
end type

type uc_excel from w_condition_window`uc_excel within w_dip203a
end type

type uc_print from w_condition_window`uc_print within w_dip203a
end type

type st_line1 from w_condition_window`st_line1 within w_dip203a
end type

type st_line2 from w_condition_window`st_line2 within w_dip203a
end type

type st_line3 from w_condition_window`st_line3 within w_dip203a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dip203a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dip203a
end type

type gb_1 from w_condition_window`gb_1 within w_dip203a
end type

type gb_2 from w_condition_window`gb_2 within w_dip203a
end type

type dw_con from uo_dwfree within w_dip203a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 190
boolean bringtotop = true
string dataobject = "d_dip203a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_dip203a
integer x = 535
integer y = 40
integer width = 485
integer taborder = 80
boolean bringtotop = true
string btnname = "사정처리"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_mojip, ls_suhum
double	ld_man1, ld_pyen1, ld_man2, ld_pyen2, ld_jumsu1, ld_jumsu2, ld_jumsu, ld_hwan1, ld_hwan2, ld_hwan

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_mojip  	=	dw_con.Object.mojip_id[1]

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
end if

if ls_mojip = ''  or Isnull(ls_mojip) then
	messagebox("확인","모집구분을 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("mojip_id")
	return
end if

IF MESSAGEBOX("확인",ls_year + "년도 " + ls_hakgi + " 학기 사정처리를 하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

SetPointer(HourGlass!)

DECLARE CUR_SAJUNG	CURSOR FOR
SELECT	SUHUM_NO,
			MAN1,
			PYEN1,
			MAN2,
			PYEN2
FROM	DIPSI.DI_WONSEO
WHERE	YEAR		=	:ls_year	
AND	HAKGI		=	:ls_hakgi
AND	MOJIP_ID	=	:ls_mojip	
USING SQLCA ;

OPEN CUR_SAJUNG	;
DO
	FETCH CUR_SAJUNG	INTO 	:ls_suhum, :ld_man1, :ld_pyen1, :ld_man2, :ld_pyen2	;

	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
		//만점에 대한 환산기준점수를 가져온다.
		if ld_man1 = 4.5 then
			ld_hwan1	=	0.11428571
			
		elseif ld_man1 = 4.3 then
			ld_hwan1	=	0.12121212
			
		elseif ld_man1 = 4.0 then
			ld_hwan1	=	0.13333333
				
		end if	

		if ld_man2 = 4.5 then
			ld_hwan2	=	0.11428571
			
		elseif ld_man2 = 4.3 then
			ld_hwan2	=	0.12121212
			
		elseif ld_man2 = 4.0 then
			ld_hwan2	=	0.13333333
			
		end if
	
	//점수가 하나만 존재
	IF (isnull(ld_man1) or ld_man1 = 0) and (isnull(ld_pyen1) or ld_pyen1 = 0) THEN
		
		if isnull(ld_pyen2) or ld_pyen2 = 0 then
			ld_jumsu =	0
			ld_man2	=	0
			ld_pyen2	=	0
		else
			ld_jumsu	= (((ld_pyen2 * 100)  - 100) * ld_hwan2) + 60
		end if
	
		//점수 UPDATE(이전학교 점수가 없는 학생은 만점과 평점을 0으로 함.)
		UPDATE	DIPSI.DI_WONSEO
		SET	MAN2		=	:ld_man2		,
				PYEN2		=	:ld_pyen2	,
				JUMSU		=	:ld_jumsu
		WHERE	YEAR		=	:ls_year
		AND	HAKGI		=	:ls_hakgi
		AND	SUHUM_NO	=	:ls_suhum
		USING SQLCA ;
		
	//점수가 두개가 존재
	ELSE
		//두개의 평점만점이 틀리면 평점을 재계산 
		if ld_man1 <> ld_man2 then	
			if ld_man1 < ld_man2 then
				ld_pyen1 =  round((ld_man2 * ld_pyen1) / ld_man1, 2)
				ld_hwan	=	ld_hwan2
			else
				ld_pyen2 =  round((ld_man1 * ld_pyen2) / ld_man2, 2)
				ld_hwan	=	ld_hwan1
			end if
		else
			ld_hwan = ld_hwan1
		end if
		
		ld_jumsu	= (((round((ld_pyen1 + ld_pyen2) / 2, 2) * 100)  - 100) * ld_hwan) + 60
//		ld_jumsu	= round((((((ld_pyen1 * 100)  - 100) * ld_hwan1) + 60) + ((((ld_pyen2 * 100) - 100) * ld_hwan2) + 60)) / 2, 2)

		//점수 UPDATE
		UPDATE	DIPSI.DI_WONSEO
		SET	JUMSU		=	:ld_jumsu
		WHERE	YEAR		=	:ls_year
		AND	HAKGI		=	:ls_hakgi
		AND	SUHUM_NO	=	:ls_suhum
		USING SQLCA ;

	END IF
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","성적사정중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	end if
	
LOOP WHILE TRUE
CLOSE CUR_SAJUNG	;

COMMIT USING SQLCA ;
SetPointer(Arrow!)
MESSAGEBOX("확인","작업이 완료되었습니다.")

dw_main.retrieve(ls_year, ls_hakgi, ls_mojip, '%', '%')

end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_dip203a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_dip203a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

