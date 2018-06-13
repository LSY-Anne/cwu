$PBExportHeader$w_sch206a.srw
$PBExportComments$[w_list_master]기숙사비고지서출력
forward
global type w_sch206a from w_window
end type
type dw_con from uo_dw within w_sch206a
end type
type dw_main from uo_dw within w_sch206a
end type
type p_1 from picture within w_sch206a
end type
type st_main from statictext within w_sch206a
end type
type p_2 from picture within w_sch206a
end type
type st_detail from statictext within w_sch206a
end type
type dw_list from uo_dw within w_sch206a
end type
type p_image from picture within w_sch206a
end type
type dw_print from uo_dw within w_sch206a
end type
end forward

global type w_sch206a from w_window
event type long ue_row_updatequery ( )
dw_con dw_con
dw_main dw_main
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
dw_list dw_list
p_image p_image
dw_print dw_print
end type
global w_sch206a w_sch206a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE

end variables

forward prototypes
public function integer wf_validall ()
end prototypes

event type long ue_row_updatequery();Long				ll_rv
Long				ll_cnt = 0
Long				ll_i
DataWindow	ldw_modified[]
Long				ll_dw_cnt

If Not uc_save.Enabled Then RETURN 1

If UpperBound(idw_modified) = 0 Then
	ldw_modified = idw_update
Else
	ldw_modified = idw_modified
End If

ll_dw_cnt = UpperBound(ldw_modified)

For ll_i = 1 To ll_dw_cnt
	If ib_list_chk	=	FALSE and ldw_modified[ll_i] = dw_list Then Continue
	ldw_modified[ll_i].AcceptText()
//	ll_cnt += ldw_modified[ll_i].uf_ModifiedCount()
	ll_cnt += (ldw_modified[ll_i].ModifiedCount() + ldw_modified[ll_i].DeletedCount())
Next

If ll_cnt > 0 Then
	ll_rv = gf_message(parentwin, 2, '0007', '', '')
	Choose Case ll_rv
		Case 1
			If This.Event ue_save() = 1 Then 
				RETURN 1
			Else
				RETURN -1
			End IF
		Case 2
			If ib_updatequery_resetupdate Then
				ll_cnt = UpperBound(idw_update)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_update[ll_i] = dw_list Then Continue
					idw_update[ll_i].resetUpdate()
				Next
				ll_cnt = UpperBound(idw_modified)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_modified[ll_i] = dw_list Then Continue
					idw_modified[ll_i].resetUpdate()
				Next
			End If
			RETURN 2			
		Case 3
			RETURN 3
	End Choose 	
Else
	RETURN 1
End If

RETURN 1

end event

public function integer wf_validall ();Integer	li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

end function

on w_sch206a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
this.dw_list=create dw_list
this.p_image=create p_image
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.st_detail
this.Control[iCurrent+7]=this.dw_list
this.Control[iCurrent+8]=this.p_image
this.Control[iCurrent+9]=this.dw_print
end on

on w_sch206a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.dw_list)
destroy(this.p_image)
destroy(this.dw_print)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )
This.Event ue_resize_dw( st_line1, dw_list )

dw_con.insertrow(0)
dw_list.insertrow(0)
dw_main.insertrow(0)

idw_update[1]	= dw_main
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= dw_main

// Print할 윈도우를 지정
idw_print = dw_print

// 공통코드 Setup
Vector lvc_data

lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
lvc_data.setProperty('column2', 'sex')  		//성별
lvc_data.setProperty('key2', 'sex_code')
lvc_data.setProperty('column3', 'religion_cd')  		//종교코드
lvc_data.setProperty('key3', 'jonggyo_code')
lvc_data.setProperty('column4', 'door_gb')  		//지원실
lvc_data.setProperty('key4', 'SAZ36')
lvc_data.setProperty('column5', 'area_gb')  		//지역구분
lvc_data.setProperty('key5', 'SYS04')
lvc_data.setProperty('column6', 'nation_cd')  		//국적구분
lvc_data.setProperty('key6', 'kukjuk_code')
lvc_data.setProperty('column7', 'enter_term')  		//입사기간
lvc_data.setProperty('key7', 'SAZ29')
lvc_data.setProperty('column8', 'zone1_gb')  		//선택그룹1
lvc_data.setProperty('key8', 'SAZ37')
lvc_data.setProperty('column9', 'zone2_gb')  		//선택그룹2
lvc_data.setProperty('key9', 'SAZ38')
lvc_data.setProperty('column10', 'zone3_gb')  		//선택그룹3
lvc_data.setProperty('key10', 'SAZ39')
lvc_data.setProperty('column11', 'smking_gb')  		//흡연종류
lvc_data.setProperty('key11', 'SAZ22')
lvc_data.setProperty('column12', 'sick_gb')  		//질병종류
lvc_data.setProperty('key12', 'SAZ40')
lvc_data.setProperty('column13', 'sms_gb')  		//SMS 정보 요청종류
lvc_data.setProperty('key13', 'SAZ41')

func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_list,lvc_data)
func.of_dddw( dw_main,lvc_data)
func.of_dddw( dw_print,lvc_data)

// 초기값 Setup
dw_con.Object.house_gb[dw_con.GetRow()]	= '1'
dw_con.Object.std_year[dw_con.GetRow()] 	= func.of_get_sdate('yyyy')
dw_con.Object.hakbun[dw_con.GetRow()]	= gs_empcode
dw_con.Object.hname[dw_con.GetRow()]	= gs_empname

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
Long		ll_row

ll_rv = dw_main.Event ue_DeleteRow()

ls_txt = "[삭제] "
If ll_rv = 1 Then
	If Trigger Event ue_save() <> 1 Then
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	Else
		ll_row = dw_list.GetRow()
		If ll_row > 0 Then
			dw_list.DeleteRow(ll_row)
		End If
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
ll_rv = dw_list.Event ue_Retrieve()
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

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "")
avc_data.SetProperty('dataobject', "d_sch206a_p1")
avc_data.SetProperty('datawindow', dw_print)

//label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])

Return 1
end event

type ln_templeft from w_window`ln_templeft within w_sch206a
end type

type ln_tempright from w_window`ln_tempright within w_sch206a
end type

type ln_temptop from w_window`ln_temptop within w_sch206a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch206a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch206a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch206a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch206a
end type

type uc_insert from w_window`uc_insert within w_sch206a
end type

type uc_delete from w_window`uc_delete within w_sch206a
end type

type uc_save from w_window`uc_save within w_sch206a
end type

type uc_excel from w_window`uc_excel within w_sch206a
end type

type uc_print from w_window`uc_print within w_sch206a
end type

type st_line1 from w_window`st_line1 within w_sch206a
end type

type st_line2 from w_window`st_line2 within w_sch206a
end type

type st_line3 from w_window`st_line3 within w_sch206a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch206a
end type

type dw_con from uo_dw within w_sch206a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch205a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_kname

This.accepttext()
Choose Case	dwo.name
	Case	'hakbun','hname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'hname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'hname'	, '')			
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
			This.object.hname[row] = ls_kname
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_hakbun)
			return 1
			
		End If	
End Choose


end event

event clicked;call super::clicked;If dwo.name = 'p_hakbun' Then
		
	s_insa_com	lstr_com
	String		ls_KName, ls_hakbun
	
	This.accepttext()
	
	ls_KName =  trim(this.object.hname[1])
		
	OpenWithParm(w_hsg_hakjuk,ls_kname)
	
	lstr_com = Message.PowerObjectParm
	IF NOT isValid(lstr_com) THEN
		dw_con.SetFocus()
		dw_con.setcolumn('hname')
		RETURN -1
	END IF
	
	ls_kname             = lstr_com.ls_item[2]	//성명
	ls_hakbun            = lstr_com.ls_item[1]	//학번
	this.object.hname[1]        = ls_kname					//성명
	This.object.hakbun[1]     = ls_hakbun				//개인번호
	Parent.post event ue_inquiry()	
	return 1
End If
end event

type dw_main from uo_dw within w_sch206a
event type long ue_retrieve ( )
integer x = 50
integer y = 1816
integer width = 4389
integer height = 448
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch206a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_Retrieve();Long		ll_row
String		ls_arg1
String		ls_arg2
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_arg1 = dw_list.object.arg1[ll_row]
ls_arg2 = dw_list.object.arg2[ll_row]

ll_rv = dw_main.Retrieve(ls_arg1, ls_arg2)

RETURN ll_rv

end event

type p_1 from picture within w_sch206a
integer x = 50
integer y = 316
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_sch206a
integer x = 110
integer y = 304
integer width = 1051
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "기숙사생 정보"
boolean focusrectangle = false
end type

type p_2 from picture within w_sch206a
integer x = 50
integer y = 1740
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_sch206a
integer x = 114
integer y = 1728
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
string text = "기숙사비 내역"
boolean focusrectangle = false
end type

type dw_list from uo_dw within w_sch206a
event type long ue_retrieve ( )
integer x = 50
integer y = 380
integer width = 4384
integer height = 1312
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sch202a_1"
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_house_gb, ls_std_year, ls_hakbun, ls_house_req_no
blob 		lb_data
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_house_gb 	= dw_con.Object.house_gb[dw_con.GetRow()]
ls_std_year 		= dw_con.Object.std_year[dw_con.GetRow()]
ls_hakbun 		= dw_con.Object.hakbun[dw_con.GetRow()]

This.SetRedraw(False)
ll_rv = This.Retrieve(ls_house_gb, ls_std_year, ls_hakbun)
If ll_rv > 0 Then
	ls_house_req_no = This.Object.house_req_no[This.GetRow()]
	dw_main.Retrieve(ls_house_gb, ls_std_year, ls_house_req_no)
	dw_print.Retrieve(ls_house_gb, ls_std_year, ls_house_req_no)
Else
	This.Event ue_insertRow()
	dw_main.Reset()
End If
This.SetRedraw(True)

// 해당 학생의 사진을 띄운다.
SELECTBLOB P_IMAGE
INTO	:lb_data
FROM HAKSA.PHOTO
WHERE HAKBUN = :ls_hakbun
USING SQLCA ;

p_image.SetPicture(lb_data)

RETURN ll_rv

end event

type p_image from picture within w_sch206a
integer x = 59
integer y = 556
integer width = 425
integer height = 444
boolean bringtotop = true
string picturename = "..\img\icon\cwu_logo.jpg"
boolean focusrectangle = false
end type

type dw_print from uo_dw within w_sch206a
boolean visible = false
integer x = 23
integer y = 1556
integer width = 247
integer height = 252
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sch206a_p1"
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)
end event

