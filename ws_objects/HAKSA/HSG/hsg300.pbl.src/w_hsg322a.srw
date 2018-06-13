$PBExportHeader$w_hsg322a.srw
$PBExportComments$[청운대]지도교수배정
forward
global type w_hsg322a from w_condition_window
end type
type dw_1 from uo_input_dwc within w_hsg322a
end type
type cb_1 from commandbutton within w_hsg322a
end type
type dw_2 from datawindow within w_hsg322a
end type
type st_1 from statictext within w_hsg322a
end type
type em_1 from uo_em_nextyear within w_hsg322a
end type
type st_3 from statictext within w_hsg322a
end type
type st_4 from statictext within w_hsg322a
end type
type dw_3 from uo_dddw_dwc within w_hsg322a
end type
type st_5 from statictext within w_hsg322a
end type
type st_6 from statictext within w_hsg322a
end type
type dw_4 from uo_dddw_dwc within w_hsg322a
end type
type cb_3 from commandbutton within w_hsg322a
end type
type cb_5 from commandbutton within w_hsg322a
end type
type ddlb_2 from dropdownlistbox within w_hsg322a
end type
type cb_2 from commandbutton within w_hsg322a
end type
type dw_5 from datawindow within w_hsg322a
end type
end forward

global type w_hsg322a from w_condition_window
dw_1 dw_1
cb_1 cb_1
dw_2 dw_2
st_1 st_1
em_1 em_1
st_3 st_3
st_4 st_4
dw_3 dw_3
st_5 st_5
st_6 st_6
dw_4 dw_4
cb_3 cb_3
cb_5 cb_5
ddlb_2 ddlb_2
cb_2 cb_2
dw_5 dw_5
end type
global w_hsg322a w_hsg322a

type variables
string is_hakgwa, is_hakyun, is_hakgi
datawindowchild idwc_model
end variables

on w_hsg322a.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.st_1=create st_1
this.em_1=create em_1
this.st_3=create st_3
this.st_4=create st_4
this.dw_3=create dw_3
this.st_5=create st_5
this.st_6=create st_6
this.dw_4=create dw_4
this.cb_3=create cb_3
this.cb_5=create cb_5
this.ddlb_2=create ddlb_2
this.cb_2=create cb_2
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.em_1
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.dw_4
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.cb_5
this.Control[iCurrent+14]=this.ddlb_2
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.dw_5
end on

on w_hsg322a.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_3)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.dw_4)
destroy(this.cb_3)
destroy(this.cb_5)
destroy(this.ddlb_2)
destroy(this.cb_2)
destroy(this.dw_5)
end on

event ue_retrieve;Int    li_row
String ls_hakbun,  ls_hakyun,  ls_gwa,  ls_janghak,  ls_year,  ls_hakgi
String ls_hakgwa,  ls_member

ls_year		= em_1.text
ls_hakgi		= dw_5.gettext()
ls_hakyun 	= ddlb_2.text + '%'
ls_hakgwa   = dw_3.gettext()
ls_member   = dw_4.gettext()

IF isnull(ls_member) OR ls_member = '' THEN
	messagebox("조회", '교수를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

IF isnull(ls_hakgi) OR ls_hakgi = '' THEN
	messagebox("조회", '학기를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

IF isnull(ls_hakgwa) OR ls_hakgwa = '' THEN
	messagebox("조회", '학과를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

//전산정보원은 다 볼수 있도록
IF	mid(gstru_uid_uname.dept_code, 1, 3) = '290' THEN
	li_row      = dw_1.retrieve(ls_year, ls_hakgi, ls_hakyun, ls_hakgwa, ls_member)		
ELSEIF mid(ls_hakgwa, 1, 3) = mid(gstru_uid_uname.dept_code, 1, 3)THEN
	li_row      = dw_1.retrieve(ls_year, ls_hakgi, ls_hakyun, ls_hakgwa, ls_member)
ELSE
	MESSAGEBOX('확인', '타과는 조회가 불가능합니다.')
	return 1
END IF

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_1.setfocus()

end event

event ue_delete;int	li_ans1	,&
		li_ans2
string ls_hakbun
long ll_row

li_ans1 = uf_messagebox(4)		//	삭제확인 메세지 출력

IF li_ans1 = 1 THEN
	ll_row = dw_1.getrow()
	
	dw_1.deleterow(ll_row)          //	현재 행을 삭제
	li_ans2 = dw_1.update()    //	삭제된 내용을 저장
	
	IF li_ans2 = -1 THEN
		ROLLBACK USING SQLCA;     
		uf_messagebox(6)        //	삭제오류 메세지 출력
	END IF
END IF

dw_1.setfocus()
end event

event ue_save;int	 li_ans,    ii,         l_cnt
String ls_member, ls_hakbun,  ls_year,  ls_hakgi,   ls_chk,  ls_hakyun
dwItemStatus	lsStatus

dw_1.AcceptText()

FOR ii      = 1 TO dw_1.RowCount()
	 ls_year      = dw_1.GetItemString(ii, 'year')
	 ls_hakgi     = dw_1.GetItemString(ii, 'hakgi')
	 ls_member    = dw_1.GetItemString(ii, 'member_no')
	 ls_hakbun    = dw_1.GetItemString(ii, 'hakbun')
	 ls_chk       = dw_1.GetItemString(ii, 'chk')
	 IF ls_chk    = 'Y' THEN
		 IF isnull(ls_member) OR ls_member = '' THEN
			 messagebox("저장", '지도교수를 선택하시기 바랍니다.')
			 dw_1.SetColumn('member_no')
          dw_1.SetFocus()
          dw_1.ScrollToRow(ii)
			 return -1
		 END IF
		 SELECT nvl(count(*), 0)
		   INTO :l_cnt
			FROM haksa.prof_sym
		  WHERE member_no  = :ls_member;
		 IF l_cnt  = 0 THEN
			 messagebox("저장", '해당 지도교수코드가 등록되지 않았습니다.')
			 dw_1.SetColumn('member_no')
          dw_1.SetFocus()
          dw_1.ScrollToRow(ii)
			 return -1
		 END IF
	 END IF
NEXT

FOR ii      = 1 TO dw_1.RowCount()
	 ls_year      = dw_1.GetItemString(ii, 'year')
	 ls_hakgi     = dw_1.GetItemString(ii, 'hakgi')
	 ls_member    = dw_1.GetItemString(ii, 'member_no')
	 ls_hakbun    = dw_1.GetItemString(ii, 'hakbun')
	 ls_chk       = dw_1.GetItemString(ii, 'chk')
	 ls_hakyun    = dw_1.GetItemString(ii, 'dr_hakyun')
	 lsStatus     = dw_1.GetItemStatus(ii, 0, Primary!)
	 IF lsStatus  = DataModified! OR lsStatus   = New! OR lsStatus   = NewModified! THEN
		 IF ls_chk = 'Y' THEN
			 SELECT nvl(count(*), 0)
				INTO :l_cnt
				FROM SUM210TL
			  WHERE year      = :ls_year
				 AND hakgi     = :ls_hakgi
				 AND hakbun    = :ls_hakbun;
			 IF l_cnt         = 0 THEN
				 INSERT INTO SUM210TL (YEAR,         HAKGI,       MEMBER_NO,     HAKBUN,
											  WORKER,
											  WORK_DATE,    IPADDR)
								 VALUES   (:ls_year,     :ls_hakgi,   :ls_member,    :ls_hakbun,
											  :gstru_uid_uname.uid,
											  sysdate,      :gstru_uid_uname.address);
								 IF sqlca.sqlcode <> 0 THEN
									 messagebox("저장", '지도교수배정 저장중 오류' + sqlca.sqlerrtext)
									 rollback;
									 return -1
								 END IF
			 ELSE
				 UPDATE SUM210TL
					 SET member_no   = :ls_member
				  WHERE year        = :ls_year
					 AND hakgi       = :ls_hakgi
					 AND hakbun      = :ls_hakbun;
				 IF sqlca.sqlcode <> 0 THEN
					 messagebox("저장", '지도교수배정 수정중 오류' + sqlca.sqlerrtext)
					 rollback;
					 return -1
				 END IF
			 END IF
		 ELSE
			 DELETE FROM SUM210TL
			  WHERE year      = :ls_year
				 AND hakgi     = :ls_hakgi
				 AND hakbun    = :ls_hakbun;
		 END IF
		 IF ls_hakyun        = '1' THEN
			 UPDATE HAKSA.JAEHAK_SINSANG
			    SET member_no1  = :ls_member
			  WHERE hakbun      = :ls_hakbun;
		 ELSEIF ls_hakyun    = '2' THEN
			 UPDATE HAKSA.JAEHAK_SINSANG
			    SET member_no2  = :ls_member
			  WHERE hakbun      = :ls_hakbun;
		 ELSEIF ls_hakyun    = '3' THEN
			 UPDATE HAKSA.JAEHAK_SINSANG
			    SET member_no3  = :ls_member
			  WHERE hakbun      = :ls_hakbun;
		 ELSEIF ls_hakyun    = '4' THEN
			 UPDATE HAKSA.JAEHAK_SINSANG
			    SET member_no4  = :ls_member
			  WHERE hakbun      = :ls_hakbun;
		 END IF
    END IF
NEXT

commit;

uf_messagebox(2)

This.TriggerEvent('ue_retrieve')
//li_ans = dw_1.update()		//	자료의 저장

//IF li_ans = -1  THEN
//	ROLLBACK USING SQLCA;
//	uf_messagebox(3)       	//	저장오류 메세지 출력
//
//ELSE
//	COMMIT USING SQLCA;
//	uf_messagebox(2)       //	저장확인 메세지 출력
//END IF
end event

event open;call super::open;wf_setmenu('RETRIEVE', 	TRUE)
wf_setmenu('INSERT', 	FALSE)
wf_setmenu('DELETE', 	FALSE)
wf_setmenu('SAVE', 		TRUE)
wf_setmenu('PRINT', 		FALSE)


end event

event ue_open;call super::ue_open;dw_5.SetTransobject(sqlca)
dw_5.retrieve()

String ls_year,  ls_hakgi

SELECT fname
  INTO :ls_year
  FROM cddb.kch001m
 WHERE type   = 'SUM00'
   AND code   = '10';
	
SELECT fname
  INTO :ls_hakgi
  FROM cddb.kch001m
 WHERE type   = 'SUM00'
   AND code   = '20';
	
em_1.text     = ls_year
dw_5.Settext(ls_hakgi)

end event

type ln_templeft from w_condition_window`ln_templeft within w_hsg322a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsg322a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsg322a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsg322a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsg322a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsg322a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsg322a
end type

type uc_insert from w_condition_window`uc_insert within w_hsg322a
end type

type uc_delete from w_condition_window`uc_delete within w_hsg322a
end type

type uc_save from w_condition_window`uc_save within w_hsg322a
end type

type uc_excel from w_condition_window`uc_excel within w_hsg322a
end type

type uc_print from w_condition_window`uc_print within w_hsg322a
end type

type st_line1 from w_condition_window`st_line1 within w_hsg322a
end type

type st_line2 from w_condition_window`st_line2 within w_hsg322a
end type

type st_line3 from w_condition_window`st_line3 within w_hsg322a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsg322a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsg322a
end type

type gb_1 from w_condition_window`gb_1 within w_hsg322a
integer height = 304
end type

type gb_2 from w_condition_window`gb_2 within w_hsg322a
end type

type dw_1 from uo_input_dwc within w_hsg322a
integer x = 187
integer y = 284
integer width = 3813
integer height = 2164
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg322a_1"
boolean border = true
end type

event itemchanged;call super::itemchanged;String ls_member

ls_member   = dw_4.GetText()

CHOOSE CASE dwo.name
	CASE 'member_no'
		IF isnull(data) OR data = '' THEN
         dw_1.SetItem(row, 'chk', 'N')
		ELSE
			dw_1.SetItem(row, 'chk', 'Y')
	   END IF
	CASE 'chk'
		IF data      = 'Y' THEN
			dw_1.SetItem(row, 'member_no', ls_member)
		ELSE
			dw_1.SetItem(row, 'member_no', '')
		END IF
END CHOOSE
end event

event clicked;call super::clicked;This.SetRow(row)
end event

type cb_1 from commandbutton within w_hsg322a
boolean visible = false
integer x = 2789
integer y = 152
integer width = 448
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "장학생제외내역"
end type

event clicked;dw_2.visible = true
end event

type dw_2 from datawindow within w_hsg322a
boolean visible = false
integer x = 1033
integer y = 556
integer width = 2153
integer height = 1720
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "입학성적장학제외대상"
string dataobject = "d_hjh107a_2"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;CHOOSE CASE dwo.name
	CASE 'b_1'
		dw_2.print()
	CASE 'b_2'
		dw_2.visible = false
END CHOOSE
end event

type st_1 from statictext within w_hsg322a
integer x = 114
integer y = 84
integer width = 160
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "년 도"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from uo_em_nextyear within w_hsg322a
integer x = 283
integer y = 72
integer taborder = 50
boolean bringtotop = true
end type

type st_3 from statictext within w_hsg322a
integer x = 635
integer y = 84
integer width = 174
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "학 기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_hsg322a
integer x = 951
integer y = 208
integer width = 174
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "학 과"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_3 from uo_dddw_dwc within w_hsg322a
integer x = 1129
integer y = 192
integer width = 800
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_list_hakgwa"
end type

type st_5 from statictext within w_hsg322a
integer x = 2025
integer y = 208
integer width = 192
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "학 년"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_hsg322a
integer x = 114
integer y = 208
integer width = 160
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "교 수"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_4 from uo_dddw_dwc within w_hsg322a
integer x = 293
integer y = 192
integer width = 562
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_list_prof"
end type

event itemchanged;call super::itemchanged;parent.triggerevent('ue_retrieve')
end event

type cb_3 from commandbutton within w_hsg322a
integer x = 2734
integer y = 116
integer width = 315
integer height = 116
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "전체선택"
end type

event clicked;Int    ii
String ls_member

ls_member  = dw_4.GetText()
FOR ii     = 1 TO dw_1.RowCount()
	 dw_1.SetItem(ii, 'chk', 'Y')
	 dw_1.SetItem(ii, 'member_no', ls_member)
NEXT
end event

type cb_5 from commandbutton within w_hsg322a
integer x = 3045
integer y = 116
integer width = 315
integer height = 116
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "전체취소"
end type

event clicked;Int    ii

FOR ii     = 1 TO dw_1.RowCount()
	 dw_1.SetItem(ii, 'chk', 'N')
	 dw_1.SetItem(ii, 'member_no', '')
NEXT
end event

type ddlb_2 from dropdownlistbox within w_hsg322a
integer x = 2226
integer y = 192
integer width = 201
integer height = 472
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string item[] = {"1","2","3","4"}
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_hsg322a
integer x = 3355
integer y = 116
integer width = 485
integer height = 116
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "이전학기복사"
end type

event clicked;Int    l_cnt
String ls_year,  ls_hakgi,   ls_be_year,   ls_be_hakgi, 	ls_hakyun, ls_hakgwa, ls_member

ls_year		= em_1.text
ls_hakgi		= dw_5.gettext()
ls_hakyun 	= ddlb_2.text + '%'
ls_hakgwa   = dw_3.gettext()
ls_member   = dw_4.gettext()

IF isnull(ls_hakgi) OR ls_hakgi = '' THEN
	messagebox("알림", '학기를 선택한 후 작업하시기 바랍니다.')
	return
END IF

IF isnull(ls_hakgwa) OR ls_hakgwa = '' THEN
	messagebox("알림", '학과를 선택한 후 작업하시기 바랍니다.')
	return
END IF

IF isnull(ls_member) OR ls_member = '' THEN
	messagebox("알림", '교수를 선택한 후 작업하시기 바랍니다.')
	return
END IF

IF ls_hakgi     = '10' THEN
	ls_be_year   = String(Long(ls_year) - 1, '0000')
	ls_be_hakgi  = '20'
ELSEIF ls_hakgi = '20' THEN
	ls_be_year   = ls_year
	ls_be_hakgi  = '10'
END IF

IF mid(ls_hakgwa, 1, 3) = mid(gstru_uid_uname.dept_code, 1, 3) THEN

ELSE
	MESSAGEBOX('확인', '타과는 복사가 불가능합니다.')
	return 1
END IF


SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM SUM210TL
 WHERE year     	= :ls_be_year
   AND hakgi    	= :ls_be_hakgi
   AND member_no  = :ls_member
;

IF l_cnt        = 0 THEN
	messagebox("알림", '이전 학기의 자료가 없습니다')
	return
END IF

l_cnt    = 0

SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM SUM210TL
 WHERE year     	= :ls_year
   AND hakgi    	= :ls_hakgi
   AND member_no  = :ls_member
;
	
IF l_cnt        > 0 THEN
	IF MessageBox("확인", "기존자료를 삭제한 후 작업을 계속 진행 하시겠습니까?", Question!, YesNo!) = 2 THEN
		Return
	END IF
END IF

DELETE FROM SUM210TL
 WHERE year    	= :ls_year
   AND hakgi   	= :ls_hakgi
   AND member_no  = :ls_member
;

INSERT INTO HAKSA.SUM210TL (
						SELECT    :ls_year,    :ls_hakgi,  :ls_member,    HAKBUN,
									 :gstru_uid_uname.uid,     :gstru_uid_uname.address,
									 sysdate,
									 :gstru_uid_uname.uid,     :gstru_uid_uname.address,
									 sysdate
						  FROM    HAKSA.SUM210TL
						 WHERE    year      = :ls_be_year
							AND    hakgi     = :ls_be_hakgi
							AND	 MEMBER_NO = :ls_member
							)	;
							
if sqlca.sqlcode <> 0 then
	rollback;
	messagebox('오류', '복사가 되지않았습니다.', exclamation!);
else
	commit;
	messagebox("복사", '정상적으로 복사가 되었습니다.')
end if

end event

type dw_5 from datawindow within w_hsg322a
integer x = 814
integer y = 72
integer width = 576
integer height = 84
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_list_hakgi"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

