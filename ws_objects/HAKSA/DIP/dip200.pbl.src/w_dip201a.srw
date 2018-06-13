$PBExportHeader$w_dip201a.srw
$PBExportComments$[대학원입시] 접수화면
forward
global type w_dip201a from w_condition_window
end type
type dw_con from uo_dwfree within w_dip201a
end type
type dw_main from uo_dwfree within w_dip201a
end type
type uo_1 from uo_imgbtn within w_dip201a
end type
end forward

global type w_dip201a from w_condition_window
dw_con dw_con
dw_main dw_main
uo_1 uo_1
end type
global w_dip201a w_dip201a

type variables
datawindowchild ldwc_hjmod

end variables

on w_dip201a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.uo_1
end on

on w_dip201a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_suhum
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_suhum	=	dw_con.Object.suhum_no[1]

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
end if

if ls_suhum = ''  or Isnull(ls_suhum) then
	messagebox("확인","수험번호를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("suhum_no")
	return -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_suhum)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event ue_save;//저장을 클릭하면 수험번호를 가져와서 setting한 후 저장발생

int		li_ans, li_row
long		ll_chebun
string	ls_year, ls_hakgi, ls_suhum, ls_jongbyul, ls_hakgwa

dw_main.AcceptText()

li_row = dw_main.getrow()

ls_year		=	dw_main.object.year[li_row]
ls_hakgi		=	dw_main.object.hakgi[li_row]
ls_jongbyul	=	dw_main.object.jongbyul_id[li_row]
ls_hakgwa	=	dw_main.object.gwa_id[li_row]
ls_suhum	=	dw_main.object.suhum_no[li_row]

if ls_jongbyul = '' or isnull(ls_jongbyul) then
	messagebox("오류","종별을 입력하세요.")
	dw_main.SetFocus()
	dw_main.SetColumn("jongbyul_id")
	return -1
end if

if ls_hakgwa = '' or isnull(ls_hakgwa) then
	messagebox("오류","지망학과를 입력하세요.")
	dw_main.SetFocus()
	dw_main.SetColumn("gwa_id")
	return -1
end if

//수험번호가 있으면 단순 저장
IF len(ls_suhum) > 0 THEN
	//저장
	li_ans = dw_main.update()
					
	if li_ans = -1 then
		//저장 오류 메세지 출력
		uf_messagebox(3)
		rollback USING SQLCA ;
	else	
		commit USING SQLCA ;
		//저장확인 메세지 출력
		uf_messagebox(2)
	end if
	
ELSE

	//원서백업에서 삭제된 자료중 최종자료를 가져온다.
	SELECT	MIN(TO_NUMBER(SUBSTR(SUHUM_NO, 5, 2)))
	INTO	:ll_chebun
	FROM	DIPSI.DI_WONSEO_BACK
	WHERE	YEAR			=	:ls_year
	AND	HAKGI			=	:ls_hakgi
	AND	JONGBYUL_ID	=	:ls_jongbyul
	AND	GWA_ID		=	:ls_hakgwa
	AND	CHEBUN_YN	=	'0'
	USING SQLCA ;
	
	//원서백업에 자료가 없으면 원서 마스터에서 수험번호생성
	if isnull(ll_chebun) then
			
		SELECT	NVL(MAX(TO_NUMBER(SUBSTR(SUHUM_NO, 5, 2))), 0) + 1
		INTO	:ll_chebun
		FROM	DIPSI.DI_WONSEO
		WHERE	YEAR			=	:ls_year
		AND	HAKGI			=	:ls_hakgi
		AND	JONGBYUL_ID	=	:ls_jongbyul
		AND	GWA_ID		=	:ls_hakgwa
		USING SQLCA ;
			
	end if
	
	//저장
	ls_suhum = ls_hakgwa + ls_jongbyul + string(ll_chebun, '00')
	dw_main.object.suhum_no[li_row]	=	ls_suhum	
	
	li_ans = dw_main.update()
						
	if li_ans = -1 then
		//저장 오류 메세지 출력
		uf_messagebox(3)
		rollback USING SQLCA ;
	else
			
		UPDATE	DIPSI.DI_WONSEO_BACK
		SET	CHEBUN_YN	=	'1'
		WHERE	YEAR			=	:ls_year
		AND	HAKGI			=	:ls_hakgi
		AND	SUHUM_NO		=	:ls_suhum
		AND	CHEBUN_yn	=	'0'
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","원서백업수정중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
			return -1
		else
		
			commit USING SQLCA ;
			//저장확인 메세지 출력
			uf_messagebox(2)
		end if
		
	end if

END IF
end event

event ue_insert;call super::ue_insert;string ls_year, ls_hakgi, ls_dhw, ls_hakgwa, ls_gwajung
long ll_line

dw_con.AcceptText()
ls_year		= dw_con.Object.year[1]
ls_hakgi		= dw_con.Object.hakgi[1]

if (ls_year = '' or Isnull(ls_year)) or (ls_hakgi = '' or Isnull(ls_hakgi))then
	messagebox("확인","년도, 학기를 입력하셔야 합니다.")
	return
end if

dw_main.reset()

ll_line = dw_main.insertrow(0)

dw_main.getchild('jungong_id',ldwc_hjmod)
ldwc_hjmod.settransobject(sqlca)	
ldwc_hjmod.retrieve('%')

dw_main.scrolltorow(ll_line)

dw_main.object.year[ll_line]			=	ls_year
dw_main.object.hakgi[ll_line]			=	ls_hakgi
dw_main.object.mojip_id[ll_line]		=	'01'
dw_main.object.jongbyul_id[ll_line]	=	'0'
dw_main.object.gwajung_id[ll_line]	=	'1'
dw_main.object.juya_gubun[ll_line]	=	'2'
dw_main.object.yeongu_yn[ll_line]	=	'0'
dw_main.object.gwa_id[ll_line]	         =	''
dw_main.object.jungong_id[ll_line]	=	''

dw_main.object.jupsuja[ll_line]		=	gs_empcode
dw_main.object.jupsu_ilja[ll_line]	    =	func.of_get_sdate('YYYYMMDD')
dw_main.object.ip_addr[ll_line]		=	gs_ip

dw_main.SetColumn('hname')
dw_main.setfocus()
end event

event ue_delete;call super::ue_delete;string	ls_year, ls_hakgi, ls_suhum
int		li_ans, li_serial, li_rtn

//삭제확인
if uf_messagebox(4) = 2 then return

//원서BACKUP
ls_year	  = dw_main.object.year[dw_main.getrow()]
ls_hakgi	  =	 dw_main.object.hakgi[dw_main.getrow()]
ls_suhum  =	 dw_main.object.suhum_no[dw_main.getrow()]

if ls_suhum = '' or isnull(ls_suhum) then
	return
end if

li_rtn	=	uf_wonseo_back(ls_year, ls_hakgi, ls_suhum)

if li_rtn = -1 then
	messagebox("백업오류","원서백업중 오류가 발생되었습니다.")
	return
end if

dw_main.deleterow(0)
li_ans = dw_main.update()								

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback USING SQLCA ;
else	
	
	commit USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

event open;call super::open;string	ls_hakgi, ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	NEXT_YEAR,      NEXT_HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi

This.TriggerEvent('ue_insert')
end event

type ln_templeft from w_condition_window`ln_templeft within w_dip201a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dip201a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dip201a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dip201a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dip201a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dip201a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dip201a
end type

type uc_insert from w_condition_window`uc_insert within w_dip201a
end type

type uc_delete from w_condition_window`uc_delete within w_dip201a
end type

type uc_save from w_condition_window`uc_save within w_dip201a
end type

type uc_excel from w_condition_window`uc_excel within w_dip201a
end type

type uc_print from w_condition_window`uc_print within w_dip201a
end type

type st_line1 from w_condition_window`st_line1 within w_dip201a
end type

type st_line2 from w_condition_window`st_line2 within w_dip201a
end type

type st_line3 from w_condition_window`st_line3 within w_dip201a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dip201a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dip201a
end type

type gb_1 from w_condition_window`gb_1 within w_dip201a
end type

type gb_2 from w_condition_window`gb_2 within w_dip201a
end type

type dw_con from uo_dwfree within w_dip201a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 170
boolean bringtotop = true
string dataobject = "d_dip201a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_dip201a
integer x = 55
integer y = 296
integer width = 4375
integer height = 1960
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dip201a"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemerror;call super::itemerror;return 2
end event

event itemchanged;call super::itemchanged;string	ls_temp,  ls_sex
long		ll_age
boolean	lb_jumin

this.acceptText()

CHOOSE CASE	DWO.NAME
	CASE	'jumin_no'
		lb_jumin	=	f_chk_jumin_no(data)
				
		if lb_jumin = false then
			if messagebox("오류","잘못된 주민번호가 입력되었습니다.~r~n계속 진행하시겠습니까", Question!, YesNo!, 2) = 2 then
				this.object.jumin_no[row] = ''
				return 1
				
			end if
		end if
		
		//성별
		ls_temp	=	mid(data, 6, 1)
		
		if ls_temp = '1' or ls_temp = '3' then
			ls_sex = '1'
		else 
			ls_sex = '2'
		end if
		
		this.object.sex[row]	=	ls_sex
		
		//나이
		ls_temp = '19' + left(data, 2)
		ll_age	=	long(string(f_sysdate(), 'yyyy')) - long(ls_temp) + 1
		this.object.age[row]	=	ll_age
	
	CASE	'gwa_id'
		//선택한 학과에 해당하는 전공만 조회
		this.getchild('jungong_id',ldwc_hjmod)
		ldwc_hjmod.settransobject(sqlca)	
		ldwc_hjmod.retrieve(data)
		
				
END CHOOSE
end event

event constructor;call super::constructor;This.SetTransObject(sqlca)

dw_main.getchild('jungong_id',ldwc_hjmod)
ldwc_hjmod.settransobject(sqlca)	
ldwc_hjmod.retrieve('%')

func.of_design_dw(dw_main)



end event

type uo_1 from uo_imgbtn within w_dip201a
integer x = 603
integer y = 40
integer width = 352
integer taborder = 40
boolean bringtotop = true
string btnname = "Reset"
end type

event clicked;call super::clicked;dw_main.reset()

dw_con.Object.suhum_no[1] = ''

parent.TriggerEvent('ue_insert')
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

