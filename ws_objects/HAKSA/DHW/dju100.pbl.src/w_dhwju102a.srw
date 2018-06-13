$PBExportHeader$w_dhwju102a.srw
$PBExportComments$[대학원졸업] 종합시험신청
forward
global type w_dhwju102a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwju102a
end type
type dw_con from uo_dwfree within w_dhwju102a
end type
type uo_1 from uo_imgbtn within w_dhwju102a
end type
end forward

global type w_dhwju102a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_dhwju102a w_dhwju102a

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

on w_dhwju102a.create
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

on w_dhwju102a.destroy
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
dw_main.object.d_jonghap_year[ll_line]			= ls_year
dw_main.object.d_jonghap_hakgi[ll_line]		= ls_hakgi
dw_main.object.d_jonghap_gyulsi_yn[ll_line]	= '0'

dw_main.object.d_jonghap_worker[ll_line]		= gs_empcode
dw_main.object.d_jonghap_ipaddr[ll_line]		= gs_ip

dw_main.SetColumn('d_jonghap_hakbun')
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

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwajung, ls_gyeyul_id, ls_hakgwa, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1

end event

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwju102a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwju102a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwju102a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwju102a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwju102a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwju102a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwju102a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwju102a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwju102a
end type

type uc_save from w_condition_window`uc_save within w_dhwju102a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwju102a
end type

type uc_print from w_condition_window`uc_print within w_dhwju102a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwju102a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwju102a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwju102a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwju102a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwju102a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwju102a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwju102a
end type

type dw_main from uo_input_dwc within w_dhwju102a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dhwju102a"
end type

event itemchanged;call super::itemchanged;string ls_gwajung, ls_hakgwa, ls_hname
string ls_gwamok
int i, li_null

setnull(li_null)

CHOOSE CASE	DWO.NAME
	//학번이 입력되면 기본사항을 가져온다.
	CASE	'd_jonghap_hakbun'
		
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
			this.object.d_jonghap_hakbun[row]	=	''
			return 1
			
		else
			this.object.d_hakjuk_hname[row]			=	ls_hname
//			this.object.d_hakjuk_gwajung_id[row]	=	ls_gwajung
			this.object.d_hakjuk_gwa_id[row]			=	ls_hakgwa
			
		end if
		
	//점수 입력 check	
	CASE	'd_jonghap_jumsu'
		
		if dec(data) < 0 or dec(data) > 100 then
			messagebox("오류","점수는 0점에서 100점까지 입력가능합니다..")
			this.object.d_jonghap_jumsu[row] = li_null
			return 1
		end if
		
	CASE	'd_jonghap_gwamok_id'
		//과목코드를 입력하면 이전자료를 검색하여 담당교수와 출제교수를 가져온다.
		for i = 1 to this.getrow()
			
			ls_gwamok = this.object.d_jonghap_gwamok_id[i]
			if ls_gwamok = data then
				this.object.d_jonghap_member_no1[row]	=	this.object.d_jonghap_member_no1[i]
				this.object.d_jonghap_member_no2[row]	=	this.object.d_jonghap_member_no2[i]
								
				return
			end if
		next
		
	CASE	'd_jonghap_gyulsi_yn'
		if data = '1' then
			this.object.d_jonghap_jumsu[row] = li_null
			return 1
		end if
		
END CHOOSE
		
end event

event itemerror;call super::itemerror;return 2
end event

type dw_con from uo_dwfree within w_dhwju102a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_dhwju102a_c1"
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

type uo_1 from uo_imgbtn within w_dhwju102a
integer x = 672
integer y = 40
integer width = 347
integer taborder = 70
boolean bringtotop = true
string btnname = "사정처리"
end type

event clicked;call super::clicked;/***************************************************************************************************************
	종합 시험 성적사정 처리
	- 현재 년도, 학기에 시험친 학생만 사정함.
	  석사 : 60점이상 과목이 3과목
	  과목별 합격이 인정되므로 현재 학기 까지 시험친 전체과목을 사정대상에 포함함.
****************************************************************************************************************/

string ls_hakbun, ls_gwamok, ls_year, ls_hakgi, ls_sysdate, ls_gwajung
int li_cnt
long ll_tot, i
double ld_jumsu

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 사정처리를 실행하시겠습니까?", Question!, YesNo!, 2) = 2 then return

ls_sysdate = string(f_sysdate(), 'YYYYMMDD')

SetPointer(HourGlass!)

//select count(distinct hakbun)
//into :ll_tot
//from d_jong_sihum 
//where year	= :ls_year	and
//		hakgi	= :ls_hakgi  ;

DECLARE CUR_SAJUNG CURSOR FOR
SELECT DISTINCT HAKBUN
FROM	HAKSA.D_JONGHAP
WHERE	YEAR	= :ls_year
AND	HAKGI	= :ls_hakgi 
ORDER BY HAKBUN
USING SQLCA ;
		
OPEN CUR_SAJUNG	;
DO
	FETCH CUR_SAJUNG	INTO	:ls_hakbun ;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	//년도, 학기에 관계없이 지금까지 시험친 모든 과목이 사정대상에 적용됨.
	SELECT COUNT(*)
	INTO	:li_cnt
	FROM	HAKSA.D_JONGHAP
	WHERE	HAKBUN	= :ls_hakbun
	AND	JUMSU		>= 60 
	USING SQLCA ;
		
	//석사 : 3과목 이상이 60점 이상이면 합격, 박사 : 5과목 이상이 60점 이상이면 합격
	if li_cnt >= 3 then
		UPDATE	HAKSA.D_HAKJUK
		SET	JONGHAP_DATE	= :ls_sysdate
		WHERE	HAKBUN			= :ls_hakbun
		USING SQLCA ;
					
		if sqlca.sqlcode <> 0 then
			messagebox("오류","종합시험 사정처리중 오류가 발생했습니다.")
			rollback USING SQLCA ;
		end if
	end if
			
	
LOOP WHILE TRUE
CLOSE CUR_SAJUNG	;

COMMIT USING SQLCA ;

Setpointer(Arrow!)
messagebox("확인","사정처리가 끝났습니다.")
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

