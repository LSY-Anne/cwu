$PBExportHeader$w_ancsheet.srw
forward
global type w_ancsheet from w_base
end type
type ln_templeft from line within w_ancsheet
end type
type ln_tempright from line within w_ancsheet
end type
type ln_temptop from line within w_ancsheet
end type
type ln_tempbuttom from line within w_ancsheet
end type
type ln_tempbutton from line within w_ancsheet
end type
type ln_tempstart from line within w_ancsheet
end type
end forward

global type w_ancsheet from w_base
integer width = 4517
integer height = 2256
string icon = "..\img\icon\windowIcon1.ico"
event ue_postopen ( )
event ue_closecheck ( ref integer ai_rtn )
ln_templeft ln_templeft
ln_tempright ln_tempright
ln_temptop ln_temptop
ln_tempbuttom ln_tempbuttom
ln_tempbutton ln_tempbutton
ln_tempstart ln_tempstart
end type
global w_ancsheet w_ancsheet

type prototypes
Function long removeTitleBar( long hWnd, long index ) Library "pbaddon.dll"
end prototypes

type variables
n_openwithparm		in_open
String					as_toolbarbtn_true, as_toolbarbtn_false
String					is_printlog

end variables

forward prototypes
end prototypes

event ue_postopen();String			ls_arg, ls_syntax, ls_true, ls_false, ls_btn, ls_temp
Long				ll_rtn, ll_cnt, i, ll_row, ll_pos
stringtokenizer		token
DataStore		lds_data

lds_data	= Create DataStore
lds_data.dataobject = 'd_btnlist2'
lds_data.setTransObject(sqlca)
ll_Row = lds_data.retrieve(gs_PgmNo, gs_empCode)

IF ll_Row > 0 THEN
	FOR i = ll_row To 1 Step -1
		token.settokenizer(lds_data.getItemString(i, 1), ",")
		do while token.hasmoretokens( )
			ls_temp = token.nexttoken( )
			ll_pos	= Pos(ls_btn, "'" + ls_temp + "'", 1)
			IF ll_pos = 0 THEN
				ls_btn += "'" + ls_temp + "',"
			END IF
		loop
	NEXT
END IF

IF ls_btn <> '' AND Not IsNull(ls_btn) THEN
	//버튼 리스트 중 사용 여부 체크하기.
	ll_pos 		= LastPos(ls_btn, ",") - 1
	ls_btn 		= LEFT(ls_btn, ll_pos)
	
	lds_data.dataobject = 'd_btncheck'
	lds_data.setTransObject(sqlca)
	ls_temp = lds_data.getSqlSelect()
	lds_data.setSqlSelect(ls_temp + " and pgm_no = '" + gs_PgmNo + "' and btn_id in (" + ls_btn + ")" )
	ll_row = lds_data.retrieve()
	lds_data.setSqlSelect(ls_temp)
	ls_btn = "'"
	IF ll_Row > 0 THEN
		FOR i = ll_row To 1 Step -1
			ls_btn += lds_data.getItemString(i, 1) + "','"
		NEXT
	END IF
	ll_pos			= LastPos(ls_btn, ",'") - 1
	ls_btn 		= LEFT(ls_btn, ll_pos)
	
	//V1.9.9.017  권한이 하나도 없으면 버튼에 권한이 없어야 하나 버튼이 활성화 됨.
	//PowerObject		lpo
	//lpo = This
	//gf_setbtnenable(lpo, ls_btn)
	//================================================
END IF

//V1.9.9.017  권한이 하나도 없으면 버튼에 권한이 없어야 하나 버튼이 활성화 됨.
PowerObject		lpo
lpo = This
gf_setbtnenable(lpo, ls_btn)
//================================================
//this.PostEvent(Activate!)
end event

on w_ancsheet.create
int iCurrent
call super::create
this.ln_templeft=create ln_templeft
this.ln_tempright=create ln_tempright
this.ln_temptop=create ln_temptop
this.ln_tempbuttom=create ln_tempbuttom
this.ln_tempbutton=create ln_tempbutton
this.ln_tempstart=create ln_tempstart
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_templeft
this.Control[iCurrent+2]=this.ln_tempright
this.Control[iCurrent+3]=this.ln_temptop
this.Control[iCurrent+4]=this.ln_tempbuttom
this.Control[iCurrent+5]=this.ln_tempbutton
this.Control[iCurrent+6]=this.ln_tempstart
end on

on w_ancsheet.destroy
call super::destroy
destroy(this.ln_templeft)
destroy(this.ln_tempright)
destroy(this.ln_temptop)
destroy(this.ln_tempbuttom)
destroy(this.ln_tempbutton)
destroy(this.ln_tempstart)
end on

event activate;window   parentwin
parentwin = This.Parentwindow()

IF IsValid(parentwin) THEN
	/*====================================
		V1.9.9 Bug Fix
		작업내용
			 현상 = 같은윈도우  여러개 실행하기
			 작업 = classname을 pgmno로 수정.
		작업자  : 김영재 송상철
	====================================*/
	//IF This.windowtype = MAIN! THEN parentwin.Dynamic wf_select(This.ClassName())
	IF This.windowtype = MAIN! THEN parentwin.Dynamic wf_select(this.getpgmno())
	//====================================
	
	gs_PgmId = Upper(This.ClassName())
	gs_activewindow = This
	
	f_set_message('', '', parentwin)			// 메세지 초기화
	f_set_PgmId(gs_PgmId, parentwin)	// 프로그램 ID Setting
	
	This.x = 0
	This.y = 0
	This.width = parentwin.Dynamic wf_getmdiwidth()
	This.height = parentwin.Dynamic wf_getmdiheight()
END IF
end event

event closequery;Integer	li_rtn
This.Event ue_closecheck(li_rtn)
IF li_rtn = -1 THEN Return 1

/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 같은윈도우  여러개 실행하기
		 작업 = classname을 pgmno로 수정.
	작업자  : 김영재 송상철
====================================*/
//IF IsValid(This.Parentwindow()) THEN This.Parentwindow().Dynamic wf_destroywin(this.classname())
IF IsValid(This.Parentwindow()) THEN This.Parentwindow().Dynamic wf_destroywin(this.getpgmno())
//====================================
end event

event open;/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 같은윈도우  여러개 실행하기
		 작업 = ancestor를 window에서 w_base로 수정.
	작업자  : 김영재 송상철
====================================*/
removeTitleBar(handle(this), 0)
This.Post Event ue_postopen()

end event

type ln_templeft from line within w_ancsheet
boolean visible = false
long linecolor = 134217857
integer linethickness = 2
integer beginx = 46
integer beginy = 24
integer endx = 46
integer endy = 2272
end type

type ln_tempright from line within w_ancsheet
boolean visible = false
long linecolor = 134217857
integer linethickness = 2
integer beginx = 4434
integer beginy = 24
integer endx = 4434
integer endy = 2272
end type

type ln_temptop from line within w_ancsheet
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 36
integer endx = 4471
integer endy = 36
end type

type ln_tempbuttom from line within w_ancsheet
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 2112
integer endx = 4471
integer endy = 2112
end type

type ln_tempbutton from line within w_ancsheet
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 120
integer endx = 4471
integer endy = 120
end type

type ln_tempstart from line within w_ancsheet
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 160
integer endx = 4471
integer endy = 160
end type

