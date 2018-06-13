$PBExportHeader$w_hfn_cust_jumin.srw
$PBExportComments$관리항목에 의한 거래처 조회...(주민등록번호분)
forward
global type w_hfn_cust_jumin from window
end type
type cb_del from commandbutton within w_hfn_cust_jumin
end type
type cb_sav from commandbutton within w_hfn_cust_jumin
end type
type dw_update from cuo_dwwindow within w_hfn_cust_jumin
end type
type dw_main from cuo_dwwindow within w_hfn_cust_jumin
end type
type cb_ins from commandbutton within w_hfn_cust_jumin
end type
type sle_rsvn_no from singlelineedit within w_hfn_cust_jumin
end type
type st_2 from statictext within w_hfn_cust_jumin
end type
type sle_cust_name from singlelineedit within w_hfn_cust_jumin
end type
type st_1 from statictext within w_hfn_cust_jumin
end type
type gb_1 from groupbox within w_hfn_cust_jumin
end type
type gb_2 from groupbox within w_hfn_cust_jumin
end type
type cb_retrieve from commandbutton within w_hfn_cust_jumin
end type
type cb_cancel from commandbutton within w_hfn_cust_jumin
end type
type cb_ok from commandbutton within w_hfn_cust_jumin
end type
end forward

global type w_hfn_cust_jumin from window
integer width = 3808
integer height = 1996
boolean titlebar = true
string title = "거래처 도움말"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
cb_del cb_del
cb_sav cb_sav
dw_update dw_update
dw_main dw_main
cb_ins cb_ins
sle_rsvn_no sle_rsvn_no
st_2 st_2
sle_cust_name sle_cust_name
st_1 st_1
gb_1 gb_1
gb_2 gb_2
cb_retrieve cb_retrieve
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_hfn_cust_jumin w_hfn_cust_jumin

type variables

end variables

forward prototypes
public function boolean wf_chk_jumin (readonly string jumin)
end prototypes

event ue_db_retrieve();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
dw_main.SetReDraw(FALSE)

if dw_main.Retrieve(trim(sle_cust_name.text)+'%', TRIM(sle_rsvn_no.Text)+'%') = 0 then
	cb_ins.triggerevent(clicked!)
else
	dw_main.setfocus()
	dw_main.trigger event rowfocuschanged(1)
end if

dw_main.SetReDraw(TRUE)



end event

public function boolean wf_chk_jumin (readonly string jumin);//argument 설명
//    jumin(string, read only)-주민등록번호 13자리 
//return값 설명
// 	type : boolean
//           true - 정상  false - 주민등록번호 error
//		
//기타 주의사항
//

integer temp, mok, chk_bit
string chkdigit

temp= (integer(left(jumin,1)))   *2+ &
		(integer(mid (jumin,2,1))) *3+ &
		(integer(mid (jumin,3,1))) *4+ &
		(integer(mid (jumin,4,1))) *5+ &
		(integer(mid (jumin,5,1))) *6+ &
		(integer(mid (jumin,6,1))) *7+ &
		(integer(mid (jumin,7,1))) *8+ &
		(integer(mid (jumin,8,1))) *9+ &
		(integer(mid (jumin,9,1))) *2+ &
		(integer(mid (jumin,10,1)))*3+ &
		(integer(mid (jumin,11,1)))*4+ &
		(integer(mid (jumin,12,1)))*5

mok = temp / 11
chk_bit = 11 - ( temp - mok * 11)

chkdigit = string(chk_bit, "00000")
if mid(chkdigit,5,1) = mid (jumin,13,1) then
	return true
else
	return false
end if	

end function

on w_hfn_cust_jumin.create
this.cb_del=create cb_del
this.cb_sav=create cb_sav
this.dw_update=create dw_update
this.dw_main=create dw_main
this.cb_ins=create cb_ins
this.sle_rsvn_no=create sle_rsvn_no
this.st_2=create st_2
this.sle_cust_name=create sle_cust_name
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_retrieve=create cb_retrieve
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.cb_del,&
this.cb_sav,&
this.dw_update,&
this.dw_main,&
this.cb_ins,&
this.sle_rsvn_no,&
this.st_2,&
this.sle_cust_name,&
this.st_1,&
this.gb_1,&
this.gb_2,&
this.cb_retrieve,&
this.cb_cancel,&
this.cb_ok}
end on

on w_hfn_cust_jumin.destroy
destroy(this.cb_del)
destroy(this.cb_sav)
destroy(this.dw_update)
destroy(this.dw_main)
destroy(this.cb_ins)
destroy(this.sle_rsvn_no)
destroy(this.st_2)
destroy(this.sle_cust_name)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_retrieve)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: open
//	기 능 설 명: 거래처 정보 도움말
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
datawindowchild	ldw_temp
string				ls_cust_name

ls_cust_name = message.stringparm

sle_cust_name.text = ls_cust_name

f_centerme(this)

this.trigger event ue_db_retrieve()

end event

event key;CHOOSE CASE key
	CASE KeyEnter!
		cb_retrieve.POST EVENT clicked()
	CASE KeyEscape!
		cb_cancel.POST EVENT clicked()
END CHOOSE

end event

type cb_del from commandbutton within w_hfn_cust_jumin
integer x = 3072
integer y = 52
integer width = 457
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "삭제"
end type

event clicked;dwItemStatus l_status 


IF dw_update.object.cust_no[1] = '9999998' OR dw_update.object.cust_no[1] = '9999999'THEN
	messagebox('확인','이거래처는 삭제 할수 없습니다..!')
	RETURN
END IF

l_status = dw_update.getitemstatus(1, 0, Primary!)

IF l_status = New! OR l_status = NewModified! THEN 

ELSE
	
	IF f_messagebox( '2', 'DEL' ) = 1 THEN

		dw_update.deleterow(0)
		
		IF f_update( dw_update,'D') = TRUE THEN 
			messagebox("확인","삭제되었습니다!")
			parent.trigger event ue_db_retrieve()
		END IF	
 
	 END IF
END IF



end event

type cb_sav from commandbutton within w_hfn_cust_jumin
integer x = 2569
integer y = 52
integer width = 457
integer height = 112
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "저장"
end type

event clicked;int 		li_count, li_count2
string 	ls_cust_no, ls_jumin_no
dwItemStatus l_status 

	   
IF f_chk_modified(dw_update) = FALSE THEN RETURN

l_status = dw_update.getitemstatus(1, 0, Primary!)

IF l_status = New! OR l_status = NewModified! OR l_status = dataModified! THEN 

	string ls_colarry[] = {'cust_name/성명','jumin_no/주민등록번호'}
	
	IF f_chk_null( dw_update, ls_colarry ) = 1 THEN  
		dw_update.object.job_uid[1] = gstru_uid_uname.uid		//수정자
		dw_update.object.job_date[1] = f_sysdate()           // 오늘 일자 
		dw_update.object.job_add[1] = gstru_uid_uname.address  //IP
	ELSE
		return
	END IF	
	
	
	ls_jumin_no = dw_update.object.jumin_no[1]

	//주민등록번호 오류체크
	if wf_chk_jumin(ls_jumin_no) = false then
		messagebox('주민등록번호 확인', '잘못된 주민등록번호 입니다!', exclamation!)
		dw_update.setfocus()
		dw_update.setcolumn('jumin_no')
		return
	end if
	  
	IF l_status = New! OR l_status = NewModified! THEN
		//거래처번호 생성...
		SELECT 	NVL(MAX(CUST_NO),'0')
		INTO 		:ls_cust_no
		FROM 		FNDB.HFN603H
		WHERE 	CUST_NO < '9999998';
		
		if ls_cust_no = '0' then //처음 입력이면 앞자리에 '5'를 삽입
			dw_update.object.cust_no[1] = '5' + string(long(ls_cust_no) + 1,'000000')
		else
			dw_update.object.cust_no[1] = string(long(ls_cust_no) + 1,'0000000')
		end if
		
		ls_cust_no = dw_update.object.cust_no[1]
		
		// 거래처번호 중복 체크
		SELECT 	count(cust_no)
		INTO 		:li_count
		FROM   	FNDB.HFN603H
		WHERE 	CUST_NO = :ls_cust_no   ;
		
		IF li_count <> 0 THEN 
			messagebox("확인","이미 등록되어 있는 거래처 코드입니다. 거래처 코드를 확인하세요")
			dw_update.setfocus()
			dw_update.setcolumn("cust_no")
			RETURN
		END IF
		
		// 주민등록번호 중복체크	
		SELECT 	count(jumin_no)
		INTO 	 	:li_count2
		FROM   	FNDB.HFN603H
		WHERE  	jumin_no = :ls_jumin_no   ;
		
		IF li_count2 <> 0 THEN 
			messagebox("확인","이미 등록되어 있는 주민등록번호 입니다. 주민등록번호를 확인하세요")
			dw_update.setfocus()
			dw_update.setcolumn("jumin_no")
			RETURN
		END IF
		
	end if

	//성명
	dw_update.object.hname[1] = dw_update.object.cust_name[1]
	
	IF f_update( dw_update,'U') = TRUE THEN 
	
		String ls_cust_name   // 저장후 리스트에서 자료 찾기
		int  li_row
		
		ls_cust_name 	= trim(sle_cust_name.text) + '%'
		ls_jumin_no 	= trim(sle_rsvn_no.text) + '%'
		ls_cust_no   	= dw_update.object.cust_no[1]
		
		dw_main.retrieve(ls_cust_name, ls_jumin_no)
		li_row = dw_main.Find("cust_no = '" + ls_cust_no + "'",1,dw_main.rowcount())
		
//		dw_main.selectrow(0,FALSE)
		
		If li_row > 0 then   
//			dw_main.selectrow(li_row,tRUE)	
			dw_main.Setrow(li_row)
			dw_main.ScrollToRow(li_row)
		end IF
		
		messagebox("확인","저장되었습니다!")
		
	END IF
		  
END IF



end event

type dw_update from cuo_dwwindow within w_hfn_cust_jumin
integer x = 1737
integer y = 292
integer width = 1966
integer height = 1300
integer taborder = 40
string dataobject = "d_hfn_cust_jumin_2"
boolean border = false
end type

event constructor;call super::constructor;this.uf_setClick(False)


end event

event itemchanged;call super::itemchanged;
if dwo.name = 'jumin_no' then
	if len(data) < 13 then
		messagebox('주민등록번호 확인', '주민등록번호 자릿수가 틀립니다!')
		this.setfocus()
		this.setcolumn('jumin_no')
		return 0
	end if
	
	if wf_chk_jumin(data) = false then
		messagebox('주민등록번호 확인', '잘못된 주민등록번호 입니다!', exclamation!)
		this.setfocus()
		this.setcolumn('jumin_no')
		return 0
	end if
end if


end event

type dw_main from cuo_dwwindow within w_hfn_cust_jumin
integer x = 18
integer y = 208
integer width = 1637
integer height = 1660
integer taborder = 30
boolean titlebar = true
string title = "개인거래처 조회내용"
string dataobject = "d_hfn_cust_jumin_1"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_cust_no

//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

this.accepttext()

IF currentrow <> 0 THEN

	ls_cust_no = this.object.cust_no[currentrow]
	
	dw_update.retrieve(ls_cust_no) 
END IF

end event

event doubleclicked;call super::doubleclicked;if row = 0 then return

cb_ok.trigger event clicked()

end event

type cb_ins from commandbutton within w_hfn_cust_jumin
integer x = 2066
integer y = 52
integer width = 457
integer height = 112
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "입력"
end type

event clicked;
int li_row

		
dw_update.reset()		
dw_update.insertrow(0)

dw_update.object.cust_gbn[1] = '2'
dw_update.object.business_opt[1] = '2'

dw_update.object.worker[1] = gstru_uid_uname.uid      // 작업자 
dw_update.object.work_date[1] = f_sysdate()           // 오늘 일자 
dw_update.object.ipaddr[1] = gstru_uid_uname.address  //IP

dw_update.setfocus()


end event

type sle_rsvn_no from singlelineedit within w_hfn_cust_jumin
integer x = 1221
integer y = 60
integer width = 530
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_hfn_cust_jumin
integer x = 809
integer y = 76
integer width = 398
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "주민등록번호"
boolean focusrectangle = false
end type

type sle_cust_name from singlelineedit within w_hfn_cust_jumin
integer x = 210
integer y = 60
integer width = 530
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_hfn_cust_jumin
integer x = 55
integer y = 76
integer width = 160
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "성명"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hfn_cust_jumin
integer x = 14
integer width = 3739
integer height = 192
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type gb_2 from groupbox within w_hfn_cust_jumin
integer x = 1696
integer y = 208
integer width = 2057
integer height = 1664
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "개인거래처 내역"
end type

type cb_retrieve from commandbutton within w_hfn_cust_jumin
boolean visible = false
integer x = 1559
integer y = 188
integer width = 306
integer height = 116
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "조회"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: p_retrieve::clicked
//	기 능 설 명: 조회처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
parent.trigger event ue_db_retrieve()

end event

type cb_cancel from commandbutton within w_hfn_cust_jumin
boolean visible = false
integer x = 1559
integer y = 420
integer width = 306
integer height = 116
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "취소"
end type

event clicked;CLOSE(PARENT)

end event

type cb_ok from commandbutton within w_hfn_cust_jumin
boolean visible = false
integer x = 1559
integer y = 304
integer width = 306
integer height = 116
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "확인"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: cb_ok::clicked
//	기 능 설 명: 확인
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com
Long			ll_GetRow

IF dw_main.RowCount() = 0 THEN
	MessageBox('확인','자료를 조회 후 사용하시기 바랍니다.')
	return
END IF

ll_GetRow = dw_main.getrow()
IF ll_GetRow = 0 THEN
	MessageBox('확인','자료를 선택 후 사용하시기 바랍니다.')
	return
END IF


lstr_com.ls_item[1] = trim(dw_main.getitemstring(ll_getrow, 'cust_no'))
lstr_com.ls_item[2] = trim(dw_main.getitemstring(ll_getrow, 'cust_name'))
lstr_com.ls_item[3] = trim(string(dw_main.getitemnumber(ll_getrow, 'bank_code')))
lstr_com.ls_item[4] = trim(dw_main.getitemstring(ll_getrow, 'acct_no'))
lstr_com.ls_item[5] = trim(dw_main.getitemstring(ll_getrow, 'depositor'))
lstr_com.ls_item[6] = trim(dw_main.getitemstring(ll_getrow, 'jumin_no'))


CloseWithReturn(PARENT,lstr_com)


end event

