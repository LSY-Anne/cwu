$PBExportHeader$w_ancresponse.srw
forward
global type w_ancresponse from window
end type
end forward

global type w_ancresponse from window
integer width = 3314
integer height = 1640
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event ue_postopen ( )
end type
global w_ancresponse w_ancresponse

event open;String					ls_arg, ls_syntax, ls_btn, ls_temp, ls_classname
Long					ll_rtn, ll_cnt, i, ll_row, ll_pos
stringtokenizer		token
DataStore			lds_data

lds_data		= Create DataStore
lds_data.dataobject = 'd_btnlist'
lds_data.setTransObject(sqlca)

ls_classname = Upper(This.ClassName())
select  Max(pgm_no), Max(pgm_id)
  Into :gs_pgmno, :gs_pgmid
  from cddb.pf_pgm_mst 
where pgm_id = :ls_classname
using sqlca;

IF sqlca.sqlcode <> 0 THEN
	messagebox("Info", "프로그램을 등록하여 사용해 주시기 바랍니다.")
	Close(This)
	return
END IF

//사용 할수 있는 버튼 list 가지고 오기.
ll_row = lds_data.retrieve(gs_empCode, gs_pgmid)

IF ll_row > 0 THEN
	FOR i = ll_row To 1 Step -1
		token.settokenizer(lds_data.getItemString(i, 2), ",")
		do while token.hasmoretokens( )
			ls_temp = token.nexttoken( )
			ll_pos	= Pos(ls_btn, "'" + ls_temp + "'", 1)
			IF ll_pos = 0 THEN
				ls_btn += "'" + ls_temp + "',"
			END IF
		loop
	NEXT
ELSE
	messagebox("Info", "권한이 없습니다. 등록하여 사용해 주시기 바랍니다.")
	Close(This)
	return
END IF

//버튼 리스트 중 사용 여부 체크하기.
ll_pos 		= LastPos(ls_btn, ",") - 1
ls_btn 		= LEFT(ls_btn, ll_pos)
IF ls_btn <> '' AND Not IsNull(ls_btn) THEN
	lds_data.dataobject = 'd_btncheck'
	lds_data.setTransObject(sqlca)
	ls_temp = lds_data.getSqlSelect()
	lds_data.setSqlSelect(ls_temp + " and pgm_no in (select pgm_no from cddb.pf_pgm_mst where pgm_id = '" + Upper(gs_pgmid) + "') and btn_id in (" + ls_btn + ")")
	ll_row = lds_data.retrieve()
	lds_data.setSqlSelect(ls_temp)
	ls_btn = "'"
	IF ll_row > 0 THEN
		FOR i = ll_row To 1 Step -1
			ls_btn += lds_data.getItemString(i, 1) + "','"
		NEXT
	END IF
	ll_pos			= LastPos(ls_btn, ",'") - 1
	ls_btn 		= LEFT(ls_btn, ll_pos)
	Powerobject	lpo
	lpo = this
	gf_setbtnenable(lpo, ls_btn)
END IF

This.Post Event ue_postopen()
end event

on w_ancresponse.create
end on

on w_ancresponse.destroy
end on

