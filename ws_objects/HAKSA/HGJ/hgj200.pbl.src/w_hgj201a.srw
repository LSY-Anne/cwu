$PBExportHeader$w_hgj201a.srw
$PBExportComments$[청운대]교직선발자관리
forward
global type w_hgj201a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hgj201a
end type
type dw_con from uo_dwfree within w_hgj201a
end type
type uo_1 from uo_imgbtn within w_hgj201a
end type
end forward

global type w_hgj201a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hgj201a w_hgj201a

on w_hgj201a.create
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

on w_hgj201a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;string ls_year, ls_jaguk, ls_pyosi, ls_hakgwa, ls_gubun
long ll_ans

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = func.of_nvl(dw_con.Object.pyosi_id[1], '%') + '%'
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_gubun    = dw_con.Object.gubun[1]

if (trim(ls_year) = '' Or Isnull(ls_year)) or (trim(ls_jaguk) = '' Or Isnull(ls_jaguk)) then
	messagebox("확인","신청년도, 자격명을 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("jaguk_id")
	return	 -1
end if

if ls_gubun = '1' Then
	dw_main.setsort( "jaguk_id A, pyosi_id A, jaehak_hakjuk_gwa A, hakbun A")
Else
	dw_main.setsort( "jaguk_id A, pyosi_id A, jaehak_hakjuk_gwa A, pyungjum D, siljum D")
end if

dw_main.sort()

ll_ans = dw_main.retrieve(ls_year, ls_jaguk, ls_pyosi, ls_hakgwa)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event ue_save;long 		ll_cnt,	ll_count, ls_goojik_sugang, ls_goojik_sugang_trans	
long		ls_iseun_sugang_trans,	ls_iseun_sugang
int 		li_ans
string	ls_hakbun,	ls_sunbal_yn
dwItemStatus	lsStatus

dw_main.AcceptText()

SetPointer(HourGlass!)

ll_count	= dw_main.rowcount()

for	ll_cnt	=	1		to		ll_count

	ls_hakbun		= dw_main.getitemstring(ll_cnt, "hakbun")
	ls_sunbal_yn	= dw_main.getitemstring(ll_cnt, "sunbal_yn")
    lsStatus       = dw_main.GetItemStatus(ll_cnt, 0, Primary!)
	 
   IF lsStatus   = DataModified! OR lsStatus   = New! OR lsStatus   = NewModified! THEN
		//성적테이블에 교직과목 COUNT, 선발에서 탈락으로 할경우 기존에 이수한 교직=>일선
		SELECT 	COUNT(GWAMOK_ID)
		INTO		:ls_goojik_sugang
		FROM		HAKSA.SUGANG
		WHERE	HAKBUN 	=	:ls_hakbun
		AND		ISU_ID	=	'40'
		USING SQLCA ;

		//수강테이블에 교직과목 COUNT, 선발에서 탈락으로 할경우 기존에 이수한 교직=>일선
		SELECT 	COUNT(GWAMOK_ID)
		INTO		:ls_goojik_sugang_trans		
		FROM		HAKSA.SUGANG_TRANS
		WHERE		HAKBUN 	=	:ls_hakbun
		AND		ISU_ID	=	'40'
		USING SQLCA ;

		if ls_sunbal_yn = 'N' then
			if ls_goojik_sugang > 0 OR ls_goojik_sugang_trans > 0 then
				
				UPDATE	HAKSA.SUGANG
				SET		ISU_ID		= 	'80'
				WHERE		HAKBUN		=	:ls_hakbun
				AND		ISU_ID		=	'40'
				USING SQLCA ;

				UPDATE	HAKSA.SUGANG_TRANS
				SET		ISU_ID		= 	'80'
				WHERE		HAKBUN		=	:ls_hakbun
				AND		ISU_ID		=	'40'
				USING SQLCA ;
				
				if sqlca.sqlcode <> 0 then
					messagebox("확인","변경중 오류발생~r~n" + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					return -1
				end if	
			end if	
		end if

		//담당자가 실수로 선발인데 탈락시킬경우 다시 탈락에서 선발로 하면 교직과목이 일선으로 되어 있던것을 교직으로 바꿈
		SELECT 	COUNT(DISTINCT(A.GWAMOK_ID))
		INTO		:ls_iseun_sugang		
		FROM		HAKSA.SUGANG 	A,
					HAKSA.GAESUL_GWAMOK	B
		WHERE		A.YEAR			=	B.YEAR
		AND		A.HAKGI			=	B.HAKGI
		AND		A.GWAMOK_ID		=	B.GWAMOK_ID
		AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
		AND		A.HAKBUN 		=	:ls_hakbun
		AND		B.ISU_ID			=	'40'
		USING SQLCA ;
		
		//담당자가 실수로 선발인데 탈락시킬경우 다시 탈락에서 선발로 하면 교직과목이 일선으로 되어 있던것을 교직으로 바꿈
		SELECT 	COUNT(DISTINCT(A.GWAMOK_ID))
		INTO		:ls_iseun_sugang_trans		
		FROM		HAKSA.SUGANG_TRANS 	A,
					HAKSA.GAESUL_GWAMOK	B
		WHERE		A.YEAR			=	B.YEAR
		AND		A.HAKGI			=	B.HAKGI
		AND		A.GWAMOK_ID		=	B.GWAMOK_ID
		AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
		AND		A.HAKBUN 		=	:ls_hakbun
		AND		B.ISU_ID			=	'40'
		USING SQLCA ;

		if ls_sunbal_yn = 'Y' then
			if ls_iseun_sugang > 0 OR ls_iseun_sugang_trans > 0 then
			
				UPDATE	HAKSA.SUGANG
				SET		ISU_ID		= 	'40'
				WHERE		HAKBUN		=	:ls_hakbun
				AND		(	GWAMOK_ID,	YEAR,	HAKGI,	HAKBUN	)	in	
								(	SELECT 	DISTINCT(A.GWAMOK_ID) ,
												A.YEAR,
												A.HAKGI,
												A.HAKBUN
									FROM		HAKSA.SUGANG 	A,
												HAKSA.GAESUL_GWAMOK	B
									WHERE		A.YEAR			=	B.YEAR
									AND		A.HAKGI			=	B.HAKGI
									AND		A.GWAMOK_ID		=	B.GWAMOK_ID
									AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
									AND		A.HAKBUN 		=	:ls_hakbun
									AND		B.ISU_ID			=	'40'
								) USING SQLCA ;

				UPDATE	HAKSA.SUGANG_TRANS
				SET		ISU_ID		= 	'40'
				WHERE		HAKBUN		=	:ls_hakbun
				AND		(	GWAMOK_ID,	YEAR,	HAKGI,	HAKBUN	)	in	
								(	SELECT 	DISTINCT(A.GWAMOK_ID) ,
												A.YEAR,
												A.HAKGI,
												A.HAKBUN
									FROM		HAKSA.SUGANG_TRANS 	A,
												HAKSA.GAESUL_GWAMOK	B
									WHERE		A.YEAR			=	B.YEAR
									AND		A.HAKGI			=	B.HAKGI
									AND		A.GWAMOK_ID		=	B.GWAMOK_ID
									AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
									AND		A.HAKBUN 		=	:ls_hakbun
									AND		B.ISU_ID			=	'40'
								) USING SQLCA ;
												
				if sqlca.sqlcode <> 0 then
					messagebox("확인","변경중 오류발생~r~n" + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					return -1
				end if	
			end if	
		end if
	END IF
next

li_ans = dw_main.update()


if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback USING SQLCA ;
else	
	commit USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(2)
	This.TriggerEvent('ue_retrieve')
end if

Return 1
end event

event open;call super::open;String ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

ls_year	= f_haksa_iljung_year()

dw_con.Object.year[1]   = ls_year



end event

type ln_templeft from w_condition_window`ln_templeft within w_hgj201a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hgj201a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hgj201a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hgj201a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hgj201a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hgj201a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hgj201a
end type

type uc_insert from w_condition_window`uc_insert within w_hgj201a
end type

type uc_delete from w_condition_window`uc_delete within w_hgj201a
end type

type uc_save from w_condition_window`uc_save within w_hgj201a
end type

type uc_excel from w_condition_window`uc_excel within w_hgj201a
end type

type uc_print from w_condition_window`uc_print within w_hgj201a
end type

type st_line1 from w_condition_window`st_line1 within w_hgj201a
end type

type st_line2 from w_condition_window`st_line2 within w_hgj201a
end type

type st_line3 from w_condition_window`st_line3 within w_hgj201a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hgj201a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hgj201a
end type

type gb_1 from w_condition_window`gb_1 within w_hgj201a
integer height = 304
end type

type gb_2 from w_condition_window`gb_2 within w_hgj201a
end type

type dw_main from uo_input_dwc within w_hgj201a
integer x = 55
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hgj201a"
end type

event itemchanged;string	ls_hakbun, ls_hname, ls_hakgwa, ls_year_sql
double	ld_pyungjum, ld_siljum
int		li_chidk
String   ls_year,   ls_jaguk, ls_pyosi,  ls_sunbal

CHOOSE CASE dwo.name
	CASE 'hakbun'
		
		//기 신청여부
		SELECT	YEAR
		INTO		:ls_year_sql
		FROM		HAKSA.GJ_SINCHUNG
		WHERE		HAKBUN	= :data
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			messagebox('확인!', ls_year_sql + '년도에 교원자격을 신청하였습니다!')
			this.object.hakbun[row] = ''
			return 1
		end if
		
		//성명
		SELECT	HNAME,	GWA
		INTO		:ls_hname, :ls_hakgwa
		FROM		HAKSA.JAEHAK_HAKJUK
		WHERE		HAKBUN	= :data
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox('확인!', '존재하지 않는 학번입니다!')
			this.object.hakbun[row] = ''
			this.object.jaehak_hakjuk_hname[row]	= ''
			this.object.jaehak_hakjuk_gwa[row]		= ''
			this.object.pyungjum[row] = 0
			return 1
			
		else
			this.object.jaehak_hakjuk_hname[row]	= ls_hname
			this.object.jaehak_hakjuk_gwa[row]		= ls_hakgwa
			
		end if
		
		//평점평균
		SELECT	ROUND(SUM(PYENGJUM * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, HAKJUM)), 2) ,
					ROUND(SUM(JUMSU * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, HAKJUM)), 2),
					SUM(DECODE(HWANSAN_JUMSU, 'F', 0, HAKJUM))
		INTO		:ld_pyungjum	,
					:ld_siljum,
					:li_chidk
		FROM 		HAKSA.SUGANG
		WHERE 	HAKYUN		= '1'
		AND		HAKBUN 			= :data
		AND		SUNGJUK_INJUNG = 'Y'
		GROUP BY HAKBUN
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox('확인!', '평점평균계산을 실패하였습니다!')
			return 1
		else
			this.object.pyungjum[row]	= ld_pyungjum
			this.object.siljum[row]	     = ld_siljum
			this.object.chidk[row]	          = li_chidk
		end if

END CHOOSE

end event

event itemerror;call super::itemerror;return 2
end event

type dw_con from uo_dwfree within w_hgj201a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_hgj201a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gubun'
		If data = '1' Then
			dw_main.setsort( "jaguk_id A, pyosi_id A, jaehak_hakjuk_gwa A, hakbun A")
			dw_main.sort()
		Else
			dw_main.setsort( "jaguk_id A, pyosi_id A, jaehak_hakjuk_gwa A, pyungjum D, siljum D")
			dw_main.sort()
		End If
End Choose
end event

type uo_1 from uo_imgbtn within w_hgj201a
integer x = 480
integer y = 40
integer width = 521
integer taborder = 41
boolean bringtotop = true
string btnname = "대상자생성"
end type

event clicked;call super::clicked;string ls_year, ls_jaguk, ls_pyosi, ls_hakgwa
int li_count, li_chidk
long ll_ans
string	ls_hakbun
double	ld_pyungjum, ld_siljum

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = dw_con.Object.pyosi_id[1]
ls_hakgwa	= dw_con.Object.gwa[1]

if trim(ls_year) = '' or trim(ls_jaguk) = '' or trim(ls_pyosi) = '' or trim(ls_hakgwa) = '' then
	messagebox("확인","신청년도, 자격명, 표시과목, 학과를 입력하세요!")
	return	 
end if

if messagebox("확인", ls_year + "대상자를 생성하시겠습니까?", question!, yesno!, 2)=2 then return

SELECT	COUNT(*)
INTO		:li_count
FROM		HAKSA.GJ_SINCHUNG
WHERE		YEAR = :ls_year
AND		JAGUK_ID	= :ls_jaguk
AND		PYOSI_ID	= :ls_pyosi
AND		HAKBUN	IN	(	SELECT	HAKBUN
								FROM		HAKSA.JAEHAK_HAKJUK
								WHERE		GWA	= :ls_hakgwa	)
USING SQLCA ;
	
if li_count > 0 then
		
	if messagebox("확인", "이미 생성된 자료가 있습니다" +&
								"~r~n기존 자료를 삭제하고 새로 생성하시겠습니까?", question!, yesno!, 2)=2 then return
								
	
	DELETE FROM HAKSA.GJ_SINCHUNG
	WHERE		YEAR = :ls_year
	AND		JAGUK_ID	= :ls_jaguk
	AND		PYOSI_ID	= :ls_pyosi
	AND		HAKBUN	IN	(	SELECT	HAKBUN
									FROM		HAKSA.JAEHAK_HAKJUK
									WHERE		GWA	= :ls_hakgwa	)
	USING SQLCA ;
		
	if sqlca.sqlcode <>0 then
		messagebox("확인", "기존 자료 삭제를 실패하였습니다")
		return
	end if
	
end if	

setpointer(hourglass!)

DECLARE CUR_HAKBUN CURSOR FOR

////대상자..
//SELECT	HAKBUN
//FROM		HAKSA.JAEHAK_HAKJUK
//WHERE		IPHAK_DATE	>= '2002'
//AND		SANGTAE		= '01'
//AND		DR_HAKYUN	= '2'
//AND		IPHAK_GUBUN <> '04'	
//AND		GWA	= :ls_hakgwa	;

//대상자.. 2003.12.31(수정) 2002학년도 이후에 입학하고 재학인 학생들 모두
SELECT	HAKBUN
FROM		HAKSA.JAEHAK_HAKJUK
WHERE		IPHAK_DATE	>= '2002'
AND		SANGTAE		= '01'
AND		IPHAK_GUBUN <> '04'	
AND		GWA	= :ls_hakgwa
USING SQLCA ;
		
OPEN CUR_HAKBUN	;

DO
	FETCH CUR_HAKBUN INTO	:ls_hakbun	;
	
	IF SQLCA.SQLCODE <> 0 THEN
		EXIT
	END IF
	
	//기 신청여부
	SELECT	COUNT(HAKBUN)
	INTO		:li_count
	FROM		HAKSA.GJ_SINCHUNG
	WHERE		HAKBUN	= :ls_hakbun
	USING SQLCA ;
	
	if li_count > 0 then
		continue
	end if
	
	//평점평균
	SELECT	ROUND(SUM(PYENGJUM * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, HAKJUM)), 2) ,
				ROUND(SUM(JUMSU * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, HAKJUM)), 2),
				SUM(DECODE(HWANSAN_JUMSU, 'F', 0, HAKJUM))
	INTO		:ld_pyungjum	,
				:ld_siljum,
				:li_chidk
	FROM 		HAKSA.SUGANG
	WHERE 	HAKYUN		= '1'
	AND		HAKBUN 			= :ls_hakbun
	AND		SUNGJUK_INJUNG = 'Y'
	GROUP BY HAKBUN
	USING SQLCA ;
			
//	if ld_pyungjum >= 3.0 and li_chidk >= 35 then
//		INSERT INTO HAKSA.GJ_SINCHUNG (	YEAR,			JAGUK_ID,		PYOSI_ID,
//													HAKBUN,		PYUNGJUM,		SILJUM,
//													CHIDK,		SUNBAL_YN,		WORKER,
//													IPADDR,		WORK_DATE,		JOB_UID,
//													JOB_ADD,		JOB_DATE						)
//		VALUES	(								:ls_year,	:ls_jaguk,		:ls_pyosi,
//													:ls_hakbun, :ld_pyungjum,	:ld_siljum,
//													:li_chidk,	'N',				:gstru_uid_uname.uid	,
//													:gstru_uid_uname.address,	SYSDATE,	:gstru_uid_uname.uid	,
//													:gstru_uid_uname.address,	SYSDATE					)	;
//		
//		if sqlca.sqlcode <> 0 then
//			rollback;
//			messagebox('확인','일괄생성을 실패하였습니다!')
//			return
//		end if	
//	end if

//	대상자.. 2003.12.31(수정) 2002학년도 이후에 입학하고 재학인 학생들 모두 그래서 성적 및 취득학점 체크 안함
	INSERT INTO HAKSA.GJ_SINCHUNG (	YEAR,			JAGUK_ID,		PYOSI_ID,
												HAKBUN,		PYUNGJUM,		SILJUM,
												CHIDK,		SUNBAL_YN,		WORKER,
												IPADDR,		WORK_DATE,		JOB_UID,
												JOB_ADD,		JOB_DATE						)
	VALUES	(								:ls_year,	:ls_jaguk,		:ls_pyosi,
												:ls_hakbun, :ld_pyungjum,	:ld_siljum,
												:li_chidk,	'N',				:gstru_uid_uname.uid	,
												:gstru_uid_uname.address,	SYSDATE,	:gstru_uid_uname.uid	,
												:gstru_uid_uname.address,	SYSDATE					) USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		rollback USING SQLCA ;
		messagebox('확인','일괄생성을 실패하였습니다!')
		return
	end if	

	
	li_count		= 0
	ld_pyungjum	= 0
	ld_siljum	= 0
	li_chidk		= 0
	
LOOP WHILE TRUE

CLOSE CUR_HAKBUN;

COMMIT USING SQLCA ;

MESSAGEBOX('확인','작업을 완료하였습니다!')


end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

