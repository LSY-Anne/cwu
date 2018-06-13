$PBExportHeader$w_hsu509p.srw
$PBExportComments$[청운대]교수별 담당과목및 주당시간현황
forward
global type w_hsu509p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hsu509p
end type
type dw_con from uo_dwfree within w_hsu509p
end type
end forward

global type w_hsu509p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hsu509p w_hsu509p

type variables
datawindowchild ldwc_hjmod
end variables

forward prototypes
protected function integer wf_jusisu (string as_year, string as_hakgi, string as_gwa, string as_gubun)
end prototypes

protected function integer wf_jusisu (string as_year, string as_hakgi, string as_gwa, string as_gubun);Int    ii,          l_cnt,     l_totcnt
string ls_bunhap,   ls_sigan,  ls_member,  ls_sname,   ls_gwaname,  ls_hakyun,  ls_juya
String ls_gwamok,   ls_isgb,   ls_member1, ls_gwamok1, ls_juya1,    ls_hakyun1, ls_gwaname1
String ls_bunhap1,  ls_gwa1,   ls_gwa,     ls_bunban,  ls_bunban1
Long   ll_hakjum,   ll_iron,   ll_silsub,  ll_sisu,    l_totsisu,   ll_gwamok_seq
Long   ll_hakjum1,  ll_iron1,  ll_silsub1, ll_sisu1,   ll_gwamok_seq1

DELETE FROM haksa.tmp_jusisu;

DECLARE cur_1  CURSOR FOR
   SELECT A.MEMBER_NO,
			 B.YOIL||B.SIGAN,
			 max(A.HAKYUN),
			 max(A.JUYA_GUBUN),
			 max(A.HAKJUM),
			 max(A.BAN_BUNHAP),
			 max(A.GWAMOK_ID),
			 max(A.GWAMOK_SEQ),
			 max(A.IS_GUBUN),
			 count(*),
			 max(A.SISU),
			 max(A.BUNBAN)
	  FROM HAKSA.GAESUL_GWAMOK A,
	       HAKSA.SIGANPYO B
	 WHERE A.YEAR			= B.YEAR
		AND A.HAKGI			= B.HAKGI
		AND A.GWA			= B.GWA
		AND A.HAKYUN		= B.HAKYUN
		AND A.BAN			= B.BAN
		AND A.GWAMOK_ID	= B.GWAMOK_ID
		AND A.GWAMOK_SEQ	= B.GWAMOK_SEQ
		AND A.BUNBAN		= B.BUNBAN
		AND A.YEAR			= :as_year
		AND A.HAKGI			= :as_hakgi
		AND A.GWA			LIKE :as_gwa
		AND A.MEMBER_NO	LIKE :as_gubun
		AND (A.PASS_GUBUN	= 'N' OR A.PASS_GUBUN IS NULL )
		AND A.SISU	     <> 0
		AND A.HAKJUM	  <> 0
		AND nvl(A.TMT_JUNGONG_GUBUN, ' ') = ' '
	 GROUP BY A.MEMBER_NO,
			    B.YOIL||B.SIGAN
	 HAVING count(*) > 1;
 OPEN   cur_1;
 DO WHILE(TRUE)
 FETCH cur_1 INTO  :ls_member, :ls_sigan,  :ls_hakyun,     :ls_juya, :ll_hakjum,
                   :ls_bunhap, :ls_gwamok, :ll_gwamok_seq, :ls_isgb, :l_cnt,
						 :ll_sisu,   :ls_bunban;
 IF SQLCA.SQLCODE  <> 0 THEN  EXIT
 
    ls_gwaname  = ''
	 ii          = 0
    DECLARE cur_2  CURSOR FOR
	    SELECT c.sname
		   FROM haksa.gaesul_gwamok a, haksa.siganpyo b, cddb.kch003m c
        WHERE A.YEAR	          = :as_year
		    AND A.HAKGI          = :as_hakgi
		    AND A.YEAR           = B.YEAR
			 AND A.HAKGI          = B.HAKGI
			 AND A.GWA            = B.GWA
			 AND A.HAKYUN         = B.HAKYUN
			 AND A.BAN            = B.BAN
			 AND A.GWAMOK_ID      = B.GWAMOK_ID
			 AND A.GWAMOK_SEQ     = B.GWAMOK_SEQ
			 AND A.BUNBAN         = B.BUNBAN
			 AND A.GWA            = TRIM(C.GWA)
			 AND A.MEMBER_NO      = :ls_member
			 AND B.YOIL||B.SIGAN  = :ls_sigan;
	 OPEN   cur_2;
	 DO WHILE(TRUE)
	 FETCH cur_2 INTO  :ls_sname ;
	 IF SQLCA.SQLCODE  <> 0 THEN  EXIT

       ii            = ii + 1
       IF ii         = 1 THEN
          ls_gwaname = ls_gwaname + ls_sname
		 ELSE
			 ls_gwaname = ls_gwaname + ',' + ls_sname
		 END IF
		 
	Loop
	Close  Cur_2;

   IF ii             > 1 THEN
		IF ls_isgb     = '1' THEN
			ll_iron     = 1
			ll_silsub   = 0
		ELSEIF ls_isgb = '2' THEN
			ll_silsub   = 1
			ll_iron     = 0
		END IF
		l_totcnt       = l_totcnt + 1
	   INSERT INTO haksa.tmp_jusisu (MEMBER_NO,     HAKYUN,      JUYA_GUBUN,    SISU_IRON,
										      SISU_SILSUB,   GWANAME,     HAKJUM,        BAN_BUNHAP,
										      SISU,          GWAMOK_ID,   GWAMOK_SEQ,    BUNBAN)
								VALUES     (:ls_member,    :ls_hakyun,  :ls_juya,      :ll_iron,
											   :ll_silsub,    :ls_gwaname, :ll_hakjum,    '2',
											   :ll_sisu,      :ls_gwamok,  :ll_gwamok_seq,:ls_bunban);
           IF sqlca.sqlcode <> 0 THEN
				  messagebox("알림", 'TEMP TABLE 저장중 ERROR' + sqlca.sqlerrtext)
				  rollback;
				  return -1
			  END IF
	END IF
Loop
Close  Cur_1;

ii     = 0
DECLARE cur_3  CURSOR FOR
   SELECT A.MEMBER_NO,
			 B.YOIL||B.SIGAN,
			 A.HAKYUN,
			 max(A.JUYA_GUBUN),
			 max(A.HAKJUM),
			 max(A.BAN_BUNHAP),
			 A.GWAMOK_ID,
			 A.GWAMOK_SEQ,
			 max(A.IS_GUBUN),
			 max(C.SNAME),
			 count(*),
			 max(A.SISU_IRON),
			 max(A.SISU_SILSUB),
			 max(A.SISU),
			 A.GWA,
			 A.bunban
	  FROM HAKSA.GAESUL_GWAMOK A,
	       HAKSA.SIGANPYO B,
			 CDDB.KCH003M C
	 WHERE A.YEAR			= B.YEAR
		AND A.HAKGI			= B.HAKGI
		AND A.GWA			= B.GWA
		AND A.HAKYUN		= B.HAKYUN
		AND A.BAN			= B.BAN
		AND A.GWAMOK_ID	= B.GWAMOK_ID
		AND A.GWAMOK_SEQ	= B.GWAMOK_SEQ
		AND A.BUNBAN		= B.BUNBAN
		AND A.YEAR			= :as_year
		AND A.HAKGI			= :as_hakgi
		AND A.GWA			LIKE :as_gwa
		AND A.MEMBER_NO	LIKE :as_gubun
		AND (A.PASS_GUBUN	= 'N' OR A.PASS_GUBUN IS NULL )
		AND A.SISU	     <> 0
		AND A.HAKJUM	  <> 0
		AND nvl(A.TMT_JUNGONG_GUBUN, ' ') = ' '
		AND A.GWA         = TRIM(C.GWA)
	 GROUP BY A.MEMBER_NO,
			    B.YOIL||B.SIGAN,
				 A.HAKYUN,
				 A.gwamok_id,
				 A.gwamok_seq,
				 a.gwa,
				 a.bunban
	 HAVING count(*) = 1
	 ORDER BY a.member_no, A.gwamok_id, A.gwamok_seq, a.hakyun, a.gwa, a.bunban;

 OPEN   cur_3;
 DO WHILE(TRUE)
 FETCH cur_3 INTO  :ls_member, :ls_sigan,  :ls_hakyun,     :ls_juya, :ll_hakjum,
                   :ls_bunhap, :ls_gwamok, :ll_gwamok_seq, :ls_isgb, :ls_sname,
						 :l_cnt,     :ll_iron,   :ll_silsub,     :ll_sisu, :ls_gwa,    :ls_bunban;
 IF SQLCA.SQLCODE  <> 0 THEN  EXIT
 
    ls_gwaname  = ls_sname
    l_totcnt    = l_totcnt + 1
	 ii          = ii + 1
	 IF isnull(ls_isgb) OR ls_isgb = '' THEN
	 ELSE
		 IF ls_isgb     = '1' THEN
			 ll_iron     = 0
		 ELSEIF ls_isgb = '2' THEN
			 ll_silsub   = 0
		 END IF
	 END IF
	 IF ii       = 1 THEN
		 ls_member1     = ls_member
		 ls_hakyun1     = ls_hakyun
		 ls_juya1       = ls_juya
		 ll_hakjum1     = ll_hakjum
		 ls_bunhap1     = ls_bunhap
		 ls_gwamok1     = ls_gwamok
		 ls_gwaname1    = ls_gwaname
		 ll_gwamok_seq1 = ll_gwamok_seq
		 ll_iron1       = ll_iron
		 ll_silsub1     = ll_silsub
		 ll_sisu1       = ll_sisu
		 ls_gwa1        = ls_gwa
		 ls_bunban1     = ls_bunban
	 END IF

	 IF ls_member  = ls_member1 AND ls_gwamok = ls_gwamok1 AND ll_gwamok_seq = ll_gwamok_seq1 AND ls_hakyun = ls_hakyun1 and ls_gwa = ls_gwa1 and ls_bunban = ls_bunban1 THEN
	 ELSE
		 INSERT INTO haksa.tmp_jusisu (MEMBER_NO,     HAKYUN,      JUYA_GUBUN,    SISU_IRON,
												 SISU_SILSUB,   GWANAME,     HAKJUM,        BAN_BUNHAP,
												 SISU,          GWAMOK_ID,   GWAMOK_SEQ,    BUNBAN)
									 VALUES  (:ls_member1,   :ls_hakyun1, :ls_juya1,     :ll_iron1,
												 :ll_silsub1,   :ls_gwaname1,:ll_hakjum1,   '',
												 :ll_sisu1,     :ls_gwamok1, :ll_gwamok_seq1,:ls_bunban1);
				  IF sqlca.sqlcode <> 0 THEN
					  messagebox("알림", 'TEMP TABLE 저장중 ERROR' + sqlca.sqlerrtext)
					  rollback;
					  return -1
				  END IF

		 ls_member1     = ls_member
		 ls_hakyun1     = ls_hakyun
		 ls_juya1       = ls_juya
		 ll_hakjum1     = ll_hakjum
		 ls_bunhap1     = ls_bunhap
		 ls_gwamok1     = ls_gwamok
		 ls_gwaname1    = ls_gwaname
		 ll_gwamok_seq1 = ll_gwamok_seq
		 ll_iron1       = ll_iron
		 ll_silsub1     = ll_silsub
		 ll_sisu1       = ll_sisu
		 ls_gwa1        = ls_gwa
		 ls_bunban1     = ls_bunban
	 END IF

Loop
Close  Cur_3;

IF ii        > 0 THEN
	INSERT INTO haksa.tmp_jusisu (MEMBER_NO,     HAKYUN,      JUYA_GUBUN,    SISU_IRON,
										   SISU_SILSUB,   GWANAME,     HAKJUM,        BAN_BUNHAP,
										   SISU,          GWAMOK_ID,   GWAMOK_SEQ,    BUNBAN)
							 VALUES    (:ls_member1,   :ls_hakyun1, :ls_juya1,     :ll_iron1,
										   :ll_silsub1,   :ls_gwaname1,:ll_hakjum1,   '',
										   :ll_sisu1,     :ls_gwamok1, :ll_gwamok_seq1,:ls_bunban1);
				  IF sqlca.sqlcode <> 0 THEN
					  messagebox("알림", 'TEMP TABLE 저장중 ERROR' + sqlca.sqlerrtext)
					  rollback;
					  return -1
				  END IF
END IF

DECLARE cur_4  CURSOR FOR
   SELECT A.MEMBER_NO,
			 B.ILJA||B.SIGAN,
			 max(A.HAKYUN),
			 max(A.JUYA_GUBUN),
			 max(A.HAKJUM),
			 max(A.BAN_BUNHAP),
			 max(A.GWAMOK_ID),
			 max(A.GWAMOK_SEQ),
			 max(A.IS_GUBUN),
			 count(*),
			 max(A.SISU),
          max(A.BUNBAN)
	  FROM HAKSA.GAESUL_GWAMOK A,
	       HAKSA.SIGANPYO_SEASON B
	 WHERE A.YEAR			= B.YEAR
		AND A.HAKGI			= B.HAKGI
		AND A.GWA			= B.GWA
		AND A.HAKYUN		= B.HAKYUN
		AND A.BAN			= B.BAN
		AND A.GWAMOK_ID	= B.GWAMOK_ID
		AND A.GWAMOK_SEQ	= B.GWAMOK_SEQ
		AND A.BUNBAN		= B.BUNBAN
		AND A.YEAR			= :as_year
		AND A.HAKGI			= :as_hakgi
		AND A.GWA			LIKE :as_gwa
		AND A.MEMBER_NO	LIKE :as_gubun
		AND (A.PASS_GUBUN	= 'N' OR A.PASS_GUBUN IS NULL )
		AND A.SISU	     <> 0
		AND A.HAKJUM	  <> 0
		AND nvl(A.TMT_JUNGONG_GUBUN, ' ') = ' '
	 GROUP BY A.MEMBER_NO,
			    B.ILJA||B.SIGAN
	 HAVING count(*) > 1;
 OPEN   cur_4;
 DO WHILE(TRUE)
 FETCH cur_4 INTO  :ls_member, :ls_sigan,  :ls_hakyun,     :ls_juya, :ll_hakjum,
                   :ls_bunhap, :ls_gwamok, :ll_gwamok_seq, :ls_isgb, :l_cnt,
						 :ll_sisu,   :ls_bunban;
 IF SQLCA.SQLCODE  <> 0 THEN  EXIT
 
    ls_gwaname  = ''
	 ii          = 0
    DECLARE cur_5  CURSOR FOR
	    SELECT c.sname
		   FROM haksa.gaesul_gwamok a, haksa.SIGANPYO_SEASON b, cddb.kch003m c
        WHERE A.YEAR	          = :as_year
		    AND A.HAKGI          = :as_hakgi
		    AND A.YEAR           = B.YEAR
			 AND A.HAKGI          = B.HAKGI
			 AND A.GWA            = B.GWA
			 AND A.HAKYUN         = B.HAKYUN
			 AND A.BAN            = B.BAN
			 AND A.GWAMOK_ID      = B.GWAMOK_ID
			 AND A.GWAMOK_SEQ     = B.GWAMOK_SEQ
			 AND A.BUNBAN         = B.BUNBAN
			 AND A.GWA            = TRIM(C.GWA)
			 AND A.MEMBER_NO      = :ls_member
			 AND B.ILJA||B.SIGAN  = :ls_sigan;
	 OPEN   cur_5;
	 DO WHILE(TRUE)
	 FETCH cur_5 INTO  :ls_sname ;
	 IF SQLCA.SQLCODE  <> 0 THEN  EXIT

       ii            = ii + 1
       IF ii         = 1 THEN
          ls_gwaname = ls_gwaname + ls_sname
		 ELSE
			 ls_gwaname = ls_gwaname + ',' + ls_sname
		 END IF
		 
	Loop
	Close  cur_5;

   IF ii             > 1 THEN
		IF ls_isgb     = '1' THEN
			ll_iron     = 1
			ll_silsub   = 0
		ELSEIF ls_isgb = '2' THEN
			ll_silsub   = 1
			ll_iron     = 0
		END IF
		l_totcnt       = l_totcnt + 1
	   INSERT INTO haksa.tmp_jusisu (MEMBER_NO,     HAKYUN,      JUYA_GUBUN,    SISU_IRON,
										      SISU_SILSUB,   GWANAME,     HAKJUM,        BAN_BUNHAP,
										      SISU,          GWAMOK_ID,   GWAMOK_SEQ,    BUNBAN)
								VALUES     (:ls_member,    :ls_hakyun,  :ls_juya,      :ll_iron,
											   :ll_silsub,    :ls_gwaname, :ll_hakjum,    '2',
											   :ll_sisu,      :ls_gwamok,  :ll_gwamok_seq,:ls_bunban);
           IF sqlca.sqlcode <> 0 THEN
				  messagebox("알림", 'TEMP TABLE 저장중 ERROR' + sqlca.sqlerrtext)
				  rollback;
				  return -1
			  END IF
	END IF
Loop
Close  cur_4;

ii     = 0
DECLARE cur_6  CURSOR FOR
   SELECT A.MEMBER_NO,
			 B.ILJA||B.SIGAN,
			 A.HAKYUN,
			 max(A.JUYA_GUBUN),
			 max(A.HAKJUM),
			 max(A.BAN_BUNHAP),
			 A.GWAMOK_ID,
			 A.GWAMOK_SEQ,
			 max(A.IS_GUBUN),
			 max(C.SNAME),
			 count(*),
			 max(A.SISU_IRON),
			 max(A.SISU_SILSUB),
			 max(A.SISU),
			 max(A.GWA),
			 max(A.bunban)
	  FROM HAKSA.GAESUL_GWAMOK A,
	       HAKSA.SIGANPYO_SEASON B,
			 CDDB.KCH003M C
	 WHERE A.YEAR			= B.YEAR
		AND A.HAKGI			= B.HAKGI
		AND A.GWA			= B.GWA
		AND A.HAKYUN		= B.HAKYUN
		AND A.BAN			= B.BAN
		AND A.GWAMOK_ID	= B.GWAMOK_ID
		AND A.GWAMOK_SEQ	= B.GWAMOK_SEQ
		AND A.BUNBAN		= B.BUNBAN
		AND A.YEAR			= :as_year
		AND A.HAKGI			= :as_hakgi
		AND A.GWA			LIKE :as_gwa
		AND A.MEMBER_NO	LIKE :as_gubun
		AND (A.PASS_GUBUN	= 'N' OR A.PASS_GUBUN IS NULL )
		AND A.SISU	     <> 0
		AND A.HAKJUM	  <> 0
		AND nvl(A.TMT_JUNGONG_GUBUN, ' ') = ' '
		AND A.GWA         = TRIM(C.GWA)
	 GROUP BY A.MEMBER_NO,
			    B.ILJA||B.SIGAN,
				 A.HAKYUN,
				 A.gwamok_id, A.gwamok_seq
	 HAVING count(*) = 1
	 ORDER BY A.gwamok_id, A.gwamok_seq;

 OPEN   cur_6;
 DO WHILE(TRUE)
 FETCH cur_6 INTO  :ls_member, :ls_sigan,  :ls_hakyun,     :ls_juya, :ll_hakjum,
                   :ls_bunhap, :ls_gwamok, :ll_gwamok_seq, :ls_isgb, :ls_sname,
						 :l_cnt,     :ll_iron,   :ll_silsub,     :ll_sisu, :ls_gwa,     :ls_bunban;
 IF SQLCA.SQLCODE  <> 0 THEN  EXIT
 
    ls_gwaname  = ls_sname
    l_totcnt    = l_totcnt + 1
	 ii          = ii + 1
	 IF ii       = 1 THEN
		 ls_member1     = ls_member
		 ls_hakyun1     = ls_hakyun
		 ls_juya1       = ls_juya
		 ll_hakjum1     = ll_hakjum
		 ls_bunhap1     = ls_bunhap
		 ls_gwamok1     = ls_gwamok
		 ls_gwaname1    = ls_gwaname
		 ll_gwamok_seq1 = ll_gwamok_seq
		 ll_iron1       = ll_iron
		 ll_silsub1     = ll_silsub
		 ll_sisu1       = ll_sisu
		 ls_gwa1        = ls_gwa
		 ls_bunban1     = ls_bunban
	 END IF

	 IF ls_member  = ls_member1 AND ls_gwamok = ls_gwamok1 AND ll_gwamok_seq = ll_gwamok_seq1 AND ls_hakyun = ls_hakyun1 and ls_bunban = ls_bunban1 THEN
	 ELSE
		 INSERT INTO haksa.tmp_jusisu (MEMBER_NO,     HAKYUN,      JUYA_GUBUN,    SISU_IRON,
												 SISU_SILSUB,   GWANAME,     HAKJUM,        BAN_BUNHAP,
												 SISU,          GWAMOK_ID,   GWAMOK_SEQ,    BUNBAN)
									 VALUES  (:ls_member1,   :ls_hakyun1, :ls_juya1,     :ll_iron1,
												 :ll_silsub1,   :ls_gwaname1,:ll_hakjum1,   '',
												 :ll_sisu1,     :ls_gwamok1, :ll_gwamok_seq1,:ls_bunban1);
				  IF sqlca.sqlcode <> 0 THEN
					  messagebox("알림", 'TEMP TABLE 저장중 ERROR' + sqlca.sqlerrtext)
					  rollback;
					  return -1
				  END IF

		 ls_member1     = ls_member
		 ls_hakyun1     = ls_hakyun
		 ls_juya1       = ls_juya
		 ll_hakjum1     = ll_hakjum
		 ls_bunhap1     = ls_bunhap
		 ls_gwamok1     = ls_gwamok
		 ls_gwaname1    = ls_gwaname
		 ll_gwamok_seq1 = ll_gwamok_seq
		 ll_iron1       = ll_iron
		 ll_silsub1     = ll_silsub
		 ll_sisu1       = ll_sisu
		 ls_gwa1        = ls_gwa
		 ls_bunban1     = ls_bunban
	 END IF

Loop
Close  cur_6;

IF ii        > 0 THEN
	INSERT INTO haksa.tmp_jusisu (MEMBER_NO,     HAKYUN,      JUYA_GUBUN,    SISU_IRON,
											SISU_SILSUB,   GWANAME,     HAKJUM,        BAN_BUNHAP,
											SISU,          GWAMOK_ID,   GWAMOK_SEQ,    BUNBAN)
								 VALUES (:ls_member1,   :ls_hakyun1, :ls_juya1,     :ll_iron1,
											:ll_silsub1,   :ls_gwaname1,:ll_hakjum1,   '',
											:ll_sisu1,     :ls_gwamok1, :ll_gwamok_seq1,:ls_bunban1);
				  IF sqlca.sqlcode <> 0 THEN
					  messagebox("알림", 'TEMP TABLE 저장중 ERROR' + sqlca.sqlerrtext)
					  rollback;
					  return -1
				  END IF
END IF
commit;

//dw_1.reset()
//ii      = 0
//DECLARE cur_9  CURSOR FOR
//   SELECT A.MEMBER_NO,
//	       A.HAKYUN,
//			 A.JUYA_GUBUN,
//			 A.GWANAME,
//			 A.HAKJUM,
//			 A.GWAMOK_ID||A.GWAMOK_SEQ,
//			 A.SISU,
//			 A.BAN_BUNHAP,
//			 sum(A.SISU_IRON),
//			 sum(A.SISU_SILSUB)
//	  FROM HAKSA.TMP_JUSISU A
//	 GROUP BY A.MEMBER_NO,
//	          A.HAKYUN,
//			    A.JUYA_GUBUN,
//			    A.GWANAME,
//			    A.HAKJUM,
//				 A.GWAMOK_ID||A.GWAMOK_SEQ,
//				 A.SISU,
//				 A.BAN_BUNHAP
//	 ORDER BY A.MEMBER_NO;
// OPEN   cur_9;
// DO WHILE(TRUE)
// FETCH cur_9 INTO  :ls_member, :ls_hakyun, :ls_juya,   :ls_gwaname, :ll_hakjum,
//                   :ls_gwamok, :ll_sisu,   :ls_bunhap, :ll_iron, :ll_silsub;
// IF SQLCA.SQLCODE  <> 0 THEN  EXIT
// 
//		 ii     = ii + 1
//
//		 dw_1.InsertRow(0)
//		 dw_1.SetItem(ii, 'member_no',   ls_member)
//		 dw_1.SetItem(ii, 'member_name', ls_member)
//		 dw_1.SetItem(ii, 'hakyun',      ls_hakyun)
//		 dw_1.SetItem(ii, 'juya',        ls_juya)
//		 dw_1.SetItem(ii, 'gwa',         ls_gwaname)
//		 dw_1.SetItem(ii, 'gwamok',      ls_gwamok)
//		 dw_1.SetItem(ii, 'hakjum',      ll_hakjum)
//		 dw_1.SetItem(ii, 'i_sisu',      ll_iron)
//		 dw_1.SetItem(ii, 's_sisu',      ll_silsub)
//		 dw_1.SetItem(ii, 'hap_yn',      ls_bunhap)
//		 
//		 
//Loop
//Close  Cur_9;
//
//dw_1.groupcalc()

return l_totcnt
end function

on w_hsu509p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hsu509p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

event ue_retrieve;call super::ue_retrieve;int		li_row,    ii
string 	ls_year,	  ls_hakgi,   ls_gubun, ls_gubun1,   ls_gwa,     ls_bunhap
String   ls_sigan,  ls_member,  ls_sname, ls_gwaname,  ls_hakyun,  ls_juya
String   ls_gwamok, ls_isgb
Long     ll_hakjum, ll_iron,    ll_silsub,ll_gwamok_seq

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa    	=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_gubun		=	dw_con.Object.gubun[1]

if ls_gubun = '1' Then
	ls_gubun1 = 'A%'
	
elseif ls_gubun = '2' Then
	ls_gubun1 = 'B%'
	
elseif ls_gubun = '3' Then
	ls_gubun1 = 'C%'
	
elseif  ls_gubun = '4' Then
	ls_gubun1 = 'D%'
	
else
	ls_gubun = '전체'
	ls_gubun1 = '%'
	
end if

SetPointer(HourGlass!)

dw_main.reset()

li_row = wf_jusisu(ls_year, ls_hakgi, ls_gwa, ls_gubun1)	

li_row = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_gubun1)	

//dw_1.deleterow(dw_1.insertrow(0))


SetPointer(Arrow!)


dw_main.object.t_gubun.text = ls_gubun + '교수'

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1

end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu509p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu509p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu509p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu509p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu509p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu509p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu509p
end type

type uc_insert from w_condition_window`uc_insert within w_hsu509p
end type

type uc_delete from w_condition_window`uc_delete within w_hsu509p
end type

type uc_save from w_condition_window`uc_save within w_hsu509p
end type

type uc_excel from w_condition_window`uc_excel within w_hsu509p
end type

type uc_print from w_condition_window`uc_print within w_hsu509p
end type

type st_line1 from w_condition_window`st_line1 within w_hsu509p
end type

type st_line2 from w_condition_window`st_line2 within w_hsu509p
end type

type st_line3 from w_condition_window`st_line3 within w_hsu509p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu509p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu509p
end type

type gb_1 from w_condition_window`gb_1 within w_hsu509p
end type

type gb_2 from w_condition_window`gb_2 within w_hsu509p
end type

type dw_main from uo_search_dwc within w_hsu509p
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu509p_2"
end type

type dw_con from uo_dwfree within w_hsu509p
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_hsu509p_c1"
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

