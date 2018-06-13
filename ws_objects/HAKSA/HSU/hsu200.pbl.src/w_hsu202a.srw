$PBExportHeader$w_hsu202a.srw
$PBExportComments$[청운대]현수강신청인원확인
forward
global type w_hsu202a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hsu202a
end type
type dw_con from uo_dwfree within w_hsu202a
end type
type uo_1 from uo_imgbtn within w_hsu202a
end type
end forward

global type w_hsu202a from w_condition_window
integer width = 4503
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hsu202a w_hsu202a

type variables
long 		il_row
string 	is_year, is_hakgi, is_gwa,	is_jungong_id, is_hakyun, is_ban, is_juya
string	is_gwamok2, is_member_no,  is_seq_no, is_hosil, is_yoil, is_sigan, is_ban_bunhap
string	is_chk, is_gwamok

end variables

on w_hsu202a.create
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

on w_hsu202a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_isu
int 	 li_ans

//조회조건
dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_ban         =  func.of_nvl(dw_con.Object.ban[1], '%')
ls_isu	         =	func.of_nvl(dw_con.Object.isu_id[1], '%')

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1

elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1

end if

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_isu)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_main.setfocus()
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu202a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu202a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu202a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu202a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu202a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu202a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu202a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu202a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu202a
end type

type uc_save from w_condition_window`uc_save within w_hsu202a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu202a
end type

type uc_print from w_condition_window`uc_print within w_hsu202a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu202a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu202a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu202a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu202a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu202a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu202a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu202a
integer taborder = 90
end type

type dw_main from uo_input_dwc within w_hsu202a
integer x = 50
integer y = 292
integer width = 4379
integer height = 1972
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_hsu200a_3"
end type

type dw_con from uo_dwfree within w_hsu202a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hsu202a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hsu202a
integer x = 599
integer y = 40
integer width = 498
integer taborder = 41
boolean bringtotop = true
string btnname = "수강인원수정"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban, ls_isu
integer	li_seq, li_inwon

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_ban         =  func.of_nvl(dw_con.Object.ban[1], '%')
ls_isu	         =	func.of_nvl(dw_con.Object.isu_id[1], '%')

setpointer(hourglass!)

DECLARE	CUR_INWON	CURSOR FOR
SELECT	YEAR,
			HAKGI,
			GWA,
			HAKYUN,
			BAN,
			GWAMOK_ID,
			GWAMOK_SEQ,
			BUNBAN
FROM	HAKSA.GAESUL_GWAMOK
WHERE	YEAR			=	:ls_year
AND	HAKGI			=	:ls_hakgi
AND	GWA		like	:ls_gwa
AND	HAKYUN	like	:ls_hakyun
AND	BAN		like	:ls_ban
AND	ISU_ID	like	:ls_isu
USING SQLCA ;

OPEN	CUR_INWON	;
DO
	FETCH	CUR_INWON	INTO	:ls_year, :ls_hakgi, :ls_gwa, :ls_hakyun, :ls_ban, :ls_gwamok, :li_seq, :ls_bunban	;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	SELECT NVL(COUNT(HAKBUN), 0)
	INTO	:li_inwon
	FROM	HAKSA.SUGANG_TRANS
	WHERE	YEAR				=	:ls_year
	AND	HAKGI				=	:ls_hakgi
	AND	GWA				=	:ls_gwa
	AND	HAKYUN			=	:ls_hakyun
	AND	BAN				=	:ls_ban
	AND	GWAMOK_ID		=	:ls_gwamok
	AND	GWAMOK_SEQ		=	:li_seq
	AND	BUNBAN			=	:ls_bunban
	AND	SUNGJUK_INJUNG	=	'Y'	
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then 
		messagebox("오류","인원체크중 오류발생~r~n" + sqlca.sqlerrtext)
		rollback	USING SQLCA ;
		return
	end if	
	
	UPDATE	HAKSA.GAESUL_GWAMOK
	SET	SU_INWON	=	:li_inwon
	WHERE	YEAR			=	:ls_year
	AND	HAKGI			=	:ls_hakgi
	AND	GWA			=	:ls_gwa
	AND	HAKYUN		=	:ls_hakyun
	AND	BAN			=	:ls_ban
	AND	GWAMOK_ID	=	:ls_gwamok
	AND	GWAMOK_SEQ	=	:li_seq
	AND	BUNBAN		=	:ls_bunban
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then 
		messagebox("오류","저장중 오류발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
	
LOOP WHILE TRUE
CLOSE CUR_INWON ;

COMMIT USING SQLCA ;
setpointer(Arrow!)

messagebox("확인","작업종료~r~n" + sqlca.sqlerrtext)



end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

