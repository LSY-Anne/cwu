$PBExportHeader$w_hjh302a.srw
$PBExportComments$[청운대]신입생오티_OMR Loading
forward
global type w_hjh302a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjh302a
end type
type dw_con from uo_dwfree within w_hjh302a
end type
type sle_path from singlelineedit within w_hjh302a
end type
type uo_1 from uo_imgbtn within w_hjh302a
end type
type uo_2 from uo_imgbtn within w_hjh302a
end type
end forward

global type w_hjh302a from w_condition_window
dw_main dw_main
dw_con dw_con
sle_path sle_path
uo_1 uo_1
uo_2 uo_2
end type
global w_hjh302a w_hjh302a

on w_hjh302a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.sle_path=create sle_path
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.sle_path
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.uo_2
end on

on w_hjh302a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.sle_path)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event ue_retrieve;integer	li_row
string	ls_year, ls_hakgi

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도와 학기를 입력하세요!")
	return -1 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if
	
li_row = dw_main.retrieve(ls_year, ls_hakgi)

if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;//idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = func.of_get_sdate('YYYY')
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjh302a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh302a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh302a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh302a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh302a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh302a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh302a
end type

type uc_insert from w_condition_window`uc_insert within w_hjh302a
end type

type uc_delete from w_condition_window`uc_delete within w_hjh302a
end type

type uc_save from w_condition_window`uc_save within w_hjh302a
end type

type uc_excel from w_condition_window`uc_excel within w_hjh302a
end type

type uc_print from w_condition_window`uc_print within w_hjh302a
end type

type st_line1 from w_condition_window`st_line1 within w_hjh302a
end type

type st_line2 from w_condition_window`st_line2 within w_hjh302a
end type

type st_line3 from w_condition_window`st_line3 within w_hjh302a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh302a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh302a
end type

type gb_1 from w_condition_window`gb_1 within w_hjh302a
end type

type gb_2 from w_condition_window`gb_2 within w_hjh302a
end type

type dw_main from uo_input_dwc within w_hjh302a
integer x = 55
integer y = 308
integer width = 4375
integer height = 1956
integer taborder = 10
boolean bringtotop = true
end type

event clicked;call super::clicked;//파일선택
string	ls_filename,named
integer	value

//경로 지정 윈도우 open
value = GetFileOpenName("Select File", ls_filename, named,"TXT", "ALL Files &(*.*),*.*,Text Files (*.TXT),*.TXT,Doc Files (*.DOC),*.DOC")

sle_path.text = ls_filename
end event

type dw_con from uo_dwfree within w_hjh302a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hjh210p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type sle_path from singlelineedit within w_hjh302a
integer x = 283
integer y = 44
integer width = 1088
integer height = 76
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

type uo_1 from uo_imgbtn within w_hjh302a
integer x = 1390
integer y = 40
integer width = 329
integer taborder = 40
boolean bringtotop = true
string btnname = "파일선택"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hjh302a
integer x = 1760
integer y = 40
integer width = 544
integer taborder = 40
boolean bringtotop = true
string btnname = "자료Loading"
end type

event clicked;call super::clicked;//File 읽기 변수
integer	fnum, bytes_read, value, i, mok
string	ls_filename, named, ls_path, ls_line
double	flen

string  ls_sunapcheo, ls_chk_suhum, ls_chk

//DB에 넣을 변수
long 		ll_write, ll_read, li_rtn, li_FileNumber, ll_in_cnt
string  ls_year, ls_hakgi, ls_textin, ls_dt, ls_sex
long 	  ls_jumsu01, ls_jumsu02, ls_jumsu03, ls_jumsu07, ls_jumsu08
long	  ls_jumsu04_1, ls_jumsu04_2, ls_jumsu04_3, ls_jumsu04_4, ls_jumsu04_5,  &
		  ls_jumsu05_1, ls_jumsu05_2, ls_jumsu05_3, & 
		  ls_jumsu06_1, ls_jumsu06_2, ls_jumsu06_3	 
long 	  ls_jumsu09, ls_jumsu10, ls_jumsu11, ls_count
int     ll_cnt

SetPointer(Hourglass!)

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도와 학기를 입력하세요!")
	return
	dw_con.setfocus()
	dw_con.SetColumn("year")
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

mok = flen / ( 11 + 2)
		
	for i = 1 to mok
	
		bytes_read = fileread(fnum, ls_line)
		
		if bytes_read = -100 then
			fileclose(fnum) 
			EXIT
		end if	
				
	 ls_sex			 = trim(Mid(ls_line, 1, 1))       		    // 성별
	 ls_jumsu01     = long(trim(Mid(ls_line,2, 1)))           // 문제 1
	 ls_jumsu02     = long(trim(Mid(ls_line,3, 1)))           // 문제 2
	 ls_jumsu03     = long(trim(Mid(ls_line,4, 1)))           // 문제 3
	 ls_jumsu04_1   = long(trim(Mid(ls_line,5, 1)))           // 문제 4
	 ls_jumsu05_1   = long(trim(Mid(ls_line,6, 1)))           // 문제 5 
	 ls_jumsu06_1   = long(trim(Mid(ls_line,7, 1)))           // 문제 6
//	 ls_jumsu04_1   = long(trim(Mid(ls_line,5, 1)))           // 문제 4_1
//	 ls_jumsu04_2   = long(trim(Mid(ls_line,6, 1)))           // 문제 4_2
//	 ls_jumsu04_3   = long(trim(Mid(ls_line,7, 1)))           // 문제 4_3
//	 ls_jumsu04_4   = long(trim(Mid(ls_line,8, 1)))           // 문제 4_4
//	 ls_jumsu04_5   = long(trim(Mid(ls_line,9, 1)))           // 문제 4_5
//	 ls_jumsu05_1   = long(trim(Mid(ls_line,10, 1)))          // 문제 5_1
//	 ls_jumsu05_2   = long(trim(Mid(ls_line,11, 1)))          // 문제 5_2
//	 ls_jumsu05_3   = long(trim(Mid(ls_line,12, 1)))          // 문제 5_3
//	 ls_jumsu06_1   = long(trim(Mid(ls_line,13, 1)))          // 문제 6_1
//	 ls_jumsu06_2   = long(trim(Mid(ls_line,14, 1)))          // 문제 6_2
//	 ls_jumsu06_3   = long(trim(Mid(ls_line,15, 1)))          // 문제 6_3
	 ls_jumsu07     = long(trim(Mid(ls_line,8, 1)))          // 문제 7
	 ls_jumsu08     = long(trim(Mid(ls_line,9, 1)))          // 문제 8
	 ls_jumsu09     = long(trim(Mid(ls_line,10, 1)))          // 문제 9
	 ls_jumsu10     = long(trim(Mid(ls_line,11, 1)))          // 문제 10
//	 ls_jumsu11     = long(trim(Mid(ls_line,12, 1)))          // 문제 11
	 ls_count   	 = i 									         // 카운트


	  INSERT INTO HAKSA.ORIENTATION_OMR
				( 	YEAR,				HAKGI,			SEX,			
					JUMSU01,			JUMSU02,			JUMSU03,			JUMSU04_1,		JUMSU05_1,
					JUMSU06_1,		JUMSU07, 		
					JUMSU08,			JUMSU09,			JUMSU10,			COUNT,			
					WORKER,			IPADDR,			WORK_DATE,		JOB_UID,			JOB_ADD,			
					JOB_DATE	)  
	  VALUES (	:ls_year,		:ls_hakgi,		:ls_sex,
	  			 	:ls_jumsu01,	:ls_jumsu02,	:ls_jumsu03,	:ls_jumsu04_1,	:ls_jumsu05_1,
					:ls_jumsu06_1,	:ls_jumsu07, 
				 	:ls_jumsu08,	:ls_jumsu09,	:ls_jumsu10,	:ls_count,
					:gs_empcode,	:gs_ip,             sysdate,			:gs_empcode,	:gs_ip,
					sysdate ) USING SQLCA ;
					
		if sqlca.sqlcode <> 0 then
			messagebox("오류!", " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
			fileclose(fnum)
			return
		end if			
	next							


FileClose(li_FileNumber)

SetPointer(Arrow!)

commit  USING SQLCA ;

Messagebox('생성확인', '총READ건수 : ' + string(mok))
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

