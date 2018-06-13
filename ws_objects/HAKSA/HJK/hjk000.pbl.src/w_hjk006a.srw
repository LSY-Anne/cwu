$PBExportHeader$w_hjk006a.srw
$PBExportComments$[청운대]패스워드관리
forward
global type w_hjk006a from w_common_inq
end type
end forward

global type w_hjk006a from w_common_inq
end type
global w_hjk006a w_hjk006a

on w_hjk006a.create
call super::create
end on

on w_hjk006a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;integer	li_row
string	    ls_name, ls_hakbun, ls_gubun

dw_con.AcceptText()

ls_name		= func.of_nvl(dw_con.Object.hname[1], '%')
ls_hakbun	= func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_gubun     = dw_con.Object.sangtae[1]

if len(trim(ls_name)) = 0 and len(trim(ls_hakbun)) = 0 then
	messagebox("확인","학번 또는 성명을 입력하세요!")
	dw_con.setfocus()
	return -1
end if

if ls_gubun = '1' then
	dw_main.dataobject = 'd_hjk006p_1'
	dw_main.settransobject(sqlca)	
	dw_main.Event constructor()
	li_row = dw_main.retrieve(ls_hakbun, ls_name)
Else			
	dw_main.dataobject = 'd_hjk006p_2'
	dw_main.settransobject(sqlca)
	dw_main.Event constructor()
	li_row = dw_main.retrieve(ls_hakbun, ls_name)
end if

if li_row = 0 then
	f_set_message("조회된 데이타가 없습니다!", '', parentwin)
elseif li_row = -1 then
	f_set_message("조회 중 오류가 발생하였습니다!", '', parentwin)
Else
	f_set_message("조회 되었습니다!", '', parentwin)
end if

Return 1
end event

event ue_save;int	li_ans,  ii
dwItemStatus lsStatus
String ls_password,  ls_gubun,  ls_hakbun

dw_main.AcceptText()

FOR ii     = 1 TO dw_main.RowCount()
	 lsStatus     = dw_main.GetItemStatus(ii, 0, Primary!)
 IF lsStatus     = DataModified! OR lsStatus   = New! OR lsStatus   = NewModified! THEN
	 ls_password  = dw_main.GetItemString(ii, 'password')
	 ls_hakbun    = dw_main.GetItemString(ii, 'hakbun')
	 ls_gubun     = dw_main.GetItemString(ii, 'gubun')
	 
	 IF ls_gubun  = '1' THEN
		 update haksa.jaehak_hakjuk
		    set password  = sys.CryptIT.encrypt(:ls_password, 'cwu')
		  where hakbun    = :ls_hakbun
		   Using sqlca;
	 ELSEIF ls_gubun     = '2' THEN
		 update haksa.d_hakjuk
		    set password  = sys.CryptIT.encrypt(:ls_password, 'cwu')
		  where hakbun    = :ls_hakbun
		   Using sqlca;
	 ELSEIF ls_gubun     = '3' THEN
		 update haksa.jolup_hakjuk
		    set password  = sys.CryptIT.encrypt(:ls_password, 'cwu')
		  where hakbun    = :ls_hakbun
		   Using sqlca;
	 END IF
	 
	 IF sqlca.sqlcode   <> 0 THEN
		 messagebox("알림", '비밀번호 저장시 오류 ' + sqlca.sqlerrtext)
		 rollback Using sqlca;
		 return -1
	 END IF
  END IF
NEXT

commit  Using sqlca;

If sqlca.sqlcode <> 0 Then
	rollback Using sqlca;
	f_set_message("저장시 오류가 발생하였습니다!", '', parentwin)
	Return -1
Else
	f_set_message("저장이 완료되었습니다!", '', parentwin)
End If

Return 1



    
end event

type ln_templeft from w_common_inq`ln_templeft within w_hjk006a
end type

type ln_tempright from w_common_inq`ln_tempright within w_hjk006a
end type

type ln_temptop from w_common_inq`ln_temptop within w_hjk006a
end type

type ln_tempbuttom from w_common_inq`ln_tempbuttom within w_hjk006a
end type

type ln_tempbutton from w_common_inq`ln_tempbutton within w_hjk006a
end type

type ln_tempstart from w_common_inq`ln_tempstart within w_hjk006a
end type

type uc_retrieve from w_common_inq`uc_retrieve within w_hjk006a
end type

type uc_insert from w_common_inq`uc_insert within w_hjk006a
end type

type uc_delete from w_common_inq`uc_delete within w_hjk006a
end type

type uc_save from w_common_inq`uc_save within w_hjk006a
end type

type uc_excel from w_common_inq`uc_excel within w_hjk006a
end type

type uc_print from w_common_inq`uc_print within w_hjk006a
end type

type st_line1 from w_common_inq`st_line1 within w_hjk006a
end type

type st_line2 from w_common_inq`st_line2 within w_hjk006a
end type

type st_line3 from w_common_inq`st_line3 within w_hjk006a
end type

type uc_excelroad from w_common_inq`uc_excelroad within w_hjk006a
end type

type ln_dwcon from w_common_inq`ln_dwcon within w_hjk006a
end type

type dw_con from w_common_inq`dw_con within w_hjk006a
integer height = 120
string dataobject = "d_hjk006a_c1"
end type

type dw_main from w_common_inq`dw_main within w_hjk006a
integer y = 300
integer height = 1984
string dataobject = "d_hjk006p_1"
end type

