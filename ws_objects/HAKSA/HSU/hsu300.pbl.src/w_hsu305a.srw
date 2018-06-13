$PBExportHeader$w_hsu305a.srw
$PBExportComments$[청운대]학기별석차생성
forward
global type w_hsu305a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hsu305a
end type
type dw_con from uo_dwfree within w_hsu305a
end type
type uo_1 from uo_imgbtn within w_hsu305a
end type
end forward

global type w_hsu305a from w_condition_window
integer width = 4512
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hsu305a w_hsu305a

type variables
long 		il_row, il_seq_no
string 	is_year, is_hakgi, is_gwa,	is_jungong_id, is_hakyun, is_ban, is_juya
string	is_gwamok2, is_member_no,  is_hosil, is_yoil, is_sigan, is_ban_bunhap
string	is_chk, is_gwamok

end variables

on w_hsu305a.create
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

on w_hsu305a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

event ue_retrieve;call super::ue_retrieve;string	ls_year,	ls_hakgi, ls_hakyun, ls_gwa
long		li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1
		
elseif	ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
		
end if

li_ans	=	dw_main.retrieve(ls_year,	ls_hakgi, ls_hakyun, ls_gwa)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_main.setfocus()
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu305a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu305a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu305a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu305a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu305a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu305a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu305a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu305a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu305a
end type

type uc_save from w_condition_window`uc_save within w_hsu305a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu305a
end type

type uc_print from w_condition_window`uc_print within w_hsu305a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu305a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu305a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu305a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu305a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu305a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu305a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu305a
integer taborder = 90
end type

type dw_main from uo_input_dwc within w_hsu305a
integer x = 50
integer y = 312
integer width = 4379
integer height = 1948
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_hsu300a_5"
end type

type dw_con from uo_dwfree within w_hsu305a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hsu305a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hsu305a
integer x = 667
integer y = 40
integer width = 402
integer taborder = 20
boolean bringtotop = true
string btnname = "석차부여"
end type

event clicked;call super::clicked;string ls_year, ls_hakgi, ls_hakyun, ls_gwa, ls_pre_gwa, ls_pre_hakyun
long	ll_rtn, ll_ans, i, m, n

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')

if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기석차를 부여하시겠습니까?", Question!, YesNo!, 2) = 2 then return

ll_rtn = dw_main.retrieve(ls_year, ls_hakgi, ls_hakyun, ls_gwa)

if ll_rtn <= 0 then
	messagebox("오류","자료가 존재하지 않습니다.")
	return
end if
					
//석차부여 - 학과, 학년, 평균평점, 실점총점순으로  sort
dw_main.setsort("gwa a, dr_hakyun a, avg_pyengjum d, chidk_hakjum d, total_siljum d, jenpil d, jensen d, gooyang d")   

dw_main.sort()
for i =1 to dw_main.rowcount()
	if dw_main.object.gwa[i]			= ls_pre_gwa		and &
		dw_main.object.dr_hakyun[i]	= ls_pre_hakyun	then
		
			// 평점평균의 같은경우 공동순위 부여		
//			if dw_main.object.avg_pyengjum[i - 1]		= dw_main.object.avg_pyengjum[i]	and &
//				dw_main.object.total_siljum[i - 1]		= dw_main.object.total_siljum[i]	then
//
//				 
//				
//				m = m
//				n = n+1
//			else
//				m = m+1 + n
//				n = 0
//			end if	
		m = m+1 + n
		n = 0

	else
		m = 1
		n = 0
	end if
	
	//순위 set
	dw_main.object.sukcha[i] = m
	
	ls_pre_gwa		= dw_main.object.gwa[i]
	ls_pre_hakyun	= dw_main.object.dr_hakyun[i]
	
next

dw_main.AcceptText( )
ll_ans = dw_main.update()         //자료의 저장

IF ll_ans = -1  THEN
	uf_messagebox(3)            //저장오류 메세지 출력
	ROLLBACK USING SQLCA;
ELSE
	commit using sqlca ;
	messagebox("확인","성적처리가 완료되었습니다.")

end IF

SetPointer(Arrow!)


end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

