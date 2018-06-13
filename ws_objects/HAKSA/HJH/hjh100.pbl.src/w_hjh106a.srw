$PBExportHeader$w_hjh106a.srw
$PBExportComments$[청운대]대출학생자료 생성
forward
global type w_hjh106a from w_condition_window
end type
type dw_con from uo_dwfree within w_hjh106a
end type
type uo_1 from uo_imgbtn within w_hjh106a
end type
type dw_main from uo_dwfree within w_hjh106a
end type
end forward

global type w_hjh106a from w_condition_window
dw_con dw_con
uo_1 uo_1
dw_main dw_main
end type
global w_hjh106a w_hjh106a

on w_hjh106a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.uo_1=create uo_1
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_main
end on

on w_hjh106a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.dw_main)
end on

event ue_retrieve;string ls_year, ls_hakgi, ls_date, ls_napip_date//, ls_nabbu_ilja
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_date		=  dw_con.Object.from_dt[1]
ls_napip_date = dw_con.Object.to_dt[1]

if ls_year = '' or Isnull(ls_year) or ls_hakgi = '' or Isnull(ls_hakgi) then
	messagebox("확인","년도, 학기를 입력하세요.")
	return -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_date, ls_napip_date)


if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;//idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate( 'YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate( 'YYYYMMDD')

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjh106a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh106a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh106a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh106a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh106a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh106a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh106a
end type

type uc_insert from w_condition_window`uc_insert within w_hjh106a
end type

type uc_delete from w_condition_window`uc_delete within w_hjh106a
end type

type uc_save from w_condition_window`uc_save within w_hjh106a
end type

type uc_excel from w_condition_window`uc_excel within w_hjh106a
end type

type uc_print from w_condition_window`uc_print within w_hjh106a
end type

type st_line1 from w_condition_window`st_line1 within w_hjh106a
end type

type st_line2 from w_condition_window`st_line2 within w_hjh106a
end type

type st_line3 from w_condition_window`st_line3 within w_hjh106a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh106a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh106a
end type

type gb_1 from w_condition_window`gb_1 within w_hjh106a
integer x = 0
end type

type gb_2 from w_condition_window`gb_2 within w_hjh106a
end type

type dw_con from uo_dwfree within w_hjh106a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_hjh106a_c1"
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
		
		If data = '1' Then
			dw_main.dataobject = 'd_hjh106a'	
			dw_main.settransobject(sqlca)
		ElseIf data = '2' Then
			dw_main.dataobject = 'd_hjh106a_1'	
			dw_main.settransobject(sqlca)
		Else
			dw_main.dataobject = 'd_hjh106a'	
			dw_main.settransobject(sqlca)
		End If
		
End Choose
end event

type uo_1 from uo_imgbtn within w_hjh106a
integer x = 686
integer y = 40
integer width = 457
integer taborder = 50
boolean bringtotop = true
string btnname = "자료생성"
end type

event clicked;call super::clicked;//해당은행별로 만들어진 DataWindow를 조회하여 바로 저장한다.

string 	ls_docname, ls_named, ls_ilja, ls_nabbu_ilja, ls_napip_date
integer 	li_value, li_chk
string  	ls_year, ls_hakgi, ls_gubun
long		ll_row

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_ilja  		=  dw_con.Object.from_dt[1]
ls_napip_date = dw_con.Object.to_dt[1]
ls_gubun     =  dw_con.Object.gubun[1]

if ls_ilja = '00000000' then
	ls_ilja = '%'
end if


if ls_gubun = '1' Then
	dw_main.dataobject = 'd_hjh106a'
	dw_main.settransobject(sqlca)
    ll_row = dw_main.retrieve(ls_year, ls_hakgi,ls_ilja, ls_napip_date)

elseif ls_gubun = '2' Then
	dw_main.dataobject = 'd_hjh106a_1'
	dw_main.settransobject(sqlca)
     ll_row = dw_main.retrieve(ls_year, ls_hakgi, ls_napip_date)

elseif ls_gubun = '3' Then
	dw_main.dataobject = 'd_hjh106a_2'
	dw_main.settransobject(sqlca)
    ll_row = dw_main.retrieve(ls_year, ls_hakgi,ls_ilja, ls_napip_date)
end if	
	
//자료가 존재하지 않으면 Message처리
if ll_row <= 0 then
	Messagebox('확인','File을 생성할 자료가 없습니다.')
	return
end if

//저장할 파일명 지정
li_value = GetFileSaveName("파일선택",	ls_docname, ls_named, "DOC", &
													"Text Files (*.TXT),*.TXT," + &
													"Doc Files (*.DOC), *.DOC,"+ &
													"EXCEL Files (*.XLS), *.XLS,"+ &
													"EXCEL Files (*.CSV), *.CSV")

IF li_value = 1 THEN
	li_chk = dw_main.SaveAs(ls_named,CSV!, FALSE)

		Messagebox('확인','자료 생성을 완료하였습니다.')	
end if		
	


end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hjh106a
integer x = 64
integer y = 292
integer width = 4366
integer height = 1972
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjh106a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

