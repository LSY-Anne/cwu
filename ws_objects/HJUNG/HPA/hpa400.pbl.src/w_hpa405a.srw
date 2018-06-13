$PBExportHeader$w_hpa405a.srw
$PBExportComments$연말정산 기부금 지급조서 생성
forward
global type w_hpa405a from w_condition_window
end type
type dw_list from uo_search_dwc within w_hpa405a
end type
type sle_filename from singlelineedit within w_hpa405a
end type
type st_21 from statictext within w_hpa405a
end type
type pb_fileupload from picturebutton within w_hpa405a
end type
type em_date1 from editmask within w_hpa405a
end type
type st_1 from statictext within w_hpa405a
end type
type em_date2 from editmask within w_hpa405a
end type
type st_2 from statictext within w_hpa405a
end type
type st_4 from statictext within w_hpa405a
end type
type st_5 from statictext within w_hpa405a
end type
type uo_year from cuo_year within w_hpa405a
end type
type st_status from statictext within w_hpa405a
end type
type hpb_1 from hprogressbar within w_hpa405a
end type
type gb_3 from groupbox within w_hpa405a
end type
type gb_4 from groupbox within w_hpa405a
end type
end forward

global type w_hpa405a from w_condition_window
dw_list dw_list
sle_filename sle_filename
st_21 st_21
pb_fileupload pb_fileupload
em_date1 em_date1
st_1 st_1
em_date2 em_date2
st_2 st_2
st_4 st_4
st_5 st_5
uo_year uo_year
st_status st_status
hpb_1 hpb_1
gb_3 gb_3
gb_4 gb_4
end type
global w_hpa405a w_hpa405a

type variables
datawindowchild	idw_child
datawindow			idw_preview, idw_data

statictext			ist_back

string		is_year						// 지급년도
string		is_date1, is_date2		// 제출년월일, 영수(지급)년월일


string		is_yearmonth
end variables

forward prototypes
public function integer wf_filedownload ()
end prototypes

public function integer wf_filedownload ();// ===============기부금 지급조서 생성======================================================
// 기    능 : 	file download
// 작 성 인 : 	이인갑
// 작성일자 : 	2002.04
// 함수원형 : 	wf_filedownload()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// Upload File Open
Integer	li_Rtn
String	ls_FullName
String	ls_FileName
String	ls_message

long		ll_rowcount, ll_row, ll_cnt, ll_cnt2
string	ls_report
string	ls_business_no, ls_campus_name, ls_president, ls_corp_no, ls_tel_phone, ls_tax_office_code, ls_fname

string	ls_member_no, ls_kname, ls_jumin_no
string	ls_business_name, ls_count,ls_businessNo, ls_gibo_code, ls_gibo_no
string	ls_gwangae_code, ls_foreigner_gbn, ls_gibu_name, ls_gibu_jumin

datastore	lds_data
datastore	lds_bef

st_status.text = '기부금 지급조서  생성 준비중입니다...'

// 생성할 자료 Retrieve
lds_data	=	create	datastore
lds_data.dataobject	=	'd_hpa405a_1'
lds_data.settransobject(sqlca)

ll_rowcount = lds_data.retrieve(is_year)
if ll_rowcount < 1 then
	f_messagebox('1', '기부금 생성할 자료가 존재하지 않습니다.!')
	return	100
end if

//  Record(제출자 레코드)
select	nvl(business_no, ' '), nvl(campus_name, ' '), nvl(president, ' '), nvl(corp_no, ' '), 
			nvl(tel_phone, ' '), nvl(tax_office_code, '   ')
into		:ls_business_no, :ls_campus_name, :ls_president, :ls_corp_no, :ls_tel_phone, :ls_tax_office_code
from		CDDB.KCH000M
where		campus_code	=	(	select	min(campus_code)
									from		CDDB.KCH000M	)	;
									
if sqlca.sqlcode <> 0 then
	f_messagebox('1', '캠퍼스 자료가 존재하지 않습니다.~n~n캠퍼스 관리에서 확인하시기 바랍니다.!')
	return	100
end if

if trim(ls_tax_office_code) = '' then
	f_messagebox('1', '세무서 코드가 존재하지 않습니다.~n~n캠퍼스 관리에서 확인하시기 바랍니다.!')
	return	100
end if

if trim(ls_business_no) = '' then
	f_messagebox('1', '사업자등록번호가 존재하지 않습니다.~n~n캠퍼스 관리에서 확인하시기 바랍니다.!')
	return	100
end if 

ls_business_no			=	trim(ls_business_no)
ls_campus_name			=	trim(ls_campus_name)
ls_president			=	trim(ls_president)
ls_corp_no				=	trim(ls_corp_no)
ls_tel_phone			=	trim(ls_tel_phone)
ls_tax_office_code	=	trim(ls_tax_office_code)
ls_fname					=	trim(ls_fname)

ls_filename	=	'H' + left(ls_business_no, 7) + '.' + right(ls_business_no, 3)

string	ls_dir
ulong		lul_buf

//lul_buf 	= 100
//ls_dir 	= space(100)
//GetCurrentDirectoryA(lul_buf, ls_dir)

ls_dir = ls_dir + '\'
ls_fullname	=	ls_dir + ls_filename

//messagebox('1', ls_fullname)

if trim(sle_filename.text) = '' then
	sle_filename.text	=	ls_fullname
elseif right(trim(sle_filename.text), 12) <> ls_filename then
	f_messagebox('3', '생성 화일명이 정확하지 않습니다.!')
	sle_filename.text	=	ls_fullname
end if
ls_fullname	=	trim(sle_filename.text)


// 화일 존재여부 체크
if FileExists(ls_fullname) then
	if f_messagebox('2', ls_fullname + '~n화일이 존재합니다.~n~n삭제 후 다시 생성하시겠습니까?') = 2 then	
		return 100
	else
		if FileDelete(ls_fullname) = false	then
			f_messagebox('3', ls_fullname + '~n화일을 삭제할 수 없습니다.~n~n확인 후 다시 실행해주시기 바랍니다.!')
			return	100
		end if
	end if
end if

idw_preview.reset()

// Process Bar Setting
hpb_1.setrange(1, ll_rowcount + 1)
hpb_1.setstep 	= 1
hpb_1.position	= 0

//  Record(기부금 레코드)
for ll_cnt = 1 to ll_rowcount

	ll_row = idw_preview.insertrow(0)
	idw_preview.scrolltorow(ll_row)
	
	ls_member_no = trim(lds_data.getitemstring(ll_cnt, 'member_no'))
	ls_kname		=	trim(lds_data.getitemstring(ll_cnt, 'so_name'))
	ls_jumin_no	=	trim(lds_data.getitemstring(ll_cnt, 'self_jumin_no'))

	ls_businessNo		=	trim(lds_data.getitemstring(ll_cnt, 'business_no'))
	ls_business_name	=	trim(lds_data.getitemstring(ll_cnt, 'business_name'))
	
	ls_gibo_code		=	trim(lds_data.getitemstring(ll_cnt, 'gibo_code'))
	ls_gibo_no			=	trim(lds_data.getitemstring(ll_cnt, 'gibo_no'))
	
	ls_gibu_name		=	trim(lds_data.getitemstring(ll_cnt, 'name'))
	ls_gibu_jumin		=	trim(lds_data.getitemstring(ll_cnt, 'jumin_no'))
	ls_GWANGAE_CODE		=	trim(lds_data.getitemstring(ll_cnt, 'GWANGAE_CODE'))
	ls_FOREIGNER_GBN		=	trim(lds_data.getitemstring(ll_cnt, 'FOREIGNER_GBN'))
	
//	IF isnull(ls_gibo_no) or ls_gibo_no = '' then ls_gibo_no = SPACE(20)
	IF isnull(ls_businessNo) or ls_businessNo = '' then ls_businessNo = SPACE(13)

	if len(ls_jumin_no) < 13 then	ls_jumin_no	=	ls_jumin_no + fill('0', 13 - len(ls_jumin_no))
	

	ls_report	=	'A' 																							//	레코드구분(1)[,1] 
	ls_report	+= '27' 																							// 자료구분(2)[,3],
	ls_report	+= ls_tax_office_code 																		// 세무서(3)[,6],
	ls_report	+= string(ll_cnt, '0000000')																// 일련번호(7)[,12]
	ls_report	+= is_date1																						// 제출년월일(8)[20]
	//제출자[대리인]
	ls_report	+=	ls_business_no																				// 사업자등록번호(10)[,30]
	ls_report	+= 'cwu3120' + space(20 - len(trim('cwu3120')))										// 홈택스아이디[50]
	ls_report	+=	'9000'																						// 세무코드(4)[,54]
	//[원천징수 의무자]
	ls_report	+=	ls_business_no																				// 사업자번호(10)[,64]
	ls_report	+=	trim(ls_campus_name) + space(40 - len(trim(ls_campus_name)))				// 업체명(40)[,104]
	//[소득자(연말정산 신청자)]
	ls_report	+=	ls_jumin_no																					// 주민번호(13)[,117]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'foreigner_gbn_so'))						//내외국인코드(1)[118]
	ls_report	+=	trim(ls_kname) + space(30 - len(trim(ls_kname)))								// 성명(30)[,148]
	//[기부금 지급내역]
	ls_report	+=	TRIM(ls_businessNo) + SPACE(13 - LEN(TRIM(ls_businessNo)))					// 지급처 사업자등록번호[,161]
	ls_report	+=	ls_business_name + space(30 - len(trim(ls_business_name)))					// 지급처상호[,191]
	ls_report	+=	ls_gibo_code																				// 기부코드	[,193]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'gibo_count'),	fill('0', 5))		// 지급건수[,198]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'gibo_amt'),	fill('0', 13))			// 지급금액[,211]
	//기부자
	ls_report	+= ls_gwangae_code														//관계 거주자1 배우자 2 직계비속 3
	ls_report	+= ls_foreigner_gbn													//내국인 1 외국 9
	ls_report	+= ls_gibu_name + space(20 - len(trim(ls_gibu_name)))	//기부자 성명
	ls_report	+= ls_gibu_jumin														//기부자 주민번호
	
	ls_report	+= '00000000'
	ls_report	+= '00000000'
	ls_report	+= '0000000000000'
	ls_report	+= fill('0', 13)
	ls_report	+= fill('0', 13)
	ls_report	+=	space(118)
	
/*2009.02	
//	IF isnull(ls_gibo_no) or ls_gibo_no = '' then 
//	ls_report	+= SPACE(20)
//	else 
//	ls_report	+=	ls_gibo_no + SPACE(20 - LEN(TRIM(ls_gibo_no)))									// 기부일련번호[,232]
//	end if
//	ls_report	+=	space(8)																						// 공란(9)[,220]
*/


	idw_preview.setitem(ll_row, 'report', ls_report)

	hpb_1.position ++
	st_status.text = string(ll_cnt, '#,##0') + ' 건 연말정산 지급조서 화일 생성중 입니다!...'
next

hpb_1.position ++

	if idw_preview.saveas(ls_fullname, Text!, false) = 1 then
		f_messagebox('1', ls_fullname + '~n화일 생성을 성공했습니다.!')
	else
		f_messagebox('3', ls_fullname + '~n화일 생성을 실패했습니다.!')
	end if

destroy	lds_data

return	0
end function

on w_hpa405a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.sle_filename=create sle_filename
this.st_21=create st_21
this.pb_fileupload=create pb_fileupload
this.em_date1=create em_date1
this.st_1=create st_1
this.em_date2=create em_date2
this.st_2=create st_2
this.st_4=create st_4
this.st_5=create st_5
this.uo_year=create uo_year
this.st_status=create st_status
this.hpb_1=create hpb_1
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.sle_filename
this.Control[iCurrent+3]=this.st_21
this.Control[iCurrent+4]=this.pb_fileupload
this.Control[iCurrent+5]=this.em_date1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.em_date2
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.uo_year
this.Control[iCurrent+12]=this.st_status
this.Control[iCurrent+13]=this.hpb_1
this.Control[iCurrent+14]=this.gb_3
this.Control[iCurrent+15]=this.gb_4
end on

on w_hpa405a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.sle_filename)
destroy(this.st_21)
destroy(this.pb_fileupload)
destroy(this.em_date1)
destroy(this.st_1)
destroy(this.em_date2)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.uo_year)
destroy(this.st_status)
destroy(this.hpb_1)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이인갑
// 작성일자 : 	2005.01.
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	true)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		true)

idw_preview	=	dw_list

uo_year.st_title.text = '기준년도'
is_year	=	uo_year.uf_getyy()

is_date1	=	f_lastdate(f_today())
em_date1.text	=	string(is_date1, '@@@@/@@/@@')

is_date2	=	left(f_today(), 6) + '25'
em_date2.text	=	string(is_date2, '@@@@/@@/@@')
end event

event ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
//wf_retrieve()
//f_setpointer('END')
return 1
end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		li_deleterow


wf_setMsg('삭제중')

li_deleterow	=	idw_data.deleterow(0)

wf_setMsg('.')


return 
end event

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	true)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		true)

idw_preview	=	dw_list

uo_year.st_title.text = '기준년도'
is_year	=	uo_year.uf_getyy()

is_date1	=	f_lastdate(f_today())
em_date1.text	=	string(is_date1, '@@@@/@@/@@')

is_date2	=	left(f_today(), 6) + '25'
em_date2.text	=	string(is_date2, '@@@@/@@/@@')
end event

type ln_templeft from w_condition_window`ln_templeft within w_hpa405a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hpa405a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hpa405a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hpa405a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hpa405a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hpa405a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hpa405a
end type

type uc_insert from w_condition_window`uc_insert within w_hpa405a
end type

type uc_delete from w_condition_window`uc_delete within w_hpa405a
end type

type uc_save from w_condition_window`uc_save within w_hpa405a
end type

type uc_excel from w_condition_window`uc_excel within w_hpa405a
end type

type uc_print from w_condition_window`uc_print within w_hpa405a
end type

type st_line1 from w_condition_window`st_line1 within w_hpa405a
end type

type st_line2 from w_condition_window`st_line2 within w_hpa405a
end type

type st_line3 from w_condition_window`st_line3 within w_hpa405a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hpa405a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hpa405a
end type

type gb_1 from w_condition_window`gb_1 within w_hpa405a
integer y = 12
integer height = 216
integer textsize = -10
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생성/조회조건"
end type

type gb_2 from w_condition_window`gb_2 within w_hpa405a
integer y = 732
integer height = 1764
end type

type dw_list from uo_search_dwc within w_hpa405a
integer x = 37
integer y = 784
integer width = 3803
integer height = 1692
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hpa405a_2"
boolean border = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_filename from singlelineedit within w_hpa405a
integer x = 891
integer y = 292
integer width = 1481
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_21 from statictext within w_hpa405a
integer x = 18
integer y = 316
integer width = 855
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "연말정산 의료비 지급조서화일명"
boolean focusrectangle = false
end type

type pb_fileupload from picturebutton within w_hpa405a
integer x = 2377
integer y = 284
integer width = 430
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "     화일생성"
string picturename = "..\bmp\INSERT_E.BMP"
string disabledname = "..\bmp\INSERT_D.BMP"
alignment htextalign = left!
vtextalign vtextalign = vcenter!
end type

event clicked;// 자료를 생성한다.

integer	li_rtn

setpointer(hourglass!)

li_rtn = wf_filedownload()

//wf_retrieve()

setpointer(arrow!)


end event

type em_date1 from editmask within w_hpa405a
integer x = 1298
integer y = 92
integer width = 480
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
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
	f_messagebox('1', st_1.text + '를 정확히 입력해 주시기 바랍니다.!')
	this.text = ls_bef_date
	is_date1 = ''
end if

is_date1	=	string(ldt_pay_date, 'yyyymmdd')

end event

type st_1 from statictext within w_hpa405a
integer x = 997
integer y = 108
integer width = 293
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
string text = "제출일자"
boolean focusrectangle = false
end type

type em_date2 from editmask within w_hpa405a
integer x = 2327
integer y = 92
integer width = 480
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
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
	is_date2 = ''
end if

is_date2	=	string(ldt_pay_date, 'yyyymmdd')

end event

type st_2 from statictext within w_hpa405a
integer x = 2025
integer y = 108
integer width = 302
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
string text = "지급일자"
boolean focusrectangle = false
end type

type st_4 from statictext within w_hpa405a
integer x = 2889
integer y = 76
integer width = 946
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "※ 제출일자와 지급일자를 확인한 후"
boolean focusrectangle = false
end type

type st_5 from statictext within w_hpa405a
integer x = 2889
integer y = 148
integer width = 919
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "   화일을 생성해 주시기 바랍니다."
boolean focusrectangle = false
end type

type uo_year from cuo_year within w_hpa405a
event destroy ( )
integer x = 82
integer y = 92
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_year.destroy
call cuo_year::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_year	=	uf_getyy()

if is_year = '0000' then
	is_year = ''
end if

end event

type st_status from statictext within w_hpa405a
integer x = 64
integer y = 520
integer width = 3749
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "진행 상태..."
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_hpa405a
integer x = 50
integer y = 600
integer width = 3776
integer height = 92
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type gb_3 from groupbox within w_hpa405a
integer y = 240
integer width = 3881
integer height = 188
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "화일 생성"
end type

type gb_4 from groupbox within w_hpa405a
integer y = 440
integer width = 3881
integer height = 288
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "진행상태"
end type

