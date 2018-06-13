$PBExportHeader$w_hsu302a.srw
$PBExportComments$[청운대]성적입력(관리자용)
forward
global type w_hsu302a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hsu302a
end type
type dw_2 from datawindow within w_hsu302a
end type
type st_4 from statictext within w_hsu302a
end type
type st_5 from statictext within w_hsu302a
end type
type st_7 from statictext within w_hsu302a
end type
type dw_4 from datawindow within w_hsu302a
end type
type dw_3 from datawindow within w_hsu302a
end type
type dw_con from uo_dwfree within w_hsu302a
end type
type uo_1 from uo_imgbtn within w_hsu302a
end type
type uo_2 from uo_imgbtn within w_hsu302a
end type
type uo_3 from uo_imgbtn within w_hsu302a
end type
end forward

global type w_hsu302a from w_condition_window
integer width = 4507
dw_main dw_main
dw_2 dw_2
st_4 st_4
st_5 st_5
st_7 st_7
dw_4 dw_4
dw_3 dw_3
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
end type
global w_hsu302a w_hsu302a

type variables
long 		il_row, il_seq_no
string 	is_year, is_hakgi, is_gwa,	is_jungong_id, is_hakyun, is_ban, is_juya
string	is_gwamok2, is_member_no,  is_hosil, is_yoil, is_sigan, is_ban_bunhap
string	is_chk, is_gwamok
String is_isu,     is_modchk,   is_create
Long   il_gijun,   il_hapgijun

end variables

forward prototypes
public function integer wf_chk (integer as_row, string as_name)
public function integer wf_chk1 (integer ai_row)
public function integer wf_each_chk ()
end prototypes

public function integer wf_chk (integer as_row, string as_name);String ls_year,   ls_hakgi,   ls_gwa,   ls_hakyun,   ls_ban,    ls_gwamok
String ls_bunban, ls_isu,     ls_chk,   ls_hakbun,   ls_hname,  ls_string
String ls_small,  ls_seq1,    ls_grade, ls_gubun,    ls_grade1
Long   l_inwon,   l_inwon1,   ll_gwamok_seq
Long   l_percent, l_gijun,    l_hapgijun
Int    ii,        l_row,      l_seq,    l_totinwon,  l_haprow,  l_chk,    jj
Double l_jumsu1,  l_jumsu2,   l_jumsu3, l_jumsu4,    l_jumsu5,  l_jumsu
Double l_jjumsu1, l_jjumsu2,  l_jjumsu3,l_jjumsu4,   l_jjumsu5, l_jjumsu
Double l_percent2

/* 상대평가 자동처리 여부 */
SELECT nvl(relation1, 'N')
  INTO :ls_chk
  FROM haksa.TMT_CODE
 WHERE large_div    = 'SUH03'
   AND small_div    = '01' ;
IF sqlca.sqlnrows   = 0 THEN
	ls_chk           = 'N'
END IF
IF ls_chk           = 'N' THEN
	return 0
END IF
/* 수강기준인원 */
SELECT nvl(relation1, 0)
  INTO :l_inwon
  FROM haksa.TMT_CODE
 WHERE large_div    = 'SUH03'
   AND small_div    = '02' ;
IF sqlca.sqlnrows   = 0 THEN
	l_inwon          = 0
END IF

IF dw_2.RowCount() < l_inwon THEN
	return 0
END IF

ls_hakbun  = dw_2.GetItemString(as_row, 'hakbun')
l_row      = dw_3.Find( "hakbun = '"+ ls_hakbun + "'", 1, dw_3.rowcount())
IF l_row   < 1 THEN
ELSE
	l_jumsu1   = dw_2.GetItemNumber(as_row, as_name)
	l_jumsu    = dw_2.GetItemNumber(as_row, 'jumsu')
	dw_3.SetItem(l_row, as_name, l_jumsu1)
	dw_3.SetItem(l_row, 'jumsu', l_jumsu)
END IF

wf_each_chk()

return -1
end function

public function integer wf_chk1 (integer ai_row);String ls_year,   ls_hakgi,   ls_gwa,   ls_hakyun,   ls_ban,    ls_gwamok
String ls_bunban, ls_grade,   ls_gubun
Long   l_percent, l_gijun,    l_happer, ll_gwamok_seq
Int    l_row

l_row           = ai_row
IF l_row        > dw_4.RowCount() THEN
	return 0
END IF

ls_grade        = dw_4.GetItemString(l_row, 'grade')
l_percent       = dw_4.GetItemNumber(l_row, 'percent')
l_happer        = dw_4.GetItemNumber(l_row, 'hap_percent')
IF isnull(ls_grade) OR ls_grade = '' THEN
	return 0
END IF

/* 기준 산정 여부 */
SELECT nvl(relation1, '')
  INTO :ls_gubun
  FROM haksa.TMT_CODE
 WHERE large_div    = 'SUH03'
   AND small_div    = '03' ;
IF ls_gubun         = '01' THEN
   il_gijun    = truncate(((l_percent * dw_3.RowCount()) / 100) + 0.9, 0)
	il_hapgijun = truncate(((l_happer  * dw_3.RowCount()) / 100) + 0.9, 0)
ELSEIF ls_gubun     = '02' THEN
   il_gijun    = truncate(((l_percent * dw_3.RowCount()) / 100), 0)
	il_hapgijun = truncate(((l_happer  * dw_3.RowCount()) / 100), 0)
ELSEIF ls_gubun     = '03' THEN
   il_gijun    = truncate(((l_percent * dw_3.RowCount()) / 100)+ 0.5, 0)
	il_hapgijun = truncate(((l_happer  * dw_3.RowCount()) / 100)+ 0.5, 0)
END IF

return l_gijun
end function

public function integer wf_each_chk ();String ls_year,   ls_hakgi,   ls_gwa,   ls_hakyun,   ls_ban,    ls_gwamok
String ls_bunban, ls_isu,     ls_chk,   ls_hakbun,   ls_hname,  ls_string
String ls_small,  ls_seq1,    ls_grade, ls_gubun,    ls_grade1
Long   l_inwon,   l_inwon1,   ll_gwamok_seq
Long   l_percent, l_gijun,    l_hapgijun
Int    ii,        l_row,      l_seq,    l_totinwon,  l_haprow,  l_chk,    jj
Int    l_count
Double l_jumsu1,  l_jumsu2,   l_jumsu3, l_jumsu4,    l_jumsu5,  l_jumsu
Double l_jjumsu1, l_jjumsu2,  l_jjumsu3,l_jjumsu4,   l_jjumsu5, l_jjumsu
Double l_percent2

dw_4.AcceptText()

ls_string  = 'jumsu D,'
DECLARE cur_1  CURSOR FOR

  SELECT small_div
    FROM haksa.tmt_code
	WHERE large_div   = 'SUH05'
	  AND small_div  <> '00000000'
	  AND nvl(relation1, ' ') <> ' '
	ORDER BY relation1 ;

 OPEN   cur_1;
 DO WHILE(TRUE)
 FETCH cur_1 INTO  :ls_small ;
 IF SQLCA.SQLCODE  <> 0 THEN  EXIT
 
    IF ls_small      = '01' THEN
		 ls_seq1       = 'jumsu_2 D,'
	 ELSEIF ls_small  = '02' THEN
		 ls_seq1       = 'jumsu_4 D,'
	 ELSEIF ls_small  = '03' THEN
		 ls_seq1       = 'jumsu_1 D,'
	 ELSEIF ls_small  = '04' THEN
		 ls_seq1       = 'jumsu_5 D,'
	 ELSEIF ls_small  = '05' THEN
		 ls_seq1       = 'jumsu_3 D,'
	 END IF
	 ls_string        = ls_string + ls_seq1
   
Loop
Close  Cur_1;

ls_string   = mid(ls_string, 1, len(ls_string) - 1)
dw_3.SetSort(ls_string)
dw_3.sort()

l_haprow    = 1
il_hapgijun = 0
il_gijun    = 0

l_haprow    = dw_4.Find( "percent <> 0 ", 1, dw_4.rowcount())
IF isnull(l_haprow) OR l_haprow = 0 THEN
	return 0
END IF
l_chk       = wf_chk1(l_haprow)
l_count     = l_haprow + 1

ls_grade    = dw_4.GetItemString(l_haprow, 'grade')
l_totinwon  = 0
l_haprow    = 1
FOR ii          = 1 TO dw_3.RowCount()
	 dw_3.SetItem(ii, 'seq', ii)
	 l_jumsu4      = dw_3.GetItemNumber(ii, 'jumsu_4')
    IF l_jumsu4  <> 0 THEN
	    l_totinwon = l_totinwon + 1
	 END IF
	 IF l_totinwon > il_gijun AND l_totinwon > il_hapgijun THEN
		 l_haprow   = dw_4.Find( "percent <> 0 ", l_count, dw_4.rowcount())
		 l_gijun    = wf_chk1(l_haprow)
		 l_count    = l_haprow + 1

		 IF l_haprow   > dw_4.RowCount() THEN
			 ls_grade   = ''
		 ELSE
		    ls_grade   = dw_4.GetItemString(l_haprow, 'grade')
		 END IF
	 END IF

	 IF l_jumsu4   = 0 THEN
		 dw_3.SetItem(ii, 'hwansan_jumsu', 'F')
		 dw_3.SetItem(ii, 'pyengjum',      0.0)
	 ELSE
	    dw_3.SetItem(ii, 'hwansan_jumsu', ls_grade)
		 IF ii        <> 1 THEN
			 l_jumsu    = dw_3.GetItemNumber(ii, 'jumsu')
			 l_jumsu1   = dw_3.GetItemNumber(ii, 'jumsu_1')
			 l_jumsu2   = dw_3.GetItemNumber(ii, 'jumsu_2')
			 l_jumsu3   = dw_3.GetItemNumber(ii, 'jumsu_3')
			 l_jumsu4   = dw_3.GetItemNumber(ii, 'jumsu_4')
			 l_jumsu5   = dw_3.GetItemNumber(ii, 'jumsu_5')
			 l_jjumsu   = dw_3.GetItemNumber(ii -1, 'jumsu')
			 l_jjumsu1  = dw_3.GetItemNumber(ii -1, 'jumsu_1')
			 l_jjumsu2  = dw_3.GetItemNumber(ii -1, 'jumsu_2')
			 l_jjumsu3  = dw_3.GetItemNumber(ii -1, 'jumsu_3')
			 l_jjumsu4  = dw_3.GetItemNumber(ii -1, 'jumsu_4')
			 l_jjumsu5  = dw_3.GetItemNumber(ii -1, 'jumsu_5')
			 l_seq      = dw_3.GetItemNumber(ii -1, 'seq')
			 ls_grade1  = dw_3.GetItemString(ii -1, 'hwansan_jumsu')
			 IF l_jumsu = l_jjumsu  AND l_jumsu1 = l_jjumsu1 AND l_jumsu2 = l_jjumsu2 AND &
				 l_jumsu3= l_jjumsu3 AND l_jumsu4 = l_jjumsu4 AND l_jumsu5 = l_jjumsu5 THEN
				 dw_3.SetItem(ii, 'seq', l_seq)
				 dw_3.SetItem(ii, 'hwansan_jumsu', ls_grade1)
			 END IF
		 END IF
	 END IF
NEXT

FOR ii          = 1 TO dw_4.RowCount()
	 ls_grade    = dw_4.GetItemString(ii, 'grade')
	 l_inwon     = 0
	 FOR jj      = 1 TO dw_3.RowCount()
		  ls_grade1   = dw_3.GetItemString(jj, 'hwansan_jumsu')
		  IF ls_grade = ls_grade1 THEN
			  l_inwon  = l_inwon + 1
		  END IF
	 NEXT
	 l_percent2  = truncate((l_inwon / dw_3.RowCount()) * 100, 2)
	 dw_4.SetItem(ii, 'inwon',    l_inwon)
	 dw_4.SetItem(ii, 'percent1', l_percent2)
NEXT

return 0

end function

on w_hsu302a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_2=create dw_2
this.st_4=create st_4
this.st_5=create st_5
this.st_7=create st_7
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.st_7
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.dw_con
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.uo_2
this.Control[iCurrent+11]=this.uo_3
end on

on w_hsu302a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_7)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
end on

event ue_save;int    li_ans,    ii,         li_cnt
Long   l_row,     l_percent
String ls_grade,  ls_jogi,    ls_hakbun
Double l_happer,  l_happer1,  l_percent1
String ls_year,   ls_hakgi,   ls_gwa,   ls_hakyun,   ls_ban,    ls_gwamok
String ls_bunban
Long   ll_gwamok_seq

dw_4.AcceptText()

IF is_isu        = 'Y' THEN
	IF is_create  = 'N' THEN
	   messagebox("알림", '개설과목의 상대평가 비율표가 작성되지 않아 상대평가가 적용되지 않고 진행됩니다.')
//	   return
	END IF
	IF is_modchk  = 'Y' THEN
		messagebox("알림", '기준 비율표가 수정되었으니 저장후 작업바랍니다')
		return -1
	END IF
	
	IF is_create  = 'Y' THEN
		l_row  = wf_each_chk()
		
		FOR ii     = 1 TO dw_4.RowCount()
			 ls_grade   = dw_4.GetItemString(ii, 'grade')
			 l_percent  = dw_4.GetItemNumber(ii, 'percent')
			 l_percent1 = dw_4.GetItemNumber(ii, 'percent1')
			 l_happer   = dw_4.GetItemNumber(ii, 'hap_percent')
			 l_happer1  = dw_4.GetItemNumber(ii, 'hap_percent1')
			 IF l_happer < l_happer1 THEN
				 messagebox("저장", ls_grade + '등급에서 누적 비율이 기준보다 초과합니다')
				 return -1
			 END IF
		NEXT
		
		uo_1.TriggerEvent(clicked!)
		
		ls_year				= dw_main.object.year[dw_main.GetRow()]
		ls_hakgi				= dw_main.object.hakgi[dw_main.GetRow()]
		ls_gwa				= dw_main.object.gwa[dw_main.GetRow()]
		ls_hakyun			= dw_main.object.hakyun[dw_main.GetRow()]
		ls_ban				= dw_main.object.ban[dw_main.GetRow()]
		ls_gwamok			= dw_main.object.gwamok_id[dw_main.GetRow()]
		ll_gwamok_seq		= dw_main.object.gwamok_seq[dw_main.GetRow()]
		ls_bunban			= dw_main.object.bunban[dw_main.GetRow()]
		DELETE FROM haksa.TMT_EACH_AMOUNT
		 WHERE year       = :ls_year
			AND hakgi      = :ls_hakgi
			AND gwa        = :ls_gwa
			AND hakyun     = :ls_hakyun
			AND ban        = :ls_ban
			AND bunban     = :ls_bunban
			AND gwamok_id  = :ls_gwamok
			AND gwamok_seq = :ll_gwamok_seq
			AND seq        = 2
			USING SQLCA ;
		
		FOR ii            = 1 TO dw_4.RowCount()
			 ls_grade      = dw_4.object.grade[ii]
			 l_percent1    = dw_4.object.percent1[ii]
			 INSERT INTO haksa.TMT_EACH_AMOUNT (year,        hakgi,       gwa,           hakyun,
															ban,         bunban,      gwamok_id,     gwamok_seq,
															seq,         grade,       percent,       upd_user_ip_addr,
															upd_user_id,
															upd_pgm_id)
												 VALUES (:ls_year,    :ls_hakgi,   :ls_gwa,       :ls_hakyun,
															:ls_ban,     :ls_bunban,  :ls_gwamok,    :ll_gwamok_seq,
															2,           :ls_grade,   :l_percent1,   :gs_ip,
															:gs_empcode,
															'W_HSU302A') USING SQLCA ;
			 IF sqlca.sqlcode <> 0 THEN
				 messagebox("저장", '저장중 에러입니다' + sqlca.sqlerrtext)
				 rollback USING SQLCA ;
				 return -1
			 END IF
		NEXT
	END IF

	FOR ii            = 1 TO dw_2.RowCount()
		 ls_hakbun     = dw_2.object.hakbun[ii]
		 ls_jogi       = dw_2.object.sugang_trans_jogi_yn[ii]
		 ls_grade      = dw_2.object.hwansan_jumsu[ii]
		 IF ls_jogi    = '1' OR ls_jogi = '2' then
			 IF ls_grade  = 'A+' THEN
				 messagebox("알림", ls_hakbun + '학번은 조기또는 추가시험자로 A+ 이상을 평가할 수 없으니 확인바랍니다.')
				 rollback USING SQLCA ;
				 return -1
			 END IF
		 END IF
	NEXT

END IF

li_ans = dw_2.update()	

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

event open;call super::open;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

event ue_retrieve;call super::ue_retrieve;string	ls_year, ls_hakgi, ls_prof
long 		ll_row

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_prof    	=	dw_con.Object.prof_no[1]

dw_2.reset()

ll_row = dw_main.retrieve(ls_year, ls_hakgi, ls_prof)

if ll_row = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)

elseif ll_row = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	

end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu302a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu302a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu302a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu302a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu302a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu302a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu302a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu302a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu302a
end type

type uc_save from w_condition_window`uc_save within w_hsu302a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu302a
end type

type uc_print from w_condition_window`uc_print within w_hsu302a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu302a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu302a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu302a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu302a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu302a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu302a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu302a
integer taborder = 90
end type

type dw_main from uo_input_dwc within w_hsu302a
integer x = 55
integer y = 372
integer width = 1993
integer height = 1056
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_hsu300a_1"
boolean border = true
end type

event clicked;call super::clicked;string	ls_year,	ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban, ls_pyungga_gubun, ls_pass_gubun
long		ll_gwamok_seq, ll_mod,   l_totper
int 		li_msg, li_ans,  ii,  l_inwon,  jj
String   ls_hakbun, ls_hname,  ls_chk,    ls_pyengjum
Double   l_jumsu1,  l_jumsu2,  l_jumsu3,  l_jumsu4,  l_jumsu5,  l_jumsu

if row <= 0 then return 

//다른 부분을 조회하기 전에 변경된 자료가 있으면 저장한다.
ll_mod = dw_2.ModifiedCount()

if ll_mod > 0 then
	li_msg = messagebox("확인","변경된 자료가 존재합니다.~r~n저장하시겠습니까?", Question!, YesNo!, 1)
	
	if li_msg = 1 then
		li_ans = dw_2.update()
		
		if li_ans = -1 then
			uf_messagebox(3)
			rollback USING SQLCA ;
		else	
			commit USING SQLCA ;
		end if
		
	end if
	
end if

ls_year				=	this.object.year[row]
ls_hakgi				=	this.object.hakgi[row]
ls_gwa				=	this.object.gwa[row]
ls_hakyun			=	this.object.hakyun[row]
ls_ban				=	this.object.ban[row]
ls_gwamok			=	this.object.gwamok_id[row]
ll_gwamok_seq		=	this.object.gwamok_seq[row]
ls_bunban			=	this.object.bunban[row]
ls_pyungga_gubun	=	this.object.pyungga_gubun[row]
ls_pass_gubun		=	this.object.pass_gubun[row]

li_ans = dw_2.retrieve(ls_year,	ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ll_gwamok_seq, ls_bunban)

SELECT nvl(tmt_each_yn, 'N')
  INTO :is_isu
  FROM haksa.gaesul_gwamok
 WHERE year       = :ls_year
   AND hakgi      = :ls_hakgi
	AND gwa        = :ls_gwa
	AND hakyun     = :ls_hakyun
	AND ban        = :ls_ban
	AND bunban     = :ls_bunban
	AND gwamok_id  = :ls_gwamok
	AND gwamok_seq = :ll_gwamok_seq
	USING SQLCA ;
IF sqlca.sqlnrows = 0 THEN
	is_isu         = 'N'
END IF


li_ans = dw_2.retrieve(ls_year,	ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ll_gwamok_seq, ls_bunban)


is_modchk   = 'N'
is_create   = 'N'
dw_4.SetTransobject(sqlca)
dw_4.reset()
li_ans = dw_4.retrieve(ls_year,	ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ll_gwamok_seq, ls_bunban)
/* 상대평가 자동처리 여부 */
SELECT nvl(relation1, 'N')
  INTO :ls_chk
  FROM haksa.TMT_CODE
 WHERE large_div    = 'SUH03'
   AND small_div    = '01' 
USING SQLCA ;
IF sqlca.sqlnrows   = 0 THEN
	ls_chk           = 'N'
END IF

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

IF is_isu  = 'Y' AND dw_2.RowCount() >= l_inwon THEN
ELSE
	is_isu  = 'N'
END IF

IF is_isu         = 'Y' THEN
	dw_3.reset()
	jj  = 0
	FOR ii            = 1 TO dw_2.RowCount()
		 ls_hakbun     = dw_2.GetItemString(ii, 'hakbun')
		 l_jumsu1      = dw_2.GetItemNumber(ii, 'jumsu_1')
		 l_jumsu2      = dw_2.GetItemNumber(ii, 'jumsu_2')
		 l_jumsu3      = dw_2.GetItemNumber(ii, 'jumsu_3')
		 l_jumsu4      = dw_2.GetItemNumber(ii, 'jumsu_4')
		 l_jumsu5      = dw_2.GetItemNumber(ii, 'jumsu_5')
		 l_jumsu       = dw_2.GetItemNumber(ii, 'jumsu')
		 ls_hname      = dw_2.GetItemString(ii, 'jaehak_hakjuk_hname')
		 ls_pyengjum   = dw_2.GetItemString(ii, 'hwansan_jumsu')
		 IF isnull(l_jumsu)  THEN
			 l_jumsu    = 0
		 END IF
		 IF isnull(l_jumsu1) THEN
			 l_jumsu1   = 0
		 END IF
		 IF isnull(l_jumsu2) THEN
			 l_jumsu2   = 0
		 END IF
		 IF isnull(l_jumsu3) THEN
			 l_jumsu3   = 0
		 END IF
		 IF isnull(l_jumsu4) THEN
			 l_jumsu4   = 0
		 END IF
		 IF isnull(l_jumsu5) THEN
			 l_jumsu5   = 0
		 END IF
		 IF isnull(ls_pyengjum) THEN
			 ls_pyengjum  = ''
		 END IF
		 IF ls_pyengjum <> 'W' THEN
		    dw_3.InsertRow(0)
			 jj   = jj + 1
			 dw_3.SetItem(jj, 'hakbun',  ls_hakbun)
			 dw_3.SetItem(jj, 'jumsu_1', l_jumsu1)
			 dw_3.SetItem(jj, 'jumsu_2', l_jumsu2)
			 dw_3.SetItem(jj, 'jumsu_3', l_jumsu3)
			 dw_3.SetItem(jj, 'jumsu_4', l_jumsu4)
			 dw_3.SetItem(jj, 'jumsu_5', l_jumsu5)
			 dw_3.SetItem(jj, 'jumsu',   l_jumsu)
			 dw_3.SetItem(jj, 'jaehak_hakjuk_hname',   ls_hname)
		 END IF
	NEXT
	wf_chk(1, 'jumsu')
END IF

l_totper   = dw_4.GetItemNumber(dw_4.RowCount(), 'tot_percent')
IF is_isu  = 'Y' THEN
	uo_1.visible   = true
	uo_3.visible   = true
	uo_2.visible   = true
	dw_4.visible   = true
	st_7.visible   = true
   IF l_totper   = 0 THEN
		dw_2.SetTabOrder ( 'hwansan_jumsu', 30 )
		dw_2.SetTabOrder ( 'jumsu_1', 0 )
		dw_2.SetTabOrder ( 'jumsu_2', 0 )
		dw_2.SetTabOrder ( 'jumsu_3', 0 )
		dw_2.SetTabOrder ( 'jumsu_4', 0 )
		dw_2.SetTabOrder ( 'jumsu_5', 0 )
		messagebox("알림", '개설과목의 상대평가 비율표가 작성되지 않아 작업할 수 없습니다')
		is_create  = 'N'
		return
	ELSE
		is_create  = 'Y'
	END IF
ELSE
	uo_1.visible   = false
	uo_3.visible   = false
	uo_2.visible   = false
	dw_4.visible   = false
	st_7.visible   = false
END IF

IF is_isu         = 'Y' THEN
	uo_1.visible   = true
	uo_3.visible   = true
	uo_2.visible   = true
	dw_4.visible   = true
	st_7.visible   = true
ELSE
	uo_1.visible   = false
	uo_3.visible   = false
	uo_2.visible   = false
	dw_4.visible   = false
	st_7.visible   = false
END IF





//평가구분, 패스과목 여부에 따라 TabOrder Control
if li_ans > 0 then
	if ls_pass_gubun = 'Y' then
//		dw_2.SetTabOrder ( 'hwansan_jumsu', 10 )
//		dw_2.SetTabOrder ( 'jumsu_1', 0 )
//		dw_2.SetTabOrder ( 'jumsu_2', 0 )
//		dw_2.SetTabOrder ( 'jumsu_3', 0 )
//		dw_2.SetTabOrder ( 'jumsu_4', 0 )
//		dw_2.SetTabOrder ( 'jumsu_5', 0 )
		
	else
		if ls_pyungga_gubun	=	'B' then
			dw_2.SetTabOrder ( 'hwansan_jumsu', 30 )
			dw_2.SetTabOrder ( 'jumsu_1', 0 )
			dw_2.SetTabOrder ( 'jumsu_2', 0 )
			dw_2.SetTabOrder ( 'jumsu_3', 0 )
			dw_2.SetTabOrder ( 'jumsu_4', 10 )
			dw_2.SetTabOrder ( 'jumsu_5', 20 )
		else
			dw_2.SetTabOrder ( 'hwansan_jumsu', 60 )
			dw_2.SetTabOrder ( 'jumsu_1', 10 )
			dw_2.SetTabOrder ( 'jumsu_2', 20 )
			dw_2.SetTabOrder ( 'jumsu_3', 30 )
			dw_2.SetTabOrder ( 'jumsu_4', 40 )
			dw_2.SetTabOrder ( 'jumsu_5', 0 )
			
		end if
		
	end if
				
end if
end event

type dw_2 from datawindow within w_hsu302a
integer x = 2071
integer y = 372
integer width = 2363
integer height = 1892
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hsu300a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event itemchanged;long		ll_jumsu_1, ll_jumsu_2, ll_jumsu_3, ll_jumsu_4, ll_jumsu_5, ll_jumsu_tot, ll_hakjum, ll_null
double   ld_pyengjum
string	ls_hwansan_jumsu, ls_jogi
Int      ii,        jj
String   ls_hakbun, ls_hname,  ls_chk,    ls_pyengjum
Double   l_jumsu1,  l_jumsu2,  l_jumsu3,  l_jumsu4,  l_jumsu5,  l_jumsu

dw_2.Accepttext()

CHOOSE CASE dwo.name
		
	CASE 'jumsu_1', 'jumsu_2', 'jumsu_3', 'jumsu_4', 'jumsu_5'
		
		ll_jumsu_1		=	dw_2.getitemnumber(row, "jumsu_1")
		ll_jumsu_2		=	dw_2.getitemnumber(row, "jumsu_2")
		ll_jumsu_3		=	dw_2.getitemnumber(row, "jumsu_3")
		ll_jumsu_4		=	dw_2.getitemnumber(row, "jumsu_4")
		ll_jumsu_5		=	dw_2.getitemnumber(row, "jumsu_5")
		ll_hakjum		=	dw_2.getitemnumber(row, "hakjum")
		
		setnull(ll_null)
		
		if dwo.name = 'jumsu_1' then
			if long(data) > 30 then
				messagebox("오류","중간고사 점수는 30점을 넘을 수 없습니다.")
				this.object.jumsu_1[row]	=	ll_null
				return 1
				
			end if
				
		elseif dwo.name = 'jumsu_2' then			
			if long(data) > 40 then
				messagebox("오류","기말고사 점수는 40점을 넘을 수 없습니다.")
				this.object.jumsu_2[row]	=	ll_null
				return 1
				
			end if
			
		elseif dwo.name = 'jumsu_3' then			
			if long(data) > 20 then
				messagebox("오류","과제 점수는 20점을 넘을 수 없습니다.")
				this.object.jumsu_3[row]	=	ll_null
				return 1
				
			end if
		
		elseif dwo.name = 'jumsu_4' then			
			if long(data) > 10 then
				messagebox("오류","출석 점수는 10점을 넘을 수 없습니다.")
				this.object.jumsu_4[row]	=	ll_null
				return 1
				
			end if
			
		elseif dwo.name = 'jumsu_5' then			
			if long(data) > 90 then
				messagebox("오류","실기 점수는 90점을 넘을 수 없습니다.")
				this.object.jumsu_5[row]	=	ll_null
				return 1
				
			end if	
			
		end if
		
		//점수합계를 구한다.
		if isnull(ll_jumsu_1) then	ll_jumsu_1 = 0
		if isnull(ll_jumsu_2) then	ll_jumsu_2 = 0
		if isnull(ll_jumsu_3) then	ll_jumsu_3 = 0
		if isnull(ll_jumsu_4) then	ll_jumsu_4 = 0
		if isnull(ll_jumsu_5) then	ll_jumsu_5 = 0		
		
		ll_jumsu_tot	=	ll_jumsu_1 + ll_jumsu_2 + ll_jumsu_3 + ll_jumsu_4 + ll_jumsu_5
		
		//조기시험자 check
		ls_jogi = this.object.sugang_trans_jogi_yn[row]
		
		if ls_jogi = '1' OR ls_jogi = '2' then
			if ll_jumsu_tot >= 95 then
				messagebox("오류","조기시험자 또는 추가시험자는 94점을 초과할 수 없습니다.")
				setnull(ll_jumsu_1)
				this.object.jumsu_1[row] = ll_null
				this.object.jumsu_2[row] = ll_null
				this.object.jumsu_3[row] = ll_null
				this.object.jumsu_4[row] = ll_null
				return 1
			end if
		end if
		
		//점수에 따른 평가코드 및 평점 부여
		//출석점수가 0점이면 무조건 'F'임
		//상대평가 교과목은 wf_chk()에서 체크함
		dw_2.setitem(row, "jumsu", ll_jumsu_tot)	
		
		IF is_isu               = 'Y' THEN
			wf_chk(row, dwo.name)
		ELSE
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
				
		dw_2.setitem(row, "hwansan_jumsu", ls_hwansan_jumsu)
		dw_2.setitem(row, "pyengjum", ld_pyengjum)
		
	CASE	'hwansan_jumsu'
		//철회자 처리
		if data = 'W' then
			this.object.jumsu_1[row]	=	ll_null
			this.object.jumsu_2[row]	=	ll_null
			this.object.jumsu_3[row]	=	ll_null
			this.object.jumsu_4[row]	=	ll_null
			this.object.jumsu[row]		=	ll_null	
			
			this.object.sungjuk_injung[row]		=	'N'
			
		else
			this.object.sungjuk_injung[row]		=	'Y'
			
		end if

		IF is_isu               = 'Y' THEN
			dw_3.reset()
			jj  = 0
			FOR ii            = 1 TO dw_2.RowCount()
				 ls_hakbun     = dw_2.GetItemString(ii, 'hakbun')
				 l_jumsu1      = dw_2.GetItemNumber(ii, 'jumsu_1')
				 l_jumsu2      = dw_2.GetItemNumber(ii, 'jumsu_2')
				 l_jumsu3      = dw_2.GetItemNumber(ii, 'jumsu_3')
				 l_jumsu4      = dw_2.GetItemNumber(ii, 'jumsu_4')
				 l_jumsu5      = dw_2.GetItemNumber(ii, 'jumsu_5')
				 l_jumsu       = dw_2.GetItemNumber(ii, 'jumsu')
				 ls_hname      = dw_2.GetItemString(ii, 'jaehak_hakjuk_hname')
				 ls_pyengjum   = dw_2.GetItemString(ii, 'hwansan_jumsu')
				 IF isnull(l_jumsu)  THEN
					 l_jumsu    = 0
				 END IF
				 IF isnull(l_jumsu1) THEN
					 l_jumsu1   = 0
				 END IF
				 IF isnull(l_jumsu2) THEN
					 l_jumsu2   = 0
				 END IF
				 IF isnull(l_jumsu3) THEN
					 l_jumsu3   = 0
				 END IF
				 IF isnull(l_jumsu4) THEN
					 l_jumsu4   = 0
				 END IF
				 IF isnull(l_jumsu5) THEN
					 l_jumsu5   = 0
				 END IF
				 IF isnull(ls_pyengjum) THEN
					 ls_pyengjum  = ''
				 END IF
				 IF ls_pyengjum <> 'W' THEN
					 dw_3.InsertRow(0)
					 jj   = jj + 1
					 dw_3.SetItem(jj, 'hakbun',  ls_hakbun)
					 dw_3.SetItem(jj, 'jumsu_1', l_jumsu1)
					 dw_3.SetItem(jj, 'jumsu_2', l_jumsu2)
					 dw_3.SetItem(jj, 'jumsu_3', l_jumsu3)
					 dw_3.SetItem(jj, 'jumsu_4', l_jumsu4)
					 dw_3.SetItem(jj, 'jumsu_5', l_jumsu5)
					 dw_3.SetItem(jj, 'jumsu',   l_jumsu)
					 dw_3.SetItem(jj, 'jaehak_hakjuk_hname',   ls_hname)
				 END IF
			NEXT
			wf_chk(row, 'jumsu_1')
		END IF
	
END CHOOSE

end event

event constructor;this.settransobject(sqlca)
end event

event itemerror;return 2
end event

type st_4 from statictext within w_hsu302a
integer x = 55
integer y = 296
integer width = 1993
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "개설강좌"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_hsu302a
integer x = 2071
integer y = 296
integer width = 2359
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "수강자 명단"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_hsu302a
boolean visible = false
integer x = 55
integer y = 1548
integer width = 1989
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "성적분포표"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_hsu302a
boolean visible = false
integer x = 50
integer y = 1624
integer width = 1993
integer height = 640
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_hsu300a_22"
boolean vscrollbar = true
boolean livescroll = true
end type

event itemchanged;CHOOSE CASE dwo.name
	CASE 'percent'
		  is_modchk   = 'Y'
END CHOOSE
end event

event itemfocuschanged;This.SelectText(1, 100)
end event

event constructor;This.SetTransObject(sqlca)
end event

type dw_3 from datawindow within w_hsu302a
boolean visible = false
integer x = 1038
integer y = 292
integer width = 2519
integer height = 1888
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "개인별성적등급분포표"
string dataobject = "d_hsu300a_21"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;dw_3.visible = false
end event

event constructor;This.SetTransObject(sqlca)
end event

type dw_con from uo_dwfree within w_hsu302a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hsu302a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hsu302a
event destroy ( )
integer x = 485
integer y = 40
integer width = 457
integer taborder = 20
boolean bringtotop = true
string btnname = "상대평가적용"
end type

on uo_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;Int    ii,          jj,        l_row,     li_cnt
String ls_hakbun,   ls_grade
Double l_pyengjum

dw_4.AcceptText()
IF is_modchk  = 'Y' THEN
	messagebox("알림", '기준 비율표가 수정되었으니 저장후 작업바랍니다')
	return
END IF

wf_each_chk()

FOR ii         = 1 TO dw_3.RowCount()
	 ls_hakbun  = dw_3.GetItemString(ii, 'hakbun')
	 ls_grade   = dw_3.GetItemString(ii, 'hwansan_jumsu')
	 l_row      = dw_2.Find( "hakbun = '" + ls_hakbun + "'", 1, dw_2.rowcount())
	 IF ls_grade      = 'A+' THEN
       l_pyengjum    = 4.5
	 ELSEIF ls_grade  = 'A'  THEN
       l_pyengjum    = 4.0
	 ELSEIF ls_grade  = 'B+' THEN
       l_pyengjum    = 3.5
	 ELSEIF ls_grade  = 'B'  THEN
       l_pyengjum    = 3.0
	 ELSEIF ls_grade  = 'C+' THEN
       l_pyengjum    = 2.5
	 ELSEIF ls_grade  = 'C'  THEN
       l_pyengjum    = 2.0
	 ELSEIF ls_grade  = 'D+' THEN
       l_pyengjum    = 1.5
	 ELSEIF ls_grade  = 'D'  THEN
       l_pyengjum    = 1.0
	 ELSE
		 l_pyengjum    = 0.0
	 END IF
	 dw_2.SetItem(l_row, 'hwansan_jumsu', ls_grade)
	 dw_2.SetItem(l_row, 'pyengjum',      l_pyengjum)
NEXT
end event

type uo_2 from uo_imgbtn within w_hsu302a
event destroy ( )
integer x = 997
integer y = 40
integer width = 896
integer taborder = 30
boolean bringtotop = true
string btnname = "개인별성적등급분포표"
end type

on uo_2.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;wf_chk(1, 'jumsu')
dw_3.visible = true
end event

type uo_3 from uo_imgbtn within w_hsu302a
event destroy ( )
integer x = 1440
integer y = 1448
integer width = 553
integer taborder = 90
string btnname = "기준비율표저장"
end type

on uo_3.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String ls_year,   ls_hakgi,   ls_gwa,   ls_hakyun,   ls_ban,    ls_gwamok
String ls_bunban, ls_isu,     ls_grade, ls_rela1,    ls_gubun,  ls_pyungga_gubun
Long   ll_gwamok_seq,         l_percent,l_happer
Int    ii
Double l_pera,    l_perb,     l_perc,   l_perd,      l_perf
Double l_relation1, l_relation2

dw_4.Accepttext()

l_happer          = dw_4.GetItemNumber(dw_4.RowCount(), 'tot_percent')
IF l_happer       > 100 THEN
	messagebox("저장", '기준비율표가 100%를 초과하였습니다')
	return
ELSEIF l_happer   < 100 THEN
	messagebox("저장", '기준비율표가 100% 미만입니다')
	return
END IF

ls_year				= dw_main.object.year[dw_main.GetRow()]
ls_hakgi				= dw_main.object.hakgi[dw_main.GetRow()]
ls_gwa				= dw_main.object.gwa[dw_main.GetRow()]
ls_hakyun			= dw_main.object.hakyun[dw_main.GetRow()]
ls_ban				= dw_main.object.ban[dw_main.GetRow()]
ls_gwamok			= dw_main.object.gwamok_id[dw_main.GetRow()]
ll_gwamok_seq		= dw_main.object.gwamok_seq[dw_main.GetRow()]
ls_pyungga_gubun	= dw_main.object.pyungga_gubun[dw_main.GetRow()]
ls_bunban			= dw_main.object.bunban[dw_main.GetRow()]
FOR ii            = 1 TO dw_4.RowCount()
	 l_percent     = dw_4.object.percent[ii]
	 IF isnull(l_percent) THEN
		 dw_4.SetItem(ii, 'percent', 0)
	 END IF
NEXT
/* 상대평가 기준표 비교 */
l_pera = 0; l_perb = 0; l_perc = 0; l_perd = 0; l_perf = 0;
FOR ii              = 1 TO dw_4.RowCount()
	 ls_rela1        = dw_4.object.relation1[ii]
	 l_percent       = dw_4.object.percent[ii]
	 IF isnull(l_percent) THEN
		 l_percent    = 0
	 END IF
	 IF ls_rela1     = 'A' THEN
		 l_pera       = l_pera + l_percent
	 ELSEIF ls_rela1 = 'B' THEN
		 l_perb       = l_perb + l_percent
	 ELSEIF ls_rela1 = 'C' THEN
		 l_perc       = l_perc + l_percent
	 ELSEIF ls_rela1 = 'D' THEN
		 l_perd       = l_perd + l_percent
	 ELSEIF ls_rela1 = 'F' THEN
		 l_perf       = l_perf + l_percent
	 END IF
NEXT
FOR ii              = 1 TO 5
	 IF ii           = 1 THEN
		 ls_gubun     = 'A'
		 l_percent    = l_pera
	 ELSEIF ii       = 2 THEN
		 ls_gubun     = 'B'
		 l_percent    = l_perb
	 ELSEIF ii       = 3 THEN
		 ls_gubun     = 'C'
		 l_percent    = l_perc
	 ELSEIF ii       = 4 THEN
		 ls_gubun     = 'D'
		 l_percent    = l_perd
	 ELSEIF ii       = 5 THEN
		 ls_gubun     = 'F'
		 l_percent    = l_perf
	 END IF
	 SELECT nvl(relation1, 0), nvl(relation2, 0)
	   INTO :l_relation1,      :l_relation2
		FROM haksa.tmt_code
	  WHERE large_div   = 'SUH01'
	    AND cont_desc   = :ls_gubun 
	  USING SQLCA ;
	 IF sqlca.sqlnrows  = 0 THEN
		 l_relation1     = 0
		 l_relation2     = 0
	 END IF
	 IF l_percent      >= l_relation1 AND l_percent <= l_relation2 THEN
	 ELSE
		 messagebox("저장", ls_gubun + '등급의 입력한 상대평가 비율이 상대평가 기준표에 적합하지 않습니다 기준표:' + string(l_relation1) + '-' + string(l_relation1) + ' 비율: ' + string(l_percent))
		 return
	 END IF
NEXT

DELETE FROM haksa.TMT_EACH_AMOUNT
 WHERE year       = :ls_year
   AND hakgi      = :ls_hakgi
	AND gwa        = :ls_gwa
	AND hakyun     = :ls_hakyun
	AND ban        = :ls_ban
	AND bunban     = :ls_bunban
	AND gwamok_id  = :ls_gwamok
	AND gwamok_seq = :ll_gwamok_seq
	AND seq        = 1
	USING SQLCA ;

FOR ii            = 1 TO dw_4.RowCount()
	 ls_grade      = dw_4.object.grade[ii]
	 l_percent     = dw_4.object.percent[ii]
	 INSERT INTO haksa.TMT_EACH_AMOUNT (year,        hakgi,       gwa,           hakyun,
	                                    ban,         bunban,      gwamok_id,     gwamok_seq,
													seq,         grade,       percent,       upd_user_ip_addr,
													upd_user_id,
													upd_pgm_id)
										 VALUES (:ls_year,    :ls_hakgi,   :ls_gwa,       :ls_hakyun,
										         :ls_ban,     :ls_bunban,  :ls_gwamok,    :ll_gwamok_seq,
													1,           :ls_grade,   :l_percent,    :gs_ip,
													:gs_empcode,
													'W_HSU301A') USING SQLCA ;
    IF sqlca.sqlcode <> 0 THEN
		 messagebox("저장", '저장중 에러입니다' + sqlca.sqlerrtext)
		 rollback USING SQLCA ;
		 return
	 END IF
NEXT

commit USING SQLCA ;

//messagebox("저장", '기준비율표가 정상적으로 저장되었습니다')
is_modchk  = 'N'
is_create  = 'Y'
if ls_pyungga_gubun	=	'B' then
	dw_2.SetTabOrder ( 'hwansan_jumsu', 30 )
	dw_2.SetTabOrder ( 'jumsu_1', 0 )
	dw_2.SetTabOrder ( 'jumsu_2', 0 )
	dw_2.SetTabOrder ( 'jumsu_3', 0 )
	dw_2.SetTabOrder ( 'jumsu_4', 10 )
	dw_2.SetTabOrder ( 'jumsu_5', 20 )
else
	dw_2.SetTabOrder ( 'hwansan_jumsu', 60 )
	dw_2.SetTabOrder ( 'jumsu_1', 10 )
	dw_2.SetTabOrder ( 'jumsu_2', 20 )
	dw_2.SetTabOrder ( 'jumsu_3', 30 )
	dw_2.SetTabOrder ( 'jumsu_4', 40 )
	dw_2.SetTabOrder ( 'jumsu_5', 0 )
	
end if

parent.TriggerEvent('ue_save')

return
end event

