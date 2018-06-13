$PBExportHeader$w_dhwdr203a.srw
$PBExportComments$[대학원등록] 은행자료생성
forward
global type w_dhwdr203a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwdr203a
end type
type dw_con from uo_dwfree within w_dhwdr203a
end type
type uo_1 from uo_imgbtn within w_dhwdr203a
end type
end forward

global type w_dhwdr203a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_dhwdr203a w_dhwdr203a

on w_dhwdr203a.create
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

on w_dhwdr203a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi)

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

//idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi 
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwdr203a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwdr203a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwdr203a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwdr203a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwdr203a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwdr203a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwdr203a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwdr203a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwdr203a
end type

type uc_save from w_condition_window`uc_save within w_dhwdr203a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwdr203a
end type

type uc_print from w_condition_window`uc_print within w_dhwdr203a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwdr203a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwdr203a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwdr203a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwdr203a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwdr203a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwdr203a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwdr203a
end type

type dw_main from uo_input_dwc within w_dhwdr203a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 10
boolean bringtotop = true
end type

type dw_con from uo_dwfree within w_dhwdr203a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_dhwdr203a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_dhwdr203a
integer x = 489
integer y = 40
integer width = 475
integer taborder = 20
boolean bringtotop = true
string btnname = "은행자료생성"
end type

event clicked;call super::clicked;//은행 파일 맹글기...(예치금만)
//해당은행별로 만들어진 DataWindow를 조회하여 바로 저장한다.

string ls_docname, ls_named
integer li_value, li_chk

string  ls_sunapcheo, ls_year, ls_hakgi
long ll_row

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_sunapcheo = dw_con.Object.bank_id[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

//수납처별로 생성
CHOOSE CASE  ls_sunapcheo
	CASE '2'												//	우리은행
		dw_main.dataobject = 'd_dhwdr203q_w'		//이거 이름 나중에 맞출것.
		dw_main.SetTransObject(Sqlca)
		
		ll_row = dw_main.retrieve(ls_year, ls_hakgi)
				
	CASE '3'												//	국민은행
		dw_main.dataobject = 'd_dhwdr203q_k'
		dw_main.SetTransObject(Sqlca)
		
		ll_row = dw_main.retrieve(ls_year, ls_hakgi)
				
	CASE ELSE
		MESSAGEBOX("은행확인","은행을 선택해주세요.")
		RETURN
		
END CHOOSE

//자료가 존재하지 않으면 Message처리
if ll_row <= 0 then
	Messagebox('확인','은행File을 생성할 자료가 없습니다.')
	return
end if

//저장할 파일명 지정
li_value = GetFileSaveName("파일선택",	ls_docname, ls_named, "DOC", &
													"Text Files (*.TXT),*.TXT," + &
													" Doc Files (*.DOC), *.DOC")

IF li_value = 1 THEN
	li_chk = dw_main.SaveAs(ls_named,TEXT!, FALSE)
	Messagebox('확인','등록금 은행자료 생성을 완료하였습니다.')
end if

end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

