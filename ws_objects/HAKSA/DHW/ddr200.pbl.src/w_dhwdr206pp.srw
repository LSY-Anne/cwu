$PBExportHeader$w_dhwdr206pp.srw
$PBExportComments$[대학원등록] 분납처리 - Popup
forward
global type w_dhwdr206pp from w_popup
end type
type dw_1 from uo_dwfree within w_dhwdr206pp
end type
end forward

global type w_dhwdr206pp from w_popup
integer width = 2414
integer height = 1648
string title = "분납처리(POPUP)"
dw_1 dw_1
end type
global w_dhwdr206pp w_dhwdr206pp

type variables
string is_hakbun,	is_year,	is_hakgi
end variables

event open;call super::open;str_parms s_parms
long		ll_rtn, ll_line
int		li_max
string	ls_name

s_parms = Message.PowerObjectParm

is_hakbun	=	s_parms.s[1]
is_year		=	s_parms.s[2]
is_hakgi		=	s_parms.s[3]
ls_name		=	s_parms.s[4]

ll_rtn = dw_1.retrieve(is_hakbun,	is_year,	is_hakgi)

//조회중 오류발생하면 윈도우 close
if ll_rtn	= -1 then
	messagebox("오류","작업중 오류가 발생되었습니다.")
	close(this)
	
else

	dw_1.object.t_name.text = '성 명 : ' + ls_name
	
	//입력가능하도록 새로운 row를 생성한다.
	ll_line = dw_1.insertrow(0)
	
	SELECT	MAX(CHASU)
	INTO		:li_max
	FROM	HAKSA.D_DUNGROK_BUN
	WHERE	HAKBUN	=	:is_hakbun
	AND	YEAR		=	:is_year
	AND	HAKGI		=	:is_hakgi	
	USING SQLCA ;
	
	if isnull(li_max) then
		li_max = 0
	end if
	
	dw_1.ScrollToRow(ll_line)
	
	dw_1.object.hakbun[ll_line]	=	is_hakbun
	dw_1.object.year[ll_line]		=	is_year
	dw_1.object.hakgi[ll_line]		=	is_hakgi
	dw_1.object.chasu[ll_line]		=	li_max + 1
	dw_1.object.napbu_date[ll_line]	=	string(f_sysdate(), 'yyyymmdd')
	dw_1.object.bank_id[ll_line]	=	'1'
	
	dw_1.SetColumn('dungrok')
	dw_1.setfocus()
	
end if
end event

on w_dhwdr206pp.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_dhwdr206pp.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_delete;call super::ue_delete;int li_ans

//삭제확인
if messagebox("확인","자료를 삭제하시겠습니까?",Question!, YesNo!, 2) = 2 then return

dw_1.deleterow(0)
end event

event ue_save;////저장하면 D_DUNGROK에 해당금액만큼 +해주고 총납입해야 할 금액보다 많게 되면 저장안되게 한다.

long	ll_tot, ll_bigo_db, ll_bigo
long	ll_iphak, ll_dungrok, ll_wonwoo, ll_iphak_b = 0, ll_dungrok_b = 0, ll_wonwoo_b = 0
int	li_ans
string ls_dr_date

//Tab위치를 변경시켜준다.
//- datawindow의 하단의 합산된 금액에서 data를 가져오는데 Tab이 이동해야 변경된 금액이 적용되기 때문
dw_1.SetColumn('napbu_date')

//총 납입해야 할 금액
SELECT	NVL(IPHAK, 0),
			NVL(DUNGROK, 0) - NVL(D_JANGHAK, 0),
			NVL(WONWOO, 0)
INTO	:ll_iphak,
		:ll_dungrok,
		:ll_wonwoo
FROM	HAKSA.D_DUNGROK
WHERE	HAKBUN	=	:is_hakbun
AND	YEAR		=	:is_year
AND	HAKGI		=	:is_hakgi
USING SQLCA ;

ll_tot = ll_iphak + ll_dungrok //+ ll_wonwoo

//이전까지의 납입금 + 현재 납입하는 금액
dw_1.gettext()

ll_bigo			=	dw_1.object.tot[1]
ll_iphak_b		=	dw_1.object.iphak_tot[1]
ll_dungrok_b	=	dw_1.object.dungrok_tot[1]
ll_wonwoo_b		=	dw_1.object.wonwoo_tot[1]

ls_dr_date		=	dw_1.object.napbu_date[1]

//납입할 금액과 입력된 금액을 비교
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
	messagebox("오류","납입해야 할 총액보다 많은 금액이 입력되었습니다.")
	return -1
		
ELSEIF ll_tot = ll_bigo THEN
	
	li_ans = dw_1.update()
					
	if li_ans = -1 then
		//저장 오류 메세지 출력
		messagebox("저장오류","저장중 오류가 발생되었습니다.")
		rollback USING SQLCA ;
	else
		
		UPDATE	HAKSA.D_DUNGROK
		SET	IPHAK_N		=	:ll_iphak_b		,
				DUNGROK_N	=	:ll_dungrok_b	,
				WONWOO_N		=	:ll_wonwoo_b	,
				NAPBU_DATE	=	:ls_dr_date		,
				WAN_YN		=	'1',
				DUNG_YN		=	'1',
				BANK_ID		=	'1'
		WHERE	HAKBUN	=	:is_hakbun
		AND	YEAR		=	:is_year
		AND	HAKGI		=	:is_hakgi
		USING SQLCA ;
		
	end if	

ELSE

	li_ans = dw_1.update()
					
	if li_ans = -1 then
		//저장 오류 메세지 출력
		messagebox("저장오류","저장중 오류가 발생되었습니다.")
		rollback USING SQLCA ;
	else
		
		UPDATE	HAKSA.D_DUNGROK
		SET	IPHAK_N		=	:ll_iphak_b		,
				DUNGROK_N	=	:ll_dungrok_b	,
				WONWOO_N		=	:ll_wonwoo_b	,
				NAPBU_DATE	=	:ls_dr_date		,
				BUN_YN		=	'1',
				DUNG_YN		=	'1',
				BANK_ID		=	'1'
		WHERE	HAKBUN	=	:is_hakbun
		AND	YEAR		=	:is_year
		AND	HAKGI		=	:is_hakgi
		USING SQLCA ;
		
	end if		
	
END IF


if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	//저장확인 메세지 출력
	messagebox("확인","자료가 저장되었습니다.")
else
	messagebox("저장오류","저장중 오류가 발생되었습니다.")
	rollback USING SQLCA ;
end if


end event

event ue_ok;call super::ue_ok;Close(This)
end event

type p_msg from w_popup`p_msg within w_dhwdr206pp
end type

type st_msg from w_popup`st_msg within w_dhwdr206pp
integer width = 2203
end type

type uc_printpreview from w_popup`uc_printpreview within w_dhwdr206pp
end type

type uc_cancel from w_popup`uc_cancel within w_dhwdr206pp
end type

type uc_ok from w_popup`uc_ok within w_dhwdr206pp
boolean originalsize = false
end type

type uc_excelroad from w_popup`uc_excelroad within w_dhwdr206pp
end type

type uc_excel from w_popup`uc_excel within w_dhwdr206pp
end type

type uc_save from w_popup`uc_save within w_dhwdr206pp
end type

type uc_delete from w_popup`uc_delete within w_dhwdr206pp
end type

type uc_insert from w_popup`uc_insert within w_dhwdr206pp
end type

type uc_retrieve from w_popup`uc_retrieve within w_dhwdr206pp
end type

type ln_temptop from w_popup`ln_temptop within w_dhwdr206pp
integer endx = 2395
end type

type ln_1 from w_popup`ln_1 within w_dhwdr206pp
integer endx = 2395
end type

type ln_2 from w_popup`ln_2 within w_dhwdr206pp
end type

type ln_3 from w_popup`ln_3 within w_dhwdr206pp
integer beginx = 2350
integer endx = 2350
end type

type r_backline1 from w_popup`r_backline1 within w_dhwdr206pp
end type

type r_backline2 from w_popup`r_backline2 within w_dhwdr206pp
end type

type r_backline3 from w_popup`r_backline3 within w_dhwdr206pp
end type

type uc_print from w_popup`uc_print within w_dhwdr206pp
end type

type dw_1 from uo_dwfree within w_dhwdr206pp
integer x = 64
integer y = 184
integer width = 2272
integer height = 1240
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dhwdr206pp"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

