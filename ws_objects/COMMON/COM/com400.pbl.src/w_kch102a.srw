$PBExportHeader$w_kch102a.srw
$PBExportComments$공통코드관리
forward
global type w_kch102a from w_msheet
end type
type tab_1 from tab within w_kch102a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_update from uo_dw within tabpage_1
end type
type dw_list from uo_grid within tabpage_1
end type
type dw_type from uo_grid within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_update dw_update
dw_list dw_list
dw_type dw_type
st_1 st_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from uo_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_kch102a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from u_tab within w_kch102a
end type
end forward

global type w_kch102a from w_msheet
integer height = 2616
string title = "권한그룹관리"
tab_1 tab_1
uo_1 uo_1
end type
global w_kch102a w_kch102a

type variables
DataWindowChild	idwc_SysGb
end variables

on w_kch102a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_kch102a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
end on

event ue_save;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_db_save
////	기 능 설 명: 자료저장 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
int    li_temp,li_code,li_row
string ls_fname, ls_rowstatus,ls_type

tab_1.tabpage_1.dw_update.accepttext()

// 입력 자료 check 
IF tab_1.tabpage_1.dw_update.rowcount() < 1 THEN 
	messagebox("저장", "저장할 자료가 없습니다...")
else
	li_row   = tab_1.tabpage_1.dw_update.getrow()
   ls_type  = tab_1.tabpage_1.dw_update.GetItemString(li_row, "type")
   li_code  = tab_1.tabpage_1.dw_update.GetItemNumber(li_row, "code")
   // Primary Key Check (new row) //
   ls_rowstatus    = tab_1.tabpage_1.dw_update.Describe("evaluate('if(IsRowNew(),~"new~",~"old~")', 1)")
   IF ls_rowstatus = "new" THEN
	   SELECT code
	   INTO :li_temp
	   FROM CDDB.kch001m
	   WHERE type = :ls_type AND
			   code = :li_code ;
	else
		 sqlca.sqlcode = 100
   end If
   
	IF sqlca.sqlcode = 0 THEN
	   messagebox("저장 실패", "같은 코드값이 이미 존재합니다...")
	   tab_1.tabpage_1.dw_update.setfocus()
	   tab_1.tabpage_1.dw_update.setcolumn("code")
   else
      // 코드명 입력 에러 
      ls_fname  = tab_1.tabpage_1.dw_update.GetItemString(li_row, "fname")
      IF IsNull(ls_fname) OR  ls_fname = "" THEN
	      MessageBox("저장 실패","코드명(전체)를 입력하십시오!")
         tab_1.tabpage_1.dw_update.setfocus()
       	tab_1.tabpage_1.dw_update.setcolumn("fname")
		else	 
         // 저장
			tab_1.tabpage_1.dw_update.SetItem(1,'type_gubun','comm')
			tab_1.tabpage_1.dw_update.SetItem(1,'code_label',0)
			tab_1.tabpage_1.dw_update.SetItem(1,'job_uid',gstru_uid_uname.uid)
			tab_1.tabpage_1.dw_update.SetItem(1,'job_add',gstru_uid_uname.address)
         IF tab_1.tabpage_1.dw_update.update() = 1 THEN
            COMMIT;
    	      tab_1.tabpage_1.dw_type.retrieve()
				tab_1.tabpage_1.dw_list.retrieve(ls_type)
            li_row     = tab_1.tabpage_1.dw_type.Find("type = '" + ls_type + "'",1,tab_1.tabpage_1.dw_type.rowcount())
			   tab_1.tabpage_1.dw_type.SELECTROW(0    ,FALSE)
				If li_row > 0 then   
					tab_1.tabpage_1.dw_type.SELECTROW(li_row,tRUE)	
					tab_1.tabpage_1.dw_type.Setrow(li_row)
					tab_1.tabpage_1.dw_type.ScrollToRow(li_row)
				end IF	
				this.TriggerEvent('ue_insert')
				wf_SetMsg('자료가 저장되었습니다.')
         ELSE
            MessageBox("저장실패","저장실패")
            ROLLBACK;
         END IF					
      END IF 
  END IF
END IF

Return 1
end event

event ue_delete;call super::ue_delete;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_delete
////	기 능 설 명: 자료삭제 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 삭제할 데이타원도우의 선택여부 체크.
/////////////////////////////////////////////////////////////////////////////////////////
string ls_code,ls_type
int li_yesno,li_code, li_ROW

lI_ROW   = tab_1.tabpage_1.dw_update.Getrow()
iF li_Row > 0 then
   li_code  = tab_1.tabpage_1.dw_update.GetitemNumber(li_row,'code') 
	ls_type  = tab_1.tabpage_1.dw_update.GetItemString(li_row, "type")
	
   IF tab_1.tabpage_1.dw_list.Rowcount() = 1 AND li_code = -1  THEN
		tab_1.tabpage_1.dw_update.deleterow(0)    //현재행 
      IF tab_1.tabpage_1.dw_update.update() = 1 THEN
         Commit;
  	      tab_1.tabpage_1.dw_type.retrieve()
			tab_1.tabpage_1.dw_list.retrieve(ls_type)

			li_row     = tab_1.tabpage_1.dw_type.Find("type = '" + ls_type + "'",1,tab_1.tabpage_1.dw_type.rowcount())
			If li_row > 0 then   

				tab_1.tabpage_1.dw_type.Setrow(li_row)
				tab_1.tabpage_1.dw_type.ScrollToRow(li_row)
			end IF	
      ELSE
         MessageBox("삭제", "삭제 실패!")
  	      ROLLBACK;
      END IF //dw_update.update() = 1		
   elseIF tab_1.tabpage_1.dw_list.Rowcount() <>  1 AND li_code = -1  THEN
	   MessageBox("삭제 실패"," 마지막 코드일 경우에만 삭제할 수 있습니다.")
	else	
      // 삭제
		tab_1.tabpage_1.dw_update.deleterow(0)    //현재행 
      IF tab_1.tabpage_1.dw_update.update() = 1 THEN
         Commit;
  	      tab_1.tabpage_1.dw_type.retrieve()
			tab_1.tabpage_1.dw_list.retrieve(ls_type)

			li_row     = tab_1.tabpage_1.dw_type.Find("type = '" + ls_type + "'",1,tab_1.tabpage_1.dw_type.rowcount())
			If li_row > 0 then   

				tab_1.tabpage_1.dw_type.Setrow(li_row)
				tab_1.tabpage_1.dw_type.ScrollToRow(li_row)
			end IF	
      ELSE
         MessageBox("삭제", "삭제 실패!")
  	      ROLLBACK;
      END IF //dw_update.update() = 1

   END IF       //dw_list.Rowcount() = 1 AND i_code = -1 
End IF	       //I_rOW
end event

event ue_insert;call super::ue_insert;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_insert
////	기 능 설 명: 자료추가 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 입력조건체크
/////////////////////////////////////////////////////////////////////////////////////////
int    li_code
long   ll_row
String ls_type

ll_row  = tab_1.tabpage_1.dw_type.GetRow() //현재 행을 검색한다.

If ll_row > 0 then

   ls_type = tab_1.tabpage_1.dw_type.GetItemString(ll_row,'type') //type 값을 가진다.
	SELECT Nvl(max(code),-2)
   INTO  :li_code
   FROM   CDDB.kch001m
   WHERE type = :ls_type;  
	tab_1.tabpage_1.dw_update.reset()
 
	ll_row = tab_1.tabpage_1.dw_update.InsertRow(0)
	
   IF li_code = -1     THEN  //TYPE 코드만 있다.
	   li_code = 1
   elseIF li_code = -2 THEN	 //한개의 코드도 등록이 되어있다.
	   li_code     = -1	
   ELSE
	   li_code++
   END IF
   tab_1.tabpage_1.dw_update.SetItem(ll_row, "type", ls_type)
   tab_1.tabpage_1.dw_update.SetItem(ll_row, "code", li_code)
   tab_1.tabpage_1.dw_update.SetFocus()
   tab_1.tabpage_1.dw_update.SetColumn("fname")

	tab_1.tabpage_1.dw_update.SetTabOrder('code',20)
End if
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_open
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_update.SetTransObject(sqlca)
func.of_design_dw( tab_1.tabpage_1.dw_update)
idw_print = tab_1.tabpage_2.dw_print

tab_1.tabpage_1.dw_type.retrieve()
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'



end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "공통코드 리스트")
avc_data.SetProperty('dataobject', tab_1.tabpage_2.dw_print)
avc_data.SetProperty('datawindow', idw_print)

Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_kch102a
end type

type ln_tempright from w_msheet`ln_tempright within w_kch102a
end type

type ln_temptop from w_msheet`ln_temptop within w_kch102a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_kch102a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_kch102a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_kch102a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_kch102a
end type

type uc_insert from w_msheet`uc_insert within w_kch102a
end type

type uc_delete from w_msheet`uc_delete within w_kch102a
end type

type uc_save from w_msheet`uc_save within w_kch102a
end type

type uc_excel from w_msheet`uc_excel within w_kch102a
end type

type uc_print from w_msheet`uc_print within w_kch102a
end type

type st_line1 from w_msheet`st_line1 within w_kch102a
end type

type st_line2 from w_msheet`st_line2 within w_kch102a
end type

type st_line3 from w_msheet`st_line3 within w_kch102a
end type

type uc_excelroad from w_msheet`uc_excelroad within w_kch102a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_kch102a
end type

type tab_1 from tab within w_kch102a
integer x = 50
integer y = 164
integer width = 4384
integer height = 2100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;String ls_TypeCode
If newindex = 2 Then
	IF tab_1.tabpage_1.dw_list.rowcount() > 0 THEN
		ls_TypeCode = Trim(tab_1.tabpage_1.dw_type.GetiTemString(tab_1.tabpage_1.dw_type.getrow(),'type'))
		tab_1.tabpage_2.dw_print.Retrieve(ls_TypeCode)
	END IF
End if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1980
string text = "공통코드 관리"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_update dw_update
dw_list dw_list
dw_type dw_type
st_1 st_1
end type

on tabpage_1.create
this.dw_update=create dw_update
this.dw_list=create dw_list
this.dw_type=create dw_type
this.st_1=create st_1
this.Control[]={this.dw_update,&
this.dw_list,&
this.dw_type,&
this.st_1}
end on

on tabpage_1.destroy
destroy(this.dw_update)
destroy(this.dw_list)
destroy(this.dw_type)
destroy(this.st_1)
end on

type dw_update from uo_dw within tabpage_1
integer x = 1609
integer y = 1188
integer width = 2725
integer height = 784
integer taborder = 20
boolean titlebar = true
string title = "코드상세정보"
string dataobject = "d_kch102a3"
end type

event itemchanged;call super::itemchanged;string ls_ColName, ls_type, ls_code, ls_fname, ls_temp
int li_code, li_rc,li_cnt

Choose Case dwo.name
	Case "type"
		ls_type = data
		ls_type = Trim(ls_type)
		//현재의 테이타 원도우에서 가장큰값을 가진다,만약 없는 데이타 이면, -1돌린다.
		SELECT Nvl(Max(code),-2)
		INTO   :li_code
		FROM   CDDB.kch001m
		WHERE type = :ls_type;
	
		IF li_code = -2 THEN //현재 등록된 데이타가 없다.
			li_code = -1
			This.SetTabOrder('code',0)
		ELSE
			If  li_code = -1 then li_code = 0 //type코드만 들록된경우.
			li_code++
			This.SetTabOrder('code',20)		
		END IF
		this.SetItem(this.GetRow(), "code", li_code)
		This.Setcolumn('fname')
// 동일 코드 조사
	Case "code" 
		ls_type = Trim(this.GetItemString(this.GetRow(), "type"))
		li_code = Integer(data)
	
		SELECT Nvl(count(code),0)
		  INTO :li_cnt	
		  FROM CDDB.kch001m
		 WHERE type = :ls_type AND 
				 code = :li_code;
		IF li_cnt > 0  THEN
			messageBox('확인',"이미 같은 코드값이 존재합니다!")
			dw_update.retrieve(ls_type,li_code)
			dw_update.SetFocus()
		else	
			This.Setcolumn('fname')		
		END IF
	Case 'fname'
		This.Setcolumn('sname')
	Case 'sname'
		This.Setcolumn('ename')		
	Case 'ename'
		This.Setcolumn('educode')		
END Choose
end event

type dw_list from uo_grid within tabpage_1
integer x = 1609
integer y = 12
integer width = 2725
integer height = 1076
integer taborder = 20
boolean titlebar = true
string title = "코드목록"
string dataobject = "d_kch102a2"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;int    i_code
String s_type

If GetRow() < 1 Then Return -1 ;

s_type    = dw_type.GetItemString(dw_type.GetRow(),'type') //데이타 타입을 가진다.	
i_code    = this.GetItemNumber(currentrow, "code")
dw_update.retrieve(s_type, i_code)


end event

event retrieveend;call super::retrieveend;int    i_code,i_cnt
String s_type

IF rowcount > 0  THEN 
   s_type = Trim(dw_type.GetItemString(dw_type.GetRow(),'type')) //데이타 타입을 가진다.
   i_code = this.GetItemNumber(rowcount, "code") //마지막행으로 이동한다.
   i_cnt  = dw_update.Retrieve(s_type,i_code)
else
	dw_update.reset()
End IF
end event

type dw_type from uo_grid within tabpage_1
integer y = 12
integer width = 1609
integer height = 1960
integer taborder = 20
boolean titlebar = true
string title = "코드종류"
string dataobject = "d_kch102a1"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;Int    i_cnt   //행의수
String s_type  //현재행의 데이타 타입

If GetRow() < 1 Then Return -1 ;
	
s_type  = Trim(this.GetItemString(currentrow, "type"))

i_cnt   = dw_list.retrieve(s_type)


end event

event retrieveend;call super::retrieveend;long   l_row
String s_type //현재선택한 데이타 타입

IF rowcount < 1 THEN 
	dw_list.reset()
	parent.TriggerEvent('ue_insert')
ELSE                   //가장 첫행으로 이동한다
	l_row  = dw_list.getrow()
	If l_row < 1 then   //처음 검색
		l_row  = This.Getrow()
      s_type = Trim(this.GetItemString(L_ROW, "type"))		
	else
	   s_type = Trim(dw_list.GetitemString(l_row,'type'))
	end IF
   l_row = dw_list.retrieve(s_type)
END IF


end event

type st_1 from statictext within tabpage_1
integer x = 1627
integer y = 1104
integer width = 1239
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "※ 코드 종류 등록시 코드값은 ~'-1~' 입니다."
alignment alignment = center!
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1980
string text = "공통코드 리스트"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from uo_dw within tabpage_2
integer x = 18
integer y = 28
integer width = 4311
integer height = 1932
integer taborder = 20
string dataobject = "d_kch102a4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransobject(sqlca)
end event

type uo_1 from u_tab within w_kch102a
event destroy ( )
integer x = 978
integer y = 104
integer taborder = 40
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

