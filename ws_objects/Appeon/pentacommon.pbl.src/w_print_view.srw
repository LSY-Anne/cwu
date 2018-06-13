$PBExportHeader$w_print_view.srw
$PBExportComments$출력미리보기배율선택
forward
global type w_print_view from window
end type
type uc_print from u_picture within w_print_view
end type
type uc_close from u_picture within w_print_view
end type
type r_2 from rectangle within w_print_view
end type
type st_title from statictext within w_print_view
end type
type st_10 from statictext within w_print_view
end type
type st_9 from statictext within w_print_view
end type
type cbx_tot from checkbox within w_print_view
end type
type ddlb_way from dropdownlistbox within w_print_view
end type
type ddlb_paper from dropdownlistbox within w_print_view
end type
type print_setup from singlelineedit within w_print_view
end type
type st_6 from statictext within w_print_view
end type
type sle_rang from singlelineedit within w_print_view
end type
type dw_print from u_dw within w_print_view
end type
type hsb_1 from hscrollbar within w_print_view
end type
type hsb_2 from hscrollbar within w_print_view
end type
type st_size_rate from statictext within w_print_view
end type
type st_pre_rate from statictext within w_print_view
end type
type uc_first from uo_imgbtn within w_print_view
end type
type uc_last from uo_imgbtn within w_print_view
end type
type uc_prior from uo_imgbtn within w_print_view
end type
type uc_next from uo_imgbtn within w_print_view
end type
type uc_printersetup from uo_imgbtn within w_print_view
end type
type uc_saveas from uo_imgbtn within w_print_view
end type
type uc_preview from uo_imgbtn within w_print_view
end type
type uc_printsize from uo_imgbtn within w_print_view
end type
type st_2 from statictext within w_print_view
end type
type st_3 from statictext within w_print_view
end type
type r_5 from rectangle within w_print_view
end type
type r_6 from rectangle within w_print_view
end type
type r_1 from rectangle within w_print_view
end type
type r_7 from rectangle within w_print_view
end type
type ln_6 from line within w_print_view
end type
type r_3 from rectangle within w_print_view
end type
type ln_5 from line within w_print_view
end type
type r_4 from rectangle within w_print_view
end type
end forward

global type w_print_view from window
integer width = 4000
integer height = 2792
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 33554431
boolean center = true
event ue_postopen ( )
uc_print uc_print
uc_close uc_close
r_2 r_2
st_title st_title
st_10 st_10
st_9 st_9
cbx_tot cbx_tot
ddlb_way ddlb_way
ddlb_paper ddlb_paper
print_setup print_setup
st_6 st_6
sle_rang sle_rang
dw_print dw_print
hsb_1 hsb_1
hsb_2 hsb_2
st_size_rate st_size_rate
st_pre_rate st_pre_rate
uc_first uc_first
uc_last uc_last
uc_prior uc_prior
uc_next uc_next
uc_printersetup uc_printersetup
uc_saveas uc_saveas
uc_preview uc_preview
uc_printsize uc_printsize
st_2 st_2
st_3 st_3
r_5 r_5
r_6 r_6
r_1 r_1
r_7 r_7
ln_6 ln_6
r_3 r_3
ln_5 ln_5
r_4 r_4
end type
global w_print_view w_print_view

type variables
s_open_print	 	istr_parm
Long 				il_return

/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 멀티랭귀지 형태를 GetFullState할때 문제가 되어 copydatawindow를 사용함.
		 작업 = ib_unicode추가.
	작업자  : 송상철
====================================*/
Boolean				ib_unicode = false
//====================================
//String is_Sort, is_Sort_Order
end variables

forward prototypes
public subroutine wf_setdddw ()
end prototypes

event ue_postopen();//parameter
//key=dwtype, value=datawindow OR datastore
//key=datawindow, value = datawindow control OR datastore control
//key=modify, value = modify syntax
//key=orientation, value = datawindow object property orientation
//key=printzoom, value=print %
//key=zoom, value=priview %

Blob  lb_data
String ls_Mod
Vector		lvc_data

SetPointer(HourGlass!)

uc_close.of_enable(true)
uc_print.of_enable(true)
uc_next.of_enable(true)
uc_prior.of_enable(true)
uc_last.of_enable(true)
uc_first.of_enable(true)
uc_saveas.of_enable(true)
uc_printersetup.of_enable(true)
uc_preview.of_enable(true)
uc_printsize.of_enable(true)

lvc_data = Message.PowerObjectParm
IF Not IsValid(lvc_data) THEN return

String			  ls_temp

/*====================================
	V1.9.9 Bug Fix
	작업내용
		 현상 = 멀티랭귀지 형태를 GetFullState할때 문제가 되어 copydatawindow를 사용함.
		 작업 = ib_unicode를 true로 할때만 타게 해 놓았다.  copydatawindow 사용.
	작업자  : 송상철
====================================*/
Choose Case Lower(lvc_data.getProperty('dwtype'))
	CASE 'datawindow'
		datawindow   ldw
		ls_temp = lvc_data.getProperty('datawindow', ldw)

		dw_print.dataobject = ldw.dataobject
		
		IF ib_unicode AND appeongetclienttype() = 'WEB' THEN
			copydatawindow	= Create copydatawindow
			copydatawindow.setcopydata(ldw, dw_print)
		ELSE
			ldw.getFullState(lb_data)
			dw_print.setfullstate(lb_data)
		END IF
	CASE 'datastore'
		datastore   lds
		ls_temp = lvc_data.getProperty('datawindow', lds)
		dw_print.dataobject = lds.dataobject
		
		IF ib_unicode AND appeongetclienttype() = 'WEB' THEN
			copydatawindow	= Create copydatawindow
			copydatawindow.setcopydata(ldw, dw_print)
		ELSE
			lds.getFullState(lb_data)
			dw_print.setfullstate(lb_data)
		END IF
	CASE Else
		datawindow   lde
		ls_temp = lvc_data.getProperty('datawindow', lde)
		dw_print.dataobject = lde.dataobject
		
		IF ib_unicode AND appeongetclienttype() = 'WEB' THEN
			copydatawindow	= Create copydatawindow
			copydatawindow.setcopydata(ldw, dw_print)
		ELSE
			lde.getFullState(lb_data)
			dw_print.setfullstate(lb_data)
		END IF
END CHOOSE
//===========================================

ls_Mod = lvc_data.getProperty("modify")
ls_temp = lvc_data.getProperty("orientation")
IF Len(Trim(ls_temp)) > 0 THEN
	ls_mod += "~ndatawindow.print.Orientation ='" +  ls_temp + "'"
END IF

ls_mod += "~nDataWindow.Print.Preview.Rulers = 'Yes'"
ls_mod += "~nDataWindow.Print.Preview = 'Yes'"

ls_temp = lvc_data.getProperty("printzoom")
if isnull(ls_temp) or trim(ls_temp) = '' then 
	ls_mod += "~nDataWindow.Print.Preview.Zoom = '100' " 
else 
	hsb_2.position = integer(ls_temp) 
	uc_printsize.triggerEvent('Clicked') 
end if 

ls_temp = lvc_data.getProperty("zoom")
if isnull(ls_temp) or trim(ls_temp) = '' then 
	ls_mod += "~nDataWindow.Zoom = '100' " 
else 
	hsb_1.position = integer(ls_temp) 
	uc_preview.triggerEvent('Clicked') 
end if 
dw_print.Modify(ls_mod)

dw_print.HscrollBar = True
dw_print.VscrollBar = True

st_pre_rate.text  = string(hsb_1.position) + '%'
st_size_rate.text = string(hsb_2.position) + '%'
cbx_tot.checked = true
print_setup.text = dw_print.Describe("DataWindow.Printer") 

//****** 디자인 교체 ******//
ddlb_paper.SelectItem(1)
ddlb_way.SelectItem(3)
sle_rang.Enabled = False
st_6.TextColor = RGB(150,150,150)

SetPointer(Arrow!) 
end event

public subroutine wf_setdddw ();Long		ll_colcnt, i
String	ls_temp, ls_colname, ls_objs
DataStore				lds_temp
StringTokenizer		token
DataWindowChild	ldc_data
lds_temp	= Create DataStore

//column count를 가지고 오면 Copy한 Colum인경우 찾기 힘들다.
//그래서 Objects를 가지고 함.
ls_objs = dw_print.Object.Datawindow.Objects
token.settokenizer( ls_objs, "~t")

Do While token.hasmoretokens( )
	ls_colname 	= token.nexttoken( )
	ls_temp 		= dw_print.Describe( ls_colname + ".Type")
	IF Not (ls_temp = '?' OR ls_temp = '!' OR ls_temp = '') THEN
		IF ls_temp = 'column' THEN
			ls_temp = dw_print.Describe(ls_colname +".dddw.name")
			IF Not (ls_temp = '?' OR ls_temp = '!' OR ls_temp = '') THEN
				lds_temp.Dataobject = ls_temp
				ls_temp = lds_temp.Describe("Datawindow.table.arguments")
				IF ls_temp = '?' THEN
					IF dw_print.GetChild(ls_colname, ldc_data ) = 1 THEN 
						IF ldc_data.RowCount() = 0 THEN ldc_data.Retrieve()
					END IF
				END IF
			END IF
		END IF
	END IF
Loop
end subroutine

event resize;SetRedraw(FALSE)

//dw_print.Width = This.Width - 100
//dw_print.Height = This.Height - 350
//
dw_print.HScrollBar = TRUE
dw_print.VScrollBar = TRUE

SetRedraw(TRUE)

end event

on w_print_view.create
this.uc_print=create uc_print
this.uc_close=create uc_close
this.r_2=create r_2
this.st_title=create st_title
this.st_10=create st_10
this.st_9=create st_9
this.cbx_tot=create cbx_tot
this.ddlb_way=create ddlb_way
this.ddlb_paper=create ddlb_paper
this.print_setup=create print_setup
this.st_6=create st_6
this.sle_rang=create sle_rang
this.dw_print=create dw_print
this.hsb_1=create hsb_1
this.hsb_2=create hsb_2
this.st_size_rate=create st_size_rate
this.st_pre_rate=create st_pre_rate
this.uc_first=create uc_first
this.uc_last=create uc_last
this.uc_prior=create uc_prior
this.uc_next=create uc_next
this.uc_printersetup=create uc_printersetup
this.uc_saveas=create uc_saveas
this.uc_preview=create uc_preview
this.uc_printsize=create uc_printsize
this.st_2=create st_2
this.st_3=create st_3
this.r_5=create r_5
this.r_6=create r_6
this.r_1=create r_1
this.r_7=create r_7
this.ln_6=create ln_6
this.r_3=create r_3
this.ln_5=create ln_5
this.r_4=create r_4
this.Control[]={this.uc_print,&
this.uc_close,&
this.r_2,&
this.st_title,&
this.st_10,&
this.st_9,&
this.cbx_tot,&
this.ddlb_way,&
this.ddlb_paper,&
this.print_setup,&
this.st_6,&
this.sle_rang,&
this.dw_print,&
this.hsb_1,&
this.hsb_2,&
this.st_size_rate,&
this.st_pre_rate,&
this.uc_first,&
this.uc_last,&
this.uc_prior,&
this.uc_next,&
this.uc_printersetup,&
this.uc_saveas,&
this.uc_preview,&
this.uc_printsize,&
this.st_2,&
this.st_3,&
this.r_5,&
this.r_6,&
this.r_1,&
this.r_7,&
this.ln_6,&
this.r_3,&
this.ln_5,&
this.r_4}
end on

on w_print_view.destroy
destroy(this.uc_print)
destroy(this.uc_close)
destroy(this.r_2)
destroy(this.st_title)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.cbx_tot)
destroy(this.ddlb_way)
destroy(this.ddlb_paper)
destroy(this.print_setup)
destroy(this.st_6)
destroy(this.sle_rang)
destroy(this.dw_print)
destroy(this.hsb_1)
destroy(this.hsb_2)
destroy(this.st_size_rate)
destroy(this.st_pre_rate)
destroy(this.uc_first)
destroy(this.uc_last)
destroy(this.uc_prior)
destroy(this.uc_next)
destroy(this.uc_printersetup)
destroy(this.uc_saveas)
destroy(this.uc_preview)
destroy(this.uc_printsize)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.r_5)
destroy(this.r_6)
destroy(this.r_1)
destroy(this.r_7)
destroy(this.ln_6)
destroy(this.r_3)
destroy(this.ln_5)
destroy(this.r_4)
end on

event open;This.Post Event ue_postopen()
end event

event key;Choose Case key
	Case KeyEscape!
		uc_close.triggerEvent('Clicked')
End Choose
end event

type uc_print from u_picture within w_print_view
integer x = 3406
integer y = 36
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_print.gif"
end type

event clicked;call super::clicked;String 	lsRange
String	ls_printno

Choose Case True

	Case cbx_tot.Checked = False
		lsRange = sle_rang.Text
		dw_print.modify("datawindow.print.page.range = '"+lsRange+"'")
	CASE ELSE
		
End Choose

il_return = Dw_Print.Print()

end event

type uc_close from u_picture within w_print_view
integer x = 3689
integer y = 36
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_close.gif"
end type

event clicked;call super::clicked;If il_return = 1 Then
	CloseWithReturn( parent, 'Y' )
Else
	CloseWithReturn( parent, 'N' )
End If
end event

type r_2 from rectangle within w_print_view
long linecolor = 29595236
integer linethickness = 4
long fillcolor = 32896501
integer x = 1509
integer y = 236
integer width = 2441
integer height = 284
end type

type st_title from statictext within w_print_view
integer x = 82
integer y = 176
integer width = 251
integer height = 48
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31439244
string text = "인쇄준비"
boolean focusrectangle = false
end type

type st_10 from statictext within w_print_view
integer x = 1550
integer y = 356
integer width = 270
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
long backcolor = 33090525
boolean enabled = false
string text = "출력방향"
boolean focusrectangle = false
end type

type st_9 from statictext within w_print_view
integer x = 1550
integer y = 264
integer width = 270
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
long backcolor = 33090525
boolean enabled = false
string text = "출력용지"
boolean focusrectangle = false
end type

type cbx_tot from checkbox within w_print_view
integer x = 3191
integer y = 424
integer width = 247
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
long backcolor = 32896501
string text = "전체"
end type

event clicked;IF This.Checked THEN
	sle_rang.Enabled = False
	st_6.TextColor = RGB(150,150,150)
ELSE
	sle_rang.Enabled = True
	st_6.TextColor = RGB(0,0,0)
END IF
end event

type ddlb_way from dropdownlistbox within w_print_view
integer x = 1984
integer y = 336
integer width = 338
integer height = 284
integer taborder = 160
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
boolean vscrollbar = true
string item[] = {"Default","가로","세로"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE index
	CASE 1
		dw_print.Modify( "datawindow.print.Orientation = 1 " )
	CASE 2
		dw_print.Modify( "datawindow.print.Orientation = 2 " )
	CASE 3
		dw_print.Modify( "datawindow.print.Orientation = 0 " )
END CHOOSE
end event

type ddlb_paper from dropdownlistbox within w_print_view
integer x = 1984
integer y = 244
integer width = 338
integer height = 380
integer taborder = 150
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Default","136 Col","80 Col","A4","A5","B4","B5"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE index
	CASE 1
		dw_print.Modify( "DataWindow.Print.Paper.Size = 0 " )
	CASE 2
		dw_print.Modify( "DataWindow.Print.Paper.Size = 04 " )
	CASE 3
		dw_print.Modify( "DataWindow.Print.Paper.Size = 01 " )
	CASE 4
		dw_print.Modify( "DataWindow.Print.Paper.Size = 09 " )
	CASE 5
		dw_print.Modify( "DataWindow.Print.Paper.Size = 11 " )
	CASE 6
		dw_print.Modify( "DataWindow.Print.Paper.Size = 12 " )
	CASE 7
		dw_print.Modify( "DataWindow.Print.Paper.Size = 13 " )
END CHOOSE
end event

type print_setup from singlelineedit within w_print_view
integer x = 357
integer y = 180
integer width = 1097
integer height = 56
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 31439244
boolean border = false
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_print_view
integer x = 3195
integer y = 264
integer width = 370
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
long backcolor = 32896501
string text = "Ex) 1, 2, 3-6"
boolean focusrectangle = false
end type

type sle_rang from singlelineedit within w_print_view
integer x = 3191
integer y = 336
integer width = 526
integer height = 76
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "궁서"
long textcolor = 20724796
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_print from u_dw within w_print_view
integer x = 50
integer y = 552
integer width = 3895
integer height = 2040
integer taborder = 170
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

type hsb_1 from hscrollbar within w_print_view
event lineleft pbm_sbnlineup
event lineright pbm_sbnlinedown
event moved pbm_sbnthumbtrack
integer x = 87
integer y = 344
integer width = 832
integer height = 68
boolean bringtotop = true
integer minposition = 10
integer maxposition = 200
integer position = 100
end type

event lineleft;this.position -= 1
st_pre_rate.text = string(this.position) + '%'
end event

event lineright;this.position += 1
st_pre_rate.text = string(this.position) + '%'
end event

event moved;st_pre_rate.text = string(this.position) + '%'
end event

type hsb_2 from hscrollbar within w_print_view
event lineleft pbm_sbnlineup
event lineright pbm_sbnlinedown
event moved pbm_sbnthumbtrack
integer x = 87
integer y = 436
integer width = 832
integer height = 68
boolean bringtotop = true
integer minposition = 1
integer maxposition = 300
integer position = 100
end type

event lineleft;this.position -= 1
st_size_rate.text = string(this.position) + '%'
end event

event lineright;this.position += 1
st_size_rate.text = string(this.position) + '%'
end event

event moved;st_size_rate.text = string(this.position) + '%'
end event

type st_size_rate from statictext within w_print_view
integer x = 955
integer y = 444
integer width = 114
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "궁서"
long textcolor = 20724796
long backcolor = 32896501
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_pre_rate from statictext within w_print_view
integer x = 955
integer y = 356
integer width = 114
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "궁서"
long textcolor = 20724796
long backcolor = 32896501
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type uc_first from uo_imgbtn within w_print_view
integer x = 46
integer y = 32
integer width = 283
integer taborder = 20
boolean bringtotop = true
string btnname = "  처음  "
end type

on uc_first.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;dw_print.ScrollToRow(1)
end event

type uc_last from uo_imgbtn within w_print_view
integer x = 347
integer y = 36
integer width = 283
integer taborder = 30
boolean bringtotop = true
string btnname = "    끝    "
end type

on uc_last.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;dw_print.ScrollToRow( dw_print.RowCount() )
end event

type uc_prior from uo_imgbtn within w_print_view
integer x = 649
integer y = 36
integer width = 283
integer taborder = 40
boolean bringtotop = true
string btnname = "  이전  "
end type

on uc_prior.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;IF dw_print.ScrollpriorPage() = -1 THEN
   BEEP(3)
END IF
end event

type uc_next from uo_imgbtn within w_print_view
integer x = 946
integer y = 36
integer width = 283
integer taborder = 50
boolean bringtotop = true
string btnname = "  이후  "
end type

on uc_next.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;IF dw_print.ScrollNextPage()= -1 THEN
   BEEP(3)
END IF
end event

type uc_printersetup from uo_imgbtn within w_print_view
integer x = 87
integer y = 248
integer width = 622
integer height = 84
integer taborder = 70
boolean bringtotop = true
string btnname = "    Printer Setup    "
end type

on uc_printersetup.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;printsetup()
print_setup.text = dw_print.Describe("DataWindow.Printer")
end event

type uc_saveas from uo_imgbtn within w_print_view
integer x = 786
integer y = 244
integer width = 622
integer height = 84
integer taborder = 80
boolean bringtotop = true
string btnname = "         Save As         "
end type

on uc_saveas.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;u_svc_saveas		luo_save
luo_save.of_saveas( dw_print, true)

end event

type uc_preview from uo_imgbtn within w_print_view
integer x = 1097
integer y = 336
integer width = 311
integer height = 84
integer taborder = 60
boolean bringtotop = true
string btnname = "미리보기"
end type

on uc_preview.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;dw_print.Modify("DataWindow.Print.Preview.Zoom = "  + string(hsb_1.position))
end event

type uc_printsize from uo_imgbtn within w_print_view
integer x = 1097
integer y = 432
integer width = 311
integer height = 84
integer taborder = 70
boolean bringtotop = true
string btnname = "출력크기"
end type

on uc_printsize.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;dw_print.Modify("DataWindow.Zoom = "  + String(hsb_2.position) )
end event

type st_2 from statictext within w_print_view
integer x = 1550
integer y = 176
integer width = 951
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31439244
string text = "인쇄옵션 및 범위"
boolean focusrectangle = false
end type

type st_3 from statictext within w_print_view
integer x = 2789
integer y = 264
integer width = 270
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
long backcolor = 33090525
boolean enabled = false
string text = "인쇄범위"
boolean focusrectangle = false
end type

type r_5 from rectangle within w_print_view
long linecolor = 29595236
integer linethickness = 4
long fillcolor = 31439244
integer x = 46
integer y = 160
integer width = 1426
integer height = 80
end type

type r_6 from rectangle within w_print_view
long linecolor = 29595236
integer linethickness = 4
long fillcolor = 32896501
integer x = 46
integer y = 236
integer width = 1426
integer height = 284
end type

type r_1 from rectangle within w_print_view
long linecolor = 29595236
integer linethickness = 4
long fillcolor = 31439244
integer x = 1509
integer y = 160
integer width = 2441
integer height = 80
end type

type r_7 from rectangle within w_print_view
long linecolor = 33090525
integer linethickness = 4
long fillcolor = 33090525
integer x = 1513
integer y = 240
integer width = 425
integer height = 276
end type

type ln_6 from line within w_print_view
long linecolor = 29935816
integer linethickness = 4
integer beginx = 1513
integer beginy = 420
integer endx = 2715
integer endy = 420
end type

type r_3 from rectangle within w_print_view
long linecolor = 33090525
integer linethickness = 4
long fillcolor = 33090525
integer x = 2715
integer y = 240
integer width = 425
integer height = 276
end type

type ln_5 from line within w_print_view
long linecolor = 29935816
integer linethickness = 4
integer beginx = 1513
integer beginy = 328
integer endx = 2715
integer endy = 328
end type

type r_4 from rectangle within w_print_view
long linecolor = 29595236
integer linethickness = 4
long fillcolor = 33554431
integer x = 46
integer y = 548
integer width = 3904
integer height = 2048
end type

