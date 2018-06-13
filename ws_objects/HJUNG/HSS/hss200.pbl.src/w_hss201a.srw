$PBExportHeader$w_hss201a.srw
$PBExportComments$건물 관리
forward
global type w_hss201a from w_tabsheet
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
type dw_update1 from cuo_dwwindow within tabpage_sheet01
end type
type gb_3 from groupbox within tabpage_sheet01
end type
type dw_update2 from cuo_dwwindow within tabpage_sheet01
end type
type st_2 from statictext within tabpage_sheet01
end type
type tabpage_2 from userobject within tab_sheet
end type
type cb_2 from uo_imgbtn within tabpage_2
end type
type dw_list2 from uo_dwgrid within tabpage_2
end type
type sle_2 from singlelineedit within tabpage_2
end type
type st_4 from statictext within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type gb_5 from groupbox within tabpage_2
end type
type sle_1 from singlelineedit within tabpage_2
end type
type gb_6 from groupbox within tabpage_2
end type
type p_build from picture within tabpage_2
end type
type cb_1 from uo_imgbtn within tabpage_2
end type
type tabpage_2 from userobject within tab_sheet
cb_2 cb_2
dw_list2 dw_list2
sle_2 sle_2
st_4 st_4
st_3 st_3
gb_5 gb_5
sle_1 sle_1
gb_6 gb_6
p_build p_build
cb_1 cb_1
end type
end forward

global type w_hss201a from w_tabsheet
string title = "건물관리"
end type
global w_hss201a w_hss201a

type variables

int ii_tab
long il_getrow = 1
datawindowchild idw_child
datawindow idw_name1
end variables

forward prototypes
public subroutine wf_insert ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_insert ();
ii_tab  = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
		tab_sheet.tabpage_sheet01.dw_update1.SetRedraw(FALSE)
		tab_sheet.tabpage_sheet01.dw_update1.reset()		
		tab_sheet.tabpage_sheet01.dw_update1.insertrow(0)
		
		tab_sheet.tabpage_sheet01.dw_update1.object.worker[1] = gs_empcode      // 작업자 
		tab_sheet.tabpage_sheet01.dw_update1.object.work_date[1] = f_sysdate()           // 오늘 일자 
		tab_sheet.tabpage_sheet01.dw_update1.object.ipaddr[1] = gs_empcode  //IP
		
		tab_sheet.tabpage_sheet01.dw_update1.SetRedraw(TRUE)
		tab_sheet.tabpage_sheet01.dw_update2.SetRedraw(FALSE)
		tab_sheet.tabpage_sheet01.dw_update2.reset()		
		tab_sheet.tabpage_sheet01.dw_update2.insertrow(0)
		
		tab_sheet.tabpage_sheet01.dw_update2.object.worker[1] = gs_empcode    // 작업자 
		tab_sheet.tabpage_sheet01.dw_update2.object.work_date[1] = f_sysdate()           // 오늘 일자 
		tab_sheet.tabpage_sheet01.dw_update2.object.ipaddr[1] = gs_empcode  //IP
		tab_sheet.tabpage_sheet01.dw_update2.SetRedraw(TRUE)
		tab_sheet.tabpage_sheet01.dw_update1.setfocus()
		

END CHOOSE

end subroutine

public subroutine wf_retrieve ();
string ls_build_code, ls_build_name



ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
    
      ls_build_code = trim(tab_sheet.tabpage_sheet01.sle_code.text) + '%'
		ls_build_name = trim(tab_sheet.tabpage_sheet01.sle_name.text) + '%'
		If isnull(ls_build_code ) then ls_build_code = '%'
		If isnull(ls_build_name ) then ls_build_name = '%'
		
		IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( ls_build_code, ls_build_name ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			wf_insert()
		ELSE	
			tab_sheet.tabpage_sheet01.dw_update_tab.setfocus()
         tab_sheet.tabpage_sheet01.dw_update_tab.trigger event rowfocuschanged(il_getrow)
		END IF	 
	CASE 2
    
      ls_build_code = trim(tab_sheet.tabpage_2.sle_1.text) + '%'
		ls_build_name = trim(tab_sheet.tabpage_2.sle_2.text) + '%'
		
		IF tab_sheet.tabpage_2.dw_list2.retrieve( ls_build_code, ls_build_name ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			tab_sheet.tabpage_2.p_build.picturename = "../bmp/blank.bmp"			
			wf_insert()
		ELSE	
			tab_sheet.tabpage_2.dw_list2.setfocus()
         tab_sheet.tabpage_2.dw_list2.trigger event rowfocuschanged(il_getrow)
		END IF		

END CHOOSE		



end subroutine

on w_hss201a.create
int iCurrent
call super::create
end on

on w_hss201a.destroy
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
// 	작성목적 : 건물관리
//    적 성 인 : 윤하영
//		작성일자 : 2002.00.00
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

//wf_setMenu('I',TRUE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',TRUE)
//wf_setMenu('U',TRUE)

f_childretrieve(tab_sheet.tabpage_sheet01.dw_update1,"buil_kind","build_kind")	 // 구내외 구분						
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update1,"facility_opt","fac_use_opt")
//f_childretrieve(tab_sheet.tabpage_sheet01.dw_list,"buil_kind","build_kind")	          // 구내외 구분	
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update2,"buil_fightway","purchase_opt")

wf_retrieve()

//this.postevent("ue_insert")




end event

event ue_save;call super::ue_save;
string ls_cust_no, ls_build_yn, ls_regist_yn, ls_safe_yn

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

     idw_name = tab_sheet.tabpage_sheet01.dw_update1
	   
	  idw_name.accepttext()	
		
	  IF f_chk_modified(idw_name) = FALSE AND f_chk_modified(tab_sheet.tabpage_sheet01.dw_update2) = FALSE THEN RETURN -1
	  
	  tab_sheet.tabpage_sheet01.dw_update2.object.buil_no[1] = idw_name.object.buil_no[1]
	  
	  string ls_colarry[] = {'buil_no/건물 번호','buil_name/건물명','buil_safe_rank/안정성등급','buil_safe_yn/안정성여부'}

	
	  IF f_chk_null( idw_name, ls_colarry ) = 1 THEN 
		
		  IF f_chk_modified(idw_name)	then
			  idw_name.object.job_uid[1] = gstru_uid_uname.uid		//수정자
		  	  idw_name.object.job_date[1] = f_sysdate()           // 오늘 일자 
		  	  idw_name.object.job_add[1] = gstru_uid_uname.address  //IP	
			  idw_name.accepttext()
		  end if
		  
		  if f_chk_modified(tab_sheet.tabpage_sheet01.dw_update2) then
			  tab_sheet.tabpage_sheet01.dw_update2.object.job_uid[1] = gstru_uid_uname.uid		//수정자
		  	  tab_sheet.tabpage_sheet01.dw_update2.object.job_date[1] = f_sysdate()           // 오늘 일자 
		  	  tab_sheet.tabpage_sheet01.dw_update2.object.job_add[1] = gstru_uid_uname.address  //IP	
			  tab_sheet.tabpage_sheet01.dw_update2.accepttext()
		  end if
		  
		  IF f_update2( idw_name, tab_sheet.tabpage_sheet01.dw_update2, 'U') = TRUE THEN 
			  wf_setmsg("저장되었습니다")
			  il_getrow = tab_sheet.tabpage_sheet01.dw_update_tab.getrow()
			  wf_retrieve()
		  END IF
		  
	  END IF	
	  
END CHOOSE		

//f_setpointer('END')

end event

event ue_delete;call super::ue_delete;
ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
      string ls_buil_no
		long ll_count
		ls_buil_no = tab_sheet.tabpage_sheet01.dw_update1.object.buil_no[tab_sheet.tabpage_sheet01.dw_update1.getrow()]
	   idw_name = tab_sheet.tabpage_sheet01.dw_update1

	   dwItemStatus l_status 
		l_status = idw_name.getitemstatus(1, 0, Primary!)
	
		IF l_status = New! OR l_status = NewModified! THEN 
				  
		ELSE
			IF f_messagebox( '2', 'DEL' ) = 1 THEN

				select buil_no 
				into   :ll_count
				from   stdb.hst241m 
				where buil_no  = :ls_buil_no;
				if  ll_count > 0 THEN
					messagebox('확인','하위 데이터가 존재함니다..!~r~n' + &
					           '하위데이터부터 삭제 하시기 바랍니다..!')
					return
				end if
				
				DELETE FROM STDB.HST240H
				WHERE  buil_no  = :ls_buil_no;

				idw_name.deleterow(0)
				tab_sheet.tabpage_sheet01.dw_update2.deleterow(0)
				IF f_update2( tab_sheet.tabpage_sheet01.dw_update2, idw_name,'D') = TRUE THEN 
					wf_setmsg("삭제되었습니다")
					wf_retrieve()
//					this.triggerevent("ue_insert")
				END IF	
	       END IF
		END IF
		
END CHOOSE		

end event

event ue_button_set;call super::ue_button_set;tab_sheet.tabpage_2.cb_2.x = tab_sheet.tabpage_2.cb_1.x + tab_sheet.tabpage_2.cb_1.width + 16
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hss201a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hss201a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hss201a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hss201a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hss201a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hss201a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hss201a
end type

type uc_insert from w_tabsheet`uc_insert within w_hss201a
end type

type uc_delete from w_tabsheet`uc_delete within w_hss201a
end type

type uc_save from w_tabsheet`uc_save within w_hss201a
end type

type uc_excel from w_tabsheet`uc_excel within w_hss201a
end type

type uc_print from w_tabsheet`uc_print within w_hss201a
end type

type st_line1 from w_tabsheet`st_line1 within w_hss201a
end type

type st_line2 from w_tabsheet`st_line2 within w_hss201a
end type

type st_line3 from w_tabsheet`st_line3 within w_hss201a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hss201a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hss201a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hss201a
integer y = 172
integer width = 4384
integer height = 2136
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_2 tabpage_2
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		f_setpointer('START')
//      wf_retrieve()
//		f_setpointer('END')		
//end choose
end event

on tab_sheet.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 2016
long backcolor = 1073741824
string text = "건물 관리"
gb_2 gb_2
gb_1 gb_1
st_1 st_1
sle_code sle_code
sle_name sle_name
dw_update1 dw_update1
gb_3 gb_3
dw_update2 dw_update2
st_2 st_2
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.sle_code=create sle_code
this.sle_name=create sle_name
this.dw_update1=create dw_update1
this.gb_3=create gb_3
this.dw_update2=create dw_update2
this.st_2=create st_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_code
this.Control[iCurrent+5]=this.sle_name
this.Control[iCurrent+6]=this.dw_update1
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.dw_update2
this.Control[iCurrent+9]=this.st_2
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.sle_code)
destroy(this.sle_name)
destroy(this.dw_update1)
destroy(this.gb_3)
destroy(this.dw_update2)
destroy(this.st_2)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 2528
integer y = 468
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
integer x = 23
integer y = 252
integer width = 1536
integer height = 1748
boolean titlebar = true
string title = "조회내용"
string dataobject = "d_hss201a_1"
end type

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

long ll_row
string ls_buil_no

idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab

idw_name1.accepttext()

IF currentrow <> 0 THEN

	ls_buil_no = idw_name1.object.buil_no[currentrow]
	
   IF	tab_sheet.tabpage_sheet01.dw_update1.retrieve( ls_buil_no ) <> 0 THEN
		
		IF tab_sheet.tabpage_sheet01.dw_update2.retrieve( ls_buil_no ) = 0 THEN 
			
		   tab_sheet.tabpage_sheet01.dw_update2.reset()
			tab_sheet.tabpage_sheet01.dw_update2.insertrow(0)
		
	   END IF
	
   ELSE
		
      wf_insert()
		
   END IF
	
END IF

end event

type uo_tab from w_tabsheet`uo_tab within w_hss201a
integer y = 128
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hss201a
boolean visible = false
integer y = 60
end type

type st_con from w_tabsheet`st_con within w_hss201a
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_2 from groupbox within tabpage_sheet01
integer x = 1582
integer y = 228
integer width = 2752
integer height = 520
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "건물 기본 내역"
end type

type gb_1 from groupbox within tabpage_sheet01
integer x = 23
integer y = 36
integer width = 1760
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
integer x = 59
integer y = 124
integer width = 297
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "건물 번호"
boolean focusrectangle = false
end type

type sle_code from singlelineedit within tabpage_sheet01
integer x = 357
integer y = 112
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
integer x = 1175
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

type dw_update1 from cuo_dwwindow within tabpage_sheet01
integer x = 1605
integer y = 284
integer width = 2706
integer height = 428
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hss201a_2"
boolean border = false
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemerror;call super::itemerror;return 1
end event

type gb_3 from groupbox within tabpage_sheet01
integer x = 1582
integer y = 748
integer width = 2752
integer height = 1252
integer taborder = 21
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "건물 상세 내역"
end type

type dw_update2 from cuo_dwwindow within tabpage_sheet01
integer x = 1614
integer y = 828
integer width = 2688
integer height = 1132
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hss201a_3"
boolean vscrollbar = true
boolean border = false
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

type st_2 from statictext within tabpage_sheet01
integer x = 914
integer y = 124
integer width = 201
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

type tabpage_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2016
string text = "건물이미지 관리"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_2 cb_2
dw_list2 dw_list2
sle_2 sle_2
st_4 st_4
st_3 st_3
gb_5 gb_5
sle_1 sle_1
gb_6 gb_6
p_build p_build
cb_1 cb_1
end type

on tabpage_2.create
this.cb_2=create cb_2
this.dw_list2=create dw_list2
this.sle_2=create sle_2
this.st_4=create st_4
this.st_3=create st_3
this.gb_5=create gb_5
this.sle_1=create sle_1
this.gb_6=create gb_6
this.p_build=create p_build
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.dw_list2,&
this.sle_2,&
this.st_4,&
this.st_3,&
this.gb_5,&
this.sle_1,&
this.gb_6,&
this.p_build,&
this.cb_1}
end on

on tabpage_2.destroy
destroy(this.cb_2)
destroy(this.dw_list2)
destroy(this.sle_2)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.gb_5)
destroy(this.sle_1)
destroy(this.gb_6)
destroy(this.p_build)
destroy(this.cb_1)
end on

type cb_2 from uo_imgbtn within tabpage_2
integer x = 2057
integer y = 96
integer taborder = 60
boolean bringtotop = true
string btnname = "이미지 삭제"
end type

event clicked;call super::clicked;string  ls_build_no
 ls_build_no = tab_sheet.tabpage_2.dw_list2.object.buil_no[tab_sheet.tabpage_2.dw_list2.getrow()]
 
 Blob	lbo_Image	//이미지
		lbo_Image = f_blob_read("..\img\message_ico.gif")
		UPDATEBLOB	STDB.HST240H
		SET			BUIL_IMG = :lbo_Image,
		WHERE			BUIL_NO  = :ls_build_no;
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

on cb_2.destroy
call uo_imgbtn::destroy
end on

type dw_list2 from uo_dwgrid within tabpage_2
integer x = 23
integer y = 252
integer width = 1554
integer height = 1764
integer taborder = 21
boolean titlebar = true
string title = "조회내용"
string dataobject = "d_hss201a_1"
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
string ls_buil_no

idw_name1 = tab_sheet.tabpage_2.dw_list2

idw_name1.accepttext()

IF currentrow <> 0 THEN

	ls_buil_no = idw_name1.object.buil_no[currentrow]
	
	////////////////////////////////////////////////////////////////////////////////////
	//  건물이미지정보 조회처리
	////////////////////////////////////////////////////////////////////////////////////
	Blob	lbo_Image
	SELECTBLOB	A.BUIL_IMG
	INTO			:lbo_Image
	FROM			STDB.HST240H A
	WHERE			A.BUIL_NO = :ls_buil_No;
	IF SQLCA.SQLCODE <> 0 THEN
		SetNull(lbo_Image)
		tab_sheet.tabpage_2.p_build.picturename = "../bmp/blank.bmp"
	END IF
		tab_sheet.tabpage_2.p_build.SetPicture(lbo_Image)
END IF

end event

type sle_2 from singlelineedit within tabpage_2
integer x = 1175
integer y = 112
integer width = 471
integer height = 80
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within tabpage_2
integer x = 914
integer y = 120
integer width = 201
integer height = 52
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

type st_3 from statictext within tabpage_2
integer x = 59
integer y = 124
integer width = 297
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "건물 번호"
boolean focusrectangle = false
end type

type gb_5 from groupbox within tabpage_2
integer x = 23
integer y = 36
integer width = 1682
integer height = 188
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "조회조건"
end type

type sle_1 from singlelineedit within tabpage_2
integer x = 357
integer y = 112
integer width = 471
integer height = 80
integer taborder = 60
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

type gb_6 from groupbox within tabpage_2
integer x = 1600
integer y = 232
integer width = 2725
integer height = 1780
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "건물이미지"
end type

type p_build from picture within tabpage_2
integer x = 1664
integer y = 312
integer width = 2597
integer height = 1648
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type cb_1 from uo_imgbtn within tabpage_2
integer x = 1742
integer y = 96
integer taborder = 50
boolean bringtotop = true
string btnname = "이미지 등록"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: buttonclikced::dw_update1
//	기 능 설 명: 건물정보 이미지처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')

idw_name1 = tab_sheet.tabpage_2.dw_list2
idw_name1.accepttext()


long ll_row
ll_row =  idw_name1.getrow()
IF ll_row = 0 THEN RETURN
string ls_build_no 
ls_build_no = idw_name1.object.buil_no[ll_row]


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
		FROM		STDB.HST240H  A
		WHERE		A.BUIL_NO = :ls_build_No;
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0
			CASE 100
				INSERT	INTO	STDB.HST240H(BUIL_NO, BUIL_IMG, WORKER, WORK_DATE, IPADDR, 
									JOB_UID, JOB_ADD, JOB_DATE)
				VALUES	(	:ls_build_no,'', :gstru_uid_uname.uid, sysdate,:gstru_uid_uname.address	,'','','');
				
			CASE ELSE
				MessageBox('오류',&
								'건물기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
				RETURN
		END CHOOSE
			
		UPDATEBLOB	STDB.HST240H
		SET			BUIL_IMG = :lbo_Image, 
		WHERE			BUIL_NO  = :ls_build_no;
		IF SQLCA.SQLCODE = 0 THEN
			COMMIT;
			p_build.picturename = ls_FullName
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

////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

