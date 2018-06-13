$PBExportHeader$w_hgj206a.srw
$PBExportComments$[청운대]이수예정자포기처리
forward
global type w_hgj206a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hgj206a
end type
type dw_con from uo_dwfree within w_hgj206a
end type
end forward

global type w_hgj206a from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hgj206a w_hgj206a

type variables

end variables

on w_hgj206a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hgj206a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string	ls_jaguk, ls_pyosi, ls_hakgwa, ls_hakyun
long ll_ans

dw_con.AcceptText()

ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = func.of_nvl(dw_con.Object.pyosi_id[1], '%') + '%'
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_hakyun	= func.of_nvl(dw_con.Object.hakyun[1], '%') + '%'

if trim(ls_jaguk) = ''  Or Isnull(ls_jaguk) then
	messagebox("확인","자격명을 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("jaguk_id")
	return	 -1
end if

ll_ans = dw_main.retrieve(ls_jaguk, ls_pyosi, ls_hakgwa, ls_hakyun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;String ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)


end event

type ln_templeft from w_condition_window`ln_templeft within w_hgj206a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hgj206a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hgj206a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hgj206a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hgj206a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hgj206a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hgj206a
end type

type uc_insert from w_condition_window`uc_insert within w_hgj206a
end type

type uc_delete from w_condition_window`uc_delete within w_hgj206a
end type

type uc_save from w_condition_window`uc_save within w_hgj206a
end type

type uc_excel from w_condition_window`uc_excel within w_hgj206a
end type

type uc_print from w_condition_window`uc_print within w_hgj206a
end type

type st_line1 from w_condition_window`st_line1 within w_hgj206a
end type

type st_line2 from w_condition_window`st_line2 within w_hgj206a
end type

type st_line3 from w_condition_window`st_line3 within w_hgj206a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hgj206a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hgj206a
end type

type gb_1 from w_condition_window`gb_1 within w_hgj206a
end type

type gb_2 from w_condition_window`gb_2 within w_hgj206a
end type

type dw_main from uo_input_dwc within w_hgj206a
integer x = 50
integer y = 300
integer width = 4384
integer height = 1964
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hgj206a"
end type

event itemchanged;string	ls_hakbun
int li_ans

CHOOSE CASE dwo.name
	CASE 'pogi_yn'
		ls_hakbun = dw_main.object.hakbun[row]
		
		if data = 'Y' then			

			if messagebox('확인','이수예정자 포기처리를 하시겠습니까?' +&
								'~r~n교직과목을 일선과목으로 변경처리됩니다!',question!,yesno!,2)=2 then return

			//수강자료
			UPDATE	HAKSA.SUGANG
			SET		ISU_ID	= '80'
			WHERE	ISU_ID	= '40'
			AND		HAKBUN	= :ls_hakbun
			USING SQLCA ;
											
			IF SQLCA.SQLCODE <> 0 THEN
				rollback USING SQLCA ;
				messagebox('확인','수강작업변경을 실패하였습니다!')
			END IF
			
			//수강트랜스 자료
			UPDATE	HAKSA.SUGANG_TRANS
			SET		ISU_ID	= '80'
			WHERE		ISU_ID	= '40'
			AND		HAKBUN	= :ls_hakbun
			USING SQLCA ;
			
			if sqlca.sqlcode = 0 then				
				li_ans = dw_main.update()
									
				if li_ans = -1 then					
					rollback USING SQLCA ;
				else	
					commit USING SQLCA ;		
				end if
				
			else
				rollback USING SQLCA ;
				messagebox('확인','수강트랜스 작업을 실패하였습니다!')
			end if
		end if
end choose

end event

event itemerror;call super::itemerror;return 2
end event

type dw_con from uo_dwfree within w_hgj206a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hgj204a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

