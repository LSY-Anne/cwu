$PBExportHeader$w_hdr307p.srw
$PBExportComments$[청운대]일일별등록금납입내역
forward
global type w_hdr307p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hdr307p
end type
type dw_con from uo_dwfree within w_hdr307p
end type
end forward

global type w_hdr307p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hdr307p w_hdr307p

on w_hdr307p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hdr307p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string 	ls_year, ls_hakgi, ls_ilja	, ls_bank, ls_gubun, ls_gubun1, ls_gubun2, ls_gubun3, ls_gubun4, ls_text, ls_status
long 		ll_ans

dw_con.AcceptText()

ls_year      = dw_con.Object.year[1]
ls_hakgi     = dw_con.Object.hakgi[1]
ls_ilja        = dw_con.Object.from_dt[1]
ls_bank     = func.of_nvl(dw_con.Object.bank_id[1], '%') + '%'
ls_status    = dw_con.Object.gubun[1]	

if ls_year = '' or isnull(ls_year) or ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","년도, 학기를 입력하세요.")
	return	 -1
end if

if ls_status = '' or isnull(ls_status) then
	ls_gubun  = '1' 
	ls_gubun1 = '2' 
	ls_gubun2 = '3' 
	ls_gubun3 = '4' 
	ls_gubun4 = '5'
	ls_text = '총괄'
elseif ls_status = '1' then
	ls_gubun  = '1' 
	ls_gubun1 = '4' 
	ls_gubun2 = '5' 
	ls_gubun3 = '6' 
	ls_gubun4 = '6'
	ls_text = '재학'	
elseif ls_status = '2' then
	ls_gubun  = '2' 
	ls_gubun1 = '6' 
	ls_gubun2 = '6' 
	ls_gubun3 = '6' 
	ls_gubun4 = '6'
	ls_text = '신입학'	
elseif ls_status = '3' then
	ls_gubun  = '3' 
	ls_gubun1 = '6' 
	ls_gubun2 = '6' 
	ls_gubun3 = '6' 
	ls_gubun4 = '6'
	ls_text	 = '편입학'	
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_ilja, ls_bank, ls_gubun, ls_gubun1, ls_gubun2, ls_gubun3, ls_gubun4)

dw_main.object.t_gubun.text = ls_text

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

dw_con.Object.from_dt[1]   = func.of_get_sdate('YYYYMMDD')

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr307p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr307p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr307p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr307p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr307p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr307p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr307p
end type

type uc_insert from w_condition_window`uc_insert within w_hdr307p
end type

type uc_delete from w_condition_window`uc_delete within w_hdr307p
end type

type uc_save from w_condition_window`uc_save within w_hdr307p
end type

type uc_excel from w_condition_window`uc_excel within w_hdr307p
end type

type uc_print from w_condition_window`uc_print within w_hdr307p
end type

type st_line1 from w_condition_window`st_line1 within w_hdr307p
end type

type st_line2 from w_condition_window`st_line2 within w_hdr307p
end type

type st_line3 from w_condition_window`st_line3 within w_hdr307p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr307p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr307p
end type

type gb_1 from w_condition_window`gb_1 within w_hdr307p
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
end type

type gb_2 from w_condition_window`gb_2 within w_hdr307p
end type

type dw_main from uo_search_dwc within w_hdr307p
integer x = 50
integer y = 300
integer width = 4384
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hdr307p_1"
end type

type dw_con from uo_dwfree within w_hdr307p
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hdr307p_c1"
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
End Choose
end event

