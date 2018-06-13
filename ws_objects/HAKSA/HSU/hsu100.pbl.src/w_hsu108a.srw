$PBExportHeader$w_hsu108a.srw
$PBExportComments$[청운대]계절학기 시간입력
forward
global type w_hsu108a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hsu108a
end type
type dw_search from uo_input_dwc within w_hsu108a
end type
type st_5 from statictext within w_hsu108a
end type
type st_7 from statictext within w_hsu108a
end type
type em_3 from editmask within w_hsu108a
end type
type em_4 from editmask within w_hsu108a
end type
type st_8 from statictext within w_hsu108a
end type
type st_9 from statictext within w_hsu108a
end type
type cb_1 from commandbutton within w_hsu108a
end type
type dw_con from uo_dwfree within w_hsu108a
end type
type dw_con1 from uo_dwfree within w_hsu108a
end type
end forward

global type w_hsu108a from w_condition_window
integer width = 4507
dw_main dw_main
dw_search dw_search
st_5 st_5
st_7 st_7
em_3 em_3
em_4 em_4
st_8 st_8
st_9 st_9
cb_1 cb_1
dw_con dw_con
dw_con1 dw_con1
end type
global w_hsu108a w_hsu108a

type variables
integer	il_row


end variables

on w_hsu108a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_search=create dw_search
this.st_5=create st_5
this.st_7=create st_7
this.em_3=create em_3
this.em_4=create em_4
this.st_8=create st_8
this.st_9=create st_9
this.cb_1=create cb_1
this.dw_con=create dw_con
this.dw_con1=create dw_con1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_search
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.em_3
this.Control[iCurrent+6]=this.em_4
this.Control[iCurrent+7]=this.st_8
this.Control[iCurrent+8]=this.st_9
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_con
this.Control[iCurrent+11]=this.dw_con1
end on

on w_hsu108a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_search)
destroy(this.st_5)
destroy(this.st_7)
destroy(this.em_3)
destroy(this.em_4)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.cb_1)
destroy(this.dw_con)
destroy(this.dw_con1)
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

end if

li_ans = dw_search.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)

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
idw_update[2] = dw_search

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con1.SetTransObject(sqlca)
dw_con1.InsertRow(0)

dw_con1.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con1.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

em_3.text = '1'
em_4.text = '4'

end event

event ue_insert;call super::ue_insert;long		ll_row, ll_inrow
string	ls_year, ls_hakyun, ls_hakgi, ls_gwa, ls_ban, ls_gwamok, ls_bunban, ls_hosil
integer	li_gwamok_seq, li_seq_no

dw_main.accepttext()

if il_row <= 0 then
	messagebox("확인","조회된 과목중에서 입력을 원하는 과목을 선택해 주세요.")
	return
end if

ls_year		=	dw_main.object.year[il_row]
ls_hakgi		=	dw_main.object.hakgi[il_row]
ls_gwa		=	dw_main.object.gwa[il_row]
ls_hakyun	=	dw_main.object.hakyun[il_row]
ls_ban		=	dw_main.object.ban[il_row]
ls_gwamok	=	dw_main.object.gwamok_id[il_row]
li_gwamok_seq	=	dw_main.object.gwamok_seq[il_row]
ls_bunban	=	dw_main.object.bunban[il_row]

ls_hosil		=	dw_main.object.hosil_code[il_row]

//차수 가져오기

SELECT	MAX(SEQ_NO) + 1
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
dw_main.object.year[ll_inrow]			=  ls_year
dw_main.object.hakgi[ll_inrow]		=  ls_hakgi
dw_main.object.gwa[ll_inrow]			=  ls_gwa
dw_main.object.hakyun[ll_inrow]		=  ls_hakyun
dw_main.object.ban[ll_inrow]			=  ls_ban
dw_main.object.gwamok_id[ll_inrow]	=  ls_gwamok
dw_main.object.gwamok_seq[ll_inrow]	=  li_gwamok_seq
dw_main.object.bunban[ll_inrow]		=  ls_bunban
dw_main.object.seq_no[ll_inrow]		=  li_seq_no
dw_main.object.hosil_code[ll_inrow]	=	ls_hosil

//기타 정보 입력
dw_main.object.gaesul_gwamok_isu_id[ll_inrow]		=	dw_main.object.gaesul_gwamok_isu_id[il_row]
dw_main.object.gaesul_gwamok_member_no[ll_inrow]	=	dw_main.object.gaesul_gwamok_member_no[il_row]
dw_main.object.gaesul_gwamok_hakjum[ll_inrow]		=	dw_main.object.gaesul_gwamok_hakjum[il_row]
dw_main.object.gaesul_gwamok_sisu[ll_inrow]			=	dw_main.object.gaesul_gwamok_sisu[il_row]

dw_main.ScrollToRow(ll_inrow)
dw_main.setcolumn('yoil')
end event

event ue_delete;call super::ue_delete;long	li_ans

if messagebox("확인","자료를 삭제하시겠습니까?", Question!, YesNo!, 2) = 2 then return

dw_main.deleterow(0);

li_ans = dw_main.update()	

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback using sqlca ;
else	
	commit using sqlca ;

end if
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu108a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu108a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu108a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu108a
integer beginy = 2256
integer endy = 2256
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu108a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu108a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu108a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu108a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu108a
end type

type uc_save from w_condition_window`uc_save within w_hsu108a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu108a
end type

type uc_print from w_condition_window`uc_print within w_hsu108a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu108a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu108a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu108a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu108a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu108a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu108a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu108a
integer taborder = 90
end type

type dw_main from uo_input_dwc within w_hsu108a
integer x = 3218
integer y = 384
integer width = 1211
integer height = 1880
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_hsu100a_8"
boolean border = true
end type

event itemchanged;call super::itemchanged;string	ls_yoil, ls_sigan
string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban
string	ls_hosil, ls_member_no, ls_chk
integer	li_gwamok_seq
integer	li_rtn, li_ans

this.AcceptText()

CHOOSE CASE	DWO.NAME
	CASE	'yoil',	'sigan'

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
		AND	ROWNUM		=	1
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			messagebox("확인","해당과목이 이미 같은시간에 존재합니다.")
			
			this.object.yoil[row]	=	''
			this.object.sigan[row]	=	''
			
			return 1
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
			AND 	A.SIGAN			=	:ls_sigan	
			USING SQLCA ;
	
			if sqlca.sqlcode = 0 then
				messagebox("시간표입력 error","해당시간에 이미 등록된 교수입니다!")
				
				this.object.yoil[row]	=	''
				this.object.sigan[row]	=	''
				
				return 1
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
		AND	ROWNUM		=	1
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			messagebox("확인","타과목과 강의실이 중복됩니다.")
			
			this.object.yoil[row]	=	''
			this.object.sigan[row]	=	''
			
			return 1
		end if			
		
		//중복체크에서 오류가 없으면 저장함.
		li_ans = dw_main.update()	
		
		if li_ans = -1 then
			messagebox("오류","시간 변경중 오류발생~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
		
		else	
			commit USING SQLCA ;
		end if			
		
		
		//GAESUL_GWAMOK TABLE의 SIGAN COLUMN에 시간입력
		li_rtn = uf_gaesul_sigan(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, li_gwamok_seq, ls_bunban)
					
		if li_rtn = -1 then
			messagebox("오류","개설과목 시간 입력중 오류발생~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
			return
			
		else
			commit USING SQLCA ;
		end if
		
END CHOOSE
end event

event itemerror;call super::itemerror;return 2
end event

event clicked;call super::clicked;//this.selectrow(0, false)
//this.selectrow(row, true)
il_row = row
end event

type dw_search from uo_input_dwc within w_hsu108a
integer x = 55
integer y = 384
integer width = 3150
integer height = 1568
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu100a_8_search"
boolean border = true
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban
integer	li_gwamok_seq

if row <= 0 then return

ls_year			=	this.object.year[row]
ls_hakgi			=	this.object.hakgi[row]
ls_gwa			=	this.object.gwa[row]
ls_hakyun		=	this.object.hakyun[row]
ls_ban			=	this.object.ban[row]
ls_gwamok		=	this.object.gwamok_id[row]
li_gwamok_seq	=	this.object.gwamok_seq[row]
ls_bunban		=	this.object.bunban[row]

dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, li_gwamok_seq, ls_bunban)
end event

type st_5 from statictext within w_hsu108a
integer x = 55
integer y = 308
integer width = 3150
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = " 개설과목"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_7 from statictext within w_hsu108a
integer x = 3218
integer y = 308
integer width = 1211
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = " 시간표"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_3 from editmask within w_hsu108a
integer x = 1134
integer y = 2152
integer width = 201
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
double increment = 1
string minmax = "1~~14"
end type

type em_4 from editmask within w_hsu108a
integer x = 1399
integer y = 2152
integer width = 201
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
double increment = 1
string minmax = "1~~14"
end type

type st_8 from statictext within w_hsu108a
integer x = 1335
integer y = 2172
integer width = 64
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 16777215
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_9 from statictext within w_hsu108a
integer x = 841
integer y = 2168
integer width = 283
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
string text = "수업시간"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_hsu108a
integer x = 1646
integer y = 2156
integer width = 448
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "시간생성"
end type

event clicked;date		ldt_start, ldt_end, ldt_ilja
string	ls_sigan_s, ls_sigan_e
integer	li_cnt, li_row, li_gigan, i, li_loop, j

//입력용 자료
string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban, ls_hosil, ls_ilja, ls_sigan, ls_gaesul_sigan
integer	li_gwamok_seq


li_row	=	dw_search.getrow()

if li_row <= 0 then 
	messagebox("확인","시간표를 생성할 과목을 선택하세요")
	return
end if

//선택된 row의 자료를 가져온다.
ls_year			=	dw_search.object.year[li_row]
ls_hakgi			=	dw_search.object.hakgi[li_row]
ls_gwa			=	dw_search.object.gwa[li_row]
ls_hakyun		=	dw_search.object.hakyun[li_row]
ls_ban			=	dw_search.object.ban[li_row]
ls_gwamok		=	dw_search.object.gwamok_id[li_row]
li_gwamok_seq	=	dw_search.object.gwamok_seq[li_row]
ls_bunban		=	dw_search.object.bunban[li_row]
ls_hosil			=	dw_search.object.hosil_code[li_row]

SELECT COUNT(*)
INTO	:li_cnt
FROM	HAKSA.SIGANPYO_SEASON
WHERE	YEAR			=	:ls_year	
AND	HAKGI			=	:ls_hakgi
AND	GWA			=	:ls_gwa
AND	HAKYUN		=	:ls_hakyun
AND	BAN			=	:ls_ban
AND	GWAMOK_ID	=	:ls_gwamok
AND	GWAMOK_SEQ	=	:li_gwamok_seq
AND	BUNBAN		=	:ls_bunban
USING SQLCA;

if li_cnt > 0 then
	if	messagebox("확인","해당 과목의 시간표가 이미 생성되어 있습니다.~r~n" + &
									"삭제후 다시 생성하시겠습니까?", Question!, YesNo!, 2)	=	2 then return
	
	DELETE FROM HAKSA.SIGANPYO_SEASON
	WHERE	YEAR			=	:ls_year	
	AND	HAKGI			=	:ls_hakgi
	AND	GWA			=	:ls_gwa
	AND	HAKYUN		=	:ls_hakyun
	AND	BAN			=	:ls_ban
	AND	GWAMOK_ID	=	:ls_gwamok
	AND	GWAMOK_SEQ	=	:li_gwamok_seq
	AND	BUNBAN		=	:ls_bunban		;
	
	IF SQLCA.SQLCODE <> 0 THEN
		messagebox("오류","기존자료 삭제중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
		rollback ;
		return
	END IF

end if
	

//입력할 수업기간
ldt_start	=	date(dw_con1.Object.from_dt[1])
ldt_end	=	date(dw_con1.Object.to_dt[1])

//수업 교시
ls_sigan_s	=	em_3.text
ls_sigan_e	=	em_4.text

//날짜 사이의 기간, 수업시간 사이의 기간을 구한다.(LOOP회수 이므로 +1을 해준다.)
li_gigan	=	DaysAfter( ldt_start, ldt_end ) + 1
li_loop	=	integer(ls_sigan_e) -  integer(ls_sigan_s) + 1

ldt_ilja	=	ldt_start

//첫번째 Loop : 개설기간
//두번째 Loop : 하루에 발생하는 수업시수
FOR i = 1 TO li_gigan
		
	ls_ilja	=	string(ldt_ilja, 'YYYYMMDD')
	
	//일요일은 생성하지 않고 넘어감.
	if DayNumber(ldt_ilja)	= 1 then 
		ldt_ilja	=	RelativeDate(ldt_ilja, 1 )
		continue
	end if
	
	ls_sigan_s	=	em_3.text	//초기화(4교시 부터 시작이면 각 날짜마다 시간이 4로 시작해서 입력이 되어야 하니까)
	
	FOR	j = 1 TO li_loop
		
		ls_sigan	=	ls_sigan_s
		
		INSERT INTO HAKSA.SIGANPYO_SEASON
					(	YEAR,			HAKGI,		GWA,			HAKYUN,		BAN,		GWAMOK_ID,	GWAMOK_SEQ,
						BUNBAN,		ILJA,			SIGAN,		HOSIL_CODE,
						WORKER,		IPADDR,		WORK_DATE							)
		VALUES	(	:ls_year,	:ls_hakgi,	:ls_gwa,		:ls_hakyun,	:ls_ban,	:ls_gwamok,	:li_gwamok_seq,
						:ls_bunban,	:ls_ilja,	:ls_sigan,	:ls_hosil,
						:gs_empcode,	:gs_ip,	sysdate										) USING SQLCA	;
		
		if sqlca.sqlcode	<>	0 then
			messagebox("오류","계절학기 시간표 개설중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA	;
			return
		end if
		
		ls_sigan_s	=	string( integer(ls_sigan) + 1)
		
	NEXT
	
	//다음날을 구함.
	ldt_ilja	=	RelativeDate(ldt_ilja, 1 )

NEXT

//개설과목의 Sigan Column Updte

ls_gaesul_sigan	=	string(Month(ldt_start)) + '월' + string(Day(ldt_start)) + '일' + '-' + &
							string(Month(ldt_end)) + '월' + string(Day(ldt_end)) + '일' + '/' + &
							string(integer(em_3.text)) + '-' + string(integer(em_4.text)) + '교시'

UPDATE	HAKSA.GAESUL_GWAMOK
SET	SIGAN			=	:ls_gaesul_sigan
WHERE	YEAR			=	:ls_year	
AND	HAKGI			=	:ls_hakgi
AND	GWA			=	:ls_gwa
AND	HAKYUN		=	:ls_hakyun
AND	BAN			=	:ls_ban
AND	GWAMOK_ID	=	:ls_gwamok
AND	GWAMOK_SEQ	=	:li_gwamok_seq
AND	BUNBAN		=	:ls_bunban
USING SQLCA	;

if sqlca.sqlcode = 0 then
	commit  USING SQLCA	;
	messagebox("확인","작업이 완료되었습니다.")
	
	dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, li_gwamok_seq, ls_bunban)
	
else
	messagebox("오류","개설과목 시간입력중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA	;
end if

	
end event

type dw_con from uo_dwfree within w_hsu108a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hsu105a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_con1 from uo_dwfree within w_hsu108a
integer x = 777
integer y = 1976
integer width = 1573
integer height = 152
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_hjk601p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;String ls_from_dt, ls_to_dt

Choose Case dwo.name
	Case 'p_from_dt'
		ls_from_dt 	= String(This.Object.from_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'from_dt' , ls_from_dt)
		
		ls_from_dt 	= left(ls_from_dt, 4) + mid(ls_from_dt, 6, 2) + right(ls_from_dt, 2)
		This.SetItem(row, 'from_dt',  ls_from_dt)
		
	Case 'p_to_dt'
		ls_to_dt 	= String(This.Object.to_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'to_dt' , ls_to_dt)
		
		ls_to_dt 	= left(ls_to_dt, 4) + mid(ls_to_dt, 6, 2) + right(ls_to_dt, 2)
		This.SetItem(row, 'to_dt',  ls_to_dt)
End Choose
end event

