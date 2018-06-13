$PBExportHeader$w_hpa303b.srw
$PBExportComments$명절휴가비 생성(전체/학과별 생성)
forward
global type w_hpa303b from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type rb_1 from radiobutton within w_hpa303b
end type
type rb_2 from radiobutton within w_hpa303b
end type
type hpb_1 from hprogressbar within w_hpa303b
end type
type st_status from statictext within w_hpa303b
end type
type cb_1 from commandbutton within w_hpa303b
end type
type gb_4 from groupbox within w_hpa303b
end type
type dw_list003_back from cuo_dwwindow within w_hpa303b
end type
type uo_yearmonth from cuo_yearmonth within w_hpa303b
end type
type uo_dept_code from cuo_dept within w_hpa303b
end type
type st_2 from statictext within w_hpa303b
end type
type em_pay_date from editmask within w_hpa303b
end type
type dw_list004 from datawindow within w_hpa303b
end type
type dw_list005 from datawindow within w_hpa303b
end type
type cbx_1 from checkbox within w_hpa303b
end type
type st_1 from statictext within w_hpa303b
end type
type dw_head from datawindow within w_hpa303b
end type
type st_3 from statictext within w_hpa303b
end type
type dw_list007 from datawindow within w_hpa303b
end type
type pb_1 from uo_imgbtn within w_hpa303b
end type
type dw_list002 from uo_dwgrid within w_hpa303b
end type
type dw_list003 from uo_dwgrid within w_hpa303b
end type
end forward

global type w_hpa303b from w_tabsheet
integer height = 2724
string title = "명절휴가비 생성"
rb_1 rb_1
rb_2 rb_2
hpb_1 hpb_1
st_status st_status
cb_1 cb_1
gb_4 gb_4
dw_list003_back dw_list003_back
uo_yearmonth uo_yearmonth
uo_dept_code uo_dept_code
st_2 st_2
em_pay_date em_pay_date
dw_list004 dw_list004
dw_list005 dw_list005
cbx_1 cbx_1
st_1 st_1
dw_head dw_head
st_3 st_3
dw_list007 dw_list007
pb_1 pb_1
dw_list002 dw_list002
dw_list003 dw_list003
end type
global w_hpa303b w_hpa303b

type variables
datawindowchild	idw_child

datawindow			idw_item, idw_item_dtl, idw_dtl

string	is_yearmonth, is_pay_date, is_yearmonth_00
string	is_dept_code
string	is_date_gbn						// 명절구분(1=평월, 2=명절)

string	is_code	= '22'				// 명절휴가비코드('22')
string	is_member_no, is_name, is_today
integer	ii_excepte_gbn, ii_sort, ii_num_of_paywork, ii_num_of_bonwork
integer	ii_item_gbn1					// 소급구분(0/9)
integer	ii_item_gbn2					// 계산기준(1:일기준, 2:월기준)
integer	ii_ann_opt						// 급여지급구분(1:정상지급, 2:연봉제)
dec{0}	idb_amt, idb_nontax_amt
string	is_first_date					// 최초임용일자
string	is_tax_class					// 비과세여부

integer	ii_str_jikjong, ii_end_jikjong

end variables

forward prototypes
public function integer wf_insert ()
public subroutine wf_getchild ()
public function integer wf_retrieve ()
public function integer wf_create ()
end prototypes

public function integer wf_insert ();// ==========================================================================================
// 기    능 : 	개인별 월 지급에 insert
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_insert()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

long	ll_row

if idb_amt = 0 and idb_nontax_amt = 0	then	return 0

if ii_num_of_paywork <= 0 then	return	0

// 계산기준에 따라서 금액을 다시 구성한다.(1:일기준, 2:월기준) 
// 월기준은 15일 이상 근무자를 말한다.(단, 상여와 정근수당은 제외)
if ii_item_gbn2 = 1 then
	idb_amt = (idb_amt / integer(right(f_lastdate(is_yearmonth), 2))) * ii_num_of_paywork
else
	if ii_num_of_paywork <= 15 then
		idb_amt = 0
	end if
end if

Insert	into	padb.hpa005d	
	(	member_no, year_month, chasu, code, item_name, pay_date, pay_amt, nontax_amt, 
		excepte_gbn, sort, contents, remark, 
		worker, work_date, ipaddr, job_uid, job_add, job_date	)	values	(
		:is_member_no, :is_yearmonth, '3', :is_code, :is_name, :is_pay_date, :idb_amt, :idb_nontax_amt, 
		:ii_excepte_gbn, :ii_sort, '', '', 
		:gs_empcode, sysdate, :gs_ip, :gs_empcode, :gs_ip, sysdate )	;

if sqlca.sqlcode <> 0 	then	return	sqlca.sqlcode

return	0
end function

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================


// 직위코드

dw_list002.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 보직코드
dw_list002.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 항목구분
dw_list003.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if



end subroutine

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :	
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================
//is_code	=	'22'
//
//// 명절휴가비에 대한 상세사항 가져오기
//select	item_name, excepte_gbn, sort, tax_class
//into		:is_name, :ii_excepte_gbn, :ii_sort, :is_tax_class
//from		padb.hpa003m
//where		use_yn	=	'9'
//and		code		=	:is_code	;
//
//if sqlca.sqlcode <> 0 then	is_code = ''
//

dw_list002.retrieve(is_yearmonth_00, is_dept_code, ii_str_jikjong, ii_end_jikjong, '')
dw_list003.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong)

return 0
end function

public function integer wf_create ();// ==========================================================================================
// 기    능 : 	월 급여 생성(명절휴가비만 생성)
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_str_member, ls_end_member, ls_name
string	ls_year_month, ls_pay_date
long		ll_count
long		ll_code_count
integer	i

long		ll_cnt1, ll_cnt2, ll_cnt3, ll_calc_count
string	ls_calc_gbn, ls_jikgub, ls_bojik, ls_gubun_chk
integer	li_jikjong, li_jikwi, li_jikmu, li_work_year, li_code, li_ann_opt
dec{0}	ldb_salary
dec		ldb_biyul

if	f_getconfirm('3', is_yearmonth, 'Y') > 0	then	return	100

st_status.text = '명절휴가비 생성 준비중 입니다. 잠시만 기다려 주시기 바랍니다!...'

wf_retrieve()

// 급여기초를 retrieve 한다.
if dw_list002.rowcount() < 1 then
	f_messagebox('1', '급여기초자료가 존재하지 않습니다.~n~n급여기초자료를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if

// 명절휴가비에 대한 상세사항 Check
if is_code = '' then
	f_messagebox('3', '명절휴가비에 대한 급여사항이 존재하지 않습니다.~n~n확인 후 다시 처리하시기 바랍니다.!')
	return	100
end if

// 월지급내역에 자료가 있는지 확인한다.
select	count(*)
into		:ll_count
from		padb.hpa005d a, indb.hin001m b
where		a.year_month	=		:is_yearmonth
and		b.gwa		like	:is_dept_code || '%'
and		a.member_no		=		b.member_no	
and      a.chasu        =     '3'
and		substr(b.duty_code, 1, 1)	>=		:ii_str_jikjong
and		substr(b.duty_code, 1, 1)	<=		:ii_end_jikjong	;

if ll_count > 0 then
	if f_messagebox('2', '해당년월의 명절휴가비 생성이 완료된 상태입니다. 자료를 삭제 후 생성하시겠습니까?') <> 1 then return	100
	
	delete	from	padb.hpa005d
	where		year_month	=	:is_yearmonth
	and      chasu       =  '3'
	and		member_no	in	(	select	member_no
										from		indb.hin001m
										where		gwa		like	:is_dept_code	||	'%'	
										and		substr(duty_code, 1, 1)	>=		:ii_str_jikjong
										and		substr(duty_code, 1, 1)	<=		:ii_end_jikjong	)	;

	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
end if

ll_count = dw_list002.rowcount()		// 급여기초자료 Count

// Process Bar Setting
hpb_1.setrange(1, ll_count + 1)
hpb_1.setstep 	= 1
hpb_1.position	= 0

// 자료 생성 Start.....

setpointer(hourglass!)

st_status.text = '명절휴가비 생성중 입니다!...'

if f_messagebox('2', string(is_yearmonth_00, '@@@@년 @@월') + '의 본봉으로~n~n' + string(is_yearmonth, '@@@@년 @@월') + '의 명절휴가비를 생성하시겠습니까?') <> 1 then
	return 100
end if

dw_list003.reset()

// 급여기초자료 Loop
for ll_cnt1	= 1 to ll_count
	is_member_no		=	dw_list002.getitemstring(ll_cnt1, 'member_no')
	li_jikjong			= 	dw_list002.getitemnumber(ll_cnt1, 'jikjong_code')
	ls_jikgub			= 	dw_list002.getitemstring(ll_cnt1, 'duty_code')
	li_jikwi				= 	dw_list002.getitemnumber(ll_cnt1, 'jikwi_code')
	li_jikmu				= 	dw_list002.getitemnumber(ll_cnt1, 'jikmu_code')
	ls_bojik				= 	dw_list002.getitemstring(ll_cnt1, 'bojik_code')
	li_work_year		= 	dw_list002.getitemnumber(ll_cnt1, 'work_year')
	ii_num_of_paywork	= 	dw_list002.getitemnumber(ll_cnt1, 'num_of_paywork')
	is_first_date		= 	dw_list002.getitemstring(ll_cnt1, 'first_date')
	li_ann_opt			=	dw_list002.getitemnumber(ll_cnt1, 'ann_opt')
	ldb_salary			= 	dw_list002.getitemnumber(ll_cnt1, 'salary')
	
   long ll_count2
	ll_count2 = idw_dtl.retrieve()
	
  for ll_cnt2 = 1 to ll_count2
		is_code           = idw_dtl.getitemstring(ll_cnt2, 'code')
		is_name           = idw_dtl.getitemstring(ll_cnt2, 'item_name')
		ii_excepte_gbn    = idw_dtl.getitemnumber(ll_cnt2, 'excepte_gbn')
		ii_sort           = idw_dtl.getitemnumber(ll_cnt2, 'sort')
		is_tax_class      = idw_dtl.getitemstring(ll_cnt2, 'tax_class')
	
		idb_amt 			= 0
		idb_nontax_amt	= 0
		
		// ==========================================================================================
		// 효도비30)	--->	교원(1)		:	본봉*50%
		//								조교(2)		:	본봉*50%
		// 							일반직(4)	:	본봉*50%
		// 							기능직(5)	:	본봉*50%
		//								겸임, 초빙은 100,000
		//								연봉자는 지급하지 않는다.
		//	특별수당(22)
		// 연구보조수당(23)
		// ==========================================================================================
		// 급여계산기준정보 Retrieve
		ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, li_work_year)
		
		// 연봉자는 지급하지 않는다.
		if li_ann_opt = 2 then continue
		
		if (ll_calc_count > 0)  then
			// 급여계산기준정보 중에서 첫 자료만으로 계산한다.(비율을 구한다.)
			ls_gubun_chk	= idw_item_dtl.getitemstring(1, 'gubun_chk')
			
			if ls_gubun_chk = '1' then
				idb_amt	=	idw_item_dtl.getitemnumber(1, 'amt')
			else
				idb_amt	=	ldb_salary * (idw_item_dtl.getitemnumber(1, 'rate') / 100)
			end if
		end if
	
		// 개인별 급여지급내역에 Insert...
		if wf_insert() < 0 then	return	sqlca.sqlcode
	
		// ==========================================================================================
		// 명절휴가비 생성 End
		// ==========================================================================================
		
   next
	hpb_1.position += 1
		
	st_status.text = string(ll_cnt1, '#,##0') + ' 건 명절휴가비 생성중 입니다!...'
next

hpb_1.position += 1
SetPointer(Arrow!)
//st_status.text = string(ll_count) + '건의 자료가 생성되었습니다.!'

return	0

end function

on w_hpa303b.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.hpb_1=create hpb_1
this.st_status=create st_status
this.cb_1=create cb_1
this.gb_4=create gb_4
this.dw_list003_back=create dw_list003_back
this.uo_yearmonth=create uo_yearmonth
this.uo_dept_code=create uo_dept_code
this.st_2=create st_2
this.em_pay_date=create em_pay_date
this.dw_list004=create dw_list004
this.dw_list005=create dw_list005
this.cbx_1=create cbx_1
this.st_1=create st_1
this.dw_head=create dw_head
this.st_3=create st_3
this.dw_list007=create dw_list007
this.pb_1=create pb_1
this.dw_list002=create dw_list002
this.dw_list003=create dw_list003
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.hpb_1
this.Control[iCurrent+4]=this.st_status
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.dw_list003_back
this.Control[iCurrent+8]=this.uo_yearmonth
this.Control[iCurrent+9]=this.uo_dept_code
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.em_pay_date
this.Control[iCurrent+12]=this.dw_list004
this.Control[iCurrent+13]=this.dw_list005
this.Control[iCurrent+14]=this.cbx_1
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.dw_head
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.dw_list007
this.Control[iCurrent+19]=this.pb_1
this.Control[iCurrent+20]=this.dw_list002
this.Control[iCurrent+21]=this.dw_list003
end on

on w_hpa303b.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.hpb_1)
destroy(this.st_status)
destroy(this.cb_1)
destroy(this.gb_4)
destroy(this.dw_list003_back)
destroy(this.uo_yearmonth)
destroy(this.uo_dept_code)
destroy(this.st_2)
destroy(this.em_pay_date)
destroy(this.dw_list004)
destroy(this.dw_list005)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.dw_head)
destroy(this.st_3)
destroy(this.dw_list007)
destroy(this.pb_1)
destroy(this.dw_list002)
destroy(this.dw_list003)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		fALSE)
//
//dw_list002			=	dw_list002
//dw_list003			=	dw_list003
//idw_item			=	dw_list004
//idw_item_dtl	=	dw_list005
//idw_dtl        =  dw_list007
//
//uo_yearmonth.uf_settitle('기준년월')
//is_yearmonth_00	=	uo_yearmonth.uf_getyearmonth()
//
//is_yearmonth	=	is_yearmonth_00
//is_pay_date	=	is_yearmonth + '25'
//em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')
//
//uo_dept_code.uf_setdept('', '학과명')
//is_dept_code	=	uo_dept_code.uf_getcode()
//
//f_getdwcommon(dw_head, 'jikjong_code', 0, 750)
//
//wf_getchild()
//
//
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		fALSE)

//dw_list002			=	dw_list002
//dw_list003			=	dw_list003
idw_item			=	dw_list004
idw_item_dtl	=	dw_list005
idw_dtl        =  dw_list007

uo_yearmonth.uf_settitle('기준년월')
is_yearmonth_00	=	uo_yearmonth.uf_getyearmonth()

is_yearmonth	=	is_yearmonth_00
is_pay_date	=	is_yearmonth + '25'
em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')

uo_dept_code.uf_setdept('', '학과명')
is_dept_code	=	uo_dept_code.uf_getcode()

f_getdwcommon(dw_head, 'jikjong_code', 0, 750)

//wf_getchild()



end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa303b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa303b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa303b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa303b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa303b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa303b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa303b
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa303b
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa303b
end type

type uc_save from w_tabsheet`uc_save within w_hpa303b
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa303b
end type

type uc_print from w_tabsheet`uc_print within w_hpa303b
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa303b
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa303b
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa303b
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa303b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa303b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa303b
boolean visible = false
integer x = 1618
integer y = 856
integer width = 3881
integer height = 2296
integer taborder = 60
tabpage_sheet02 tabpage_sheet02
end type

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
event create ( )
event destroy ( )
string tag = "N"
integer width = 3845
integer height = 2180
string text = "급여계산기준코드관리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 9
integer width = 3845
integer height = 2180
borderstyle borderstyle = stylelowered!
end type

event dw_list001::clicked;call super::clicked;//String s_memberno
//IF row > 0 then
//	s_memberno = dw_list001.getItemString(row,'member_no')
//	dw_update101.retrieve(s_memberno)
//end IF
end event

type uo_tab from w_tabsheet`uo_tab within w_hpa303b
boolean visible = false
integer x = 1920
integer y = 1332
end type

type dw_con from w_tabsheet`dw_con within w_hpa303b
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hpa303b
integer height = 228
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 3845
integer height = 2180
long backcolor = 79741120
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type rb_1 from radiobutton within w_hpa303b
boolean visible = false
integer x = 1298
integer y = 288
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
boolean enabled = false
string text = "평월"
end type

event clicked;rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)

rb_1.underline	=	true
rb_2.underline	=	false

is_date_gbn	= '1'

end event

type rb_2 from radiobutton within w_hpa303b
boolean visible = false
integer x = 1641
integer y = 288
integer width = 494
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean underline = true
long textcolor = 16711680
long backcolor = 67108864
string text = "명절(설날,추석)"
boolean checked = true
end type

event clicked;rb_2.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)

rb_2.underline	=	true
rb_1.underline	=	false

is_date_gbn	= '2'

end event

type hpb_1 from hprogressbar within w_hpa303b
integer x = 101
integer y = 584
integer width = 4279
integer height = 92
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type st_status from statictext within w_hpa303b
integer x = 114
integer y = 504
integer width = 4283
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "진행 상태..."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_hpa303b
event keypress pbm_keydown
boolean visible = false
integer x = 1701
integer y = 328
integer width = 370
integer height = 104
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "처리"
end type

event keypress;if key = keyenter! then
	this.post event clicked()
end if
end event

event clicked;//string ls_year
//long   ll_count
//

end event

type gb_4 from groupbox within w_hpa303b
integer x = 50
integer y = 424
integer width = 4384
integer height = 288
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "진행상태"
end type

type dw_list003_back from cuo_dwwindow within w_hpa303b
boolean visible = false
integer x = 50
integer y = 1620
integer width = 101
integer height = 100
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "명절휴가비 지급 내역"
string dataobject = "d_hpa303b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event un_unmove;call super::un_unmove;// Title Bar가 있으면서 DataWindow를 이동시킬 수 없다.

uint	lui_wordparm

//lui_wordparm = message.wordparm　 

lui_wordparm = 61456

CHOOSE CASE lui_wordparm
      CASE 61456, 61458
         message.processed = true
         message.returnvalue = 0
END CHOOSE

return


//// Title Bar가 있으면서 DataWindow를 이동시킬 수 없다.
//unsignedinteger	lui_wordparm
//lui_wordparm = message.wordparm　 
//CHOOSE CASE lui_wordparm
//      CASE 61456, 61458
//         message.processed = true
//         message.returnvalue = 0
//END CHOOSE
//return


end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

selectrow(0, false)
selectrow(currentrow, true)

f_dw_find(this, dw_list002, 'member_no')

end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

selectrow(0, false)
selectrow(1, true)

f_dw_find(dw_list002, this, 'member_no')

end event

event constructor;call super::constructor;this.uf_setClick(False)
end event

type uo_yearmonth from cuo_yearmonth within w_hpa303b
event destroy ( )
integer x = 151
integer y = 188
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yearmonth_00	=	uf_getyearmonth()

is_pay_date = is_yearmonth + right(em_pay_date.text, 2)
em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')

parent.triggerevent('ue_retrieve')

end event

type uo_dept_code from cuo_dept within w_hpa303b
event destroy ( )
integer x = 1778
integer y = 176
integer taborder = 30
boolean bringtotop = true
boolean border = false
end type

on uo_dept_code.destroy
call cuo_dept::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_dept_code = uf_getcode()

//parent.triggerevent('ue_retrieve')
end event

type st_2 from statictext within w_hpa303b
integer x = 215
integer y = 300
integer width = 293
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "지급일자"
boolean focusrectangle = false
end type

type em_pay_date from editmask within w_hpa303b
integer x = 494
integer y = 284
integer width = 480
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "19000101~~29991231"
end type

event modified;date		ldt_pay_date
string	ls_bef_date

ls_bef_date	=	 this.text

if getdata(ldt_pay_date) < 0 then
	f_messagebox('1', st_2.text + '를 정확히 입력해 주시기 바랍니다.!')
	this.text = ls_bef_date
	is_pay_date = ''
end if

is_pay_date		=	string(ldt_pay_date, 'yyyymmdd')
is_yearmonth	=	left(is_pay_date, 6)


end event

type dw_list004 from datawindow within w_hpa303b
event ue_dwnkey pbm_dwnkey
boolean visible = false
integer x = 1417
integer y = 292
integer width = 1509
integer height = 512
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa301b_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_list005 from datawindow within w_hpa303b
boolean visible = false
integer x = 1760
integer y = 396
integer width = 1509
integer height = 512
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa301b_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cbx_1 from checkbox within w_hpa303b
boolean visible = false
integer x = 2386
integer y = 284
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean underline = true
long textcolor = 16711680
long backcolor = 67108864
string text = "소급금계산"
end type

type st_1 from statictext within w_hpa303b
integer x = 1801
integer y = 300
integer width = 206
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "직종명"
boolean focusrectangle = false
end type

type dw_head from datawindow within w_hpa303b
integer x = 2021
integer y = 284
integer width = 699
integer height = 80
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) or trim(data) = '0' or trim(data) = '' then	
	ii_str_jikjong	=	0
	ii_end_jikjong	=	9
else
	ii_str_jikjong = integer(trim(data))
	ii_end_jikjong = integer(trim(data))
end if

//wf_getchild2()

//parent.triggerevent('ue_retrieve')
end event

event itemfocuschanged;triggerevent(itemchanged!)

end event

type st_3 from statictext within w_hpa303b
integer x = 901
integer y = 196
integer width = 777
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 본봉이 있는 년월입니다."
boolean focusrectangle = false
end type

type dw_list007 from datawindow within w_hpa303b
boolean visible = false
integer x = 521
integer y = 536
integer width = 411
integer height = 432
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa303b_3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type pb_1 from uo_imgbtn within w_hpa303b
integer x = 50
integer y = 36
integer taborder = 60
boolean bringtotop = true
string btnname = "생성처리"
end type

event clicked;call super::clicked;// 생성처리한다.
integer	li_rtn
string ls_month
long ll_count, ll_judge
setpointer(hourglass!)

ls_month =  mid(is_yearmonth_00,5,2) 

select count(*)
  into :ll_count
  from padb.hpa003m
 where substr(pay_month,:ls_month,1) = '1'
   and code in ('22','23','30'); 

if sqlca.sqlcode <> 0 then
	messagebox('','error')
   return
end if

select count(*)
	  into :ll_judge
	  from padb.hpa021m 
	 where confirm_gbn = 9
		and year_month = :is_yearmonth
		and chasu      = '3';
	
	if sqlca.sqlcode <> 0 then return 
   
	if ll_judge <> 0 then
	   messagebox('','이미 확정처리가 되었습니다.')
	   return
   end if
	

if ll_count = 0 then
	messagebox('','해당월은 특별상여월이 아닙니다.')
	return
end if


li_rtn	=	wf_create()

setpointer(arrow!)

if	li_rtn = 0 then
	commit;
	parent.triggerevent('ue_retrieve')
	f_messagebox('1', string(dw_list003.rowcount()) + '건의 자료를 생성했습니다.!')
elseif li_rtn < 0 then
	f_messagebox('3', '[' + is_member_no + '] ' + sqlca.sqlerrtext)
	rollback	;
	parent.triggerevent('ue_retrieve')
end if

st_status.text = '진행 상태...'

end event

on pb_1.destroy
call uo_imgbtn::destroy
end on

type dw_list002 from uo_dwgrid within w_hpa303b
integer x = 50
integer y = 720
integer width = 4384
integer height = 900
integer taborder = 70
boolean titlebar = true
string title = "급여 기초 사항"
string dataobject = "d_hpa303b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;// 직위코드

dw_list002.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 보직코드
dw_list002.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
settransobject(sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, dw_list003, 'member_no')
end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(dw_list003, this, 'member_no')


end event

type dw_list003 from uo_dwgrid within w_hpa303b
event un_unmove pbm_syscommand
integer x = 50
integer y = 1620
integer width = 4384
integer height = 676
integer taborder = 90
boolean bringtotop = true
boolean titlebar = true
string title = "명절휴가비 지급 내역"
string dataobject = "d_hpa303b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event un_unmove;uint li_msg
li_msg = message.wordparm
CHOOSE CASE li_msg
	CASE 61456, 61458
		message.processed = true
		message.returnvalue = 0
END CHOOSE


// Title Bar가 있으면서 DataWindow를 이동시킬 수 없다.

uint	lui_wordparm

//lui_wordparm = message.wordparm　 

lui_wordparm = 61456

CHOOSE CASE lui_wordparm
      CASE 61456, 61458
         message.processed = true
         message.returnvalue = 0
END CHOOSE

return


//// Title Bar가 있으면서 DataWindow를 이동시킬 수 없다.
//unsignedinteger	lui_wordparm
//lui_wordparm = message.wordparm　 
//CHOOSE CASE lui_wordparm
//      CASE 61456, 61458
//         message.processed = true
//         message.returnvalue = 0
//END CHOOSE
//return
end event

event constructor;call super::constructor;// 항목구분
dw_list003.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if



settransobject(sqlca)
end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(dw_list002, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, dw_list002, 'member_no')

end event

