$PBExportHeader$w_hjk702a.srw
$PBExportComments$[청운대]정원등록관리
forward
global type w_hjk702a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjk702a
end type
type dw_con from uo_dwfree within w_hjk702a
end type
type uo_1 from uo_imgbtn within w_hjk702a
end type
end forward

global type w_hjk702a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hjk702a w_hjk702a

on w_hjk702a.create
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

on w_hjk702a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_insert;long	ll_newrow

ll_newrow	= dw_main.InsertRow(0)		/*	데이타윈도우의 마지막 행에 추가			*/

if ll_newrow <> -1 then
    dw_main.ScrollToRow(ll_newrow)		/*	추가된 행에 스크롤							*/
    dw_main.setcolumn(1)              	/*	추가된 행의 첫번째 컬럼에 커서 위치		*/
    dw_main.setfocus()                	/*	dw_main 포커스 이동							*/
end if
end event

event ue_delete;int	li_ans1	,&
		li_ans2

li_ans1 = uf_messagebox(4)				/*	삭제확인 메세지 출력			*/

if li_ans1 = 1 then
	dw_main.deleterow(0)            	/*	현재 행을 삭제					*/
	li_ans2 = dw_main.update()      	/*	삭제된 내용을 저장 			*/
	
	if li_ans2 = -1 then        
		ROLLBACK USING SQLCA;     
		uf_messagebox(6)          		/*	삭제오류 메세지 출력			*/
	
	else
      COMMIT USING SQLCA;		  
		uf_messagebox(5)      		    /*	삭제완료 메세지 출력		*/
	end if
end if

dw_main.setfocus()
end event

event ue_print;//
end event

event ue_retrieve;call super::ue_retrieve;string	ls_year	,&
			ls_gwa
int		li_row	,&
			li_rtn

iw_window		= this
idw_datawindow	= dw_main

li_rtn = f_save_before_search(iw_window, idw_datawindow)

if li_rtn = 1 then
	this.triggerevent("ue_save")
elseif li_rtn = 3 then
	return  -1
end if

dw_con.AcceptText()

ls_year  = func.of_nvl(dw_con.Object.year[1], '%')
ls_gwa  = func.of_nvl(dw_con.Object.gwa[1], '%')

li_row		= dw_main.retrieve(ls_year, ls_gwa)

if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1] = func.of_get_sdate('YYYY')
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk702a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk702a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk702a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk702a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk702a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk702a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk702a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk702a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk702a
end type

type uc_save from w_condition_window`uc_save within w_hjk702a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk702a
end type

type uc_print from w_condition_window`uc_print within w_hjk702a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk702a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk702a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk702a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk702a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk702a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk702a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk702a
end type

type dw_main from uo_input_dwc within w_hjk702a
integer x = 59
integer y = 300
integer width = 4370
integer height = 1964
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hjk702a_1"
end type

type dw_con from uo_dwfree within w_hjk702a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk702a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hjk702a
integer x = 489
integer y = 44
integer width = 795
integer taborder = 20
boolean bringtotop = true
string btnname = "이전년도 정원자료복사"
end type

event clicked;call super::clicked;string 	ls_year, ls_last_year
string 	ls_gwa, ls_gubun
int 		li_count, li_ans
long		ll_iphak, ll_mojip, ll_inwon

dw_con.AcceptText()

ls_year  = func.of_nvl(dw_con.Object.year[1], '%')

select	count(*)
into 		:li_count
from 		HAKSA.JUNGWON
where 	YEAR = :ls_year
USING SQLCA
;
		
/* 최종년도 학기를 가져온다*/		
SELECT 	YEAR
INTO  	:ls_last_year 
FROM 		HAKSA.JUNGWON
WHERE 	YEAR = (	SELECT 	max(YEAR)
						FROM 		HAKSA.JUNGWON		)
GROUP BY YEAR
USING SQLCA
;
			
		
if li_count > 0 then
	messagebox("확인",ls_year + "년도 정원내역이 이미 존재합니다.")
	return 
else
	
	DECLARE LC_JUNGWON CURSOR FOR
		SELECT 	JUNGWON.GWA,      
					JUNGWON.IPHAK_JUNGWON,   
					JUNGWON.MOJIP_JUNGWON,
					JUNGWON.IPHAK_INWON
		FROM 		HAKSA.JUNGWON  
		WHERE 	( JUNGWON.YEAR = :ls_last_year )
		USING SQLCA
		;

	OPEN LC_JUNGWON ;
	DO
	FETCH LC_JUNGWON
	INTO  :ls_gwa, :ll_iphak, :ll_mojip, :ll_inwon;
	
		if sqlca.sqlcode <> 0 then EXIT
		
		INSERT INTO HAKSA.JUNGWON
			(	GWA, YEAR, IPHAK_JUNGWON, MOJIP_JUNGWON, IPHAK_INWON )
		VALUES
			(  :ls_gwa, :ls_year, :ll_iphak, :ll_mojip, :ll_inwon )
		USING SQLCA
		;
		
		if sqlca.sqlcode <> 0 then
			messagebox("확인", "오류가 발생했습니다.~r~n" + sqlca.sqlerrtext )
			rollback USING SQLCA ;
			return 
		end if

	LOOP WHILE TRUE;
	CLOSE LC_JUNGWON;
	
	COMMIT USING SQLCA;

	messagebox("확인",ls_year + "년도 정원자료를 생성했습니다.")
end if
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

