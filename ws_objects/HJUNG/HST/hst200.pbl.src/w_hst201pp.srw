$PBExportHeader$w_hst201pp.srw
$PBExportComments$부대품관리
forward
global type w_hst201pp from window
end type
type dw_update from datawindow within w_hst201pp
end type
type sle_item_class from singlelineedit within w_hst201pp
end type
type sle_id_no from singlelineedit within w_hst201pp
end type
type st_2 from statictext within w_hst201pp
end type
type st_1 from statictext within w_hst201pp
end type
type cb_end from commandbutton within w_hst201pp
end type
type cb_save from commandbutton within w_hst201pp
end type
type cb_delete from commandbutton within w_hst201pp
end type
type cb_insert from commandbutton within w_hst201pp
end type
type st_3 from statictext within w_hst201pp
end type
end forward

global type w_hst201pp from window
integer width = 3465
integer height = 1312
boolean titlebar = true
string title = "부대품관리"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
event ue_retrieve pbm_custom01
event ue_insert pbm_custom02
event ue_save pbm_custom03
event ue_delete pbm_custom06
dw_update dw_update
sle_item_class sle_item_class
sle_id_no sle_id_no
st_2 st_2
st_1 st_1
cb_end cb_end
cb_save cb_save
cb_delete cb_delete
cb_insert cb_insert
st_3 st_3
end type
global w_hst201pp w_hst201pp

type variables
int ii_revenue, ii_item, ii_purchase_date
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
String	ls_IdNo
ls_IdNo = TRIM(sle_id_no.Text)

SetPointer(HourGlass!)

Long		ll_RowCnt
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(ls_IdNo,ii_item)
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

dw_update.object.revenue_opt  [ll_InsRow] = ii_revenue					//구입재원
dw_update.object.id_no        [ll_InsRow] = sle_id_no.text				//등재번호
dw_update.object.item_class   [ll_InsRow] = ii_item						//물품구분
//dw_update.object.item_sub_date[ll_InsRow] = ii_purchase_date				   //등록일자
dw_update.object.worker       [ll_InsRow] = gs_empcode		//등록자
dw_update.object.ipaddr       [ll_InsRow] = gs_ip	//등록IP
dw_update.object.work_date    [ll_InsRow] = f_sysdate()					//등록일자
IF ll_InsRow > 1 THEN
	dw_update.object.item_sub_name[ll_InsRow] = dw_update.object.item_sub_name[ll_InsRow - 1]	   //부대품코드
END IF
dw_update.ScrollToRow(ll_InsRow)
dw_update.setfocus()
dw_update.setrow(ll_InsRow)
end event

event ue_save;String	ls_colarry[]
String	ls_id_no
Long		ll_item_class
Long		ll_row
Long		ll_max
Long		ll_count = 0
Long     ll_amt, ll_qty, ll_price
SetNull(ll_max)
IF f_chk_modified(dw_update) = FALSE THEN RETURN
 
dw_update.AcceptText()

ls_id_no = sle_id_no.text
//ll_qty  = dw_update.object.item_qty[dw_update.getrow()]
//ll_price = dw_update.object.item_price[dw_update.getrow()]
//ll_amt = ll_qty*ll_price
//ll_amt = dw_update.object.item_amt[dw_update.getrow()]

//ls_colarry[] = {'item_sub_name/부대품명,item_no/부대품코드','item_sub_date/장착일자','revenue_opt/구입재원'}
ls_colarry[] = {'item_sub_name/부대품명'}

IF f_chk_null( dw_update, ls_colarry ) = 1 THEN 
	ll_row = dw_update.getnextmodified(0,primary!)	
	
	DO WHILE ll_row > 0
		dw_update.object.job_uid[ll_row] = gs_empcode         //등록자
		dw_update.object.job_add[ll_row] = gs_ip		//등록IP
		dw_update.object.job_date[ll_row] = f_sysdate()     				//등록일자
		
		IF isnull(dw_update.getitemnumber(ll_row, "item_sub_no")) THEN 	//신규일경우 부대품번호를 할당해 주기위해
			ll_count = ll_count + 1
			IF isNull(ll_max) THEN			//신규의 첫번째 로우만
				SELECT NVL(MAX(ITEM_SUB_NO),0)
				INTO   :ll_max
				FROM   STDB.HST028H
				WHERE  ID_NO      = :ls_id_no
				AND    ITEM_CLASS = :ii_item
				USING  SQLCA;
			END IF
			dw_update.object.item_sub_no[ll_row] = ll_max + ll_count
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

on w_hst201pp.create
this.dw_update=create dw_update
this.sle_item_class=create sle_item_class
this.sle_id_no=create sle_id_no
this.st_2=create st_2
this.st_1=create st_1
this.cb_end=create cb_end
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.st_3=create st_3
this.Control[]={this.dw_update,&
this.sle_item_class,&
this.sle_id_no,&
this.st_2,&
this.st_1,&
this.cb_end,&
this.cb_save,&
this.cb_delete,&
this.cb_insert,&
this.st_3}
end on

on w_hst201pp.destroy
destroy(this.dw_update)
destroy(this.sle_item_class)
destroy(this.sle_id_no)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_end)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.st_3)
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

s_insa_com	lstr_com
lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	CLOSE(THIS)
	RETURN
END IF

sle_id_no.text    	= lstr_com.ls_item[1]	//등재번호
sle_item_class.text	= lstr_com.ls_item[2]	//물품구분명

ii_item    = lstr_com.ll_item[1]				//물품구분
ii_revenue = lstr_com.ll_item[2]  			//구입재원
//ii_purchase_date = lstr_com.ll_item[3]  	//구입일자

//dw_update.object.item_sub_date[0] = ii_purchase_date
dw_update.SetTransObject(SQLCA)
f_childretrieve(dw_update,"revenue_opt","revenue_opt")	 //구입재원

THIS.TRIGGEREVENT('ue_retrieve')

////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////
end event

event closequery;string msg

// 1.변경사항 Check
IF dw_update.DeletedCount() > 0 or dw_update.ModifiedCount() > 0 THEN
	msg = "변경된 자료가 있지만 아직 저장하지 않았습니다.!~r~n"
	msg = msg + "저장하지 않고 다른 작업을 하시려면 [예]를 누르십시오."
	if MessageBox('확인',msg, Question!, YesNo!, 2) = 2 then 
		dw_update.SelectText(1,30)
		dw_update.SetFocus()
		return 1
	end if
END IF
end event

type dw_update from datawindow within w_hst201pp
event key_enter pbm_dwnprocessenter
integer x = 37
integer y = 292
integer width = 3397
integer height = 868
integer taborder = 70
string title = "none"
string dataobject = "d_hst201pp_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event key_enter;
long ll_getrow
string ls_item_no, ls_room_code, ls_midd_name, ls_large_name

this.accepttext()
	
ll_getrow = this.getrow()

IF this.getcolumnname() = 'item_no' THEN                         // 물품 코드 

	ls_item_no = this.object.item_no[ll_getrow]
		
	openwithparm(w_hgm001h,ls_item_no)
			
	IF message.stringparm <> '' THEN
	
		this.object.item_no[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.item_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
//		this.object.item_class[ll_getrow] = integer(gstru_uid_uname.s_parm[3])	   
//		this.object.item_stand_size[ll_getrow] = gstru_uid_uname.s_parm[4]	   
//		this.object.model[ll_getrow] = gstru_uid_uname.s_parm[5]	   
	
	END IF

END IF

	   

end event

event itemfocuschanged;//choose case dwo.name
//	case "school_amt", "nation_amt", "replace_amt", "self_amt", "prepare_amt"
//		this.SelectText(1,30)
//end choose
end event

event clicked;if row = 0 then // 데이터윈도우 외의 영역을 클릭하면 
   Return // 스크립트 종료 
end if 

if this.RowCount() < 1 then return 

dw_update.SetColumn('item_sub_date')

//dw_update.selectrow(0, false)
//dw_update.selectrow(row, true)

dw_update.setrow(row)
dw_update.SetFocus()
end event

event retrieveend;//if rowcount > 0 then
////	dw_update.selectrow(1, true)
//end if
end event

event itemchanged;
dw_update.accepttext()
this.object.item_amt[row] = this.object.item_qty[row] * this.object.item_price[row]
end event

event rowfocuschanged;If currentrow <= 0 Then Return

if this.object.item_amt[currentrow] = 0 then
 this.object.item_amt[currentrow] = this.object.item_qty[currentrow] * this.object.item_price[currentrow]
end if
end event

type sle_item_class from singlelineedit within w_hst201pp
integer x = 1294
integer y = 216
integer width = 576
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type sle_id_no from singlelineedit within w_hst201pp
integer x = 329
integer y = 212
integer width = 411
integer height = 80
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_hst201pp
integer x = 997
integer y = 224
integer width = 293
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "물품구분"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_hst201pp
integer x = 37
integer y = 224
integer width = 293
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "등재번호"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_end from commandbutton within w_hst201pp
integer x = 969
integer y = 32
integer width = 311
integer height = 132
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_hst201pp
integer x = 658
integer y = 32
integer width = 311
integer height = 132
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;parent.triggerevent('ue_save')
end event

type cb_delete from commandbutton within w_hst201pp
integer x = 347
integer y = 32
integer width = 311
integer height = 132
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;parent.triggerevent('ue_delete')
end event

type cb_insert from commandbutton within w_hst201pp
integer x = 37
integer y = 32
integer width = 311
integer height = 132
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "추가"
end type

event clicked;parent.triggerevent('ue_insert')
end event

type st_3 from statictext within w_hst201pp
integer x = 27
integer y = 24
integer width = 1262
integer height = 144
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

