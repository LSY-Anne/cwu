$PBExportHeader$w_kch103a.srw
$PBExportComments$학과코드관리
forward
global type w_kch103a from w_msheet
end type
type dw_update from uo_dw within w_kch103a
end type
type dw_list from uo_grid within w_kch103a
end type
end forward

global type w_kch103a from w_msheet
dw_update dw_update
dw_list dw_list
end type
global w_kch103a w_kch103a

on w_kch103a.create
int iCurrent
call super::create
this.dw_update=create dw_update
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update
this.Control[iCurrent+2]=this.dw_list
end on

on w_kch103a.destroy
call super::destroy
destroy(this.dw_update)
destroy(this.dw_list)
end on

event ue_insert;call super::ue_insert;long ll_row
int  li_code
string s_code,s_col_code

dw_update.SetRedraw(False)
dw_update.reset()
ll_row = dw_update.Insertrow(0)
dw_update.setitem(ll_row, 'job_uid', gstru_uid_uname.uid)
dw_update.setitem(ll_row, 'job_add', gstru_uid_uname.address)
dw_update.setitem(ll_row, 'job_date', f_sysdate())
dw_update.SetRedraw(True)
dw_update.SetFocus()

end event

event ue_delete;call super::ue_delete;String s_col_code //대학명

IF f_MessageBox('2','DEL') = 1 THEN	
   dw_update.DeleteRow(dw_update.GetRow())
   IF	dw_update.Update() = 1 THEN
	   COMMIT USING SQLCA ;
      dw_list.retrieve()
   ELSE
	   f_MessageBox('3','DEL')
   	ROLLBACK USING SQLCA ;
   END IF
End IF	



end event

event ue_save;int li_temp, li_yesno, li_row
String ls_col_code, ls_gwa_code, ls_cclm_code, ls_fname, ls_usegubun
Long   ll_hakwicode
If dw_update.accepttext() = 1 Then
	li_row      = dw_update.GetRow()
	ls_gwa_code  = Trim(dw_update.GetItemString(li_row, "gwa")) //학과
	ls_cclm_code = Trim(dw_update.GetItemString(li_row, "cclm_code")) //교과목
	ls_fname     = Trim(dw_update.GetItemString(li_row, "fname"))     //학과명
	ll_hakwicode = dw_update.GetItemnumber(li_row, "hakwi_code")      //학위명
	ls_usegubun  = Trim(dw_update.GetItemString(li_row, "use_gubun")) //사용여부
	
	// 저장조건 확인
	IF IsNULL(ls_gwa_code) THEN
		MessageBox("입력오류","학과를  확인하십시오!")
		dw_update.SetFocus()
		dw_update.SetColumn('gwa')
	elseIF IsNULL(ls_fname) THEN
		MessageBox("입력오류","학과명을  확인하십시오!")
		dw_update.SetFocus()	
		dw_update.SetColumn('fname')
	elseIF IsNULL(ls_usegubun) THEN
		MessageBox("입력오류","사용여부를  확인하십시오!")
		dw_update.SetFocus()		
		dw_update.SetColumn('use_gubun')
	else
		If dw_update.Update() = 1 Then
			COMMIT USING SQLCA ;
			dw_list.setredraw(False)
			dw_list.retrieve ()		
			dw_list.setredraw(True)
			wf_setmsg('저장 하였습니다..')
		ELSE
			f_MessageBox('3',"save")
			rollback USING SQLCA ;
		END IF
	END IF
End If

Return 1
end event

event ue_postopen;call super::ue_postopen;
f_childretrieve (dw_update, "hakwi_code",  "hakwi_code")
f_childretrieve (dw_update, "pyosi_code" ,  "pyosi_code")
f_childretrieve (dw_update, "gyojik_code",  "gyojik_code")
f_childretrieve (dw_update, "group1_code",  "group1_code")
f_childretrieve (dw_update, "group2_code",  "group2_code")
f_childretrieve (dw_update, "group3_code",  "group3_code")
f_childretrieve (dw_update, "group4_code",  "group4_code") //등록계열
f_childretrieve (dw_update, "group5_code",  "group5_code")
f_childretrieve (dw_update, "group6_code",  "group6_code")
f_childretrieve (dw_update, "group7_code",  "group7_code")
f_childretrieve (dw_update, "group8_code",  "group8_code") //학사편람계열
f_childretrieve (dw_update, "group9_code",  "group9_code")
//2006.01.09 학과/부서코드 출력구분 추가(Jung Kwang Hoon)
f_childretrieve (dw_update, "group15_code",  "group15_code")

dw_update.SettransObject(sqlca)
func.of_design_dw(dw_update)

dw_list.Retrieve()


end event

type ln_templeft from w_msheet`ln_templeft within w_kch103a
end type

type ln_tempright from w_msheet`ln_tempright within w_kch103a
end type

type ln_temptop from w_msheet`ln_temptop within w_kch103a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_kch103a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_kch103a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_kch103a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_kch103a
end type

type uc_insert from w_msheet`uc_insert within w_kch103a
end type

type uc_delete from w_msheet`uc_delete within w_kch103a
end type

type uc_save from w_msheet`uc_save within w_kch103a
end type

type uc_excel from w_msheet`uc_excel within w_kch103a
end type

type uc_print from w_msheet`uc_print within w_kch103a
end type

type st_line1 from w_msheet`st_line1 within w_kch103a
end type

type st_line2 from w_msheet`st_line2 within w_kch103a
end type

type st_line3 from w_msheet`st_line3 within w_kch103a
end type

type uc_excelroad from w_msheet`uc_excelroad within w_kch103a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_kch103a
end type

type dw_update from uo_dw within w_kch103a
integer x = 1563
integer y = 164
integer width = 2843
integer height = 2100
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "학과코드 상세내역"
string dataobject = "d_kch103a2"
boolean vscrollbar = true
end type

type dw_list from uo_grid within w_kch103a
integer x = 50
integer y = 164
integer width = 1504
integer height = 2100
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "학과(부서) 리스트"
string dataobject = "d_kch103a1"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_gwa

If GetRow() < 1 Then Return -1 ;

ls_gwa = Trim(this.GetItemString(currentrow,"gwa"))  //학과

dw_update.retrieve(ls_gwa) //학과명 상세정보 검색

end event

event retrieveend;call super::retrieveend;parent.TriggerEvent('ue_insert')
end event

