$PBExportHeader$w_hdr202a.srw
$PBExportComments$[청운대]은행자료Loading
forward
global type w_hdr202a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hdr202a
end type
type dw_con from uo_dwfree within w_hdr202a
end type
type sle_path from singlelineedit within w_hdr202a
end type
type uo_1 from uo_imgbtn within w_hdr202a
end type
type uo_2 from uo_imgbtn within w_hdr202a
end type
type st_cnt from statictext within w_hdr202a
end type
end forward

global type w_hdr202a from w_condition_window
dw_main dw_main
dw_con dw_con
sle_path sle_path
uo_1 uo_1
uo_2 uo_2
st_cnt st_cnt
end type
global w_hdr202a w_hdr202a

on w_hdr202a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.sle_path=create sle_path
this.uo_1=create uo_1
this.uo_2=create uo_2
this.st_cnt=create st_cnt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.sle_path
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.st_cnt
end on

on w_hdr202a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.sle_path)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.st_cnt)
end on

event ue_retrieve;string ls_year, ls_hakgi
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year = '' or Isnull(ls_year) or ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","년도, 학기를 입력하세요.")
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

event open;call super::open;//idw_update[1] = dw_main

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

type ln_templeft from w_condition_window`ln_templeft within w_hdr202a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr202a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr202a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr202a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr202a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr202a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr202a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr202a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr202a
end type

type uc_save from w_condition_window`uc_save within w_hdr202a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr202a
end type

type uc_print from w_condition_window`uc_print within w_hdr202a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr202a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr202a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr202a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr202a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr202a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr202a
end type

type gb_2 from w_condition_window`gb_2 within w_hdr202a
end type

type dw_main from uo_input_dwc within w_hdr202a
integer x = 55
integer y = 304
integer width = 4379
integer height = 1960
integer taborder = 10
boolean bringtotop = true
end type

type dw_con from uo_dwfree within w_hdr202a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hdr202a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type sle_path from singlelineedit within w_hdr202a
integer x = 91
integer y = 48
integer width = 1019
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_imgbtn within w_hdr202a
integer x = 1138
integer y = 40
integer width = 329
integer taborder = 40
boolean bringtotop = true
string btnname = "파일선택"
end type

event clicked;call super::clicked;//파일선택
string	ls_filename,named
integer	value

//경로 지정 윈도우 open
value = GetFileOpenName("Select File", ls_filename, named,"TXT", "ALL Files &(*.*),*.*,Text Files (*.TXT),*.TXT,Doc Files (*.DOC),*.DOC")

sle_path.text = ls_filename
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hdr202a
integer x = 1522
integer y = 40
integer width = 544
integer taborder = 40
boolean bringtotop = true
string btnname = "은행자료Loading"
end type

event clicked;call super::clicked;//File 읽기 변수
integer	fnum, bytes_read, value, i, mok, l_chasu
string	ls_filename, named, ls_path, ls_line 
double	flen

string  ls_sunapcheo, ls_chk_suhum, ls_chk, ls_bunnap

//DB에 넣을 변수
string	ls_year, ls_hakgi, ls_hakbun, ls_dr_ilja, ls_hakyun
long		ll_napip, ll_haksengwhe, ll_gyojae, ll_dongchang, ll_memory,&
			ll_album, ll_ip_napip,   ll_hakjum

//현재년도의 입학금의 변수			
long 		ll_iphak			

string	af_hakbun,	af_su_hakyun
long 		lf_chasu, ll_count

// 비정상적은 자료 변수
string	bi_hakbun,	bi_su_hakyun,	bi_janghak_id,  ls_napbu
long 		bi_chasu,   l_cnt, 		l_bun_cnt
long		bi_hakjum,	bi_iphak,	bi_dungrok,	bi_haksengwhe,	bi_gyojae,	bi_album,	bi_hakwhe,	bi_memorial, &
			bi_dongchangwhe,	bi_i_janghak,		bi_d_janghak

//년도, 학기
dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year = '' or isnull(ls_year) or isnull(ls_hakgi) or ls_hakgi = '' then
	MESSAGEBOX("확인","년도, 학기를 선택해주세요.")
	RETURN
end if

//수납처 선택
ls_sunapcheo = dw_con.Object.bank_id[1]

if ls_sunapcheo = '' or isnull(ls_sunapcheo) or ls_sunapcheo = '1' then
	MESSAGEBOX("확인","수납처를 선택해주세요.")
	RETURN
end if

if messagebox("확인","선택된 File을 처리하시겠습니까?", Question!, YesNo!, 2) = 2 then return

//File Open
ls_filename	=	sle_path.text
flen = FileLength(ls_filename) 
fnum = fileopen(ls_filename, Linemode!, Read!, LockRead!)

if fnum = -1 then
	messagebox("확인", ls_filename + "화일을 열수가 없습니다", StopSign!, OK!)
	FileClose(fnum)
	return 
end if

SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')
  INTO :ls_napbu
  FROM DUAL;

//현재학년도의 입학금을 가져온다
SELECT 	DISTINCT IPHAK
INTO		:ll_iphak
FROM 		HAKSA.DUNGROK_MODEL
WHERE		YEAR = :ls_year
USING SQLCA ;

//WOORI BANK
CHOOSE CASE  ls_sunapcheo
	CASE '2'													
		
//		mok = flen / ( 81 + 2)
		mok = flen / ( 115 + 2)		
		
		messagebox('우리', string(mok))

		for i = 1 to mok
	
			bytes_read = fileread(fnum, ls_line)
			
			if bytes_read = -100 then
				fileclose(fnum) 
				EXIT
			end if	
			
			ls_chk	=	mid(ls_line, 1, 1)
			
			if ls_chk = ' ' then
				messagebox("오류!","우리은행 형식의 File이 아닙니다.~r~n다시 선택해 주세요.")
				FileClose(fnum)
				return
			end if			
			
			ls_hakbun		=	trim(mid(ls_line, 1, 8))				//학번 
			ls_hakyun		=	trim(mid(ls_line, 9, 1))				//학년 
			ll_hakjum		=	long(trim(mid(ls_line, 14, 2)))		//학점
			ll_ip_napip		=	long(trim(mid(ls_line, 16, 7)))		//입학금
			ll_napip			=	long(trim(mid(ls_line, 23, 7)))		//등록금			
////			if	ll_ip_napip =	ll_iphak  and ll_napip > 0 then
			if	ll_ip_napip > 0 then
				ll_napip		=	long(trim(mid(ls_line, 37, 7)))		//등록금
				ll_napip		=	ll_napip - ll_ip_napip
			else	
				ll_napip		=	long(trim(mid(ls_line, 37, 7)))		//등록금
			end if
			ll_haksengwhe	=	long(trim(mid(ls_line, 44, 7)))		//학생회비
			ll_gyojae		=	long(trim(mid(ls_line, 51, 7)))		//교재비
			ll_dongchang	=	long(trim(mid(ls_line, 58, 7)))		//동창회비
			ll_memory		=  long(trim(mid(ls_line, 65, 7)))		//졸업기념비
			ll_album			=  long(trim(mid(ls_line, 72, 7)))		//졸업앨범비
//			ls_dr_ilja		=	mid(ls_line, 88, 8)


/*   분납자 체크 (우리은행)*/
         ls_bunnap      = 'N'
         select nvl(count(*), 0)
			  into :l_cnt
			  from haksa.bunnap_gwanri c, ( select hakbun, max(nvl(chasu, 0)) chasu
                                           from haksa.bunnap_gwanri
                                          where year   = :ls_year
                                            and hakgi  = :ls_hakgi
														  and hakbun = :ls_hakbun
                                            and nvl(dungrok, 0) <> 0
                                          group by hakbun) d
            where c.year    = :ls_year
              and c.hakgi   = :ls_hakgi
				  and c.hakbun  = :ls_hakbun
              and c.hakbun  = d.hakbun
              and c.chasu   = d.chasu
		   USING SQLCA ;
				  
			IF sqlca.sqlnrows  = 0 THEN
				l_cnt           = 0
			END IF
			IF l_cnt           > 0 THEN
				ls_bunnap       = 'Y'
			END IF
			
			select 	nvl(c.CHASU, 0)
			into 		:l_bun_cnt
			from 		haksa.DUNGROK_BUNNAP c
			where 	c.year    = :ls_year
			and 		c.hakgi   = :ls_hakgi
			and 		c.hakbun  = :ls_hakbun
			USING SQLCA ;
			
			IF sqlca.sqlnrows  = 0 THEN
				l_bun_cnt		 =	0
			END IF
			
			
			IF ls_bunnap       = 'Y' THEN
				IF l_bun_cnt    =	0 THEN 
					
					UPDATE HAKSA.DUNGROK_GWANRI					
						SET IPHAK_N          = IPHAK_N + NVL(:ll_ip_napip, 0),
							 DUNGROK_N        = DUNGROK_N + NVL(:ll_napip, 0),
							 HAKSENGWHE_N     = HAKSENGWHE_N + NVL(:ll_haksengwhe, 0),
							 GYOJAE_N         = GYOJAE_N + NVL(:ll_gyojae, 0),
							 DONGCHANGWHE_N   = DONGCHANGWHE_N + NVL(:ll_dongchang, 0),
							 MEMORIAL_N	      = MEMORIAL_N + NVL(:ll_memory, 0),
							 ALBUM_N          = ALBUM_N + NVL(:ll_album, 0),
							 BANK_ID          = '2',
							 BUN_YN           = 'Y',
							 DUNG_YN          = 'Y',
							 NAPBU_DATE       = TO_CHAR(SYSDATE, 'YYYYMMDD')
					 WHERE YEAR             = :ls_year
						AND HAKGI            = :ls_hakgi
						AND HAKBUN           = :ls_hakbun
					  USING SQLCA ;
						
				ELSE
					UPDATE HAKSA.DUNGROK_GWANRI
						SET IPHAK_N          = IPHAK_N + NVL(:ll_ip_napip, 0),
							 DUNGROK_N        = DUNGROK_N + NVL(:ll_napip, 0),
							 HAKSENGWHE_N     = HAKSENGWHE_N + NVL(:ll_haksengwhe, 0),
							 GYOJAE_N         = GYOJAE_N + NVL(:ll_gyojae, 0),
							 DONGCHANGWHE_N   = DONGCHANGWHE_N + NVL(:ll_dongchang, 0),
							 MEMORIAL_N	      = MEMORIAL_N + NVL(:ll_memory, 0),
							 ALBUM_N          = ALBUM_N + NVL(:ll_album, 0),
							 BANK_ID          = '2',
							 BUN_YN           = 'Y',
							 DUNG_YN          = 'Y'
					 WHERE YEAR             = :ls_year
						AND HAKGI            = :ls_hakgi
						AND HAKBUN           = :ls_hakbun
						AND DUNG_YN				=	'Y'
						AND BUN_YN				=	'Y'
 						AND WAN_YN				=	'N'
					  USING SQLCA ;
				END IF


				IF sqlca.sqlcode       <> 0 THEN
					messagebox("저장", '등록급 납부 수정중 오류_우리' + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					return
				END IF
				
				
				SELECT nvl(max(chasu), 0)
				  INTO :l_chasu
				  FROM haksa.dungrok_bunnap
				 WHERE hakbun           = :ls_hakbun
				   AND year             = :ls_year
					AND hakgi            = :ls_hakgi
				 USING SQLCA ;
            IF sqlca.sqlnrows       = 0 THEN
					l_chasu    = 1
				ELSE
					l_chasu    = l_chasu + 1
				END IF
			  INSERT INTO haksa.dungrok_bunnap (HAKBUN,         YEAR,           HAKGI,        BANK_ID,
													  	 SU_HAKYUN,			 CHASU,          IPHAK,        DUNGROK,
														 HAKSENGWHE,     GYOJAE,         ALBUM,        HAKWHE,
														 MEMORIAL,       DONGCHANGWHE,   NAPBU_DATE,
														 WORKER,                         IPADDR,
														 WORK_DATE,      JOB_UID,        JOB_ADD,
														 JOB_DATE)
							  values             (:ls_hakbun,     :ls_year,       :ls_hakgi,    '2',
														 :ls_hakyun,	  :l_chasu,       :ll_ip_napip,   :ll_napip,
														 :ll_haksengwhe, :ll_gyojae,     :ll_album,    0,
														 :ll_memory,     :ll_dongchang,  TO_CHAR(SYSDATE, 'YYYYMMDD'),
														 :gs_empcode,           :gs_ip,
														 sysdate,        '',             '',
														 sysdate) USING SQLCA ;
							IF sqlca.sqlcode  <> 0 THEN
								messagebox("알림", '분납 관리 저장중 오류_우리' + sqlca.sqlerrtext)
								rollback USING SQLCA ;
								return
							END IF
							
	     //분납자가 분납금액의 합과 납부할 금액이 같을경우 완납으로 처리
				UPDATE 	HAKSA.DUNGROK_GWANRI
				SET 		WAN_YN      = 'Y'
				WHERE 	HAKBUN		= 	:ls_hakbun
				AND 		YEAR			= 	:ls_year
				AND 		HAKGI			= 	:ls_hakgi
				AND		DUNGROK		= 	DUNGROK_N
				AND		DUNG_YN		=	'Y'
				AND		BUN_YN		=	'Y'
				AND		WAN_YN		=	'N'
			    USING SQLCA ;


			ELSE
				
				

	//			정상적으로 1차에 완납등록자 조회 
				SELECT	HAKBUN,
							SU_HAKYUN,
							CHASU
				INTO 		:af_hakbun,
							:af_su_hakyun,
							:lf_chasu
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN	= 'Y'
				AND		DUNG_YN	= 'Y'
				USING SQLCA ;
	
	//			정상적으로 1차에 완납등록자이면서 추가납인경우 조회 
				SELECT	COUNT(HAKBUN)
				INTO 		:ll_count
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN	= 'N'
				AND		DUNG_YN	= 'N'
				AND		CHU_YN	= 'Y'
				USING SQLCA ;
	
	//			비정상적으로 1차에 완납추가납인경우 조회 
				SELECT	HAKBUN,
							SU_HAKYUN,
							NVL(HAKJUM, 0),
							NVL(IPHAK, 0),
							NVL(DUNGROK, 0),
							NVL(HAKSENGWHE, 0),
							NVL(GYOJAE, 0),
							NVL(ALBUM, 0),
							NVL(HAKWHE, 0),
							NVL(MEMORIAL, 0),
							NVL(DONGCHANGWHE, 0),
							NVL(I_JANGHAK, 0),
							NVL(D_JANGHAK, 0),
							NVL(JANGHAK_ID, ''),
							MAX(CHASU)
				INTO 		:bi_hakbun,
							:bi_su_hakyun,
							:bi_hakjum,	
							:bi_iphak,	
							:bi_dungrok,	
							:bi_haksengwhe,	
							:bi_gyojae,	
							:bi_album,	
							:bi_hakwhe,	
							:bi_memorial, 
							:bi_dongchangwhe,	
							:bi_i_janghak,		
							:bi_d_janghak,	
							:bi_janghak_id, 						
							:bi_chasu
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN	= 'Y'			
				AND		DUNG_YN	= 'N'
				AND		CHU_YN	= 'Y'
				GROUP BY	HAKBUN,
							SU_HAKYUN,
							HAKJUM,
							IPHAK,
							DUNGROK,
							HAKSENGWHE,
							GYOJAE,
							ALBUM,
							HAKWHE,
							MEMORIAL,
							DONGCHANGWHE,
							I_JANGHAK,
							D_JANGHAK,
							JANGHAK_ID
					USING SQLCA ;
			
				IF ls_hakbun = af_hakbun and ll_count <> 1 THEN
		
						messagebox("확인",ls_hakbun +'이 학생은 완납이 되어있습니다.')
						lf_chasu =	lf_chasu + 1
						//INSERT
					  INSERT INTO HAKSA.DUNGROK_GWANRI  		
									 ( HAKBUN,   		YEAR,				HAKGI,			SU_HAKYUN,	   CHASU,  		HAKJUM,		   IPHAK,	   DUNGROK,
									  HAKSENGWHE,  	GYOJAE,  		ALBUM,   		HAKWHE,   		MEMORIAL,   DONGCHANGWHE,  I_JANGHAK,  D_JANGHAK,
									  JANGHAK_ID,  	IPHAK_N,  		DUNGROK_N,   	HAKSENGWHE_N,  GYOJAE_N,   ALBUM_N,   		HAKWHE_N,   MEMORIAL_N,
									  DONGCHANGWHE_N, NAPBU_DATE,   						BANK_ID,   		WAN_YN,   	DUNG_YN,   		BUN_YN,  	CHU_YN,
									  HWAN_YN,   		BANK_YN,   		DUNGROK_GUBUN, WORKER,   		IPADDR,   	WORK_DATE,   
									  JOB_UID,   JOB_ADD,   JOB_DATE)
						  VALUES   (:ls_hakbun,   	:ls_year,		:ls_hakgi,		:af_su_hakyun,	:lf_chasu,  0,					0,				0,   
									  0,   				0, 				0,   				0,   				0,  	 		0,  	 			0,  	 		0,   
									  null,   			:ll_ip_napip,	:ll_napip, 		:ll_haksengwhe,:ll_gyojae,	:ll_album,		0,				:ll_memory,
									  :ll_dongchang,	TO_CHAR(SYSDATE, 'YYYYMMDD'),	'2',				'Y',			'N',				'N',			'Y',
									  'N',				'0',				'1',				NULL,				NULL,			SYSDATE,
									  NULL,				NULL,				SYSDATE  ) USING SQLCA ;
	
				ELSEif 	ls_hakbun = af_hakbun and ll_count = 1 THEN		
			
							//추가납부만 Update
							UPDATE	HAKSA.DUNGROK_GWANRI
							SET		IPHAK_N			=	:ll_ip_napip	,
										DUNGROK_N		=	:ll_napip		,
										HAKSENGWHE_N	=	:ll_haksengwhe	,
										GYOJAE_N			= 	:ll_gyojae		,
										DONGCHANGWHE_N	= 	:ll_dongchang	,
										MEMORIAL_N		= 	:ll_memory		,
										ALBUM_N			=  :ll_album		,
										BANK_ID			=	'2'				,
										NAPBU_DATE		=	TO_CHAR(SYSDATE, 'YYYYMMDD'),
										WAN_YN			=	'Y'				
							WHERE		YEAR		=	:ls_year
							AND		HAKGI		=	:ls_hakgi
							AND		HAKBUN 	= 	:ls_hakbun	
							AND		CHU_YN		=	'Y'
							USING SQLCA ;
							
				ELSEIF 	ls_hakbun <> af_hakbun and ll_count <> 1  THEN	
					
					if bi_chasu = 1  then
						
						messagebox("확인_우리",ls_hakbun +'이 학생은 등록이 아닌 추가납이 되어있습니다.')
						bi_chasu =	bi_chasu + 1
							//INSERT
						  INSERT INTO HAKSA.DUNGROK_GWANRI  		
										 ( HAKBUN,   		YEAR,				HAKGI,			SU_HAKYUN,	   CHASU,  		HAKJUM,		   IPHAK,	   DUNGROK,
										  HAKSENGWHE,  	GYOJAE,  		ALBUM,   		HAKWHE,   		MEMORIAL,   DONGCHANGWHE,  I_JANGHAK,  D_JANGHAK,
										  JANGHAK_ID,  	IPHAK_N,  		DUNGROK_N,   	HAKSENGWHE_N,  GYOJAE_N,   ALBUM_N,   		HAKWHE_N,   MEMORIAL_N,
										  DONGCHANGWHE_N, NAPBU_DATE,   						BANK_ID,   		WAN_YN,   	DUNG_YN,   		BUN_YN,  	CHU_YN,
										  HWAN_YN,   		BANK_YN,   		DUNGROK_GUBUN, WORKER,   		IPADDR,   	WORK_DATE,   
										  JOB_UID,   JOB_ADD,   JOB_DATE)
							  VALUES   (:ls_hakbun,   	:ls_year,		:ls_hakgi,		:bi_su_hakyun,	:bi_chasu,  :bi_hakjum,		:bi_iphak,  :bi_dungrok,
										  :bi_haksengwhe, :bi_gyojae, 	:bi_album,   	:bi_hakwhe,   	:bi_memorial,:bi_dongchangwhe,:bi_i_janghak,:bi_d_janghak, 
										  :bi_janghak_id, :ll_ip_napip,	:ll_napip, 		:ll_haksengwhe,:ll_gyojae,	:ll_album,		0,				:ll_memory,
										  :ll_dongchang,	TO_CHAR(SYSDATE, 'YYYYMMDD'),	'2',				'Y',			'Y',				'N',			'N',
										  'N',				'0',				'1',				NULL,				NULL,			SYSDATE,
										  NULL,				NULL,				SYSDATE  ) USING SQLCA ;
					elseif ll_hakjum = 0 then 
	
						//Update
						UPDATE	HAKSA.DUNGROK_GWANRI
						SET		IPHAK_N			=	:ll_ip_napip	,
									DUNGROK_N		=	:ll_napip		,
									HAKSENGWHE_N	=	:ll_haksengwhe	,
									GYOJAE_N			= 	:ll_gyojae		,
									DONGCHANGWHE_N	= 	:ll_dongchang	,
									MEMORIAL_N		= 	:ll_memory		,
									ALBUM_N			=  :ll_album		,
									BANK_ID			=	'2'				,
									NAPBU_DATE		=	TO_CHAR(SYSDATE, 'YYYYMMDD'),
									WAN_YN			=	'Y'				,
									CHU_YN			=	'Y'	
						WHERE		YEAR		=	:ls_year
						AND		HAKGI		=	:ls_hakgi
						AND		HAKBUN	= 	:ls_hakbun	
						USING SQLCA ;
					else
	
						//Update
						UPDATE	HAKSA.DUNGROK_GWANRI
						SET		IPHAK_N			=	:ll_ip_napip	,
									DUNGROK_N		=	:ll_napip		,
									HAKSENGWHE_N	=	:ll_haksengwhe	,
									GYOJAE_N			= 	:ll_gyojae		,
									DONGCHANGWHE_N	= 	:ll_dongchang	,
									MEMORIAL_N		= 	:ll_memory		,
									ALBUM_N			=  :ll_album		,
									BANK_ID			=	'2'				,
									NAPBU_DATE		=	TO_CHAR(SYSDATE, 'YYYYMMDD'),
									WAN_YN			=	'Y'				,
									DUNG_YN			=	'Y'	
						WHERE		YEAR		=	:ls_year
						AND		HAKGI		=	:ls_hakgi
						AND		HAKBUN	= 	:ls_hakbun	
						USING SQLCA ;				
					END IF
				END IF
							
				if sqlca.sqlcode <> 0 then
					messagebox("오류!",ls_hakbun + " 처리중 오류발생_우리~r~n" + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					fileclose(fnum)
					return
				end if			
		  END IF
	
			st_cnt.text = string(i) + '/' + string(mok)

/* 수납관리 저장 */
        l_cnt        = 0
        SELECT nvl(count(*), 0)
		    INTO :l_cnt
			 FROM haksa.sunap_gwanri
			WHERE hakbun    = :ls_hakbun
			  AND year      = :ls_year
			  AND hakgi     = :ls_hakgi
			  AND bank_id   = '2'
			  USING SQLCA ;
		  IF sqlca.sqlnrows  = 0 THEN
			  l_cnt         = 1
		  ELSE
			  l_cnt         = l_cnt + 1
		  END IF
		  INSERT INTO haksa.sunap_gwanri (HAKBUN,         YEAR,           HAKGI,        BANK_ID,
                                        CHASU,          HAKJUM,         IPHAK,        DUNGROK,
                                        HAKSENGWHE,     GYOJAE,         ALBUM,        HAKWHE,
                                        MEMORIAL,       DONGCHANGWHE,   NAPBU_DATE,
													 WORKER,                         IPADDR,
                                        WORK_DATE,      JOB_UID,        JOB_ADD,
                                        JOB_DATE)
				        values             (:ls_hakbun,     :ls_year,       :ls_hakgi,    '2',
						                      :l_cnt,         0,              :ll_ip_napip, :ll_napip,
													 :ll_haksengwhe, :ll_gyojae,     :ll_album,    0,
													 :ll_memory,     :ll_dongchang,  TO_CHAR(SYSDATE, 'YYYYMMDD'),
													 :gs_empcode,           :gs_ip,
													 sysdate,        '',             '',
													 sysdate) USING SQLCA ;
						IF sqlca.sqlcode  <> 0 THEN
							messagebox("알림", '수납 관리 저장중 오류_우리' + sqlca.sqlerrtext)
							rollback USING SQLCA ;
							return
						END IF


		next							
		
	//KOOKMIN BANK	
	CASE '3'													
		
		mok = flen / (128 + 2)
		
		for i = 1 to mok
	
			bytes_read = fileread(fnum, ls_line)
			
			if bytes_read = -100 then
				fileclose(fnum) 
				EXIT
			end if
			
			ls_chk	=	mid(ls_line, 1, 1)
			
			if ls_chk <> ' ' then
				messagebox("오류!","국민은행 형식의 File이 아닙니다.~r~n다시 선택해 주세요.")
				FileClose(fnum)
				return
			end if
			
			ls_hakbun		=	trim(mid(ls_line, 13, 12))				//학번
			ls_hakyun		=	trim(mid(ls_line, 25, 1))				//학년 
			ll_hakjum		=	long(trim(mid(ls_line, 42, 2)))		//학점		
			ll_ip_napip		=	long(trim(mid(ls_line, 44, 7)))		//입학금
			ll_napip			=	long(trim(mid(ls_line, 51, 7)))		//등록금			
////			if	ll_ip_napip =	ll_iphak  and ll_napip > 0 then
			if	ll_ip_napip > 0 then
				ll_napip		=	long(trim(mid(ls_line, 65, 7)))		//등록금
				ll_napip		=	ll_napip - ll_ip_napip
			else	
				ll_napip		=	long(trim(mid(ls_line, 65, 7)))		//등록금
			end if
			ll_haksengwhe	=	long(trim(mid(ls_line, 72, 7)))		//학생회비
			ll_gyojae		= 	long(trim(mid(ls_line, 79, 7)))		//교재비
			ll_dongchang	= 	long(trim(mid(ls_line, 86, 7)))		//동창회비
			ll_memory		= 	long(trim(mid(ls_line, 93, 7)))		//졸업기념비
			ll_album			= 	long(trim(mid(ls_line, 100, 7)))		//졸업앨범비
			ls_dr_ilja		=	mid(ls_line, 121, 8)						//납입일자

/*   분납자 체크 (국민은행) */
         ls_bunnap      = 'N'
         select nvl(count(*), 0)
			  into :l_cnt
			  from haksa.bunnap_gwanri c, ( select hakbun, max(chasu) chasu
                                           from haksa.bunnap_gwanri
                                          where year   = :ls_year
                                            and hakgi  = :ls_hakgi
														  and hakbun = :ls_hakbun
                                            and nvl(dungrok, 0) <> 0
                                          group by hakbun) d
            where c.year    = :ls_year
              and c.hakgi   = :ls_hakgi
				  and c.hakbun  = :ls_hakbun
              and c.hakbun  = d.hakbun
              and c.chasu   = d.chasu
		    USING SQLCA ;
			IF sqlca.sqlnrows  = 0 THEN
				l_cnt           = 0
			END IF
			IF l_cnt           > 0 THEN
				ls_bunnap       = 'Y'
			END IF

			IF ls_bunnap       = 'Y' THEN
				UPDATE HAKSA.DUNGROK_GWANRI
				   SET IPHAK_N          = IPHAK_N + NVL(:ll_ip_napip, 0),
						 DUNGROK_N        = DUNGROK_N + NVL(:ll_napip, 0),
						 HAKSENGWHE_N     = HAKSENGWHE_N + NVL(:ll_haksengwhe, 0),
						 GYOJAE_N         = GYOJAE_N + NVL(:ll_gyojae, 0),
						 DONGCHANGWHE_N   = DONGCHANGWHE_N + NVL(:ll_dongchang, 0),
						 MEMORIAL_N	      = MEMORIAL_N + NVL(:ll_memory, 0),
						 ALBUM_N          = ALBUM_N + NVL(:ll_album, 0),
						 BANK_ID          = '3',
						 BUN_YN           = 'Y',
						 DUNG_YN          = 'Y',
						 NAPBU_DATE       = TO_CHAR(SYSDATE, 'YYYYMMDD')
				 WHERE YEAR             = :ls_year
				   AND HAKGI            = :ls_hakgi
				   AND HAKBUN           = :ls_hakbun
				 USING SQLCA ;
				 
				IF sqlca.sqlcode       <> 0 THEN
					messagebox("저장", '등록급 납부 수정중 오류_국민' + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					return
				END IF
				
				SELECT nvl(max(chasu), 0)
				  INTO :l_chasu
				  FROM haksa.dungrok_bunnap
				 WHERE hakbun           = :ls_hakbun
				   AND year             = :ls_year
					AND hakgi            = :ls_hakgi
			     USING SQLCA ;
            IF sqlca.sqlnrows       = 0 THEN
					l_chasu    = 1
				ELSE
					l_chasu    = l_chasu + 1
				END IF
			  INSERT INTO haksa.dungrok_bunnap (HAKBUN,       YEAR,           HAKGI,        BANK_ID,
														 SU_HAKYUN,		  CHASU,          IPHAK,        DUNGROK,
														 HAKSENGWHE,     GYOJAE,         ALBUM,        HAKWHE,
														 MEMORIAL,       DONGCHANGWHE,   NAPBU_DATE,
														 WORKER,                         IPADDR,
														 WORK_DATE,      JOB_UID,        JOB_ADD,
														 JOB_DATE)
							  values             (:ls_hakbun,     :ls_year,       :ls_hakgi,    '3',
														 :ls_hakyun,	  :l_chasu,       :ll_ip_napip,   :ll_napip,
														 :ll_haksengwhe, :ll_gyojae,     :ll_album,    0,
														 :ll_memory,     :ll_dongchang,  TO_CHAR(SYSDATE, 'YYYYMMDD'),
														 :gs_empcode,           :gs_ip,
														 sysdate,        '',             '',
														 sysdate) USING SQLCA ;
							IF sqlca.sqlcode  <> 0 THEN
								messagebox("알림", '분납 관리 저장중 오류_국민' + sqlca.sqlerrtext)
								rollback USING SQLCA ;
								return
							END IF
			ELSE



	//			정상적으로 1차에 완납등록자 조회 			
				SELECT	HAKBUN,
							SU_HAKYUN,
							CHASU
				INTO 		:af_hakbun,
							:af_su_hakyun,
							:lf_chasu
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN	= 'Y'
				AND		DUNG_YN	= 'Y'
				USING SQLCA ;
	
	//			정상적으로 1차에 완납등록자이면서 추가납인경우 조회 
				SELECT	COUNT(HAKBUN)
				INTO 		:ll_count
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN	= 'N'
				AND		DUNG_YN	= 'N'
				AND		CHU_YN	= 'Y'
				USING SQLCA ;
				
	//			비정상적으로 1차에 완납추가납인경우 조회 
				SELECT	HAKBUN,
							SU_HAKYUN,
							NVL(HAKJUM, 0),
							NVL(IPHAK, 0),
							NVL(DUNGROK, 0),
							NVL(HAKSENGWHE, 0),
							NVL(GYOJAE, 0),
							NVL(ALBUM, 0),
							NVL(HAKWHE, 0),
							NVL(MEMORIAL, 0),
							NVL(DONGCHANGWHE, 0),
							NVL(I_JANGHAK, 0),
							NVL(D_JANGHAK, 0),
							NVL(JANGHAK_ID, ''),
							MAX(CHASU)
				INTO 		:bi_hakbun,
							:bi_su_hakyun,
							:bi_hakjum,	
							:bi_iphak,	
							:bi_dungrok,	
							:bi_haksengwhe,	
							:bi_gyojae,	
							:bi_album,	
							:bi_hakwhe,	
							:bi_memorial, 
							:bi_dongchangwhe,	
							:bi_i_janghak,		
							:bi_d_janghak,	
							:bi_janghak_id, 						
							:bi_chasu
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN	= 'Y'			
				AND		DUNG_YN	= 'N'
				AND		CHU_YN	= 'Y'
				GROUP BY	HAKBUN,
							SU_HAKYUN,
							HAKJUM,
							IPHAK,
							DUNGROK,
							HAKSENGWHE,
							GYOJAE,
							ALBUM,
							HAKWHE,
							MEMORIAL,
							DONGCHANGWHE,
							I_JANGHAK,
							D_JANGHAK,
							JANGHAK_ID
				USING SQLCA ;

				IF ls_hakbun = af_hakbun and ll_count <> 1 THEN
					messagebox("확인",ls_hakbun +'이 학생은 완납이 되어있습니다.')
					lf_chasu =	lf_chasu + 1
					//INSERT
						  INSERT INTO HAKSA.DUNGROK_GWANRI  		
										 ( HAKBUN,   		YEAR,				HAKGI,			SU_HAKYUN,	   CHASU,  		HAKJUM,		   IPHAK,	   DUNGROK,
										  HAKSENGWHE,  	GYOJAE,  		ALBUM,   		HAKWHE,   		MEMORIAL,   DONGCHANGWHE,  I_JANGHAK,  D_JANGHAK,
										  JANGHAK_ID,  	IPHAK_N,  		DUNGROK_N,   	HAKSENGWHE_N,  GYOJAE_N,   ALBUM_N,   		HAKWHE_N,   MEMORIAL_N,
										  DONGCHANGWHE_N, NAPBU_DATE,   						BANK_ID,   		WAN_YN,   	DUNG_YN,   		BUN_YN,  	CHU_YN,
										  HWAN_YN,   		BANK_YN,   		DUNGROK_GUBUN, WORKER,   		IPADDR,   	WORK_DATE,   
										  JOB_UID,   JOB_ADD,   JOB_DATE)
							  VALUES   (:ls_hakbun,   	:ls_year,		:ls_hakgi,		:af_su_hakyun,	:lf_chasu,  0,					0,				0,   
										  0,   				0, 				0,   				0,   				0,  	 		0,  	 			0,  	 		0,   
										  null,   			:ll_ip_napip,	:ll_napip, 		:ll_haksengwhe,:ll_gyojae,	:ll_album,		0,				:ll_memory,
										  :ll_dongchang,	:ls_dr_ilja,						'3',				'Y',			'N',				'N',			'Y',
										  'N',				'0',				'1',				NULL,				NULL,			SYSDATE,
										  NULL,				NULL,				SYSDATE  ) USING SQLCA ;
										  
				ELSEif 	ls_hakbun = af_hakbun and ll_count = 1 THEN		
							//추가납부만 Update
							UPDATE	HAKSA.DUNGROK_GWANRI
							SET		IPHAK_N			=	:ll_ip_napip	,
										DUNGROK_N		=	:ll_napip		,
										HAKSENGWHE_N	=	:ll_haksengwhe	,
										GYOJAE_N			= 	:ll_gyojae		,
										DONGCHANGWHE_N	= 	:ll_dongchang	,
										MEMORIAL_N		= 	:ll_memory		,
										ALBUM_N			=  :ll_album		,
										NAPBU_DATE		=	:ls_dr_ilja		,
										BANK_ID			=	'3'				,
										WAN_YN			=	'Y'				
							WHERE		YEAR		=	:ls_year
							AND		HAKGI		=	:ls_hakgi
							AND		HAKBUN 	= 	:ls_hakbun	
							AND		CHU_YN		=	'Y'
							USING SQLCA ;
							
				ELSEIF 	ls_hakbun <> af_hakbun and ll_count <> 1 THEN	
					if bi_chasu = 1  then
						messagebox("확인",ls_hakbun +'이 학생은 등록이 아닌 추가납이 되어있습니다.')
						bi_chasu =	bi_chasu + 1
							//INSERT
						  INSERT INTO HAKSA.DUNGROK_GWANRI  		
										 ( HAKBUN,   		YEAR,				HAKGI,			SU_HAKYUN,	   CHASU,  		HAKJUM,		   IPHAK,	   DUNGROK,
										  HAKSENGWHE,  	GYOJAE,  		ALBUM,   		HAKWHE,   		MEMORIAL,   DONGCHANGWHE,  I_JANGHAK,  D_JANGHAK,
										  JANGHAK_ID,  	IPHAK_N,  		DUNGROK_N,   	HAKSENGWHE_N,  GYOJAE_N,   ALBUM_N,   		HAKWHE_N,   MEMORIAL_N,
										  DONGCHANGWHE_N, NAPBU_DATE,   						BANK_ID,   		WAN_YN,   	DUNG_YN,   		BUN_YN,  	CHU_YN,
										  HWAN_YN,   		BANK_YN,   		DUNGROK_GUBUN, WORKER,   		IPADDR,   	WORK_DATE,   
										  JOB_UID,   JOB_ADD,   JOB_DATE)
							  VALUES   (:ls_hakbun,   	:ls_year,		:ls_hakgi,		:bi_su_hakyun,	:bi_chasu,  :bi_hakjum,		:bi_iphak,  :bi_dungrok,
										  :bi_haksengwhe, :bi_gyojae, 	:bi_album,   	:bi_hakwhe,   	:bi_memorial,:bi_dongchangwhe,:bi_i_janghak,:bi_d_janghak, 
										  :bi_janghak_id, :ll_ip_napip,	:ll_napip, 		:ll_haksengwhe,:ll_gyojae,	:ll_album,		0,				:ll_memory,
										  :ll_dongchang,	TO_CHAR(SYSDATE, 'YYYYMMDD'),	'3',				'Y',			'Y',				'N',			'N',
										  'N',				'0',				'1',				NULL,				NULL,			SYSDATE,
										  NULL,				NULL,				SYSDATE  ) USING SQLCA ;
					elseif ll_hakjum = 0 then 
						//Update
						UPDATE	HAKSA.DUNGROK_GWANRI
						SET		IPHAK_N			=	:ll_ip_napip	,
									DUNGROK_N		=	:ll_napip		,
									HAKSENGWHE_N	=	:ll_haksengwhe	,
									GYOJAE_N			= 	:ll_gyojae		,
									DONGCHANGWHE_N	= 	:ll_dongchang	,
									MEMORIAL_N		= 	:ll_memory		,
									ALBUM_N			=  :ll_album		,
									BANK_ID			=	'3'				,
									NAPBU_DATE		=	TO_CHAR(SYSDATE, 'YYYYMMDD'),
									WAN_YN			=	'Y'				,
									CHU_YN			=	'Y'	
						WHERE		YEAR		=	:ls_year
						AND		HAKGI		=	:ls_hakgi
						AND		HAKBUN	= 	:ls_hakbun	
						USING SQLCA ;
					else
						//Update
						UPDATE	HAKSA.DUNGROK_GWANRI
						SET		IPHAK_N			=	:ll_ip_napip	,
									DUNGROK_N		=	:ll_napip		,
									HAKSENGWHE_N	=	:ll_haksengwhe	,
									GYOJAE_N			= 	:ll_gyojae		,
									DONGCHANGWHE_N	= 	:ll_dongchang	,
									MEMORIAL_N		= 	:ll_memory		,
									ALBUM_N			=  :ll_album		,
									BANK_ID			=	'3'				,
									NAPBU_DATE		=	TO_CHAR(SYSDATE, 'YYYYMMDD'),
									WAN_YN			=	'Y'				,
									DUNG_YN			=	'Y'	
						WHERE		YEAR		=	:ls_year
						AND		HAKGI		=	:ls_hakgi
						AND		HAKBUN	= 	:ls_hakbun	
						USING SQLCA ;
					END IF
				END IF
				
				if sqlca.sqlcode <> 0 then
					messagebox("오류!",ls_hakbun + " 처리중 오류발생_국민~r~n" + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					fileclose(fnum)
					return	
				end if
	
			END IF
			st_cnt.text = string(i) + '/' + string(mok)


/* 수납관리 저장 */
        l_cnt        = 0
        SELECT nvl(count(*), 0)
		    INTO :l_cnt
			 FROM haksa.sunap_gwanri
			WHERE hakbun    = :ls_hakbun
			  AND year      = :ls_year
			  AND hakgi     = :ls_hakgi
			  AND bank_id   = '3'
		USING SQLCA ;
		  IF sqlca.sqlnrows  = 0 THEN
			  l_cnt         = 1
		  ELSE
			  l_cnt         = l_cnt + 1
		  END IF
		  INSERT INTO haksa.sunap_gwanri (HAKBUN,         YEAR,           HAKGI,        BANK_ID,
                                        CHASU,          HAKJUM,         IPHAK,        DUNGROK,
                                        HAKSENGWHE,     GYOJAE,         ALBUM,        HAKWHE,
                                        MEMORIAL,       DONGCHANGWHE,   NAPBU_DATE,
													 WORKER,                         IPADDR,
                                        WORK_DATE,      JOB_UID,        JOB_ADD,
                                        JOB_DATE)
				        values             (:ls_hakbun,     :ls_year,       :ls_hakgi,    '3',
						                      :l_cnt,         0,              :ll_ip_napip, :ll_napip,
													 :ll_haksengwhe, :ll_gyojae,     :ll_album,    0,
													 :ll_memory,     :ll_dongchang,  TO_CHAR(SYSDATE, 'YYYYMMDD'),
													 :gs_empcode,           :gs_ip,
													 sysdate,        '',             '',
													 sysdate) USING SQLCA ;
						IF sqlca.sqlcode  <> 0 THEN
							messagebox("알림", '수납 관리 저장중 오류_국민' + sqlca.sqlerrtext)
							rollback USING SQLCA ;
							return
						END IF



		NEXT

	//농협-인터넷대출
	CASE '4'													

		mok = flen / (189 + 2)
	
		for i = 1 to mok
	
			bytes_read = fileread(fnum, ls_line)
			
			if bytes_read = -100 then
				fileclose(fnum) 
				EXIT
			end if
			
			ls_chk	=	mid(ls_line, 1, 1)

			if ls_chk = ' ' then
				messagebox("오류!","농협 형식의 File이 아닙니다.~r~n다시 선택해 주세요.")
				FileClose(fnum)
				return
			end if
			
			ls_hakbun		=	trim(mid(ls_line, 1, 15))				//학번
			ls_hakyun		=	trim(mid(ls_line, 73, 1))				//학년 
			
			ll_ip_napip		=	long(trim(mid(ls_line, 75, 7)))		//입학금
			ll_napip			=	long(trim(mid(ls_line, 82, 7)))		//등록금			
////			if	ll_ip_napip =	ll_iphak  and ll_napip > 0 then
			if	ll_ip_napip > 0 then
				ll_napip		=	long(trim(mid(ls_line, 131, 7)))		//등록금
				ll_napip		=	ll_napip - ll_ip_napip
			else	
				ll_napip		=	long(trim(mid(ls_line, 131, 7)))		//등록금
			end if

			ll_haksengwhe	=	long(trim(mid(ls_line, 138, 7)))		//학생회비
			ll_gyojae		= 	long(trim(mid(ls_line, 145, 7)))		//교재비
//			ll_dongchang	= 	long(trim(mid(ls_line, 166, 7)))		//동창회비
//			ll_memory		= 	long(trim(mid(ls_line, 159, 7)))		//졸업기념비
//			ll_album			= 	long(trim(mid(ls_line, 152, 7)))		//졸업앨범비
			ll_album			= 	long(trim(mid(ls_line, 166, 7)))		//졸업앨범비
			ll_dongchang	= 	long(trim(mid(ls_line, 159, 7)))		//동창회비
			ll_memory		= 	long(trim(mid(ls_line, 152, 7)))		//졸업기념비
			ls_dr_ilja		=	mid(ls_line, 180, 8)						//납입일자


/*   분납자 체크 (농협) */
         ls_bunnap      = 'N'
         select nvl(count(*), 0)
			  into :l_cnt
			  from haksa.bunnap_gwanri c, ( select hakbun, max(chasu) chasu
                                           from haksa.bunnap_gwanri
                                          where year   = :ls_year
                                            and hakgi  = :ls_hakgi
														  and hakbun = :ls_hakbun
                                            and nvl(dungrok, 0) <> 0
                                          group by hakbun) d
            where c.year    = :ls_year
              and c.hakgi   = :ls_hakgi
				  and c.hakbun  = :ls_hakbun
              and c.hakbun  = d.hakbun
              and c.chasu   = d.chasu
		   USING SQLCA ;
			
			IF sqlca.sqlnrows  = 0 THEN
				l_cnt           = 0
			END IF
			IF l_cnt           > 0 THEN
				ls_bunnap       = 'Y'
			END IF
			IF ls_bunnap       = 'Y' THEN
				UPDATE HAKSA.DUNGROK_GWANRI
				   SET IPHAK_N          = IPHAK_N + NVL(:ll_ip_napip, 0),
						 DUNGROK_N        = DUNGROK_N + NVL(:ll_napip, 0),
						 HAKSENGWHE_N     = HAKSENGWHE_N + NVL(:ll_haksengwhe, 0),
						 GYOJAE_N         = GYOJAE_N + NVL(:ll_gyojae, 0),
						 DONGCHANGWHE_N   = DONGCHANGWHE_N + NVL(:ll_dongchang, 0),
						 MEMORIAL_N	      = MEMORIAL_N + NVL(:ll_memory, 0),
						 ALBUM_N          = ALBUM_N + NVL(:ll_album, 0),
						 BANK_ID          = '4',
						 BUN_YN           = 'Y',
						 DUNG_YN          = 'Y',
						 NAPBU_DATE       = TO_CHAR(SYSDATE, 'YYYYMMDD')
				 WHERE YEAR             = :ls_year
				   AND HAKGI            = :ls_hakgi
				   AND HAKBUN           = :ls_hakbun
				 USING SQLCA ;
					
				SELECT nvl(max(chasu), 0)
				  INTO :l_chasu
				  FROM haksa.dungrok_bunnap
				 WHERE hakbun           = :ls_hakbun
				   AND year             = :ls_year
					AND hakgi            = :ls_hakgi
				 USING SQLCA ;
            IF sqlca.sqlnrows       = 0 THEN
					l_chasu    = 1
				ELSE
					l_chasu    = l_chasu + 1
				END IF
			  INSERT INTO haksa.dungrok_bunnap (HAKBUN,       YEAR,           HAKGI,        BANK_ID,
														 SU_HAKYUN,		  CHASU,          IPHAK,          DUNGROK,
														 HAKSENGWHE,     GYOJAE,         ALBUM,        HAKWHE,
														 MEMORIAL,       DONGCHANGWHE,   NAPBU_DATE,
														 WORKER,                         IPADDR,
														 WORK_DATE,      JOB_UID,        JOB_ADD,
														 JOB_DATE)
							  values             (:ls_hakbun,     :ls_year,       :ls_hakgi,    '4',
														 :ls_hakyun,	  :l_chasu,       :ll_ip_napip,   :ll_napip,
														 :ll_haksengwhe, :ll_gyojae,     :ll_album,    0,
														 :ll_memory,     :ll_dongchang,  TO_CHAR(SYSDATE, 'YYYYMMDD'),
														 :gs_empcode,           :gs_ip,
														 sysdate,        '',             '',
														 sysdate) USING SQLCA ;
							IF sqlca.sqlcode  <> 0 THEN
								messagebox("알림", '분납 관리 저장중 오류' + sqlca.sqlerrtext)
								rollback USING SQLCA ;
								return
							END IF
			ELSE



	//			정상적으로 1차에 완납등록자 조회 				
				SELECT	HAKBUN,
							SU_HAKYUN,
							CHASU
				INTO 		:af_hakbun,
							:af_su_hakyun,
							:lf_chasu
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN	= 'Y'
				AND		DUNG_YN	= 'Y'
				USING SQLCA ;
	
	//			정상적으로 1차에 완납등록자이면서 추가납인경우 조회 
				SELECT	COUNT(HAKBUN)
				INTO 		:ll_count
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN	= 'N'
				AND		DUNG_YN	= 'N'
				AND		CHU_YN	= 'Y'
				USING SQLCA ;
	
	//			비정상적으로 1차에 완납추가납인경우 조회 
				SELECT	HAKBUN,
							SU_HAKYUN,
							NVL(HAKJUM, 0),
							NVL(IPHAK, 0),
							NVL(DUNGROK, 0),
							NVL(HAKSENGWHE, 0),
							NVL(GYOJAE, 0),
							NVL(ALBUM, 0),
							NVL(HAKWHE, 0),
							NVL(MEMORIAL, 0),
							NVL(DONGCHANGWHE, 0),
							NVL(I_JANGHAK, 0),
							NVL(D_JANGHAK, 0),
							NVL(JANGHAK_ID, ''),
							MAX(CHASU)
				INTO 		:bi_hakbun,
							:bi_su_hakyun,
							:bi_hakjum,	
							:bi_iphak,	
							:bi_dungrok,	
							:bi_haksengwhe,	
							:bi_gyojae,	
							:bi_album,	
							:bi_hakwhe,	
							:bi_memorial, 
							:bi_dongchangwhe,	
							:bi_i_janghak,		
							:bi_d_janghak,	
							:bi_janghak_id, 						
							:bi_chasu
				FROM		HAKSA.DUNGROK_GWANRI
				WHERE		YEAR		= :ls_year
				AND		HAKGI		= :ls_hakgi
				AND		HAKBUN	= :ls_hakbun
				AND		WAN_YN	= 'Y'			
				AND		DUNG_YN	= 'N'
				AND		CHU_YN	= 'Y'
				GROUP BY	HAKBUN,
							SU_HAKYUN,
							HAKJUM,
							IPHAK,
							DUNGROK,
							HAKSENGWHE,
							GYOJAE,
							ALBUM,
							HAKWHE,
							MEMORIAL,
							DONGCHANGWHE,
							I_JANGHAK,
							D_JANGHAK,
							JANGHAK_ID
				USING SQLCA ;
	
		
				IF ls_hakbun = af_hakbun and ll_count <> 1 THEN
					messagebox("확인",ls_hakbun +'이 학생은 완납이 되어있습니다.')
					lf_chasu =	lf_chasu + 1
					//INSERT
						  INSERT INTO HAKSA.DUNGROK_GWANRI  		
										 ( HAKBUN,   		YEAR,				HAKGI,			SU_HAKYUN,	   CHASU,  		HAKJUM,		   IPHAK,	   DUNGROK,
										  HAKSENGWHE,  	GYOJAE,  		ALBUM,   		HAKWHE,   		MEMORIAL,   DONGCHANGWHE,  I_JANGHAK,  D_JANGHAK,
										  JANGHAK_ID,  	IPHAK_N,  		DUNGROK_N,   	HAKSENGWHE_N,  GYOJAE_N,   ALBUM_N,   		HAKWHE_N,   MEMORIAL_N,
										  DONGCHANGWHE_N, NAPBU_DATE,   						BANK_ID,   		WAN_YN,   	DUNG_YN,   		BUN_YN,  	CHU_YN,
										  HWAN_YN,   		BANK_YN,   		DUNGROK_GUBUN, WORKER,   		IPADDR,   	WORK_DATE,   
										  JOB_UID,   		JOB_ADD,   JOB_DATE)
							  VALUES   (:ls_hakbun,   	:ls_year,		:ls_hakgi,		:af_su_hakyun,	:lf_chasu,  0,					0,				0,   
										  0,   				0, 				0,   				0,   				0,  	 		0,  	 			0,  	 		0,   
										  null,   			:ll_ip_napip,	:ll_napip, 		:ll_haksengwhe,:ll_gyojae,	:ll_album,		0,				:ll_memory,
										  :ll_dongchang,	:ls_dr_ilja,						'4',				'Y',			'N',				'N',			'Y',
										  'N',				'0',				'1',				NULL,				NULL,			SYSDATE,
										  NULL,				NULL,				SYSDATE  ) USING SQLCA ;
										  
				ELSEif 	ls_hakbun = af_hakbun and ll_count = 1 THEN		
			
							//추가납부만 Update
							UPDATE	HAKSA.DUNGROK_GWANRI
							SET		IPHAK_N			=	:ll_ip_napip	,
										DUNGROK_N		=	:ll_napip		,
										HAKSENGWHE_N	=	:ll_haksengwhe	,
										GYOJAE_N			= 	:ll_gyojae		,
										DONGCHANGWHE_N	= 	:ll_dongchang	,
										MEMORIAL_N		= 	:ll_memory		,
										ALBUM_N			=  :ll_album		,
										NAPBU_DATE		=	:ls_dr_ilja		,
										BANK_ID			=	'4'				,
										WAN_YN			=	'Y'				
							WHERE		YEAR		=	:ls_year
							AND		HAKGI		=	:ls_hakgi
							AND		HAKBUN 	= 	:ls_hakbun	
							AND		CHU_YN		=	'Y'
							USING SQLCA ;
							
				ELSEIF 	ls_hakbun <> af_hakbun and ll_count <> 1 THEN	
			
							// Update
							UPDATE	HAKSA.DUNGROK_GWANRI
							SET		IPHAK_N			=	:ll_ip_napip	,
										DUNGROK_N		=	:ll_napip		,
										HAKSENGWHE_N	=	:ll_haksengwhe	,
										GYOJAE_N			= 	:ll_gyojae		,
										DONGCHANGWHE_N	= 	:ll_dongchang	,
										MEMORIAL_N		= 	:ll_memory		,
										ALBUM_N			=  :ll_album		,
										NAPBU_DATE		=	:ls_dr_ilja		,
										BANK_ID			=	'4'				,
										WAN_YN			=	'Y'				,
										DUNG_YN			=	'Y'	
							WHERE		YEAR		=	:ls_year
							AND		HAKGI		=	:ls_hakgi
							AND		HAKBUN 	= 	:ls_hakbun
							USING SQLCA ;
				end if	
				
				if sqlca.sqlcode <> 0 then
					messagebox("오류!",ls_hakbun + " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					fileclose(fnum)
					return	
				end if

         END IF
			st_cnt.text = string(i) + '/' + string(mok)


/* 수납관리 저장 */
        l_cnt        = 0
        SELECT nvl(count(*), 0)
		    INTO :l_cnt
			 FROM haksa.sunap_gwanri
			WHERE hakbun    = :ls_hakbun
			  AND year      = :ls_year
			  AND hakgi     = :ls_hakgi
			  AND bank_id   = '4'
			  USING SQLCA ;
		  IF sqlca.sqlnrows  = 0 THEN
			  l_cnt         = 1
		  ELSE
			  l_cnt         = l_cnt + 1
		  END IF
		  INSERT INTO haksa.sunap_gwanri (HAKBUN,         YEAR,           HAKGI,        BANK_ID,
                                        CHASU,          HAKJUM,         IPHAK,        DUNGROK,
                                        HAKSENGWHE,     GYOJAE,         ALBUM,        HAKWHE,
                                        MEMORIAL,       DONGCHANGWHE,   NAPBU_DATE,
													 WORKER,                         IPADDR,
                                        WORK_DATE,      JOB_UID,        JOB_ADD,
                                        JOB_DATE)
				        values             (:ls_hakbun,     :ls_year,       :ls_hakgi,    '4',
						                      :l_cnt,         0,              :ll_ip_napip, :ll_napip,
													 :ll_haksengwhe, :ll_gyojae,     :ll_album,    0,
													 :ll_memory,     :ll_dongchang,  TO_CHAR(SYSDATE, 'YYYYMMDD'),
													 :gs_empcode,           :gs_ip,
													 sysdate,        '',             '',
													 sysdate) USING SQLCA ;
						IF sqlca.sqlcode  <> 0 THEN
							messagebox("알림", '수납 관리 저장중 오류' + sqlca.sqlerrtext)
							rollback USING SQLCA ;
							return
						END IF


		NEXT
	
END CHOOSE

if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	fileclose(fnum)
	MESSAGEBOX("확인!","작업이 종료되었습니다.")
	
	dw_main.retrieve()
		
end if
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type st_cnt from statictext within w_hdr202a
integer x = 2139
integer y = 48
integer width = 494
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
alignment alignment = right!
boolean focusrectangle = false
end type

