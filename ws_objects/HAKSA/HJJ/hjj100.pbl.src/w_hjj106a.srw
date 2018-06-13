$PBExportHeader$w_hjj106a.srw
$PBExportComments$[청운대]조기졸업대상자선정-신규
forward
global type w_hjj106a from w_window
end type
type dw_main from uo_grid within w_hjj106a
end type
type dw_con from uo_dw within w_hjj106a
end type
type uo_1 from uo_imgbtn within w_hjj106a
end type
end forward

global type w_hjj106a from w_window
event type long ue_row_updatequery ( )
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hjj106a w_hjj106a

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

on w_hjj106a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
end on

on w_hjj106a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_postopen;call super::ue_postopen;String	ls_year, ls_hakgi, ls_admin, ls_gwa, ls_bojik_code
Long   ll_cnt = 0

func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )
dw_con.settransobject(sqlca)
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

type ln_templeft from w_window`ln_templeft within w_hjj106a
end type

type ln_tempright from w_window`ln_tempright within w_hjj106a
end type

type ln_temptop from w_window`ln_temptop within w_hjj106a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hjj106a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hjj106a
end type

type ln_tempstart from w_window`ln_tempstart within w_hjj106a
end type

type uc_retrieve from w_window`uc_retrieve within w_hjj106a
end type

type uc_insert from w_window`uc_insert within w_hjj106a
end type

type uc_delete from w_window`uc_delete within w_hjj106a
end type

type uc_save from w_window`uc_save within w_hjj106a
end type

type uc_excel from w_window`uc_excel within w_hjj106a
end type

type uc_print from w_window`uc_print within w_hjj106a
end type

type st_line1 from w_window`st_line1 within w_hjj106a
end type

type st_line2 from w_window`st_line2 within w_hjj106a
end type

type st_line3 from w_window`st_line3 within w_hjj106a
end type

type uc_excelroad from w_window`uc_excelroad within w_hjj106a
end type

type dw_main from uo_grid within w_hjj106a
event type long ue_retrieve ( )
integer x = 91
integer y = 312
integer width = 4384
integer height = 1948
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjj106a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		 ls_hakbun, ls_hname, ls_hakgi_chk, ls_fix_yn
Long		ll_rv,          ll_row

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ll_row = dw_con.GetRow()

ls_hakbun = func.of_nvl(dw_con.Object.hakbun[ll_row], '%')
ls_hakgi_chk = func.of_nvl(dw_con.Object.hakgi_chk[ll_row], '%')
ls_fix_yn   = dw_con.Object.fix_yn[ll_row]

ll_rv = This.Retrieve(ls_hakbun,  ls_hakgi_chk, ls_fix_yn )

RETURN ll_rv

end event

event ue_deletestart;call super::ue_deletestart;String ls_trans_yn
Long   ll_row

ll_row = This.GetRow()

If ll_row < 1 Then Return -1 ;

ls_trans_yn = This.Object.trans_yn[ll_row]

If ls_trans_yn = 'Y' Then
	Messagebox('확인', '이미 졸업이관이 되었으므로 삭제할수 없습니다.')
	Return -1
End If

Return 1
end event

type dw_con from uo_dw within w_hjj106a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjj106a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;Vector lvc_data

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
end event

type uo_1 from uo_imgbtn within w_hjj106a
integer x = 183
integer y = 40
integer width = 722
integer taborder = 20
boolean bringtotop = true
string btnname = "조기졸업대상자 생성"
end type

event clicked;call super::clicked;String ls_hakbun, ls_hname, ls_hakgi_chk
Long   ll_hakgi,     ll_hakjum, ll_rtn, ll_irow

ll_rtn = Messagebox('확인', '조기졸업자 대상선정 생성작업을 하시겠습니까?', Question!, YesNo!)

If ll_rtn = 2 Then Return ;

dw_main.Reset()

// 조기졸업대상자 가져오기.
// 7학기등록필하고 해당 신청하는 년도학기의 수강신청학점을 포함하여 140학점이 넘어야 하고, 직전학기가 4.25 이상인 학생.
DECLARE CUR CURSOR FOR

SELECT A.HAKBUN
          , A.HNAME
	     ,  NVL(A.HAKGI_CHK, 'Y')
		 , B.HAKGI
		 , B.HAKJUM + NVL(A.INJUNG_HAKJUM, 0)
    FROM HAKSA.JAEHAK_HAKJUK A
	      , ( SELECT A.HAKBUN                                                                      AS HAKBUN
			           , NVL(SUM(DECODE(A.HAKGI, '1', 1, '2', 1, '3', 0, '4', 0)), 0)  AS HAKGI
					  , NVL(SUM(A.HAKJUM), 0)                                                  AS HAKJUM
			   FROM (  SELECT HAKBUN, YEAR, HAKGI, SUM(DECODE( SUNGJUK_INJUNG, 'Y', DECODE( NVL(HWANSAN_JUMSU, 'N'), 'F', 0, HAKJUM))) AS HAKJUM
							FROM HAKSA.SUGANG
						   GROUP BY HAKBUN, YEAR, HAKGI ) A
			  GROUP BY A.HAKBUN ) B
		 , ( SELECT HAKBUN
					 , AVG_PYENGJUM
			   FROM HAKSA.SUNGJUKGYE  A
					 , ( SELECT SUBSTR(X.PRE_YEAR, 1, 4) AS PRE_YEAR
								  , SUBSTR(X.PRE_YEAR, 5, 1) AS PRE_HAKGI
								  , SIJUM_FLAG
						   FROM ( SELECT YEAR, HAKGI, LAG( YEAR || HAKGI) OVER(ORDER BY YEAR || HAKGI) AS PRE_YEAR, SIJUM_FLAG
									   FROM HAKSA.HAKSA_ILJUNG ) X ) B
			 WHERE A.YEAR  = B.PRE_YEAR
				 AND A.HAKGI = B.PRE_HAKGI 
				 AND B.SIJUM_FLAG = 'Y' ) C
 WHERE A.HAKBUN = B.HAKBUN
      AND A.HAKBUN = C.HAKBUN
      AND B.HAKGI   = 7
	 AND ( B.HAKJUM + NVL(A.INJUNG_HAKJUM, 0)) >= 140
      AND A.HAKBUN NOT IN ( SELECT HAKBUN FROM HAKSA.EARLY_JOLUP )
	 AND A.SANGTAE = '01'
	 AND C.AVG_PYENGJUM >= 4.25
 USING SQLCA ;
 
 OPEN CUR ;
			
DO WHILE TRUE
	
	FETCH CUR INTO :ls_hakbun, :ls_hname, :ls_hakgi_chk, :ll_hakgi, :ll_hakjum ;
	
	IF sqlca.sqlcode <> 0 THEN EXIT ;

	ll_irow = dw_main.InsertRow(0)
	
	dw_main.Object.hakbun[ll_irow]       = ls_hakbun
	dw_main.Object.hname[ll_irow]       = ls_hname
	dw_main.Object.jolup_gb[ll_irow]    = ls_hakgi_chk
	dw_main.Object.hakgi_total[ll_irow] = ll_hakgi
	dw_main.Object.chidk_total[ll_irow] = ll_hakjum

LOOP	

CLOSE CUR ;

Messagebox('완료', '조기졸업자 대상선정 작업을 완료 했습니다.')
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

