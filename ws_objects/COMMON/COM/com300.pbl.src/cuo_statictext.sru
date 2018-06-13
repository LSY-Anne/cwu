$PBExportHeader$cuo_statictext.sru
$PBExportComments$데이타 윈도우의 텍스트 컬러
forward
global type cuo_statictext from statictext
end type
end forward

global type cuo_statictext from statictext
int Width=247
int Height=76
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="굴림체"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type
global cuo_statictext cuo_statictext

type variables
long il_rgb
end variables

forward prototypes
public function integer uf_setbackcolor (long al_rgb)
end prototypes

public function integer uf_setbackcolor (long al_rgb);/////////////////////////////////////////////////////////////
//현재의 색을 변경한다.
//////////////////////////////////////////////////////////////
il_rgb         = al_rgb
This.BackColor = il_rgb
return 1

end function

event constructor;il_rgb           = RGB(174,122,136) 
uf_setBackColor(il_rgb)

end event

