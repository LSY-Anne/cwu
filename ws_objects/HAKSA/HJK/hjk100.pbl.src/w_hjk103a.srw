$PBExportHeader$w_hjk103a.srw
$PBExportComments$[청운대]사진일괄입력관리
forward
global type w_hjk103a from w_condition_window
end type
type dw_1 from uo_search_dwc within w_hjk103a
end type
type p_1 from picture within w_hjk103a
end type
type st_sangtae from statictext within w_hjk103a
end type
type uo_progressbar1 from u_progress_bar within w_hjk103a
end type
type st_row from statictext within w_hjk103a
end type
type st_3 from statictext within w_hjk103a
end type
type st_4 from statictext within w_hjk103a
end type
type st_5 from statictext within w_hjk103a
end type
type dw_con from uo_dwfree within w_hjk103a
end type
type uo_1 from uo_imgbtn within w_hjk103a
end type
end forward

global type w_hjk103a from w_condition_window
dw_1 dw_1
p_1 p_1
st_sangtae st_sangtae
uo_progressbar1 uo_progressbar1
st_row st_row
st_3 st_3
st_4 st_4
st_5 st_5
dw_con dw_con
uo_1 uo_1
end type
global w_hjk103a w_hjk103a

type variables
string is_hakbun
end variables

on w_hjk103a.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.p_1=create p_1
this.st_sangtae=create st_sangtae
this.uo_progressbar1=create uo_progressbar1
this.st_row=create st_row
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.st_sangtae
this.Control[iCurrent+4]=this.uo_progressbar1
this.Control[iCurrent+5]=this.st_row
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.dw_con
this.Control[iCurrent+10]=this.uo_1
end on

on w_hjk103a.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.p_1)
destroy(this.st_sangtae)
destroy(this.uo_progressbar1)
destroy(this.st_row)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_hakgwa

dw_con.AcceptText()

ls_hakgwa = func.of_nvl(dw_con.Object.gwa[1], '%')

dw_1.retrieve(ls_hakgwa)

uo_1.enabled = true

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk103a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk103a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk103a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk103a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk103a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk103a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk103a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk103a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk103a
end type

type uc_save from w_condition_window`uc_save within w_hjk103a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk103a
end type

type uc_print from w_condition_window`uc_print within w_hjk103a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk103a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk103a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk103a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk103a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk103a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk103a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk103a
end type

type dw_1 from uo_search_dwc within w_hjk103a
integer x = 50
integer y = 388
integer width = 1339
integer height = 1876
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk103a_1"
boolean border = true
end type

event constructor;this.settransobject(sqlca)

end event

type p_1 from picture within w_hjk103a
integer x = 2405
integer y = 848
integer width = 576
integer height = 604
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type st_sangtae from statictext within w_hjk103a
integer x = 1723
integer y = 1896
integer width = 2011
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 15780518
boolean focusrectangle = false
end type

type uo_progressbar1 from u_progress_bar within w_hjk103a
integer x = 2075
integer y = 1676
integer taborder = 30
boolean bringtotop = true
end type

on uo_progressbar1.destroy
call u_progress_bar::destroy
end on

type st_row from statictext within w_hjk103a
integer x = 3077
integer y = 856
integer width = 539
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 15780518
boolean focusrectangle = false
end type

type st_3 from statictext within w_hjk103a
integer x = 50
integer y = 296
integer width = 1339
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 15793151
long backcolor = 8388736
string text = "사진입력대상자"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_hjk103a
integer x = 1632
integer y = 340
integer width = 2075
integer height = 144
boolean bringtotop = true
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 32768
long backcolor = 80269524
string text = "학과별 일괄사진 입력 "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_hjk103a
integer x = 1737
integer y = 520
integer width = 1861
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32896
long backcolor = 80269524
string text = "학과별 조회로 검색후 일괄입력을 할 수 있습니다."
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hjk103a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hjk103a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
This.InsertRow(0)
end event

type uo_1 from uo_imgbtn within w_hjk103a
event destroy ( )
integer x = 393
integer y = 40
integer width = 530
integer height = 92
integer taborder = 30
boolean bringtotop = true
string btnname = "사진일괄입력"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event dragdrop;call super::dragdrop;String ls_gwa

dw_con.Accepttext()

ls_gwa = dw_con.Object.gwa[1]
if Isnull(ls_gwa) Or ls_gwa = '' then
	messagebox("확인","학과를 먼저 선택하세요")
end if

SetPointer(HourGlass!)
blob b_total_pic1	
int  li_count, li_ans
string ls_hakbun,ls_doc_name,ls_dir_name

int    fh, ret, li_ans1, ll_loops, ll_count
blob   b_emp_pic, b_total_pic
string ls_txtname, ls_named
string ls_defext = "JPG"
string ls_filter = "bitmap Files (*.bmp), *.bmp, Jpg Files (*.jpg),*.jpg "
long   ll_filelength, ll_bytes
ulong  lul_nbr
int li_inwon, li_length,i,li_row_count=0

          dw_1.settransobject(sqlca)
          li_inwon= dw_1.rowcount()
	       ret = GetFileOpenName("Open BMP,JPG", ls_dir_name, ls_named, ls_defext, ls_filter)
          //ls_dir_name에 사진이 들어있는 폴더를 사용자로 하여금 입력받음
IF ret = 1 THEN
	
	//ls_dir_name의 길이를 구함(예,  c:/mydoc/12345678.JPG  이면 21자리)
	li_length = len(ls_dir_name)
	
	//학번.JPG 가 12자리 이므로
	li_length = li_length - 12
	
	//ls_dir_name은  c:/mydoc/  가 됨
	ls_dir_name = mid(ls_dir_name,1,li_length)	
	uo_progressbar1.visible = TRUE
	uo_progressbar1.uf_init(li_inwon)
				
	for i = 1 to li_inwon 
	   setpointer(hourglass!)	
	
		 ls_hakbun = dw_1.object.hakbun[i]
		 ls_doc_name = ls_dir_name+ls_hakbun+'.jpg'	
       //ls_doc_name은  c:/mydoc/바뀌는 학번.jpg가 됨
      
       //학번이 바뀜에 따라 같은 폴더에서 학번에 맞는 사진을 읽어온다.		
		fh=FileOpen(ls_doc_name, StreamMode!,read!,lockreadwrite!)
		FileClose(fh)
		
		 // 화일open
		 
		 IF fh <> -1 THEN// 화일 open 성공 7
						ll_filelength = filelength(ls_doc_name)
					
				fh = FileOpen(ls_doc_name, StreamMode!,read!,lockreadwrite!)	
				
						if ll_filelength > 32765 then// 6
							if mod(ll_filelength,32765) = 0 then// 5
								ll_loops = ll_filelength/32765
							else
								ll_loops = (ll_filelength/32765) + 1
							end if// 5
						else
							ll_loops = 1
						end if// 6
			        
						for ll_count = 1 to ll_loops
							ll_bytes = FileRead(fh, b_emp_pic)
                      
							b_total_pic = b_total_pic + b_emp_pic
						next
		 
 

		p_1.setpicture(b_total_pic)////////
					    INSERT INTO HAKSA.PHOTO  
        					          ( HAKBUN, P_IMAGE )  
  					      	VALUES ( :ls_hakbun, null )  ;
								  
				       if sqlca.sqlcode = 0 then	
							
						    UPDATEBLOB HAKSA.PHOTO
						    SET P_IMAGE = :b_total_pic
						    WHERE hakbun = :ls_hakbun ;	
							 
				          if sqlca.sqlcode = 0 then	
						       commit;
                     
             	          st_sangtae.text = "   "+ ls_hakbun+"학생의 사진을 입력중입니다."	
                        dw_1.scrolltorow(li_row_count)
							
								 li_row_count = li_row_count +1				

			                uo_progressbar1.uf_set_position(li_row_count)
			             else
			                rollback;
                         //			uf_messagebox(3)
			             end if			
		             else
				          messagebox("확인","학번 INSERT 실패")///////////////////////////
		             end if
           FileClose(fh)
					 st_row.text= string(li_row_count) + '/'+string(li_inwon) + "  명"
	     END IF// 화일open end
//				 setnull(b_total_pic)
				 b_total_pic = blob('')
				 ls_doc_name = ''
       next
	ELSE
			messagebox("확인","화일을 여는데 실패했습니다.")
   END IF// 사진입력 시작 end	
		st_sangtae.text ="   "+string(li_row_count)+"명의 사진 입력으로 모든 JPG화일이 입력되었습니다."
	
     //////////////////////////////////////////////////////////////////////////////////////////////////
end event

