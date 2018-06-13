$PBExportHeader$w_sch205a.srw
$PBExportComments$[w_master_detail]룸메이트신청등록
forward
global type w_sch205a from w_window
end type
type dw_con from uo_dw within w_sch205a
end type
type dw_main from uo_dw within w_sch205a
end type
type dw_sub from uo_grid within w_sch205a
end type
type uc_row_insert from u_picture within w_sch205a
end type
type uc_row_delete from u_picture within w_sch205a
end type
type p_1 from picture within w_sch205a
end type
type st_main from statictext within w_sch205a
end type
type p_2 from picture within w_sch205a
end type
type st_detail from statictext within w_sch205a
end type
type p_image from picture within w_sch205a
end type
end forward

global type w_sch205a from w_window
dw_con dw_con
dw_main dw_main
dw_sub dw_sub
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
p_image p_image
end type
global w_sch205a w_sch205a

type variables
Integer	ii_person
end variables

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

on w_sch205a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
this.dw_sub=create dw_sub
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
this.p_image=create p_image
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.dw_sub
this.Control[iCurrent+4]=this.uc_row_insert
this.Control[iCurrent+5]=this.uc_row_delete
this.Control[iCurrent+6]=this.p_1
this.Control[iCurrent+7]=this.st_main
this.Control[iCurrent+8]=this.p_2
this.Control[iCurrent+9]=this.st_detail
this.Control[iCurrent+10]=this.p_image
end on

on w_sch205a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.dw_sub)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.p_image)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )
This.Event ue_resize_dw( st_line1, dw_sub )

dw_con.insertrow(0)
dw_main.InsertRow(0)

idw_update[1]	= dw_main
idw_update[2]	= dw_sub
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_main
//idw_Toexcel[2]	= dw_sub

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
func.of_dddw( dw_main,lvc_data)
func.of_dddw( dw_sub,lvc_data)

// 초기값 Setup
dw_con.Object.std_year[dw_con.GetRow()] 	= func.of_get_sdate('yyyy')
dw_con.Object.hakbun[dw_con.GetRow()]	= gs_empcode
dw_con.Object.hname[dw_con.GetRow()]	= gs_empname//wait 화면을 표시하고 싶은 처리에 한해 지정

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

event ue_delete;call super::ue_delete;String		ls_txt

ls_txt = "[삭제] "
If dw_main.RowCount() > 0 Then
	If dw_main.Event ue_DeleteRow() > 0 Then
		dw_sub.uf_deleteAll()
		If Trigger Event ue_save() <> 1 Then
			f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
		Else
			f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
		End If
	Else
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	End If
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

event ue_button_set;call super::ue_button_set;If uc_row_insert.Enabled Then
	uc_row_insert.Visible	= TRUE
Else
	uc_row_insert.Visible	= FALSE
End If

If uc_row_delete.Enabled Then
	uc_row_delete.Visible	= TRUE
Else
	uc_row_delete.Visible	= FALSE
End If

end event

type ln_templeft from w_window`ln_templeft within w_sch205a
end type

type ln_tempright from w_window`ln_tempright within w_sch205a
end type

type ln_temptop from w_window`ln_temptop within w_sch205a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch205a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch205a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch205a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch205a
end type

type uc_insert from w_window`uc_insert within w_sch205a
end type

type uc_delete from w_window`uc_delete within w_sch205a
end type

type uc_save from w_window`uc_save within w_sch205a
end type

type uc_excel from w_window`uc_excel within w_sch205a
end type

type uc_print from w_window`uc_print within w_sch205a
end type

type st_line1 from w_window`st_line1 within w_sch205a
end type

type st_line2 from w_window`st_line2 within w_sch205a
end type

type st_line3 from w_window`st_line3 within w_sch205a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch205a
end type

type dw_con from uo_dw within w_sch205a
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

type dw_main from uo_dw within w_sch205a
event type long ue_retrieve ( )
integer x = 50
integer y = 388
integer width = 4384
integer height = 704
integer taborder = 11
string dataobject = "d_sch202a_1"
boolean border = false
end type

event type long ue_retrieve();String		ls_house_gb, ls_std_year, ls_hakbun, ls_house_req_no, ls_door_gb
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
	ls_house_req_no = dw_main.Object.house_req_no[dw_main.GetRow()]
	dw_sub.Retrieve(ls_house_gb, ls_std_year, ls_house_req_no)
Else
	This.Event ue_insertRow()
	dw_sub.Reset()
End If
This.SetRedraw(True)

// 해당 학생의 사진을 띄운다.
SELECTBLOB P_IMAGE
INTO	:lb_data
FROM HAKSA.PHOTO
WHERE HAKBUN = :ls_hakbun
USING SQLCA ;

p_image.SetPicture(lb_data)

ls_door_gb = This.Object.door_gb[This.GetRow()]

SELECT TO_NUMBER(TRIM(ETC_CD1))
INTO	 :ii_person
FROM	 CDDB.KCH102D
WHERE	 CODE_GB = 'SAZ36'
AND	 CODE = :ls_door_gb
USING SQLCA ;

If IsNull(ii_person ) Then ii_person = 0

RETURN ll_rv


end event

event ue_deleteend;call super::ue_deleteend;If dw_sub.uf_DeleteAll() >= 0 Then
	RETURN 1
Else
	RETURN -1
End If

end event

event ue_insertstart;call super::ue_insertstart;If AncestorReturnValue = 1 Then
	dw_sub.Reset()
End If

RETURN AncestorReturnValue

end event

type dw_sub from uo_grid within w_sch205a
integer x = 50
integer y = 1220
integer width = 4389
integer height = 1040
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sch205a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean ib_end_add = true
end type

event ue_insertstart;call super::ue_insertstart;If ii_person <= 1 Then
	MessageBox("확인","선택한 호실은 룸메이트를 신청할 수 있는 호실이 아닙니다.")
	Return -1
End If

If This.RowCount() = ii_person - 1 Then
	MessageBox("확인","룸메이트 신청인원은 가능인원을 초과할 수 없습니다.")
	Return -1
End If

Return 1
end event

event ue_insertend;call super::ue_insertend;Integer	li_row

li_row = dw_main.GetRow()

This.Object.house_gb[al_row] = dw_main.Object.house_gb[li_row]
This.Object.std_year[al_row] = dw_main.Object.house_gb[li_row]
This.Object.house_req_no[al_row] = dw_main.Object.house_gb[li_row]
This.Object.req_dt[al_row] = func.of_get_sdate('yyyymmdd')
If al_row = 1 Then
	This.Object.req_no[al_row] = al_row
Else
	This.Object.req_no[al_row] = Long(This.Object.req_no[al_row - 1]) + 1
End If
This.Object.door_gb[al_row] = dw_main.Object.door_gb[li_row]
This.Object.door_per[al_row] = ii_person

Return 1

end event

event clicked;call super::clicked;If dwo.name = 'p_rmhakbun' Then
		
	s_insa_com	lstr_com
	String		ls_KName, ls_hakbun, ls_gwa, ls_hakyun, ls_hp
	
	This.accepttext()
	
	ls_KName =  trim(this.object.hname[1])
		
	OpenWithParm(w_hsg_hakjuk,ls_kname)
	
	lstr_com = Message.PowerObjectParm
	IF NOT isValid(lstr_com) THEN
		This.SetFocus()
		This.setcolumn('rm_hname')
		RETURN -1
	END IF
	
	ls_kname             = lstr_com.ls_item[2]	//성명
	ls_hakbun            = lstr_com.ls_item[1]	//학번
	ls_hakyun				= lstr_com.ls_item[5]	//학년
	ls_gwa					= lstr_com.ls_item[3]	//학과
	This.object.rm_hname[1]        = ls_kname					//성명
	This.object.rm_hakbun[1]     = ls_hakbun				//개인번호
	This.object.rm_gwa[1]     = ls_gwa				//학과
	This.object.rm_hakyun[1]     = ls_hakyun				//학년
	This.Object.rm_cellno[1]		= ls_hp
	return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_kname, ls_gwa, ls_hp, ls_hakyun

This.accepttext()
Choose Case	dwo.name
	Case	'rm_hakbun','rm_hname'
		If dwo.name = 'rm_hakbun' Then	ls_hakbun = data
		If dwo.name = 'rm_hname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'rm_hakbun'	, '')
			This.Post SetItem(row, 'rm_hname'	, '')			
			RETURN
		End If
		
		SELECT HAKBUN, HNAME, GWA, HP, DR_HAKYUN
		INTO :ls_hakbun , :ls_kname, :ls_gwa, :ls_hp, :ls_hakyun
		FROM	HAKSA.JAEHAK_HAKJUK
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_kname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.rm_hakbun[row] = ls_hakbun
			This.object.rm_hname[row] = ls_kname
			This.object.rm_gwa[row] = ls_gwa
			This.object.rm_cellno[row] = ls_hp
			This.Object.rm_hakyun[row] = ls_hakyun
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_rmhakbun)
			return 1
			
		End If	
End Choose


end event

type uc_row_insert from u_picture within w_sch205a
integer x = 3890
integer y = 1112
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;If dw_main.RowCount() > 0 Then
	dw_sub.PostEvent("ue_InsertRow")
End If

end event

type uc_row_delete from u_picture within w_sch205a
integer x = 4169
integer y = 1112
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_sub.PostEvent("ue_DeleteRow")

end event

type p_1 from picture within w_sch205a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_sch205a
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
string text = "입사신청정보"
boolean focusrectangle = false
end type

type p_2 from picture within w_sch205a
integer x = 50
integer y = 1152
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_sch205a
integer x = 114
integer y = 1140
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
string text = "룸메이트신청정보"
boolean focusrectangle = false
end type

type p_image from picture within w_sch205a
integer x = 64
integer y = 592
integer width = 425
integer height = 444
boolean bringtotop = true
string picturename = "..\img\icon\cwu_logo.jpg"
boolean focusrectangle = false
end type

