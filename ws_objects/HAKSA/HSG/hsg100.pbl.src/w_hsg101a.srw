$PBExportHeader$w_hsg101a.srw
$PBExportComments$[청운대]상담지도
forward
global type w_hsg101a from w_condition_window
end type
type em_year from uo_em_year within w_hsg101a
end type
type st_3 from statictext within w_hsg101a
end type
type ddlb_hakgi from uo_ddlb_hakgi within w_hsg101a
end type
type st_4 from statictext within w_hsg101a
end type
type st_5 from statictext within w_hsg101a
end type
type dw_2 from uo_dddw_dwc within w_hsg101a
end type
type dw_1 from uo_input_dwc within w_hsg101a
end type
end forward

global type w_hsg101a from w_condition_window
em_year em_year
st_3 st_3
ddlb_hakgi ddlb_hakgi
st_4 st_4
st_5 st_5
dw_2 dw_2
dw_1 dw_1
end type
global w_hsg101a w_hsg101a

type variables
datawindowchild ldwc_hjmod
end variables

on w_hsg101a.create
int iCurrent
call super::create
this.em_year=create em_year
this.st_3=create st_3
this.ddlb_hakgi=create ddlb_hakgi
this.st_4=create st_4
this.st_5=create st_5
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_year
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.ddlb_hakgi
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_1
end on

on w_hsg101a.destroy
call super::destroy
destroy(this.em_year)
destroy(this.st_3)
destroy(this.ddlb_hakgi)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;wf_setmenu('RETRIEVE', 	TRUE)
wf_setmenu('INSERT', 	TRUE)
wf_setmenu('DELETE', 	TRUE)
wf_setmenu('SAVE', 		TRUE)
wf_setmenu('PRINT', 		FALSE)

//사용자가 교수이면 검색조건의 교수를 ENABLED
if f_enabled_chk(gstru_uid_uname.uid) = 1 then
	dw_2.SetItem(1, 1, gstru_uid_uname.uid)
	dw_2.enabled = false
	
end if
end event

event ue_retrieve;call super::ue_retrieve;int		li_row
string 	ls_year,	ls_hakgi, ls_prof_id

ls_year 		=	em_year.text + '%'
ls_hakgi		=	ddlb_hakgi.text + '%'
ls_prof_id	=	dw_2.gettext() + '%'


li_row = dw_1.retrieve(ls_year, ls_hakgi, ls_prof_id)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_1.setfocus()
return 1
end event

event ue_insert;call super::ue_insert;long		ll_newrow
string	ls_year, ls_hakgi, ls_prof_id

ls_year 		=	em_year.text
ls_hakgi		= 	ddlb_hakgi.text
ls_prof_id		=  dw_2.gettext()

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "상담지도 년도와 학기를 입력하세요!")
	return 
	dw_2.setfocus()
end if

dw_2.setfocus()
ll_newrow	= dw_1.InsertRow(0)//	데이타윈도우의 마지막 행에 추가

dw_1.object.year[ll_newrow] = ls_year
dw_1.object.hakgi[ll_newrow] = ls_hakgi
dw_1.object.prof_id[ll_newrow] = ls_prof_id

IF ll_newrow <> -1 THEN
   dw_1.ScrollToRow(ll_newrow)		//	추가된 행에 스크롤
	dw_1.setcolumn(1)              	//	추가된 행의 첫번째 컬럼에 커서 위치
	dw_1.setfocus()                	//	dw_1 포커스 이동
END IF

end event

event ue_save;call super::ue_save;int	li_ans

dw_1.AcceptText()

li_ans = dw_1.update()		//	자료의 저장

IF li_ans = -1  THEN
	ROLLBACK USING SQLCA;
	uf_messagebox(3)       	//	저장오류 메세지 출력

ELSE
	COMMIT USING SQLCA;
	uf_messagebox(2)       //	저장확인 메세지 출력
END IF
return 1
end event

event ue_delete;call super::ue_delete;long	li_ans

if messagebox("확인","삭제하시겠습니까?", Question!, YesNo!, 2) = 2 then return

dw_1.deleterow(0)

li_ans = dw_1.update()	

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback;
else	
	commit;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

type gb_1 from w_condition_window`gb_1 within w_hsg101a
integer x = 0
end type

type gb_2 from w_condition_window`gb_2 within w_hsg101a
integer x = 0
end type

type em_year from uo_em_year within w_hsg101a
integer x = 398
integer y = 108
integer width = 242
integer taborder = 10
boolean bringtotop = true
end type

type st_3 from statictext within w_hsg101a
integer x = 219
integer y = 120
integer width = 174
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_hakgi from uo_ddlb_hakgi within w_hsg101a
integer x = 933
integer y = 108
integer height = 444
integer taborder = 20
boolean bringtotop = true
end type

type st_4 from statictext within w_hsg101a
integer x = 754
integer y = 120
integer width = 174
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_hsg101a
integer x = 1221
integer y = 120
integer width = 187
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "교수"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from uo_dddw_dwc within w_hsg101a
integer x = 1408
integer y = 108
integer width = 571
integer height = 80
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_list_prof"
end type

type dw_1 from uo_input_dwc within w_hsg101a
integer x = 229
integer y = 320
integer width = 2670
integer height = 2156
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsg101a"
end type

event itemchanged;call super::itemchanged;long		ll_jungi, ll_hugi, ll_jungi2, ll_hugi2, ll_sangdam_cnt, ll_jumsu, ll_null
double   ld_average


dw_1.Accepttext()

CHOOSE CASE dwo.name
		
	CASE 'jungi', 'hugi', 'jungi2', 'hugi2'
		
		ll_jungi		=	dw_1.object.jungi[row]
		ll_hugi		=	dw_1.object.hugi[row]
		ll_jungi2	=	dw_1.object.jungi2[row]
		ll_hugi2		=	dw_1.object.hugi2[row]
		
		
		setnull(ll_null)
		

		//각 항목별 점수 합계를 구한다.
		if isnull(ll_jungi) then	ll_jungi = 0
		if isnull(ll_hugi) then	ll_hugi = 0
		if isnull(ll_jungi2) then	ll_jungi2 = 0
		if isnull(ll_hugi2) then	ll_hugi2 = 0		
		
		ll_sangdam_cnt	=	ll_jungi + ll_hugi + ll_jungi2 + ll_hugi2
		ld_average = ll_sangdam_cnt / 2
		

		//상담지도 학기별 평균 횟수
		if	ld_average 	>=	40		then 	
			ll_jumsu = 30
		elseif ld_average 	>=	30	and ld_average < 40	then 	
			ll_jumsu = 20
		elseif ld_average >= 0 and ld_average < 30  then
			ll_jumsu = 10
		end if
					
		dw_1.setitem(row, "sangdam_cnt", ll_sangdam_cnt)	
		dw_1.setitem(row, "jumsu", ll_jumsu)
		
	END CHOOSE

end event

