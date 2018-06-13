$PBExportHeader$cuo_dwwindow.sru
$PBExportComments$데이타 원도우 뭄직이지 않는다.주로 List데이타 원도우에 사용한다.
forward
global type cuo_dwwindow from datawindow
end type
end forward

global type cuo_dwwindow from datawindow
integer width = 494
integer height = 360
integer taborder = 1
boolean livescroll = true
event un_unmove pbm_syscommand
event key_enter pbm_dwnprocessenter
event key_press pbm_dwnkey
event key_enterpress pbm_custom01
event key_arrow pbm_custom02
event ue_nextpage pbm_custom37
event ue_priorpage pbm_custom24
end type
global cuo_dwwindow cuo_dwwindow

type variables
private :
  Boolean   ib_clicked = true,ib_keyBorde = False,ib_Sort = True
  Boolean   ib_multiselect = False
  Boolean   ib_scroll  = false //스크로여부

long		il_currentrow	=	0
end variables

forward prototypes
public function integer uf_selectrow (integer ai_row)
public function integer uf_setclick (boolean ab_boolean)
public function integer uf_sethsplite (integer ai_x)
public function integer uf_setkey (boolean ab_flag)
public function integer uf_setmulty (boolean ab_flag)
public function integer uf_setpreview (boolean ab_boolean)
public function integer uf_setscroll (boolean ab_boolean)
public function integer uf_tab ()
public function integer uf_setsort (boolean ab_flag)
public function boolean uf_isrownew (long ai_row)
public subroutine uf_winid (window as_window)
end prototypes

event un_unmove;//////////////////////////////////////////////////////////////////
// 	작성목적 : 데이타윈도우의 Move 금지
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

uint li_msg
li_msg = message.wordparm
CHOOSE CASE li_msg
	CASE 61456, 61458
		message.processed = true
//		message.returnvalue = 0
END CHOOSE

return
end event

public function integer uf_selectrow (integer ai_row);//////////////////////////////////////////////////////////////////
// 	작성목적 : 원하는 행번호를 선택하여 행번호를 반전한다.
//    적 성 인 : 문준영
//		작성일자 : 2001.07
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
//    적 성 인 : 문준영
//		작성일자 : 2001.07
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
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

////h 스트롤의 좌표를 선정한다
// 데이타원도우.dataonject.컬럼명
// Appeon Deploy에서 지원하지 않으므로 막음.
//this.Object.datawindow.horizontalscrollsplit = string(ai_x)
return 0
end function

public function integer uf_setkey (boolean ab_flag);//////////////////////////////////////////////////////////////////
// 	작성목적 : 키보드 사용 가능을 Seting 한다.
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

ib_keyborde  = ab_flag

return 1
end function

public function integer uf_setmulty (boolean ab_flag);//////////////////////////////////////////////////////////////////
// 	작성목적 : 멀티 셀렉트의 가능 여부 Seting
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

ib_multiselect = ab_flag
return 0
end function

public function integer uf_setpreview (boolean ab_boolean);//////////////////////////////////////////////////////////////////
// 	작성목적 : 현재 출력물을 플뷰하거나 정상적이게한다.
//    적 성 인 : 문준영
//		작성일자 : 2001.07
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
//    적 성 인 : 문준영
//		작성일자 : 2001.07
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

public function integer uf_tab ();//////////////////////////////////////////////////////////////////
// 	작성목적 : 다음 컬럼으로 이동.
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

send(Handle(This),256,9,long(0,0))
return 1
end function

public function integer uf_setsort (boolean ab_flag);//////////////////////////////////////////////////////////////////
// 	작성목적 : Sort 가능여부 Seting
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

ib_Sort = ab_Flag
return 0
end function

public function boolean uf_isrownew (long ai_row);//////////////////////////////////////////////////////////////////
// 	작성목적 : 새로운 행인지 아닌가를 판별한다.
//    적 성 인 : 문준영
//		작성일자 : 2001.07
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

public subroutine uf_winid (window as_window);string ls_window
ls_window = upper(as_window.Classname( ))
This.Modify("w_id.Text='" + ls_window + "'")
end subroutine

event constructor;//////////////////////////////////////////////////////////////////
// 	작성목적 : datawindow를 계승받기위한 User Object를 생성한다.
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

this.SettransObject(sqlca)
end event

event clicked;string	dwobject, oldsort, newsort, band
string	ls_columnname
integer  li_pos
int  i_findrow,i_rowcount,i_stpos = 0,i,li_idx
IF row > 0 and ib_clicked THEN 
	IF ib_multiselect  then
		IF KeyDown(KeyShift!) THEN
			IF il_currentrow = 0 THEN
				THIS.SelectRow(row,TRUE)
			END IF
		
			IF il_currentrow > row THEN
				FOR li_idx = il_currentrow TO row STEP -1
					THIS.SelectRow(li_idx,TRUE)     	
				NEXT	
			ELSE
				FOR li_idx = il_currentrow TO row
					THIS.SelectRow(li_idx,TRUE)   
				NEXT	
			END IF
		ELSE
			IF KeyDown(KeyControl!) THEN
				IF GetSelectedRow(Row - 1) = Row THEN
					THIS.SelectRow(Row,FALSE)
				ELSE
					THIS.SelectRow(Row,TRUE)
				END IF
			Else
				THIS.SelectRow(0,FALSE)
				THIS.SelectRow(Row,True)							
			END IF
		END IF
		
//		
//		
//		
//		
//		IF KeyDown (KeyShift!) then
//			i_rowcount     = this.rowcount()
//
//			do
//				 i_findrow  = this.GetSelectedrow(i_stpos)			
//				 IF i_findrow < 1   then exit
//				 IF i_findrow > row then exit
//				 i_stpos    = i_findrow
//			loop while true
//		
//			IF  i_stpos > 0 then
//				 for i = i_stpos to row
//					  this.Selectrow(i,true)				
//				 next
//			else
//				 IF this.IsSelected(row) then
//					 this.Selectrow(row,False)
//				 else
//					 this.Selectrow(row,True)				
//				 end IF
//			end IF
//		elseIF KeyDown (KeyControl!) then
//				 IF this.IsSelected(row) then
//					 this.Selectrow(row,False)
//				 else
//						 this.Selectrow(row,True)				
//				 end IF
//		else   //일반적으로 행선택이 되었을 경우 
//		   this.SelectRow(0  , FALSE)
//   		this.SelectRow(row, TRUE)
//		end IF
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
il_currentrow = row

end event

event rowfocuschanging;////////////////////////////////////////////////////////////////
// 	작성목적 : 선택된 행을 반전 한다..
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

int  i_edit = 0 //이티터가능한다.

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
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

string s
IF ib_scroll then 
   s                 = This.Describe("DataWindow.FirstRowOnPage")
//   s               = This.Describe("DataWindow.LastRowOnPage")	
   IF IsNumber(s) THEN This.uf_selectrow(Long(s))
end IF	


end event

on cuo_dwwindow.create
end on

on cuo_dwwindow.destroy
end on

event dberror;//////////////////////////////////////////////////////////////////
// 	작성목적 : DB ERR시 나타내는 에러 메세지.
//    적 성 인 : 문준영
//		작성일자 : 2001.07
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

event retrieveend;if il_currentrow	>	rowcount	then
	il_currentrow	=	0
end if

setredraw(false)
scrolltorow(il_currentrow)
setrow(il_currentrow)
setredraw(true)

il_currentrow	=	0


end event

event updatestart;il_currentrow	=	getrow()

end event

event retrievestart;setredraw(false)
reset()
end event

