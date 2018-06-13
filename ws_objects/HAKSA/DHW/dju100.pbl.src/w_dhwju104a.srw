$PBExportHeader$w_dhwju104a.srw
$PBExportComments$[대학원졸업] 논문심사관리
forward
global type w_dhwju104a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwju104a
end type
type dw_con from uo_dwfree within w_dhwju104a
end type
type uo_1 from uo_imgbtn within w_dhwju104a
end type
end forward

global type w_dhwju104a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_dhwju104a w_dhwju104a

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
//dw_con.Object.jungong.Protect   = li_chk3

//dw_main.Object.d_hakjuk_gyeyul_id.Protect    = li_chk1
//dw_main.Object.d_hakjuk_gwa_id.Protect       = li_chk2
//dw_main.Object.d_hakjuk_jungong_id.Protect  = li_chk3
end subroutine

on w_dhwju104a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
end on

on w_dhwju104a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event open;call super::open;string	ls_hakgi, ls_year

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
end event

event ue_delete;call super::ue_delete;int li_ans

//삭제확인
if uf_messagebox(4) = 2 then return

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

event ue_insert;call super::ue_insert;string ls_year, ls_hakgi, ls_dhw, ls_hakgwa, ls_gwajung
long ll_line

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_line = dw_main.insertrow(0)

dw_main.scrolltorow(ll_line)
dw_main.object.d_nonmun_simsa_year[ll_line]	= ls_year
dw_main.object.d_nonmun_simsa_hakgi[ll_line]	= ls_hakgi

dw_main.object.worker[ll_line]		= gs_empcode
dw_main.object.ipaddr[ll_line]		= gs_ip

dw_main.SetColumn('d_nonmun_simsa_hakbun')
dw_main.setfocus()
end event

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_hakbun, ls_gyeyul_id
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwajung  =	func.of_nvl(dw_con.Object.gwajung[1], '%') + '%'
ls_gyeyul_id =  func.of_nvl(dw_con.Object.gyeyul_id[1], '%') + '%'
ls_hakgwa   =	func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_hakbun    =  func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwajung, ls_gyeyul_id, ls_hakgwa, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if


end event

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwju104a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwju104a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwju104a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwju104a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwju104a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwju104a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwju104a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwju104a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwju104a
end type

type uc_save from w_condition_window`uc_save within w_dhwju104a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwju104a
end type

type uc_print from w_condition_window`uc_print within w_dhwju104a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwju104a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwju104a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwju104a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwju104a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwju104a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwju104a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwju104a
end type

type dw_main from uo_input_dwc within w_dhwju104a
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dhwju104a"
end type

event itemchanged;call super::itemchanged;string ls_gwajung, ls_hakgwa, ls_hname

CHOOSE CASE	DWO.NAME
	//학번이 입력되면 기본사항을 가져온다.
	CASE	'd_nonmun_simsa_hakbun'
		
		SELECT	GWAJUNG_ID,
					GWA_ID,
					HNAME
		INTO	:ls_gwajung,
				:ls_hakgwa,
				:ls_hname
		FROM	HAKSA.D_HAKJUK
		WHERE	HAKBUN	=	:data	
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","잘못된 학번입니다.")
			this.object.d_nonmun_simsa_hakbun[row]	=	''
			return 1
			
		else
			this.object.d_hakjuk_hname[row]			=	ls_hname
			this.object.d_hakjuk_gwajung_id[row]	=	ls_gwajung
			this.object.d_hakjuk_gwa_id[row]			=	ls_hakgwa
			
		end if

END CHOOSE
		
end event

event itemerror;call super::itemerror;return 2
end event

type dw_con from uo_dwfree within w_dhwju104a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 170
boolean bringtotop = true
string dataobject = "d_dhwju104a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//
//Choose Case dwo.name
//	Case 'gwa'
//		DataWindowChild ldwc_hjmod
//
//		This.getchild('jungong', ldwc_hjmod)
//		ldwc_hjmod.SetTransObject(sqlca)	
//		ldwc_hjmod.Retrieve(data)
//		
//End Choose
end event

type uo_1 from uo_imgbtn within w_dhwju104a
integer x = 727
integer y = 40
integer width = 329
integer taborder = 70
boolean bringtotop = true
string btnname = "사정처리"
end type

event clicked;call super::clicked;/***************************************************************************************************************
	논문심사에 대한 사정처리
	심사위원중 석사 2/3이상 합격이면 최종합격.
	합격하면 D_NONMUN에 논문Pass 여부를 넣어준다('1' : Pass).
****************************************************************************************************************/

string ls_year, ls_hakgi, ls_hakbun, ls_gwajung
double ld_jumsu
int li_cnt, li_nonmun, li_prof_no
long ll_tot, i

if messagebox("확인","논문심사 사정처리를 실행하시겠습니까?",Question!, YesNo!, 2) = 2 then return

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

SELECT	COUNT(DISTINCT HAKBUN)
INTO :ll_tot
FROM	HAKSA.D_NONMUN_SIMASA
WHERE	YEAR	= :ls_year		
AND	HAKGI	= :ls_hakgi 	
USING SQLCA ;
		
SetPointer(HourGlass!)

//논문심사에 나와있는 학생수 만큼 커서 실행.
DECLARE CUR_NONMUN CURSOR FOR
SELECT DISTINCT HAKBUN
FROM	HAKSA.D_NONMUN_SIMSA
WHERE YEAR	= :ls_year
AND	HAKGI	= :ls_hakgi 
ORDER BY HAKBUN
USING SQLCA ;
	
OPEN CUR_NONMUN	;
DO
	FETCH CUR_NONMUN INTO :ls_hakbun ;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	//심사위원수, 논문점수 합격 수
	SELECT	COUNT(HAKBUN), 
				SUM(DECODE(PANJUNG, '1', 1, 0))
	INTO	:li_cnt,
			:li_nonmun
	FROM	HAKSA.D_NONMUN_SIMSA
	WHERE	YEAR		= :ls_year
	AND	HAKGI		= :ls_hakgi
	AND	HAKBUN	= :ls_hakbun	
	GROUP BY HAKBUN 
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","논문심사 사정중 오류발생~R~N" + SQLCA.SQLERRTEXT)
		return
	end if
	
		
	//심사위원의 합격선을 구함(석사 2/3 )
	li_prof_no = Ceiling(li_cnt * (2/3))

	//합격받은 건수가 심사위원의 합격선보다 많으면 'P', 아니면 'N'
	if li_prof_no <= li_nonmun then
		UPDATE	HAKSA.D_NONMUN
		SET	PANJUNG	= '1'
		WHERE	HAKBUN = :ls_hakbun 
		USING SQLCA ;
	else
		UPDATE	HAKSA.D_NONMUN
		SET	PANJUNG	= '0'
		WHERE	HAKBUN = :ls_hakbun
		USING SQLCA ;
	end if
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","논문심사결과 사정중 오류가 발생되었습니다(D_Nonmun Update)")
		rollback USING SQLCA ;
		return
	end if
	
loop while true
close cur_nonmun ;

commit USING SQLCA ;
SetPointer(HourGlass!)
messagebox("확인","사정처리가 완료되었습니다.")

end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

