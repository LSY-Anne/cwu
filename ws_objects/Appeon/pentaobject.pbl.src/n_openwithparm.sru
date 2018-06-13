$PBExportHeader$n_openwithparm.sru
forward
global type n_openwithparm from nonvisualobject
end type
end forward

global type n_openwithparm from nonvisualobject autoinstantiate
end type

forward prototypes
public function boolean checkwindow (string as_windowname, ref str_tree astr_tree)
public function w_base opensheet (string as_windowname, window aw_parent)
public function w_base opensheetwithparm (string as_windowname, long arg, window aw_parent)
public function w_base opensheetwithparm (string as_windowname, powerobject arg, window aw_parent)
public function w_base opensheetwithparm (string as_windowname, string arg, window aw_parent)
end prototypes

public function boolean checkwindow (string as_windowname, ref str_tree astr_tree);String		ls_classname
ls_className = Upper(as_windowname)

//V1.9.9.012   pgm_id가 같은 것이 있으면 기존 로직으로는 여러개의 Row가 나올 수 있다.
select MAX(a.PGM_NO)		
		,a.Pgm_Id			
		,Max(a.Pgm_Name)
INTO :astr_tree.pgm_no
		,:astr_tree.pgm_id
		,:astr_tree.pgm_nm
  from  cddb.pf_pgm_mst   a	
		 ,cddb.pf_pgm_role  b		
		 ,cddb.pf_userrole  c		
where a.pgm_no 	= b.pgm_no	
  and b.role_no 	= c.role_no		
  and c.emp_code 	= :gs_empCode		
  and a.pgm_id   	= :ls_className	
  Group by pgm_id
using sqlca;
//========================================================
//select MAX(a.PGM_NO)		
//		,a.Pgm_Id			
//		,a.Pgm_Name			
//INTO :astr_tree.pgm_no
//		,:astr_tree.pgm_id
//		,:astr_tree.pgm_nm
//  from  pf_pgm_mst   a	
//		 ,pf_pgm_role  b		
//		 ,pf_userrole  c		
//where a.pgm_no 	= b.pgm_no	
//  and b.role_no 	= c.role_no		
//  and c.emp_code 	= :gs_empCode		
//  and a.pgm_id   	= :ls_className	
//  Group by pgm_id, pgm_name		
//using sqlca;
//========================================================
IF sqlca.sqlcode <> 0 THEN
	return false
END IF

gs_pgmno = astr_tree.pgm_no

return true
end function

public function w_base opensheet (string as_windowname, window aw_parent);Long		ll_rtn
String 	ls_className
str_tree		lstr_tree

//V1.9.9.012_ return을 위해 추가.  return value를 w_base로 변경..
w_base		lw_return
//=========================

IF Not checkwindow(as_windowname, lstr_tree) THEN
	Messagebox("Info", as_windowname + "는 등록되지 않은 프로그램 입니다.~r~n등록하고 사용하여 주시기 바랍니다.")
	
	//V1.9.9.012_ return으로 돌림.
	return  lw_return
	//=====================
	//return
	//=====================
END IF

//V1.9.9.012_ return으로 돌림.
return aw_parent.Dynamic wf_opensheet(lstr_tree.pgm_nm, lstr_tree.pgm_id, lstr_tree.pgm_no)
//=========================
//aw_parent.Dynamic wf_opensheet(lstr_tree.pgm_nm, lstr_tree.pgm_id, lstr_tree.pgm_no)
//=========================

end function

public function w_base opensheetwithparm (string as_windowname, long arg, window aw_parent);Long		ll_rtn
String	ls_className
str_tree		lstr_tree

//V1.9.9.012_ return을 위해 추가.  return value를 w_base로 변경..
w_base		lw_return
//=========================

IF Not checkwindow(as_windowname, lstr_tree) THEN
	Messagebox("Info", as_windowname + "는 등록되지 않은 프로그램 입니다.~r~n등록하고 사용하여 주시기 바랍니다.")
	//V1.9.9.012_ return으로 돌림.
	return  lw_return
	//=====================
	//return
	//=====================
END IF

//V1.9.9.012_ return으로 돌림.
return aw_parent.Dynamic wf_opensheetparmlong(lstr_tree.pgm_nm, lstr_tree.pgm_id, lstr_tree.pgm_no, arg)
//======================
//aw_parent.Dynamic wf_opensheetparmlong(lstr_tree.pgm_nm, lstr_tree.pgm_id, lstr_tree.pgm_no, arg)
//======================

end function

public function w_base opensheetwithparm (string as_windowname, powerobject arg, window aw_parent);Long		ll_rtn
String 	ls_className
str_tree		lstr_tree

//V1.9.9.012_ return을 위해 추가.  return value를 w_base로 변경..
w_base		lw_return
//=========================

IF Not checkwindow(as_windowname, lstr_tree) THEN
	Messagebox("Info", as_windowname + "는 등록되지 않은 프로그램 입니다.~r~n등록하고 사용하여 주시기 바랍니다.")
	//V1.9.9.012_ return으로 돌림.
	return  lw_return
	//=====================
	//return
	//=====================
END IF

//V1.9.9.012_ return으로 돌림.
return aw_parent.Dynamic wf_opensheetparmpob(lstr_tree.pgm_nm, lstr_tree.pgm_id, lstr_tree.pgm_no, arg)
//=====================
//aw_parent.Dynamic wf_opensheetparmpob(lstr_tree.pgm_nm, lstr_tree.pgm_id, lstr_tree.pgm_no, arg)
//=====================

end function

public function w_base opensheetwithparm (string as_windowname, string arg, window aw_parent);Long		ll_rtn
String 	ls_className
str_tree		lstr_tree

//V1.9.9.012_ return을 위해 추가.  return value를 w_base로 변경..
w_base		lw_return
//=========================

IF Not checkwindow(as_windowname, lstr_tree) THEN
	Messagebox("Info", as_windowname + "는 등록되지 않은 프로그램 입니다.~r~n등록하고 사용하여 주시기 바랍니다.")
	//V1.9.9.012_ return으로 돌림.
	return  lw_return
	//=====================
	//return
	//=====================
END IF

//V1.9.9.012_ return으로 돌림.
return aw_parent.Dynamic wf_opensheetparmstring(lstr_tree.pgm_nm, lstr_tree.pgm_id, lstr_tree.pgm_no, arg)
//========================
//aw_parent.Dynamic wf_opensheetparmstring(lstr_tree.pgm_nm, lstr_tree.pgm_id, lstr_tree.pgm_no, arg)
//========================

end function

on n_openwithparm.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_openwithparm.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

