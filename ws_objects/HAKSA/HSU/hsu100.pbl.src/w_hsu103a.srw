$PBExportHeader$w_hsu103a.srw
$PBExportComments$[청운대]개설과목관리
forward
global type w_hsu103a from w_condition_window
end type
type dw_con from uo_dwfree within w_hsu103a
end type
type uo_1 from uo_imgbtn within w_hsu103a
end type
type uo_2 from uo_imgbtn within w_hsu103a
end type
type dw_main from uo_dwfree within w_hsu103a
end type
type dw_print from uo_search_dwc within w_hsu103a
end type
end forward

global type w_hsu103a from w_condition_window
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
dw_main dw_main
dw_print dw_print
end type
global w_hsu103a w_hsu103a

on w_hsu103a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_main=create dw_main
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.dw_main
this.Control[iCurrent+5]=this.dw_print
end on

on w_hsu103a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_main)
destroy(this.dw_print)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakyun, ls_hakgi, ls_ban, ls_gwa
int li_ans

dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_ban        =	func.of_nvl(dw_con.Object.ban[1], '%')

if ls_year = '' or ls_hakgi = '' then
	messagebox("확인","년도, 학기를 입력하세요.")
	return -1
end if

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)

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
idw_print        = dw_print

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

event ue_insert;call super::ue_insert;long		ll_row, ll_getrow
string	ls_year, ls_hakyun, ls_hakgi, ls_gwa, ls_temp = "1"

dw_con.accepttext()
ll_getrow	=	dw_main.getrow()
ll_row		=	dw_main.insertrow(ll_getrow + 1)

ls_year		=	dw_con.Object.year[1]
ls_hakyun	=	dw_con.Object.hakyun[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	dw_con.Object.gwa[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
	
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
	
end if

dw_main.scrolltorow(ll_row)
dw_main.setitem(ll_row, "year",	ls_year)
dw_main.setitem(ll_row, "hakgi",	ls_hakgi)
dw_main.setitem(ll_row, "gwa",	ls_gwa)
dw_main.setitem(ll_row, "hakyun", ls_hakyun)

IF MID(ls_gwa, 4, 1) = '0' or MID(ls_gwa, 4, 1) = '3' THEN
	//호경학부는 BAB0이므로  주야 구분을 1로 대치
	dw_main.setitem(ll_row, "juya_gubun", ls_temp)
ELSE
	dw_main.setitem(ll_row, "juya_gubun", right(ls_gwa, 1))
END IF

dw_main.setitem(ll_row, "pyegang_yn", 'N')

dw_main.setcolumn('gwa')


end event

event ue_delete;call super::ue_delete;long	li_ans

if messagebox("확인","삭제하시겠습니까?", Question!, YesNo!, 2) = 2 then return

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

event ue_printstart;string ls_year, ls_hakyun, ls_hakgi, ls_ban, ls_gwa, ls_gwa_nm

dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_ban        =	func.of_nvl(dw_con.Object.ban[1], '%')
ls_gwa_nm =  dw_con.Describe("Evaluate('lookupdisplay(gwa)',1)")

dw_print.Retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)

If ls_gwa = '%'     Then ls_gwa_nm = '전체' ;
If ls_ban = '%'      Then ls_ban        = '전체' ;
If ls_hakyun = '%' Then ls_hakyun    = '전체' ;

dw_print.Object.t_cond1.text = ls_year
dw_print.Object.t_cond2.text = ls_hakgi
dw_print.Object.t_cond3.text = ls_gwa_nm
dw_print.Object.t_cond4.text = ls_hakyun
dw_print.Object.t_cond5.text = ls_ban

// 출력물 설정
avc_data.SetProperty('title', "출력물")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
avc_data.SetProperty('zoom', '65')

Return 1

end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu103a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu103a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu103a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu103a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu103a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu103a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu103a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu103a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu103a
end type

type uc_save from w_condition_window`uc_save within w_hsu103a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu103a
end type

type uc_print from w_condition_window`uc_print within w_hsu103a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu103a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu103a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu103a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu103a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu103a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu103a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu103a
end type

type dw_con from uo_dwfree within w_hsu103a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hsu103a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hsu103a
boolean visible = false
integer x = 489
integer y = 40
integer taborder = 60
boolean bringtotop = true
string btnname = "출력"
end type

event clicked;call super::clicked;string ls_year, ls_hakyun, ls_hakgi, ls_ban, ls_gwa, ls_gwa_nm


dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_ban        =	func.of_nvl(dw_con.Object.ban[1], '%')
ls_gwa_nm =  dw_con.Describe("Evaluate('lookupdisplay(gwa)',1)")

if messagebox("확인","출력하시겠습니까?", Question!, YesNo!, 2) = 2 then return

DataStore lds_report

lds_report = Create DataStore    // 메모리에 할당
lds_report.DataObject = "d_hsu100a_3_print"
lds_report.SetTransObject(sqlca)

lds_report.Retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)
lds_report.Print()

Destroy lds_report
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hsu103a
integer x = 827
integer y = 40
integer width = 471
integer taborder = 70
boolean bringtotop = true
string btnname = "인원초기화"
end type

event clicked;call super::clicked;long	ll_cnt

for	ll_cnt = 1 to dw_main.rowcount()
	dw_main.setitem(ll_cnt, "inwon", 60)
next
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hsu103a
integer x = 55
integer y = 304
integer width = 4379
integer height = 1960
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_hsu100a_3"
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
		USING SQLCA;
		
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

type dw_print from uo_search_dwc within w_hsu103a
boolean visible = false
integer x = 2551
integer y = 428
integer width = 1778
integer height = 480
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu103a_print"
end type

