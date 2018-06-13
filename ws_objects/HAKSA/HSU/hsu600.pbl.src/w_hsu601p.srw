$PBExportHeader$w_hsu601p.srw
$PBExportComments$[청운대]성적평가표
forward
global type w_hsu601p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hsu601p
end type
type dw_con from uo_dwfree within w_hsu601p
end type
end forward

global type w_hsu601p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hsu601p w_hsu601p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hsu601p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hsu601p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

//사용자가 교수이면 검색조건의 교수를 ENABLED
if f_enabled_chk(gs_empcode) = 1 then
	dw_con.Object.prof_no[1] = gs_empcode
    dw_con.Object.prof_no.Protect = 0
	
end if

if gs_empcode	=	'A0002' then
	dw_con.Object.prof_no.Protect = 1
end if
end event

event ue_retrieve;string 	ls_year,	ls_hakgi, ls_hakgwa, ls_hakyun, ls_bunban, ls_prof, ls_ban, ls_isu
string   ls_gwa,  ls_gwamok,ls_grade,  ls_pyengjum
long		ll_row,  ii,       li_gwamok_seq,  l_percent,  l_inwon

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakgwa	=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_prof        =	func.of_nvl(dw_con.Object.prof_no[1], '%')
ls_ban         =  func.of_nvl(dw_con.Object.ban[1], '%')

ll_row = dw_main.retrieve(ls_year, ls_hakgi, ls_hakgwa, ls_hakyun, ls_prof, ls_ban)	

IF ll_row  > 0 THEN
	ls_gwa				=	dw_main.object.gaesul_gwamok_gwa[1]
	ls_hakyun			=	dw_main.object.gaesul_gwamok_hakyun[1]
	ls_ban				=	dw_main.object.gaesul_gwamok_ban[1]
	ls_gwamok			=	dw_main.object.gaesul_gwamok_gwamok_id[1]
	li_gwamok_seq		=	dw_main.object.gaesul_gwamok_gwamok_seq[1]
	ls_bunban			=	dw_main.object.gaesul_gwamok_bunban[1]
	
	SELECT nvl(tmt_each_yn, 'N')
	  INTO :ls_isu
	  FROM haksa.gaesul_gwamok
	 WHERE year       = :ls_year
		AND hakgi      = :ls_hakgi
		AND gwa        = :ls_gwa
		AND hakyun     = :ls_hakyun
		AND ban        = :ls_ban
		AND bunban     = :ls_bunban
		AND gwamok_id  = :ls_gwamok
		AND gwamok_seq = :li_gwamok_seq
		USING SQLCA ;
		
	IF sqlca.sqlnrows = 0 THEN
		ls_isu         = 'N'
	END IF
	
	/* 수강기준인원 */
	SELECT nvl(relation1, 0)
	  INTO :l_inwon
	  FROM haksa.TMT_CODE
	 WHERE large_div    = 'SUH03'
		AND small_div    = '02' 
	 USING SQLCA ;
	 
	IF sqlca.sqlnrows   = 0 THEN
		l_inwon          = 0
	END IF
	IF ls_isu  = 'Y' AND ll_row >= l_inwon THEN
	ELSE
		ls_isu  = 'N'
	END IF
END IF

IF ls_isu  = 'Y' AND ll_row > 0 THEN
   dw_main.SetItem(1, 'tmt_each_yn', ls_isu)
	FOR ii    = 1 TO 10
 		 dw_main.modify("t_" + String(ii) + "_1.text = '"  + '' + "'")
		 dw_main.modify("t_" + String(ii) + "_2.text = '"  + '' + "'")
		 dw_main.modify("t_" + String(ii) + "_3.text = '"  + '' + "'")
	NEXT
	ii        = 0
	DECLARE cur_1  CURSOR FOR
	
	SELECT grade,   percent
	  FROM haksa.tmt_each_amount
	 WHERE year       = :ls_year
	   AND hakgi      = :ls_hakgi
		AND gwa        = :ls_gwa
		AND hakyun     = :ls_hakyun
		AND ban        = :ls_ban
		AND bunban     = :ls_bunban
		AND gwamok_id  = :ls_gwamok
		AND gwamok_seq = :li_gwamok_seq
		AND seq        = 1
    order by substr(grade,1,1), length(grade) desc
	USING SQLCA ;
	
	 OPEN   cur_1;
	 DO WHILE(TRUE)
	 FETCH cur_1 INTO  :ls_grade, :l_percent ;
	 IF SQLCA.SQLCODE  <> 0 THEN  EXIT
	 
	    ii      = ii + 1
		 IF ls_grade      = 'A+' THEN
			 ls_pyengjum   = '4.5'
		 ELSEIF ls_grade  = 'A'  THEN
			 ls_pyengjum   = '4.0'
		 ELSEIF ls_grade  = 'B+' THEN
			 ls_pyengjum   = '3.5'
		 ELSEIF ls_grade  = 'B'  THEN
			 ls_pyengjum   = '3.0'
		 ELSEIF ls_grade  = 'C+' THEN
			 ls_pyengjum   = '2.5'
		 ELSEIF ls_grade  = 'C'  THEN
			 ls_pyengjum   = '2.0'
		 ELSEIF ls_grade  = 'D+' THEN
			 ls_pyengjum   = '1.5'
		 ELSEIF ls_grade  = 'D'  THEN
			 ls_pyengjum   = '1.0'
		 ELSEIF ls_grade  = 'F'  THEN
			 ls_pyengjum   = '0.0'
		 END IF
		 dw_main.modify("t_" + String(ii) + "_1.text = '"  + string(l_percent) + '%' + "'")
		 dw_main.modify("t_" + String(ii) + "_2.text = '"  + ls_grade + "'")
		 dw_main.modify("t_" + String(ii) + "_3.text = '"  + ls_pyengjum + "'")
	Loop
	Close  Cur_1;
ELSE
	dw_main.Modify("t_1_1.text = '95-100'")
	dw_main.Modify("t_1_2.text = 'A+'")
	dw_main.Modify("t_1_3.text = '4.5'")
	dw_main.Modify("t_2_1.text = '90-94'")
	dw_main.Modify("t_2_2.text = 'A'")
	dw_main.Modify("t_2_3.text = '4.0'")
	dw_main.Modify("t_3_1.text = '85-89'")
	dw_main.Modify("t_3_2.text = 'B+'")
	dw_main.Modify("t_3_3.text = '3.5'")
	dw_main.Modify("t_4_1.text = '80-84'")
	dw_main.Modify("t_4_2.text = 'B'")
	dw_main.Modify("t_4_3.text = '3.0'")
	dw_main.Modify("t_5_1.text = '75-79'")
	dw_main.Modify("t_5_2.text = 'C+'")
	dw_main.Modify("t_5_3.text = '2.5'")
	dw_main.Modify("t_6_1.text = '70-74'")
	dw_main.Modify("t_6_2.text = 'C'")
	dw_main.Modify("t_6_3.text = '2.0'")
	dw_main.Modify("t_7_1.text = '65-69'")
	dw_main.Modify("t_7_2.text = 'D+'")
	dw_main.Modify("t_7_3.text = '1.5'")
	dw_main.Modify("t_8_1.text = '60-64'")
	dw_main.Modify("t_8_2.text = 'D'")
	dw_main.Modify("t_8_3.text = '1.0'")
	dw_main.Modify("t_9_1.text = '59이하'")
	dw_main.Modify("t_9_2.text = 'F'")
	dw_main.Modify("t_9_3.text = '0.0'")
END IF

if ll_row = 0 then
	uf_messagebox(7)
	
elseif ll_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1



end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu601p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu601p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu601p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu601p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu601p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu601p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu601p
end type

type uc_insert from w_condition_window`uc_insert within w_hsu601p
end type

type uc_delete from w_condition_window`uc_delete within w_hsu601p
end type

type uc_save from w_condition_window`uc_save within w_hsu601p
end type

type uc_excel from w_condition_window`uc_excel within w_hsu601p
end type

type uc_print from w_condition_window`uc_print within w_hsu601p
end type

type st_line1 from w_condition_window`st_line1 within w_hsu601p
end type

type st_line2 from w_condition_window`st_line2 within w_hsu601p
end type

type st_line3 from w_condition_window`st_line3 within w_hsu601p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu601p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu601p
end type

type gb_1 from w_condition_window`gb_1 within w_hsu601p
integer height = 356
end type

type gb_2 from w_condition_window`gb_2 within w_hsu601p
integer y = 360
integer height = 2136
end type

type dw_main from uo_search_dwc within w_hsu601p
integer x = 50
integer y = 292
integer width = 4379
integer height = 1972
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hsu600p_1"
end type

type dw_con from uo_dwfree within w_hsu601p
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_hsu601p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

