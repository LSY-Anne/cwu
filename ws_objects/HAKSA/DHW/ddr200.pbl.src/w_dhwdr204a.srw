$PBExportHeader$w_dhwdr204a.srw
$PBExportComments$[대학원등록] 은행자료Loading
forward
global type w_dhwdr204a from w_condition_window
end type
type dw_con from uo_dwfree within w_dhwdr204a
end type
type sle_path from singlelineedit within w_dhwdr204a
end type
type uo_1 from uo_imgbtn within w_dhwdr204a
end type
type uo_2 from uo_imgbtn within w_dhwdr204a
end type
type dw_main from uo_dwfree within w_dhwdr204a
end type
end forward

global type w_dhwdr204a from w_condition_window
dw_con dw_con
sle_path sle_path
uo_1 uo_1
uo_2 uo_2
dw_main dw_main
end type
global w_dhwdr204a w_dhwdr204a

on w_dhwdr204a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.sle_path=create sle_path
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.sle_path
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.dw_main
end on

on w_dhwdr204a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.sle_path)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_bank
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_bank		=  dw_con.Object.bank_id[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

if ls_bank =''or isnull(ls_bank)  then
	messagebox('확인', "수납처를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("bank_id")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_bank)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;string	ls_hakgi, ls_year

//idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
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

type ln_templeft from w_condition_window`ln_templeft within w_dhwdr204a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwdr204a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwdr204a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwdr204a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwdr204a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwdr204a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwdr204a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwdr204a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwdr204a
end type

type uc_save from w_condition_window`uc_save within w_dhwdr204a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwdr204a
end type

type uc_print from w_condition_window`uc_print within w_dhwdr204a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwdr204a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwdr204a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwdr204a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwdr204a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwdr204a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwdr204a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwdr204a
end type

type dw_con from uo_dwfree within w_dhwdr204a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_dhwdr204a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type sle_path from singlelineedit within w_dhwdr204a
integer x = 59
integer y = 44
integer width = 1088
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_imgbtn within w_dhwdr204a
integer x = 1161
integer y = 40
integer width = 329
integer taborder = 40
boolean bringtotop = true
string btnname = "파일선택"
end type

event clicked;call super::clicked;//파일선택
string	ls_filename,named
integer	value

//경로 지정 윈도우 open
value = GetFileOpenName("Select File", ls_filename, named,"TXT", "ALL Files &(*.*),*.*,Text Files (*.TXT),*.TXT,Doc Files (*.DOC),*.DOC")

sle_path.text = ls_filename
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_dhwdr204a
integer x = 1563
integer y = 40
integer width = 576
integer taborder = 50
boolean bringtotop = true
string btnname = "은행자료Loading"
end type

event clicked;call super::clicked;//File 읽기 변수
integer	fnum, bytes_read, value, i, mok
string	ls_filename, named, ls_path, ls_line
double	flen

string  ls_sunapcheo, ls_chk_suhum, ls_chk

//DB에 넣을 변수
string	ls_year, ls_hakgi, ls_hakbun, ls_dr_ilja
long		ll_napip, ll_wonwoo, ll_iphak, ll_dungrok, ll_janghak, ll_sil_dungrok

//년도, 학기
dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_sunapcheo	=  dw_con.Object.bank_id[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

if ls_sunapcheo = '' or isnull(ls_sunapcheo) or ls_sunapcheo = '1' then
	MESSAGEBOX("확인","수납처를 선택해주세요.")
	RETURN
end if

if messagebox("확인","선택된 File을 처리하시겠습니까?", Question!, YesNo!, 2) = 2 then return

//File Open
ls_filename	=	sle_path.text
flen = FileLength(ls_filename) 
fnum = fileopen(ls_filename, Linemode!, Read!, LockRead!)

if fnum = -1 then
	messagebox("확인", ls_filename + "화일을 열수가 없습니다", StopSign!, OK!)
	FileClose(fnum)
	return 
end if

CHOOSE CASE  ls_sunapcheo
	CASE '2'													//WOORI BANK
		
		mok = flen / 109 + 2

		for i = 1 to mok
	
			bytes_read = fileread(fnum, ls_line)
			
			if bytes_read = -100 then
				fileclose(fnum) 
				EXIT
			end if	
			
			ls_chk	=	mid(ls_line, 1, 1)
			
			if ls_chk = ' ' then
				messagebox("오류!","우리은행 형식의 File이 아닙니다.~r~n다시 선택해 주세요.")
				FileClose(fnum)
				return
			end if			
//			
			ls_hakbun			=	trim(mid(ls_line, 1, 9))
			ll_iphak				=	long(trim(mid(ls_line, 16, 7)))
			ll_dungrok			=	long(trim(mid(ls_line, 23, 7)))
			ll_janghak			=	long(trim(mid(ls_line, 37, 7)))
			ll_sil_dungrok		=	long(trim(mid(ls_line, 44, 7)))
			ll_wonwoo			=	long(trim(mid(ls_line, 51, 7)))
			ls_dr_ilja			=	mid(ls_line, 102, 8)
						
			//Update
			UPDATE	HAKSA.D_DUNGROK
			SET	IPHAK_N		=	:ll_iphak		,
					DUNGROK_N	=	(:ll_sil_dungrok - :ll_iphak),
					WONWOO_N		=	:ll_wonwoo		,
					NAPBU_DATE	=	:ls_dr_ilja	,
					BANK_ID		=	'2',
					WAN_YN		=	'1',
					DUNG_YN		=	'1'
			WHERE	YEAR		=	:ls_year
			AND	HAKGI		=	:ls_hakgi
			AND	HAKBUN	=	:ls_hakbun
			USING SQLCA ;
						
			if sqlca.sqlcode <> 0 then
				messagebox("오류!",ls_hakbun + " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				fileclose(fnum)
				return
				
			end if
					
		next							
		
		
	CASE '3'													//KOOKMIN BANK
		
		mok = flen / 129 + 2
		for i = 1 to mok
	
			bytes_read = fileread(fnum, ls_line)
			
			if bytes_read = -100 then
				fileclose(fnum) 
				EXIT
			end if
			
			ls_chk	=	mid(ls_line, 1, 1)
			
			if ls_chk <> ' ' then
				messagebox("오류!","국민은행 형식의 File이 아닙니다.~r~n다시 선택해 주세요.")
				FileClose(fnum)
				return
			end if
			
			ls_hakbun	=	trim(mid(ls_line, 13, 12))
			ll_napip		=	long(trim(mid(ls_line,  58, 7)))
			ll_wonwoo	=	long(trim(mid(ls_line, 66, 6)))
			ls_dr_ilja	=	mid(ls_line, 114, 8)
			
			//Update
			UPDATE	HAKSA.D_DUNGROK
			SET	DUNGROK_N	=	:ll_napip	,
					WONWOO_N		=	:ll_wonwoo	,
					NAPBU_DATE	=	:ls_dr_ilja,
					BANK_ID		=	'3',
					WAN_YN		=	'1',
					DUNG_YN		=	'1'
			WHERE	YEAR		=	:ls_year
			AND	HAKGI		=	:ls_hakgi
			AND	HAKBUN	=	:ls_hakbun
			USING SQLCA ;

			if sqlca.sqlcode <> 0 then
				messagebox("오류!",ls_hakbun + " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				fileclose(fnum)
				return
				
			end if
					
		NEXT
			
END CHOOSE

if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	fileclose(fnum)
	MESSAGEBOX("확인!","작업이 종료되었습니다.")
	
	dw_main.retrieve(ls_year, ls_hakgi, ls_sunapcheo)
		
end if
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_dhwdr204a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dhwdr204a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

