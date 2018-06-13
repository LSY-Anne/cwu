$PBExportHeader$w_hdr332a.srw
$PBExportComments$[청운대]수납내역
forward
global type w_hdr332a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hdr332a
end type
type dw_con from uo_dwfree within w_hdr332a
end type
end forward

global type w_hdr332a from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hdr332a w_hdr332a

on w_hdr332a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hdr332a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string ls_year, ls_hakgi, ls_gwa, ls_hakbun, ls_hakyun, ls_sangtae, ls_hjmod_date, ls_hname
string ls_bank, ls_start, ls_end
long ll_ans

dw_con.AcceptText()
	
ls_year      = dw_con.Object.year[1]
ls_hakgi     = dw_con.Object.hakgi[1]
ls_gwa      = func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun  = func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_bank      = dw_con.Object.bank_id[1]
ls_start      = dw_con.Object.from_dt[1]
ls_end       = dw_con.Object.to_dt[1]

if ls_year = '' or isnull(ls_year) or ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","년도, 학기를 입력하세요.")
	return	 -1
end if

IF isnull(ls_bank) OR ls_bank = '' THEN
   setnull(ls_bank)
END IF

dw_main.reset()

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakbun, ls_bank, ls_start, ls_end)

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

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr332a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr332a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr332a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr332a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr332a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr332a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr332a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr332a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr332a
end type

type uc_save from w_condition_window`uc_save within w_hdr332a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr332a
end type

type uc_print from w_condition_window`uc_print within w_hdr332a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr332a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr332a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr332a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr332a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr332a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr332a
integer height = 340
end type

type gb_2 from w_condition_window`gb_2 within w_hdr332a
integer y = 316
integer height = 2196
end type

type dw_main from uo_input_dwc within w_hdr332a
integer x = 55
integer y = 384
integer width = 4375
integer height = 1880
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hdr332a"
end type

type dw_con from uo_dwfree within w_hdr332a
integer x = 55
integer y = 168
integer width = 4375
integer height = 204
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hdr332p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;String ls_from_dt, ls_to_dt

Choose Case dwo.name
	Case 'p_from_dt'
		ls_from_dt 	= String(This.Object.from_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'from_dt' , ls_from_dt)
		
		ls_from_dt 	= left(ls_from_dt, 4) + mid(ls_from_dt, 6, 2) + right(ls_from_dt, 2)
		This.SetItem(row, 'from_dt',  ls_from_dt)
		
	Case 'p_to_dt'
		ls_to_dt 	= String(This.Object.to_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'to_dt' , ls_to_dt)
		
		ls_to_dt 	= left(ls_to_dt, 4) + mid(ls_to_dt, 6, 2) + right(ls_to_dt, 2)
		This.SetItem(row, 'to_dt',  ls_to_dt)
End Choose
end event

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gubun1'
		If data = '1' Then
			dw_main.dataobject = 'd_hdr306p_1'	
			dw_main.settransobject(sqlca)
		ElseIf data = '2' Then
			dw_main.dataobject = 'd_hdr306p_1_132column'	
			dw_main.settransobject(sqlca)
		End If
End Choose

	
end event

