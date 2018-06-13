$PBExportHeader$w_hjk203p.srw
$PBExportComments$[청운대]복학예정자명부출력
forward
global type w_hjk203p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjk203p
end type
type dw_con from uo_dwfree within w_hjk203p
end type
type uo_1 from uo_imgbtn within w_hjk203p
end type
end forward

global type w_hjk203p from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hjk203p w_hjk203p

on w_hjk203p.create
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

on w_hjk203p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1] = func.of_get_sdate('YYYY')
end event

event ue_retrieve;string 	ls_year,		& 
			ls_hakgi,	&
			ls_gwa,		ls_docname,	ls_named,  ls_gubun
integer 	li_ans, 		li_value,	li_chk

dw_con.AcceptText()

ls_year  = dw_con.Object.year[1]
ls_hakgi = dw_con.Object.hakgi[1]
ls_gwa  = func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_gubun = dw_con.Object.gubun[1]
      
if Isnull(ls_year) Or Isnull(ls_hakgi) Then
	Messagebox("확인", "복학예정년도/학기를 입력하세요")
	dw_con.Setfocus()
	dw_con.SetColumn("year")
else
	 
	 IF ls_gubun = '1' Then
		dw_main.dataobject = 'd_hjk203p_1'
		dw_main.settransobject(sqlca)	 
		dw_main.Modify("datawindow.print.preview=yes")
	 	li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa)
	ELSEIF	ls_gubun = '2' Then
		dw_main.dataobject = 'd_hjk203p_3'
		dw_main.settransobject(sqlca)
		dw_main.Modify("datawindow.print.preview=yes")
		li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa)
	ELSEIF	ls_gubun = '3' Then
		dw_main.dataobject = 'd_hjk203p_4'
		dw_main.settransobject(sqlca)
		dw_main.Modify("datawindow.print.preview=yes")
		li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa)		
		
			//저장할 파일명 지정
			li_value = GetFileSaveName("파일선택",	ls_docname, ls_named, "XLS", &
																" EXCLE Files (*.xls), *.xls")
			
			IF li_value = 1 THEN
				li_chk = dw_main.SaveAs(ls_named,TEXT!, FALSE)
				Messagebox('확인','복학예정자 작업을 완료하였습니다.')	
			end if		
	END IF
	 
	 if li_ans < 1 then
		uf_messagebox(7)
		dw_main.reset()
	end if
	
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk203p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk203p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk203p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk203p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk203p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk203p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk203p
end type

type uc_insert from w_condition_window`uc_insert within w_hjk203p
end type

type uc_delete from w_condition_window`uc_delete within w_hjk203p
end type

type uc_save from w_condition_window`uc_save within w_hjk203p
end type

type uc_excel from w_condition_window`uc_excel within w_hjk203p
end type

type uc_print from w_condition_window`uc_print within w_hjk203p
end type

type st_line1 from w_condition_window`st_line1 within w_hjk203p
end type

type st_line2 from w_condition_window`st_line2 within w_hjk203p
end type

type st_line3 from w_condition_window`st_line3 within w_hjk203p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk203p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk203p
end type

type gb_1 from w_condition_window`gb_1 within w_hjk203p
end type

type gb_2 from w_condition_window`gb_2 within w_hjk203p
end type

type dw_main from uo_search_dwc within w_hjk203p
integer x = 55
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjk203p_1"
end type

type dw_con from uo_dwfree within w_hjk203p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_hjk203a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjk203p
integer x = 366
integer y = 40
integer width = 672
integer height = 92
integer taborder = 31
boolean bringtotop = true
string btnname = "복학예정자 주소출력"
end type

event clicked;call super::clicked;string ls_year, ls_hakgi, ls_gwa
DataStore lds_report             //DataStore 선언 

dw_con.AcceptText()

ls_year  = dw_con.Object.year[1]
ls_hakgi = dw_con.Object.hakgi[1]
ls_gwa  = func.of_nvl(dw_con.Object.gwa[1], '%') + '%'

lds_report = Create DataStore    // 메모리에 할당
lds_report.DataObject = "d_hjk203p_2"
lds_report.SetTransObject(sqlca)

lds_report.Retrieve(ls_year, ls_hakgi, ls_gwa)
lds_report.Print()

Destroy lds_report
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

