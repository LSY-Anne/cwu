$PBExportHeader$w_commonfind.srw
forward
global type w_commonfind from w_commonresponse
end type
type st_1 from statictext within w_commonfind
end type
type dw_find from uo_dwlv within w_commonfind
end type
type dw_cond from datawindow within w_commonfind
end type
type st_2 from statictext within w_commonfind
end type
end forward

global type w_commonfind from w_commonresponse
integer width = 2021
integer height = 1700
string title = ""
st_1 st_1
dw_find dw_find
dw_cond dw_cond
st_2 st_2
end type
global w_commonfind w_commonfind

type variables
Vector		ivc_data
Long			il_row
String		is_findSyntax
end variables

forward prototypes
private function string wf_findsyntaxs ()
public subroutine wf_sle_find ()
end prototypes

private function string wf_findsyntaxs ();Long		ll_cnt, i
String 	ls_syntax, ls_type, ls_colname

ll_cnt = Long(dw_find.Object.DataWindow.Column.Count)

FOR i = ll_cnt TO 1 Step -1
	IF dw_find.Describe("#" + String(i) + ".Visible") = "1" THEN
		IF i < ll_cnt AND Len(ls_syntax) > 0 THEN ls_syntax += " or "		
		ls_colname = dw_find.Describe("#" + String(i) + ".Name")

		ls_type = dw_find.Describe(ls_colname + ".ColType")
		CHOOSE CASE TRUE
			CASE Pos(Upper(ls_type), 'CHAR', 1) > 0
				ls_syntax += "Pos(" + ls_colname + " , '{value}') > 0 "
			CASE ELSE
				ls_syntax += "Pos(lookupdisplay(" + ls_colname + ") , '{value}' ) > 0 "
		END CHOOSE
	END IF
NEXT

return ls_syntax
end function

public subroutine wf_sle_find ();String	ls_syntax

ls_syntax = is_findSyntax

dw_cond.acceptText()

replaceall(ls_syntax, "{value}", dw_cond.getItemString(1, 'find'))

il_row++

il_row = dw_find.Find(ls_syntax, il_row, dw_find.rowcount())

IF il_row > 0 THEN
	dw_find.setFocus()
	dw_find.scrolltorow(il_row)
	dw_find.setrow(il_row)
	dw_find.Event rowfocuschanged(il_row)
END IF
end subroutine

on w_commonfind.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_find=create dw_find
this.dw_cond=create dw_cond
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_find
this.Control[iCurrent+3]=this.dw_cond
this.Control[iCurrent+4]=this.st_2
end on

on w_commonfind.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_find)
destroy(this.dw_cond)
destroy(this.st_2)
end on

event key;call super::key;choose case key
	case keyenter!, KeyF3!
		choose case getfocus().classname()
			case 'dw_cond'
				IF key = KeyEnter! THEN il_row = 0
				wf_sle_find()
			end choose
	case KeyEscape!
		postevent('ue_close')
end choose
end event

event ue_ok;call super::ue_ok;Long	ll_row, ll_cnt, i
Vector lvc_data
String	ls_type, ls_val
lvc_data = Create Vector

ll_row = dw_find.getrow()

if ll_row < 1 then return

ll_cnt = ivc_data.getfindkeycount("fcol")

FOR i = ll_cnt TO 1 Step -1
	ls_val = ivc_data.getProperty('fcol' + String(i))
	ls_type = dw_find.Describe(ls_val + ".ColType")
	CHOOSE CASE TRUE
		CASE Pos(Upper(ls_type), 'CHAR', 1) > 0
			lvc_data.setProperty(ls_val, dw_find.GetItemString(ll_row, ls_val))
		CASE Pos(Upper(ls_type), 'ULONG', 1) > 0 OR Pos(Upper(ls_type), 'INT', 1) > 0 OR Pos(Upper(ls_type), 'LONG', 1) > 0 OR Pos(Upper(ls_type), 'REAL', 1) > 0 
			lvc_data.setProperty(ls_val, dw_find.GetItemNumber(ll_row, ls_val))
		CASE Pos(Upper(ls_type), 'DATETIME', 1) = 0 AND Pos(Upper(ls_type), 'DATE', 1) > 0
			lvc_data.setProperty(ls_val, dw_find.GetItemDate(ll_row, ls_val))
		CASE Pos(Upper(ls_type), 'DATETIME', 1) > 0 
			lvc_data.setProperty(ls_val, dw_find.GetItemDateTime(ll_row, ls_val))
		CASE Pos(Upper(ls_type), 'DECIMAL', 1) > 0
			lvc_data.setProperty(ls_val, dw_find.GetItemDecimal(ll_row, ls_val))
		CASE Pos(Upper(ls_type), 'TIME', 1) > 0 OR Pos(Upper(ls_type), 'TIMESTAMP', 1) > 0 
			lvc_data.setProperty(ls_val, dw_find.GetItemTime(ll_row, ls_val))
	END CHOOSE
NEXT

closewithreturn(this, lvc_data)
end event

event ue_cancel;call super::ue_cancel;Close(this)
end event

event ue_postopen;call super::ue_postopen;ivc_data = Message.PowerObjectParm

//key = find					찾을 문자열
//key = where					Select문에 whare절을 추가 해준다.
//key = title					Title를 지정해 준다.
//key = dataobject			Datawindow Dataobject를 Setting한다.
//key = fcol1, fcol2.....  Retun할 Datawindow의 Full ColumnName
//key = arg1, arg2 ....		Retrieve조건에 들어갈 아규먼트 

dw_cond.insertrow(0)

IF IsValid(ivc_data) THEN
	dw_find.dataobject = ivc_data.getProperty("dataobject")
	dw_find.Event Constructor()
	dw_find.setTransObject(sqlca)
	
	is_findSyntax = wf_findsyntaxs()
	
	dw_find.object.DataWindow.readonly = 'yes'
	
	this.title = ivc_data.getProperty("title")
	
	dw_cond.Object.find[1] = ivc_data.getProperty("find") 
	
	TriggerEvent('ue_retrieve')
	
	dw_cond.setColumn("find")
	dw_cond.setFocus()
	Trigger event key(keyenter!,0)
	dw_cond.setColumn("find")
	dw_cond.setFocus()
END IF
end event

event ue_retrieve;call super::ue_retrieve;Long  	ll_cnt, i, ll_row, ll_temp,ll_dh, ll_argcnt, j
String	ls_oldsql, ls_newsql, ls_temp
any		la_arg[]
ll_cnt = ivc_data.getfindkeycount('arg')

ls_temp = dw_find.Object.Datawindow.Table.Arguments
IF ls_temp <> '?' THEN
	replaceall(ls_temp, "~n", "&")
	replaceall(ls_temp, "~t", "=")
	
	Vector	lvc_data
	lvc_data = getconvertcommandparm(ls_temp)
	
	ll_cnt = lvc_data.getKeycount()
	FOR i = ll_cnt to 1 step -1
		la_arg[i] = ivc_data.getProperty('arg' + String(i))
	NEXT
END IF

ls_oldsql = dw_find.getSqlSelect()
IF ivc_data.getProperty("where") <> "" THEN
	ls_newsql = ls_oldsql + ivc_data.getProperty("where")
	dw_find.Object.Datawindow.Table.Select = ls_newsql
	//dw_find.setSqlSelect(ls_newsql)
END IF

IF ll_cnt = 0 THEN
	dw_find.retrieve()
ELSE
	choose case ll_cnt
		case 1
			dw_find.retrieve(la_arg[1])
		case 2
			dw_find.retrieve(la_arg[1], la_arg[2])
		case 3
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3])
		case 4
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4])
		case 5
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5])
		case 6
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6])
		case 7
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7])
		case 8
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8])
		case 9
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9])
		case 10
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10])
		case 11
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10] + &
							   la_arg[11])
		case 12
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10] + &
							   la_arg[11], la_arg[12])
		case 13
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10] + &
							   la_arg[11], la_arg[12], la_arg[13])
		case 14
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10] + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14])
		case 15
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10] + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15])
		case 16
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], + &
							   la_arg[16])
		case 17
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], + &
							   la_arg[16], la_arg[17])
		case 18
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], + &
							   la_arg[16], la_arg[17], la_arg[18])
		case 19
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], + &
							   la_arg[16], la_arg[17], la_arg[18], la_arg[19])
		case 20
			dw_find.retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], + &
							   la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], + &
							   la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], + &
							   la_arg[16], la_arg[17], la_arg[18], la_arg[19], la_arg[20])
	end choose
END IF

dw_find.Object.Datawindow.Table.Select = ls_oldsql
end event

type uc_retrieve from w_commonresponse`uc_retrieve within w_commonfind
boolean visible = false
end type

type uc_cancel from w_commonresponse`uc_cancel within w_commonfind
integer x = 1687
integer y = 40
integer width = 274
integer height = 84
end type

type uc_close from w_commonresponse`uc_close within w_commonfind
boolean visible = false
end type

type uc_ok from w_commonresponse`uc_ok within w_commonfind
integer x = 1394
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type ln_templeft from w_commonresponse`ln_templeft within w_commonfind
end type

type ln_temptop from w_commonresponse`ln_temptop within w_commonfind
end type

type ln_tempbutton from w_commonresponse`ln_tempbutton within w_commonfind
end type

type ln_tempstart from w_commonresponse`ln_tempstart within w_commonfind
end type

type ln_4 from w_commonresponse`ln_4 within w_commonfind
integer beginy = 1572
integer endy = 1572
end type

type ln_tempright from w_commonresponse`ln_tempright within w_commonfind
integer beginx = 1957
integer endx = 1957
end type

type st_1 from statictext within w_commonfind
integer x = 46
integer y = 320
integer width = 1915
integer height = 1256
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
long bordercolor = 29992855
boolean focusrectangle = false
end type

type dw_find from uo_dwlv within w_commonfind
event ue_key pbm_dwnkey
string tag = "settrans=true"
integer x = 46
integer y = 324
integer width = 1915
integer height = 1248
integer taborder = 40
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
string linecolor = "185,190,195"
string rowselectcolor = "250,241,237"
string hotbackcolor = "240,240,240"
string nobackcolor = "255,255,255"
string graysepcolor = "185,190,195"
string graysepcolor2 = "240,240,240"
string hotlinecolor = "185,190,195"
string nomallinecolor = "230,230,230"
string alternatefirstcolor = "255,255,255"
string nofontcolor = "50,50,50"
string hotfontcolor = "50,50,50"
end type

event ue_key;choose case key
	case keyenter!
		parent.event ue_ok()
	CASE keyF3!
		wf_sle_find()
end choose	
end event

event doubleclicked;call super::doubleclicked;IF row > 0 THEN Parent.TriggerEvent("ue_ok")




end event

type dw_cond from datawindow within w_commonfind
event ue_key pbm_dwnkey
integer x = 46
integer y = 164
integer width = 1915
integer height = 128
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_findcond"
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event ue_key;choose case key
	case keyenter!, KeyF3!
		IF key = KeyEnter! THEN il_row = 0
		wf_sle_find()
END CHOOSE

end event

event clicked;IF row > 0 THEN
	IF dwo.name = 'p_find' THEN
		il_row = 0
		wf_sle_find()
	END IF
END IF
end event

type st_2 from statictext within w_commonfind
integer x = 46
integer y = 160
integer width = 1915
integer height = 136
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
long bordercolor = 29992855
boolean focusrectangle = false
end type

