$PBExportHeader$w_dip305a.srw
$PBExportComments$[대학원입시] 자료이관
forward
global type w_dip305a from w_basewindow
end type
type st_cnt from statictext within w_dip305a
end type
type hpb_1 from hprogressbar within w_dip305a
end type
type cb_2 from commandbutton within w_dip305a
end type
type st_2 from statictext within w_dip305a
end type
type dw_con from uo_dwfree within w_dip305a
end type
end forward

global type w_dip305a from w_basewindow
st_cnt st_cnt
hpb_1 hpb_1
cb_2 cb_2
st_2 st_2
dw_con dw_con
end type
global w_dip305a w_dip305a

on w_dip305a.create
int iCurrent
call super::create
this.st_cnt=create st_cnt
this.hpb_1=create hpb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_cnt
this.Control[iCurrent+2]=this.hpb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_con
end on

on w_dip305a.destroy
call super::destroy
destroy(this.st_cnt)
destroy(this.hpb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_con)
end on

event open;call super::open;string	ls_hakgi, ls_year

//idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi

end event

type ln_templeft from w_basewindow`ln_templeft within w_dip305a
end type

type ln_tempright from w_basewindow`ln_tempright within w_dip305a
end type

type ln_temptop from w_basewindow`ln_temptop within w_dip305a
end type

type ln_tempbuttom from w_basewindow`ln_tempbuttom within w_dip305a
end type

type ln_tempbutton from w_basewindow`ln_tempbutton within w_dip305a
end type

type ln_tempstart from w_basewindow`ln_tempstart within w_dip305a
end type

type uc_retrieve from w_basewindow`uc_retrieve within w_dip305a
end type

type uc_insert from w_basewindow`uc_insert within w_dip305a
end type

type uc_delete from w_basewindow`uc_delete within w_dip305a
end type

type uc_save from w_basewindow`uc_save within w_dip305a
end type

type uc_excel from w_basewindow`uc_excel within w_dip305a
end type

type uc_print from w_basewindow`uc_print within w_dip305a
end type

type st_line1 from w_basewindow`st_line1 within w_dip305a
end type

type st_line2 from w_basewindow`st_line2 within w_dip305a
end type

type st_line3 from w_basewindow`st_line3 within w_dip305a
end type

type uc_excelroad from w_basewindow`uc_excelroad within w_dip305a
end type

type ln_dwcon from w_basewindow`ln_dwcon within w_dip305a
end type

type st_cnt from statictext within w_dip305a
integer x = 2528
integer y = 996
integer width = 457
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
long backcolor = 16777215
string text = "count"
alignment alignment = right!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_dip305a
integer x = 1024
integer y = 1064
integer width = 1966
integer height = 84
unsignedinteger maxposition = 100
unsignedinteger position = 1
integer setstep = 10
end type

type cb_2 from commandbutton within w_dip305a
integer x = 2597
integer y = 1288
integer width = 375
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "자료이관"
end type

event clicked;string ls_year, ls_hakgi, ls_iphak
long ll_sugang

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_iphak    	=	dw_con.Object.from_dt[1]

if messagebox("확인",ls_year +"년도 "+ ls_hakgi + "학기 입시자료를 학적으로 이관하시겠습니까?", Question!, YesNo!, 2) = 2 then return

//학적자료
INSERT INTO HAKSA.D_HAKJUK
(	SELECT	HAKBUN,
				GWAJUNG_ID,
				GWA_ID,
				JUNGONG_ID,
				DECODE(JONGBYUL_ID, '0', '1', '2'),
				DECODE(JONGBYUL_ID, '0', '1', '2'),
				HNAME,
				CNAME,
				NULL,
				JUMIN_NO,
				SEX,
				'01',
				'A',
				DECODE(JONGBYUL_ID, '0', 'A11', 'A13'),
				:ls_iphak,
				NULL,
				ZIP_ID,
				JUSO,
				NULL,
				TEL,
				HP,
				JOB_ID,
				NULL,
				NULL,
				NULL,
				OFF_TEL,
				NULL,
				BO_HNAME,
				BO_GWANGYE,
				BO_ZIP_ID,
				BO_JUSO,
				BO_TEL,
				BO_JOB_ID,
				:ls_iphak,
				DECODE(JONGBYUL_ID, '0', '1', '3'),
				SUHUM_NO,
				NULL,				
				DECODE(JONGBYUL_ID, '5', 6, NULL),
				NULL,				NULL,				NULL,				NULL,				NULL,
				NULL,				NULL,				NULL,				NULL,
				sys.CryptIT.encrypt(JUMIN_NO, 'cwu'),
				NULL,				NULL,				NULL,				NULL,				NULL,
				NULL
		FROM	DIPSI.DI_WONSEO
		WHERE	YEAR		=	:ls_year
		AND	HAKGI		=	:ls_hakgi
		AND	HAP_ID	<> '00'
		AND	DUNG_YN	=	'1'
		AND	HAKBUN	IN ('AM2009055')//,'AM2007050','AM2007051')
		) USING SQLCA ;

if sqlca.sqlcode <> 0 then	
	messagebox("오류","자료이관중 오류가 발생되었습니다.(학적)~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	RETURN
	
end if


//하위과정
INSERT	INTO	HAKSA.D_HAWI_HAKWI
(	SELECT	HAKBUN,
				'9',
				COLLEGE_ID2,
				GWA_NAME2,
				HAKWI_NO2,
				NULL, NULL, NULL, NULL, NULL, NULL
	FROM	DIPSI.DI_WONSEO
	WHERE	YEAR		=	:ls_year
	AND	HAKGI		=	:ls_hakgi
	AND	HAP_ID	<> '00'
	AND	DUNG_YN	=	'1'
	AND	HAKBUN	IN ('AM2009055')//,'AM2007050','AM2007051')
	) USING SQLCA ;

if sqlca.sqlcode <> 0 then	
	messagebox("오류","자료이관중 오류가 발생되었습니다.(하위학위)~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	RETURN
	
end if

//장학이관(D_JANGHAK)
INSERT INTO HAKSA.D_JANGHAK
(	SELECT	HAKBUN,
				YEAR,
				HAKGI,
				JANGHAK_ID,
				NULL,				NULL,				NULL,
				NULL,				NULL,				NULL
		FROM	DIPSI.DI_WONSEO
		WHERE	YEAR		=	:ls_year
		AND	HAKGI		=	:ls_hakgi
		AND	HAP_ID	<> '00'
		AND	DUNG_YN	=	'1'
		AND	HAKBUN	IN ('AM2009055')//,'AM2007050','AM2007051')
) USING SQLCA ;
		
if sqlca.sqlcode <> 0 then	
	messagebox("오류","자료이관중 오류가 발생되었습니다.(장학대상자명단)~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	RETURN
	
end if


//등록자료 이관 - 총괄자료(D_DUNGROK)
INSERT	INTO	HAKSA.D_DUNGROK
(	SELECT	B.HAKBUN,
				A.YEAR,
				A.HAKGI,
				1,
				6,
				SUM(A.IPHAK),
				SUM(A.DUNGROK),
				SUM(A.WONWOO),
				SUM(A.I_JANGHAK),
				SUM(A.D_JANGHAK),
				SUM(A.IPHAK_N),
				SUM(A.DUNGROK_N),
				SUM(A.WONWOO_N),
				MAX(A.NAPBU_DATE),
				MAX(A.BANK_ID),
				MAX(A.WAN_YN),
				MAX(A.DUNG_YN),
				MAX(A.BUN_YN),
				MAX(A.CHU_YN),
				MAX(A.HWAN_YN)
	FROM	DIPSI.DI_DUNGROK	A,
			DIPSI.DI_WONSEO	B
	WHERE	A.SUHUM_NO	=	B.SUHUM_NO
	AND	A.YEAR		=	B.YEAR
	AND	A.HAKGI		=	B.HAKGI
	AND	A.YEAR		=	:ls_year
	AND	A.HAKGI		=	:ls_hakgi
	AND	( A.HWAN_YN	IS NULL OR A.HWAN_YN = '0')
	AND	B.DUNG_YN = '1'
	AND	B.HAKBUN	IN ('AM2009055')//,'AM2007050','AM2007051')
	GROUP BY B.HAKBUN,
				A.YEAR,
				A.HAKGI
) USING SQLCA ;
				
if sqlca.sqlcode <> 0 then	
	messagebox("오류","자료이관중 오류가 발생되었습니다.(등록)~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	RETURN
	
end if

//등록자료 이관 - 분납(D_DUNGROK_BUN)
INSERT INTO	HAKSA.D_DUNGROK_BUN
(	SELECT	B.HAKBUN,
				A.YEAR,
				A.HAKGI,
				A.CHASU,
				A.IPHAK_N,
				A.DUNGROK_N,
				A.WONWOO_N,
				A.NAPBU_DATE,
				A.BANK_ID,
				NULL, NULL, NULL, NULL, NULL, NULL
	FROM	DIPSI.DI_DUNGROK	A,
			DIPSI.DI_WONSEO	B
	WHERE	A.SUHUM_NO	=	B.SUHUM_NO
	AND	A.YEAR		=	B.YEAR
	AND	A.HAKGI		=	B.HAKGI
	AND	A.YEAR		=	:ls_year
	AND	A.HAKGI		=	:ls_hakgi
	AND	A.BUN_YN	=	'1'
	AND	( A.HWAN_YN	IS NULL OR A.HWAN_YN = '0')
	AND	B.DUNG_YN = '1'
	AND	B.HAKBUN	IN ('AM2009055')//,'AM2007050','AM2007051')
)	USING SQLCA ;

if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	messagebox("확인","자료이관이 완료되었습니다.")
else
	messagebox("오류","자료이관중 오류가 발생되었습니다. ~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	
end if
end event

type st_2 from statictext within w_dip305a
integer x = 50
integer y = 296
integer width = 4384
integer height = 100
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 12639424
string text = "합격자 자료이관"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_dip305a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dip305a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;String ls_from_dt, ls_to_dt

Choose Case dwo.name
	Case 'p_from_dt'
		ls_from_dt 	= String(This.Object.from_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'from_dt' , ls_from_dt)
		
		ls_from_dt 	= left(ls_from_dt, 4) + mid(ls_from_dt, 6, 2) + right(ls_from_dt, 2)
		This.SetItem(row, 'from_dt',  ls_from_dt)
		
	Case 'p_to_dt'
		ls_to_dt 	= String(This.Object.to_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'to_dt' , ls_to_dt)
		
		ls_to_dt 	= left(ls_to_dt, 4) + mid(ls_to_dt, 6, 2) + right(ls_to_dt, 2)
		This.SetItem(row, 'to_dt',  ls_to_dt)
End Choose
end event

