$PBExportHeader$w_hpa413a.srw
$PBExportComments$new연말정산처리
forward
global type w_hpa413a from w_window
end type
type dw_main from uo_grid within w_hpa413a
end type
type dw_con from uo_dw within w_hpa413a
end type
type p_1 from picture within w_hpa413a
end type
type st_main from statictext within w_hpa413a
end type
type uo_create from uo_imgbtn within w_hpa413a
end type
end forward

global type w_hpa413a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
uo_create uo_create
end type
global w_hpa413a w_hpa413a

on w_hpa413a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.uo_create=create uo_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.uo_create
end on

on w_hpa413a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.uo_create)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_dw( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)

datawindowchild ldwc_Temp
Long ll_insrow


dw_con.GetChild('jikjong_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
	messagebox('알림', '공통코드[직종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF


dw_con.Object.jikjong_code[1] = ''
dw_con.Object.jikjong_code.dddw.PercentWidth = 100

String ls_year
ls_year = left(f_today(), 4)
ls_year = STring(long(ls_year) - 1)
dw_con.object.year[1] = ls_year


idw_update[1]	= dw_main
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

type ln_templeft from w_window`ln_templeft within w_hpa413a
end type

type ln_tempright from w_window`ln_tempright within w_hpa413a
end type

type ln_temptop from w_window`ln_temptop within w_hpa413a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hpa413a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hpa413a
end type

type ln_tempstart from w_window`ln_tempstart within w_hpa413a
end type

type uc_retrieve from w_window`uc_retrieve within w_hpa413a
end type

type uc_insert from w_window`uc_insert within w_hpa413a
end type

type uc_delete from w_window`uc_delete within w_hpa413a
end type

type uc_save from w_window`uc_save within w_hpa413a
end type

type uc_excel from w_window`uc_excel within w_hpa413a
end type

type uc_print from w_window`uc_print within w_hpa413a
end type

type st_line1 from w_window`st_line1 within w_hpa413a
end type

type st_line2 from w_window`st_line2 within w_hpa413a
end type

type st_line3 from w_window`st_line3 within w_hpa413a
end type

type uc_excelroad from w_window`uc_excelroad within w_hpa413a
end type

type dw_main from uo_grid within w_hpa413a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa413a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_year, ls_gu, ls_dept, ls_emp, ls_fr_mm, ls_to_mm
String		ls_arg2
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.year[dw_con.GetRow()]
ls_gu = dw_con.object.gu[dw_con.GetRow()]
ls_dept = dw_con.object.jikjong_code[dw_con.GetRow()]
If ls_dept = '' or isnull(ls_dept) or ls_dept = '0' Then ls_dept = '%'
ls_emp = dw_con.object.member_no[dw_con.GetRow()]
If ls_emp = '' or isnull(ls_emp) Then ls_emp = '%'



SELECT	SUBSTR(A.FDATE,1,6),	SUBSTR(A.TDATE,1,6)
	INTO	:ls_fr_mm,	:ls_to_mm
	FROM	PADB.HPA022M A  
	WHERE	A.YEAR	=	:ls_year
	USING SQLCA;
	
IF SQLCA.SQLCODE <> 0 or isnull(ls_fr_mm) or ls_fr_mm = '' Then 
	Messagebox("알림", "연말정산기간관리 테이블을 확인하세요!")
	RETURN -1
End If

f_set_message("[조회] " + '조회중입니다........', '', parentwin)
ll_rv = THIS.Retrieve(ls_year, ls_gu, ls_dept, ls_Emp, ls_fr_mm, ls_to_mm)

RETURN ll_rv

end event

type dw_con from uo_dw within w_hpa413a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa413a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
//uo_hirfunc	lvc_hirfunc
//vector		lvc_data
String		ls_h01nno	,ls_h01knm

//lvc_data		= create vector
//lvc_hirfunc	= create	uo_hirfunc
This.accepttext()
Choose Case	dwo.name
	Case	'member_no','kor_name'
		If dwo.name = 'member_no' Then	ls_h01nno = data
		If dwo.name = 'kor_name' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
			This.Post SetItem(row, 'kor_name'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_h01nno , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_h01nno || '%'
		OR NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.member_no[row] = ls_h01nno
			This.object.kor_name[row] = ls_h01knm
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			
		End If	
		
	

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

event clicked;call super::clicked;If dwo.name = 'p_search' Then
s_insa_com	lstr_com
String		ls_KName, ls_member_no
This.accepttext()
ls_KName =  trim(this.object.kor_name[1])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = ''//교직원구분

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kor_name')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.kor_name[1]        = ls_kname					//성명
This.object.member_no[1]     = ls_Member_No				//개인번호
End If
end event

type p_1 from picture within w_hpa413a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hpa413a
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
string text = "연말정산처리"
boolean focusrectangle = false
end type

type uo_create from uo_imgbtn within w_hpa413a
integer x = 50
integer y = 36
integer taborder = 20
boolean bringtotop = true
string btnname = "연말정산처리"
end type

event clicked;call super::clicked; String ls_yar, ls_gu, ls_nno, ls_dcd
 Long ll_row, ll_chk_cnt, ll_i
 uo_payfunc lvc_payfunc
 dw_con.Accepttext()
 ll_row = dw_con.Getrow()

 ls_yar = left(func.of_nvl(dw_con.GetitemString(ll_row, 'year'), ''), 4)
 ls_gu = func.of_nvl(dw_con.GetitemString(ll_row, 'gu'), '')
 ls_dcd = func.of_nvl(dw_con.GetitemString(ll_row, 'jikjong_code'), '')
 ls_nno = func.of_nvl(dw_con.GetitemString(ll_row, 'member_no'), '')
 
 If ls_yar = '' Or isnull(ls_yar) Then
	Messagebox("알림", "정산년도를 확인하세요!")
	RETURN 
End If

If ls_dcd = '' Or isnull(ls_dcd) or ls_dcd = '0' Then ls_dcd = '%'
If ls_nno = '' Or isnull(ls_nno) Then ls_nno = '%'

If dw_main.rowcount()  = 0 Then
	Messagebox("알림", "대상자 조회 후 작업하세요!")
	RETURN 
End If

 lvc_payfunc = Create uo_payfunc	

ll_chk_cnt = dw_main.GetitemNumber(1, 'chk_sum')

If ll_chk_cnt = 0 Then
	If Messagebox("알림", "선택된 대상자가 없습니다. 전체 생성 하시겠습니까?" , Exclamation!, YesNo!, 2)  = 2 Then
		RETURN   //취소
	Else  //전체생성 
		
		If	lvc_payfunc.of_year_deduction(ls_yar, ls_gu, ls_dcd, ls_nno) <> 1 Then	  //공제정보생성
					ROLLBACK USING SQLCA;
					Destroy lvc_payfunc
					RETURN 
		Else
					If	lvc_payfunc.of_year_create(ls_yar, ls_gu, ls_dcd, ls_nno) <> 1 Then	 //연말정산처리
						ROLLBACK USING SQLCA;
						Destroy lvc_payfunc
						RETURN 
					End If
		End If

//
//		For ll_i = 1 To dw_main.RowCount()   //개별 생성
//		//If dw_main.GetitemString(ll_i, 'chk' ) = 'Y' Then  //선택 시
//			ls_dcd = left(func.of_nvl(dw_main.GetitemString(ll_i, 'jikjong_code'), '%'), 1)  //부서
//			ls_nno = func.of_nvl(dw_main.GetitemString(ll_i, 'member_no'), '') //사번
//			
//			If	lvc_payfunc.of_year_deduction(ls_yar, ls_gu, ls_dcd, ls_nno) <> 1 Then	  //공제정보생성
//						ROLLBACK USING SQLCA;
//						Destroy lvc_payfunc
//						f_set_message("[연말정산] " +ls_nno + ' 연말정산처리에러발생!.', '', parentwin)
//						RETURN 
//			Else
//						If	lvc_payfunc.of_year_create(ls_yar, ls_gu, ls_dcd, ls_nno) <> 1 Then	 //연말정산처리
//							ROLLBACK USING SQLCA;
//							Destroy lvc_payfunc
//							f_set_message("[연말정산] " +ls_nno + ' 연말정산처리에러발생!.', '', parentwin)
//							RETURN 
//						End If
//			End If
//		//End If		
//	Next
	
		
   	End If

Else  //선택 건이 존재할 때
	For ll_i = 1 To dw_main.RowCount()   //개별 생성
		If dw_main.GetitemString(ll_i, 'chk' ) = 'Y' Then  //선택 시
			ls_dcd = left(func.of_nvl(dw_main.GetitemString(ll_i, 'jikjong_code'), '%'), 1)  //부서
			ls_nno = func.of_nvl(dw_main.GetitemString(ll_i, 'member_no'), '') //사번
			
			If	lvc_payfunc.of_year_deduction(ls_yar, ls_gu, ls_dcd, ls_nno) <> 1 Then	  //공제정보생성
						ROLLBACK USING SQLCA;
						Destroy lvc_payfunc
						f_set_message("[연말정산] " +ls_nno + ' 연말정산처리에러발생!.', '', parentwin)
						RETURN 
			Else
						If	lvc_payfunc.of_year_create(ls_yar, ls_gu, ls_dcd, ls_nno) <> 1 Then	 //연말정산처리
							ROLLBACK USING SQLCA;
							Destroy lvc_payfunc
							f_set_message("[연말정산] " +ls_nno + ' 연말정산처리에러발생!.', '', parentwin)
							RETURN 
						End If
			End If
		End If		
	Next
	
	
End If
 
COMMIT USING SQLCA;
f_set_message("[연말정산] " + '연말정산처리 완료!.', '', parentwin)
Destroy lvc_payfunc
end event

on uo_create.destroy
call uo_imgbtn::destroy
end on

