$PBExportHeader$w_hin808p.srw
$PBExportComments$교수업적평가제실시현황
forward
global type w_hin808p from w_msheet
end type
type dw_print from cuo_dwwindow within w_hin808p
end type
end forward

global type w_hin808p from w_msheet
dw_print dw_print
end type
global w_hin808p w_hin808p

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

public subroutine wf_setmenubtn (string as_type);//입력
////저장
////삭제
////조회
////검색
//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN lb_Value = TRUE
//	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
//	
//	CHOOSE CASE ls_Flag[li_idx]
//		CASE 'I' ;ib_insert   = lb_Value
//		CASE 'S' ;ib_update   = lb_Value
//		CASE 'D' ;ib_delete   = lb_Value
//		CASE 'R' ;ib_retrieve = lb_Value
//		CASE 'P' ;ib_print    = lb_Value
//		CASE 'P' ;ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

on w_hin808p.create
int iCurrent
call super::create
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
end on

on w_hin808p.destroy
call super::destroy
destroy(this.dw_print)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 교수업적평가제실시현황을 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
dw_print.uf_setPreview(True) //옆의 테두리로 출력물 처리로 보이게한다
dw_print.uf_SetClick(False)  //선택 처리 미사용
//wf_setmenu('R',TRUE)         //조회버튼 활성화

end event

event ue_print;call super::ue_print;f_print(dw_print)//출력



end event

event ue_retrieve;call super::ue_retrieve;
dw_print.retrieve()
return 1
end event

type ln_templeft from w_msheet`ln_templeft within w_hin808p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin808p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin808p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin808p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin808p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin808p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin808p
end type

type uc_insert from w_msheet`uc_insert within w_hin808p
end type

type uc_delete from w_msheet`uc_delete within w_hin808p
end type

type uc_save from w_msheet`uc_save within w_hin808p
end type

type uc_excel from w_msheet`uc_excel within w_hin808p
end type

type uc_print from w_msheet`uc_print within w_hin808p
end type

type st_line1 from w_msheet`st_line1 within w_hin808p
end type

type st_line2 from w_msheet`st_line2 within w_hin808p
end type

type st_line3 from w_msheet`st_line3 within w_hin808p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin808p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin808p
end type

type dw_print from cuo_dwwindow within w_hin808p
integer y = 12
integer width = 3867
integer height = 2600
integer taborder = 10
string dataobject = "d_hin808p_1"
borderstyle borderstyle = stylelowered!
end type

event retrieveend;call super::retrieveend;/////////////////////////////////////////////////////////////////////////////
//     *행의수를 조회한다 .                                                //
//     *조회를 했을시 조회내용이 있을때만 프린터버튼을 활성화하여          // 
//     *프린터를 할수 있도록 한다.                                         //
/////////////////////////////////////////////////////////////////////////////
//IF rowcount > 0 then
//	wf_setMenu('PRINT',True)
//else
//	wf_setMenu('PRINT',False)	
//end IF

wf_setrowcount(string(rowcount)) //행의수를 조회

end event

