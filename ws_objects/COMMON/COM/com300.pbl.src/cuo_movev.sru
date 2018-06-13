$PBExportHeader$cuo_movev.sru
$PBExportComments$수평으로 패널을 이동할수 있다.
forward
global type cuo_movev from statictext
end type
end forward

global type cuo_movev from statictext
int Width=247
int Height=76
string Text="none"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
string Pointer="SizeNS!"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
end type
global cuo_movev cuo_movev

type variables
Boolean ib_debug = false
long       il_HiddenColor = 16776960  //배그라운드 컬러
long       il_BackColor = 0 
int          ii_barheight = 15

end variables

forward prototypes
public function integer uf_setcolor (long al_rgb)
public function integer uf_resizebar (integer ai_x, integer ai_y, integer ai_width, integer ai_height)
public function integer uf_sety (integer ai_y)
public function integer uf_sety (dragobject addragobject, integer ai_pointery, boolean ai_boolean)
public function integer uf_movex (integer ai_position)
public function integer uf_movey (integer ai_position)
public function integer uf_move (integer ai_x, integer ai_y)
public function integer uf_resizey (dragobject addragobject, integer ai_flag)
public function integer uf_resizex (dragobject addragobject, integer ai_flag)
public function boolean uf_moveable (integer ai_x, integer ai_y, integer ai_start, integer ai_end)
public function integer uf_setbackcolor (long al_rgb)
end prototypes

event mousemove;//Integer	li_prevposition
//flags = 1
//If KeyDown(keyLeftButton!) Then
//	// Store the previous position.
//	li_prevposition = This.X
//
//	// Refresh the Bar attributes.
//	This.X = Parent.PointerX()
//	
//	// Perform redraws when appropriate.
//	If Not IsValid(idrg_topright) or Not IsValid(idrg_topleft) Then Return
//	If li_prevposition > idrg_topright.x Then idrg_topright.setredraw(true)
//	If li_prevposition < idrg_topleft.x + idrg_topleft.width Then idrg_topleft.setredraw(true)
//End If
//
end event

event mouseup;// Hide the bar
//////////////////////////////////////////////
// 마우스 버튼을 놓은 경우에 사용
//////////////////////////////////////////////
If Not ib_Debug Then This.BackColor = il_HiddenColor

end event

event mousedown;//////////////////////////////////////////////
// 처음 마우스 버튼을 눌른 경우에 사용한다.
//////////////////////////////////////////////
This.SetPosition(ToTop!)
If Not ib_debug Then This.BackColor = il_backcolor  // Show Bar in Black while being moved.
end event

public function integer uf_setcolor (long al_rgb);//현재의 색의 백그라운드의 색을 조정한다
il_HiddenColor  = al_rgb
This.BackColor  = il_HiddenColor
return 1
end function

public function integer uf_resizebar (integer ai_x, integer ai_y, integer ai_width, integer ai_height);////////////////////////////////////////////////
// 처음  프로그램을 시행시에 좌표를 선정시 사용
////////////////////////////////////////////////
//x,y
this.Move (ai_x, ai_y)
//width,height
this.Resize (ai_width, ii_barheight  + ai_height)
this.SetPosition(ToTop!)


//of_RefreshBars()

return 1
end function

public function integer uf_sety (integer ai_y);//y
this.Move (this.X, ai_y)

return 1
end function

public function integer uf_sety (dragobject addragobject, integer ai_pointery, boolean ai_boolean);int  i_Pointerx,i_pointery,i_height
int  i_IncreaseY //이동 Y좌표
//객체의 X,Y좌표로 이동한다
int i_x     ,i_y     ,i_w     ,i_h,i_tt
int i_thisx ,i_thisy ,i_thisw ,i_thish //현재 자신의 좌표 계산
int i_PY,iDy
Boolean B_Continue = False
int     i_return   = 0


/************************
 * 현재 마우스의 Y 좌표 *
 ************************/
i_pointery = ai_Pointery
i_thisy    = this.y
i_PY       = i_thisy
iDy        = adDragObject.y


//이동 개개체가 현재의 개체보다 y좌표가 큰경우
If i_PY    >= iDy THEN
	i_tt     = i_pointery + this.Height 
   IF (iDy <=  i_tt) THEN
      i_IncreaseY = i_pointery - i_thisy //마우스 포인트의 위치 - 개체의 우치
      i_y         = adDragObject.y
	
      IF i_pointery > i_y THEN
         If ai_boolean then this.uf_sety(i_pointery)
   		i_return    =  i_IncreaseY 
	   END IF
	END IF
ELSE
	i_tt     = i_pointery - this.Height 
	iDy     += adDragObject.Height

   IF (iDy >  i_tt) THEN
      i_IncreaseY = i_pointery - i_thisy //마우스 포인트의 위치 - 개체의 우치
      i_y         = adDragObject.y + adDragObject.Height - this.Height
	
      IF i_pointery < i_y THEN
         If ai_boolean then this.uf_sety(i_pointery)
		   i_return    =  i_IncreaseY 
   	END IF
	
   END IF

END IF

//현재 자신의 객체
return i_return
end function

public function integer uf_movex (integer ai_position);//x좌표의 이동 공간을 계산하다.
return (ai_position - this.x)
end function

public function integer uf_movey (integer ai_position);//y좌표의 이동 공간을 계산하다.
return (ai_position - this.y)
end function

public function integer uf_move (integer ai_x, integer ai_y);//객체의방향을 이동한다.
this.Move (ai_x, ai_y)

return 1
end function

public function integer uf_resizey (dragobject addragobject, integer ai_flag);/************************
 * 객체의 리사이즈 한다 *
 ************************/
int  i_height,i_y,i_h
int  i_dragy,i_dargHeight,i_dragh,i_dragyh
int  i_movePoint

i_y      = this.y
i_height = this.height
i_h      = i_y  + i_height

i_dragy      = adDragObject.y
i_dargHeight = adDragObject.Height
i_dragyh     = i_dragy + i_dargHeight  //객체의 전체 높이

i_dragh      = i_y     - i_dragy
i_movePoint  = i_dragy - i_h   
IF  ai_flag = 2 then //객체의 위로 증가
    adDragObject.Move(adDragObject.x       ,         i_h)
	 adDragObject.resize(adDragObject.Width , i_dargHeight +  i_movePoint)		 
else
    adDragObject.resize(adDragObject.Width , i_dragh)	
end IF	

adDragObject.Setredraw(true)


return 1
end function

public function integer uf_resizex (dragobject addragobject, integer ai_flag);//////////////////////////////////////////////
// 객체의 리사이즈 한다                   
//////////////////////////////////////////////
int  i_width,i_x,i_w
int  i_dragx,i_dargwidth,i_dragwx,i_dragxh
int  i_movePoint


i_x      = this.x
i_width  = this.width
i_w      = i_x  + i_width


i_dragx      = adDragObject.x
i_dargWidth  = adDragObject.Width
i_dragwx     = i_dragx + i_dargWidth  //객체의 전체 너비


i_dragxh     = i_x     - i_dragx //이동 너비
i_movePoint  = i_dragwx - i_w


IF  ai_flag = 2 then //객체의 위로 증가
    adDragObject.Move(i_w                  ,      adDragObject.y )
	 adDragObject.resize(i_movePoint,  adDragObject.height)		 
else
    adDragObject.resize(i_dragxh , adDragObject.height)	
end IF	


adDragObject.Setredraw(true)


return 1
end function

public function boolean uf_moveable (integer ai_x, integer ai_y, integer ai_start, integer ai_end);Boolean B_continue = false
int i_temp

IF ai_x = 0 then 
	i_temp = ai_end - this.Height
   IF (ai_start < ai_y ) and (ai_y < i_temp) then
		B_continue = true
	end IF
else
	i_temp = ai_end - this.width
   IF (ai_start < ai_x ) and (ai_x < i_temp) then
		B_continue = true
	end IF
	
end IF
return  B_continue
end function

public function integer uf_setbackcolor (long al_rgb);//현재의 색의 백그라운드의 색을 조정한다
il_backcolor    = al_rgb
return 1
end function

event constructor;il_HiddenColor = rgb(0,0,255)  
/////////////////////////////////////////
// 프로그램 사용 순선
// 0. uf_setColor(Parent.BackColor) //색조정
// 1. uf_resizebar(객체 생성시 사용한다)
/////////////////////////////////////////
//    이동,마우스 이동시 사용
// 2.
// IF  flags = 1 then  //마우스를 이동하는 경우
// i_y   = parent.pointery() //현 원도우에서 마우스 위치
// i_move      = uf_movey(i_y) //마우스 이동한 거리
//	 b_continue = this.uf_moveable(0,i_y,dw_list001.y,dw_list002.y + dw_list002.height)
//	 IF b_continue then	 uf_move(this.x ,this.y + i_move)
// end if	 
/////////////////////////////////////////
//    마우스를 버튼을 놓은 경우에 사용한다.
// 3. uf_resizey(dw_list001_01list,1)
//    uf_resizey(dw_list001_01update,2)
/////////////////////////////////////////
end event

