$PBExportHeader$w_hjh104a.srw
$PBExportComments$[청운대]대출학생관리
forward
global type w_hjh104a from w_condition_window
end type
type dw_con from uo_dwfree within w_hjh104a
end type
type dw_main from uo_dwfree within w_hjh104a
end type
end forward

global type w_hjh104a from w_condition_window
integer height = 2408
dw_con dw_con
dw_main dw_main
end type
global w_hjh104a w_hjh104a

on w_hjh104a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hjh104a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_hakbun
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun   =  func.of_nvl(dw_con.Object.hakbun[1], '%')

if ls_year = '' or ls_hakgi ='' or isnull(ls_year) or isnull(ls_hakgi) then
	messagebox( '확인', "년도와 학기를  입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1


end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
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

event ue_insert;call super::ue_insert;string ls_year, ls_hakgi
long ll_line, ll_row = 0, li_dungrok

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year = '' or ls_hakgi ='' or isnull(ls_year) or isnull(ls_hakgi) then
	messagebox( '확인', "학년도와 학기를 반드시 입력하세요.")
	return
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_row = dw_main.getrow()

ll_line = dw_main.insertrow(ll_row + 1)
dw_main.scrolltorow(ll_line)

dw_main.object.daichul_gwanri_year[ll_line]			=	ls_year
dw_main.object.daichul_gwanri_hakgi[ll_line]			=	ls_hakgi
dw_main.object.daichul_gwanri_sunbal_date[ll_line]	=	string(f_sysdate(), 'YYYYMMDD')

//dw_main.object.daichul_gwanri_bank_id[ll_line]		=	'1'

dw_main.SetColumn('daichul_gwanri_gubun')
dw_main.setfocus()



end event

event ue_delete;call super::ue_delete;int li_ans, li_chasu

//li_chasu	=	dw_main.object.di_dungrok_chasu[dw_main.getrow()]
//
//if li_chasu > 1 then
//	messagebox("오류","차수가 1인 자료는 삭제할 수 없습니다.")
//	return
//end if

//삭제확인
//if uf_messagebox(4) = 2 then return

dw_main.deleterow(0)
li_ans = dw_main.update()								

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback USING SQLCA;
else	
	commit USING SQLCA;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjh104a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh104a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh104a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh104a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh104a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh104a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh104a
end type

type uc_insert from w_condition_window`uc_insert within w_hjh104a
end type

type uc_delete from w_condition_window`uc_delete within w_hjh104a
end type

type uc_save from w_condition_window`uc_save within w_hjh104a
end type

type uc_excel from w_condition_window`uc_excel within w_hjh104a
end type

type uc_print from w_condition_window`uc_print within w_hjh104a
end type

type st_line1 from w_condition_window`st_line1 within w_hjh104a
end type

type st_line2 from w_condition_window`st_line2 within w_hjh104a
end type

type st_line3 from w_condition_window`st_line3 within w_hjh104a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh104a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh104a
end type

type gb_1 from w_condition_window`gb_1 within w_hjh104a
end type

type gb_2 from w_condition_window`gb_2 within w_hjh104a
end type

type dw_con from uo_dwfree within w_hjh104a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_hjh104a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hjh104a
integer x = 50
integer y = 304
integer width = 4379
integer height = 1960
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjh104a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string 	ls_year, ls_hakgi, ls_hakbun, ls_gwa, ls_su_hakyun, ls_name, ls_jumin_no
long 		li_dungrok

if dwo.name = 'daichul_gwanri_hakbun' then
	
	ls_year		=	this.object.daichul_gwanri_year[row]
	ls_hakgi		=	this.object.daichul_gwanri_hakgi[row]
	//ls_hakbun	=	this.object.daichul_gwanri_hakbun[row]
	ls_hakbun	=	data

//	this.AcceptText()
	
	SELECT	A.DUNGROK,
				B.GWA,
				A.SU_HAKYUN,
				B.HNAME,
				B.JUMIN_NO
	INTO		:li_dungrok,
				:ls_gwa,
				:ls_su_hakyun,
				:ls_name,
				:ls_jumin_no
	FROM 		HAKSA.DUNGROK_GWANRI A,
				HAKSA.JAEHAK_HAKJUK	B
	WHERE		A.HAKBUN	=	B.HAKBUN
	AND		A.YEAR	=	:ls_year
	AND		A.HAKGI	=	:ls_hakgi
	AND		A.HAKBUN	=	:ls_hakbun
	USING SQLCA ;
	
	this.object.daichul_gwanri_gitagum[row]	= li_dungrok
	this.object.daichul_gwanri_gwa[row]			= ls_gwa
	this.object.daichul_gwanri_hakyun[row]		= ls_su_hakyun
	this.object.daichul_gwanri_hname[row]		= ls_name
	this.object.daichul_gwanri_jumin_no[row]	= ls_jumin_no	
	

//	this.AcceptText()

//	ls_hakbun	=	this.object.daichul_gwanri_hakbun[row]

end if
		

end event

event itemerror;call super::itemerror;return 2
end event

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

