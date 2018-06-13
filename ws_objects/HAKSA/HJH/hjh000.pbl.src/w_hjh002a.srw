$PBExportHeader$w_hjh002a.srw
$PBExportComments$[청운대] 장학코드관리
forward
global type w_hjh002a from w_no_condition_window
end type
type dw_1 from uo_input_dwc within w_hjh002a
end type
type dw_main from uo_input_dwc within w_hjh002a
end type
type st_1 from statictext within w_hjh002a
end type
type st_2 from statictext within w_hjh002a
end type
end forward

global type w_hjh002a from w_no_condition_window
dw_1 dw_1
dw_main dw_main
st_1 st_1
st_2 st_2
end type
global w_hjh002a w_hjh002a

type variables
string is_code
datawindow idw_dwn
end variables

on w_hjh002a.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_main=create dw_main
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_hjh002a.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_main)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_retrieve;int		li_row

dw_main.Settransobject(sqlca)
li_row = dw_main.retrieve(is_code)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1

end event

event open;call super::open;idw_update[1] = dw_main

dw_1.retrieve()

end event

event ue_delete;int	li_ans1	,&
		li_ans2

li_ans1 = uf_messagebox(4)		//	삭제확인 메세지 출력

IF li_ans1 = 1 THEN
	dw_main.deleterow(0)          //	현재 행을 삭제
	li_ans2 = dw_main.update()    //	삭제된 내용을 저장
	
	IF li_ans2 = -1 THEN
		ROLLBACK USING SQLCA;     
		uf_messagebox(6)        //	삭제오류 메세지 출력
	
	ELSE
      COMMIT USING SQLCA;		  
		uf_messagebox(5)       //	삭제완료 메시지 출력
	END IF
END IF

dw_main.setfocus()
end event

event ue_insert;long		ll_newrow
string	ls_year, ls_hakgi, ls_code

ll_newrow	= dw_main.InsertRow(0)//	데이타윈도우의 마지막 행에 추가

//장학내외구분코드에 따른 장학코드의 max값을 가져온다
SELECT	max(SUBSTR(JANGHAK_ID,2,2))
INTO		:ls_code
FROM 		HAKSA.JANGHAK_CODE
WHERE		INOUT_GUBUN = :is_code
USING SQLCA ;

if ls_code = '' or isnull(ls_code) then ls_code = '00'

IF is_code = '01' then
	dw_main.object.janghak_id[ll_newrow] = 'I' + string(long(ls_code)+1,'00')
ELSE
	dw_main.object.janghak_id[ll_newrow] = 'O' + string(long(ls_code)+1,'00')
END IF	
	dw_main.object.inout_gubun[ll_newrow] = is_code

IF ll_newrow <> -1 THEN
   dw_main.ScrollToRow(ll_newrow)		//	추가된 행에 스크롤
	dw_main.setcolumn(1)              	//	추가된 행의 첫번째 컬럼에 커서 위치
	dw_main.setfocus()                	//	dw_main 포커스 이동
END IF
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_hjh002a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hjh002a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hjh002a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hjh002a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hjh002a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hjh002a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hjh002a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hjh002a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hjh002a
end type

type uc_save from w_no_condition_window`uc_save within w_hjh002a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hjh002a
end type

type uc_print from w_no_condition_window`uc_print within w_hjh002a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hjh002a
end type

type st_line2 from w_no_condition_window`st_line2 within w_hjh002a
end type

type st_line3 from w_no_condition_window`st_line3 within w_hjh002a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hjh002a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hjh002a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hjh002a
end type

type dw_1 from uo_input_dwc within w_hjh002a
integer x = 55
integer y = 256
integer width = 1015
integer height = 2008
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjh002q_1"
boolean border = true
end type

event clicked;call super::clicked;integer li_msg

if row > 0 then
	
	is_code = this.object.gita_id[row]
/*------------------------------------------------
	데이타의 변경내용이 있는가를 확인 
------------------------------------------------*/
	IF (dw_main.modifiedcount() + dw_main.deletedcount()) 	>0 	THEN
		li_msg 	= 	messagebox("확인","저장하시겠습니까?",Information!,YesNo!,1)
		
		if li_msg= 1 	THEN	
			Parent.Event ue_save()
		end if	
		
	END IF
	
end if

Parent.Event ue_retrieve()
dw_main.setfocus()
end event

event getfocus;call super::getfocus;idw_dwn = getfocus()
end event

type dw_main from uo_input_dwc within w_hjh002a
integer x = 1093
integer y = 256
integer width = 3342
integer height = 2008
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjh002a_1"
boolean border = true
end type

event getfocus;call super::getfocus;idw_dwn = getfocus()
end event

type st_1 from statictext within w_hjh002a
integer x = 55
integer y = 168
integer width = 1015
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 15793151
long backcolor = 8388736
string text = "구분코드"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_hjh002a
integer x = 1093
integer y = 168
integer width = 3342
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 15793151
long backcolor = 8388736
string text = "장학관련 기타코드"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

