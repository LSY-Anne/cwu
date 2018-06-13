$PBExportHeader$w_hgm301i.srw
$PBExportComments$물품 접수(주관접수)
forward
global type w_hgm301i from w_tabsheet
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type dw_update1_back from cuo_dwwindow within tabpage_sheet01
end type
type tab_sheet_2 from userobject within tab_sheet
end type
type gb_3 from groupbox within tab_sheet_2
end type
type dw_update2 from uo_dwgrid within tab_sheet_2
end type
type tab_sheet_2 from userobject within tab_sheet
gb_3 gb_3
dw_update2 dw_update2
end type
type dw_head from datawindow within w_hgm301i
end type
type rb_total from radiobutton within w_hgm301i
end type
type sle_accept_num from singlelineedit within w_hgm301i
end type
type rb_del from radiobutton within w_hgm301i
end type
type gb_4 from groupbox within w_hgm301i
end type
type gb_5 from groupbox within w_hgm301i
end type
end forward

global type w_hgm301i from w_tabsheet
string title = "물품 접수"
dw_head dw_head
rb_total rb_total
sle_accept_num sle_accept_num
rb_del rb_del
gb_4 gb_4
gb_5 gb_5
end type
global w_hgm301i w_hgm301i

type variables

int ii_tab
datawindow idw_sname, idw_name1
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();
int  li_ord_class
long ll_row, ll_RowCnt, ll_apply_qty, ll_ord_class
string ls_item_middle, ls_item_name, ls_dept_code

DataWindow  dw_name
dw_name = tab_sheet.tabpage_sheet01.dw_update_tab


dw_head.accepttext()
				
ls_item_middle = trim(dw_head.object.c_item_middle[1]) + '%'
ls_item_name = trim(dw_head.object.c_item_name[1]) + '%'
ls_dept_code = trim(dw_head.object.c_dept_code[1]) + '%'
ll_ord_class = dw_head.object.c_ord_class[1]

IF ISNULL(ls_item_middle) THEN ls_item_middle = '%'
IF ISNULL(ls_item_name) THEN ls_item_name = '%'
IF ISNULL(ls_dept_code) THEN ls_dept_code = '%'

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
		ll_RowCnt = tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( ls_item_middle, ls_item_name, ls_dept_code,ll_ord_class )
		IF  ll_RowCnt = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
	   ELSE
			wf_setMsg("자료가 조회 되었습니다")
		   ll_apply_qty = dw_name.Object.apply_qty[dw_name.GetRow()]
			dw_name.Object.update_qty[dw_name.GetRow()] = ll_apply_qty
		END IF	 
   
	CASE 2
	 
	   IF tab_sheet.tab_sheet_2.dw_update2.retrieve( ls_item_middle, ls_item_name, ls_dept_code ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE
			wf_setMsg("자료가 조회 되었습니다")
		END IF	 	 
	
   END CHOOSE



rb_total.checked = FALSE


end subroutine

on w_hgm301i.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.rb_total=create rb_total
this.sle_accept_num=create sle_accept_num
this.rb_del=create rb_del
this.gb_4=create gb_4
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.rb_total
this.Control[iCurrent+3]=this.sle_accept_num
this.Control[iCurrent+4]=this.rb_del
this.Control[iCurrent+5]=this.gb_4
this.Control[iCurrent+6]=this.gb_5
end on

on w_hgm301i.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.rb_total)
destroy(this.sle_accept_num)
destroy(this.rb_del)
destroy(this.gb_4)
destroy(this.gb_5)
end on

event ue_retrieve;call super::ue_retrieve;		
wf_retrieve()
return 1




end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 물품접수 및 접수취소
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////


String ls_req_no
Long	ll_InsRow
//wf_setMenu('R',TRUE)
//wf_setMenu('U',TRUE)


dw_head.object.c_apply_date_f[1] = left(f_today(),6) + '01'
dw_head.object.c_apply_date_t[1] = f_today()

DataWindowChild	ldwc_Temp
dw_head.GetChild('c_dept_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)

IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('공통코드[부서]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
else
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','')
	ldwc_Temp.SetSort('gwa ASC')
	ldwc_Temp.Sort()
END IF

dw_head.InsertRow(0)
dw_head.Object.c_dept_code.dddw.PercentWidth = 300

//물품상태
dw_head.GetChild('c_ord_class',ldwc_Temp)         
ldwc_Temp.SetTransObject(SQLCA)

IF ldwc_Temp.Retrieve("ord_class") = 0 THEN
	wf_setmsg('공통코드[물품상태]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','0')
	ldwc_Temp.SetItem(ll_InsRow,'fname','전체')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF

tab_sheet.tabpage_sheet01.dw_update_tab.reset()
tab_sheet.tab_sheet_2.dw_update2.reset()

// 접수번호 	초기화
SELECT	TO_char(SYSDATE,'YYYYMM')||trim(to_char(nvl(substr(max(REQ_NO),7,4)+1,'0001'),'0000'))
INTO		:ls_req_no
FROM		STDB.HST105H
WHERE 	REQ_NO LIKE	TO_char(SYSDATE,'YYYYMM') ||'%' ;

sle_accept_num.text = ls_req_no

end event

event ue_save;call super::ue_save;
long 		ll_row, i, ll_seq, ll_number, ll_seq_no, ll_ord_class
string 	ls_req_no
Integer	li_item_Seq_num

ii_tab 		= tab_sheet.selectedtab
ls_req_no	=	sle_accept_num.text

CHOOSE CASE ii_tab
		
	CASE 1
    
	  idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
	  
	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN -1
	  
	  idw_name1.accepttext()
	  
	  ll_row = idw_name1.rowcount()
	  
	  IF idw_name1.rowcount() <> 0 THEN
		
			li_item_seq_num	=	1
			SELECT	TO_char(SYSDATE,'YYYYMM')||trim(to_char(nvl(substr(max(REQ_NO),7,4)+1,'0001'),'0000'))
			 INTO		:ll_number
			 FROM		STDB.HST105H 
			 WHERE 	REQ_NO LIKE	TO_char(SYSDATE,'YYYYMM') ||'%';
			
			FOR i = 1 TO ll_row
				
			   IF idw_name1.object.ord_class[i] = 2  THEN
			
					idw_name1.object.req_no[i]		= string(ll_number)
					ll_number ++
//					messagebox(string(ll_number),string(i))
//					messagebox(string(ll_number),ll_number)
					idw_name1.object.item_seq[i] 	= li_item_seq_num				//품목번호					
					idw_name1.object.job_uid[i] 	= gs_empcode		//수정자
		  			idw_name1.object.job_date[i] 	= f_sysdate()          		//오늘 일자 
		  			idw_name1.object.job_add[i] 	= gs_ip  //IP
					
 				END IF
  				  	
			NEXT 			

			  idw_name1.accepttext() 
           IF f_update( idw_name1,'U') = TRUE THEN 
				  wf_retrieve()
				  wf_setmsg("저장되었습니다")
			  END IF		  
	 END IF		  
//	  IF idw_name1.rowcount() <> 0 THEN
//		
//			li_item_seq_num	=	1		
//
//			 SELECT	TO_char(SYSDATE,'YYYYMM')||trim(to_char(nvl(substr(max(REQ_NO),7,4)+1,'0001'),'0000'))
//			 INTO		:ll_number
//			 FROM		STDB.HST105H 
//			 WHERE 	REQ_NO LIKE	TO_char(SYSDATE,'YYYYMM') ||'%';
//			
//			ll_row = idw_name1.rowcount()

//			FOR i = 1 TO ll_row
//				ll_ord_class = idw_name1.object.ord_class[i]
//
//			   IF ll_ord_class = 2  THEN  
////				messagebox(string(ll_number),string(i))
//					idw_name1.object.REQ_NO[i] 		= string( ll_number)	      //접수번호
//					ll_number ++
//
//					idw_name1.object.item_seq[i] 	= li_item_seq_num				//품목번호					
//					idw_name1.object.job_uid[i] 	= gs_empcode		//수정자
//		  			idw_name1.object.job_date[i] 	= f_sysdate()          		//오늘 일자 
//		  			idw_name1.object.job_add[i] 	= gs_ip  //IP
// 				END IF
//  				  	
//			NEXT 			
//
//			idw_name1.accepttext() 
//           IF f_update( idw_name1,'U') = TRUE THEN 
////				  wf_retrieve()
//				  wf_setmsg("저장되었습니다")
//			  END IF		  
//	 END IF		  
	  
   CASE 2
     
	  idw_name1 = tab_sheet.tab_sheet_2.dw_update2
	
     ll_row = idw_name1.rowcount()
	  
	  FOR i = 1 TO ll_row
		
		 IF idw_name1.object.ord_class[i] = 3 THEN
	      
			 idw_name1.object.accept_date[i] = ''						//접수일자
	       idw_name1.object.req_no[i] = ''								//접수번호
	       idw_name1.object.item_seq[i] = 0								//품목번호
			 idw_name1.object.job_uid[i] = gs_empcode		//수정자
			 idw_name1.object.job_date[i] = f_sysdate()            //오늘 일자 
			 idw_name1.object.job_add[i] = gs_ip //IP
			
		 END IF	
		 
	  NEXT
		  
	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN	-1
	  
	  IF f_update( idw_name1,'U') = TRUE THEN 
		  wf_retrieve()
		  wf_setmsg("저장되었습니다")
	  END IF		  
	  
END CHOOSE		



end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hgm301i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hgm301i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hgm301i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hgm301i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hgm301i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hgm301i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hgm301i
end type

type uc_insert from w_tabsheet`uc_insert within w_hgm301i
end type

type uc_delete from w_tabsheet`uc_delete within w_hgm301i
end type

type uc_save from w_tabsheet`uc_save within w_hgm301i
end type

type uc_excel from w_tabsheet`uc_excel within w_hgm301i
end type

type uc_print from w_tabsheet`uc_print within w_hgm301i
end type

type st_line1 from w_tabsheet`st_line1 within w_hgm301i
end type

type st_line2 from w_tabsheet`st_line2 within w_hgm301i
end type

type st_line3 from w_tabsheet`st_line3 within w_hgm301i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hgm301i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hgm301i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hgm301i
integer x = 73
integer y = 412
integer width = 4384
integer height = 1884
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tab_sheet_2 tab_sheet_2
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		f_setpointer('START')
//      wf_retrieve()
//		f_setpointer('END')		
//end choose
rb_total.checked = FALSE
end event

on tab_sheet.create
this.tab_sheet_2=create tab_sheet_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_sheet_2
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tab_sheet_2)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 1764
long backcolor = 1073741824
string text = "물품 접수"
gb_2 gb_2
dw_update1_back dw_update1_back
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.dw_update1_back=create dw_update1_back
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.dw_update1_back
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.dw_update1_back)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 2670
integer y = 216
integer width = 238
integer height = 92
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
integer x = 55
integer y = 108
integer width = 4256
integer height = 1616
string dataobject = "d_hgm301i_2"
end type

event dw_update_tab::itemchanged;call super::itemchanged;
long ll_lim_amt
string ls_dept_code, ls_year, ls_acct_code

this.accepttext()

IF dwo.name = 'ord_class' THEN   

   IF data = '1' or data = '3'  or data = '20' THEN	   
		this.object.accept_date[row] = ''
		this.object.req_no[row] = ''
		this.object.lim_amt[row] = 0
	ELSE			
		this.object.accept_date[row] = f_today()
	END IF
	
END IF

IF dwo.name = 'acct_code' THEN                      // 계정 과목  
	
	IF this.object.ord_class[row] = 2 THEN           // 접 수
	
		ls_dept_code = this.object.apply_gwa[row]
		ls_year = left(this.object.apply_date[row],4)
		ls_acct_code = this.object.acct_code[row]

		//예산통제금액 = 배정예산 - (가집행금액 + 집행금액) 
		SELECT NVL((ASSN_USED_AMT - (ASSN_TEMP_AMT + ASSN_REAL_AMT) ),0)    
		INTO :ll_lim_amt
		FROM ACDB.HAC012M
		WHERE BDGT_YEAR = :ls_year  AND
				DEPT_CODE = :ls_dept_code  AND
				ACCT_CODE = :ls_acct_code    ;

		this.object.lim_amt[row] = ll_lim_amt		
	
   END IF
	
END IF

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

long ll_apply_qty

dataWindow  dw_name
dw_name = tab_sheet.tabpage_sheet01.dw_update_tab

IF currentrow <> 0 THEN
   dw_name.Object.update_qty[currentrow] = dw_name.Object.apply_qty[currentrow]
END IF
end event

type uo_tab from w_tabsheet`uo_tab within w_hgm301i
integer x = 1088
integer y = 460
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hgm301i
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hgm301i
boolean visible = false
end type

type gb_2 from groupbox within tabpage_sheet01
integer x = 23
integer y = 36
integer width = 4325
integer height = 1716
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "물품 신청 내역"
end type

type dw_update1_back from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer x = 55
integer y = 108
integer width = 101
integer height = 100
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hgm301i_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;//this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;
long ll_lim_amt
string ls_dept_code, ls_year, ls_acct_code

this.accepttext()

IF dwo.name = 'ord_class' THEN   

   IF data = '1' or data = '3'  or data = '20' THEN	   
		this.object.accept_date[row] = ''
		this.object.req_no[row] = ''
		this.object.lim_amt[row] = 0
	ELSE			
		this.object.accept_date[row] = f_today()
	END IF
	
END IF

IF dwo.name = 'acct_code' THEN                      // 계정 과목  
	
	IF this.object.ord_class[row] = 2 THEN           // 접 수
	
		ls_dept_code = this.object.apply_gwa[row]
		ls_year = left(this.object.apply_date[row],4)
		ls_acct_code = this.object.acct_code[row]

		//예산통제금액 = 배정예산 - (가집행금액 + 집행금액) 
		SELECT NVL((ASSN_USED_AMT - (ASSN_TEMP_AMT + ASSN_REAL_AMT) ),0)    
		INTO :ll_lim_amt
		FROM ACDB.HAC012M
		WHERE BDGT_YEAR = :ls_year  AND
				DEPT_CODE = :ls_dept_code  AND
				ACCT_CODE = :ls_acct_code    ;

		this.object.lim_amt[row] = ll_lim_amt		
	
   END IF
	
END IF

end event

event dberror;call super::dberror;//IF sqldbcode = 1 THEN
//	messagebox("확인",'중복된 값이 있습니다.')
//	setcolumn(1)
//	setfocus()
//END IF
//
//RETURN 1
end event

event doubleclicked;call super::doubleclicked;//
//IF dwo.name = 'item_middle' THEN
//	
//	open(w_kch101h)
//	   	
//	IF message.stringparm <> '' THEN
//	
//	   this.object.item_middle[row] = gstru_uid_uname.s_parm[1]
//		this.object.midd_name[row] = gstru_uid_uname.s_parm[2]	   
//	
//   END IF
//	
//END IF
end event

event rowfocuschanged;call super::rowfocuschanged;//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

long ll_apply_qty

dataWindow  dw_name
dw_name = tab_sheet.tabpage_sheet01.dw_update_tab

IF currentrow <> 0 THEN
   dw_name.Object.update_qty[currentrow] = dw_name.Object.apply_qty[currentrow]
END IF
end event

event itemerror;call super::itemerror;//RETURN 1
end event

event key_enter;call super::key_enter;//
//long ll_getrow
//string ls_acct_code
//
//this.accepttext()	
//	
//ll_getrow = this.getrow()
//
//IF this.getcolumnname() = 'acct_code' THEN                         // 계정과목 
//
//	ls_acct_code = this.object.acct_code[ll_getrow]
//	
//	openwithparm(w_hgm300h,ls_acct_code)
//			
//	IF message.stringparm <> '' THEN
//	
//		this.object.acct_code[ll_getrow] = gstru_uid_uname.s_parm[1]
//		this.object.acct_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
//	
//	END IF
//
//END IF
end event

type tab_sheet_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1764
string text = "물품 접수 취소"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_3 gb_3
dw_update2 dw_update2
end type

on tab_sheet_2.create
this.gb_3=create gb_3
this.dw_update2=create dw_update2
this.Control[]={this.gb_3,&
this.dw_update2}
end on

on tab_sheet_2.destroy
destroy(this.gb_3)
destroy(this.dw_update2)
end on

type gb_3 from groupbox within tab_sheet_2
integer x = 27
integer y = 40
integer width = 4320
integer height = 1720
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "물품 접수 내역"
end type

type dw_update2 from uo_dwgrid within tab_sheet_2
integer x = 50
integer y = 112
integer width = 4274
integer height = 1624
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hgm301i_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_head from datawindow within w_hgm301i
event ue_keydown pbm_dwnkey
integer x = 201
integer y = 232
integer width = 3186
integer height = 96
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm301i_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
IF key = keyenter! THEN wf_retrieve()
end event

event constructor;f_pro_toggle('k',handle(parent))
end event

type rb_total from radiobutton within w_hgm301i
integer x = 3662
integer y = 380
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "전체선택"
end type

event clicked;
long ll_rowcount, i

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1 
 
		ll_rowcount = tab_sheet.tabpage_sheet01.dw_update_tab.rowcount()
		
		FOR i = 1 TO ll_rowcount
			
			tab_sheet.tabpage_sheet01.dw_update_tab.object.accept_date[i] = f_today()
			tab_sheet.tabpage_sheet01.dw_update_tab.object.ord_class[i] = 2		           // 주관접수로 바꾼다  		
			
		NEXT
	
	CASE 2 
		
		ll_rowcount = tab_sheet.tab_sheet_2.dw_update2.rowcount()
		
		FOR i = 1 TO ll_rowcount

			tab_sheet.tab_sheet_2.dw_update2.object.ord_class[i] = 3		           // 신청로 바꾼다  		
			
		NEXT
		
END CHOOSE		
		
end event

type sle_accept_num from singlelineedit within w_hgm301i
integer x = 3794
integer y = 236
integer width = 544
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

type rb_del from radiobutton within w_hgm301i
integer x = 4037
integer y = 380
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "전체취소"
end type

event clicked;
long ll_rowcount, i

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1 
 
		ll_rowcount = tab_sheet.tabpage_sheet01.dw_update_tab.rowcount()
		
		FOR i = 1 TO ll_rowcount
			
			tab_sheet.tabpage_sheet01.dw_update_tab.object.accept_date[i] = ''
			tab_sheet.tabpage_sheet01.dw_update_tab.object.ord_class[i] = 3		           // 주관접수로 바꾼다  		
			
		NEXT
	
	CASE 2 
		
		ll_rowcount = tab_sheet.tab_sheet_2.dw_update2.rowcount()
		
		FOR i = 1 TO ll_rowcount

			tab_sheet.tab_sheet_2.dw_update2.object.ord_class[i] = 2	            // 신청로 바꾼다  		
			
		NEXT
		
END CHOOSE		
		
end event

type gb_4 from groupbox within w_hgm301i
integer x = 50
integer y = 156
integer width = 3616
integer height = 204
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회 조건"
end type

type gb_5 from groupbox within w_hgm301i
integer x = 3680
integer y = 156
integer width = 759
integer height = 204
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "접수번호"
end type

