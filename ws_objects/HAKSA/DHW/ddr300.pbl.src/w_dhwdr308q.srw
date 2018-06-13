$PBExportHeader$w_dhwdr308q.srw
$PBExportComments$[대학원등록] 교육비 납입증명서
forward
global type w_dhwdr308q from w_condition_window
end type
type dw_main from uo_search_dwc within w_dhwdr308q
end type
type dw_con from uo_dwfree within w_dhwdr308q
end type
end forward

global type w_dhwdr308q from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_dhwdr308q w_dhwdr308q

on w_dhwdr308q.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_dhwdr308q.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakbun, ls_name, ls_chk
int li_cnt, li_ans

dw_con.AcceptText()

ls_year	  =  dw_con.Object.year[1]
ls_hakbun =	 dw_con.Object.hakbun[1]
ls_name   =	 dw_con.Object.hname[1]

if ls_hakbun =''or isnull(ls_hakbun) or ls_name ='' or isnull(ls_name) then
	messagebox("오류","학번이나 성명을 입력하세요")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("hakbun")
end if

//성명만으로 검색시
//같은 성명이 있으면 Popup Window를 사용하여 학번을 가져와서 조회
if ls_name <> '' then

	SELECT COUNT(*)
	INTO :li_cnt
	FROM HAKSA.D_HAKJUK
	WHERE HNAME	= :ls_name
	USING SQLCA ;
	
	if li_cnt >= 2 then
		openwithparm(w_dhw_search, ls_name)
		
		ls_hakbun = Message.StringParm
		
	elseif li_cnt = 1 then
		SELECT HAKBUN
		INTO :ls_hakbun
		FROM	HAKSA.D_HAKJUK
		WHERE	HNAME	=	:ls_name
		USING SQLCA ;
		
	else
		messagebox("오류","존재하지 않는 성명입니다.")
		return -1
	end if

else			// 성명이 입력되어 있지 않으면...학번만으로 검색...

	SELECT HAKBUN
	INTO :ls_chk
	FROM	HAKSA.D_HAKJUK
	WHERE	HAKBUN		= :ls_hakbun
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","존재하지않는 학번입니다..")
		dw_con.setfocus()
     	dw_con.SetColumn("hakbun")
		return -1
	end if
end if

li_ans = dw_main.retrieve(ls_year, ls_hakbun )

if li_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;String ls_year
idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	YEAR
INTO		:ls_year
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year

end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwdr308q
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwdr308q
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwdr308q
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwdr308q
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwdr308q
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwdr308q
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwdr308q
end type

type uc_insert from w_condition_window`uc_insert within w_dhwdr308q
end type

type uc_delete from w_condition_window`uc_delete within w_dhwdr308q
end type

type uc_save from w_condition_window`uc_save within w_dhwdr308q
end type

type uc_excel from w_condition_window`uc_excel within w_dhwdr308q
end type

type uc_print from w_condition_window`uc_print within w_dhwdr308q
end type

type st_line1 from w_condition_window`st_line1 within w_dhwdr308q
end type

type st_line2 from w_condition_window`st_line2 within w_dhwdr308q
end type

type st_line3 from w_condition_window`st_line3 within w_dhwdr308q
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwdr308q
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwdr308q
end type

type gb_1 from w_condition_window`gb_1 within w_dhwdr308q
end type

type gb_2 from w_condition_window`gb_2 within w_dhwdr308q
end type

type dw_main from uo_search_dwc within w_dhwdr308q
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dhwdr308q"
end type

type dw_con from uo_dwfree within w_dhwdr308q
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_dhwdr308q_c1"
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

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gubun'
		If Data = '1' Then
			dw_main.DataObject = 'd_dhwdr307q_1'
			dw_main.SetTransObject(Sqlca)
			dw_main.Modify("datawindow.print.preview=yes") 
		ElseIf Data = '2' Then
			dw_main.DataObject = 'd_dhwdr307q_2'
			dw_main.SetTransObject(Sqlca)
			dw_main.Modify("datawindow.print.preview=yes") 
		End IF
		
End Choose
end event

