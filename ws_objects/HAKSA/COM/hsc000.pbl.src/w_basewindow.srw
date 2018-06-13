$PBExportHeader$w_basewindow.srw
$PBExportComments$[청운대]조상Window
forward
global type w_basewindow from w_msheet
end type
end forward

global type w_basewindow from w_msheet
integer height = 2612
end type
global w_basewindow w_basewindow

forward prototypes
public function integer uf_messagebox (integer a_code)
end prototypes

public function integer uf_messagebox (integer a_code);int	li_temp

choose case a_code
	case 1
		li_temp = messagebox("저장확인","자료를 저장 하시겠습니까?", question!, yesno!)
		return li_temp
	case 2
		li_temp = messagebox("저장완료","자료가 저장 되었습니다.")
		return li_temp
	case 3
		li_temp = messagebox("저장오류","자료가 저장되지 않았습니다.",stopsign!)
		return li_temp
	case 4
		li_temp = messagebox("삭제확인","자료를 삭제하시겠습니까?", question!, yesno!)
		return li_temp
	case 5
		li_temp = messagebox("삭제완료","자료가 삭제 되었습니다.")
		return li_temp
	case 6
		li_temp = messagebox("삭제오류","자료가 삭제되지 않았습니다.",stopsign!)
		return li_temp
	case 7
		li_temp = messagebox("확인","조회한 자료가 없습니다.")
		return li_temp
	case 8
		li_temp = messagebox("조회오류","자료가 조회되지 않았습니다.",stopsign!)
		return li_temp
	case 9
		li_temp = messagebox("종료확인","종료하시겠습니까?",question!, yesno!)
		return li_temp
	case 10
		li_temp = messagebox("확인","변경된 자료가 있습니다.~n자료를 저장하시겠습니까?",question!,yesnocancel!)
		return li_temp
	case 11
		li_temp = messagebox("확인","삭제할 자료가 존재하지 않습니다.")
		return li_temp
	case 12
		li_temp = messagebox("확인","연도를 입력하지 않았습니다.")
		return li_temp		
	case 13
		li_temp = messagebox("확인","학년을 입력하지 않았습니다.")
		return li_temp
	case 14
		li_temp = messagebox("확인","학기를 입력하지 않았습니다.")
		return li_temp
	case 15
		li_temp = messagebox("확인","학번을 입력하지 않았습니다.")
		return li_temp		
	case 16
		li_temp = messagebox("확인","저장할 자료가 없습니다.")
		return li_temp
	case 17
		li_temp = messagebox("확인","반을 입력하지 않았습니다.")
		return li_temp
	case 18
		li_temp = messagebox("확인","주야을 입력하지 않았습니다.")
		return li_temp
	case 19
		li_temp = messagebox("확인","학과를 입력하지 않았습니다.")
		return li_temp
	case 20
		li_temp = messagebox("확인","개설된 과목이 존재하지 않습니다.")
		return li_temp
end choose
end function

on w_basewindow.create
call super::create
end on

on w_basewindow.destroy
call super::destroy
end on

event open;call super::open;f_pro_toggle('K', Handle(THIS)) 
end event

event ue_printstart;call super::ue_printstart;// 출력물 설정

avc_data.SetProperty('title', "출력물")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

Return 1
end event

type ln_templeft from w_msheet`ln_templeft within w_basewindow
end type

type ln_tempright from w_msheet`ln_tempright within w_basewindow
end type

type ln_temptop from w_msheet`ln_temptop within w_basewindow
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_basewindow
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_basewindow
end type

type ln_tempstart from w_msheet`ln_tempstart within w_basewindow
end type

type uc_retrieve from w_msheet`uc_retrieve within w_basewindow
end type

type uc_insert from w_msheet`uc_insert within w_basewindow
end type

type uc_delete from w_msheet`uc_delete within w_basewindow
end type

type uc_save from w_msheet`uc_save within w_basewindow
end type

type uc_excel from w_msheet`uc_excel within w_basewindow
end type

type uc_print from w_msheet`uc_print within w_basewindow
end type

type st_line1 from w_msheet`st_line1 within w_basewindow
end type

type st_line2 from w_msheet`st_line2 within w_basewindow
end type

type st_line3 from w_msheet`st_line3 within w_basewindow
end type

type uc_excelroad from w_msheet`uc_excelroad within w_basewindow
end type

type ln_dwcon from w_msheet`ln_dwcon within w_basewindow
end type

