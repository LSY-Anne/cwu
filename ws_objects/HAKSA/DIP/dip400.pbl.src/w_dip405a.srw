$PBExportHeader$w_dip405a.srw
$PBExportComments$[대학원입시] 은행파일Loading
forward
global type w_dip405a from w_condition_window
end type
type sle_path from singlelineedit within w_dip405a
end type
type dw_con from uo_dwfree within w_dip405a
end type
type uo_1 from uo_imgbtn within w_dip405a
end type
type uo_2 from uo_imgbtn within w_dip405a
end type
type dw_main from uo_dwfree within w_dip405a
end type
end forward

global type w_dip405a from w_condition_window
sle_path sle_path
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
dw_main dw_main
end type
global w_dip405a w_dip405a

on w_dip405a.create
int iCurrent
call super::create
this.sle_path=create sle_path
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_path
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.dw_main
end on

on w_dip405a.destroy
call super::destroy
destroy(this.sle_path)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_bank
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_bank        =	dw_con.Object.bank_id[1]

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
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

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	NEXT_YEAR,      NEXT_HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi

end event

type ln_templeft from w_condition_window`ln_templeft within w_dip405a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dip405a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dip405a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dip405a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dip405a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dip405a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dip405a
end type

type uc_insert from w_condition_window`uc_insert within w_dip405a
end type

type uc_delete from w_condition_window`uc_delete within w_dip405a
end type

type uc_save from w_condition_window`uc_save within w_dip405a
end type

type uc_excel from w_condition_window`uc_excel within w_dip405a
end type

type uc_print from w_condition_window`uc_print within w_dip405a
end type

type st_line1 from w_condition_window`st_line1 within w_dip405a
end type

type st_line2 from w_condition_window`st_line2 within w_dip405a
end type

type st_line3 from w_condition_window`st_line3 within w_dip405a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dip405a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dip405a
end type

type gb_1 from w_condition_window`gb_1 within w_dip405a
end type

type gb_2 from w_condition_window`gb_2 within w_dip405a
end type

type sle_path from singlelineedit within w_dip405a
integer x = 128
integer y = 40
integer width = 1211
integer height = 80
integer taborder = 60
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

type dw_con from uo_dwfree within w_dip405a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 200
boolean bringtotop = true
string dataobject = "d_dip404a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_dip405a
integer x = 1367
integer y = 40
integer width = 370
integer taborder = 70
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

type uo_2 from uo_imgbtn within w_dip405a
integer x = 1792
integer y = 40
integer width = 850
integer taborder = 80
boolean bringtotop = true
string btnname = "은행자료Loading"
end type

event clicked;call super::clicked;//File 읽기 변수
integer	fnum, bytes_read, value, i, mok
string	ls_filename, named, ls_path, ls_line
double	flen

string  ls_sunapcheo, ls_chk_suhum, ls_chk

//DB에 넣을 변수
string	ls_year, ls_hakgi, ls_suhum, ls_dr_ilja, ls_napbu_ilja
string	ls_hakgwa, ls_name, ls_hakgicha
long		ll_dungrok, ll_iphak, ll_wonwoo, ll_janghak, ll_sil_dungrok
long		ll_hakjum, ll_napip

dw_con.AcceptText()

ls_year		  =	 dw_con.Object.year[1]
ls_hakgi		  =	 dw_con.Object.hakgi[1]
ls_sunapcheo = dw_con.Object.bank_id[1]

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
end if

if ls_sunapcheo = '' or isnull(ls_sunapcheo) or ls_sunapcheo = '1' then
	MESSAGEBOX("확인","수납처를 선택해주세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("bank_id")
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
		
		mok = flen / (101 + 2)
				
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
						
			ls_suhum				=	trim(mid(ls_line, 1, 8))
			ls_hakgwa			=	trim(mid(ls_line, 11, 4))
			ll_iphak				=	long(trim(mid(ls_line, 16, 7)))
			ll_dungrok			=	long(trim(mid(ls_line, 23, 7)))
			ll_janghak			=	long(trim(mid(ls_line, 37, 7)))
			ll_sil_dungrok		=	long(trim(mid(ls_line, 44, 7)))
			ll_wonwoo			=	long(trim(mid(ls_line, 51, 7)))
			ls_name				=	trim(mid(ls_line, 72, 16))
			
//			ls_napbu_ilja		=	mid(ls_line, 64, 8)
			
			//Update
			UPDATE	DIPSI.DI_DUNGROK
			SET	IPHAK_N		=	:ll_iphak		,
					DUNGROK_N	=	(:ll_sil_dungrok - :ll_iphak),
					WONWOO_N		=	:ll_wonwoo		,
					NAPBU_DATE	=	TO_CHAR(SYSDATE, 'YYYYMMDD')	,
					BANK_ID		=	'2',
					WAN_YN		=	'1',
					DUNG_YN		=	'1'
			WHERE	YEAR		=	:ls_year
			AND	HAKGI		=	:ls_hakgi
			AND	SUHUM_NO	=	:ls_suhum
			USING SQLCA ;
						
			if sqlca.sqlcode = 0 then
				
				UPDATE DIPSI.DI_WONSEO
				SET	DUNG_YN	=	'1'
				WHERE	YEAR		=	:ls_year
				AND	HAKGI		=	:ls_hakgi
				AND	SUHUM_NO	=	:ls_suhum
				USING SQLCA ;
				
				if sqlca.sqlcode <> 0 then
					messagebox("오류!",ls_suhum + " 처리중 오류발생(DI_WONSEO)~r~n" + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					fileclose(fnum)
					return					
				end if
				
			else
				
				messagebox("오류!",ls_suhum + " 처리중 오류발생(DI_DUNGROK)~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				fileclose(fnum)
				return
				
			end if
		next							
		
	CASE '3'													//KOOKMIN BANK
		
		mok = flen / (100 + 2)
		
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
			
			ls_suhum		=	trim(mid(ls_line, 13, 12))
			ll_iphak		=	long(trim(mid(ls_line,  44, 7)))
			ll_dungrok	=	long(trim(mid(ls_line,  51, 7)))
			ll_janghak	=	long(trim(mid(ls_line,  58, 7)))
			ll_sil_dungrok	=	long(trim(mid(ls_line,  65, 7)))
			ll_wonwoo	=	long(trim(mid(ls_line, 72, 7)))
			ls_dr_ilja	=	mid(ls_line, 93, 8)
			
			//Update
			UPDATE	DIPSI.DI_DUNGROK
			SET	IPHAK_N		=	:ll_iphak,
					DUNGROK_N	=	(:ll_sil_dungrok - :ll_iphak),
					WONWOO_N		=	:ll_wonwoo	,
					NAPBU_DATE	=	:ls_dr_ilja,
					BANK_ID		=	'3',
					WAN_YN		=	'1',
					DUNG_YN		=	'1'
			WHERE	YEAR		=	:ls_year
			AND	HAKGI		=	:ls_hakgi
			AND	SUHUM_NO	=	:ls_suhum
			USING SQLCA ;
			
			if sqlca.sqlcode = 0 then
				
				UPDATE DIPSI.DI_WONSEO
				SET	DUNG_YN	=	'1'
				WHERE	YEAR		=	:ls_year
				AND	HAKGI		=	:ls_hakgi
				AND	SUHUM_NO	=	:ls_suhum
				USING SQLCA ;
				
				if sqlca.sqlcode <> 0 then
					messagebox("오류!",ls_suhum + " 처리중 오류발생(DI_WONSEO)~r~n" + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					fileclose(fnum)
					return					
				end if
				
			else
				
				messagebox("오류!",ls_suhum + " 처리중 오류발생(DI_DUNGROK)~r~n" + sqlca.sqlerrtext)
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




////File 읽기 변수
//integer	fnum, bytes_read, value, i, mok
//string	ls_filename, named, ls_path, ls_line
//double	flen
//
//string  ls_sunapcheo, ls_chk_suhum, ls_chk
//
////DB에 넣을 변수
//string	ls_year, ls_hakgi, ls_suhum, ls_dr_ilja, ls_napbu_ilja
//string	ls_hakgwa, ls_name, ls_hakgicha
//long		ll_dungrok, ll_iphak, ll_wonwoo, ll_janghak, ll_i_jang, ll_d_jang
//long		ll_hakjum, ll_napip
//
////년도, 학기
//ls_year	=	em_1.text
//ls_hakgi	=	ddlb_1.text
//
//if ls_year = '' or ls_hakgi = '' then
//	MESSAGEBOX("확인","년도, 학기를 선택해주세요.")
//	RETURN
//end if
//
////수납처 선택
//ls_sunapcheo = dw_1.gettext()
//
//if ls_sunapcheo = '' or isnull(ls_sunapcheo) or ls_sunapcheo = '1' then
//	MESSAGEBOX("확인","수납처를 선택해주세요.")
//	RETURN
//end if
//
//if messagebox("확인","선택된 File을 처리하시겠습니까?", Question!, YesNo!, 2) = 2 then return
//
////File Open
//ls_filename	=	sle_path.text
//flen = FileLength(ls_filename) 
//fnum = fileopen(ls_filename, Linemode!, Read!, LockRead!)
//
//if fnum = -1 then
//	messagebox("확인", ls_filename + "화일을 열수가 없습니다", StopSign!, OK!)
//	FileClose(fnum)
//	return 1
//end if
//
//CHOOSE CASE  ls_sunapcheo
//	CASE '2'													//WOORI BANK
//		
//		mok = flen / 77
//
//		for i = 1 to mok
//	
//			bytes_read = fileread(fnum, ls_line)
//			
//			if bytes_read = -100 then
//				fileclose(fnum) 
//				EXIT
//			end if	
//			
//			ls_chk	=	mid(ls_line, 1, 1)
//			
//			if ls_chk = ' ' then
//				messagebox("오류!","우리은행 형식의 File이 아닙니다.~r~n다시 선택해 주세요.")
//				FileClose(fnum)
//				return
//			end if			
//			
//			ls_hakgwa	=	mid(ls_line, 1, 4)
//			ls_name		=	mid(ls_line, 5, 16)
//			ls_hakgicha	=	mid(ls_line, 21, 2)
//			ls_suhum		=	trim(mid(ls_line, 23, 10))
//			ll_hakjum	=	long(trim(mid(ls_line, 33, 2)))
//			ll_iphak		=	long(trim(mid(ls_line, 35, 7)))
//			ll_dungrok	=	long(trim(mid(ls_line, 42, 7)))
//			ll_janghak	=	long(trim(mid(ls_line, 49, 7)))
//			ll_napip		=	long(trim(mid(ls_line, 56, 7)))
//			ll_wonwoo	=	long(trim(mid(ls_line, 63, 7)))
//			
//			ls_napbu_ilja	=	mid(ls_line, 70, 8)
//
//			//Update
//			UPDATE	DIPSI.DI_DUNGROK
//			SET	IPHAK_N		=	:ll_iphak,
//					DUNGROK_N	=	:ll_dungrok	,
//					WONWOO_N		=	:ll_wonwoo	,
//					NAPBU_DATE	=	:ls_napbu_ilja,
//					BANK_ID		=	'2',
//					WAN_YN		=	'1',
//					DUNG_YN		=	'1'
//			WHERE	YEAR		=	:ls_year
//			AND	HAKGI		=	:ls_hakgi
//			AND	SUHUM_NO	=	:ls_suhum	;
//						
//				if sqlca.sqlcode = 0 then
//					INSERT INTO	DIPSI.DI_DUNGROK_BUN
//								(	YEAR,					HAKGI,			SUHUM_NO,		CHASU,
//									IPHAK,				DUNGROK,			WONWOO,			I_JANGHAK,	D_JANGHAK,
//									NAPBU_DATE,			BANK_ID,			NAP_GUBUN
//								)
//					VALUES	(	:ls_year,			:ls_hakgi,		:ls_suhum,		1,
//									:ll_iphak,			:ll_dungrok,	:ll_wonwoo,		:ll_i_jang,	:ll_d_jang,
//									:ls_napbu_ilja,	'1',				'1'
//								)	;
//								
//					if sqlca.sqlcode <> 0 then
//						messagebox("오류!",ls_suhum + " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
//						rollback ;
//						fileclose(fnum)
//						return
//					end if
//					
//				else
//					messagebox("오류!",ls_suhum + " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
//					rollback ;
//					fileclose(fnum)
//					return
//					
//				end if
//		next							
//		
//	CASE '3'													//KOOKMIN BANK
//		
//		mok = flen / 119
//		for i = 1 to mok
//	
//			bytes_read = fileread(fnum, ls_line)
//			
//			if bytes_read = -100 then
//				fileclose(fnum) 
//				EXIT
//			end if
//			
//			ls_chk	=	mid(ls_line, 1, 1)
//			
//			if ls_chk <> ' ' then
//				messagebox("오류!","국민은행 형식의 File이 아닙니다.~r~n다시 선택해 주세요.")
//				FileClose(fnum)
//				return
//			end if
//			
//			ls_suhum		=	trim(mid(ls_line, 13, 12))
////			ll_napip		=	long(trim(mid(ls_line,  58, 7)))
//			ll_wonwoo	=	long(trim(mid(ls_line, 65, 7)))
//			ls_dr_ilja	=	mid(ls_line, 114, 8)
//			
//			//Update
//			UPDATE	DIPSI.DI_DUNGROK
//			SET	IPHAK_N		=	:ll_iphak,
//					DUNGROK_N	=	:ll_dungrok	,
//					WONWOO_N		=	:ll_wonwoo	,
//					NAPBU_DATE	=	:ls_napbu_ilja,
//					BANK_ID		=	'2',
//					WAN_YN		=	'1',
//					DUNG_YN		=	'1'
//			WHERE	YEAR		=	:ls_year
//			AND	HAKGI		=	:ls_hakgi
//			AND	SUHUM_NO	=	:ls_suhum	;
//						
//				if sqlca.sqlcode = 0 then
//					INSERT INTO	DIPSI.DI_DUNGROK_BUN
//								(	YEAR,					HAKGI,			SUHUM_NO,		CHASU,
//									IPHAK,				DUNGROK,			WONWOO,			I_JANGHAK,	D_JANGHAK,
//									NAPBU_DATE,			BANK_ID,			NAP_GUBUN
//								)
//					VALUES	(	:ls_year,			:ls_hakgi,		:ls_suhum,		1,
//									:ll_iphak,			:ll_dungrok,	:ll_wonwoo,		:ll_i_jang,	:ll_d_jang,
//									:ls_napbu_ilja,	'1',				'1'
//								)	;
//								
//					if sqlca.sqlcode <> 0 then
//						messagebox("오류!",ls_suhum + " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
//						rollback ;
//						fileclose(fnum)
//						return
//					end if
//					
//				else
//					messagebox("오류!",ls_suhum + " 처리중 오류발생~r~n" + sqlca.sqlerrtext)
//					rollback ;
//					fileclose(fnum)
//					return
//					
//				end if
//		NEXT
//	
//END CHOOSE
//
//if sqlca.sqlcode = 0 then
//	commit ;
//	fileclose(fnum)
//	MESSAGEBOX("확인!","작업이 종료되었습니다.")
//	
//	dw_main.retrieve(ls_year, ls_hakgi)
//		
//end if
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_dip405a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dip405a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

