$PBExportHeader$w_dhwju106a.srw
$PBExportComments$[대학원졸업] 졸업대상자 사정처리
forward
global type w_dhwju106a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwju106a
end type
type st_cnt from statictext within w_dhwju106a
end type
type dw_con from uo_dwfree within w_dhwju106a
end type
type uo_1 from uo_imgbtn within w_dhwju106a
end type
end forward

global type w_dhwju106a from w_condition_window
dw_main dw_main
st_cnt st_cnt
dw_con dw_con
uo_1 uo_1
end type
global w_dhwju106a w_dhwju106a

on w_dhwju106a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.st_cnt=create st_cnt
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.st_cnt
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_1
end on

on w_dhwju106a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.st_cnt)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event open;call super::open;string	ls_hakgi, ls_year

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi 
end event

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_hakbun
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","학기를 선택하세요")
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

event ue_save;int li_ans

dw_main.accepttext()

li_ans = dw_main.update()
					
if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback using sqlca ;
else	
	commit using sqlca ;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwju106a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwju106a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwju106a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwju106a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwju106a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwju106a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwju106a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwju106a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwju106a
end type

type uc_save from w_condition_window`uc_save within w_dhwju106a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwju106a
end type

type uc_print from w_condition_window`uc_print within w_dhwju106a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwju106a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwju106a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwju106a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwju106a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwju106a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwju106a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwju106a
end type

type dw_main from uo_input_dwc within w_dhwju106a
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dhwju106a"
end type

event itemchanged;call super::itemchanged;string ls_gwajung, ls_hakgwa, ls_hname

CHOOSE CASE	DWO.NAME
	//학번이 입력되면 기본사항을 가져온다.
	CASE	'd_nonmun_simsa_hakbun'
		
		SELECT	GWAJUNG_ID,
					GWA_ID,
					HNAME
		INTO	:ls_gwajung,
				:ls_hakgwa,
				:ls_hname
		FROM	HAKSA.D_HAKJUK
		WHERE	HAKBUN	=	:data	;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","잘못된 학번입니다.")
			this.object.d_nonmun_simsa_hakbun[row]	=	''
			return 1
			
		else
			this.object.d_hakjuk_hname[row]			=	ls_hname
			this.object.d_hakjuk_gwajung_id[row]	=	ls_gwajung
			this.object.d_hakjuk_gwa_id[row]			=	ls_hakgwa
			
		end if

END CHOOSE
		
end event

event itemerror;call super::itemerror;return 2
end event

type st_cnt from statictext within w_dhwju106a
integer x = 1019
integer y = 44
integer width = 453
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "count"
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_dhwju106a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dhwju106a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_dhwju106a
integer x = 640
integer y = 40
integer width = 329
integer taborder = 70
boolean bringtotop = true
string btnname = "사정처리"
end type

event clicked;call super::clicked;/***************************************************************************************************************
	- 졸업대상자 사정처리
	
	이수학점이 졸업가능학점보다 크고, 필수학점을 반드시 이수해야 하고, 
	평점이 3.0이상, 종합시험합격, 논문 합격자
****************************************************************************************************************/

string	ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_jonghap, ls_nonmun, ls_sunsu, ls_panjung
double	ld_pyengjum
long	ll_line, ll_jol_hakjum, ll_isu_hakjum, ll_sunsu_hakjum, ll_pilsu_hakjum, ll_non_hakjum
long	ll_tot, i
int	li_cnt, li_nonmun, li_prof_no

if messagebox("확인","졸업 사정처리를 실행하시겠습니까?",Question!, YesNo!, 2) = 2 then return

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","학기를 선택하세요")
	return 
end if

SetPointer(HourGlass!)

SELECT COUNT(*)
INTO :ll_tot
FROM	HAKSA.D_JOLUP_SAJUNG
WHERE	YEAR	= :ls_year
AND	HAKGI	= :ls_hakgi 
USING SQLCA ;

DECLARE CUR_SAJUNG CURSOR FOR
SELECT	B.GWAJUNG_ID,		A.HAKBUN,			A.JOL_HAKJUM,		A.ISU_HAKJUM,	A.PILSU_HAKJUM,
			A.SUNSU_HAKJUM,	A.PYENGJUM_AVG,	A.NONMUN_HAKJUM,	A.JONGHAP,		A.NONMUN,	
			B.SUNSU_YN	
FROM	HAKSA.D_JOLUP_SAJUNG	A,
		HAKSA.D_HAKJUK			B
WHERE	A.HAKBUN	=	B.HAKBUN
AND	A.YEAR	= :ls_year
AND	A.HAKGI	= :ls_hakgi 
USING SQLCA ;
		
OPEN CUR_SAJUNG;
DO
	FETCH	CUR_SAJUNG
	INTO	:ls_gwajung,		:ls_hakbun,		:ll_jol_hakjum,	:ll_isu_hakjum,	:ll_pilsu_hakjum,
			:ll_sunsu_hakjum,	:ld_pyengjum,	:ll_non_hakjum,	:ls_jonghap,		:ls_nonmun,
			:ls_sunsu			;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
		
	//졸업 사정
	CHOOSE CASE ls_gwajung
		CASE '1'					//석사과정		
			//선수과정자는 선수학점을 체크함.
			if ls_sunsu = '1' then
				if ll_isu_hakjum >= ll_jol_hakjum	and	ld_pyengjum >= 3.0	and	 ll_pilsu_hakjum >= 6	and &
					((ls_jonghap = '1' and ls_nonmun = '1') or ll_non_hakjum >= 6 )	and ll_sunsu_hakjum >= 6 then
					
					ls_panjung = '1'
				else
					ls_panjung = ''
				end if
			else
				
				if ll_isu_hakjum >= ll_jol_hakjum	and	ld_pyengjum >= 3.0	and	 ll_pilsu_hakjum >= 6	and &
					((ls_jonghap = '1' and ls_nonmun = '1') or ll_non_hakjum >= 6 )	then
					
					ls_panjung = '1' 
				else
					ls_panjung = ''
				end if
			end if
			
		CASE '5'					//연구과정(연구생은 졸업이 없고 수료만 존재함.)
			if ll_isu_hakjum >= ll_jol_hakjum then
				ls_panjung = '1'
			else
				ls_panjung = '0'
			end if
			
	END CHOOSE
	
	UPDATE	HAKSA.D_JOLUP_SAJUNG
	SET	PANJUNG	=	:ls_panjung
	WHERE YEAR		=	:ls_year
	AND	HAKGI		=	:ls_hakgi
	AND	HAKBUN	=	:ls_hakbun
	USING SQLCA ;

	if sqlca.sqlcode <> 0 then
		messagebox("오류","졸업사정중 오류가 발생되었습니다.~r~n" + Sqlca.SqlErrText)
		return
	end if
	
	i = i + 1
	st_cnt.text = string(i) + ' / ' + string(ll_tot)
	
LOOP WHILE TRUE
CLOSE CUR_SAJUNG ;

COMMIT USING SQLCA ;
SetPointer(Arrow!)

messagebox("확인","작업이 완료되었습니다.")
dw_main.retrieve(ls_year, ls_hakgi)

end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

