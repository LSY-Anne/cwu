$PBExportHeader$w_hsu110a_p2.srw
$PBExportComments$[청운대]강의계획서 -  전년도내용
forward
global type w_hsu110a_p2 from w_popup
end type
type st_2 from statictext within w_hsu110a_p2
end type
type st_1 from statictext within w_hsu110a_p2
end type
type ddlb_1 from uo_ddlb_hakgi within w_hsu110a_p2
end type
type em_1 from uo_em_year within w_hsu110a_p2
end type
type dw_1 from uo_input_dwc within w_hsu110a_p2
end type
type uo_1 from uo_imgbtn within w_hsu110a_p2
end type
type dw_2 from uo_dwfree within w_hsu110a_p2
end type
end forward

global type w_hsu110a_p2 from w_popup
integer width = 3579
integer height = 1892
string title = "강의계획서 -  전년도내용"
st_2 st_2
st_1 st_1
ddlb_1 ddlb_1
em_1 em_1
dw_1 dw_1
uo_1 uo_1
dw_2 dw_2
end type
global w_hsu110a_p2 w_hsu110a_p2

type variables
string	is_year,	is_hakgi,	is_gwa,	is_hakyun,	is_ban,	is_gwamok,	is_bunban, is_prof
integer	ii_gwamok_seq
end variables

on w_hsu110a_p2.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.em_1=create em_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddlb_1
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.dw_2
end on

on w_hsu110a_p2.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.em_1)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.dw_2)
end on

event open;call super::open;string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban
integer	li_gwamok_seq

str_parms s_parms

s_parms = Message.PowerObjectParm

is_year			=	s_parms.s[1]
is_hakgi			=	s_parms.s[2]
is_gwa			=	s_parms.s[3]
is_hakyun		=	s_parms.s[4]
is_ban			=	s_parms.s[5]
is_gwamok		=	s_parms.s[6]
is_bunban		=	s_parms.s[7]
ii_gwamok_seq	=	s_parms.l[1]

is_prof		=	s_parms.s[8] + '%'

dw_1.retrieve(is_year, is_hakgi, is_prof)
end event

event ue_inquiry;call super::ue_inquiry;string	ls_year, ls_hakgi
integer	li_ans

ls_year	=	em_1.text
ls_hakgi	=	ddlb_1.text

li_ans	=	dw_1.retrieve(ls_year, ls_hakgi, is_prof)

if li_ans <= 0 then
	messagebox("확인","자료가 존재하지 않습니다.")
end if

Return 1
end event

type p_msg from w_popup`p_msg within w_hsu110a_p2
integer y = 1708
end type

type st_msg from w_popup`st_msg within w_hsu110a_p2
integer y = 1708
end type

type uc_printpreview from w_popup`uc_printpreview within w_hsu110a_p2
end type

type uc_cancel from w_popup`uc_cancel within w_hsu110a_p2
end type

type uc_ok from w_popup`uc_ok within w_hsu110a_p2
end type

type uc_excelroad from w_popup`uc_excelroad within w_hsu110a_p2
end type

type uc_excel from w_popup`uc_excel within w_hsu110a_p2
end type

type uc_save from w_popup`uc_save within w_hsu110a_p2
end type

type uc_delete from w_popup`uc_delete within w_hsu110a_p2
end type

type uc_insert from w_popup`uc_insert within w_hsu110a_p2
end type

type uc_retrieve from w_popup`uc_retrieve within w_hsu110a_p2
end type

type ln_temptop from w_popup`ln_temptop within w_hsu110a_p2
end type

type ln_1 from w_popup`ln_1 within w_hsu110a_p2
integer beginy = 1768
integer endy = 1768
end type

type ln_2 from w_popup`ln_2 within w_hsu110a_p2
integer endy = 1812
end type

type ln_3 from w_popup`ln_3 within w_hsu110a_p2
integer endy = 1812
end type

type r_backline1 from w_popup`r_backline1 within w_hsu110a_p2
end type

type r_backline2 from w_popup`r_backline2 within w_hsu110a_p2
end type

type r_backline3 from w_popup`r_backline3 within w_hsu110a_p2
end type

type uc_print from w_popup`uc_print within w_hsu110a_p2
end type

type st_2 from statictext within w_hsu110a_p2
integer x = 786
integer y = 56
integer width = 146
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_hsu110a_p2
integer x = 210
integer y = 56
integer width = 146
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from uo_ddlb_hakgi within w_hsu110a_p2
integer x = 951
integer y = 44
integer taborder = 10
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type em_1 from uo_em_year within w_hsu110a_p2
integer x = 370
integer y = 44
integer width = 242
integer taborder = 10
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_1 from uo_input_dwc within w_hsu110a_p2
integer x = 50
integer y = 176
integer width = 3410
integer height = 512
integer taborder = 20
string dataobject = "d_hsu110a_p2_1"
boolean hscrollbar = false
end type

event clicked;call super::clicked;long		ll_mod
integer	li_ans, li_gwamok_seq
string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban 

if row <= 0 then return 

//다른 부분을 조회하기 전에 변경된 자료가 있으면 저장한다.

this.AcceptText()

ls_year				=	this.object.year[row]
ls_hakgi				=	this.object.hakgi[row]
ls_gwa				=	this.object.gwa[row]
ls_hakyun			=	this.object.hakyun[row]
ls_ban				=	this.object.ban[row]
ls_gwamok			=	this.object.gwamok_id[row]
li_gwamok_seq		=	this.object.gwamok_seq[row]
ls_bunban			=	this.object.bunban[row]
		
li_ans = dw_2.retrieve(ls_year,	ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, li_gwamok_seq, ls_bunban)
end event

type uo_1 from uo_imgbtn within w_hsu110a_p2
integer x = 1321
integer y = 44
integer taborder = 30
boolean bringtotop = true
string btnname = "복사"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban, ls_pyung
integer	li_gwamok_seq, li_row


li_row = dw_1.getrow()

ls_year				=	dw_1.object.year[li_row]
ls_hakgi				=	dw_1.object.hakgi[li_row]
ls_gwa				=	dw_1.object.gwa[li_row]
ls_hakyun			=	dw_1.object.hakyun[li_row]
ls_ban				=	dw_1.object.ban[li_row]
ls_gwamok			=	dw_1.object.gwamok_id[li_row]
li_gwamok_seq		=	dw_1.object.gwamok_seq[li_row]
ls_bunban			=	dw_1.object.bunban[li_row]

//DELETE하고 INSERT함.
DELETE	FROM HAKSA.GANGPLAN
WHERE	YEAR			=	:is_year
AND	HAKGI			=	:is_hakgi
AND	GWA			=	:is_gwa
AND	HAKYUN		=	:is_hakyun		
AND	BAN			=	:is_ban
AND	GWAMOK_ID	=	:is_gwamok
AND	GWAMOK_SEQ	=	:ii_gwamok_seq
AND	BUNBAN		=	:is_bunban
USING SQLCA ;

IF SQLCA.SQLCODE <> 0 THEN

	MESSAGEBOX("오류","복사중 오류가 발생되었습니다.(GANGPLAN삭제)~r~n" + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA ;
	RETURN
	
END IF

DELETE	FROM HAKSA.GANGPLAN_JU
WHERE	YEAR			=	:is_year
AND	HAKGI			=	:is_hakgi
AND	GWA			=	:is_gwa
AND	HAKYUN		=	:is_hakyun	
AND	BAN			=	:is_ban
AND	GWAMOK_ID	=	:is_gwamok
AND	GWAMOK_SEQ	=	:ii_gwamok_seq
AND	BUNBAN		=	:is_bunban
USING SQLCA ;

IF SQLCA.SQLCODE <> 0 THEN

	MESSAGEBOX("오류","복사중 오류가 발생되었습니다.(GANGPLAN_JU삭제)~r~n" + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA ;
	RETURN
	
END IF


INSERT	INTO HAKSA.GANGPLAN
(	SELECT	:is_year,
				:is_hakgi,
				:is_gwa,
				:is_hakyun,
				:is_ban,
				:is_gwamok,
				:ii_gwamok_seq,
				:is_bunban,
				TEL,
				MOKJUK,
				MOKPYO,
				GANG_HYUNG,
				SU_1,
				SU_2,
				SU_3,
				SU_4,
				SU_5,
				SU_6,
				SU_7,
				SU_8,
				SU_9,
				SU_10,
				SU_11,
				SU_12,
				GIJAJAE_1,
				GIJAJAE_2,
				GIJAJAE_3,
				GIJAJAE_4,
				GIJAJAE_5,
				GIJAJAE_6,
				GIJAJAE_7,
				GIJAJAE_8,
				PYUNGGA_GUBUN,
				JU_AUTHOR,
				JU_YEAR,
				JU_COMPANY,
				JU_TITLE,
				BU_AUTHOR,
				BU_YEAR,
				BU_COMPANY,
				BU_TITLE,
				CHAM1_AUTHOR,
				CHAM1_YEAR,
				CHAM1_COMPANY,
				CHAM1_TITLE,
				CHAM2_AUTHOR,
				CHAM2_YEAR,
				CHAM2_COMPANY,
				CHAM2_TITLE,
				CHAM3_AUTHOR,
				CHAM3_YEAR,
				CHAM3_COMPANY,
				CHAM3_TITLE,
				:gs_empcode,
				:gs_ip,
				SYSDATE,
				JOB_UID,
				JOB_ADD,
				JOB_DATE
	FROM	HAKSA.GANGPLAN
	WHERE	YEAR			=	:ls_year
	AND	HAKGI			=	:ls_hakgi
	AND	GWA			=	:ls_gwa
	AND	HAKYUN		=	:ls_hakyun		
	AND	BAN			=	:ls_ban
	AND	GWAMOK_ID	=	:ls_gwamok
	AND	GWAMOK_SEQ	=	:li_gwamok_seq
	AND	BUNBAN		=	:ls_bunban
)	USING SQLCA ;

IF SQLCA.SQLCODE <> 0 THEN

	MESSAGEBOX("오류","복사중 오류가 발생되었습니다.(GANGPLAN입력)~r~n" + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA ;
	RETURN
	
END IF

INSERT	INTO HAKSA.GANGPLAN_JU
(	SELECT	:is_year,
				:is_hakgi,
				:is_gwa,
				:is_hakyun,
				:is_ban,
				:is_gwamok,
				:ii_gwamok_seq,
				:is_bunban,
				JU,	
				NAEYONG,
				BANG,
				JARYO,
				GWAJAE,
				:gs_empcode,
				:gs_ip,
				SYSDATE,
				JOB_UID,
				JOB_ADD,
				JOB_DATE
	FROM	HAKSA.GANGPLAN_JU
	WHERE	YEAR			=	:ls_year
	AND	HAKGI			=	:ls_hakgi
	AND	GWA			=	:ls_gwa
	AND	HAKYUN		=	:ls_hakyun
	AND	BAN			=	:ls_ban
	AND	GWAMOK_ID	=	:ls_gwamok
	AND	GWAMOK_SEQ	=	:li_gwamok_seq
	AND	BUNBAN		=	:ls_bunban
)	USING SQLCA ;

IF SQLCA.SQLCODE <> 0 THEN

	MESSAGEBOX("오류","복사중 오류가 발생되었습니다.(GANGPLAN_JU입력)~r~n" + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA ;
	
ELSE
	COMMIT USING SQLCA ;
//	CLOSE(PARENT)
END IF

//개설과목의 강의평가를 update한다.
ls_pyung	=	dw_2.object.pyungga_gubun[1]

UPDATE	HAKSA.GAESUL_GWAMOK
SET	PYUNGGA_GUBUN	=	:ls_pyung
WHERE	YEAR			=	:is_year
AND	HAKGI			=	:is_hakgi
AND	GWA			=	:is_gwa
AND	HAKYUN		=	:is_hakyun
AND	BAN			=	:is_ban
AND	GWAMOK_ID	=	:is_gwamok
AND	GWAMOK_SEQ	=	:ii_gwamok_seq
AND	BUNBAN		=	:is_bunban
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	COMMIT USING SQLCA ;
	CLOSE(PARENT)
	
ELSE
	MESSAGEBOX("오류","저장중 오류가 발생되었습니다.(Gaesul_Gwamok)" + sqlca.sqlerrtext)
	ROLLBACK USING SQLCA ;
END IF
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_2 from uo_dwfree within w_hsu110a_p2
integer x = 50
integer y = 708
integer width = 3410
integer height = 976
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hsu110a_p2_2"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)

func.of_design_dw(dw_2)
end event

