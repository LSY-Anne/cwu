$PBExportHeader$w_hsg104a.srw
$PBExportComments$[w_list] 학생지도교수등록
forward
global type w_hsg104a from w_window
end type
type dw_main from uo_grid within w_hsg104a
end type
type dw_con from uo_dw within w_hsg104a
end type
type p_1 from picture within w_hsg104a
end type
type st_main from statictext within w_hsg104a
end type
type uo_copy from uo_imgbtn within w_hsg104a
end type
end forward

global type w_hsg104a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
uo_copy uo_copy
end type
global w_hsg104a w_hsg104a

forward prototypes
public function integer wf_validall ()
end prototypes

public function integer wf_validall ();Integer	li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

end function

on w_hsg104a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.uo_copy=create uo_copy
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.uo_copy
end on

on w_hsg104a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.uo_copy)
end on

event ue_postopen;call super::ue_postopen;String	ls_year, ls_hakgi, ls_admin

func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )
dw_con.settransobject(sqlca)
dw_con.insertrow(0)

idw_update[1]	= dw_main

Vector lvc_data
uo_hsfunc hsfunc

lvc_data = Create Vector
hsfunc = Create uo_hsfunc

lvc_data.setProperty('column1', 'hakgi')  //학기
lvc_data.setProperty('key1', 'HSG01')

func.of_dddw( dw_con,lvc_data)

// 초기 Value Setup - 해당 상담관리에서 사용하는 최종 연도및학기를 확인한다.
hsfunc.of_get_yearhakgi('SUM', lvc_data)

ls_year = lvc_data.GetProperty('year')
ls_hakgi = lvc_data.GetProperty('hakgi')

If ls_year = '' Or IsNull(ls_year) Then
	dw_con.object.hakyear[dw_con.getrow()] = func.of_get_sdate('yyyy')
Else
	dw_con.object.hakyear[dw_con.getrow()] = ls_year
	dw_con.Object.hakgi[dw_con.getrow()] = ls_hakgi
End If

DataWindowChild	ldwc_Temp
dw_main.GetChild('prof_gwa',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	messagebox('알림','부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	Long	ll_InsRow
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','')
	ldwc_Temp.SetSort('gwa ASC')
	ldwc_Temp.Sort()
END IF

idw_print = dw_main

SELECT CODE
INTO :ls_admin
FROM CDDB.KCH102D 
WHERE UPPER(CODE_GB) = 'SUM99'
AND CODE = :gs_empcode
USING SQLCA;

If ls_admin = '' or isnull(ls_admin) Then
	dw_con.object.gwa[dw_con.getrow()] = gs_deptcode
	dw_con.object.gwa.protect = 1
	uo_copy.of_enable(false)
End If

//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_update[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_main

//Excel로부터 IMPORT 할 DataWindow가 있으면 지정
//If uc_excelroad.Enabled Then
//	idw_excelload	=	dw_main
//	is_file_name	=	'우편번호'
//	is_col_name[]	=	{'우편번호', '시도명', '시군구명', '읍면동명', '리명', '도서명', '번지', '아파트/건물명', '상세주소'}
//End If

//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

end event

event ue_insert;call super::ue_insert;Long		ll_rv
String		ls_txt

ll_rv = dw_main.Event ue_InsertRow()

ls_txt = "[신규] "
If ll_rv = 1 Then
	f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If

end event

event ue_delete;call super::ue_delete;Long		ll_rv
String		ls_txt

ll_rv = dw_main.Event ue_DeleteRow()

ls_txt = "[삭제] "
If ll_rv = 1 Then
	If Trigger Event ue_save() <> 1 Then
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	Else
		f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
	End If
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If

end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = This.Event ue_updatequery() 
If ll_rv <> 1 And ll_rv <> 2 Then RETURN -1

SetPointer(HourGlass!)
If ib_retrieve_wait Then
	gf_openwait()
End If
ll_rv = dw_main.Event ue_Retrieve()
If ll_rv > 0 Then
	f_set_message("[조회] " + String(ll_rv) + '건의 자료가 조회되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	f_set_message("[조회] " + '자료가 없습니다.', '', parentwin)
Else
	f_set_message("[조회] " + '오류가 발생했습니다.', '', parentwin)
End If
If ib_retrieve_wait Then
	gf_closewait()
End If
SetPointer(Arrow!)
ib_excl_yn = FALSE

RETURN ll_rv

end event

event ue_save;int	 li_ans,    ii,         l_cnt
String ls_member, ls_hakbun,  ls_year,  ls_hakgi,   ls_chk,  ls_hakyun
dwItemStatus	lsStatus

dw_main.AcceptText()

FOR ii      = 1 TO dw_main.RowCount()
	 ls_year      = dw_main.GetItemString(ii, 'year')
	 ls_hakgi     = dw_main.GetItemString(ii, 'hakgi')
	 ls_member    = dw_main.GetItemString(ii, 'member_no')
	 ls_hakbun    = dw_main.GetItemString(ii, 'hakbun')
	 ls_chk       = dw_main.GetItemString(ii, 'chk')
	 IF ls_chk    = 'Y' THEN
		 IF isnull(ls_member) OR ls_member = '' THEN
			 messagebox("저장", '지도교수를 선택하시기 바랍니다.')
			 dw_main.SetColumn('member_no')
          dw_main.SetFocus()
          dw_main.ScrollToRow(ii)
			 return -1
		 END IF
		 SELECT nvl(count(*), 0)
		   INTO :l_cnt
			FROM haksa.prof_sym
		  WHERE member_no  = :ls_member;
		 IF l_cnt  = 0 THEN
			 messagebox("저장", '해당 지도교수코드가 등록되지 않았습니다.')
			 dw_main.SetColumn('member_no')
          dw_main.SetFocus()
          dw_main.ScrollToRow(ii)
			 return -1
		 END IF
	 END IF
NEXT

FOR ii      = 1 TO dw_main.RowCount()
	 ls_year      = dw_main.GetItemString(ii, 'year')
	 ls_hakgi     = dw_main.GetItemString(ii, 'hakgi')
	 ls_member    = dw_main.GetItemString(ii, 'member_no')
	 ls_hakbun    = dw_main.GetItemString(ii, 'hakbun')
	 ls_chk       = dw_main.GetItemString(ii, 'chk')
	 ls_hakyun    = dw_main.GetItemString(ii, 'dr_hakyun')
	 lsStatus     = dw_main.GetItemStatus(ii, 0, Primary!)
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


This.TriggerEvent('ue_retrieve')
//li_ans = dw_main.update()		//	자료의 저장

//IF li_ans = -1  THEN
//	ROLLBACK USING SQLCA;
//	uf_messagebox(3)       	//	저장오류 메세지 출력
//
//ELSE
//	COMMIT USING SQLCA;
//	uf_messagebox(2)       //	저장확인 메세지 출력
//END IF
end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "학생별 지도교수")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_window`ln_templeft within w_hsg104a
end type

type ln_tempright from w_window`ln_tempright within w_hsg104a
end type

type ln_temptop from w_window`ln_temptop within w_hsg104a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hsg104a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hsg104a
end type

type ln_tempstart from w_window`ln_tempstart within w_hsg104a
end type

type uc_retrieve from w_window`uc_retrieve within w_hsg104a
end type

type uc_insert from w_window`uc_insert within w_hsg104a
end type

type uc_delete from w_window`uc_delete within w_hsg104a
end type

type uc_save from w_window`uc_save within w_hsg104a
end type

type uc_excel from w_window`uc_excel within w_hsg104a
end type

type uc_print from w_window`uc_print within w_hsg104a
end type

type st_line1 from w_window`st_line1 within w_hsg104a
end type

type st_line2 from w_window`st_line2 within w_hsg104a
end type

type st_line3 from w_window`st_line3 within w_hsg104a
end type

type uc_excelroad from w_window`uc_excelroad within w_hsg104a
end type

type dw_main from uo_grid within w_hsg104a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg104a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_year, ls_hakgi, ls_gwa, ls_member_no, ls_hakbun
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.hakyear[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.GetRow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.getrow()], '%')
ls_member_no = func.of_nvl(dw_con.object.member_no[dw_con.getrow()], '%')
ls_hakbun = func.of_nvl(dw_con.object.hakbun[dw_con.getrow()], '%')

//IF isnull(ls_member_no) OR ls_member_no = '' THEN
//	messagebox("조회", '교수를 선택한 후 조회하시기 바랍니다.')
//	return -1
//END IF
//
IF isnull(ls_hakgi) OR ls_hakgi = '' THEN
	messagebox("조회", '학기를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

If ls_gwa = '%' and ls_member_no = '%' and ls_hakbun = '%' Then
	Messagebox("알림", "학과,교수명,학번 중 한 가지 이상 선택하세요!")
	RETURN -1
End If

//IF isnull(ls_gwa) OR ls_gwa = '' THEN
//	messagebox("조회", '학과를 선택한 후 조회하시기 바랍니다.')
//	return -1
//END IF

////전산정보원은 다 볼수 있도록
//IF	mid(gs_deptcode, 1, 3) = '290'  or gs_empcode = 'admin'THEN
	ll_rv = THIS.Retrieve(ls_year, ls_hakgi, ls_gwa, ls_member_no, ls_hakbun)	
//ELSEIF mid(ls_gwa, 1, 3) = mid(gstru_uid_uname.dept_code, 1, 3)THEN
//	ll_rv = THIS.Retrieve(ls_year, ls_hakgi, ls_gwa, ls_member_no)
//ELSE
//	MESSAGEBOX('확인', '타과는 조회가 불가능합니다.')
//	return -1
//END IF


RETURN ll_rv

end event

event itemchanged;call super::itemchanged;String ls_member
String ls_phone1, ls_phone2, ls_phone3, ls_cell1, ls_cell2, ls_cell3, ls_email, ls_gwa

dw_con.accepttext()
ls_member   = func.of_nvl(dw_con.object.member_no[dw_con.getrow()], '')

If ls_member = '' or isnull(ls_member) Then RETURN -1

SELECT C.HOME_PHONENO1    ,C.HOME_PHONENO2       ,C.HOME_PHONENO3
       ,C.CELL_PHONENO1       ,C.CELL_PHONENO2       ,C.CELL_PHONENO3       ,C.EMAIL_ID        , D.GWA
       INTO :ls_phone1, :ls_phone2, :ls_phone3, :ls_cell1, :ls_cell2, :ls_cell3, :ls_email, :ls_gwa
    FROM   INDB.HIN011M C, INDB.HIN001M D
    WHERE C.MEMBER_NO = D.MEMBER_NO
    AND C.MEMBER_NO = :ls_member ;
    

CHOOSE CASE dwo.name
	CASE 'member_no'
		IF isnull(data) OR data = '' THEN
		         This.SetItem(row, 'chk', 'N')
		ELSE
			This.SetItem(row, 'chk', 'Y')
	   END IF
	CASE 'chk'
		IF data      = 'Y' THEN
			This.SetItem(row, 'member_no', ls_member)
			This.Setitem(row, 'prof_gwa' , ls_gwa)
			This.setitem(row, 'home_phoneno1' , ls_phone1)
			This.setitem(row, 'home_phoneno2' , ls_phone2)
			This.setitem(row, 'home_phoneno3' , ls_phone3)
			This.setitem(row, 'cell_phoneno1' , ls_cell1)
			This.setitem(row, 'cell_phoneno2' , ls_cell2)
			This.setitem(row, 'cell_phoneno3' , ls_cell3)
			This.setitem(row, 'email_id' , ls_email)
			
		ELSE
			This.SetItem(row, 'member_no', '')
			This.Setitem(row, 'prof_gwa' , '')
			This.setitem(row, 'home_phoneno1' , '')
			This.setitem(row, 'home_phoneno2' , '')
			This.setitem(row, 'home_phoneno3' , '')
			This.setitem(row, 'cell_phoneno1' , '')
			This.setitem(row, 'cell_phoneno2' , '')
			This.setitem(row, 'cell_phoneno3' , '')
			This.setitem(row, 'email_id' , '')
		END IF
END CHOOSE
end event

type dw_con from uo_dw within w_hsg104a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg104a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
If this.Describe("hakbun.Protect") = '1' Then return 	-1
s_insa_com	lstr_com
String		ls_KName, ls_hakbun
This.accepttext()
ls_KName =  trim(this.object.kname[1])



OpenWithParm(w_hsg_hakjuk,ls_kname)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[2]	//성명
ls_hakbun            = lstr_com.ls_item[1]	//학번
this.object.kname[1]        = ls_kname					//성명
This.object.hakbun[1]     = ls_hakbun				//개인번호
Parent.post event ue_inquiry()	
return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_kname

This.accepttext()
Choose Case	dwo.name
	Case	'hakbun','kname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'kname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'kname'	, '')			
			RETURN
		End If
		
		SELECT HAKBUN, HNAME
		INTO :ls_hakbun , :ls_kname
		FROM  (	SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JAEHAK_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JOLUP_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.D_HAKJUK	A	)	A
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_kname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.hakbun[row] = ls_hakbun
			This.object.kname[row] = ls_kname
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
End Choose


end event

type p_1 from picture within w_hsg104a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hsg104a
integer x = 114
integer y = 312
integer width = 1051
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "검색결과"
boolean focusrectangle = false
end type

type uo_copy from uo_imgbtn within w_hsg104a
integer x = 55
integer y = 36
integer taborder = 20
boolean bringtotop = true
string btnname = "이전학기자료복사"
end type

event clicked;call super::clicked;String		ls_year, ls_bef_year, ls_err, ls_hakgi, ls_bef_hakgi
String		ls_hakgwa, ls_member
Long		ll_rv, ll_cnt

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN 
End If

ls_year = dw_con.object.hakyear[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.Getrow()]
ls_hakgwa = dw_con.object.gwa[dw_con.Getrow()]
ls_member = func.of_nvl(dw_con.object.member_no[dw_con.Getrow()], '%') + '%'

If ls_year = '' Or isnull(ls_year) Then
	
	Messagebox("알림", "학년도를 입력하세요!")
	RETURN 
End If

If ls_hakgi = '' or isnull(ls_hakgi) Then
	Messagebox("알림", "학기를 입력하세요!")
	RETURN
End If


//IF isnull(ls_hakgwa) OR ls_hakgwa = '' THEN
//	messagebox("알림", '학과를 선택한 후 작업하시기 바랍니다.')
//	return
//END IF

//IF isnull(ls_member) OR ls_member = '' THEN
//	messagebox("알림", '교수를 선택한 후 작업하시기 바랍니다.')
//	return
//END IF


If ls_hakgi = '1' Then
	ls_bef_year = String(long(ls_year) - 1)
	ls_bef_hakgi = '2'
Elseif ls_hakgi = '2' Then
	ls_bef_year = ls_year
	ls_bef_hakgi = '1'
End If


//IF mid(ls_hakgwa, 1, 3) = mid(gs_deptcode, 1, 3) THEN
//
//ELSE
//	MESSAGEBOX('확인', '타과는 복사가 불가능합니다.')
//	return 
//END IF



SELECT nvl(count(*), 0)
  INTO :ll_cnt
  FROM SUM210TL
 WHERE year     	= :ls_bef_year
   AND hakgi    	= :ls_bef_hakgi
   AND member_no  like :ls_member ;

IF ll_cnt        = 0 THEN
	messagebox("알림", '이전 학기의 자료가 없습니다')
	return
END IF




SELECT COUNT(*)
INTO :ll_cnt
FROM HAKSA.SUM210TL
WHERE YEAR = :ls_year
ANd HAKGI = :ls_hakgi
AND MEMBER_NO like :ls_member
USING SQLCA;

If ll_cnt > 0 then
	If Messagebox("알림", "해당년도/학기 자료가 존재합니다! 삭제후 다시 복사하시겠습니까?",    Exclamation!, YesNo!, 2) = 1 Then
	
		DELETE
		FROM HAKSA.SUM210TL
		WHERE YEAR = :ls_year
		AND HAKGI = :ls_hakgi
		AND MEMBER_NO like :ls_member
		USING SQLCA;	
		
		If SQLCA.SQLCODE <> 0 Then
			ls_err = SQLCa.SQLERRTEXT
			Rollback using sqlca;
			Messagebox("알림", ls_err)
			return 	
		End If
	Else
		RETURN 
	End If

End If


 INSERT INTO HAKSA.SUM210TL (YEAR,         HAKGI,       MEMBER_NO,     HAKBUN,
				  WORKER,
				  WORK_DATE,    IPADDR)
SELECT :ls_year, :ls_hakgi, MEMBER_NO, HAKBUN,
:gs_empcode, sysdate, :gs_ip
FROM HAKSA.SUM210TL
WHERE YEAR = :ls_bef_year
AND HAKGI = :ls_bef_hakgi
AND MEMBER_NO like :ls_member
USING SQLCA;

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCa.SQLERRTEXT
	Rollback using sqlca;
	Messagebox("알림", ls_err)
	return 
Else
	Commit using sqlca;
	Messagebox("알림", "이전학기 자료 복사 완료!")
	parent.post event ue_inquiry()
End If

end event

on uo_copy.destroy
call uo_imgbtn::destroy
end on

