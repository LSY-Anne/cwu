$PBExportHeader$w_printoption.srw
$PBExportComments$출력 원도우
forward
global type w_printoption from window
end type
type rb_file from radiobutton within w_printoption
end type
type st_3 from statictext within w_printoption
end type
type em_topage from editmask within w_printoption
end type
type em_frompage from editmask within w_printoption
end type
type rb_range from radiobutton within w_printoption
end type
type rb_all from radiobutton within w_printoption
end type
type em_copies from editmask within w_printoption
end type
type st_2 from statictext within w_printoption
end type
type st_1 from statictext within w_printoption
end type
type cb_setup from commandbutton within w_printoption
end type
type cb_cancel from commandbutton within w_printoption
end type
type cb_ok from commandbutton within w_printoption
end type
end forward

global type w_printoption from window
integer x = 951
integer y = 828
integer width = 1797
integer height = 632
boolean titlebar = true
string title = "인 쇄"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
rb_file rb_file
st_3 st_3
em_topage em_topage
em_frompage em_frompage
rb_range rb_range
rb_all rb_all
em_copies em_copies
st_2 st_2
st_1 st_1
cb_setup cb_setup
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_printoption w_printoption

type variables
datawindow idw_DwName
string is_row, is_page, is_preview
end variables

on w_printoption.create
this.rb_file=create rb_file
this.st_3=create st_3
this.em_topage=create em_topage
this.em_frompage=create em_frompage
this.rb_range=create rb_range
this.rb_all=create rb_all
this.em_copies=create em_copies
this.st_2=create st_2
this.st_1=create st_1
this.cb_setup=create cb_setup
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.rb_file,&
this.st_3,&
this.em_topage,&
this.em_frompage,&
this.rb_range,&
this.rb_all,&
this.em_copies,&
this.st_2,&
this.st_1,&
this.cb_setup,&
this.cb_cancel,&
this.cb_ok}
end on

on w_printoption.destroy
destroy(this.rb_file)
destroy(this.st_3)
destroy(this.em_topage)
destroy(this.em_frompage)
destroy(this.rb_range)
destroy(this.rb_all)
destroy(this.em_copies)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_setup)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;String s_copy,s_page
int    i_page

idw_dwName = Message.PowerObjectParm
this.title = '프린트 : ' + idw_dwName.describe('datawindow.printer')
//is_row     = string(idw_dwname.getrow())
//s_page    =  idw_dwname.Describe("Datawindow.Page")
is_row = idw_dwname.describe("datawindow.FirstRowOnPage")
s_page    = idw_dwname.Describe("evaluate('Page()'," + is_row + ")")
s_copy     = trim(idw_dwname.tag)
IF isNull(s_copy) or Len(s_copy) < 1 then 
	s_copy = '1'
else
end IF
//ls_first = dw_1.Object.DataWindow.FirstRowOnPage
//ls_last = dw_1.Object.DataWindow.LastRowOnPaged

em_copies.text     = s_copy
em_frompage.minmax = "1~~9999"
em_topage.minmax   = "1~~9999"

em_frompage.text = s_page 
em_topage.text   = s_page 
end event

type rb_file from radiobutton within w_printoption
integer x = 379
integer y = 404
integer width = 352
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "엑셀화일"
end type

event clicked;is_row = string(idw_dwname.getrow())
is_page = idw_dwname.Describe("evaluate('Page()'," + is_row + ")")

em_frompage.text = is_page
em_topage.text = is_page
em_frompage.enabled = true
em_topage.enabled = true

em_frompage.SetFocus()
end event

type st_3 from statictext within w_printoption
integer x = 923
integer y = 288
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "∼"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_topage from editmask within w_printoption
integer x = 1015
integer y = 276
integer width = 247
integer height = 84
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 33554431
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "1~~999"
end type

type em_frompage from editmask within w_printoption
integer x = 667
integer y = 276
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
double increment = 1
string minmax = "1~~999"
end type

type rb_range from radiobutton within w_printoption
integer x = 379
integer y = 280
integer width = 256
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "일 부"
end type

event clicked;is_row = string(idw_dwname.getrow())
is_page = idw_dwname.Describe("evaluate('Page()'," + is_row + ")")

em_frompage.enabled = true
em_topage.enabled = true

em_frompage.SetFocus()
end event

type rb_all from radiobutton within w_printoption
integer x = 379
integer y = 168
integer width = 256
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "전 체"
boolean checked = true
end type

event clicked;em_frompage.enabled = false
em_topage.enabled = false
end event

type em_copies from editmask within w_printoption
integer x = 375
integer y = 32
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean autoskip = true
boolean spin = true
string displaydata = "~t/"
string minmax = "1~~999"
end type

type st_2 from statictext within w_printoption
integer x = 37
integer y = 172
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "인쇄 범위"
boolean focusrectangle = false
end type

type st_1 from statictext within w_printoption
integer x = 37
integer y = 48
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "인쇄 매수"
boolean focusrectangle = false
end type

type cb_setup from commandbutton within w_printoption
integer x = 1385
integer y = 368
integer width = 352
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "설정..."
end type

event clicked;This.Enabled = False
printsetup()
parent.title = '프린트 : ' + idw_dwName.describe('datawindow.printer')
This.Enabled = True
end event

type cb_cancel from commandbutton within w_printoption
integer x = 1385
integer y = 208
integer width = 352
integer height = 104
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취  소"
end type

event clicked;This.Enabled = False
close(PARENT)
end event

type cb_ok from commandbutton within w_printoption
integer x = 1385
integer y = 44
integer width = 352
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확  인"
boolean default = true
end type

event clicked;string ls_copies, ls_range,s_docname, s_named,s_excel,s_filename,s_text
int    i_value
OleObject ole_object

this.Enabled            = False
cb_cancel.Enabled       = False
cb_setup.Enabled        = False

IF rb_file.checked THEN
//   i_value = GetFileSaveName("Select File", s_docname, s_named, "XLS",  "Excel Files (*.XLS),*.XLS")
//	IF i_value > 0 THEN
//   	idw_dwname.SaveAs(s_docname,Excel5! ,true)
//	END IF	
	i_value = GetFileSaveName( "File Save", s_excel, s_filename , "XLS", " Excel Files (*.XLS), *.XLS," + " All Files (*.*),*.*" ) 
	CHOOSE CASE i_value 
		CASE 1 
		  s_text = Mid(s_excel,1,Pos(s_excel,'.',1)) + 'TXT' 
		  idw_dwname.SaveAsAscii(s_text)    

		  ole_object = Create OleObject 
		  i_value = ole_object.ConnectToNewObject("excel.application") 

		  IF i_value <> 0 THEN 
		     MessageBox( "확인" , 'Excel Object 생성시 오류가 발생했습니다.' + string(i_value) ) 
		     DESTROY ole_object 
		     RETURN 
		  END IF

		  ole_object.WorkBooks.Open(s_text) 
		  ole_object.application.workbooks(1).saveas(s_excel, -4143) 
		  ole_object.Application.Quit 
		  ole_object.DisConnectObject() 
		  DESTROY ole_object
		CASE 0 
		  RETURN 
		CASE ELSE 
		  MessageBox("확인","GetFileSaveName 작업시 오류발생" +":"+ string(i_value))
		
		  RETURN 
	END CHOOSE 
ELSE
   if trim(em_copies.text) = "" then em_copies.text = "1"

   if rb_all.checked then
	   ls_range = ""
   else
	   ls_range = em_frompage.text + "-" + em_topage.text
   end if

   idw_dwname.Modify("DataWindow.Print.copies     = '" + em_copies.text + "'") //인쇄매수지정
   idw_dwname.Modify("DataWindow.Print.Page.Range = '" + ls_range + "'")       //인쇄범위지정
   idw_dwname.print(false)
END IF
close(parent)
end event

