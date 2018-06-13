$PBExportHeader$w_hgm201pp.srw
$PBExportComments$소모품관리
forward
global type w_hgm201pp from window
end type
type cb_end from uo_imgbtn within w_hgm201pp
end type
type cb_save from uo_imgbtn within w_hgm201pp
end type
type cb_delete from uo_imgbtn within w_hgm201pp
end type
type cb_insert from uo_imgbtn within w_hgm201pp
end type
type dw_update from uo_dwgrid within w_hgm201pp
end type
type st_4 from statictext within w_hgm201pp
end type
type sle_item_date from singlelineedit within w_hgm201pp
end type
type sle_gwa_name from singlelineedit within w_hgm201pp
end type
type sle_gwa from singlelineedit within w_hgm201pp
end type
type sle_gian_no from singlelineedit within w_hgm201pp
end type
type st_2 from statictext within w_hgm201pp
end type
type st_1 from statictext within w_hgm201pp
end type
type gb_1 from groupbox within w_hgm201pp
end type
end forward

global type w_hgm201pp from window
integer width = 3447
integer height = 1948
boolean titlebar = true
string title = "소모품관리"
boolean controlmenu = true
windowtype windowtype = response!
event ue_retrieve pbm_custom01
event ue_insert pbm_custom02
event ue_save pbm_custom03
event ue_delete pbm_custom06
cb_end cb_end
cb_save cb_save
cb_delete cb_delete
cb_insert cb_insert
dw_update dw_update
st_4 st_4
sle_item_date sle_item_date
sle_gwa_name sle_gwa_name
sle_gwa sle_gwa
sle_gian_no sle_gian_no
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_hgm201pp w_hgm201pp

type variables
integer ii_item_gian_no
string  is_gwa ,is_apply_date,is_item_gwa, is_gian_no
end variables

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////
// 이 벤 트 명: ue_retrieve
// 기 능 설 명: 자료조회
// 작성/수정자:
// 작성/수정일:
// 주 의 사 항:
//////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건체크
//////////////////////////////////////////////////////////////////////////////////
String	ls_gian_no, ls_gwa , ls_item_date
integer	li_gian_no

li_gian_no 	= integer(TRIM(sle_gian_no.Text))
ls_gwa		= sle_gwa.text

ls_item_date	= TRIM(sle_item_date.text)
						
SetPointer(HourGlass!)

//messagebox('li_gian_no', li_gian_no)
//messagebox('ls_gwa',ls_gwa)

Long		ll_RowCnt
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(li_gian_no, ls_gwa, ls_item_date)
dw_update.SetReDraw(TRUE)

IF ll_RowCnt > 0 THEN
	dw_update.SetFocus()
END IF
//////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////
end event

event ue_insert;Long		ll_InsRow

ll_InsRow = dw_update.InsertRow(0)

dw_update.object.ITEM_GIAN_NO  [ll_InsRow] = integer(is_gian_no)				//구매번호
dw_update.object.gwa  			 [ll_InsRow] = sle_gwa.text				//학과/부서
dw_update.object.item_gb  		 [ll_InsRow] = '1'							//소모품 구분
dw_update.object.item_date		 [ll_InsRow] = is_apply_date			 	//구매일자
dw_update.object.worker        [ll_InsRow] = gstru_uid_uname.uid		//등록자
dw_update.object.ipaddr        [ll_InsRow] = gstru_uid_uname.address	//등록IP
dw_update.object.work_date     [ll_InsRow] = f_sysdate()					//등록일자
//IF ll_InsRow > 1 THEN
//	dw_update.object.item_name[ll_InsRow] = dw_update.object.item_name[ll_InsRow - 1]	   //부대품코드
//END IF
dw_update.ScrollToRow(ll_InsRow)
dw_update.setfocus()
dw_update.setrow(ll_InsRow)
end event

event ue_save;String	ls_colarry[]
String	ls_gian_no, ls_gwa, ls_item_date
Long		ll_item_class
Long		ll_row
Long		ll_max
Long		ll_count = 0

SetNull(ll_max)
IF f_chk_modified(dw_update) = FALSE THEN RETURN
 
dw_update.AcceptText()

ls_gian_no = sle_gian_no.text
ls_gwa		= sle_gwa.text
ls_item_date = sle_item_date.text


ls_colarry[] = {'item_name/품명'}

IF f_chk_null( dw_update, ls_colarry ) = 1 THEN 
	ll_row = dw_update.getnextmodified(0,primary!)	
	
	DO WHILE ll_row > 0
		dw_update.object.job_uid[ll_row] = gstru_uid_uname.uid         //등록자
		dw_update.object.job_add[ll_row] = gstru_uid_uname.address		//등록IP
		dw_update.object.job_date[ll_row] = f_sysdate()     				//등록일자
		
		IF isnull(dw_update.getitemnumber(ll_row, "SERIAL_NO")) THEN 	//신규일경우 소모품번호를 할당해 주기위해
			ll_count = ll_count + 1
			IF isNull(ll_max) THEN			//신규의 첫번째 로우만
				SELECT NVL(MAX(SERIAL_NO),0)
				INTO   :ll_max
				FROM   STDB.HST105M
				WHERE  ITEM_GIAN_NO  = :ls_gian_no
				AND	GWA 				= :ls_gwa
				AND   ITEM_DATE 		= :ls_item_date
				
				USING  SQLCA;
			END IF
			dw_update.object.SERIAL_NO[ll_row] = ll_max + ll_count
		END IF
			
		ll_row = dw_update.getnextmodified(ll_row,primary!)
	LOOP
	
	dw_update.accepttext()
   IF f_update( dw_update,'U') = TRUE THEN 			   			
	   messagebox("알림", "저장되었습니다")
	   THIS.triggerevent('ue_retrieve')
   END IF		 
END IF
end event

event ue_delete;long ll_row

ll_row = dw_update.GetRow()

IF ll_row <> 0 THEN
				
	dwItemStatus l_status 
	l_status = dw_update.getitemstatus(ll_row, 0, Primary!)

	IF l_status = New! OR l_status = NewModified! THEN 
		dw_update.deleterow(ll_row)
		
	   IF f_update( dw_update,'D') = TRUE  THEN 
			messagebox('확인','삭제 되었습니다..!')
		END IF
	ELSE
	
	  IF f_messagebox( '2', 'DEL' ) = 1 THEN
		  
		  dw_update.deleterow(ll_row)

	  END IF		
	
	END IF
END IF	
end event

on w_hgm201pp.create
this.cb_end=create cb_end
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.dw_update=create dw_update
this.st_4=create st_4
this.sle_item_date=create sle_item_date
this.sle_gwa_name=create sle_gwa_name
this.sle_gwa=create sle_gwa
this.sle_gian_no=create sle_gian_no
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_end,&
this.cb_save,&
this.cb_delete,&
this.cb_insert,&
this.dw_update,&
this.st_4,&
this.sle_item_date,&
this.sle_gwa_name,&
this.sle_gwa,&
this.sle_gian_no,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_hgm201pp.destroy
destroy(this.cb_end)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.dw_update)
destroy(this.st_4)
destroy(this.sle_item_date)
destroy(this.sle_gwa_name)
destroy(this.sle_gwa)
destroy(this.sle_gian_no)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;////////////////////////////////////////////////////////////////////////////////
// 작성목적 : 부대품 등록 - 자산등재에서 호출한다
// 적 성 인 : 윤하영
//	작성일자 : 2002.03.25
// 변 경 인 :
// 변경일자 :
// 변경사유 :
////////////////////////////////////////////////////////////////////////////////
long ll_getrow
f_centerme(THIS)

s_somo		lstr_com
lstr_com = Message.PowerObjectParm

IF NOT isValid(lstr_com) THEN
	CLOSE(THIS)
	RETURN
END IF

f_childretrieve(dw_update,"item_gb","somo_gb")         // 구분

sle_gian_no.text    	= string(lstr_com.item_gian_no)	//번호
sle_gwa.text			= lstr_com.item_gwa					//학과
sle_gwa_name.text		= lstr_com.item_gwa_name			//학과이름
sle_item_date.text	= lstr_com.item_date

is_gian_no				= string(lstr_com.item_gian_no)
is_item_gwa				= lstr_com.item_gwa
is_apply_date 			= lstr_com.item_date  	//구입일자


dw_update.SetTransObject(SQLCA)

Long ll_pos

ll_pos = dw_update.x + dw_update.width - cb_end.width
cb_end.x = ll_pos 
ll_pos = ll_pos - 16 - cb_save.width
cb_save.x = ll_pos
ll_pos = ll_pos - 16 - cb_delete.width
cb_delete.x = ll_pos
ll_pos = ll_pos - 16 - cb_insert.width
cb_insert.x = ll_pos

cb_insert.of_enable(true)
cb_delete.of_enable(true)
cb_save.of_enable(true)
cb_end.of_enable(true)



THIS.TRIGGEREVENT('ue_retrieve')

////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////
end event

event closequery;//string msg
//long	ll_item_tot
//
//// 1.변경사항 Check
//IF dw_update.DeletedCount() > 0 or dw_update.ModifiedCount() > 0 THEN
//	msg = "변경된 자료가 있지만 아직 저장하지 않았습니다.!~r~n"
//	msg = msg + "저장하지 않고 다른 작업을 하시려면 [예]를 누르십시오."
//	if MessageBox('확인',msg, Question!, YesNo!, 2) = 2 then 
//		dw_update.SelectText(1,30)
//		dw_update.SetFocus()
//		return 1
//	end if
//END IF
//
end event

type cb_end from uo_imgbtn within w_hgm201pp
integer x = 2994
integer y = 60
integer taborder = 110
string btnname = "종료"
end type

event clicked;call super::clicked;long ll_item_tot

//ll_item_tot = dw_update.getitemnumber(dw_update.rowcount(), 'item_tot')
//closewithreturn(parent, string(ll_item_tot))

if dw_update.rowcount() >= 1  then
	ll_item_tot = dw_update.getitemnumber(dw_update.rowcount(), 'item_tot')
	closewithreturn(parent, string(ll_item_tot))
else
	close(parent)
end if

end event

on cb_end.destroy
call uo_imgbtn::destroy
end on

type cb_save from uo_imgbtn within w_hgm201pp
integer x = 2661
integer y = 60
integer taborder = 100
string btnname = "저장"
end type

event clicked;call super::clicked;parent.triggerevent('ue_save')
end event

on cb_save.destroy
call uo_imgbtn::destroy
end on

type cb_delete from uo_imgbtn within w_hgm201pp
integer x = 2327
integer y = 60
integer taborder = 100
string btnname = "삭제"
end type

event clicked;call super::clicked;parent.triggerevent('ue_delete')
end event

on cb_delete.destroy
call uo_imgbtn::destroy
end on

type cb_insert from uo_imgbtn within w_hgm201pp
integer x = 1993
integer y = 60
integer taborder = 90
string btnname = "입력"
end type

event clicked;call super::clicked;parent.triggerevent('ue_insert')
end event

on cb_insert.destroy
call uo_imgbtn::destroy
end on

type dw_update from uo_dwgrid within w_hgm201pp
integer x = 9
integer y = 220
integer width = 3397
integer height = 1608
integer taborder = 80
string dataobject = "d_hgm201pp_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;if row = 0 then // 데이터윈도우 외의 영역을 클릭하면 
   Return // 스크립트 종료 
end if 

if this.RowCount() < 1 then return 

dw_update.SetColumn('item_date')

//dw_update.selectrow(0, false)
//dw_update.selectrow(row, true)

dw_update.setrow(row)
dw_update.SetFocus()
end event

event itemchanged;call super::itemchanged;
dw_update.accepttext()
this.object.item_amt[row] = this.object.item_qty[row] * this.object.item_price[row]

end event

event retrieveend;call super::retrieveend;Integer i

if rowcount > 0 then
	For i = 1 to rowcount
		if this.object.item_amt[i] = 0 then
			this.object.item_amt[i] = this.object.item_qty[i] * this.object.item_price[i]
		end if
	Next
		
//	dw_update.selectrow(1, true)
end if


end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type st_4 from statictext within w_hgm201pp
integer x = 37
integer y = 28
integer width = 233
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "구매일자"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_item_date from singlelineedit within w_hgm201pp
integer x = 274
integer y = 12
integer width = 343
integer height = 76
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_gwa_name from singlelineedit within w_hgm201pp
integer x = 1175
integer y = 56
integer width = 773
integer height = 80
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type sle_gwa from singlelineedit within w_hgm201pp
integer x = 914
integer y = 56
integer width = 265
integer height = 80
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type sle_gian_no from singlelineedit within w_hgm201pp
integer x = 274
integer y = 96
integer width = 343
integer height = 80
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_hgm201pp
integer x = 626
integer y = 68
integer width = 302
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "학과/부서"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_hgm201pp
integer x = 27
integer y = 108
integer width = 251
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "구매번호"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hgm201pp
integer x = 5
integer y = 184
integer width = 3410
integer height = 1660
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

