$PBExportHeader$w_hml205a.srw
$PBExportComments$[w_list] 마일리지장학생조회
forward
global type w_hml205a from w_window
end type
type dw_main from uo_grid within w_hml205a
end type
type dw_con from uo_dw within w_hml205a
end type
type p_1 from picture within w_hml205a
end type
type st_main from statictext within w_hml205a
end type
type uo_ok from uo_imgbtn within w_hml205a
end type
type uo_select from uo_imgbtn within w_hml205a
end type
type uo_deselect from uo_imgbtn within w_hml205a
end type
end forward

global type w_hml205a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
uo_ok uo_ok
uo_select uo_select
uo_deselect uo_deselect
end type
global w_hml205a w_hml205a

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

on w_hml205a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.uo_ok=create uo_ok
this.uo_select=create uo_select
this.uo_deselect=create uo_deselect
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.uo_ok
this.Control[iCurrent+6]=this.uo_select
this.Control[iCurrent+7]=this.uo_deselect
end on

on w_hml205a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.uo_ok)
destroy(this.uo_select)
destroy(this.uo_deselect)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.settransobject(sqlca)
dw_con.insertrow(0)

//idw_update[1]	= dw_main

dw_con.object.std_year[dw_con.getrow()] = func.of_get_sdate('YYYY')

Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'hakgi')  //학기
lvc_data.setProperty('key1', 'HSG01')

func.of_dddw( dw_con,lvc_data)



lvc_data.setProperty('column1', 'bank_id')  //은행
lvc_data.setProperty('key1', 'bank_code')

func.of_dddw( dw_main,lvc_data)

idw_print = dw_main

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

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_tempright.beginx

If uo_ok.Enabled Then
	uo_ok.X		= ll_stnd_pos - uo_ok.Width
	ll_stnd_pos		= ll_stnd_pos - uo_ok.Width - 16
Else
	uo_ok.Visible	= FALSE
End If


ll_stnd_pos    = st_main.x + st_main.width + 16

uo_select.X		= ll_stnd_pos
ll_stnd_pos		= ll_stnd_pos +  uo_select.Width + 16

uo_deselect.X		= ll_stnd_pos
ll_stnd_pos		= ll_stnd_pos +  uo_deselect.Width + 16
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1
end event

type ln_templeft from w_window`ln_templeft within w_hml205a
end type

type ln_tempright from w_window`ln_tempright within w_hml205a
end type

type ln_temptop from w_window`ln_temptop within w_hml205a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hml205a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hml205a
end type

type ln_tempstart from w_window`ln_tempstart within w_hml205a
end type

type uc_retrieve from w_window`uc_retrieve within w_hml205a
end type

type uc_insert from w_window`uc_insert within w_hml205a
end type

type uc_delete from w_window`uc_delete within w_hml205a
end type

type uc_save from w_window`uc_save within w_hml205a
end type

type uc_excel from w_window`uc_excel within w_hml205a
end type

type uc_print from w_window`uc_print within w_hml205a
end type

type st_line1 from w_window`st_line1 within w_hml205a
end type

type st_line2 from w_window`st_line2 within w_hml205a
end type

type st_line3 from w_window`st_line3 within w_hml205a
end type

type uc_excelroad from w_window`uc_excelroad within w_hml205a
end type

type dw_main from uo_grid within w_hml205a
event type long ue_retrieve ( )
integer x = 50
integer y = 392
integer width = 4389
integer height = 1800
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hml205a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_year, ls_hakgi
Long		ll_point
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.std_year[dw_con.GetRow()]
ll_point = dw_con.object.base_point[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.Getrow()]


If ls_year = '' or isnull(ls_year) Then
	Messagebox("알림", "년도를 입력하세요!")
	RETURN -1
End If

If ls_hakgi = '' or isnull(ls_hakgi) Then
	Messagebox("알림", "학기를 입력하세요!")
	RETURN -1
End If



If isnull(ll_point) or ll_point = 0 Then
	Messagebox("알림", "1회사용마일리지를 입력하세요!")
	RETURN -1
End If

ll_rv = THIS.Retrieve(ls_year,ll_point, ls_hakgi)

RETURN ll_rv

end event

type dw_con from uo_dw within w_hml205a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hml205a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type p_1 from picture within w_hml205a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hml205a
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
string text = "부처별 신청마일리지 승인"
boolean focusrectangle = false
end type

type uo_ok from uo_imgbtn within w_hml205a
integer x = 4142
integer y = 300
integer taborder = 20
boolean bringtotop = true
string btnname = "확정"
end type

on uo_ok.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String		ls_year, ls_yn, ls_bank_id, ls_account_name, ls_account_no, ls_hakgi, ls_hakbun, ls_err
Long		ll_point, ll_row, ll_approval_point, ll_cnt

If dw_main.rowcount() = 0 Then RETURN 

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN 
End If

ls_year = dw_con.object.std_year[dw_con.GetRow()]
ll_point = dw_con.object.base_point[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.Getrow()]


If ls_year = '' or isnull(ls_year) Then
	Messagebox("알림", "년도를 입력하세요!")
	RETURN
End If

If ls_hakgi = '' or isnull(ls_hakgi) Then
	Messagebox("알림", "학기를 입력하세요!")
	RETURN
End If

If isnull(ll_point) or ll_point = 0 Then
	Messagebox("알림", "1회사용마일리지를 입력하세요!")
	RETURN
End If


For ll_row = 1 To dw_main.rowcount()
	ls_yn = dw_main.object.chk[ll_row]
	
	If ls_yn = 'Y' then
		
		ll_cnt ++
		
		ls_hakbun = dw_main.object.hakbun[ll_row]
		ll_approval_point = dw_main.object.approval_point[ll_row]
		
		ll_approval_point = ll_approval_point - ll_point
		
		
		 ls_bank_id = dw_main.object.bank_id[ll_row]
		 ls_account_name = dw_main.object.account_name[ll_row]
		 ls_account_no = dw_main.object.account_no[ll_row]
		
		INSERT INTO HAKSA.POINT_BENEFIT
		(HAKBUN       ,BENEFIT_YEAR       ,HAKGI       ,BENEFIT_POINT       ,REMAIND_POINT
		       ,BANK_CD		       ,ACCOUNT_NAME	       ,ACCOUNT_NO		       ,WORKER
		       ,IPADDR		       ,WORK_DATE		       ,JOB_UID		       ,JOB_ADD		       ,JOB_DATE)
		VALUES(:ls_hakbun,   :ls_year,   :ls_hakgi,    :ll_point,  :ll_approval_point
		      ,:ls_bank_id,	:ls_account_name,	:ls_account_no,	:gs_empcode,
		      :gs_ip,	sysdate, :gs_empcode, :gs_ip, sysdate)
		USING SQLCA;
		
		If SQLCA.SQLCODE <> 0 Then
			ls_err = SQLCA.SQLERRTEXT
			Rollback using sqlca;
			Messagebox("알림", ls_err)
			RETURN 
		
		End If
				
		
	End If
	
Next

If ll_cnt > 0 Then
	Commit using sqlca;
	Messagebox("알림", "확정 완료!")
	parent.event ue_inquiry()
Else
	Messagebox("알림", "선택 후 확정 바랍니다!")
	RETURN
End If



end event

type uo_select from uo_imgbtn within w_hml205a
integer x = 1257
integer y = 300
integer taborder = 30
boolean bringtotop = true
string btnname = "전체선택"
end type

event clicked;call super::clicked;String		ls_yn
Long		ll_row


If dw_main.rowcount() = 0 Then RETURN 

For ll_row = 1 To dw_main.rowcount()
	dw_main.object.chk[ll_row] = 'Y'
Next


end event

on uo_select.destroy
call uo_imgbtn::destroy
end on

type uo_deselect from uo_imgbtn within w_hml205a
integer x = 1623
integer y = 300
integer taborder = 40
boolean bringtotop = true
string btnname = "선택해제"
end type

event clicked;call super::clicked;String		ls_yn
Long		ll_row


If dw_main.rowcount() = 0 Then RETURN 

For ll_row = 1 To dw_main.rowcount()
	dw_main.object.chk[ll_row] = 'N'
Next


end event

on uo_deselect.destroy
call uo_imgbtn::destroy
end on

