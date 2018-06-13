$PBExportHeader$uo_insa_auth_group.sru
$PBExportComments$인사권한그룹
forward
global type uo_insa_auth_group from dropdownlistbox
end type
end forward

global type uo_insa_auth_group from dropdownlistbox
integer width = 379
integer height = 968
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
string item[] = {"1. 교원","2. 직원","3. 전체"}
borderstyle borderstyle = stylelowered!
end type
global uo_insa_auth_group uo_insa_auth_group

type variables
Integer	ii_JikJongCode
end variables

event constructor;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: constructor
//	기 능 설 명: 활성화되는 시점에 로그인한 사람의 권한그룹을 체크하여
//						교직원구분을 셋팅한다.
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UserID		//로그인사번
Integer	li_JikJongCode	//교직원구분코드
ls_UserID = TRIM(gstru_uid_uname.uid)			//로그인사번
IF LEN(ls_UserID) = 0 THEN
	li_JikJongCode = 1
	RETURN
END IF

String 	ls_GroupID		//권한그굽코드
Boolean	lb_GroupChk = FALSE
SELECT	UPPER(A.GROUP_ID)
INTO		:ls_GroupID
FROM		CDDB.KCH403M A
WHERE		A.MEMBER_NO = :ls_UserID
AND		UPPER(A.GROUP_ID) IN ('HIN00','HIN01','HIN02','HIN03','ADMIN','MNGER','PGMER2')
AND		ROWNUM       = 1;

CHOOSE CASE TRIM(ls_GroupID)
	CASE 'HIN01'
		ii_JikJongCode = 3	//직원담당
		lb_GroupChk    = TRUE
	CASE 'HIN02'
		ii_JikJongCode = 1	//교원담당
	CASE ELSE
		ii_JikJongCode = 3	//관리자
		lb_GroupChk    = TRUE
END CHOOSE

THIS.SelectItem(ii_JikJongCode)
THIS.Enabled = lb_GroupChk

THIS.TRIGGER EVENT selectionchanged(ii_JikJongCode)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on uo_insa_auth_group.create
end on

on uo_insa_auth_group.destroy
end on

