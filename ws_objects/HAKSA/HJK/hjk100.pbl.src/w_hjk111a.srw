$PBExportHeader$w_hjk111a.srw
$PBExportComments$[청운대]유학생 주소관리
forward
global type w_hjk111a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjk111a
end type
type dw_con from uo_dwfree within w_hjk111a
end type
type uo_1 from uo_imgbtn within w_hjk111a
end type
end forward

global type w_hjk111a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hjk111a w_hjk111a

on w_hjk111a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
end on

on w_hjk111a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;string ls_gwa, ls_hakbun, ls_hakyun
int li_ans

dw_con.AcceptText()

//조회조건
ls_hakyun	= func.of_nvl(dw_con.Object.hakgi[1], '%')
ls_gwa		= func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun 	= func.of_nvl(dw_con.Object.hakbun[1], '%')

li_ans = dw_main.retrieve(ls_hakbun, ls_gwa, ls_hakyun)	

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
end event

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk111a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk111a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk111a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk111a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk111a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk111a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk111a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk111a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk111a
end type

type uc_save from w_condition_window`uc_save within w_hjk111a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk111a
end type

type uc_print from w_condition_window`uc_print within w_hjk111a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk111a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk111a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk111a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk111a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk111a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk111a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk111a
end type

type dw_main from uo_input_dwc within w_hjk111a
integer x = 55
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk111a_1"
boolean livescroll = false
end type

type dw_con from uo_dwfree within w_hjk111a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
string dataobject = "d_hjk111a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjk111a
integer x = 347
integer y = 36
integer width = 347
integer taborder = 20
boolean bringtotop = true
string btnname = "주소출력"
end type

event dragdrop;call super::dragdrop;string ls_gwa, ls_hakyun, ls_hakbun
DataStore lds_report             //DataStore 선언 

dw_con.AcceptText()

//조회조건
ls_hakyun	= func.of_nvl(dw_con.Object.hakgi[1], '%')
ls_gwa		= func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun 	= func.of_nvl(dw_con.Object.hakbun[1], '%')

lds_report = Create DataStore    // 메모리에 할당
lds_report.DataObject = "d_hjk111a_2"
lds_report.SetTransObject(sqlca)

lds_report.Retrieve(ls_gwa, ls_hakyun, ls_hakbun)
lds_report.Print()

Destroy lds_report
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

