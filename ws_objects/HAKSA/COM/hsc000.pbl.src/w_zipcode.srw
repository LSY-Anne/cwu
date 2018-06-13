$PBExportHeader$w_zipcode.srw
$PBExportComments$[청운대]주소검색Window
forward
global type w_zipcode from w_popup
end type
type st_1 from statictext within w_zipcode
end type
type sle_dong from uo_sle within w_zipcode
end type
type dw_search from uo_dwfree within w_zipcode
end type
end forward

global type w_zipcode from w_popup
integer width = 2871
integer height = 1652
string title = "우편번호"
st_1 st_1
sle_dong sle_dong
dw_search dw_search
end type
global w_zipcode w_zipcode

on w_zipcode.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_dong=create sle_dong
this.dw_search=create dw_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_dong
this.Control[iCurrent+3]=this.dw_search
end on

on w_zipcode.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_dong)
destroy(this.dw_search)
end on

event ue_inquiry;call super::ue_inquiry;string	ls_dong
integer 	li_row = 0

ls_dong	= trim(sle_dong.text)

if len(ls_dong) = 0 then
	messagebox("확인", "동이름을 입력하세요!", Information!)
	sle_dong.setfocus()
	return -1
end if

li_row = dw_search.retrieve(ls_dong+'%')

if li_row < 1 then 
	li_row = 0
end if
st_msg.text = string(li_row) + '건 조회되었습니다.'

end event

event ue_ok;call super::ue_ok;long		i
string	    ls_zip_code, &
			ls_zip_name, ls_zip_name01

i = dw_search.getrow()

if i > 0 then

	ls_zip_code     = dw_search.object.zip_id[i]
	ls_zip_name    = func.of_nvl(dw_search.object.com_zipname[i], ' ')
	ls_zip_name01 = func.of_nvl(dw_search.object.zip_name4[i], ' ')

	closewithreturn(This, ls_zip_code + ls_zip_name + ' ' + ls_zip_name01 + ' ' )
else
	close(This) 
end if
end event

type p_msg from w_popup`p_msg within w_zipcode
end type

type st_msg from w_popup`st_msg within w_zipcode
integer width = 2656
end type

type uc_printpreview from w_popup`uc_printpreview within w_zipcode
end type

type uc_cancel from w_popup`uc_cancel within w_zipcode
end type

type uc_ok from w_popup`uc_ok within w_zipcode
end type

type uc_excelroad from w_popup`uc_excelroad within w_zipcode
end type

type uc_excel from w_popup`uc_excel within w_zipcode
end type

type uc_save from w_popup`uc_save within w_zipcode
end type

type uc_delete from w_popup`uc_delete within w_zipcode
end type

type uc_insert from w_popup`uc_insert within w_zipcode
end type

type uc_retrieve from w_popup`uc_retrieve within w_zipcode
end type

type ln_temptop from w_popup`ln_temptop within w_zipcode
integer endx = 2862
end type

type ln_1 from w_popup`ln_1 within w_zipcode
integer endx = 2862
end type

type ln_2 from w_popup`ln_2 within w_zipcode
end type

type ln_3 from w_popup`ln_3 within w_zipcode
integer beginx = 2807
integer endx = 2807
end type

type r_backline1 from w_popup`r_backline1 within w_zipcode
end type

type r_backline2 from w_popup`r_backline2 within w_zipcode
end type

type r_backline3 from w_popup`r_backline3 within w_zipcode
end type

type uc_print from w_popup`uc_print within w_zipcode
end type

type st_1 from statictext within w_zipcode
integer x = 69
integer y = 56
integer width = 210
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "주소"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_dong from uo_sle within w_zipcode
integer x = 297
integer y = 52
integer width = 946
integer height = 72
integer taborder = 10
integer textsize = -9
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

event modified;//override
Parent.TriggerEvent("ue_inquiry")
end event

type dw_search from uo_dwfree within w_zipcode
integer x = 50
integer y = 176
integer width = 2752
integer height = 1264
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_zipcode"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

event doubleclicked;call super::doubleclicked;//override
long i
string ls_zip_code, ls_zip_name, ls_zip_name01

i = dw_search.getrow()

if i > 0 then
	ls_zip_code = dw_search.object.zip_id[i]
	ls_zip_name = func.of_nvl(dw_search.object.com_zipname[i], ' ')
	ls_zip_name01 = func.of_nvl(dw_search.object.zip_name4[i], ' ')

	closewithreturn(parent, ls_zip_code + ls_zip_name + ' ' + ls_zip_name01 + ' ' )
else
	messagebox('확인', "동을 다시입력하여주세요")
	return 0
	sle_dong.setfocus()
end if
end event

