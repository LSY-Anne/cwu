$PBExportHeader$w_hdr201a.srw
$PBExportComments$[청운대]은행자료생성
forward
global type w_hdr201a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hdr201a
end type
type dw_con from uo_dwfree within w_hdr201a
end type
type uo_1 from uo_imgbtn within w_hdr201a
end type
end forward

global type w_hdr201a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hdr201a w_hdr201a

on w_hdr201a.create
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

on w_hdr201a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;string ls_year, ls_hakgi, ls_date
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_date		=  dw_con.Object.from_dt[1]

if ls_year = '' or Isnull(ls_year) or ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","년도, 학기를 입력하세요.")
	return -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_date)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1

end event

event open;call super::open;//idw_update[1] = dw_main

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

type ln_templeft from w_condition_window`ln_templeft within w_hdr201a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr201a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr201a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr201a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr201a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr201a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr201a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr201a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr201a
end type

type uc_save from w_condition_window`uc_save within w_hdr201a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr201a
end type

type uc_print from w_condition_window`uc_print within w_hdr201a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr201a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr201a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr201a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr201a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr201a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr201a
integer x = 0
end type

type gb_2 from w_condition_window`gb_2 within w_hdr201a
end type

type dw_main from uo_input_dwc within w_hdr201a
integer x = 55
integer y = 340
integer width = 4379
integer height = 1916
integer taborder = 10
boolean bringtotop = true
end type

type dw_con from uo_dwfree within w_hdr201a
integer x = 55
integer y = 168
integer width = 4379
integer height = 148
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hdr201a_c1"
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

type uo_1 from uo_imgbtn within w_hdr201a
integer x = 709
integer y = 40
integer width = 457
integer taborder = 40
boolean bringtotop = true
string btnname = "은행자료생성"
end type

event clicked;call super::clicked;//해당은행별로 만들어진 DataWindow를 조회하여 바로 저장한다.

string 	ls_docname, ls_named, ls_ilja, ls_ok
integer 	li_value, li_chk

string	ls_data, ls_name, ls_jumin_no, ls_gubun, ls_hakyunje, ls_gwa, ls_hakbun, ls_bank, ls_gitagum
string	ls_rb_check, ls_hakyun
int	 	li_WriteNum

string  	ls_sunapcheo, ls_year, ls_hakgi, ls_bunnapchasu = '0'
long		ll_row

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_ilja		     =  func.of_nvl(dw_con.Object.from_dt[1], '%')
ls_sunapcheo = dw_con.Object.bank_id[1]
ls_gubun      =  dw_con.Object.gubun[1]

if ls_ilja = '19000101' then
	ls_ilja = '%'
end if

//분납자 포함(1차)인지 아닌지 체크
IF ls_gubun = '1' Then
	ls_ok         = 'Y'
	ls_bunnapchasu   = '1'
END IF 	
IF ls_gubun = '4' Then
	ls_ok         = 'N'
END IF

//분납자 포함이면서 2차인지 3차인지 체크
IF ls_gubun = '2' Then
	ls_bunnapchasu   = '2'
	ls_ok         = 'Y'
END IF
IF ls_gubun = '3' Then
	ls_bunnapchasu   = '3'
	ls_ok         = 'Y'
END IF

//수납처별로 생성
CHOOSE CASE  ls_sunapcheo
	CASE '2'												//	우리은행
		dw_main.dataobject = 'd_hdr201a_2'		//이거 이름 나중에 맞출것.
		dw_main.SetTransObject(Sqlca)
		dw_main.Event constructor()
		
		ll_row = dw_main.retrieve(ls_year, ls_hakgi,ls_ilja, ls_ok, ls_bunnapchasu)
				
	CASE '3'												//	국민은행
		dw_main.dataobject = 'd_hdr201a_1'
		dw_main.SetTransObject(Sqlca)
		dw_main.Event constructor()
		
		ll_row = dw_main.retrieve(ls_year, ls_hakgi, ls_ilja, ls_ok)
		
	CASE '4'												//	농협 인터넷 대출
		dw_main.dataobject = 'd_hdr201a_3'
		dw_main.SetTransObject(Sqlca)
		dw_main.Event constructor()
		
		ll_row = dw_main.retrieve(ls_year, ls_hakgi, ls_ilja, ls_ok)	
		
	CASE ELSE
		MESSAGEBOX("은행확인","은행을 선택해주세요.")
		RETURN
		
END CHOOSE

if ls_sunapcheo <> '5' then
	
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
	
	
end if



end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

