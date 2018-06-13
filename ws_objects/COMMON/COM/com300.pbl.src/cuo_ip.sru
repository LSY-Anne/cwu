$PBExportHeader$cuo_ip.sru
$PBExportComments$IP 주소찾기
forward
global type cuo_ip from nonvisualobject
end type
end forward

global type cuo_ip from nonvisualobject
end type
global cuo_ip cuo_ip

type prototypes
Subroutine About ( ) library "getmacip.dll"
Function integer GetMACAddress ( ref string buf, integer len ) library "getmacip.dll" Alias For "GetMACAddress;Ansi"
Function integer GetIPAddress ( ref string buf, integer len ) library "getmacip.dll" Alias For "GetIPAddress;Ansi"
end prototypes

type variables
Private:
String is_ipaddr, is_macaddr
end variables

forward prototypes
public function integer uf_getipaddr (ref string ipaddr)
public function integer uf_getmacaddr (ref string macaddr)
public subroutine uf_about ()
end prototypes

public function integer uf_getipaddr (ref string ipaddr);SetNull (ipaddr)

IF isNull ( is_ipaddr) THEN
	return 0
ELSE
	ipaddr = is_ipaddr
	return 1
END IF
end function

public function integer uf_getmacaddr (ref string macaddr);SetNull (macaddr)

IF isNull ( is_macaddr) THEN
	return 0
ELSE
	macaddr = is_macaddr
	return 1
END IF
end function

public subroutine uf_about ();About()
end subroutine

on cuo_ip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on cuo_ip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;String ls_buf

ls_buf = Space(50)
IF GetMACAddress ( ls_buf, 50 ) = 1 THEN
	is_macaddr = ls_buf
ELSE
	SetNull(is_macaddr)
END IF

ls_buf = Space(50)
IF GetIPAddress ( ls_buf, 50 ) = 1 THEN
	is_ipaddr = ls_buf
ELSE
	SetNull(is_ipaddr)
END IF

end event

