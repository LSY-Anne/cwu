$PBExportHeader$w_hsu106a.srw
$PBExportComments$[청운대]시간표재조정
forward
global type w_hsu106a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hsu106a
end type
type dw_con from uo_dwfree within w_hsu106a
end type
end forward

global type w_hsu106a from w_condition_window
integer width = 4507
dw_main dw_main
dw_con dw_con
end type
global w_hsu106a w_hsu106a

type variables
integer	il_row


end variables

on w_hsu106a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hsu106a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakyun, ls_hakgi, ls_ban, ls_juya, ls_gwa
int 	 li_ans

dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_gwa		=	dw_con.Object.gwa[1]
ls_ban         =  func.of_nvl( dw_con.Object.ban[1], '%')


if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1
		
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
		
elseif ls_gwa = "" or isnull(ls_gwa) then
	uf_messagebox(19)
	dw_con.SetFocus()
	dw_con.SetColumn("gwa")
	return -1
		
end if

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_main.setfocus()
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

end event

event ue_insert;long		ll_row, ll_inrow
string	ls_year, ls_hakyun, ls_hakgi, ls_gwa, ls_ban, ls_gwamok, ls_bunban, ls_hosil
integer	li_gwamok_seq, li_seq_no

dw_main.accepttext()

if il_row <= 0 then
	messagebox("확인","조회된 과목중에서 입력을 원하는 과목을 선택해 주세요.")
	return
end if

ls_year			=	dw_main.object.year[il_row]
ls_hakgi			=	dw_main.object.hakgi[il_row]
ls_gwa			=	dw_main.object.gwa[il_row]
ls_hakyun		=	dw_main.object.hakyun[il_row]
ls_ban			=	dw_main.object.ban[il_row]
ls_gwamok		=	dw_main.object.gwamok_id[il_row]
li_gwamok_seq	=	dw_main.object.gwamok_seq[il_row]
ls_bunban		=	dw_main.object.bunban[il_row]

ls_hosil			=	dw_main.object.hosil_code[il_row]

//차수 가져오기

SELECT	NVL(MAX(SEQ_NO), 0) + 1
INTO	:li_seq_no
FROM	HAKSA.SIGANPYO
WHERE	YEAR			=	:ls_year
AND	HAKGI			=	:ls_hakgi
AND	GWA			=	:ls_gwa
AND	HAKYUN		=	:ls_hakyun
AND	BAN			=	:ls_ban
AND	GWAMOK_ID	=	:ls_gwamok
AND	GWAMOK_SEQ	=	:li_gwamok_seq
AND	BUNBAN		=	:ls_bunban
USING SQLCA ;

ll_inrow		=	dw_main.insertrow(il_row + 1)

//시간표 테이블 정보 입력
dw_main.object.year[ll_inrow]			=	ls_year
dw_main.object.hakgi[ll_inrow]		=	ls_hakgi
dw_main.object.gwa[ll_inrow]			=	ls_gwa
dw_main.object.hakyun[ll_inrow]		=	ls_hakyun
dw_main.object.ban[ll_inrow]			=	ls_ban
dw_main.object.gwamok_id[ll_inrow]	=	ls_gwamok
dw_main.object.gwamok_seq[ll_inrow]	=	li_gwamok_seq
dw_main.object.bunban[ll_inrow]		=	ls_bunban
dw_main.object.seq_no[ll_inrow]		=	li_seq_no
dw_main.object.hosil_code[ll_inrow]	=	ls_hosil

//기타 정보 입력
dw_main.object.gaesul_gwamok_isu_id[ll_inrow]		=	dw_main.object.gaesul_gwamok_isu_id[il_row]
dw_main.object.gaesul_gwamok_member_no[ll_inrow]	=	dw_main.object.gaesul_gwamok_member_no[il_row]
dw_main.object.gaesul_gwamok_hakjum[ll_inrow]		=	dw_main.object.gaesul_gwamok_hakjum[il_row]
dw_main.object.gaesul_gwamok_sisu[ll_inrow]			=	dw_main.object.gaesul_gwamok_sisu[il_row]

dw_main.ScrollToRow(ll_inrow)
dw_main.setcolumn('yoil')
end event

event ue_delete;call super::ue_delete;string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban
integer	li_gwamok_seq
integer	li_ans, li_row, li_rtn

li_row = dw_main.getrow()

ls_year			=	dw_main.object.year[li_row]
ls_hakgi			=	dw_main.object.hakgi[li_row]
ls_gwa			=	dw_main.object.gwa[li_row]
ls_hakyun		=	dw_main.object.hakyun[li_row]
ls_ban			=	dw_main.object.ban[li_row]
ls_gwamok		=	dw_main.object.gwamok_id[li_row]
li_gwamok_seq	=	dw_main.object.gwamok_seq[li_row]
ls_bunban		=	dw_main.object.bunban[li_row]

if messagebox("확인","삭제하시겠습니까?", Question!, YesNo!, 2) = 2 then return

dw_main.deleterow(0)

li_ans = dw_main.update()	

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback using sqlca;
else	
	commit using sqlca;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if

//GAESUL_GWAMOK TABLE의 SIGAN COLUMN에 시간입력
li_rtn = uf_gaesul_sigan(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, li_gwamok_seq, ls_bunban)
			
if li_rtn = -1 then
	messagebox("오류","개설과목 시간 입력중 오류발생~r~n" + sqlca.sqlerrtext)
	rollback using sqlca;
	return
	
else
	commit using sqlca;
	
end if


end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu106a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu106a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu106a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu106a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu106a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu106a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu106a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu106a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu106a
end type

type uc_save from w_condition_window`uc_save within w_hsu106a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu106a
end type

type uc_print from w_condition_window`uc_print within w_hsu106a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu106a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu106a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu106a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu106a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu106a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu106a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu106a
integer taborder = 90
end type

type dw_main from uo_input_dwc within w_hsu106a
integer x = 50
integer y = 320
integer width = 4379
integer height = 1944
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_hsu100a_6"
end type

event itemchanged;call super::itemchanged;string	ls_yoil, ls_sigan, ls_room_name
string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban, ls_gwamok_name, ls_yoil_na
string	ls_hosil, ls_member_no, ls_chk
integer	li_gwamok_seq
integer	li_rtn, li_ans, li_chk

string   lll_member_no, lll_sigan, lll_gwamok, lll_bunban, lll_yoil, lll_room_name, lll_gwamok_name, lll_yoil_na
string   lll_hosil
integer  lll_gwamok_seq

this.AcceptText()

CHOOSE CASE	DWO.NAME
	CASE	'yoil',	'sigan', 'hosil_code'

		ls_yoil	=	this.object.yoil[row]
		ls_sigan	=	this.object.sigan[row]
		ls_hosil	=	this.object.hosil_code[row]
		
		if isnull(ls_hosil) or ls_hosil = '' then
			messagebox("확인","강의실 중복체크를 위해 강의실을 먼저 입력하셔야 합니다.")
			this.object.yoil[row]	=	''
			this.object.sigan[row]	=	''
			
			return 1
		end if
		
		if dwo.name = 'yoil' then
			if isnull(ls_sigan) then
				return
			end if
			
		elseif dwo.name = 'sigan' then
			if isnull(ls_yoil) then
				return
			end if
			
		end if
		
		ls_year			=	this.object.year[row]
		ls_hakgi			=	this.object.hakgi[row]
		ls_gwa			=	this.object.gwa[row]
		ls_hakyun		=	this.object.hakyun[row]
		ls_ban			=	this.object.ban[row]
		ls_gwamok		=	this.object.gwamok_id[row]
		li_gwamok_seq	=	this.object.gwamok_seq[row]
		ls_bunban		=	this.object.bunban[row]
		
		ls_member_no	=	this.object.gaesul_gwamok_member_no[row]
		
		////////////////////////////////////////////////////////////////////////////////////
		//										시간표 중복체크
		///////////////////////////////////////////////////////////////////////////////////
		//1. 선택한 과목이 이미 선택한 시간에 배정이 되었는지 확인
		SELECT	YEAR
		INTO	:ls_chk
		FROM	HAKSA.SIGANPYO
		WHERE	YEAR			=	:ls_year
		AND	HAKGI			=	:ls_hakgi
		AND	GWA			=	:ls_gwa
		AND	HAKYUN		=	:ls_hakyun
		AND	BAN			=	:ls_ban
		AND	GWAMOK_ID	=	:ls_gwamok
		AND	GWAMOK_SEQ	=	:li_gwamok_seq
		AND	BUNBAN		=	:ls_bunban
		AND	YOIL			=	:ls_yoil
		AND	SIGAN			=	:ls_sigan 
		AND	ROWNUM		=	1				;
		
		SELECT	GWAMOK_ID, BUNBAN, YOIL, SIGAN, GWAMOK_SEQ
		INTO	:lll_gwamok, :lll_bunban, :lll_yoil, :lll_sigan, :lll_gwamok_seq
		FROM	HAKSA.SIGANPYO
		WHERE	YEAR			=	:ls_year
		AND	HAKGI			=	:ls_hakgi
		AND	YOIL			=	:ls_yoil
		AND   HOSIL_code  =  :ls_hosil
		AND	SIGAN			=	:ls_sigan
		AND   ROWNUM = 1 USING SQLCA;
	
		
		if sqlca.sqlcode = 0 then
			li_chk = 1
		end if
		
		//2. 해당시간에 이미 등록한 교수가 있는 지를 확인한다.
		//		교수가 입력되어 있지 않으면 체크하지 않음.
		if isnull(ls_member_no) or ls_member_no = '' then
			
		else
			SELECT 	A.YEAR
			INTO	:ls_chk
			FROM 	HAKSA.SIGANPYO			A,
					HAKSA.GAESUL_GWAMOK	B
			WHERE	A.YEAR			=	B.YEAR
			AND	A.HAKGI			=	B.HAKGI
			AND	A.GWA				=	B.GWA
			AND	A.HAKYUN			=	B.HAKYUN
			AND	A.BAN				=	B.BAN
			AND	A.GWAMOK_ID		=	B.GWAMOK_ID
			AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
			AND	A.BUNBAN			=	B.BUNBAN
			AND	A.YEAR			=	:ls_year
			AND 	A.HAKGI 			=	:ls_hakgi
			AND	B.MEMBER_NO		=	:ls_member_no
			AND 	A.YOIL			=	:ls_yoil
			AND 	A.SIGAN			=	:ls_sigan	;
			
			SELECT 	B.MEMBER_NO
			INTO	:lll_member_no
			FROM 	HAKSA.SIGANPYO			A,
					HAKSA.GAESUL_GWAMOK	B
			WHERE	A.YEAR			=	B.YEAR
			AND	A.HAKGI			=	B.HAKGI
			AND	A.GWA				=	B.GWA
			AND	A.HAKYUN			=	B.HAKYUN
			AND	A.BAN				=	B.BAN
			AND	A.GWAMOK_ID		=	B.GWAMOK_ID
			AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
			AND	A.BUNBAN			=	B.BUNBAN
			AND	A.YEAR			=	:ls_year
			AND 	A.HAKGI 			=	:ls_hakgi
			AND	B.MEMBER_NO		=	:ls_member_no
			AND 	A.YOIL			=	:ls_yoil
			AND 	A.SIGAN			=	:ls_sigan	;
			
	
			if sqlca.sqlcode = 0 then
				li_chk = 1
				
			end if		
			
		end if
		
		//3. 강의실 중복체크
		SELECT	YEAR
		INTO	:ls_chk
		FROM	HAKSA.SIGANPYO
		WHERE	YEAR			=	:ls_year
		AND	HAKGI			=	:ls_hakgi
		AND	HOSIL_CODE	=	:ls_hosil
		AND	YOIL			=	:ls_yoil
		AND	SIGAN			=	:ls_sigan 
		AND	ROWNUM		=	1				;
		
		SELECT	HOSIL_CODE
		INTO	:lll_hosil
		FROM	HAKSA.SIGANPYO
		WHERE	YEAR			=	:ls_year
		AND	HAKGI			=	:ls_hakgi
		AND	HOSIL_CODE	=	:ls_hosil
		AND	YOIL			=	:ls_yoil
		AND	SIGAN			=	:ls_sigan 
		AND	ROWNUM		=	1				;
		
		if sqlca.sqlcode = 0 then
			li_chk = 2
			
		end if	

		SELECT  	ROOM_NAME
		INTO		:ls_room_name
		FROM 		STDB.HST242M 
		WHERE		ROOM_CODE = :ls_hosil;  

		SELECT  	ROOM_NAME
		INTO		:lll_room_name
		FROM 		STDB.HST242M 
		WHERE		ROOM_CODE = :lll_hosil;  		
 		
		SELECT  	GWAMOK_HNAME
		INTO		:ls_gwamok_name
		FROM 		HAKSA.GWAMOK_CODE  
		WHERE		GWAMOK_ID	=	:ls_gwamok
		AND		GWAMOK_SEQ	=	:li_gwamok_seq;
		
		SELECT  	GWAMOK_HNAME
		INTO		:lll_gwamok_name
		FROM 		HAKSA.GWAMOK_CODE  
		WHERE		GWAMOK_ID	=	:lll_gwamok
		AND		GWAMOK_SEQ	=	:lll_gwamok_seq;		

		CHOOSE CASE ls_yoil
			CASE 'a'
				ls_yoil_na = '월요일' 
			CASE 'b'
				ls_yoil_na = '화요일' 
			CASE 'c'
				ls_yoil_na = '수요일' 
			CASE 'd'
				ls_yoil_na = '목요일' 
			CASE 'e'
				ls_yoil_na = '금요일' 
		END CHOOSE 
	
	CHOOSE CASE lll_yoil
			CASE 'a'
				lll_yoil_na = '월요일' 
			CASE 'b'
				lll_yoil_na = '화요일' 
			CASE 'c'
				lll_yoil_na = '수요일' 
			CASE 'd'
				lll_yoil_na = '목요일' 
			CASE 'e'
				lll_yoil_na = '금요일' 
		END CHOOSE 
	
		//중복체크
		if li_chk = 1 then
//			if messagebox("확인","과목 또는 교수의 시간이 중복됩니다.~r~n계속하시겠습니까?", Question!, YesNO!, 2) = 2 then
			if messagebox("확인","<< 교강사 중복 >> 학수번호간의 교강사 중복이 발생했습니다.~r~n~r~n" +&
										"중복학수번호 : "+lll_gwamok + lll_bunban + "[ "+lll_gwamok_name+" ]~r~n"+&
										"중복교강사    : "+lll_member_no+"~r~n"         +&
										"중복요일       : "+lll_yoil_na+"~r~n"       +&
										"중복시간       : "+lll_sigan+"교시"+"~r~n"+&
										"계속하시겠습니까? ", Question!, YesNO!, 2) = 2 then
				this.object.yoil[row]	=	''
				this.object.sigan[row]	=	''
				return 1

			end if
			
		elseif li_chk = 2 then
//			if messagebox("확인","해당시간에 사용중인 강의실입니다.~r~n계속하시겠습니까?", Question!, YesNO!, 2) = 2 then
			if messagebox("확인","<< 강의실 중복 >> 학수번호간의 강의실 중복이 발생했습니다.~r~n~r~n" +&
										"중복학수번호 : "+lll_gwamok + lll_bunban + "[ "+lll_gwamok_name+" ]~r~n"+&
										"중복강의실    : "+lll_hosil+"[ "+ lll_room_name + "]"+ "~r~n"         +&
										"중복요일       : "+lll_yoil_na+"~r~n"       +&
										"중복시간       : "+lll_sigan+"교시"+"~r~n"+&
										"계속하시겠습니까? ", Question!, YesNO!, 2) = 2 then
				this.object.yoil[row]	=	''
				this.object.sigan[row]	=	''
				this.object.hosil_code[row]	=	''
				return 1
				
			end if
			
		end if
		
		
		//중복체크에서 오류가 없으면 저장함.
		this.AcceptText()
		li_ans = dw_main.update()	
		
		if li_ans = -1 then
			messagebox("오류","시간 변경중 오류발생~r~n" + sqlca.sqlerrtext)
			rollback ;
		
		else
			commit;
			
		end if
		
		//GAESUL_GWAMOK TABLE의 SIGAN COLUMN에 시간입력
		li_rtn = uf_gaesul_sigan(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, li_gwamok_seq, ls_bunban)
					
		if li_rtn = -1 then
			messagebox("오류","개설과목 시간 입력중 오류발생~r~n" + sqlca.sqlerrtext)
			rollback ;
			return
			
		else
			commit ;
			
		end if
		
END CHOOSE

end event

event itemerror;call super::itemerror;return 2
end event

event clicked;call super::clicked;//this.selectrow(0, false)
//this.selectrow(row, true)
il_row = row
end event

type dw_con from uo_dwfree within w_hsu106a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hsu105a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

