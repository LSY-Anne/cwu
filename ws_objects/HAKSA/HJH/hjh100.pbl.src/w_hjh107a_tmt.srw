$PBExportHeader$w_hjh107a_tmt.srw
$PBExportComments$[청운대]입학장학생생성관리
forward
global type w_hjh107a_tmt from w_condition_window
end type
type dw_1 from uo_input_dwc within w_hjh107a_tmt
end type
type st_2 from statictext within w_hjh107a_tmt
end type
type dw_2 from datawindow within w_hjh107a_tmt
end type
type dw_con from uo_dwfree within w_hjh107a_tmt
end type
type uo_1 from uo_imgbtn within w_hjh107a_tmt
end type
type uo_2 from uo_imgbtn within w_hjh107a_tmt
end type
type uo_3 from uo_imgbtn within w_hjh107a_tmt
end type
end forward

global type w_hjh107a_tmt from w_condition_window
dw_1 dw_1
st_2 st_2
dw_2 dw_2
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
end type
global w_hjh107a_tmt w_hjh107a_tmt

type variables
string is_hakgwa, is_hakyun, is_hakgi
datawindowchild idwc_model
end variables

forward prototypes
public function integer f_bohun_process_tmt ()
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

return 0
end function

on w_hjh107a_tmt.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_2=create st_2
this.dw_2=create dw_2
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_con
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.uo_2
this.Control[iCurrent+7]=this.uo_3
end on

on w_hjh107a_tmt.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
end on

event ue_retrieve;Int    li_row
String ls_hakbun,     ls_hakyun,    ls_gwa,    ls_janghak,    ls_year,    ls_hakgi

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_hakbun   =  func.of_nvl(dw_con.Object.hakbun[1], '%')

li_row      = dw_1.retrieve(ls_year, ls_hakgi, ls_hakyun, ls_gwa, ls_hakbun)

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
	
	dw_1.deleterow(ll_row)          //	현재 행을 삭제
	li_ans2 = dw_1.update()    //	삭제된 내용을 저장
	
	IF li_ans2 = -1 THEN
		ROLLBACK USING SQLCA;     
		uf_messagebox(6)        //	삭제오류 메세지 출력
	END IF
END IF

dw_1.setfocus()
end event

event open;call super::open;idw_update[1] = dw_1

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

type ln_templeft from w_condition_window`ln_templeft within w_hjh107a_tmt
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh107a_tmt
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh107a_tmt
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh107a_tmt
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh107a_tmt
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh107a_tmt
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh107a_tmt
end type

type uc_insert from w_condition_window`uc_insert within w_hjh107a_tmt
end type

type uc_delete from w_condition_window`uc_delete within w_hjh107a_tmt
end type

type uc_save from w_condition_window`uc_save within w_hjh107a_tmt
end type

type uc_excel from w_condition_window`uc_excel within w_hjh107a_tmt
end type

type uc_print from w_condition_window`uc_print within w_hjh107a_tmt
end type

type st_line1 from w_condition_window`st_line1 within w_hjh107a_tmt
end type

type st_line2 from w_condition_window`st_line2 within w_hjh107a_tmt
end type

type st_line3 from w_condition_window`st_line3 within w_hjh107a_tmt
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh107a_tmt
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh107a_tmt
end type

type gb_1 from w_condition_window`gb_1 within w_hjh107a_tmt
end type

type gb_2 from w_condition_window`gb_2 within w_hjh107a_tmt
end type

type dw_1 from uo_input_dwc within w_hjh107a_tmt
integer x = 50
integer y = 376
integer width = 4384
integer height = 1888
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjh107a_1"
boolean border = true
end type

event itemchanged;call super::itemchanged;String ls_continue,   ls_date

//ls_date   = to_char(sysdate, 'YYYYMMDD')
SELECT to_char(sysdate, 'YYYYMMDD')
  INTO :ls_date
  FROM DUAL;

CHOOSE CASE dwo.name
	CASE 'continue_yn'
		IF data       = 'Y' THEN
         dw_1.SetItem(row, 'sunbal_date', ls_date)
		ELSE
			dw_1.SetItem(row, 'sunbal_date', '')
	   END IF
END CHOOSE
end event

event clicked;call super::clicked;This.SetRow(row)
end event

type st_2 from statictext within w_hjh107a_tmt
integer x = 50
integer y = 296
integer width = 4384
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
string text = "입학장학생생성"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_hjh107a_tmt
boolean visible = false
integer x = 1079
integer y = 372
integer width = 2153
integer height = 1720
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "입학성적장학제외대상"
string dataobject = "d_hjh107a_2"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;CHOOSE CASE dwo.name
	CASE 'b_1'
		dw_2.print()
	CASE 'b_2'
		dw_2.visible = false
END CHOOSE
end event

type dw_con from uo_dwfree within w_hjh107a_tmt
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_hjh107a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjh107a_tmt
event destroy ( )
boolean visible = false
integer x = 256
integer y = 40
integer width = 448
integer taborder = 70
boolean bringtotop = true
string btnname = "장학생제외내역"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;dw_2.visible = true
end event

type uo_2 from uo_imgbtn within w_hjh107a_tmt
event destroy ( )
integer x = 878
integer y = 44
integer width = 599
integer taborder = 80
boolean bringtotop = true
string btnname = "장학관리전체이관"
end type

on uo_2.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string	ls_year	, ls_hakgi,	ls_hakyun, ls_gwa, ls_gwa1, ls_hakyun1, ls_max, ls_tyear, ls_thakgi
String   ls_hakbun1, ls_janghak
long		ll_woosu1, ll_woosu2, ll_woosu3,	ll_woosu4, ll_su, ll_i, ll_iphak, ll_hakjum,	ll_dungrok
integer 	li_sukcha, li_chk

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

DELETE FROM HAKSA.JANGHAK_GWANRI
 WHERE year        = :ls_year
   AND hakgi       = :ls_hakgi
	AND janghak_id in('I50', 'I51', 'I54', 'I55', 'I62')
USING SQLCA ;

INSERT INTO HAKSA.JANGHAK_GWANRI
       (HAKBUN,       YEAR,          HAKGI,          GWA,         HAKYUN,
		  JANGHAK_ID,   SUNBAL_DATE,   WORKER,
		  IPADDR,                      WORK_DATE)
(SELECT HAKBUN,       YEAR,          HAKGI,          GWA,         HAKYUN,
        JANGHAK_ID,   to_char(sysdate, 'YYYYMMDD'),  :gs_empcode,
		  :gs_ip,    SYSDATE
   FROM HAKSA.JANGHAK_IPHAK
  WHERE YEAR        = :ls_year
    AND HAKGI       = :ls_hakgi
	 AND continue_yn = 'Y') USING SQLCA ;

IF sqlca.sqlcode   <> 0 THEN
	messagebox("저장", '장학관리 이관중 오류가 발생했습니다.' + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	return
END IF

COMMIT USING SQLCA ;

Messagebox("확인", "장학관리 자료 전체이관 작업이 정상적으로 종료되었습니다.", Information!, Ok!)	
setpointer(ARROW!)	

//parent.triggerevent("ue_retrieve")
end event

type uo_3 from uo_imgbtn within w_hjh107a_tmt
event destroy ( )
integer x = 1637
integer y = 40
integer width = 599
integer taborder = 90
boolean bringtotop = true
string btnname = "입학장학생전체생성"
end type

on uo_3.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string ls_year,      ls_hakgi,    ls_hakyun, ls_gwa,   ls_sayu,    ls_hakbun
String ls_janghak,   ls_tyear,    ls_thakgi, ls_chk,   ls_recall
String ls_hakbun1,   ls_hakyun1,  ls_gwa1,   ls_juya,  ls_sangtae, ls_hname
Int    l_cnt,        li_hakgi,    li_cnt1,   l_cnt1,   li_chk,     ii
Int    l_cnt2,       l_sukcha,    l_cnt3,    l_sukcha1
Double ldb_pyengjum, ldb_dungrok3

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

/* 보훈장학생 성적생성 여부 체크(토마토) */
li_chk     = f_bohun_process_tmt()
IF li_chk <> 0 THEN
	return
END IF


SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM haksa.janghak_iphak
 WHERE year       = :ls_year
   AND hakgi      = :ls_hakgi 
 USING SQLCA ;
IF sqlca.sqlnrows = 0 THEN
	l_cnt          = 0
END IF
IF l_cnt          > 0 THEN
   IF MessageBox("알림", "기존 자료가 존재합니다. 삭제 후 재생성 하시겠습니까?", Question!, YesNo!) = 2 THEN
      Return
   END IF
END IF
setpointer(HourGlass!)

dw_2.Settransobject(sqlca)
dw_2.reset()

ii     = 0

DELETE FROM haksa.janghak_iphak
 WHERE year       = :ls_year
   AND hakgi      = :ls_hakgi 
 USING SQLCA ;
 
/* 직전학기: 입학 성적 장학대상이고 취득학점 17학점이상, 평점 4.0이상인 학번 */
DECLARE cur_1  CURSOR FOR
   SELECT a.hakbun,
	       c.su_hakyun,
			 c.gwa,
			 a.janghak_id,
			 b.avg_pyengjum,
			 c.sangtae,
			 c.juya_gubun,
			 c.hname
	  FROM HAKSA.janghak_sinip a, HAKSA.JAEHAK_HAKJUK c, HAKSA.SUNGJUKGYE b
	 WHERE a.janghak_id  in('I50', 'I51', 'I54', 'I55', 'I62')
		AND a.hakbun       = c.hakbun
		AND a.hakbun       = b.hakbun
		AND b.year         = :ls_tyear
		AND b.hakgi        = :ls_thakgi
		AND b.chidk_hakjum >= 17
		and b.avg_pyengjum >= 4.0 
	 USING SQLCA ;

 OPEN   cur_1;
 DO WHILE(TRUE)
 FETCH cur_1 INTO  :ls_hakbun1, :ls_hakyun1, :ls_gwa1, :ls_janghak, :ldb_pyengjum, :ls_sangtae, :ls_juya, :ls_hname ;
 IF SQLCA.SQLCODE  <> 0 THEN  EXIT

/* 입학성적 장학대상이면서('I55':학기당 백만원공제) 성적 장학생인 경우 */
   l_cnt2            = 0
   IF ls_janghak     = 'I55' THEN
/* 장학배정 내역 성적장학B 이상 */
		SELECT nvl(woosu_a, 0) + nvl(woosu_b, 0) + nvl(woosu_c, 0)
		  INTO :l_sukcha
		  FROM haksa.janghak_baejung
		 WHERE year    = :ls_year
		   AND hakgi   = :ls_hakgi
			AND hakyun  = :ls_hakyun1
			AND gwa     = :ls_gwa1
		 USING SQLCA ;
		 
		IF sqlca.sqlnrows  = 0 THEN
			l_sukcha    = 0
		END IF
/* 해당 학번의 장학석차 */
      SELECT nvl(jh_sukcha, 0)
		  INTO :l_sukcha1
		  FROM HAKSA.SUNGJUKGYE
		 WHERE YEAR      = :ls_tyear
			and HAKGI     = :ls_thakgi
			and HAKYUN    = :ls_hakyun1
			and GWA       = :ls_gwa1
			and hakbun    = :ls_hakbun1
		 USING SQLCA ;
		 
		IF sqlca.sqlnrows  = 0 THEN
			l_sukcha1     = 0
		END IF

/* 입학성적 장학대상이면서('I55':학기당 백만원공제) 성적 장학A 이상인 경우 장학을 처리하지 않는다 */
		IF l_sukcha      > l_sukcha1 AND l_sukcha1 <> 0 THEN /* 성적장학B 이상 */
			l_cnt2        = 2
/* 입학성적 장학대상이면서('I55':학기당 백만원공제) 성적 장학B(등록금의 1/3공제)인 경우 금액이 큰 장학을 처리한다 */
		ELSEIF l_sukcha  = l_sukcha1 AND l_sukcha1 <> 0 THEN
			SELECT nvl(TMT_hakgi_dungrok / 3, 0)
			  INTO :ldb_dungrok3
			  FROM haksa.dungrok_model
			 WHERE year    = :ls_year
				AND hakgi   = :ls_hakgi
				AND hakyun  = :ls_hakyun1
				AND gwa     = :ls_gwa1
			 USING SQLCA ;
			 
			IF sqlca.sqlnrows = 0 THEN
				ldb_dungrok3   = 0
			END IF
			IF ldb_dungrok3   > 1000000 THEN
				l_cnt2      = 1
			END IF
		END IF
	END IF

/* 보훈장학생 체크 */
	SELECT nvl(count(*), 0)
	  INTO :l_cnt1
	  FROM haksa.janghak_gwanri
	 WHERE year       = :ls_year
		AND hakgi      = :ls_hakgi
		AND hakbun     = :ls_hakbun1
		AND janghak_id IN('I11', 'O01', 'O02')
	 USING SQLCA ;
	IF sqlca.sqlnrows = 0 THEN
		l_cnt1         = 0
	END IF
	IF l_cnt1         > 0 THEN
//		messagebox("알림", ls_hakbun1 + '의 학번은 보훈장학생이므로 입학성적 장학 생성을 하지 않습니다.')
		dw_2.InsertRow(0)
		ii     = ii + 1
		dw_2.setItem(ii, 'hakbun', ls_hakbun1)
		dw_2.setItem(ii, 'hname',  ls_hname)
		dw_2.setItem(ii, 'hakyun', ls_hakyun1)
		dw_2.setItem(ii, 'gwa',    ls_gwa1)
		dw_2.setItem(ii, 'bigo',   '보훈장학생')
	ELSEIF l_cnt2     = 1 THEN
//		messagebox("알림", ls_hakbun1 + '의 학번은 성적장학C 대상이므로 입학성적 장학 생성을 하지 않습니다.')
		dw_2.InsertRow(0)
		ii     = ii + 1
		dw_2.setItem(ii, 'hakbun', ls_hakbun1)
		dw_2.setItem(ii, 'hname',  ls_hname)
		dw_2.setItem(ii, 'hakyun', ls_hakyun1)
		dw_2.setItem(ii, 'gwa',    ls_gwa1)
		dw_2.setItem(ii, 'bigo',   '성적장학생C')
	ELSEIF l_cnt2     = 2 THEN
//		messagebox("알림", ls_hakbun1 + '의 학번은 성적장학 대상이므로 입학성적 장학 생성을 하지 않습니다.')
		dw_2.InsertRow(0)
		ii     = ii + 1
		dw_2.setItem(ii, 'hakbun', ls_hakbun1)
		dw_2.setItem(ii, 'hname',  ls_hname)
		dw_2.setItem(ii, 'hakyun', ls_hakyun1)
		dw_2.setItem(ii, 'gwa',    ls_gwa1)
		dw_2.setItem(ii, 'bigo',   '성적장학생')
	ELSE
	
	/* 등록학기 체크 */
		 SELECT nvl(COUNT(HAKGI), 0)
			INTO :li_hakgi
			FROM HAKSA.SUNGJUKGYE
		  WHERE hakgi in('1', '2')
			 AND HAKBUN     = :ls_hakbun1
		   USING SQLCA ;
			
		 IF sqlca.sqlnrows = 0 THEN
			 li_hakgi       = 0
		 END IF
		 ls_chk            = 'Y'
		 IF ls_janghak     = 'I50' THEN
			 IF li_hakgi    > 8     THEN
				 ls_chk      = 'N'
			 END IF
		 ELSEIF ls_janghak = 'I51' OR ls_janghak = 'I55' THEN
			 IF li_hakgi    > 2     THEN
				 ls_chk      = 'N'
			 END IF
		 ELSEIF ls_janghak = 'I54' THEN
			 IF li_hakgi    > 4     THEN
				 ls_chk      = 'N'
			 END IF
		 ELSEIF ls_janghak = 'I62' THEN
			 IF li_hakgi    > 8     THEN
				 ls_chk      = 'N'
			 END IF			 
		 ELSE
			 ls_chk         = 'N'
		 END IF
	
	/* 수강철회여부 체크 */
		 ls_recall         = 'N'
		 li_cnt1           = 0
		 
		 SELECT nvl(count(*), 0)
			INTO :li_cnt1
			FROM HAKSA.SUGANG_TRANS
		  WHERE year       = :ls_tyear
			 AND hakgi      = :ls_thakgi
			 AND hakbun     = :ls_hakbun1
			 AND hwansan_jumsu = 'W' 
		  USING SQLCA ;
		  
		 IF sqlca.sqlnrows = 0 THEN
			 li_cnt1        = 0
		 END IF
		 IF li_cnt1        > 0 THEN
			 ls_recall      = 'Y'
		 END IF
		 
		 IF ls_chk      = 'Y' THEN
			 INSERT INTO HAKSA.JANGHAK_IPHAK
				( HAKBUN,       YEAR,          HAKGI,       GWA,          JANGHAK_ID,
				  HAKYUN,       AVG_PYENGJUM,  SANGTAE,     SUNBAL_DATE,
				  RECALL_GB,
				  CONTINUE_YN,  WORKER,                     IPADDR,
				  WORK_DATE )
			 VALUES
				( :ls_hakbun1,  :ls_year,      :ls_hakgi,   :ls_gwa1,     :ls_janghak,
				  :ls_hakyun1,  :ldb_pyengjum, :ls_sangtae, to_char(sysdate, 'yyyymmdd'),
				  :ls_recall,
				  'Y',          :gs_empcode,       :gs_ip,
				  sysdate) USING SQLCA ;
			 IF SQLCA.SQLCODE <> 0 THEN
				 MESSAGEBOX('확인', "오류가 발생하였습니다.~R~N" + SQLCA.SQLERRTEXT)
				 rollback USING SQLCA ;
				 RETURN
			 END IF
		 END IF
	  END IF

Loop
Close  Cur_1;

COMMIT USING SQLCA ;

IF ii     > 0 THEN
	dw_2.visible  = true
	uo_1.visible  = true
ELSE
	dw_2.visible  = false
	uo_1.visible  = false
END IF

setpointer(Arrow!)
Messagebox("확인", "입학장학생 대상 생성이 완료되었습니다.", Information!, Ok!)


parent.triggerevent("ue_retrieve")
end event

