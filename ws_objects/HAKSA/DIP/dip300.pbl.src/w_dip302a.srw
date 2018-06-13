$PBExportHeader$w_dip302a.srw
$PBExportComments$[대학원입시] 순위부여
forward
global type w_dip302a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dip302a
end type
type dw_con from uo_dwfree within w_dip302a
end type
type uo_1 from uo_imgbtn within w_dip302a
end type
end forward

global type w_dip302a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_dip302a w_dip302a

on w_dip302a.create
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

on w_dip302a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_mojip, ls_jongbyul, ls_gyeyul   
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_mojip  	=	dw_con.Object.mojip_id[1]
ls_jongbyul 	=	func.of_nvl(dw_con.Object.jongbyul_id[1], '%') + '%'
ls_gyeyul 	=	func.of_nvl(dw_con.Object.gyeyul_id[1], '%') + '%'

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

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_mojip, ls_jongbyul, ls_gyeyul)

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

type ln_templeft from w_condition_window`ln_templeft within w_dip302a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dip302a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dip302a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dip302a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dip302a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dip302a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dip302a
end type

type uc_insert from w_condition_window`uc_insert within w_dip302a
end type

type uc_delete from w_condition_window`uc_delete within w_dip302a
end type

type uc_save from w_condition_window`uc_save within w_dip302a
end type

type uc_excel from w_condition_window`uc_excel within w_dip302a
end type

type uc_print from w_condition_window`uc_print within w_dip302a
end type

type st_line1 from w_condition_window`st_line1 within w_dip302a
end type

type st_line2 from w_condition_window`st_line2 within w_dip302a
end type

type st_line3 from w_condition_window`st_line3 within w_dip302a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dip302a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dip302a
end type

type gb_1 from w_condition_window`gb_1 within w_dip302a
end type

type gb_2 from w_condition_window`gb_2 within w_dip302a
end type

type dw_main from uo_input_dwc within w_dip302a
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dip302a"
end type

type dw_con from uo_dwfree within w_dip302a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 210
boolean bringtotop = true
string dataobject = "d_dip302a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_dip302a
integer x = 631
integer y = 40
integer width = 434
integer taborder = 20
boolean bringtotop = true
string btnname = "석차부여"
end type

event clicked;call super::clicked;/////////--------------------- 방법 1 : DW를 이용하여 sort한 뒤 순위부여 ----------------------------------------------

string	ls_year, ls_hakgi, ls_mojip, ls_jongbyul
string	ls_pre_jongbyul, ls_pre_gwajung, ls_pre_gyeyul_id
long		ll_rtn, m, n, i, ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_mojip  	=	dw_con.Object.mojip_id[1]
ls_jongbyul 	=	func.of_nvl(dw_con.Object.jongbyul_id[1], '%') + '%'

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

IF MESSAGEBOX("확인",ls_mojip + "에 대한 석차를 부여 하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

SetPointer(HourGlass!)

ll_rtn = dw_main.retrieve(ls_year, ls_hakgi, ls_mojip, ls_jongbyul, '%')

if ll_rtn <= 0 then
	messagebox("오류","자료가 존재하지 않습니다.")
	return
end if

//전체석차 부여 - 종별, 과정별 순위부여
dw_main.setsort("jongbyul_id a, gwajung_id a, jumsu d, jumin_no a")   
dw_main.sort()
for i =1 to dw_main.rowcount()
	if dw_main.object.jongbyul_id[i]	= ls_pre_jongbyul	and &
		dw_main.object.gwajung_id[i]	= ls_pre_gwajung	then
		
		m = m + 1

	else
		m = 1
		
	end if
	
	//순위 set
	dw_main.object.tot_sunwi[i] = m
	
	ls_pre_jongbyul	=	dw_main.object.jongbyul_id[i]
	ls_pre_gwajung	=	dw_main.object.gwajung_id[i]
	
	
next


//전체석차부여을 위해 변수 초기하
ls_pre_jongbyul	=	''
ls_pre_gwajung	=	''
m = 0

//과별석차 부여 - 종별, 과정별, 학과별 순위부여   2008학년도까지만 과별석차
//계열석차 부여 - 종별, 과정별, 계열별 순위부여   2009학년도부터는 게열석차
dw_main.setsort("jongbyul_id a, gwajung_id a, gyeyul_id a, jumsu d, jumin_no a")   
dw_main.sort()
for i =1 to dw_main.rowcount()
	if dw_main.object.jongbyul_id[i]	= ls_pre_jongbyul	and &
		dw_main.object.gwajung_id[i]	= ls_pre_gwajung	and &
		dw_main.object.gyeyul_id[i]	= ls_pre_gyeyul_id	then
		
		m = m + 1

	else
		m = 1
		
	end if
	
	//순위 set
	dw_main.object.gwa_sunwi[i] = m
	
	ls_pre_jongbyul	=	dw_main.object.jongbyul_id[i]
	ls_pre_gwajung	=	dw_main.object.gwajung_id[i]
	ls_pre_gyeyul_id	=	dw_main.object.gyeyul_id[i]
	
next

dw_main.AcceptText( )
ll_ans = dw_main.update()         //자료의 저장

IF ll_ans = -1  THEN
	uf_messagebox(3)            //저장오류 메세지 출력
	ROLLBACK USING SQLCA;
ELSE
	commit using sqlca ;
	messagebox("확인","성적처리가 완료되었습니다.")

end IF

SetPointer(Arrow!)



////////////////-------------------------- 방법 2 : Oracle RANK()함수 이용 ------------------------
//string	ls_year, ls_hakgi, ls_mojip, ls_jongbyul, ls_gwajung, ls_hakgwa
//
//ls_year		=	uo_1.em_1.text
//ls_hakgi		=	uo_1.ddlb_1.text
//ls_mojip		=	uo_1.dw_1.gettext()
//ls_jongbyul	=	uo_1.dw_1.gettext() + '%'
//
//IF MESSAGEBOX("확인",ls_year + "년도 " + ls_hakgi + " 학기 사정처리를 하시겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN
//
//SetPointer(HourGlass!)
//
//
//전체 석차
//DECLARE CUR_SAJUNG_T	CURSOR FOR
//SELECT	DISTINCT JONGBYUL_ID, GWAJUNG_ID
//FROM	DIPSI.DI_WONSEO
//WHERE	YEAR		=	:ls_year	
//AND	HAKGI		=	:ls_hakgi
//AND	MOJIP_ID	=	:ls_mojip	;
//
//OPEN CUR_SAJUNG_T	;
//DO
//	FETCH CUR_SAJUNG_T	INTO 	:ls_jongbyul, :ls_gwajung ;
//
//	IF SQLCA.SQLCODE <> 0 THEN EXIT
//		
//	UPDATE	DIPSI.DI_WONSEO	B
//	SET	TOT_SUNWI	=	(	SELECT	A.SUKCHA
//									FROM	(	SELECT	HAKBUN,
//															RANK() OVER (ORDER BY JUMSU DESC, JUMIN_NO ASC ) AS SUKCHA
//												FROM	DIPSI.DI_WONSEO
//												WHERE	YEAR			=	:ls_year
//												AND	HAKGI			=	:ls_hakgi
//												AND	MOJIP_ID		=	:ls_mojip
//												AND	JONGBYUL_ID	=	:ls_jongbyul
//												AND	GWAJUNG_ID	=	:ls_gwajung
//												AND	MYUNJUP_JUMSU	<> 'F'
//											)	A	
//									WHERE	A.HAKBUN	=	B.HAKBUN
//	WHERE	YEAR			=	:ls_year
//	AND	HAKGI			=	:ls_hakgi
//	AND	MOJIP_ID		=	:ls_mojip
//	AND	JONGBYUL_ID	=	:ls_jongbyul
//	AND	GWAJUNG_ID	=	:ls_gwajung
//	AND	MYUNJUP_JUMSU	<> 'F';
//	
//	
//	if sqlca.sqlcode <> 0 then
//		messagebox("오류","성적사정중 오류발생~r~n" + sqlca.sqlerrtext)
//		return
//	end if
//	
//LOOP WHILE TRUE
//CLOSE CUR_SAJUNG_T	;
//
//COMMIT ;
//
//
//
//과별 석차
//DECLARE CUR_SAJUNG_GWA	CURSOR FOR
//SELECT	DISTINCT GWA_ID,	JONGBYUL_ID, GWAJUNG_ID
//FROM	DIPSI.DI_WONSEO
//WHERE	YEAR		=	:ls_year	
//AND	HAKGI		=	:ls_hakgi
//AND	MOJIP_ID	=	:ls_mojip	;
//
//OPEN CUR_SAJUNG_GWA	;
//DO
//	FETCH CUR_SAJUNG_GWA	INTO 	:ls_hakgwa, :ls_jongbyul, :ls_gwajung	;
//
//	IF SQLCA.SQLCODE <> 0 THEN EXIT
//		
//	UPDATE	DIPSI.DI_WONSEO	B
//	SET	TOT_SUNWI	=	(	SELECT	A.SUKCHA
//									FROM	(	SELECT	HAKBUN,
//															RANK() OVER (ORDER BY JUMSU DESC, JUMIN_NO ASC ) AS SUKCHA
//												FROM	DIPSI.DI_WONSEO
//												WHERE	YEAR			=	:ls_year
//												AND	HAKGI			=	:ls_hakgi
//												AND	MOJIP_ID		=	:ls_mojip
//												AND	JONGBYUL_ID	=	:ls_jongbyul
//												AND	GWAJUNG_ID	=	:ls_gwajung
//												AND	GWA_ID		=	:ls_hakgwa												
//												AND	MYUNJUP_JUMSU	<> 'F'
//											)	A	
//									WHERE	A.HAKBUN	=	B.HAKBUN
//	WHERE	YEAR			=	:ls_year
//	AND	HAKGI			=	:ls_hakgi
//	AND	MOJIP_ID		=	:ls_mojip
//	AND	JONGBYUL		=	:ls_jongbyul	
//	AND	GWAJUNG_ID	=	:ls_gwajung
//	AND	GA_ID			=	:ls_hakgwa
//	AND	MYUNJUP_JUMSU	<> 'F'		;
//		
//	if sqlca.sqlcode <> 0 then
//		messagebox("오류","성적사정중 오류발생~r~n" + sqlca.sqlerrtext)
//		return
//	end if
//	
//LOOP WHILE TRUE
//CLOSE CUR_SAJUNG_GWA	;
//
//COMMIT ;
//SetPointer(Arrow!)
//MESSAGEBOX("확인","작업이 완료되었습니다.")
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

