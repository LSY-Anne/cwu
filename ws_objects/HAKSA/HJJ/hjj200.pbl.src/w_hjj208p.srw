$PBExportHeader$w_hjj208p.srw
$PBExportComments$[청운대]학과별 학점취득자LIST성적표출력
forward
global type w_hjj208p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjj208p
end type
type dw_main2 from datawindow within w_hjj208p
end type
type dw_con from uo_dwfree within w_hjj208p
end type
type uo_1 from uo_imgbtn within w_hjj208p
end type
end forward

global type w_hjj208p from w_condition_window
dw_main dw_main
dw_main2 dw_main2
dw_con dw_con
uo_1 uo_1
end type
global w_hjj208p w_hjj208p

on w_hjj208p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_main2=create dw_main2
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_main2
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_1
end on

on w_hjj208p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_main2)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;string	ls_year		,&
			ls_junhugi	,&
			ls_hakgwa	,&
			ls_hakbun
long		ll_row
integer	li_hakjum

dw_con.AcceptText()

ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_hakbun   = func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'
li_hakjum    = dw_con.Object.hakjum[1]

If Isnull(li_hakjum) Then li_hakjum = 0 ;
ll_row = dw_main.retrieve(ls_hakbun, ls_hakgwa,  li_hakjum )

if ll_row = 0 then
	uf_messagebox(7)
	
elseif ll_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1
end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjj208p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjj208p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjj208p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjj208p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjj208p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjj208p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjj208p
end type

type uc_insert from w_condition_window`uc_insert within w_hjj208p
end type

type uc_delete from w_condition_window`uc_delete within w_hjj208p
end type

type uc_save from w_condition_window`uc_save within w_hjj208p
end type

type uc_excel from w_condition_window`uc_excel within w_hjj208p
end type

type uc_print from w_condition_window`uc_print within w_hjj208p
end type

type st_line1 from w_condition_window`st_line1 within w_hjj208p
end type

type st_line2 from w_condition_window`st_line2 within w_hjj208p
end type

type st_line3 from w_condition_window`st_line3 within w_hjj208p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjj208p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjj208p
end type

type gb_1 from w_condition_window`gb_1 within w_hjj208p
end type

type gb_2 from w_condition_window`gb_2 within w_hjj208p
end type

type dw_main from uo_search_dwc within w_hjj208p
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjj208p_1"
end type

type dw_main2 from datawindow within w_hjj208p
boolean visible = false
integer x = 3081
integer y = 336
integer width = 699
integer height = 412
integer taborder = 21
string title = "none"
string dataobject = "d_hjj208p_1_gai"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_con from uo_dwfree within w_hjj208p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 210
boolean bringtotop = true
string dataobject = "d_hjj208p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gubun'
		If data = '1' Then
			dw_main.reset()
			dw_main.dataobject = 'd_hjj208p_1'	
			dw_main.settransobject(sqlca)
		Else
			dw_main.reset()
			dw_main.dataobject = 'd_hjj208p_2'	
			dw_main.settransobject(sqlca)
		End IF
		
End Choose
end event

type uo_1 from uo_imgbtn within w_hjj208p
integer x = 398
integer y = 40
integer taborder = 70
boolean bringtotop = true
string btnname = "인쇄"
end type

event clicked;call super::clicked;string	ls_year,	ls_hakbun,	ls_hakgwa,	ls_hakbun1, ls_gubun
long		li_ans
integer	li_hakjum

dw_con.AcceptText()

ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_hakbun   = func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'
li_hakjum    = dw_con.Object.hakjum[1]
ls_gubun     = dw_con.Object.gubun[1]

IF MESSAGEBOX("확인","인쇄 하겠습니까?", Question!, YesNo!, 2) = 2 THEN RETURN

SetPointer(HourGlass!)

if ls_gubun = '1' Then
	
	DECLARE CUR_PRINT CURSOR  FOR
			SELECT	A.HAKBUN
			FROM		HAKSA.JAEHAK_HAKJUK A
			WHERE 	A.GWA			like :ls_hakgwa
			AND		A.HAKBUN		like :ls_hakbun
			AND		(	SELECT	SUM(DECODE(B.HWANSAN_JUMSU, 'F', 0, B.HAKJUM))	CHIDK
							FROM		HAKSA.SUGANG B
							WHERE		B.SUNGJUK_INJUNG = 'Y'
							AND		A.HAKBUN	=	B.HAKBUN
						)  + NVL(TO_NUMBER(A.INJUNG_HAKJUM), 0)	>= :li_hakjum
			AND		A.SANGTAE	=	'01'
			ORDER BY	A.GWA ASC,
						A.HAKBUN ASC
			USING SQLCA ;
	
	OPEN CUR_PRINT ;
	DO 
		
		FETCH CUR_PRINT INTO :ls_hakbun1 ;
	
		IF SQLCA.SQLCODE <> 0 THEN EXIT
	
		ls_hakgwa = '%' 
		li_hakjum =	0
		
		//dw_main이 성적표가 조회되는 datawindow
		dw_main2.dataobject = 'd_hjj208p_1_gai'
		dw_main2.setTransObject(sqlca)
		li_ans = dw_main2.retrieve(ls_hakbun1)
		
		if li_ans > 0 then	
			dw_main2.print()
		end if
	
	LOOP  WHILE TRUE
	
	CLOSE CUR_PRINT ;
	
elseif ls_gubun = '2' Then
	
	DECLARE CUR_PRINT_1 CURSOR  FOR
			SELECT	A.HAKBUN
			FROM		HAKSA.JAEHAK_HAKJUK A
			WHERE 	A.GWA			like :ls_hakgwa
			AND		A.HAKBUN		like :ls_hakbun
			AND		(	SELECT	SUM(DECODE(B.HWANSAN_JUMSU, 'F', 0, B.HAKJUM))	CHIDK
							FROM		HAKSA.SUGANG B
							WHERE		//B.SUNGJUK_INJUNG = 'Y'
							//AND		
							A.HAKBUN	=	B.HAKBUN
						)  + NVL(TO_NUMBER(A.INJUNG_HAKJUM), 0)	>= :li_hakjum
			AND		A.SANGTAE	=	'01'
			ORDER BY	A.GWA ASC,
						A.HAKBUN ASC
			USING SQLCA ;
	
	OPEN CUR_PRINT_1 ;
	DO 
		
		FETCH CUR_PRINT_1 INTO :ls_hakbun1 ;
	
		IF SQLCA.SQLCODE <> 0 THEN EXIT
	
		ls_hakgwa = '%'
		li_hakjum =	0
		
		//dw_main이 성적표가 조회되는 datawindow
		dw_main2.dataobject = 'd_hjj208p_2_gai'
		dw_main2.setTransObject(sqlca)
		li_ans = dw_main2.retrieve(ls_hakbun1)
	
		if li_ans > 0 then	
			dw_main2.print()
		end if
	
	LOOP  WHILE TRUE

	CLOSE CUR_PRINT_1 ;	

end if	

SetPointer(Arrow!)

MESSAGEBOX("확인","출력완료")



end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

