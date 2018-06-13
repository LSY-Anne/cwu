$PBExportHeader$w_hgm502p.srw
forward
global type w_hgm502p from w_msheet
end type
type dw_print from cuo_dwwindow_one_hin within w_hgm502p
end type
type dw_gwa_code from datawindow within w_hgm502p
end type
type st_2 from statictext within w_hgm502p
end type
type em_to_date from editmask within w_hgm502p
end type
type sle_ord_numto from singlelineedit within w_hgm502p
end type
type st_3 from statictext within w_hgm502p
end type
type em_fr_date from editmask within w_hgm502p
end type
type sle_ord_numfr from singlelineedit within w_hgm502p
end type
type st_1 from statictext within w_hgm502p
end type
type gb_1 from groupbox within w_hgm502p
end type
end forward

global type w_hgm502p from w_msheet
integer height = 2616
dw_print dw_print
dw_gwa_code dw_gwa_code
st_2 st_2
em_to_date em_to_date
sle_ord_numto sle_ord_numto
st_3 st_3
em_fr_date em_fr_date
sle_ord_numfr sle_ord_numfr
st_1 st_1
gb_1 gb_1
end type
global w_hgm502p w_hgm502p

on w_hgm502p.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.dw_gwa_code=create dw_gwa_code
this.st_2=create st_2
this.em_to_date=create em_to_date
this.sle_ord_numto=create sle_ord_numto
this.st_3=create st_3
this.em_fr_date=create em_fr_date
this.sle_ord_numfr=create sle_ord_numfr
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.dw_gwa_code
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_to_date
this.Control[iCurrent+5]=this.sle_ord_numto
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.em_fr_date
this.Control[iCurrent+8]=this.sle_ord_numfr
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.gb_1
end on

on w_hgm502p.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.dw_gwa_code)
destroy(this.st_2)
destroy(this.em_to_date)
destroy(this.sle_ord_numto)
destroy(this.st_3)
destroy(this.em_fr_date)
destroy(this.sle_ord_numfr)
destroy(this.st_1)
destroy(this.gb_1)
end on

event ue_open;call super::ue_open;sle_ord_numfr.text = '20030001'
sle_ord_numto.text = '20030100'
em_fr_date.text  = left(f_today(),6) + '01'
em_to_date.text  = f_today()

f_childretrieven(dw_gwa_code,"code")           // 부서
dw_print.Object.DataWindow.print.preview = 'YES'
end event

event ue_retrieve;call super::ue_retrieve;     string  ls_ord_numfr, ls_ord_numto, ls_gwa_code, ls_fr_date, ls_to_date
	  Long   ll_rowcnt
	    ls_ord_numfr  = sle_ord_numfr.text 
		 ls_ord_numto  = sle_ord_numto.text 
		 ls_gwa_code = trim(dw_gwa_code.Object.code[1]) 
		 ls_fr_date  = left(em_fr_date.text,4)+mid(em_fr_date.text,6,2)+ &
		               right(em_fr_date.text,2)
		 ls_to_date  = left(em_to_date.text,4)+mid(em_to_date.text,6,2)+ &
		               right(em_to_date.text,2)
		 
		 IF isnull(ls_gwa_code) OR ls_gwa_code = '' THEN
			 ls_gwa_code = '%'
		 ELSE
			 ls_gwa_code = trim(dw_gwa_code.Object.code[1]) 
		 END IF 
		 
		 ll_RowCnt = dw_print.retrieve(ls_ord_numfr, ls_ord_numto, ls_fr_date, ls_to_Date, ls_gwa_code)
//		 	 FOR idx = ll_RowCnt  TO 24
//				  tab_sheet.tabpage_1.dw_print.insertRow(0)
//			 NEXT
		 IF ll_RowCnt = 0 THEN
			 wf_SetMsg('조회된 자료가없습니다..!')
//			 wf_Setmenu('R',TRUE)
		 ELSE
			 wf_SetMsg('자료가 조회되었습니다..!')
//			 wf_Setmenu('R',TRUE)
//			 wf_Setmenu('p',TRUE)
		 END IF
		 return 1
end event

event ue_print;call super::ue_print;f_print(dw_print)
end event

type ln_templeft from w_msheet`ln_templeft within w_hgm502p
end type

type ln_tempright from w_msheet`ln_tempright within w_hgm502p
end type

type ln_temptop from w_msheet`ln_temptop within w_hgm502p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hgm502p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hgm502p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hgm502p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hgm502p
end type

type uc_insert from w_msheet`uc_insert within w_hgm502p
end type

type uc_delete from w_msheet`uc_delete within w_hgm502p
end type

type uc_save from w_msheet`uc_save within w_hgm502p
end type

type uc_excel from w_msheet`uc_excel within w_hgm502p
end type

type uc_print from w_msheet`uc_print within w_hgm502p
end type

type st_line1 from w_msheet`st_line1 within w_hgm502p
end type

type st_line2 from w_msheet`st_line2 within w_hgm502p
end type

type st_line3 from w_msheet`st_line3 within w_hgm502p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hgm502p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hgm502p
end type

type dw_print from cuo_dwwindow_one_hin within w_hgm502p
integer x = 32
integer y = 276
integer width = 3817
integer height = 2208
integer taborder = 60
string dataobject = "d_hgm502i_6"
end type

type dw_gwa_code from datawindow within w_hgm502p
integer x = 2322
integer y = 96
integer width = 901
integer height = 104
integer taborder = 20
string dataobject = "d_hgm201i_7"
boolean border = false
boolean livescroll = true
end type

type st_2 from statictext within w_hgm502p
integer x = 2190
integer y = 120
integer width = 178
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "부서"
boolean focusrectangle = false
end type

type em_to_date from editmask within w_hgm502p
integer x = 1669
integer y = 100
integer width = 393
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type sle_ord_numto from singlelineedit within w_hgm502p
integer x = 1371
integer y = 100
integer width = 293
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_hgm502p
integer x = 1307
integer y = 96
integer width = 64
integer height = 84
integer textsize = -18
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "~~"
boolean focusrectangle = false
end type

type em_fr_date from editmask within w_hgm502p
integer x = 905
integer y = 100
integer width = 393
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type sle_ord_numfr from singlelineedit within w_hgm502p
integer x = 608
integer y = 100
integer width = 293
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_hgm502p
integer x = 155
integer y = 128
integer width = 558
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "발주/입고일자"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hgm502p
integer x = 32
integer y = 12
integer width = 3817
integer height = 248
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회조건"
end type

