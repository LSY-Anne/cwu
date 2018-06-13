$PBExportHeader$w_hsu307a.srw
$PBExportComments$[청운대]학사경고 유예자 관리
forward
global type w_hsu307a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hsu307a
end type
type dw_con from uo_dwfree within w_hsu307a
end type
type st_4 from statictext within w_hsu307a
end type
end forward

global type w_hsu307a from w_condition_window
integer width = 4503
dw_main dw_main
dw_con dw_con
st_4 st_4
end type
global w_hsu307a w_hsu307a

type variables
long 		il_row, il_seq_no
string 	is_year, is_hakgi, is_gwa,	is_jungong_id, is_hakyun, is_ban, is_juya
string	is_gwamok2, is_member_no,  is_hosil, is_yoil, is_sigan, is_ban_bunhap
string	is_chk, is_gwamok

end variables

on w_hsu307a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.st_4
end on

on w_hsu307a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.st_4)
end on

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

event ue_retrieve;call super::ue_retrieve;string	ls_year, ls_hakgi, ls_hakbun
long		li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  dw_con.Object.hakbun[1]

if	ls_hakbun = "" or isnull(ls_hakbun) then
	uf_messagebox(15)
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return -1
end if

li_ans	=	dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return -1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return -1
else
	dw_main.setfocus()
end if

Return 1
end event

event ue_savestart;call super::ue_savestart;int li_ans
integer rc
long NbrRows, row = 0
string ls_year, ls_hakgi, ls_hakbun, ls_gyunggo_yn

dw_main.AcceptText()

NbrRows = dw_main.RowCount()

//변경된 자료를 찾아서 경고 횟수를 update한다.
DO WHILE row <= NbrRows
		row = dw_main.GetNextModified(row, Primary!)
		
		IF row > 0 THEN
			ls_year		=	dw_main.object.year[row]
			ls_hakgi		=	dw_main.object.hakgi[row]
			ls_hakbun	=	dw_main.object.sungjukgye_hakbun[row]
			
			ls_gyunggo_yn = dw_main.object.sungjukgye_gyunggo_yn[row]
			
			//학사 경고이면 경고횟수 +1, 유예가 되면 -1
			if ls_gyunggo_yn = '1' then
				
				//최종년도, 학기의 성적계에서 연속 경고 횟수를 변경시킨다.
				UPDATE HAKSA.SUNGJUKGYE
				SET	GYUNGGO_CNT = GYUNGGO_CNT + 1
				WHERE	HAKBUN	=	:ls_hakbun
				AND	YEAR||HAKGI	=	(	SELECT MAX(YEAR||HAKGI)
												FROM	HAKSA.SUNGJUKGYE
												WHERE	HAKBUN	=	:ls_hakbun
												AND	HAKGI IN ('1', '2')	)
				USING SQLCA ;
				
				
			elseif ls_gyunggo_yn = '2' then

				UPDATE HAKSA.SUNGJUKGYE
				SET	GYUNGGO_CNT = GYUNGGO_CNT - 1
				WHERE	HAKBUN	=	:ls_hakbun
				AND	YEAR||HAKGI	=	(	SELECT MAX(YEAR||HAKGI)
												FROM	HAKSA.SUNGJUKGYE
												WHERE	HAKBUN	=	:ls_hakbun
												AND	HAKGI IN ('1', '2')	)
				USING SQLCA ;
								
			end if
			
			if sqlca.sqlcode <> 0 then
				messagebox("오류","연속경고횟수 수정중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return -1
			end if
			
		ELSE
			row = NbrRows + 1
		END IF
LOOP

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu307a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu307a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu307a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu307a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu307a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu307a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu307a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu307a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu307a
end type

type uc_save from w_condition_window`uc_save within w_hsu307a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu307a
end type

type uc_print from w_condition_window`uc_print within w_hsu307a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu307a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu307a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu307a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu307a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu307a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu307a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu307a
integer taborder = 90
end type

type dw_main from uo_input_dwc within w_hsu307a
integer x = 59
integer y = 300
integer width = 4370
integer height = 1964
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_hsu300a_7"
end type

type dw_con from uo_dwfree within w_hsu307a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hsu303a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_4 from statictext within w_hsu307a
integer x = 128
integer y = 52
integer width = 1550
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "※유예자 처리는 최종년도, 학기 자료만 수정하세요"
boolean focusrectangle = false
end type

