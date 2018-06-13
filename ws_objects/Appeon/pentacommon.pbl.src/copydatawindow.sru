$PBExportHeader$copydatawindow.sru
forward
global type copydatawindow from nonvisualobject
end type
end forward

global type copydatawindow from nonvisualobject
end type
global copydatawindow copydatawindow

forward prototypes
private function integer setchilddatawindow (datawindowchild source, ref datawindowchild target)
public function integer setcopydata (datastore source, ref datastore target)
public function integer setcopydata (datastore source, ref datawindow target)
public function integer setcopydata (datawindow source, ref datastore target)
public function integer setcopydata (datawindow source, ref datawindow target)
end prototypes

private function integer setchilddatawindow (datawindowchild source, ref datawindowchild target);Long		colcount, i, ll_pos
String	ls_objs, ls_holder, ls_data, ls_temp
DatawindowChild		ldwc_source, ldwc_target
Blob		lb_totaldata, lb_data

IF source.rowscopy(1, source.rowcount(), Primary!, target, 1, Primary! ) < 0 THEN Return -1

//자식이 있는지 찾는다.
ls_objs = source.Describe("DataWindow.Objects")

do while Len(ls_objs) > 0 
	ll_pos = Pos( ls_objS, '~t')
	IF ll_pos = 0 THEN
		ls_holder = ls_objs
		ls_objs = ''
	ELSE
		ls_holder = Left(ls_objs, ll_pos - 1 )
		ls_objs = Mid(ls_objs, ll_pos + Len('~t') )
	END IF
	
	ls_temp = lower(source.Describe(ls_holder + ".type"))
	Choose Case ls_temp
		Case 'column'
			ls_temp = source.Describe(ls_holder + ".DDDW.Name") 
		Case 'report'	
			ls_temp = source.Describe(ls_holder + ".dataobject") 
		Case Else
			Continue
	End Choose

	IF IsNull(ls_temp) THEN ls_temp = ""
	Choose Case ls_temp
		Case '', '!', '?'
			Continue
	End Choose

	IF source.getChild(ls_holder, ldwc_source) < 0 THEN Continue
	IF target.getChild(ls_holder, ldwc_target) < 0 THEN Return -1
	
	IF setchilddatawindow(ldwc_source,ldwc_target) < 0 THEN Return -1
Loop

target.groupcalc()
target.setredraw(true)

return 1
end function

public function integer setcopydata (datastore source, ref datastore target);Long		colcount, i, ll_pos, ll_rtn
String	ls_objs, ls_holder, ls_data, ls_temp
DatawindowChild		ldwc_source, ldwc_target

ls_temp = source.Object.Datawindow.Syntax
IF target.Create(ls_temp, ls_temp) < 0  THEN
	Messagebox("DW Copy Failed", ls_temp)
	return -1
END IF
IF source.rowscopy(1, source.rowcount(), Primary!, target, 1, Primary! ) < 0 THEN Return -1
//=======================================================

//자식이 있는지 찾는다.
ls_objs = source.Describe("DataWindow.Objects")

do while Len(ls_objs) > 0 
	ll_pos = Pos( ls_objS, '~t')
	IF ll_pos = 0 THEN
		ls_holder = ls_objs
		ls_objs = ''
	ELSE
		ls_holder = Left(ls_objs, ll_pos - 1 )
		ls_objs = Mid(ls_objs, ll_pos + Len('~t') )
	END IF
	
	ls_temp = lower(source.Describe(ls_holder + ".type"))
	Choose Case ls_temp
		Case 'column'
			ls_temp = source.Describe(ls_holder + ".DDDW.Name") 
		Case 'report'	
			ls_temp = source.Describe(ls_holder + ".dataobject") 
		Case Else
			Continue
	End Choose

	IF IsNull(ls_temp) THEN ls_temp = ""
	Choose Case ls_temp
		Case '', '!', '?'
			Continue
	End Choose
	
	ll_rtn =  source.getChild(ls_holder, ldwc_source)
	IF ll_rtn  < 0 THEN 
		Continue
	END IF
	
	IF target.getChild(ls_holder, ldwc_target) < 0 THEN return -1
	
	IF setchilddatawindow(ldwc_source,ldwc_target) < 0 THEN Return -1
Loop
//======================================================

target.groupcalc()

return 1
end function

public function integer setcopydata (datastore source, ref datawindow target);Long		colcount, i, ll_pos, ll_rtn
String	ls_objs, ls_holder, ls_data, ls_temp
DatawindowChild		ldwc_source, ldwc_target

ls_temp = source.Object.Datawindow.Syntax
IF target.Create(ls_temp, ls_temp) < 0  THEN
	Messagebox("DW Copy Failed", ls_temp)
	return -1
END IF

IF source.rowscopy(1, source.rowcount(), Primary!, target, 1, Primary! ) < 0 THEN Return -1
//=======================================================

//자식이 있는지 찾는다.
ls_objs = source.Describe("DataWindow.Objects")

do while Len(ls_objs) > 0 
	ll_pos = Pos( ls_objS, '~t')
	IF ll_pos = 0 THEN
		ls_holder = ls_objs
		ls_objs = ''
	ELSE
		ls_holder = Left(ls_objs, ll_pos - 1 )
		ls_objs = Mid(ls_objs, ll_pos + Len('~t') )
	END IF
	
	ls_temp = lower(source.Describe(ls_holder + ".type"))
	Choose Case ls_temp
		Case 'column'
			ls_temp = source.Describe(ls_holder + ".DDDW.Name") 
		Case 'report'	
			ls_temp = source.Describe(ls_holder + ".dataobject") 
		Case Else
			Continue
	End Choose

	IF IsNull(ls_temp) THEN ls_temp = ""
	Choose Case ls_temp
		Case '', '!', '?'
			Continue
	End Choose
	
	ll_rtn =  source.getChild(ls_holder, ldwc_source)
	IF ll_rtn  < 0 THEN 
		Continue
	END IF
	
	IF target.getChild(ls_holder, ldwc_target) < 0 THEN return -1
	
	IF setchilddatawindow(ldwc_source,ldwc_target) < 0 THEN Return -1
Loop
//======================================================

target.groupcalc()
target.setredraw(true)

return 1
end function

public function integer setcopydata (datawindow source, ref datastore target);Long		colcount, i, ll_pos, ll_rtn
String	ls_objs, ls_holder, ls_data, ls_temp
DatawindowChild		ldwc_source, ldwc_target

ls_temp = source.Object.Datawindow.Syntax
IF target.Create(ls_temp, ls_temp) < 0  THEN
	Messagebox("DW Copy Failed", ls_temp)
	return -1
END IF

IF source.rowscopy(1, source.rowcount(), Primary!, target, 1, Primary! ) < 0 THEN Return -1
//=======================================================

//자식이 있는지 찾는다.
ls_objs = source.Describe("DataWindow.Objects")

do while Len(ls_objs) > 0 
	ll_pos = Pos( ls_objS, '~t')
	IF ll_pos = 0 THEN
		ls_holder = ls_objs
		ls_objs = ''
	ELSE
		ls_holder = Left(ls_objs, ll_pos - 1 )
		ls_objs = Mid(ls_objs, ll_pos + Len('~t') )
	END IF
	
	ls_temp = lower(source.Describe(ls_holder + ".type"))
	Choose Case ls_temp
		Case 'column'
			ls_temp = source.Describe(ls_holder + ".DDDW.Name") 
		Case 'report'	
			ls_temp = source.Describe(ls_holder + ".dataobject") 
		Case Else
			Continue
	End Choose

	IF IsNull(ls_temp) THEN ls_temp = ""
	Choose Case ls_temp
		Case '', '!', '?'
			Continue
	End Choose
	
	ll_rtn =  source.getChild(ls_holder, ldwc_source)
	IF ll_rtn  < 0 THEN 
		Continue
	END IF
	
	IF target.getChild(ls_holder, ldwc_target) < 0 THEN return -1
	
	IF setchilddatawindow(ldwc_source,ldwc_target) < 0 THEN Return -1
Loop
//======================================================

target.groupcalc()

return 1
end function

public function integer setcopydata (datawindow source, ref datawindow target);Long		colcount, i, ll_pos, ll_rtn
String	ls_objs, ls_holder, ls_data, ls_temp
DatawindowChild		ldwc_source, ldwc_target

ls_temp = source.Object.Datawindow.Syntax
IF target.Create(ls_temp, ls_temp) < 0  THEN
	Messagebox("DW Copy Failed", ls_temp)
	return -1
END IF

IF source.rowscopy(1, source.rowcount(), Primary!, target, 1, Primary! ) < 0 THEN Return -1
//=======================================================

//자식이 있는지 찾는다.
ls_objs = source.Describe("DataWindow.Objects")

do while Len(ls_objs) > 0 
	ll_pos = Pos( ls_objS, '~t')
	IF ll_pos = 0 THEN
		ls_holder = ls_objs
		ls_objs = ''
	ELSE
		ls_holder = Left(ls_objs, ll_pos - 1 )
		ls_objs = Mid(ls_objs, ll_pos + Len('~t') )
	END IF
	
	ls_temp = lower(source.Describe(ls_holder + ".type"))
	Choose Case ls_temp
		Case 'column'
			ls_temp = source.Describe(ls_holder + ".DDDW.Name") 
		Case 'report'	
			ls_temp = source.Describe(ls_holder + ".dataobject") 
		Case Else
			Continue
	End Choose

	IF IsNull(ls_temp) THEN ls_temp = ""
	Choose Case ls_temp
		Case '', '!', '?'
			Continue
	End Choose
	
	ll_rtn =  source.getChild(ls_holder, ldwc_source)
	IF ll_rtn  < 0 THEN 
		Continue
	END IF
	
	IF target.getChild(ls_holder, ldwc_target) < 0 THEN return -1
	
	IF setchilddatawindow(ldwc_source,ldwc_target) < 0 THEN Return -1
Loop
//======================================================

target.groupcalc()
target.setredraw(true)

return 1
end function

on copydatawindow.create
call super::create
TriggerEvent( this, "constructor" )
end on

on copydatawindow.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 멀티랭귀지 형태를 GetFullState할때 문제가 되어 copydatawindow를 사용함.
		 작업 = 생성.
	작업자  : 송상철
====================================*/
end event

