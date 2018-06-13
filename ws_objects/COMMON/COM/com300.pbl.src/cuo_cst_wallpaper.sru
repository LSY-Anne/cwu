$PBExportHeader$cuo_cst_wallpaper.sru
forward
global type cuo_cst_wallpaper from nonvisualobject
end type
end forward

global type cuo_cst_wallpaper from nonvisualobject
event ue_paint ( )
end type
global cuo_cst_wallpaper cuo_cst_wallpaper

type prototypes
FUNCTION int     ReleaseDC(ulong handle, ulong hDC) LIBRARY "User32.dll"
FUNCTION ulong   SelectObject(ulong hDC, ulong hGDIObj) LIBRARY "Gdi32.dll"
FUNCTION int     BitBlt(ulong hDC, int num, int num, int num, int num, ulong hDC, int num, int num, ulong lParam) LIBRARY "Gdi32.dll"
FUNCTION ulong   CreateCompatibleDC(ulong hDC) LIBRARY "Gdi32.dll"
FUNCTION ulong   GetDC(ulong handle) LIBRARY "User32.dll"
FUNCTION ulong   LoadImageA( ulong hints, ref string lpszName,  UINT uType, int cxDesired,int cyDesired,UINT fuLoad ) library "user32.dll" Alias For "LoadImageA;Ansi"
FUNCTION ulong   GetObjectBitmap( ulong  hgdiobj, int  cbBuffer, ref s_bitmap bm ) library "gdi32.dll" alias for "GetObjectBitmap;Ansi" // GetObjectA
FUNCTION boolean DeleteObject ( ulong hgdiobj ) library "gdi32.dll" 
FUNCTION boolean StretchBlt(ulong hDCdest, int x1, int y1, int w1, int h1, ulong hDCsrc, int x2, int y2, int w2, int h2, ulong lParam) LIBRARY "Gdi32.dll"


end prototypes

type variables
boolean ib_mdi = false
mdiclient i_mdi
window iw_window
string ls_bitmap
ulong iul_hbitmap
ulong iul_hmdi
ulong iul_dcmdi
ulong iul_hDCMem
s_bitmap istr_Bitmap
boolean ib_center = FALSE
boolean ib_resize = TRUE
integer ii_TitleBarHeight = 200
end variables

forward prototypes
public function integer of_setwindow (window wa_window, mdiclient a_mdi)
public function integer of_setwindow (window wa_window)
public function integer of_setbitmap (string as_filename)
public function integer of_setwallpaper (boolean ab_switch)
end prototypes

event ue_paint();integer li_x = 0
integer li_y = 0
integer li_Width
integer li_Height
ulong lul_hOldBitmap
integer li_W
integer li_H

li_Width  = istr_bitmap.bmWidth
li_Height = istr_bitmap.bmHeight


if ib_mdi then
	li_w = i_mdi.width
	li_h = i_mdi.height
else
	li_w = iw_window.width
	li_h = iw_window.height - ii_TitleBarHeight
end if

if ib_Center then
	li_x = (UnitsToPixels(li_w,XUnitsToPixels!) - istr_bitmap.bmWidth ) / 2
	li_y = (UnitsToPixels(li_h,YUnitsToPixels!) - istr_bitmap.bmHeight ) / 2
end if
if ib_Resize then
	li_x = 0
	li_y = 0
	li_Width = UnitsToPixels(li_w,XUnitsToPixels!) 
	li_Height = UnitsToPixels(li_h,YUnitsToPixels!) 
end if

if ib_Center and not ib_Resize then
	if ib_mdi then
		i_mdi.backcolor = i_mdi.backcolor
	else
		iw_window.backcolor = iw_window.backcolor
	end if
end if


lul_hOldBitmap = SelectObject(iul_hDcMem,iul_hBitmap)
StretchBlt(iul_DcMdi,li_x,li_y,li_Width,li_Height,iul_hDcMem,0,0,istr_bitmap.bmWidth,istr_bitmap.bmHeight, 13369376) 
SelectObject(iul_hDcMem,lul_hOldBitmap)

end event

public function integer of_setwindow (window wa_window, mdiclient a_mdi);iw_window = wa_window
i_mdi = a_mdi
ib_mdi = TRUE
return 1
end function

public function integer of_setwindow (window wa_window);iw_window = wa_window
ib_mdi = FALSE
return 1
end function

public function integer of_setbitmap (string as_filename);ls_bitmap = as_filename

return 1
end function

public function integer of_setwallpaper (boolean ab_switch);ulong lul_Null
window lw_frame


if ab_switch then

	of_SetWallPaper(FALSE)

	SetNull(lul_Null)
	iul_hBitmap = loadImageA(lul_Null,ls_Bitmap,0,0,0,80)

	if ( iul_hBitmap  > 0 ) then
	
		GetObjectBitmap( iul_hBitmap, 28, istr_Bitmap )	
		if ib_Mdi then
			iul_hMdi = handle( i_Mdi )
		else
			iul_hMdi 	= handle( iw_Window )
		end if
		iul_DcMdi 	   = GetDC( iul_hMdi )
		iul_hDcMem     = CreateCompatibleDC(iul_DcMdi)
		
		this.Event Post ue_Paint()
		
		return 1
	
	else
	
		return -1
		
	end if

		
else

	DeleteObject ( iul_hBitmap )
	ReleaseDC(iul_DcMdi, iul_hMdi)

	return 1
	
end if


end function

on cuo_cst_wallpaper.create
call super::create
TriggerEvent( this, "constructor" )
end on

on cuo_cst_wallpaper.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;This.of_SetWallPaper(false)
end event

