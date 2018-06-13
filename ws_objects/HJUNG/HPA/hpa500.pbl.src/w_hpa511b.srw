$PBExportHeader$w_hpa511b.srw
$PBExportComments$강사료 기초자료 생성
forward
global type w_hpa511b from w_msheet
end type
type dw_mast from datawindow within w_hpa511b
end type
type dw_print from datawindow within w_hpa511b
end type
type st_27 from statictext within w_hpa511b
end type
type st_26 from statictext within w_hpa511b
end type
type st_create_cnt2 from statictext within w_hpa511b
end type
type st_err_cnt2 from statictext within w_hpa511b
end type
type st_23 from statictext within w_hpa511b
end type
type st_31 from statictext within w_hpa511b
end type
type uo_end_week from cuo_week within w_hpa511b
end type
type uo_str_week from cuo_week within w_hpa511b
end type
type st_err_cnt1 from statictext within w_hpa511b
end type
type st_create_cnt1 from statictext within w_hpa511b
end type
type st_20 from statictext within w_hpa511b
end type
type st_19 from statictext within w_hpa511b
end type
type rb_3 from radiobutton within w_hpa511b
end type
type rb_2 from radiobutton within w_hpa511b
end type
type rb_1 from radiobutton within w_hpa511b
end type
type uo_gwa from cuo_hakgwa within w_hpa511b
end type
type uo_yy from cuo_yyhakgi within w_hpa511b
end type
type gb_3 from groupbox within w_hpa511b
end type
type st_24 from statictext within w_hpa511b
end type
type st_25 from statictext within w_hpa511b
end type
type gb_1 from groupbox within w_hpa511b
end type
type st_28 from statictext within w_hpa511b
end type
type st_29 from statictext within w_hpa511b
end type
type gb_2 from groupbox within w_hpa511b
end type
type dw_list002 from datawindow within w_hpa511b
end type
type uo_insa from cuo_insa_member_gangsa within w_hpa511b
end type
type st_1 from statictext within w_hpa511b
end type
type pb_create from uo_imgbtn within w_hpa511b
end type
type pb_delete from uo_imgbtn within w_hpa511b
end type
type dw_list001 from uo_dwgrid within w_hpa511b
end type
end forward

global type w_hpa511b from w_msheet
integer height = 2724
string title = "인사기본정보조회"
dw_mast dw_mast
dw_print dw_print
st_27 st_27
st_26 st_26
st_create_cnt2 st_create_cnt2
st_err_cnt2 st_err_cnt2
st_23 st_23
st_31 st_31
uo_end_week uo_end_week
uo_str_week uo_str_week
st_err_cnt1 st_err_cnt1
st_create_cnt1 st_create_cnt1
st_20 st_20
st_19 st_19
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
uo_gwa uo_gwa
uo_yy uo_yy
gb_3 gb_3
st_24 st_24
st_25 st_25
gb_1 gb_1
st_28 st_28
st_29 st_29
gb_2 gb_2
dw_list002 dw_list002
uo_insa uo_insa
st_1 st_1
pb_create pb_create
pb_delete pb_delete
dw_list001 dw_list001
end type
global w_hpa511b w_hpa511b

type variables
DataWindowChild	idwc_DutyCode	//직급코드 DDDW
DataWindowChild	idwc_SalClass	//호봉코드 DDDW
datawindowchild	idw_child

datawindow			idw_errlist, idw_week

//세부사항명들
String				is_SubTitle[] = {'[인사기본정보]',&
											  '[신상정보상세]',&
											  '[가족사항]',&
											  '[학력사항]',&
											  '[경력사항]',&
											  '[자격사항]',&
											  '[포상.징계사항]',&
											  '[해외연수사항]',&
											  '[보직사항]',&
											  '[신상변동이력]'}

string		is_yy, is_hakgi, is_gwa, is_member
integer		ii_str_week, ii_end_week		// 조회 주(F,T)
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
public function integer wf_delete ()
public function integer wf_retrieve_chk (string as_process_gbn)
public subroutine wf_retrieve ()
public function integer wf_create ()
end prototypes

public subroutine wf_setmenubtn (string as_type);// ==========================================================================================
//// 기    능 : 	button control
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 함수원형 : 	wf_setmenubtn(string as_type)
//// 인    수 :	as_type	-	button type
//// 되 돌 림 :
//// 주의사항 :
//// 수정사항 :
//// ==========================================================================================
//
//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN lb_Value = TRUE
//	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
//	
//	CHOOSE CASE li_idx
//		CASE 1;ib_insert   = lb_Value
//		CASE 2;ib_update   = lb_Value
//		CASE 3;ib_delete   = lb_Value
//		CASE 4;ib_retrieve = lb_Value
//		CASE 5;ib_print    = lb_Value
//		CASE 6;ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

public function integer wf_delete ();// ==========================================================================================
// 기    능 : 	data delete
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_delete()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

STRING ls_member_no,ls_name,ls_acct,ls_jikjong,ls_dept,ls_sal
long   ll_duty, ll_bank, ll_cnt,ll_sec,ll_time,ll_count,ll_err
int    li_sisu1,li_sisu2,li_sisu3,li_sisu4, li_bank_code
String ls_acct_no, ls_bojik

long		ll_count2, ll_err2, ll_limit_time
integer	li_week_count, li_month, i, j, li_week
integer	li_str_week, li_end_week
string	ls_message

if wf_retrieve_chk('D') = 100 then	return	100

wf_setmsg('기초자료생성 자료 Check')

if ii_str_week = 0 or ii_end_week = 0 then
	ls_message	=	'삭제시 ' + is_yy + '학년도 ' + is_hakgi + '학기 주별시수내역과 강사료지급내역이 모두 삭제됩니다.~n~n삭제 하시겠습니까?'
else
	ls_message	=	'삭제시 ' + is_yy + '학년도 ' + is_hakgi + '학기 ' + string(ii_str_week) + ' ~~ ' + string(ii_end_week) +	&
						'주 주별시수내역과 강사료지급내역이 모두 삭제됩니다.~n~n삭제 하시겠습니까?'
end if

If MessageBox('확인', ls_message, Exclamation!, OKCancel!, 2) = 1 Then

	wf_setmsg('기초자료생성 자료 삭제 중..')
	
	// 주가 없으면 학기 전체를 삭제한다.
	if ii_str_week = 0 or ii_end_week = 0 then

		// 강사료지급내역 삭제
		delete	from	padb.hpa116t
		where		year			=		:is_yy
		and		hakgi			=		:is_hakgi
		and		member_no	in		(	select	member_no
												from		padb.hpa111m
												where		year			=		:is_yy
												and		hakgi			=		:is_hakgi
												and		gwa			like	:is_gwa	
												and		member_no	like	:is_member	)	;
		
		If sqlca.sqlcode <> 0 Then
			messagebox('강사료지급내역 삭제 오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
			return	sqlca.sqlcode
		End if

		// 월 강사료 시수내역
		delete	from	padb.hpa113t
		where		year			=		:is_yy
		and		hakgi			=		:is_hakgi
		and		member_no	in		(	select	member_no
												from		padb.hpa111m
												where		year			=		:is_yy
												and		hakgi			=		:is_hakgi
												and		gwa			like	:is_gwa	
												and		member_no	like	:is_member	)	;
		
		If sqlca.sqlcode <> 0 Then
			messagebox('월강사료시수내역 삭제오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
			return	sqlca.sqlcode
		End if
		
		// 주별 시수 산출 내역
		delete	from	padb.hpa112t
		where		year				=		:is_yy
		and		hakgi				=		:is_hakgi
		and		member_no		in		(	select	member_no
													from		padb.hpa111m
													where		year			=		:is_yy
													and		hakgi			=		:is_hakgi
													and		gwa			like	:is_gwa	
													and		member_no	like	:is_member	)	;

		If sqlca.sqlcode <> 0 Then
			messagebox('강사주별시수산출내역 삭제오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
			return	sqlca.sqlcode
		End if
	
	// 주가 있으면 선택된 주의 자료만 삭제한다.
	else		
		li_week_count = idw_week.rowcount()
		
		for	i	=	1 to	li_week_count
			li_month		=	idw_week.getitemnumber(i, 'month')
			li_str_week	=	idw_week.getitemnumber(i, 'from_weekend')
			li_end_week	=	idw_week.getitemnumber(i, 'to_weekend')
			
			// 강사료지급내역 삭제
			delete	from	padb.hpa116t
			where		year			=		:is_yy
			and		hakgi			=		:is_hakgi
			and		month			=		:li_month
			and		member_no	in		(	select	member_no
													from		padb.hpa111m
													where		year			=		:is_yy
													and		hakgi			=		:is_hakgi
													and		gwa			like	:is_gwa	
													and		member_no	like	:is_member	)	;
			
			If sqlca.sqlcode <> 0 Then
				messagebox('강사료지급내역 삭제 오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
				return	sqlca.sqlcode
			End if

			// 월 강사료 시수내역
			delete	from	padb.hpa113t
			where		year			=		:is_yy
			and		hakgi			=		:is_hakgi
			and		month			=		:li_month
			and		member_no	in		(	select	member_no
													from		padb.hpa111m
													where		year			=		:is_yy
													and		hakgi			=		:is_hakgi
													and		gwa			like	:is_gwa	
													and		member_no	like	:is_member	)	;
			
			If sqlca.sqlcode <> 0 Then
				messagebox('월강사료시수내역 삭제오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
				return	sqlca.sqlcode
			End if
		next
		
		// 주별 시수 산출 내역
		delete	from	padb.hpa112t
		where		year				=		:is_yy
		and		hakgi				=		:is_hakgi
		and		week_weekend	>=		:ii_str_week
		and		week_weekend	<=		:ii_end_week
		and		member_no		in		(	select	member_no
													from		padb.hpa111m
													where		year			=		:is_yy
													and		hakgi			=		:is_hakgi
													and		gwa			like	:is_gwa	
													and		member_no	like	:is_member	)	;

		If sqlca.sqlcode <> 0 Then
			messagebox('강사주별시수산출내역 삭제오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
			return	sqlca.sqlcode
		End if
	end if

	// 주별시수산출내역의 년도 학기 자료가 없으면 마스터를 삭제하고, 자료가 한건이라도 있으면 삭제할 수 없다.
	select	count(*)
	into		:ll_count
	from		padb.hpa112t
	where		year				=		:is_yy
	and		hakgi				=		:is_hakgi	
	and		member_no		in		(	select	member_no
												from		padb.hpa111m
												where		year			=		:is_yy
												and		hakgi			=		:is_hakgi
												and		gwa			like	:is_gwa	
												and		member_no	like	:is_member	)	;
												
	if sqlca.sqlcode <> 0 then		return	sqlca.sqlcode
	
	if ll_count < 1 then
		delete	from	padb.hpa111m
		where	year			=		:is_yy
		and		hakgi			=		:is_hakgi
		and		member_no	like	:is_member
		and		gwa			like	:is_gwa	;

		if sqlca.sqlcode <> 0 then
			messagebox('강사지급마스터 삭제오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
			return	sqlca.sqlcode
		end if
		
		DELETE FROM PADB.HPA111H
			WHERE YEAR   = :is_yy
				AND HAKGI  = :is_hakgi
				AND MEMBER_NO LIKE :is_member || '%'
				AND MONTH  = (SELECT MONTH FROM PADB.HPA101M 
								  WHERE YEAR  = :is_yy
									 AND HAKGI = :is_HAKGI
									 AND :ii_str_week >= FROM_WEEKEND
									 AND :ii_end_week <= TO_WEEKEND)
				AND GWA LIKE :is_gwa || '%' 
			    USING SQLCA ;
		if sqlca.sqlcode <> 0 then
			messagebox('강사지급내역 삭제오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
			return	sqlca.sqlcode
		end if

		return	0
	else
		f_messagebox('1', '주별시수산출내역에 다른 주의 자료가 ' + string(ll_count) + '건 존재합니다.~n~n기초자료는 삭제할 수 없습니다.!')
		return	100
	end if
else
	return	100
end if

end function

public function integer wf_retrieve_chk (string as_process_gbn);// ==========================================================================================
// 기    능 : 	조건 체크
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve_chk(string as_process_gbn)	return	integer
// 인    수 :	as_process_gbn	-	생성 구분	C : 생성
// 되 돌 림 :	sqlcas.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

wf_setmsg('생성조건 Check')

is_yy     	= 	uo_yy.uf_getyy()
is_hakgi  	= 	uo_yy.uf_gethakgi()
ii_str_week	=	uo_str_week.uf_getweek()
ii_end_week	=	uo_end_week.uf_getweek()

if as_process_gbn	=	'C'	then
	if ii_str_week = 0 or ii_end_week = 0 then
		f_messagebox('1', '생성할 주를 정확히 입력해 주시기 바랍니다.!')
		uo_str_week.em_week.setfocus()
		return	100
	elseif idw_week.retrieve(is_yy, is_hakgi, ii_str_week, ii_end_week) < 1 then
		f_messagebox('1', '강사료지급주가 존재하지 않습니다.~n~n강사료지급주 자료를 먼저 확인하신 후 다시 처리하시기 바랍니다.!')
		return	100
	end if
else
	idw_week.retrieve(is_yy, is_hakgi, ii_str_week, ii_end_week)
end if

If rb_1.Checked Then //전체
	is_gwa    = '%'
	is_member = '%'
ElseIf rb_2.Checked Then //학과
	is_gwa    = uo_gwa.uf_getgwa()
	If isnull(is_gwa) or trim(is_gwa) = '' Then
		f_messagebox('1', '학과를 선택해 주시기 바랍니다.!')
		uo_gwa.SetFocus()
		return	100
	End if
	is_member = '%'
ElseIf rb_3.Checked Then //개인별
	is_gwa    = '%'
	is_member = uo_insa.is_MemberNo
	If isnull(is_member) or trim(is_member) = '' Then
		f_messagebox('1', '담당교수를 선택해 주시기 바랍니다.!')
		uo_insa.sle_kname.SetFocus()
		return	100
	End if
End if

return	0
end function

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

idw_errlist.retrieve(is_yy, is_hakgi, is_gwa, is_member)
dw_print.retrieve(is_yy, is_hakgi, is_gwa, is_member)
end subroutine

public function integer wf_create ();// ==========================================================================================
// 기    능 : 	create
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

STRING ls_member_no,ls_name,ls_acct,ls_jikjong,ls_dept,ls_sal, ls_duty
long   ll_bank, ll_cnt,ll_sec,ll_time,ll_count,ll_err
int    li_d_sisu, li_sisu1,li_sisu2,li_sisu3,li_sisu4, li_bank_code
String ls_acct_no, ls_bojik

long		ll_count2, ll_err2, ll_limit_time
integer	li_week_count, li_month, i, j, li_week
integer	li_str_week, li_end_week, li_sec_code
string	ls_message, ls_old_duty_yn

if wf_retrieve_chk('C') = 100 then	return	100

wf_setmsg('기초자료생성 자료 Check')

SELECT "PADB"."HPA111M"."YEAR"  
  INTO :ll_cnt  
  FROM "PADB"."HPA111M"  
 WHERE ( PADB."HPA111M"."YEAR"      =		:is_yy ) AND  
       ( PADB."HPA111M"."HAKGI"     =		:is_hakgi ) AND  
       ( PADB."HPA111M"."MEMBER_NO" like	:is_member ) AND  
       ( PADB."HPA111M"."GWA" 		like	:is_gwa )	;

If ll_cnt > 0 Then
	
	long		ll_count112t
	
	select	count(*)
	into		:ll_count112t
	from		padb.hpa112t
	where	year				=		:is_yy
	and		hakgi				=		:is_hakgi
	and		week_weekend	>=		:ii_str_week
	and		week_weekend	<=		:ii_end_week
	and		member_no		in		(	select	member_no
												from		padb.hpa111m
												where		year			=		:is_yy
												and		hakgi			=		:is_hakgi
												and		gwa			like	:is_gwa	
												and		member_no	like	:is_member	)	;

	if ll_count112t	>	0	then
		ls_message	=	'생성된 자료가 있습니다.~n~n재생성시 ' + is_yy + '학년도 ' + is_hakgi + '학기 ' +	&
							string(ii_str_week) + ' ~~ ' + string(ii_end_week) + '주~n주별시수내역과 강사료지급내역이 모두 삭제됩니다.~n~n다시 생성 하시겠습니까?'
	else	
		ls_message	=	is_yy + '학년도 ' + is_hakgi + '학기 ' +	&
							string(ii_str_week) + ' ~~ ' + string(ii_end_week) + '주~n주별시수내역과 강사료지급내역을 생성 하시겠습니까?'
	end if


	If MessageBox('확인',ls_message, Exclamation!, OKCancel!, 2) = 1 Then

		wf_setmsg('기초자료생성 자료 삭제 중..')
		
		li_week_count = idw_week.rowcount()
		
		for	i	=	1 to	li_week_count
			li_month		=	idw_week.getitemnumber(i, 'month')
			li_str_week	=	idw_week.getitemnumber(i, 'from_weekend')
			li_end_week	=	idw_week.getitemnumber(i, 'to_weekend')
			
			// 강사료지급내역 삭제
			delete	from	padb.hpa116t
			where		year			=		:is_yy
			and		hakgi			=		:is_hakgi
			and		month			=		:li_month
			and		member_no	in		(	select	member_no
													from		padb.hpa111m
													where		year			=		:is_yy
													and		hakgi			=		:is_hakgi
													and		gwa			like	:is_gwa	
													and		member_no	like	:is_member	)	;
			
			If sqlca.sqlcode <> 0 Then
				messagebox('강사료지급내역 삭제 오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
				return	sqlca.sqlcode
			End if

			// 월 강사료 시수내역
			delete	from	padb.hpa113t
			where		year			=		:is_yy
			and		hakgi			=		:is_hakgi
			and		month			=		:li_month
			and		member_no	in		(	select	member_no
													from		padb.hpa111m
													where		year			=		:is_yy
													and		hakgi			=		:is_hakgi
													and		gwa			like	:is_gwa	
													and		member_no	like	:is_member	)	;
			
			If sqlca.sqlcode <> 0 Then
				messagebox('월강사료시수내역 삭제오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
				return	sqlca.sqlcode
			End if
		next
		
		// 주별 시수 산출 내역
		delete	from	padb.hpa112t
		where		year				=		:is_yy
		and		hakgi				=		:is_hakgi
		and		week_weekend	>=		:ii_str_week
		and		week_weekend	<=		:ii_end_week
		and		member_no		in		(	select	member_no
													from		padb.hpa111m
													where		year			=		:is_yy
													and		hakgi			=		:is_hakgi
													and		gwa			like	:is_gwa	
													and		member_no	like	:is_member	)	;

		If sqlca.sqlcode <> 0 Then
			messagebox('강사주별시수산출내역 삭제오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
			return	sqlca.sqlcode
		End if

		DELETE FROM "PADB"."HPA111M"  
            WHERE ( PADB."HPA111M"."YEAR"      	= 		:is_yy ) AND  
				      ( PADB."HPA111M"."HAKGI"     	= 		:is_hakgi ) AND  
			         ( PADB."HPA111M"."MEMBER_NO" 	like 	:is_member ) AND  
			         ( PADB."HPA111M"."GWA" 			like 	:is_gwa );
		If sqlca.sqlcode <> 0 Then
			messagebox('강사지급마스터 삭제오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
			return	sqlca.sqlcode
		End if
		
		DELETE FROM PADB.HPA111H
				WHERE YEAR = :is_yy
				AND HAKGI  = :is_HAKGI
				AND MEMBER_NO LIKE :is_member || '%'
				AND MONTH  = (SELECT MONTH FROM PADB.HPA101M 
								  WHERE YEAR  = :is_yy
									 AND HAKGI = :is_HAKGI
									 AND :ii_str_week >= FROM_WEEKEND
									 AND :ii_end_week <= TO_WEEKEND)
				AND GWA LIKE :is_gwa || '%' 
			    USING SQLCA ;
				 
      If sqlca.sqlcode <> 0 Then
			messagebox('강사지급내역 삭제오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
			return	sqlca.sqlcode
		End if
	Else
		return	100
	End if
End if

long		ll_mast_count, ll_row

ll_mast_count	=	dw_mast.retrieve(is_yy, is_hakgi, is_member, is_gwa)

ll_count		=	0
ll_count2	=	0
ll_err		=	0
ll_err2		=	0

wf_setmsg('기초자료생성 중..')

for	ll_row = 1	to	ll_mast_count
		ls_member_no	=	dw_mast.getitemstring(ll_row, 'member_no')
		ls_name			=	dw_mast.getitemstring(ll_row, 'kname')
		ls_dept			=	dw_mast.getitemstring(ll_row, 'dept_code')
		ls_duty			=	dw_mast.getitemstring(ll_row, 'duty_code')
		ls_sal			=	dw_mast.getitemstring(ll_row, 'sal_class')
		ls_bojik			=	dw_mast.getitemstring(ll_row, 'bojik_code1')
		li_sisu1			=	dw_mast.getitemnumber(ll_row, 'sisu')
		li_sec_code		=	dw_mast.GetitemNumber(ll_row, 'sec_code')
		ll_time 			=	0
		ll_limit_time	=	0

	ls_jikjong = mid(ls_duty,1,1)
   
	// 책임시수를 구한다.
	SELECT	nvl("PADB"."HPA201M"."RESPONS_TIME", 0),
				nvl("PADB"."HPA201M"."LIMIT_TIME", 0)
	  INTO 	:ll_time, :ll_limit_time
	  FROM 	"PADB"."HPA201M"
	 WHERE 	"PADB"."HPA201M"."RESPONS_GB" 	= '1' AND
			 	"PADB"."HPA201M"."RESPONS_CODE" 	= :ls_bojik;

	If sqlca.sqlcode = 100 Then
		ll_time 			=	0
		ll_limit_time	=	0
	ElseIf sqlca.sqlcode < 0 Then
		messagebox('책임시수 생성 오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
		return	sqlca.sqlcode
	End if
	
	if ll_time < 1 then
		SELECT	nvl("PADB"."HPA201M"."RESPONS_TIME", 0),
					nvl("PADB"."HPA201M"."LIMIT_TIME", 0)
		  INTO	:ll_time, :ll_limit_time
	     FROM 	"PADB"."HPA201M"  
		 WHERE 	"PADB"."HPA201M"."RESPONS_GB" 	= '2' AND
		       	"PADB"."HPA201M"."RESPONS_CODE" 	= :ls_duty;

		If sqlca.sqlcode = 100 Then
			ll_time 			=	0
			ll_limit_time	=	0
		ElseIf sqlca.sqlcode < 0 Then
			messagebox('책임시수 생성 오류', '전산소로 문의하시기 바랍니다.!~n~nsqlca.sqlerrtext')
			return	sqlca.sqlcode
		End if
	end if
	
	If isnull(ls_sal) or len(trim(ls_sal)) < 1 Then ls_sal = ' '
	
	// ==========================================================================================
	// 은행코드와 계좌를 가져온다.
	// ==========================================================================================
	li_bank_code		=	0
	ls_acct_no	=	''
	
	select	nvl(bank_code, 0), 
				nvl(acct_no, ' ')
	into		:li_bank_code, :ls_acct_no
	from		padb.hpa020m a
	where		member_no		=	:ls_member_no
	and		pay_class		=	(	select	max(pay_class)
											from		padb.hpa020m
											where		pay_class	in	(0, 2)
											and		member_no	=	a.member_no	)	;
											
	if sqlca.sqlcode <> 0 then
		li_bank_code		=	0
		ls_acct_no	=	''
	end if
	
	// ==========================================================================================
	
	// ==========================================================================================
	// 강사료마스타 Insert
	// ==========================================================================================
	
	
	INSERT INTO "PADB"."HPA111M"  
             ( "YEAR",             	"HAKGI",          	"MEMBER_NO",   	 "NAME",   "BOJIK_CODE",
               "GWA",        			"JIKJONG_CODE",   	"DUTY_CODE",    	"SEC_CODE",   
               "SAL_CLASS",        	"BANK_CODE",      	"ACCT_NO",      	"NUM_OF_TIME",   
               "NUM_OF_GENERAL",   	"NUM_OF_MIDDLE",  	"NUM_OF_LARGE", 	"NUM_OF_ETC1", 
					"NUM_OF_NIGENERAL", 	"NUM_OF_NIMIDDLE",	"NUM_OF_NILARGE", "NUM_OF_NIETC1", 
					"LIMIT_TIME",   		"HOLIDAY_OPT",   		
               "WORKER",          	"IPADDR",         "WORK_DATE",   
               "JOB_UID",          	"JOB_ADD",        "JOB_DATE" )  
      VALUES ( :is_yy,            :is_hakgi,        :ls_member_no,  :ls_name,		:ls_bojik,
		         :ls_dept,          :ls_jikjong,      :ls_duty,       :li_sec_code,
					:ls_sal,           :li_bank_code,    :ls_acct_no, 	  :ll_time,
					:li_sisu1,         :li_sisu2,        :li_sisu3,      0,
					:li_sisu4,                 0,                0,              0,	
					:ll_limit_time,	'0',					
					:gstru_uid_uname.uid,:gstru_uid_uname.address,sysdate,
					:gstru_uid_uname.uid,:gstru_uid_uname.address,sysdate)	;
					
	If sqlca.sqlcode = 0 Then
		// 담당시수 < 책임시수일 경우 오류처리한다.
		// 
		if ((li_sisu1 + li_sisu2 + li_sisu3 ) < ll_time) 	then
			ll_err	++
		else
			ll_count ++
		end if
	Else
		f_messagebox('3', '[HPA111M INSERT][' + ls_member_no + '] ' + sqlca.sqlerrtext)
		return	sqlca.sqlcode
	End if

	st_create_cnt1.Text 	= string(ll_count, '#,##0')
	st_err_cnt1.Text 		= string(ll_err, '#,##0')

	if sqlca.sqlcode <> 0 then
		f_messagebox('3', '[HPA112T DELETE][' + ls_member_no + '] ' + sqlca.sqlerrtext)
		return	sqlca.sqlcode
	else

		li_week_count = idw_week.rowcount()

		for i	=	1 to	li_week_count
			 li_month		=	idw_week.getitemnumber(i, 'month')
			 li_str_week	=	idw_week.getitemnumber(i, 'from_weekend')
			 li_end_week	=	idw_week.getitemnumber(i, 'to_weekend')
			
			// 월마스타를 생성한다.
			delete	from	padb.hpa111h
			where		year			=	:is_yy
			and		hakgi			=	:is_hakgi
			and		month			=	:li_month
			and		member_no	=	:ls_member_no	;

			if sqlca.sqlcode	<>	0	then
				f_messagebox('3', '[HPA111H DELETE][' + ls_member_no + '] ' + sqlca.sqlerrtext)
				return	sqlca.sqlcode
			end if

			INSERT INTO "PADB"."HPA111H"  
						 ( "YEAR",             	"HAKGI",          	"MONTH",	"MEMBER_NO",   	"NAME",   "BOJIK_CODE",
							"GWA",        			"JIKJONG_CODE",   	"DUTY_CODE",    	"SEC_CODE",   
							"SAL_CLASS",        	"BANK_CODE",      	"ACCT_NO",      	"NUM_OF_TIME",   
							"NUM_OF_GENERAL",   	"NUM_OF_MIDDLE",  	"NUM_OF_LARGE", 	"NUM_OF_ETC1", 
							"NUM_OF_NIGENERAL", 	"NUM_OF_NIMIDDLE",	"NUM_OF_NILARGE", "NUM_OF_NIETC1", 
							"LIMIT_TIME",   		"HOLIDAY_OPT",   		
							"WORKER",          	"IPADDR",         "WORK_DATE",   
							"JOB_UID",          	"JOB_ADD",        "JOB_DATE" )  
				VALUES ( :is_yy,            :is_hakgi,        :li_month, 	:ls_member_no,  :ls_name,		:ls_bojik,
							:ls_dept,          :ls_jikjong,      :ls_duty,     :li_sec_code,
							:ls_sal,           :li_bank_code,    :ls_acct_no, 	:ll_time,
							:li_sisu1,         :li_sisu2,        :li_sisu3,     0,
							0,                 0,                0,             0,	
							:ll_limit_time,	'0',					
							:gstru_uid_uname.uid,:gstru_uid_uname.address,sysdate,
							:gstru_uid_uname.uid,:gstru_uid_uname.address,sysdate)	;

			if sqlca.sqlcode	<>	0	then
				f_messagebox('3', '[HPA111H INSERT][' + ls_member_no + '] ' + sqlca.sqlerrtext)
				return	sqlca.sqlcode
			end if
				if		is_hakgi = '3' or is_hakgi = '4' then
					ll_time = 0;ll_limit_time = 0
				end if
				for	li_week	=	li_str_week	to	li_end_week
					// 주별시수산출내역 생성
						insert	into	padb.hpa112t	
							(	year, hakgi, member_no, week_weekend, month, 
								num_of_time, limit_time,
								num_of_general, num_of_middle, num_of_large, num_of_etc1, 
								num_of_overtime1, num_of_overtime2, num_of_overtime3, num_of_overtime4, 
								worker, ipaddr, work_date, work_gbn,
								job_uid, job_add, job_date	)
								values	
							(	:is_yy, :is_hakgi, :ls_member_no, :li_week, :li_month, 
								:ll_time, :ll_limit_time, 
								:li_sisu1, :li_sisu2, :li_sisu3, 0,
								:li_sisu1 - :ll_time, 0, 0, 0,
								:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate, 'I',
								:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate	)	;
						if	sqlca.sqlcode <> 0 then
							UPDATE	PADB.HPA112T
								SET	num_of_time			=	:ll_time,
										limit_time			=	:ll_limit_time,
										num_of_general	 	=	:li_sisu1,
										num_of_middle		=	:li_sisu2,
										num_of_large		=	:li_sisu3,
										num_of_etc1			=	0,
										num_of_overtime1	=	:li_sisu1 - :ll_time,
										num_of_overtime2	=	0,
										num_of_overtime3	=	0,
										num_of_overtime4	=	0
							WHERE		YEAR				=	:is_yy
							AND		HAKGI				=	:is_hakgi
							AND		MEMBER_NO		=	:ls_member_no
							AND		WEEK_WEEKEND  	= 	:li_week;
						end if

					if sqlca.sqlcode <> 0 then	
						f_messagebox('3', '[HPA112T INSERT][' + ls_member_no + '] ' + sqlca.sqlerrtext)
						return	sqlca.sqlcode
						ll_err2	++
					else
						ll_count2 ++
					end if
					st_create_cnt2.Text 	= string(ll_count2, '#,##0')
					st_err_cnt2.Text 		= string(ll_err2, '#,##0')
				next
		next
	end if
next

If ll_err = 0 and ll_err2 = 0 Then
	return	0
Else
	return	2
End if
end function

on w_hpa511b.create
int iCurrent
call super::create
this.dw_mast=create dw_mast
this.dw_print=create dw_print
this.st_27=create st_27
this.st_26=create st_26
this.st_create_cnt2=create st_create_cnt2
this.st_err_cnt2=create st_err_cnt2
this.st_23=create st_23
this.st_31=create st_31
this.uo_end_week=create uo_end_week
this.uo_str_week=create uo_str_week
this.st_err_cnt1=create st_err_cnt1
this.st_create_cnt1=create st_create_cnt1
this.st_20=create st_20
this.st_19=create st_19
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.uo_gwa=create uo_gwa
this.uo_yy=create uo_yy
this.gb_3=create gb_3
this.st_24=create st_24
this.st_25=create st_25
this.gb_1=create gb_1
this.st_28=create st_28
this.st_29=create st_29
this.gb_2=create gb_2
this.dw_list002=create dw_list002
this.uo_insa=create uo_insa
this.st_1=create st_1
this.pb_create=create pb_create
this.pb_delete=create pb_delete
this.dw_list001=create dw_list001
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mast
this.Control[iCurrent+2]=this.dw_print
this.Control[iCurrent+3]=this.st_27
this.Control[iCurrent+4]=this.st_26
this.Control[iCurrent+5]=this.st_create_cnt2
this.Control[iCurrent+6]=this.st_err_cnt2
this.Control[iCurrent+7]=this.st_23
this.Control[iCurrent+8]=this.st_31
this.Control[iCurrent+9]=this.uo_end_week
this.Control[iCurrent+10]=this.uo_str_week
this.Control[iCurrent+11]=this.st_err_cnt1
this.Control[iCurrent+12]=this.st_create_cnt1
this.Control[iCurrent+13]=this.st_20
this.Control[iCurrent+14]=this.st_19
this.Control[iCurrent+15]=this.rb_3
this.Control[iCurrent+16]=this.rb_2
this.Control[iCurrent+17]=this.rb_1
this.Control[iCurrent+18]=this.uo_gwa
this.Control[iCurrent+19]=this.uo_yy
this.Control[iCurrent+20]=this.gb_3
this.Control[iCurrent+21]=this.st_24
this.Control[iCurrent+22]=this.st_25
this.Control[iCurrent+23]=this.gb_1
this.Control[iCurrent+24]=this.st_28
this.Control[iCurrent+25]=this.st_29
this.Control[iCurrent+26]=this.gb_2
this.Control[iCurrent+27]=this.dw_list002
this.Control[iCurrent+28]=this.uo_insa
this.Control[iCurrent+29]=this.st_1
this.Control[iCurrent+30]=this.pb_create
this.Control[iCurrent+31]=this.pb_delete
this.Control[iCurrent+32]=this.dw_list001
end on

on w_hpa511b.destroy
call super::destroy
destroy(this.dw_mast)
destroy(this.dw_print)
destroy(this.st_27)
destroy(this.st_26)
destroy(this.st_create_cnt2)
destroy(this.st_err_cnt2)
destroy(this.st_23)
destroy(this.st_31)
destroy(this.uo_end_week)
destroy(this.uo_str_week)
destroy(this.st_err_cnt1)
destroy(this.st_create_cnt1)
destroy(this.st_20)
destroy(this.st_19)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.uo_gwa)
destroy(this.uo_yy)
destroy(this.gb_3)
destroy(this.st_24)
destroy(this.st_25)
destroy(this.gb_1)
destroy(this.st_28)
destroy(this.st_29)
destroy(this.gb_2)
destroy(this.dw_list002)
destroy(this.uo_insa)
destroy(this.st_1)
destroy(this.pb_create)
destroy(this.pb_delete)
destroy(this.dw_list001)
end on

event ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_errlist	=	dw_list001
idw_week		=	dw_list002

THIS.TRIGGER EVENT ue_init()

rb_1.triggerevent(clicked!)

uo_yy.triggerevent('ue_itemchange')
end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
//wf_SetMenuBtn('RP')

end event

event ue_retrieve;call super::ue_retrieve;idw_errlist.reset()
if wf_retrieve_chk('')	=	0 then
	wf_retrieve()
end if
return 1

end event

event ue_print;call super::ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 자료출력 처리
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

IF dw_print.RowCount() < 1 THEN	return

OpenWithParm(w_printoption, dw_print)

end event

event ue_button_set;call super::ue_button_set;pb_delete.X		= pb_create.x + pb_create.width + 16
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

type ln_templeft from w_msheet`ln_templeft within w_hpa511b
end type

type ln_tempright from w_msheet`ln_tempright within w_hpa511b
end type

type ln_temptop from w_msheet`ln_temptop within w_hpa511b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hpa511b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hpa511b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hpa511b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hpa511b
end type

type uc_insert from w_msheet`uc_insert within w_hpa511b
end type

type uc_delete from w_msheet`uc_delete within w_hpa511b
end type

type uc_save from w_msheet`uc_save within w_hpa511b
end type

type uc_excel from w_msheet`uc_excel within w_hpa511b
end type

type uc_print from w_msheet`uc_print within w_hpa511b
end type

type st_line1 from w_msheet`st_line1 within w_hpa511b
end type

type st_line2 from w_msheet`st_line2 within w_hpa511b
end type

type st_line3 from w_msheet`st_line3 within w_hpa511b
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hpa511b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hpa511b
end type

type dw_mast from datawindow within w_hpa511b
boolean visible = false
integer x = 805
integer y = 204
integer width = 2555
integer height = 432
integer taborder = 110
string title = "none"
string dataobject = "d_hpa511b_4"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_print from datawindow within w_hpa511b
boolean visible = false
integer x = 754
integer y = 480
integer width = 411
integer height = 432
integer taborder = 110
string title = "none"
string dataobject = "d_hpa511b_3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

this.getchild('sec_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end event

type st_27 from statictext within w_hpa511b
integer x = 2313
integer y = 796
integer width = 347
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "생성건수"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_26 from statictext within w_hpa511b
integer x = 3387
integer y = 796
integer width = 347
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "에러건수"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_create_cnt2 from statictext within w_hpa511b
integer x = 2752
integer y = 796
integer width = 329
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_err_cnt2 from statictext within w_hpa511b
integer x = 3826
integer y = 796
integer width = 329
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777407
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_23 from statictext within w_hpa511b
integer x = 110
integer y = 572
integer width = 1851
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777407
string text = "※ 자료를 생성 후에는 반드시 월 지급 강사료 생성을 하시기 바랍니다."
boolean focusrectangle = false
end type

type st_31 from statictext within w_hpa511b
integer x = 1381
integer y = 200
integer width = 59
integer height = 52
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_end_week from cuo_week within w_hpa511b
integer x = 1426
integer y = 180
integer height = 92
integer taborder = 30
boolean bringtotop = true
end type

event ue_itemchange;call super::ue_itemchange;ii_end_week	=	uf_getweek()

//parent.triggerevent('ue_retrieve')
end event

on uo_end_week.destroy
call cuo_week::destroy
end on

type uo_str_week from cuo_week within w_hpa511b
integer x = 1061
integer y = 180
integer height = 92
integer taborder = 80
boolean bringtotop = true
end type

event ue_itemchange;call super::ue_itemchange;ii_str_week	=	uf_getweek()

if ii_str_week = 0 then
	ii_end_week	=	0
else
	ii_end_week	=	ii_str_week + 3
end if
uo_end_week.em_week.text = string(ii_end_week)

uo_end_week.em_week.setfocus()

//parent.triggerevent('ue_retrieve')
end event

on uo_str_week.destroy
call cuo_week::destroy
end on

type st_err_cnt1 from statictext within w_hpa511b
integer x = 1573
integer y = 796
integer width = 329
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777407
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_create_cnt1 from statictext within w_hpa511b
integer x = 562
integer y = 796
integer width = 329
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_20 from statictext within w_hpa511b
integer x = 1134
integer y = 796
integer width = 347
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "에러건수"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_19 from statictext within w_hpa511b
integer x = 123
integer y = 796
integer width = 347
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "생성건수"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_3 from radiobutton within w_hpa511b
integer x = 3461
integer y = 196
integer width = 347
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "개인별"
end type

event clicked;uo_gwa.uf_enable(false)
uo_insa.trigger event ue_enbled(true)
uo_insa.sle_kname.setfocus()
end event

type rb_2 from radiobutton within w_hpa511b
integer x = 3177
integer y = 196
integer width = 270
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "학과"
end type

event clicked;uo_gwa.uf_enable(true)
uo_gwa.dw_daehak.setfocus()
uo_insa.trigger event ue_enbled(false)

end event

type rb_1 from radiobutton within w_hpa511b
integer x = 2894
integer y = 196
integer width = 270
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "전체"
boolean checked = true
end type

event clicked;//uo_gwa.Enabled  = False
uo_gwa.uf_enable(false)
uo_insa.trigger event ue_enbled(false)
end event

type uo_gwa from cuo_hakgwa within w_hpa511b
event destroy ( )
integer x = 1746
integer y = 176
integer width = 2135
integer height = 100
integer taborder = 40
end type

on uo_gwa.destroy
call cuo_hakgwa::destroy
end on

type uo_yy from cuo_yyhakgi within w_hpa511b
event destroy ( )
integer x = 59
integer y = 176
integer width = 1298
integer height = 96
integer taborder = 10
boolean border = false
end type

on uo_yy.destroy
call cuo_yyhakgi::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yy     = this.uf_getyy()
is_hakgi  = this.uf_gethakgi()

integer	li_month

//li_month	=	integer(mid(f_today(), 5, 2))
//IF li_month < 8 then
//	is_hakgi = '1'
//	uo_yy.em_hakgi.text ='1'
//else 
//	is_hakgi ='2'
//	uo_yy.em_hakgi.text ='2'
//end if
//
//select	from_weekend, to_weekend
//into		:ii_str_week, :ii_end_week
//from		padb.hpa101m
//where		year		=	:is_yy
//and		hakgi	=	:is_hakgi
//and		month	=	:li_month	;
//
//if sqlca.sqlcode	<> 0	then
//	ii_str_week	=	0
//	ii_end_week	=	0
//end if

uo_str_week.em_week.text	=	string(ii_str_week)
uo_end_week.em_week.text	=	string(ii_end_week)


end event

type gb_3 from groupbox within w_hpa511b
integer x = 50
integer y = 476
integer width = 4393
integer height = 208
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
end type

type st_24 from statictext within w_hpa511b
integer x = 512
integer y = 776
integer width = 430
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_25 from statictext within w_hpa511b
integer x = 1522
integer y = 776
integer width = 430
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hpa511b
integer x = 55
integer y = 700
integer width = 2185
integer height = 208
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "강사기초자료 생성건수"
end type

type st_28 from statictext within w_hpa511b
integer x = 2702
integer y = 776
integer width = 430
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_29 from statictext within w_hpa511b
integer x = 3776
integer y = 776
integer width = 430
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_hpa511b
integer x = 2249
integer y = 700
integer width = 2194
integer height = 208
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "주별시수자료 생성건수"
end type

type dw_list002 from datawindow within w_hpa511b
boolean visible = false
integer x = 247
integer y = 236
integer width = 2862
integer height = 280
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa511b_1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type uo_insa from cuo_insa_member_gangsa within w_hpa511b
integer x = 50
integer y = 296
integer width = 4393
integer height = 172
integer taborder = 110
boolean bringtotop = true
end type

on uo_insa.destroy
call cuo_insa_member_gangsa::destroy
end on

type st_1 from statictext within w_hpa511b
integer x = 50
integer y = 164
integer width = 4393
integer height = 124
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_create from uo_imgbtn within w_hpa511b
integer x = 2853
integer y = 552
integer taborder = 120
boolean bringtotop = true
string btnname = "생성처리"
end type

event clicked;call super::clicked;integer	li_rtn

li_rtn	=	wf_create()
idw_errlist.reset()

if li_rtn	=	0	then
	commit using sqlca ;
	wf_setmsg('기초자료생성 완료')
	f_messagebox('1', '생성을 완료했습니다.!')
	wf_retrieve()
elseif li_rtn	=	2	then
	commit using sqlca ;
	wf_setmsg('기초자료오류 발생')
	f_messagebox('1', st_err_cnt1.text + '건의 오류가 발생했습니다.~n~n오류 내용을 참조하시기 바랍니다.!')
	wf_retrieve()
elseif li_rtn	=	100	then
	Rollback using sqlca ;
	wf_setmsg('')
else
	Rollback using sqlca ;
	wf_setmsg('')
	f_messagebox('3', '생성을 실패했습니다. 전산소에 문의하시기 바랍니다.!~n~n' + sqlca.sqlerrtext)
end if


end event

on pb_create.destroy
call uo_imgbtn::destroy
end on

type pb_delete from uo_imgbtn within w_hpa511b
integer x = 3177
integer y = 552
integer taborder = 130
boolean bringtotop = true
string btnname = "삭제처리"
end type

event clicked;call super::clicked;integer	li_rtn

idw_errlist.reset()

li_rtn	=	wf_delete()

if li_rtn	=	0	then
	commit using sqlca ;
	wf_setmsg('자료삭제 완료')
	f_messagebox('1', '삭제를 완료했습니다.!')
	wf_retrieve()
elseif li_rtn	=	100	then
	Rollback using sqlca ;
	wf_setmsg('')
else
	Rollback using sqlca ;
	wf_setmsg('')
	f_messagebox('3', '삭제를 실패했습니다. 전산소에 문의하시기 바랍니다.!~n~n')
end if


end event

on pb_delete.destroy
call uo_imgbtn::destroy
end on

type dw_list001 from uo_dwgrid within w_hpa511b
integer x = 55
integer y = 916
integer width = 4384
integer height = 1388
integer taborder = 80
boolean titlebar = true
string title = "생성 오류 내역"
string dataobject = "d_hpa511b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;settransobject(sqlca)



this.getchild('sec_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end event

event retrieveend;call super::retrieveend;//selectrow(0, false)
//selectrow(1, true)
//
this.title	=	is_yy + '년도 ' + is_hakgi + '학기 생성 오류 내역'
end event

