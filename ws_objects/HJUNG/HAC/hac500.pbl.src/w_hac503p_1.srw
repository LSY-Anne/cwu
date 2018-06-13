$PBExportHeader$w_hac503p_1.srw
$PBExportComments$부서별 예산사용 현황 출력(전체부서-기획처)
forward
global type w_hac503p_1 from w_print_form1
end type
type dw_gwa from datawindow within w_hac503p_1
end type
type st_4 from statictext within w_hac503p_1
end type
type uo_acct_class from cuo_acct_class within w_hac503p_1
end type
type uo_1 from cuo_date within w_hac503p_1
end type
type st_1 from statictext within w_hac503p_1
end type
end forward

global type w_hac503p_1 from w_print_form1
dw_gwa dw_gwa
st_4 st_4
uo_acct_class uo_acct_class
uo_1 uo_1
st_1 st_1
end type
global w_hac503p_1 w_hac503p_1

type variables
datawindow			idw_mast
statictext			ist_back

string is_gwa
string is_pay_date

end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_retrieve ()
public subroutine wf_jasan_proc (string as_io_gubun, string as_bdgt_year)
public subroutine wf_transfer_proc (string as_io_gubun, string as_acct_code)
end prototypes

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
// 요구부서
dw_gwa.getchild('code', idw_child)
idw_child.settransobject(sqlca)
idw_child.retrieve(1,3)
idw_child.insertrow(1)
idw_child.setitem(1,'dept_code','')
idw_child.setitem(1,'dept_name','전체')
dw_gwa.insertrow(0)



//idw_print.getchild('gwa', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve(1, 3) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if

end subroutine

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string ls_date, ls_io_gubun

ls_date = uo_1.uf_getdate()

if idw_print.retrieve(is_bdgt_year, is_gwa, ii_acct_class, is_slip_class, ls_date) < 1 then
	ist_back.bringtotop = true

	idw_print.reset()
	uo_bdgt_year.setfocus()
else
	ist_back.bringtotop = false

		
	//수입
	if is_slip_class = '' or is_slip_class = '1' then
		ls_io_gubun = '1'

		// 고정자산 매각수입에 대한 금액 보정
		// 고정자산 매각수입 = 고정자산매각수입 - 고정자산처분손실
		wf_jasan_proc(ls_io_gubun,is_bdgt_year)
		
		//기계기구,집기비품 계정을 건물로 대체한 전표가 있음. (물품관리전환 건물대체)(2005.07.12)
		wf_transfer_proc(ls_io_gubun,'1314')
		wf_transfer_proc(ls_io_gubun,'1315')
	end if


	//지출
	if is_slip_class = '' or is_slip_class = '2' then
		ls_io_gubun = '2'

		//건물매입비에서 건설가계정 금액 감산...
		wf_transfer_proc(ls_io_gubun,'1312')
		//차량운반구에서 건설가계정 금액 감산...(2005.07.12)
		wf_transfer_proc(ls_io_gubun,'1316')
	
		//기계기구,집기비품 계정을 건물로 대체한 전표가 있음. (물품관리전환 건물대체)(2005.07.12)
		wf_transfer_proc(ls_io_gubun,'1314')
		wf_transfer_proc(ls_io_gubun,'1315')
	end if


	idw_print.groupcalc()


end if


end subroutine

public subroutine wf_jasan_proc (string as_io_gubun, string as_bdgt_year);dec{0}				ldc_acct_amt
long					ll_row, ll_end, ll_find, ll_acct_no, ll_cnt
string 				ls_acct_code, ls_acct_date


ll_end  = idw_print.rowcount()
ll_find = idw_print.find("com_io_gubun = '"+as_io_gubun+"' and left(com_acct_code, 2) = '13'", 1, ll_end)

do while	ll_find > 0
	ls_acct_code   = idw_print.getitemstring(ll_find, 'com_acct_code')
	ls_acct_date   = idw_print.getitemstring(ll_find, 'slip_date')
	ll_acct_no   	= idw_print.getitemnumber(ll_find, 'slip_no')
	

	// 고정자산 매각수입에 대한 금액 보정
	// 고정자산 매각수입 = 고정자산매각수입 - 고정자산처분손실
		
	// 고정자산처분손실금액 select...
	SELECT	SUM(A.SLIP_AMT)
	INTO		:ldc_acct_amt
	FROM		FNDB.HFN202M A, 
				(
					SELECT	B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO
					FROM		FNDB.HFN202M B, FNDB.HFN201M C
					WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
					AND		B.SLIP_DATE 				= 	C.SLIP_DATE
					AND		B.SLIP_NO 					= 	C.SLIP_NO
					AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
					AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
					AND		C.ACCT_DATE 				= 	:ls_acct_date
					AND		C.ACCT_NO 					= 	:ll_acct_no
					AND		C.STEP_OPT 					= 	5
					AND		B.ACCT_CODE 				= 	:ls_acct_code
					AND		B.DRCR_CLASS 				= 	'C' 
				) D
	WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
	AND		A.SLIP_DATE 				= D.SLIP_DATE
	AND		A.SLIP_NO 					= D.SLIP_NO
	AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
	AND		A.ACCT_CODE 				= '442601'
	AND		A.DRCR_CLASS 				= 'D' ;
	
	if isnull(ldc_acct_amt) then ldc_acct_amt = 0
	messagebox('wf_jasan_proc1',string(ll_find)+':'+string(ldc_acct_amt))
	idw_print.setitem(ll_find, 'com_acct_amt', idw_print.getitemnumber(ll_find, 'com_acct_amt') - ldc_acct_amt)

	
	//대체전표 금액보정
	
	//대체금액 select...
	SELECT	count(*)
	INTO		:ll_cnt
	FROM		FNDB.HFN202M B, FNDB.HFN201M C
	WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
	AND		B.SLIP_DATE 				= 	C.SLIP_DATE
	AND		B.SLIP_NO 					= 	C.SLIP_NO
	AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
	AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
	AND		C.ACCT_DATE 				= 	:ls_acct_date
	AND		C.ACCT_NO 					= 	:ll_acct_no
	AND		C.STEP_OPT 					= 	5
	AND		C.SLIP_CLASS				=  3							//대체...
	AND		B.ACCT_CODE 				= 	:ls_acct_code
	AND		B.DRCR_CLASS 				= 	'D'
	;
	
	if ll_cnt > 0 then 
		messagebox('wf_jasan_proc2',string(ll_find)+':'+string(ll_cnt))
		idw_print.setitem(ll_find, 'com_acct_amt', 0)
	end if
	
	ll_find ++
	if ll_find > ll_end then exit
	ll_find = idw_print.find("com_io_gubun = '"+as_io_gubun+"' and left(com_acct_code, 2) = '13'", ll_find, ll_end)
loop


end subroutine

public subroutine wf_transfer_proc (string as_io_gubun, string as_acct_code);/*
	기계기구(1314),집기비품(1315),건물(1312),차량운반구(1316)
	
	대체전표 처리 : 2005.07.12
	대체전표에 대한 자금계산서 계정별 처리

	1. 
		건설가계정 계정 관련...
		건물 건축 완료후 본계정 대체 시...
		자금계산서 지출 중 건물매입비 금액에서 건설가계정 금액을 차감하여 계산...
	2.
		기계기구, 집기비품 매각대 계정 추가 작업...(2005.07.12)
			ㄱ.기계기구,집기비품 계정을 건물로 대체한 전표가 있음. (물품관리전환 건물대체)
			ㄴ.수입일 경우 : 기계기구,집기비품 - 건물 대체금액.
			ㄷ.지출일 경우 : 건물매입비 - 기계기구,집기비품 대체금액 계산함.
	3.
		차량운반구 계정 관련...(2005.07.12)
		차량 제작 완료후 본계정 대체 시...
		자금계산서 지출 중 차량운반구 금액에서 건설가계정 금액을 차감하여 계산...
*/

dec{0}				ldc_acct_amt
long					ll_row, ll_end, ll_find, ll_acct_no, ll_cnt, ll_slip_class
string 				ls_acct_code, ls_acct_date

ll_end  = idw_print.rowcount()
ll_find = idw_print.find("com_io_gubun = '"+as_io_gubun+"' and left(com_acct_code, 4) = '"+as_acct_code+"'", 1, ll_end)

do while	ll_find > 0
	ls_acct_code   = idw_print.getitemstring(ll_find, 'com_acct_code')
	ls_acct_date   = idw_print.getitemstring(ll_find, 'slip_date')
	ll_acct_no   	= idw_print.getitemnumber(ll_find, 'slip_no')
	ll_slip_class  = idw_print.getitemnumber(ll_find, 'slip_class')
	
	if ll_slip_class = 3 then 
		messagebox('wf_transfer_proc',string(ll_find)+':'+string(ls_acct_code))
		idw_print.setitem(ll_find, 'com_acct_amt', 0)
	end if
	
	ll_find ++
	if ll_find > ll_end then exit
	ll_find = idw_print.find("com_io_gubun = '"+as_io_gubun+"' and left(com_acct_code, 4) = '"+as_acct_code+"'", ll_find, ll_end)
loop


end subroutine

on w_hac503p_1.create
int iCurrent
call super::create
this.dw_gwa=create dw_gwa
this.st_4=create st_4
this.uo_acct_class=create uo_acct_class
this.uo_1=create uo_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_gwa
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.uo_acct_class
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.st_1
end on

on w_hac503p_1.destroy
call super::destroy
destroy(this.dw_gwa)
destroy(this.st_4)
destroy(this.uo_acct_class)
destroy(this.uo_1)
destroy(this.st_1)
end on

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_print		=	dw_print
ist_back			=	st_back

//uo_slip_class.rb_1.visible = false

wf_getchild()

is_bdgt_year	=	uo_bdgt_year.uf_getyy()
is_slip_class 	= 	uo_slip_class.uf_getcode()
ii_acct_class	=	uo_acct_class.uf_getcode()
is_gwa			=	gstru_uid_uname.dept_code	
dw_gwa.setitem(1, 'code', gstru_uid_uname.dept_code)


is_pay_date = f_today()

end event

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('조회중')

wf_retrieve()

wf_setMsg('')

return 1

end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_print_form1`ln_templeft within w_hac503p_1
end type

type ln_tempright from w_print_form1`ln_tempright within w_hac503p_1
end type

type ln_temptop from w_print_form1`ln_temptop within w_hac503p_1
end type

type ln_tempbuttom from w_print_form1`ln_tempbuttom within w_hac503p_1
end type

type ln_tempbutton from w_print_form1`ln_tempbutton within w_hac503p_1
end type

type ln_tempstart from w_print_form1`ln_tempstart within w_hac503p_1
end type

type uc_retrieve from w_print_form1`uc_retrieve within w_hac503p_1
end type

type uc_insert from w_print_form1`uc_insert within w_hac503p_1
end type

type uc_delete from w_print_form1`uc_delete within w_hac503p_1
end type

type uc_save from w_print_form1`uc_save within w_hac503p_1
end type

type uc_excel from w_print_form1`uc_excel within w_hac503p_1
end type

type uc_print from w_print_form1`uc_print within w_hac503p_1
end type

type st_line1 from w_print_form1`st_line1 within w_hac503p_1
end type

type st_line2 from w_print_form1`st_line2 within w_hac503p_1
end type

type st_line3 from w_print_form1`st_line3 within w_hac503p_1
end type

type uc_excelroad from w_print_form1`uc_excelroad within w_hac503p_1
end type

type ln_dwcon from w_print_form1`ln_dwcon within w_hac503p_1
end type

type uo_slip_class from w_print_form1`uo_slip_class within w_hac503p_1
integer x = 2181
integer y = 176
end type

event uo_slip_class::ue_itemchanged;call super::ue_itemchanged;is_slip_class	=	uf_getcode()

end event

type rb_3 from w_print_form1`rb_3 within w_hac503p_1
boolean visible = false
integer x = 3163
integer y = 352
end type

type rb_2 from w_print_form1`rb_2 within w_hac503p_1
boolean visible = false
integer x = 2665
integer y = 352
end type

type rb_1 from w_print_form1`rb_1 within w_hac503p_1
boolean visible = false
integer x = 2167
integer y = 352
end type

type gb_1 from w_print_form1`gb_1 within w_hac503p_1
boolean visible = false
integer x = 1883
integer y = 264
end type

type uo_bdgt_year from w_print_form1`uo_bdgt_year within w_hac503p_1
integer x = 78
integer y = 184
integer width = 663
end type

event uo_bdgt_year::ue_itemchange;call super::ue_itemchange;is_bdgt_year	=	uf_getyy()

end event

type gb_3 from w_print_form1`gb_3 within w_hac503p_1
boolean visible = false
integer width = 3872
integer height = 180
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_back from w_print_form1`st_back within w_hac503p_1
boolean visible = false
integer x = 18
integer y = 44
integer height = 112
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_print from w_print_form1`dw_print within w_hac503p_1
string dataobject = "d_hac503p_1"
end type

type dw_con from w_print_form1`dw_con within w_hac503p_1
boolean visible = false
end type

type dw_gwa from datawindow within w_hac503p_1
integer x = 1033
integer y = 192
integer width = 1106
integer height = 76
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_sosok501_group_opt1"
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

event itemchanged;is_gwa = trim(data)
end event

event losefocus;accepttext()
end event

type st_4 from statictext within w_hac503p_1
integer x = 763
integer y = 200
integer width = 270
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "요구부서"
boolean focusrectangle = false
end type

type uo_acct_class from cuo_acct_class within w_hac503p_1
event destroy ( )
boolean visible = false
integer x = 2848
integer y = 88
integer width = 987
integer taborder = 130
boolean bringtotop = true
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class	=	uf_getcode()

end event

type uo_1 from cuo_date within w_hac503p_1
integer x = 3150
integer y = 180
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_1.destroy
call cuo_date::destroy
end on

type st_1 from statictext within w_hac503p_1
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
boolean focusrectangle = false
end type

