$PBExportHeader$w_hjk003a.srw
$PBExportComments$[청운대]학적일정관리
forward
global type w_hjk003a from w_common_rgt
end type
end forward

global type w_hjk003a from w_common_rgt
end type
global w_hjk003a w_hjk003a

event open;call super::open;String ls_year

idw_update[1] = dw_main

dw_main.InsertRow(0)

ls_year = func.of_get_sdate('YYYY')

dw_con.Object.year[1]  = ls_year
dw_con.Object.hakgi[1] = f_haksa_iljung_hakgi()
end event

event ue_delete;call super::ue_delete;int li_ans

dw_main.deleterow(0)
li_ans = dw_main.update()			

if li_ans = -1 then
	//저장 오류 메세지 출력
	rollback;
	f_set_message("삭제시 오류가 발생하였습니다!", '', parentwin)
else	
	commit Using Sqlca ;
	//저장확인 메세지 출력
	f_set_message("삭제 되었습니다!", '', parentwin)
end if


end event

event ue_insert;call super::ue_insert;long 		ll_line
string 	ls_year

dw_con.AcceptText()

ls_year = dw_con.Object.year[1]

ll_line = dw_main.insertrow(0)

dw_main.setitem(ll_line, "year", ls_year)

if ll_line <> -1 then
	dw_main.scrolltorow(ll_line)
	dw_main.setcolumn(1)
	dw_main.setfocus()
end if		
end event

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi
int li_ans

dw_con.AcceptText()

//조회조건
ls_year  = dw_con.Object.year[1]
ls_hakgi = dw_con.Object.hakgi[1]

li_ans = dw_main.retrieve(ls_year, ls_hakgi)
if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	f_set_message("조회 되었습니다!", '', parentwin)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	f_set_message("조회시 오류가 발생하였습니다!", '', parentwin)
	return 1
else
	dw_main.setfocus()
end if
end event

on w_hjk003a.create
call super::create
end on

on w_hjk003a.destroy
call super::destroy
end on

type ln_templeft from w_common_rgt`ln_templeft within w_hjk003a
end type

type ln_tempright from w_common_rgt`ln_tempright within w_hjk003a
end type

type ln_temptop from w_common_rgt`ln_temptop within w_hjk003a
end type

type ln_tempbuttom from w_common_rgt`ln_tempbuttom within w_hjk003a
end type

type ln_tempbutton from w_common_rgt`ln_tempbutton within w_hjk003a
end type

type ln_tempstart from w_common_rgt`ln_tempstart within w_hjk003a
end type

type uc_retrieve from w_common_rgt`uc_retrieve within w_hjk003a
end type

type uc_insert from w_common_rgt`uc_insert within w_hjk003a
end type

type uc_delete from w_common_rgt`uc_delete within w_hjk003a
end type

type uc_save from w_common_rgt`uc_save within w_hjk003a
end type

type uc_excel from w_common_rgt`uc_excel within w_hjk003a
end type

type uc_print from w_common_rgt`uc_print within w_hjk003a
end type

type st_line1 from w_common_rgt`st_line1 within w_hjk003a
end type

type st_line2 from w_common_rgt`st_line2 within w_hjk003a
end type

type st_line3 from w_common_rgt`st_line3 within w_hjk003a
end type

type uc_excelroad from w_common_rgt`uc_excelroad within w_hjk003a
end type

type ln_dwcon from w_common_rgt`ln_dwcon within w_hjk003a
end type

type dw_con from w_common_rgt`dw_con within w_hjk003a
integer height = 120
string dataobject = "d_hjk003a_c1"
end type

type dw_main from w_common_rgt`dw_main within w_hjk003a
integer y = 300
integer width = 4379
integer height = 1988
string dataobject = "d_hjk003a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_main::itemchanged;call super::itemchanged;string 	ls_sijum ,&
			ls_hakgi ,&
			ls_year
integer	li_cnt

STRING LS_1, LS_2, LS_3

CHOOSE CASE dwo.name
		
	case 'year','hakgi'
		
		dw_main.AcceptText ( )
		
		ls_year 	= dw_main.object.year[row]
		ls_hakgi = dw_main.object.hakgi[row]
		
		select	count(year)
		into		:li_cnt
		from		haksa.haksa_iljung
		where		year = :ls_year
		and		hakgi = :ls_hakgi
		Using sqlca
		;
		
		if li_cnt <> 0 then
			messagebox('확인', ls_year + '년도' + ls_hakgi + "학기 학사일정내역이 생성되어있습니다.")
			return 1			
		else
		
			if ls_hakgi = '1' then
				dw_main.setitem(row,'next_year', ls_year)
				dw_main.setitem(row,'next_hakgi', '2')
			elseif ls_hakgi = '3'then
				dw_main.setitem(row,'next_year', ls_year)
				dw_main.setitem(row,'next_hakgi', '2')				
			elseif ls_hakgi = '2'then
				dw_main.setitem(row,'next_year', string(integer(ls_year)+ 1))
				dw_main.setitem(row,'next_hakgi', '1')
			elseif ls_hakgi = '4'then
				dw_main.setitem(row,'next_year', string(integer(ls_year)+ 1))
				dw_main.setitem(row,'next_hakgi', '1')				
			else 
				return 1
			end if
		end if
		
	case 'sijum_flag'
		
		dw_main.AcceptText ( )
		
		ls_sijum = data
		ls_year 	= dw_main.object.year[row]
		ls_hakgi = dw_main.object.hakgi[row]
		
		if ls_sijum = 'Y'then
			
			UPDATE 	HAKSA.HAKSA_ILJUNG
			SET 		SIJUM_FLAG = 'N'
			WHERE 	SIJUM_FLAG = 'Y'
			AND		(	YEAR 	<> :ls_year
				OR			HAKGI <> :ls_hakgi
						)
		    USING SQLCA	;
			
			if sqlca.sqlcode <> 0 then
				MessageBox("SQL error~R~N", SQLCA.SQLErrText)
				rollback USING SQLCA ;
				return 1
			else
				COMMIT USING SQLCA ;
			end if
		end if
end choose

end event

