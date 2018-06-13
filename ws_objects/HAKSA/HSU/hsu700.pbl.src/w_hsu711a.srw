$PBExportHeader$w_hsu711a.srw
$PBExportComments$[청운대]강의평가_OMR Loading
forward
global type w_hsu711a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hsu711a
end type
type cb_1 from commandbutton within w_hsu711a
end type
type sle_path from singlelineedit within w_hsu711a
end type
type cb_2 from commandbutton within w_hsu711a
end type
type dw_con from uo_dwfree within w_hsu711a
end type
end forward

global type w_hsu711a from w_condition_window
dw_main dw_main
cb_1 cb_1
sle_path sle_path
cb_2 cb_2
dw_con dw_con
end type
global w_hsu711a w_hsu711a

on w_hsu711a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.cb_1=create cb_1
this.sle_path=create sle_path
this.cb_2=create cb_2
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.sle_path
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_con
end on

on w_hsu711a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.cb_1)
destroy(this.sle_path)
destroy(this.cb_2)
destroy(this.dw_con)
end on

event ue_retrieve;int		li_row
string 	ls_year,	ls_hakgi

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

li_row = dw_main.retrieve(ls_year, ls_hakgi)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1

end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu711a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu711a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu711a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu711a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu711a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu711a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu711a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu711a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu711a
end type

type uc_save from w_condition_window`uc_save within w_hsu711a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu711a
end type

type uc_print from w_condition_window`uc_print within w_hsu711a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu711a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu711a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu711a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu711a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu711a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu711a
end type

type gb_2 from w_condition_window`gb_2 within w_hsu711a
end type

type dw_main from uo_input_dwc within w_hsu711a
integer x = 50
integer y = 292
integer width = 4379
integer height = 1972
integer taborder = 10
boolean bringtotop = true
end type

type cb_1 from commandbutton within w_hsu711a
integer x = 1641
integer y = 40
integer width = 544
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "자료Loading"
end type

event clicked;//File 읽기 변수
integer	fnum, bytes_read, value, i, mok
string	ls_filename, named, ls_path, ls_line
double	flen

string  ls_sunapcheo, ls_chk_suhum, ls_chk

//DB에 넣을 변수
long 		ll_write, ll_read, li_rtn, li_FileNumber, ll_in_cnt
string  ls_year, ls_hakgi, ls_textin, ls_dt, ls_hakyun, ls_gwa, ls_studt_na, ls_sex
string	 ls_gwamok, ls_member, ls_isu_gubun, ls_juya
long 		 ls_jumsu01, ls_jumsu02, ls_jumsu03, ls_jumsu04, ls_jumsu05, ls_jumsu06, ls_jumsu07, ls_jumsu08
long 		 ls_jumsu09, ls_jumsu10, ls_jumsu11, ls_jumsu12, ls_jumsu13, ls_jumsu14, ls_jumsu15, ls_jumsu16
long 		 ls_jumsu17
int		 ll_cnt

SetPointer(Hourglass!)

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year = '' or isnull(ls_year) or isnull(ls_hakgi) or ls_hakgi = '' then
	MESSAGEBOX("확인","년도, 학기를 선택해주세요.")
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
	return 1
end if

mok = flen / ( 39 + 2)
	for i = 1 to mok
	
		bytes_read = fileread(fnum, ls_line)
		
		if bytes_read = -100 then
			fileclose(fnum) 
			EXIT
		end if	
	 ls_juya			 = Mid(ls_line, 5, 1)
	 
	 if ls_juya = '1' or ls_juya = '2' then
		 ls_juya = '1'
	 else 
		 ls_juya = '2'	
    end if
	 
	 ls_gwa         = Mid(ls_line, 1, 3) + ls_juya         // 학과
    ls_hakyun      = Mid(ls_line, 4, 1)           // 학년
	 ls_sex			 = Mid(ls_line, 6, 1)           // 성별
	 ls_isu_gubun	 = Mid(ls_line, 7, 1)           // 이수구분
    ls_gwamok   	 = Mid(ls_line, 8, 9)           // 학수번호
    ls_member		 = Mid(ls_line, 17, 5)                // 교수코드
//    ls_techr_na_kr= Mid(ls_textin, 21, 6)                // 교수명
	 ls_jumsu01     = long(Mid(ls_line,22, 1))           // 문제 1
	 ls_jumsu02     = long(Mid(ls_line,23, 1))           // 문제 2
	 ls_jumsu03     = long(Mid(ls_line,24, 1))           // 문제 3
	 ls_jumsu04     = long(Mid(ls_line,25, 1))           // 문제 4
	 ls_jumsu05     = long(Mid(ls_line,26, 1))           // 문제 5
	 ls_jumsu06     = long(Mid(ls_line,27, 1))           // 문제 6
	 ls_jumsu07     = long(Mid(ls_line,28, 1))           // 문제 7
	 ls_jumsu08     = long(Mid(ls_line,29, 1))           // 문제 8
	 ls_jumsu09     = long(Mid(ls_line,30, 1))           // 문제 9
	 ls_jumsu10     = long(Mid(ls_line,31, 1))           // 문제 10
	 ls_jumsu11     = long(Mid(ls_line,32, 1))           // 문제 11
	 ls_jumsu12     = long(Mid(ls_line,33, 1))           // 문제 12
	 ls_jumsu13     = long(Mid(ls_line,34, 1))           // 문제 13
	 ls_jumsu14     = long(Mid(ls_line,35, 1))           // 문제 14
	 ls_jumsu15     = long(Mid(ls_line,36, 1))           // 문제 15
	 ls_jumsu16     = long(Mid(ls_line,37, 1))           // 문제 16
	 ls_jumsu17     = long(Mid(ls_line,38, 1))           // 문제 17


	  INSERT INTO HAKSA.EVALUATE_OMR
				( 	YEAR,			HAKGI,		GWA,			HAKYUN,		SEX,			ISU_GUBUN,	GWAMOK,
					MEMBER_NO,	JUMSU01,		JUMSU02,		JUMSU03,		JUMSU04,		JUMSU05,		JUMSU06,
					JUMSU07, 	JUMSU08,		JUMSU09,		JUMSU10,		JUMSU11,		JUMSU12,		JUMSU13,
					JUMSU14,		JUMSU15,		JUMSU16,		JUMSU17,		WORKER,		IPADDR,		WORK_DATE,
					JOB_UID,		JOB_ADD,		JOB_DATE	)  
	  VALUES (	:ls_year,	:ls_hakgi,	:ls_gwa,		:ls_hakyun,	:ls_sex,		:ls_isu_gubun,:ls_gwamok,
	  				:ls_member,	:ls_jumsu01,:ls_jumsu02,:ls_jumsu03,:ls_jumsu04,:ls_jumsu05,:ls_jumsu06,
					:ls_jumsu07,:ls_jumsu08,:ls_jumsu09,:ls_jumsu10,:ls_jumsu11,:ls_jumsu12,:ls_jumsu13,
					:ls_jumsu14,:ls_jumsu15,:ls_jumsu16,:ls_jumsu17,'F0016',		:i,			SYSDATE,
					'F0016',		'210.97.46.65',SYSDATE ) USING SQLCA ;

					
		if sqlca.sqlcode <> 0 then
			messagebox("오류!",ls_line + " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
			messagebox("오류!",i)			
			rollback  USING SQLCA ;
			fileclose(fnum)
			return
		end if			
	next							


FileClose(li_FileNumber)

SetPointer(Arrow!)

Messagebox('생성확인', '총READ건수 : ' + string(mok))

if sqlca.sqlcode = 0 then
	commit  USING SQLCA ;
	fileclose(fnum)
	MESSAGEBOX("확인!","작업이 종료되었습니다.")
	
	dw_main.retrieve()
		
end if
end event

type sle_path from singlelineedit within w_hsu711a
integer x = 192
integer y = 48
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

type cb_2 from commandbutton within w_hsu711a
integer x = 1289
integer y = 40
integer width = 329
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "파일선택"
end type

event clicked;//파일선택
string	ls_filename,named
integer	value

//경로 지정 윈도우 open
value = GetFileOpenName("Select File", ls_filename, named,"TXT", "ALL Files &(*.*),*.*,Text Files (*.TXT),*.TXT,Doc Files (*.DOC),*.DOC")

sle_path.text = ls_filename
end event

type dw_con from uo_dwfree within w_hsu711a
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 160
string dataobject = "d_hsu702p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

