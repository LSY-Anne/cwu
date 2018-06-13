$PBExportHeader$w_emp_code.srw
forward
global type w_emp_code from w_default_response
end type
type dw_cond from datawindow within w_emp_code
end type
type sle_1 from singlelineedit within w_emp_code
end type
type r_2 from rectangle within w_emp_code
end type
type r_1 from rectangle within w_emp_code
end type
end forward

global type w_emp_code from w_default_response
integer width = 1737
string title = "사원 조회"
dw_cond dw_cond
sle_1 sle_1
r_2 r_2
r_1 r_1
end type
global w_emp_code w_emp_code

type variables
CONSTANT LONG SINGLE = 1
CONSTANT LONG MULTY = 2
CONSTANT LONG COPY = 3

Boolean		ib_multi	= False

vector         ivc
end variables

forward prototypes
public function integer wf_rolecopy ()
end prototypes

public function integer wf_rolecopy ();String 		ls_temp, ls_sql, ls_empcode, ls_roleno[]
Long			ll_cnt, i, ll_row, j, ll_empcnt, ll_check
datastore	lds_data, lds_set

lds_data = create datastore
lds_set = create datastore

ls_empcode = ivc.getproperty('emp_code')

lds_data.dataobject = 'd_role_search'
lds_data.settransobject(sqlca)

lds_set.dataobject = 'd_userrole'
lds_set.settransobject(sqlca)

ls_temp = lds_data.GetSqlSelect()
ls_sql = ls_temp + ",  cddb.pf_userrole			b	~r~n" + &
			" where 	a.role_no		= b.role_no ~r~n" + &
			"     and  b.emp_code		= '" + ls_empcode + "'"
lds_data.SetSqlSelect(ls_sql)	
ll_cnt = lds_data.retrieve()
lds_data.SetSqlSelect(ls_temp)

ls_roleno = lds_data.object.role_no.primary

lds_set.retrieve(ls_roleno)
ll_empcnt = dw_multi.rowcount()
for i = ll_cnt to 1 step -1
	j = 1
	do while true
		j = dw_multi.find('checkbox = 1', j, ll_empcnt)
		if j = 0 then exit
		ls_empcode =  dw_multi.GetItemString(j, 'emp_code')
		ll_row = lds_set.find("role_no = '" + ls_roleno[i] + "' and emp_code = '" + ls_empcode + "'", 1, ll_cnt)
		if ll_row = 0 then
			ll_check = lds_set.insertrow(0)
			lds_set.setitem(ll_check, 'role_no', ls_roleno[i])
			lds_set.setitem(ll_check, 'emp_code', ls_empcode)
		end if
		j++
		if j > ll_empcnt then exit
	loop
next

if lds_set.update() < 0 then
	ROLLBACK USING SQLCA;
	messagebox('INFO', 'ROLE COPY ERROR')
	ll_row = -1
ELSE
	COMMIT USING SQLCA;
	ll_row = 1
end if

return ll_row
end function

on w_emp_code.create
int iCurrent
call super::create
this.dw_cond=create dw_cond
this.sle_1=create sle_1
this.r_2=create r_2
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cond
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.r_2
this.Control[iCurrent+4]=this.r_1
end on

on w_emp_code.destroy
call super::destroy
destroy(this.dw_cond)
destroy(this.sle_1)
destroy(this.r_2)
destroy(this.r_1)
end on

event ue_postopen;call super::ue_postopen;Long		ll_parm, i, ll_cnt
String	ls_rtn
String	ls_column[2] = {'code', 'name'}

dw_multi.SetTransObject(sqlca)
uc_retrieve.of_enable(true)
uc_ok.of_enable(true)
uc_cancel.of_enable(true)

dw_cond.insertrow(0)
dw_cond.SetItem(1, 'type', 1)

ivc = Message.PowerObjectParm
IF IsValid(ivc) THEN
	//ll_parm = Long(lstr_data.row[1].data[1])
	ll_parm = Long(ivc.getproperty('type'))
	IF ll_parm = COPY THEN sle_1.text = ivc.getproperty('title')
	IF ll_parm = MULTY OR ll_parm = COPY THEN
		ls_rtn = dw_multi.Modify('checkbox.protect=0')
		IF ls_rtn = '!' THEN Messagebox("Info", 'dw_multy Modify Error')
		ib_multi = True
	ELSE
		ls_rtn = dw_multi.Modify('checkbox.protect=1')
		IF ls_rtn = '!' THEN Messagebox("Info", 'dw_multy Modify Error')
		ib_multi = False
	END IF
	
	//ll_cnt = UpperBound(lstr_data.row[1].data)
	ll_cnt = upperbound(ls_column)
	FOR i = ll_cnt TO 1 Step -1
		dw_cond.setItem(1, ls_column[i], ivc.getproperty( ls_column[i]))
	NEXT
	
	IF ll_cnt > 1 THEN 
		IF ll_parm = MULTY OR ll_parm = COPY THEN
			dw_cond.SetItem(1, 'type', 1)
		ELSE
			dw_cond.SetItem(1, 'type', 2)
		END IF
	END IF
	
	uc_retrieve.PostEvent(Clicked!)
END IF



end event

type st_1 from w_default_response`st_1 within w_emp_code
end type

type uc_insert from w_default_response`uc_insert within w_emp_code
boolean visible = false
end type

type uc_cancel from w_default_response`uc_cancel within w_emp_code
integer x = 1417
integer y = 40
integer taborder = 30
end type

event uc_cancel::clicked;call super::clicked;//Close 할때 반드시 지켜주어야 할 사항들..
//This.of_SetMouseOver(False)
//This.of_ondisplay( )

s_row	lstr_data
CloseWithReturn(Parent, lstr_data)
end event

type uc_close from w_default_response`uc_close within w_emp_code
boolean visible = false
end type

type uc_delete from w_default_response`uc_delete within w_emp_code
boolean visible = false
end type

type uc_excel from w_default_response`uc_excel within w_emp_code
boolean visible = false
end type

type uc_ok from w_default_response`uc_ok within w_emp_code
integer x = 1129
integer y = 40
integer taborder = 20
end type

event uc_ok::clicked;call super::clicked;s_row		lstr_data
Long			ll_currentrow, i

IF ib_multi THEN
	IF long(ivc.getproperty('type')) = COPY THEN
		if wf_rolecopy() < 0 then return
	ELSE
		Long		ll_check, j
		ll_currentrow = dw_multi.rowcount( )
		FOR i = ll_currentrow TO 1 Step -1
			ll_check = dw_multi.getItemNumber(i, 'checkbox')
			IF ll_check = 1 THEN
				j++
				lstr_data.row[j].data[1] = dw_multi.GetItemString(i, 'dept_code')
				lstr_data.row[j].data[2] = dw_multi.GetItemString(i, 'dept_name')
				lstr_data.row[j].data[3] = dw_multi.GetItemString(i, 'emp_code')
				lstr_data.row[j].data[4] = dw_multi.GetItemString(i, 'emp_name')
			END IF
		NEXT
	END IF
ELSE
	ll_currentrow = dw_multi.getRow()
	IF ll_currentrow > 0 THEN
		lstr_data.row[1].data[1] = dw_multi.GetItemString(ll_currentrow, 'dept_code')
		lstr_data.row[1].data[2] = dw_multi.GetItemString(ll_currentrow, 'dept_name')
		lstr_data.row[1].data[3] = dw_multi.GetItemString(ll_currentrow, 'emp_code')
		lstr_data.row[1].data[4] = dw_multi.GetItemString(ll_currentrow, 'emp_name')
	END IF
END IF

//Close 할때 반드시 지켜주어야 할 사항들..
//This.of_SetMouseOver(False)
//This.of_ondisplay( )

CloseWithReturn(Parent, lstr_data)
end event

type uc_print from w_default_response`uc_print within w_emp_code
boolean visible = false
end type

type uc_run from w_default_response`uc_run within w_emp_code
boolean visible = false
end type

type uc_save from w_default_response`uc_save within w_emp_code
boolean visible = false
end type

type uc_retrieve from w_default_response`uc_retrieve within w_emp_code
integer x = 841
integer y = 40
integer taborder = 10
end type

event uc_retrieve::clicked;call super::clicked;String 	ls_temp = '%'
String	ls_code, ls_name
Long		ll_type
dw_cond.AcceptText()
ll_type = dw_cond.GetItemNumber(1, 'type')

ls_code = dw_cond.GetItemString(1, 'code') + ls_temp
IF IsNull(ls_code) OR Trim(ls_code) = '' THEN ls_code = ls_temp
	
ls_name	= ls_temp + dw_cond.GetItemString(1, 'name') + ls_temp
IF IsNull(ls_name) OR Trim(ls_name) = '' THEN ls_name = ls_temp

IF ll_type = 1 THEN
	dw_multi.retrieve('%', '%', ls_code , ls_name)
ELSE
	dw_multi.retrieve(ls_code , ls_name, '%', '%')
END IF
end event

type dw_multi from w_default_response`dw_multi within w_emp_code
integer x = 41
integer y = 296
integer width = 1646
integer height = 1248
integer taborder = 50
string dataobject = "d_empcode"
boolean hscrollbar = true
boolean vscrollbar = true
string checkboxname = "checkbox"
end type

event dw_multi::doubleclicked;call super::doubleclicked;String	ls_data, ls_data_origin, ls_ColumnName, ls_syntax
String	ls_tkt_no, ls_conj_no
Long		i, ll_cnt, ll_data

IF row > 0 THEN
	ib_multi = False
	if long(ivc.getproperty('type')) = COPY then
		ib_multi = true
		this.setitem(row, 'checkbox', 1)
	end if
	uc_ok.PostEvent(Clicked!)
END IF

ls_ColumnName = dwo.name
IF ls_columnName = "" OR IsNull(ls_columnName) THEN Return
ls_columnName = Left(ls_columnName, Pos(ls_columnName, '_hfx') - 1)

IF ls_columnName = 'checkbox' THEN
	This.SetRedraw(FALSE)
	ls_data_origin = Trim(Describe(dwo.name + ".text"))
	IF IsNull(ls_data_origin) THEN ls_data_origin = ''
	IF ls_data_origin = '√' THEN
		ls_data = '0'
	ELSE
		ls_data = '1'
	END IF

	ll_cnt = This.RowCount()
	FOR i = 1 TO ll_cnt
		This.SetItem(i, ls_columnName, Long(ls_data))
	NEXT
	
	This.SetRedraw(TRUE)

	IF ls_data = '0' THEN
		ls_syntax = ls_columnName + "_hfx.text=''~r~n " + ls_columnName + "_nml.text=''"
		//
	ELSE
		ls_syntax = ls_columnName + "_hfx.text='√'~r~n " + ls_columnName + "_nml.text='√'"
		//
	END IF
	ls_syntax = This.Modify(ls_syntax)
END IF


end event

type ln_templeft from w_default_response`ln_templeft within w_emp_code
end type

type ln_tempright from w_default_response`ln_tempright within w_emp_code
end type

type ln_tempstart from w_default_response`ln_tempstart within w_emp_code
end type

type ln_4 from w_default_response`ln_4 within w_emp_code
end type

type ln_temptop from w_default_response`ln_temptop within w_emp_code
end type

type ln_tempbutton from w_default_response`ln_tempbutton within w_emp_code
end type

type dw_cond from datawindow within w_emp_code
event ue_keyenter pbm_dwnprocessenter
integer x = 41
integer y = 164
integer width = 1650
integer height = 96
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_empcode_cond"
boolean border = false
boolean livescroll = true
end type

event ue_keyenter;uc_retrieve.PostEvent(Clicked!)
end event

event itemchanged;IF row > 0 THEN
	CHOOSE CASE dwo.name
		CASE 'code'
			This.SetItem(1,'name', '')
		CASE 'name'
			This.SetItem(1,'code', '')
		CASE 'type'
			this.setitem(row, 'code', '')
			this.setitem(row, 'name', '')
			IF Long(data) = 1 THEN
				This.Modify('code.Edit.Limit=12')
			ELSE
				This.Modify('code.Edit.Limit=5')
			END IF
	END CHOOSE
END IF
end event

type sle_1 from singlelineedit within w_emp_code
integer x = 55
integer y = 32
integer width = 763
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 10789024
boolean border = false
boolean displayonly = true
end type

type r_2 from rectangle within w_emp_code
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 32305380
integer x = 41
integer y = 160
integer width = 1650
integer height = 104
end type

type r_1 from rectangle within w_emp_code
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 31439244
integer x = 41
integer y = 292
integer width = 1646
integer height = 1256
end type

