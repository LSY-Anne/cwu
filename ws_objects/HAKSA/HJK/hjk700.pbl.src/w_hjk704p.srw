$PBExportHeader$w_hjk704p.srw
$PBExportComments$[청운대]재적생변동상황총괄표(교육부보고)
forward
global type w_hjk704p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjk704p
end type
type dw_con from uo_dwfree within w_hjk704p
end type
end forward

global type w_hjk704p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hjk704p w_hjk704p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hjk704p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjk704p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')

dw_main.insertrow(0)
end event

event ue_retrieve;integer old_jae,old_m_in_jol,old_m_in_su,old_m_in_je,old_m_in_gita,&  
        old_m_out_jol ,old_m_out_su ,old_m_out_je ,old_m_out_gita ,&
		  old_su_jol,&
		  new_p_in_sin ,new_p_in_pyen ,new_p_in_jaeip ,new_p_in_gita ,&
		  new_p_out_sin ,new_p_out_pyen ,new_p_out_hak_pyen ,new_p_out_tuk_jae ,new_p_out_gun ,new_p_out_gita,&
		  new_p_out_foreign, new_s_out_foreign, new_p_out_nong, new_s_out_nong, &
		  new_p_out_jaeip, new_s_out_jang, new_s_out_silup, &
		  new_s_out_sanup, new_p_out_sanup_pyen
integer li_inwon = 0 , li_old_jaejukseng_su , li_jolup_suryo , li_jolup_jolup
		  
string ls_sangtae	, ls_gubun, ls_junhyung, ls_hjmod, ls_sayu	  
string ls_sijum, ls_jongjum, ls_junwhogi, ls_year, ls_inout

dw_con.AcceptText()

ls_sijum   	= dw_con.Object.from_dt[1]
ls_jongjum	= dw_con.Object.to_dt[1]
old_jae 		= dw_con.Object.jae_num[1]

if ls_junwhogi = '03' then
	ls_junwhogi = '전기'
else
   ls_junwhogi = '후기'
end if

dw_main.object.gijun.text = ls_year + '년도(' + ls_junwhogi + ') '		

SELECT 	count(a.hakbun)
INTO 		:old_m_in_jol 				//2정원내 졸업생수
FROM 		haksa.jolup_hakjuk a,
			haksa.iphak_junhyung b
WHERE 	a.iphak_junhyung = b.junhyung_id
and      b.inout_gubun = '1'
and      a.jolup_date BETWEEN :ls_sijum and :ls_jongjum
USING SQLCA ;

SELECT 	count(a.hakbun)
INTO 		:old_m_in_su 				//3정원내 수료자수
FROM 		haksa.jaehak_hakjuk_tr a,
			haksa.iphak_junhyung b
WHERE 	a.iphak_junhyung = b.junhyung_id
and		a.sayu_id = 'G14'
and		a.sangtae = '05'
and      b.inout_gubun = '1' 
and      a.hjmod_date BETWEEN :ls_sijum and :ls_jongjum
USING SQLCA ;

SELECT	count(a.hakbun)
INTO 		:old_m_in_je 				//4정원내 제적자수
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.HAKJUKBYENDONG B,
			HAKSA.IPHAK_JUNHYUNG C
WHERE		A.IPHAK_JUNHYUNG	= C.JUNHYUNG_ID
AND		A.HAKBUN				= B.HAKBUN
AND		C.INOUT_GUBUN		= '1'
AND		B.HJMOD_ID			in ('D','E')
AND		B.HJMOD_SIJUM		BETWEEN :ls_sijum and :ls_jongjum
USING SQLCA ;
	
SELECT 	count(a.hakbun)
INTO 		:old_m_out_jol 			//6정원외 졸업생수
FROM 		haksa.jolup_hakjuk a,
			haksa.iphak_junhyung b
WHERE 	a.iphak_junhyung = b.junhyung_id
and      b.inout_gubun = '2'
and      a.jolup_date BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;
	
SELECT 	count(a.hakbun)
INTO 		:old_m_out_su 				//7정원외 수료자수
FROM 		haksa.jaehak_hakjuk_tr a,
			haksa.iphak_junhyung b
WHERE 	a.iphak_junhyung = b.junhyung_id
and		a.sayu_id = 'G14'
and		a.sangtae = '05'
and      b.inout_gubun = '2' 
and      a.hjmod_date BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT	count(a.hakbun)
INTO 		:old_m_out_je 				//8정원외 제적자수
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.HAKJUKBYENDONG B,
			HAKSA.IPHAK_JUNHYUNG C
WHERE		A.IPHAK_JUNHYUNG	= C.JUNHYUNG_ID
AND		A.HAKBUN				= B.HAKBUN
AND		C.INOUT_GUBUN		= '2'
AND		B.HJMOD_ID			in ('D','E')
AND		B.HJMOD_SIJUM		BETWEEN :ls_sijum and :ls_jongjum
USING SQLCA ;
			
SELECT 	count(a.hakbun) 				//11정원내 신입학
INTO 		:new_p_in_sin
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '1'
and		a.IPHAK_GUBUN	 	IN ('01','02','03')
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//12정원내 편입학
INTO 		:new_p_in_pyen
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '1'
and		a.IPHAK_GUBUN	 	IN ('04')
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//13정원내 재입학
INTO 		:new_p_in_jaeip
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.HAKJUKBYENDONG B,
			HAKSA.IPHAK_JUNHYUNG C
WHERE 	A.IPHAK_JUNHYUNG	= C.JUNHYUNG_ID
AND		A.HAKBUN				= B.HAKBUN
AND		C.INOUT_GUBUN		= '1'
and		B.HJMOD_ID	 		IN 'I'
and		B.HJMOD_SIJUM 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//15정원외 신입학
INTO 		:new_p_out_sin
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '2'
and		a.IPHAK_GUBUN	 	IN ('01','02','03')
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//18정원외 신입학(외국인)
INTO 		:new_s_out_foreign
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '2'
and		a.IPHAK_GUBUN	 	IN ('01','02','03')
AND		A.IPHAK_JUNHYUNG	= '06'
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//19정원외 신입학(장애인)
INTO 		:new_s_out_jang
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '2'
and		a.IPHAK_GUBUN	 	IN ('01','02','03')
AND		A.IPHAK_JUNHYUNG	= '05'
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//20정원외 신입학(농어촌)
INTO 		:new_s_out_nong
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '2'
and		a.IPHAK_GUBUN	 	IN ('01','02','03')
AND		A.IPHAK_JUNHYUNG	= '04'
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//21정원외 신입학(실업계 고교)
INTO 		:new_s_out_silup
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '2'
and		a.IPHAK_GUBUN	 	IN ('01','02','03')
AND		A.IPHAK_JUNHYUNG	= '13'
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//22정원외 신입학(산업체 위탁)
INTO 		:new_s_out_sanup
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '2'
and		a.IPHAK_GUBUN	 	IN ('01','02','03')
AND		A.IPHAK_JUNHYUNG	= '17'
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;


SELECT 	count(a.hakbun) 				//26정원외 편입학
INTO 		:new_p_out_pyen
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '2'
and		a.IPHAK_GUBUN	 	IN ('04')
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//27정원외 편입학(산업체위탁)
INTO 		:new_p_out_sanup_pyen
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '2'
AND		A.IPHAK_JUNHYUNG	= '17'
and		a.IPHAK_GUBUN	 	IN ('04')
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//29정원외 편입학(외국인)
INTO 		:new_p_out_foreign
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '2'
AND		A.IPHAK_JUNHYUNG	= '06'
and		a.IPHAK_GUBUN	 	IN ('04')
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//34정원외 편입학(학사편입학)
INTO 		:new_p_out_hak_pyen
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.IPHAK_JUNHYUNG B,
			HAKSA.HAKJUKBYENDONG C
WHERE 	a.IPHAK_JUNHYUNG	= b.JUNHYUNG_ID
AND		A.HAKBUN				= C.HAKBUN(+)
AND		B.INOUT_GUBUN		= '2'
AND		A.IPHAK_JUNHYUNG	= '11'
and		a.IPHAK_GUBUN	 	IN ('04')
and		a.IPHAK_DATE 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

SELECT 	count(a.hakbun) 				//41 정원외 재입학(기타)
INTO 		:new_p_out_jaeip
FROM		HAKSA.JAEHAK_HAKJUK A,
			HAKSA.HAKJUKBYENDONG B,
			HAKSA.IPHAK_JUNHYUNG C
WHERE 	A.IPHAK_JUNHYUNG	= C.JUNHYUNG_ID
AND		A.HAKBUN				= B.HAKBUN
AND		C.INOUT_GUBUN		= '2'
and		B.HJMOD_ID	 		IN 'I'
and		B.HJMOD_SIJUM 		BETWEEN :ls_sijum and :ls_jongjum 
USING SQLCA ;

dw_main.setitem(1,'old_jae' , old_jae)
dw_main.setitem(1,'old_m_in_jol' , old_m_in_jol)
dw_main.setitem(1,'old_m_in_su' , old_m_in_su)
dw_main.setitem(1,'old_m_in_je' , old_m_in_je)
dw_main.setitem(1,'old_m_in_gita' , old_m_in_gita)
dw_main.setitem(1,'old_m_out_jol' , old_m_out_jol)
dw_main.setitem(1,'old_m_out_su' , old_m_out_su)
dw_main.setitem(1,'old_m_out_je' , old_m_out_je)
dw_main.setitem(1,'old_m_out_gita' , old_m_out_gita)
dw_main.setitem(1,'old_su_jol' , old_su_jol)
dw_main.setitem(1,'new_p_in_sin' , new_p_in_sin)
dw_main.setitem(1,'new_p_in_pyen' , new_p_in_pyen)
dw_main.setitem(1,'new_p_in_jaeip' , new_p_in_jaeip)
dw_main.setitem(1,'new_p_in_gita' , new_p_in_gita)
dw_main.setitem(1,'new_p_out_sin' , new_p_out_sin)
dw_main.setitem(1,'new_p_out_pyen' , new_p_out_pyen)
dw_main.setitem(1,'new_p_out_hak_py' , new_p_out_hak_pyen)
dw_main.setitem(1,'new_p_out_tuk_jae' , new_p_out_tuk_jae)
dw_main.setitem(1,'new_p_out_gun' , new_p_out_gun)
dw_main.setitem(1,'new_p_out_gita' , new_p_out_gita)
dw_main.setitem(1,'new_p_out_nong' , new_p_out_nong)
dw_main.setitem(1,'new_s_out_nong' , new_s_out_nong)
dw_main.setitem(1,'new_s_out_silup' , new_s_out_silup)
dw_main.setitem(1,'new_p_out_foreign' , new_p_out_foreign)
dw_main.setitem(1,'new_s_out_foreign' , new_s_out_foreign)
dw_main.setitem(1,'new_p_out_sanup_pyen' , new_p_out_sanup_pyen)
dw_main.setitem(1,'new_s_out_sanup' , new_s_out_sanup)
dw_main.setitem(1,'new_p_out_jaeip' , new_p_out_jaeip)
dw_main.setitem(1,'new_s_out_jang' , new_s_out_jang)

dw_main.Modify("datawindow.print.preview=yes")

dw_main.setfocus()

Return 1

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk704p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk704p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk704p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk704p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk704p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk704p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk704p
end type

type uc_insert from w_condition_window`uc_insert within w_hjk704p
end type

type uc_delete from w_condition_window`uc_delete within w_hjk704p
end type

type uc_save from w_condition_window`uc_save within w_hjk704p
end type

type uc_excel from w_condition_window`uc_excel within w_hjk704p
end type

type uc_print from w_condition_window`uc_print within w_hjk704p
end type

type st_line1 from w_condition_window`st_line1 within w_hjk704p
end type

type st_line2 from w_condition_window`st_line2 within w_hjk704p
end type

type st_line3 from w_condition_window`st_line3 within w_hjk704p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk704p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk704p
end type

type gb_1 from w_condition_window`gb_1 within w_hjk704p
end type

type gb_2 from w_condition_window`gb_2 within w_hjk704p
end type

type dw_main from uo_search_dwc within w_hjk704p
integer x = 50
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjk704p_1"
end type

type dw_con from uo_dwfree within w_hjk704p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk704p_c1"
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

