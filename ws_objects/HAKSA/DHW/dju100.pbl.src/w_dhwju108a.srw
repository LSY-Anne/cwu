$PBExportHeader$w_dhwju108a.srw
$PBExportComments$[대학원졸업] 졸업생 이관
forward
global type w_dhwju108a from w_basewindow
end type
type cb_2 from commandbutton within w_dhwju108a
end type
type st_cnt from statictext within w_dhwju108a
end type
type hpb_1 from hprogressbar within w_dhwju108a
end type
type cb_1 from commandbutton within w_dhwju108a
end type
type st_2 from statictext within w_dhwju108a
end type
type dw_con from uo_dwfree within w_dhwju108a
end type
end forward

global type w_dhwju108a from w_basewindow
cb_2 cb_2
st_cnt st_cnt
hpb_1 hpb_1
cb_1 cb_1
st_2 st_2
dw_con dw_con
end type
global w_dhwju108a w_dhwju108a

on w_dhwju108a.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.st_cnt=create st_cnt
this.hpb_1=create hpb_1
this.cb_1=create cb_1
this.st_2=create st_2
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.st_cnt
this.Control[iCurrent+3]=this.hpb_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_con
end on

on w_dhwju108a.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.st_cnt)
destroy(this.hpb_1)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.dw_con)
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

type ln_templeft from w_basewindow`ln_templeft within w_dhwju108a
end type

type ln_tempright from w_basewindow`ln_tempright within w_dhwju108a
end type

type ln_temptop from w_basewindow`ln_temptop within w_dhwju108a
end type

type ln_tempbuttom from w_basewindow`ln_tempbuttom within w_dhwju108a
end type

type ln_tempbutton from w_basewindow`ln_tempbutton within w_dhwju108a
end type

type ln_tempstart from w_basewindow`ln_tempstart within w_dhwju108a
end type

type uc_retrieve from w_basewindow`uc_retrieve within w_dhwju108a
end type

type uc_insert from w_basewindow`uc_insert within w_dhwju108a
end type

type uc_delete from w_basewindow`uc_delete within w_dhwju108a
end type

type uc_save from w_basewindow`uc_save within w_dhwju108a
end type

type uc_excel from w_basewindow`uc_excel within w_dhwju108a
end type

type uc_print from w_basewindow`uc_print within w_dhwju108a
end type

type st_line1 from w_basewindow`st_line1 within w_dhwju108a
end type

type st_line2 from w_basewindow`st_line2 within w_dhwju108a
end type

type st_line3 from w_basewindow`st_line3 within w_dhwju108a
end type

type uc_excelroad from w_basewindow`uc_excelroad within w_dhwju108a
end type

type ln_dwcon from w_basewindow`ln_dwcon within w_dhwju108a
end type

type cb_2 from commandbutton within w_dhwju108a
integer x = 2702
integer y = 1156
integer width = 343
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "이관"
end type

event clicked;///******************************************************************************************************************
//	졸업생 자료이관
//******************************************************************************************************************/
//
//int li_int
//long ll_tot, ll_cnt
//boolean lb_ans
//string ls_yn, ls_year, ls_hakgi, ls_hakbun
//
//dw_con.AcceptText()
//
//ls_year		=	dw_con.Object.year[1]
//ls_hakgi		=	dw_con.Object.hakgi[1]
//
//if ls_hakgi = '' or isnull(ls_hakgi) then
//	messagebox("확인","학기를 선택하세요")
//	return -1
//end if
// 
//if messagebox("확인","졸업자의 자료를 이관하시겠습니까?", Question!, YesNo!, 2 ) = 2 then return 
//
////Progress Bar 
//select count(*)
//into :ll_tot
//from d_jolup_trans
//where year		= :ls_year	and
//		hakgi		= :ls_hakgi	and
//		panjung 	= '1' 
//USING SQLCA ;
//		
//hpb_1.MaxPosition = ll_tot
//
////이관시작
//DECLARE CUR_IKWAN CURSOR FOR
//SELECT	HAKBUN
//FROM	HAKSA.D_JOLUP_TRANS
//WHERE	YEAR		= :ls_year
//AND	HAKGI		= :ls_hakgi
//AND	PANJUNG 	= '1' 
//USING SQLCA ;
// 			
//OPEN CUR_IKWAN ;
//DO
//	FETCH CUR_IKWAN INTO :ls_hakbun ;
//	
//	IF SQLCA.SQLCODE <> 0 THEN EXIT
//	
//		//학적마스터
//		SELECT HAKBUN 
//		INTO :ls_yn
//		FROM HAKSA.D_HAKJUK
//		WHERE HAKBUN	=	:ls_hakbun 
//		USING SQLCA ;
//		
//		if sqlca.sqlcode = 100 then 
//			messagebox("오류",ls_hakbun + "의 D_HAKJUK가 존재하지 않습니다.")
//			rollback USING SQLCA ;
//			return
//		else
//			INSERT INTO HAKSA.D_HAKJUK_JOLUP
//			( SELECT * 
//				FROM HAKSA.D_HAKJUK
//				WHERE HAKBUN = :ls_hakbun ) USING SQLCA ;
//					
//		   if sqlca.sqlcode <> 0 then 
//				messagebox("오류",ls_hakbun + "의 D_HAKJUK 이관시 오류입니다.")
//				rollback USING SQLCA ;
//				return
//				
//			elseif sqlca.sqlcode = 0 then
//				
//				DELETE FROM HAKSA.D_HAKJUK_MST WHERE hakbun = :ls_hakbun 
//				USING SQLCA ;
//				
//			end if	
//		end if
//		
//		
//		//하위학력
//		SELECT HAKBUN 
//		into :ls_yn
//		FROM	HAKSA.D_HAWI_HAKWI
//		WHERE HAKBUN = :ls_hakbun 
//		USING SQLCA ;
//		
//		if sqlca.sqlcode = 0 then 
//			INSERT INTO HAKSA.D_HAWI_HAKWI_JOLUP
//				( SELECT * 
//					FROM HAKSA.D_HAWI_HAKWI 
//					WHERE HAKBUN = :ls_hakbun ) USING SQLCA ;
//			
//			if sqlca.sqlcode <> 0 then 
//				messagebox("오류",ls_hakbun + "의 D_HAWI_HAKWI 이관시 오류가 발생되었습니다.")
//				rollback USING SQLCA ;
//				return 
//			elseif sqlca.sqlcode = 0 then 
//				
//				delete from HAKSA.HAWI_HAKWI where hakbeon = :ls_hakbun 
//				USING SQLCA ;
//			end if
//			
//		elseif sqlca.sqlcode = -1 then
//			messagebox("오류",ls_hakbun + "의 D_HAWI_HAKWI 자료 조회중 오류가 발생되었습니다.")
//			return
//			
//		end if
//		
//		
//		//학적변동
//		SELECT HAKBUN
//		into :ls_yn
//		FROM HAKSA.D_HAKBYEN WHERE HAKBUN = :ls_hakbun 
//		USING SQLCA ;
//		
//		if sqlca.sqlcode = 0 then 
//			INSERT INTO HAKSA.D_HAKBYEN
//				( SELECT * 
//					FROM HAKSA.D_HAKBYEN 
//					WHERE HAKBUN = :ls_hakbun ) USING SQLCA ;
//		
//			if sqlca.sqlcode <> 0 then 
//				 messagebox("오류",ls_hakbun + "의 D_HAKBYEN 이관시 오류가 발생되었습니다.")
//				 rollback  USING SQLCA ;
//				 return
//			elseif sqlca.sqlcode = 0 then 
//				
//				DELETE FROM HAKSA.D_HAKBYEN WHERE HAKBUN = :ls_hakbun 
//				USING SQLCA ;
//			end if
//			
//		elseif sqlca.sqlcode = -1 then
//			messagebox("오류",ls_hakbun + "의 D_HAKBYEN 자료 조회중 오류가 발생되었습니다.")
//			return
//
//		end if
//		
////		//상벌사항
////		SELECT HAKBUN 
////		into :ls_yn
////		FROM D_SANGBUL WHERE HAKBUN	=	:ls_hakbun ;
////		
////		if sqlca.sqlcode = 0 then 
////			INSERT INTO D_SANGBUL_JOLUP
////				( SELECT * 
////					FROM D_SANGBUL 
////					WHERE HAKBUN = :ls_hakbun ) ;
////		
////			if sqlca.sqlcode <> 0 then 
////				messagebox("오류",ls_hakbun + "의 D_SANGBUL 이관시 오류가 발생되었습니다.")
////				rollback ;
////				return
////			elseif sqlca.sqlcode = 0 then 
////				
////				delete from D_SANGBUL where HAKBUN = :ls_hakbun ;
////
////			end if
////		end if
//		
//	
//		//장학생 정보
//	
//	
//		//등록정보
//	
//		//분납 정보
//		
//		//성적계
//		SELECT HAKBUN 
//		into :ls_yn
//		FROM	HAKSA.D_SUNGJUKGYE
//		WHERE HAKBUN = :ls_hakbun 
//		USING SQLCA ;
//		
//		if sqlca.sqlcode = 0 then 
//			INSERT INTO HAKSA.D_SUNGJUKGYE_JOLUP
//				( SELECT * 
//					FROM HAKSA.D_SUNGJUKGYE 
//					WHERE HAKBUN = :ls_hakbun ) USING SQLCA ;
//		
//			if sqlca.sqlcode <> 0 then 
//				messagebox("오류",ls_hakbun + "의 D_SUNGJUKGYE 이관시 오류가 발생되었습니다.")
//				rollback using sqlca;
//				return 
//				
//			elseif sqlca.sqlcode = 0 then 
//				
//				DELETE FROM HAKSA.D_SUNGJUKGYE WHERE HAKBUN = :ls_hakbun 
//				USING SQLCA ;
//			end if				
//
//		elseif sqlca.sqlcode = -1 then
//			messagebox("오류",ls_hakbun + "의 D_SUNGJUKGYE 자료 조회중 오류가 발생되었습니다.")
//			return
//
//		end if
//		
//		//수강
//		SELECT HAKBUN 
//		into :ls_yn
//		FROM	HAKSA.D_SUGANG
//		WHERE HAKBUN = :ls_hakbun 
//		USING SQLCA ;
//		
//		if sqlca.sqlcode = 100 then 
//			INSERT INTO HAKSA.D_SUGANG_JOLUP
//				( SELECT * 
//					FROM HAKSA.D_SUGANG 
//					WHERE HAKBUN = :ls_hakbun ) USING SQLCA ;
//		
//			if sqlca.sqlcode <> 0 then 
//				messagebox("오류",ls_hakbun + "의 SUGANG 이관시 오류가 발생되었습니다.")
//				rollback using sqlca;
//				return 
//				
//			elseif sqlca.sqlcode = 0 then 
//				
//				DELETE FROM HAKSA.D_SUGANG WHERE HAKBUN = :ls_hakbun 
//				USING SQLCA ;
//			end if
//			
//		elseif sqlca.sqlcode = -1 then
//			messagebox("오류",ls_hakbun + "의 SUGANG 자료 조회중 오류가 발생되었습니다.")
//			return
//			
//		end if
//		
//		
//	//Progress Bar
//	ll_cnt = ll_cnt + 1
//	hpb_1.Position = ll_cnt
//	st_cnt.text = string(ll_cnt) + ' / ' + string(ll_tot)	
//
//LOOP WHILE TRUE
//CLOSE CUR_IKWAN ;
//
//commit  USING SQLCA ;
//MESSAGEBOX("확인","졸업생 자료를 이관하였습니다.")
//
//
////D_JOUP_SAJUNG하고 JOIN이 필요한 경우사용
////			INSERT INTO HAKSA.D_HAKJUK_JOLUP
////			(SELECT	A.HAKBUN,			A.GWAJUNG_ID,		A.GWA_ID,			A.JUNGONG_ID,		A.D_HAKGICHA,
////						A.S_HAKGICHA,		A.HNAME,				A.CNAME,				A.ENAME,				A.JUMIN_NO,
////						A.SEX,				A.SANGTAE_ID,		A.HJMOD_ID,			A.HJMOD_SAYU_ID,	A.HJMOD_DATE,
////						A.ZIP_ID,			A.JUSO,				A.TEL,				A.HP,					A.JOB_ID,		
////						A.OFFICE,			A.OFFICE_ZIP,		A.OFFICE_JUSO,		A.OFFICE_TEL,		A.EMAIL,
////						A.BO_NAME,			A.BO_RELATION,		A.BO_ZIP_ID,		A.BO_JUSO,			A.BO_TEL,
////						A.BO_JOB,			A.IPHAK_DATE,		A.IPHAK_GUBUN,		A.SUHUM_NO,			A.SUNSU_YN,
////						A.INJUNG_HAKJUM,	A.BYENG_GUBUN,		A.JONGHAP_DATE,	B.JOLUP_DATE,		B.SURYO_DATE,
////						B.HAKWI_NO,			B.JUNG_NO,			B.SURYO_NO,			B.HAKWI_ID,			A.JANGHAK_ID,
////						A.BOHUN_ID,			A.PASSWORD,			A.WORKER,			A.IPADDR,			A.WORK_DATE,
////						A.JOB_UID,			A.JOB_ADD,			A.JOB_DATE
////				FROM	HAKSA.D_HAKJUK			A,
////						HAKSA.D_JOLUP_SAJUNG	B
////				WHERE	B.YEAR	=	:ls_year
////				AND	B.HAKGI	=	:ls_hakgi )	;
end event

type st_cnt from statictext within w_dhwju108a
integer x = 2592
integer y = 864
integer width = 457
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
string text = "count"
alignment alignment = right!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_dhwju108a
integer x = 1088
integer y = 932
integer width = 1966
integer height = 84
unsignedinteger maxposition = 100
unsignedinteger position = 1
integer setstep = 10
end type

type cb_1 from commandbutton within w_dhwju108a
integer x = 2354
integer y = 1156
integer width = 343
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "학적변동"
end type

event clicked;//졸업(수료)자들의 학적상태를 변경해준다.
//졸업일자, 수료일자, 졸업

string	ls_year, ls_hakgi, ls_date
string	ls_hakbun, ls_gwajung, ls_panjung, ls_j_ilja, ls_s_ilja, ls_hakwi_no, ls_jung_no, ls_suryo_no, ls_hakwi
string	ls_hak_year, ls_hak_hakgi, ls_hjmod_sayu_id

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","학기를 선택하세요")
	return -1
end if
 
ls_date = string(f_sysdate() , 'YYYYMMDD')

if messagebox("확인","졸업자의 학적변동을 실행하시겠습니까?", Question!, YesNo!, 2 ) = 2 then return 
 
Setpointer(HourGlass!) 
DECLARE CUR_BYENDONG CURSOR FOR
SELECT	HAKBUN,
			GWAJUNG_ID,
			PANJUNG,
			JOLUP_DATE,
			SURYO_DATE,
			HAKWI_NO,
			JUNG_NO,
			SURYO_NO,
			HAKWI_ID
FROM	HAKSA.D_JOLUP_SAJUNG
WHERE	YEAR		= :ls_year
AND	HAKGI		= :ls_hakgi
AND	PANJUNG 	IN ('1', '2') 
USING SQLCA ;

IF ls_hakgi = '1' THEN 
	ls_hjmod_sayu_id ='G11'
ELSE 
	ls_hjmod_sayu_id ='G12'
END IF
 			
OPEN CUR_BYENDONG ;
DO
	FETCH CUR_BYENDONG 
	INTO :ls_hakbun, :ls_gwajung, :ls_panjung, :ls_j_ilja, :ls_s_ilja, :ls_hakwi_no, :ls_jung_no, :ls_suryo_no, :ls_hakwi;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	//졸업자인 경우(연구과정은 수료가 졸업으로 간주)
	IF ls_panjung = '1' THEN
		
		//석사과정은 졸업으로 연구과정은 수료로 학적변동한다.
		if ls_gwajung = '1' then
			
			UPDATE	HAKSA.D_HAKJUK
			SET SANGTAE_ID		=	'04',
				 HJMOD_ID		=	'G',
				 HJMOD_SAYU_ID	=	'',
				 HJMOD_DATE		=	:ls_date,
				 JOLUP_DATE		=	:ls_j_ilja,
				 HAKWI_NO		=	:ls_hakwi_no,
				 JUNG_NO			=	:ls_jung_no,
				 HAKWI_ID		=	:ls_hakwi
		  WHERE HAKBUN = :ls_hakbun
		  USING SQLCA ;
		  
		else
			UPDATE	HAKSA.D_HAKJUK
			SET SANGTAE_ID		=	'05',
				 HJMOD_ID		=	'F',
				 HJMOD_SAYU_ID	=	'',
				 HJMOD_DATE		=	:ls_date,
				 SURYO_DATE		=	:ls_s_ilja,
				 SURYO_NO		=	:ls_suryo_no				 
		  WHERE HAKBUN = :ls_hakbun
		  USING SQLCA ;
		  
		end if
	
	//수료자인 경우
	ELSEIF ls_panjung = '2' THEN
		
		UPDATE	HAKSA.D_HAKJUK
		SET	SANGTAE_ID		=	'05',
			 	HJMOD_ID			=	'F',
				HJMOD_SAYU_ID	=	'',
				HJMOD_DATE		=	:ls_date,
				SURYO_DATE		=	:ls_s_ilja,
				SURYO_NO			=	:ls_suryo_no				
	  WHERE	HAKBUN	= :ls_hakbun
	  USING SQLCA ;
	  
		if sqlca.sqlcode = 0 then
		
		//수료생중에서 석사과정은 학적변동을 Insert 한다.
		  if ls_gwajung = '1' then
			  
			  SELECT		YEAR,
			  				HAKGI  
				INTO		:ls_hak_year,
							:ls_hak_hakgi  
				FROM		HAKSA.D_HAKSA_ILJUNG  
				WHERE		SIJUM_FLAG = '1'
				USING SQLCA ;
				
				this.text = ls_hakgi
			  
			  //학적변동 INSERT
			  INSERT INTO HAKSA.D_HAKBYEN
							(	HAKBUN,			HJMOD_SIJUM,	HJMOD_ID,
								YEAR,				HAKGI,			HAKGICHA	)
					VALUES(	:ls_hakbun,		:ls_date,		'F',
								:ls_hak_year,	:ls_hak_hakgi,	'6'		)	USING SQLCA ;
			end if
		end  if
	  
	end if

	if sqlca.sqlcode <> 0 then
		messagebox("오류",ls_hakbun + " 처리시 오류 발생")
		rollback	USING SQLCA ;
	end if		
		
LOOP WHILE TRUE
CLOSE CUR_BYENDONG ;
commit USING SQLCA ;

Setpointer(Arrow!)
messagebox("확인","졸업대상자들의 학적변동처리가 완료되었습니다.")
end event

type st_2 from statictext within w_dhwju108a
integer x = 55
integer y = 296
integer width = 4379
integer height = 100
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 32500968
string text = "졸업생 학적변동 일괄처리"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_dhwju108a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwju106a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

