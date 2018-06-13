$PBExportHeader$w_dhwsu202a.srw
$PBExportComments$[대학원수업] 수강신청(관리자)
forward
global type w_dhwsu202a from w_condition_window
end type
type dw_sigan from uo_input_dwc within w_dhwsu202a
end type
type st_5 from statictext within w_dhwsu202a
end type
type st_6 from statictext within w_dhwsu202a
end type
type st_7 from statictext within w_dhwsu202a
end type
type st_8 from statictext within w_dhwsu202a
end type
type dw_con from uo_dwfree within w_dhwsu202a
end type
type dw_main from uo_dwfree within w_dhwsu202a
end type
type dw_hakjuk from uo_dwfree within w_dhwsu202a
end type
end forward

global type w_dhwsu202a from w_condition_window
dw_sigan dw_sigan
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
dw_con dw_con
dw_main dw_main
dw_hakjuk dw_hakjuk
end type
global w_dhwsu202a w_dhwsu202a

type variables
string	is_hakbun
end variables

forward prototypes
public subroutine wf_con_protect ()
end prototypes

public subroutine wf_con_protect ();// 계열, 학과, 전공 사용유무를 체크하여 protect한다.
// ls_chk1 : 계열, ls_chk2 : 학과, ls_chk3 : 전공
// Y: 사용, N: 미사용

String ls_chk1, ls_chk2, ls_chk3
Int      li_chk1, li_chk2, li_chk3

SELECT ETC_CD1, ETC_CD2, ETC_CD3
   INTO :ls_chk1, :ls_chk2, :ls_chk3
  FROM CDDB.KCH102D
 WHERE CODE_GB = 'DHW01'
 USING SQLCA ;
 
If  ls_chk1 = 'Y' Then
	li_chk1 = 0
Else
	li_chk1 = 1
End If

If  ls_chk2 = 'Y' Then
	li_chk2 = 0
Else
	li_chk2 = 1
End If

If  ls_chk3 = 'Y' Then
	li_chk3 = 0
Else
	li_chk3 = 1
End If
 
dw_con.Object.gyeyul_id.Protect = li_chk1
dw_con.Object.gwa.Protect        = li_chk2
dw_con.Object.jungong.Protect   = li_chk3

//////dw_main.Object.d_hakjuk_gyeyul_id.Protect    = li_chk1
//dw_sigan.Object.gwa_id.Protect       = li_chk2
//dw_sigan.Object.jungong_id.Protect  = li_chk3
end subroutine

on w_dhwsu202a.create
int iCurrent
call super::create
this.dw_sigan=create dw_sigan
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.dw_con=create dw_con
this.dw_main=create dw_main
this.dw_hakjuk=create dw_hakjuk
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sigan
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.st_8
this.Control[iCurrent+6]=this.dw_con
this.Control[iCurrent+7]=this.dw_main
this.Control[iCurrent+8]=this.dw_hakjuk
end on

on w_dhwsu202a.destroy
call super::destroy
destroy(this.dw_sigan)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.dw_hakjuk)
end on

event ue_retrieve;call super::ue_retrieve;string ls_hakbun, ls_year, ls_hakgi, ls_hakgwa, ls_gwajung, ls_jungong, ls_gyeyul_id, ls_hakgwa1
long ll_ans1, ll_ans2

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  dw_con.Object.hakbun[1]

If (ls_hakbun = '' Or Isnull(ls_hakbun))Then
	messagebox("확인","학번을 입력하세요!")
	dw_hakjuk.SetFocus()
	dw_hakjuk.SetColumn("hakbun")
	Return -1
End If

ll_ans1 = dw_hakjuk.retrieve(ls_hakbun)

if ll_ans1 = 1 then
	
	dw_hakjuk.Accepttext()
	
	ls_gwajung	=  func.of_nvl(dw_hakjuk.object.gwajung_id[1], '%') 
	ls_hakgwa	=  func.of_nvl(dw_con.object.gwa[1], '%')
	ls_hakgwa1 =  dw_hakjuk.object.gwa_id[1]
	ls_gyeyul_id =  func.of_nvl(dw_hakjuk.Object.gyeyul_id[1], '%')
	ls_jungong	= func.of_nvl(dw_hakjuk.object.jungong_id[1], '%')
	
//	dw_con.object.gwa[1] = ls_hakgwa1
	
	ll_ans2 = dw_sigan.retrieve(ls_year, ls_hakgi, ls_gwajung, ls_gyeyul_id, ls_hakgwa, ls_jungong)
	dw_main.retrieve(ls_hakbun, ls_year, ls_hakgi)
	
	if ll_ans2 <= 0 then
		messagebox("확인","학생의 시간표가 존재하지 않습니다.")
	end if
	
else
	messagebox("오류","잘못된 학번입니다.")
	dw_con.Object.hakbun[1] = ''
	return -1
end if

Return 1
end event

event open;call super::open;string	ls_hakgi, ls_year
DataWindowChild ldwc_hjmod

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi 

dw_con.getchild('jungong', ldwc_hjmod)
ldwc_hjmod.SetTransObject(sqlca)	
ldwc_hjmod.Retrieve('%')

end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwsu202a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwsu202a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwsu202a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwsu202a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwsu202a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwsu202a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwsu202a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwsu202a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwsu202a
end type

type uc_save from w_condition_window`uc_save within w_dhwsu202a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwsu202a
end type

type uc_print from w_condition_window`uc_print within w_dhwsu202a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwsu202a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwsu202a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwsu202a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwsu202a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwsu202a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwsu202a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwsu202a
end type

type dw_sigan from uo_input_dwc within w_dhwsu202a
integer x = 50
integer y = 576
integer width = 4384
integer height = 632
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwsu202q_2"
boolean border = true
end type

event doubleclicked;call super::doubleclicked;/********************************************************************************************************************
									- Double Click이 되면 수강신청이 이루어짐 -
	제한 사항
	1. 이번 학기 이미 신청한 과목인지 체크 
	2. 한학기 수강신청 가능학점 체크(9학점 이하.)
	3. 재수강 여부 체크(C+이하과목에 한해서)
*********************************************************************************************************************/

string ls_year, ls_hakgi, ls_hakbun, ls_gwajung, ls_hakgwa, ls_jungong, ls_gwamok, ls_isu
string ls_s_jungong, ls_s_hakgwa, ls_s_gwajung, ls_jesu_year, ls_jesu_hakgi, ls_jesu_gubun, ls_prof
double ld_hakjum, ld_pyen_avg, ld_sum_hakjum, ld_init_hakjum
int li_gwamok, li_msg, li_line, li_ans, li_check, li_gijon_gwamok, li_daeche_gwamok
date ldt_date

string	ls_wan_yn, ls_bun_yn
string	ls_iphak_year, ls_iphak_hakgi,  ls_old_year,     ls_old_hakgi

if this.getclickedrow() <= 0 then return

if dw_hakjuk.rowcount() <= 0 then return

//system 날짜를 받아온다.
select sysdate
into :ldt_date
from dual ;

//수강신청 하고자 하는 과목에 대한 내역을 가져옴.
ls_year			= dw_sigan.object.year[row]
ls_hakgi			= dw_sigan.object.hakgi[row]
ls_s_gwajung	= dw_sigan.object.gwajung_id[row]
ls_s_hakgwa		= dw_sigan.object.gwa_id[row]
ls_s_jungong	= dw_sigan.object.jungong_id[row]
ls_gwamok		= dw_sigan.object.gwamok_id[row]
ls_isu			= dw_sigan.object.isu_id[row]
ld_hakjum		= dw_sigan.object.hakjum[row]
ls_prof			= dw_sigan.object.member_no[row]


//학적내용
ls_hakbun	= dw_hakjuk.object.hakbun[1]
ls_gwajung	= dw_hakjuk.object.gwajung_id[1]
ls_hakgwa	= dw_hakjuk.object.gwa_id[1]
ls_jungong	= dw_hakjuk.object.jungong_id[1]


//************************************************ 제한 사항 시작 **************************************************//

//---------------------------	분납인 학생은 수강정정을 할 수 없다.
SELECT	WAN_YN,
			BUN_YN
INTO	:ls_wan_yn,
		:ls_bun_yn
FROM	HAKSA.D_DUNGROK
WHERE	YEAR		=	:ls_year
AND	HAKGI		=	:ls_hakgi
AND	HAKBUN	=	:ls_hakbun
AND	CHASU		=	1
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	
	//신입생은 분납자라도 수강신청 가능하다.
	SELECT	SUBSTR(IPHAK_DATE, 1, 4),
				DECODE(SUBSTR(IPHAK_DATE, 5, 2), '03', '1', '08', '2')
	INTO	:ls_iphak_year,
			:ls_iphak_hakgi
	FROM	HAKSA.D_HAKJUK
	WHERE	HAKBUN	=	:ls_hakbun
	USING SQLCA ;
	
	if ( ls_year	<>	ls_iphak_year or ls_hakgi	<>	ls_iphak_hakgi) then
		
		if ls_wan_yn = '0' and ls_bun_yn = '1' then
			messagebox("확인","분납자는 완납시까지 수강정정을 할 수 없습니다.")
			return
		end if
		
	end if	
	
END IF

//-------------------------- 1. 이번학기 이미 신청한 과목인지 체크
SELECT count(*)
INTO :li_gwamok
FROM	HAKSA.D_SUGANG_TRANS
WHERE	YEAR			= :ls_year		and
		HAKGI			= :ls_hakgi		and
		HAKBUN		= :ls_hakbun	and
		GWAMOK_ID	= :ls_gwamok
		USING SQLCA ;
		
		if li_gwamok > 0 then
			messagebox("오류","이미 수강신청이 되어 있습니다.")
			return
		end if

//-------------------------- 2. 기존 취득한 과목인지 체크
SELECT count(*)
INTO :li_gijon_gwamok
FROM	HAKSA.D_SUGANG
WHERE	HAKBUN		= :ls_hakbun	and
		GWAMOK_ID	= :ls_gwamok
USING SQLCA ;
		
if li_gijon_gwamok > 0 then
	messagebox("오류","이미 성적 취득한 과목입니다.")
	return
end if

//-------------------------- 2-1. 기존 취득한 과목인지 체크(대체과목) => 로직추가
SELECT MAX(A.YEAR),  MAX(A.HAKGI), COUNT(*)
   INTO :ls_old_year,     :ls_old_hakgi,   :li_daeche_gwamok
 FROM HAKSA.D_SUGANG A
         , HAKSA.D_DAECHE_GWAMOK B
WHERE A.GWAMOK_ID = B.GWAMOK_ID_AFTER
     AND A.HAKBUN		  = :ls_hakbun
	AND A.GWAMOK_ID = :ls_gwamok
	AND A.HWANSAN <> 'F'
    AND ROWNUM = 1
USING SQLCA ;
		
If li_daeche_gwamok > 0 Then
	messagebox("오류", ls_old_year + '년도 ' + ls_old_hakgi + "학기에 수강한 과목입니다.")
	Return
End If
	

//-------------------------- 3. 초과학점 체크
////이전학기 평점평균을 가져온다.
//SELECT PYENGJUM_AVG
//INTO :ld_pyen_avg
//FROM	HAKSA.D_SUNGJUKGYE
//WHERE	HAKBUN	= :ls_hakbun	AND
//		YEAR||HAKGI = (SELECT MAX(YEAR||HAKGI)
//							FROM	D_SUNGJUKGYE
//							WHERE	HAKBUN = :ls_hakbun) ;

//현재까지 신청된 학점을 가져온다.
//SELECT	SUM(HAKJUM)
//into  :ld_sum_hakjum
//from HAKSA.D_SUGANG_TRANS
//where YEAR				= :ls_year		AND
//		HAKGI				= :ls_hakgi		AND
//		HAKBUN			= :ls_hakbun	AND
//		SUNGJUK_INJUNG	= '1'	
//USING SQLCA ;
//		
//if sqlca.sqlcode <> 0 then
//	messagebox("오류","현재까지 수강신청된 학점을 가져올 수 없습니다.~r~n" + sqlca.sqlerrtext)
//	return
//end if

// 기준학점
SELECT ETC_AMT1 
  INTO  :ld_init_hakjum
  FROM CDDB.KCH102D
 WHERE CODE_GB = 'DHW02'
   AND USE_YN = 'Y'
 USING SQLCA ;

// 등록된 학점합계
ld_sum_hakjum = dw_main.Object.sum_hakjum[1]

// 공통코드('DHW02')에 등록된 기준학점을 초과할수 없다.
if ld_sum_hakjum  + ld_hakjum > ld_init_hakjum then 
	messagebox("확인", string(ld_init_hakjum) + "학점을 초과할 수 없습니다.")
	return
end if

//----------------------------------- 4. 재수강 여부 체크
SELECT YEAR,	HAKGI
INTO :ls_jesu_year, :ls_jesu_hakgi
FROM	HAKSA.D_SUGANG
WHERE	HAKBUN			= :ls_hakbun	and
		GWAMOK_ID		= :ls_gwamok	and	
		SUNGJUK_INJUNG	= '01'
USING SQLCA ;
		
if sqlca.sqlcode = 0 then		
	li_msg = messagebox("확인",ls_jesu_year + "년도 " + ls_jesu_hakgi + "학기에 수강한 과목입니다.~r~n재수강하시겠습니까?", Question!, YesNo!, 2)
										
	if li_msg = 1 then 
		ls_jesu_gubun = '1'
	else
		return
	end if
end if

//-------------------- 수강신청 ---------------------
li_line = dw_main.insertrow(0)

dw_main.object.hakbun[li_line]				= ls_hakbun
dw_main.object.year[li_line]					= ls_year	
dw_main.object.hakgi[li_line]					= ls_hakgi	
dw_main.object.gwa_id[li_line]				= ls_s_hakgwa	
dw_main.object.jungong_id[li_line]			= ls_s_jungong
dw_main.object.gwajung_id[li_line]			= ls_gwajung	
dw_main.object.gwamok_id[li_line]			= ls_gwamok	
dw_main.object.isu_id[li_line]				= ls_isu	
dw_main.object.hakjum[li_line]				= ld_hakjum	
dw_main.object.sungjuk_injung[li_line]		= '1'
dw_main.object.jesu_gubun[li_line]			= ls_jesu_gubun
dw_main.object.jesu_year[li_line]			= ls_jesu_year
dw_main.object.jesu_hakgi[li_line]			= ls_jesu_hakgi
dw_main.object.member_no[li_line]			= ls_prof

dw_main.object.worker[li_line]		= gs_empcode
dw_main.object.ipaddr[li_line]		= gs_ip

li_ans = dw_main.update()

if li_ans = -1 then
	messagebox("오류","수강신청시 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
	dw_main.deleterow(li_line)
	
elseif li_ans = 1 then
	commit USING SQLCA ;
	dw_main.retrieve(ls_hakbun, ls_year, ls_hakgi)
end if

end event

type st_5 from statictext within w_dhwsu202a
integer x = 50
integer y = 492
integer width = 4384
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = " 시 간 표"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_dhwsu202a
integer x = 50
integer y = 1280
integer width = 4384
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = " 수 강 신 청 내 역"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_7 from statictext within w_dhwsu202a
integer x = 37
integer y = 1216
integer width = 2414
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "※수강신청을 원하는 과목을 마우스로 더블클릭하시면 수강신청이 이루어집니다."
boolean focusrectangle = false
end type

type st_8 from statictext within w_dhwsu202a
integer x = 46
integer y = 2208
integer width = 2158
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "※수강신청된 과목을 삭제하시려면 해당 강좌를 더블클릭하시면 됩니다."
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_dhwsu202a
integer x = 55
integer y = 168
integer width = 4379
integer height = 200
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_dhwsu202a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String ls_hakbun, ls_hname
vector    lvc_data

lvc_data   = create vector

Choose Case dwo.name
	Case 'gwa'
		DataWindowChild ldwc_hjmod

		This.getchild('jungong', ldwc_hjmod)
		ldwc_hjmod.SetTransObject(sqlca)	
		ldwc_hjmod.Retrieve(data)
		
	Case 'hakbun', 'hname'
		If dwo.name = 'hakbun'  Then ls_hakbun = data ;
		If dwo.name = 'hname'  Then ls_hname  = data ;
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'   , '')
			This.Post SetItem(row, 'hname'  ,  '')
			RETURN
		End If
		
		Choose Case  f_d_hakjuk_search(ls_hakbun, ls_hname, lvc_data)
			Case	1
				This.Object.hakbun[row]	 = lvc_data.GetProperty('hakbun'	)
				This.Object.hname[row]  = lvc_data.GetProperty('hname'	)				
					
				Return 2
			Case Else
				This.Trigger Event clicked(-1, 0, row, This.object.p_emp)
		End Choose
		
End Choose
end event

event clicked;call super::clicked;Vector lvc_data

This.AcceptText()
lvc_data = Create Vector

Choose Case dwo.name
	Case 'p_emp'
		 lvc_data.setproperty('parm_cnt' , '1')		
		 lvc_data.setProperty('hakbun'  , This.object.hakbun[row] )
	 	 lvc_data.setProperty('hname'   , This.object.hname[row])
			
		If	openwithparm(w_d_hakjuk_pop, lvc_data) = 1 Then
			lvc_data = message.powerobjectparm
			If isvalid(lvc_data) Then
				If Long(lvc_data.GetProperty("parm_cnt")) = 0 Then RETURN ;		
				This.Object.hakbun[row]	 = lvc_data.GetProperty("hakbun1")
				This.Object.hname[row]	 = lvc_data.GetProperty("hname1")		
			End If
		End If
		
End Choose

Destroy lvc_data
end event

type dw_main from uo_dwfree within w_dhwsu202a
integer x = 55
integer y = 1360
integer width = 4379
integer height = 840
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_dhwsu202a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event doubleclicked;call super::doubleclicked;/********************************************************************************************************************
									- Double Click이 되면 Sugang_Trans에서 삭제 -
*********************************************************************************************************************/
int li_ans
string ls_year, ls_hakgi, ls_hakbun

if this.getclickedrow() <= 0 then return
if dw_hakjuk.rowcount() <= 0 then return

if messagebox("확인","수강신청내역을 삭제하시겠습니까?", Question!, YesNo!, 2) = 2 then return

dw_main.deleterow(row)
li_ans = dw_main.update()

if li_ans = -1 then
	messagebox("오류","수강신청내역 삭제시 오류가 발생했습니다.")
	rollback USING SQLCA ;
	//수강신청내역을 다시 조회한다.
	dw_con.AcceptText()

	ls_year		=	dw_con.Object.year[1]
	ls_hakgi		=	dw_con.Object.hakgi[1]
	ls_hakbun	= dw_hakjuk.object.hakbun[1]
	this.retrieve(ls_year, ls_hakgi, ls_hakbun)
	
elseif li_ans = 1 then
	commit USING SQLCA ;
	
end if
end event

event constructor;call super::constructor;This.SetTransObject(sqlca)

end event

type dw_hakjuk from uo_dwfree within w_dhwsu202a
integer x = 50
integer y = 376
integer width = 4384
integer height = 112
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dhwsu202q_1"
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

