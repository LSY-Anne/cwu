$PBExportHeader$w_hjk805a.srw
$PBExportComments$[청운대]병무자료생성
forward
global type w_hjk805a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjk805a
end type
type dw_con from uo_dwfree within w_hjk805a
end type
type uo_1 from uo_imgbtn within w_hjk805a
end type
end forward

global type w_hjk805a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hjk805a w_hjk805a

on w_hjk805a.create
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

on w_hjk805a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;long ll_ans

ll_ans = dw_main.retrieve()

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

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk805a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk805a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk805a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk805a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk805a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk805a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk805a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk805a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk805a
end type

type uc_save from w_condition_window`uc_save within w_hjk805a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk805a
end type

type uc_print from w_condition_window`uc_print within w_hjk805a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk805a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk805a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk805a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk805a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk805a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk805a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk805a
end type

type dw_main from uo_input_dwc within w_hjk805a
integer x = 50
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 10
boolean bringtotop = true
end type

type dw_con from uo_dwfree within w_hjk805a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk805a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjk805a
integer x = 558
integer y = 40
integer width = 544
integer taborder = 40
boolean bringtotop = true
string btnname = "File 자료생성"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;//해당은행별로 만들어진 DataWindow를 조회하여 바로 저장한다.

string ls_docname, ls_named
integer li_value, li_chk

string  ls_napbucheo
long ll_row

dw_con.Accepttext()

ls_napbucheo = dw_con.Object.gubun[1]

//생성처별로 생성
CHOOSE CASE  ls_napbucheo
		
	//병무청
	CASE '1'												
		dw_main.dataobject = 'd_hjk805a_1'		//이거 이름 나중에 맞출것.
		dw_main.SetTransObject(Sqlca)
		
		ll_row = dw_main.retrieve()
		
	//병무청
	CASE '2'											
		dw_main.dataobject = 'd_hjk805a_3'
		dw_main.SetTransObject(Sqlca)
		
		ll_row = dw_main.retrieve()

	//	국민연금관리공단					
	CASE '3'											
		dw_main.dataobject = 'd_hjk805a_2'
		dw_main.SetTransObject(Sqlca)
		
		ll_row = dw_main.retrieve()		

	//병무청
	CASE '4'												
		dw_main.dataobject = 'd_hjk805a_4'		//이거 이름 나중에 맞출것.
		dw_main.SetTransObject(Sqlca)
		
		ll_row = dw_main.retrieve()
		
	//병무청
	CASE '5'											
		dw_main.dataobject = 'd_hjk805a_5'
		dw_main.SetTransObject(Sqlca)
		
		ll_row = dw_main.retrieve()


	//병무청
	CASE '6'												
		dw_main.dataobject = 'd_hjk805a_6'		//이거 이름 나중에 맞출것.
		dw_main.SetTransObject(Sqlca)
		
		ll_row = dw_main.retrieve()
				
	//	국민연금관리공단									
	CASE ELSE
		MESSAGEBOX("확인","생성처를 선택해주세요.")
		RETURN
		
END CHOOSE

//자료가 존재하지 않으면 Message처리
if ll_row <= 0 then
	Messagebox('확인','생성할 자료가 없습니다.')
	return 
end if

//저장할 파일명 지정
li_value = GetFileSaveName("파일선택",	ls_docname, ls_named, "DOC", &
													"Text Files (*.TXT),*.TXT," + &
													" Doc Files (*.DOC), *.DOC")

IF li_value = 1 THEN
	li_chk = dw_main.SaveAs(ls_named,TEXT!, FALSE)
	Messagebox('확인','자료 생성을 완료하였습니다.')	
end if



end event

