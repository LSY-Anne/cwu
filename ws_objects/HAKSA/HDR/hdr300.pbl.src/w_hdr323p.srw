$PBExportHeader$w_hdr323p.srw
$PBExportComments$[청운대]등록금고지서출력(경리과용)
forward
global type w_hdr323p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hdr323p
end type
type dw_con from uo_dwfree within w_hdr323p
end type
type uo_1 from uo_imgbtn within w_hdr323p
end type
end forward

global type w_hdr323p from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hdr323p w_hdr323p

on w_hdr323p.create
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

on w_hdr323p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;string 	ls_year, ls_hakgi, ls_hakyun, ls_gwa, ls_hakbun, ls_name
long 		ll_ans
Int          li_count

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun   =  dw_con.Object.hakbun[1]
ls_name     =  dw_con.Object.hname[1]

if ls_year = '' or isnull(ls_year) or ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","년도, 학기를 입력하세요.")
	return -1
end if

if len(trim(ls_hakbun)) = 0 and len(trim(ls_name)) = 0 then
	messagebox("확인","학번 또는 성명을 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return -1
end if

SELECT	count( JAEHAK_HAKJUK.HAKBUN )  
INTO		:li_count
FROM		HAKSA.JAEHAK_HAKJUK  
WHERE	( JAEHAK_HAKJUK.HAKBUN	LIKE :ls_hakbun||'%'	)	AND
			( JAEHAK_HAKJUK.HNAME	LIKE :ls_name||'%')
USING SQLCA ;
			
if li_count = 0 then
	messagebox("확인", "해당 학생은 존재하지 않습니다.!", Exclamation!)
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return -1
	
elseif li_count =1 then

		SELECT	JAEHAK_HAKJUK.HAKBUN,
					JAEHAK_HAKJUK.HNAME
		INTO		:ls_hakbun,
					:ls_name
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE	( JAEHAK_HAKJUK.HNAME	like :ls_name||'%'	)
		and		( JAEHAK_HAKJUK.HAKBUN	like :ls_hakbun||'%'	)
		USING SQLCA ;

	dw_con.Object.hname[1] = ls_name
		
elseif li_count >=2 then
	
//	OpenWithParm(w_hdr104pp, ls_name)	
	ls_hakbun	= Message.StringParm
	dw_con.Object.hname[1] = ls_name

end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr323p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr323p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr323p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr323p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr323p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr323p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr323p
end type

type uc_insert from w_condition_window`uc_insert within w_hdr323p
end type

type uc_delete from w_condition_window`uc_delete within w_hdr323p
end type

type uc_save from w_condition_window`uc_save within w_hdr323p
end type

type uc_excel from w_condition_window`uc_excel within w_hdr323p
end type

type uc_print from w_condition_window`uc_print within w_hdr323p
end type

type st_line1 from w_condition_window`st_line1 within w_hdr323p
end type

type st_line2 from w_condition_window`st_line2 within w_hdr323p
end type

type st_line3 from w_condition_window`st_line3 within w_hdr323p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr323p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr323p
end type

type gb_1 from w_condition_window`gb_1 within w_hdr323p
end type

type gb_2 from w_condition_window`gb_2 within w_hdr323p
end type

type dw_main from uo_search_dwc within w_hdr323p
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hdr323p_1"
end type

type dw_con from uo_dwfree within w_hdr323p
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_hdr323p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'hakbun'
		This.Post SetItem(row, "hname", '')
	Case 'hname'
		This.Post SetItem(row, "hakbun", '')
End Choose
end event

type uo_1 from uo_imgbtn within w_hdr323p
integer x = 713
integer y = 40
integer width = 471
integer taborder = 20
boolean bringtotop = true
string btnname = "공지사항등록"
end type

event clicked;call super::clicked;string ls_year, ls_hakgi

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
openwithparm(w_hdr204pp_1, ls_year + ls_hakgi)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

