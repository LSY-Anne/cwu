$PBExportHeader$w_hss204a.srw
$PBExportComments$호실관리
forward
global type w_hss204a from w_tabsheet
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type st_1 from statictext within tabpage_sheet01
end type
type sle_code from singlelineedit within tabpage_sheet01
end type
type sle_name from singlelineedit within tabpage_sheet01
end type
type st_3 from statictext within tabpage_sheet01
end type
type dw_build from datawindow within tabpage_sheet01
end type
type st_2 from statictext within tabpage_sheet01
end type
type dw_update from uo_dwfree within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_list1 from uo_dwgrid within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type dw_build1 from datawindow within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type sle_name1 from singlelineedit within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type sle_code1 from singlelineedit within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type p_room from picture within tabpage_1
end type
type cb_2 from uo_imgbtn within tabpage_1
end type
type cb_1 from uo_imgbtn within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_list1 dw_list1
gb_3 gb_3
dw_build1 dw_build1
st_6 st_6
sle_name1 sle_name1
st_5 st_5
sle_code1 sle_code1
st_4 st_4
gb_4 gb_4
p_room p_room
cb_2 cb_2
cb_1 cb_1
end type
end forward

global type w_hss204a from w_tabsheet
string title = "호실관리"
end type
global w_hss204a w_hss204a

type variables

int ii_tab
long il_getrow = 1
datawindowchild idw_child
DataWindowchild	idwc_Gwa
datawindow idw_name1
string is_build
end variables

forward prototypes
public subroutine wf_insert ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_insert ();
int li_row

ii_tab  = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
		tab_sheet.tabpage_sheet01.dw_update.reset()	
		tab_sheet.tabpage_sheet01.dw_update.insertrow(0)
 
		tab_sheet.tabpage_sheet01.dw_update.object.worker[1] = gstru_uid_uname.uid      // 작업자 
		tab_sheet.tabpage_sheet01.dw_update.object.work_date[1] = f_sysdate()           // 오늘 일자 
		tab_sheet.tabpage_sheet01.dw_update.object.ipaddr[1] = gstru_uid_uname.address  //IP
	
		tab_sheet.tabpage_sheet01.dw_update.setfocus()
    
END CHOOSE

end subroutine

public subroutine wf_retrieve ();
string ls_room_code, ls_room_name, ls_build

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1		
       ls_build = TRIM(tab_sheet.tabpage_sheet01.dw_build.Object.code[1])
       IF isNull(ls_build) OR LEN(ls_build) = 0 THEN
          messagebox("알림",'건물명을 선택하시기 바랍니다.')
          tab_sheet.tabpage_sheet01.dw_build.SetFocus()
         RETURN
       END IF
    
      ls_room_code = trim(tab_sheet.tabpage_sheet01.sle_code.text) + '%'
		ls_room_name = trim(tab_sheet.tabpage_sheet01.sle_name.text) + '%'
		
		IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( ls_room_code, ls_room_name, is_build) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			wf_insert()
		ELSE	
			tab_sheet.tabpage_sheet01.dw_update_tab.setfocus()
         tab_sheet.tabpage_sheet01.dw_update_tab.trigger event rowfocuschanged(il_getrow)
		END IF	 
	CASE 2

      ls_room_code = trim(tab_sheet.tabpage_1.sle_code1.text) + '%'
		ls_room_name = trim(tab_sheet.tabpage_1.sle_name1.text) + '%'

		IF tab_sheet.tabpage_1.dw_list1.retrieve( ls_room_code, ls_room_name, is_build ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			wf_insert()
		ELSE	

			tab_sheet.tabpage_1.dw_list1.setfocus()
         tab_sheet.tabpage_1.dw_list1.trigger event rowfocuschanged(il_getrow)
		END IF	

END CHOOSE		

//f_setpointer('END')

end subroutine

on w_hss204a.create
int iCurrent
call super::create
end on

on w_hss204a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;
wf_retrieve()

return 1




end event

event ue_insert;call super::ue_insert;
wf_insert()


end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 호실관리
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

//wf_setMenu('I',TRUE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',TRUE)
//wf_setMenu('U',TRUE)

f_childretrieve(tab_sheet.tabpage_sheet01.dw_update,"facility_opt","fac_use_opt")	                // 시설 구분 
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update,"room_group_code","room_group_code")	          // 계열 구분
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update,"room_yongdo","room_yongdo")	                   // 계열 구분 
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update,"mgr_gwa","mgr_gwa")	                         // 관리 부서  
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update,"old_gwa","old_gwa")	                         // 관리 부서  
f_childretrieven(tab_sheet.tabpage_sheet01.dw_update,"buil_no")	                                  // 건물번호
func.of_design_dw(tab_sheet.tabpage_sheet01.dw_update)
tab_sheet.tabpage_sheet01.dw_update.settransobject(sqlca)
tab_sheet.tabpage_sheet01.dw_update.insertrow(0)

tab_sheet.tabpage_sheet01.dw_build.settransobject(sqlca)
tab_sheet.tabpage_sheet01.dw_build.insertrow(0)
tab_sheet.tabpage_sheet01.dw_build.GetChild('code',idwc_Gwa)
idwc_Gwa.SetTransObject(SQLCA)
IF idwc_Gwa.Retrieve() = 0 THEN
	wf_setmsg('건물코드를 입력하시기 바랍니다.')
	tab_sheet.tabpage_sheet01.dw_build.InsertRow(0)
END IF


tab_sheet.tabpage_1.dw_build1.settransobject(sqlca)
tab_sheet.tabpage_1.dw_build1.insertrow(0)
tab_sheet.tabpage_1.dw_build1.GetChild('code',idwc_Gwa)
idwc_Gwa.SetTransObject(SQLCA)
IF idwc_Gwa.Retrieve() = 0 THEN
	wf_setmsg('건물코드를 입력하시기 바랍니다.')
	tab_sheet.tabpage_1.dw_build1.InsertRow(0)
END IF

//
//wf_retrieve()
//
this.postevent("ue_insert")




end event

event ue_save;call super::ue_save;
int    li_tab
string ls_buil_no,ls_floor, ls_room_no

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

     idw_name1 = tab_sheet.tabpage_sheet01.dw_update
	   
	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN -1
     	  
	  ls_buil_no = trim(idw_name1.object.buil_no[1])
     ls_floor = trim(idw_name1.object.floor[1])
     ls_room_no = trim(idw_name1.object.room_no[1])

     dwitemstatus l_status 
     l_status = idw_name1.getitemstatus(1, 0, Primary!)
				
	  IF l_status = New! OR l_status = NewModified! THEN 

        idw_name1.object.room_code[1] = ls_buil_no + ls_floor + ls_room_no
		  
	  END IF	 

     IF len(ls_floor) <> 2 THEN
		  messagebox("확인","층번호를 확인하세요")
		  idw_name1.setfocus()
		  idw_name1.setcolumn("floor")
        RETURN	-1  	
	  END IF
// 2008.11.25	  
//	  IF len(ls_room_no) <> 3 THEN
//		  messagebox("확인","호실번호를 확인하세요")
//		  idw_name1.setfocus()
//		  idw_name1.setcolumn("room_no")
//        RETURN	  	
//	  END IF

	  string ls_colarry[] = {'buil_no/건물 번호','floor/층번호','room_no/호실번호','room_name/호실명'}
	
	  IF f_chk_null( idw_name1, ls_colarry ) = 1 THEN 
		
		  idw_name1.object.job_uid[1] = gstru_uid_uname.uid		//수정자
		  idw_name1.object.job_date[1] = f_sysdate()           // 오늘 일자 
		  idw_name1.object.job_add[1] = gstru_uid_uname.address  //IP
	  
		  IF f_update( idw_name1,'U') = TRUE THEN 
			  wf_setmsg("저장되었습니다")
			  il_getrow = tab_sheet.tabpage_sheet01.dw_update_tab.getrow()
			  wf_retrieve()
		  END IF
		 
	  END IF
	  
END CHOOSE
//f_setpointer('END')

end event

event ue_delete;call super::ue_delete;int li_tab
String ls_room_code

li_tab = tab_sheet.selectedtab

CHOOSE CASE li_tab
		
	CASE 1

	   idw_name1 = tab_sheet.tabpage_sheet01.dw_update
	   dwItemStatus l_status 
		l_status = idw_name1.getitemstatus(1, 0, Primary!)
	
		IF l_status = New! OR l_status = NewModified! THEN 
				  
		ELSE
			
			IF f_messagebox( '2', 'DEL' ) = 1 THEN
            ls_room_code = idw_name1.object.room_code[1]
//            messagebox('ghkrld',ls_room_code)
//            Blob	lbo_Image	//이미지
//		      lbo_Image = f_blob_read("c:\cwu\bmp\blank.bmp")
//		      UPDATEBLOB	STDB.HST242H
//		      SET			ROOM_IMG = :lbo_Image, 
//		      WHERE			ROOM_CODE  = :ls_room_code;
//				
//		      IF SQLCA.SQLCODE = 0 THEN
//			      COMMIT;
//			      wf_SetMsg('이미지 정보가 저장되었습니다.')
//		      ELSE
//			      MessageBox('오류',&
//							   '건물기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
//							   '하단의 장애번호와 장애내역을~r~n' + &
//							   '기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
//							   '장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
//							   '장애내역 : ' + SQLCA.SqlErrText)
//			      ROLLBACK;
//		      END IF
				
				DELETE FROM STDB.HST242H
				WHERE   ROOM_CODE = :ls_room_code;
				
				idw_name1.deleterow(0)

				IF f_update( idw_name1,'D') = TRUE THEN 
					wf_setmsg("삭제되었습니다")
					wf_retrieve()
					this.triggerevent("ue_insert")
				END IF	

	       END IF
		END IF
END CHOOSE
end event

event ue_postopen;call super::ue_postopen;This.postevent('ue_open')
end event

event ue_button_set;call super::ue_button_set;tab_sheet.tabpage_1.cb_2.x = tab_sheet.tabpage_1.cb_1.x + tab_sheet.tabpage_1.cb_1.width + 16
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hss204a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hss204a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hss204a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hss204a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hss204a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hss204a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hss204a
end type

type uc_insert from w_tabsheet`uc_insert within w_hss204a
end type

type uc_delete from w_tabsheet`uc_delete within w_hss204a
end type

type uc_save from w_tabsheet`uc_save within w_hss204a
end type

type uc_excel from w_tabsheet`uc_excel within w_hss204a
end type

type uc_print from w_tabsheet`uc_print within w_hss204a
end type

type st_line1 from w_tabsheet`st_line1 within w_hss204a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hss204a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hss204a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hss204a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hss204a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hss204a
integer y = 188
integer width = 4384
integer height = 2108
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_1 tabpage_1
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		f_setpointer('START')
//      wf_retrieve()
//		f_setpointer('END')		
//end choose
end event

on tab_sheet.create
this.tabpage_1=create tabpage_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_1)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 1988
long backcolor = 1073741824
string text = "호실관리"
gb_2 gb_2
gb_1 gb_1
st_1 st_1
sle_code sle_code
sle_name sle_name
st_3 st_3
dw_build dw_build
st_2 st_2
dw_update dw_update
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.sle_code=create sle_code
this.sle_name=create sle_name
this.st_3=create st_3
this.dw_build=create dw_build
this.st_2=create st_2
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_code
this.Control[iCurrent+5]=this.sle_name
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.dw_build
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.sle_code)
destroy(this.sle_name)
destroy(this.st_3)
destroy(this.dw_build)
destroy(this.st_2)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 2478
integer y = 32
integer width = 238
integer height = 168
integer taborder = 50
boolean titlebar = true
string title = "조회 내용"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;
//wf_chrow()
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer y = 248
integer width = 2226
integer height = 1732
boolean titlebar = true
string title = "조회내용"
string dataobject = "d_hss204a_1"
end type

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )
long ll_row
string ls_room_code

idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
idw_name1.accepttext()

IF currentrow <> 0 THEN
	ls_room_code = idw_name1.object.room_code[currentrow]
	tab_sheet.tabpage_sheet01.dw_update.retrieve( ls_room_code )
END IF

end event

type uo_tab from w_tabsheet`uo_tab within w_hss204a
integer x = 1120
integer y = 148
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hss204a
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hss204a
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_2 from groupbox within tabpage_sheet01
integer x = 2258
integer y = 224
integer width = 2080
integer height = 1760
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "호실 내역"
end type

type gb_1 from groupbox within tabpage_sheet01
integer x = 23
integer y = 36
integer width = 3168
integer height = 188
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회조건"
end type

type st_1 from statictext within tabpage_sheet01
integer x = 1184
integer y = 124
integer width = 462
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "사용 장소 코드"
boolean focusrectangle = false
end type

type sle_code from singlelineedit within tabpage_sheet01
integer x = 1641
integer y = 108
integer width = 471
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;wf_retrieve()
end event

type sle_name from singlelineedit within tabpage_sheet01
integer x = 2537
integer y = 108
integer width = 562
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;wf_retrieve()
end event

type st_3 from statictext within tabpage_sheet01
integer x = 183
integer y = 124
integer width = 229
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "건물명"
boolean focusrectangle = false
end type

type dw_build from datawindow within tabpage_sheet01
integer x = 384
integer y = 100
integer width = 736
integer height = 96
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_build"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_build	=	data
end event

type st_2 from statictext within tabpage_sheet01
integer x = 2190
integer y = 128
integer width = 334
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "사용장소명"
boolean focusrectangle = false
end type

type dw_update from uo_dwfree within tabpage_sheet01
integer x = 2295
integer y = 284
integer width = 2011
integer height = 1668
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_hss204a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemerror;call super::itemerror;return 1
end event

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1988
string text = "호실이미지관리"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list1 dw_list1
gb_3 gb_3
dw_build1 dw_build1
st_6 st_6
sle_name1 sle_name1
st_5 st_5
sle_code1 sle_code1
st_4 st_4
gb_4 gb_4
p_room p_room
cb_2 cb_2
cb_1 cb_1
end type

on tabpage_1.create
this.dw_list1=create dw_list1
this.gb_3=create gb_3
this.dw_build1=create dw_build1
this.st_6=create st_6
this.sle_name1=create sle_name1
this.st_5=create st_5
this.sle_code1=create sle_code1
this.st_4=create st_4
this.gb_4=create gb_4
this.p_room=create p_room
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_list1,&
this.gb_3,&
this.dw_build1,&
this.st_6,&
this.sle_name1,&
this.st_5,&
this.sle_code1,&
this.st_4,&
this.gb_4,&
this.p_room,&
this.cb_2,&
this.cb_1}
end on

on tabpage_1.destroy
destroy(this.dw_list1)
destroy(this.gb_3)
destroy(this.dw_build1)
destroy(this.st_6)
destroy(this.sle_name1)
destroy(this.st_5)
destroy(this.sle_code1)
destroy(this.st_4)
destroy(this.gb_4)
destroy(this.p_room)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type dw_list1 from uo_dwgrid within tabpage_1
integer x = 23
integer y = 248
integer width = 1856
integer height = 1728
integer taborder = 31
boolean titlebar = true
string title = "조회내용"
string dataobject = "d_hss204a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.SettransObject(sqlca)

this.object.compute_1.width = 0
this.object.room_code.width = 0
this.object.room_no.width = 0
this.object.floor.width = 200
this.taborder = 0
dw_list1.Object.DataWindow.ReadOnly = 'YES'
end event

event rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

long ll_row
string ls_buil_no, ls_room_code

idw_name1 = tab_sheet.tabpage_1.dw_list1

idw_name1.accepttext()

IF currentrow <> 0 THEN

	ls_room_code = idw_name1.object.room_code[currentrow]
	
	////////////////////////////////////////////////////////////////////////////////////
	//  건물이미지정보 조회처리
	////////////////////////////////////////////////////////////////////////////////////
	Blob	lbo_Image
	SELECTBLOB	A.ROOM_IMG
	INTO			:lbo_Image
	FROM			STDB.HST242H A
	WHERE			A.room_code = :ls_room_code;
	IF SQLCA.SQLCODE <> 0 THEN
		SetNull(lbo_Image)
		tab_sheet.tabpage_1.p_room.picturename = "../bmp/blank.bmp"
	END IF
		tab_sheet.tabpage_1.p_room.SetPicture(lbo_Image)
END IF

end event

type gb_3 from groupbox within tabpage_1
integer x = 23
integer y = 36
integer width = 2830
integer height = 188
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회조건"
end type

type dw_build1 from datawindow within tabpage_1
integer x = 2121
integer y = 96
integer width = 709
integer height = 96
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_build"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_build	=	data
end event

type st_6 from statictext within tabpage_1
integer x = 1929
integer y = 120
integer width = 197
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "건물명"
boolean focusrectangle = false
end type

type sle_name1 from singlelineedit within tabpage_1
integer x = 1317
integer y = 112
integer width = 562
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;wf_retrieve()
end event

type st_5 from statictext within tabpage_1
integer x = 997
integer y = 128
integer width = 320
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "사용장소명"
boolean focusrectangle = false
end type

type sle_code1 from singlelineedit within tabpage_1
integer x = 480
integer y = 112
integer width = 471
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;wf_retrieve()
end event

type st_4 from statictext within tabpage_1
integer x = 59
integer y = 124
integer width = 421
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "사용장소 코드"
boolean focusrectangle = false
end type

type gb_4 from groupbox within tabpage_1
integer x = 1893
integer y = 220
integer width = 2441
integer height = 1752
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "호실이미지"
end type

type p_room from picture within tabpage_1
integer x = 1929
integer y = 304
integer width = 2368
integer height = 1636
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type cb_2 from uo_imgbtn within tabpage_1
event destroy ( )
integer x = 3195
integer y = 100
integer taborder = 70
boolean bringtotop = true
string btnname = "이미지 삭제"
end type

on cb_2.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;string  ls_room_code


 idw_name1 = tab_sheet.tabpage_1.dw_list1
 ls_room_code = idw_name1.object.room_code[idw_name1.getrow()]

 Blob	lbo_Image	//이미지
		lbo_Image = f_blob_read("..\img\message_ico.gif")
		UPDATEBLOB	STDB.HST242H
		SET			ROOM_IMG = :lbo_Image, 
		WHERE			ROOM_CODE  = :ls_room_code;
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
	wf_retrieve()
end event

type cb_1 from uo_imgbtn within tabpage_1
event destroy ( )
integer x = 2880
integer y = 100
integer taborder = 60
boolean bringtotop = true
string btnname = "이미지 등록"
end type

on cb_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: buttonclikced::dw_update1
//	기 능 설 명: 호실정보 이미지처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')

idw_name1 = tab_sheet.tabpage_1.dw_list1
idw_name1.accepttext()


long ll_row
ll_row =  idw_name1.getrow()
IF ll_row = 0 THEN RETURN
string ls_room_no 
ls_room_no = idw_name1.object.room_code[ll_row]


		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.2 화일열기 화면 오픈
		/////////////////////////////////////////////////////////////////////////////////
		Integer	li_Rtn
		String	ls_FullName
		String	ls_FileName
		li_Rtn = GetFileOpenName("", + ls_FullName,&
									ls_FileName, "BMP",&
									"BMP Files (*.BMP),*.BMP," + &
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
		FROM		STDB.HST242H  A
		WHERE		A.room_code = :ls_room_No;
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0
			CASE 100
				INSERT	INTO	STDB.HST242H(room_code)
				VALUES	(	:ls_room_no);
				
			CASE ELSE
				MessageBox('오류',&
								'호실기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
				RETURN
		END CHOOSE
			
		UPDATEBLOB	STDB.HST242H
		SET			ROOM_IMG = :lbo_Image, 
		WHERE			ROOM_CODE = :ls_room_no;
		IF SQLCA.SQLCODE = 0 THEN
			COMMIT;
			p_room.picturename = ls_FullName
			wf_SetMsg('이미지 정보가 저장되었습니다.')
		ELSE
			MessageBox('오류',&
							'호실기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
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

