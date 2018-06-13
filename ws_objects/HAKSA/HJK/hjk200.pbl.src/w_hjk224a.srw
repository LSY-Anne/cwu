$PBExportHeader$w_hjk224a.srw
$PBExportComments$[청운대]휴학연기(변경)신청-신규
forward
global type w_hjk224a from w_window
end type
type dw_main from uo_grid within w_hjk224a
end type
type dw_con from uo_dw within w_hjk224a
end type
type uo_apply from uo_imgbtn within w_hjk224a
end type
type dw_detail from uo_dw within w_hjk224a
end type
type st_1 from statictext within w_hjk224a
end type
end forward

global type w_hjk224a from w_window
event type long ue_row_updatequery ( )
dw_main dw_main
dw_con dw_con
uo_apply uo_apply
dw_detail dw_detail
st_1 st_1
end type
global w_hjk224a w_hjk224a

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
	If ib_list_chk	=	FALSE and ldw_modified[ll_i] = dw_detail Then Continue
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
					If ib_list_chk	=	FALSE and idw_update[ll_i] = dw_detail Then Continue
					idw_update[ll_i].resetUpdate()
				Next
				ll_cnt = UpperBound(idw_modified)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_modified[ll_i] = dw_detail Then Continue
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

public function integer wf_validall ();Integer	li_rtn, i, li_row
String     ls_sign_status, ls_sign_status_nm, ls_sayu_id, ls_army_dt, ls_discharge_dt

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

li_row = dw_detail.GetRow()
ls_sign_status = dw_detail.Object.sign_status[li_row]
ls_sayu_id      = dw_detail.Object.sayu_id[li_row]

If ls_sign_status = '3' Then
	ls_sign_status_nm = '확정'
ElseIf ls_sign_status = '9' Then
	ls_sign_status_nm = '반려'
End If

If ls_sign_status <> '0' Then
	Messagebox('확인', '신청건이 ' + ls_sign_status_nm + ' 상태이므로 수정 할 수 없습니다.')
	Return -1
End If

If ls_sayu_id = 'B13' Then
	ls_army_dt        = dw_detail.Object.army_dt[li_row]
	ls_discharge_dt = dw_detail.Object.discharge_dt[li_row]
	
	If ls_army_dt = '' Or Isnull( ls_army_dt) Then
		Messagebox('확인', '입대일을 입력하세요!')
		dw_detail.SetFocus()
		dw_detail.SetColumn("army_dt")
		Return -1
	End If
	
	If ls_discharge_dt = '' Or Isnull( ls_discharge_dt) Then
		Messagebox('확인', '전역예정일을 입력하세요!')
		dw_detail.SetFocus()
		dw_detail.SetColumn("discharge_dt")
		Return -1
	End If
End If

end function

on w_hjk224a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_apply=create uo_apply
this.dw_detail=create dw_detail
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_apply
this.Control[iCurrent+4]=this.dw_detail
this.Control[iCurrent+5]=this.st_1
end on

on w_hjk224a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_apply)
destroy(this.dw_detail)
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;String	ls_year, ls_hakgi, ls_admin

func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )
dw_con.settransobject(sqlca)
dw_con.insertrow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')

idw_update[1]	= dw_detail

// dddw 값 셋팅
//Vector lvc_data
//
//lvc_data = Create Vector
//
//lvc_data.setProperty('column1', 'sayu_id') // 휴학사유
//lvc_data.setProperty('key1', 'B')
//
//func.of_dddw( dw_main,lvc_data)
//func.of_dddw( dw_detail,lvc_data)

DataWindowChild	ldwc_child, ldwc_child1

dw_main.GetChild('sayu_id', ldwc_child)
ldwc_child.SetTransObject(SQLCA)
ldwc_child.Retrieve('B')

dw_detail.GetChild('sayu_id', ldwc_child1)
ldwc_child1.SetTransObject(SQLCA)
ldwc_child1.Retrieve('B')

// 학적변동 신청기간인지 체크
Int      li_apply_cnt
String ls_today,  ls_fdt, ls_tdt, ls_ftime, ls_ttime, ls_ftime1, ls_ttime1, ls_time

ls_today = func.of_get_sdate('YYYYMMDD')

 SELECT ETC_CD1, ETC_CD2, ETC_CD3, ETC_CD4, SUBSTR(ETC_CD3,1,2) || SUBSTR(ETC_CD3, 4, 2), SUBSTR(ETC_CD4,1,2) || SUBSTR(ETC_CD4, 4, 2)
     INTO :ls_fdt,     :ls_tdt,     :ls_ftime,  :ls_ttime, :ls_ftime1,  :ls_ttime1
  FROM CDDB.KCH102D
 WHERE CODE_GB = 'HJK02'
   AND USE_YN  = 'Y'
USING SQLCA ;
  
If ls_today < ls_fdt Or  ls_today > ls_tdt Then
	Messagebox('확인', '학적변동 신청기간이 아닙니다.' + &
	                              "~n신청가능 날짜: " + ls_fdt + " - " + ls_tdt )
	uc_retrieve.Enabled = False
	uc_insert.Enabled    = False
	uc_delete.Enabled   = False
	uc_save.Enabled     = False
End If

SELECT TO_CHAR(SYSDATE, 'hh24mm')
    INTO :ls_time
    FROM DUAL
   USING SQLCA ;

If ls_time < ls_ftime1 Or  ls_time > ls_ttime1 Then
	Messagebox('확인', '현재 시간은 신청을 할 수 없습니다.' +&
	                              "~n신청가능시간: " + ls_ftime + " - " + ls_ttime)
	uc_retrieve.Enabled = False
	uc_insert.Enabled    = False
	uc_delete.Enabled   = False
	uc_save.Enabled     = False
End If

//This.Event ue_Insert()
//dw_detail.ResetUpdate()

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
	
	dw_detail.Reset()
	dw_detail.Event ue_InsertRow()
	
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

ll_rv = dw_detail.Event ue_DeleteRow()

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

event ue_save;call super::ue_save;If ancestorreturnvalue = 1 Then dw_main.event ue_retrieve()

return 1
end event

event ue_savestart;call super::ue_savestart;// 신청일 순번 생성.
String ls_apply_dt, ls_fdate, ls_tdate, ls_hjmod_gb, ls_sayu_id, ls_discharge_dt, ls_hakgi, ls_bokhak_hakgi, ls_yyyy, ls_input_hakgi
Long  ll_apply_seq = 0, ll_row, ll_cnt, ll_rtn, ll_old_hjmod_gigan, ll_hjmod_gigan, ll_gigan = 0, ll_mm

ll_rtn = Messagebox('확인', '휴학연기 신청을 하시겠습니까?', Question!, YesNo!)

If ll_rtn = 2 Then Return -1;

ll_row = dw_detail.GetRow()
ls_apply_dt      = dw_detail.Object.apply_dt[ll_row]
ls_fdate           = dw_detail.Object.hjmod_fdt[ll_row]
ls_tdate           = dw_detail.Object.hjmod_tdt[ll_row]
ls_hjmod_gb    = dw_detail.Object.hjmod_gb[ll_row]
ls_sayu_id        = dw_detail.Object.sayu_id[ll_row]
ls_discharge_dt = dw_detail.Object.discharge_dt[ll_row]
ls_input_hakgi   = dw_detail.Object.bokhak_year[ll_row] + dw_detail.Object.bokhak_hakgi[ll_row]

// 군입대일경우.
If ls_sayu_id = 'B13' Then
	SELECT TO_NUMBER(SUBSTR(TO_CHAR(TO_DATE(:ls_discharge_dt), 'YYYYMMDD'), 5, 2))
		  INTO  :ll_mm
		  FROM DUAL  
		 USING SQLCA ;
		 
		If ll_mm > 8 Then
		    ls_yyyy = String(Long(mid(ls_tdate, 1, 4)) + 1)
		Else
			ls_yyyy = mid(ls_tdate, 1, 4)
		End If
		
		If ll_mm < 3 Or ll_mm > 8 Then
			ls_hakgi = '1'
		Else
			ls_hakgi = '2'
		End If
		
		ls_bokhak_hakgi = ls_yyyy + ls_hakgi
		
		If ls_input_hakgi > ls_bokhak_hakgi Then
			Messagebox('확인', '복학예정년도(학기)는 제대후 처음 시작하는 학기를 넘길 수 없습니다.')
			Return -1
		End If
	
End If

// 휴학연기 일때.
If ls_hjmod_gb = '3' Then
	// 일반휴학일 구하기. ( 2년을 넘길수 없슴)
	SELECT SUM(A.GIGAN)
		 INTO :ll_old_hjmod_gigan
	  FROM ( 
			  SELECT HAKBUN
					 , HJMOD_ID
					 , SAYU_ID
					 , HJMOD_SIJUM
					 , LEAD( HJMOD_SIJUM ) OVER(ORDER BY HJMOD_SIJUM)             AS NEXT_SIJUM
					 , BOKHAK_YEAR || DECODE( BOKHAK_HAKGI, '1', '0228', '0831' ) AS BOKHAK_DT
					 , TO_DATE(DECODE( HJMOD_ID, 'B', NVL(LEAD( HJMOD_SIJUM ) OVER(ORDER BY HJMOD_SIJUM), 'N'), 'N', (BOKHAK_YEAR || DECODE( BOKHAK_HAKGI, '1', '0228', '0831' )) 
																																		                      ,  LEAD( HJMOD_SIJUM ) OVER(ORDER BY HJMOD_SIJUM) ))                                                                                         
					  - TO_DATE(HJMOD_SIJUM) AS GIGAN
				 FROM HAKSA.HAKJUKBYENDONG
				WHERE HAKBUN = :gs_empcode
				ORDER BY HJMOD_SIJUM ) A
	 WHERE A.HJMOD_ID = 'B'
		AND A.SAYU_ID <> 'B13'
	 USING SQLCA ;
	
	// 휴학신청한 기간.
	SELECT TO_DATE(:ls_tdate) - TO_DATE(:ls_fdate)
		INTO  :ll_hjmod_gigan
	  FROM DUAL 
	 USING SQLCA ;
	 
	ll_gigan = ll_hjmod_gigan + ll_hjmod_gigan
	
	If ll_gigan > 730 Then
		Messagebox('확인', '일반휴학기간은 2년을 넘길 수 없습니다. 확인하세요!')
		Return -1
	End If
	
End If

// 신청순번생성.
SELECT NVL(MAX(APPLY_SEQ), 0) + 1
   INTO :ll_apply_seq
   FROM HAKSA.HJMOD_SINCHUNG
 WHERE APPLY_DT = :ls_apply_dt
      AND HJMOD_GB = '3'
 USING SQLCA ;
 
 dw_detail.Object.apply_seq[ll_row] = ll_apply_seq
 
 Return 1
end event

event ue_saveend;call super::ue_saveend;String ls_zip, ls_addr, ls_tel, ls_hp, ls_email
Int      li_row

li_row    = dw_detail.GetRow()

ls_zip     = dw_detail.Object.zip_id[li_row]
ls_addr  = dw_detail.Object.addr[li_row]
ls_tel     = dw_detail.Object.tel[li_row]
ls_hp     = dw_detail.Object.hp[li_row]
ls_email = dw_detail.Object.email[li_row]

UPDATE	HAKSA.JAEHAK_HAKJUK  
	SET	ZIP_ID                      = :ls_zip
		 ,  ADDR                        = :ls_addr
		 ,  TEL                           = :ls_tel
		 ,  HP                            = :ls_hp
		 , EMAIL                        = :ls_email
WHERE HAKBUN	= :gs_empcode   
USING SQLCA ;

If sqlca.sqlNrows < 1 Then
	messagebox("오류", "학적에 저장시 오류가 발생하였습니다.")
	Return -1
End If

Return 1
end event

type ln_templeft from w_window`ln_templeft within w_hjk224a
end type

type ln_tempright from w_window`ln_tempright within w_hjk224a
end type

type ln_temptop from w_window`ln_temptop within w_hjk224a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hjk224a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hjk224a
end type

type ln_tempstart from w_window`ln_tempstart within w_hjk224a
end type

type uc_retrieve from w_window`uc_retrieve within w_hjk224a
end type

type uc_insert from w_window`uc_insert within w_hjk224a
end type

type uc_delete from w_window`uc_delete within w_hjk224a
end type

type uc_save from w_window`uc_save within w_hjk224a
end type

type uc_excel from w_window`uc_excel within w_hjk224a
end type

type uc_print from w_window`uc_print within w_hjk224a
end type

type st_line1 from w_window`st_line1 within w_hjk224a
end type

type st_line2 from w_window`st_line2 within w_hjk224a
end type

type st_line3 from w_window`st_line3 within w_hjk224a
end type

type uc_excelroad from w_window`uc_excelroad within w_hjk224a
end type

type dw_main from uo_grid within w_hjk224a
event type long ue_retrieve ( )
integer x = 50
integer y = 312
integer width = 4384
integer height = 648
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk224a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_from_dt, ls_to_dt
Long		ll_rv,          ll_row

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ll_row = dw_con.GetRow()

ls_from_dt = dw_con.Object.from_dt[ll_row]
ls_to_dt     = dw_con.Object.to_dt[ll_row]

ll_rv = This.Retrieve(ls_from_dt, ls_to_dt, gs_empcode )

RETURN ll_rv

end event

event ue_insertend;call super::ue_insertend;This.Object.apply_dt[al_row] = func.of_get_sdate('YYYYMMDD')
This.Object.hakbun[al_row]   = gs_empcode

Return 1
end event

event rowfocuschanged;call super::rowfocuschanged;String ls_apply_dt, ls_sign_status, ls_hjmod_id
Long   ll_apply_seq, ll_rv

If This.GetRow() < 1 Then Return ;

ll_rv = Parent.Event ue_updatequery() 

If currentrow > 0 And (ll_rv = 1 Or ll_rv = 2) Then
	If dw_main.GetItemStatus(currentrow, 0, Primary!) <> New! THEN 

		ls_apply_dt  = This.Object.apply_dt[currentrow]
		ll_apply_seq = This.Object.apply_seq[currentrow]
		ls_sign_status = This.Object.sign_status[currentrow]
		ls_hjmod_id    = This.Object.hjmod_id[currentrow]
		
		If dw_detail.Retrieve( ls_apply_dt, ls_hjmod_id, ll_apply_seq ) < 1 Then
			dw_detail.Reset()
			dw_detail.Event ue_InsertRow()
		Else
			If ls_sign_status <> '0' Then
				uc_delete.Enabled = False
				uc_save.Enabled   = False
			Else
				uc_delete.Enabled = True
				uc_save.Enabled   = True
			End If
		End If
	End If
End If

Return 
end event

event rowfocuschanging;call super::rowfocuschanging;If newrow > 0 Then
	If il_rv = 0 Then
		il_ret = Parent.Event ue_row_updatequery()
		Choose Case il_ret
			Case 3, -1
				il_rv ++
				If il_rv > 1 Then
					il_rv = 0
				End If
				RETURN 1
			Case 2
				il_rv = 0
				RETURN 0
			Case Else
				il_rv = 0
				RETURN 0
		End Choose
	Else
		Choose Case il_ret
			Case 3, -1
				il_rv ++
				If il_rv > 1 Then
					il_rv = 0
				End If
				RETURN 1
			Case 2
				il_rv = 0
				RETURN 0
			Case Else
				il_rv = 0
				RETURN 0
		End Choose
	End If
Else
	il_rv = 0
	RETURN 0
End If

end event

type dw_con from uo_dw within w_hjk224a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk224a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;String ls_from_dt, ls_to_dt

Choose Case dwo.name
	Case 'p_from_dt'
		ls_from_dt 	= String(This.Object.from_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'from_dt' , ls_from_dt)
		
		ls_from_dt 	= left(ls_from_dt, 4) + mid(ls_from_dt, 6, 2) + right(ls_from_dt, 2)
		This.SetItem(row, 'from_dt',  ls_from_dt)
		
	Case 'p_to_dt'
		ls_to_dt 	= String(This.Object.to_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'to_dt' , ls_to_dt)
		
		ls_to_dt 	= left(ls_to_dt, 4) + mid(ls_to_dt, 6, 2) + right(ls_to_dt, 2)
		This.SetItem(row, 'to_dt',  ls_to_dt)
End Choose
end event

type uo_apply from uo_imgbtn within w_hjk224a
boolean visible = false
integer x = 123
integer y = 40
integer taborder = 20
boolean bringtotop = true
string btnname = "휴학신청"
end type

on uo_apply.destroy
call uo_imgbtn::destroy
end on

type dw_detail from uo_dw within w_hjk224a
integer x = 50
integer y = 1040
integer width = 4384
integer height = 1228
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk224a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_insertend;call super::ue_insertend;String ls_hname, ls_hakyun, ls_hakgi, ls_gwa, ls_zip_id, ls_addr, ls_tel, ls_hp, ls_email

SELECT HNAME,     DR_HAKYUN,   HAKGI,    GWA,     ZIP_ID,     ADDR,      TEL,        HP,      EMAIL
   INTO :ls_hname, :ls_hakyun,    :ls_hakgi, :ls_gwa, : ls_zip_id, :ls_addr,  :ls_tel,    :ls_hp,  :ls_email
   FROM HAKSA.JAEHAK_HAKJUK
 WHERE HAKBUN = :gs_empcode
 USING SQLCA ;
 
This.Object.apply_dt[al_row] = func.of_get_sdate('YYYYMMDD')
This.Object.hakbun[al_row]   = gs_empcode
This.Object.hname[al_row]   = ls_hname
This.Object.hakyun[al_row]   = ls_hakyun
This.Object.hakgi[al_row]     = ls_hakgi
This.Object.gwa[al_row]       = ls_gwa
This.Object.hjmod_fdt[al_row] = func.of_get_sdate('YYYYMMDD')
This.Object.hjmod_tdt[al_row] = String(Long(func.of_get_sdate('YYYYMMDD')) + 10000)
This.Object.zip_id[al_row]   = ls_zip_id
This.Object.addr[al_row]     = ls_addr
This.Object.tel[al_row]        = ls_tel
This.Object.hp[al_row]        = ls_hp
This.Object.email[al_row]    = ls_email

Return 1
end event

event ue_constructor;call super::ue_constructor;func.of_design_dw(dw_detail)
end event

event itemchanged;call super::itemchanged;String ls_fdate, ls_tdate, ls_old_tdate, ls_yyyy, ls_hakgi, ls_sayu_id, ls_hjmod_id, ls_old_hjmod_id
Long   ll_gigan, ll_mm

Choose Case dwo.name
	Case 'hjmod_tdt'
		
		ls_sayu_id    = This.Object.sayu_id[row]
		ls_old_tdate = This.Object.hjmod_fdt.Original[row]
		ls_fdate       = This.Object.hjmod_fdt[row]
		ls_tdate       = data
		
		If ls_sayu_id <> 'B13' Then // 군입대 제외
			
			SELECT TO_DATE(:ls_tdate) - TO_DATE(:ls_fdate)
			  INTO  :ll_gigan
			  FROM DUAL 
			 USING SQLCA ;
			 
			If ll_gigan > 365 Then
				Messagebox('확인', '휴학기간은 1년을 넘을수 없습니다.')
				This.Post Setitem(row, "hjmod_tdt", ls_old_tdate)
				Return 1
			End If
		End If
		
		SELECT TO_NUMBER(SUBSTR(TO_CHAR(TO_DATE(:ls_tdate), 'YYYYMMDD'), 5, 2))
		  INTO  :ll_mm
		  FROM DUAL  
		 USING SQLCA ;
		 
		If ll_mm > 8 Then
		    ls_yyyy = String(Long(mid(ls_tdate, 1, 4)) + 1)
		Else
			ls_yyyy = mid(ls_tdate, 1, 4)
		End If
		
		If ll_mm < 3 Or ll_mm > 8 Then
			ls_hakgi = '1'
		Else
			ls_hakgi = '2'
		End If
		 
		This.Object.bokhak_year[row]  = ls_yyyy
		This.Object.bokhak_hakgi[row] = ls_hakgi
		
	Case 'hjmod_gb'
		ls_old_hjmod_id = This.Object.hjmod_gb.Original[row]
		
		If data = '1' Or data = '2' Then
			Messagebox('확인', '휴학연기(변경) 신청만 가능합니다.')
			This.Post Setitem(row, "hjmod_gb", ls_old_hjmod_id)
			Return 1
		End If
		
End Choose
end event

event clicked;call super::clicked;String ls_param, ls_zip_id, ls_addr
Int      li_len

Choose Case dwo.name
	Case 'p_zip'
		Open(w_zipcode)
		
		ls_param	= Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr	= mid(ls_param, 7, li_len)
		
		This.setitem(row, "zip_id", ls_zip_id)
		This.setitem(row, "addr"	, ls_addr)
		
		This.setcolumn("addr")
		
End Choose
end event

event ue_deleteend;call super::ue_deleteend;Long ll_row

ll_row = dw_main.GetRow()

dw_main.DeleteRow(ll_row)

Return 1
end event

event ue_deletestart;call super::ue_deletestart;String ls_sign_status, ls_sign_status_nm
Int     li_row

li_row = This.GetRow()
ls_sign_status = This.Object.sign_status[li_row]

If ls_sign_status = '3' Then
	ls_sign_status_nm = '확정'
ElseIf ls_sign_status = '9' Then
	ls_sign_status_nm = '반려'
End If

If ls_sign_status <> '0' Then
	Messagebox('확인', '신청건이 ' + ls_sign_status_nm + ' 상태이므로 삭제 할 수 없습니다.')
	Return -1
End If

Return 1
end event

type st_1 from statictext within w_hjk224a
integer x = 69
integer y = 968
integer width = 1344
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = ">> 변동구분은 휴학연기, 휴학변동만 가능합니다."
boolean focusrectangle = false
end type

