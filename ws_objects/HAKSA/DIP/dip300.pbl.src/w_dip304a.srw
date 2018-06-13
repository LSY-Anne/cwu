$PBExportHeader$w_dip304a.srw
$PBExportComments$[대학원입시] 학번부여
forward
global type w_dip304a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dip304a
end type
type dw_con from uo_dwfree within w_dip304a
end type
type uo_1 from uo_imgbtn within w_dip304a
end type
end forward

global type w_dip304a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_dip304a w_dip304a

on w_dip304a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
end on

on w_dip304a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string	ls_year, ls_hakgi
long		ll_ans, i

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi)

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

//idw_print = dw_main

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

type ln_templeft from w_condition_window`ln_templeft within w_dip304a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dip304a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dip304a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dip304a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dip304a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dip304a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dip304a
end type

type uc_insert from w_condition_window`uc_insert within w_dip304a
end type

type uc_delete from w_condition_window`uc_delete within w_dip304a
end type

type uc_save from w_condition_window`uc_save within w_dip304a
end type

type uc_excel from w_condition_window`uc_excel within w_dip304a
end type

type uc_print from w_condition_window`uc_print within w_dip304a
end type

type st_line1 from w_condition_window`st_line1 within w_dip304a
end type

type st_line2 from w_condition_window`st_line2 within w_dip304a
end type

type st_line3 from w_condition_window`st_line3 within w_dip304a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dip304a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dip304a
end type

type gb_1 from w_condition_window`gb_1 within w_dip304a
end type

type gb_2 from w_condition_window`gb_2 within w_dip304a
end type

type dw_main from uo_input_dwc within w_dip304a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dip304a"
end type

type dw_con from uo_dwfree within w_dip304a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_dip304a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_dip304a
integer x = 581
integer y = 40
integer width = 421
integer taborder = 20
boolean bringtotop = true
string btnname = "학번부여"
end type

event clicked;call super::clicked;string ls_year, ls_hakgi, ls_suhum, ls_hakbun
integer	li_max

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if messagebox("확인","학번을 부여하시겠습니까?", Question!, YesNo!, 2) = 2 then return

SELECT	NVL(MAX(SUBSTR(HAKBUN, 7, 3)), 0) + 1
INTO	:li_max
FROM	HAKSA.D_HAKJUK
WHERE	IPHAK_DATE	LIKE	:ls_year||'%'
USING SQLCA ;


DECLARE	CUR_HAKBUN	CURSOR FOR
SELECT	A.SUHUM_NO
FROM		DIPSI.DI_WONSEO	A,
			DIPSI.DI_JUNGONG_CODE	B
WHERE		A.JUNGONG_ID	=	B.JUNGONG_ID
AND		A.YEAR			=	:ls_year
AND		A.HAKGI			=	:ls_hakgi
AND		A.HAP_ID			<> '00'
AND		A.DUNG_YN		=	'1'	
ORDER BY	B.GYEYUL_ID,   
			A.JUNGONG_ID, 
			A.HNAME	
USING SQLCA ;
			
OPEN CUR_HAKBUN	;
DO
	FETCH CUR_HAKBUN	INTO	:ls_suhum	;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	ls_hakbun	=	'AM' + ls_year + string(li_max, '000')
	
	UPDATE	DIPSI.DI_WONSEO
	SET	HAKBUN	=	:ls_hakbun
	WHERE	YEAR		=	:ls_year
	AND	HAKGI		=	:ls_hakgi
	AND	SUHUM_NO	=	:ls_suhum
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","학번부여중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
	
	li_max = li_max + 1
	
LOOP WHILE TRUE
CLOSE CUR_HAKBUN	;

COMMIT USING SQLCA ;
messagebox("확인","작업이 완료되었습니다.")
dw_main.retrieve(ls_year, ls_hakgi)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

