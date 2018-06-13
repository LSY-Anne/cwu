$PBExportHeader$uo_dwfree.sru
forward
global type uo_dwfree from u_dwfree
end type
end forward

global type uo_dwfree from u_dwfree
string linecolor = "190,193,198"
string _backcolor = "232,236,239"
end type
global uo_dwfree uo_dwfree

on uo_dwfree.create
call super::create
end on

on uo_dwfree.destroy
call super::destroy
end on

event constructor;call super::constructor;this.setPosition(totop!)
end event

event itemerror;call super::itemerror;Return 1
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

