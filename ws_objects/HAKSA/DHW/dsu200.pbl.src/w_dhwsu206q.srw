$PBExportHeader$w_dhwsu206q.srw
$PBExportComments$[대학원수업] 누계성적조회
forward
global type w_dhwsu206q from w_condition_window
end type
type dw_2 from uo_input_dwc within w_dhwsu206q
end type
type dw_con from uo_dwfree within w_dhwsu206q
end type
type st_hakjuk from statictext within w_dhwsu206q
end type
type dw_1 from uo_dwfree within w_dhwsu206q
end type
end forward

global type w_dhwsu206q from w_condition_window
dw_2 dw_2
dw_con dw_con
st_hakjuk st_hakjuk
dw_1 dw_1
end type
global w_dhwsu206q w_dhwsu206q

on w_dhwsu206q.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_con=create dw_con
this.st_hakjuk=create st_hakjuk
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.st_hakjuk
this.Control[iCurrent+4]=this.dw_1
end on

on w_dhwsu206q.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_con)
destroy(this.st_hakjuk)
destroy(this.dw_1)
end on

event ue_retrieve;call super::ue_retrieve;
string ls_hakbun, ls_name, ls_gwa_name,	ls_jungong_name,	ls_hakgicha
int li_cnt, li_ans

dw_con.AcceptText()

ls_hakbun    =  dw_con.Object.hakbun[1]
ls_name		=	dw_con.Object.hname[1]

if (ls_hakbun = '' or isnull(ls_hakbun)) and (ls_name = '' or isnull(ls_name)) then
	messagebox("오류","학번이나 성명을 입력하세요")
	return -1
end if

//성명만으로 검색시
//같은 성명이 있으면 Popup Window를 사용하여 학번을 가져와서 조회
if ls_name <> '' then

	SELECT COUNT(*)
	INTO :li_cnt
	FROM	HAKSA.D_HAKJUK
	WHERE HNAME	= :ls_name 
	USING SQLCA ;
	
	if li_cnt >= 2 then
		openwithparm(w_dhw_search, ls_name)
		
		ls_hakbun = Message.StringParm
		
	elseif li_cnt = 1 then
		SELECT	A.HAKBUN,	A.HNAME,		B.GWA_HNAME,	C.JUNGONG_HNAME,	A.S_HAKGICHA
		INTO		:ls_hakbun,	:ls_name,	:ls_gwa_name,	:ls_jungong_name,	:ls_hakgicha
		FROM	HAKSA.d_HAKJUK			A,
				HAKSA.D_GWA_CODE		B,
				HAKSA.D_JUNGONG_CODE	C
		WHERE	A.GWA_ID			=	b.GWA_ID		
		AND	A.JUNGONG_ID	=	C.JUNGONG_ID
		AND	A.HNAME			=	:ls_name 
		USING SQLCA ;
		
	else
		messagebox("오류","존재하지 않는 성명입니다.")
		return -1
	end if

else			// 성명이 입력되어 있지 않으면...학번만으로 검색...

	SELECT	A.HNAME,		B.GWA_HNAME,	C.JUNGONG_HNAME,	A.S_HAKGICHA
	INTO		:ls_name,	:ls_gwa_name,	:ls_jungong_name,	:ls_hakgicha
	FROM	HAKSA.d_HAKJUK			A,
			HAKSA.D_GWA_CODE		B,
			HAKSA.D_JUNGONG_CODE	C
	WHERE	A.GWA_ID			=	b.GWA_ID		
	AND	A.JUNGONG_ID	=	C.JUNGONG_ID
	AND	A.hakbun			=	:ls_hakbun 
	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","존재하지않는 학번입니다..")
		dw_con.setfocus()
		dw_con.SetColumn("hakbun")
		return -1
	end if
end if

li_ans = dw_1.retrieve(ls_hakbun )
li_ans = dw_2.retrieve(ls_hakbun )

st_hakjuk.text =  ls_name + ' ' + ls_gwa_name + ' ' + ls_jungong_name + ' ' + ls_hakgicha

if li_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;
dw_1.SetTransObject(sqlca)
dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwsu206q
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwsu206q
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwsu206q
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwsu206q
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwsu206q
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwsu206q
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwsu206q
end type

type uc_insert from w_condition_window`uc_insert within w_dhwsu206q
end type

type uc_delete from w_condition_window`uc_delete within w_dhwsu206q
end type

type uc_save from w_condition_window`uc_save within w_dhwsu206q
end type

type uc_excel from w_condition_window`uc_excel within w_dhwsu206q
end type

type uc_print from w_condition_window`uc_print within w_dhwsu206q
end type

type st_line1 from w_condition_window`st_line1 within w_dhwsu206q
end type

type st_line2 from w_condition_window`st_line2 within w_dhwsu206q
end type

type st_line3 from w_condition_window`st_line3 within w_dhwsu206q
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwsu206q
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwsu206q
end type

type gb_1 from w_condition_window`gb_1 within w_dhwsu206q
end type

type gb_2 from w_condition_window`gb_2 within w_dhwsu206q
end type

type dw_2 from uo_input_dwc within w_dhwsu206q
integer x = 64
integer y = 604
integer width = 4370
integer height = 1660
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwsu206q_2"
end type

type dw_con from uo_dwfree within w_dhwsu206q
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dhwsu206q_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_hakjuk from statictext within w_dhwsu206q
integer x = 119
integer y = 52
integer width = 1659
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 32500968
boolean focusrectangle = false
end type

type dw_1 from uo_dwfree within w_dhwsu206q
integer x = 55
integer y = 292
integer width = 4375
integer height = 292
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_dhwsu206q_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

