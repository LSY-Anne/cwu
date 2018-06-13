$PBExportHeader$w_dhwdr208a.srw
$PBExportComments$[대학원등록]가상계좌일괄생성 및 개별생성
forward
global type w_dhwdr208a from w_no_condition_window
end type
type st_2 from statictext within w_dhwdr208a
end type
type hpb_1 from hprogressbar within w_dhwdr208a
end type
type cb_3 from commandbutton within w_dhwdr208a
end type
type st_sangtae from statictext within w_dhwdr208a
end type
type cb_1 from commandbutton within w_dhwdr208a
end type
type dw_con from uo_dwfree within w_dhwdr208a
end type
type r_1 from rectangle within w_dhwdr208a
end type
end forward

global type w_dhwdr208a from w_no_condition_window
st_2 st_2
hpb_1 hpb_1
cb_3 cb_3
st_sangtae st_sangtae
cb_1 cb_1
dw_con dw_con
r_1 r_1
end type
global w_dhwdr208a w_dhwdr208a

on w_dhwdr208a.create
int iCurrent
call super::create
this.st_2=create st_2
this.hpb_1=create hpb_1
this.cb_3=create cb_3
this.st_sangtae=create st_sangtae
this.cb_1=create cb_1
this.dw_con=create dw_con
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.hpb_1
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.st_sangtae
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_con
this.Control[iCurrent+7]=this.r_1
end on

on w_dhwdr208a.destroy
call super::destroy
destroy(this.st_2)
destroy(this.hpb_1)
destroy(this.cb_3)
destroy(this.st_sangtae)
destroy(this.cb_1)
destroy(this.dw_con)
destroy(this.r_1)
end on

event open;call super::open;//idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   =  f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_dhwdr208a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_dhwdr208a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_dhwdr208a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_dhwdr208a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_dhwdr208a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_dhwdr208a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_dhwdr208a
end type

type uc_insert from w_no_condition_window`uc_insert within w_dhwdr208a
end type

type uc_delete from w_no_condition_window`uc_delete within w_dhwdr208a
end type

type uc_save from w_no_condition_window`uc_save within w_dhwdr208a
end type

type uc_excel from w_no_condition_window`uc_excel within w_dhwdr208a
end type

type uc_print from w_no_condition_window`uc_print within w_dhwdr208a
end type

type st_line1 from w_no_condition_window`st_line1 within w_dhwdr208a
end type

type st_line2 from w_no_condition_window`st_line2 within w_dhwdr208a
end type

type st_line3 from w_no_condition_window`st_line3 within w_dhwdr208a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_dhwdr208a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_dhwdr208a
end type

type gb_1 from w_no_condition_window`gb_1 within w_dhwdr208a
end type

type st_2 from statictext within w_dhwdr208a
integer x = 55
integer y = 300
integer width = 4379
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
string text = "가상계좌 생성관리"
alignment alignment = center!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_dhwdr208a
integer x = 992
integer y = 940
integer width = 2354
integer height = 96
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type cb_3 from commandbutton within w_dhwdr208a
integer x = 1563
integer y = 1180
integer width = 489
integer height = 120
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "최초 생성"
end type

event clicked;
//검색조건
string	ls_year, ls_hakgi, ls_hakjukbyendong
string	ls_chk, ll_count

long	ll_cnt, ll_rtn
	
dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
//ls_hakbun   	=	func.of_nvl(dw_con.Object.hakbun[1], '%')

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi)  then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 가상계좌를 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return

SELECT  HAKBUN
INTO	:ls_chk
FROM  HAKSA.D_GASANG
WHERE	YEAR		=		:ls_year
AND	HAKGI		=		:ls_hakgi
AND	ROWNUM	=	1
USING SQLCA ;

if sqlca.sqlcode = 0 then

	if messagebox("확인","이미 자료가 존재합니다! ~r~n 삭제후 재생성하시겠습니까?", Question!, YesNo!,2) = 2 then return
	
	DELETE FROM HAKSA.D_GASANG
	WHERE	YEAR		=		:ls_year
	AND	HAKGI		=		:ls_hakgi 
	USING SQLCA ;
		
	if sqlca.sqlcode <> 0 then
		messagebox("오류","이전자료 삭제중 오류발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
		
end if		

//Progress Bar Setting
SELECT	COUNT(HAKBUN)
INTO		:ll_count
FROM		HAKSA.D_DUNGROK
WHERE	YEAR		=		:ls_year
AND		HAKGI		=		:ls_hakgi
USING SQLCA ;

st_sangtae.text = '가상계좌 일괄생성중...'

SetPointer(HourGlass!)


////전체 및 처리건수 확인==========================
//SELECT  count(*)
//INTO   :ll_p_cnt
//FROM   IP_WONSEO
//WHERE  JONGBYUL_CODE = :ls_jongbyul
////AND   HAPGYUK_GUBUN = :ls_hapgyuk 
//;
//
//ls_p_cnt = string(ll_p_cnt) 
////================================================
//

INSERT 	INTO HAKSA.D_GASANG
SELECT	A.YEAR,
			A.HAKGI,
			A.HAKBUN,
			B.GASANG_NO,
			:gs_empcode,
			:gs_ip,
			SYSDATE,
			NULL,
			NULL,
			NULL			
FROM 		( 	SELECT 	YEAR,
							HAKGI,
							HAKBUN,
							ROWNUM RN
				FROM 		HAKSA.D_DUNGROK
				WHERE		YEAR		=		:ls_year
				AND		HAKGI		=		:ls_hakgi			
				ORDER BY HAKBUN ) A,
			(	SELECT  	GASANG_NO,
	 						ROWNUM 	RN
				FROM   	HAKSA.GASANG_GWANRI
				WHERE  	GUBUN = '2'
				AND	  	ORDER_SEQ > ( 	SELECT	NVL(MAX(A.ORDER_SEQ), 0)
												FROM 		HAKSA.GASANG_GWANRI 	A,
															HAKSA.D_GASANG			B
												WHERE		A.GASANG_NO	=	B.GASANG_NO
												AND		B.YEAR 	=	:ls_year 
												AND		B.HAKGI 	=	:ls_hakgi)
				ORDER BY ORDER_SEQ ) B
WHERE		A.RN	=B.RN
ORDER BY A.HAKBUN
USING SQLCA ;


if sqlca.sqlcode <> 0 then
 rollback USING SQLCA ;
 messagebox('가상계좌입력 오류!', '일괄처리를 실패하였습니다!', exclamation!)
 RETURN
END IF

COMMIT USING SQLCA;
MESSAGEBOX('확인!', '일괄처리를 완료하였습니다.( 처리건수: ' + ll_count + '건 )')

SetPointer(Arrow!)
st_sangtae.text = ''


end event

type st_sangtae from statictext within w_dhwdr208a
integer x = 1394
integer y = 836
integer width = 1650
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
long backcolor = 32500968
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_dhwdr208a
integer x = 2231
integer y = 1180
integer width = 645
integer height = 120
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "개인별 생성"
end type

event clicked;
//검색조건
string	ls_year, ls_hakgi, ls_hakbun
string	ls_chk, ll_count

long	ll_cnt, ll_rtn

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun   	=	dw_con.Object.hakbun[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi)  then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

if ls_hakbun =''or isnull(ls_hakbun) then
	messagebox('확인', "학번을 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("hakbun")
end if

if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 가상계좌를 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return

SELECT  	HAKBUN
INTO		:ls_chk
FROM  	HAKSA.D_GASANG
WHERE		YEAR		=	:ls_year
AND		HAKGI		=	:ls_hakgi
AND		HAKBUN	=  :ls_hakbun
AND		ROWNUM	=	1
USING SQLCA ;

if sqlca.sqlcode = 0 then

	if messagebox("확인","이미 자료가 존재합니다! ~r~n 삭제후 재생성하시겠습니까?", Question!, YesNo!,2) = 2 then return
	
	DELETE 	FROM HAKSA.D_GASANG
	WHERE		YEAR		=	:ls_year
	AND		HAKGI		=	:ls_hakgi
	AND		HAKBUN	=  :ls_hakbun
	USING SQLCA ;
		
	if sqlca.sqlcode <> 0 then
		messagebox("오류","이전자료 삭제중 오류발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
		
end if		

//Progress Bar Setting
SELECT	COUNT(HAKBUN)
INTO		:ll_count
FROM		HAKSA.D_DUNGROK
WHERE		YEAR		=	:ls_year
AND		HAKGI		=	:ls_hakgi
AND		HAKBUN	=  :ls_hakbun
USING SQLCA ;

st_sangtae.text = '가상계좌 일괄생성중...' 
//messagebox('ll_count', ll_count)

SetPointer(HourGlass!)


////전체 및 처리건수 확인==========================
//SELECT  count(*)
//INTO   :ll_p_cnt
//FROM   IP_WONSEO
//WHERE  JONGBYUL_CODE = :ls_jongbyul
////AND   HAPGYUK_GUBUN = :ls_hapgyuk 
//;
//
//ls_p_cnt = string(ll_p_cnt) 
////================================================
//

INSERT 	INTO HAKSA.D_GASANG
SELECT	A.YEAR,
			A.HAKGI,
			A.HAKBUN,
			B.GASANG_NO,
			:gs_empcode,
			:gs_ip,
			SYSDATE,
			NULL,
			NULL,
			NULL			
FROM 		( 	SELECT 	A.YEAR,
							A.HAKGI,
							A.HAKBUN,
							ROWNUM RN
				FROM 		HAKSA.D_DUNGROK		A,
							HAKSA.D_HAKJUK		B
				WHERE		A.HAKBUN		=	B.HAKBUN
				AND		A.YEAR		=	:ls_year
				AND		A.HAKGI		=	:ls_hakgi
				AND		B.HAKBUN 	=  :ls_hakbun		
				AND		A.WAN_YN 	= '0'
				ORDER BY A.HAKBUN ) A,
			(	SELECT  	GASANG_NO,
	 						ROWNUM 	RN
				FROM   	HAKSA.GASANG_GWANRI
				WHERE  	GUBUN = '2'
				AND	  	ORDER_SEQ > ( 	SELECT	NVL(MAX(A.ORDER_SEQ), 0)
												FROM 		HAKSA.GASANG_GWANRI 	A,
															HAKSA.D_GASANG			B
												WHERE		A.GASANG_NO	=	B.GASANG_NO
												AND		B.YEAR		=		:ls_year
												AND		B.HAKGI		=		:ls_hakgi)
				ORDER BY ORDER_SEQ ) B
WHERE		A.RN	=B.RN
ORDER BY A.HAKBUN
USING SQLCA ;

if sqlca.sqlcode <> 0 then
 rollback USING SQLCA ;
 messagebox('가상계좌입력 오류!', '일괄처리를 실패하였습니다!', exclamation!)
 RETURN
END IF

COMMIT USING SQLCA;
MESSAGEBOX('확인!', '일괄처리를 완료하였습니다.( 처리건수: ' + ll_count + '건 )')

SetPointer(Arrow!)
st_sangtae.text = ''
end event

type dw_con from uo_dwfree within w_dhwdr208a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwdr208a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type r_1 from rectangle within w_dhwdr208a
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 31577551
integer x = 722
integer y = 620
integer width = 2898
integer height = 960
end type

