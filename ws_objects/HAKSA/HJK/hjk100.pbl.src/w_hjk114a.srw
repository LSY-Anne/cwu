$PBExportHeader$w_hjk114a.srw
$PBExportComments$[청운대]학점교류학생관리-신규
forward
global type w_hjk114a from w_window
end type
type dw_main from uo_grid within w_hjk114a
end type
type dw_con from uo_dw within w_hjk114a
end type
end forward

global type w_hjk114a from w_window
string title = "학점교류학생관리"
event type long ue_row_updatequery ( )
dw_main dw_main
dw_con dw_con
end type
global w_hjk114a w_hjk114a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE
String     is_sign_nm

end variables

forward prototypes
public function integer wf_validall ()
end prototypes

public function integer wf_validall ();Integer	li_rtn, i, li_row
String     ls_sign_status, ls_sign_status_nm

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next



end function

on w_hjk114a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjk114a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_postopen;call super::ue_postopen;String	ls_year, ls_hakgi, ls_admin, ls_gwa, ls_bojik_code
Long   ll_cnt = 0

func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )
dw_con.settransobject(sqlca)
dw_con.insertrow(0)

idw_update[1]	= dw_main

// dddw 값 셋팅
Vector lvc_data

lvc_data = Create Vector

lvc_data.setProperty('column1', 'isu_gb') // 이수대상구분
lvc_data.setProperty('key1', 'HJK03')

func.of_dddw( dw_con,lvc_data)

lvc_data.setProperty('column1', 'isu_gb') // 이수대상구분
lvc_data.setProperty('key1', 'HJK03')
lvc_data.setProperty('column2', 'exchange_uni') // 자매대학
lvc_data.setProperty('key2', 'HJK04')
lvc_data.setProperty('column3', 'isu_course') // 이수과정
lvc_data.setProperty('key3', 'HJK05')

func.of_dddw( dw_main,lvc_data)

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

ll_rv = This.Event ue_updatequery() 

If  (ll_rv = 1 Or ll_rv = 2) Then

	ll_rv = dw_main.Event ue_InsertRow()
	
	ls_txt = "[신규] "
	If ll_rv = 1 Then
		f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
	ElseIf ll_rv = 0 Then
		
	Else
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	End If

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

event ue_savestart;call super::ue_savestart;Long    i,  ll_cnt, ll_old_cnt, ll_rtn
String  ls_hakbun, ls_isu_gb, ls_year, ls_hakgi
dwItemStatus 	l_status

ll_rtn = Messagebox('확인', '입력한 학점교류내역을 저장하시겠습니까?', Question!, YesNo!)

If ll_rtn = 2 Then Return -1;

ll_cnt = dw_main.Rowcount()

For i = 1 To ll_cnt
    l_status = dw_main.GetItemStatus(i, 0, Primary!)
	 
	If l_status  = NewModified! Then
		ls_isu_gb  = dw_main.Object.isu_gb[i]
		ls_year     = dw_main.Object.year[i]
		ls_hakgi    = dw_main.Object.hakgi[i]
		ls_hakbun = dw_main.Object.hakbun[i]

		// 기 데이타 있는지 확인.
		SELECT COUNT(*)
			INTO :ll_old_cnt
			FROM HAKSA.HAKJUM_EXCHANGE
		 WHERE ISU_GB = :ls_isu_gb
		     AND YEAR    = :ls_year
			 AND HAKGI  = :ls_hakgi
		     AND HAKBUN = :ls_hakbun
			 AND ROWNUM = 1
		 USING SQLCA ;
		 
		If  ll_old_cnt > 0 Then
			Messagebox('확인', '기 등록된 내역이 존재합니다.')
			Return -1
		End If
		 
	End If
		 
Next

Return 1
end event

type ln_templeft from w_window`ln_templeft within w_hjk114a
end type

type ln_tempright from w_window`ln_tempright within w_hjk114a
end type

type ln_temptop from w_window`ln_temptop within w_hjk114a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hjk114a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hjk114a
end type

type ln_tempstart from w_window`ln_tempstart within w_hjk114a
end type

type uc_retrieve from w_window`uc_retrieve within w_hjk114a
end type

type uc_insert from w_window`uc_insert within w_hjk114a
end type

type uc_delete from w_window`uc_delete within w_hjk114a
end type

type uc_save from w_window`uc_save within w_hjk114a
end type

type uc_excel from w_window`uc_excel within w_hjk114a
end type

type uc_print from w_window`uc_print within w_hjk114a
end type

type st_line1 from w_window`st_line1 within w_hjk114a
end type

type st_line2 from w_window`st_line2 within w_hjk114a
end type

type st_line3 from w_window`st_line3 within w_hjk114a
end type

type uc_excelroad from w_window`uc_excelroad within w_hjk114a
end type

type dw_main from uo_grid within w_hjk114a
event type long ue_retrieve ( )
integer x = 50
integer y = 312
integer width = 4384
integer height = 1948
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk114a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_isu_gb, ls_hakbun
Long		ll_rv,          ll_row

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ll_row = dw_con.GetRow()

ls_isu_gb = dw_con.Object.isu_gb[ll_row]
ls_hakbun = func.of_nvl(dw_con.Object.hakbun[ll_row], '%')

ll_rv = This.Retrieve(ls_isu_gb, ls_hakbun, ls_hakbun )

RETURN ll_rv

end event

event itemchanged;call super::itemchanged;String ls_hakbun,  ls_hname, ls_jumin_no

Choose Case dwo.name
	Case 'hakbun'
		ls_hakbun = data
		
		SELECT HNAME
		    INTO :ls_hname
  	      FROM HAKSA.JAEHAK_HAKJUK
	     WHERE HAKBUN = :ls_hakbun
		 USING SQLCA ;
		 
		This.Object.hname[row]     = ls_hname
			
End Choose
end event

event ue_insertend;call super::ue_insertend;
This.SetFocus()
This.SetRow(al_row)
This.SetColumn("year")

Return 1
end event

type dw_con from uo_dw within w_hjk114a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk114a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;
Vector lvc_data

This.AcceptText()
lvc_data = Create Vector

Choose Case dwo.name
		
	Case 'p_emp'
		 lvc_data.setproperty('parm_cnt' , '1')		
		 lvc_data.setProperty('hakbun'  , This.object.hakbun[row] )
	 	 lvc_data.setProperty('hname'   , This.object.hname[row])
			
		If	openwithparm(w_hakjuk_pop, lvc_data) = 1 Then
			lvc_data = message.powerobjectparm
			If isvalid(lvc_data) Then
				If Long(lvc_data.GetProperty("parm_cnt")) = 0 Then RETURN ;		
				This.Object.hakbun[row]	 = lvc_data.GetProperty("hakbun1")
				This.Object.hname[row]	 = lvc_data.GetProperty("hname1")		
			End If
		End If
End Choose

Destroy lvc_data
end event

event itemchanged;call super::itemchanged;String ls_hakbun, ls_hname
vector    lvc_data

lvc_data   = create vector

Choose Case dwo.name
		
	Case 'hakbun', 'hname'
		If dwo.name = 'hakbun'  Then ls_hakbun = data ;
		If dwo.name = 'hname'  Then ls_hname  = data ;
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'   , '')
			This.Post SetItem(row, 'hname'  ,  '')
			RETURN
		End If
		
		Choose Case  f_hakjuk_search(ls_hakbun, ls_hname, lvc_data)
			Case	1
				This.Object.hakbun[row]	 = lvc_data.GetProperty('hakbun'	)
				This.Object.hname[row]  = lvc_data.GetProperty('hname'	)
					
				Return 2
			Case Else
				This.Trigger Event clicked(-1, 0, row, This.object.p_emp)
		End Choose
		
End Choose

Destroy lvc_data
end event

