$PBExportHeader$w_role_main.srw
forward
global type w_role_main from w_default_templet
end type
type uc_rmsave from u_picture within w_role_main
end type
type uc_rminsert from u_picture within w_role_main
end type
type uc_rmdelete from u_picture within w_role_main
end type
type uc_rusave from u_picture within w_role_main
end type
type uc_rudelete from u_picture within w_role_main
end type
type uc_ruinsert from u_picture within w_role_main
end type
type dw_userrole from uo_dwlv within w_role_main
end type
type dw_pgm_role from uo_dwlv within w_role_main
end type
type st_1 from statictext within w_role_main
end type
type st_2 from statictext within w_role_main
end type
type st_3 from statictext within w_role_main
end type
type uc_rpconfig from uo_imgbtn within w_role_main
end type
type uo_copy from uo_imgbtn within w_role_main
end type
type p_2 from picture within w_role_main
end type
type p_1 from picture within w_role_main
end type
type p_3 from picture within w_role_main
end type
type r_1 from rectangle within w_role_main
end type
type r_2 from rectangle within w_role_main
end type
type r_3 from rectangle within w_role_main
end type
type r_4 from rectangle within w_role_main
end type
end forward

global type w_role_main from w_default_templet
string title = "Role 등록"
uc_rmsave uc_rmsave
uc_rminsert uc_rminsert
uc_rmdelete uc_rmdelete
uc_rusave uc_rusave
uc_rudelete uc_rudelete
uc_ruinsert uc_ruinsert
dw_userrole dw_userrole
dw_pgm_role dw_pgm_role
st_1 st_1
st_2 st_2
st_3 st_3
uc_rpconfig uc_rpconfig
uo_copy uo_copy
p_2 p_2
p_1 p_1
p_3 p_3
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
end type
global w_role_main w_role_main

type variables
Boolean		ib_modify = False
Integer		ii_modifyrow

CONSTANT LONG	SINGLE	= 1
CONSTANT LONG MULTI		= 2
end variables

on w_role_main.create
int iCurrent
call super::create
this.uc_rmsave=create uc_rmsave
this.uc_rminsert=create uc_rminsert
this.uc_rmdelete=create uc_rmdelete
this.uc_rusave=create uc_rusave
this.uc_rudelete=create uc_rudelete
this.uc_ruinsert=create uc_ruinsert
this.dw_userrole=create dw_userrole
this.dw_pgm_role=create dw_pgm_role
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.uc_rpconfig=create uc_rpconfig
this.uo_copy=create uo_copy
this.p_2=create p_2
this.p_1=create p_1
this.p_3=create p_3
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uc_rmsave
this.Control[iCurrent+2]=this.uc_rminsert
this.Control[iCurrent+3]=this.uc_rmdelete
this.Control[iCurrent+4]=this.uc_rusave
this.Control[iCurrent+5]=this.uc_rudelete
this.Control[iCurrent+6]=this.uc_ruinsert
this.Control[iCurrent+7]=this.dw_userrole
this.Control[iCurrent+8]=this.dw_pgm_role
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.uc_rpconfig
this.Control[iCurrent+13]=this.uo_copy
this.Control[iCurrent+14]=this.p_2
this.Control[iCurrent+15]=this.p_1
this.Control[iCurrent+16]=this.p_3
this.Control[iCurrent+17]=this.r_1
this.Control[iCurrent+18]=this.r_2
this.Control[iCurrent+19]=this.r_3
this.Control[iCurrent+20]=this.r_4
end on

on w_role_main.destroy
call super::destroy
destroy(this.uc_rmsave)
destroy(this.uc_rminsert)
destroy(this.uc_rmdelete)
destroy(this.uc_rusave)
destroy(this.uc_rudelete)
destroy(this.uc_ruinsert)
destroy(this.dw_userrole)
destroy(this.dw_pgm_role)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.uc_rpconfig)
destroy(this.uo_copy)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.p_3)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
end on

event ue_postopen;call super::ue_postopen;dw_view.SetTransObject(SQLCA)
dw_pgm_role.SetTransObject(SQLCA)
dw_tran.SetTransObject(SQLCA)
dw_userrole.SetTransObject(SQLCA)

dw_tran.InsertRow(0)
dw_view.retrieve()
String	ls_syntax
ls_syntax += "~r~n" + 'insert_yn.Protect=1'
ls_syntax += "~r~n" + 'update_yn.Protect=1'
ls_syntax += "~r~n" + 'delete_yn.Protect=1'
ls_syntax += "~r~n" + 'print_yn.Protect=1'
ls_syntax += "~r~n" + 'use_btn.Protect=1'

dw_pgm_role.modify(ls_syntax)

uo_copy.of_enable( true)
end event

type ln_templeft from w_default_templet`ln_templeft within w_role_main
end type

type ln_tempright from w_default_templet`ln_tempright within w_role_main
end type

type ln_temptop from w_default_templet`ln_temptop within w_role_main
end type

type ln_tempbuttom from w_default_templet`ln_tempbuttom within w_role_main
end type

type ln_tempbutton from w_default_templet`ln_tempbutton within w_role_main
end type

type ln_tempstart from w_default_templet`ln_tempstart within w_role_main
end type

type uc_retrieve from w_default_templet`uc_retrieve within w_role_main
boolean visible = false
integer x = 3186
integer y = 36
integer width = 265
boolean originalsize = false
end type

type uc_save from w_default_templet`uc_save within w_role_main
boolean visible = false
integer x = 4192
integer y = 36
boolean originalsize = false
end type

type uc_run from w_default_templet`uc_run within w_role_main
boolean visible = false
integer x = 2222
integer width = 265
end type

type uc_print from w_default_templet`uc_print within w_role_main
boolean visible = false
end type

type uc_ok from w_default_templet`uc_ok within w_role_main
boolean visible = false
integer y = 36
boolean originalsize = false
end type

type uc_excel from w_default_templet`uc_excel within w_role_main
boolean visible = false
integer y = 36
integer width = 265
boolean originalsize = false
end type

type uc_delete from w_default_templet`uc_delete within w_role_main
boolean visible = false
integer x = 4110
integer y = 36
integer width = 306
integer height = 96
boolean originalsize = false
end type

type uc_close from w_default_templet`uc_close within w_role_main
boolean visible = false
integer y = 36
boolean originalsize = false
end type

type uc_cancel from w_default_templet`uc_cancel within w_role_main
boolean visible = false
integer x = 2866
integer y = 36
integer width = 265
boolean originalsize = false
end type

type uc_insert from w_default_templet`uc_insert within w_role_main
boolean visible = false
integer x = 3461
integer y = 36
integer width = 265
boolean originalsize = false
end type

type dw_tran from w_default_templet`dw_tran within w_role_main
integer x = 46
integer y = 252
integer width = 1248
integer height = 424
string dataobject = "d_pub_role"
end type

event dw_tran::doubleclicked;call super::doubleclicked;s_row		lstr_row
vector		vc
vc = create vector

IF row > 0 THEN
	CHOOSE CASE dwo.name
		CASE  'dept_code' , 'dept_name'
			IF This.GetItemString(row, 'role_cat_code') <> '02' THEN Return
			This.AcceptText()
			vc.setproperty('type', String(SINGLE))
			vc.setproperty('dept_code', This.GetItemString(row, 'dept_code'))
			vc.setproperty('dept_name', This.GetItemString(row, 'dept_name'))

			OpenWithParm(w_dept_code, vc, Parent)
			
			lstr_row = Message.PowerObjectParm
			IF IsValid(lstr_row) THEN
				IF upperbound(lstr_row.row) > 0 THEN
					This.SetItem(1, 'dept_code', lstr_row.row[1].data[1])
					This.SetItem(1, 'dept_name', lstr_row.row[1].data[2])
				END IF
			END IF	

		CASE 'emp_code' , 'emp_name'
			IF This.GetItemString(row, 'role_cat_code') <> '01' THEN Return
			This.AcceptText()
			vc.setproperty('type', String(SINGLE))
			vc.setproperty('code', This.GetItemString(row, 'emp_code'))
			vc.setproperty('name', This.GetItemString(row, 'emp_name'))

			OpenWithParm(w_emp_code, vc, Parent)
			
			lstr_row = Message.PowerObjectParm
			IF IsValid(lstr_row) THEN
				IF upperbound(lstr_row.row) > 0 THEN
					This.SetItem(1, 'emp_code', lstr_row.row[1].data[3])
					This.SetItem(1, 'emp_name', lstr_row.row[1].data[4])
				END IF
			END IF
		CASE ELSE
	END CHOOSE
END IF
end event

event dw_tran::itemchanged;call super::itemchanged;IF row > 0 THEN
	IF dwo.name = 'role_cat_code' THEN
		String 	ls_syntax
		Choose Case data
			Case '01'
				This.SetItem(1, 'dept_code', '')
				This.SetItem(1, 'dept_name', '')
				ls_syntax   = ' ~n dept_code.Protect=1'
				ls_syntax += ' ~n dept_name.Protect=1'
				ls_syntax += ' ~n emp_code.Protect=0'
				ls_syntax += ' ~n emp_name.Protect=0'
				IF This.Modify(ls_syntax) = '!' THEN Messagebox("Info", This.ClassName() + " Modify Failed")
			Case '02'
				This.SetItem(1, 'emp_code', '')
				This.SetItem(1, 'emp_name', '')
				ls_syntax   = ' ~n dept_code.Protect=0'
				ls_syntax += ' ~n dept_name.Protect=0'
				ls_syntax += ' ~n emp_code.Protect=1'
				ls_syntax += ' ~n emp_name.Protect=1'
				IF This.Modify(ls_syntax) = '!' THEN Messagebox("Info", This.ClassName() + " Modify Failed")
			Case '03'
				This.SetItem(1, 'dept_code', '')
				This.SetItem(1, 'dept_name', '')
				This.SetItem(1, 'emp_code', '')
				This.SetItem(1, 'emp_name', '')
				ls_syntax   = ' ~n dept_code.Protect=1'
				ls_syntax += ' ~n dept_name.Protect=1'
				ls_syntax += ' ~n emp_code.Protect=1'
				ls_syntax += ' ~n emp_name.Protect=1'
				IF This.Modify(ls_syntax) = '!' THEN Messagebox("Info", This.ClassName() + " Modify Failed")
			CASE ELSE
				ls_syntax   = ' ~n dept_code.Protect=0'
				ls_syntax += ' ~n dept_name.Protect=0'
				ls_syntax += ' ~n emp_code.Protect=0'
				ls_syntax += ' ~n emp_name.Protect=0'
				IF This.Modify(ls_syntax) = '!' THEN Messagebox("Info", This.ClassName() + " Modify Failed")
		End Choose
	END IF
END IF
end event

type dw_view from w_default_templet`dw_view within w_role_main
integer x = 46
integer y = 708
integer width = 1248
integer height = 1404
string dataobject = "d_role_master"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_view::rowfocuschanged;call super::rowfocuschanged;String		ls_data[]

IF currentrow > 0 THEN
	dw_tran.reset()
	This.RowsCopy(currentrow, currentrow, Primary!, dw_tran, 1, Primary!)
	dw_tran.Trigger Event itemchanged(1, dw_tran.Object.role_cat_code, This.GetItemString(currentrow, 'role_cat_code'))
	dw_tran.resetupdate()
	dw_tran.setRedraw( true )
	ib_modify = True
	ii_modifyrow = currentrow
	
	ls_data[1] = dw_view.getItemString(currentrow, 'role_no')
	IF ls_data[1] = '00000' THEN
		uc_rmdelete.of_enable(False)
		uc_rminsert.of_enable(False)
		uc_rmsave.of_enable(False)
		uc_rpconfig.of_enable(False)
		uc_rudelete.of_enable(False)
		uc_ruinsert.of_enable(False)
		uc_rusave.of_enable(False)
		dw_tran.Enabled = False
	ELSE
		uc_rmdelete.of_enable(True)
		uc_rminsert.of_enable(True)
		uc_rmsave.of_enable(True)
		uc_rpconfig.of_enable(True)
		uc_rudelete.of_enable(True)
		uc_ruinsert.of_enable(True)
		uc_rusave.of_enable(True)
		dw_tran.Enabled = True
	END IF
	dw_userrole.retrieve(ls_data)
	dw_pgm_role.retrieve(ls_data[1])
	This.SetFocus()
END IF
end event

type uc_rmsave from u_picture within w_role_main
integer x = 1134
integer y = 36
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_save.gif"
end type

event clicked;call super::clicked;String		ls_sql, ls_arg, ls_null, ls_cat, ls_data
Long			ll_rtn, ll_row
s_row		lstr_data
dwItemStatus	ldwstatus
dw_tran.Accepttext( )

ldwstatus = dw_tran.GetItemStatus(1,0,Primary!)
IF ldwstatus = NotModified! THEN return

ls_cat = dw_tran.GetItemString(1, 'role_cat_code')

CHOOSE CASE ls_cat
	CASE '01'
		ls_null = dw_tran.GetItemString(1, 'emp_code')
		IF IsNull(ls_null) OR Trim(ls_null) = '' THEN
			Messagebox("Info", "사원코드를 입력해 주시기 바랍니다.")
			dw_tran.SetColumn('emp_code')
			dw_tran.SetFocus()
			Return
		END IF
	CASE '02'
		ls_null = dw_tran.GetItemString(1, 'dept_code')
		IF IsNull(ls_null) OR Trim(ls_null) = '' THEN
			Messagebox("Info", "부서코드를 입력해 주시기 바랍니다.")
			dw_tran.SetColumn('dept_code')
			dw_tran.SetFocus()
			Return
		END IF
	CASE '03'
	CASE ELSE
		Messagebox("Info", "구분코드를 넣어 주시기 바랍니다.")
		dw_tran.SetColumn('role_cat_code')
		dw_tran.SetFocus()
		Return
END CHOOSE

ls_null = dw_tran.GetItemString(1, 'role_name')
IF IsNull(ls_null) OR Trim(ls_null) = '' THEN
	Messagebox("Info", "Role명을 입력해 주시기 바랍니다.")
	dw_tran.SetColumn('role_name')
	dw_tran.SetFocus()
	Return
END IF

IF 	Not ib_modify THEN 
	select Max(role_no)
	  into :ls_data
	 from cddb.pf_role
	using sqlca;
	
	IF  sqlca.sqlcode = 0 THEN
		IF IsNull(ls_data) THEN 
			ls_data = String(1, '00000')
		ELSE
			ls_data = String(Long(ls_data) + 1, '00000')
		END IF
		
		dw_tran.SetItem(1, 'role_no',	ls_data)
	END IF
END IF

IF Not ib_modify THEN
	ll_row = dw_view.rowcount() + 1
	dw_tran.rowscopy( 1, 1, Primary!, dw_view, ll_row, Primary!)
ELSE
	ls_data = dw_tran.GetItemString(1, 'role_cat_code')
	dw_view.setItem(ii_modifyrow, 'role_cat_code', ls_data)
	ls_data = dw_tran.GetItemString(1, 'role_name')
	dw_view.setItem(ii_modifyrow, 'role_name', ls_data)
	ls_data = dw_tran.GetItemString(1, 'dept_code')
	dw_view.setItem(ii_modifyrow, 'dept_code', ls_data)
	ls_data = dw_tran.GetItemString(1, 'dept_name')
	dw_view.setItem(ii_modifyrow, 'dept_name', ls_data)
	ls_data = dw_tran.GetItemString(1, 'emp_code')
	dw_view.setItem(ii_modifyrow, 'emp_code', ls_data)
	ls_data = dw_tran.GetItemString(1, 'emp_name')
	dw_view.setItem(ii_modifyrow, 'emp_name', ls_data)
	ib_modify = False
	ii_modifyrow = 0
END IF

IF dw_view.update() < 0 THEN
	Rollback Using sqlca;
	messagebox("Info", "저장에 실패하였습니다.")
	ls_data = dw_view.GetItemString(1, 'role_cat_code', Primary!, True)
	dw_view.setItem(ii_modifyrow, 'role_cat_code', ls_data)
	ls_data = dw_view.GetItemString(1, 'role_name', Primary!, True)
	dw_view.setItem(ii_modifyrow, 'role_name', ls_data)
	ls_data = dw_view.GetItemString(1, 'dept_code', Primary!, True)
	dw_view.setItem(ii_modifyrow, 'dept_code', ls_data)
	ls_data = dw_view.GetItemString(1, 'dept_name', Primary!, True)
	dw_view.setItem(ii_modifyrow, 'dept_name', ls_data)
	ls_data = dw_view.GetItemString(1, 'emp_code', Primary!, True)
	dw_view.setItem(ii_modifyrow, 'emp_code', ls_data)
	ls_data = dw_view.GetItemString(1, 'emp_name', Primary!, True)
	dw_view.setItem(ii_modifyrow, 'emp_name', ls_data)
ELSE
	IF ldwstatus = NewModified! then
		ls_sql = dw_tran.getitemstring(1, 'role_cat_code')
		if ls_sql = '02' then
			ls_sql = dw_tran.GetItemString(1, 'dept_code')
			INSERT INTO CDDB.PF_USERROLE ( ROLE_NO, EMP_CODE)
			SELECT :ls_data, EMP_CODE FROM cddb.pf_employee WHERE DEPT_CODE = :ls_sql
			USING SQLCA;
		elseif ls_sql = '01' then
			ls_sql = dw_tran.GetItemString(1, 'emp_code')
			INSERT INTO CDDB.PF_USERROLE( ROLE_NO, EMP_CODE)
			VALUES ( :ls_data, :ls_sql)
			USING SQLCA;
		end if
	end if
	
	Commit Using sqlca;
	ll_row = dw_view.find("role_no = '" + dw_tran.getitemstring(1, 'role_no') + "'", 1, dw_view.rowcount())
	dw_view.setrow(ll_row)
	dw_tran.resetupdate()
END IF
end event

type uc_rminsert from u_picture within w_role_main
integer x = 576
integer y = 36
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topbtn_add.gif"
end type

event clicked;call super::clicked;String	ls_temp
dw_tran.reset()
dw_tran.Insertrow(0)
dw_tran.Post Event itemchanged(1, dw_tran.Object.role_cat_code, ls_temp)

ib_modify = False
ii_modifyrow = 0
end event

type uc_rmdelete from u_picture within w_role_main
integer x = 855
integer y = 36
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;String				ls_role_no, ls_delete[2], ls_arg[2]
Long					ll_row, ll_rtn
Datawindow		ldw_data[1]
ll_row	= dw_view.getRow()
IF ll_row > 0 THEN
	ls_role_no = dw_view.GetItemString(ll_row,  'role_no')
	IF Messagebox("Question", "시스템에 영향을 줄 수 있습니다.~r~n삭제 하시겠습니까?", Question!, YesNo!, 2) = 1 THEN
		IF Not IsNull(ls_role_no) AND Trim(ls_role_no) <> '' THEN
			dw_view.DeleteRow(ll_row)
			
			Delete From CDDB.PF_PGM_ROLE WHERE ROLE_NO = :ls_role_no
			Using sqlca;
			IF  sqlca.sqlcode <> 0 THEN
				Rollback Using sqlca;
				messagebox("Info", "저장에 실패하였습니다")
				dw_view.RowsMove ( 1, dw_view.DeletedCount ( ) , Delete!, dw_view, ll_row, Primary! )
			ELSE
				Delete From CDDB.PF_USERROLE WHERE ROLE_NO = :ls_role_no
				Using sqlca;
				IF sqlca.sqlcode <> 0 THEN
					Rollback Using sqlca;
					messagebox("Info", "저장에 실패하였습니다")
					dw_view.RowsMove ( 1, dw_view.DeletedCount ( ) , Delete!, dw_view, ll_row, Primary! )
				ELSE
					ll_rtn = dw_view.Update()
					IF ll_rtn < 0 THEN
						Rollback Using sqlca;
						messagebox("Info", "저장에 실패하였습니다")
						dw_view.RowsMove ( 1, dw_view.DeletedCount ( ) , Delete!, dw_view, ll_row, Primary! )
					ELSE
						Commit Using sqlca;
					END IF
				END IF
			END IF
		END IF
	END IF
END IF  

end event

type uc_rusave from u_picture within w_role_main
boolean visible = false
integer x = 2437
integer y = 16
integer width = 247
integer height = 88
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_save.gif"
end type

event clicked;call super::clicked;IF dw_userrole.update() <> 1 THEN
	Rollback using sqlca;
	messagebox("Info", "권한 사용자 등록 실패")
ELSE
	Commit Using sqlca;
END IF
	
end event

type uc_rudelete from u_picture within w_role_main
integer x = 2418
integer y = 36
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_userrole.deleterow(0)

uc_rusave.PostEvent(Clicked!)
end event

type uc_ruinsert from u_picture within w_role_main
integer x = 2135
integer y = 36
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_add.gif"
end type

event clicked;call super::clicked;s_row		lstr_row
Long		ll_rowcnt, i, ll_row, ll_currentrow, ll_cnt
String		ls_roleno, ls_code, ls_name, ls_type
vector		vc
vc = create vector

ll_currentrow = dw_view.getrow()
ls_roleno		= dw_view.getItemString(ll_currentrow, 'role_no')
ls_type			= dw_view.getItemString(ll_currentrow, 'role_cat_code')
IF ll_currentrow > 0 THEN
	vc.setproperty('type', String(MULTI))
	//lstr_row.row[1].data[1] = String(MULTI)
	
	IF ls_type = '02' THEN
		vc.setproperty('dept_code', dw_view.getItemString(ll_currentrow, 'dept_code'))
		vc.setproperty('dept_name', dw_view.getItemString(ll_currentrow, 'dept_name'))
	END IF 
	OpenWithParm(w_emp_code, vc, Parent)
	
	lstr_row = Message.PowerObjectParm
	IF IsValid(lstr_row) THEN
		ll_rowcnt = UpperBound(lstr_row.row)
		IF ll_rowcnt > 0 THEN
			ll_cnt = dw_userrole.rowcount()
			FOR i = ll_rowcnt TO 1 Step -1
				ll_row = dw_userrole.find("emp_code='" + lstr_row.row[i].data[3] + "' and emp_name= '" + lstr_row.row[i].data[4] + "'", 1, ll_cnt)
				IF ll_row = 0 THEN
					ll_row = dw_userrole.insertrow(0)
					dw_userrole.setItem(ll_row, 'role_no', ls_roleno)
					dw_userrole.SetItem(ll_row, 'dept_code', lstr_row.row[i].data[1])
					dw_userrole.SetItem(ll_row, 'dept_name', lstr_row.row[i].data[2])
					dw_userrole.SetItem(ll_row, 'emp_code', lstr_row.row[i].data[3])
					dw_userrole.SetItem(ll_row, 'emp_name', lstr_row.row[i].data[4])
				END IF
			NEXT
		END IF
	END IF
END IF

uc_rusave.PostEvent(Clicked!)
end event

type dw_userrole from uo_dwlv within w_role_main
integer x = 1335
integer y = 252
integer width = 1349
integer height = 1860
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_userrole"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_pgm_role from uo_dwlv within w_role_main
integer x = 2725
integer y = 252
integer width = 1714
integer height = 1860
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pgmrole"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event doubleclicked;call super::doubleclicked;String		ls_roleno, ls_pgmno
s_row		lstr_data

IF row > 0 THEN
	lstr_data.row[1].data[1] 	= This.GetItemString(row, 'role_no')
	lstr_data.row[1].data[2] 	= This.GetItemString(row, 'pgm_no')
	
	Openwithparm(w_btnlist, lstr_data)
	
	lstr_data = Message.PowerObjectParm
	
	IF IsValid(lstr_data) THEN
		This.SetItem(row, 'use_btn'		, lstr_data.row[1].data[1])
		This.ResetUpdate()
	END IF
	
END IF



end event

type st_1 from statictext within w_role_main
integer x = 110
integer y = 172
integer width = 457
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "Role 등록"
boolean focusrectangle = false
end type

type st_2 from statictext within w_role_main
integer x = 1399
integer y = 172
integer width = 503
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "Role 사용자 등록"
boolean focusrectangle = false
end type

type st_3 from statictext within w_role_main
integer x = 2789
integer y = 172
integer width = 562
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "Role 프로그램 등록"
boolean focusrectangle = false
end type

type uc_rpconfig from uo_imgbtn within w_role_main
integer x = 4091
integer y = 36
integer width = 311
integer height = 84
integer taborder = 20
boolean bringtotop = true
string btnname = "등록관리"
end type

event clicked;call super::clicked;String		ls_roleno
Long			ll_row
ll_row = dw_view.GetRow()
IF ll_row > 0 THEN
	ls_roleno = dw_view.GetItemString(ll_row, 'role_no')
	OpenwithParm(w_pgmlist, ls_roleno, Parent)
	
	dw_pgm_role.retrieve(ls_roleno)
ELSE
	Messagebox("Info", "등록된 Role이 업습니다.~r~nRole를 등록하고 사용해 주시기 바랍니다.")
END IF
end event

on uc_rpconfig.destroy
call uo_imgbtn::destroy
end on

type uo_copy from uo_imgbtn within w_role_main
integer x = 46
integer y = 36
integer width = 434
integer height = 84
integer taborder = 30
boolean bringtotop = true
string btnname = " Role 복사 "
end type

on uo_copy.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String		ls_roleno, ls_newroleno
String		ls_sql, ls_arg
s_row		lstr_data
Long			ll_rtn, ll_row

ls_roleno = dw_tran.GetItemString(1, 'role_no')
IF ls_roleno = '' OR IsNull(ls_roleno) THEN Return

select Max(role_no)
Into	:ls_newroleno
from cddb.pf_role
using sqlca;

IF sqlca.sqlcode = 0 THEN
	IF IsNull(ls_newroleno) THEN 
		ls_newroleno = String(1, '00000')
	ELSE
		ls_newroleno = String(Long(ls_newroleno) + 1, '00000')
	END IF
	
	dw_tran.SetItem(1, 'role_no', ls_newroleno)
	ll_row = dw_view.rowcount() + 1
	dw_tran.rowscopy( 1, 1, Primary!, dw_view, ll_row, Primary!)
	ll_rtn = dw_view.update()
	IF  ll_rtn > 0 THEN
		Insert Into CDDB.PF_PGM_ROLE (pgm_no, role_no, use_btn) 
				  select pgm_no, :ls_newroleno, use_btn 
				from cddb.pf_pgm_role 
				where role_no = :ls_roleno
		using sqlca;
		IF sqlca.sqlcode = 0 THEN
			Insert Into CDDB.PF_USERROLE ( role_no, emp_code ) 
					 select :ls_newroleno , emp_code 
					 from CDDB.PF_USERROLE 
					 where role_no = :ls_roleno
			using sqlca;
			IF sqlca.sqlcode <> 0 THEN
				RollBack using sqlca;
				messagebox("Info", "USER ROLE 정보 저장에 실패하였습니다")
				dw_view.deleterow(ll_row)
				dw_tran.SetItem(1, 'role_no', ls_roleno)
			ELSE
				Commit using sqlca;
				dw_view.setrow(ll_row)
				dw_view.ScrollToRow(ll_row)
				dw_tran.resetupdate()
			END IF
		ELSE
			RollBack using sqlca;
			messagebox("Info", "PROGRAM ROLE 저보 저장에 실패하였습니다")
			dw_view.deleterow(ll_row)
			dw_tran.SetItem(1, 'role_no', ls_roleno)
		END IF
	ELSE
		RollBack using sqlca;
		messagebox("Info", "ROLE 정보 저장에 실패하였습니다")
		dw_view.deleterow(ll_row)
		dw_tran.SetItem(1, 'role_no', ls_roleno)
	END IF
END IF

end event

type p_2 from picture within w_role_main
integer x = 50
integer y = 176
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_role_main
integer x = 1335
integer y = 176
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_role_main
integer x = 2725
integer y = 176
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type r_1 from rectangle within w_role_main
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 16777215
integer x = 46
integer y = 248
integer width = 1248
integer height = 432
end type

type r_2 from rectangle within w_role_main
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 16777215
integer x = 46
integer y = 704
integer width = 1248
integer height = 1412
end type

type r_3 from rectangle within w_role_main
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 16777215
integer x = 1335
integer y = 248
integer width = 1349
integer height = 1868
end type

type r_4 from rectangle within w_role_main
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 16777215
integer x = 2725
integer y = 248
integer width = 1714
integer height = 1868
end type

