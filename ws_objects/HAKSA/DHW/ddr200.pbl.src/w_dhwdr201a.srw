$PBExportHeader$w_dhwdr201a.srw
$PBExportComments$[대학원등록] 등록금모델관리
forward
global type w_dhwdr201a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwdr201a
end type
type dw_con from uo_dwfree within w_dhwdr201a
end type
type uo_1 from uo_imgbtn within w_dhwdr201a
end type
end forward

global type w_dhwdr201a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_dhwdr201a w_dhwdr201a

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
 
//dw_con.Object.gyeyul_id.Protect = li_chk1
//dw_con.Object.gwa.Protect        = li_chk2
//dw_con.Object.jungong.Protect   = li_chk3

dw_main.Object.gyeyul_id.Protect    = li_chk1
dw_main.Object.gwa_id.Protect       = li_chk2
dw_main.Object.jungong_id.Protect  = li_chk3
end subroutine

on w_dhwdr201a.create
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

on w_dhwdr201a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
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

dw_main.object.year[ll_line]			=	ls_year
dw_main.object.hakgi[ll_line]			=	ls_hakgi
dw_main.object.gwajung_id[ll_line]	=	'1'

dw_main.object.job_uid[ll_line]	=	gs_empcode
dw_main.object.job_add[ll_line]	=	gs_ip

dw_main.SetColumn('gwajung_id')
dw_main.setfocus()
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

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwdr201a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwdr201a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwdr201a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwdr201a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwdr201a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwdr201a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwdr201a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwdr201a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwdr201a
end type

type uc_save from w_condition_window`uc_save within w_dhwdr201a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwdr201a
end type

type uc_print from w_condition_window`uc_print within w_dhwdr201a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwdr201a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwdr201a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwdr201a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwdr201a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwdr201a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwdr201a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwdr201a
end type

type dw_main from uo_input_dwc within w_dhwdr201a
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwdr201a"
end type

type dw_con from uo_dwfree within w_dhwdr201a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_dhwdr201a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_dhwdr201a
integer x = 466
integer y = 40
integer width = 457
integer taborder = 40
boolean bringtotop = true
string btnname = "기초자료생성"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_be_year, ls_be_hakgi

long		ll_cnt

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

if ls_hakgi = '1' then
	ls_be_year	=	string(long(ls_year) - 1)
	ls_be_hakgi	=	'2'
	
else
	ls_be_year	=	ls_year
	ls_be_hakgi	=	'1'
end if


//등록생성년도 학기에 해당자료유무검색
SELECT	COUNT(*)
INTO		:ll_cnt
FROM		HAKSA.D_DUNGROK_MODEL
WHERE		YEAR	=	:ls_year
AND		HAKGI	=	:ls_hakgi	
USING SQLCA ;

if ll_cnt > 0 then	
	if messagebox("확인",ls_year + "년도" + ls_hakgi +"  학기 자료가 존재합니다.~r~n" +&
								"삭제후 재생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	
	DELETE FROM HAKSA.D_DUNGROK_MODEL
	WHERE	YEAR	=	:ls_year
	AND	HAKGI	=	:ls_hakgi	
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		
		messagebox("오류","삭제중 오류가 발생되었습니다.~r~n" +  sqlca.sqlerrtext)
		rollback  USING SQLCA ;
		
	end if
end if	

INSERT INTO	HAKSA.D_DUNGROK_MODEL
(	SELECT	:ls_year,
				:ls_hakgi,
				GWAJUNG_ID,
				GWA_ID,
				JUNGONG_ID,
				IPHAK,
				DUNGROK,
				HAKGI_DUNGROK,
				WONWOO,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL
	FROM	HAKSA.D_DUNGROK_MODEL
	WHERE	YEAR	=	:ls_be_year
	AND	HAKGI	=	:ls_be_hakgi
)	USING SQLCA ;
	
IF SQLCA.SQLCODE = 0 THEN
	COMMIT USING SQLCA ;
	MESSAGEBOX("확인","자료가 생성되었습니다.")
	dw_main.retrieve(ls_year, ls_hakgi)
ELSE
	MESSAGEBOX("오류","자료생성중 오류가 발생되었습니다~R~N" + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA ;
END IF
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

