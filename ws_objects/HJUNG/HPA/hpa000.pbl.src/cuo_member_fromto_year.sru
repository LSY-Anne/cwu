$PBExportHeader$cuo_member_fromto_year.sru
$PBExportComments$개인번호 From, To로 선택할 수 있다.
forward
global type cuo_member_fromto_year from userobject
end type
type dw_end_member from datawindow within cuo_member_fromto_year
end type
type dw_str_member from datawindow within cuo_member_fromto_year
end type
type st_6 from statictext within cuo_member_fromto_year
end type
type pb_str_find from picturebutton within cuo_member_fromto_year
end type
type pb_end_find from picturebutton within cuo_member_fromto_year
end type
end forward

global type cuo_member_fromto_year from userobject
integer width = 2167
integer height = 92
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchanged ( )
dw_end_member dw_end_member
dw_str_member dw_str_member
st_6 st_6
pb_str_find pb_str_find
pb_end_find pb_end_find
end type
global cuo_member_fromto_year cuo_member_fromto_year

type variables
datawindowchild	uidw_str_child, uidw_end_child

string		uis_str_member, uis_end_member

end variables

forward prototypes
public function string uf_end_member ()
public function string uf_str_member ()
public subroutine uf_getchild (string as_year, integer ai_str_jikjong, integer ai_end_jikjong, string as_dept_code, integer ai_jaejik_opt)
end prototypes

public function string uf_end_member ();// ==========================================================================================
// 기    능 : 	get end member_no
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	uf_end_member()	return	string
// 인    수 :
// 되 돌 림 :	end member_no
// 주의사항 :
// 수정사항 :
// ==========================================================================================

return	uis_end_member
end function

public function string uf_str_member ();// ==========================================================================================
// 기    능 : 	get start member_no
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	uf_str_member()	return	string
// 인    수 :
// 되 돌 림 :	start member_no
// 주의사항 :
// 수정사항 :
// ==========================================================================================

return	uis_str_member
end function

public subroutine uf_getchild (string as_year, integer ai_str_jikjong, integer ai_end_jikjong, string as_dept_code, integer ai_jaejik_opt);// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	uf_getchild(string as_year, integer ai_str_jikjong, integer ai_end_jikjong, string as_dept_code, integer ai_jaejik_opt)
// 인    수 :	as_year			-	기준년도
//					ai_str_jikjong	-	start jikjong
//					ai_end_jikjong	-	end jikjong
//					as_dept_code	-	부서코드
//					ai_jaejik_opt	-	재직구분
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 개인번호(Start)
dw_str_member.reset()
dw_str_member.insertrow(0)

dw_str_member.getchild('code', uidw_str_child)
uidw_str_child.settransobject(sqlca)

uidw_str_child.setfilter("")
uidw_str_child.filter()

if uidw_str_child.retrieve(ai_str_jikjong, ai_end_jikjong, as_dept_code) < 1 then
	uidw_str_child.reset()
	uidw_str_child.insertrow(0)
end if

// 재직구분에 따라서 1=재직, 퇴직예정, 휴직
//                   3=퇴직, 정년퇴직
if ai_jaejik_opt = 1 then
	uidw_str_child.setfilter("jaejik_opt in (1, 2, 4)")
	uidw_str_child.filter()
elseif ai_jaejik_opt = 3 then
	uidw_str_child.setfilter("jaejik_opt not in (1, 2, 4) and  left(retire_date, 4) = '" + as_year + "'	")
	uidw_str_child.filter()
end if

uidw_str_child.setsort('member_no')
uidw_str_child.sort()


// 개인번호(End)
dw_end_member.reset()
dw_end_member.insertrow(0)

dw_end_member.getchild('code', uidw_end_child)
uidw_end_child.settransobject(sqlca)

uidw_end_child.setfilter("")
uidw_end_child.filter()

if uidw_end_child.retrieve(ai_str_jikjong, ai_end_jikjong, as_dept_code) < 1 then
	uidw_end_child.reset()
	uidw_end_child.insertrow(0)
end if

// 재직구분에 따라서 1=재직, 퇴직예정, 휴직
//                   3=퇴직, 정년퇴직
if ai_jaejik_opt = 1 then
	uidw_end_child.setfilter("jaejik_opt in (1, 2, 4)")
	uidw_end_child.filter()
elseif ai_jaejik_opt = 3 then
	uidw_end_child.setfilter("jaejik_opt not in (1, 2, 4) and  left(retire_date, 4) = '" + as_year + "'	")
	uidw_end_child.filter()
end if

uidw_end_child.setsort('member_no')
uidw_end_child.sort()

end subroutine

on cuo_member_fromto_year.create
this.dw_end_member=create dw_end_member
this.dw_str_member=create dw_str_member
this.st_6=create st_6
this.pb_str_find=create pb_str_find
this.pb_end_find=create pb_end_find
this.Control[]={this.dw_end_member,&
this.dw_str_member,&
this.st_6,&
this.pb_str_find,&
this.pb_end_find}
end on

on cuo_member_fromto_year.destroy
destroy(this.dw_end_member)
destroy(this.dw_str_member)
destroy(this.st_6)
destroy(this.pb_str_find)
destroy(this.pb_end_find)
end on

event constructor;uis_str_member	=	'     '
uis_end_member	=	'zzzzz'

end event

type dw_end_member from datawindow within cuo_member_fromto_year
event ue_dwnkey pbm_dwnkey
integer x = 1129
integer width = 946
integer height = 96
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_insa_all"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;if key = keyenter! or key = keyF1! then	
	accepttext()
	pb_end_find.triggerevent(clicked!)
end if
end event

event itemchanged;long		ll_row

if trim(data) = '' then	
	uis_end_member	=	'zzzzz'
else
	uis_end_member	=	trim(data)
end if

ll_row = uidw_end_child.find("member_no = '" + uis_end_member + "'	", 1, uidw_end_child.rowcount())
if ll_row > 0 then	
	uidw_end_child.scrolltorow(ll_row)
	dw_end_member.setitem(dw_end_member.getrow(), 'code',	uidw_end_child.getitemstring(ll_row, 'member_no') + '   ' + uidw_end_child.getitemstring(ll_row, 'name'))
end if

parent.triggerevent('ue_itemchanged')
end event

event losefocus;accepttext()
end event

type dw_str_member from datawindow within cuo_member_fromto_year
event ue_dwnkey pbm_dwnkey
integer width = 946
integer height = 96
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_insa_all"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;if key = keyenter! or key = keyF1! then	
	accepttext()
	pb_str_find.triggerevent(clicked!)
end if
end event

event itemchanged;long		ll_row

if trim(data) = '' then	
	uis_str_member	=	'     '
else
	uis_str_member	=	trim(data)
end if

ll_row = uidw_str_child.find("member_no = '" + uis_str_member + "'	", 1, uidw_str_child.rowcount())
if ll_row > 0 then
	uidw_str_child.scrolltorow(ll_row)
	dw_str_member.setitem(dw_str_member.getrow(), 'code',	uidw_str_child.getitemstring(ll_row, 'member_no') + '   ' + uidw_str_child.getitemstring(ll_row, 'name'))
	uis_end_member = uis_str_member

	uidw_end_child.scrolltorow(ll_row)
	dw_end_member.setitem(dw_end_member.getrow(), 'code',	uidw_end_child.getitemstring(ll_row, 'member_no') + '   ' + uidw_end_child.getitemstring(ll_row, 'name'))
end if

parent.triggerevent('ue_itemchanged')
end event

event losefocus;accepttext()
end event

type st_6 from statictext within cuo_member_fromto_year
integer x = 1033
integer y = 20
integer width = 91
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_str_find from picturebutton within cuo_member_fromto_year
integer x = 933
integer width = 101
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "..\img\icon\ib_search.gif"
string disabledname = "..\bmp\QUERY_S.bmp"
alignment htextalign = left!
end type

event clicked;s_insa_com	lstr_com
string		ls_kname
long			ll_row

ls_kname	=	''

if trim(uis_str_member) = '' or not isnumber(trim(uis_str_member)) then	
	ls_kname			=	trim(uis_str_member)
	uis_str_member	=	''
end if
	
lstr_com.ls_item[1] = ls_kname					// 성명
lstr_com.ls_item[2] = uis_str_member				// 개인번호

OpenWithParm(w_hin000h_hpa, lstr_com)

lstr_com = Message.PowerObjectParm

IF NOT isValid(lstr_com) THEN
	dw_str_member.setfocus()
	return
END IF

uis_str_member	=	lstr_com.ls_item[2]

ll_row = uidw_str_child.find("member_no = '" + uis_str_member + "'	", 1, uidw_str_child.rowcount())
if ll_row > 0 then
	uidw_str_child.scrolltorow(ll_row)
	dw_str_member.setitem(dw_str_member.getrow(), 'code',	uidw_str_child.getitemstring(ll_row, 'member_no') + '   ' + uidw_str_child.getitemstring(ll_row, 'name'))
	uis_end_member = uis_str_member

	uidw_end_child.scrolltorow(ll_row)
	dw_end_member.setitem(dw_end_member.getrow(), 'code',	uidw_end_child.getitemstring(ll_row, 'member_no') + '   ' + uidw_end_child.getitemstring(ll_row, 'name'))
	uidw_str_child.scrolltorow(ll_row)
end if

parent.triggerevent('ue_itemchanged')
end event

type pb_end_find from picturebutton within cuo_member_fromto_year
integer x = 2062
integer width = 101
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "..\img\icon\ib_search.gif"
string disabledname = "..\bmp\QUERY_S.bmp"
alignment htextalign = left!
end type

event clicked;s_insa_com	lstr_com
string		ls_kname
long			ll_row

ls_kname	=	''

if trim(uis_end_member) = '' or not isnumber(trim(uis_end_member)) then	
	ls_kname			=	trim(uis_end_member)
	uis_end_member	=	''
end if
	
lstr_com.ls_item[1] = ls_kname					// 성명
lstr_com.ls_item[2] = uis_end_member				// 개인번호

OpenWithParm(w_hin000h_hpa, lstr_com)

lstr_com = Message.PowerObjectParm

IF NOT isValid(lstr_com) THEN
	dw_end_member.setfocus()
	return
END IF

uis_end_member	=	lstr_com.ls_item[2]

ll_row = uidw_end_child.find("member_no = '" + uis_end_member + "'	", 1, uidw_end_child.rowcount())
if ll_row > 0 then
	uidw_end_child.scrolltorow(ll_row)
	dw_end_member.setfocus()
end if

parent.triggerevent('ue_itemchanged')
end event

