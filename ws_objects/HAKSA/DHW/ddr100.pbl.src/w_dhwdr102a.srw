$PBExportHeader$w_dhwdr102a.srw
$PBExportComments$[대학원장학] 장학생관리
forward
global type w_dhwdr102a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwdr102a
end type
type dw_con from uo_dwfree within w_dhwdr102a
end type
type uo_1 from uo_imgbtn within w_dhwdr102a
end type
end forward

global type w_dhwdr102a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_dhwdr102a w_dhwdr102a

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
end subroutine

on w_dhwdr102a.create
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

on w_dhwdr102a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_jungong, ls_gyeyul_id
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gyeyul_id =  dw_con.Object.gyeyul_id[1]
ls_gwajung  =	func.of_nvl(dw_con.Object.gwajung[1], '%')
ls_hakgwa   =	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_jungong   =	func.of_nvl(dw_con.Object.jungong[1], '%')

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwajung, ls_gyeyul_id, ls_hakgwa, ls_jungong)

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

dw_main.object.d_janghak_year[ll_line]		=	ls_year
dw_main.object.d_janghak_hakgi[ll_line]	=	ls_hakgi
	
dw_main.SetColumn('d_janghak_hakbun')
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

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwdr102a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwdr102a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwdr102a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwdr102a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwdr102a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwdr102a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwdr102a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwdr102a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwdr102a
end type

type uc_save from w_condition_window`uc_save within w_dhwdr102a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwdr102a
end type

type uc_print from w_condition_window`uc_print within w_dhwdr102a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwdr102a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwdr102a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwdr102a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwdr102a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwdr102a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwdr102a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwdr102a
end type

type dw_main from uo_input_dwc within w_dhwdr102a
integer x = 55
integer y = 300
integer width = 4375
integer height = 1964
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwdr102a"
end type

event itemchanged;call super::itemchanged;string ls_gwajung, ls_jungong, ls_hakgwa, ls_hname
string ls_gwamok, ls_gyeyul_id
int i, li_null

setnull(li_null)

this.AcceptText()

CHOOSE CASE	DWO.NAME
	//학번이 입력되면 기본사항을 가져온다.
	CASE	'd_janghak_hakbun'
		
		SELECT	GWAJUNG_ID,
		              GYEYUL_ID,
					GWA_ID,
					JUNGONG_ID,
					HNAME
		INTO	:ls_gwajung,
		         :ls_gyeyul_id,
				:ls_hakgwa,
				:ls_jungong,
				:ls_hname
		FROM	HAKSA.D_HAKJUK
		WHERE	HAKBUN	=	:data	;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","잘못된 학번입니다.")
			this.object.d_janghak_hakbun[row]	=	''
			return 1
			
		else
			this.object.d_hakjuk_hname[row]			=	ls_hname
			this.object.d_hakjuk_gyeyul_id[row]		=	ls_gyeyul_id
			this.object.d_hakjuk_gwajung_id[row]	=	ls_gwajung
			this.object.d_hakjuk_gwa_id[row]			=	ls_hakgwa
			this.object.d_hakjuk_jungong_id[row]	=	ls_jungong
			
		end if
		
			
END CHOOSE
		
end event

event itemerror;call super::itemerror;return 2
end event

type dw_con from uo_dwfree within w_dhwdr102a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_dhwdr102a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gwa'
		DataWindowChild ldwc_hjmod

		This.getchild('jungong', ldwc_hjmod)
		ldwc_hjmod.SetTransObject(sqlca)	
		ldwc_hjmod.Retrieve(data)
		
End Choose
end event

type uo_1 from uo_imgbtn within w_dhwdr102a
integer x = 631
integer y = 40
integer width = 453
integer taborder = 70
boolean bringtotop = true
string btnname = "기초자료생성"
end type

event clicked;call super::clicked;string 		ls_year, ls_hakgi, ls_chk
integer  	li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

SELECT	HAKBUN
INTO	:ls_chk
FROM	HAKSA.D_JANGHAK
WHERE	YEAR		=	:ls_year
AND	HAKGI		=	:ls_hakgi
AND	ROWNUM	=	1
USING SQLCA ;

if sqlca.sqlcode = 0 then
	if messagebox("확인","자료가 존재합니다~r~n삭제후 재생성 하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	
	DELETE FROM HAKSA.D_JANGHAK
	WHERE	YEAR	=	:ls_year
	AND	HAKGI	=	:ls_hakgi	
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","기존자료 삭제중 오류발생~r~n" + sqlca.sqlerrtext)
		return
	end if
end if

	
li_ans = messagebox(	"확인","기초자료 생성하시겠습니까?", Exclamation!, OKCancel!, 1)

IF li_ans = 2 THEN
	return
END IF
		

INSERT INTO	HAKSA.D_JANGHAK
(	SELECT	A.HAKBUN,
				:ls_year,
				:ls_hakgi,
				A.JANGHAK_ID,
				:gs_empcode,
				:gs_ip,
				sysdate,
				null,
				null,
				null
	FROM	HAKSA.D_HAKJUK	A
	WHERE	JANGHAK_ID	IS NOT NULL	
	AND	SANGTAE_ID	IN	('01')) USING SQLCA ;
	
if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	messagebox("확인","작업이 완료되었습니다.")
	parent.Triggerevent('ue_retrieve')
	
else
	messagebox("오류","작업중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	
end if
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

