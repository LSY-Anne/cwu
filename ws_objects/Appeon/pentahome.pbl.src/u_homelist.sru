$PBExportHeader$u_homelist.sru
forward
global type u_homelist from userobject
end type
type p_more from picture within u_homelist
end type
type p_2 from picture within u_homelist
end type
type st_title from statictext within u_homelist
end type
type dw_1 from uo_dwlv within u_homelist
end type
type st_1 from statictext within u_homelist
end type
end forward

global type u_homelist from userobject
integer width = 1829
integer height = 1292
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_retrieve ( )
event ue_callparentevent ( )
event ue_resize ( long wpos,  long hpos )
p_more p_more
p_2 p_2
st_title st_title
dw_1 dw_1
st_1 st_1
end type
global u_homelist u_homelist

type variables
private:
	String 	is_parentevent
	vector   	ivc

end variables

forward prototypes
public function string getwindow ()
public function string getwindowopenstyle ()
end prototypes

event ue_retrieve();Long  ll_cnt, i, ll_row, ll_temp,ll_dh
String	ls_oldsql, ls_newsql, ls_temp
any	la_arg[]
ll_cnt = ivc.getfindkeycount('arg')

FOR i = ll_cnt to 1 step -1
	la_arg[i] = ivc.getProperty('arg' + String(i))
NEXT

dw_1.SetTransObject(sqlca)

//ls_oldsql = dw_1.getSqlSelect()
//ll_row = LastPos(Upper(ls_oldsql), 'WHERE')
//
//IF ll_row = 0 THEN
//	ls_newsql = ls_oldsql + " where "
//ELSE
//	//ll_row = pos(Upper(ls_oldsql), 'FROM', ll_row + 1)
//	ls_newsql = ls_oldsql + " and "
//END IF

ll_temp = long(dw_1.describe("DataWindow.Header.Height + DataWindow.Summary.Height + DataWindow.Footer.Height"))
ll_temp = dw_1.height - ll_temp
ll_dh = long(dw_1.describe("DataWindow.Detail.Height"))
if mod(ll_temp, ll_dh) > 0 then
	ll_temp = Truncate(ll_temp / ll_dh, 0) - 1
else
	ll_temp = truncate(ll_temp / ll_dh, 0)
end if

//ls_newsql += ' ROW_NUMBER() <= ' + String(ll_temp)
//ls_newsql += ' rownum <= ' + String(ll_temp)

//dw_1.Object.DataWindow.Table.Select = ls_newsql

IF ll_cnt = 0 THEN
	dw_1.retrieve()
ELSE
	choose case ll_cnt
		case 1
			dw_1.retrieve(la_arg[1])
		case 2
			dw_1.retrieve(la_arg[1], la_arg[2])
		case 3
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3])
		case 4
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4])
		case 5
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5])
		case 6
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6])
		case 7
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7])
		case 8
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8])
		case 9
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9])
		case 10
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10])
		case 11
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10] + &
							   la_arg[11])
		case 12
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10] + &
							   la_arg[11], la_arg[12])
		case 13
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10] + &
							   la_arg[11], la_arg[12], la_arg[13])
		case 14
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10] + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14])
		case 15
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10] + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15])
		case 16
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], + &
							   la_arg[16])
		case 17
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], + &
							   la_arg[16], la_arg[17])
		case 18
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], + &
							   la_arg[16], la_arg[17], la_arg[18])
		case 19
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], + &
							   la_arg[16], la_arg[17], la_arg[18], la_arg[19])
		case 20
			dw_1.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], + &
							   la_arg[16], la_arg[17], la_arg[18], la_arg[19], la_arg[20])
	end choose
END IF

dw_1.setsqlselect(ls_oldsql)
end event

event ue_callparentevent();Parent.Dynamic Event ue_openwindow(ivc)


	


end event

event ue_resize(long wpos, long hpos);this.width = wpos
this.height = hpos

st_1.y = st_title.y + st_title.height + pixelstounits(1, ypixelstounits!)
st_1.width = this.width - pixelstounits(4, xpixelstounits!)
st_1.height = this.height - st_title.y - st_title.height - pixelstounits(1, ypixelstounits!)

dw_1.x = st_1.x// + pixelstounits(1, xpixelstounits!)
dw_1.y = st_1.y + pixelstounits(1, ypixelstounits!)
dw_1.width = st_1.width// - pixelstounits(2, xpixelstounits!)
dw_1.height = st_1.height - pixelstounits(2, ypixelstounits!)
dw_1.of_resize()

p_more.x = dw_1.x + dw_1.width - p_more.width
p_more.y = p_2.y + PixelsToUnits(2, YPixelsToUnits!)
end event

public function string getwindow ();String ls_rtn = ""

IF IsValid(ivc) THEN
	ls_rtn = ivc.getproperty('window')
END IF

return ls_rtn
end function

public function string getwindowopenstyle ();String ls_rtn = ""

IF IsValid(ivc) THEN
	ls_rtn = ivc.getproperty('openstyle')
END IF

return ls_rtn
end function

on u_homelist.create
this.p_more=create p_more
this.p_2=create p_2
this.st_title=create st_title
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.p_more,&
this.p_2,&
this.st_title,&
this.dw_1,&
this.st_1}
end on

on u_homelist.destroy
destroy(this.p_more)
destroy(this.p_2)
destroy(this.st_title)
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;ivc = Message.PowerObjectparm
IF IsValid(ivc) THEN
	st_title.text = ivc.getproperty("title")
	dw_1.dataobject = ivc.getproperty("dataobject")
END IF

end event

type p_more from picture within u_homelist
integer x = 1678
integer y = 64
integer width = 123
integer height = 36
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "..\img\icon\home_more.gif"
boolean focusrectangle = false
end type

event clicked;long  ll_cnt, i
ll_cnt 	= ivc.getfindkeycount('column')
for i = ll_cnt to 1 step -1
	ivc.removeproperty(ivc.getproperty('key' + String(i)))
next

Parent.Post event ue_callparentevent()
end event

type p_2 from picture within u_homelist
integer x = 14
integer y = 44
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_title from statictext within u_homelist
integer x = 73
integer y = 40
integer width = 1138
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 25454675
long backcolor = 16777215
boolean focusrectangle = false
end type

event clicked;//dw_1.Post of_resize()
end event

type dw_1 from uo_dwlv within u_homelist
event ue_mousemove pbm_dwnmousemove
integer y = 128
integer width = 1824
integer height = 1160
integer taborder = 10
boolean border = false
end type

event constructor;call super::constructor;this.SetPosition(totop!)


end event

event doubleclicked;call super::doubleclicked;String  	ls_val, ls_type
long		ll_cnt, i

IF row > 0 THEN
	ll_cnt = ivc.getfindkeycount('column')
	for i = ll_cnt to 1 step -1
		ls_val = ivc.getproperty('column' + String(i))
		
		ls_type = dw_1.Describe(ls_val + ".ColType")
		CHOOSE CASE TRUE
			CASE Pos(Upper(ls_type), 'CHAR', 1) > 0
				ls_type	 	= dw_1.GetItemString(row, ls_val)
			CASE Pos(Upper(ls_type), 'ULONG', 1) > 0 OR Pos(Upper(ls_type), 'INT', 1) > 0 OR Pos(Upper(ls_type), 'LONG', 1) > 0 OR Pos(Upper(ls_type), 'REAL', 1) > 0 
				ls_type	 	= String(dw_1.GetItemNumber(row, ls_val))
			CASE Pos(Upper(ls_type), 'DATETIME', 1) = 0 AND Pos(Upper(ls_type), 'DATE', 1) > 0
				ls_type	 	= String(dw_1.GetItemDate(row, ls_val))
			CASE Pos(Upper(ls_type), 'DATETIME', 1) > 0 
				ls_type	 	= String(dw_1.GetItemDateTime(row, ls_val))
			CASE Pos(Upper(ls_type), 'DECIMAL', 1) > 0
				ls_type	 	= String(dw_1.GetItemDecimal(row, ls_val))
			CASE Pos(Upper(ls_type), 'TIME', 1) > 0 OR Pos(Upper(ls_type), 'TIMESTAMP', 1) > 0 
				ls_type	 	= String(dw_1.GetItemTime(row, ls_val))
			CASE ELSE
				ls_type 		= ivc.getproperty('defaultval' + String(i))
		END CHOOSE
		ivc.setproperty(ivc.getproperty('key' + String(i)), ls_type)
	next
	
	Parent.post event ue_callparentevent()
END IF
end event

type st_1 from statictext within u_homelist
integer y = 124
integer width = 1824
integer height = 1168
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
long bordercolor = 29738437
boolean focusrectangle = false
end type

