$PBExportHeader$w_hjh105a.srw
$PBExportComments$[청운대]대출학생관리Loading
forward
global type w_hjh105a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjh105a
end type
type dw_con from uo_dwfree within w_hjh105a
end type
type sle_path from singlelineedit within w_hjh105a
end type
type uo_1 from uo_imgbtn within w_hjh105a
end type
type uo_2 from uo_imgbtn within w_hjh105a
end type
type uo_3 from uo_imgbtn within w_hjh105a
end type
type st_cnt from statictext within w_hjh105a
end type
end forward

global type w_hjh105a from w_condition_window
dw_main dw_main
dw_con dw_con
sle_path sle_path
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
st_cnt st_cnt
end type
global w_hjh105a w_hjh105a

on w_hjh105a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.sle_path=create sle_path
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
this.st_cnt=create st_cnt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.sle_path
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.uo_3
this.Control[iCurrent+7]=this.st_cnt
end on

on w_hjh105a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.sle_path)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.st_cnt)
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

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjh105a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh105a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh105a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh105a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh105a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh105a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh105a
end type

type uc_insert from w_condition_window`uc_insert within w_hjh105a
end type

type uc_delete from w_condition_window`uc_delete within w_hjh105a
end type

type uc_save from w_condition_window`uc_save within w_hjh105a
end type

type uc_excel from w_condition_window`uc_excel within w_hjh105a
end type

type uc_print from w_condition_window`uc_print within w_hjh105a
end type

type st_line1 from w_condition_window`st_line1 within w_hjh105a
end type

type st_line2 from w_condition_window`st_line2 within w_hjh105a
end type

type st_line3 from w_condition_window`st_line3 within w_hjh105a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh105a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh105a
end type

type gb_1 from w_condition_window`gb_1 within w_hjh105a
end type

type gb_2 from w_condition_window`gb_2 within w_hjh105a
end type

type dw_main from uo_input_dwc within w_hjh105a
integer x = 59
integer y = 308
integer width = 4375
integer height = 1948
integer taborder = 10
boolean bringtotop = true
end type

type dw_con from uo_dwfree within w_hjh105a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hjh105a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type sle_path from singlelineedit within w_hjh105a
integer x = 69
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

type uo_1 from uo_imgbtn within w_hjh105a
integer x = 1184
integer y = 40
integer width = 329
integer taborder = 170
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

type uo_2 from uo_imgbtn within w_hjh105a
integer x = 1595
integer y = 40
integer width = 439
integer taborder = 40
boolean bringtotop = true
string btnname = "학생자료Loading"
end type

event clicked;call super::clicked;//File 읽기 변수
integer	fnum, bytes_read, value, i, mok
string	ls_filename, named, ls_path, ls_line 
double	flen

string  ls_chk_suhum, ls_chk

//DB에 넣을 변수
string	ls_year, ls_hakgi, ls_hakbun, ls_name, ls_serial, ls_jumin_no, ls_gwa, ls_hakyun
long		ll_napip, ll_haksengwhe, ll_gyojae, ll_dongchang, ll_memory,&
			ll_album, ll_ip_napip,   ll_hakjum

//년도, 학기
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
	return 
end if

mok = flen / ( 34 + 2)

messagebox('처리 건수', string(mok))

for i = 1 to mok

	bytes_read = fileread(fnum, ls_line)
	
	if bytes_read = -100 then
		fileclose(fnum) 
		EXIT
	end if	
	
	ls_chk	=	mid(ls_line, 1, 1)
	
	if ls_chk = ' ' then
		messagebox("오류!","자료 형식의 File이 아닙니다.~r~n다시 선택해 주세요.")
		FileClose(fnum)
		return
	end if			
	
	
	ls_jumin_no		=	trim(mid(ls_line, 1, 13))				//주민번호
	ls_name			=	trim(mid(ls_line, 15, 20))				//성명	

	SELECT	A.HAKBUN,
				A.SU_HAKYUN,
				A.GWA
	INTO		:ls_hakbun,
				:ls_hakyun,
				:ls_gwa
	FROM 		(	SELECT	HAKBUN,
								SU_HAKYUN,
								GWA
					FROM		HAKSA.JAEHAK_HAKJUK
					WHERE		JUMIN_NO	=	:ls_jumin_no
					
					UNION
					
					SELECT	HAKBUN,
								SU_HAKYUN,
								GWA
					FROM		HAKSA.JOLUP_HAKJUK
					WHERE		JUMIN_NO	=	:ls_jumin_no) A
	USING SQLCA ;

			//INSERT
		  INSERT INTO HAKSA.DAICHUL_GWANRI
						 (SERIAL,   		GUBUN,			HAKBUN,			YEAR,	   		HAKGI,  		GWA,		 		HNAME,	   JUMIN_NO,
						  HAKYUN,  			DAICHUL_ID,  	SUNBAL_DATE, 						GITAGUM,   	WORKER,   						IPADDR,
						  WORK_DATE,	  	JOB_UID,		  	JOB_ADD,  		JOB_DATE)
			  VALUES   (:i,		   	'1',				:ls_hakbun,		:ls_year,		:ls_hakgi,  :ls_gwa,			:ls_name,	:ls_jumin_no,
						  :ls_hakyun,		'1', 				TO_CHAR(SYSDATE, 'YYYYMMDD'),  null,		:gs_empcode,		:gs_ip,
						  SYSDATE,		  	NULL,				NULL,				SYSDATE  ) USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류!",ls_hakbun + " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		fileclose(fnum)
		return
	end if			

	st_cnt.text = string(i) + '/' + string(mok)

next							
		

if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	fileclose(fnum)
	MESSAGEBOX("확인!","작업이 종료되었습니다.")
	
	dw_main.retrieve()
		
end if
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type uo_3 from uo_imgbtn within w_hjh105a
integer x = 2249
integer y = 40
integer width = 608
integer taborder = 50
boolean bringtotop = true
string btnname = "기등록학생Loading"
end type

event clicked;call super::clicked;//File 읽기 변수
integer	fnum, bytes_read, value, i, mok
string	ls_filename, named, ls_path, ls_line 
double	flen

string  ls_chk_suhum, ls_chk

//DB에 넣을 변수
string	ls_year, ls_hakgi, ls_hakbun, ls_name, ls_serial, ls_jumin_no, ls_gwa, ls_hakyun
long		ll_napip, ll_haksengwhe, ll_gyojae, ll_dongchang, ll_memory,&
			ll_album, ll_ip_napip,   ll_hakjum

//년도, 학기
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
	return 
end if

mok = flen / ( 34 + 2)
//mok = flen / ( 14 + 2)
messagebox('처리 건수', string(mok))

for i = 1 to mok

	bytes_read = fileread(fnum, ls_line)
	
	if bytes_read = -100 then
		fileclose(fnum) 
		EXIT
	end if	
	
	ls_chk	=	mid(ls_line, 1, 1)
	
	if ls_chk = ' ' then
		messagebox("오류!","자료 형식의 File이 아닙니다.~r~n다시 선택해 주세요.")
		FileClose(fnum)
		return
	end if			
	
//	ls_serial		= 	trim(mid(ls_line, 1, 13))				//일련번호
	ls_jumin_no		=	trim(mid(ls_line, 1, 13))				//주민번호
//	ls_hakbun		=	trim(mid(ls_line, 29, 9))				//학번
//	ls_gwa			=	trim(mid(ls_line, 69, 2))				//학과
	ls_name			=	trim(mid(ls_line, 15, 20))				//성명
	
////	ls_serial		= 	trim(mid(ls_line, 1, 13))				//일련번호
////	ls_jumin_no		=	trim(mid(ls_line, 1, 13))				//주민번호
//	ls_name			=	trim(mid(ls_line, 1, 6))				//성명
//	ls_hakbun		=	trim(mid(ls_line, 7, 8))				//학번
////	ls_gwa			=	trim(mid(ls_line, 69, 2))				//학과
//

	SELECT	A.HAKBUN,
				A.SU_HAKYUN
	INTO		:ls_hakbun,
				:ls_hakyun				
	FROM 		(	SELECT	HAKBUN,
								SU_HAKYUN
					FROM		HAKSA.JAEHAK_HAKJUK
					WHERE		JUMIN_NO	=	:ls_jumin_no
					
					UNION
					
					SELECT	HAKBUN,
								SU_HAKYUN
					FROM		HAKSA.JOLUP_HAKJUK
					WHERE		JUMIN_NO	=	:ls_jumin_no) A
	USING SQLCA ;


			//INSERT
		  INSERT INTO HAKSA.DAICHUL_GIDUNGROK  		
						 (YEAR,	   		HAKGI,  			HAKBUN,			GWA,		 		HNAME,	   JUMIN_NO,
						  HAKYUN,  			DAICHUL_ID,  	SUNBAL_DATE, 	GITAGUM,   		WORKER,    	IPADDR,
						  WORK_DATE,	  	JOB_UID,		  	JOB_ADD,  		JOB_DATE)
			  VALUES   (:ls_year,		:ls_hakgi,  	:ls_hakbun,		null,				:ls_name,	:ls_jumin_no,
						  :ls_hakyun,   	'1', 				TO_CHAR(SYSDATE, 'YYYYMMDD'),  null,		:gs_empcode,		:gs_ip,
						  SYSDATE,		  	NULL,				NULL,				SYSDATE  ) USING SQLCA ;

				
	if sqlca.sqlcode <> 0 then
		messagebox("오류!",ls_hakbun + " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		fileclose(fnum)
		return
	end if			

	st_cnt.text = string(i) + '/' + string(mok)

next							
		

if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	fileclose(fnum)
	MESSAGEBOX("확인!","작업이 종료되었습니다.")
	
	dw_main.retrieve()
		
end if
end event

on uo_3.destroy
call uo_imgbtn::destroy
end on

type st_cnt from statictext within w_hjh105a
integer x = 2962
integer y = 48
integer width = 530
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 32500968
alignment alignment = right!
boolean focusrectangle = false
end type

