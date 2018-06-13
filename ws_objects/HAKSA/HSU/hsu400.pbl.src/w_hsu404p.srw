$PBExportHeader$w_hsu404p.srw
$PBExportComments$[청운대]외래교수출강부
forward
global type w_hsu404p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hsu404p
end type
type dw_con from uo_dwfree within w_hsu404p
end type
end forward

global type w_hsu404p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hsu404p w_hsu404p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hsu404p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hsu404p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')

end event

event ue_retrieve;call super::ue_retrieve;int		li_row
string 	ls_year,	ls_hakgi, ls_gwa, ls_start, ls_end, ls_ju

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')

ls_start	=	dw_con.Object.from_dt[1]
ls_end	=	dw_con.Object.to_dt[1]
ls_ju		=	dw_con.Object.week_ju[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1
		
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
		
end if
	
li_row = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa)

dw_main.object.t_gigan.text = '강의기간 : ' + ls_start + ' - ' + ls_end + '  ' + ls_ju + '주'

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu404p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu404p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu404p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu404p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu404p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu404p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu404p
end type

type uc_insert from w_condition_window`uc_insert within w_hsu404p
end type

type uc_delete from w_condition_window`uc_delete within w_hsu404p
end type

type uc_save from w_condition_window`uc_save within w_hsu404p
end type

type uc_excel from w_condition_window`uc_excel within w_hsu404p
end type

type uc_print from w_condition_window`uc_print within w_hsu404p
end type

type st_line1 from w_condition_window`st_line1 within w_hsu404p
end type

type st_line2 from w_condition_window`st_line2 within w_hsu404p
end type

type st_line3 from w_condition_window`st_line3 within w_hsu404p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu404p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu404p
end type

type gb_1 from w_condition_window`gb_1 within w_hsu404p
end type

type gb_2 from w_condition_window`gb_2 within w_hsu404p
end type

type dw_main from uo_search_dwc within w_hsu404p
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu400p_4"
end type

event retrieveend;call super::retrieveend;long		ll_cnt, li_sigan
string	ls_member_no, ls_yoil, ls_sigan, ls_year, ls_hakgi
string	ls_sigan1, ls_sigan2, ls_sigan3, ls_sigan4, ls_sigan5

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

for	ll_cnt	=	1		to		rowcount
		
		ls_sigan1	=	""
		ls_sigan2	=	""
		ls_sigan3	=	""
		ls_sigan4	=	""
		ls_sigan5	=	""
		
		ls_member_no	=	dw_main.getitemstring(ll_cnt, "gaesul_gwamok_member_no")

		DECLARE SIGAN_CUR CURSOR FOR
		
		SELECT	DISTINCT
					B.YOIL,
					TO_NUMBER(B.SIGAN)
		FROM	HAKSA.GAESUL_GWAMOK	A,
				HAKSA.SIGANPYO			B
		WHERE	A.YEAR			=	B.YEAR
		AND	A.HAKGI			=	B.HAKGI
		AND	A.GWA				=	B.GWA
		AND	A.HAKYUN			=	B.HAKYUN
		AND	A.BAN				=	B.BAN
		AND	A.GWAMOK_ID		=	B.GWAMOK_ID
		AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
		AND	A.BUNBAN			=	B.BUNBAN
		AND	A.YEAR			=	:ls_year
		AND	A.HAKGI			=	:ls_hakgi
		AND	A.MEMBER_NO		=	:ls_member_no
		ORDER BY B.YOIL, TO_NUMBER(B.SIGAN)
		USING SQLCA ;

		OPEN 		SIGAN_CUR;
		DO
			FETCH 	SIGAN_CUR INTO :ls_yoil, :li_sigan ;
					
				if sqlca.sqlcode <> 0 then exit
				
				ls_sigan = string(li_sigan)
				
				if	ls_yoil	=	'a'	then
					if ls_sigan1 = "" then
						ls_sigan1 = ls_sigan
						
					else
						ls_sigan1 =	ls_sigan1 + ',' + ls_sigan
						
					end if
					
				elseif	ls_yoil	=	'b'	then
					if ls_sigan2 = "" then
						ls_sigan2 = ls_sigan
						
					else
						ls_sigan2 =	ls_sigan2 + ',' + ls_sigan
						
					end if
					
				elseif	ls_yoil	=	'c'	then
					if ls_sigan3 = "" then
						ls_sigan3 = ls_sigan
						
					else
						ls_sigan3 =	ls_sigan3 + ',' + ls_sigan
						
					end if
					
				elseif	ls_yoil	=	'd'	then
					if ls_sigan4 = "" then
						ls_sigan4 = ls_sigan
						
					else
						ls_sigan4 =	ls_sigan4 + ',' + ls_sigan
						
					end if
					
				elseif	ls_yoil	=	'e'	then
					if ls_sigan5 = "" then
						ls_sigan5 = ls_sigan
						
					else
						ls_sigan5 =	ls_sigan5 + ',' + ls_sigan
						
					end if
					
				end if

		LOOP WHILE TRUE
		CLOSE SIGAN_CUR;
		
		dw_main.setitem(ll_cnt, "a2",ls_sigan1)
		dw_main.setitem(ll_cnt, "a3",ls_sigan2)
		dw_main.setitem(ll_cnt, "a4",ls_sigan3)
		dw_main.setitem(ll_cnt, "a5",ls_sigan4)
		dw_main.setitem(ll_cnt, "a6",ls_sigan5)
		
	next
end event

type dw_con from uo_dwfree within w_hsu404p
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_hsu404p_c1"
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

