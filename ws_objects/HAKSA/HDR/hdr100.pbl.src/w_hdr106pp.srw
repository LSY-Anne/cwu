$PBExportHeader$w_hdr106pp.srw
$PBExportComments$[청운대]환불처리popup
forward
global type w_hdr106pp from w_popup
end type
type st_1 from statictext within w_hdr106pp
end type
type dw_1 from uo_dwfree within w_hdr106pp
end type
end forward

global type w_hdr106pp from w_popup
integer width = 2606
integer height = 1656
string title = "환불처리"
st_1 st_1
dw_1 dw_1
end type
global w_hdr106pp w_hdr106pp

type variables
string is_hakbun,	is_year,	is_hakgi, is_hakyun
end variables

event open;call super::open;str_parms str_hwanbul
long		ll_rtn, ll_line
int		li_max
datetime ld_date
Double   ldb_dungrok

ld_date = f_sysdate()
str_hwanbul = Message.PowerObjectParm

is_hakbun	=	str_hwanbul.s[1]
is_year		=	str_hwanbul.s[2]
is_hakgi		=	str_hwanbul.s[3]
is_hakyun	=  str_hwanbul.s[4]

ll_rtn = dw_1.retrieve(is_hakbun, is_year, is_hakgi)

//조회중 오류발생하면 윈도우 close
if ll_rtn	= -1 then
	messagebox("","")
	close(this)
	
else
	//입력가능하도록 새로운 row를 생성한다.
	ll_line = dw_1.insertrow(0)
	
	SELECT	MAX(CHASU)
	INTO		:li_max
	FROM		HAKSA.HWANBUL
	WHERE		HAKBUN	=	:is_hakbun
	AND		YEAR		=	:is_year
	AND		HAKGI		=	:is_hakgi	
	USING SQLCA ;
	
	if isnull(li_max) then
		li_max = 0
	end if
	
	dw_1.object.hakbun[ll_line]	=	is_hakbun
	dw_1.object.year[ll_line]		=	is_year
	dw_1.object.hakgi[ll_line]		=	is_hakgi
	dw_1.object.chasu[ll_line]		=	li_max + 1
	dw_1.object.hwanbul_date[ll_line]	=	string(ld_date, 'yyyymmdd')
	
	dw_1.SetColumn('iphak')
	dw_1.setfocus()
	
end if
end event

on w_hdr106pp.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_hdr106pp.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_1)
end on

event ue_insert;call super::ue_insert;long 	ll_line, li_max

ll_line = dw_1.insertrow(0)

SELECT	MAX(CHASU)
INTO		:li_max
FROM		HAKSA.HWANBUL
WHERE		HAKBUN	=	:is_hakbun
AND		YEAR		=	:is_year
AND		HAKGI		=	:is_hakgi	
USING SQLCA ;

if isnull(li_max) then
	li_max = 0
end if

dw_1.object.hakbun[ll_line]	=	is_hakbun
dw_1.object.year[ll_line]		=	is_year
dw_1.object.hakgi[ll_line]		=	is_hakgi
dw_1.object.chasu[ll_line]		=	li_max + 1
dw_1.object.hwanbul_date[ll_line]	=	string(f_sysdate(), 'yyyymmdd')

dw_1.SetColumn('dungrok')
dw_1.setfocus()
end event

event ue_delete;call super::ue_delete;dw_1.deleterow(0)
end event

event ue_save;long		ll_tot, ll_bigo_db, ll_bigo, ll_row
long  	ll_hwn_ip, ll_hwn_dn, ll_hwn_hw, ll_hwn_gj, ll_hwn_mm, ll_hwn_ab, ll_hwn_dh
long		ll_hakseng, ll_gyojae, ll_memory, ll_album, ll_dongchang
long		ll_iphak, ll_dungrok, ll_chasu, ll_hwn_hak
long		ll_hakjum_b, 	ll_iphak_b = 0, ll_dungrok_b = 0, ll_hakseng_b = 0, ll_gyojae_b = 0, &
			ll_memory_b = 0, ll_album_b = 0, ll_dongchang_b = 0
int		li_ans
string 	ls_hwn_date, ls_gubun

dw_1.AcceptText()

 SELECT	NVL(SUM(DECODE(SIGN(IPHAK_N), 1, IPHAK_N, 0)), 0),
			NVL(SUM(DECODE(SIGN(DUNGROK_N), 1, DUNGROK_N, 0)), 0),
			NVL(SUM(DECODE(SIGN(HAKSENGWHE_N), 1, HAKSENGWHE_N, 0)), 0),
			NVL(SUM(DECODE(SIGN(GYOJAE_N), 1, GYOJAE_N, 0)), 0),
			NVL(SUM(DECODE(SIGN(MEMORIAL_N), 1, MEMORIAL_N, 0)), 0),
			NVL(SUM(DECODE(SIGN(ALBUM_N), 1, ALBUM_N, 0)), 0),
			NVL(SUM(DECODE(SIGN(DONGCHANGWHE_N), 1, DONGCHANGWHE_N, 0)), 0)
INTO		:ll_iphak,
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
AND		WAN_YN 	= 'Y'
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox('확인', "납입내역이 없는 학생입니다 환불이 불가합니다.")
	return -1
end if

ll_tot 	= ll_iphak + ll_dungrok + ll_hakseng + ll_gyojae + ll_memory + ll_album + ll_dongchang

//지금 환불하는 금액
dw_1.SetColumn('hwanbul_date')

dw_1.gettext()
ll_row = dw_1.rowcount()
ll_hwn_hak		= -(dw_1.object.hakjum[ll_row])
ll_hwn_ip		= -(dw_1.object.iphak[ll_row])
ll_hwn_dn		= -(dw_1.object.dungrok[ll_row])
ll_hwn_hw		= -(dw_1.object.haksengwhe[ll_row])
ll_hwn_gj		= -(dw_1.object.gyojae[ll_row])
ll_hwn_mm		= -(dw_1.object.memorial[ll_row])
ll_hwn_ab		= -(dw_1.object.album[ll_row])
ll_hwn_dh		= -(dw_1.object.dongchangwhe[ll_row])
ls_hwn_date		= dw_1.object.hwanbul_date[ll_row]


ll_bigo			=	dw_1.object.tot[1]
ll_hakjum_b		=	dw_1.object.hakjum_tot[1]
ll_iphak_b		=	dw_1.object.iphak_tot[1]
ll_dungrok_b	=	dw_1.object.dungrok_tot[1]
ll_hakseng_b	=	dw_1.object.hakseng_tot[1]
ll_gyojae_b		=	dw_1.object.gyojae_tot[1]
ll_memory_b		=	dw_1.object.memory_tot[1]
ll_album_b		=	dw_1.object.album_tot[1]
ll_dongchang_b	=	dw_1.object.dong_tot[1]

IF ll_iphak < ll_iphak_b THEN
	messagebox("오류","입학금이 초과되었습니다..")
	return -1
END IF

IF ll_dungrok < ll_dungrok_b THEN
	messagebox("오류","등록금이 초과되었습니다..")
	return -1
END IF

IF ll_hakseng < ll_hakseng_b THEN
	messagebox("오류","잡부비가 초과되었습니다..")
    return -1
END IF

IF ll_gyojae < ll_gyojae_b THEN
	messagebox("오류","교재비가 초과되었습니다..")
	return -1
END IF

IF ll_memory < ll_memory_b THEN
	messagebox("오류","졸업기념비가 초과되었습니다..")
	return -1
END IF

IF ll_album < ll_album_b THEN
	messagebox("오류","앨범비가 초과되었습니다..")
	return -1
END IF

IF ll_dongchang < ll_dongchang_b THEN
	messagebox("오류","동창회비가 초과되었습니다..")
	return -1
END IF

IF ll_tot < ll_bigo THEN
 	messagebox("오류","총액보다 많은 금액이 환불금액으로 입력되었습니다.")
	return -1
		
ELSEIF ll_tot >= ll_bigo THEN
		
	li_ans = dw_1.update()
					
	if li_ans = -1 then
		//저장 오류 메세지 출력
		messagebox("저장오류","저장중 오류가 발생되었습니다.")
		rollback USING SQLCA ;
	else
		//등록최고차수를 구한다.
		SELECT	nvl(MAX(CHASU),0) + 1
		INTO		:ll_chasu
		FROM		HAKSA.DUNGROK_GWANRI
		WHERE		YEAR		=	:is_year
		AND		HAKGI		=	:is_hakgi
		AND		HAKBUN	=	:is_hakbun	
		USING SQLCA ;
		
		SELECT DISTINCT DUNGROK_GUBUN
		INTO	:ls_gubun
		FROM HAKSA.DUNGROK_GWANRI
		WHERE	YEAR		=	:is_year
		AND	HAKGI		=	:is_hakgi
		AND	HAKBUN	=	:is_hakbun
		USING SQLCA ;

		//Table Insert
		INSERT INTO	HAKSA.DUNGROK_GWANRI
				(	HAKBUN,			YEAR,				HAKGI,				SU_HAKYUN,		CHASU,		
					HAKJUM,			IPHAK_N,			DUNGROK_N,			HAKSENGWHE_N,	GYOJAE_N,
					MEMORIAL_N,		ALBUM_N,			DONGCHANGWHE_N,	NAPBU_DATE,		WAN_YN,			
					DUNG_YN,			BUN_YN,			CHU_YN,				HWAN_YN,			WORKER,
					IPADDR,			DUNGROK_GUBUN
				)
		VALUES		
				(	:is_hakbun,		:is_year,		:is_hakgi,			:is_hakyun,		:ll_chasu,	
					:ll_hakjum_b,	:ll_hwn_ip,		:ll_hwn_dn,			:ll_hwn_hw,		:ll_hwn_gj,	
					:ll_hwn_mm,		:ll_hwn_ab,		:ll_hwn_dh,			:ls_hwn_date,	'Y',			
					'N',				'N',				'Y',					'Y',				:gs_empcode,	
					:gs_ip	, :ls_gubun					
				)	
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류", is_hakbun + "환불내역 생성중 오류발생~r~n" + sqlca.sqlerrtext)
			return -1
		end if
		
		
		commit USING SQLCA ;
		//저장확인 메세지 출력
		messagebox("확인","자료가 저장되었습니다.")
	end if
END IF


end event

event ue_ok;call super::ue_ok;int li_rtn

li_rtn = f_save_before_close(This, dw_1)

if li_rtn = 1 then
	This.Event ue_save()
else
	close(This)
end if
end event

type p_msg from w_popup`p_msg within w_hdr106pp
end type

type st_msg from w_popup`st_msg within w_hdr106pp
integer width = 2405
end type

type uc_printpreview from w_popup`uc_printpreview within w_hdr106pp
end type

type uc_cancel from w_popup`uc_cancel within w_hdr106pp
end type

type uc_ok from w_popup`uc_ok within w_hdr106pp
end type

type uc_excelroad from w_popup`uc_excelroad within w_hdr106pp
end type

type uc_excel from w_popup`uc_excel within w_hdr106pp
end type

type uc_save from w_popup`uc_save within w_hdr106pp
end type

type uc_delete from w_popup`uc_delete within w_hdr106pp
end type

type uc_insert from w_popup`uc_insert within w_hdr106pp
end type

type uc_retrieve from w_popup`uc_retrieve within w_hdr106pp
end type

type ln_temptop from w_popup`ln_temptop within w_hdr106pp
integer endx = 2597
end type

type ln_1 from w_popup`ln_1 within w_hdr106pp
integer endx = 2597
end type

type ln_2 from w_popup`ln_2 within w_hdr106pp
end type

type ln_3 from w_popup`ln_3 within w_hdr106pp
integer beginx = 2551
integer endx = 2551
end type

type r_backline1 from w_popup`r_backline1 within w_hdr106pp
end type

type r_backline2 from w_popup`r_backline2 within w_hdr106pp
end type

type r_backline3 from w_popup`r_backline3 within w_hdr106pp
end type

type uc_print from w_popup`uc_print within w_hdr106pp
end type

type st_1 from statictext within w_hdr106pp
integer x = 87
integer y = 1376
integer width = 754
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "※ 학점 환불은 학점 꼭 기입"
boolean focusrectangle = false
end type

type dw_1 from uo_dwfree within w_hdr106pp
integer x = 50
integer y = 176
integer width = 2491
integer height = 1180
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hdr106pp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;Double ldb_dungrok, ldb_amt
Int    l_bunja,     l_bunmo

CHOOSE CASE dwo.name
	CASE 'tmt_hwanbul'
		IF isnull(data) OR data = '' THEN
			dw_1.SetItem(row, 'dungrok', 0)
			return
		END IF
		SELECT //NVL(SUM(DECODE(SIGN(DUNGROK_N), 1, DUNGROK_N, 0)), 0) 
		       //2007.12.11 수정 1차 완납후 수강정정으로 1차 환불후 자퇴 2차 환불
				 SUM(DUNGROK_N)
		  INTO :ldb_dungrok
		  FROM HAKSA.DUNGROK_GWANRI
		 WHERE hakbun   = :is_hakbun
			AND year     = :is_year
			AND hakgi    = :is_hakgi
			AND wan_yn   = 'Y'
			USING SQLCA ;
			
		IF ldb_dungrok  > 0 THEN
			SELECT to_number(sname), to_number(ename)
			  INTO :l_bunja, :l_bunmo
			  FROM cddb.kch001m
			 WHERE type  = 'hwanbul_per'
			   AND code  = :data
			 USING SQLCA ;
			 
			SELECT trunc((:ldb_dungrok * :l_bunja) / :l_bunmo, -2)
			  INTO :ldb_amt
			  FROM DUAL
			  USING SQLCA ;
			  
			dw_1.setItem(row, 'dungrok', ldb_amt)
		END IF
END CHOOSE


end event

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

