$PBExportHeader$cuo_dw_hac007h_search.sru
$PBExportComments$단위부서 예산신청 자료내역 조회
forward
global type cuo_dw_hac007h_search from datawindow
end type
end forward

global type cuo_dw_hac007h_search from datawindow
integer width = 3438
integer height = 1864
integer taborder = 1
boolean titlebar = true
string title = "단위부서 예산신청 자료내역 조회"
string dataobject = "d_hac007h_search"
boolean controlmenu = true
boolean minbox = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "..\BMP\fldropen.ico"
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event un_unmove pbm_syscommand
event key_enter pbm_dwnprocessenter
event key_press pbm_dwnkey
event key_enterpress pbm_custom01
event key_arrow pbm_custom02
event ue_nextpage pbm_custom37
event ue_priorpage pbm_custom24
end type
global cuo_dw_hac007h_search cuo_dw_hac007h_search

type variables
private :
  Boolean   ib_clicked = true,ib_keyBorde = False,ib_Sort = True
  Boolean   ib_multiselect = False
  Boolean   ib_scroll  = false //스크로여부

datawindowchild	idw_child
end variables

forward prototypes
public function boolean uf_isrownew (long ai_row)
public function integer uf_selectrow (integer ai_row)
public function integer uf_setclick (boolean ab_boolean)
public function integer uf_sethsplite (integer ai_x)
public function integer uf_setkey (boolean ab_flag)
public function integer uf_setmulty (boolean ab_flag)
public function integer uf_setpreview (boolean ab_boolean)
public function integer uf_setscroll (boolean ab_boolean)
public function integer uf_setsort (boolean ab_flag)
public function integer uf_tab ()
end prototypes

public function boolean uf_isrownew (long ai_row);//////////////////////////////////////////////////////////////////
// 	작성목적 : 새로운 행인지 아닌가를 판별한다.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

Boolean b_boolean = false
String  s_row

s_row    = this.Describe("evaluate('IF ( isrownew(),1,0)'," + String(ai_row) + ")")
IF s_row = '1' then b_boolean = True

return  b_boolean
end function

public function integer uf_selectrow (integer ai_row);//////////////////////////////////////////////////////////////////
// 	작성목적 : 원하는 행번호를 선택하여 행번호를 반전한다.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////
this.selectrow(0,false)
this.Setrow(ai_row)
IF ib_clicked then
   this.selectrow(ai_row,true)
end IF	
this.Scrolltorow(ai_row)
return 1
end function

public function integer uf_setclick (boolean ab_boolean);//////////////////////////////////////////////////////////////////
// 	작성목적 : Click 여부를 Seting 한다.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

//행을 선택시 데이타 처리
ib_clicked = ab_boolean
return 1
end function

public function integer uf_sethsplite (integer ai_x);//////////////////////////////////////////////////////////////////
// 	작성목적 : h 스트롤의 좌표를 선정한다.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

////h 스트롤의 좌표를 선정한다
// 데이타원도우.dataonject.컬럼명
// Appeon Deploy에서 지원하지 않으므로 막음
//this.Object.datawindow.horizontalscrollsplit = string(ai_x)
return 0
end function

public function integer uf_setkey (boolean ab_flag);//////////////////////////////////////////////////////////////////
// 	작성목적 : 키보드 사용 가능을 Seting 한다.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////


ib_keyborde  = ab_flag

return 1
end function

public function integer uf_setmulty (boolean ab_flag);//////////////////////////////////////////////////////////////////
// 	작성목적 : 멀티 셀렉트의 가능 여부 Seting
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

ib_multiselect = ab_flag
return 0
end function

public function integer uf_setpreview (boolean ab_boolean);//////////////////////////////////////////////////////////////////
// 	작성목적 : 현재 출력물을 플뷰하거나 정상적이게한다.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

IF ab_boolean THEN
   this.Modify("DataWindow.Print.Preview='yes'")
ELSE
   this.Modify("DataWindow.Print.Preview='no'")
END IF
return 1
end function

public function integer uf_setscroll (boolean ab_boolean);//////////////////////////////////////////////////////////////////
// 	작성목적 : 스크롤바를 선택한경우에 항상 가장 처음의 행을 선택하게한다.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

ib_scroll = ab_boolean
IF ib_scroll  then
   This.uf_selectrow(getrow())
end IF	
return 1
end function

public function integer uf_setsort (boolean ab_flag);//////////////////////////////////////////////////////////////////
// 	작성목적 : Sort 가능여부 Seting
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

ib_Sort = ab_Flag
return 0
end function

public function integer uf_tab ();//////////////////////////////////////////////////////////////////
// 	작성목적 : 다음 컬럼으로 이동.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

send(Handle(This),256,9,long(0,0))
return 1
end function

event constructor;//////////////////////////////////////////////////////////////////
// 	작성목적 : datawindow를 계승받기위한 User Object를 생성한다.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

this.visible	=	false

settransobject(sqlca)

this.getchild('stat_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('stat_class', 0)	< 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
end event

event clicked;string	dwobject, oldsort, newsort, band
string	ls_columnname
integer  li_pos
int  i_findrow,i_rowcount,i_stpos = 0,i
IF row > 0 and ib_clicked THEN 
	IF ib_multiselect  then
		IF KeyDown (KeyShift!) then
			i_rowcount     = this.rowcount()

			do
				 i_findrow  = This.getrow()//this.GetSelectedrow(i_stpos)			
				 IF i_findrow < 1   then exit
				 IF i_findrow > row then exit
				 i_stpos    = i_findrow
			loop while true
		
			IF  i_stpos > 0 then
				 for i = i_stpos to row
					  this.Selectrow(i,true)				
				 next
			else
				 IF this.IsSelected(row) then
					 this.Selectrow(row,False)
				 else
					 this.Selectrow(row,True)				
				 end IF
			end IF
		elseIF KeyDown (KeyControl!) then
				 IF this.IsSelected(row) then
					 this.Selectrow(row,False)
				 else
						 this.Selectrow(row,True)				
				 end IF
		else   //일반적으로 행선택이 되었을 경우 
		   this.SelectRow(0  , FALSE)
   		this.SelectRow(row, TRUE)
		end IF
	ELSE		//IF ib_multiselect 
	   this.SelectRow(0  , FALSE)
   	this.SelectRow(row, TRUE)
	   this.SetRow(row)	
	end IF
	
else

	IF ib_Sort then
		dwobject = this.GetObjectAtPointer()
		band 		= this.GetBandAtPointer()
		if Match(dwobject, "[_t0-9]$") and left(band, 6) = 'header' then
			If This.Rowcount() > 0 Then
				openwithparm(w_sort, This)
			End if
		End if
	end IF
end IF


end event

event rowfocuschanging;////////////////////////////////////////////////////////////////
// 	작성목적 : 선택된 행을 반전 한다..
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

int  i_edit = 0 //에디터가능한다.

////////////////////////////////////////////////
// 읽기만 가능한 경우에 사용한다.
////////////////////////////////////////////////
IF   ib_keyborde then
  	  Selectrow(0   ,false)				
     Selectrow(newrow,true)					 
end IF

return i_edit

end event

event scrollvertical;//////////////////////////////////////////////////////////////////
// 	작성목적 : 클릭을 할수 있게 선택한 경우에 한하여 스크롤을 하면 항상 처음의 행을 선택한다
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

string s
IF ib_scroll then 
   s                 = This.Describe("DataWindow.FirstRowOnPage")
   IF IsNumber(s) THEN This.uf_selectrow(Long(s))
end IF	


end event

on cuo_dw_hac007h_search.create
end on

on cuo_dw_hac007h_search.destroy
end on

event dberror;//////////////////////////////////////////////////////////////////
// 	작성목적 : DB ERR시 나타내는 에러 메세지.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

IF sqldbcode < 0 then
choose case sqldbcode
	case 1
	case else
		MessageBox('확인',sqlerrtext + ' ~r' + sqlsyntax)
end choose
end IF
end event

event doubleclicked;this.visible	=	false
end event

event retrieveend;selectrow(0, false)
selectrow(1, true)

end event

event rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)
//
end event

