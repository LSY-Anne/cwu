$PBExportHeader$w_hsu207a.srw
$PBExportComments$[청운대]수강신청(야간->주간,주간->야간 과목)
forward
global type w_hsu207a from w_condition_window
end type
type st_8 from statictext within w_hsu207a
end type
type cb_2 from commandbutton within w_hsu207a
end type
type cb_3 from commandbutton within w_hsu207a
end type
type dw_con from uo_dwfree within w_hsu207a
end type
type st_2 from statictext within w_hsu207a
end type
type uo_1 from uo_imgbtn within w_hsu207a
end type
type dw_main from uo_dwfree within w_hsu207a
end type
type dw_2 from uo_dwfree within w_hsu207a
end type
end forward

global type w_hsu207a from w_condition_window
integer width = 4507
st_8 st_8
cb_2 cb_2
cb_3 cb_3
dw_con dw_con
st_2 st_2
uo_1 uo_1
dw_main dw_main
dw_2 dw_2
end type
global w_hsu207a w_hsu207a

type variables
string 	is_hakbun, is_year, is_hakyun, is_hakgi, is_gwa, is_jungong_id, is_gwamok, is_gaesul_hakyun, is_gaesul_bunban
long		il_hakjum, il_gwamok_seq
end variables

forward prototypes
public subroutine sugangdelete (string p_hakbun, string p_gwamok, long p_gwamok_seq, string p_gaesul_gwa, string p_gaesul_bunban, string p_gaesul_hakyun)
public subroutine sugangsave (string p_hakbun, string p_hakyun, string p_gaesul_hakyun, string p_gaesul_bunabn, string p_gwamok, long p_gwamok_seq, string p_dept_code, string p_gaesul_gwa)
end prototypes

public subroutine sugangdelete (string p_hakbun, string p_gwamok, long p_gwamok_seq, string p_gaesul_gwa, string p_gaesul_bunban, string p_gaesul_hakyun);string		ls_year			//년도
string		ls_hakgi			//학기
long			ll_su_inwon		//수강한인원
string		ls_dr_hakyun

//1. 년도학기 구하기...

select dr_hakyun
into	 :ls_dr_hakyun
from   haksa.jaehak_hakjuk
where  hakbun	=	:p_hakbun ;

	if	ls_dr_hakyun	=	'1'	then
		select	year,	hakgi
		into		:ls_year,	:ls_hakgi
		from		haksa.haksa_iljung
		where		sysdate		between	sugang_1_to and	sugang_1_from
		and		sijum_flag	=	'Y';
	elseif	ls_dr_hakyun	=	'2'	then
		select	year,	hakgi
		into		:ls_year,	:ls_hakgi
		from		haksa.haksa_iljung
		where		sysdate		between	sugang_2_to and	sugang_2_from
		and		sijum_flag	=	'Y';
	elseif	ls_dr_hakyun	=	'3'	then
		select	year,	hakgi
		into		:ls_year,	:ls_hakgi
		from		haksa.haksa_iljung
		where		sysdate		between	sugang_3_to and	sugang_3_from
		and		sijum_flag	=	'Y';
	elseif	ls_dr_hakyun	=	'4'	then
		select	year,	hakgi
		into		:ls_year,	:ls_hakgi
		from		haksa.haksa_iljung
		where		sysdate		between	sugang_4_to and	sugang_4_from
		and		sijum_flag	=	'Y';
	end if;
	
//테스용
ls_year 	= 	'2003'
ls_hakgi	=	'1'

//2. 수강신청 delete....
  	
  	delete	haksa.sugang_trans
  	 where 	hakbun		=	:p_hakbun
  	 and		year 			= 	:ls_year
  	 and 		hakgi  		= 	:ls_hakgi
  	 and 		gwamok_id	=	:p_gwamok
	 and		gwamok_seq	=	:p_gwamok_seq;	
  	   
//-3. 수강신청인원 delete....
	select	su_inwon
	into		:ll_su_inwon
	from		haksa.gaesul_gwamok
	where		year			=	:ls_year
	and		hakgi			=	:ls_hakgi
	and		gwa			=	:p_gaesul_gwa
	and		gwamok_id	=	:p_gwamok
	and		gwamok_seq	=	:p_gwamok_seq
	and		bunban		=	:p_gaesul_bunban
	and		hakyun		=	:p_gaesul_hakyun	;
	
  	update 	haksa.gaesul_gwamok 
  	set 		su_inwon		= (:ll_su_inwon - 1)
  	where		year			=	:ls_year
	and		hakgi			=	:ls_hakgi
	and		gwa			=	:p_gaesul_gwa
	and		gwamok_id	=	:p_gwamok
	and		gwamok_seq	=	:p_gwamok_seq
	and		bunban		=	:p_gaesul_bunban
	and		hakyun		=	:p_gaesul_hakyun	;
 
if		sqlca.sqlcode	=	0	then	      	   
  		messagebox("삭제","삭제 되었읍니다.!!!!")
	  	commit;
		return
else
		messagebox("오류","삭제되지 않았읍니다.!!!!")
		rollback;
		return
end if

end subroutine

public subroutine sugangsave (string p_hakbun, string p_hakyun, string p_gaesul_hakyun, string p_gaesul_bunabn, string p_gwamok, long p_gwamok_seq, string p_dept_code, string p_gaesul_gwa);	string			ls_year
	string			ls_hakgi
	long				ll_count
	long				ll_tot_hakjum
	long				ll_hakjum
	string			ls_gwa
	string			ss_gwa
	long				ll_sum_hakjum
	string			ls_isu_id
	long				ll_inwon
	long				ll_su_inwon
	string			ls_yoil
	string			ls_sigan
	string			ss_yoil
	string			ss_sigan
	string			ls_su_hakyun
	long				ll_seq_count
	long				ll_seq
	long				ll_jae_count
	long				ll_seq_no
	string			ls_juya_gubun
	string			ss_juya_gubun
	string			ls_sangtae
	long				ll_year_tot_hakjum
	string			ss_year
	string			ss_hakgi
	long				ll_ave_pyengjum
	string			ls_member_no
	long				ll_sum_hakjum_30
	
	//1. 년도학기 구하기...----------------------------------------------------------------------
	if	p_hakyun	=	'1'	then
		select	year,	hakgi
		into		:ls_year,	:ls_hakgi
		from		haksa.haksa_iljung
		where		sysdate	between	sugang_1_to and	sugang_1_from
		and		sijum_flag	=	'Y'	;
		
	elseif	p_hakyun	=	'2'	then
		select	year,	hakgi
		into		:ls_year,	:ls_hakgi
		from		haksa.haksa_iljung
		where		sysdate	between	sugang_2_to and	sugang_2_from
		and		sijum_flag	=	'Y'	;
	elseif	p_hakyun	=	'3'	then
		select	year,	hakgi
		into		:ls_year,	:ls_hakgi
		from		haksa.haksa_iljung
		where		sysdate	between	sugang_3_to and	sugang_3_from
		and		sijum_flag	=	'Y'	;
	elseif	p_hakyun	=	'4'	then
		select	year,	hakgi
		into		:ls_year,	:ls_hakgi
		from		haksa.haksa_iljung
		where		sysdate	between	sugang_4_to and	sugang_4_from
		and		sijum_flag	=	'Y'	;
	end if;
	
	//테스트학기위한값
	
	ls_year	=	'2003'
	ls_hakgi	=	'1'

	//2. 재학생, 복학생만 수강신청 가능함...-------------------------------------------------------------
	//2.1 ls_sangtae	<>	'02'	휴학생
	select	juya_gubun, sangtae, su_hakyun,gwa
	into		:ss_juya_gubun, :ls_sangtae, :ls_su_hakyun, :ss_gwa
	from		haksa.jaehak_hakjuk
	where		hakbun		=	:p_hakbun	;	

	if		ls_sangtae	<>	'01' then
			messagebox("오류","재학생만 수강신청 가능합니다...!")
			return;
	end if;
			
	//3. 교과목 중복 check...
	select	count(*)
	into		:ll_count
	from		haksa.sugang_trans
	where		year			=	:ls_year
	and		hakgi			=	:ls_hakgi
	and		hakbun		=	:p_hakbun
	and		gwa			=  :p_gaesul_gwa
	and		gwamok_id	=	:p_gwamok
	and		gwamok_seq	=	:p_gwamok_seq ;

	if		ll_count	>	0	then
			messagebox("오류","이미 수강한 과목 입니다...!")
  			return;
	end if;

	//4. 최대학점 check...
	if		ls_hakgi	=	'1'		or		ls_hakgi	=	'2'		then
			ll_tot_hakjum	=	23													//1,2학기 기본 수강학점 23
	else
			ll_tot_hakjum	=	6													//계절학기는 6학점으로
	end if;

	//4.1 재수강 과목 유무
	if		ls_hakgi	=	'1'		or		ls_hakgi	=	'2'		then
	
			select	count(*)
			into		:ll_jae_count
			from		haksa.sugang_trans
			where		hakbun			=		:p_hakbun
			and		gwamok_id		=		:p_gwamok
			and		gwamok_seq		=   	:p_gwamok_seq
			and		avg_pyengjum	<		4		;
	
			if		ll_jae_count	>	0	then
					ll_tot_hakjum	=	26
			end if
			
	end if
		
	//4.2 수강신청 최대학점 계산
	//4.2.1	직전학기 4.0이상인자 4학점 초과 신청할 수 있음.
	if		ls_hakgi	=	'1'		or		ls_hakgi	=	'2'		then
	
		if		ls_hakgi	=	'1'				then
				ss_year		=	string(long(ls_year)	-	1)
				ss_hakgi		=	'2'
		elseif	ls_hakgi		=	'2'		then
				ss_year		=	ls_year
				ss_hakgi		=	'1'
		end if		

		select 	avg_pyengjum
		into		:ll_ave_pyengjum
		from		haksa.sungjukgye
		where		year		=	:ss_year
		and		hakgi		=	:ss_hakgi
		and		hakbun	=	:p_hakbun	;
	
		if		ll_ave_pyengjum		>	3.99		then
				ll_tot_hakjum	=	27
		end if
		
	end if

	//4.2.2 매년 2학기, 겨울 계절학기 최대 수강학점...
	if		ls_hakgi	=	'2'		or	ls_hakgi	=	'4'		then
			
			ll_year_tot_hakjum	=	42
			
			if		ll_jae_count	>	0	then
					ll_year_tot_hakjum	=	46
			end if
			
			if		ll_ave_pyengjum		>	3.99		then
					ll_year_tot_hakjum	=	48
			end if
					
	end if
	
	//4.3 수강신청한 과목 학점 합계
	
	select	hakjum, gwa, juya_gubun, member_no
	into		:ll_hakjum, :ls_gwa, :ls_juya_gubun, :ls_member_no
	from		haksa.gaesul_gwamok
	where		year						=	:ls_year
	and		hakgi						=	:ls_hakgi
	and		gwa						=	:p_gaesul_gwa
	and		gwamok_id				=	:p_gwamok
	and		gwamok_seq				=  :p_gwamok_seq
	and		nvl(pass_gubun,'N')	not in	('Y')						//선이수
	and		isu_id					not in	('05')		;		   //pass 과목

	select	sum(a.hakjum)
	into		:ll_sum_hakjum
	from		haksa.sugang_trans		a,
				haksa.gaesul_gwamok		b
	where		a.year						=	:ls_year
	and		a.hakgi						=	:ls_hakgi
	and		a.hakbun						=	:p_hakbun
	and		a.year						=	b.year
	and		a.hakgi						=	b.hakgi
	and		a.gwa							=	b.gwa
	and		a.gwamok_id					=	b.gwamok_id
	and		a.gwamok_seq				=  b.gwamok_seq
	and		b.isu_id						not in	('05')					//선이수
	and		nvl(b.pass_gubun,'N')	not in	('Y')		;				//pass 과목
	
	if	ll_tot_hakjum	<	(ll_sum_hakjum + ll_hakjum)	then
		messagebox("오류","최대학점" + string(ll_tot_hakjum) + "학점 초과할 수 없읍니다...!")
  		return;
	end if

	//4.4 2학기, 겨울 계절학기 최대 수강학점 check...
	
	if		ls_hakgi	=	'2'		or	ls_hakgi	=	'4'		then
			
				select	hakjum, gwa, juya_gubun
				into		:ll_hakjum, :ls_gwa, :ls_juya_gubun
				from		haksa.gaesul_gwamok
				where		year						=	:ls_year
				and		hakgi						=	:ls_hakgi
				and		gwa						=	:p_gaesul_gwa
				and		gwamok_id				=	:p_gwamok
				and		gwamok_seq				=  :p_gwamok_seq
				and		nvl(pass_gubun,'N')	not in	('Y')					//선이수
				and		isu_id					not in	('05')		;		//pass 과목

				select	sum(a.hakjum)
				into		:ll_sum_hakjum
				from		haksa.sugang_trans		a,
							haksa.gaesul_gwamok		b
				where		a.year						=	:ls_year
				and		a.hakbun						=	:p_hakbun
				and		a.year						=	b.year
				and		a.hakgi						=	b.hakgi
				and		a.gwa							=	b.gwa
				and		a.gwamok_id					=	b.gwamok_id
				and		a.gwamok_seq				=  b.gwamok_seq
				and		b.isu_id						not in	('05')				//선이수
				and		nvl(b.pass_gubun,'N')	not in	('Y')		;			//pass 과목
				
				if	ll_year_tot_hakjum	<	(ll_sum_hakjum + ll_hakjum)	then
					messagebox("오류","매년 최대학점" + string(ll_year_tot_hakjum) + "학점 초과할 수 없읍니다...!")
  					return;
				end if
	end if

	//5. 상급 수강신청 check...
	select	isu_id
	into		:ls_isu_id
	from		haksa.gaesul_gwamok
	where		year			=	:ls_year
	and		hakgi			=	:ls_hakgi
	and		gwa			=	:p_gaesul_gwa
	and		gwamok_id	=	:p_gwamok
	and		gwamok_seq	=  :p_gwamok_seq	;

	if	ls_isu_id	=	'21'	or	ls_isu_id	=	'22'	then
		if	P_hakyun	<	p_gaesul_hakyun		then
			messagebox("오류","하위학년이 상위학년 전공과목을 신청할 수 없다...!")
  			return;
		end if
	end if
	
	//5.1 선이수 과목 6학점 초과 check...

	if	ls_isu_id	=	'30'	then
		
		select	sum(hakjum)
		into		:ll_sum_hakjum_30
		from		haksa.sugang_trans
		where		year		=	:ls_year
		and		hakgi		=	:ls_hakgi
		and		hakbun	=	:p_hakbun
		and		isu_id	=	'30'	;
		
		if		(ll_sum_hakjum_30 + ll_hakjum) 	>	6	then
				messagebox("오류","선이수 과목 6학점 초과할 수 없읍니다...!")
  				return;
		end if
		
	end if

	//5.2 주전공과목 타학과학생이 신청시는 일반선택으로 이수구분변환

	if	ls_isu_id	=	'03'	or		ls_isu_id	=	'04'	then

		if	ls_gwa	<>	ss_gwa	then     //ls_gwa => 개설학과, ss_gwa => 학생 학적학과
			ls_isu_id	=	'80'
		end if
		
	end if

	//7. 수강인원 check...
	select	inwon,	su_inwon
	into		:ll_inwon,	:ll_su_inwon
	from		haksa.gaesul_gwamok
	where		year			=	:ls_year
	and		hakgi			=	:ls_hakgi
	and		gwamok_id	=	:p_gwamok
	and		gwamok_seq	=  :p_gwamok_seq
	and		bunban		=	:p_gaesul_bunabn	;

	if	ll_inwon	<	(ll_su_inwon + 1)	then
		messagebox("오류","수강과목 인원 초과 입니다...!")
  		return;
	end if
	
	//8. 수강신청 시간 중복 check...
	//8.1 수강한 과목이 1학점 이상이면 수강과목 시간 중복 check... 
	if	ll_sum_hakjum	>	0	then		
	
		declare 	sigan_s cursor for
		
   			select	b.yoil, b.sigan
   			from 		haksa.sugang_trans 	a,
							haksa.siganpyo 		b
  				where 	a.year 		 	= :ls_year
  				and 		a.hakgi		 	= :ls_hakgi
  				and 		a.hakbun	 		= :p_hakbun
  				and     	a.year		 	= b.year
  				and 		a.hakgi		 	= b.hakgi 
  				and     	a.gwamok_id	 	= b.gwamok_id
  				and		a.gwamok_seq 	= b.gwamok_seq
  				order by b.yoil;
	
		open sigan_s;
  		do
  		fetch sigan_s into :ls_yoil, :ls_sigan;
			
			if sqlca.sqlcode <> 0 then exit
			
			declare 	sigan cursor for
  						select 	yoil, sigan
   		  			from 		haksa.siganpyo
  		 				where		year 			=	:ls_year
  		   			and 		hakgi			=	:ls_hakgi
  		   			and 		gwamok_id 	=	:p_gwamok
  		   			and		gwamok_seq	=  :p_gwamok_seq
  		   			order by yoil	;
			open sigan;
  			do
  				fetch 	sigan into :ss_yoil, :ss_sigan;
  				if sqlca.sqlcode <> 0 then exit
  			
  				if ls_yoil = ss_yoil then
  		   			if ls_sigan	=	ss_sigan	then
  		   				messagebox("오류","수강신청할 과목이 수강시간 중복 입니다.!!!!")
							return;
  						end if
  				end if	
			loop while true;
			close sigan;
		loop while true;
		close sigan_s;
end if

//9. 수강신청저장....
insert into haksa.sugang_trans(hakbun, year, su_hakyun, hakgi, gwa, jungong_id, bunban, gwamok_id, gwamok_seq, isu_id, hakjum, member_no)
  		values(:p_hakbun, :ls_year, :p_gaesul_hakyun, :ls_hakgi, :ls_gwa, :ls_gwa, :p_gaesul_bunabn, :p_gwamok, :p_gwamok_seq, :ls_isu_id, :ll_hakjum, :ls_member_no);
  		
select	max(nvl(seq_no,0))	+ 1
into		:ll_seq_no
from		haksa.sugang_his
where		hakbun		=	:p_hakbun
and		year			=	:ls_year
and		hakgi			=	:ls_hakgi
and		gwamok_id	=	:p_gwamok
and		gwamok_seq	=  :p_gwamok_seq		;
  	
insert into haksa.sugang_his(hakbun, seq_no, year, su_hakyun, hakgi, gwa, jungong_id, bunban, gwamok_id, gwamok_seq, isu_id, hakjum, member_no, status)
  		values(:p_hakbun, :ll_seq_no, :ls_year, :p_gaesul_hakyun, :ls_hakgi, :ls_gwa, :ls_gwa, :p_gaesul_bunabn, :p_gwamok, :p_gwamok_seq, :ls_isu_id, :ll_hakjum, :ls_member_no, 'I');

//10. 수강신청인원 증가...

select	nvl(su_inwon,0)
into		:ll_seq_count
from		haksa.gaesul_gwamok
where		year			= :ls_year
and		hakgi			= :ls_hakgi
and		gwamok_id	= :p_gwamok
and		gwamok_seq  = :p_gwamok_seq
and		bunban		= :p_gaesul_bunabn	;
  
if	ll_seq_count = 0 then
  	ll_seq = 1
else	  
   ll_seq = ll_seq_count + 1
end if

update	haksa.gaesul_gwamok 
set		su_inwon		=	:ll_seq
where		year			=	:ls_year
and		hakgi			=	:ls_hakgi
and		gwamok_id	=	:p_gwamok
and		gwamok_seq	=  :p_gwamok_seq
and		bunban		= 	:p_gaesul_bunabn	;

if	sqlca.sqlcode	=	0	then
	messagebox("저장","저장되었읍니다.!!!!")
	commit;
	return;
else
	messagebox("실패","저장되지 않았읍니다.!!!!")
	rollback;
	return;
end if
end subroutine

on w_hsu207a.create
int iCurrent
call super::create
this.st_8=create st_8
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_con=create dw_con
this.st_2=create st_2
this.uo_1=create uo_1
this.dw_main=create dw_main
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_8
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.dw_con
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.dw_main
this.Control[iCurrent+8]=this.dw_2
end on

on w_hsu207a.destroy
call super::destroy
destroy(this.st_8)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_con)
destroy(this.st_2)
destroy(this.uo_1)
destroy(this.dw_main)
destroy(this.dw_2)
end on

event ue_retrieve;string ls_hakbun, ls_gwa_nm, ls_su_hakyun, ls_bunban, ls_juya_gubun, ls_hname, ls_year, ls_hakgi
int 	 li_ans

//조회조건
dw_con.accepttext()

ls_hakbun    =	dw_con.Object.hakbun[1]
ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if	ls_hakbun = "" or isnull(ls_hakbun) then
	uf_messagebox(15)
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return -1
	
elseif	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1
		
elseif	ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
		
end if

select	b.fname, a.su_hakyun, a.ban, decode(a.juya_gubun,'1','주간','야간'), a.hname
into		:ls_gwa_nm, :ls_su_hakyun, :ls_bunban, :ls_juya_gubun, :ls_hname
from		haksa.jaehak_hakjuk	a,
			haksa.gwa_sym			b
where	a.gwa		=	b.gwa
and		a.hakbun	=	:ls_hakbun
USING SQLCA ;

st_2.text	=	"학과 : " + ls_gwa_nm + "     학년 : " + ls_su_hakyun + "     반 : " + ls_bunban + "     주/야 : " + ls_juya_gubun + "     성명 : " + ls_hname

li_ans = dw_2.retrieve(ls_year, ls_hakgi, ls_hakbun)

if li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_2.setfocus()
end if

Return 1
end event

event open;call super::open;string	ls_year,		ls_hakgi

idw_update[1] = dw_2

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

select	next_year,	next_hakgi
into		:ls_year,	:ls_hakgi
from		haksa.haksa_iljung
where		sijum_flag	= 'Y' 
USING SQLCA ;

dw_con.Object.year[1] 	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi

cb_2.enabled	=	false
cb_3.enabled	=	false
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu207a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu207a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu207a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu207a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu207a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu207a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu207a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu207a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu207a
end type

type uc_save from w_condition_window`uc_save within w_hsu207a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu207a
end type

type uc_print from w_condition_window`uc_print within w_hsu207a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu207a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu207a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu207a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu207a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu207a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu207a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu207a
integer taborder = 90
end type

type st_8 from statictext within w_hsu207a
integer x = 50
integer y = 2192
integer width = 4384
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 32500968
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_hsu207a
integer x = 110
integer y = 1284
integer width = 389
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "과목추가"
end type

event clicked;string	ls_errcode, ls_errmsg, ls_status, ls_dept_code
string	ls_year,	ls_hakgi
long		li_ans

dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
elseif	ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
end if

ls_dept_code	= gs_DeptCode

sugangsave(is_hakbun, is_hakyun, is_gaesul_hakyun, is_gaesul_bunban, is_gwamok, il_gwamok_seq, ls_dept_code, is_gwa)

li_ans = dw_2.retrieve(ls_year, ls_hakgi, is_hakbun)

if li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_2.setfocus()
end if
end event

type cb_3 from commandbutton within w_hsu207a
integer x = 571
integer y = 1284
integer width = 389
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "과목삭제"
end type

event clicked;string	ls_errcode, ls_errmsg, ls_status
string	ls_year,	ls_hakgi
long		li_ans

dw_con.accepttext()

is_hakbun    =	dw_con.Object.hakbun[1]
ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
elseif	ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
end if

sugangdelete(is_hakbun, is_gwamok, il_gwamok_seq, is_gwa, is_gaesul_bunban, is_gaesul_hakyun)

li_ans = dw_2.retrieve(ls_year, ls_hakgi, is_hakbun)

if li_ans = -1 then
	uf_messagebox(8)	
	return 1
else
	dw_2.setfocus()
end if
end event

type dw_con from uo_dwfree within w_hsu207a
integer x = 55
integer y = 168
integer width = 4379
integer height = 216
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hsu207a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_2 from statictext within w_hsu207a
integer x = 859
integer y = 188
integer width = 2240
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 32500968
string text = "  "
boolean focusrectangle = false
end type

type uo_1 from uo_imgbtn within w_hsu207a
integer x = 617
integer y = 44
integer width = 498
integer taborder = 80
boolean bringtotop = true
string btnname = "개설과목조회"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_bunban
long		li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	dw_con.Object.gwa[1]
ls_hakyun	=	dw_con.Object.hakyun[1]
ls_bunban   =  dw_con.Object.ban[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
elseif	ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
elseif	ls_gwa = "" or isnull(ls_gwa) then
	uf_messagebox(19)
	dw_con.SetFocus()
	dw_con.SetColumn("gwa")
	return
elseif	ls_hakyun = "" or isnull(ls_hakyun) then
	uf_messagebox(13)
	dw_con.SetFocus()
	dw_con.SetColumn("hakyun")
	return
elseif	ls_bunban = "" or isnull(ls_bunban) then
	uf_messagebox(17)
	dw_con.SetFocus()
	dw_con.SetColumn("ban")
	return
end if

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_bunban)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(20)
	return
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return
else
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
end if
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hsu207a
integer x = 50
integer y = 388
integer width = 4384
integer height = 872
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_hsu200a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;string		ls_dr_hakyun, ls_year

if	row	=	0	then
	return
end if

dw_con.AcceptText()

is_hakbun			=	dw_con.Object.hakbun[1]
is_year				=	dw_con.Object.year[1]
is_gaesul_hakyun	=	dw_con.Object.hakyun[1]
is_gaesul_bunban  =  dw_con.Object.ban[1]
is_hakgi				=	dw_con.Object.hakgi[1]
is_gwa				=	dw_con.Object.gwa[1]
is_gwamok			=	dw_main.getitemstring(row, "gwamok_id_1")
il_gwamok_seq		=	dw_main.getitemnumber(row, "gwamok_seq")
il_hakjum			=	dw_main.getitemnumber(row, "hakjum")

if	is_hakbun = "" or isnull(is_hakbun) then
	uf_messagebox(15)
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return
elseif	is_gaesul_hakyun = "" or isnull(is_gaesul_hakyun) then
	uf_messagebox(13)
	dw_con.SetFocus()
	dw_con.SetColumn("hakyun")
	return
elseif	is_gwa = "" or isnull(is_gwa) then
	uf_messagebox(19)
	dw_con.SetFocus()
	dw_con.SetColumn("gwa")
	return
elseif	is_gaesul_bunban = "" or isnull(is_gaesul_bunban) then
	uf_messagebox(17)
	dw_con.SetFocus()
	dw_con.SetColumn("ban")
	return
end if

select 	dr_hakyun
into		:ls_dr_hakyun
from		haksa.jaehak_hakjuk
where	hakbun	=	:is_hakbun
USING SQLCA ;

is_hakyun	=	ls_dr_hakyun

if		ls_dr_hakyun	=	'1'	then
	
		select	year
		into		:ls_year
		from		haksa.haksa_iljung
		where		to_char(sysdate, 'yyyymmdd') between substr(sugang_1_to,1,8) and substr(sugang_1_from,1,8)
		and		sijum_flag = 'Y' 
		USING SQLCA ;
		
elseif	ls_dr_hakyun	=	'2'	then
		
		select	year
		into		:ls_year
		from		haksa.haksa_iljung
		where		to_char(sysdate, 'yyyymmdd') between substr(sugang_2_to,1,8) and substr(sugang_2_from,1,8)
		and		sijum_flag = 'Y' 
		USING SQLCA ;
		
elseif	ls_dr_hakyun	=	'3'	then
	
		select	year
		into		:ls_year
		from		haksa.haksa_iljung
		where		to_char(sysdate, 'yyyymmdd') between substr(sugang_3_to,1,8) and substr(sugang_3_from,1,8)
		and		sijum_flag = 'Y' 
		USING SQLCA ;
elseif	ls_dr_hakyun	=	'4'	then
		select	year
		into		:ls_year
		from		haksa.haksa_iljung
		where		to_char(sysdate, 'yyyymmdd') between substr(sugang_4_to,1,8) and substr(sugang_4_from,1,8)
		and		sijum_flag = 'Y' 
		USING SQLCA ;
end if

if		ls_year	=	""		or	isnull(ls_year)	then
		messagebox("확인", ls_dr_hakyun	+	"학년 수강신청기간이 맞지 않읍니다.")
		return
end if

cb_2.enabled	=	true
cb_3.enabled	=	false

end event

event constructor;call super::constructor;This.settransobject(sqlca)
end event

type dw_2 from uo_dwfree within w_hsu207a
integer x = 50
integer y = 1388
integer width = 4384
integer height = 792
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hsu200a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.settransobject(sqlca)
end event

event retrieveend;call super::retrieveend;long			ll_count,	ll_sum_hakjum

select		count(*)
into		:ll_count
from		haksa.sugang_trans
where		year		=	:is_year
and			hakgi		=	:is_hakgi
and			hakbun	=	:is_hakbun
USING SQLCA ;


select		sum(hakjum)
into		:ll_sum_hakjum
from		haksa.sugang_trans
where		year		=	:is_year
and			hakgi		=	:is_hakgi
and			hakbun	=	:is_hakbun
USING SQLCA ;


st_8.text	=	"신청과목수 : " + string(ll_count)	+	"     신청학점계 : "	+	string(ll_sum_hakjum)
end event

