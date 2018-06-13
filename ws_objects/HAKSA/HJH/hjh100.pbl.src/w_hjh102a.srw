$PBExportHeader$w_hjh102a.srw
$PBExportComments$[청운대]장학생생성관리
forward
global type w_hjh102a from w_condition_window
end type
type st_1 from statictext within w_hjh102a
end type
type st_2 from statictext within w_hjh102a
end type
type dw_janghak_model from uo_dddw_dwc within w_hjh102a
end type
type st_6 from statictext within w_hjh102a
end type
type dw_5 from datawindow within w_hjh102a
end type
type dw_con from uo_dwfree within w_hjh102a
end type
type uo_1 from uo_imgbtn within w_hjh102a
end type
type uo_2 from uo_imgbtn within w_hjh102a
end type
type uo_3 from uo_imgbtn within w_hjh102a
end type
type uo_4 from uo_imgbtn within w_hjh102a
end type
type uo_5 from uo_imgbtn within w_hjh102a
end type
type uo_6 from uo_imgbtn within w_hjh102a
end type
type dw_1 from uo_dwfree within w_hjh102a
end type
type dw_2 from uo_dwfree within w_hjh102a
end type
end forward

global type w_hjh102a from w_condition_window
st_1 st_1
st_2 st_2
dw_janghak_model dw_janghak_model
st_6 st_6
dw_5 dw_5
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
uo_4 uo_4
uo_5 uo_5
uo_6 uo_6
dw_1 dw_1
dw_2 dw_2
end type
global w_hjh102a w_hjh102a

type variables
string is_hakgwa, is_hakyun, is_hakgi
Int    is_ii
datawindowchild idwc_model
end variables

forward prototypes
public function integer f_bohun_process_tmt ()
public function integer f_iphak_bohun1_tmt (string as_hakyun, string as_gwa, integer as_sukcha)
public function integer f_iphak_bohun_tmt (string as_hakyun, string as_gwa, integer as_sukcha)
end prototypes

public function integer f_bohun_process_tmt ();string ls_year,  ls_hakgi,  ls_tyear, ls_thakgi
int    l_cnt,    l_cnt1

ls_tyear		= f_haksa_iljung_year()
ls_thakgi 	= f_haksa_iljung_hakgi() 

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

/* 보훈장학생 성적생성 여부 체크 */
SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM HAKSA.JAEHAK_HAKJUK A,
		( 	SELECT A.HAKBUN,
					 A.AVG_PYENGJUM,
					 B.HAKGI
			  FROM HAKSA.SUNGJUKGYE A,
				    (SELECT HAKBUN,
								TO_CHAR(COUNT(HAKGI))HAKGI
						 FROM HAKSA.SUNGJUKGYE
						WHERE hakgi in('1', '2')
						GROUP BY HAKBUN) B
			 WHERE A.HAKBUN = B.HAKBUN
			   AND A.YEAR 	 = :ls_tyear
				AND A.HAKGI  = :ls_thakgi
				AND A.AVG_PYENGJUM > 2.0) B
 WHERE A.HAKBUN   = B.HAKBUN
	AND A.BOHUN_ID IS NOT NULL
	AND A.SANGTAE  = '01'
	AND NVL(A.BOHUN_HAKGI,0) >= B.HAKGI
 USING SQLCA ;
IF sqlca.sqlnrows = 0 THEN
	l_cnt          = 0
END IF

SELECT nvl(count(*), 0)
  INTO :l_cnt1
  FROM haksa.janghak_gwanri
 WHERE year       = :ls_year
   AND hakgi      = :ls_hakgi
	AND janghak_id IN('I11', 'O01', 'O02')
 USING SQLCA ;
IF sqlca.sqlnrows = 0 THEN
	l_cnt1         = 0
END IF
IF l_cnt          > 0 THEN
	IF l_cnt1      = 0 THEN
		messagebox("알림", '보훈장학생 생성 후 작업하시기 바랍니다.')
		return -1
	END IF
END IF

IF ls_year  + ls_hakgi  >= '20062' THEN
	l_cnt1      = 0
	SELECT nvl(count(*), 0)
	  INTO :l_cnt1
	  FROM haksa.janghak_gwanri
	 WHERE year       = :ls_year
		AND hakgi      = :ls_hakgi
		AND janghak_id IN('I50', 'I51', 'I54', 'I55', 'I62')
	 USING SQLCA ;
	IF sqlca.sqlnrows = 0 THEN
		l_cnt1         = 0
	END IF
	IF l_cnt1         = 0 THEN
		if messagebox("알림",ls_year + "년도 " + ls_hakgi + "학기 입학성적 장학생 생성 하셨습니까?", Question!, YesNo!, 2) = 2 then 	return -1
	END IF
END IF

return 0
end function

public function integer f_iphak_bohun1_tmt (string as_hakyun, string as_gwa, integer as_sukcha);string ls_year,  ls_hakgi,  ls_tyear, ls_thakgi,  ls_hakbun,  ls_hname,  ls_gwa
int    l_cnt,    l_cnt1,    l_cnt2

ls_tyear		= f_haksa_iljung_year()
ls_thakgi 	= f_haksa_iljung_hakgi() 

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

SELECT A.HAKBUN,   B.HNAME,    B.gwa
  INTO :ls_hakbun, :ls_hname,  :ls_gwa
  FROM HAKSA.SUNGJUKGYE A,
       HAKSA.JAEHAK_HAKJUK	B
 WHERE A.HAKBUN		= B.HAKBUN
   AND A.YEAR 			= :ls_tyear
   AND A.HAKGI			= :ls_thakgi
   AND B.SU_HAKYUN 	= :as_hakyun
   AND A.GWA 	 		= :as_gwa
   AND A.JH_SUKCHA 	= :as_sukcha
 USING SQLCA ;
						
/* 보훈장학생 또는 입학성적장학생 여부 체크 */
SELECT nvl(count(*), 0)
  INTO :l_cnt1
  FROM haksa.janghak_gwanri
 WHERE year       = :ls_year
   AND hakgi      = :ls_hakgi
	AND hakbun     = :ls_hakbun
	AND janghak_id IN('I11', 'O01', 'O02')
 USING SQLCA ;
IF sqlca.sqlnrows = 0 THEN
	l_cnt1         = 0
END IF
SELECT nvl(count(*), 0)
  INTO :l_cnt2
  FROM haksa.janghak_gwanri
 WHERE year       = :ls_year
   AND hakgi      = :ls_hakgi
	AND hakbun     = :ls_hakbun
	AND janghak_id IN('I50', 'I51', 'I54', 'I55', 'I62')
 USING SQLCA ;
IF sqlca.sqlnrows = 0 THEN
	l_cnt2         = 0
END IF

IF l_cnt1         > 0 THEN
	dw_5.InsertRow(0)
	is_ii     = is_ii + 1
	dw_5.setItem(is_ii, 'hakbun', ls_hakbun)
	dw_5.setItem(is_ii, 'hname',  ls_hname)
	dw_5.setItem(is_ii, 'hakyun', as_hakyun)
	dw_5.setItem(is_ii, 'gwa',    ls_gwa)
	dw_5.setItem(is_ii, 'bigo',   '보훈장학생')
	return -1
ELSEIF l_cnt2     > 0 THEN
	dw_5.InsertRow(0)
	is_ii     = is_ii + 1
	dw_5.setItem(is_ii, 'hakbun', ls_hakbun)
	dw_5.setItem(is_ii, 'hname',  ls_hname)
	dw_5.setItem(is_ii, 'hakyun', as_hakyun)
	dw_5.setItem(is_ii, 'gwa',    ls_gwa)
	dw_5.setItem(is_ii, 'bigo',   '입학성적 장학생')
	return -1
END IF

return 0
end function

public function integer f_iphak_bohun_tmt (string as_hakyun, string as_gwa, integer as_sukcha);string ls_year,  ls_hakgi,  ls_tyear, ls_thakgi,  ls_hakbun,  ls_hname,  ls_gwa
int    l_cnt,    l_cnt1,    l_cnt2

ls_tyear		= f_haksa_iljung_year()
ls_thakgi 	= f_haksa_iljung_hakgi() 

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

SELECT A.HAKBUN,   B.HNAME,    B.gwa
  INTO :ls_hakbun, :ls_hname,  :ls_gwa
  FROM HAKSA.SUNGJUKGYE A,
       HAKSA.JAEHAK_HAKJUK	B
 WHERE A.HAKBUN		= B.HAKBUN
   AND A.YEAR 			= :ls_tyear
   AND A.HAKGI			= :ls_thakgi
   AND B.SU_HAKYUN 	= :as_hakyun
   AND A.GWA 	 		= :as_gwa
   AND A.JH_SUKCHA 	= :as_sukcha
 USING SQLCA ;
						
/* 보훈장학생 또는 입학성적장학생, 지방인문계장학 여부 체크 */
SELECT nvl(count(*), 0)
  INTO :l_cnt1
  FROM haksa.janghak_gwanri
 WHERE year       = :ls_year
   AND hakgi      = :ls_hakgi
	AND hakbun     = :ls_hakbun
	AND janghak_id IN('I11', 'O01', 'O02')
 USING SQLCA ;
IF sqlca.sqlnrows = 0 THEN
	l_cnt1         = 0
END IF

SELECT nvl(count(*), 0)
  INTO :l_cnt2
  FROM haksa.janghak_gwanri
 WHERE year       = :ls_year
   AND hakgi      = :ls_hakgi
	AND hakbun     = :ls_hakbun
	AND janghak_id IN('I50', 'I51', 'I54', 'I55', 'I62')
 USING SQLCA ;
IF sqlca.sqlnrows = 0 THEN
	l_cnt2         = 0
END IF

IF l_cnt1         > 0 THEN
	dw_5.InsertRow(0)
	is_ii     = is_ii + 1
	dw_5.setItem(is_ii, 'hakbun', ls_hakbun)
	dw_5.setItem(is_ii, 'hname',  ls_hname)
	dw_5.setItem(is_ii, 'hakyun', as_hakyun)
	dw_5.setItem(is_ii, 'gwa',    ls_gwa)
	dw_5.setItem(is_ii, 'bigo',   '보훈장학생')
	return -1
ELSEIF l_cnt2     > 0 THEN
	dw_5.InsertRow(0)
	is_ii     = is_ii + 1
	dw_5.setItem(is_ii, 'hakbun', ls_hakbun)
	dw_5.setItem(is_ii, 'hname',  ls_hname)
	dw_5.setItem(is_ii, 'hakyun', as_hakyun)
	dw_5.setItem(is_ii, 'gwa',    ls_gwa)
	dw_5.setItem(is_ii, 'bigo',   '입학성적 장학생')
	return -1
END IF

return 0
end function

on w_hjh102a.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.dw_janghak_model=create dw_janghak_model
this.st_6=create st_6
this.dw_5=create dw_5
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
this.uo_4=create uo_4
this.uo_5=create uo_5
this.uo_6=create uo_6
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_janghak_model
this.Control[iCurrent+4]=this.st_6
this.Control[iCurrent+5]=this.dw_5
this.Control[iCurrent+6]=this.dw_con
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.uo_2
this.Control[iCurrent+9]=this.uo_3
this.Control[iCurrent+10]=this.uo_4
this.Control[iCurrent+11]=this.uo_5
this.Control[iCurrent+12]=this.uo_6
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.dw_2
end on

on w_hjh102a.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_janghak_model)
destroy(this.st_6)
destroy(this.dw_5)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.uo_4)
destroy(this.uo_5)
destroy(this.uo_6)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event ue_retrieve;int		li_row
string 	ls_hakbun,& 
			ls_hakyun,&
			ls_gwa,	 &
			ls_janghak,&
			ls_year,	 &
			ls_hakgi	 

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_hakbun   =  func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_janghak	= dw_janghak_model.gettext() + '%'

li_row = dw_2.retrieve(ls_gwa, ls_hakyun, ls_hakbun)

dw_1.retrieve(ls_year, ls_hakgi, ls_hakyun, ls_hakbun, ls_gwa, ls_janghak)

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_1.setfocus()

Return 1

end event

event ue_delete;int	li_ans1	,&
		li_ans2
string ls_hakbun
long ll_row

li_ans1 = uf_messagebox(4)		//	삭제확인 메세지 출력

IF li_ans1 = 1 THEN
	ll_row = dw_1.getrow()
	
	dw_1.deleterow(0)          //	현재 행을 삭제
	li_ans2 = dw_1.update()    //	삭제된 내용을 저장
	
	IF li_ans2 = -1 THEN
		ROLLBACK USING SQLCA;     
		uf_messagebox(6)        //	삭제오류 메세지 출력
	END IF
END IF

dw_1.setfocus()
end event

event open;call super::open;idw_print = dw_1

dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
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

type ln_templeft from w_condition_window`ln_templeft within w_hjh102a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh102a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh102a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh102a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh102a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh102a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh102a
end type

type uc_insert from w_condition_window`uc_insert within w_hjh102a
end type

type uc_delete from w_condition_window`uc_delete within w_hjh102a
end type

type uc_save from w_condition_window`uc_save within w_hjh102a
end type

type uc_excel from w_condition_window`uc_excel within w_hjh102a
end type

type uc_print from w_condition_window`uc_print within w_hjh102a
end type

type st_line1 from w_condition_window`st_line1 within w_hjh102a
end type

type st_line2 from w_condition_window`st_line2 within w_hjh102a
end type

type st_line3 from w_condition_window`st_line3 within w_hjh102a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh102a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh102a
end type

type gb_1 from w_condition_window`gb_1 within w_hjh102a
integer y = 1032
end type

type gb_2 from w_condition_window`gb_2 within w_hjh102a
integer y = 1128
end type

type st_1 from statictext within w_hjh102a
integer x = 50
integer y = 600
integer width = 937
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 15793151
long backcolor = 8388736
string text = "장학대상자선정"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_hjh102a
integer x = 1006
integer y = 296
integer width = 3429
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 15793151
long backcolor = 8388736
string text = "장학생생성"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_janghak_model from uo_dddw_dwc within w_hjh102a
integer x = 146
integer y = 388
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_list_jhmodel"
end type

type st_6 from statictext within w_hjh102a
integer x = 50
integer y = 304
integer width = 919
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32896
long backcolor = 12639424
string text = "장 학 모 델 선 택"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_5 from datawindow within w_hjh102a
boolean visible = false
integer x = 1079
integer y = 376
integer width = 2153
integer height = 1720
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "성적장학제외대상"
string dataobject = "d_hjh107a_2"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;CHOOSE CASE dwo.name
	CASE 'b_1'
		dw_5.print()
	CASE 'b_2'
		dw_5.visible = false
END CHOOSE
end event

type dw_con from uo_dwfree within w_hjh102a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_hjh102a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjh102a
event destroy ( )
integer x = 55
integer y = 40
integer width = 622
integer taborder = 60
boolean bringtotop = true
string btnname = "성적장학생제외내역"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;dw_5.visible = true
end event

type uo_2 from uo_imgbtn within w_hjh102a
event destroy ( )
integer x = 800
integer y = 40
integer width = 850
integer taborder = 70
boolean bringtotop = true
string btnname = "외국,산업특별,위탁,혜전 일괄"
end type

on uo_2.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string	ls_ilja, ls_year, ls_hakgi, ls_hakyun, ls_janghak, ls_result
string	ls_hakbun, ls_gwa, ls_max, ls_jhname, ls_shakbun, ls_hakgwa, ls_shakyun
string	ls_inout_gubun, ls_jigup_gubun
integer  li_row, li_ans, li_count
long		ll_row, ll_i, ll_gitagum

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakgwa	=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_shakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_shakbun  =  func.of_nvl(dw_con.Object.hakbun[1], '%')

//장학모델을 선택하여 장학금에 관한것을 가져온다.
ls_janghak = dw_janghak_model.gettext()

if (ls_janghak = 'I15' OR ls_janghak = 'I29' OR ls_janghak = 'I60' OR ls_janghak = 'I61') THEN
else
	messagebox("확인","혜전장학(I15), 외국인 유학장학(I29), 산업체위탁(I60), 특별(I61) 장학만 생성할수 있습니다.")
	return		
end if		

CHOOSE CASE ls_janghak
	
	CASE ''
		messagebox("확인","해당하는 장학코드를 선택하여주십시요!")
		dw_janghak_model.setfocus()
	CASE 'I15'
		li_ans = messagebox(	"경고", "혜전출신장학 일괄선택을 하였습니다.~r~n"  + &
									"2009학번 이후의 혜전대학출신(편입학)~r~n"  + &
									"장학을 생성하시겠습니까?", Exclamation!, OKCancel!, 1)

		IF li_ans = 2 THEN
			dw_janghak_model.setfocus()		
			return

		END IF		
	CASE 'I29'
		li_ans = messagebox(	"경고", "외국인 유학장학 일괄선택을 하였습니다.~r~n"  + &
									"2006학번의 외국인 유학생은 개별생성하셔야 합니다.~r~n"  + &
									"장학을 생성하시겠습니까?", Exclamation!, OKCancel!, 1)

		IF li_ans = 2 THEN
			dw_janghak_model.setfocus()		
			return

		END IF
	CASE 'I60'
		li_ans = messagebox(	"확인","산업체위탁 장학을 생성하시겠습니까?", Exclamation!, OKCancel!, 1)

		IF li_ans = 2 THEN
			dw_janghak_model.setfocus()		
			return

		END IF
	CASE 'I61'
		li_ans = messagebox(	"확인","산업체특별 장학을 생성하시겠습니까?", Exclamation!, OKCancel!, 1)

		IF li_ans = 2 THEN
			dw_janghak_model.setfocus()		
			return

		END IF			
	
END CHOOSE	
	


CHOOSE CASE ls_janghak
//2009학년도 이후 편입학자중 혜전대학 출신장학(I15), 실질적인 장학생을 장학생관리 테이블에 입력하여준다.
CASE	 'I15'
	
		//자료체크
		SELECT	COUNT(B.HAKBUN)
		INTO		:li_count
		FROM		HAKSA.JAEHAK_HAKJUK	A,
					HAKSA.JANGHAK_GWANRI	B
		WHERE		A.HAKBUN		=	B.HAKBUN
		AND		SUBSTR(A.IPHAK_DATE, 1, 4)		>=	'2009'
		AND		A.HAKBUN	like :ls_shakbun
		AND		B.YEAR	=	:ls_year
		AND		B.HAKGI	=	:ls_hakgi
		AND		B.JANGHAK_ID=	'I15'
		USING SQLCA ;
		
		if li_count > 0 then
			if messagebox('확인!', '혜전대학 출신장학을 삭제하시겠습니까?', QUESTION!, YESNO!, 2) = 2 THEN return
		end if
		
		DELETE FROM	HAKSA.JANGHAK_GWANRI
		WHERE		YEAR	=	:ls_year
		AND		HAKGI	=	:ls_hakgi
		AND		HAKBUN	like :ls_shakbun
		AND		JANGHAK_ID=	'I15'	
		AND		SUBSTR(HAKBUN, 1, 4) >= '2009'
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			rollback;
			messagebox('확인!', '혜전대학 출신장학 자료삭제를 실패하였습니다!')
			return
		end if


		//혜전대학 출신장학 입력 시작
		INSERT INTO HAKSA.JANGHAK_GWANRI
	(		SELECT	A.HAKBUN,
						B.YEAR,
						B.HAKGI,
						A.GWA,
						A.SU_HAKYUN,
						'I15'			JANGHAK_ID,
						TO_CHAR(SYSDATE,'YYYYMMDD')	SUNBAL_DATE,
						(TMT_HAKGI_DUNGROK * 0.2)		GITAGUM,
						NULL									GITAGUM_IPHAK,
						NULL,
						:gs_empcode,
						:gs_ip,
						SYSDATE,
						NULL,
						NULL,
						NULL,
						NULL
			FROM		HAKSA.JAEHAK_HAKJUK	A,
						HAKSA.DUNGROK_MODEL	B
			WHERE		A.GWA	=	B.GWA
			AND		A.DR_HAKYUN	=	B.HAKYUN
			AND		A.HAKBUN		NOT IN (	SELECT	DISTINCT Z.HAKBUN
													FROM 		HAKSA.JANGHAK_GWANRI	Z
													WHERE		Z.YEAR    = :ls_year
													AND 		Z.HAKGI   = :ls_hakgi
													AND		Z.JANGHAK_ID IN('I01','I02','I03','I04','I11','O01','O02','I50','I51','I54','I55','I61','I62','O34','O36')) 
			AND		SUBSTR(A.IPHAK_DATE, 1, 4)		>=	'2009'	
			AND		A.COLLEGE_NAME LIKE '혜%전%'
			AND		A.IPHAK_JUNHYUNG	=	'12'
			AND		B.YEAR	=	:ls_year
			AND		B.HAKGI	=	:ls_hakgi
			AND		A.HAKBUN	like :ls_shakbun
		) USING SQLCA ;
		
		SetPointer(Arrow!)
		
		if sqlca.sqlcode = 0 then
			commit USING SQLCA ;
			messagebox("확인","혜전대학 출신장학 생성이 완료되었습니다.")
			
		else
			messagebox("오류","혜전대학 출신장학생성중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
			
		end if	
//외국인 유학장학(I29), 실질적인 장학생을 장학생관리 테이블에 입력하여준다.		
CASE	 'I29'
	
		//자료체크
		SELECT	COUNT(B.HAKBUN)
		INTO		:li_count
		FROM		HAKSA.JAEHAK_HAKJUK	A,
					HAKSA.JANGHAK_GWANRI	B
		WHERE		A.HAKBUN		=	B.HAKBUN
		AND		SUBSTR(A.IPHAK_DATE, 1, 4)		>=	'2007'	
		AND		A.IPHAK_JUNHYUNG	=	'06'
		AND		B.YEAR	=	:ls_year
		AND		B.HAKGI	=	:ls_hakgi
		AND		A.HAKBUN	like :ls_shakbun
		AND		B.JANGHAK_ID=	'I29'
		USING SQLCA ;
		
		if li_count > 0 then
			if messagebox('확인!', '외국인유학생장학을 삭제하시겠습니까?', QUESTION!, YESNO!, 2) = 2 THEN return
		end if
		
		DELETE FROM	HAKSA.JANGHAK_GWANRI
		WHERE		YEAR	=	:ls_year
		AND		HAKGI	=	:ls_hakgi
		AND		HAKBUN	like :ls_shakbun
		AND		JANGHAK_ID=	'I29'	
		AND		SUBSTR(HAKBUN, 1, 4) >= '2007'
		USING SQLCA ;
		if sqlca.sqlcode <> 0 then
			rollback;
			messagebox('확인!', '장학자료삭제를 실패하였습니다!')
			return
		end if


		//외국인 유학장학생 입력 시작
		INSERT INTO HAKSA.JANGHAK_GWANRI
	(		SELECT	A.HAKBUN,
						B.YEAR,
						B.HAKGI,
						A.GWA,
						A.SU_HAKYUN,
						'I29'			JANGHAK_ID,
						TO_CHAR(SYSDATE,'YYYYMMDD')	SUNBAL_DATE,
						(TMT_HAKGI_DUNGROK * 0.4)		GITAGUM,
						NULL									GITAGUM_IPHAK,
						NULL,
						:gs_empcode,
						:gs_ip,
						SYSDATE,
						NULL,
						NULL,
						NULL,
						NULL
			FROM		HAKSA.JAEHAK_HAKJUK	A,
						HAKSA.DUNGROK_MODEL	B
			WHERE		A.GWA	=	B.GWA
			AND		A.DR_HAKYUN	=	B.HAKYUN
			AND		A.HAKBUN		NOT IN (	SELECT	DISTINCT Z.HAKBUN
													FROM 		HAKSA.JANGHAK_GWANRI	Z
													WHERE		Z.YEAR    = :ls_year
													AND 		Z.HAKGI   = :ls_hakgi
													AND		Z.JANGHAK_ID IN('I01','I02','I03','I04','I11','O01','O02','I50','I51','I54','I55','I61','I62','O34','O36')) 
			AND		SUBSTR(A.IPHAK_DATE, 1, 4)		>=	'2007'	
			AND		A.IPHAK_JUNHYUNG	=	'06'
			AND		B.YEAR	=	:ls_year
			AND		B.HAKGI	=	:ls_hakgi
			AND		A.HAKBUN	like :ls_shakbun
		)	USING SQLCA ;
		
		SetPointer(Arrow!)
		
		if sqlca.sqlcode = 0 then
			commit USING SQLCA ;
			messagebox("확인","외국인 유학생 장학생성이 완료되었습니다.")
			
		else
			messagebox("오류","외국인 유학생 장학생성중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
			
		end if			

//편입학자중 산업체 특별장학(I61), 실질적인 장학생을 장학생관리 테이블에 입력하여준다.
CASE	 'I61'
	
		//자료체크
		SELECT	COUNT(B.HAKBUN)
		INTO		:li_count
		FROM		HAKSA.JAEHAK_HAKJUK	A,
					HAKSA.JANGHAK_GWANRI	B
		WHERE		A.HAKBUN		=	B.HAKBUN
		AND		SUBSTR(A.IPHAK_DATE, 1, 4)		>=	'2008'	
		AND		A.IPHAK_JUNHYUNG	=	'07'
		AND		B.YEAR	=	:ls_year
		AND		B.HAKGI	=	:ls_hakgi
		AND		A.HAKBUN	like :ls_shakbun
		AND		B.JANGHAK_ID=	'I61'
		USING SQLCA ;
		
		if li_count > 0 then
			if messagebox('확인!', '산업체특별장학을 삭제하시겠습니까?', QUESTION!, YESNO!, 2) = 2 THEN return
		end if
		
		DELETE FROM	HAKSA.JANGHAK_GWANRI
		WHERE		YEAR	=	:ls_year
		AND		HAKGI	=	:ls_hakgi
		AND		HAKBUN	like :ls_shakbun
		AND		JANGHAK_ID=	'I61'	
		AND		SUBSTR(HAKBUN, 1, 4) >= '2008'
		USING SQLCA ;
		if sqlca.sqlcode <> 0 then
			rollback;
			messagebox('확인!', '산업체특별장학 자료삭제를 실패하였습니다!')
			return
		end if


		//산업체특별장학 입력 시작
		INSERT INTO HAKSA.JANGHAK_GWANRI
	(		SELECT	A.HAKBUN,
						B.YEAR,
						B.HAKGI,
						A.GWA,
						A.SU_HAKYUN,
						'I61'			JANGHAK_ID,
						TO_CHAR(SYSDATE,'YYYYMMDD')	SUNBAL_DATE,
						(TMT_HAKGI_DUNGROK * 0.2)		GITAGUM,
						NULL									GITAGUM_IPHAK,
						NULL,
						:gs_empcode,
						:gs_ip,
						SYSDATE,
						NULL,
						NULL,
						NULL,
						NULL
			FROM		HAKSA.JAEHAK_HAKJUK	A,
						HAKSA.DUNGROK_MODEL	B
			WHERE		A.GWA	=	B.GWA
			AND		A.DR_HAKYUN	=	B.HAKYUN
			AND		A.HAKBUN		NOT IN (	SELECT	DISTINCT Z.HAKBUN
													FROM 		HAKSA.JANGHAK_GWANRI	Z
													WHERE		Z.YEAR    = :ls_year
													AND 		Z.HAKGI   = :ls_hakgi
													AND		Z.JANGHAK_ID IN('I01','I02','I03','I04','I11', 'O01', 'O02', 'I50', 'I51', 'I54', 'I55', 'I62')) 
			AND		SUBSTR(A.IPHAK_DATE, 1, 4)		>=	'2008'	
			AND		A.IPHAK_JUNHYUNG	=	'07'
			AND		B.YEAR	=	:ls_year
			AND		B.HAKGI	=	:ls_hakgi
			AND		A.HAKBUN	like :ls_shakbun
		) USING SQLCA ;
		
		SetPointer(Arrow!)
		
		if sqlca.sqlcode = 0 then
			commit USING SQLCA ;
			messagebox("확인","산업체특별 장학생성이 완료되었습니다.")
			
		else
			messagebox("오류","산업체특별 장학생성중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
			
		end if			

//산업체 위탁장학(I60), 실질적인 장학생을 장학생관리 테이블에 입력하여준다.
CASE	 'I60'
	
		//자료체크
		SELECT	COUNT(B.HAKBUN)
		INTO		:li_count
		FROM		HAKSA.JAEHAK_HAKJUK	A,
					HAKSA.JANGHAK_GWANRI	B
		WHERE		A.HAKBUN		=	B.HAKBUN
		AND		SUBSTR(A.IPHAK_DATE, 1, 4)		>=	'2008'	
		AND		A.IPHAK_JUNHYUNG	=	'17'
		AND		B.YEAR	=	:ls_year
		AND		B.HAKGI	=	:ls_hakgi
		AND		A.HAKBUN	like :ls_shakbun
		AND		B.JANGHAK_ID=	'I60'
		USING SQLCA ;
		
		if li_count > 0 then
			if messagebox('확인!', '산업체 위탁장학을 삭제하시겠습니까?', QUESTION!, YESNO!, 2) = 2 THEN return
		end if
		
		DELETE FROM	HAKSA.JANGHAK_GWANRI
		WHERE		YEAR	=	:ls_year
		AND		HAKGI	=	:ls_hakgi
		AND		HAKBUN	like :ls_shakbun
		AND		JANGHAK_ID=	'I60'	
		AND		SUBSTR(HAKBUN, 1, 4) >= '2008'
		USING SQLCA ;
		if sqlca.sqlcode <> 0 then
			rollback USING SQLCA ;
			messagebox('확인!', '산업체 위탁장학 자료삭제를 실패하였습니다!')
			return
		end if


		//산업체 위탁장학 입력 시작
		INSERT INTO HAKSA.JANGHAK_GWANRI
	(		SELECT	A.HAKBUN,
						B.YEAR,
						B.HAKGI,
						A.GWA,
						A.SU_HAKYUN,
						'I60'			JANGHAK_ID,
						TO_CHAR(SYSDATE,'YYYYMMDD')	SUNBAL_DATE,
						(TMT_HAKGI_DUNGROK - 2600000)		GITAGUM,
						NULL									GITAGUM_IPHAK,
						NULL,
						:gs_empcode,
						:gs_ip,
						SYSDATE,
						NULL,
						NULL,
						NULL,
						NULL
			FROM		HAKSA.JAEHAK_HAKJUK	A,
						HAKSA.DUNGROK_MODEL	B
			WHERE		A.GWA	=	B.GWA
			AND		A.DR_HAKYUN	=	B.HAKYUN
			AND		A.HAKBUN		NOT IN (	SELECT	DISTINCT Z.HAKBUN
													FROM 		HAKSA.JANGHAK_GWANRI	Z
													WHERE		Z.YEAR    = :ls_year
													AND 		Z.HAKGI   = :ls_hakgi
													AND		Z.JANGHAK_ID IN('I11', 'O01', 'O02', 'I50', 'I51', 'I54', 'I55', 'I62')) 
			AND		SUBSTR(A.IPHAK_DATE, 1, 4)		>=	'2008'	
			AND		A.IPHAK_JUNHYUNG	=	'17'
			AND		B.YEAR	=	:ls_year
			AND		B.HAKGI	=	:ls_hakgi
			AND		A.HAKBUN	like :ls_shakbun
		)	USING SQLCA ;
		
		SetPointer(Arrow!)
		
		if sqlca.sqlcode = 0 then
			commit USING SQLCA ;
			messagebox("확인","산업체 위탁 장학생성이 완료되었습니다.")
			
		else
			messagebox("오류","산업체 위탁 장학생성중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
			
		end if	

END CHOOSE

dw_2.reset()
dw_2.retrieve(ls_hakgwa, ls_shakyun, ls_shakbun)

li_row = dw_1.retrieve(ls_year, ls_hakgi, '%', '%', '%', ls_janghak )
if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

end event

type uo_3 from uo_imgbtn within w_hjh102a
event destroy ( )
integer x = 1870
integer y = 40
integer width = 558
integer taborder = 70
boolean bringtotop = true
string btnname = "성적장학생생성"
end type

on uo_3.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string	ls_year	, ls_hakgi,	ls_hakyun, ls_gwa, ls_gwa1, ls_hakyun1, ls_max, ls_tyear, ls_thakgi
long		ll_woosu1, ll_woosu2, ll_woosu3,	ll_woosu4, ll_su, ll_i, ll_iphak, ll_hakjum,	ll_dungrok
integer 	li_sukcha, l_cnt,    l_cnt1,    li_chk

// 성적계를 적용을 위한 현년도 학기를 가져온다.
ls_tyear		= f_haksa_iljung_year()
ls_thakgi 	= f_haksa_iljung_hakgi() 

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year = '' or ls_hakgi ='' or isnull(ls_year) or isnull(ls_hakgi) then
	messagebox( '확인', "학년도와 학기를 반드시 입력하세요.")
	return
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')

setpointer(hourglass!)

/* 보훈장학생 성적생성 여부 체크(토마토) */
li_chk     = f_bohun_process_tmt()
IF li_chk <> 0 THEN
	return
END IF

dw_5.Settransobject(sqlca)
dw_5.reset()
is_ii      = 0

DECLARE	LC_JH_BAEJUNG CURSOR FOR
		SELECT	GWA,
					HAKYUN,
					WOOSU_A,
					WOOSU_B,
					WOOSU_C,
					WOOSU_D,
					HAKSENG_SU
		FROM		HAKSA.JANGHAK_BAEJUNG
		WHERE		YEAR	= :ls_year
		and		HAKGI	= :ls_hakgi
		and		HAKYUN	like :ls_hakyun
		and		GWA	like :ls_gwa
		USING SQLCA ;	  

OPEN LC_JH_BAEJUNG;
DO
FETCH LC_JH_BAEJUNG INTO :ls_gwa1, :ls_hakyun1, :ll_woosu1, :ll_woosu2, :ll_woosu3, :ll_woosu4, :ll_su;

	IF sqlca.sqlcode <> 0 then EXIT
	
	if ll_woosu1 <> 0 then

		FOR ll_i = 1 to ll_woosu1
			
			li_sukcha = li_sukcha + 1

//			2004.01.09 진급되는 학년도의 학기에 학년이 수업학년(진급된)으로 처리 해야됨
//			INSERT INTO HAKSA.JANGHAK_GWANRI
//				(		SELECT 	HAKBUN, :ls_year, :ls_hakgi, GWA, HAKYUN, 'I01', TO_CHAR(SYSDATE, 'YYYYMMDD'), '', '', '', '', '', '', '', ''
//						FROM		HAKSA.SUNGJUKGYE
//						WHERE		YEAR 		= :ls_tyear
//						and		HAKGI		= :ls_thakgi
//						and		HAKYUN 	= :ls_hakyun1
//						and		GWA 	 	= :ls_gwa1
//						and		JH_SUKCHA = :li_sukcha
//				);

       /* 보훈이나 입학성적 장학생 여부 체크(토마토) */
       li_chk  = 0
       li_chk  = f_iphak_bohun_tmt(ls_hakyun1, ls_gwa1, li_sukcha)
		 IF li_chk    <> 0 THEN			
//			 messagebox("알림", ls_hakyun1 + '의 학번은 보훈이나 입학 성적장학생이므로 해당 과수석에 대한 자료를 생성하지 않습니다.')
		 ELSE
			INSERT INTO HAKSA.JANGHAK_GWANRI
				(		SELECT 	A.HAKBUN, :ls_year, :ls_hakgi, A.GWA, B.SU_HAKYUN, 'I01', TO_CHAR(SYSDATE, 'YYYYMMDD'), '', '', '', '', '', '', '', '', '', ''
						FROM		HAKSA.SUNGJUKGYE 		A,
									HAKSA.JAEHAK_HAKJUK	B
						WHERE		A.HAKBUN			= B.HAKBUN
						AND		A.YEAR 			= :ls_tyear
						and		A.HAKGI			= :ls_thakgi
						and		B.SU_HAKYUN 	= :ls_hakyun1
						and		A.GWA 	 		= :ls_gwa1
						and		A.JH_SUKCHA 	= :li_sukcha
				) USING SQLCA ;				
		 END IF
		 
		 
		next
	end if
	
	if ll_woosu2 <> 0 then
	
		FOR ll_i = 1 to ll_woosu2
		
		li_sukcha = li_sukcha + 1
		
       /* 보훈이나 입학성적 장학생 여부 체크(토마토) */
       li_chk  = 0
       li_chk  = f_iphak_bohun_tmt(ls_hakyun1, ls_gwa1, li_sukcha)
		 IF li_chk    <> 0 THEN
//			 messagebox("알림", ls_hakyun1 + '의 학번은 보훈이나 입학 성적장학생이므로 해당 성적A에 대한 자료를 생성하지 않습니다.')
		 ELSE
		    INSERT INTO HAKSA.JANGHAK_GWANRI
			    (		SELECT 	A.HAKBUN, :ls_year, :ls_hakgi, A.GWA, B.SU_HAKYUN, 'I02', TO_CHAR(SYSDATE, 'YYYYMMDD'), '', '', '', '', '', '', '', '', '', ''
					     FROM	HAKSA.SUNGJUKGYE 		A,
							   	HAKSA.JAEHAK_HAKJUK	B
    					 WHERE	A.HAKBUN			= B.HAKBUN
					      AND	A.YEAR 			= :ls_tyear
					      and	A.HAKGI			= :ls_thakgi
					      and	B.SU_HAKYUN 	= :ls_hakyun1
					      and	A.GWA 	 		= :ls_gwa1
					      and	A.JH_SUKCHA 	= :li_sukcha	) USING SQLCA ;
		 END IF
		 
		 
		next
	end if
	
	if ll_woosu3 <> 0 then

		FOR ll_i = 1 to ll_woosu3
			
			li_sukcha = li_sukcha + 1
			
       /* 보훈이나 입학성적 장학생 여부 체크(토마토) */
       li_chk  = 0
       li_chk  = f_iphak_bohun1_tmt(ls_hakyun1, ls_gwa1, li_sukcha)
		 IF li_chk    <> 0 THEN
//			 messagebox("알림", ls_hakyun1 + '의 학번은 보훈이나 입학 성적장학생이므로 해당 성적B에 대한 자료를 생성하지 않습니다.')
		 ELSE
			
			INSERT INTO HAKSA.JANGHAK_GWANRI
				(	SELECT	A.HAKBUN, :ls_year, :ls_hakgi, A.GWA, B.SU_HAKYUN, 'I03', TO_CHAR(SYSDATE, 'YYYYMMDD'), '', '', '', '', '', '', '', '', '', ''
					FROM		HAKSA.SUNGJUKGYE 		A,
								HAKSA.JAEHAK_HAKJUK	B
					WHERE		A.HAKBUN			= B.HAKBUN
					AND		A.YEAR 			= :ls_tyear
					and		A.HAKGI			= :ls_thakgi
					and		B.SU_HAKYUN 	= :ls_hakyun1
					and		A.GWA 	 		= :ls_gwa1
					and		A.JH_SUKCHA 	= :li_sukcha	) USING SQLCA ;
		 END IF
		 

		next
	end if

	if ll_woosu4 <> 0 then

		FOR ll_i = 1 to ll_woosu4
	
			li_sukcha = li_sukcha + 1

       /* 보훈이나 입학성적 장학생 여부 체크(토마토) */
       li_chk  = 0
       li_chk  = f_iphak_bohun1_tmt(ls_hakyun1, ls_gwa1, li_sukcha)
		 IF li_chk    <> 0 THEN
//			 messagebox("알림", ls_hakyun1 + '의 학번은 보훈이나 입학 성적장학생이므로 해당 성적C에 대한 자료를 생성하지 않습니다.')
		 ELSE

			INSERT INTO HAKSA.JANGHAK_GWANRI
				(	SELECT 	A.HAKBUN, :ls_year, :ls_hakgi, A.GWA, B.SU_HAKYUN, 'I04', TO_CHAR(SYSDATE, 'YYYYMMDD'), '', '', '', '', '', '', '', '', '', ''
					FROM		HAKSA.SUNGJUKGYE 		A,
								HAKSA.JAEHAK_HAKJUK	B
					WHERE		A.HAKBUN			= B.HAKBUN
					AND		A.YEAR 			= :ls_tyear
					and		A.HAKGI			= :ls_thakgi
					and		B.SU_HAKYUN 	= :ls_hakyun1
					and		A.GWA 	 		= :ls_gwa1
					and		A.JH_SUKCHA 	= :li_sukcha	) USING SQLCA ;
		 END IF
		 

		next
	end if

	li_sukcha = 0
	
LOOP WHILE TRUE;
CLOSE LC_JH_BAEJUNG;

COMMIT;

IF is_ii     > 0 THEN
	dw_5.visible  = true
	uo_1.visible  = true
ELSE
	dw_5.visible  = false
	uo_1.visible  = false
END IF

Messagebox("확인", "성적장학생생성 완료", Information!, Ok!)	
setpointer(ARROW!)	

parent.triggerevent("ue_retrieve")
end event

type uo_4 from uo_imgbtn within w_hjh102a
event destroy ( )
integer x = 2496
integer y = 40
integer width = 558
integer taborder = 50
boolean bringtotop = true
string btnname = "보훈장학생생성"
end type

on uo_4.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string	ls_year, ls_hakgi,	ls_hakyun, ls_gwa, ls_sayu, ls_hakbun, ls_janghak, ls_tyear, ls_thakgi

//성적계산을 위한 학년도, 학기를 가져온다.
ls_tyear 	= f_haksa_iljung_year()
ls_thakgi	= f_haksa_iljung_hakgi()
						
dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year = '' or ls_hakgi ='' or isnull(ls_year) or isnull(ls_hakgi) then
	messagebox( '확인', "학년도와 학기를 반드시 입력하세요.")
	return
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if
setpointer(HourGlass!)

DECLARE	LC_BOHUNJH CURSOR FOR
	SELECT	A.HAKBUN,
				A.SU_HAKYUN,
				A.GWA,
				A.BOHUN_GUBUN
	FROM 		HAKSA.JAEHAK_HAKJUK A,
				( 	SELECT  	A.HAKBUN,
								A.AVG_PYENGJUM,
								B.HAKGI
					FROM		HAKSA.SUNGJUKGYE A,
								(	SELECT 	HAKBUN,
												TO_CHAR(COUNT(HAKGI))HAKGI
									FROM		HAKSA.SUNGJUKGYE
									where hakgi in('1', '2')
									GROUP BY HAKBUN
								)B
					WHERE		A.HAKBUN = B.HAKBUN
					AND		A.YEAR 	= :ls_tyear
					AND		A.HAKGI 	= :ls_thakgi
					AND		A.AVG_PYENGJUM > 2.0
				)B
	WHERE		A.HAKBUN = B.HAKBUN
	AND		A.BOHUN_ID IS NOT NULL
	AND		A.SANGTAE = '01'
	AND		NVL(A.BOHUN_HAKGI,0) >= B.HAKGI
	USING SQLCA ;

OPEN LC_BOHUNJH;
DO
FETCH LC_BOHUNJH INTO :ls_hakbun, :ls_hakyun, :ls_gwa, :ls_sayu;

	IF sqlca.sqlcode <> 0 then EXIT
	
	if ls_sayu  = '1' then
		ls_janghak = 'I11'
	elseif ls_sayu  = '2' then
		ls_janghak = 'O01'
	else	
		ls_janghak = 'O02'
	end if

	INSERT INTO HAKSA.JANGHAK_GWANRI
		(	HAKBUN, YEAR, HAKGI, GWA, HAKYUN, JANGHAK_ID, SUNBAL_DATE	
		)
	VALUES
		(	:ls_hakbun, :ls_year, :ls_hakgi, :ls_gwa, :ls_hakyun, :ls_janghak, to_char(sysdate, 'yyyymmdd')
		) USING SQLCA ;
		
	IF SQLCA.SQLCODE <> 0 THEN
		MESSAGEBOX('확인', "오류가 발생하였습니다.~R~N" + SQLCA.SQLERRTEXT)
		RETURN
	END IF
	
LOOP WHILE TRUE;
CLOSE LC_BOHUNJH;

COMMIT USING SQLCA ;

setpointer(Arrow!)
Messagebox("확인", "보훈장학생 생성이 완료되었습니다.", Information!, Ok!)


parent.triggerevent("ue_retrieve")
end event

type uo_5 from uo_imgbtn within w_hjh102a
integer x = 37
integer y = 488
integer width = 457
integer taborder = 20
boolean bringtotop = true
string btnname = "장학생 생성"
end type

event clicked;call super::clicked;string	ls_ilja, ls_year, ls_hakgi, ls_hakyun, ls_janghak, ls_result
string	ls_hakbun, ls_gwa, ls_max, ls_jhname, ls_shakbun, ls_hakgwa, ls_shakyun
string	ls_inout_gubun, ls_jigup_gubun
integer  li_row, li_ans, li_count
long		ll_row, ll_i, ll_gitagum


ll_row = dw_2.rowcount()

if ll_row >= 1 then 
	
	SetPointer(HourGlass!)
	
	dw_con.AcceptText()

	ls_year		=	dw_con.Object.year[1]
	ls_hakgi		=	dw_con.Object.hakgi[1]
	ls_hakgwa	=	func.of_nvl(dw_con.Object.gwa[1], '%')
	ls_shakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
	ls_shakbun  =  func.of_nvl(dw_con.Object.hakbun[1], '%')
	
//장학모델을 선택하여 장학금에 관한것을 가져온다.
	ls_janghak = dw_janghak_model.gettext()
		
	CHOOSE CASE ls_janghak
		
		CASE ''
			messagebox("확인","해당하는 장학코드를 선택하여주십시요!")
			dw_janghak_model.setfocus()
		CASE 'I50','I51','I54','I55'
			messagebox("확인","입학성적 관련 장학생성은 할 수 없습니다.")
			return
		CASE 'I01','I02','I03','I04'
			li_ans = messagebox(	"경고", "해당장학코드는 신입생장학에만 사용됩니다.~r~n"  + &
										"재학생은 성적장학생성 버튼을 활용하세요.~r~n"  + &
										"장학을 생성하시겠습니까?", Exclamation!, OKCancel!, 1)

			IF li_ans = 2 THEN
				dw_janghak_model.setfocus()		
				return

			END IF
		
	END CHOOSE	
		
//실질적인 장학생을 장학생관리 테이블에 입력하여준다.

CHOOSE CASE MID(TRIM(ls_janghak),1,1)
	CASE	 'O'
			FOR ll_i = 1 TO ll_row
				
				ls_result = dw_2.object.janghak_yn[ll_i]
				ls_gwa	 = dw_2.object.gwa[ll_i]
				
				IF ls_result = '1' THEN
					
					ls_hakbun	= dw_2.object.hakbun[ll_i]
					ls_hakyun 	= dw_2.object.su_hakyun[ll_i]
					
					SELECT	COUNT(*)
					INTO  	:li_count
					FROM		HAKSA.JANGHAK_GWANRI
					WHERE		HAKBUN	= :ls_hakbun
					AND		YEAR		= :ls_year
					AND		HAKGI		= :ls_hakgi
					AND		SUBSTR(JANGHAK_ID,1,1)	= SUBSTR(:ls_janghak,1,1)
					USING SQLCA	;
					
					SELECT	JANGHAK_NAME
					INTO  	:ls_jhname
					FROM		HAKSA.JANGHAK_GWANRI A, HAKSA.JANGHAK_CODE B
					WHERE		A.HAKBUN			= :ls_hakbun
					AND		A.YEAR			= :ls_year
					AND		A.HAKGI			= :ls_hakgi
					AND		A.JANGHAK_ID 	= B.JANGHAK_ID
					USING SQLCA	;
					
					if li_count > 0 then
						IF messagebox('확인', ls_jhname + "을 이미 받은 학생입니다.", Question!, YesNo!, 2) = 2 then
					  return
					 	end if
					end if
					
					SELECT 	B.GITAGUM
					INTO		:ll_gitagum
					FROM		HAKSA.JANGHAK_MODEL B
					WHERE		B.YEAR		= :ls_year
					AND		B.HAKGI		= :ls_hakgi
					AND		B.JANGHAK_ID	= :ls_janghak
					USING SQLCA	;
					
					//장학해당학생의 장학을 생성한다.
						INSERT INTO HAKSA.JANGHAK_GWANRI  
								( 		HAKBUN,   
										YEAR,   
										HAKYUN,
										HAKGI,
										GWA,
										JANGHAK_ID,
										GITAGUM,
										SUNBAL_DATE
								)  
						VALUES 
								( 		:ls_hakbun, 
										:ls_year,
										:ls_hakyun,     
										:ls_hakgi,
										:ls_gwa,
										:ls_janghak,
										:ll_gitagum,										
										TO_CHAR(SYSDATE,'YYYYMMDD')
								) USING SQLCA	;
								
						if sqlca.sqlcode <> 0 then
							rollback USING SQLCA	;
							messagebox("입력오류","입력하신 장학생의 학과 및 장학모델을 확인 하십시요.")
							return 
						else
							commit USING SQLCA	;
						end if		
						
				END IF
		
			NEXT
		CASE 'I' 
			FOR ll_i = 1 TO ll_row
				
				ls_result = dw_2.object.janghak_yn[ll_i]
				ls_gwa	 = dw_2.object.gwa[ll_i]
				
				IF ls_result = '1' THEN
					
					ls_hakbun	= dw_2.object.hakbun[ll_i]
					ls_hakyun 	= dw_2.object.su_hakyun[ll_i]
					
					SELECT	COUNT(*)
					INTO  	:li_count
					FROM 		HAKSA.JANGHAK_GWANRI
					WHERE		HAKBUN	= :ls_hakbun
					AND		YEAR		= :ls_year
					AND		HAKGI		= :ls_hakgi
					AND		SUBSTR(JANGHAK_ID,1,1)	= SUBSTR(:ls_janghak,1,1)
					USING SQLCA	;
				
					SELECT	JANGHAK_NAME
					INTO  	:ls_jhname
					FROM		HAKSA.JANGHAK_GWANRI A, HAKSA.JANGHAK_CODE B
					WHERE		A.HAKBUN			= :ls_hakbun
					AND		A.YEAR			= :ls_year
					AND		A.HAKGI			= :ls_hakgi
					AND		A.JANGHAK_ID 	= B.JANGHAK_ID
					USING SQLCA	;
					
					if li_count > 0 then
						IF	messagebox('확인', ls_jhname + "을 이미 받은 학생입니다.", Question!, YesNo!, 2) = 2 then
					  	return 
					  end if
					end if					

					SELECT 	B.GITAGUM
					INTO		:ll_gitagum
					FROM		HAKSA.JANGHAK_MODEL B
					WHERE		B.YEAR		= :ls_year
					AND		B.HAKGI		= :ls_hakgi
					AND		B.JANGHAK_ID	= :ls_janghak
					USING SQLCA	;
				
					//장학금의 장학내외구분, 장학지급구분을 가져온다
					SELECT	A.INOUT_GUBUN,
								A.JIGUP_GUBUN
					INTO		:ls_inout_gubun,
								:ls_jigup_gubun
					FROM		HAKSA.JANGHAK_CODE A 
					WHERE		A.JANGHAK_ID 	= :ls_janghak
					USING SQLCA	;

					IF (ls_inout_gubun = '01' AND ls_jigup_gubun ='02') THEN
					//장학해당학생의 장학을 생성한다.
						INSERT INTO HAKSA.JANGHAK_GWANRI  
								( 		HAKBUN,   
										YEAR,   
										HAKYUN,
										HAKGI,
										GWA,
										JANGHAK_ID,
										GITAGUM,										
										SUNBAL_DATE
								)  
						VALUES 
								( 		:ls_hakbun, 
										:ls_year,
										:ls_hakyun,     
										:ls_hakgi,
										:ls_gwa,
										:ls_janghak,
										:ll_gitagum,																				
										TO_CHAR(SYSDATE,'YYYYMMDD')
								) USING SQLCA	;
					 ELSE
					//장학해당학생의 장학을 생성한다.
						INSERT INTO HAKSA.JANGHAK_GWANRI  
								( 		HAKBUN,   
										YEAR,   
										HAKYUN,
										HAKGI,
										GWA,
										JANGHAK_ID,
										SUNBAL_DATE
								)  
						VALUES 
								( 		:ls_hakbun, 
										:ls_year,
										:ls_hakyun,     
										:ls_hakgi,
										:ls_gwa,
										:ls_janghak,
										TO_CHAR(SYSDATE,'YYYYMMDD')
								) USING SQLCA	;
					 END IF
								
						if sqlca.sqlcode <> 0 then
							rollback USING SQLCA	;
							messagebox("입력오류","입력하신 장학생의 학과 및 장학모델을 확인 하십시요.")
							return 
						else
							commit USING SQLCA	;
						end if		
						
				END IF
		
			NEXT
	END CHOOSE
	
	dw_2.reset()
	dw_2.retrieve(ls_hakgwa, ls_shakyun, ls_shakbun)
	
	li_row = dw_1.retrieve(ls_year, ls_hakgi, '%', '%', '%', ls_janghak )
	if li_row = 0 then
		uf_messagebox(7)
	
	elseif li_row = -1 then
		uf_messagebox(8)
	end if

else
	
	messagebox("알림", "조회된 내용이 없습니다.")
	return 
	
end if
end event

on uo_5.destroy
call uo_imgbtn::destroy
end on

type uo_6 from uo_imgbtn within w_hjh102a
integer x = 507
integer y = 488
integer width = 439
integer taborder = 30
boolean bringtotop = true
string btnname = "보훈번호등록"
end type

event clicked;call super::clicked;open(w_hjh101pp)
end event

on uo_6.destroy
call uo_imgbtn::destroy
end on

type dw_1 from uo_dwfree within w_hjh102a
integer x = 1006
integer y = 376
integer width = 3429
integer height = 1888
integer taborder = 20
string dataobject = "d_hjh102a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_2 from uo_dwfree within w_hjh102a
integer x = 50
integer y = 680
integer width = 937
integer height = 1580
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjh102a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

