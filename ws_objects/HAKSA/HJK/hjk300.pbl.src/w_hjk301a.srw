$PBExportHeader$w_hjk301a.srw
$PBExportComments$[청운대]포상내역관리
forward
global type w_hjk301a from w_condition_window
end type
type dw_1 from uo_input_dwc within w_hjk301a
end type
type dw_2 from uo_input_dwc within w_hjk301a
end type
type st_1 from statictext within w_hjk301a
end type
type st_2 from statictext within w_hjk301a
end type
type dw_con from uo_dwfree within w_hjk301a
end type
end forward

global type w_hjk301a from w_condition_window
dw_1 dw_1
dw_2 dw_2
st_1 st_1
st_2 st_2
dw_con dw_con
end type
global w_hjk301a w_hjk301a

type variables
string is_gubun, is_code

datawindowchild ldwc_hjmod
end variables

on w_hjk301a.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_1=create st_1
this.st_2=create st_2
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_con
end on

on w_hjk301a.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_con)
end on

event ue_delete;int	li_ans1	,&
		li_ans2

li_ans1 = uf_messagebox(4)		//	삭제확인 메세지 출력

IF li_ans1 = 1 THEN
	dw_1.deleterow(0)          //	현재 행을 삭제
	li_ans2 = dw_1.update()    //	삭제된 내용을 저장
	
	IF li_ans2 = -1 THEN
		ROLLBACK USING SQLCA;     
		uf_messagebox(6)        //	삭제오류 메세지 출력
	
	ELSE
      COMMIT USING SQLCA;		  
		uf_messagebox(5)       //	삭제완료 메시지 출력
	END IF
END IF

dw_1.setfocus()

end event

event ue_insert;string 	ls_code
  long	ll_newrow

dw_1.getchild('sangbul_id',ldwc_hjmod)
ldwc_hjmod.settransobject(sqlca)	
ldwc_hjmod.retrieve(is_gubun)

ll_newrow	= dw_1.InsertRow(0)//	데이타윈도우의 마지막 행에 추가

dw_1.object.sangbul_id[ll_newrow] = is_code
dw_1.object.sangbul_gubun[ll_newrow] = is_gubun

IF ll_newrow <> -1 THEN
   dw_1.ScrollToRow(ll_newrow)		//	추가된 행에 스크롤
	dw_1.setcolumn(1)              	//	추가된 행의 첫번째 컬럼에 커서 위치
	dw_1.setfocus()                	//	dw_main 포커스 이동
END IF

end event

event open;call super::open;idw_update[1] = dw_1

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_2.settransobject(sqlca)
dw_1.Settransobject(sqlca)

dw_2.retrieve()
end event

event ue_print;//override
end event

event ue_retrieve;call super::ue_retrieve;int		li_row
string ls_year

dw_con.AcceptText()

ls_year = dw_con.Object.year[1]

li_row = dw_1.retrieve(ls_year, is_code)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_2.setfocus()

Return 1

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk301a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk301a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk301a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk301a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk301a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk301a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk301a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk301a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk301a
end type

type uc_save from w_condition_window`uc_save within w_hjk301a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk301a
end type

type uc_print from w_condition_window`uc_print within w_hjk301a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk301a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk301a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk301a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk301a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk301a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk301a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk301a
end type

type dw_1 from uo_input_dwc within w_hjk301a
integer x = 1088
integer y = 388
integer width = 3346
integer height = 1876
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk301a_1"
boolean border = true
end type

event itemchanged;string	ls_hakbun, &
			ls_hakbun1,&
			ls_hakyun, &
			ls_hakgi,  &
			ls_year
integer 	li_count

CHOOSE CASE dwo.name
		
	CASE 'hakbun'
		
		dw_1.accepttext()
		ls_hakbun = dw_1.getitemstring(row, "hakbun")
		
		SELECT	count( JAEHAK_HAKJUK.HAKBUN )  
		INTO		:li_count
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE		( JAEHAK_HAKJUK.HAKBUN	LIKE :ls_hakbun	)
		USING SQLCA
		;		 
		
		ls_year = dw_con.Object.year[1]
		
 		if li_count = 0 then
			messagebox("확인", "해당 학생은 존재하지 않습니다.!", Exclamation!)
			dw_1.setcolumn('hakbun')
			return 1

		elseif li_count = 1 then
	
			SELECT	JAEHAK_HAKJUK.HAKBUN,
						JAEHAK_HAKJUK.SU_HAKYUN,
						JAEHAK_HAKJUK.HAKGI						
			INTO		:ls_hakbun1,
						:ls_hakyun,
						:ls_hakgi
			FROM		HAKSA.JAEHAK_HAKJUK  
			WHERE		( JAEHAK_HAKJUK.HAKBUN	= :ls_hakbun)
			USING SQLCA
			;
		
			dw_1.object.hakbun[row]		= ls_hakbun1
			dw_1.object.year[row] 			= ls_year
			dw_1.object.su_hakyun[row]	= ls_hakyun
			dw_1.object.hakgi[row]			= ls_hakgi
			dw_1.object.sangbul_ilja[row]	= string(today(), 'yyyymmdd')
			
		elseif li_count >=2 then
	
			OpenWithParm(w_hjk101pp, ls_hakbun)
			
			ls_hakbun = Message.StringParm
	
			SELECT	JAEHAK_HAKJUK.HAKBUN,
						JAEHAK_HAKJUK.SU_HAKYUN,
						JAEHAK_HAKJUK.HAKGI						
			INTO		:ls_hakbun1,
						:ls_hakyun,
						:ls_hakgi
			FROM		HAKSA.JAEHAK_HAKJUK  
			WHERE		( JAEHAK_HAKJUK.HNAME		= :ls_hakbun)
			USING SQLCA
			;
			
			dw_1.object.hakbun[row]		= ls_hakbun1
			dw_1.object.year[row] 			= ls_year
			dw_1.object.su_hakyun[row]	= ls_hakyun
			dw_1.object.hakgi[row]			= ls_hakgi
			dw_1.object.sangbul_ilja[row]	= string(today(), 'yyyymmdd')

		end if	
END CHOOSE
end event

type dw_2 from uo_input_dwc within w_hjk301a
integer x = 55
integer y = 388
integer width = 1006
integer height = 1876
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjk301q_1"
boolean border = true
end type

event clicked;integer li_msg

if row > 0 then
	
	is_code 	= this.object.sangbul_id[row]
	is_gubun = this.object.sangbul_gubun[row]
///*------------------------------------------------
//	데이타의 변경내용이 있는가를 확인 
//------------------------------------------------*/
	IF (dw_1.modifiedcount() + dw_1.deletedcount()) 	>0 	THEN
		li_msg 	= 	messagebox("확인","저장하시겠습니까?",Information!,YesNo!,1)
		if li_msg= 1 then	
			Parent.Event ue_save()
		end if	
	END IF
	
end if

Parent.Event ue_retrieve()
	
dw_1.setfocus()

end event

type st_1 from statictext within w_hjk301a
integer x = 55
integer y = 300
integer width = 1006
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 15793151
long backcolor = 8388736
string text = "포상코드"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_hjk301a
integer x = 1088
integer y = 300
integer width = 3346
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 15793151
long backcolor = 8388736
string text = "포 상 내 역    관 리"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hjk301a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk301a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

