$PBExportHeader$w_dhwdr302q.srw
$PBExportComments$[대학원등록] 대학원 등록내역
forward
global type w_dhwdr302q from w_condition_window
end type
type dw_main from uo_search_dwc within w_dhwdr302q
end type
type dw_con from uo_dwfree within w_dhwdr302q
end type
end forward

global type w_dhwdr302q from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_dhwdr302q w_dhwdr302q

on w_dhwdr302q.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_dhwdr302q.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_start, ls_end, ls_gubun
long ll_ans

dw_con.AcceptText()

ls_year	 =	dw_con.Object.year[1]
ls_hakgi	 =	dw_con.Object.hakgi[1]
ls_start	 =	dw_con.Object.from_dt[1]
ls_end	 =	dw_con.Object.to_dt[1]
ls_gubun  =	dw_con.Object.gubun[1]

if ls_gubun = '1' Then
	dw_main.dataobject = 'd_dhwdr302q_1'	
	dw_main.settransobject(sqlca)
	ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_start, ls_end)
end if

if ls_gubun = '3' Then
	dw_main.dataobject = 'd_dhwdr302q_1_132column'	
	dw_main.settransobject(sqlca)
	ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_start, ls_end)
end if

if ls_gubun = '2' Then
	dw_main.dataobject = 'd_dhwdr302q_2'	
	dw_main.settransobject(sqlca)
	ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_start, ls_end)
end if

if ls_gubun = '4' Then
	dw_main.dataobject = 'd_dhwdr302q_2_132column'	
	dw_main.settransobject(sqlca)	
	ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_start, ls_end)
end if

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

idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate( 'YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate( 'YYYYMMDD')

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi 
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwdr302q
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwdr302q
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwdr302q
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwdr302q
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwdr302q
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwdr302q
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwdr302q
end type

type uc_insert from w_condition_window`uc_insert within w_dhwdr302q
end type

type uc_delete from w_condition_window`uc_delete within w_dhwdr302q
end type

type uc_save from w_condition_window`uc_save within w_dhwdr302q
end type

type uc_excel from w_condition_window`uc_excel within w_dhwdr302q
end type

type uc_print from w_condition_window`uc_print within w_dhwdr302q
end type

type st_line1 from w_condition_window`st_line1 within w_dhwdr302q
end type

type st_line2 from w_condition_window`st_line2 within w_dhwdr302q
end type

type st_line3 from w_condition_window`st_line3 within w_dhwdr302q
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwdr302q
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwdr302q
end type

type gb_1 from w_condition_window`gb_1 within w_dhwdr302q
integer textsize = -9
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
end type

type gb_2 from w_condition_window`gb_2 within w_dhwdr302q
end type

type dw_main from uo_search_dwc within w_dhwdr302q
integer x = 50
integer y = 300
integer width = 4384
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dhwdr302q_1"
end type

type dw_con from uo_dwfree within w_dhwdr302q
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_dhwdr302q_c1"
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
	Case 'gubun'
		If Data = '1' Then
			dw_main.DataObject = 'd_dhwdr302q_1'
			dw_main.SetTransObject(Sqlca)
		ElseIf Data = '2' Then
			dw_main.DataObject = 'd_dhwdr302q_2'
			dw_main.SetTransObject(Sqlca)
		ElseIf Data = '3' Then
			dw_main.DataObject = 'd_dhwdr302q_1_132column'
			dw_main.SetTransObject(Sqlca)
		Else
			dw_main.DataObject = 'd_dhwdr302q_2_132column'
			dw_main.SetTransObject(Sqlca)
		End IF
		
End Choose
end event

