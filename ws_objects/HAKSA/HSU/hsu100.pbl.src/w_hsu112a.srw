$PBExportHeader$w_hsu112a.srw
$PBExportComments$[청운대]개설과목관리_조교용
forward
global type w_hsu112a from w_condition_window
end type
type dw_con from uo_dwfree within w_hsu112a
end type
type dw_main from uo_dwfree within w_hsu112a
end type
end forward

global type w_hsu112a from w_condition_window
dw_con dw_con
dw_main dw_main
end type
global w_hsu112a w_hsu112a

on w_hsu112a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hsu112a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakyun, ls_hakgi, ls_ban, ls_gwa
int li_ans

dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
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

IF (mid(gs_deptcode, 1, 1) = 'A' or	&
	mid(gs_deptcode, 1, 1) = 'B' or	&
	mid(gs_deptcode, 1, 1) = 'C') THEN 

	IF mid(ls_gwa, 1, 3) = mid(gs_deptcode, 1, 3) THEN
		li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)
	ELSE
		MESSAGEBOX('확인', '타과학생은 조회가 불가능하며 권한이 없습니다.')
		return 1
	END IF
ELSE	
		li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)
END IF 


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

type ln_templeft from w_condition_window`ln_templeft within w_hsu112a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu112a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu112a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu112a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu112a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu112a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu112a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu112a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu112a
end type

type uc_save from w_condition_window`uc_save within w_hsu112a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu112a
end type

type uc_print from w_condition_window`uc_print within w_hsu112a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu112a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu112a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu112a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu112a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu112a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu112a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu112a
end type

type dw_con from uo_dwfree within w_hsu112a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_hsu105a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hsu112a
integer x = 55
integer y = 300
integer width = 4379
integer height = 1960
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hsu112a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;integer	li_hakjum, li_iron, li_silgi, li_temp1, li_temp2, li_ans
string	ls_isu, ls_pass, ls_gwamok_gubun
string	ls_year, ls_hakgi, ls_hakgwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban, ls_member
integer	li_gwamok_seq

this.AcceptText()

CHOOSE CASE	DWO.NAME
	CASE	'gwamok'
		this.object.gwamok_id[row]		  =	left(data, 7)
		this.object.gwamok_seq[row]	  =	integer(mid(data, 8, 2))
		this.object.tmt_gwamok_id[row]  =	left(data, 7)
		this.object.tmt_gwamok_seq[row] =	integer(mid(data, 8, 2))
		This.object.tmt_gwamok[row]     =   data
		
		SELECT	ISU_GUBUN,
					HAKJUM,
					IRON_SISU,
					SILGI_SISU,
					GWAMOK_GUBUN,
					PASS_GUBUN
		INTO	:ls_isu,
				:li_hakjum,
				:li_iron,
				:li_silgi,
				:ls_gwamok_gubun,
				:ls_pass
		FROM	HAKSA.GWAMOK_CODE
		WHERE	GWAMOK_ID||GWAMOK_SEQ	=	:data
		USING SQLCA ;
		
		if isnull(li_iron) then 
			li_temp1 = 0
		else
			li_temp1 = li_iron
		end if
		
		if isnull(li_silgi) then 
			li_temp2 = 0
		else
			li_temp2 = li_silgi
		end if
		
		this.object.isu_id[row]			= ls_isu
		this.object.hakjum[row]			= li_hakjum
		this.object.sisu_iron[row]		= li_iron
		this.object.sisu_silsub[row]	= li_silgi
		this.object.sisu[row] 			= li_temp1 + li_temp2
		this.object.pass_gubun[row]	= ls_pass
	CASE	'tmt_gwamok'
		this.object.tmt_gwamok_id[row]		=	left(data, 7)
		this.object.tmt_gwamok_seq[row]	=	integer(mid(data, 8, 2))
	CASE	'sisu_iron', 'sisu_silsub'
		li_iron	= this.object.sisu_iron[row]
		li_silgi	= this.object.sisu_silsub[row]
		
		if isnull(li_iron) then li_iron = 0
		if isnull(li_silgi) then li_silgi = 0
		
		this.object.sisu[row] = li_iron + li_silgi
		
	CASE	'ban_bunhap'
		IF isnull(data) OR data  = '' THEN
			this.object.is_gubun[row] = ''
		END IF
	CASE	'gwa'
		this.object.juya_gubun[row] = right(data, 1)
		
END CHOOSE
		
end event

event constructor;call super::constructor;This.settransobject(sqlca)
end event

