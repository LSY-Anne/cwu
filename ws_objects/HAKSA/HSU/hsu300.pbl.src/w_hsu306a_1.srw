$PBExportHeader$w_hsu306a_1.srw
$PBExportComments$[청운대]보관용 성적수정(졸업생)
forward
global type w_hsu306a_1 from w_condition_window
end type
type dw_2 from datawindow within w_hsu306a_1
end type
type gb_3 from uo_main_groupbox within w_hsu306a_1
end type
type st_name from statictext within w_hsu306a_1
end type
type dw_con from uo_dwfree within w_hsu306a_1
end type
end forward

global type w_hsu306a_1 from w_condition_window
integer width = 4507
dw_2 dw_2
gb_3 gb_3
st_name st_name
dw_con dw_con
end type
global w_hsu306a_1 w_hsu306a_1

type variables
string is_isu = 'N'
end variables

on w_hsu306a_1.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_3=create gb_3
this.st_name=create st_name
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.st_name
this.Control[iCurrent+4]=this.dw_con
end on

on w_hsu306a_1.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_3)
destroy(this.st_name)
destroy(this.dw_con)
end on

event ue_save;long 		li_ans, ll_cnt, ll_count, ll_jumsu_1, ll_jumsu_2, ll_jumsu_3, ll_jumsu_4, ll_jumsu, ll_hakjum
long		ll_sum_hakjum, ll_chidk_hakjum, ll_sum_jumsu, ll_gwamok_seq
double	ll_pyengjum,	ll_sum_pyengjum,	ll_avg_pyengjum,	ll_avg_jumsu
string	ls_gwamok_id, ls_hwansan_jumsu, ls_year, ls_hakgi, ls_hakbun, ls_new_gwamok, ls_new_gwamok_id, ls_new_gwamok_seq
string	ls_gwa,	ls_hakyun, ls_new_gwa, ls_new_hakyun, ls_isu_id
string	ls_pass_gubun, ls_new_pass_gubun
long		l_inwon,       l_inwon1
string   ls_bunban,     ls_ban,      ls_each_yn

li_ans 	= dw_2.update()

ll_count	= dw_2.rowcount()

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  dw_con.Object.hakbun[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1
		
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
		
elseif ls_hakbun = "" or isnull(ls_hakbun) then
	uf_messagebox(15)
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return -1
		
end if

for	ll_cnt	=	1		to		ll_count

		ls_new_gwamok		=	dw_2.getitemstring(ll_cnt, "gwamok")
		ls_gwamok_id		=	dw_2.getitemstring(ll_cnt, "gwamok_id")
		ll_gwamok_seq		=	dw_2.getitemnumber(ll_cnt, "gwamok_seq")
		ls_isu_id			=	dw_2.getitemstring(ll_cnt, "sugang_trans_isu_id")		
		ll_jumsu_1			=	dw_2.getitemnumber(ll_cnt, "jumsu_1")
		ll_jumsu_2			=	dw_2.getitemnumber(ll_cnt, "jumsu_2")
		ll_jumsu_3			=	dw_2.getitemnumber(ll_cnt, "jumsu_3")
		ll_jumsu_4			=	dw_2.getitemnumber(ll_cnt, "jumsu_4")
		ll_jumsu				=	dw_2.getitemnumber(ll_cnt, "jumsu")
		ls_hwansan_jumsu	=	dw_2.getitemstring(ll_cnt, "hwansan_jumsu")
		ll_pyengjum			=	dw_2.GetItemDecimal(ll_cnt, "pyengjum")
		ll_hakjum			=	dw_2.getitemnumber(ll_cnt, "hakjum")
		ls_gwa				=	dw_2.getitemstring(ll_cnt, "gaesul_gwamok_gwa")
		ls_hakyun			=	dw_2.getitemstring(ll_cnt, "gaesul_gwamok_hakyun")
		ls_ban            =  dw_2.getitemstring(ll_cnt, "sugang_trans_ban")
		ls_bunban         =  dw_2.getitemstring(ll_cnt, "sugang_trans_bunban")
		ls_each_yn        =  dw_2.getitemstring(ll_cnt, "tmt_each_yn")

		// 과목이 바뀌는경우..
		ls_new_gwamok_id	=	mid(ls_new_gwamok, 1, 7)
		ls_new_gwamok_seq	=	trim(mid(ls_new_gwamok, 8, 1))
		
		SELECT 	A.PASS_GUBUN
		INTO		:ls_pass_gubun
		FROM 		HAKSA.GAESUL_GWAMOK A
		WHERE		A.YEAR			=	:ls_year
		AND		A.HAKGI			=	:ls_hakgi
		AND		A.GWAMOK_ID		=	:ls_gwamok_id
		AND		A.GWAMOK_SEQ	=	:ll_gwamok_seq
		AND		A.ISU_ID			=	:ls_isu_id
		USING SQLCA ;


		/* 토마토 추가부분 */
		/* 수강기준인원 */
		SELECT nvl(relation1, 0)
		  INTO :l_inwon
		  FROM haksa.TMT_CODE
		 WHERE large_div    = 'SUH03'
			AND small_div    = '02' 
		 USING SQLCA ;
		IF sqlca.sqlnrows   = 0 THEN
			l_inwon          = 0
		END IF

      SELECT nvl(count(*), 0)
		  INTO :l_inwon1
		  FROM haksa.sugang_trans
		 WHERE year        = :ls_year
		   AND hakgi       = :ls_hakgi
			AND gwa         = :ls_gwa
			AND hakyun      = :ls_hakyun
			AND ban         = :ls_ban
			AND gwamok_id   = :ls_gwamok_id
		   AND gwamok_seq  = :ll_gwamok_seq
			AND bunban      = :ls_bunban
			AND (SUNGJUK_INJUNG = 'Y' OR HWANSAN_JUMSU = 'W')
			USING SQLCA ;

      IF ls_each_yn        = 'Y' AND l_inwon1 >= l_inwon THEN
		elseif ls_pass_gubun = 'Y' then
			if ls_hwansan_jumsu = 'P' OR ls_hwansan_jumsu ='F' then
			else
			messagebox("확인","패스과목은 P 또는 F 만 넣을수 있습니다.")
			rollback USING SQLCA ;
			return -1
			end if 
		end if				

		update	haksa.jolup_sugang
		set		jumsu_1			=	:ll_jumsu_1,
					jumsu_2			=	:ll_jumsu_2,
					jumsu_3			= 	:ll_jumsu_3,
					jumsu_4			=	:ll_jumsu_4,
					jumsu				=	:ll_jumsu,
					hwansan_jumsu	=	:ls_hwansan_jumsu,
					pyengjum			=	:ll_pyengjum,
					isu_id			=	:ls_isu_id
		where		year			=	:ls_year
		and		hakgi			=	:ls_hakgi
		and		hakbun		=	:ls_hakbun
		and		gwamok_id	=	:ls_gwamok_id
		and		gwamok_seq	=	:ll_gwamok_seq 
		USING SQLCA ;
		
		dw_2.setitem(ll_cnt, "gwamok_id", ls_new_gwamok_id )	
		dw_2.setitem(ll_cnt, "gwamok_seq", ls_new_gwamok_seq)
		
//		select	gwa,
//					hakyun
//		into		:ls_new_gwa,
//					:ls_new_hakyun
//		from		haksa.GAESUL_GWAMOK
//		where		year			=	:ls_year
//		and		hakgi			=	:ls_hakgi
//		and		gwa			= 	:ls_gwa
//		and		hakyun		=	:ls_hakyun
//		and		gwamok_id	=	:ls_new_gwamok_id
//		and		gwamok_seq	=	:ls_new_gwamok_seq ;
//
//		dw_2.setitem(ll_cnt, "sugang_trans_gwa", ls_new_gwa )	
//		dw_2.setitem(ll_cnt, "sugang_trans_hakyun", ls_new_hakyun)
		
		li_ans 	= dw_2.update()
		
		SELECT 	A.PASS_GUBUN
		INTO		:ls_new_pass_gubun
		FROM 		HAKSA.GAESUL_GWAMOK A
		WHERE		A.YEAR			=	:ls_year
		AND		A.HAKGI			=	:ls_hakgi
		AND		A.GWAMOK_ID		=	:ls_gwamok_id
		AND		A.GWAMOK_SEQ	=	:ll_gwamok_seq
		AND		A.ISU_ID			=	:ls_isu_id
		USING SQLCA ;


      IF ls_each_yn        = 'Y' AND l_inwon1 >= l_inwon THEN
		elseif ls_new_pass_gubun = 'Y' then
			if ls_hwansan_jumsu = 'P' OR ls_hwansan_jumsu ='F' then
			else
			messagebox("확인","패스과목은 대문자 P 또는 F 만 넣을수 있습니다.")
			rollback USING SQLCA ;
			return -1
			end if 
		end if			

		update	haksa.jolup_sugang
		set		gwamok_id		= 	:ls_new_gwamok_id,
					gwamok_seq		=	:ls_new_gwamok_seq
		where		year				=	:ls_year
		and		hakgi				=	:ls_hakgi
		and		hakbun			=	:ls_hakbun
		and		gwamok_id		=	:ls_gwamok_id
		and		gwamok_seq		=	:ll_gwamok_seq 
		USING SQLCA ;
				
		if sqlca.sqlcode <> 0 then
			messagebox("확인","변경중 오류발생~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
			return -1
		end if
	
		if ls_new_pass_gubun = 'Y' or ls_pass_gubun = 'Y' or ls_hwansan_jumsu = 'P' or ls_hwansan_jumsu = 'W' then
		else
			ll_sum_hakjum	=	ll_sum_hakjum	+	ll_hakjum								//신청학점
		end if	
	
//		if	ll_jumsu	> 59 or ls_hwansan_jumsu = 'P' then
      if isnull(ll_pyengjum) THEN
			ll_pyengjum = 0
		END IF
      if	ll_pyengjum	> 0 or ls_hwansan_jumsu = 'P' then
				ll_chidk_hakjum	=	ll_chidk_hakjum	+	ll_hakjum				//취득학점
		end if
			
		if ls_new_pass_gubun = 'Y' or ls_pass_gubun = 'Y' or ls_hwansan_jumsu = 'P' or ls_hwansan_jumsu = 'W' then
		else
		ll_sum_pyengjum	=	ll_sum_pyengjum	+	( ll_pyengjum	* ll_hakjum)			//평점계
	
		ll_sum_jumsu		=	round((ll_sum_jumsu	+	(ll_jumsu	*	ll_hakjum)), 2)	//총점
		end if

next
	
	ll_avg_pyengjum	=	round((ll_sum_pyengjum	/	ll_sum_hakjum), 2)
	ll_avg_jumsu		=	round((ll_sum_jumsu	/	ll_sum_hakjum), 2)
	
	update	haksa.jolup_sungjukgye
	set		chidk_hakjum		=	:ll_chidk_hakjum,
				total_pyengjum		=	:ll_sum_pyengjum,
				avg_pyengjum		=	:ll_avg_pyengjum,
				total_siljum		=	:ll_sum_jumsu,
				avg_siljum			=	:ll_avg_jumsu
	where		year			=	:ls_year
	and		hakgi			=	:ls_hakgi
	and		hakbun		=	:ls_hakbun
	USING SQLCA ;

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback USING SQLCA ;
else	
	commit USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if
end event

event open;call super::open;//idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

st_name.setPosition(totop!)
end event

event ue_retrieve;string	ls_year, ls_hakgi, ls_hakbun, ls_hname, ls_gwa_nm, ls_su_hakyun
long		li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun    =  dw_con.Object.hakbun[1]

if	ls_year = "" or isnull(ls_year) then
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	uf_messagebox(12)
	return -1
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	uf_messagebox(14)
	return -1
elseif ls_hakbun = "" or isnull(ls_hakbun) then
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	uf_messagebox(15)
	return -1
end if

//학적조회
select	b.fname,
			a.su_hakyun,
			a.hname
into		:ls_gwa_nm,
			:ls_su_hakyun,
			:ls_hname
from		haksa.JOLUP_HAKJUK	a,
			haksa.gwa_sym			b
where		a.gwa		=	b.gwa
and		a.hakbun	=	:ls_hakbun 
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("확인","존재하지 않는 학번입니다.")
	return -1
	dw_con.Object.hakbun[1] = ''
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")

end if

st_name.text	=	ls_hname + '   ' + ls_gwa_nm + '   '

li_ans	=	dw_2.retrieve(ls_year,	ls_hakgi, ls_hakbun)

if li_ans = 0 then
	dw_2.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return -1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return -1
else
	dw_2.setfocus()
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu306a_1
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu306a_1
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu306a_1
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu306a_1
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu306a_1
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu306a_1
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu306a_1
end type

type uc_insert from w_condition_window`uc_insert within w_hsu306a_1
end type

type uc_delete from w_condition_window`uc_delete within w_hsu306a_1
end type

type uc_save from w_condition_window`uc_save within w_hsu306a_1
end type

type uc_excel from w_condition_window`uc_excel within w_hsu306a_1
end type

type uc_print from w_condition_window`uc_print within w_hsu306a_1
end type

type st_line1 from w_condition_window`st_line1 within w_hsu306a_1
end type

type st_line2 from w_condition_window`st_line2 within w_hsu306a_1
end type

type st_line3 from w_condition_window`st_line3 within w_hsu306a_1
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu306a_1
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu306a_1
end type

type gb_1 from w_condition_window`gb_1 within w_hsu306a_1
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu306a_1
integer taborder = 90
end type

type dw_2 from datawindow within w_hsu306a_1
integer x = 55
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hsu300a_6_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;long		ll_jumsu_1, ll_jumsu_2, ll_jumsu_3, ll_jumsu_4, ll_jumsu_5, ll_jumsu_tot, ll_hakjum
double   ld_pyengjum
string	ls_hwansan_jumsu, ls_jogi

dw_2.Accepttext()

CHOOSE CASE dwo.name
   CASE 'hwansan_jumsu'
		IF is_isu          = 'Y' THEN
			IF data         = 'A+' THEN
				ld_pyengjum  = 4.5
			ELSEIF data     = 'A'  THEN
				ld_pyengjum  = 4.0
			ELSEIF data     = 'B+' THEN
				ld_pyengjum  = 3.5
			ELSEIF data     = 'B'  THEN
				ld_pyengjum  = 3.0
			ELSEIF data     = 'C+'  THEN
				ld_pyengjum  = 2.5
			ELSEIF data     = 'C'  THEN
				ld_pyengjum  = 2.0
			ELSEIF data     = 'D+'  THEN
				ld_pyengjum  = 1.5
			ELSEIF data     = 'D'  THEN
				ld_pyengjum  = 1.0
			ELSEIF data     = 'F'  THEN
				ld_pyengjum  = 0.0
			END IF
			dw_2.setitem(row, "pyengjum", ld_pyengjum)
		END IF		
	CASE 'jumsu_1', 'jumsu_2', 'jumsu_3', 'jumsu_4', 'jumsu_5'
		
		ll_jumsu_1		=	dw_2.getitemnumber(row, "jumsu_1")
		ll_jumsu_2		=	dw_2.getitemnumber(row, "jumsu_2")
		ll_jumsu_3		=	dw_2.getitemnumber(row, "jumsu_3")
		ll_jumsu_4		=	dw_2.getitemnumber(row, "jumsu_4")
		ll_jumsu_5		=	dw_2.getitemnumber(row, "jumsu_5")
		ll_hakjum		=	dw_2.getitemnumber(row, "hakjum")		
		
		if isnull(ll_jumsu_1) then	ll_jumsu_1 = 0
		if isnull(ll_jumsu_2) then	ll_jumsu_2 = 0
		if isnull(ll_jumsu_3) then	ll_jumsu_3 = 0
		if isnull(ll_jumsu_4) then	ll_jumsu_4 = 0
		if isnull(ll_jumsu_5) then	ll_jumsu_5 = 0		
		
		ll_jumsu_tot	=	ll_jumsu_1	+	ll_jumsu_2	+	ll_jumsu_3	+	ll_jumsu_4 +	ll_jumsu_5
		
		
		//조기시험자 check
		ls_jogi = this.object.sugang_trans_jogi_yn[row]
		
		if ls_jogi = 'Y' then
			if ll_jumsu_tot >= 95 then
				messagebox("오류","조기시험자 또는 추가시험자는 94점을 초과할 수 없습니다.")
				setnull(ll_jumsu_1)
				this.object.jumsu_1[row] = ll_jumsu_1
				this.object.jumsu_2[row] = ll_jumsu_1
				this.object.jumsu_3[row] = ll_jumsu_1
				this.object.jumsu_4[row] = ll_jumsu_1
				this.object.jumsu_5[row] = ll_jumsu_1
				return 1
			end if
		end if
		
		if	ll_jumsu_tot > 100 then
			messagebox("오류","총점이 100점을 초과할 수 없습니다.")
			setnull(ll_jumsu_1)
			this.object.jumsu_1[row] = ll_jumsu_1
			this.object.jumsu_2[row] = ll_jumsu_1
			this.object.jumsu_3[row] = ll_jumsu_1
			this.object.jumsu_4[row] = ll_jumsu_1
			this.object.jumsu_5[row] = ll_jumsu_1
			return 1
		ELSEIF is_isu    <> 'Y' THEN
			if	ll_jumsu_tot	>	94		and	ll_jumsu_tot	<=	100	then
				if	ll_jumsu_4	=	0	then
					ls_hwansan_jumsu	=	'F'
					ld_pyengjum			=	0.0
				else
					ls_hwansan_jumsu	=	'A+'
					ld_pyengjum			=	4.5
				end if
			elseif	ll_jumsu_tot	>	89		and	ll_jumsu_tot	<	95	then
				if	ll_jumsu_4	=	0	then
					ls_hwansan_jumsu	=	'F'
					ld_pyengjum			=	0.0
				else
					ls_hwansan_jumsu	=	'A'
					ld_pyengjum			=	4.0
				end if
			elseif	ll_jumsu_tot	>	84		and	ll_jumsu_tot	<	90	then
				if	ll_jumsu_4	=	0	then
					ls_hwansan_jumsu	=	'F'
					ld_pyengjum			=	0.0
				else
					ls_hwansan_jumsu	=	'B+'
					ld_pyengjum			=	3.5
				end if
			elseif	ll_jumsu_tot	>	79		and	ll_jumsu_tot	<	85	then
				if	ll_jumsu_4	=	0	then
					ls_hwansan_jumsu	=	'F'
					ld_pyengjum			=	0.0
				else
					ls_hwansan_jumsu	=	'B'
					ld_pyengjum			=	3.0
				end if
			elseif	ll_jumsu_tot	>	74		and	ll_jumsu_tot	<	80	then
				if	ll_jumsu_4	=	0	then
					ls_hwansan_jumsu	=	'F'
					ld_pyengjum			=	0.0
				else
					ls_hwansan_jumsu	=	'C+'
					ld_pyengjum			=	2.5
				end if
			elseif	ll_jumsu_tot	>	69		and	ll_jumsu_tot	<	75	then
				if	ll_jumsu_4	=	0	then
					ls_hwansan_jumsu	=	'F'
					ld_pyengjum			=	0.0
				else
					ls_hwansan_jumsu	=	'C'
					ld_pyengjum			=	2.0
				end if
			elseif	ll_jumsu_tot	>	64		and	ll_jumsu_tot	<	70	then
				if	ll_jumsu_4	=	0	then
					ls_hwansan_jumsu	=	'F'
					ld_pyengjum			=	0.0
				else
					ls_hwansan_jumsu	=	'D+'
					ld_pyengjum			=	1.5
				end if
			elseif	ll_jumsu_tot	>	59		and	ll_jumsu_tot	<	65	then
				if	ll_jumsu_4	=	0	then
					ls_hwansan_jumsu	=	'F'
					ld_pyengjum			=	0.0
				else
					ls_hwansan_jumsu	=	'D'
					ld_pyengjum			=	1.0
				end if
			elseif	ll_jumsu_tot	<	60	then
				if	ll_jumsu_4	=	0	then
					ls_hwansan_jumsu	=	'F'
					ld_pyengjum			=	0.0
				else
					ls_hwansan_jumsu	=	'F'
					ld_pyengjum			=	0.0
				end if
			end if
		END IF
		
		dw_2.setitem(row, "jumsu", ll_jumsu_tot)	
		dw_2.setitem(row, "hwansan_jumsu", ls_hwansan_jumsu)
		dw_2.setitem(row, "pyengjum", ld_pyengjum)
	
END CHOOSE


end event

event constructor;dw_2.settransobject(sqlca)
end event

event clicked;string	ls_pass_gubun,	ls_new_pass_gubun ,ls_year, ls_hakgi
string	ls_new_gwamok,	ls_gwamok_id,	ls_new_gwamok_seq,ls_isu_id,	ls_new_gwamok_id, ls_hwansan_jumsu
long		ll_gwamok_seq, l_inwon,       l_inwon1
string   ls_hakyun,     ls_bunban,     ls_ban,      ls_gwa,    ls_each_yn

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if dwo.name = 'hwansan_jumsu' then
		ls_new_gwamok		=	dw_2.getitemstring(row, "gwamok")
		ls_gwamok_id		=	dw_2.getitemstring(row, "gwamok_id")
		ll_gwamok_seq		=	dw_2.getitemnumber(row, "gwamok_seq")
		ls_isu_id			=	dw_2.getitemstring(row, "sugang_trans_isu_id")
		ls_hwansan_jumsu	=	dw_2.getitemstring(row, "hwansan_jumsu")	
		ls_gwa            = dw_2.getitemstring(row, "sugang_trans_gwa")
		ls_hakyun         = dw_2.getitemstring(row, "sugang_trans_hakyun")
		ls_ban            = dw_2.getitemstring(row, "sugang_trans_ban")
		ls_bunban         = dw_2.getitemstring(row, "sugang_trans_bunban")
		ls_each_yn        = dw_2.getitemstring(row, "tmt_each_yn")

		// 과목이 바뀌는경우..
		ls_new_gwamok_id	=	mid(ls_new_gwamok, 1, 7)
		ls_new_gwamok_seq	=	trim(mid(ls_new_gwamok, 8, 1))
		
		SELECT 	A.PASS_GUBUN
		INTO		:ls_pass_gubun
		FROM 		HAKSA.GAESUL_GWAMOK A
		WHERE		A.YEAR			=	:ls_year
		AND		A.HAKGI			=	:ls_hakgi
		AND		A.GWAMOK_ID		=	:ls_gwamok_id
		AND		A.GWAMOK_SEQ	=	:ll_gwamok_seq
		AND		A.ISU_ID			=	:ls_isu_id
		USING SQLCA ;


		/* 토마토 추가부분 */
		/* 수강기준인원 */
		SELECT nvl(relation1, 0)
		  INTO :l_inwon
		  FROM haksa.TMT_CODE
		 WHERE large_div    = 'SUH03'
			AND small_div    = '02' 
		USING SQLCA ;
		IF sqlca.sqlnrows   = 0 THEN
			l_inwon          = 0
		END IF

      SELECT nvl(count(*), 0)
		  INTO :l_inwon1
		  FROM haksa.sugang_trans
		 WHERE year        = :ls_year
		   AND hakgi       = :ls_hakgi
			AND gwa         = :ls_gwa
			AND hakyun      = :ls_hakyun
			AND ban         = :ls_ban
			AND gwamok_id   = :ls_gwamok_id
		   AND gwamok_seq  = :ll_gwamok_seq
			AND bunban      = :ls_bunban
			AND (SUNGJUK_INJUNG = 'Y' OR HWANSAN_JUMSU = 'W')
		   USING SQLCA ;

      is_isu  = 'N'
      IF ls_each_yn        = 'Y' AND l_inwon1 >= l_inwon THEN
			is_isu            = 'Y'
		elseif ls_pass_gubun = 'Y' or ls_new_pass_gubun = 'Y' then
		else 
			messagebox("확인","패스과목이 아니라서 변경 불가능합니다." )
			rollback USING SQLCA ;
			return
		end if		
end if

end event

type gb_3 from uo_main_groupbox within w_hsu306a_1
integer x = 18
integer y = 2504
integer taborder = 100
end type

type st_name from statictext within w_hsu306a_1
integer x = 1902
integer y = 188
integer width = 1879
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 32500968
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hsu306a_1
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
string dataobject = "d_hsu303a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

