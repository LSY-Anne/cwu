$PBExportHeader$w_dhwdr207pp.srw
$PBExportComments$[대학원등록] 환불처리 - Popup
forward
global type w_dhwdr207pp from w_popup
end type
type dw_1 from uo_dwfree within w_dhwdr207pp
end type
end forward

global type w_dhwdr207pp from w_popup
integer width = 2446
string title = "환불처리"
dw_1 dw_1
end type
global w_dhwdr207pp w_dhwdr207pp

type variables
string is_hakbun,	is_year,	is_hakgi, is_hakyun
end variables

event open;str_parms str_hwanbul
long		ll_rtn, ll_line
int		li_max
datetime ld_date

ld_date = f_sysdate()
str_hwanbul = Message.PowerObjectParm

is_hakbun	=	str_hwanbul.s[1]
is_year		=	str_hwanbul.s[2]
is_hakgi		=	str_hwanbul.s[3]
//is_hakyun	=  str_hwanbul.s[4]

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
	FROM		HAKSA.D_HWANBUL
	WHERE	HAKBUN	=	:is_hakbun
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
	
	dw_1.SetColumn('dungrok')
	dw_1.setfocus()
	
end if
end event

on w_dhwdr207pp.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_dhwdr207pp.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_insert;call super::ue_insert;long 	ll_line, li_max

ll_line = dw_1.insertrow(0)

SELECT	MAX(CHASU)
INTO		:li_max
FROM		HAKSA.D_HWANBUL
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
long  	ll_hwn_ip, ll_hwn_dn, ll_hwn_wo
long		ll_wonwoo
long		ll_hwn_hak,	ll_iphak, ll_dungrok, ll_chasu
long		ll_hakjum_b, ll_iphak_b = 0, ll_dungrok_b = 0, ll_wonwoo_b = 0
int		li_ans
string 	ls_hwn_date, ls_gubun

//총 등록된 금액
SELECT	NVL(SUM(DECODE(SIGN(IPHAK_N), 1, IPHAK_N, 0)), 0),
			NVL(SUM(DECODE(SIGN(DUNGROK_N), 1, DUNGROK_N, 0)), 0),
			NVL(SUM(DECODE(SIGN(WONWOO_N), 1, WONWOO_N, 0)), 0)
INTO		:ll_iphak,
			:ll_dungrok,
			:ll_wonwoo
FROM		HAKSA.D_DUNGROK
WHERE		HAKBUN	=	:is_hakbun
AND		YEAR		=	:is_year
AND		HAKGI		=	:is_hakgi
AND		WAN_YN 	= 	'1'
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox('확인', "납입내역이 없는 학생입니다 환불이 불가합니다.")
	return 1
end if

ll_tot 	= ll_iphak + ll_dungrok + ll_wonwoo

//지금 환불하는 금액
dw_1.SetColumn('hwanbul_date')

dw_1.gettext()
ll_row = dw_1.rowcount()
ll_hwn_hak		= -(dw_1.object.hakjum[ll_row])
ll_hwn_ip		= -(dw_1.object.iphak[ll_row])
ll_hwn_dn		= -(dw_1.object.dungrok[ll_row])
ll_hwn_wo		= -(dw_1.object.wonwoo[ll_row])
ls_hwn_date		= dw_1.object.hwanbul_date[ll_row]


ll_bigo			=	dw_1.object.tot[1]
ll_hakjum_b		=	dw_1.object.hakjum_tot[1]
ll_iphak_b		=	dw_1.object.iphak_tot[1]
ll_dungrok_b	=	dw_1.object.dungrok_tot[1]
ll_wonwoo_b		=	dw_1.object.wonwoo_tot[1]

IF ll_iphak < ll_iphak_b THEN
	messagebox("오류","입학금이 초과되었습니다..")
	return -1
END IF

IF ll_dungrok < ll_dungrok_b THEN
	messagebox("오류","등록금이 초과되었습니다..")
	return -1
END IF

IF ll_wonwoo < ll_wonwoo_b THEN
	messagebox("오류","원우회비가 초과되었습니다..")
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
		FROM		HAKSA.D_DUNGROK
		WHERE		YEAR		=	:is_year
		AND		HAKGI		=	:is_hakgi
		AND		HAKBUN	=	:is_hakbun	
		USING SQLCA ;
		
		//Table Insert
		INSERT INTO	HAKSA.D_DUNGROK
				(	HAKBUN,			YEAR,				HAKGI,				CHASU,		
					HAKJUM,			IPHAK_N,			DUNGROK_N,			WONWOO_N,
					NAPBU_DATE,		WAN_YN,			
					DUNG_YN,			BUN_YN,			CHU_YN,				HWAN_YN
				)
		VALUES		
				(	:is_hakbun,		:is_year,		:is_hakgi,			:ll_chasu,	
					:ll_hakjum_b,	:ll_hwn_ip,		:ll_hwn_dn,			:ll_hwn_wo,
					:ls_hwn_date,	'1',			
					'0',				'0',				'1',					'1'
				)	
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류", is_hakbun + "환불내역 생성중 오류발생~r~n" + sqlca.sqlerrtext)
			return 2
		end if
		
		commit USING SQLCA ;
		//저장확인 메세지 출력
		messagebox("확인","자료가 저장되었습니다.")
	end if
END IF


end event

type p_msg from w_popup`p_msg within w_dhwdr207pp
end type

type st_msg from w_popup`st_msg within w_dhwdr207pp
integer width = 2249
end type

type uc_printpreview from w_popup`uc_printpreview within w_dhwdr207pp
end type

type uc_cancel from w_popup`uc_cancel within w_dhwdr207pp
end type

type uc_ok from w_popup`uc_ok within w_dhwdr207pp
end type

type uc_excelroad from w_popup`uc_excelroad within w_dhwdr207pp
end type

type uc_excel from w_popup`uc_excel within w_dhwdr207pp
end type

type uc_save from w_popup`uc_save within w_dhwdr207pp
end type

type uc_delete from w_popup`uc_delete within w_dhwdr207pp
end type

type uc_insert from w_popup`uc_insert within w_dhwdr207pp
end type

type uc_retrieve from w_popup`uc_retrieve within w_dhwdr207pp
end type

type ln_temptop from w_popup`ln_temptop within w_dhwdr207pp
integer endx = 2441
end type

type ln_1 from w_popup`ln_1 within w_dhwdr207pp
integer endx = 2441
end type

type ln_2 from w_popup`ln_2 within w_dhwdr207pp
end type

type ln_3 from w_popup`ln_3 within w_dhwdr207pp
integer beginx = 2400
integer endx = 2400
end type

type r_backline1 from w_popup`r_backline1 within w_dhwdr207pp
end type

type r_backline2 from w_popup`r_backline2 within w_dhwdr207pp
end type

type r_backline3 from w_popup`r_backline3 within w_dhwdr207pp
end type

type uc_print from w_popup`uc_print within w_dhwdr207pp
end type

type dw_1 from uo_dwfree within w_dhwdr207pp
integer x = 59
integer y = 180
integer width = 2336
integer height = 1264
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dhwdr207pp"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

