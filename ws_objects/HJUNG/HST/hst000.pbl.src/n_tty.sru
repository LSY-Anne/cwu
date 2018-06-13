$PBExportHeader$n_tty.sru
$PBExportComments$Generic V24 funktions
forward
global type n_tty from nonvisualobject
end type
end forward

global type n_tty from nonvisualobject
end type
global n_tty n_tty

type prototypes

end prototypes

type variables
Public:
string commport 
int baudrate =  9600
int bytesize = 8
string parity = "N"
string stopbits = "1"
string handshake = "NO"

/* Set - Get CommEventMask */
CONSTANT UINT EV_RXCHAR  = 1  
CONSTANT UINT EV_RXFLAG  = 2   
CONSTANT UINT EV_TXEMPTY = 4    
CONSTANT UINT EV_CTS = 8    
CONSTANT UINT EV_DSR = 16  
CONSTANT UINT EV_RLSD = 32   
CONSTANT UINT EV_BREAK = 64   
CONSTANT UINT EV_ERR  = 128  
CONSTANT UINT EV_RING = 256  
CONSTANT UINT EV_PERR = 512  
CONSTANT UINT EV_CTSS  = 1024 
CONSTANT UINT EV_RLSDS = 4096 
/* Commnotify Event Messages */
CONSTANT UINT CN_RECEIVE =  01
CONSTANT UINT CN_TRANSMIT = 02
CONSTANT UINT CN_EVENT   = 04


Protected:
boolean isopen = FALSE
int  idcommdev = -1
int inqsize = 2048
int outqsize = 2048
boolean DEBUG = FALSE

end variables

forward prototypes
public function integer of_save_tty_profile (string as_filename)
public function integer of_getmaxcomm ()
public function integer of_readcomm (ref string ps_commbuf)
public function integer of_setdtr (boolean ab_on)
public function integer of_setrts (boolean ab_on)
public function integer of_setxonoff (boolean ab_on)
public subroutine of_setcommeventmask (unsignedinteger fnevtset)
public function integer of_getcommeventmask (integer fnevtclear)
public function integer of_clearcommbreak ()
public function boolean of_writecomm (string ps_commbuf)
public function integer of_enablecommnotification (integer hwnd, integer cbinqueue, integer cboutqueue, unsignedinteger eventmask, character evtchar)
public function boolean of_closecomm ()
public function boolean of_opencomm ()
public function string of_setup ()
public function string of_setup (integer ai_inqsize, integer ai_outqsize)
public function integer of_load_tty_profile (string as_filename, string as_commport)
public function unsignedinteger of_clearallevents ()
end prototypes

public function integer of_save_tty_profile (string as_filename);
IF this.commport = "" THEN return -1

// Set Bauderate
SetProfileString(as_filename,this.commport,"baudrate",string(this.baudrate))
// Set Databits
SetProfileString(as_filename,this.commport,"bytesize",string(this.bytesize))
// Set PARITY
SetProfileString(as_filename,this.commport,"parity",this.parity)
// Set Stopbits
SetProfileString(as_filename,this.commport,"stopbits",this.stopbits)
// Set Protokoll Handshake
SetProfileString(as_filename,this.commport,"handshake",this.handshake)

// Set Buffersize
SetProfileString(as_filename,this.commport,"inqsize",string(this.inqsize))
SetProfileString(as_filename,this.commport,"outqsize",string(this.outqsize))

return 1
end function

public function integer of_getmaxcomm ();// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_GetMaxComm not implemented !",StopSign!)
return -999
end function

public function integer of_readcomm (ref string ps_commbuf);// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_ReadComm not implemented !",StopSign!)
return -999
end function

public function integer of_setdtr (boolean ab_on);// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_SetDTR not implemented !",StopSign!)
return -999
end function

public function integer of_setrts (boolean ab_on);// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_SetRTS not implemented !",StopSign!)
return -999
end function

public function integer of_setxonoff (boolean ab_on);// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_SetXONOFF not implemented !",StopSign!)
return -999
end function

public subroutine of_setcommeventmask (unsignedinteger fnevtset);// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_SetCommEventMask not implemented !",StopSign!)

end subroutine

public function integer of_getcommeventmask (integer fnevtclear);// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_GetCommEventMask not implemented !",StopSign!)
return -999
end function

public function integer of_clearcommbreak ();// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_ClearCommBreak not implemented !",StopSign!)
return -999
end function

public function boolean of_writecomm (string ps_commbuf);// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_WriteComm not implemented !",StopSign!)
return FALSE
end function

public function integer of_enablecommnotification (integer hwnd, integer cbinqueue, integer cboutqueue, unsignedinteger eventmask, character evtchar);// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_EnableCommnotification not implemented !",StopSign!)
return -999
end function

public function boolean of_closecomm ();// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_CloseComm not implemented !",StopSign!)
return FALSE
end function

public function boolean of_opencomm ();// Not Valid
IF DEBUG THEN MessageBox("n_tty","Funktion of_OpenComm not implemented !",StopSign!)
return FALSE
end function

public function string of_setup ();IF this.isopen THEN return ""
 openwithparm(w_port_setup,this)
return this.Commport
end function

public function string of_setup (integer ai_inqsize, integer ai_outqsize);this.inqsize = ai_inqsize
this.outqsize = ai_outqsize

return this.of_Setup()



end function

public function integer of_load_tty_profile (string as_filename, string as_commport);// OPEN or not
IF this.isopen THEN return -1


IF as_commport = "" THEN return -1
this.CommPort = as_commport
// Get Bauderate
this.baudrate = ProfileInt(as_filename,as_commport,"baudrate",9600)
// Get Databits
this.bytesize = ProfileInt(as_filename,as_commport,"bytesize",8)
// Get PARITY
this.parity = ProfileString(as_filename,as_commport,"parity","N")
// Get Stopbits
this.stopbits = ProfileString(as_filename,as_commport,"stopbits","1")
// Get Protokoll Handshake
this.handshake = ProfileString(as_filename,as_commport,"handshake","NO")

// Get Buffersize
this.inqsize = ProfileInt(as_filename,as_commport,"inqsize",128)
this.outqsize = ProfileInt(as_filename,as_commport,"outqsize",128)

return 1
end function

public function unsignedinteger of_clearallevents ();return of_GetCommEventMask(65535)
end function

on n_tty.create
TriggerEvent( this, "constructor" )
end on

on n_tty.destroy
TriggerEvent( this, "destructor" )
end on

