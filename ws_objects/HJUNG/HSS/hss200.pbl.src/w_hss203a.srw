$PBExportHeader$w_hss203a.srw
$PBExportComments$층 관리
forward
global type w_hss203a from w_tabsheet
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type st_1 from statictext within tabpage_sheet01
end type
type sle_code from singlelineedit within tabpage_sheet01
end type
type st_2 from statictext within tabpage_sheet01
end type
type sle_name from singlelineedit within tabpage_sheet01
end type
type dw_update1 from uo_dwgrid within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_list1 from uo_dwgrid within tabpage_1
end type
type cb_2 from uo_imgbtn within tabpage_1
end type
type cb_1 from uo_imgbtn within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type sle_code1 from singlelineedit within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type p_floor from picture within tabpage_1
end type
type dw_build2 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_list1 dw_list1
cb_2 cb_2
cb_1 cb_1
gb_2 gb_2
st_4 st_4
sle_code1 sle_code1
st_3 st_3
gb_3 gb_3
p_floor p_floor
dw_build2 dw_build2
end type
end forward

global type w_hss203a from w_tabsheet
string title = "건물관리"
end type
global w_hss203a w_hss203a

type variables

int ii_tab
long il_getrow = 1
datawindowchild idw_child
string	is_buil_no, is_build_no 
DataWindowchild	idwc_Gwa
datawindow idw_name1
end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_insert ()
end prototypes

public subroutine wf_retrieve ();
string ls_build_code, ls_build_name, ls_build_code2, ls_build_name2



ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
    
      ls_build_code = trim(tab_sheet.tabpage_sheet01.sle_code.text) + '%'
		ls_build_name = trim(tab_sheet.tabpage_sheet01.sle_name.text) + '%' + '%'
		
		IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( ls_build_code, ls_build_name ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			
//			wf_insert()
		ELSE	
			tab_sheet.tabpage_sheet01.dw_update_tab.setfocus()
         tab_sheet.tabpage_sheet01.dw_update_tab.trigger event rowfocuschanged(il_getrow)
		END IF	 
	CASE 2		
      ls_build_code2 = trim(tab_sheet.tabpage_1.sle_code1.text) 
		IF (LS_BUILD_CODE2 = '' OR ISNULL(LS_BUILD_CODE2) ) AND (is_build_no = '' or isnull(is_build_no)) then
			wf_setMsg("건물번호나 건물명을 입력하세요")	
			tab_sheet.tabpage_1.p_floor.picturename = "../bmp/blank.bmp"						

			RETURN
		END IF	
      ls_build_code2 = ls_build_code2 + '%'
		ls_build_name2 = is_build_no 
		
		
		IF tab_sheet.tabpage_1.dw_list1.retrieve( ls_build_name2) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			tab_sheet.tabpage_1.p_floor.picturename = "../bmp/blank.bmp"						
			wf_insert()
		ELSE	
			tab_sheet.tabpage_1.dw_list1.setfocus()
         tab_sheet.tabpage_1.dw_list1.trigger event rowfocuschanged(il_getrow)
		END IF	 

END CHOOSE		



end subroutine

public subroutine wf_insert ();STRING	ls_cur_buil_no

ii_tab  = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
      
     

		ls_cur_buil_no	=	tab_sheet.tabpage_sheet01.dw_update_tab.object.buil_no[tab_sheet.tabpage_sheet01.dw_update_tab.getrow()]		
//		tab_sheet.tabpage_sheet01.dw_update1.object.buil_no[		tab_sheet.tabpage_sheet01.dw_update1.getrow()] =	ls_cur_buil_no
		tab_sheet.tabpage_sheet01.dw_update1.object.buil_no[tab_sheet.tabpage_sheet01.dw_update1.insertrow(0)] =	ls_cur_buil_no
		
		tab_sheet.tabpage_sheet01.dw_update1.object.worker[1] = gstru_uid_uname.uid      // 작업자 
		tab_sheet.tabpage_sheet01.dw_update1.object.work_date[1] = f_sysdate()           // 오늘 일자 
		tab_sheet.tabpage_sheet01.dw_update1.object.ipaddr[1] = gstru_uid_uname.address  //IP

		tab_sheet.tabpage_sheet01.dw_update_tab.accepttext()

		tab_sheet.tabpage_sheet01.dw_update1.object.ipaddr[1] = gstru_uid_uname.address  //BUIL_NO		
		tab_sheet.tabpage_sheet01.dw_update1.setfocus()
		
END CHOOSE

end subroutine

on w_hss203a.create
int iCurrent
call super::create
end on

on w_hss203a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;
wf_retrieve()
return 1





end event

event ue_insert;call super::ue_insert;
wf_insert()


end event

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////
// 작성목적 : 층관리
// 적 성 인 : 황현석
//	작성일자 : 2002.06.29
// 변 경 인 :
// 변경일자 :
// 변경사유 :
////////////////////////////////////////////////////////////////////
//
//wf_setMenu('I',TRUE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',TRUE)
//wf_setMenu('U',TRUE)

f_childretrieve(tab_sheet.tabpage_sheet01.dw_update1,"fac_use_opt","fac_use_opt")
f_childretrieve(tab_sheet.tabpage_1.dw_list1,"fac_use_opt","fac_use_opt")
//f_childretrieve(tab_sheet.tabpage_sheet01.dw_update1,"buil_kind","build_kind")	 // 구내외 구분						
//f_childretrieve(tab_sheet.tabpage_sheet01.dw_update1,"facility_opt","fac_use_opt")
////f_childretrieve(tab_sheet.tabpage_sheet01.dw_list,"buil_kind","build_kind")	          // 구내외 구분						
//
//
//tab_sheet.tabpage_sheet01.dw_build.settransobject(sqlca)
//tab_sheet.tabpage_sheet01.dw_build.insertrow(0)
//tab_sheet.tabpage_sheet01.dw_build.GetChild('code',idwc_Gwa)
//idwc_Gwa.SetTransObject(SQLCA)
//IF idwc_Gwa.Retrieve() = 0 THEN
//	wf_setmsg('건물코드를 입력하시기 바랍니다.')
//	tab_sheet.tabpage_sheet01.dw_build.InsertRow(0)
//END IF

tab_sheet.tabpage_1.dw_build2.settransobject(sqlca)
tab_sheet.tabpage_1.dw_build2.insertrow(0)
tab_sheet.tabpage_1.dw_build2.GetChild('code',idwc_Gwa)
idwc_Gwa.SetTransObject(SQLCA)
IF idwc_Gwa.Retrieve() = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	tab_sheet.tabpage_1.dw_build2.InsertRow(0)
END IF

wf_retrieve()

end event

event ue_save;call super::ue_save;
string ls_cust_no, ls_is_extend
////f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
     
     idw_name1 = tab_sheet.tabpage_sheet01.dw_update1
	   
//	  idw_name.accepttext()	
		
	  IF  f_chk_modified(tab_sheet.tabpage_sheet01.dw_update1) = FALSE THEN RETURN -1
	  
	  string ls_colarry[] = {'floor_kind/층구분','floor/층'}
	  IF f_chk_null( idw_name1, ls_colarry ) = 1 THEN 
		  IF f_chk_modified(idw_name1)	then
			  idw_name1.object.job_uid[1] = gstru_uid_uname.uid		//수정자
		  	  idw_name1.object.job_date[1] = f_sysdate()           // 오늘 일자 
		  	  idw_name1.object.job_add[1] = gstru_uid_uname.address  //IP	
//			  idw_name1.accepttext()
		  end if
		  IF f_update(idw_name1,'U') = TRUE THEN 
			  wf_setmsg("저장되었습니다")
			  il_getrow = tab_sheet.tabpage_sheet01.dw_update_tab.getrow()
			  wf_retrieve()
		  END IF
	  END IF	
	  
END CHOOSE		

//f_setpointer('END')

end event

event ue_delete;call super::ue_delete;ii_tab = tab_sheet.selectedtab
String  ls_buil_no, ls_floor_kind, ls_floor
Long   ll_count
CHOOSE CASE ii_tab
		
	CASE 1

	   idw_name1 = tab_sheet.tabpage_sheet01.dw_update1
      ls_buil_no    = tab_sheet.tabpage_sheet01.dw_update1.object.buil_no[tab_sheet.tabpage_sheet01.dw_update1.getrow()]
		ls_floor_kind = tab_sheet.tabpage_sheet01.dw_update1.object.floor_kind[tab_sheet.tabpage_sheet01.dw_update1.getrow()]
		ls_floor      = tab_sheet.tabpage_sheet01.dw_update1.object.floor[tab_sheet.tabpage_sheet01.dw_update1.getrow()]
	   dwItemStatus l_status 
		l_status = idw_name1.getitemstatus(1, 0, Primary!)
	
			IF f_messagebox( '2', 'DEL' ) = 1 THEN
	

				select buil_no 
				into   :ll_count
				from   stdb.hst242m 
				where buil_no  = :ls_buil_no
				and   floor_kind = :ls_floor_kind
				and   floor      = :ls_floor;
				IF  ll_count > 0 THEN
					messagebox('확인','하위 데이터가 존재함니다..!~r~n' + &
					           '하위데이터부터 삭제 하시기 바랍니다..!')
					RETURN
				END IF
          	idw_name1.deleterow(0)
				IF f_update2( tab_sheet.tabpage_sheet01.dw_update1, idw_name1,'D') = TRUE THEN 
					wf_setmsg("삭제되었습니다")
					wf_retrieve()
//					this.triggerevent("ue_insert")
				END IF	
       
	       END IF
		
END CHOOSE		

end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_button_set;call super::ue_button_set;tab_sheet.tabpage_1.cb_2.x = tab_sheet.tabpage_1.cb_1.x + tab_sheet.tabpage_1.cb_1.width + 16
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hss203a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hss203a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hss203a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hss203a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hss203a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hss203a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hss203a
end type

type uc_insert from w_tabsheet`uc_insert within w_hss203a
end type

type uc_delete from w_tabsheet`uc_delete within w_hss203a
end type

type uc_save from w_tabsheet`uc_save within w_hss203a
end type

type uc_excel from w_tabsheet`uc_excel within w_hss203a
end type

type uc_print from w_tabsheet`uc_print within w_hss203a
end type

type st_line1 from w_tabsheet`st_line1 within w_hss203a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hss203a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hss203a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hss203a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hss203a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hss203a
integer y = 184
integer width = 4384
integer height = 2120
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
integer height = 2000
long backcolor = 1073741824
string text = "층 관리"
gb_1 gb_1
st_1 st_1
sle_code sle_code
st_2 st_2
sle_name sle_name
dw_update1 dw_update1
end type

on tabpage_sheet01.create
this.gb_1=create gb_1
this.st_1=create st_1
this.sle_code=create sle_code
this.st_2=create st_2
this.sle_name=create sle_name
this.dw_update1=create dw_update1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_code
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_name
this.Control[iCurrent+6]=this.dw_update1
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.sle_code)
destroy(this.st_2)
destroy(this.sle_name)
destroy(this.dw_update1)
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
integer x = 23
integer y = 252
integer width = 1499
integer height = 1744
boolean titlebar = true
string title = "조회내용"
string dataobject = "d_hss201a_1"
end type

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )
//
long ll_row
string ls_buil_no

idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab

idw_name1.accepttext()

IF currentrow <> 0 THEN

	ls_buil_no = idw_name1.object.buil_no[currentrow]
	
   IF	tab_sheet.tabpage_sheet01.dw_update1.retrieve( ls_buil_no ) <> 0 THEN
		
   ELSE
		
      wf_insert()
		
   END IF
	
END IF

end event

type uo_tab from w_tabsheet`uo_tab within w_hss203a
integer x = 1061
integer y = 152
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hss203a
boolean visible = false
integer x = 91
integer y = 16
end type

type st_con from w_tabsheet`st_con within w_hss203a
boolean visible = false
integer x = 46
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_1 from groupbox within tabpage_sheet01
integer x = 23
integer y = 36
integer width = 1984
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

type st_2 from statictext within tabpage_sheet01
integer x = 919
integer y = 124
integer width = 215
integer height = 64
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

type sle_name from singlelineedit within tabpage_sheet01
integer x = 1157
integer y = 112
integer width = 649
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

type dw_update1 from uo_dwgrid within tabpage_sheet01
integer x = 1550
integer y = 252
integer width = 2798
integer height = 1744
integer taborder = 110
boolean bringtotop = true
boolean titlebar = true
string title = "층내역"
string dataobject = "d_hss203a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;
if dwo.name = "floor_kind"	and data = '3' then
	this.object.floor[row]	=	"0"
end if	


end event

event itemerror;call super::itemerror;return 1
end event

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2000
string text = "층 이미지관리"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list1 dw_list1
cb_2 cb_2
cb_1 cb_1
gb_2 gb_2
st_4 st_4
sle_code1 sle_code1
st_3 st_3
gb_3 gb_3
p_floor p_floor
dw_build2 dw_build2
end type

on tabpage_1.create
this.dw_list1=create dw_list1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_2=create gb_2
this.st_4=create st_4
this.sle_code1=create sle_code1
this.st_3=create st_3
this.gb_3=create gb_3
this.p_floor=create p_floor
this.dw_build2=create dw_build2
this.Control[]={this.dw_list1,&
this.cb_2,&
this.cb_1,&
this.gb_2,&
this.st_4,&
this.sle_code1,&
this.st_3,&
this.gb_3,&
this.p_floor,&
this.dw_build2}
end on

on tabpage_1.destroy
destroy(this.dw_list1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.st_4)
destroy(this.sle_code1)
destroy(this.st_3)
destroy(this.gb_3)
destroy(this.p_floor)
destroy(this.dw_build2)
end on

type dw_list1 from uo_dwgrid within tabpage_1
integer x = 23
integer y = 252
integer width = 1554
integer height = 1764
integer taborder = 30
boolean titlebar = true
string title = "조회내용"
string dataobject = "d_hss203a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.SettransObject(sqlca)
//this.object.floor_area.width = 0
//this.object.floor_real_area.width = 0
//this.object.is_extend.width = 0
//this.object.remark.width = 0
//this.object.floor.width = 150
//this.taborder = 0
dw_list1.Object.DataWindow.ReadOnly = 'YES'

end event

event rowfocuschanged;call super::rowfocuschanged;//
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

long ll_row
string ls_buil_no, ls_floor, ls_floor_kind

idw_name1 = tab_sheet.tabpage_1.dw_list1

idw_name1.accepttext()

IF currentrow <> 0 THEN

	ls_floor = idw_name1.object.floor[currentrow]
	ls_floor_kind = idw_name1.object.floor_kind[currentrow]	
	
	////////////////////////////////////////////////////////////////////////////////////
	//  건물이미지정보 조회처리
	////////////////////////////////////////////////////////////////////////////////////
	Blob	lbo_Image
	SELECTBLOB	A.FLOOR_IMG
	INTO			:lbo_Image
	FROM			STDB.HST245H A
	WHERE			A.BUIL_NO = :is_build_No AND FLOOR_KIND = :ls_floor_kind AND  floor = :ls_floor  ;
	IF SQLCA.SQLCODE <> 0 THEN
		SetNull(lbo_Image)
		tab_sheet.tabpage_1.p_floor.picturename = "../bmp/blank.bmp"
	END IF
		tab_sheet.tabpage_1.p_floor.SetPicture(lbo_Image)
END IF

end event

type cb_2 from uo_imgbtn within tabpage_1
integer x = 1568
integer y = 96
integer taborder = 70
boolean bringtotop = true
string btnname = "이미지 삭제"
end type

event clicked;call super::clicked;string  ls_build_no, ls_floor_kind, ls_floor
 ls_build_no = dw_build2.object.code[dw_build2.getrow()]

 idw_name1 = tab_sheet.tabpage_1.dw_list1
 ls_floor_kind = idw_name1.object.floor_kind[idw_name1.getrow()]
 ls_floor  = idw_name1.object.floor[idw_name1.getrow()]
 Blob	lbo_Image	//이미지
		lbo_Image = f_blob_read("..\img\message_ico.gif")
		UPDATEBLOB	STDB.HST245H
		SET			FLOOR_IMG = :lbo_Image, 
		WHERE			BUIL_NO  = :ls_build_no
		and         FLOOR_KIND = :ls_floor_kind
		and         FLOOR      = :ls_floor;
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

type cb_1 from uo_imgbtn within tabpage_1
integer x = 1253
integer y = 96
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

idw_name1 = tab_sheet.tabpage_1.dw_list1
idw_name1.accepttext()


long ll_row
ll_row =  idw_name1.getrow()
IF ll_row = 0 THEN RETURN
string ls_build_no , ls_floor_kind, ls_floor
ls_floor = idw_name1.object.floor[ll_row]
ls_floor_kind = idw_name1.object.floor_kind[ll_row]


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
		FROM		STDB.HST245H  A
		WHERE		A.BUIL_NO = :is_build_No AND floor = :ls_floor AND  floor_kind = :ls_floor_kind;
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0
			CASE 100
				INSERT	INTO	STDB.HST245H(BUIL_NO,FLOOR_KIND, FLOOR)
				VALUES	(	:is_build_no, :ls_floor_kind,:ls_floor);
				
			CASE ELSE
				MessageBox('오류',&
								'층기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
				RETURN
		END CHOOSE
			
		UPDATEBLOB	STDB.HST245H
		SET			FLOOR_IMG = :lbo_Image, 
		WHERE			BUIL_NO  = :is_build_no AND  floor_kind = :ls_floor_kind AND  floor = :ls_floor;
		IF SQLCA.SQLCODE = 0 THEN
			COMMIT;
			p_floor.picturename = ls_FullName
			wf_SetMsg('이미지 정보가 저장되었습니다.')
		ELSE
			MessageBox('오류',&
							'층기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
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

type gb_2 from groupbox within tabpage_1
integer x = 23
integer y = 36
integer width = 1184
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

type st_4 from statictext within tabpage_1
boolean visible = false
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

type sle_code1 from singlelineedit within tabpage_1
boolean visible = false
integer x = 357
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

type st_3 from statictext within tabpage_1
integer x = 119
integer y = 124
integer width = 215
integer height = 64
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

type gb_3 from groupbox within tabpage_1
integer x = 1623
integer y = 224
integer width = 2711
integer height = 1768
integer taborder = 21
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "층 이미지"
end type

type p_floor from picture within tabpage_1
integer x = 1705
integer y = 312
integer width = 2574
integer height = 1612
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type dw_build2 from datawindow within tabpage_1
integer x = 334
integer y = 100
integer width = 709
integer height = 92
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_build"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_build_no	=	data
end event

