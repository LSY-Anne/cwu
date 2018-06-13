$PBExportHeader$w_dept_code.srw
forward
global type w_dept_code from w_default_response
end type
type dw_cond from datawindow within w_dept_code
end type
type r_2 from rectangle within w_dept_code
end type
type r_1 from rectangle within w_dept_code
end type
end forward

global type w_dept_code from w_default_response
integer width = 1449
integer height = 1676
string title = "부서 조회"
dw_cond dw_cond
r_2 r_2
r_1 r_1
end type
global w_dept_code w_dept_code

type variables
CONSTANT LONG SINGLE = 1
CONSTANT LONG MULTY = 2

Boolean		ib_multi	= False
end variables

on w_dept_code.create
int iCurrent
call super::create
this.dw_cond=create dw_cond
this.r_2=create r_2
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cond
this.Control[iCurrent+2]=this.r_2
this.Control[iCurrent+3]=this.r_1
end on

on w_dept_code.destroy
call super::destroy
destroy(this.dw_cond)
destroy(this.r_2)
destroy(this.r_1)
end on

event ue_postopen;call super::ue_postopen;Long		ll_parm, i
String	ls_rtn
String	ls_column[2] = {'dept_code', 'dept_name'}
//s_row	lstr_data
vector   vc

dw_multi.SetTransObject(sqlca)
uc_retrieve.of_enable(true)
uc_ok.of_enable(true)
uc_cancel.of_enable(true)

dw_cond.insertrow(0)

vc = Message.PowerObjectParm

IF IsValid(vc) THEN
	//ll_parm = Long(lstr_data.row[1].data[1])
	ll_parm = Long(vc.getproperty('type'))
	IF ll_parm = MULTY THEN
		ls_rtn = dw_multi.Modify('checkbox.protect=0')
		IF ls_rtn = '!' THEN Messagebox("Info", 'dw_multy Modify Error')
		ib_multi = True
	ELSE
		ls_rtn = dw_multi.Modify('checkbox.protect=1')
		IF ls_rtn = '!' THEN Messagebox("Info", 'dw_multy Modify Error')
		ib_multi = False
	END IF
	
	//ll_parm = UpperBound(lstr_data.row[1].data)
	ll_parm = upperbound(ls_column)
	FOR i = ll_parm TO 1 Step -1
		dw_cond.setItem(1, ls_column[i],  vc.getproperty(ls_column[i]))
	NEXT
	
	uc_retrieve.PostEvent(Clicked!)
END IF		
	
end event

type st_1 from w_default_response`st_1 within w_dept_code
end type

type uc_insert from w_default_response`uc_insert within w_dept_code
boolean visible = false
end type

type uc_cancel from w_default_response`uc_cancel within w_dept_code
integer x = 1129
integer y = 40
integer taborder = 30
end type

event uc_cancel::clicked;call super::clicked;s_row	lstr_data

This.of_setmouseover( False)
This.of_ondisplay()

CloseWithReturn(Parent, lstr_data)




end event

type uc_close from w_default_response`uc_close within w_dept_code
boolean visible = false
end type

type uc_delete from w_default_response`uc_delete within w_dept_code
boolean visible = false
end type

type uc_excel from w_default_response`uc_excel within w_dept_code
boolean visible = false
end type

type uc_ok from w_default_response`uc_ok within w_dept_code
integer x = 841
integer y = 40
integer taborder = 20
end type

event uc_ok::clicked;call super::clicked;s_row		lstr_data
Long			ll_currentrow, i

IF ib_multi THEN
	Long		ll_check, j
	ll_currentrow = dw_multi.rowcount( )
	FOR i = ll_currentrow TO 1 Step -1
		ll_check = dw_multi.getItemNumber(i, 'checkbox')
		IF ll_check = 1 THEN
			j++
			lstr_data.row[j].data[1] = dw_multi.GetItemString(i, 'dept_code')
			lstr_data.row[j].data[2] = dw_multi.GetItemString(i, 'dept_name')
		END IF
	NEXT
ELSE
	ll_currentrow = dw_multi.getRow()
	IF ll_currentrow > 0 THEN
		lstr_data.row[1].data[1] = dw_multi.GetItemString(ll_currentrow, 'dept_code')
		lstr_data.row[1].data[2] = dw_multi.GetItemString(ll_currentrow, 'dept_name')
	END IF
END IF

CloseWithReturn(Parent, lstr_data)
end event

type uc_print from w_default_response`uc_print within w_dept_code
boolean visible = false
end type

type uc_run from w_default_response`uc_run within w_dept_code
boolean visible = false
end type

type uc_save from w_default_response`uc_save within w_dept_code
boolean visible = false
end type

type uc_retrieve from w_default_response`uc_retrieve within w_dept_code
integer x = 553
integer y = 40
integer taborder = 10
end type

event uc_retrieve::clicked;call super::clicked;String 	ls_temp = '%'
String	ls_code, ls_name

dw_cond.AcceptText()

ls_code = dw_cond.GetItemString(1, 'dept_code') + ls_temp
IF IsNull(ls_code) OR Trim(ls_code) = '' THEN ls_code = ls_temp

ls_name	= ls_temp + dw_cond.GetItemString(1, 'dept_name') + ls_temp
IF IsNull(ls_name) OR Trim(ls_name) = '' THEN ls_name = ls_temp

dw_multi.retrieve(ls_code , ls_name)
end event

type dw_multi from w_default_response`dw_multi within w_dept_code
integer x = 41
integer y = 296
integer width = 1358
integer height = 1260
integer taborder = 50
string dataobject = "d_deptcode"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_multi::doubleclicked;call super::doubleclicked;IF row > 0 THEN
	ib_multi = False
	uc_ok.PostEvent(Clicked!)
END IF

end event

type ln_templeft from w_default_response`ln_templeft within w_dept_code
end type

type ln_tempright from w_default_response`ln_tempright within w_dept_code
end type

type ln_tempstart from w_default_response`ln_tempstart within w_dept_code
end type

type ln_4 from w_default_response`ln_4 within w_dept_code
end type

type ln_temptop from w_default_response`ln_temptop within w_dept_code
end type

type ln_tempbutton from w_default_response`ln_tempbutton within w_dept_code
end type

type dw_cond from datawindow within w_dept_code
event ue_keyenter pbm_dwnprocessenter
integer x = 41
integer y = 164
integer width = 1358
integer height = 96
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_deptcode_cond"
boolean border = false
boolean livescroll = true
end type

event ue_keyenter;uc_retrieve.PostEvent(Clicked!)
end event

event itemchanged;IF row > 0 THEN
	CHOOSE CASE dwo.name
		CASE 'dept_code'
			This.SetItem(1,'dept_name', '')
		CASE 'dept_name'
			This.SetItem(1,'dept_code', '')
	END CHOOSE
END IF
end event

type r_2 from rectangle within w_dept_code
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 32226247
integer x = 41
integer y = 160
integer width = 1358
integer height = 104
end type

type r_1 from rectangle within w_dept_code
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 31439244
integer x = 41
integer y = 292
integer width = 1358
integer height = 1268
end type

