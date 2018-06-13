$PBExportHeader$w_dhwhj203a.srw
$PBExportComments$[대학원학적] 학적변동관리
forward
global type w_dhwhj203a from w_condition_window
end type
type dw_2 from uo_input_dwc within w_dhwhj203a
end type
type st_3 from statictext within w_dhwhj203a
end type
type cb_1 from commandbutton within w_dhwhj203a
end type
type cb_2 from commandbutton within w_dhwhj203a
end type
type cb_3 from commandbutton within w_dhwhj203a
end type
type cb_4 from commandbutton within w_dhwhj203a
end type
type cb_5 from commandbutton within w_dhwhj203a
end type
type dw_1 from uo_dwfree within w_dhwhj203a
end type
type dw_con from uo_dwfree within w_dhwhj203a
end type
type cb_6 from commandbutton within w_dhwhj203a
end type
type cb_7 from commandbutton within w_dhwhj203a
end type
end forward

global type w_dhwhj203a from w_condition_window
dw_2 dw_2
st_3 st_3
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
dw_1 dw_1
dw_con dw_con
cb_6 cb_6
cb_7 cb_7
end type
global w_dhwhj203a w_dhwhj203a

forward prototypes
public subroutine wf_button_control (string as_hjmod)
end prototypes

public subroutine wf_button_control (string as_hjmod);//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Finction Name: wf_button_control
//return value	: None
//Author			: Pictek
//학적변동 버튼을 콘트롤하기위한 함수
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CHOOSE CASE	as_hjmod
	case 'A', 'C'				//재학생 : 복학, 재입학 불가
		cb_1.enabled = true
		cb_2.enabled = false
		cb_3.enabled = true
		cb_4.enabled = true
		cb_5.enabled = false
		cb_6.enabled = true
		cb_7.enabled = true
		
	case 'B'						//휴학생 : 재입학 불가
		cb_1.enabled = true
		cb_2.enabled = true
		cb_3.enabled = true
		cb_4.enabled = true
		cb_5.enabled = false
		cb_6.enabled = true
		cb_7.enabled = true
		
	case 'D'						//제적생 : 휴학, 복학, 제적 불가
		cb_1.enabled = false
		cb_2.enabled = false
		cb_3.enabled = false
		cb_4.enabled = true
		cb_5.enabled = true
		cb_6.enabled = true
		cb_7.enabled = false
		
	case 'E', 'H'  				//퇴학생,자퇴생 : 휴학, 복학, 제적, 퇴학 불가
		cb_1.enabled = false
		cb_2.enabled = false
		cb_3.enabled = false
		cb_4.enabled = false
		cb_5.enabled = true
		cb_6.enabled = false
		cb_7.enabled = false
		
	case else					//몽땅 불가
		cb_1.enabled = false
		cb_2.enabled = false
		cb_3.enabled = false
		cb_4.enabled = false
		cb_5.enabled = false
		cb_6.enabled = false
		
END CHOOSE
end subroutine

on w_dhwhj203a.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.dw_1=create dw_1
this.dw_con=create dw_con
this.cb_6=create cb_6
this.cb_7=create cb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_4
this.Control[iCurrent+7]=this.cb_5
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.dw_con
this.Control[iCurrent+10]=this.cb_6
this.Control[iCurrent+11]=this.cb_7
end on

on w_dhwhj203a.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.dw_1)
destroy(this.dw_con)
destroy(this.cb_6)
destroy(this.cb_7)
end on

event ue_retrieve;call super::ue_retrieve;string ls_hakbun, ls_db_hakbun, ls_name, ls_jeonip, ls_hj_mod, ls_delete_yn
int li_cnt, li_ans1, li_ans2

dw_con.AcceptText()

dw_1.Reset()
dw_1.InsertRow(0)

ls_hakbun =	 dw_con.Object.hakbun[1]
ls_name   =	 dw_con.Object.hname[1]
ls_delete_yn = dw_con.Object.delete_yn[1]

If ls_delete_yn = 'Y' Then ls_delete_yn = '%';

//검색조건이 없으면 return
if (ls_hakbun = '' or isnull(ls_hakbun)) and (ls_name = '' or isnull(ls_name)) then
	messagebox("오류","학번이나 성명을 입력하세요")
	return -1
end if

//성명만으로 검색시
//같은 성명이 있으면 Popup Window를 사용하여 학번을 가져와서 조회
if ls_name <> '' then

	SELECT COUNT(*)
	INTO :li_cnt
	FROM	HAKSA.D_HAKJUK
	WHERE	HNAME	= :ls_name
	USING SQLCA ;
	
	if li_cnt >= 2 then
		openwithparm(w_dhw_search, ls_name)
		
		ls_db_hakbun = Message.StringParm
		
	elseif li_cnt = 1 then
		SELECT HAKBUN
		INTO :ls_db_hakbun
		FROM	HAKSA.D_HAKJUK
		WHERE	HNAME	=	:ls_name
		USING SQLCA ;
		
	else
		messagebox("오류","존재하지 않는 성명입니다.")
		dw_con.Object.hakbun[1] = ''
		dw_con.Object.hname[1] = ''
		return -1
	end if

else			// 성명이 입력되어 있지 않으면...학번만으로 검색...

	SELECT	HAKBUN
	INTO :ls_db_hakbun
	FROM	HAKSA.D_HAKJUK
	WHERE	HAKBUN	= :ls_hakbun 
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","존재하지않는 학번입니다.")
		dw_con.Object.hakbun[1] = ''
		dw_con.Object.hname[1] = ''
		dw_con.setfocus()
		dw_con.SetColumn("hakbun")
		return -1
	end if
end if
li_ans1 = dw_1.retrieve(ls_db_hakbun )
li_ans2 = dw_2.retrieve(ls_db_hakbun, ls_delete_yn )

//학적상태를 가져와서 버튼을 Control한다.
SELECT	HJMOD_ID
INTO :ls_hj_mod
FROM	HAKSA.D_HAKJUK
WHERE	HAKBUN = :ls_db_hakbun
USING SQLCA ;

//Window Function - 학적변동 버튼을 Control하기 위한 함수
wf_button_control(ls_hj_mod)

dw_con.Object.hakbun[1] = ''
dw_con.Object.hname[1] = ''
		
Return 1		
end event

event ue_save;//저장시 학적MST와 수강트랜스의 내용도 저장.
//입학시 '입학'이라는 학적변동이 없슴.

string	ls_hakbun, ls_hjmod, ls_sayu, ls_date, ls_injung, ls_sangtae, ls_year, ls_hakgi, ls_iphak
string	ls_hj_sayu, ls_iphak_gubun, ls_be_mod, ls_delete_yn
int		li_ans, li_row, li_modrow, li_delrow

//변경되거나 삭제된 row가 없으면 저장하지 않는다.
li_modrow = dw_2.modifiedcount()
li_delrow = dw_2.deletedcount()

if li_modrow + li_delrow = 0 then 
	wf_button_control(dw_1.object.hjmod_id[1])
	return -1
end if

li_row = dw_2.rowcount()

dw_con.AcceptText()
dw_2.AcceptText()

ls_hakbun	= dw_1.object.hakbun[1]

//rowcount가 0이면 학적변동을 입학상태로 한다.(학적변동 자료를 모두 삭제한 경우)
if li_delrow >= 1 and li_row = 0 then
	
	li_ans = dw_2.update()
	
	if li_ans = -1 then
		MESSAGEBOX("오류","저장중 오류가 발생되었습니다(1).~n" + Sqlca.SqlErrText)
		return -1
		
	else
		
		SELECT	IPHAK_DATE,
					IPHAK_GUBUN
		INTO	:ls_iphak,
				:ls_iphak_gubun
		FROM	HAKSA.D_HAKJUK
		WHERE	HAKBUN = :ls_hakbun
		USING SQLCA ;
		
		if ls_iphak_gubun = '1' then
			ls_hj_sayu = 'A11'
			
		elseif ls_iphak_gubun = '2' then
			ls_hj_sayu = 'A12'
			
		elseif ls_iphak_gubun = '3' then
			ls_hj_sayu = 'A13'
			
		end if
		
		UPDATE	HAKSA.D_HAKJUK
		SET	SANGTAE_ID		= '01'	,
				HJMOD_ID			= 'A'		,
				HJMOD_SAYU_ID	= :ls_hj_sayu	,
				HJMOD_DATE		= :ls_iphak
		WHERE	HAKBUN = :ls_hakbun
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			commit USING SQLCA ;
			
		else
			MESSAGEBOX("오류","저장중 오류가 발생되었습니다(2).~n" + Sqlca.SqlErrText)
			rollback USING SQLCA ;
			return -1
		end if
		
	end if

else
	
	ls_hjmod		= dw_2.object.hjmod_id[li_row]
	ls_sayu		= dw_2.object.hjmod_sayu_id[li_row]
	ls_date		= dw_2.object.hjmod_sijum[li_row]
	ls_injung	= dw_2.object.sungjuk_injung[li_row]
	ls_year		= dw_2.object.year[li_row]
	ls_hakgi		= dw_2.object.hakgi[li_row]
	
	//학적변동에 따라 학적상태를 결정한다 - 학적마스터를 UPDATE하기위해.
	if ls_hjmod = 'A' or ls_hjmod = 'C' then
		ls_sangtae	= '01'
	elseif ls_hjmod = 'B' then
		ls_sangtae	= '02' 
	elseif ls_hjmod = 'D' or ls_hjmod = 'E' or ls_hjmod = 'H' then
		ls_sangtae	= '03' 
	ElseIf ls_hjmod = 'F' then
		ls_sangtae	= '05' 
	end if
	
	li_ans = dw_2.update()
	
	IF li_ans = 1 THEN
		
		IF ls_hjmod = 'B' THEN
		
			SELECT HJMOD_ID
			INTO	:ls_be_mod
			FROM	HAKSA.D_HAKJUK
			WHERE	HAKBUN	=	:ls_hakbun
			USING SQLCA ;
			
			//현재의 학적상태가 휴학이면 최초휴학일을 UPDATE 하지 않고, 아니면 UPDATE
			IF ls_be_mod = 'B' THEN
				
				UPDATE	HAKSA."D_HAKJUK"  
				SET		"SANGTAE_ID"		= :ls_sangtae	,
							"HJMOD_ID"			= :ls_hjmod		,
							"HJMOD_SAYU_ID"	= :ls_sayu		,
							"HJMOD_DATE"		= :ls_date
				WHERE		"HAKBUN"	= :ls_hakbun
				USING SQLCA ;
				
			ELSE
				
				UPDATE	HAKSA."D_HAKJUK"  
				SET		"SANGTAE_ID"		= :ls_sangtae	,
							"HJMOD_ID"			= :ls_hjmod		,
							"HJMOD_SAYU_ID"	= :ls_sayu		,
							"HJMOD_DATE"		= :ls_date		,
							"HUHAK_DATE"		= :ls_date	
				WHERE		"HAKBUN"	= :ls_hakbun 
				USING SQLCA ;
				
			END IF
			
		ELSE
			UPDATE	HAKSA."D_HAKJUK"  
			SET		"SANGTAE_ID"		= :ls_sangtae	,
						"HJMOD_ID"			= :ls_hjmod		,
						"HJMOD_SAYU_ID"	= :ls_sayu		,
						"HJMOD_DATE"		= :ls_date
			WHERE		"HAKBUN"	= :ls_hakbun 
			USING SQLCA ;
		END IF
		
		if sqlca.sqlcode = 0 then
			
			//SUGANG_TRANS UPDATE - 휴학, 제적, 퇴학일때만(성적인정코드 확정이 필요함.)
			if ls_injung = '0' then
				
				if ls_hjmod = 'B' or ls_hjmod = 'D' or ls_hjmod = 'E' then
					UPDATE HAKSA.D_SUGANG_TRANS
					SET	SUNGJUK_INJUNG = '2'
					WHERE HAKBUN	= :ls_hakbun	AND
							YEAR		= :ls_year		AND
							HAKGI		= :ls_hakgi
					USING SQLCA ;
							
					if sqlca.sqlcode = 0 or sqlca.sqlcode = 100 then
						commit USING SQLCA ;
					else
						MESSAGEBOX("오류","저장중 오류가 발생되었습니다.(수강신청내역)~r~n" + sqlca.sqlerrtext)
						rollback USING SQLCA ;
						return -1
					end if
				end if
			else
				COMMIT USING SQLCA ;
				MESSAGEBOX("확인","학적변동 처리되었습니다.")
				
			end if
		else
			MESSAGEBOX("오류","저장중 오류가 발생되었습니다.(학적)~r~n" + sqlca.sqlerrtext)
			ROLLBACK USING SQLCA ;
			RETURN -1
			
		end if
	ELSE
		MESSAGEBOX("오류","저장중 오류가 발생되었습니다.(학적변동)~r~n" + sqlca.sqlerrtext)
		ROLLBACK USING SQLCA ;
		RETURN -1
		
	END IF
end if

ls_delete_yn = dw_con.Object.delete_yn[1]
If ls_delete_yn = 'Y' Then ls_delete_yn = '%' ;

//저장된 자료를 보여주고, button을 control한다.
dw_1.retrieve(ls_hakbun)
dw_2.retrieve(ls_hakbun, ls_delete_yn)
wf_button_control(ls_hjmod)

end event

event ue_delete;call super::ue_delete;string ls_date, ls_hjmod
int li_row, li_cnt

if messagebox("확인","자료를 삭제하시겠습니까?", Question!, YesNo!, 2) = 2 then return

li_row = dw_2.getrow()
li_cnt  = dw_2.rowcount()

if li_row < 1 then return ;

if li_row = li_cnt then 
		dw_2.Object.delete_yn[li_row] = 'Y'
		
		wf_button_control('Z')			//저장되기 전까지 모든 버튼을 Disabled한다.
		
		If dw_2.Update(True, True) <> 1 Then
			Rollback using sqlca ;
			Messagebox('오류', '삭제시 오류가 발생하였습니다.')
			Return
		Else
			Commit using sqlca ;
			f_set_message('삭제 되었습니다.', '', parentwin)
		End If
		
else
	messagebox("오류","최종자료만 삭제할 수 있습니다.")
end if


end event

event open;call super::open;idw_update[1] = dw_2

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_1.InsertRow(0)
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwhj203a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwhj203a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwhj203a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwhj203a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwhj203a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwhj203a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwhj203a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwhj203a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwhj203a
end type

type uc_save from w_condition_window`uc_save within w_dhwhj203a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwhj203a
end type

type uc_print from w_condition_window`uc_print within w_dhwhj203a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwhj203a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwhj203a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwhj203a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwhj203a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwhj203a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwhj203a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwhj203a
end type

type dw_2 from uo_input_dwc within w_dhwhj203a
integer x = 1097
integer y = 300
integer width = 3337
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dhwhj203a"
end type

event clicked;call super::clicked;//이걸 사용하려면 hjmod_sayu_id가 Argument가 있는걸 사용.
//변동사유 Filter
DatawindowChild ldwc_hjmod
string ls_byen

if dwo.name = 'hjmod_sayu_id' then
	ls_byen = this.object.hjmod_id[row]
	
	this.getchild('hjmod_sayu_id',ldwc_hjmod)
	ldwc_hjmod.settransobject(sqlca)	
	ldwc_hjmod.retrieve()
	
	ldwc_hjmod.setfilter("left(hjmod_sayu_id, 1) = '"+ ls_byen +"' ")  
	ldwc_hjmod.filter()
end if

end event

type st_3 from statictext within w_dhwhj203a
integer x = 91
integer y = 60
integer width = 393
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31577551
string text = "학적변동처리"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_dhwhj203a
integer x = 512
integer y = 36
integer width = 270
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "휴학"
end type

event clicked;//휴학처리
string ls_hakbun, ls_today, ls_hakgicha, ls_injung, ls_year, ls_hakgi, ls_hjmod_before
int li_row, li_cnt

ls_hakbun	= dw_1.object.hakbun[1]
ls_today		= string(f_sysdate(), 'YYYYMMDD')
ls_hakgicha	= dw_1.object.s_hakgicha[1]

//금일 학적변동이 있으면 변경불가
SELECT COUNT(*)
INTO :li_cnt
FROM HAKSA.D_HAKBYEN
WHERE	HAKBUN		= :ls_hakbun	and
		HJMOD_SIJUM	= :ls_today 
USING SQLCA ;
		
if li_cnt > 0 then
	messagebox("오류","금일 학적변동이 발생되었습니다.~n학적변동을 발생시킬 수 없습니다.")
	return
end if
		

//학사일정
SELECT YEAR, HAKGI
INTO  :ls_year,
		:ls_hakgi
FROM	HAKSA.D_HAKSA_ILJUNG
WHERE	SIJUM_FLAG	=	'1' 
USING SQLCA ;
//
////1:인정, 2:불인정
//if ls_today <= ls_haksa_iljung then
//	ls_injung = '2'
//else
//	ls_injung = '1'
//end if

li_row = dw_2.insertrow(0)

dw_2.ScrollToRow(li_row)

dw_2.object.hakbun[li_row]				= ls_hakbun
dw_2.object.hjmod_id[li_row]			= 'B'
dw_2.object.hjmod_sijum[li_row]		= ls_today
dw_2.object.hakgicha[li_row]			= ls_hakgicha
dw_2.object.year[li_row]				= ls_year
dw_2.object.hakgi[li_row]				= ls_hakgi
dw_2.object.sungjuk_injung[li_row]	= '1'

dw_2.object.worker[li_row]		= gs_empcode
dw_2.object.ipaddr[li_row]		= gs_ip

ls_hjmod_before = dw_1.object.hjmod_id[1]

wf_button_control('Z')			//저장되기 전까지 모든 버튼을 Disabled한다.


end event

type cb_2 from commandbutton within w_dhwhj203a
integer x = 791
integer y = 36
integer width = 270
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "복학"
end type

event clicked;//복학처리
string ls_hakbun, ls_today, ls_hakgicha, ls_year, ls_hakgi
int li_row

ls_hakbun	= dw_1.object.hakbun[1]
ls_today		= string(f_sysdate(), 'YYYYMMDD')
ls_hakgicha	= dw_1.object.s_hakgicha[1]

//학사일정에서 현재년도 학기를 가져온다.
SELECT	YEAR,	HAKGI
INTO	:ls_year,
		:ls_hakgi
FROM	HAKSA.D_HAKSA_ILJUNG
WHERE	SIJUM_FLAG = '1' 
USING SQLCA ;

li_row = dw_2.insertrow(0)

dw_2.ScrollToRow(li_row)

dw_2.object.hakbun[li_row]				= ls_hakbun
dw_2.object.hjmod_id[li_row]			= 'C'
dw_2.object.hjmod_sijum[li_row]		= ls_today
dw_2.object.hakgicha[li_row]			= ls_hakgicha
dw_2.object.year[li_row]				= ls_year
dw_2.object.hakgi[li_row]				= ls_hakgi

dw_2.object.worker[li_row]		= gs_empcode
dw_2.object.ipaddr[li_row]		= gs_ip

wf_button_control('Z')			//저장되기 전까지 모든 버튼을 Disabled한다. 
end event

type cb_3 from commandbutton within w_dhwhj203a
integer x = 1070
integer y = 36
integer width = 270
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "제적"
end type

event clicked;//휴학처리
string ls_hakbun, ls_today, ls_haksa_iljung, ls_hakgicha, ls_injung, ls_year, ls_hakgi
int li_row

ls_hakbun	= dw_1.object.hakbun[1]
ls_today		= string(f_sysdate(), 'YYYYMMDD')
ls_hakgicha	= dw_1.object.s_hakgicha[1]

//학사일정에서 현재년도 학기를 가져온다.
SELECT	YEAR, HAKGI
INTO	:ls_year,
		:ls_hakgi
FROM	HAKSA.D_HAKSA_ILJUNG
WHERE	SIJUM_FLAG = '1' ;

////학사일정이 2/3선을 넘으면 성적을 인정한다.
//SELECT YEAR, HAKGI, DATE_32
//INTO  :ls_year,
//		:ls_hakgi, 
//		:ls_haksa_iljung
//FROM	HAKSA2002.HAKSA_ILJUNG
//WHERE	SIJUM_FLAG	=	'Y' ;
//
////1:인정, 2:불인정
//if ls_today <= ls_haksa_iljung then
//	ls_injung = '2'
//else
//	ls_injung = '1'
//end if

li_row = dw_2.insertrow(0)

dw_2.ScrollToRow(li_row)

dw_2.object.hakbun[li_row]				= ls_hakbun
dw_2.object.hjmod_id[li_row]			= 'D'
dw_2.object.hjmod_sijum[li_row]		= ls_today
dw_2.object.hakgicha[li_row]			= ls_hakgicha
dw_2.object.year[li_row]				= ls_year
dw_2.object.hakgi[li_row]				= ls_hakgi
dw_2.object.sungjuk_injung[li_row]	= '1'

dw_2.object.worker[li_row]		= gs_empcode
dw_2.object.ipaddr[li_row]		= gs_ip

wf_button_control('Z')			//저장되기 전까지 모든 버튼을 Disabled한다.


end event

type cb_4 from commandbutton within w_dhwhj203a
integer x = 1349
integer y = 36
integer width = 270
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "퇴학"
end type

event clicked;//퇴학처리
string ls_hakbun, ls_today, ls_haksa_iljung, ls_hakgicha, ls_injung, ls_year, ls_hakgi
int li_row

ls_hakbun	= dw_1.object.hakbun[1]
ls_today		= string(f_sysdate(), 'YYYYMMDD')
ls_hakgicha	= dw_1.object.s_hakgicha[1]

//학사일정에서 현재년도 학기를 가져온다.
SELECT	YEAR, HAKGI
INTO	:ls_year,
		:ls_hakgi
FROM	HAKSA.D_HAKSA_ILJUNG
WHERE	SIJUM_FLAG = '1' 
USING SQLCA ;


////학사일정이 2/3선을 넘으면 성적을 인정한다.
//SELECT YEAR, HAKGI, DATE_32
//INTO  :ls_year,
//		:ls_hakgi, 
//		:ls_haksa_iljung
//FROM	HAKSA2002.HAKSA_ILJUNG
//WHERE	SIJUM_FLAG	=	'Y' ;
//
////1:인정, 2:불인정
//if ls_today <= ls_haksa_iljung then
//	ls_injung = '2'
//else
//	ls_injung = '1'
//end if

li_row = dw_2.insertrow(0)

dw_2.ScrollToRow(li_row)

dw_2.object.hakbun[li_row]				= ls_hakbun
dw_2.object.hjmod_id[li_row]			= 'E'
dw_2.object.hjmod_sijum[li_row]		= ls_today
dw_2.object.hakgicha[li_row]			= ls_hakgicha
dw_2.object.year[li_row]				= ls_year
dw_2.object.hakgi[li_row]				= ls_hakgi
dw_2.object.sungjuk_injung[li_row]	= '1'

dw_2.object.worker[li_row]		= gs_empcode
dw_2.object.ipaddr[li_row]		= gs_ip

wf_button_control('Z')			//저장되기 전까지 모든 버튼을 Disabled한다.


end event

type cb_5 from commandbutton within w_dhwhj203a
integer x = 1627
integer y = 36
integer width = 270
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "재입학"
end type

event clicked;//재입학처리
string ls_hakbun, ls_today, ls_hakgicha, ls_year, ls_hakgi
int li_row

ls_hakbun	= dw_1.object.hakbun[1]
ls_today		= string(f_sysdate(), 'YYYYMMDD')
ls_hakgicha	= dw_1.object.s_hakgicha[1]

//학사일정에서 현재년도 학기를 가져온다.
SELECT	YEAR, HAKGI
INTO	:ls_year,
		:ls_hakgi
FROM	HAKSA.D_HAKSA_ILJUNG
WHERE	SIJUM_FLAG = '1' 
USING SQLCA ;

li_row = dw_2.insertrow(0)

dw_2.ScrollToRow(li_row)

dw_2.object.hakbun[li_row]				= ls_hakbun
dw_2.object.hjmod_id[li_row]			= 'A'
dw_2.object.hjmod_sayu_id[li_row]	= 'A12'
dw_2.object.hjmod_sijum[li_row]		= ls_today
dw_2.object.hakgicha[li_row]			= ls_hakgicha
dw_2.object.year[li_row]				= ls_year
dw_2.object.hakgi[li_row]				= ls_hakgi

dw_2.object.worker[li_row]		= gs_empcode
dw_2.object.ipaddr[li_row]		= gs_ip

wf_button_control('Z')			//저장되기 전까지 모든 버튼을 Disabled한다.


end event

type dw_1 from uo_dwfree within w_dhwhj203a
integer x = 50
integer y = 300
integer width = 1024
integer height = 1964
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dhwhj203q"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)

func.of_design_dw(dw_1)
end event

type dw_con from uo_dwfree within w_dhwhj203a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 130
string dataobject = "d_dhwhj203a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_6 from commandbutton within w_dhwhj203a
integer x = 1906
integer y = 36
integer width = 270
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "자퇴"
end type

event clicked;//자퇴처리-추가
string ls_hakbun, ls_today, ls_haksa_iljung, ls_hakgicha, ls_injung, ls_year, ls_hakgi
int li_row

ls_hakbun	= dw_1.object.hakbun[1]
ls_today		= string(f_sysdate(), 'YYYYMMDD')
ls_hakgicha	= dw_1.object.s_hakgicha[1]

//학사일정에서 현재년도 학기를 가져온다.
SELECT	YEAR, HAKGI
INTO	:ls_year,
		:ls_hakgi
FROM	HAKSA.D_HAKSA_ILJUNG
WHERE	SIJUM_FLAG = '1' 
USING SQLCA ;

li_row = dw_2.insertrow(0)

dw_2.ScrollToRow(li_row)

dw_2.object.hakbun[li_row]				= ls_hakbun
dw_2.object.hjmod_id[li_row]			= 'H'
dw_2.object.hjmod_sijum[li_row]		= ls_today
dw_2.object.hakgicha[li_row]			= ls_hakgicha
dw_2.object.year[li_row]				= ls_year
dw_2.object.hakgi[li_row]				= ls_hakgi
dw_2.object.sungjuk_injung[li_row]	= '1'

dw_2.object.worker[li_row]		= gs_empcode
dw_2.object.ipaddr[li_row]		= gs_ip

wf_button_control('Z')			//저장되기 전까지 모든 버튼을 Disabled한다.


end event

type cb_7 from commandbutton within w_dhwhj203a
integer x = 2185
integer y = 36
integer width = 270
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "수료"
end type

event clicked;//자퇴처리-추가
string ls_hakbun, ls_today, ls_haksa_iljung, ls_hakgicha, ls_injung, ls_year, ls_hakgi
int li_row

ls_hakbun	= dw_1.object.hakbun[1]
ls_today		= string(f_sysdate(), 'YYYYMMDD')
ls_hakgicha	= dw_1.object.s_hakgicha[1]

//학사일정에서 현재년도 학기를 가져온다.
SELECT	YEAR, HAKGI
INTO	:ls_year,
		:ls_hakgi
FROM	HAKSA.D_HAKSA_ILJUNG
WHERE	SIJUM_FLAG = '1' 
USING SQLCA ;

li_row = dw_2.insertrow(0)

dw_2.ScrollToRow(li_row)

dw_2.object.hakbun[li_row]				= ls_hakbun
dw_2.object.hjmod_id[li_row]			= 'F'
dw_2.object.hjmod_sijum[li_row]		= ls_today
dw_2.object.hakgicha[li_row]			= ls_hakgicha
dw_2.object.year[li_row]				= ls_year
dw_2.object.hakgi[li_row]				= ls_hakgi
dw_2.object.sungjuk_injung[li_row]	= '1'

dw_2.object.worker[li_row]		= gs_empcode
dw_2.object.ipaddr[li_row]		= gs_ip

wf_button_control('Z')			//저장되기 전까지 모든 버튼을 Disabled한다.


end event

