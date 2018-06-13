$PBExportHeader$w_hyk304p.srw
$PBExportComments$[w_list] 교원업적평가표
forward
global type w_hyk304p from w_window
end type
type dw_main from uo_grid within w_hyk304p
end type
type dw_con from uo_dw within w_hyk304p
end type
type p_1 from picture within w_hyk304p
end type
type st_main from statictext within w_hyk304p
end type
type dw_print from datawindow within w_hyk304p
end type
end forward

global type w_hyk304p from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
dw_print dw_print
end type
global w_hyk304p w_hyk304p

forward prototypes
public function integer wf_validall ()
end prototypes

public function integer wf_validall ();Integer	li_rtn, i

//For I = 1 To UpperBound(idw_update)
//	If func.of_checknull(idw_update[i]) = -1 Then
//		Return -1
//	End If
//Next
return 1

end function

on w_hyk304p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.dw_print
end on

on w_hyk304p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.dw_print)
end on

event ue_postopen;call super::ue_postopen;String ls_evl_ym, ls_emp
//
//SELECT CODE
//INTO :ls_emp
//FROM CDDB.KCH102D
//WHERE CODE_GB = 'HYK99'
//AND CODE = :gs_empcode
//USING SQLCA;
//
//If SQLCA.SQLCODE <> 0 Or ls_emp = '' Or isnull(ls_emp) Then 
//
//	
//	dw_con.Setitem(dw_con.Getrow(), 'member_no', gs_empcode)
//	dw_con.Setitem(dw_con.Getrow(), 'kname', gs_empname)
//	dw_con.object.member_no.protect = 1
//	dw_con.object.kname.protect = 1
//
//	
//End If


func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)

Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'appoint_gb')  //임용구분
lvc_data.setProperty('key1', 'HYK02')
func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)

select CODE
INTO :ls_evl_ym
from cddb.kch102d
where code_gb = 'HYK00'
AND USE_YN = 'Y'
USING SQLCA;

dw_con.object.evl_ym[dw_con.getrow()] = ls_evl_ym

//SELECT CODE
//INTO :ls_emp
//FROM CDDB.KCH102D
//WHERE CODE_GB = 'HYK99'
//AND CODE = :gs_empcode
//USING SQLCA;
//
//If SQLCA.SQLCODE <> 0 Or ls_emp = '' Or isnull(ls_emp) Then 
//	is_magam = 'Y'
////	is_magam = 'N'
//	
//	dw_con.Setitem(dw_con.Getrow(), 'member_no', gs_empcode)
//	dw_con.Setitem(dw_con.Getrow(), 'kname', gs_empname)
//	dw_con.object.member_no.protect = 1
//	dw_con.object.kname.protect = 1
//Else
////If gs_empcode = 'F0016' Or gs_empcode = 'admin'  Then
//	is_magam = 'N'


idw_update[1]	= dw_main

idw_print = dw_print
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

event ue_savestart;call super::ue_savestart;String ls_evl_ym, ls_member_no, ls_mng_no, ls_evl_ym1
Long l_mng_no
Long ll_row, ll_rowcnt

if dw_main.rowcount() = 0 Then return -1
ls_evl_ym = dw_con.object.evl_ym[dw_con.GetRow()]
ls_member_no = dw_con.object.member_no[dw_con.GetRow()]


select lpad((to_number(nvl(max(substr(mng_no,10,3)), 0))) + 1, 3,'0') 
into :l_mng_no
from ygdb.hyk205t
where mng_no like :ls_evl_ym || '%'
and member_no = :ls_member_no
USING SQLCA;

if isnull(l_mng_no) then l_mng_no = 1



For ll_row = 1 To dw_main.rowcount()
		ls_mng_no = func.of_nvl(dw_main.object.mng_no[ll_row], '')
		
		If  ls_mng_no = '' or isnull(ls_mng_no) Then
			ls_mng_no = mid(ls_evl_ym, 3, 4)  + ls_member_no + String(l_mng_no, '000')
			dw_main.object.mng_no[ll_row] = ls_mng_no
			l_mng_no = l_mng_no + 1
		Else
			If l_mng_no <= long(right(ls_mng_no, 3)) Then
				l_mng_no =  long(right(ls_mng_no, 3)) + 1
			End If
		End If	
Next
	

return 1
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정

if idw_print.rowcount()=0 then return -1

avc_data.SetProperty('title', "업적평가표")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 THEN
	this.post event ue_inquiry()
end if

return AncestorReturnValue
end event

type ln_templeft from w_window`ln_templeft within w_hyk304p
end type

type ln_tempright from w_window`ln_tempright within w_hyk304p
end type

type ln_temptop from w_window`ln_temptop within w_hyk304p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hyk304p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hyk304p
end type

type ln_tempstart from w_window`ln_tempstart within w_hyk304p
end type

type uc_retrieve from w_window`uc_retrieve within w_hyk304p
end type

type uc_insert from w_window`uc_insert within w_hyk304p
end type

type uc_delete from w_window`uc_delete within w_hyk304p
end type

type uc_save from w_window`uc_save within w_hyk304p
end type

type uc_excel from w_window`uc_excel within w_hyk304p
end type

type uc_print from w_window`uc_print within w_hyk304p
end type

type st_line1 from w_window`st_line1 within w_hyk304p
end type

type st_line2 from w_window`st_line2 within w_hyk304p
end type

type st_line3 from w_window`st_line3 within w_hyk304p
end type

type uc_excelroad from w_window`uc_excelroad within w_hyk304p
end type

type dw_main from uo_grid within w_hyk304p
event type long ue_retrieve ( )
integer x = 41
integer y = 412
integer width = 4389
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyk304p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

event type long ue_retrieve();String		ls_evl_ym, ls_appoint_gb, ls_member_no
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_evl_ym = dw_con.object.evl_ym[dw_con.GetRow()]
ls_appoint_gb = dw_con.object.appoint_gb[dw_con.GetRow()]
ls_member_no = func.of_nvl(dw_con.object.member_no[dw_con.GetRow()], '%')

If ls_evl_ym = '' or isnull(ls_evl_ym) then
	Messagebox("알림", "평가년월을 입력하세요!")
	RETURn -1
End If

If ls_appoint_gb = '' or isnull(ls_appoint_gb) then
	Messagebox("알림", "임용구분을 입력하세요!")
	RETURn -1
End If


ll_rv = THIS.Retrieve(ls_evl_ym, ls_appoint_gb, ls_member_no)
If ll_rv > 0 Then
	dw_print.Retrieve(ls_evl_ym, ls_appoint_gb, ls_member_no)
End If

RETURN ll_rv



end event

type dw_con from uo_dw within w_hyk304p
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyk207a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
//	If is_magam = 'Y' Then RETURN
	
s_insa_com	lstr_com
String		ls_KName, ls_member_no
This.accepttext()
ls_KName =  trim(this.object.kname[1])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = '1'//교직원구분 -교원

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.kname[1]        = ls_kname					//성명
This.object.member_no[1]     = ls_Member_No				//개인번호
Parent.post event ue_inquiry()	
return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_member_no	,ls_h01knm


This.accepttext()
Choose Case	dwo.name
	Case	'member_no','kname'
		If dwo.name = 'member_no' Then	ls_member_no = data
		If dwo.name = 'kname' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
			This.Post SetItem(row, 'kname'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_member_no , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_member_no || '%'
		AND NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.member_no[row] = ls_member_no
			This.object.kname[row] = ls_h01knm
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
		
	

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

type p_1 from picture within w_hyk304p
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hyk304p
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
string text = "교육업적평가표"
boolean focusrectangle = false
end type

type dw_print from datawindow within w_hyk304p
event type long ue_retrieve ( )
boolean visible = false
integer x = 475
integer y = 40
integer width = 713
integer height = 476
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_hyk304p_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

