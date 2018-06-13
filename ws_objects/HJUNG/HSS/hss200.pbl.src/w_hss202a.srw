$PBExportHeader$w_hss202a.srw
$PBExportComments$건물명부
forward
global type w_hss202a from w_msheet
end type
type tab_1 from tab within w_hss202a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_list from uo_dwgrid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_list dw_list
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hss202a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type st_1 from statictext within w_hss202a
end type
type dw_2 from datawindow within w_hss202a
end type
type uo_1 from u_tab within w_hss202a
end type
type gb_1 from groupbox within w_hss202a
end type
end forward

global type w_hss202a from w_msheet
integer height = 2616
string title = "건물명부"
tab_1 tab_1
st_1 st_1
dw_2 dw_2
uo_1 uo_1
gb_1 gb_1
end type
global w_hss202a w_hss202a

type variables
long ii_width, ii_height

//datawindowchild idw_build

date id_fdate, id_tdate

string is_name, is_year
end variables

on w_hss202a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_1=create st_1
this.dw_2=create dw_2
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_hss202a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event resize;call super::resize;//tab_1.tabpage_1.dw_list.resize(this.width - ii_width, this.height - ii_height)
end event

event ue_print;call super::ue_print;
//f_print(tab_1.tabpage_2.dw_print)


	


end event

event ue_init;call super::ue_init;//dw_2.reset()
//dw_2.insertrow(0)

//is_name = '%'
//is_year = '%'

tab_1.tabpage_1.dw_list.reset()
//em_1.text = left(f_today(),4)
//
this.postevent('ue_retrieve')
end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_open
//	기 능 설 명: 초기화 처리
//	작성/수정자: 박매영
//	작성/수정일: 2002.00.00
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 건물명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
dw_2.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('공통코드[건물]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
else
	ldwc_temp.insertrow(1)
	ldwc_temp.setitem(1, 'buil_no', 		'')
	ldwc_temp.setitem(1, 'buil_name', 	'전체')
END IF

dw_2.InsertRow(0)
dw_2.Object.code.dddw.PercentWidth = 100

//wf_setMenu('R',TRUE)



tab_1.tabpage_1.dw_list.settransobject(sqlca)
dw_2.settransobject(sqlca)

tab_1.tabpage_2.dw_print.Object.DataWindow.print.preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print
this.postevent('ue_init')

end event

event ue_retrieve;call super::ue_retrieve;string ls_mes, ls_mes1, ls_mes2

long ll_RowCnt
tab_1.tabpage_1.dw_list.setredraw(false)

ll_RowCnt = tab_1.tabpage_1.dw_list.retrieve(is_name)

tab_1.tabpage_1.dw_list.setredraw(true)

tab_1.tabpage_2.dw_print.setredraw(false)

ll_RowCnt = tab_1.tabpage_2.dw_print.retrieve(is_name)

tab_1.tabpage_2.dw_print.setredraw(true)

IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('R',TRUE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('R',TRUE)
//	wf_SetMenu('p',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
END IF
return 1

end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then RETURN -1
avc_data.SetProperty('title', "건물명부")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hss202a
end type

type ln_tempright from w_msheet`ln_tempright within w_hss202a
end type

type ln_temptop from w_msheet`ln_temptop within w_hss202a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hss202a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hss202a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hss202a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hss202a
end type

type uc_insert from w_msheet`uc_insert within w_hss202a
end type

type uc_delete from w_msheet`uc_delete within w_hss202a
end type

type uc_save from w_msheet`uc_save within w_hss202a
end type

type uc_excel from w_msheet`uc_excel within w_hss202a
end type

type uc_print from w_msheet`uc_print within w_hss202a
end type

type st_line1 from w_msheet`st_line1 within w_hss202a
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hss202a
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hss202a
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hss202a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hss202a
end type

type tab_1 from tab within w_hss202a
integer x = 50
integer y = 384
integer width = 4384
integer height = 1908
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1788
string text = "건물명부"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list dw_list
end type

on tabpage_1.create
this.dw_list=create dw_list
this.Control[]={this.dw_list}
end on

on tabpage_1.destroy
destroy(this.dw_list)
end on

type dw_list from uo_dwgrid within tabpage_1
integer y = 12
integer width = 4343
integer height = 1776
integer taborder = 20
string dataobject = "d_hss202a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1788
string text = "건물명부 출력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from datawindow within tabpage_2
integer width = 4343
integer height = 1784
integer taborder = 70
string title = "none"
string dataobject = "d_hss202a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type st_1 from statictext within w_hss202a
integer x = 183
integer y = 228
integer width = 274
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "건물명"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_hss202a
integer x = 457
integer y = 204
integer width = 704
integer height = 88
integer taborder = 10
boolean bringtotop = true
string dataobject = "ddw_build"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//if dwo.name = "build" then
//	is_name = data
//end if

is_name = data
end event

type uo_1 from u_tab within w_hss202a
integer x = 1358
integer y = 356
integer height = 148
integer taborder = 60
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type gb_1 from groupbox within w_hss202a
integer x = 50
integer y = 124
integer width = 4384
integer height = 228
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

