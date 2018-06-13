$PBExportHeader$w_hst202i.srw
$PBExportComments$물품이미지관리
forward
global type w_hst202i from w_msheet
end type
type st_1 from statictext within w_hst202i
end type
type sle_item_no from singlelineedit within w_hst202i
end type
type p_item_img from picture within w_hst202i
end type
type sle_item_name from singlelineedit within w_hst202i
end type
type st_2 from statictext within w_hst202i
end type
type gb_2 from groupbox within w_hst202i
end type
type gb_1 from groupbox within w_hst202i
end type
type dw_list from uo_dwgrid within w_hst202i
end type
type cb_1 from uo_imgbtn within w_hst202i
end type
type cb_2 from uo_imgbtn within w_hst202i
end type
end forward

global type w_hst202i from w_msheet
st_1 st_1
sle_item_no sle_item_no
p_item_img p_item_img
sle_item_name sle_item_name
st_2 st_2
gb_2 gb_2
gb_1 gb_1
dw_list dw_list
cb_1 cb_1
cb_2 cb_2
end type
global w_hst202i w_hst202i

type variables
int ii_tab
long il_getrow = 1
datawindowchild idw_child
string	is_id_no, is_item_class, is_item_no
DataWindowchild	idwc_Gwa
end variables

on w_hst202i.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_item_no=create sle_item_no
this.p_item_img=create p_item_img
this.sle_item_name=create sle_item_name
this.st_2=create st_2
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_list=create dw_list
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_item_no
this.Control[iCurrent+3]=this.p_item_img
this.Control[iCurrent+4]=this.sle_item_name
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.dw_list
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_2
end on

on w_hst202i.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_item_no)
destroy(this.p_item_img)
destroy(this.sle_item_name)
destroy(this.st_2)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_list)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_open
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
//////////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건의 초기화 처리.
//////////////////////////////////////////////////////////////////////////////////////////
//tab_1.tabpage_1.dw_main.Reset()
//tab_1.tabpage_2.dw_print.object.datawindow.zoom = 100
//tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'

f_childretrieve(dw_list,"hst027m_item_class","item_class")      //물품구분
////////////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
//////////////////////////////////////////////////////////////////////////////////////////
dw_list.Reset()

////wf_setmenu('I',TRUE)//입력버튼 활성화
////wf_setmenu('S',TRUE)//저장버튼 활성화
////wf_setmenu('D',TRUE)//삭제버튼 활성화
//wf_setmenu('R',TRUE)//저장버튼 활성화


triggerevent('ue_retrieve')
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
String  ls_item_name ,ls_item_no
ls_item_name = sle_item_name.text +'%'
ls_item_no	= sle_item_no.text +'%'
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_list.SetReDraw(FALSE)
ll_RowCnt = dw_list.Retrieve(ls_item_name,ls_item_no)
dw_list.SetReDraw(TRUE)

     	
dw_list.setfocus()
dw_list.trigger event rowfocuschanged(il_GetRow)
	 
///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
	//wf_setmenu('D',FALSE)
	//wf_setmenu('S',FALSE)
	//wf_setmenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
	//wf_setmenu('D',FALSE)
	//wf_setmenu('S',FALSE)
	//wf_setmenu('P',FALSE)
	wf_SetMsg('자료가 조회되었습니다.')
END IF
return 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_button_set;call super::ue_button_set;cb_2.x = cb_1.x + cb_1.width + 16


end event

type ln_templeft from w_msheet`ln_templeft within w_hst202i
end type

type ln_tempright from w_msheet`ln_tempright within w_hst202i
end type

type ln_temptop from w_msheet`ln_temptop within w_hst202i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst202i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst202i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst202i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst202i
end type

type uc_insert from w_msheet`uc_insert within w_hst202i
end type

type uc_delete from w_msheet`uc_delete within w_hst202i
end type

type uc_save from w_msheet`uc_save within w_hst202i
end type

type uc_excel from w_msheet`uc_excel within w_hst202i
end type

type uc_print from w_msheet`uc_print within w_hst202i
end type

type st_line1 from w_msheet`st_line1 within w_hst202i
end type

type st_line2 from w_msheet`st_line2 within w_hst202i
end type

type st_line3 from w_msheet`st_line3 within w_hst202i
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst202i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst202i
end type

type st_1 from statictext within w_hst202i
integer x = 1545
integer y = 232
integer width = 265
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "품목코드"
boolean focusrectangle = false
end type

type sle_item_no from singlelineedit within w_hst202i
integer x = 1815
integer y = 212
integer width = 617
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type p_item_img from picture within w_hst202i
integer x = 2441
integer y = 436
integer width = 1952
integer height = 1804
boolean originalsize = true
boolean focusrectangle = false
end type

type sle_item_name from singlelineedit within w_hst202i
integer x = 320
integer y = 212
integer width = 1079
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_hst202i
integer x = 110
integer y = 232
integer width = 215
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "품목명"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_hst202i
integer x = 2405
integer y = 372
integer width = 2030
integer height = 1900
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "물품이미지"
end type

type gb_1 from groupbox within w_hst202i
integer x = 50
integer y = 124
integer width = 4384
integer height = 232
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type dw_list from uo_dwgrid within w_hst202i
integer x = 50
integer y = 372
integer width = 2345
integer height = 1904
integer taborder = 20
boolean titlebar = true
string title = "물품리스트"
string dataobject = "d_hst202i_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

long ll_row
string ls_item_no, ls_item_stand_size

dw_list.accepttext()
ll_row = dw_list.GetRow()
IF ll_row <> 0 THEN
	
	ls_item_no = dw_list.object.hst027m_item_no[ll_row]	
	ls_item_stand_size = dw_list.object.hst027m_item_stand_size[ll_row]
	
	////////////////////////////////////////////////////////////////////////////////////
	//  건물이미지정보 조회처리
	////////////////////////////////////////////////////////////////////////////////////
	Blob	lbo_Image
	SELECTBLOB	A.ITEM_IMG
	INTO			:lbo_Image
	FROM			STDB.HST026h A
	WHERE			A.item_no = :ls_item_no 
	AND         A.item_stand_size = :ls_item_stand_size  ;

	IF SQLCA.SQLCODE <> 0 THEN
		SetNull(lbo_Image)
		p_item_img.picturename = "../bmp/blank.bmp"
	END IF
		p_item_img.SetPicture(lbo_Image)
END IF
end event

type cb_1 from uo_imgbtn within w_hst202i
integer x = 2633
integer y = 216
integer taborder = 60
boolean bringtotop = true
string btnname = "이미지 등록"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: buttonclikced::dw_update1
//	기 능 설 명: 층정보 이미지처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
dw_list.accepttext()


long ll_row
ll_row =  dw_list.getrow()
IF ll_row = 0 THEN RETURN
string ls_item_no, ls_item_stand_size
ls_item_no = dw_list.object.hst027m_item_no[ll_row]
ls_item_stand_size = dw_list.object.hst027m_item_stand_size[ll_row]

		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.2 화일열기 화면 오픈
		/////////////////////////////////////////////////////////////////////////////////
//		Integer	li_Rtn
//		String	ls_FullName
//		String	ls_FileName
//		li_Rtn = GetFileOpenName("", + ls_FullName,&
//									ls_FileName, "BMP",&
//									"BMP Files (*.BMP),*.BMP," + &
//									"ALL Files (*.*), *.*")
//		IF li_Rtn <> 1 THEN RETURN
//		IF LEN(ls_FullName) = 0 THEN RETURN
		Integer	li_Rtn
		String	ls_FullName
		String	ls_FileName
		li_Rtn = GetFileOpenName("", + ls_FullName,&
									ls_FileName, "JPEG",&
									"JPG Files (*.JPG),*.JPG," + &
									"ALL Files (*.*), *.*")
		IF li_Rtn <> 1 THEN RETURN
		IF LEN(ls_FullName) = 0 THEN RETURN
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.3 저장하고자하는 이미지화일을 BLOB에 읽어온다.
		/////////////////////////////////////////////////////////////////////////////////
		Blob	lbo_Image	//인사이미지
		lbo_Image = f_blob_read(ls_FullName)
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.4 이미지 정보 추가 및 수정처리
		/////////////////////////////////////////////////////////////////////////////////
		wf_SetMsg('이미지 정보를 저장 중입니다.')

		SELECT	1
		INTO		:li_Rtn
		FROM		STDB.HST026h 
		WHERE	   item_no = :ls_item_no 
		AND      item_stand_size = :ls_item_stand_size;
//MessageBox('확인',ls_item_no+':'+ls_item_stand_size)
//MessageBox('',SQLCA.SQLCODE)
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0
				UPDATE	STDB.HST026h
				SET		WORK_DATE	= SYSDATE,
							JOB_DATE = sysdate
				WHERE		item_no = :ls_item_no 
				AND      item_stand_size = :ls_item_stand_size
				;
			CASE 100
				INSERT	INTO	STDB.HST026h(ITEM_NO,ITEM_STAND_SIZE)
				VALUES	( :ls_item_no, :ls_item_stand_size);
				
			CASE ELSE
	
				MessageBox('오류',&
								'물품이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
				RETURN
		END CHOOSE

		UPDATEBLOB	STDB.HST026h
		SET			item_img = :lbo_Image 
		WHERE		 	item_no = :ls_item_no 
		AND         item_stand_size = :ls_item_stand_size
		;
		
//		MessageBox('이미지',long(lbo_Image))
//		MessageBox('품목코드와규격',ls_item_no+':'+ls_item_stand_size)
//		MessageBox('SQLCODE',SQLCA.SQLCODE)
		IF SQLCA.SQLCODE = 0 THEN
			COMMIT;
			p_item_img.picturename = ls_FullName
			wf_SetMsg('이미지 정보가 저장되었습니다.')
		ELSE
			MessageBox('오류',&
							'물품이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK;
		END IF

////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

type cb_2 from uo_imgbtn within w_hst202i
integer x = 2935
integer y = 216
integer taborder = 70
boolean bringtotop = true
string btnname = "이미지 삭제"
end type

event clicked;call super::clicked;string  ls_item_stand_size, ls_item_no

 ls_item_no    = dw_list.object.hst027m_item_no[dw_list.getrow()]
 ls_item_stand_size = dw_list.object.hst027m_item_stand_size[dw_list.getrow()]

// Blob	lbo_Image	//이미지
//		lbo_Image = f_blob_read("c:\cwu\bmp\blank.bmp")
		
		DELETE FROM STDB.HST026H
		WHERE	   ITEM_NO     = :ls_item_no
		AND      ITEM_STAND_SIZE = :ls_item_stand_size;
		
//		UPDATEBLOB	STDB.HST026H
//		SET			ITEM_IMG    = :lbo_Image, 
//		WHERE		   ITEM_NO     = :ls_item_no
//		AND         ITEM_STAND_SIZE = :ls_item_stand_size;
		
		IF SQLCA.SQLCODE = 0 THEN
			COMMIT;
			wf_SetMsg('이미지 정보가 저장되었습니다.')
		ELSE
			MessageBox('오류',&
							'건물기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK;
	END IF
	
  TRIGGER EVENT ue_retrieve()
  
end event

on cb_2.destroy
call uo_imgbtn::destroy
end on

