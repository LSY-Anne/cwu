$PBExportHeader$w_commonsheet.srw
forward
global type w_commonsheet from w_ancsheet
end type
type p_retrieve from u_picture within w_commonsheet
end type
type p_insert from u_picture within w_commonsheet
end type
type p_delete from u_picture within w_commonsheet
end type
type p_save from u_picture within w_commonsheet
end type
type p_excel from u_picture within w_commonsheet
end type
type p_excelload from u_picture within w_commonsheet
end type
type p_preview from u_picture within w_commonsheet
end type
type p_print from u_picture within w_commonsheet
end type
end forward

global type w_commonsheet from w_ancsheet
event type integer ue_save ( )
event type boolean ue_checkdelete ( datawindow dwdata,  integer row )
event ue_delete ( )
event ue_export ( )
event ue_init ( )
event ue_insert ( )
event ue_print ( )
event ue_retrieve ( )
event ue_setitem ( datawindow dwdata,  integer row )
event ue_import ( )
event ue_preview ( )
event ue_keyf1 ( )
event ue_keyf2 ( )
event ue_keyf3 ( )
event ue_keyf4 ( )
event ue_keyf5 ( )
event ue_keyf6 ( )
event ue_keyf7 ( )
event ue_keyf8 ( )
event ue_keyf9 ( )
event ue_keyf10 ( )
event ue_keyf11 ( )
event ue_keyf12 ( )
p_retrieve p_retrieve
p_insert p_insert
p_delete p_delete
p_save p_save
p_excel p_excel
p_excelload p_excelload
p_preview p_preview
p_print p_print
end type
global w_commonsheet w_commonsheet

type variables
Protected:
	u_dw   	UpdateDW[]
	u_dw 	 	idw_current
	Vector	ivc_retrieve

Private:
	BOOLEAN #RETRIEVE = TRUE
	BOOLEAN #INSERT 	= TRUE
	BOOLEAN #DELETE 	= TRUE
	BOOLEAN #SAVE 		= TRUE
	BOOLEAN #PRINT		= TRUE
end variables

forward prototypes
protected subroutine wf_settransobject (powerobject apo)
protected function integer wf_save (boolean revers)
private subroutine wf_setmenu ()
private subroutine wf_init ()
protected function integer wf_retrieve (integer argcount, ref datawindow data, any arg[])
protected function integer wf_retrieve (integer argcount, ref datastore data, any arg[])
protected function long wf_retrieve (readonly powerobject source, long arg_row, ref powerobject target)
protected subroutine wf_currentdw (datawindow adw)
private subroutine wf_setargument (integer argcount, string column[], integer arg_row, vector avc_data, ref datastore data, ref any arg[])
private subroutine wf_setargument (integer argcount, string column[], integer arg_row, vector avc_data, ref datawindow data, ref any arg[])
protected function long wf_retrieve (readonly powerobject source, long arg_row, string as_paramcolumn, ref powerobject target)
public subroutine wf_setargument (string keyname, string argtype, vector avc_data, string as_like1, string as_like2, ref any arg)
end prototypes

event type integer ue_save();IF wf_save(false) < 0 THEN
	rollback using sqlca;
	Messagebox("Error",  "저장에 실패 하였습니다.")
	return -1
ELSE
	commit using sqlca;
	Messagebox('Information','저장에 성공 하였습니다.')
	return 1
END IF
end event

event type boolean ue_checkdelete(datawindow dwdata, integer row);return true
end event

event ue_delete();//
end event

event ue_export();//
end event

event ue_insert();//
end event

event ue_print();//
end event

event ue_retrieve();//
end event

event ue_setitem(datawindow dwdata, integer row);/*====================================================
	
	Commant : 기본으로 관련 Datawindow에 대하여 기본적인 Data를 집어 넣는 곳이다.
	
	==================================================
	pass by 			Argument Type				Argument Name						Commant
	==================================================
	value				datawindow					dwdata										setting할 datawindow
	value				integer							row											setting할 dw의 row
	==================================================
	
===================================================*/

end event

event ue_import();//
end event

event ue_preview();//
end event

event ue_keyf1();//
end event

event ue_keyf2();//
end event

event ue_keyf3();//
end event

event ue_keyf4();//
end event

event ue_keyf5();//
end event

event ue_keyf6();//
end event

event ue_keyf7();//
end event

event ue_keyf8();//
end event

event ue_keyf9();//
end event

event ue_keyf10();//
end event

event ue_keyf11();//
end event

event ue_keyf12();//
end event

protected subroutine wf_settransobject (powerobject apo);Long		ll_ctr_cnt, i
String	ls_tag

Choose Case apo.typeof()
	Case Datawindow!
		Datawindow ldw
		ldw = apo
		ls_tag = ldw.tag

		Vector  lvc_data
		lvc_data = getconvertcommandparm(ls_tag)
		
		IF Lower( lvc_data.getProperty('settrans') ) = 'true' THEN 
			
			ldw.settransobject(sqlca)
			IF Lower( lvc_data.getProperty('trans') ) = 'true' THEN
				String ls_index
				ls_index = Lower( lvc_data.getProperty('index') )
				IF IsNumber(ls_index) THEN
					Integer	li_index
					li_index = Integer(ls_index)
					IF li_index > 0 THEN
						IF UpperBound(UpdateDW) < li_index THEN
							UpdateDW[li_index] = ldw
						ELSE
							IF IsValid(UpdateDW[li_index]) THEN
								MessageBox("Error", "Update Index Exists : " + UpdateDW[li_index].classname() + " / " + ldw.classname() )
								Return
							ELSE
								UpdateDW[li_index] = ldw
							END IF
						END IF
					END IF
				END IF
			END IF
		END IF
		
		Destroy lvc_data
	Case UserObject!
		UserObject  luo
		luo = apo
		IF Upper(luo.tag) <> 'TEXTSTYLEPICTUREBUTTON' THEN
			ll_ctr_cnt = UpperBound(luo.control)
			FOR i = ll_ctr_cnt TO 1 Step -1
				wf_settransobject(luo.control[i])
			NEXT
		END IF
	Case Tab!
		Tab  lt
		lt = apo
		ll_ctr_cnt = UpperBound(lt.control)
		FOR i = ll_ctr_cnt TO 1 Step -1
			wf_settransobject(lt.control[i])
		NEXT
	Case Window!
		window	lw
		lw = apo
		ll_ctr_cnt = UpperBound(lw.control)
		FOR i = ll_ctr_cnt TO 1 Step -1
			wf_settransobject(lw.control[i])
		NEXT
End Choose
end subroutine

protected function integer wf_save (boolean revers);Integer		li_cnt, i, li_rtn

li_cnt = UpperBound(UpdateDW)

IF revers THEN
	FOR i = li_cnt TO 1 Step -1
		IF Not IsValid(UpdateDW[i]) THEN
			MessageBox("Error", "Update Index Not Exists : index is " + String(i))
			li_rtn = -1
			Exit
		END IF
		
		IF UpdateDW[i].Accepttext( ) <> 1 THEN
			li_rtn = -1
			Exit
		ELSE
			li_rtn = UpdateDW[i].update()
			IF li_rtn = 1 THEN
				li_rtn = UpdateDW[i].Event ue_updateend()
				IF li_rtn = -1 THEN Exit
			ELSE
				li_Rtn = -1
				Exit
			END IF
		END IF
	NEXT
ELSE
	FOR i = 1 TO li_cnt
		IF Not IsValid(UpdateDW[i]) THEN
			MessageBox("Error", "Update Index Not Exists : index is " + String(i))
			li_rtn = -1
			Exit
		END IF
		
		IF UpdateDW[i].Accepttext( ) <> 1 THEN
			li_rtn = -1
			Exit
		ELSE
			li_rtn = UpdateDW[i].update()
			IF li_rtn = 1 THEN
				li_rtn = UpdateDW[i].Event ue_updateend()
				IF li_rtn = -1 THEN Exit
			ELSE
				Exit
			END IF
		END IF
	NEXT
END IF

return li_rtn
end function

private subroutine wf_setmenu ();
end subroutine

private subroutine wf_init ();u_picture		lpcbutton[8] 
lpcbutton = { p_retrieve, p_insert, p_delete, p_save, p_excel, p_excelload, p_preview, p_print }

Long	xpos
Long 	ypos
Integer	li_cnt, i
Boolean	lb_case
String	ls_classname
xpos = ln_tempright.beginx
ypos = ln_temptop.beginy

li_cnt = UpperBound(lpcbutton)

FOR i = li_cnt TO 1 Step -1
	lb_case = false
	
	IF lpcbutton[i].Visible THEN
		xpos = xpos - lpcbutton[i].width
		lpcbutton[i].x = xpos
		lpcbutton[i].y = ypos
		
		xpos = xpos - PixelsToUnits(4, XPixelsToUnits!)
	ELSE
		lb_case = true
	END IF
	
	IF Not lpcbutton[i].enabled AND Not lb_case THEN
		lb_case = true
	END IF
	
	IF lb_case THEN
		ls_classname = Lower( lpcbutton[i].ClassName() )
		CHOOSE CASE ls_classname
			CASE 'p_retrieve'
				#RETRIEVE 	= FALSE
			CASE 'p_insert'
				#INSERT 		= FALSE
			CASE 'p_delete'
				#DELETE 		= FALSE
			CASE 'p_save'
				#SAVE 		= FALSE
			CASE 'p_print'
				#PRINT		= FALSE
		END CHOOSE
	END IF
NEXT

wf_setmenu()
end subroutine

protected function integer wf_retrieve (integer argcount, ref datawindow data, any arg[]);long	rowcnt
IF argcount = 0 THEN
	rowcnt = data.retrieve()
ELSE
	choose case argcount
		case 1
			rowcnt = data.retrieve(arg[1])
		case 2
			rowcnt = data.retrieve(arg[1], arg[2])
		case 3
			rowcnt = data.retrieve(arg[1], arg[2], arg[3])
		case 4
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4])
		case 5
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5])
		case 6
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6])
		case 7
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7])
		case 8
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8])
		case 9
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9])
		case 10
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10])
		case 11
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10] + &
							   arg[11])
		case 12
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10] + &
							   arg[11], arg[12])
		case 13
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10] + &
							   arg[11], arg[12], arg[13])
		case 14
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10] + &
							   arg[11], arg[12], arg[13], arg[14])
		case 15
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10] + &
							   arg[11], arg[12], arg[13], arg[14], arg[15])
		case 16
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10], + &
							   arg[11], arg[12], arg[13], arg[14], arg[15], + &
							   arg[16])
		case 17
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10], + &
							   arg[11], arg[12], arg[13], arg[14], arg[15], + &
							   arg[16], arg[17])
		case 18
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10], + &
							   arg[11], arg[12], arg[13], arg[14], arg[15], + &
							   arg[16], arg[17], arg[18])
		case 19
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10], + &
							   arg[11], arg[12], arg[13], arg[14], arg[15], + &
							   arg[16], arg[17], arg[18], arg[19])
		case 20
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10], + &
							   arg[11], arg[12], arg[13], arg[14], arg[15], + &
							   arg[16], arg[17], arg[18], arg[19], arg[20])
	end choose
END IF

return rowcnt
end function

protected function integer wf_retrieve (integer argcount, ref datastore data, any arg[]);long	rowcnt
IF argcount = 0 THEN
	rowcnt = data.retrieve()
ELSE
	choose case argcount
		case 1
			rowcnt = data.retrieve(arg[1])
		case 2
			rowcnt = data.retrieve(arg[1], arg[2])
		case 3
			rowcnt = data.retrieve(arg[1], arg[2], arg[3])
		case 4
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4])
		case 5
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5])
		case 6
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6])
		case 7
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7])
		case 8
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8])
		case 9
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9])
		case 10
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10])
		case 11
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10] + &
							   arg[11])
		case 12
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10] + &
							   arg[11], arg[12])
		case 13
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10] + &
							   arg[11], arg[12], arg[13])
		case 14
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10] + &
							   arg[11], arg[12], arg[13], arg[14])
		case 15
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10] + &
							   arg[11], arg[12], arg[13], arg[14], arg[15])
		case 16
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10], + &
							   arg[11], arg[12], arg[13], arg[14], arg[15], + &
							   arg[16])
		case 17
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10], + &
							   arg[11], arg[12], arg[13], arg[14], arg[15], + &
							   arg[16], arg[17])
		case 18
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10], + &
							   arg[11], arg[12], arg[13], arg[14], arg[15], + &
							   arg[16], arg[17], arg[18])
		case 19
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10], + &
							   arg[11], arg[12], arg[13], arg[14], arg[15], + &
							   arg[16], arg[17], arg[18], arg[19])
		case 20
			rowcnt = data.retrieve(arg[1], arg[2], arg[3], arg[4], arg[5], + &
							   arg[6], arg[7], arg[8], arg[9], arg[10], + &
							   arg[11], arg[12], arg[13], arg[14], arg[15], + &
							   arg[16], arg[17], arg[18], arg[19], arg[20])
	end choose
END IF

return rowcnt
end function

protected function long wf_retrieve (readonly powerobject source, long arg_row, ref powerobject target);String		ls_temp
Long			ll_Rtn, ll_arg_cnt
any			la_arg[]
String		ls_col[]
Vector		lvc_data
u_dw	dw
u_ds	ds

CHOOSE CASE target.typeof()
	CASE Datawindow!
		dw 		= target		
		ls_temp  = dw.Object.Datawindow.Table.Arguments
	CASE DataStore!
		ds 		= target
		ls_temp  = ds.Object.Datawindow.Table.Arguments
END CHOOSE

IF ls_temp <> '?' THEN
	//ll_arg_cnt= detail dw argument 수
	replaceall(ls_temp, "~n", "&")
	ll_arg_cnt = replaceall(ls_temp, "~t", "=")
	
	lvc_data = getconvertcommandparm(ls_temp)
	
	CHOOSE CASE source.typeof()
		CASE Datawindow!
			dw = source
			
			ll_Rtn 	= gf_parsetoarray(dw.paramcolumn, ";", ls_col)
			if ll_arg_cnt <> ll_Rtn then
				messagebox('♣ 알림 ♣','개발에 정의된 변수 갯수와 조회시 사용될 변수 갯수가 다름니다.')
				return -1
			end if	

			wf_setargument(ll_arg_cnt, ls_col, arg_row, lvc_data, dw, la_arg)
		CASE DataStore!
			ds = source
	
			ll_Rtn 	= gf_parsetoarray(ds.paramcolumn, ";", ls_col)
			if ll_arg_cnt <> ll_Rtn then
				messagebox('♣ 알림 ♣','개발에 정의된 변수 갯수와 조회시 사용될 변수 갯수가 다름니다.')
				return -1
			end if	
			wf_setargument(ll_arg_cnt, ls_col, arg_row, lvc_data, ds, la_arg)
	END CHOOSE		
END IF

CHOOSE CASE target.typeof()
	CASE Datawindow!
		dw = target
		ll_rtn = wf_retrieve(ll_arg_cnt, dw, la_arg)
	CASE DataStore!
		ds = target
		ll_rtn = wf_retrieve(ll_arg_cnt, ds, la_arg)
END CHOOSE		

return ll_rtn
end function

protected subroutine wf_currentdw (datawindow adw);idw_current = adw
end subroutine

private subroutine wf_setargument (integer argcount, string column[], integer arg_row, vector avc_data, ref datastore data, ref any arg[]);String 	ls_type, ls_like1, ls_like2, ls_temp
Integer	i, li_pos

data.acceptText()
FOR i = argcount to 1 step -1
	li_pos = pos(column[i], '%')
	IF li_pos = 1 THEN
		ls_like1 = Left(column[i], li_pos)
		column[i] = mid(column[i], li_pos + Len('%'))
	END IF
	
	li_pos = pos(column[i], '%')
	IF li_Pos > 1 THEN
		ls_like2 = Mid(column[i], li_pos)
		column[i] = Left(column[i], li_pos - Len('%'))
	END IF

	ls_type = data.Describe(column[i] + ".ColType")
	CHOOSE CASE TRUE
		CASE Pos(Upper(ls_type), 'CHAR', 1) > 0
			arg[i]	= ls_like1 + data.GetItemString(arg_row, column[i]) + ls_like2
		CASE Pos(Upper(ls_type), 'ULONG', 1) > 0 OR Pos(Upper(ls_type), 'INT', 1) > 0 OR Pos(Upper(ls_type), 'LONG', 1) > 0 OR Pos(Upper(ls_type), 'REAL', 1) > 0 OR Pos(Upper(ls_type), 'NUMB', 1) > 0 
			arg[i]	= data.GetItemNumber(arg_row, column[i])
		CASE Pos(Upper(ls_type), 'DATETIME', 1) = 0 AND Pos(Upper(ls_type), 'DATE', 1) > 0
			arg[i]	= data.GetItemDate(arg_row, column[i])
		CASE Pos(Upper(ls_type), 'DATETIME', 1) > 0 
			arg[i]	= data.GetItemDateTime(arg_row, column[i])
		CASE Pos(Upper(ls_type), 'DECIMAL', 1) > 0
			arg[i]	= data.GetItemDecimal(arg_row, column[i])
		CASE Pos(Upper(ls_type), 'TIME', 1) > 0 OR Pos(Upper(ls_type), 'TIMESTAMP', 1) > 0 
			arg[i]	= data.GetItemTime(arg_row, column[i])
		CASE ELSE
			ls_type = Lower(avc_data.getProperty(avc_data.getKey(i)))
			wf_setargument(column[i], ls_type, ivc_retrieve, ls_like1, ls_like2, arg[i])
	END CHOOSE
	ls_like1 = ""
	ls_like2 = ""
	ls_temp = ""
NEXT
end subroutine

private subroutine wf_setargument (integer argcount, string column[], integer arg_row, vector avc_data, ref datawindow data, ref any arg[]);String 	ls_type, ls_like1, ls_like2, ls_temp
Integer	i, li_pos

data.acceptText()
FOR i = argcount to 1 step -1
	li_pos = pos(column[i], '%')
	IF li_pos = 1 THEN
		ls_like1 = Left(column[i], li_pos)
		column[i] = mid(column[i], li_pos + Len('%'))
	END IF
	
	li_pos = pos(column[i], '%')
	IF li_Pos > 1 THEN
		ls_like2 = Mid(column[i], li_pos)
		column[i] = Left(column[i], li_pos - Len('%'))
	END IF

	ls_type = data.Describe(column[i] + ".ColType")
	CHOOSE CASE TRUE
		CASE Pos(Upper(ls_type), 'CHAR', 1) > 0
			arg[i] = data.GetItemString(arg_row, column[i])
			IF IsNull(arg[i]) THEN 
				arg[i] = ls_like1 + ls_like2
			ELSE
				arg[i] = ls_like1 + arg[i] + ls_like2
			END IF
		CASE Pos(Upper(ls_type), 'ULONG', 1) > 0 OR Pos(Upper(ls_type), 'INT', 1) > 0 OR Pos(Upper(ls_type), 'LONG', 1) > 0 OR Pos(Upper(ls_type), 'REAL', 1) > 0 OR Pos(Upper(ls_type), 'NUMB', 1) > 0 
			arg[i]	= data.GetItemNumber(arg_row, column[i])
		CASE Pos(Upper(ls_type), 'DATETIME', 1) = 0 AND Pos(Upper(ls_type), 'DATE', 1) > 0
			arg[i]	= data.GetItemDate(arg_row, column[i])
		CASE Pos(Upper(ls_type), 'DATETIME', 1) > 0 
			arg[i]	= data.GetItemDateTime(arg_row, column[i])
		CASE Pos(Upper(ls_type), 'DECIMAL', 1) > 0
			arg[i]	= data.GetItemDecimal(arg_row, column[i])
		CASE Pos(Upper(ls_type), 'TIME', 1) > 0 OR Pos(Upper(ls_type), 'TIMESTAMP', 1) > 0 
			arg[i]	= data.GetItemTime(arg_row, column[i])
		CASE ELSE
			ls_type = Lower(avc_data.getProperty(avc_data.getKey(i)))
			wf_setargument(column[i], ls_type, ivc_retrieve, ls_like1, ls_like2, arg[i])
	END CHOOSE
	ls_like1 = ""
	ls_like2 = ""
	ls_temp = ""
NEXT
end subroutine

protected function long wf_retrieve (readonly powerobject source, long arg_row, string as_paramcolumn, ref powerobject target);String		ls_temp
Long			ll_Rtn, ll_arg_cnt
any			la_arg[]
String		ls_col[]
Vector		lvc_data
u_dw	dw
u_ds	ds

CHOOSE CASE target.typeof()
	CASE Datawindow!
		dw 		= target		
		ls_temp  = dw.Object.Datawindow.Table.Arguments
	CASE DataStore!
		ds 		= target
		ls_temp  = ds.Object.Datawindow.Table.Arguments
END CHOOSE

IF ls_temp <> '?' THEN
	//ll_arg_cnt= detail dw argument 수
	replaceall(ls_temp, "~n", "&")
	ll_arg_cnt = replaceall(ls_temp, "~t", "=")
	
	lvc_data = getconvertcommandparm(ls_temp)
	ll_Rtn 	= gf_parsetoarray(as_paramcolumn, ";", ls_col)
	if ll_arg_cnt <> ll_Rtn then
		messagebox('♣ 알림 ♣','개발에 정의된 변수 갯수와 조회시 사용될 변수 갯수가 다름니다.')
		return -1
	end if	
	
	CHOOSE CASE source.typeof()
		CASE Datawindow!
			dw = source
			wf_setargument(ll_arg_cnt, ls_col, arg_row, lvc_data, dw, la_arg)
		CASE DataStore!
			ds = source
			wf_setargument(ll_arg_cnt, ls_col, arg_row, lvc_data, ds, la_arg)
	END CHOOSE		
END IF

CHOOSE CASE target.typeof()
	CASE Datawindow!
		dw = target
		ll_rtn = wf_retrieve(ll_arg_cnt, dw, la_arg)
	CASE DataStore!
		ds = target
		ll_rtn = wf_retrieve(ll_arg_cnt, ds, la_arg)
END CHOOSE		

return ll_rtn
end function

public subroutine wf_setargument (string keyname, string argtype, vector avc_data, string as_like1, string as_like2, ref any arg);CHOOSE CASE argtype
	CASE 'date', 'datetime', 'number', 'time', 'datelist', 'datetimelist', 'numberlist', 'timelist', 'stringlist'
		arg = avc_data.getProperty(keyname)
	CASE 'string'
		arg = as_like1 + avc_data.getProperty(keyname) + as_like2
	CASE ELSE
		arg = as_like1 + String(avc_data.getProperty(keyname)) + as_like2
END CHOOSE

end subroutine

on w_commonsheet.create
int iCurrent
call super::create
this.p_retrieve=create p_retrieve
this.p_insert=create p_insert
this.p_delete=create p_delete
this.p_save=create p_save
this.p_excel=create p_excel
this.p_excelload=create p_excelload
this.p_preview=create p_preview
this.p_print=create p_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_retrieve
this.Control[iCurrent+2]=this.p_insert
this.Control[iCurrent+3]=this.p_delete
this.Control[iCurrent+4]=this.p_save
this.Control[iCurrent+5]=this.p_excel
this.Control[iCurrent+6]=this.p_excelload
this.Control[iCurrent+7]=this.p_preview
this.Control[iCurrent+8]=this.p_print
end on

on w_commonsheet.destroy
call super::destroy
destroy(this.p_retrieve)
destroy(this.p_insert)
destroy(this.p_delete)
destroy(this.p_save)
destroy(this.p_excel)
destroy(this.p_excelload)
destroy(this.p_preview)
destroy(this.p_print)
end on

event ue_closecheck;call super::ue_closecheck;//CloseQuary전에 체크하는 로직을 적는 부분
integer			li_cnt, i, li_ChangedCnt=0

li_cnt = UpperBound(UpdateDW)

FOR  i = 1  TO li_cnt
	IF Not IsValid(UpdateDW[i]) THEN
		MessageBox("Error", "Update Index Not Exists : index is " + String(i))
		ai_rtn = -1
		Return
	END IF

	IF UpdateDW[i].AcceptText() <> 1 THEN
		ai_rtn = 1
		Return
	ELSE
		li_ChangedCnt = li_ChangedCnt + UpdateDW[i].ModifiedCount() + UpdateDW[i].DeletedCount()
	END IF
NEXT

IF li_ChangedCnt > 0 THEN
	CHOOSE CASE MessageBox("확인", "변경사항을 저장하시겠습니까 ?",Question!,YesNoCancel!)
		CASE 1
			ai_rtn = This.TriggerEvent('ue_save')
		CASE 3
			ai_rtn = -1
		CASE ELse
			ai_rtn = 1
	END CHOOSE
END IF
end event

event ue_postopen;call super::ue_postopen;//KeyF1 ~ Key12는 해당 Event로 생성 해놓았습니다.
//ue_KeyF1 ~ ue_KeyF12로 매칭 시켜놓았으니 사용 하시기 바랍니다.
//HotKey를 생성 할때는 pentaobject.pbl/m_main/HotKey에다 아이템을 추가 시켜주시기 바랍니다.

wf_settransobject(this)

wf_init()

Event ue_init()
end event

event open;call super::open;ivc_retrieve = Create Vector
/*==========================================================
	각 Datawindow는 u_dw, uo_dwlv, uo_dwlvin, uo_dwfree를 상속 받아 사용 한다.
	해당 datawindow의 tag에는 settransobject, transaction 처리와 같은 tag를 넣어 자동으로 해준다.
	
	settrans=true  	--> 자동으로 settransobject를 해준다.  default = false
	trans=true 		--> update할 것인지 여부를 뭍는다.     default = false
	index=1			--> update시에 순번을 datawindow에 지정을 한다.
	
	ex) 
	   	*settransaction object만 해야 할 경우, 즉 조회만 해야 하는 경우
			settrans=true
		*transaction이 필요한 경우 (update, insert, delete를 해야 할 경우 ) 이 옵션은 index와 같이 사용 된다.
		   settrans=true&trans=true&index=1
			
	그리고 update를 할 경우 update하기전 체크할 사항은 datawindow의 updatestart에 기술하여 
	실패한 경우 1 성공한 경우 0으로 return값을 보내면 된다.
	
	또한 update가 끝난 후  체크 사항은 ue_updateend에 기술 하면 된다. 성공 1, 실패 -1
	
	이 내용은 각 datawindow에 대해서의 상황을 판단하여 스크립트 하면 된다.
==========================================================*/
end event

type ln_templeft from w_ancsheet`ln_templeft within w_commonsheet
end type

type ln_tempright from w_ancsheet`ln_tempright within w_commonsheet
end type

type ln_temptop from w_ancsheet`ln_temptop within w_commonsheet
end type

type ln_tempbuttom from w_ancsheet`ln_tempbuttom within w_commonsheet
end type

type ln_tempbutton from w_ancsheet`ln_tempbutton within w_commonsheet
end type

type ln_tempstart from w_ancsheet`ln_tempstart within w_commonsheet
end type

type p_retrieve from u_picture within w_commonsheet
integer x = 2437
integer y = 36
integer width = 206
integer height = 72
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_retrieve.gif"
string is_event = "ue_retrieve"
end type

type p_insert from u_picture within w_commonsheet
integer x = 2661
integer y = 36
integer width = 206
integer height = 72
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_input.gif"
string is_event = "ue_insert"
end type

type p_delete from u_picture within w_commonsheet
integer x = 2885
integer y = 36
integer width = 206
integer height = 72
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
string is_event = "ue_delete"
end type

type p_save from u_picture within w_commonsheet
integer x = 3109
integer y = 36
integer width = 206
integer height = 72
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_save.gif"
string is_event = "ue_save"
end type

type p_excel from u_picture within w_commonsheet
integer x = 3333
integer y = 36
integer width = 206
integer height = 72
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_excel.gif"
string is_event = "ue_export"
end type

type p_excelload from u_picture within w_commonsheet
integer x = 3557
integer y = 36
integer width = 315
integer height = 72
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_excelroad.gif"
string is_event = "ue_import"
end type

type p_preview from u_picture within w_commonsheet
integer x = 3890
integer y = 36
integer width = 315
integer height = 72
boolean bringtotop = true
string picturename = "..\img\button\topBtn_preview.gif"
string is_event = "ue_preview"
end type

type p_print from u_picture within w_commonsheet
integer x = 4224
integer y = 36
integer width = 215
integer height = 72
boolean bringtotop = true
string picturename = "..\img\button\topBtn_print01.gif"
string is_event = "ue_print"
end type

