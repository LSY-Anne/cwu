$PBExportHeader$w_sch306a.srw
$PBExportComments$하자보수처리결과등록
forward
global type w_sch306a from w_window
end type
type dw_main from uo_grid within w_sch306a
end type
type dw_con from uo_dw within w_sch306a
end type
type p_1 from picture within w_sch306a
end type
type st_main from statictext within w_sch306a
end type
type uo_sms from uo_imgbtn within w_sch306a
end type
end forward

global type w_sch306a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
uo_sms uo_sms
end type
global w_sch306a w_sch306a

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

on w_sch306a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.uo_sms=create uo_sms
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.uo_sms
end on

on w_sch306a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.uo_sms)
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
Vector		lvc_data

lvc_data = Create Vector

lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
lvc_data.setProperty('column2', 'process_gb')  //처리상태
lvc_data.setProperty('key2', 'SAZ31')

func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)

// 초기값 Setup
dw_con.Object.from_date[dw_con.GetRow()] 	= func.of_get_sdate('yyyy') + '0101'
dw_con.Object.to_date[dw_con.GetRow()] 	= func.of_get_sdate('yyyymmdd')
dw_con.Object.process_gb[dw_con.GetRow()] = '01'

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

event ue_button_set;call super::ue_button_set;uo_sms.x = ln_tempright.beginx - uo_sms.width
end event

type ln_templeft from w_window`ln_templeft within w_sch306a
end type

type ln_tempright from w_window`ln_tempright within w_sch306a
end type

type ln_temptop from w_window`ln_temptop within w_sch306a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch306a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch306a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch306a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch306a
end type

type uc_insert from w_window`uc_insert within w_sch306a
end type

type uc_delete from w_window`uc_delete within w_sch306a
end type

type uc_save from w_window`uc_save within w_sch306a
end type

type uc_excel from w_window`uc_excel within w_sch306a
end type

type uc_print from w_window`uc_print within w_sch306a
end type

type st_line1 from w_window`st_line1 within w_sch306a
end type

type st_line2 from w_window`st_line2 within w_sch306a
end type

type st_line3 from w_window`st_line3 within w_sch306a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch306a
end type

type dw_main from uo_grid within w_sch306a
event type long ue_retrieve ( )
integer x = 50
integer y = 408
integer width = 4389
integer height = 1856
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch306a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_house_gb, ls_from_date, ls_to_date, ls_process_gb
Long		li_row, ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

li_row = dw_con.GetRow()

ls_house_gb = dw_con.object.house_gb[li_row]
ls_from_date = dw_con.object.from_date[li_row]
ls_to_date = dw_con.object.to_date[li_row]
ls_process_gb = dw_con.object.process_gb[li_row]


ll_rv = THIS.Retrieve(ls_house_gb, ls_from_date, ls_to_date, ls_process_gb)

RETURN ll_rv

end event

type dw_con from uo_dw within w_sch306a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch306a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type p_1 from picture within w_sch306a
integer x = 50
integer y = 340
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_sch306a
integer x = 114
integer y = 324
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
string text = "하자보수신청 처리내역등록"
boolean focusrectangle = false
end type

type uo_sms from uo_imgbtn within w_sch306a
integer x = 4142
integer y = 308
integer taborder = 100
boolean bringtotop = true
string btnname = "SMS전송"
end type

event clicked;call super::clicked;Long ll_row
String ls_fname, ls_tel_no, ls_hname, ls_hp

dw_main.accepttext()

If dw_main.rowcount() = 0 Then RETURN 
ll_row = dw_main.getrow()

ls_hname = dw_main.object.hname[ll_row]
ls_hp = func.of_replace(trim(dw_main.object.contact_no[ll_row]), '-', '')



If ls_hp = '' or isnull(ls_hp) Then RETURN


SELECT FNAME, ETC_CD1 
INTO :ls_fname, :ls_tel_no
FROM CDDB.KCH102D 
WHERE UPPER(CODE_GB) = 'COM01' 
AND  CODE = 'cwuhouse'
USING SQLCA;


String 		ls_msg 
long		TYPE_VALUE = 1
long		TYPE_FILE = 2
parameters	param

param.serverurl = "http://sms.chungwoon.ac.kr/smssend.jsp"

SELECT remark
INTO :ls_msg
FROM CDDB.KCH102D 
WHERE UPPER(CODE_GB) = 'SAZ42' 
AND  CODE = '0004'
USING SQLCA;

ls_msg =  '[' + ls_fname + '] ' + ls_msg


param.parameter[1].param = "USER_ID"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = ls_fname

// 보내는이
param.parameter[2].param = "CALLBACK"
param.parameter[2].param_type = TYPE_VALUE
param.parameter[2].data = ls_tel_no

// 메세지 보낼 전화번호 갯수
param.parameter[3].param = "DEST_COUNT"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = "1"  

// 받는이
param.parameter[3].param = "DEST_INFO"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = ls_hname + '^' + ls_hp //"박구석^01093713219|이주연^0173909690"  // 박구석^01093713219|이주연^0173909690

// 메시지
param.parameter[4].param = "SMS_MSG"
param.parameter[4].param_type = TYPE_VALUE
param.parameter[4].data = ls_msg

postsendurl(param, ls_msg)
//messagebox("", postsendurl(param, ls_msg))
//messagebox("Info", ls_msg)
//
//
//Long i, ll_cnt
//ll_cnt = UpperBound(param.parameter)
//String ls_parm
//
//FOR i = 1 TO ll_cnt
//	ls_parm += param.parameter[i].param + "=" + param.parameter[i].data
//	IF i < ll_cnt THEN
//		ls_parm += "&"
//	END IF
//NEXT
//sessioncheck("http://sms.chungwoon.ac.kr/smssend", ls_parm, 1, ls_msg)
end event

on uo_sms.destroy
call uo_imgbtn::destroy
end on

