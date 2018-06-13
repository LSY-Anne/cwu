$PBExportHeader$w_dhwsu201a.srw
$PBExportComments$[대학원수업] 개설과목관리
forward
global type w_dhwsu201a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwsu201a
end type
type dw_con from uo_dwfree within w_dhwsu201a
end type
type uo_1 from uo_imgbtn within w_dhwsu201a
end type
type uo_2 from uo_imgbtn within w_dhwsu201a
end type
end forward

global type w_dhwsu201a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
end type
global w_dhwsu201a w_dhwsu201a

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

//dw_main.Object.gyeyul_id.Protect    = li_chk1
dw_main.Object.gwa_id.Protect       = li_chk2
dw_main.Object.jungong_id.Protect  = li_chk3
end subroutine

on w_dhwsu201a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.uo_2
end on

on w_dhwsu201a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_jungong, ls_gyeyul_id
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwajung  =	func.of_nvl(dw_con.Object.gwajung[1], '%') + '%'
ls_gyeyul_id =  func.of_nvl(dw_con.Object.gyeyul_id[1], '%') + '%'
ls_hakgwa   =	func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_jungong   =	func.of_nvl(dw_con.Object.jungong[1], '%') + '%'

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
long ll_line, ll_getrow

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_getrow	=	dw_main.getrow()
ll_line		= dw_main.insertrow(ll_getrow + 1)
dw_main.scrolltorow(ll_line)

if ll_line > 1 then
	
	dw_main.object.year[ll_line]			=	dw_main.object.year[ll_line - 1]
	dw_main.object.hakgi[ll_line]			=	dw_main.object.hakgi[ll_line - 1]
	dw_main.object.gwajung_id[ll_line]	=	dw_main.object.gwajung_id[ll_line - 1]
	dw_main.object.gwa_id[ll_line]		=	dw_main.object.gwa_id[ll_line - 1]
	dw_main.object.jungong_id[ll_line]	=	dw_main.object.jungong_id[ll_line - 1]
	dw_main.object.isu_id[ll_line]		=	dw_main.object.isu_id[ll_line - 1]
	dw_main.object.hakjum[ll_line]			=	3
	dw_main.object.sisu[ll_line]				=	3
	dw_main.object.gaesul_gubun[ll_line]	=	'01'
	
	dw_main.SetColumn('gwamok_id')
	dw_main.setfocus()
else

	dw_main.object.year[ll_line]				=	ls_year
	dw_main.object.hakgi[ll_line]				=	ls_hakgi	
	dw_main.object.hakjum[ll_line]			=	3
	dw_main.object.sisu[ll_line]				=	3
	dw_main.object.gaesul_gubun[ll_line]	=	'01'
	
	dw_main.SetColumn('gwajung_id')
	dw_main.setfocus()
end if	


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

type ln_templeft from w_condition_window`ln_templeft within w_dhwsu201a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwsu201a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwsu201a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwsu201a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwsu201a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwsu201a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwsu201a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwsu201a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwsu201a
end type

type uc_save from w_condition_window`uc_save within w_dhwsu201a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwsu201a
end type

type uc_print from w_condition_window`uc_print within w_dhwsu201a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwsu201a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwsu201a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwsu201a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwsu201a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwsu201a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwsu201a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwsu201a
end type

type dw_main from uo_input_dwc within w_dhwsu201a
integer x = 55
integer y = 296
integer width = 4375
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwsu201a"
boolean hsplitscroll = true
end type

event itemchanged;call super::itemchanged;int li_ans, li_msg, ll_cnt, ll_rtn
string ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_gwamok, ls_prof_before
String ls_gwamok_id, ls_isu_id, ls_from, ls_to, ls_old_year, ls_old_hakgi

//개설구분을 변경함에 따라 폐강처리를 한다.
if dwo.name = 'gaesul_gubun' then
	
	ls_year		=	this.object.year[row]
	ls_hakgi		=	this.object.hakgi[row]
	ls_gwajung	=	this.object.gwajung_id[row]
	ls_hakgwa	=	this.object.gwa_id[row]
	ls_gwamok	=	this.object.gwamok_id[row]
	
	this.AcceptText()
	
	//폐강처리 되면
	if data = '11' then
		
		if messagebox("확인","폐강처리 하시겠습니까?~r~n" + &
									"본과목을 수강한 학생의 내역이 폐강처리됩니다.", Question!, YesNo!, 2) = 2 then
			this.object.gaesul_gubun[row] = '01'
			return 1
		end if
		
		li_ans = this.Update()
		
		if li_ans = -1 then
			//저장 오류 메세지 출력
			uf_messagebox(3)
			rollback;
			return
			
		else
			UPDATE HAKSA.D_SUGANG_TRANS
			SET	SUNGJUK_INJUNG = '0'
			WHERE	YEAR			=	:ls_year
			AND	HAKGI			=	:ls_hakgi
			AND	GWAJUNG_ID	=	:ls_gwajung
			AND	GWA_ID		=	:ls_hakgwa
			AND	GWAMOK_ID	=	:ls_gwamok	;
			
			if sqlca.sqlcode = 0 then
				commit ;
			else
				messagebox("오류","수강신청내역 변경중 오류발생~r~n" + sqlca.sqlerrtext )
				rollback ;
				return
			end if
		end if
		
	elseif data = '01'  then
		
		if messagebox("확인","폐강된 과목을 재개설하시겠습니까?~r~n" + &
									"수강신청내역에서 폐강된 학생들이 수강인정으로 변경됩니다.", Question!, YesNo!, 2) = 2 then
			this.object.gaesul_gubun[row] = '11'
			return 1
		end if
		
		li_ans = this.Update()
		
		if li_ans = -1 then
			//저장 오류 메세지 출력
			uf_messagebox(3)
			rollback;
			return
			
		else
			UPDATE HAKSA.D_SUGANG_TRANS
			SET	SUNGJUK_INJUNG = '1'
			WHERE	YEAR			=	:ls_year
			AND	HAKGI			=	:ls_hakgi
			AND	GWAJUNG_ID	=	:ls_gwajung
			AND	GWA_ID		=	:ls_hakgwa
			AND	GWAMOK_ID	=	:ls_gwamok	;
			
			if sqlca.sqlcode = 0 then
				commit ;
			else
				messagebox("오류","수강신청내역 변경중 오류발생~r~n" + sqlca.sqlerrtext )
				rollback ;
				return
			end if
		end if		
		
	end if
	
elseif dwo.name = 'member_no' then
	
	ls_prof_before	=	this.object.member_no[row]
	
	this.AcceptText()
	
	ls_year		=	this.object.year[row]
	ls_hakgi		=	this.object.hakgi[row]
	ls_gwajung	=	this.object.gwajung_id[row]
	ls_hakgwa	=	this.object.gwa_id[row]
	ls_gwamok	=	this.object.gwamok_id[row]
	
	UPDATE	HAKSA.D_SUGANG_TRANS
	SET	MEMBER_NO	=	:data
	WHERE	YEAR			=	:ls_year
	AND	HAKGI			=	:ls_hakgi
	AND	GWAJUNG_ID	=	:ls_gwajung
	AND	GWA_ID		=	:ls_hakgwa
	AND	GWAMOK_ID	=	:ls_gwamok
	AND	MEMBER_NO	=	:ls_prof_before	;
	
	if sqlca.sqlcode = 0 then
		
			li_ans = dw_main.update()
								
			if li_ans = -1 then
				//저장 오류 메세지 출력
				uf_messagebox(3)
				rollback;
				return
			else	
				commit;
		
			end if
		
	elseif sqlca.sqlcode = -1 then
		messagebox("오류","교수변경중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
		rollback ;
		
	end if
	
ElseIF dwo.name = "gwamok_id" Then
	
	ls_year		=	This.object.year[row]
	ls_hakgi		=	This.object.hakgi[row]
	ls_gwajung	=	This.object.gwajung_id[row]
	ls_hakgwa	=	This.object.gwa_id[row]
	
	ls_isu_id = This.Object.isu_id[row]
	
	If ls_isu_id = '3' Or ls_isu_id = '4' Then
		If ls_hakgi = '1' Then
			ls_from  = String(Long(ls_year) - 1) + '1'
			ls_to      = String(Long(ls_year) - 1) + '2'
		ElseIf ls_hakgi = '2' Then
			ls_from  = String(Long(ls_year) - 1) + '2'
			ls_to      = ls_year + '1'
		End If
		
         SELECT MAX(YEAR), MAX(HAKGI), COUNT(*)
		  INTO :ls_old_year, :ls_old_hakgi, :ll_cnt
   		  FROM HAKSA.D_GAESUL_GWAMOK
	     WHERE YEAR || HAKGI BETWEEN :ls_from AND :ls_to
		    AND GWAJUNG_ID = :ls_gwajung
		    AND GWA_ID        = :ls_hakgwa
			AND GWAMOK_ID = :data
		    AND ROWNUM = 1
		USING SQLCA ;
		
		If ll_cnt > 0 Then
			ll_rtn = Messagebox('확인', ls_old_year + '년 ' + ls_old_hakgi + '학기에 개설된 과목입니다. 개설하시겠습니까?', StopSign!, YesNo! )
			
			If ll_rtn = 2 Then
				This.Post SetItem( row, "gwamok_id", '' )
			End If
			
		End If
	End If
	
ElseIf dwo.name = "isu_id" Then
	
	ls_year		=	This.object.year[row]
	ls_hakgi		=	This.object.hakgi[row]
	ls_gwajung	=	This.object.gwajung_id[row]
	ls_hakgwa	=	This.object.gwa_id[row]
	
	If data = '3' Or data = '4' Then
		ls_gwamok_id =  This.Object.gwamok_id[row]
		
		If ls_hakgi = '1' Then
			ls_from  = String(Long(ls_year) - 1) + '1'
			ls_to      = String(Long(ls_year) - 1) + '2'
		ElseIf ls_hakgi = '2' Then
			ls_from  = String(Long(ls_year) - 1) + '2'
			ls_to      = ls_year + '1'
		End If
		
         SELECT MAX(YEAR), MAX(HAKGI), COUNT(*)
		  INTO :ls_old_year, :ls_old_hakgi, :ll_cnt
   		  FROM HAKSA.D_GAESUL_GWAMOK
	     WHERE YEAR || HAKGI BETWEEN :ls_from AND :ls_to
		    AND GWAJUNG_ID = :ls_gwajung
		    AND GWA_ID        = :ls_hakgwa
			AND GWAMOK_ID = :ls_gwamok_id
		    AND ROWNUM = 1
		USING SQLCA ;
		
		If ll_cnt > 0 Then
			ll_rtn = Messagebox('확인', ls_old_year + '년 ' + ls_old_hakgi + '학기에 개설된 과목입니다. 개설하시겠습니까?', StopSign!, YesNo! )
			
			If ll_rtn = 2 Then
				This.Post SetItem( row, "gwamok_id", '' )
			End If
			
		End If
	End If
		
		
end if


end event

event itemerror;call super::itemerror;return 2
end event

type dw_con from uo_dwfree within w_dhwsu201a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_dhwdr202a_c1"
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

type uo_1 from uo_imgbtn within w_dhwsu201a
integer x = 640
integer y = 40
integer width = 343
integer taborder = 70
boolean bringtotop = true
string btnname = "공필입력"
end type

event clicked;call super::clicked;open(w_dhwsu201pp)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_dhwsu201a
integer x = 1033
integer y = 40
integer width = 343
integer taborder = 70
boolean bringtotop = true
string btnname = "공필생성"
end type

event clicked;call super::clicked;string ls_chk, ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_gwamok, ls_isu, ls_prof
int	li_hakjum, li_sisu, ll_chk

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

SELECT A.GWAMOK_ID
INTO 	:ls_chk
FROM	HAKSA.D_GAESUL_GWAMOK	A,
		HAKSA.D_GAESUL_PILSU		B
WHERE	A.GWAJUNG_ID	=	B.GWAJUNG_ID
AND	A.GWA_ID			=	B.GWA_ID
AND	A.GWAMOK_ID		=	B.GWAMOK_ID
AND	A.YEAR			=	:ls_year
AND	A.HAKGI			=	:ls_hakgi
AND	ROWNUM	=	1
USING SQLCA ;

if sqlca.sqlcode = 0 then
	messagebox("확인","기존 자료가 존재합니다.")
	return	
end if

//지도교수가 선정되어야만 공통필수 과목을 입력할 수 있다.
SELECT COUNT(*)
INTO	:ll_chk
FROM HAKSA.D_NONMUN
WHERE	MB_YEAR		=	:ls_year
AND	MB_HAKGI		=	:ls_hakgi
AND	MEMBER_NO	IS NOT NULL
USING SQLCA ;

//IF ll_chk = 0 then
//	messagebox("확인","지도교수가 신청되지 않았습니다.")
//	return
//end if

SetPointer(HourGlass!)

DECLARE CUR_GAESUL CURSOR FOR
SELECT	DISTINCT B.GWAJUNG_ID,
						B.GWA_ID,
						C.GWAMOK_ID,
						C.ISU_ID,
						C.HAKJUM,
						C.SISU,
						A.MEMBER_NO
FROM	HAKSA.D_NONMUN	A,
		HAKSA.D_HAKJUK	B,
		HAKSA.D_GAESUL_PILSU	C
WHERE	A.HAKBUN			=	B.HAKBUN
AND	B.GWAJUNG_ID	=	C.GWAJUNG_ID
AND	B.GWA_ID			=	C.GWA_ID
AND	B.SANGTAE_ID	= '01'
USING SQLCA ;

OPEN CUR_GAESUL	;
DO
	FETCH	CUR_GAESUL	INTO	:ls_gwajung, :ls_hakgwa, :ls_gwamok, :ls_isu, :li_hakjum, :li_sisu, :ls_prof	;
	
	IF SQLCA.SQLCODE <>  0 THEN EXIT
	
	INSERT INTO HAKSA.D_GAESUL_GWAMOK
				(	YEAR,			HAKGI,		GWAJUNG_ID,		GWA_ID,		GWAMOK_ID,	
					ISU_ID,		HAKJUM,		SISU,				MEMBER_NO					)
	VALUES	(	:ls_year,	:ls_hakgi,	:ls_gwajung,	:ls_hakgwa,	:ls_gwamok,
					:ls_isu,		:li_hakjum,	:li_sisu,		:ls_prof						)	USING SQLCA ;
					
	if sqlca.sqlcode <> 0 then
		messagebox("오류","개설과목 생성중 오류발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	end if
			
LOOP WHILE TRUE
CLOSE CUR_GAESUL	;

COMMIT USING SQLCA ;
SetPointer(Arrow!)
messagebox("확인","작업이 완료되었습니다.")
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

