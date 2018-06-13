$PBExportHeader$w_hsu104a.srw
$PBExportComments$[청운대]시간표생성
forward
global type w_hsu104a from w_no_condition_window
end type
type st_2 from statictext within w_hsu104a
end type
type hpb_1 from hprogressbar within w_hsu104a
end type
type cb_1 from commandbutton within w_hsu104a
end type
type st_9 from statictext within w_hsu104a
end type
type dw_con from uo_dwfree within w_hsu104a
end type
end forward

global type w_hsu104a from w_no_condition_window
st_2 st_2
hpb_1 hpb_1
cb_1 cb_1
st_9 st_9
dw_con dw_con
end type
global w_hsu104a w_hsu104a

on w_hsu104a.create
int iCurrent
call super::create
this.st_2=create st_2
this.hpb_1=create hpb_1
this.cb_1=create cb_1
this.st_9=create st_9
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.hpb_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_9
this.Control[iCurrent+5]=this.dw_con
end on

on w_hsu104a.destroy
call super::destroy
destroy(this.st_2)
destroy(this.hpb_1)
destroy(this.cb_1)
destroy(this.st_9)
destroy(this.dw_con)
end on

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

end event

type ln_templeft from w_no_condition_window`ln_templeft within w_hsu104a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hsu104a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hsu104a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hsu104a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hsu104a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hsu104a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hsu104a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hsu104a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hsu104a
end type

type uc_save from w_no_condition_window`uc_save within w_hsu104a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hsu104a
end type

type uc_print from w_no_condition_window`uc_print within w_hsu104a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hsu104a
end type

type st_line2 from w_no_condition_window`st_line2 within w_hsu104a
end type

type st_line3 from w_no_condition_window`st_line3 within w_hsu104a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hsu104a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hsu104a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hsu104a
end type

type st_2 from statictext within w_hsu104a
integer x = 59
integer y = 408
integer width = 4370
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 32500968
string text = "시간표 생성"
alignment alignment = center!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_hsu104a
integer x = 1216
integer y = 824
integer width = 2149
integer height = 92
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type cb_1 from commandbutton within w_hsu104a
integer x = 1929
integer y = 1052
integer width = 718
integer height = 184
integer taborder = 70
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생성"
end type

event clicked;string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_hosil, ls_bunban
integer	li_seq, li_sisu, li_loop
integer	li_return_msg
long		ll_count, ll_tot_count, i, ll_chk

dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_ban        =	func.of_nvl(dw_con.Object.ban[1], '%')
ls_gwamok =	func.of_nvl(dw_con.Object.gwamok[1], '%')
ls_bunban  =	func.of_nvl(dw_con.Object.bunban[1], '%')

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
	
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
end if

//기존의 시간표정보 유무 확인(년도, 학기, 학년, 반, 학과/전공, 과목별 검색)
SELECT	COUNT(*)
INTO	:ll_count
FROM	HAKSA.SIGANPYO
WHERE	YEAR  			=	:ls_year
AND	HAKGI				=	:ls_hakgi
AND	GWA   		like	:ls_gwa
AND	HAKYUN 		like	:ls_hakyun
AND	BAN			like	:ls_ban
AND	GWAMOK_ID	like	:ls_gwamok
AND	BUNBAN		like	:ls_bunban
USING SQLCA;

//기존의 시간표정보가 존재하면
if ll_count > 0 then   					
	li_return_msg = messagebox("확인","이미 시간표가 존재합니다! ~n 삭제후 재생성하시겠습니까?",Exclamation!,okcancel!,2)
	
	//삭제후 생성시, 시간표 테이블에서 삭제함
	if li_return_msg = 1 then 			

		delete from	haksa.siganpyo   
		where year 		 	=	:ls_year
		and   hakgi			=	:ls_hakgi
		and   gwa   		like	:ls_gwa
		and   hakyun		like	:ls_hakyun
		and   ban			like	:ls_ban
		and   gwamok_id	like	:ls_gwamok
		AND	bunban		like	:ls_bunban
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","기존자료 삭제중 오류발생~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
			return
		end if
	else
		return
	end if
end if

//시수입력 여부 체크
SELECT nvl(sisu, 0)
INTO   :ll_chk
FROM  HAKSA.GAESUL_GWAMOK
WHERE	YEAR  			=	:ls_year
AND	HAKGI				=	:ls_hakgi
AND	GWA   		like	:ls_gwa
AND	HAKYUN 		like	:ls_hakyun
AND	BAN			like	:ls_ban
AND	GWAMOK_ID	like	:ls_gwamok
AND	BUNBAN		like	:ls_bunban
AND	SISU	IS NULL
USING SQLCA ;

if ll_chk > 0 then
	messagebox("오류","시수가 입력않은 과목이 있습니다.~r~n시수가 입력되어야 시간표 생성이 이루집니다.")
	return
end if

//해당 시간표자료의 총수를 계산
SELECT sum(sisu)
INTO	:ll_tot_count
FROM	HAKSA.GAESUL_GWAMOK
WHERE	YEAR  			=	:ls_year
AND	HAKGI				=	:ls_hakgi
AND	GWA   		like	:ls_gwa
AND	HAKYUN 		like	:ls_hakyun
AND	BAN			like	:ls_ban
AND	GWAMOK_ID	like	:ls_gwamok
AND	BUNBAN		like	:ls_bunban
USING SQLCA ;

	
SetPointer(hourglass!)
hpb_1.maxposition	=	ll_tot_count

//개설과목의 자료를 읽어와서 시간표 자료 생성
DECLARE CUR_SIGAN	CURSOR FOR
SELECT	YEAR,			HAKGI,		GWA,		HAKYUN,		BAN,
			GWAMOK_ID,	GWAMOK_SEQ, BUNBAN,	HOSIL_CODE,	SISU
FROM	HAKSA.GAESUL_GWAMOK
WHERE	YEAR  			=	:ls_year
AND	HAKGI				=	:ls_hakgi
AND	GWA   		like	:ls_gwa
AND	HAKYUN 		like	:ls_hakyun
AND	BAN			like	:ls_ban
AND	GWAMOK_ID	like	:ls_gwamok
AND	BUNBAN		like	:ls_bunban
USING SQLCA ;

OPEN CUR_SIGAN ;
DO
	FETCH CUR_SIGAN INTO :ls_year,	:ls_hakgi,	:ls_gwa, 	:ls_hakyun,	:ls_ban,
								:ls_gwamok,	:li_seq,		:ls_bunban,	:ls_hosil,	:li_sisu			;
	
//	MESSAGEBOX("A", SQLCA.SQLCODE)
	IF SQLCA.SQLCODE <> 0 THEN EXIT	
		
		//시수만큼 시간표 row생성
		FOR li_loop = 1 TO li_sisu
			
			INSERT INTO HAKSA.SIGANPYO
						(	YEAR,			     HAKGI,		GWA,			HAKYUN,		BAN,		
							GWAMOK_ID,	GWAMOK_SEQ,	BUNBAN,	SEQ_NO,		HOSIL_CODE,
							WORKER,		IPADDR,		WORK_DATE								)
			VALUES	(	:ls_year,          :ls_hakgi,	:ls_gwa,		:ls_hakyun,	:ls_ban,
							:ls_gwamok,	:li_seq,		:ls_bunban,	:li_loop,   	:ls_hosil,	
							:gs_empcode,	:gs_ip,	    sysdate	) USING SQLCA ;
											
			if sqlca.sqlcode <> 0 then 
				messagebox("오류","시간표 생성중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return
			end if
			
			i = i + 1
			hpb_1.position = i
		NEXT
			
	
LOOP WHILE TRUE
CLOSE CUR_SIGAN ;

COMMIT USING SQLCA ;
MESSAGEBOX("확인","작업이 완료되었습니다.")

end event

type st_9 from statictext within w_hsu104a
integer x = 928
integer y = 844
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "처리경과"
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hsu104a
integer x = 55
integer y = 168
integer width = 4379
integer height = 228
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsu104a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

