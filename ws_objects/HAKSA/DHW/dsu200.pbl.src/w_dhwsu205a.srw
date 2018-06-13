$PBExportHeader$w_dhwsu205a.srw
$PBExportComments$[대학원수업] 보관용성적수정
forward
global type w_dhwsu205a from w_condition_window
end type
type dw_con from uo_dwfree within w_dhwsu205a
end type
type st_hakjuk from statictext within w_dhwsu205a
end type
type dw_main from uo_dwfree within w_dhwsu205a
end type
end forward

global type w_dhwsu205a from w_condition_window
dw_con dw_con
st_hakjuk st_hakjuk
dw_main dw_main
end type
global w_dhwsu205a w_dhwsu205a

on w_dhwsu205a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.st_hakjuk=create st_hakjuk
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.st_hakjuk
this.Control[iCurrent+3]=this.dw_main
end on

on w_dhwsu205a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.st_hakjuk)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_hakbun, ls_year, ls_hakgi, ls_gwa_name, ls_jungong_name, ls_hakgicha, ls_name
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  dw_con.Object.hakbun[1]

SELECT	A.HNAME,		B.GWA_HNAME,	C.JUNGONG_HNAME,	A.S_HAKGICHA
INTO		:ls_name,	:ls_gwa_name,	:ls_jungong_name,	:ls_hakgicha
FROM	HAKSA.d_HAKJUK			A,
		HAKSA.D_GWA_CODE		B,
		HAKSA.D_JUNGONG_CODE	C
WHERE	A.GWA_ID			=	b.GWA_ID		
AND	A.JUNGONG_ID	=	C.JUNGONG_ID
AND	A.hakbun			=	:ls_hakbun 
USING SQLCA ;

//재학생이 아니면 졸업생테이블에서 검색한다.		
if sqlca.sqlcode = 0 then
	dw_main.dataobject = 'd_dhwsu205a_1'
	dw_main.SetTransObject(Sqlca)
else
	SELECT	A.HNAME,		B.GWA_HNAME,	C.JUNGONG_HNAME,	A.S_HAKGICHA
	INTO		:ls_name,	:ls_gwa_name,	:ls_jungong_name,	:ls_hakgicha
	FROM	 HAKSA.d_HAKJUK_jolup	A,
			 HAKSA.D_GWA_CODE		B,
			 HAKSA.D_JUNGONG_CODE	C
	WHERE	A.GWA_ID			=	b.GWA_ID		
	AND	A.JUNGONG_ID	=	C.JUNGONG_ID
	AND	A.hakbun			=	:ls_hakbun 
	USING SQLCA ;
	
	dw_main.SetTransObject(Sqlca)
	
	if sqlca.sqlcode = 0 then
		dw_main.dataobject = 'd_dhwsu205a_2'
		dw_main.SetTransObject(Sqlca)
	else
		messagebox("오류","잘못된 학번입니다.")
		dw_con.SetFocus()
		dw_con.SetColumn("hakbun")
		return -1
	end if
	
end if

st_hakjuk.text =  ls_name + ' ' + ls_gwa_name + ' ' + ls_jungong_name + ' ' + ls_hakgicha

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1

end event

event ue_save;// 변경된 점수대로 Sugang Table을 변경하고  Sungjukgye Table도 같이 Update함.
int li_ans, li_ans1
long  ll_pass_hakjum, ll_pass_gwamok, ll_modifiedcount
double ld_pyengjum_tot, ld_pyengjum_avg, ld_hwansan_tot, ld_hwansan_avg
string  ls_name, ls_year, ls_hakgi, ls_hakbun

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  dw_con.Object.hakbun[1]

dw_main.AcceptText()

ll_modifiedcount = dw_main.modifiedcount()              //수정된 행의 갯수

if ll_modifiedcount > 0 then 
	
	ll_pass_gwamok		= dw_main.object.pass_gwamok[1]
	ll_pass_hakjum		= dw_main.object.pass_hakjum[1]
	ld_pyengjum_tot	= dw_main.object.pyengjum_tot[1]
	ld_pyengjum_avg	= dw_main.object.pyengjum_avg[1]
	ld_hwansan_tot		= dw_main.object.hwansan_tot[1]
	ld_hwansan_avg		= dw_main.object.hwansan_avg[1]
		
   wf_upd_date_set()
	
   li_ans = dw_main.update()        //자료의 저장
	
   IF li_ans = -1  THEN
	   uf_messagebox(3)            //저장오류 메세지 출력
      ROLLBACK USING SQLCA ;
   ELSE
			
		 UPDATE HAKSA.D_SUNGJUKGYE  
			SET PASS_HAKJUM	= :ll_pass_hakjum,
				 PASS_GWAMOK	= :ll_pass_gwamok,
				 PYENGJUM_TOT	= :ld_pyengjum_tot,   
				 PYENGJUM_AVG	= :ld_pyengjum_avg,   
				 HWANSAN_TOT	= :ld_hwansan_tot,   
				 HWANSAN_AVG	= :ld_hwansan_avg  
		 WHERE ( HAKBUN	= :ls_hakbun ) AND  
				 ( YEAR		= :ls_year ) AND  
				 ( HAKGI		= :ls_hakgi ) 
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then		
			commit USING SQLCA ;
			messagebox("확인","작업이 완료되었습니다.")
			
		else
			messagebox("오류","성적계 수정오류~r~n" + SQLCA.SQLERRTEXT)
			rollback USING SQLCA ;
			
		end if
	END IF
end if

Return 1
end event

event open;call super::open;string	ls_hakgi, ls_year

idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
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

type ln_templeft from w_condition_window`ln_templeft within w_dhwsu205a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwsu205a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwsu205a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwsu205a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwsu205a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwsu205a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwsu205a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwsu205a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwsu205a
end type

type uc_save from w_condition_window`uc_save within w_dhwsu205a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwsu205a
end type

type uc_print from w_condition_window`uc_print within w_dhwsu205a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwsu205a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwsu205a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwsu205a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwsu205a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwsu205a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwsu205a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwsu205a
end type

type dw_con from uo_dwfree within w_dhwsu205a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dhwsu204a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_hakjuk from statictext within w_dhwsu205a
integer x = 91
integer y = 52
integer width = 1659
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 32500968
boolean focusrectangle = false
end type

type dw_main from uo_dwfree within w_dhwsu205a
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dhwsu205a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;double ld_jumsu, ld_jumsu_tot, ld_pyengjum, ld_hakjum
string ls_hwansan

IF dwo.name = 'jumsu' THEN
	
	ld_jumsu_tot	=	double(data)
	ld_hakjum		=	this.object.hakjum[row]
	
	//해당 점수별 부여가능 점수를 체크한다.
	if ld_jumsu_tot > 100 then
		
		setnull(ld_jumsu_tot)
		messagebox("오류","100점을 초과할 수 없습니다.")
		this.object.jumsu[row] = ld_jumsu_tot
		return 1
	end if
		
	if ld_jumsu_tot <= 100 and ld_jumsu_tot >= 95 then
		ld_pyengjum	= 4.5 * ld_hakjum
		ls_hwansan	= 'A+'
	elseif ld_jumsu_tot < 95 and ld_jumsu_tot >= 90 then
		ld_pyengjum = 4.0 * ld_hakjum
		ls_hwansan	= 'A'
	elseif ld_jumsu_tot < 90 and ld_jumsu_tot >= 85 then
		ld_pyengjum = 3.5 * ld_hakjum
		ls_hwansan	= 'B+'
	elseif ld_jumsu_tot < 85 and ld_jumsu_tot >= 80 then
		ld_pyengjum = 3.0 * ld_hakjum
		ls_hwansan	= 'B'
	elseif ld_jumsu_tot < 80 and ld_jumsu_tot >= 75 then
		ld_pyengjum = 2.5 * ld_hakjum
		ls_hwansan	= 'C+'
	elseif ld_jumsu_tot < 75 and ld_jumsu_tot >= 70 then
		ld_pyengjum = 2.0 * ld_hakjum
		ls_hwansan	= 'C'
	elseif ld_jumsu_tot < 70 and ld_jumsu_tot >= 0 then
		ld_pyengjum = 0.0
		ls_hwansan	= 'F'
	end if
	//넣기.

	this.object.pyengjum[row]	= ld_pyengjum
	this.object.hwansan[row]	= ls_hwansan
	this.object.jumsu[row]		= ld_jumsu_tot
	
END IF
end event

event itemerror;call super::itemerror;return 2
end event

