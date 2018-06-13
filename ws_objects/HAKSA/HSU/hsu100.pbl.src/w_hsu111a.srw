$PBExportHeader$w_hsu111a.srw
$PBExportComments$[청운대]교과목정리[생성]
forward
global type w_hsu111a from w_no_condition_window
end type
type st_2 from statictext within w_hsu111a
end type
type hpb_1 from hprogressbar within w_hsu111a
end type
type cb_1 from commandbutton within w_hsu111a
end type
type st_9 from statictext within w_hsu111a
end type
type dw_con from uo_dwfree within w_hsu111a
end type
end forward

global type w_hsu111a from w_no_condition_window
st_2 st_2
hpb_1 hpb_1
cb_1 cb_1
st_9 st_9
dw_con dw_con
end type
global w_hsu111a w_hsu111a

on w_hsu111a.create
int iCurrent
call super::create
this.st_2=create st_2
this.hpb_1=create hpb_1
this.cb_1=create cb_1
this.st_9=create st_9
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.hpb_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_9
this.Control[iCurrent+5]=this.dw_con
end on

on w_hsu111a.destroy
call super::destroy
destroy(this.st_2)
destroy(this.hpb_1)
destroy(this.cb_1)
destroy(this.st_9)
destroy(this.dw_con)
end on

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_hsu111a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hsu111a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hsu111a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hsu111a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hsu111a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hsu111a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hsu111a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hsu111a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hsu111a
end type

type uc_save from w_no_condition_window`uc_save within w_hsu111a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hsu111a
end type

type uc_print from w_no_condition_window`uc_print within w_hsu111a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hsu111a
end type

type st_line2 from w_no_condition_window`st_line2 within w_hsu111a
end type

type st_line3 from w_no_condition_window`st_line3 within w_hsu111a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hsu111a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hsu111a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hsu111a
end type

type st_2 from statictext within w_hsu111a
integer x = 55
integer y = 320
integer width = 4379
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 32500968
string text = "교과목정리 [UPDATE]"
alignment alignment = center!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_hsu111a
integer x = 1390
integer y = 908
integer width = 2149
integer height = 92
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type cb_1 from commandbutton within w_hsu111a
integer x = 1925
integer y = 1124
integer width = 718
integer height = 184
integer taborder = 50
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생성"
end type

event clicked;string	befor_gwamok, befor_gwamok_seq, after_gwamok, after_gwamok_seq
integer	li_seq, li_sisu, li_loop
integer	li_return_msg

dw_con.AcceptText()
befor_gwamok 		    =	dw_con.Object.gwamok[1]
befor_gwamok_seq	= 	dw_con.Object.gwamok_seq[1]
after_gwamok			=	dw_con.Object.gwamok1[1]
after_gwamok_seq	=	dw_con.Object.gwamok_seq1[1]

if	befor_gwamok = "" or isnull(befor_gwamok) then
	messagebox("확인","변경할 과목코드를 선택하세요!",Exclamation!,okcancel!,2)
	dw_con.SetFocus()
	dw_con.SetColumn("gwamok")
	return
end if

if after_gwamok = "" or isnull(after_gwamok) then
	messagebox("확인","변경할 과목코드를 선택하세요!",Exclamation!,okcancel!,2)
	dw_con.SetFocus()
	dw_con.SetColumn("gwamok1")
	return
end if

SetPointer(hourglass!)

UPDATE	HAKSA.EVALUATE										//교수평가
SET 		GWAMOK_ID 	= :after_gwamok,
			GWAMOK_SEQ	= :after_gwamok_seq
WHERE		GWAMOK_ID	= :befor_gwamok
AND		GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","교수평가 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.GAESUL_GWAMOK								//개설과목
SET 		GWAMOK_ID 	= :after_gwamok,
			GWAMOK_SEQ	= :after_gwamok_seq
WHERE		GWAMOK_ID	= :befor_gwamok
AND		GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","개설과목 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.GANGPLAN										//강의계획서
SET 		GWAMOK_ID 	= :after_gwamok,
			GWAMOK_SEQ	= :after_gwamok_seq
WHERE		GWAMOK_ID	= :befor_gwamok
AND		GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","강의계획서 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.GANGPLAN_JU									//강의계획서_주별세부계획
SET 		GWAMOK_ID 	= :after_gwamok,
			GWAMOK_SEQ	= :after_gwamok_seq
WHERE		GWAMOK_ID	= :befor_gwamok
AND		GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","강의계획서_주별세부계획 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.GJ_GIBON_GWAMOK							//기본이수과목
SET 		GWAMOK_ID 	= :after_gwamok,
			GWAMOK_SEQ	= :after_gwamok_seq
WHERE		GWAMOK_ID	= :befor_gwamok
AND		GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","기본이수과목 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.GJ_GWAMOK									//교직과목
SET 		GWAMOK_ID 	= :after_gwamok,
			GWAMOK_SEQ	= :after_gwamok_seq
WHERE		GWAMOK_ID	= :befor_gwamok
AND		GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","교직과목 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.GYOGWA_GWAJUNG								//교과과정
SET 		GWAMOK_ID 	= :after_gwamok,
			GWAMOK_SEQ	= :after_gwamok_seq
WHERE		GWAMOK_ID	= :befor_gwamok
AND		GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","교과과정 TABLE UPDATE시에 에러났습니다.")
	return
end if


DELETE FROM	HAKSA.GWAMOK_CODE								//교과목코드
WHERE		GWAMOK_ID	= :befor_gwamok
AND		GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","교과목코드 TABLE DELETE시에 에러났습니다.")
	return
end if


UPDATE	HAKSA.JOLUP_SUGANG								//수강(졸업)
SET 		GWAMOK_ID 			= :after_gwamok,
			GWAMOK_SEQ			= :after_gwamok_seq
WHERE		GWAMOK_ID			= :befor_gwamok
AND		GWAMOK_SEQ			= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","수강(졸업) TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.JOLUP_SUGANG								//수강(졸업-재수강)
SET 		JESU_GWAMOK_ID 	= :after_gwamok,
			JESU_GWAMOK_SEQ	= :after_gwamok_seq
WHERE		JESU_GWAMOK_ID		= :befor_gwamok
AND		JESU_GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","수강(졸업-재수강) TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.SIGANPYO										//시간표
SET 		GWAMOK_ID 	= :after_gwamok,
			GWAMOK_SEQ	= :after_gwamok_seq
WHERE		GWAMOK_ID	= :befor_gwamok
AND		GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","시간표 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.SIGANPYO_SEASON							//계절학기 시간표
SET 		GWAMOK_ID 	= :after_gwamok,
			GWAMOK_SEQ	= :after_gwamok_seq
WHERE		GWAMOK_ID	= :befor_gwamok
AND		GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","계절학기 시간표 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.SUGANG										//수강
SET 		GWAMOK_ID 			= :after_gwamok,
			GWAMOK_SEQ			= :after_gwamok_seq
WHERE		GWAMOK_ID			= :befor_gwamok
AND		GWAMOK_SEQ			= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","수강 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.SUGANG										//수강-재수강
SET 		JESU_GWAMOK_ID 	= :after_gwamok,
			JESU_GWAMOK_SEQ	= :after_gwamok_seq
WHERE		JESU_GWAMOK_ID		= :befor_gwamok
AND		JESU_GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","수강-재수강 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.SUGANG_HIS									//수강트랜스_history
SET 		GWAMOK_ID 			= :after_gwamok,
			GWAMOK_SEQ			= :after_gwamok_seq
WHERE		GWAMOK_ID			= :befor_gwamok
AND		GWAMOK_SEQ			= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","수강트랜스_history TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.SUGANG_TRANS								//수강트랜스
SET 		GWAMOK_ID 			= :after_gwamok,
			GWAMOK_SEQ			= :after_gwamok_seq
WHERE		GWAMOK_ID			= :befor_gwamok
AND		GWAMOK_SEQ			= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","수강트랜스 TABLE UPDATE시에 에러났습니다.")
	return
end if

UPDATE	HAKSA.SUGANG_TRANS								//수강트랜스-재수강
SET 		JESU_GWAMOK_ID 	= :after_gwamok,
			JESU_GWAMOK_SEQ	= :after_gwamok_seq
WHERE		JESU_GWAMOK_ID		= :befor_gwamok
AND		JESU_GWAMOK_SEQ	= :befor_gwamok_seq
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	rollback USING SQLCA ;
	MESSAGEBOX("확인","수강트랜스-재수강 TABLE UPDATE시에 에러났습니다.")
	return
end if

COMMIT USING SQLCA ;
MESSAGEBOX("확인","작업이 완료되었습니다.")



end event

type st_9 from statictext within w_hsu111a
integer x = 1102
integer y = 928
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "처리경과"
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hsu111a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsu111a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

