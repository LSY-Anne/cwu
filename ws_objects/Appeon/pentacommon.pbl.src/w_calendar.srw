$PBExportHeader$w_calendar.srw
forward
global type w_calendar from w_anccontrol
end type
type p_close from u_picture within w_calendar
end type
type st_1 from statictext within w_calendar
end type
type st_rec from statictext within w_calendar
end type
type uob_calendar from uo_calendar within w_calendar
end type
end forward

global type w_calendar from w_anccontrol
integer width = 617
integer height = 708
boolean titlebar = false
boolean controlmenu = false
p_close p_close
st_1 st_1
st_rec st_rec
uob_calendar uob_calendar
end type
global w_calendar w_calendar

type prototypes
Function boolean AnimateWindow(long lhWnd, long lTm, long lFlags ) library 'user32.dll'
FUNCTION ulong SetCapture(ulong hwnd) LIBRARY "user32.dll"
FUNCTION ulong ReleaseCapture() LIBRARY "user32.dll"
FUNCTION boolean GetCursorPos(REF POINT ipPoint) LIBRARY "user32.dll"
FUNCTION boolean ScreenToClient(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
end prototypes

type variables

end variables

event ue_postopen;call super::ue_postopen;Date				ldt_selecteDate
long				ll_x, ll_y
ulong				lul
POINT 			lp
vector				vc
Boolean			lb_true
String				ls_format[] = {'@@@@/@@/@@', '@@@@-@@-@@', '@@-@@-@@@@', '@@/@@/@@@@'}

vc = Message.PowerObjectParm
IF IsValid(vc) THEN
	IF vc.getproperty('date') = '' THEN
		ldt_selecteDate = today()
	ELSE
		ldt_selecteDate = Date(vc.getproperty('date'))
		IF ldt_selecteDate = 1900-01-01 OR IsNull(ldt_selecteDate) THEN
			ll_x = UpperBound(ls_format)
			FOR ll_y = ll_x TO 1 Step -1
				ldt_selecteDate = Date(String(vc.getproperty('date'), ls_format[ll_y]))
				IF Not (ldt_selecteDate = 1900-01-01 OR IsNull(ldt_selecteDate)) THEN 
					lb_true = true
					Exit
				END IF
			NEXT
			IF Not lb_true THEN
				ldt_selecteDate = today()
			END IF
		END IF
	END IF
	
	uob_calendar.init_cal(ldt_selecteDate)
END IF

p_close.of_enable(true)
end event

on w_calendar.create
int iCurrent
call super::create
this.p_close=create p_close
this.st_1=create st_1
this.st_rec=create st_rec
this.uob_calendar=create uob_calendar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_close
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_rec
this.Control[iCurrent+4]=this.uob_calendar
end on

on w_calendar.destroy
call super::destroy
destroy(this.p_close)
destroy(this.st_1)
destroy(this.st_rec)
destroy(this.uob_calendar)
end on

event key;Choose Case key
	Case KeyEscape!
		Close(This)
End Choose
end event

type p_close from u_picture within w_calendar
integer x = 535
integer width = 55
integer height = 48
string picturename = "..\img\tab\closetooltab.gif"
end type

event clicked;call super::clicked;closewithreturn(parent, '')
end event

type st_1 from statictext within w_calendar
integer y = 24
integer width = 517
integer height = 12
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
long bordercolor = 31297177
boolean focusrectangle = false
end type

type st_rec from statictext within w_calendar
integer y = 8
integer width = 517
integer height = 12
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
long bordercolor = 31297177
boolean focusrectangle = false
end type

type uob_calendar from uo_calendar within w_calendar
integer y = 52
integer width = 590
integer taborder = 30
end type

on uob_calendar.destroy
call uo_calendar::destroy
end on

event ue_doubleclicked;call super::ue_doubleclicked;String	ls_curDate_new, ls_class
date		ld_curDate_new, ld_date 

ld_curDate_new = uob_calendar.uf_get_selected_date( )
ls_curDate_new = String(ld_curDate_new, 'YYYY/MM/DD')

ivc_data.setproperty("curdate", ls_curdate_new)

wf_hide(ivc_data)

end event

