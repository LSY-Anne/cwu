$PBExportHeader$w_hjk412a.srw
$PBExportComments$[청운대]증명발급대장관리
forward
global type w_hjk412a from w_condition_window
end type
type dw_con from uo_dwfree within w_hjk412a
end type
type dw_main from uo_dwfree within w_hjk412a
end type
end forward

global type w_hjk412a from w_condition_window
dw_con dw_con
dw_main dw_main
end type
global w_hjk412a w_hjk412a

on w_hjk412a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hjk412a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;call super::ue_retrieve;string 	ls_year,		& 
			ls_hakgi,	&
			ls_gwa,		&
			ls_id,		&
			ls_from,		&
			ls_to
integer 	li_ans

dw_con.AcceptText()
      
ls_year 	= dw_con.Object.year[1]
ls_gwa	= func.of_nvl(dw_con.Object.gwa[1], '%')
ls_id		= func.of_nvl(dw_con.Object.jungmyung_id[1], '%')
ls_from	= dw_con.Object.from_dt[1]
ls_to		= dw_con.Object.to_dt[1]
	 
li_ans = dw_main.retrieve(ls_year, ls_gwa, ls_id, ls_from, ls_to)

if li_ans < 1 then
	uf_messagebox(7)
	dw_main.reset()
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]      = func.of_get_sdate( 'YYYY')
dw_con.Object.from_dt[1] = func.of_get_sdate( 'YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate( 'YYYYMMDD')
end event

event ue_delete;string	ls_year,	ls_bunho, ls_yongdo
int	li_row	,&
		li_ans1	,&
		li_rtn

li_ans1 = uf_messagebox(4)				/*	삭제확인 메세지 출력		*/

li_row = dw_main.getrow()

ls_year 		= dw_main.object.balgup_daejang_year[li_row]
ls_bunho		= right(dw_main.object.balgup_daejang_bunho[li_row], 5)
ls_yongdo	= dw_main.object.balgup_daejang_yongdo_id[li_row]	

if li_ans1 = 1 then
	li_rtn = f_balgup_daejang_backup(ls_bunho, 'D', ls_yongdo)

	if li_rtn = -1 then
		messagebox('백업실패!', '원서마스터 백업을 실패하였습니다!')
		return
	end if
	
	dw_main.deleterow(0)            	/*	현재 행을 삭제				*/
end if

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk412a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk412a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk412a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk412a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk412a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk412a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk412a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk412a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk412a
end type

type uc_save from w_condition_window`uc_save within w_hjk412a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk412a
end type

type uc_print from w_condition_window`uc_print within w_hjk412a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk412a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk412a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk412a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk412a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk412a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk412a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk412a
end type

type dw_con from uo_dwfree within w_hjk412a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk412a_c1"
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
		
	Case 'p_to_dt'
		ls_to_dt 	= String(This.Object.to_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'to_dt' , ls_to_dt)
		
		ls_to_dt 	= left(ls_to_dt, 4) + mid(ls_to_dt, 6, 2) + right(ls_to_dt, 2)
		This.SetItem(row, 'to_dt',  ls_to_dt)
End Choose
end event

type dw_main from uo_dwfree within w_hjk412a
integer x = 55
integer y = 300
integer width = 4375
integer height = 1964
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_hjk412a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

