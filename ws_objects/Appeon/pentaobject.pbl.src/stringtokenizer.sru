$PBExportHeader$stringtokenizer.sru
forward
global type stringtokenizer from nonvisualobject
end type
end forward

global type stringtokenizer from nonvisualobject autoinstantiate
end type

type variables
private String is_data
private String is_token
private String nextString
private String moreString
private Boolean	returnb
private Long	il_cnt
private Vector	ivc_data
end variables

forward prototypes
public subroutine settokenizer (string data, string token)
public function boolean hasmoretokens ()
public function string nexttoken ()
public function string getmorestring ()
public function long getcount ()
public function string gettoken (integer idx)
end prototypes

public subroutine settokenizer (string data, string token);Integer 	li_pos, li_cnt
String		ls_data	

is_token 	= token
il_cnt 		= 0

ivc_data.removeall( )

do while Len(data) > 0
	li_cnt++
	li_pos = Pos(data, token)
	IF li_pos = 0 THEN 
		li_pos = Len(data) + 1
	END IF

	ls_data 	= Left(data, li_pos - 1)
	data 		= Mid(data, li_pos + Len(token))
	IF IsNull(data) THEN data = ''
	ivc_data.setproperty(String(li_cnt), ls_data)
loop

end subroutine

public function boolean hasmoretokens ();String		ls_data
Boolean	lb_rtn = false

il_cnt++
IF il_cnt <= ivc_data.getkeycount( ) THEN
	lb_rtn = true
END IF

return lb_rtn
end function

public function string nexttoken ();return ivc_data.getproperty(String(il_cnt))
end function

public function string getmorestring ();String		ls_data
Integer	li_cnt, i

li_cnt = ivc_data.getkeycount( )

FOR i = il_cnt + 1 TO li_cnt
	ls_data += ivc_data.getproperty(String(i))
	IF i < li_cnt THEN ls_data += is_token
NEXT

return ls_data
end function

public function long getcount ();return ivc_data.getkeycount( )
end function

public function string gettoken (integer idx);return ivc_data.getproperty(String(idx))
end function

on stringtokenizer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on stringtokenizer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivc_data = Create Vector

end event

event destructor;IF IsValid(ivc_data) THEN Destroy ivc_data
end event

