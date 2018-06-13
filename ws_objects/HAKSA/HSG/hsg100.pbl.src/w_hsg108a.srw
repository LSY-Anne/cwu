$PBExportHeader$w_hsg108a.srw
$PBExportComments$[w_list_tab]  상담 결과 등록(지도교수, 기타)
forward
global type w_hsg108a from w_window
end type
type dw_list from uo_grid within w_hsg108a
end type
type dw_con from uo_dw within w_hsg108a
end type
type tab_1 from tab within w_hsg108a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_tab1 from uo_dw within tabpage_1
end type
type st_tab1_line from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_tab1 dw_tab1
st_tab1_line st_tab1_line
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tab2 from uo_dw within tabpage_2
end type
type st_tab2_line from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_tab2 dw_tab2
st_tab2_line st_tab2_line
end type
type tabpage_3 from userobject within tab_1
end type
type dw_sub from uo_grid within tabpage_3
end type
type dw_tab3 from uo_dw within tabpage_3
end type
type dw_main from uo_dw within tabpage_3
end type
type st_tab3_line from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_sub dw_sub
dw_tab3 dw_tab3
dw_main dw_main
st_tab3_line st_tab3_line
end type
type tab_1 from tab within w_hsg108a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type uo_1 from u_tab within w_hsg108a
end type
type p_1 from picture within w_hsg108a
end type
type st_main from statictext within w_hsg108a
end type
type p_2 from picture within w_hsg108a
end type
type st_detail from statictext within w_hsg108a
end type
type uo_stu from uo_imgbtn within w_hsg108a
end type
end forward

global type w_hsg108a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
tab_1 tab_1
uo_1 uo_1
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
uo_stu uo_stu
end type
global w_hsg108a w_hsg108a

type variables
Long				il_rv
Long				il_ret
DataWindow	idw_tab[]
Boolean			ib_list_chk	=	FALSE

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

String ls_context

tab_1.tabpage_1.dw_tab1.accepttext()
If tab_1.tabpage_1.dw_tab1.rowcount() = 0 Then return 1

ls_context = tab_1.tabpage_1.dw_tab1.object.context[1]
If len(ls_context) < 20 then
	Messagebox("알림", "내용은 20자 이상 입력하셔야 합니다!")
	RETURN -1
End If

return 1
end function

on w_hsg108a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.tab_1=create tab_1
this.uo_1=create uo_1
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
this.uo_stu=create uo_stu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.st_main
this.Control[iCurrent+7]=this.p_2
this.Control[iCurrent+8]=this.st_detail
this.Control[iCurrent+9]=this.uo_stu
end on

on w_hsg108a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.uo_stu)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_list )


//This.Event ue_resize_dw( tab_1.tabpage_1.st_tab1_line, tab_1.tabpage_1.dw_tab1 )
//This.Event ue_resize_dw( tab_1.tabpage_2.st_tab2_line, tab_1.tabpage_2.dw_tab2 )
//This.Event ue_resize_dw( tab_1.tabpage_3.st_tab3_line, tab_1.tabpage_3.dw_tab3 )
//만일 dw_tab1, dw_tab2, dw_tab3가 Single Row이면 uo_dw를 사용하여
//dw_tab1, dw_tab2, dw_tab3를 만들고
func.of_design_dw( tab_1.tabpage_1.dw_tab1 )
func.of_design_dw( tab_1.tabpage_2.dw_tab2 )
func.of_design_dw( tab_1.tabpage_3.dw_tab3 )

dw_con.insertrow(0)
tab_1.tabpage_1.dw_tab1.insertrow(0)
tab_1.tabpage_2.dw_tab2.insertrow(0)
tab_1.tabpage_3.dw_tab3.insertrow(0)
idw_update[1]	= tab_1.tabpage_1.dw_tab1
//idw_update[2]	= tab_1.tabpage_2.dw_tab2
//idw_update[3]	= tab_1.tabpage_3.dw_tab3
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= tab_1.tabpage_1.dw_tab1
//idw_Toexcel[3]	= tab_1.tabpage_2.dw_tab2
//idw_Toexcel[4]	= tab_1.tabpage_3.dw_tab3

idw_tab[1] = tab_1.tabpage_1.dw_tab1
idw_tab[2] = tab_1.tabpage_2.dw_tab2
idw_tab[3] = tab_1.tabpage_3.dw_tab3

tab_1.tabpage_1.dw_tab1.iw_parent = This
tab_1.tabpage_2.dw_tab2.iw_parent = This
tab_1.tabpage_3.dw_tab3.iw_parent = This

//tab_1.tabpage_1.dw_tab1.Width	= tab_1.Width	- 60
//tab_1.tabpage_2.dw_tab2.Width	= tab_1.Width	- 60
//tab_1.tabpage_3.dw_tab3.Width	= tab_1.Width	- 60
//tab_1.tabpage_1.dw_tab1.Height	= tab_1.Height	- 144
//tab_1.tabpage_2.dw_tab2.Height	= tab_1.Height	- 144
//tab_1.tabpage_3.dw_tab3.Height	= tab_1.Height	- 144
tab_1.tabpage_1.dw_tab1.width = 4370
tab_1.tabpage_1.dw_tab1.height = 1108
tab_1.tabpage_2.dw_tab2.width = 4352
tab_1.tabpage_2.dw_tab2.height = 1108
tab_1.tabpage_3.dw_tab3.width = 3552
tab_1.tabpage_3.dw_tab3.height = 1104


//dw_con.object.hakyear[dw_con.getrow()] = func.of_get_sdate('yyyy')
//dw_con.object.case_dt_fr[dw_con.getrow()] = func.of_get_sdate('yyyymm') + '01'
//dw_con.object.case_dt_to[dw_con.getrow()] = func.of_get_sdate('yyyymmdd')

Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'hakgi')  //학기
lvc_data.setProperty('key1', 'HSG01')
lvc_data.setProperty('column2', 'case_tp')  //상담구분
lvc_data.setProperty('key2', 'SUM05')
func.of_dddw( dw_con,lvc_data)

datawindowchild dwc

dw_con.getchild('case_tp', dwc)
dwc.setfilter("cd <> '1'")
dwc.filter()

lvc_data.setProperty('column1', 'counsel_tp')  //상담구분
lvc_data.setProperty('key1', 'SUM05')
lvc_data.setProperty('column2', 'act_tp')  //결과진행구분
lvc_data.setProperty('key2', 'SUM26')
lvc_data.setProperty('column3', 'hakgi')  //학기
lvc_data.setProperty('key3', 'HSG01')
lvc_data.setProperty('column4', 'counsel_place') //상담방법
lvc_data.setProperty('key4', 'SUM32')
func.of_dddw( tab_1.tabpage_1.dw_tab1,lvc_data)

lvc_data.setProperty('column3', 'purpose')  //찾은목적
lvc_data.setProperty('key3', 'SUM02')
lvc_data.setProperty('column4', 'case_tp')  //상담구분
lvc_data.setProperty('key4', 'SUM05')
lvc_data.setProperty('column5', 'monthod')  //찾아온경위
lvc_data.setProperty('key5', 'SUM06')
func.of_dddw( tab_1.tabpage_3.dw_tab3,lvc_data)


String ls_year, ls_hakgi, ls_str, ls_end
uo_hsfunc hsfunc

hsfunc = Create uo_hsfunc
// 초기 Value Setup - 해당 상담관리에서 사용하는 최종 연도및학기를 확인한다.
hsfunc.of_get_yearhakgi('SUM', lvc_data)

ls_year = lvc_data.GetProperty('year')
ls_hakgi = lvc_data.GetProperty('hakgi')
ls_str = lvc_data.GetProperty('hakgi_str')
ls_end = lvc_data.GetProperty('hakgi_end')

If ls_year = '' Or IsNull(ls_year) Then
	dw_con.object.hakyear[dw_con.getrow()] = func.of_get_sdate('yyyy')
	tab_1.tabpage_1.dw_tab1.object.year[1] = func.of_get_sdate('yyyy')

	
	dw_con.object.case_dt_fr[dw_con.getrow()] = func.of_get_sdate('yyyymm') + '01'
	dw_con.object.case_dt_to[dw_con.getrow()] = func.of_get_sdate('yyyymmdd')
Else
	dw_con.object.hakyear[dw_con.getrow()] = ls_year
	dw_con.Object.hakgi[dw_con.getrow()] = ls_hakgi
	
	dw_con.object.case_dt_fr[dw_con.getrow()] = ls_str
	dw_con.object.case_dt_to[dw_con.getrow()] = ls_end
	
	
	tab_1.tabpage_1.dw_tab1.object.year[1] = ls_year
	tab_1.tabpage_1.dw_tab1.object.hakgi[1] = ls_hakgi
End If

dw_con.object.hakyear.protect = 1
dw_con.object.hakgi.protect = 1


String ls_today, ls_fr_dt, ls_to_dt, ls_close_dt
ls_today = func.of_get_sdate('YYYYMMDD') 

SELECT HAKGI_STR, HAKGI_END,  NVL(CLOSE_DT, '29991231')
INTO :ls_fr_dt, :ls_to_dt, :ls_close_dt
FROM HAKSA.SUM170TL
WHERE YEAR = :ls_year
AND HAKGI = :ls_hakgi
USING SQLCA;

If ls_close_dt = '' or isnull(ls_close_dt) Then ls_close_dt = '29991231'
If ls_fr_dt <> '' AND isnull(ls_fr_dt)= False then
	If ls_fr_dt > ls_today or ls_today > ls_to_dt  or ls_today > ls_close_dt Then
		uc_insert.of_enable(false)
		uc_delete.of_enable(false)
		uc_save.of_enable(false)
		tab_1.tabpage_1.dw_tab1.object.datawindow.readonly = 'Yes'
	End If
End If



//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

end event

event ue_insert;call super::ue_insert;//상담신청 자동 생성 입력
String		ls_year, ls_hakgi, ls_hakbun, ls_tel, ls_hp, ls_email, ls_case_no, ls_hname, ls_sex
String		ls_counsel_tp, ls_member_no, ls_su_hakyun, ls_prof_name
String		ls_gwa, ls_gwa_name, ls_rst_no
Long		ll_rv, ll_row
Long 		l_rst_no, l_case_no

dw_con.accepttext()
ll_row = dw_con.getrow()
ls_year = dw_con.object.hakyear[ll_row]
ls_hakgi = dw_con.object.hakgi[ll_row]
ls_hakbun = dw_con.object.hakbun[ll_row]
//ls_case_no = dw_list.object.case_no[ll_row]
//ls_counsel_tp = trim(dw_con.object.case_tp[ll_row])

If ls_year = '' or isnull(ls_year) Then 
	Messagebox("알림", "학년도를 입력하세요!")
	RETURN 
End If

If ls_hakgi = '' or isnull(ls_hakgi) Then 
	Messagebox("알림", "학기를 입력하세요!")
	RETURN 
End If
//If ls_hakbun = '' or isnull(ls_hakbun) Then 
//	Messagebox("알림", "학번을 입력하세요!")
//	RETURN 
//End If




////If Messagebox("알림", "상담 신청 건 포함 신규입력을 하시겠습니까?", Exclamation!, YesNo!, 2) = 2 Then RETURN
//
//
If ls_hakbun <> '' and isnull(ls_hakbun) = false Then 

SELECT :ls_year || lpad((to_number(nvl(max(substr(rst_no,5,10)), 0))) + 1, 6,'0') 
  INTO :l_rst_no
  from SUM140tl 
 where rst_no like :ls_year || '%'
 and hakbun = :ls_hakbun;

 If isnull(l_rst_no ) Then 
	ls_rst_no =  ls_year + '000001'
Else
	ls_rst_no = String(l_rst_no)
End If


SELECT :ls_year || lpad((to_number(nvl(max(substr(case_no,5,10)), 0))) + 1, 6,'0') 
  INTO :l_case_no
  FROM SUM120TL
 where case_no like :ls_year || '%'
  and hakbun = :ls_hakbun;
 
 If isnull(l_case_no ) Then 
	ls_case_no =  ls_year + '000001'
Else
	ls_case_no = String(l_case_no)
End If

//SELECT :ls_year || lpad((to_number(nvl(max(substr(rst_no,5,10)), 0))) + 1, 6,'0') 
//  INTO :l_rst_no
//  from SUM140tl 
// where rst_no like :ls_year || '%';
// 

SELECT TEL,     HP,     EMAIL, GWA, 
 (SELECT  FNAME  FROM 	CDDB.KCH003M  B WHERE B.GWA = A.GWA) , HNAME, SEX, SU_HAKYUN
  INTO :ls_tel, :ls_hp, :ls_email  , :ls_gwa, :ls_gwa_name, :ls_hname, :ls_sex, :ls_su_hakyun
  FROM HAKSA.JAEHAK_HAKJUK A
 WHERE HAKBUN   = :ls_hakbun;
 
SELECT  B.MEMBER_NO, C.NAME 
INTO :ls_member_no, :ls_prof_name
FROM HAKSA.PROF_SYM C , HAKSA.SUM210TL B
WHERE B.MEMBER_NO = C.MEMBER_NO
AND B.YEAR = :ls_year
AND B.HAKGI = :ls_hakgi
AND B.HAKBUN = :ls_hakbun;


If ls_member_no <> gs_empcode Then //로그인자와 지도교수가 다를 경우
 	ls_counsel_tp = '9'
Else
	ls_counsel_tp = '2'
End If	
	

tab_1.tabpage_1.dw_tab1.reset()
ll_row = tab_1.tabpage_1.dw_tab1.insertrow(0)

tab_1.tabpage_1.dw_tab1.object.year[ll_row] = ls_year
tab_1.tabpage_1.dw_tab1.object.hakgi[ll_row] = ls_hakgi
tab_1.tabpage_1.dw_tab1.object.hakbun[ll_row] = ls_hakbun
tab_1.tabpage_1.dw_tab1.object.hname[ll_row] = ls_hname
tab_1.tabpage_1.dw_tab1.object.case_no[ll_row] = ls_case_no
tab_1.tabpage_1.dw_tab1.object.rst_no[ll_row] = ls_rst_no  //상담결과번호
tab_1.tabpage_1.dw_tab1.object.counsel_dt[ll_row] = func.of_get_sdate('yyyymmdd')
tab_1.tabpage_1.dw_tab1.object.counsel_tp[ll_row] = ls_counsel_tp
//tab_1.tabpage_1.dw_tab1.object.start_time[ll_row] = left(func.of_get_sdate('hhmmss'), 4)
tab_1.tabpage_1.dw_tab1.object.act_tp[ll_row] = '1'  //상담결과구분
tab_1.tabpage_1.dw_tab1.object.purpose[ll_row] = '1'  //상담
tab_1.tabpage_1.dw_tab1.object.tel[ll_row] = ls_tel
tab_1.tabpage_1.dw_tab1.object.hp[ll_row] = ls_hp
tab_1.tabpage_1.dw_tab1.object.counseller[ll_row] = gs_empcode
tab_1.tabpage_1.dw_tab1.object.coun_name[ll_row] = gs_empname
tab_1.tabpage_1.dw_tab1.object.gwa[ll_row] = ls_gwa
tab_1.tabpage_1.dw_tab1.object.gwa_nm[ll_row] = ls_gwa_name
tab_1.tabpage_1.dw_tab1.object.su_hakyun[ll_row] = ls_su_hakyun
tab_1.tabpage_1.dw_tab1.object.sex[ll_row] = ls_sex
Else
tab_1.tabpage_1.dw_tab1.reset()
ll_row = tab_1.tabpage_1.dw_tab1.insertrow(0)

tab_1.tabpage_1.dw_tab1.object.year[ll_row] = ls_year
tab_1.tabpage_1.dw_tab1.object.hakgi[ll_row] = ls_hakgi
tab_1.tabpage_1.dw_tab1.object.counsel_dt[ll_row] = func.of_get_sdate('yyyymmdd')
tab_1.tabpage_1.dw_tab1.object.act_tp[ll_row] = '1'  //상담결과구분
tab_1.tabpage_1.dw_tab1.object.purpose[ll_row] = '1'  //상담
tab_1.tabpage_1.dw_tab1.object.counseller[ll_row] = gs_empcode
tab_1.tabpage_1.dw_tab1.object.coun_name[ll_row] = gs_empname


End if
tab_1.tabpage_1.dw_tab1.object.datawindow.readonly = 'No'
uc_delete.of_enable(true)
    uc_save.of_enable(true)
//
//RETURN 1




//tab_1.tabpage_1.dw_tab1.PostEvent("ue_InsertRow")
//tab_1.SelectTab(1)

//tab_1.tabpage_2.dw_tab2.PostEvent("ue_InsertRow")
//tab_1.tabpage_3.dw_tab3.PostEvent("ue_InsertRow")

end event

event ue_delete;call super::ue_delete;Long		ll_row
String		ls_txt

//ls_txt = "[삭제] "
//tab_1.tabpage_1.dw_tab1.uf_DeleteAll()
//tab_1.tabpage_2.dw_tab2.uf_DeleteAll()
//tab_1.tabpage_3.dw_tab3.uf_DeleteAll()
//

tab_1.tabpage_1.dw_tab1.event ue_deleterow()

If Trigger Event ue_save() <> 1 Then
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
Else
	ll_row = dw_list.GetRow()
	If ll_row > 0 Then
		dw_list.DeleteRow(ll_row)
	End If
	f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
End If

end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = THIS.Event ue_updatequery() 
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

event ue_save;call super::ue_save;If ancestorreturnvalue = 1 Then 
	dw_list.event ue_retrieve()
End If

return 1
end event

event ue_savestart;call super::ue_savestart;If ancestorreturnvalue < 1 Then 
	Return -1
End If

String		ls_year, ls_hakgi, ls_hakbun,    ls_case_no  , ls_counsel_dt
String		ls_err
Long		 ll_row, ll_cnt
String		ls_case_tp, ls_purpose, ls_tel, ls_hp, ls_title, ls_context, ls_member_no, ls_hname, ls_prof_name
String		ls_gwa, ls_gwa_name, ls_su_hakyun, ls_sex, ls_counseller




tab_1.tabpage_1.dw_tab1.accepttext()
If tab_1.tabpage_1.dw_tab1.rowcount() = 0 Then
	//삭제 시
	
ll_row = dw_list.getrow()
ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_hakbun = dw_list.object.hakbun[ll_row]
ls_case_no = dw_list.object.case_no[ll_row]	

	
//UPDATE HAKSA.SUM120TL
//SET COUNSEL_DT = '',
//       STEP = '4',
//       JOB_UID = :gs_empcode ,
//       JOB_ADD = :gs_ip ,
//       JOB_DATE = sysdate
//WHERE YEAR = :ls_year
//AND HAKGI = :ls_hakgi
//AND CASE_NO = :ls_case_no
//AND HAKBUN = :ls_hakbun
//AND STEP = '6' 
//USING SQLCA;	

DELETE FROM  HAKSA.SUM120TL
WHERE YEAR = :ls_year
AND HAKGI = :ls_hakgi
AND CASE_NO = :ls_case_no
AND HAKBUN = :ls_hakbun
USING SQLCA;	

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("알림", ls_err)
	RETURN -1
End If
	
Else
	

ll_row = tab_1.tabpage_1.dw_tab1.getrow()
ls_year = tab_1.tabpage_1.dw_tab1.object.year[ll_row]
ls_hakgi = tab_1.tabpage_1.dw_tab1.object.hakgi[ll_row]
ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[ll_row]
ls_case_no = tab_1.tabpage_1.dw_tab1.object.case_no[ll_row]
ls_counsel_dt = tab_1.tabpage_1.dw_tab1.object.counsel_dt[ll_row]   //상담일자

SELECT COUNT(*)
INTO :ll_cnt
FROM HAKSA.SUM120TL
WHERE YEAR = :ls_year
AND HAKGI = :ls_hakgi
AND CASE_NO = :ls_case_no
AND HAKBUN = :ls_hakbun
USING SQLCA;

If ll_cnt = 0 Then



ls_case_tp = tab_1.tabpage_1.dw_tab1.object.counsel_tp[ll_row] 
ls_purpose = tab_1.tabpage_1.dw_tab1.object.purpose[ll_row]
ls_tel = tab_1.tabpage_1.dw_tab1.object.tel[ll_row] 
ls_hp = tab_1.tabpage_1.dw_tab1.object.hp[ll_row]
ls_title = tab_1.tabpage_1.dw_tab1.object.title[ll_row]
ls_context = tab_1.tabpage_1.dw_tab1.object.context[ll_row]
ls_counseller = tab_1.tabpage_1.dw_tab1.object.counseller[ll_row] 
ls_hname = tab_1.tabpage_1.dw_tab1.object.hname[ll_row]  
ls_gwa = tab_1.tabpage_1.dw_tab1.object.gwa[ll_row] 
ls_gwa_name = tab_1.tabpage_1.dw_tab1.object.gwa_nm[ll_row]
ls_su_hakyun = tab_1.tabpage_1.dw_tab1.object.su_hakyun[ll_row] 
ls_sex = tab_1.tabpage_1.dw_tab1.object.sex[ll_row] 	

SELECT  B.MEMBER_NO
INTO :ls_member_no
FROM HAKSA.PROF_SYM C , HAKSA.SUM210TL B
WHERE B.MEMBER_NO = C.MEMBER_NO
AND B.YEAR = :ls_year
AND B.HAKGI = :ls_hakgi
AND B.HAKBUN = :ls_hakbun;
	
	INSERT INTO HAKSA.SUM120TL
	(  YEAR ,		HAKGI ,		CASE_NO ,		HAKBUN , 
	    CASE_TP ,	CASE_DATE ,	TEL ,			HP ,
	    PURPOSE , 	TITLE ,		CONTEXT ,	STEP ,			
	    ACT_DT ,          ACT_MEM_NO ,	COUNSEL_DT ,	MEMBER_NO , 
	    COUNSELLER ,	HNAME ,		GWA ,			GWA_NM ,	
	    SU_HAKYUN ,	SEX ,		WORKER ,		IPADDR ,
	    WORK_DATE ,JOB_UID ,JOB_ADD ,JOB_DATE)
VALUES(:ls_year, 		:ls_hakgi,		:ls_case_no,		:ls_hakbun,
	:ls_case_tp,	to_char(sysdate, 'yyyymmdd'), :ls_tel,		:ls_hp,
	:ls_purpose,	:ls_title, 		:ls_context,		'6',	
	to_char(sysdate, 'yyyymmdd'),  	:gs_empcode,	:ls_counsel_dt,	:ls_member_no,
	:ls_counseller,	:ls_hname,	:ls_gwa, 			:ls_gwa_name,
	:ls_su_hakyun,	:ls_sex,		:gs_empcode,	:gs_ip,
	sysdate,		:gs_empcode,	:gs_ip,		sysdate)
	USING SQLCA;
	
	
Else	


//진행단계가 완료가 아닌 건들 중 업데이트함.
UPDATE HAKSA.SUM120TL
SET COUNSEL_DT = :ls_counsel_dt,
       STEP = '6'
WHERE YEAR = :ls_year
AND HAKGI = :ls_hakgi
AND CASE_NO = :ls_case_no
AND HAKBUN = :ls_hakbun
AND STEP <> '6' 
USING SQLCA;

End If

If SQLCA.SQLCODE <> 0 Then
	ls_err = SQLCA.SQLERRTEXT
	ROLLBACK USING SQLCA;
	Messagebox("알림", ls_err)
	RETURN -1
End If
	
End If	
	



RETURN 1
//
end event

event ue_button_set;call super::ue_button_set;uo_stu.x = ln_tempright.beginx - uo_stu.width
end event

type ln_templeft from w_window`ln_templeft within w_hsg108a
end type

type ln_tempright from w_window`ln_tempright within w_hsg108a
end type

type ln_temptop from w_window`ln_temptop within w_hsg108a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hsg108a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hsg108a
end type

type ln_tempstart from w_window`ln_tempstart within w_hsg108a
end type

type uc_retrieve from w_window`uc_retrieve within w_hsg108a
end type

type uc_insert from w_window`uc_insert within w_hsg108a
end type

type uc_delete from w_window`uc_delete within w_hsg108a
end type

type uc_save from w_window`uc_save within w_hsg108a
end type

type uc_excel from w_window`uc_excel within w_hsg108a
end type

type uc_print from w_window`uc_print within w_hsg108a
end type

type st_line1 from w_window`st_line1 within w_hsg108a
end type

type st_line2 from w_window`st_line2 within w_hsg108a
end type

type st_line3 from w_window`st_line3 within w_hsg108a
end type

type uc_excelroad from w_window`uc_excelroad within w_hsg108a
end type

type dw_list from uo_grid within w_hsg108a
event type long ue_retrieve ( )
integer x = 50
integer y = 484
integer width = 4389
integer height = 468
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg108a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_year, ls_hakgi, ls_hakbun, ls_fr_dt, ls_to_dt, ls_case_tp
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.hakyear[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.GetRow()]
ls_hakbun = func.of_nvl(dw_con.object.hakbun[dw_con.GetRow()], '%')
ls_fr_dt = dw_con.object.case_dt_fr[dw_con.Getrow()]
ls_to_dt = dw_con.object.case_dt_to[dw_con.Getrow()]
ls_case_tp = func.of_nvl(dw_con.object.case_tp[dw_con.Getrow()], '%')

If ls_year = '' or isnull(ls_year) Then 
	Messagebox("알림", "학년도를 입력하세요!")
	RETURN -1
End If

If ls_hakgi = '' or isnull(ls_hakgi) Then 
	Messagebox("알림", "학기를 입력하세요!")
	RETURN -1
End If
If ls_hakbun = '' or isnull(ls_hakbun) Then 
	Messagebox("알림", "학번을 입력하세요!")
	RETURN -1
End If

//If ls_case_tp = '' or isnull(ls_case_tp) Then 
//	Messagebox("알림", "상담구분을 입력하세요!")
//	RETURN -1
//End If




tab_1.tabpage_1.dw_tab1.Reset()
tab_1.tabpage_2.dw_tab2.Reset()
tab_1.tabpage_3.dw_tab3.Reset()

ll_rv = This.Retrieve(ls_year, ls_hakgi, ls_fr_dt, ls_to_dt , ls_case_tp, ls_hakbun)
If ll_rv = 0 Then
	
	tab_1.tabpage_1.dw_tab1.event ue_insertrow()
	tab_1.tabpage_1.dw_tab1.object.datawindow.readonly = 'Yes'
Else
	tab_1.tabpage_1.dw_tab1.object.datawindow.readonly = 'No'
	
End If

RETURN ll_rv

end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_rv
//String		ls_arg1
//String		ls_arg2

This.AcceptText()

ll_rv = Parent.Event ue_row_updatequery() 

If currentrow > 0 And (ll_rv = 1 or ll_rv = 2) Then
	If dw_list.GetItemStatus(currentrow, 0, Primary!) <> New! Then
//		ls_arg1 = This.Object.arg_key1[currentrow]
//		ls_arg2 = This.Object.arg_key2[currentrow]
		tab_1.tabpage_1.dw_tab1.event ue_Retrieve()
		tab_1.tabpage_2.dw_tab2.event ue_Retrieve()
		tab_1.tabpage_3.dw_tab3.event ue_Retrieve()
	Else
		//dw_main.Post Event ue_InsertRow()
	End If
End If

il_rv = 0

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

event retrieveend;call super::retrieveend;If rowcount > 0 Then
This.setrow(1)
tab_1.tabpage_1.dw_tab1.event ue_Retrieve()
tab_1.tabpage_2.dw_tab2.event ue_Retrieve()
tab_1.tabpage_3.dw_tab3.event ue_Retrieve()
End If
end event

type dw_con from uo_dw within w_hsg108a
integer x = 50
integer y = 164
integer width = 4389
integer height = 200
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg107a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_hakbun
This.accepttext()
ls_KName =  trim(this.object.kname[1])



OpenWithParm(w_hsg_hakjuk,ls_kname)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[2]	//성명
ls_hakbun            = lstr_com.ls_item[1]	//학번
this.object.kname[1]        = ls_kname					//성명
This.object.hakbun[1]     = ls_hakbun				//개인번호
Parent.post event ue_inquiry()	
return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_kname

This.accepttext()
Choose Case	dwo.name
	Case	'hakbun','kname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'kname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'kname'	, '')			
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
			This.object.kname[row] = ls_kname
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
End Choose


end event

event constructor;call super::constructor;this.object.case_tp_t.text = '상담구분'
this.object.case_tp_t.visible = 0
this.object.case_tp.visible = 0
//
end event

type tab_1 from tab within w_hsg108a
integer x = 50
integer y = 1068
integer width = 4379
integer height = 1204
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean raggedright = true
boolean showpicture = false
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;Choose Case newindex
	Case 1 
		uc_delete.of_enable(true)
		uc_save.of_enable(true)
		uc_insert.of_enable(true)
		
	Case Else
		uc_delete.of_enable(false)
		uc_save.of_enable(false)
		uc_insert.of_enable(false)
End Choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4343
integer height = 1092
long backcolor = 16777215
string text = "상담 결과 등록"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab1 dw_tab1
st_tab1_line st_tab1_line
end type

on tabpage_1.create
this.dw_tab1=create dw_tab1
this.st_tab1_line=create st_tab1_line
this.Control[]={this.dw_tab1,&
this.st_tab1_line}
end on

on tabpage_1.destroy
destroy(this.dw_tab1)
destroy(this.st_tab1_line)
end on

type dw_tab1 from uo_dw within tabpage_1
event type long ue_retrieve ( )
integer width = 4370
integer height = 1080
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hsg108a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no, ls_counseller
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_counseller = func.of_nvl(dw_list.object.counseller[ll_row], '')

If ls_counseller <> gs_empcode Then  //상담자와 다를 경우
    This.reset()
    This.insertrow(0)
    uc_delete.of_enable(false)
    uc_save.of_enable(false)
    tab_1.tabpage_1.dw_tab1.object.datawindow.readonly = 'Yes'
Else
tab_1.tabpage_1.dw_tab1.object.datawindow.readonly = 'No'	
   uc_delete.of_enable(true)
    uc_save.of_enable(true)

ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_hakbun = dw_list.object.hakbun[ll_row]
ls_case_no = dw_list.object.case_no[ll_row]

ll_rv = this.Retrieve(ls_year, ls_hakgi, ls_case_no, ls_hakbun)

If ll_rv = 0 Then 
	This.event ue_insertrow()
End If

End If

RETURN ll_rv



end event

event ue_insertrow;call super::ue_insertrow;String		ls_year, ls_hakgi, ls_hakbun, ls_tel, ls_hp, ls_email, ls_case_no, ls_hname, ls_sex
String		ls_counsel_tp, ls_member_no
String		ls_gwa, ls_gwa_name, ls_rst_no
Long		ll_rv, ll_row
Long 		l_rst_no

dw_list.accepttext()

If dw_list.rowcount() = 0 Then RETURN -1
ll_row = dw_list.getrow()
ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_hakbun = dw_list.object.hakbun[ll_row]
ls_case_no = dw_list.object.case_no[ll_row]
ls_counsel_tp = dw_list.object.case_tp[ll_row]



SELECT :ls_year || lpad((to_number(nvl(max(substr(rst_no,5,10)), 0))) + 1, 6,'0') 
  INTO :l_rst_no
  from SUM140tl 
 where rst_no like :ls_year || '%'
 and hakbun = :ls_hakbun;

 If isnull(l_rst_no ) Then 
	ls_rst_no =  ls_year + '000001'
Else
	ls_rst_no = String(l_rst_no)
End If


//SELECT TEL,     HP,     EMAIL, GWA, 
// (SELECT  FNAME  FROM 	CDDB.KCH003M  B WHERE B.GWA = A.GWA) , HNAME, SEX
//  INTO :ls_tel, :ls_hp, :ls_email  , :ls_gwa, :ls_gwa_name, :ls_hname, :ls_sex
//  FROM HAKSA.JAEHAK_HAKJUK A
// WHERE HAKBUN   = :ls_hakbun;
ls_member_no = dw_list.object.counseller[ll_row]
SELECT NAME 
INTO :ls_hname
FROM INDB.HIN001M
WHERE MEMBER_NO = :ls_member_no
USING SQLCA;


This.object.year[This.getrow()] = ls_year
This.object.hakgi[This.getrow()] = ls_hakgi
This.object.hakbun[This.getrow()] = ls_hakbun
This.object.case_no[This.getrow()] = ls_case_no
This.object.rst_no[This.getrow()] = ls_rst_no  //상담결과번호
This.object.counsel_dt[This.getrow()] = func.of_get_sdate('yyyymmdd')
This.object.counsel_tp[This.getrow()] = ls_counsel_tp
//This.object.start_time[This.getrow()] = left(func.of_get_sdate('hhmmss'), 4)
This.object.act_tp[This.getrow()] = '1'  //상담결과구분
This.object.purpose[This.getrow()] = dw_list.object.purpose[ll_row]
This.object.tel[This.getrow()] = dw_list.object.tel[ll_row]
This.object.hp[This.getrow()] = dw_list.object.hp[ll_row]
This.object.counseller[This.getrow()] = ls_member_no
This.object.coun_name[This.getrow()] = ls_hname
This.object.gwa[This.getrow()] = dw_list.object.gwa[ll_row]
This.object.gwa_nm[This.getrow()] = dw_list.object.gwa_nm[ll_row]
This.object.su_hakyun[This.getrow()] = dw_list.object.su_hakyun[ll_row]
This.object.sex[This.getrow()] = dw_list.object.sex[ll_row]


RETURN 1

end event

event clicked;call super::clicked;s_insa_com	lstr_com
String		ls_hName, ls_hakbun
String		ls_KName, ls_member_no

			//상담신청 자동 생성 입력
String		ls_year, ls_hakgi, ls_tel, ls_hp, ls_email, ls_case_no,  ls_sex
String		ls_counsel_tp,  ls_su_hakyun, ls_prof_name
String		ls_gwa, ls_gwa_name, ls_rst_no
Long		ll_rv, ll_row
Long 		l_rst_no, l_case_no
String 		ls_readonly

This.accepttext()


If dwo.name = 'p_search' Then
	
	ls_KName =  trim(this.object.coun_name[row])
	
	lstr_com.ls_item[1] = ls_KName		//성명
	lstr_com.ls_item[2] = ''				//개인번호
	lstr_com.ls_item[3] = ''
	
	OpenWithParm(w_hin000h,lstr_com)
	
	
	lstr_com = Message.PowerObjectParm
	IF NOT isValid(lstr_com) THEN
		this.SetFocus()
		this.setcolumn('coun_name')
		RETURN -1
	END IF
	
	ls_kname               = lstr_com.ls_item[01]	//성명
	ls_Member_No            = lstr_com.ls_item[02]	//개인번호
	this.object.coun_name[1]        = ls_kname					//성명
	This.object.counseller[1]     = ls_Member_No				//개인번호
	return 1

ElseIf dwo.name = 'p_hakbun' Then
	ls_readonly = This.object.datawindow.readonly	
	if UPPER(ls_readonly) = 'YES' Then RETURN -1

	ls_hName =  trim(this.object.hname[row])
	
	
	
	OpenWithParm(w_hsg_hakjuk,ls_hname)
	
	
	lstr_com = Message.PowerObjectParm
	IF NOT isValid(lstr_com) THEN
		this.SetFocus()
		this.setcolumn('hname')
		RETURN
	END IF
	
	ls_hname               = lstr_com.ls_item[2]	//성명
	ls_hakbun            = lstr_com.ls_item[1]	//학번
	this.object.hname[row]        = ls_kname					//성명
	This.object.hakbun[row]     = ls_hakbun				//개인번호
	
	
	dw_con.accepttext()
	ll_row = dw_con.getrow()
	ls_year = dw_con.object.hakyear[ll_row]
	ls_hakgi = dw_con.object.hakgi[ll_row]
	
	SELECT :ls_year || lpad((to_number(nvl(max(substr(rst_no,5,10)), 0))) + 1, 6,'0') 
	  INTO :l_rst_no
	  from SUM140tl 
	 where rst_no like :ls_year || '%'
	 and hakbun = :ls_hakbun;
	
	 If isnull(l_rst_no ) Then 
		ls_rst_no =  ls_year + '000001'
	Else
		ls_rst_no = String(l_rst_no)
	End If
	
	
	SELECT :ls_year || lpad((to_number(nvl(max(substr(case_no,5,10)), 0))) + 1, 6,'0') 
	  INTO :l_case_no
	  FROM SUM120TL
	 where case_no like :ls_year || '%'
	  and hakbun = :ls_hakbun;
	 
	 If isnull(l_case_no ) Then 
		ls_case_no =  ls_year + '000001'
	Else
		ls_case_no = String(l_case_no)
	End If
	
	//SELECT :ls_year || lpad((to_number(nvl(max(substr(rst_no,5,10)), 0))) + 1, 6,'0') 
	//  INTO :l_rst_no
	//  from SUM140tl 
	// where rst_no like :ls_year || '%';
	// 
	
	SELECT TEL,     HP,     EMAIL, GWA, 
	 (SELECT  FNAME  FROM 	CDDB.KCH003M  B WHERE B.GWA = A.GWA) , HNAME, SEX, SU_HAKYUN
	  INTO :ls_tel, :ls_hp, :ls_email  , :ls_gwa, :ls_gwa_name, :ls_hname, :ls_sex, :ls_su_hakyun
	  FROM HAKSA.JAEHAK_HAKJUK A
	 WHERE HAKBUN   = :ls_hakbun;
	 
	SELECT  B.MEMBER_NO, C.NAME 
	INTO :ls_member_no, :ls_prof_name
	FROM HAKSA.PROF_SYM C , HAKSA.SUM210TL B
	WHERE B.MEMBER_NO = C.MEMBER_NO
	AND B.YEAR = :ls_year
	AND B.HAKGI = :ls_hakgi
	AND B.HAKBUN = :ls_hakbun;
	
	
	If ls_member_no <> gs_empcode Then //로그인자와 지도교수가 다를 경우
		ls_counsel_tp = '9'
	Else
		ls_counsel_tp = '2'
	End If	
	
	this.object.year[row] = ls_year
	this.object.hakgi[row] = ls_hakgi
	this.object.hakbun[row] = ls_hakbun
	This.object.hname[row] = ls_hname
	this.object.case_no[row] = ls_case_no
	this.object.rst_no[row] = ls_rst_no  //상담결과번호
	this.object.counsel_dt[row] = func.of_get_sdate('yyyymmdd')
	this.object.counsel_tp[row] = ls_counsel_tp
	//this.object.start_time[row] = left(func.of_get_sdate('hhmmss'), 4)
	this.object.act_tp[row] = '1'  //상담결과구분
	this.object.purpose[row] = '1'  //상담
	this.object.tel[row] = ls_tel
	this.object.hp[row] = ls_hp
	this.object.counseller[row] = gs_empcode
	this.object.coun_name[row] = gs_empname
	this.object.gwa[row] = ls_gwa
	this.object.gwa_nm[row] = ls_gwa_name
	this.object.su_hakyun[row] = ls_su_hakyun
	this.object.sex[row] = ls_sex
	
	this.object.datawindow.readonly = 'No'


return 1


End If
end event

event itemchanged;call super::itemchanged;String ls_h01nno, ls_h01knm, ls_hakbun, ls_hname
			//상담신청 자동 생성 입력
String		ls_year, ls_hakgi, ls_tel, ls_hp, ls_email, ls_case_no,  ls_sex
String		ls_counsel_tp, ls_member_no, ls_su_hakyun, ls_prof_name
String		ls_gwa, ls_gwa_name, ls_rst_no
Long		ll_rv, ll_row
Long 		l_rst_no, l_case_no


This.accepttext()
Choose Case dwo.name	
    	Case	'counseller','coun_name'
		If dwo.name = 'counseller' Then	ls_h01nno = data
		If dwo.name = 'coun_name' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'counseller'	, '')
			This.Post SetItem(row, 'coun_name'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_h01nno , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_h01nno || '%'
		AND NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.counseller[row] = ls_h01nno
			This.object.coun_name[row] = ls_h01knm
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
		
	Case	'hakbun','hname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'hname' Then	ls_hname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'hname'	, '')			
			RETURN
		End If
		
		SELECT HAKBUN, HNAME
		INTO :ls_hakbun , :ls_hname
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
		AND HNAME LIKE :ls_hname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.hakbun[row] = ls_hakbun
			This.object.hname[row] = ls_hname		
			
			
			


			dw_con.accepttext()
			ll_row = dw_con.getrow()
			ls_year = dw_con.object.hakyear[ll_row]
			ls_hakgi = dw_con.object.hakgi[ll_row]
			
			SELECT :ls_year || lpad((to_number(nvl(max(substr(rst_no,5,10)), 0))) + 1, 6,'0') 
			  INTO :l_rst_no
			  from SUM140tl 
			 where rst_no like :ls_year || '%'
			 and hakbun = :ls_hakbun;
			
			 If isnull(l_rst_no ) Then 
				ls_rst_no =  ls_year + '000001'
			Else
				ls_rst_no = String(l_rst_no)
			End If
			
			
			SELECT :ls_year || lpad((to_number(nvl(max(substr(case_no,5,10)), 0))) + 1, 6,'0') 
			  INTO :l_case_no
			  FROM SUM120TL
			 where case_no like :ls_year || '%'
			  and hakbun = :ls_hakbun;
			 
			 If isnull(l_case_no ) Then 
				ls_case_no =  ls_year + '000001'
			Else
				ls_case_no = String(l_case_no)
			End If
			
			//SELECT :ls_year || lpad((to_number(nvl(max(substr(rst_no,5,10)), 0))) + 1, 6,'0') 
			//  INTO :l_rst_no
			//  from SUM140tl 
			// where rst_no like :ls_year || '%';
			// 
			
			SELECT TEL,     HP,     EMAIL, GWA, 
			 (SELECT  FNAME  FROM 	CDDB.KCH003M  B WHERE B.GWA = A.GWA) , HNAME, SEX, SU_HAKYUN
			  INTO :ls_tel, :ls_hp, :ls_email  , :ls_gwa, :ls_gwa_name, :ls_hname, :ls_sex, :ls_su_hakyun
			  FROM HAKSA.JAEHAK_HAKJUK A
			 WHERE HAKBUN   = :ls_hakbun;
			 
			SELECT  B.MEMBER_NO, C.NAME 
			INTO :ls_member_no, :ls_prof_name
			FROM HAKSA.PROF_SYM C , HAKSA.SUM210TL B
			WHERE B.MEMBER_NO = C.MEMBER_NO
			AND B.YEAR = :ls_year
			AND B.HAKGI = :ls_hakgi
			AND B.HAKBUN = :ls_hakbun;
			
			
			If ls_member_no <> gs_empcode Then //로그인자와 지도교수가 다를 경우
				ls_counsel_tp = '9'
			Else
				ls_counsel_tp = '2'
			End If				
			
			this.object.year[row] = ls_year
			this.object.hakgi[row] = ls_hakgi
			this.object.hakbun[row] = ls_hakbun
			This.object.hname[row] = ls_hname
			this.object.case_no[row] = ls_case_no
			this.object.rst_no[row] = ls_rst_no  //상담결과번호
			this.object.counsel_dt[row] = func.of_get_sdate('yyyymmdd')
			this.object.counsel_tp[row] = ls_counsel_tp
			//this.object.start_time[row] = left(func.of_get_sdate('hhmmss'), 4)
			this.object.act_tp[row] = '1'  //상담결과구분
			this.object.purpose[row] = '1'  //상담
			this.object.tel[row] = ls_tel
			this.object.hp[row] = ls_hp
			this.object.counseller[row] = gs_empcode
			this.object.coun_name[row] = gs_empname
			this.object.gwa[row] = ls_gwa
			this.object.gwa_nm[row] = ls_gwa_name
			this.object.su_hakyun[row] = ls_su_hakyun
			this.object.sex[row] = ls_sex
			
			this.object.datawindow.readonly = 'No'
			
			
			
			
			
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_hakbun)
			return 1
			
		End If		
		

End Choose
end event

type st_tab1_line from statictext within tabpage_1
boolean visible = false
integer x = 137
integer y = 28
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 96
integer width = 4343
integer height = 1092
long backcolor = 16777215
string text = "학생정보 조회"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab2 dw_tab2
st_tab2_line st_tab2_line
end type

on tabpage_2.create
this.dw_tab2=create dw_tab2
this.st_tab2_line=create st_tab2_line
this.Control[]={this.dw_tab2,&
this.st_tab2_line}
end on

on tabpage_2.destroy
destroy(this.dw_tab2)
destroy(this.st_tab2_line)
end on

type dw_tab2 from uo_dw within tabpage_2
event type long ue_retrieve ( )
integer width = 4352
integer height = 1108
integer taborder = 10
string dataobject = "d_hsg109a_3"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no, ls_counseller
Long		ll_rv

ll_row = dw_list.GetRow()
dw_list.accepttext()

If ll_row <= 0 Then RETURN -1
ls_hakbun = dw_list.object.hakbun[ll_row]
ls_counseller = func.of_nvl(dw_list.object.counseller[ll_row], '')

If ls_counseller <> gs_empcode Then  //상담자와 다를 경우
   This.reset()
   This.insertrow(0)
Else

ll_rv = this.Retrieve(ls_hakbun)

If ll_rv = 0 Then 
	This.insertrow(0)
End If
end If
RETURN ll_rv

end event

event constructor;call super::constructor;this.object.datawindow.readonly = 'Yes'
end event

event retrieveend;call super::retrieveend;If rowcount = 0 Then return -1
String ls_hakbun

blob lbBmp
int li_cnt, i

int FP, Li_x, Li_count
long LL_size, LL_start, LL_write
blob imagedata, Lblb_part

ls_hakbun = this.object.hakbun[This.getrow()]

If ls_hakbun = '' or isnull(ls_hakbun) then
	 this.SetItem(1, 'bmp_hakbun', 'C:\emp_image\space.jpg')
Else

	IF DirectoryExists ('c:\emp_image') THEN
	ELSE
	   CreateDirectory ('c:\emp_image')
	END IF
	
	
	
	 SELECTBLOB	P_IMAGE
			 INTO :lbBmp
			 FROM HAKSA.PHOTO
			WHERE HAKBUN	= :ls_hakbun;
	 IF sqlca.sqlcode = 0 then
		
		 LL_size = Len(lbBmp)
		 IF LL_size > 32765 THEN
			 IF Mod(LL_size, 32765) = 0 THEN
				 Li_count = LL_size / 32765
			 ELSE
				 Li_count = (LL_size / 32765) + 1
			 END IF
		 ELSE
			 Li_count = 1
		 END IF
		
		 FP = FileOpen("c:\emp_image\" + ls_hakbun + ".jpg", StreamMode!, Write!, Shared!, Replace!)
		
		 FOR i = 1 to Li_count
			  LL_write    = FileWrite(fp,lbBmp )
			  IF LL_write = 32765 THEN
				  lbBmp    = BlobMid(lbBmp, 32766)
			  END IF
		 NEXT
		 FileClose(FP)
		 this.SetItem(1, 'bmp_hakbun', 'C:\emp_image\' + ls_hakbun + '.jpg')
	ELSE
		 this.SetItem(1, 'bmp_hakbun', 'C:\emp_image\space.jpg')
	END IF
End If
end event

type st_tab2_line from statictext within tabpage_2
boolean visible = false
integer x = 187
integer y = 32
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type tabpage_3 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 96
integer width = 4343
integer height = 1092
long backcolor = 16777215
string text = "상담신청내역 조회"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_sub dw_sub
dw_tab3 dw_tab3
dw_main dw_main
st_tab3_line st_tab3_line
end type

on tabpage_3.create
this.dw_sub=create dw_sub
this.dw_tab3=create dw_tab3
this.dw_main=create dw_main
this.st_tab3_line=create st_tab3_line
this.Control[]={this.dw_sub,&
this.dw_tab3,&
this.dw_main,&
this.st_tab3_line}
end on

on tabpage_3.destroy
destroy(this.dw_sub)
destroy(this.dw_tab3)
destroy(this.dw_main)
destroy(this.st_tab3_line)
end on

type dw_sub from uo_grid within tabpage_3
event type long ue_retrieve ( )
integer x = 3557
integer width = 795
integer height = 1104
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hsg105a_3"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no, ls_code
Long		ll_rv

dw_tab3.accepttext()
ll_row = dw_tab3.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_tab3.object.year[ll_row]
ls_hakgi = dw_tab3.object.hakgi[ll_row]
ls_hakbun = dw_tab3.object.hakbun[ll_row]
ls_case_no = dw_tab3.object.case_no[ll_row]
ls_code = dw_tab3.object.purpose[ll_row]
ll_rv = dw_sub.Retrieve(ls_year, ls_hakgi, ls_case_no, ls_hakbun, ls_code)


RETURN ll_rv

end event

event constructor;call super::constructor;this.object.datawindow.readonly = 'Yes'
end event

type dw_tab3 from uo_dw within tabpage_3
event type long ue_retrieve ( )
integer width = 3552
integer height = 1104
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hsg109a_4"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no, ls_counseller
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_counseller = func.of_nvl(dw_list.object.counseller[ll_row], '')

If ls_counseller <> gs_empcode Then  //상담자와 다를 경우
   This.reset()
   This.insertrow(0)
   dw_sub.Reset()
Else
	
ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_hakbun = dw_list.object.hakbun[ll_row]
ls_case_no = dw_list.object.case_no[ll_row]


ll_rv = this.Retrieve(ls_year, ls_hakgi, ls_case_no, ls_hakbun)
If ll_rv > 0 Then
	dw_sub.event ue_retrieve()	
Else
	dw_sub.Reset()
End If
End If
RETURN ll_rv

end event

event ue_deletestart;call super::ue_deletestart;Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no

ll_row = dw_main.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_main.object.year[ll_row]
ls_hakgi = dw_main.object.hakgi[ll_row]
ls_hakbun = dw_main.object.hakbun[ll_row]
ls_case_no = dw_main.object.case_no[ll_row]

DELETE FROM HAKSA.SUM130TL A
WHERE A.YEAR = :ls_year
AND A.HAKGI = :ls_hakgi
AND A.CASE_NO = :ls_case_no
AND A.HAKBUN = :ls_hakbun
USING SQLCA;

If SQLCA.SQLCODE <> 0 then
	ROLLBACK USING SQLCA;
	Messagebox("알림" ,"희망상담검사종목 SUM130TL 삭제 중 에러 발생!")
	RETURN -1
End If

return 1
end event

event ue_insertrow;call super::ue_insertrow;
If AncestorReturnValue = 1 Then dw_sub.Reset()

RETURN AncestorReturnValue

end event

event constructor;call super::constructor;this.object.datawindow.readonly = 'Yes'
end event

type dw_main from uo_dw within tabpage_3
event type long ue_retrieve ( )
integer x = 50
integer y = 1376
integer width = 3579
integer height = 888
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hsg105a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no, ls_step
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_list.object.year[ll_row]
ls_hakgi = dw_list.object.hakgi[ll_row]
ls_hakbun = dw_list.object.hakbun[ll_row]
ls_case_no = dw_list.object.case_no[ll_row]
ls_step = dw_list.object.step1[ll_row]

If ls_step = '2' then //신청
	This.object.datawindow.readonly = 'No'  //수정가능
	dw_sub.object.datawindow.readonly = 'No'  //수정가능
Else
	This.object.datawindow.readonly = 'Yes'  //수정불가능
	dw_sub.object.datawindow.readonly = 'Yes'  //수정불가능
End If

ll_rv = dw_main.Retrieve(ls_year, ls_hakgi, ls_case_no, ls_hakbun)
If ll_rv > 0 Then
	dw_sub.event ue_retrieve()	
Else
	dw_sub.Reset()
End If

RETURN ll_rv

end event

event itemchanged;call super::itemchanged;This.accepttext()
Choose Case dwo.name
	Case 'purpose'  //신규 row 시에만 tab 활성화 되므로.. 신규일 경우에만 발생함.
		//dw_sub를 재조회한다.(신규시 공통코드정보만 조회됨)
	//목적에 따라서 상담 종목이  바뀜.
		dw_sub.event ue_retrieve()
	Case 'case_tp'	
		If data = '2' Then  //지도교수 - 해당 지도교수를 상담자로 setting한다.
			This.object.counseller[row] = This.object.member_no[row]
			This.object.coun_name[row] = This.object.prof_name[row]
		Else //resest
			This.object.counseller[row] = ''
			This.object.coun_name[row] = ''
		End If

End Choose
end event

event ue_deletestart;call super::ue_deletestart;Long		ll_row
String		ls_year, ls_hakgi, ls_hakbun, ls_case_no

ll_row = dw_main.GetRow()
If ll_row <= 0 Then RETURN -1

ls_year = dw_main.object.year[ll_row]
ls_hakgi = dw_main.object.hakgi[ll_row]
ls_hakbun = dw_main.object.hakbun[ll_row]
ls_case_no = dw_main.object.case_no[ll_row]

DELETE FROM HAKSA.SUM130TL A
WHERE A.YEAR = :ls_year
AND A.HAKGI = :ls_hakgi
AND A.CASE_NO = :ls_case_no
AND A.HAKBUN = :ls_hakbun
USING SQLCA;

If SQLCA.SQLCODE <> 0 then
	ROLLBACK USING SQLCA;
	Messagebox("알림" ,"희망상담검사종목 SUM130TL 삭제 중 에러 발생!")
	RETURN -1
End If

return 1
end event

event ue_insertrow;call super::ue_insertrow;
If AncestorReturnValue = 1 Then dw_sub.Reset()

String		ls_year, ls_hakgi, ls_hakbun, ls_tel, ls_hp, ls_email, ls_case_no, ls_hname, ls_sex, ls_su_hakyun
String		ls_gwa, ls_gwa_name, ls_member_no, ls_prof_name
Long		ll_rv
Long 		l_case_no

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.hakyear[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.GetRow()]
ls_hakbun = dw_con.object.hakbun[dw_con.GetRow()]

SELECT :ls_year || lpad((to_number(nvl(max(substr(case_no,5,10)), 0))) + 1, 6,'0') 
  INTO :l_case_no
  FROM SUM120TL
 where case_no like :ls_year || '%'
  and hakbun = :ls_hakbun;
 
 If isnull(l_case_no ) Then 
	ls_case_no =  ls_year + '000001'
Else
	ls_case_no = String(l_case_no)
End If

//SELECT :ls_year || lpad((to_number(nvl(max(substr(rst_no,5,10)), 0))) + 1, 6,'0') 
//  INTO :l_rst_no
//  from SUM140tl 
// where rst_no like :ls_year || '%';
// 

SELECT TEL,     HP,     EMAIL, GWA, 
 (SELECT  FNAME  FROM 	CDDB.KCH003M  B WHERE B.GWA = A.GWA) , HNAME, SEX, SU_HAKYUN
  INTO :ls_tel, :ls_hp, :ls_email  , :ls_gwa, :ls_gwa_name, :ls_hname, :ls_sex, :ls_su_hakyun
  FROM HAKSA.JAEHAK_HAKJUK A
 WHERE HAKBUN   = :ls_hakbun;
 
SELECT  B.MEMBER_NO, C.NAME 
INTO :ls_member_no, :ls_prof_name
FROM HAKSA.PROF_SYM C , HAKSA.SUM210TL B
WHERE B.MEMBER_NO = C.MEMBER_NO
AND B.YEAR = :ls_year
AND B.HAKGI = :ls_hakgi
AND B.HAKBUN = :ls_hakbun;


This.object.year[This.getrow()] = ls_year
This.object.hakgi[This.getrow()] = ls_hakgi
This.object.hakbun[This.getrow()] = ls_hakbun
This.object.tel[This.getrow()] = ls_tel
This.object.hp[This.getrow()] = ls_hp
This.object.email[This.getrow()] = ls_email
This.object.gwa[This.getrow()] = ls_gwa
This.object.gwa_nm[This.getrow()] = ls_gwa_name
This.object.hname[This.getrow()] = ls_hname
This.object.sex[This.getrow()] = ls_sex
This.object.su_hakyun[This.getrow()] = ls_su_hakyun
This.object.member_no[This.getrow()] = ls_member_no
This.object.prof_name[This.getrow()] = ls_prof_name
This.object.case_no[This.getrow()] = ls_case_no  //상담신청번호
//This.object.counsel_dt[This.getrow()] = func.of_get_sdate('yyyymmdd')
This.object.case_date[This.getrow()] = func.of_get_sdate('yyyymmdd')

This.object.datawindow.readonly = 'No'
dw_sub.object.datawindow.readonly = 'No'

//dw_sub를 재조회한다.(신규시 공통코드정보만 조회됨)
dw_sub.event ue_retrieve()



RETURN AncestorReturnValue

end event

type st_tab3_line from statictext within tabpage_3
boolean visible = false
integer x = 155
integer y = 20
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type uo_1 from u_tab within w_hsg108a
integer x = 2007
integer y = 1020
integer taborder = 30
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type p_1 from picture within w_hsg108a
integer x = 50
integer y = 404
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hsg108a
integer x = 114
integer y = 396
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
string text = "상담내역"
boolean focusrectangle = false
end type

type p_2 from picture within w_hsg108a
integer x = 50
integer y = 976
integer width = 46
integer height = 44
boolean bringtotop = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_hsg108a
integer x = 114
integer y = 964
integer width = 1051
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "상담 결과 등록"
boolean focusrectangle = false
end type

type uo_stu from uo_imgbtn within w_hsg108a
integer x = 4142
integer y = 968
integer taborder = 40
boolean bringtotop = true
string btnname = "학생정보조회"
end type

event clicked;call super::clicked;String		 ls_hakbun
Int    l_cnt

if tab_1.tabpage_1.dw_tab1.rowcount() = 0 Then return 

ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[tab_1.tabpage_1.dw_tab1.GetRow()]
If ls_hakbun = '' or isnull(ls_hakbun) Then 
	//Messagebox("알림", "학번을 입력하세요!")
	
	ls_hakbun = dw_list.object.hakbun[dw_list.getrow()]
	
	If ls_hakbun = '' or isnull(ls_hakbun) Then
		ls_hakbun = dw_con.object.hakbun[dw_con.getrow()]
		
		If ls_hakbun = '' or isnull(ls_hakbun) Then
			RETURN 
		End If
	End If
End If


SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM HAKSA.SUM220TL
 WHERE hakbun  = :ls_hakbun;
IF l_cnt       = 0 THEN
	messagebox("알림", '학생환경기록카드의 정보등록이 안되었습니다')
	return
END IF

OpenWithParm(w_hsg102pp, ls_hakbun)

	
end event

on uo_stu.destroy
call uo_imgbtn::destroy
end on

