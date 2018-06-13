$PBExportHeader$w_dhwhj201a.srw
$PBExportComments$[대학원학적] 학적내용관리
forward
global type w_dhwhj201a from w_no_condition_window
end type
type dw_search from uo_input_dwc within w_dhwhj201a
end type
type tab_1 from tab within w_dhwhj201a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from uo_dwfree within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_3 from uo_dwfree within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_4 from uo_grid within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_4 dw_4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_6 from uo_grid within tabpage_5
end type
type dw_5 from uo_dwfree within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_6 dw_6
dw_5 dw_5
end type
type tabpage_6 from userobject within tab_1
end type
type dw_7 from uo_dwfree within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_7 dw_7
end type
type tab_1 from tab within w_dhwhj201a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
type p_photo from picture within w_dhwhj201a
end type
type cb_1 from commandbutton within w_dhwhj201a
end type
type cb_2 from commandbutton within w_dhwhj201a
end type
type dw_con from uo_dwfree within w_dhwhj201a
end type
type gb_4 from groupbox within w_dhwhj201a
end type
end forward

global type w_dhwhj201a from w_no_condition_window
dw_search dw_search
tab_1 tab_1
p_photo p_photo
cb_1 cb_1
cb_2 cb_2
dw_con dw_con
gb_4 gb_4
end type
global w_dhwhj201a w_dhwhj201a

type variables
integer	ii_index
string	is_hakbun
end variables

forward prototypes
public subroutine wf_retrieve (string as_sangtae, string as_hakbun)
public subroutine wf_con_protect ()
end prototypes

public subroutine wf_retrieve (string as_sangtae, string as_hakbun);//졸업생인지 재학생인지 체크하여 데이타윈도우를 변경한다.
choose case as_sangtae
	case '01', '02', '03', '04'
		tab_1.tabpage_1.dw_1.dataobject = 'd_dhwhj201a_1'
		tab_1.tabpage_2.dw_2.dataobject = 'd_dhwhj201a_2'
		tab_1.tabpage_3.dw_3.dataobject = 'd_dhwhj201a_3'
		tab_1.tabpage_1.dw_1.settransobject(sqlca)
		tab_1.tabpage_2.dw_2.settransobject(sqlca)
		tab_1.tabpage_3.dw_3.settransobject(sqlca)
		
	case else
		tab_1.tabpage_1.dw_1.dataobject = 'd_dhwhj201a_4'
		tab_1.tabpage_2.dw_2.dataobject = 'd_dhwhj201a_5'
		tab_1.tabpage_3.dw_3.dataobject = 'd_dhwhj201a_6'
		tab_1.tabpage_1.dw_1.settransobject(sqlca)
		tab_1.tabpage_2.dw_2.settransobject(sqlca)
		tab_1.tabpage_3.dw_3.settransobject(sqlca)
end choose

		tab_1.tabpage_1.dw_1.retrieve(as_hakbun)		
		tab_1.tabpage_2.dw_2.retrieve(as_hakbun)	
		tab_1.tabpage_3.dw_3.retrieve(as_hakbun)	
//			SELECTBLOB	PHOTO
//			INTO			:b_total_pic
//			FROM			D_PHOTO
//			WHERE 		HAKBUN	= :is_hakbun
//			;
//				
//			if sqlca.sqlcode = 0 then
//				p_photo.setpicture(b_total_pic)
//			end if
end subroutine

public subroutine wf_con_protect ();// 계열, 학과, 전공 사용유무를 체크하여 protect한다.
// ls_chk1 : 계열, ls_chk2 : 학과, ls_chk3 : 전공
// Y: 사용, N: 미사용

String ls_chk1, ls_chk2, ls_chk3
Int      li_chk1, li_chk2, li_chk3

SELECT ETC_CD1, ETC_CD2, ETC_CD3
   INTO :ls_chk1, :ls_chk2, :ls_chk3
  FROM CDDB.KCH102D
 WHERE CODE_GB = 'DHW01'
 USING SQLCA ;
 
If  ls_chk1 = 'Y' Then
	li_chk1 = 0
Else
	li_chk1 = 1
End If

If  ls_chk2 = 'Y' Then
	li_chk2 = 0
Else
	li_chk2 = 1
End If

If  ls_chk3 = 'Y' Then
	li_chk3 = 0
Else
	li_chk3 = 1
End If
 
tab_1.tabpage_1.dw_1.Object.gyeyul_id.Protect     = li_chk1
tab_1.tabpage_1.dw_1.Object.gwa_id.Protect        = li_chk2
tab_1.tabpage_1.dw_1.Object.jungong_id.Protect   = li_chk3
end subroutine

on w_dhwhj201a.create
int iCurrent
call super::create
this.dw_search=create dw_search
this.tab_1=create tab_1
this.p_photo=create p_photo
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_con=create dw_con
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_search
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.p_photo
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.dw_con
this.Control[iCurrent+7]=this.gb_4
end on

on w_dhwhj201a.destroy
call super::destroy
destroy(this.dw_search)
destroy(this.tab_1)
destroy(this.p_photo)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_con)
destroy(this.gb_4)
end on

event ue_retrieve;call super::ue_retrieve;long ll_row, ll_ans
string ls_hakbun, ls_name, ls_sangtae1, ls_sangtae2, ls_sangtae3, ls_sangtae4, ls_gubun

dw_con.AcceptText()

ls_hakbun =	 func.of_nvl(dw_con.Object.hakbun[1], '%') + '%'
ls_name   =	 func.of_nvl(dw_con.Object.hname[1], '%') + '%'
ls_gubun	  =  dw_con.Object.gubun[1]

if ls_gubun = '1' Then
	ls_sangtae1 = '01'
	ls_sangtae2 = '02'
	ls_sangtae3 = '03'
	ls_sangtae4 = '05'
else
	ls_sangtae1 = '04'
end if

ll_ans = dw_search.retrieve(ls_hakbun, ls_name, ls_sangtae1, ls_sangtae2, ls_sangtae3, ls_sangtae4)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
elseif ll_ans > 0 then
	
	is_hakbun	= dw_search.object.hakbun[1]
//	ls_sangtae	= dw_search.object.sangtae_id[1]

	tab_1.tabpage_1.dw_1.retrieve(is_hakbun)		
	tab_1.tabpage_2.dw_2.retrieve(is_hakbun)	
	tab_1.tabpage_3.dw_3.retrieve(is_hakbun)		
	tab_1.tabpage_4.dw_4.retrieve(is_hakbun)
	tab_1.tabpage_5.dw_5.retrieve(is_hakbun)
	tab_1.tabpage_6.dw_7.retrieve(is_hakbun)
	
//	wf_retrieve(ls_sangtae, is_hakbun)		//재학생인지 졸업생인지를 체크하여 조회하는 함수.
	
end if

	dw_con.Object.hakbun[1] = ''
	dw_con.Object.hname[1] = ''

Return 1
end event

event ue_delete;call super::ue_delete;int li_ans

if ii_index <> 3 then
	messagebox("오류","하위과정만 삭제가 가능합니다.")
	return
end if

tab_1.tabpage_3.dw_3.deleterow(0)
li_ans = tab_1.tabpage_3.dw_3.update()

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback USING SQLCA ;
else	
	commit USING SQLCA ;
	//저장확인 메세지 출력
//	uf_messagebox(2)
end if
end event

event ue_insert;call super::ue_insert;long ll_line

if ii_index <> 3 then
	messagebox("오류","하위과정만 신규입력이 가능합니다.")
	return
end if

ll_line = tab_1.tabpage_3.dw_3.insertrow(0)

if ll_line <> -1 then
	tab_1.tabpage_3.dw_3.scrolltorow(ll_line)
	
	tab_1.tabpage_3.dw_3.object.hakbun[ll_line]	= is_hakbun
	
	tab_1.tabpage_3.dw_3.setcolumn('gwajung_id')
	tab_1.tabpage_3.dw_3.setfocus()
end if
end event

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

end event

event ue_savestart;call super::ue_savestart;String ls_gyeyul_hname, ls_gwa_hname, ls_jungong_hname
Long   ll_row

ll_row = tab_1.tabpage_1.dw_1.GetRow()

ls_gyeyul_hname = tab_1.tabpage_1.dw_1.Describe("Evaluate('lookupdisplay(gyeyul_id)',1)")
tab_1.tabpage_1.dw_1.Object.gyeyul_hname[ll_row] = ls_gyeyul_hname

ls_gwa_hname = tab_1.tabpage_1.dw_1.Describe("Evaluate('lookupdisplay(gwa_id)',1)")
tab_1.tabpage_1.dw_1.Object.gwa_hname[ll_row] = ls_gwa_hname

ls_jungong_hname = tab_1.tabpage_1.dw_1.Describe("Evaluate('lookupdisplay(jungong_id)',1)")
tab_1.tabpage_1.dw_1.Object.jungong_hname[ll_row] = ls_jungong_hname

Return 1
end event

event ue_postopen;call super::ue_postopen;Vector lvc_data

// 공통코드 Setup
lvc_data = Create Vector
lvc_data.setProperty('column1', 'nation_code')  // 국적
lvc_data.setProperty('key1', 'kukjuk_code')

func.of_dddw( tab_1.tabpage_1.dw_1, lvc_data)

wf_con_protect()
end event

type ln_templeft from w_no_condition_window`ln_templeft within w_dhwhj201a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_dhwhj201a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_dhwhj201a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_dhwhj201a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_dhwhj201a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_dhwhj201a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_dhwhj201a
end type

type uc_insert from w_no_condition_window`uc_insert within w_dhwhj201a
end type

type uc_delete from w_no_condition_window`uc_delete within w_dhwhj201a
end type

type uc_save from w_no_condition_window`uc_save within w_dhwhj201a
end type

type uc_excel from w_no_condition_window`uc_excel within w_dhwhj201a
end type

type uc_print from w_no_condition_window`uc_print within w_dhwhj201a
end type

type st_line1 from w_no_condition_window`st_line1 within w_dhwhj201a
end type

type st_line2 from w_no_condition_window`st_line2 within w_dhwhj201a
end type

type st_line3 from w_no_condition_window`st_line3 within w_dhwhj201a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_dhwhj201a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_dhwhj201a
end type

type gb_1 from w_no_condition_window`gb_1 within w_dhwhj201a
end type

type dw_search from uo_input_dwc within w_dhwhj201a
integer x = 50
integer y = 296
integer width = 736
integer height = 1280
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwhj201q_1"
end type

event clicked;call super::clicked;string ls_sangtae
blob b_total_pic

if row > 0 then

	is_hakbun	= this.object.hakbun[row]
	ls_sangtae	= this.object.sangtae_id[row]
	
	tab_1.tabpage_1.dw_1.retrieve(is_hakbun)		
	tab_1.tabpage_2.dw_2.retrieve(is_hakbun)	
	tab_1.tabpage_3.dw_3.retrieve(is_hakbun)
	tab_1.tabpage_4.dw_4.retrieve(is_hakbun)	
	tab_1.tabpage_5.dw_5.retrieve(is_hakbun)	
	tab_1.tabpage_6.dw_7.retrieve(is_hakbun)	
	
//	wf_retrieve(ls_sangtae, is_hakbun)		//재학생인지 졸업생인지를 체크하여 조회하는 함수.
	
			SELECTBLOB	P_IMAGE
			INTO			:b_total_pic
			FROM			HAKSA.D_PHOTO
			WHERE 		HAKBUN	= :is_hakbun
			USING SQLCA ;
				
			IF sqlca.sqlcode = 0 THEN
				p_photo.setpicture(b_total_pic)
				
			ELSE
				p_photo.picturename = "..\HAKSA\DHW\flower.gif"

			END IF
end if	
end event

type tab_1 from tab within w_dhwhj201a
integer x = 809
integer y = 296
integer width = 3625
integer height = 1968
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event selectionchanged;ii_index = newindex

choose case ii_index
	case 1
		idw_update[1] = tab_1.tabpage_1.dw_1
		tab_1.tabpage_1.dw_1.retrieve(is_hakbun)
	case 2
		idw_update[1] = tab_1.tabpage_2.dw_2
		tab_1.tabpage_2.dw_2.retrieve(is_hakbun)
	case 3
		idw_update[1] = tab_1.tabpage_3.dw_3
		tab_1.tabpage_3.dw_3.retrieve(is_hakbun)
		
end choose


end event

event selectionchanging;/*----------------------------------------------------------------------
	Description	:	현재 tabpage에 저장되지 않은 내용을 저장할 것인가 확인
	Create by	:	KoreaIT.Inc
	Create dt	:	2001/11/21
----------------------------------------------------------------------*/
int  li_ret
long  ll_modified, ll_deleted


choose case oldindex
	case 1
		tab_1.tabpage_1.dw_1.accepttext()
		ll_modified	= tab_1.tabpage_1.dw_1.modifiedcount() 
		ll_deleted	= tab_1.tabpage_1.dw_1.deletedcount()		
	case 2
		tab_1.tabpage_2.dw_2.accepttext()
		ll_modified	= tab_1.tabpage_2.dw_2.modifiedcount() 
		ll_deleted	= tab_1.tabpage_2.dw_2.deletedcount()	
//	case 3
//		tab_1.tabpage_3.dw_3.accepttext()
//		ll_modified	= tab_1.tabpage_3.dw_3.modifiedcount() 
//		ll_deleted	= tab_1.tabpage_3.dw_3.deletedcount()	
end choose

if ll_modified + ll_deleted > 0 then
	li_ret = messagebox('확인','자료를 저장하시겠습니까?',Question!,YesNo!)
	
	IF li_ret = 1 THEN
		triggerevent("ue_save")
		
	END IF
end if

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3589
integer height = 1848
long backcolor = 16777215
string text = "학적기본"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from uo_dwfree within tabpage_1
integer width = 3598
integer height = 1840
integer taborder = 21
string dataobject = "d_dhwhj201a_1"
boolean resizable = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;//주소 검색하기...
string ls_tot, ls_zip, ls_juso
long ll_len

choose case dwo.name
	case 'b_1'
		open(w_zipcode)
		ls_tot	= message.Stringparm
		ll_len	= len(ls_tot)
		ls_zip	= mid(ls_tot, 1, 6)
		ls_juso	= mid(ls_tot, 7, ll_len)
		
		this.object.zip_id[row] = ls_zip
		this.object.juso[row]	= ls_juso
		this.SetColumn("juso")
	case 'b_2'
		open(w_zipcode)
		ls_tot	= message.Stringparm
		ll_len	= len(ls_tot)
		ls_zip	= mid(ls_tot, 1, 6)
		ls_juso	= mid(ls_tot, 7, ll_len)
		
		this.object.bo_zip_id[row] = ls_zip
		this.object.bo_juso[row]	= ls_juso
		this.SetColumn("bo_juso")
end choose

//Keyboard입력을 동적으로 사용(글로벌함수)
//SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"
//Keybd_event( 35, 1, 0, 0 ) //End Key를 친것과 같음..커서를 주소 맨 마지막에 보낼려고


end event

event constructor;call super::constructor;This.SetTransObject(sqlca)

func.of_design_dw(dw_1)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3589
integer height = 1848
long backcolor = 16777215
string text = "입학/논문사항"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from uo_dwfree within tabpage_2
integer y = 4
integer width = 3589
integer height = 1840
integer taborder = 30
string dataobject = "d_dhwhj201a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)

func.of_design_dw(dw_2)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3589
integer height = 1848
long backcolor = 16777215
string text = "하위과정"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from uo_dwfree within tabpage_3
integer y = 8
integer width = 3593
integer height = 1836
integer taborder = 30
string dataobject = "d_dhwhj201A_3"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)

func.of_design_dw(dw_3)
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3589
integer height = 1848
long backcolor = 16777215
string text = "학적변동내역"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_4.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_4)
end on

type dw_4 from uo_grid within tabpage_4
integer y = 20
integer width = 3566
integer height = 1800
integer taborder = 130
string dataobject = "d_dhwhj201a_4"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3589
integer height = 1848
long backcolor = 16777215
string text = "성적내역"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_6 dw_6
dw_5 dw_5
end type

on tabpage_5.create
this.dw_6=create dw_6
this.dw_5=create dw_5
this.Control[]={this.dw_6,&
this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_6)
destroy(this.dw_5)
end on

type dw_6 from uo_grid within tabpage_5
integer y = 632
integer width = 3584
integer height = 1204
integer taborder = 20
string dataobject = "d_dhwhj201a_5_1"
boolean vscrollbar = true
end type

type dw_5 from uo_dwfree within tabpage_5
integer y = 16
integer width = 3584
integer height = 588
integer taborder = 140
string dataobject = "d_dhwhj201a_5"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;String ls_hakbun, ls_year, ls_hakgi

If This.GetRow() < 1 Then Return ;

ls_hakbun = This.Object.hakbun[currentrow]
ls_year     = This.Object.year[currentrow]
ls_hakgi   = This.Object.hakgi[currentrow]

dw_6.Retrieve( ls_hakbun, ls_year, ls_hakgi )
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3589
integer height = 1848
long backcolor = 16777215
string text = "장학/등록내역"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_7 dw_7
end type

on tabpage_6.create
this.dw_7=create dw_7
this.Control[]={this.dw_7}
end on

on tabpage_6.destroy
destroy(this.dw_7)
end on

type dw_7 from uo_dwfree within tabpage_6
integer y = 8
integer width = 3579
integer height = 1820
integer taborder = 140
string dataobject = "d_dhwhj201a_6"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

type p_photo from picture within w_dhwhj201a
integer x = 183
integer y = 1628
integer width = 489
integer height = 504
boolean bringtotop = true
string picturename = ".\flower.gif"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_dhwhj201a
integer x = 123
integer y = 2144
integer width = 306
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "사진"
end type

event clicked;blob b_total_pic, b_pic
int li_ans, li_rtn, li_filenum, ll_count
long ll_filelen, ll_loop
string ls_extension, ls_filter, ls_path, ls_filename

if is_hakbun <> '' then
	SetPointer(HourGlass!)
	
	SELECTBLOB	P_IMAGE
	INTO			:b_total_pic
	FROM			HAKSA.D_PHOTO
	WHERE 		HAKBUN	= :is_hakbun
	;
	
	if sqlca.sqlcode = 0 then
		p_photo.setpicture(b_total_pic)
		
	elseif sqlca.sqlcode = 100 then
		li_ans = messagebox("확인","조회한 학생의 사진이 존재하지 않습니다."	&
											+ "~n사진을 입력하시겠습니까?", question!, yesno!, 1)
		
		if li_ans = 1 then
			
			ls_extension	= "BMP"
			ls_filter		= "Jpg Files (*.jpg),*.jpg"
			
			li_rtn = GetFileOpenName("Open BMP, JPEG", ls_path	, ls_filename, ls_extension, ls_filter)
			
			if li_rtn = 1 then
				li_filenum = FileOpen(ls_filename, StreamMode!)
										
				if li_filenum <> -1 then
					ll_filelen = filelength(ls_filename)
					
					/*****************************************
					//	파일을 클 경우 한번에 전부 읽을 수 없다.
					// 32765Byte 읽을 수 있다. 
					****************************************/
					if ll_filelen > 32765 then
						if mod(ll_filelen, 32765) = 0 then
							ll_loop = ll_filelen/32765
						else
							ll_loop = ll_filelen/32765 + 1
						end if
					else
						ll_loop = 1
					end if
					
					for ll_count = 1 to ll_loop
						FileRead(li_filenum, b_pic)
						b_total_pic = b_total_pic + b_pic
					next
					
					FileClose(li_filenum)
					
					li_ans = p_photo.setpicture(b_total_pic)
						
					if li_ans = 1 then
						li_ans = messagebox("확인", "자료를 저장하시겠씁니까?", question!, yesno!, 1)
						SetPointer(HourGlass!)
						
						if li_ans = 1 then
							/**************** 사진 저장  ********************/
							/*사진을 바로 Insert 할 수 없고 학번을 저장한 후*/
							/*사진을 Update 한다.                         	*/
							/************************************************/
							INSERT INTO	HAKSA.D_PHOTO
											(	HAKBUN		,
												P_IMAGE
											)
							VALUES		(	:is_hakbun	,
												null
											)
							;
								
							if sqlca.sqlcode = 0 then
								UPDATEBLOB	HAKSA.D_PHOTO
								SET			P_IMAGE = :b_total_pic
								WHERE			HAKBUN = :is_hakbun
								;
					
								if sqlca.sqlcode = 0 then
									commit;
									uf_messagebox(2)
								else
									rollback;
									uf_messagebox(3)
								end if
					
							end if
						end if
					end if
				end if
			end if
		end if
	end if
end if
end event

type cb_2 from commandbutton within w_dhwhj201a
integer x = 434
integer y = 2144
integer width = 306
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "삭제"
end type

event clicked;if is_hakbun <> '' then			

	if messagebox("확인", "사진을 삭제하시겠습니까?", question!, yesno!, 2) = 2 then return
		
	DELETE FROM	HAKSA.D_PHOTO
	WHERE			HAKBUN = :is_hakbun
	;
				
	if sqlca.sqlcode = -1 then
		uf_messagebox(6)          //삭제오류 메세지 출력
		ROLLBACK USING SQLCA;     
	else
		COMMIT USING SQLCA;		  
		uf_messagebox(5)
		
		p_photo.visible = false
		
	end if		

end if
end event

type dw_con from uo_dwfree within w_dhwhj201a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_dhwhj201a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type gb_4 from groupbox within w_dhwhj201a
integer x = 37
integer y = 1572
integer width = 763
integer height = 692
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

