$PBExportHeader$uo_grid.sru
$PBExportComments$DataObject - Grid 용
forward
global type uo_grid from uo_dwgrid
end type
end forward

global type uo_grid from uo_dwgrid
event ue_clicked ( integer xpos,  integer ypos,  long row,  dwobject dwo )
event ue_constructor ( )
event type integer ue_deleteend ( )
event type integer ue_deletestart ( )
event type integer ue_deleterow ( )
event type integer ue_insertend ( long al_row )
event type integer ue_insertstart ( )
event type integer ue_insertrow ( )
event ue_keyenter pbm_dwnprocessenter
end type
global uo_grid uo_grid

type variables
window 			iw_parent
Boolean			ib_multi_row	=	TRUE
Boolean			ib_end_add		=	FALSE

end variables

forward prototypes
public function long uf_deleteall ()
public function string uf_displayvalue (long ai_row, string as_col)
public function long uf_modifiedcount ()
end prototypes

event ue_clicked(integer xpos, integer ypos, long row, dwobject dwo);//
end event

event ue_constructor();iw_parent = Parent

This.SetTransObject(SQLCA)

end event

event type integer ue_deleteend();/*
 NAME   	: ue_DeleteEnd			
 RETURN 	: Long ( Success : 1, Fail : OTHERS)  
 DESC   	: Execute before ue_DeleteRow
*/
RETURN 1
end event

event type integer ue_deletestart();/*
 NAME   	: ue_DeleteStart			
 RETURN 	: Long ( Success : 1, Fail : OTHERS)  
 DESC   	: Execute before ue_DeleteRow
*/
RETURN 1

end event

event type integer ue_deleterow();/*
 NAME   	: ue_DeleteRow		
 RETURN 	: Long ( Success : 1, Fail : OTHERS)  
 DESC   	: Delete this Row
*/
Long		ll_rv
Long		ll_row
Long		ll_cnt

If This.RowCount() > 0 Then
	     This.Accepttext( )
		// call ue_DeleteStart 
		If This.Event ue_DeleteStart() = 1 Then
			ll_row	= This.GetRow()
			ll_cnt	= This.RowCount()
			If This.GetItemStatus(ll_row, 0, Primary!) = New! Or This.GetItemStatus(ll_row, 0, Primary!) = NewModified! Then
				ll_rv = 1
			Else
				ll_rv = gf_message(iw_parent, 2, '1004', iw_parent.Title, '')
			End If
		
			If ll_rv = 1 Then
				ll_rv		= This.DeleteRow(0)
				If ll_row <> ll_cnt And This.RowCount() > 0 Then This.Event Rowfocuschanged(ll_row)
				If ll_rv = 1 Then ll_rv = This.EVENT ue_DeleteEnd()
				RETURN ll_rv
			Else
				RETURN 0
			End If
		Else
			RETURN -1
		End If

Else
	RETURN 0
End If



end event

event type integer ue_insertend(long al_row);/*
 NAME   	: ue_InsertEnd																													                       
 RETURN 	: Long ( Success : 1, Fail : OTHERS)  
 DESC   	: Execute After ue_InsertRow
*/

RETURN 1
end event

event type integer ue_insertstart();RETURN 1

end event

event type integer ue_insertrow();/*
 NAME   	: ue_InsertRow																													                       
 RETURN 	: Long ( Success : 1, Fail : OTHERS)  
 DESC   	: Insert a new Row
*/
Long		ll_InsertRow
Long		ll_row

If This.Event ue_InsertStart() = 1 Then	

	If ib_end_add Then
		ll_InsertRow = This.InsertRow(0)
	Else
		ll_row			= This.GetRow()
		ll_InsertRow	= This.InsertRow(ll_row + 1)
	End If

	If ll_InsertRow > 0 Then
		This.SetRow(ll_InsertRow)
		This.ScrollTORow(ll_InsertRow)
		This.SetFocus()
		If This.Event ue_InsertEnd(ll_InsertRow) <> 1 Then RETURN -1
		RETURN 1
	Else
		
		gf_message(iw_parent, 2, '1003', iw_parent.Title, '')       // 검색자료 없음 
		RETURN -1
	End If

Else
	RETURN -1
End If

end event

event ue_keyenter;Send(Handle(This), 256,9,0)
RETURN 1
end event

public function long uf_deleteall ();/*
 NAME   	: uf_DeleteAll																													
 RETURN 	: Long ( Deleted Row Count )                         
 DESC   	: Delete Entire Row
*/
Long				li_RowCount, i

li_RowCount = THIS.RowCount()

For i = li_RowCount To 1 Step -1
	THIS.DeleteRow(i)
Next

Return li_RowCount

end function

public function string uf_displayvalue (long ai_row, string as_col);THIS.AcceptText()
Return THIS.Describe("evaluate('LookUpDisplay(" + as_col + ")'," + String(ai_row) + ")")

end function

public function long uf_modifiedcount ();Return THIS.ModIFiedCount() + THIS.DeletedCount()
end function

event clicked;call super::clicked;String	ls_tag
String	ls_gubun
String	ls_name
String	ls_date

If row <= 0 Then RETURN

ls_tag	= Trim(This.Describe(String(dwo.name) + '.Tag'))

If ls_tag <> '?' Then
	ls_gubun	= func.of_get_token(ls_Tag, '(')
	ls_name	= func.of_get_Token(ls_Tag, ')')
End If

If Pos(Upper(ls_gubun) , 'DATE') > 0  And This.Describe(ls_name + '.Coltype') <> '!' Then
	If This.AcceptText() = -1 Then
		This.SetFocus()
		Return
	End If
		ls_date	=	String(This.GetItemString(row, ls_name), '@@@@/@@/@@')		

	If gf_dwsetdate( This,  ls_name, ls_date) Then
		ls_date = String(Date(ls_date), 'yyyymmdd')
		This.SetItem(row,  ls_name, ls_date)
	End If
End If

Trigger Event ue_clicked(xpos, ypos, row, dwo)
end event

event constructor;call super::constructor;Post Event ue_constructor()
end event

event dberror;call super::dberror;gf_dberr_msg(Parent.ClassName(), THIS.ClassName(), sqldbcode, sqlerrtext)

THIS.SetFocus()

Return 1

end event

event getfocus;call super::getfocus;// DataWindow가 Focus를 받으면 첫번째 Item의 Text를 반전시킨다

If This.RowCount() = 0 Then RETURN

This.SelectText(1,Len(This.GetText()) + 100)

end event

event itemchanged;call super::itemchanged;String		ls_tag
String		ls_Data

If This.RowCount() = 0 Then RETURN
If row <= 0 Then RETURN

This.SelectText(1,Len(This.GetText()) + 100)

ls_Tag  = Trim(This.Describe(dwo.name + '.Tag'))

If Pos(Upper(ls_Tag), "DATE") > 0 Then
	If NOT func.of_check_day(data, 'YMD') Then
		ls_Data = This.GetItemString(row, String(dwo.name), Primary!, FALSE)
		gf_message(iw_parent, 2, '9999', 'ERROR', '날자형식이 아닙니다.')
		This.Post setItem(row,	String(dwo.name), ls_Data)
		RETURN 1
	End If
ElseIf Pos(Upper(ls_Tag), "TIME") > 0 Then
	If NOT func.of_time_valid_nomsg(data) Then
		ls_Data = This.GetItemString(row, String(dwo.name), Primary!, FALSE)
		gf_message(iw_parent, 2, '9999', 'ERROR', '시간 입력이 잘못되었습니다.')
		This.Post setItem(row,	String(dwo.name), ls_Data)
		RETURN 1
	End If
ElseIf Pos(Upper(ls_Tag), "YYYY") > 0 Then
	If NOT func.of_check_day(data, 'YYYY') Then
		ls_Data = This.GetItemString(row, String(dwo.name), Primary!, FALSE)
		gf_message(iw_parent, 2, '9999', 'ERROR', '년도 입력이 잘못되었습니다.')
		This.Post setItem(row,	String(dwo.name), ls_Data)
		RETURN 1
	End If
ElseIf Pos(Upper(ls_Tag), "YYMM") > 0 Then
	If NOT func.of_check_day(data, 'YYYYMM') Then
		ls_Data = This.GetItemString(row, String(dwo.name), Primary!, FALSE)
		gf_message(iw_parent, 2, '9999', 'ERROR', '년월 입력이 잘못되었습니다.')
		This.Post setItem(row,	String(dwo.name), ls_Data)
		RETURN 1
	End If
End If

end event

event itemerror;call super::itemerror;RETURN 1
end event

event itemfocuschanged;call super::itemfocuschanged;// Item의 Focus가 변경된 경우 변경된 Item의 Text를 반전시킨다
String		ls_tag

If This.RowCount() = 0 Then RETURN
If row <= 0 Then RETURN

This.SelectText(1,Len(This.GetText()) + 100)

ls_Tag  = Trim(This.Describe(dwo.name + '.Tag'))

If Pos(Upper(ls_Tag), "KOR") > 0 Then
	gf_settoggle(handle(This), KOR)
Else
	gf_settoggle(handle(This), ENG)
End If

end event

on uo_grid.create
call super::create
end on

on uo_grid.destroy
call super::destroy
end on

event doubleclicked;call super::doubleclicked;String	ls_tag, ls_gubun, ls_name, ls_date, ls_coltype

If row <= 0 Then RETURN
If Lower(This.Describe("DataWindow.ReadOnly")) = 'yes' Then RETURN

ls_tag	= Trim(This.Describe(String(dwo.name) + '.Tag'))

If ls_tag <> '?' Then
	ls_gubun	= func.of_get_token(ls_Tag, '(')
	ls_name	= dwo.Name //func.of_get_Token(ls_Tag, ')')
End If

ls_coltype = This.Describe(ls_name + '.Coltype')

If Pos(Upper(ls_gubun) , 'DATE') > 0  And ls_coltype <> '!' Then
	If This.AcceptText() = -1 Then
		This.SetFocus()
		Return
	End If
	
	If ls_coltype = 'date' Then
		ls_date	=	String(This.GetItemDate(row, ls_name), '@@@@/@@/@@')
	ElseIf Left(ls_coltype,4) = 'char' Then
		ls_date	=	String(This.GetItemString(row, ls_name), '@@@@/@@/@@')	
	End If

	If gf_dwsetdate( This,  ls_name, ls_date) Then
		If ls_coltype = 'date' Then
			This.SetItem(row,  ls_name, Date(ls_date))
		ElseIf Left(ls_coltype,4) = 'char' Then
			ls_date = String(Date(ls_date), 'yyyymmdd')
			This.SetItem(row,  ls_name, ls_date)
		End If
	End If
End If
end event

