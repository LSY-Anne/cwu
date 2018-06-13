$PBExportHeader$w_hsg102a.srw
$PBExportComments$[청운대]상담및검사신청
forward
global type w_hsg102a from w_condition_window
end type
type dw_1 from uo_input_dwc within w_hsg102a
end type
type cb_1 from commandbutton within w_hsg102a
end type
type st_1 from statictext within w_hsg102a
end type
type em_1 from uo_em_nextyear within w_hsg102a
end type
type st_3 from statictext within w_hsg102a
end type
type st_2 from statictext within w_hsg102a
end type
type sle_1 from uo_sle_hakbun within w_hsg102a
end type
type st_4 from statictext within w_hsg102a
end type
type sle_2 from uo_sle_hakbun within w_hsg102a
end type
type dw_2 from datawindow within w_hsg102a
end type
type dw_4 from datawindow within w_hsg102a
end type
type cb_2 from commandbutton within w_hsg102a
end type
end forward

global type w_hsg102a from w_condition_window
dw_1 dw_1
cb_1 cb_1
st_1 st_1
em_1 em_1
st_3 st_3
st_2 st_2
sle_1 sle_1
st_4 st_4
sle_2 sle_2
dw_2 dw_2
dw_4 dw_4
cb_2 cb_2
end type
global w_hsg102a w_hsg102a

type variables
string is_hakgwa, is_hakyun, is_hakgi
datawindowchild idwc_model
DataWindowChild dwc_counseller
string dwo_name

end variables

on w_hsg102a.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.em_1=create em_1
this.st_3=create st_3
this.st_2=create st_2
this.sle_1=create sle_1
this.st_4=create st_4
this.sle_2=create sle_2
this.dw_2=create dw_2
this.dw_4=create dw_4
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.sle_1
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.sle_2
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.dw_4
this.Control[iCurrent+12]=this.cb_2
end on

on w_hsg102a.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.st_4)
destroy(this.sle_2)
destroy(this.dw_2)
destroy(this.dw_4)
destroy(this.cb_2)
end on

event ue_retrieve;Int    li_row,     l_cnt
String ls_hakbun,  ls_hakyun,  ls_gwa,    ls_janghak,  ls_year,  ls_hakgi
String ls_hakgwa,  ls_member,  ls_rstno, ls_purpose, 	ls_counseller

ls_year		= em_1.text
ls_hakgi		= dw_4.gettext()
ls_hakbun 	= sle_1.text
SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM haksa.jaehak_hakjuk
 WHERE hakbun   = :ls_hakbun;
IF l_cnt    = 0 THEN
	messagebox("조회", '재학 등록이 안된 학번이니 확인바랍니다 .')
	return -1
END IF
IF isnull(ls_hakgi) OR ls_hakgi = '' THEN
	messagebox("조회", '학기를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

li_row      = dw_1.retrieve(ls_year, ls_hakgi, ls_hakbun)
//IF li_row   > 0 THEN
//	ls_year     = dw_1.GetItemString(1, 'year')
//	ls_hakgi    = dw_1.GetItemString(1, 'hakgi')
//	ls_hakbun   = dw_1.GetItemString(1, 'hakbun')
//	ls_rstno    = dw_1.GetItemString(1, 'rst_no')
//	ls_purpose  = dw_1.GetItemString(1, 'purpose')
//	ls_counseller  = dw_1.GetItemString(1, 'counseller')
//	
////	
	dw_2.reset()
////	dw_2.Retrieve(ls_year, ls_hakgi, ls_hakbun, ls_rstno)
////	dwc_counseller.Retrieve(ls_year, ls_hakgi)
//END IF

if li_row   = 0 then
		messagebox("확인", '상담, 검사신청 및 검사이력 없습니다.~r~n입력하신후 상담 및 검사신청하시면 됩니다')
//	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_1.setfocus()

end event

event ue_delete;int    li_ans1,   li_ans2,  l_cnt
string ls_hakbun, ls_year,  ls_hakgi,  ls_caseno, ls_counseller
long   ll_row

IF dw_1.GetRow() < 1 THEN RETURN

ls_year     = dw_1.GetItemString(dw_1.GetRow(), 'year')
ls_hakgi    = dw_1.GetItemString(dw_1.GetRow(), 'hakgi')
ls_hakbun   = dw_1.GetItemString(dw_1.GetRow(), 'hakbun')
ls_caseno   = dw_1.GetItemString(dw_1.GetRow(), 'case_no')
ls_counseller  = dw_1.GetItemString(dw_1.GetRow(), 'counseller')

if ls_counseller = gstru_uid_uname.uid then 
else	
	messagebox('확인', '본인의 상담한 내용만 삭제가 가능합니다')
	return
end if

//SELECT nvl(count(*), 0)
//  INTO :l_cnt
//  FROM SUM140TL
// WHERE year    = :ls_year
//   AND hakgi   = :ls_hakgi
//	AND hakbun  = :ls_hakbun
//	AND case_no = :ls_caseno;
//IF l_cnt       > 0 THEN
//	messagebox("삭제", '상담 결과가 이루어진 신청내역은 삭제할 수 없습니다.')
//	return
//END IF
	
li_ans1 = uf_messagebox(4)		//	삭제확인 메세지 출력

DELETE SUM120TL
 WHERE year    = :ls_year
   AND hakgi   = :ls_hakgi
	AND case_no = :ls_caseno
	AND hakbun  = :ls_hakbun;

IF li_ans1 = 1 THEN
	dw_2.deleterow(1)          //	현재 행을 삭제
	li_ans2 = dw_2.update()    //	삭제된 내용을 저장
	
	IF li_ans2 = -1 THEN
		ROLLBACK USING SQLCA;     
		uf_messagebox(6)        //	삭제오류 메세지 출력
		return
	END IF
END IF

commit;

This.TriggerEvent('ue_retrieve')

end event

event ue_save;int	 li_ans,    ii,         l_cnt,    lirow,      li_cnt
String ls_rstno,   ls_code,  ls_purpose, ls_context ,ls_counsel_tp, ls_mon_pay,   ls_method
string ls_member, ls_hakbun,  ls_year,  ls_hakgi,   ls_chk,        ls_hakyun,  ls_caseno, &
       ls_tel,    ls_hp,      ls_email, ls_month,   ls_monthod,    ls_title,  &
		 ls_counselle, ls_hname,ls_gwa,   ls_gwa_nm,  ls_su_hakyun,  ls_sex,     ls_mail_yn, ls_sangtae, &
		 ls_counsel_cd	 		
datetime 	ls_case_date, ls_counsel_dt
dwItemStatus	lsStatus

dw_2.AcceptText()

ls_year     = dw_2.GetItemString(1, 'year')
ls_hakgi    = dw_2.GetItemString(1, 'hakgi')
ls_hakbun   = dw_2.GetItemString(1, 'hakbun')
ls_caseno   = dw_2.GetItemString(1, 'case_no')
ls_rstno    = dw_2.GetItemString(1, 'rst_no')
ls_counsel_tp = dw_2.GetItemString(1, 'counsel_tp')
ls_counselle  = dw_2.GetItemString(1, 'counseller')
ls_tel      = dw_2.GetItemString(1, 'tel')
ls_hp       = dw_2.GetItemString(1, 'hp')
ls_email    = dw_2.GetItemString(1, 'email')
ls_month    = dw_2.GetItemString(1, 'monthtl_pay')
ls_monthod  = dw_2.GetItemString(1, 'monthod')
ls_purpose  = dw_2.GetItemString(1, 'purpose')
ls_counsel_dt  = dw_2.GetItemdatetime(1, 'counsel_dt')
ls_counsel_cd  = dw_2.GetItemString(1, 'counsel_cd')
ls_context   = dw_2.GetItemString(1, 'context')

if ls_counsel_tp = '' or ls_counsel_tp = '0' or isnull(ls_counsel_tp) then
	messagebox('확인', '상담구분을 선택 하세요.')
	dw_2.setfocus()
	return -1
end if	

if ls_counsel_cd = '' or isnull(ls_counsel_cd) then
	messagebox('확인', '상담종류를 선택 하세요.')
	dw_2.setfocus()
	return -1
end if	

if ls_monthod = '' or isnull(ls_monthod) then
	messagebox('확인', '찾아온경위를 선택 하세요.')
	dw_2.setfocus()
	return -1
end if	

//상담내용 자리수 카운트
if ls_purpose = '1' and (isnull(ls_context) or trim(ls_context) = '') then
	messagebox('확인', '상담내용이 없습니다.')
	dw_2.setfocus()
	return -1
else
	if	ls_purpose = '1' and len(ls_context) < 39 then
		messagebox('확인', '상담내용은 20자 이상 입력을 해야 합니다.')
		dw_2.setfocus()
		return -1
	end if
end if

//if ls_case_date > ls_counsel_dt then
//	messagebox('확인', '신청일자가 상담일자보다 과거일수 없습니다.')
//	dw_2.setfocus()
//	return
//end if	


li_ans  = dw_2.update()

IF li_ans = -1  THEN
	ROLLBACK USING SQLCA;
	uf_messagebox(3)       	//	저장오류 메세지 출력
ELSE
	
	SELECT nvl(count(*),0)
     INTO :li_cnt
     FROM sum120tl
    WHERE year    = :ls_year   and
	       hakgi   = :ls_hakgi  and
			 case_no = :ls_caseno and
	       HAKBUN   =:ls_hakbun;

	SELECT hname,       gwa,     fu_dept_nm ( gwa, 'K' ),   sex,      sangtae       ,dr_hakyun
	  into :ls_hname,  :ls_gwa, :ls_gwa_nm,                :ls_sex,   :ls_sangtae   ,:ls_hakyun
	  FROM HAKSA.JAEHAK_HAKJUK
	 WHERE HAKBUN   = :ls_hakbun;
				 
    if li_cnt = 0 then
		
		 insert into sum120tl (YEAR,		     HAKGI,		   CASE_NO,		 HAKBUN,		     CASE_TP,		      CASE_DATE,       &
		                       TEL,		     HP,			   EMAIL,       MONTHTL_PAY,    MONTHOD,		      purpose,         &
									  TITLE,		     CONTEXT,	   STEP,			 ACT_DT,		     COUNSEL_DT,                     &
									  COUNSELLER,    HNAME,		   GWA,		  	 GWA_NM,		     SU_HAKYUN,	      SEX,             &
									  SANGTAE)									  
		               values (:ls_year,     :ls_hakgi,   :ls_caseno , :ls_hakbun,      :ls_counsel_tp,    :ls_counsel_dt,   &
                             :ls_tel,      :ls_hp,      :ls_email,   :ls_month,       :ls_monthod,       '1' ,             &
									  :ls_title,    :ls_context, '6',         :ls_counsel_dt,  :ls_counsel_dt,                   &
									  :ls_counselle,:ls_hname,   :ls_gwa,     :ls_gwa_nm,      :ls_hakyun,        :ls_sex,          &
									  :ls_sangtae)	;
									  
						 IF sqlca.sqlcode <> 0 THEN
							 messagebox("저장", '상담신청 테이블에 추가 중 저장 오류' + sqlca.sqlerrtext)
							 rollback;
							 return -1
						 END IF
	else
		
		update sum120tl
		set tel = :ls_tel, hp = :ls_hp, email = :ls_email, monthtl_pay = :ls_month, monthod = :ls_monthod
	   WHERE year    = :ls_year   and
	         hakgi   = :ls_hakgi  and
	         case_no = :ls_caseno and
	         HAKBUN   =:ls_hakbun; 
						
	end if		
		
	COMMIT USING SQLCA;
	uf_messagebox(2)       //	저장확인 메세지 출력
END IF

dw_1.retrieve(ls_year, ls_hakgi, ls_hakbun)
liRow       = dw_1.Find( "rst_no = '" + ls_rstno + "'", 1, dw_1.rowcount())

dw_1.ScrollToRow(lirow)
dw_2.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_rstno)

SELECT TEL,      HP,     EMAIL,     monthtl_pay,    monthod
  INTO :ls_tel, :ls_hp, :ls_email,  :ls_mon_pay,   :ls_method
  FROM sum120tl
 WHERE HAKBUN   = :ls_hakbun  and
       year     = :ls_year    and
		 hakgi    = :ls_hakgi   and
		 case_no  = :ls_caseno  ;
		 
//MessageBox("tel", ls_tel)
//MessageBox("hp",  ls_hp)
//MessageBox("email", ls_email)
//MessageBox("pay", ls_mon_pay)
//MessageBox("monthod", ls_method)

dw_2.SetItem(1, 'TEL',     ls_tel)
dw_2.SetItem(1, 'HP',      ls_hp)
dw_2.SetItem(1, 'EMAIL',   ls_email)
dw_2.SetItem(1, 'monthtl_pay' , ls_mon_pay)
dw_2.SetItem(1, 'monthod',    ls_method)


end event

event open;call super::open;wf_setmenu('RETRIEVE', 	TRUE)
wf_setmenu('INSERT', 	TRUE)
wf_setmenu('DELETE', 	TRUE)
wf_setmenu('SAVE', 		TRUE)
wf_setmenu('PRINT', 		FALSE)


end event

event ue_insert;call super::ue_insert;String ls_year,   ls_hakgi,   ls_hakbun,   ls_caseno,  ls_purpose
String ls_tel,    ls_hp,      ls_email
double l_row,     l_case_no,   l_rst_no  
DaTe   ldt_date

SELECT to_char(sysdate, 'yyyymmdd') 
  INTO :ldt_date
  FROM DUAL;

dw_2.reset()

ls_year		= em_1.text
ls_hakgi    = dw_4.gettext()
ls_hakbun 	= sle_1.text


dw_2.InsertRow(0)

//dwc_counseller.Retrieve(ls_year, ls_hakgi)

SELECT :ls_year || lpad((to_number(nvl(max(substr(case_no,5,10)), 0))) + 1, 6,'0') 
  INTO :l_case_no
  FROM SUM120TL
 where case_no like :ls_year || '%';

SELECT :ls_year || lpad((to_number(nvl(max(substr(rst_no,5,10)), 0))) + 1, 6,'0') 
  INTO :l_rst_no
  from SUM140tl 
 where rst_no like :ls_year || '%';
 
// messagebox("case",l_case_no)
//  messagebox("rst",l_rst_no)

SELECT TEL,     HP,     EMAIL
  INTO :ls_tel, :ls_hp, :ls_email  
  FROM HAKSA.JAEHAK_HAKJUK
 WHERE HAKBUN   = :ls_hakbun;

dw_2.SetItem(1, 'year',    ls_year)
dw_2.SetItem(1, 'hakgi',   ls_hakgi)
dw_2.SetItem(1, 'hakbun',  ls_hakbun)
dw_2.SetItem(1, 'TEL',     ls_tel)
dw_2.SetItem(1, 'HP',      ls_hp)
dw_2.SetItem(1, 'EMAIL',   ls_email)
dw_2.SetItem(1, 'case_date', ldt_date)
dw_2.SetItem(1, 'purpose', '1')
dw_2.SetItem(1, 'rst_no' , string(l_rst_no))
dw_2.SetItem(1, 'case_no', string(l_case_no))
dw_2.SetItem(1, 'COUNSEL_DT', ldt_date)
dw_2.SetItem(1, 'ACT_TP',   '1')

dw_2.SetColumn('counsel_tp')
dw_2.setfocus()

end event

event ue_open;call super::ue_open;dw_1.SetTransobject(sqlca)
dw_2.SetTransobject(sqlca)
dw_4.SetTransobject(sqlca)
dw_4.retrieve()

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
dw_4.Settext(ls_hakgi)

end event

type gb_1 from w_condition_window`gb_1 within w_hsg102a
integer height = 304
end type

type gb_2 from w_condition_window`gb_2 within w_hsg102a
end type

type dw_1 from uo_input_dwc within w_hsg102a
integer x = 32
integer y = 312
integer width = 3813
integer height = 996
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "상담내역"
string dataobject = "d_hsg103a_1"
boolean border = true
end type

event clicked;call super::clicked;//This.SetRow(row)


String ls_year,   ls_hakgi,   ls_hakbun,   ls_rstno,    ls_caseno,  ls_purpose
String ls_tel,    ls_hp,      ls_email,    ls_mon_pay,  ls_method,  ls_counseller
Int    l_row


IF row  < 1 THEN return

dw_1.SelectRow(0, false)
dw_1.SelectRow(row, true)

ls_year     = dw_1.GetItemString(row, 'year')
ls_hakgi    = dw_1.GetItemString(row, 'hakgi')
ls_hakbun   = dw_1.GetItemString(row, 'hakbun')
ls_rstno    = dw_1.GetItemString(row, 'rst_no')
ls_caseno   = dw_1.GetItemString(row, 'case_no')
ls_purpose  = dw_1.GetItemString(row, 'purpose')
ls_counseller  = dw_1.GetItemString(row, 'counseller')

if ls_counseller = gstru_uid_uname.uid then 
else	
	messagebox('확인', '본인의 상담한 내용만 조회가 가능합니다')
	return
end if

dw_2.reset()

dw_2.Retrieve(ls_year, ls_hakgi, ls_hakbun, ls_rstno)
//dwc_counseller.Retrieve(ls_year, ls_hakgi)

SELECT TEL,      HP,     EMAIL,     monthtl_pay,    monthod
  INTO :ls_tel, :ls_hp, :ls_email,  :ls_mon_pay,   :ls_method
  FROM sum120tl
 WHERE HAKBUN   = :ls_hakbun  and
       year     = :ls_year    and
		 hakgi    = :ls_hakgi   and
		 case_no  = :ls_caseno  ;
		 


dw_2.SetItem(1, 'TEL',     ls_tel)
dw_2.SetItem(1, 'HP',      ls_hp)
dw_2.SetItem(1, 'EMAIL',   ls_email)
dw_2.SetItem(1, 'monthtl_pay' , ls_mon_pay)
dw_2.SetItem(1, 'monthod',    ls_method)


end event

event rowfocuschanged;call super::rowfocuschanged;//String ls_year,   ls_hakgi,   ls_hakbun,   ls_rstno,    ls_caseno,  ls_purpose
//String ls_tel,    ls_hp,      ls_email,    ls_mon_pay,  ls_method
//Int    l_row
//
//
//IF currentrow  < 1 THEN return
//
//this.SelectRow(0, false)
//this.SelectRow(Currentrow, true)
//
//ls_year     = This.GetItemString(currentrow, 'year')
//ls_hakgi    = This.GetItemString(currentrow, 'hakgi')
//ls_hakbun   = This.GetItemString(currentrow, 'hakbun')
//ls_rstno    = This.GetItemString(currentrow, 'rst_no')
//ls_caseno   = This.GetItemString(currentrow, 'case_no')
//ls_purpose  = This.GetItemString(currentrow, 'purpose')
//
//dw_2.reset()
//
//dw_2.Retrieve(ls_year, ls_hakgi, ls_hakbun, ls_rstno)
////dwc_counseller.Retrieve(ls_year, ls_hakgi)
//
//SELECT TEL,      HP,     EMAIL,     monthtl_pay,    monthod
//  INTO :ls_tel, :ls_hp, :ls_email,  :ls_mon_pay,   :ls_method
//  FROM sum120tl
// WHERE HAKBUN   = :ls_hakbun  and
//       year     = :ls_year    and
//		 hakgi    = :ls_hakgi   and
//		 case_no  = :ls_caseno  ;
//		 
//
//
//dw_2.SetItem(1, 'TEL',     ls_tel)
//dw_2.SetItem(1, 'HP',      ls_hp)
//dw_2.SetItem(1, 'EMAIL',   ls_email)
//dw_2.SetItem(1, 'monthtl_pay' , ls_mon_pay)
//dw_2.SetItem(1, 'monthod',    ls_method)
//
//
end event

type cb_1 from commandbutton within w_hsg102a
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

type st_1 from statictext within w_hsg102a
integer x = 123
integer y = 84
integer width = 169
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
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from uo_em_nextyear within w_hsg102a
integer x = 306
integer y = 72
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
end type

type st_3 from statictext within w_hsg102a
integer x = 837
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
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_hsg102a
integer x = 123
integer y = 204
integer width = 169
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
string text = "학번"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from uo_sle_hakbun within w_hsg102a
integer x = 306
integer y = 188
integer width = 379
integer taborder = 50
boolean bringtotop = true
end type

type st_4 from statictext within w_hsg102a
integer x = 837
integer y = 204
integer width = 165
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
string text = "성명"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_2 from uo_sle_hakbun within w_hsg102a
integer x = 1006
integer y = 188
integer taborder = 60
boolean bringtotop = true
end type

event getfocus;//sle_1.text = ''
end event

event modified;String ls_name,   ls_hakbun
Int    l_cnt

ls_name   = sle_2.text

SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM haksa.jaehak_hakjuk
 WHERE hname   = :ls_name;
IF l_cnt       = 1 THEN
	SELECT hakbun
	  INTO :ls_hakbun
	  FROM haksa.jaehak_hakjuk
	 WHERE hname    = :ls_name;
	sle_1.text      = ls_hakbun
	parent.TriggerEvent('ue_retrieve')
ELSEIF len(trim(ls_name)) = 0 THEN
		sle_2.setfocus()
		return
	ELSE
		OpenWithParm(w_hsg320pp, ls_name)
		ls_hakbun	= Message.StringParm
		IF isnull(ls_hakbun) OR ls_hakbun = '' THEN
		ELSE
			sle_1.text      = ls_hakbun
			parent.TriggerEvent('ue_retrieve')
		END IF
END IF
	
end event

type dw_2 from datawindow within w_hsg102a
event ue_key pbm_dwnkey
integer x = 37
integer y = 1312
integer width = 3803
integer height = 1184
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "상담입력"
string dataobject = "d_hsg103a_2"
boolean livescroll = true
end type

event itemchanged;String ls_year,   ls_hakgi,  ls_hakbun,  ls_caseno,  ls_tel,  ls_hp,  ls_email
String ls_member, ls_start , ls_end

ls_year     = dw_2.GetItemString(1, 'year')
ls_hakgi    = dw_2.GetItemString(1, 'hakgi')
ls_hakbun   = dw_2.GetItemString(1, 'hakbun')
ls_caseno   = dw_2.GetItemString(1, 'case_no')

CHOOSE CASE dwo.name
	CASE 'counsel_tp'
		IF data     = '2' THEN
			SELECT member_no
			  INTO :ls_member
			  FROM SUM210TL
			 WHERE YEAR     = :ls_year
			   AND HAKGI    = :ls_hakgi
				AND HAKBUN   = :ls_hakbun;		
				
			if ls_member = ''  then
				messagebox("알림", "지도교수가 존재 하지 않는 학생입니다. 상담구분을 기타상담으로 변경하세요.")
			   dw_2.SetItem(1, 'counsel_tp', '4')
				dw_2.SetItem(1, 'counseller', gstru_uid_uname.uid)

			else
				
				if	gstru_uid_uname.uid = ls_member then
					dw_2.SetItem(1, 'counseller', ls_member)
				else
					messagebox("알림", ls_hakbun + "의 학생의 지도교수가 아닙니다. 상담구분을 기타상담으로 변경하세요.")					
					dw_2.SetItem(1, 'counsel_tp', '4')
					dw_2.Dynamic Event itemchanged(row, dwo, '4')
					return 2
				end if 
  		   end if
				
      ELSE

			dw_2.SetItem(1, 'counseller', gstru_uid_uname.uid)
			dw_2.setfocus()
			dw_2.setcolumn('counsel_place')
		END IF
	
	CASE 'start_time'
		
		ls_end   = dw_2.GetItemString(1, 'end_time')
		  
		IF ls_end <= data then
         messagebox("알림", "종료 시간이 시작 시간 보다 작을 수 없습니다.")
			dw_2.SetItem(1, 'start_time', '')
			return 
		end if
		
	CASE 'end_time'
		
		ls_start   = dw_2.GetItemString(1, 'start_time')
		  
		IF ls_start >= data then
         messagebox("알림", "종료 시간이 시작 시간 보다 작을 수 없습니다.")
			dw_2.SetItem(1, 'end_time', '')
			return 
		end if
END CHOOSE
			
end event

event constructor;String ls_year,  ls_hakgi

ls_year		= em_1.text
ls_hakgi		= dw_4.gettext()

dw_2.SetTransObject(SQLCA)

//dw_2.GetChild('counseller',dwc_counseller)
//dwc_counseller.SetTransObject(SQLCA)
//dwc_counseller.InsertRow(0)
end event

event itemfocuschanged;if dwo.name = 'context' then
	dwo_name = 'context'
else
	dwo_name = ''
end if

end event

event editchanged;if dwo.name = 'context' then
	this.object.t_14.text = string(len(data))
end if

end event

type dw_4 from datawindow within w_hsg102a
integer x = 1006
integer y = 72
integer width = 576
integer height = 84
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_list_hakgi"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_hsg102a
integer x = 3136
integer y = 96
integer width = 457
integer height = 144
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "학생정보조회"
end type

event clicked;String ls_name,   ls_hakbun
Int    l_cnt

//IF dw_1.RowCount() < 1 THEN
//	messagebox("알림", '자료를 저장한 후 처리하시기 바랍니다.')
//	return
//END IF

//ls_hakbun = dw_1.GetItemString(1, 'hakbun')

ls_hakbun 	= sle_1.text

SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM HAKSA.SUM220TL
 WHERE hakbun  = :ls_hakbun;
IF l_cnt       = 0 THEN
	messagebox("알림", '학생환경기록카드의 정보등록이 안되었습니다')
	return
END IF

OpenWithParm(w_hsg102pp, ls_hakbun)

	
end event

