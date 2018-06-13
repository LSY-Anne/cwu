$PBExportHeader$w_hdr105pp.srw
$PBExportComments$[청운대]분납처리popup
forward
global type w_hdr105pp from w_popup
end type
type dw_1 from uo_dwfree within w_hdr105pp
end type
end forward

global type w_hdr105pp from w_popup
integer width = 2446
integer height = 1648
string title = "분납처리"
dw_1 dw_1
end type
global w_hdr105pp w_hdr105pp

type variables
string is_hakbun,	is_year,	is_hakgi
end variables

event open;call super::open;str_parms str_bunnap
long			ll_rtn, ll_line, ll_tot, ll_iphak, ll_dungrok, &
				ll_hakseng, ll_gyojae, ll_memory, ll_album, ll_dongchang, ll_tot1
int			li_max
datetime		ld_date
string		ls_su_hakyun

ld_date = f_sysdate()
str_bunnap = Message.PowerObjectParm

is_hakbun	=	str_bunnap.s[1]
is_year		=	str_bunnap.s[2]
is_hakgi		=	str_bunnap.s[3]

ll_rtn = dw_1.retrieve(is_hakbun, is_year, is_hakgi)

//조회중 오류발생하면 윈도우 close
if ll_rtn	= -1 then
	close(this)
	
else
	
	//총 납입해야 할 금액
	SELECT	SU_HAKYUN,
				NVL(IPHAK, 0),
				NVL(DUNGROK, 0) - NVL(D_JANGHAK, 0),
				NVL(HAKSENGWHE, 0),
				NVL(GYOJAE, 0),
				NVL(MEMORIAL, 0),
				NVL(ALBUM, 0),
				NVL(DONGCHANGWHE, 0)
	INTO		:ls_su_hakyun,
				:ll_iphak,
				:ll_dungrok,
				:ll_hakseng,
				:ll_gyojae,
				:ll_memory,
				:ll_album,
				:ll_dongchang
	FROM		HAKSA.DUNGROK_GWANRI
	WHERE		HAKBUN	=	:is_hakbun
	AND		YEAR		=	:is_year
	AND		HAKGI		=	:is_hakgi
	USING SQLCA ;

	ll_tot 	= ll_iphak + ll_dungrok + ll_hakseng + ll_gyojae + ll_memory + ll_album + ll_dongchang
	ll_tot1 	= ll_iphak + ll_dungrok
	
	//입력가능하도록 새로운 row를 생성한다.
	ll_line = dw_1.insertrow(0)
	
	SELECT	MAX(CHASU)
	INTO		:li_max
	FROM		HAKSA.DUNGROK_BUNNAP
	WHERE		HAKBUN	=	:is_hakbun
	AND		YEAR		=	:is_year
	AND		HAKGI		=	:is_hakgi	
	USING SQLCA ;
	
	if isnull(li_max) then
		li_max = 0
	end if
	
	dw_1.object.su_hakyun[ll_line]		=	ls_su_hakyun
	dw_1.object.total[ll_line]		=  ll_tot
	dw_1.object.d_tot[ll_line]		=  ll_tot1
	dw_1.object.hakbun[ll_line]	=	is_hakbun
	dw_1.object.year[ll_line]		=	is_year
	dw_1.object.hakgi[ll_line]		=	is_hakgi
	dw_1.object.chasu[ll_line]		=	li_max + 1
	dw_1.object.napbu_date[ll_line]	=	string(ld_date, 'yyyymmdd')
	dw_1.object.bank_id[ll_line]	=	'1'
	
	dw_1.SetColumn('dungrok')
	dw_1.setfocus()
	
end if
end event

on w_hdr105pp.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_hdr105pp.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_delete;call super::ue_delete;int li_ans

//삭제확인
if messagebox("확인","자료를 삭제하시겠습니까?",Question!, YesNo!, 2) = 2 then return

dw_1.deleterow(0)
end event

event ue_save;////저장하면 DUNGROK_GWANRI에 해당금액만큼 +해주고 총납입해야 할 금액보다 많게 되면 저장안되게 한다.
string	ls_ilja
long		ll_tot, ll_bigo_db, ll_bigo
long		ll_hakseng, ll_gyojae, ll_memory, ll_album, ll_dongchang
long		ll_iphak, ll_dungrok
long		ll_iphak_b = 0, ll_dungrok_b = 0, ll_hakseng_b = 0, ll_gyojae_b = 0, &
			ll_memory_b = 0, ll_album_b = 0, ll_dongchang_b = 0
int		li_ans,	ll_chasu
Double ldb_iphak,    ldb_dungrok,  ldb_haksengwhe,  ldb_gyojae,  ldb_album
Double ldb_memorial, ldb_dongchangwhe
String ls_napbu,     ls_bank, ls_su_hakyun
Int    li_chasu,     ii,           l_cnt,           li_refchasu

dw_1.AcceptText()

FOR ii        = dw_1.RowCount() TO 1 step -1
	 ldb_iphak        = dw_1.GetItemNumber(ii, 'iphak')
	 ldb_dungrok      = dw_1.GetItemNumber(ii, 'dungrok')
	 ldb_haksengwhe   = dw_1.GetItemNumber(ii, 'haksengwhe')
	 ldb_gyojae       = dw_1.GetItemNumber(ii, 'gyojae')
	 ldb_album        = dw_1.GetItemNumber(ii, 'album')
	 ldb_memorial     = dw_1.GetItemNumber(ii, 'memorial')
	 ldb_dongchangwhe = dw_1.GetItemNumber(ii, 'dongchangwhe')
	 IF ldb_iphak = 0 and ldb_dungrok  = 0 and ldb_haksengwhe   = 0 and ldb_gyojae = 0 and &
	    ldb_album = 0 and ldb_memorial = 0 and ldb_dongchangwhe = 0 then
		 dw_1.deleterow(ii)
	 END IF
NEXT

//총 납입해야 할 금액
SELECT	NVL(IPHAK, 0),
			NVL(DUNGROK, 0) - NVL(D_JANGHAK, 0),
			NVL(HAKSENGWHE, 0),
			NVL(GYOJAE, 0),
			NVL(MEMORIAL, 0),
			NVL(ALBUM, 0),
			NVL(DONGCHANGWHE, 0)
INTO		:ll_iphak,
			:ll_dungrok,
			:ll_hakseng,
			:ll_gyojae,
			:ll_memory,
			:ll_album,
			:ll_dongchang
FROM		HAKSA.DUNGROK_GWANRI
WHERE	HAKBUN	=	:is_hakbun
AND		YEAR		=	:is_year
AND		HAKGI		=	:is_hakgi
USING SQLCA ;

ll_tot 	= ll_iphak + ll_dungrok

//지금 납입하는 금액
dw_1.accepttext()
dw_1.gettext()

//ls_su_hakyun	=	dw_1.object.ls_su_hakyun[1]
ll_bigo			=	dw_1.object.tot[1]
ll_iphak_b		=	dw_1.object.iphak_tot[1]
ll_dungrok_b	=	dw_1.object.dungrok_tot[1]
ll_hakseng_b	=	dw_1.object.hakseng_tot[1]
ll_gyojae_b		=	dw_1.object.gyojae_tot[1]
ll_memory_b		=	dw_1.object.memory_tot[1]
ll_album_b		=	dw_1.object.album_tot[1]
ll_dongchang_b	=	dw_1.object.dong_tot[1]
ls_ilja			=  dw_1.object.napbu_date[1]

IF isnull(ll_iphak_b) then ll_iphak_b = 0
IF ll_iphak < ll_iphak_b THEN
	messagebox("오류","입학금이 초과되었습니다.")
	return -1
END IF

IF isnull(ll_dungrok_b) then ll_dungrok_b = 0
IF ll_dungrok < ll_dungrok_b THEN
	messagebox("오류","등록금이 초과되었습니다.")
	return -1
END IF

IF isnull(ll_hakseng_b) then ll_hakseng_b = 0
IF ll_hakseng < ll_hakseng_b THEN
	messagebox("오류","잡부비가 초과되었습니다.")
	return -1
END IF

IF isnull(ll_gyojae_b) then ll_gyojae_b = 0
IF ll_gyojae < ll_gyojae_b THEN
	messagebox("오류","교재비가 초과되었습니다.")
	return -1
END IF

IF isnull(ll_memory_b) then ll_memory_b = 0
IF ll_memory < ll_memory_b THEN
	messagebox("오류","졸업기념비가 초과되었습니다.")
	return -1
END IF

IF isnull(ll_album_b) then ll_album_b = 0
IF ll_album < ll_album_b THEN
	messagebox("오류","앨범비가 초과되었습니다.")
	return -1
END IF

IF isnull(ll_dongchang_b) then ll_dongchang_b = 0
IF ll_dongchang < ll_dongchang_b THEN
	messagebox("오류","동창회비가 초과되었습니다.")
	return -1
END IF

IF isnull(ll_bigo) then ll_bigo = 0
IF ll_tot < ll_bigo THEN
	messagebox("오류","납입해야 할 총액보다 많은 금액이 입력되었습니다.")
	return -1
		
ELSEIF ll_tot = ll_bigo THEN
	
	li_ans = dw_1.update()
					
	if li_ans = -1 then
		//저장 오류 메세지 출력
		messagebox("저장오류","저장중 오류가 발생되었습니다.")
		rollback USING SQLCA ;
	else
		
		UPDATE	HAKSA.DUNGROK_GWANRI
			SET	IPHAK_N			=	:ll_iphak_b	,
					DUNGROK_N		=	:ll_dungrok_b	,
					HAKSENGWHE_N	=	:ll_hakseng_b	,
					GYOJAE_N			=	:ll_gyojae_b,
					MEMORIAL_N		= 	:ll_memory_b,
					ALBUM_N			=	:ll_album_b,
					DONGCHANGWHE_N =	:ll_dongchang_b,
					NAPBU_DATE		=  :ls_ilja,
					BUN_YN			=  'Y',
					DUNG_YN			= 	'Y',
					WAN_YN			=	'Y',
					BANK_ID			=  '1'
		WHERE		HAKBUN	=	:is_hakbun
		AND		YEAR		=	:is_year
		AND		HAKGI		=	:is_hakgi
		AND		BUN_YN	=	'Y'
		USING SQLCA ;
		
		IF SQLCA.SQLCODE <> 0 THEN
			MESSAGEBOX( '확인', SQLCA.SQLERRTEXT)
		END IF
		
	end if	

ELSE

	li_ans = dw_1.update()
					
	if li_ans = -1 then
		//저장 오류 메세지 출력
		messagebox("저장오류","저장중 오류가 발생되었습니다.")
		rollback USING SQLCA ;
	else
		
		SELECT 	CHASU
		INTO		:ll_chasu		
		FROM 		HAKSA.DUNGROK_GWANRI
		WHERE 	HAKBUN	=	:is_hakbun
		AND		YEAR		=	:is_year
		AND		HAKGI		=	:is_hakgi
		AND		BUN_YN	= 	'Y'
		USING SQLCA ;
		
		if	ll_chasu > 0 then  //기분납액이 있는 경우 
		
		UPDATE	HAKSA.DUNGROK_GWANRI
			SET	IPHAK_N			=	:ll_iphak_b,
					DUNGROK_N		=	:ll_dungrok_b,
					HAKSENGWHE_N	=	:ll_hakseng_b,
					GYOJAE_N			=	:ll_gyojae_b,
					MEMORIAL_N		= 	:ll_memory_b,
					ALBUM_N			=	:ll_album_b,
					DONGCHANGWHE_N =	:ll_dongchang_b,
					NAPBU_DATE		=  :ls_ilja,
					DUNG_YN			= 	'Y',
					BUN_YN			=	'Y',
					BANK_ID			= 	'1'
		WHERE		HAKBUN	=	:is_hakbun
		AND		YEAR		=	:is_year
		AND		HAKGI		=	:is_hakgi
		AND		BUN_YN	=	'Y'
		USING SQLCA ;
		
		else		//최초 분납인경우
		
		UPDATE	HAKSA.DUNGROK_GWANRI
			SET	IPHAK_N			=	:ll_iphak_b,
					DUNGROK_N		=	:ll_dungrok_b,
					HAKSENGWHE_N	=	:ll_hakseng_b,
					GYOJAE_N			=	:ll_gyojae_b,
					MEMORIAL_N		= 	:ll_memory_b,
					ALBUM_N			=	:ll_album_b,
					DONGCHANGWHE_N =	:ll_dongchang_b,
					NAPBU_DATE		=  :ls_ilja,
					DUNG_YN			= 	'Y',
					BUN_YN			=	'Y',
					BANK_ID			= 	'1'
		WHERE		HAKBUN	=	:is_hakbun
		AND		YEAR		=	:is_year
		AND		HAKGI		=	:is_hakgi
		USING SQLCA ;

		end if
		
	end if		
	
END IF


if sqlca.sqlcode = 0 then
else
	messagebox("저장오류","저장중 오류가 발생되었습니다.")
	rollback USING SQLCA ;
end if


FOR ii        = 1 TO dw_1.RowCount()
	 ls_napbu         = dw_1.GetItemString(ii, 'napbu_date')
	 ls_bank          = dw_1.GetItemString(ii, 'bank_id')
	 li_refchasu      = dw_1.GetItemNumber(ii, 'chasu')
	 ldb_iphak        = dw_1.GetItemNumber(ii, 'iphak')
	 ldb_dungrok      = dw_1.GetItemNumber(ii, 'dungrok')
	 ldb_haksengwhe   = dw_1.GetItemNumber(ii, 'haksengwhe')
	 ldb_gyojae       = dw_1.GetItemNumber(ii, 'gyojae')
	 ldb_album        = dw_1.GetItemNumber(ii, 'album')
	 ldb_memorial     = dw_1.GetItemNumber(ii, 'memorial')
	 ldb_dongchangwhe = dw_1.GetItemNumber(ii, 'dongchangwhe')
	 
	 SELECT nvl(count(*), 0)
	   INTO :l_cnt
		FROM haksa.sunap_gwanri
	  WHERE hakbun    = :is_hakbun
	    AND year      = :is_year
		 AND hakgi     = :is_hakgi
		 AND ref_chasu = :li_refchasu
		 USING SQLCA ;
		 
	 IF sqlca.sqlnrows  = 0 THEN
		 l_cnt         = 0
	 END IF
	 IF l_cnt         = 0 THEN
		
		 SELECT nvl(MAX(chasu), 0)
		   INTO :li_chasu
			FROM haksa.sunap_gwanri
		  WHERE hakbun   = :is_hakbun
		    AND year     = :is_year
			 AND hakgi    = :is_hakgi
			 USING SQLCA ;
		 IF sqlca.sqlnrows = 0 THEN
			 li_chasu     = 0
		 END IF
		 li_chasu        = li_chasu + 1
		 INSERT INTO haksa.sunap_gwanri
		             (hakbun,          year,        hakgi,        bank_id,
						  chasu,           hakjum,      iphak,        dungrok,
						  haksengwhe,      gyojae,      album,        hakwhe,
						  memorial,        dongchangwhe,              napbu_date,
						  ref_chasu,       worker,                    ipaddr,
						  work_date)
			  values  (:is_hakbun,      :is_year,    :is_hakgi,    :ls_bank,
			           :li_chasu,       0,           :ldb_iphak,   :ldb_dungrok,
						  :ldb_haksengwhe, :ldb_gyojae, :ldb_album,   0,
						  :ldb_memorial,   :ldb_dongchangwhe,         :ls_napbu,
						  :li_refchasu,    :gs_empcode,      :gs_ip,
						  sysdate) USING SQLCA ;
		 IF sqlca.sqlcode <> 0 THEN
			 messagebox("저장", '납부관리 저장중 오류 ' + sqlca.sqlerrtext)
       		 rollback USING SQLCA ;
			 return -1
		 END IF
	 ELSE
		 UPDATE haksa.sunap_gwanri
		    SET napbu_date   = :ls_napbu,
				  bank_id      = :ls_bank,
				  iphak        = :ldb_iphak,
				  dungrok      = :ldb_dungrok,
				  haksengwhe   = :ldb_haksengwhe,
				  gyojae       = :ldb_gyojae,
				  album        = :ldb_album,
				  memorial     = :ldb_memorial,
				  dongchangwhe = :ldb_dongchangwhe,
				  job_uid      = :gs_empcode,
				  job_add      = :gs_ip,
				  job_date     = sysdate
	     WHERE hakbun       = :is_hakbun
	       AND year         = :is_year
		    AND hakgi        = :is_hakgi
		    AND ref_chasu    = :li_refchasu
		 USING SQLCA ;
	 END IF
	 IF sqlca.sqlnrows   = 0 THEN
		 messagebox("저장", '납부관리 수정중 오류 ' + sqlca.sqlerrtext)
		 rollback USING SQLCA ;
		 return -1
	 END IF
NEXT

commit USING SQLCA ;
//저장확인 메세지 출력
messagebox("확인","자료가 저장되었습니다.")


end event

event ue_ok;call super::ue_ok;int li_rtn

li_rtn = f_save_before_close(This, dw_1)

if li_rtn = 1 then
	This.Event ue_save()
else
	close(This)
end if
end event

type p_msg from w_popup`p_msg within w_hdr105pp
end type

type st_msg from w_popup`st_msg within w_hdr105pp
integer width = 2240
end type

type uc_printpreview from w_popup`uc_printpreview within w_hdr105pp
end type

type uc_cancel from w_popup`uc_cancel within w_hdr105pp
end type

type uc_ok from w_popup`uc_ok within w_hdr105pp
end type

type uc_excelroad from w_popup`uc_excelroad within w_hdr105pp
end type

type uc_excel from w_popup`uc_excel within w_hdr105pp
end type

type uc_save from w_popup`uc_save within w_hdr105pp
end type

type uc_delete from w_popup`uc_delete within w_hdr105pp
end type

type uc_insert from w_popup`uc_insert within w_hdr105pp
end type

type uc_retrieve from w_popup`uc_retrieve within w_hdr105pp
end type

type ln_temptop from w_popup`ln_temptop within w_hdr105pp
integer endx = 2432
end type

type ln_1 from w_popup`ln_1 within w_hdr105pp
integer endx = 2432
end type

type ln_2 from w_popup`ln_2 within w_hdr105pp
end type

type ln_3 from w_popup`ln_3 within w_hdr105pp
integer beginx = 2386
integer endx = 2386
end type

type r_backline1 from w_popup`r_backline1 within w_hdr105pp
end type

type r_backline2 from w_popup`r_backline2 within w_hdr105pp
end type

type r_backline3 from w_popup`r_backline3 within w_hdr105pp
end type

type uc_print from w_popup`uc_print within w_hdr105pp
end type

type dw_1 from uo_dwfree within w_hdr105pp
integer x = 50
integer y = 176
integer width = 2313
integer height = 1260
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hdr105pp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

