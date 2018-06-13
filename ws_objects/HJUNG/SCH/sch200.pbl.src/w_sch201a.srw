$PBExportHeader$w_sch201a.srw
$PBExportComments$[w_list]사생모집단위설정등록
forward
global type w_sch201a from w_window
end type
type dw_main from uo_grid within w_sch201a
end type
type dw_con from uo_dw within w_sch201a
end type
type p_1 from picture within w_sch201a
end type
type st_main from statictext within w_sch201a
end type
end forward

global type w_sch201a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
end type
global w_sch201a w_sch201a

forward prototypes
public function integer wf_validall ()
public function integer wf_dup_check (string as_house_gb, string as_std_year, string as_recruit_no)
end prototypes

public function integer wf_validall ();Integer	I, li_cnt
dwItemStatus 	l_status
String	ls_house_gb, ls_year, ls_no

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

// 해당 등록된 자료를 확인하여 신규입력된 자료인 경우, Dup Check를 한다.
For I = 1 To dw_main.RowCount()
	l_status = func.of_getrowstatus(dw_main, I)
	
	If l_status = NewModified! Then
		
		ls_house_gb	= dw_main.Object.house_gb[i]
		ls_year		= dw_main.Object.std_year[i]
		ls_no			= dw_main.Object.recruit_no[i]
	
		SELECT Count(*)
		INTO		:li_cnt
		FROM		SCH.SAZ210T
		WHERE	HOUSE_GB	= :ls_house_gb
		AND		STD_YEAR	= :ls_year
		AND		RECRUIT_NO = :ls_no
		USING SQLCA ;
		
		If li_cnt > 0 Then
			MessageBox("확인",String(i) + "번째 Row의 배정번호는 기 존재하는 번호입니다. 재부여해주십시요")
			dw_main.Object.recruit_no[i] = ''
			Return -1			
		End If
		
	End If
Next

Return 1
end function

public function integer wf_dup_check (string as_house_gb, string as_std_year, string as_recruit_no);Integer	li_cnt

SELECT 	Count(*)
INTO		:li_cnt
FROM		SCH.SAZ210T
WHERE	HOUSE_GB 	= :as_house_gb
AND		STD_YEAR	= :as_std_year
AND		RECRUIT_NO	= :as_recruit_no
USING SQLCA ;

If li_cnt > 0 Then
	Return -1
Else
	Return 1
End If
end function

on w_sch201a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
end on

on w_sch201a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)

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

// 공통코드 Setup
Vector lvc_data

lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
lvc_data.setProperty('column2', 'hakjuk_gb')  //학적구분
lvc_data.setProperty('key2', 'SAZ08')
lvc_data.setProperty('column3', 'enter_term')  //입사기간
lvc_data.setProperty('key3', 'SAZ29')
lvc_data.setProperty('column4', 'sex')  //성별
lvc_data.setProperty('key4', 'sex_code')
lvc_data.setProperty('column5', 'door_ty')  //지원실
lvc_data.setProperty('key5', 'SAZ36')

func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)

// 초기값 Setup
dw_con.Object.std_year[dw_con.GetRow()] 		= func.of_get_sdate('yyyy')
dw_con.Object.notice_dt[dw_con.GetRow()] 	= func.of_get_sdate('yyyy') + '0101'

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

type ln_templeft from w_window`ln_templeft within w_sch201a
end type

type ln_tempright from w_window`ln_tempright within w_sch201a
end type

type ln_temptop from w_window`ln_temptop within w_sch201a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch201a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch201a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch201a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch201a
end type

type uc_insert from w_window`uc_insert within w_sch201a
end type

type uc_delete from w_window`uc_delete within w_sch201a
end type

type uc_save from w_window`uc_save within w_sch201a
end type

type uc_excel from w_window`uc_excel within w_sch201a
end type

type uc_print from w_window`uc_print within w_sch201a
end type

type st_line1 from w_window`st_line1 within w_sch201a
end type

type st_line2 from w_window`st_line2 within w_sch201a
end type

type st_line3 from w_window`st_line3 within w_sch201a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch201a
end type

type dw_main from uo_grid within w_sch201a
event type long ue_retrieve ( )
integer x = 50
integer y = 384
integer width = 4389
integer height = 1880
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch201a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

event type long ue_retrieve();String		ls_house_gb, ls_year, ls_notice_dt
Long			ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_house_gb 	= dw_con.Object.house_gb[dw_con.GetRow()]
ls_year 			= dw_con.Object.std_year[dw_con.GetRow()]
ls_notice_dt	= dw_con.Object.notice_dt[dw_con.GetRow()]

If ls_year = '' Or IsNull(ls_year) Then
	MessageBox("확인","학년도를 선택하셔야 합니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('std_year')
	Return 0
End If

dw_main.SetRedraw(False)
dw_main.Reset()
ll_rv = This.Retrieve(ls_house_gb, ls_year, ls_notice_dt)

dw_main.SetRedraw(True)

RETURN ll_rv

end event

event itemchanged;call super::itemchanged;String		ls_house_gb, ls_std_year, ls_recruit_no 
Integer		li_find

Choose Case dwo.Name
	Case 'house_gb', 'std_year', 'recruit_no'
		ls_house_gb = This.Object.house_gb[row]
		ls_std_year = This.Object.std_year[row]
		ls_recruit_no = This.Object.recruit_no[row]
				
		If (ls_house_gb = '' Or IsNull(ls_house_gb)) Or (ls_std_year = '' Or IsNull(ls_std_year)) Or (ls_recruit_no = '' Or IsNull(ls_recruit_no)) Then
		Else
			li_find = This.Find("house_gb = '" + ls_house_gb + "' and std_year = '" + ls_std_year + "' and recruit_no = '" + ls_recruit_no + "'", 1, row - 1)
			If li_find > 0 Then
				MessageBox("확인","해당 모집정보가 존재합니다. 조회후, 정보를 수정하십시요.")
				Data = ''
				This.Object.recruit_no[row] = ''
				Return 2
			End If
			
			If wf_dup_check(ls_house_gb, ls_std_year, ls_recruit_no) < 0 Then
				MessageBox("확인","해당 모집정보가 존재합니다. 조회후, 정보를 수정하십시요.")
				Return 2
			End If
		End If
End Choose

end event

event ue_insertend;call super::ue_insertend;String	ls_house_gb, ls_std_year

ls_house_gb = dw_con.Object.house_gb[dw_con.GetRow()]
ls_std_year = dw_con.Object.std_year[dw_con.GetRow()]

This.Object.house_gb[al_row] = ls_house_gb
This.Object.std_year[al_row] = ls_std_year
This.Object.notice_dt[al_row] = func.of_get_sdate('yyyymmdd')

Return 1
end event

type dw_con from uo_dw within w_sch201a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch201a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type p_1 from picture within w_sch201a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_sch201a
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
string text = "모집공고 정보등록"
boolean focusrectangle = false
end type

