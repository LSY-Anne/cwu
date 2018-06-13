$PBExportHeader$w_hsg320a.srw
$PBExportComments$[청운대]학생생활기록카드
forward
global type w_hsg320a from w_condition_window
end type
type st_3 from statictext within w_hsg320a
end type
type st_4 from statictext within w_hsg320a
end type
type tab_1 from tab within w_hsg320a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_main from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_main dw_main
end type
type tabpage_2 from userobject within tab_1
end type
type dw_4 from uo_dwgrid within tabpage_2
end type
type dw_3 from uo_dwgrid within tabpage_2
end type
type dw_2 from uo_dwgrid within tabpage_2
end type
type dw_1 from uo_dwgrid within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type
type tabpage_3 from userobject within tab_1
end type
type dw_7 from uo_dwgrid within tabpage_3
end type
type dw_6 from uo_dwgrid within tabpage_3
end type
type dw_5 from uo_dwgrid within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_7 dw_7
dw_6 dw_6
dw_5 dw_5
end type
type tab_1 from tab within w_hsg320a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type dw_print from datawindow within w_hsg320a
end type
type uo_1 from u_tab within w_hsg320a
end type
type dw_con from uo_dw within w_hsg320a
end type
type uo_create from uo_imgbtn within w_hsg320a
end type
end forward

global type w_hsg320a from w_condition_window
st_3 st_3
st_4 st_4
tab_1 tab_1
dw_print dw_print
uo_1 uo_1
dw_con dw_con
uo_create uo_create
end type
global w_hsg320a w_hsg320a

type variables
String is_sangtae
end variables

forward prototypes
public function integer wf_insert (string as_hakbun)
public function integer wf_retrieve (string as_hakbun)
public function integer wf_image (string as_hakbun)
end prototypes

public function integer wf_insert (string as_hakbun);String ls_gwa,    ls_hname,   ls_cname,   ls_ename,   ls_jumin,   ls_sex,   ls_email
String ls_tel,    ls_hp,      ls_boname,  ls_bojob,   ls_gwangye, ls_bogrd, ls_boaddr
String ls_zipcd,  ls_bank,    ls_account, ls_chuimi,  ls_tukgi,   ls_jonggyo
String ls_zipid,  ls_addr,    ls_blood,   ls_botel
String ls_gunbun, ls_ipdate,  ls_jundate, ls_yukjong, ls_gunbyul, ls_grade
Long   ll_year,   l_cnt

SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM haksa.jaehak_hakjuk
 WHERE hakbun   = :as_hakbun;
IF l_cnt        > 0 THEN
	SELECT gwa,        hname,      cname,       ename,       substr(iphak_date, 1, 4),
			 jumin_no,   sex,        email,       tel,         hp,
			 bo_name,    bo_job,     bo_gwangye,  bo_grade,    bo_addr,
			 bo_zip_id,  bank_id,    account_no,  zip_id,      addr,
			 gunbun,     ipdae_date, junyuk_date, yukjong_id,  gunbyul_id,
			 grade_id,   bo_tel
	  INTO :ls_gwa,    :ls_hname,  :ls_cname,   :ls_ename,   :ll_year,
			 :ls_jumin,  :ls_sex,    :ls_email,   :ls_tel,     :ls_hp,
			 :ls_boname, :ls_bojob,  :ls_gwangye, :ls_bogrd,   :ls_boaddr,
			 :ls_zipcd,  :ls_bank,   :ls_account, :ls_zipid,   :ls_addr,
			 :ls_gunbun, :ls_ipdate, :ls_jundate, :ls_yukjong, :ls_gunbyul,
			 :ls_grade,  :ls_botel
	  FROM haksa.jaehak_hakjuk
	 WHERE hakbun     = :as_hakbun;
	
	SELECT chuimi,    tukgi,      jonggyo,     blood
	  INTO :ls_chuimi,:ls_tukgi,  :ls_jonggyo, :ls_blood
	  FROM haksa.jaehak_sinsang
	 WHERE hakbun     = :as_hakbun;
ELSE
	SELECT gwa,        hname,      cname,       ename,       substr(iphak_date, 1, 4),
			 jumin_no,   sex,        email,       tel,         hp,
			 bo_name,    bo_job,     bo_gwangye,  bo_grade,    bo_addr,
			 bo_zip_id,  bank_id,    account_no,  zip_id,      addr,
			 gunbun,     ipdae_date, junyuk_date, yukjong_id,  gunbyul_id,
			 grade_id,   bo_tel
	  INTO :ls_gwa,    :ls_hname,  :ls_cname,   :ls_ename,   :ll_year,
			 :ls_jumin,  :ls_sex,    :ls_email,   :ls_tel,     :ls_hp,
			 :ls_boname, :ls_bojob,  :ls_gwangye, :ls_bogrd,   :ls_boaddr,
			 :ls_zipcd,  :ls_bank,   :ls_account, :ls_zipid,   :ls_addr,
			 :ls_gunbun, :ls_ipdate, :ls_jundate, :ls_yukjong, :ls_gunbyul,
			 :ls_grade,  :ls_botel
	  FROM haksa.jolup_hakjuk
	 WHERE hakbun     = :as_hakbun;
	
	SELECT chuimi,    tukgi,      jonggyo,     blood
	  INTO :ls_chuimi,:ls_tukgi,  :ls_jonggyo, :ls_blood
	  FROM haksa.jolup_sinsang
	 WHERE hakbun     = :as_hakbun;
END IF
 
st_3.text  = '신규 입력입니다. 저장하세요'

tab_1.tabpage_1.dw_main.reset()
tab_1.tabpage_1.dw_main.InsertRow(0)

tab_1.tabpage_1.dw_main.SetItem(1, 'hakbun',        as_hakbun)
tab_1.tabpage_1.dw_main.SetItem(1, 'gwa',           ls_gwa)
tab_1.tabpage_1.dw_main.SetItem(1, 'hname',         ls_hname)
tab_1.tabpage_1.dw_main.SetItem(1, 'cname',         ls_cname)
tab_1.tabpage_1.dw_main.SetItem(1, 'ename',         ls_ename)
tab_1.tabpage_1.dw_main.SetItem(1, 'iphak_year',    ll_year)
tab_1.tabpage_1.dw_main.SetItem(1, 'jumin_no',      ls_jumin)
tab_1.tabpage_1.dw_main.SetItem(1, 'sex',           ls_sex)
tab_1.tabpage_1.dw_main.SetItem(1, 'email',         ls_email)
tab_1.tabpage_1.dw_main.SetItem(1, 'tel',           ls_tel)
tab_1.tabpage_1.dw_main.SetItem(1, 'hp',            ls_hp)
tab_1.tabpage_1.dw_main.SetItem(1, 'ft_name',       ls_boname)
tab_1.tabpage_1.dw_main.SetItem(1, 'ft_job',        ls_bojob)
tab_1.tabpage_1.dw_main.SetItem(1, 'ft_relation',   ls_gwangye)
tab_1.tabpage_1.dw_main.SetItem(1, 'ft_school_grd', ls_bogrd)
tab_1.tabpage_1.dw_main.SetItem(1, 'ft_zip_code',   ls_zipcd)
tab_1.tabpage_1.dw_main.SetItem(1, 'ft_zip_addr',   ls_boaddr)
tab_1.tabpage_1.dw_main.SetItem(1, 'account_cd',    ls_account)
tab_1.tabpage_1.dw_main.SetItem(1, 'account_bank',  ls_bank)
tab_1.tabpage_1.dw_main.SetItem(1, 'zip_code',      ls_zipid)
tab_1.tabpage_1.dw_main.SetItem(1, 'zip_addr',      ls_addr)
tab_1.tabpage_1.dw_main.SetItem(1, 'blood',         ls_blood)
tab_1.tabpage_1.dw_main.SetItem(1, 'fa_skill',      ls_chuimi)
tab_1.tabpage_1.dw_main.SetItem(1, 'special',       ls_tukgi)
tab_1.tabpage_1.dw_main.SetItem(1, 'mil_kind',      ls_gunbyul)
tab_1.tabpage_1.dw_main.SetItem(1, 'mil_kind_tp',   ls_yukjong)
tab_1.tabpage_1.dw_main.SetItem(1, 'mil_grd',       ls_grade)
tab_1.tabpage_1.dw_main.SetItem(1, 'mil_no',        ls_gunbun)
tab_1.tabpage_1.dw_main.SetItem(1, 'mil_ipdae_date',ls_ipdate)
tab_1.tabpage_1.dw_main.SetItem(1, 'mil_jukyuk_date', ls_jundate)
tab_1.tabpage_1.dw_main.SetItem(1, 'reglion',       ls_jonggyo)
tab_1.tabpage_1.dw_main.SetItem(1, 'ft_cel_hp',     ls_botel)

wf_image(as_hakbun)

return 0
end function

public function integer wf_retrieve (string as_hakbun);Int    l_row,     ii
String ls_hakyun

tab_1.tabpage_2.dw_1.SetTransobject(sqlca)

l_row    = tab_1.tabpage_2.dw_1.Retrieve(as_hakbun)
FOR ii   = l_row  TO 2
	 tab_1.tabpage_2.dw_1.InsertRow(0)
NEXT

tab_1.tabpage_2.dw_2.SetTransobject(sqlca)

l_row    = tab_1.tabpage_2.dw_2.Retrieve(as_hakbun)
FOR ii   = l_row  TO 2
	 tab_1.tabpage_2.dw_2.InsertRow(0)
NEXT

tab_1.tabpage_2.dw_3.SetTransobject(sqlca)

l_row    = tab_1.tabpage_2.dw_3.Retrieve(as_hakbun)
FOR ii   = l_row  TO 6
	 tab_1.tabpage_2.dw_3.InsertRow(0)
NEXT

tab_1.tabpage_2.dw_4.SetTransobject(sqlca)

l_row    = tab_1.tabpage_2.dw_4.Retrieve(as_hakbun)
FOR ii   = l_row  TO 5
	 tab_1.tabpage_2.dw_4.InsertRow(0)
NEXT

tab_1.tabpage_3.dw_5.SetTransobject(sqlca)

l_row    = tab_1.tabpage_3.dw_5.Retrieve(as_hakbun)
IF l_row = 0 THEN
	FOR ii    = 1 TO 4
		 tab_1.tabpage_3.dw_5.InsertRow(0)
		 tab_1.tabpage_3.dw_5.SetItem(ii, 'dr_hakyun', ii)
	NEXT
END IF

tab_1.tabpage_3.dw_6.SetTransobject(sqlca)

l_row    = tab_1.tabpage_3.dw_6.Retrieve(as_hakbun)
FOR ii   = l_row  TO 2
	 tab_1.tabpage_3.dw_6.InsertRow(0)
NEXT

tab_1.tabpage_3.dw_7.SetTransobject(sqlca)

l_row    = tab_1.tabpage_3.dw_7.Retrieve(as_hakbun)
FOR ii   = l_row  TO 2
	 tab_1.tabpage_3.dw_7.InsertRow(0)
NEXT

blob lbBmp
int li_cnt, i

int FP, Li_x, Li_count
long LL_size, LL_start, LL_write
blob imagedata, Lblb_part

IF DirectoryExists ('c:\emp_image') THEN
ELSE
   CreateDirectory ('c:\emp_image')
END IF

dw_print.SetTransobject(sqlca)
dw_print.Retrieve( as_hakbun)
 SELECTBLOB	P_IMAGE
		 INTO :lbBmp
		 FROM HAKSA.PHOTO
		WHERE HAKBUN	= :as_hakbun;
 IF sqlca.sqlcode = 0 then
	
	 LL_size = Len(lbBmp)
	 IF LL_size > 32765 THEN
		 IF Mod(LL_size, 32765) = 0 THEN
			 Li_count = LL_size / 32765
		 ELSE
			 Li_count = (LL_size / 32765) + 1
		 END IF
	 ELSE
		 Li_count = 1
	 END IF
	
	 FP = FileOpen("c:\emp_image\" + as_hakbun + ".jpg", StreamMode!, Write!, Shared!, Replace!)
	
	 FOR i = 1 to Li_count
		  LL_write    = FileWrite(fp,lbBmp )
		  IF LL_write = 32765 THEN
			  lbBmp    = BlobMid(lbBmp, 32766)
		  END IF
	 NEXT
	 FileClose(FP)
	 dw_print.SetItem(1, 'photo_path', 'C:\emp_image\' + as_hakbun + '.jpg')
	 tab_1.tabpage_1.dw_main.SetItem(1, 'photo_path', 'C:\emp_image\' + as_hakbun + '.jpg')
ELSE
	 dw_print.SetItem(1, 'photo_path', 'C:\emp_image\space.jpg')
	 tab_1.tabpage_1.dw_main.SetItem(1, 'photo_path', 'C:\emp_image\space.jpg')
END IF

return 0
end function

public function integer wf_image (string as_hakbun);//string ls_param
//blob   b_total_pic, b_pic
//int		li_ans		,&
//			li_rtn		,&
//			li_filenum	,&
//			li_len
//string 	ls_path		,&
//			ls_filename	,&
//			ls_extension,&
//			ls_filter
//long 		ll_filelen	,&
//			ll_loop		,&
//			ll_count
//
//if as_hakbun <> '' then
//	SetPointer(HourGlass!)
//	
//	SELECTBLOB	P_IMAGE
//	INTO			:b_total_pic
//	FROM			HAKSA.PHOTO
//	WHERE 		HAKBUN	= :as_hakbun
//	;
//	
//	if sqlca.sqlcode = 0 then
//		tab_1.tabpage_1.p_photo.visible = true
//		tab_1.tabpage_1.p_photo.setpicture(b_total_pic)
//	end if
//end if
//		
return 0
end function

on w_hsg320a.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_4=create st_4
this.tab_1=create tab_1
this.dw_print=create dw_print
this.uo_1=create uo_1
this.dw_con=create dw_con
this.uo_create=create uo_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.dw_print
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.dw_con
this.Control[iCurrent+7]=this.uo_create
end on

on w_hsg320a.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_4)
destroy(this.tab_1)
destroy(this.dw_print)
destroy(this.uo_1)
destroy(this.dw_con)
destroy(this.uo_create)
end on

event ue_retrieve;string ls_hakbun,  ls_name,   ls_gwa
long   ll_ans,     l_cnt

tab_1.tabpage_1.dw_main.SetTransobject(sqlca)

dw_con.accepttext()
ls_hakbun =  dw_con.object.hakbun[dw_con.getrow()]


tab_1.tabpage_2.dw_1.reset()
tab_1.tabpage_2.dw_2.reset()
tab_1.tabpage_2.dw_3.reset()
tab_1.tabpage_2.dw_4.reset()
tab_1.tabpage_3.dw_5.reset()
tab_1.tabpage_3.dw_6.reset()
tab_1.tabpage_3.dw_7.reset()

ls_gwa     = gstru_uid_uname.dept_code

IF ls_gwa  = '1200' OR ls_gwa = '1201' OR ls_gwa = '2902' THEN
	ls_gwa  = '%'
ELSE
	ls_gwa  = ls_gwa + '%'
END IF

SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM haksa.jaehak_hakjuk
 WHERE hakbun    = :ls_hakbun
   AND SUBSTR(gwa, 1, 3)    like SUBSTR(:ls_gwa, 1, 3);
IF l_cnt      = 1 THEN
	is_sangtae = '1'
END IF
IF l_cnt  = 0 THEN
	SELECT nvl(count(*), 0)
	  INTO :l_cnt
	  FROM haksa.jolup_hakjuk
	 WHERE hakbun    = :ls_hakbun
   	AND SUBSTR(gwa, 1, 3)    like SUBSTR(:ls_gwa, 1, 3);
	IF l_cnt      = 1 THEN
		is_sangtae = '2'
	END IF
END IF
IF l_cnt  = 0 THEN
	messagebox("알림", '해당 학번은 존재하지 않거나 조회할 권한이 없는 학과의 학번입니다.')
	return -1
//	tab_1.tabpage_1.dw_main.Object.DataWindow.ReadOnly="Yes"
//	tab_1.tabpage_2.dw_1.Object.DataWindow.ReadOnly="Yes"
//	tab_1.tabpage_2.dw_2.Object.DataWindow.ReadOnly="Yes"
//	tab_1.tabpage_2.dw_3.Object.DataWindow.ReadOnly="Yes"
//	tab_1.tabpage_2.dw_4.Object.DataWindow.ReadOnly="Yes"
//	tab_1.tabpage_3.dw_5.Object.DataWindow.ReadOnly="Yes"
//	tab_1.tabpage_3.dw_6.Object.DataWindow.ReadOnly="Yes"
//	tab_1.tabpage_3.dw_7.Object.DataWindow.ReadOnly="Yes"
ELSE
	tab_1.tabpage_1.dw_main.Object.DataWindow.ReadOnly="No"
	tab_1.tabpage_2.dw_1.Object.DataWindow.ReadOnly="No"
	tab_1.tabpage_2.dw_2.Object.DataWindow.ReadOnly="No"
	tab_1.tabpage_2.dw_3.Object.DataWindow.ReadOnly="No"
	tab_1.tabpage_2.dw_4.Object.DataWindow.ReadOnly="No"
	tab_1.tabpage_3.dw_5.Object.DataWindow.ReadOnly="No"
	tab_1.tabpage_3.dw_6.Object.DataWindow.ReadOnly="No"
	tab_1.tabpage_3.dw_7.Object.DataWindow.ReadOnly="No"
END IF
	
//tab_1.tabpage_1.p_photo.visible = false
ll_ans    = tab_1.tabpage_1.dw_main.retrieve(ls_hakbun)

wf_retrieve(ls_hakbun)

st_3.text      = ''

if ll_ans = 0 then
//	uf_messagebox(7)
   wf_insert(ls_hakbun)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

//if ll_ans  > 0 then
//	wf_image(ls_hakbun)
//end if
return 1
end event

event ue_save;int    li_ans,      ii,         jj,          i1,          i2,          kk
string ls_hakbun,   ls_sch_tp,  ls_sch_nm,   ls_sch_gwa,  ls_grd_tp,   ls_seq
String ls_sch_date, ls_ent_dt,  ls_ent_nm,   ls_compony,  ls_relation, ls_name
String ls_birthdt,  ls_sch_grd, ls_comnm,    ls_comgrade, ls_tel,      ls_zipcode
String ls_zipaddr,  ls_forecd,  ls_foregrd,  ls_teach,    ls_hakyun,   ls_context
String ls_dept,     ls_cname,   ls_ename,    ls_email,    ls_hp,       ls_boname
String ls_bojob,    ls_gwangye, ls_bogrd,    ls_zipcd,    ls_boaddr,   ls_botel
String ls_account,  ls_bank,    ls_gunbyul,  ls_yukjong,  ls_grade,    ls_gunbun
String ls_ipdate,   ls_jundate, ls_blood,    ls_chuimi,   ls_tukgi,    ls_jonggyo
String ls_intel,    ls_ingwa,   ls_inhname,  ls_outtel,   ls_outgwa,   ls_outhname
String ls_daehak,   ls_daehak1
DateTime ld_sch_date,   ld_ent_dt,   ld_birthdt,  ld_ipdate,  ld_jundate
Int    l_cnt
Long   ll_hakyun

ls_hakbun = tab_1.tabpage_1.dw_main.GetItemString(1, 'hakbun')

IF is_sangtae  = '1' THEN
	SELECT nvl(count(*), 0)
	  INTO :l_cnt
	  FROM haksa.jaehak_hakjuk
	 WHERE hakbun   = :ls_hakbun;
	IF l_cnt        = 0 THEN
		messagebox("저장", ls_hakbun + '학번은 재학 학적에 등록되지 않아 저장할 수 없습니다.')
		return -1
	END IF
ELSE
	SELECT nvl(count(*), 0)
	  INTO :l_cnt
	  FROM haksa.jolup_hakjuk
	 WHERE hakbun   = :ls_hakbun;
	IF l_cnt        = 0 THEN
		messagebox("저장", ls_hakbun + '학번은 졸업 학적에 등록되지 않아 저장할 수 없습니다.')
		return -1
	END IF
END IF

tab_1.tabpage_2.dw_1.AcceptText()
tab_1.tabpage_2.dw_2.AcceptText()
tab_1.tabpage_2.dw_3.AcceptText()
tab_1.tabpage_2.dw_4.AcceptText()
tab_1.tabpage_3.dw_5.AcceptText()
tab_1.tabpage_3.dw_6.AcceptText()
tab_1.tabpage_3.dw_7.AcceptText()

li_ans    = tab_1.tabpage_1.dw_main.update()
if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback;
end if

SetPointer(HourGlass!)

DELETE FROM HAKSA.SUM230TL
 WHERE hakbun = :ls_hakbun;

jj            = 0
FOR ii        = 1 TO tab_1.tabpage_2.dw_1.RowCount()
	 ls_sch_tp      = tab_1.tabpage_2.dw_1.GetItemString(ii, 'school_tp')
	 ld_sch_date    = tab_1.tabpage_2.dw_1.GetItemDateTime(ii, 'school_date')
	 ls_sch_nm      = tab_1.tabpage_2.dw_1.GetItemString(ii, 'school_nm')
	 ls_sch_gwa     = tab_1.tabpage_2.dw_1.GetItemString(ii, 'school_gwa')
	 ls_grd_tp      = tab_1.tabpage_2.dw_1.GetItemString(ii, 'grd_tp')
	 IF isnull(ls_sch_tp) OR ls_sch_tp = '' THEN
	 ELSE
		 jj          = jj  +  1
		 ls_seq      = string(jj, '0')
		 INSERT INTO HAKSA.SUM230TL(hakbun,       seq,        school_tp,     school_date,
											 school_nm,    grd_tp,     school_gwa,    worker,
											 ipaddr,                   work_date)
								 VALUES  (:ls_hakbun,   :ls_seq,    :ls_sch_tp,    :ld_sch_date,
											 :ls_sch_nm,   :ls_grd_tp, :ls_sch_gwa,   :gstru_uid_uname.uid,
											 :gstru_uid_uname.address, sysdate);
					IF sqlca.sqlcode <> 0 THEN
						messagebox("저장", '출신학교 저장중 오류' + sqlca.sqlerrtext)
						rollback;
						return -1
				   END IF
	 END IF
NEXT

DELETE FROM HAKSA.SUM260TL
 WHERE hakbun = :ls_hakbun;

jj            = 0
FOR ii        = 1 TO tab_1.tabpage_2.dw_2.RowCount()
	 ld_ent_dt      = tab_1.tabpage_2.dw_2.GetItemDateTime(ii, 'ent_dt')
	 ls_ent_nm      = tab_1.tabpage_2.dw_2.GetItemString(ii, 'ent_nm')
	 ls_compony     = tab_1.tabpage_2.dw_2.GetItemString(ii, 'ent_compony')
	 IF isnull(ls_ent_nm) OR ls_ent_nm = '' THEN
	 ELSE
		 jj          = jj  +  1
		 ls_seq      = string(jj, '0')
		 INSERT INTO HAKSA.SUM260TL(hakbun,       seq,        ent_dt,        ent_nm,
											 ent_compony,  worker,
											 ipaddr,                   work_date)
								 VALUES  (:ls_hakbun,   :ls_seq,    :ld_ent_dt,    :ls_ent_nm,
											 :ls_compony,  :gstru_uid_uname.uid,
											 :gstru_uid_uname.address, sysdate);
					IF sqlca.sqlcode <> 0 THEN
						messagebox("저장", '자격증 저장중 오류' + sqlca.sqlerrtext)
						rollback;
						return -1
				   END IF
	 END IF
NEXT
IF jj     = 0 THEN
	INSERT INTO HAKSA.SUM260TL(hakbun,       seq,        ent_dt,        ent_nm,
										ent_compony,  worker,
										ipaddr,                   work_date)
							 VALUES (:ls_hakbun,   '1',        '',            '',
										'',           :gstru_uid_uname.uid,
										:gstru_uid_uname.address, sysdate);
END IF

DELETE FROM SUM270TL
 WHERE hakbun = :ls_hakbun;

jj            = 0
FOR ii        = 1 TO tab_1.tabpage_2.dw_3.RowCount()
	 ls_relation    = tab_1.tabpage_2.dw_3.GetItemString(ii, 'relation')
	 ls_name        = tab_1.tabpage_2.dw_3.GetItemString(ii, 'name')
	 ld_birthdt     = tab_1.tabpage_2.dw_3.GetItemDateTime(ii, 'birth_dt')
	 ls_sch_grd     = tab_1.tabpage_2.dw_3.GetItemString(ii, 'school_grd')
	 ls_comnm       = tab_1.tabpage_2.dw_3.GetItemString(ii, 'com_nm')
	 ls_comgrade    = tab_1.tabpage_2.dw_3.GetItemString(ii, 'com_grade')
	 ls_tel         = tab_1.tabpage_2.dw_3.GetItemString(ii, 'tel')
	 ls_zipcode     = tab_1.tabpage_2.dw_3.GetItemString(ii, 'zip_code')
	 ls_zipaddr     = tab_1.tabpage_2.dw_3.GetItemString(ii, 'zip_addr')
	 IF isnull(ls_relation) OR ls_relation = '' THEN
	 ELSE
		 jj          = jj  +  1
		 ls_seq      = string(jj, '0')
		 INSERT INTO HAKSA.SUM270TL(hakbun,       seq,        relation,      fa_name,
											 birth_dt,     school_grd, com_nm,        com_grade,
											 tel,          zip_code,   zip_addr,
											 worker,
											 ipaddr,                   work_date)
								 VALUES  (:ls_hakbun,   :ls_seq,    :ls_relation,  :ls_name,
											 :ld_birthdt,  :ls_sch_grd,:ls_comnm,     :ls_comgrade,
											 :ls_tel,      :ls_zipcode,:ls_zipaddr,
											 :gstru_uid_uname.uid,
											 :gstru_uid_uname.address, sysdate);
					IF sqlca.sqlcode <> 0 THEN
						messagebox("저장", '가족관계 저장중 오류' + sqlca.sqlerrtext)
						rollback;
						return -1
				   END IF
	 END IF
NEXT
IF jj     = 0 THEN
	INSERT INTO HAKSA.SUM270TL(hakbun,       seq,        relation,      fa_name,
										birth_dt,     school_grd, com_nm,        com_grade,
										tel,          zip_code,   zip_addr,
										worker,
										ipaddr,                   work_date)
							 VALUES (:ls_hakbun,   '1',        '',            '',
										'',           '',         '',            '',
										'',           '',         '',
										:gstru_uid_uname.uid,
										:gstru_uid_uname.address, sysdate);
					IF sqlca.sqlcode <> 0 THEN
						messagebox("저장", '가족관계 저장중 오류2' + sqlca.sqlerrtext)
						rollback;
						return -1
				   END IF
END IF

DELETE FROM SUM240TL
 WHERE hakbun = :ls_hakbun;

jj            = 0
FOR ii        = 1 TO tab_1.tabpage_2.dw_4.RowCount()
	 ls_forecd      = tab_1.tabpage_2.dw_4.GetItemString(ii, 'fore_cd')
	 ls_foregrd     = tab_1.tabpage_2.dw_4.GetItemString(ii, 'fore_grade')
	 IF isnull(ls_forecd) OR ls_forecd = '' THEN
	 ELSE
		 jj          = jj  +  1
		 ls_seq      = string(jj, '0')
		 INSERT INTO HAKSA.SUM240TL(hakbun,       seq,        fore_cd,       fore_grade,
											 worker,
											 ipaddr,                   work_date)
								 VALUES  (:ls_hakbun,   :ls_seq,    :ls_forecd,    :ls_foregrd,
											 :gstru_uid_uname.uid,
											 :gstru_uid_uname.address, sysdate);
					IF sqlca.sqlcode <> 0 THEN
						messagebox("저장", '외국어구사능력 저장중 오류' + sqlca.sqlerrtext)
						rollback;
						return -1
				   END IF
	 END IF
NEXT

DELETE FROM SUM280TL
 WHERE hakbun = :ls_hakbun;

jj            = 0
FOR ii        = 1 TO tab_1.tabpage_3.dw_5.RowCount()
	 ls_teach       = tab_1.tabpage_3.dw_5.GetItemString(ii, 'teach_cd')
	 ll_hakyun      = tab_1.tabpage_3.dw_5.GetItemNumber(ii, 'dr_hakyun')
	 ls_context     = tab_1.tabpage_3.dw_5.GetItemString(ii, 'context')
	 jj          = jj  +  1
	 ls_seq      = string(jj, '0')
	 INSERT INTO HAKSA.SUM280TL(hakbun,       seq,        teach_cd,      dr_hakyun,
										 context,      worker,
										 ipaddr,                   work_date)
							 VALUES  (:ls_hakbun,   :ls_seq,    :ls_teach,     :ll_hakyun,
										 :ls_context,  :gstru_uid_uname.uid,
										 :gstru_uid_uname.address, sysdate);
				IF sqlca.sqlcode <> 0 THEN
					messagebox("저장", '지도사항 저장중 오류' + sqlca.sqlerrtext)
					rollback;
					return -1
				END IF
NEXT

DELETE FROM SUM250TL
 WHERE hakbun  = :ls_hakbun
   AND area_tp = '1';

i1            = 0
jj            = 0
FOR ii        = 1 TO tab_1.tabpage_3.dw_6.RowCount()
	 ls_name        = tab_1.tabpage_3.dw_6.GetItemString(ii, 'name')
	 ls_zipcode     = tab_1.tabpage_3.dw_6.GetItemString(ii, 'zip_code')
	 ls_zipaddr     = tab_1.tabpage_3.dw_6.GetItemString(ii, 'zip_addr')
	 ls_tel         = tab_1.tabpage_3.dw_6.GetItemString(ii, 'tel')
	 ls_dept        = tab_1.tabpage_3.dw_6.GetItemString(ii, 'dept')
	 jj          = jj  +  1
	 ls_seq      = string(jj, '0')
 	 IF isnull(ls_name) OR ls_name = '' THEN
	 ELSE
		 i1       = i1 + 1
		 IF i1    = 1 THEN
			 ls_ingwa     = ls_dept
			 ls_inhname   = ls_name
			 ls_intel     = ls_tel
		 END IF
		 INSERT INTO HAKSA.SUM250TL(hakbun,       seq,        area_tp,       name,
											 zip_code,     zip_addr,   tel,           dept,
											 worker,
											 ipaddr,                   work_date)
								 VALUES  (:ls_hakbun,   :ls_seq,    '1',           :ls_name,
											 :ls_zipcode,  :ls_zipaddr,:ls_tel,       :ls_dept,
											 :gstru_uid_uname.uid,
											 :gstru_uid_uname.address, sysdate);
					IF sqlca.sqlcode <> 0 THEN
						messagebox("저장", '교내친구 저장중 오류' + sqlca.sqlerrtext)
						rollback;
						return -1
					END IF
	 END IF
NEXT
IF i1     = 0 THEN
	INSERT INTO HAKSA.SUM250TL(hakbun,       seq,        area_tp,       name,
										zip_code,     zip_addr,   tel,           dept,
										worker,
										ipaddr,                   work_date)
							 VALUES (:ls_hakbun,   '1',        '1',           '',
										'',           '',         '',            '',
										:gstru_uid_uname.uid,
										:gstru_uid_uname.address, sysdate);
					IF sqlca.sqlcode <> 0 THEN
						messagebox("저장", '교내친구 저장중 오류2' + sqlca.sqlerrtext)
						rollback;
						return -1
					END IF
END IF

DELETE FROM SUM250TL
 WHERE hakbun  = :ls_hakbun
   AND area_tp = '2';

i2            = 0
FOR ii        = 1 TO tab_1.tabpage_3.dw_7.RowCount()
	 ls_name        = tab_1.tabpage_3.dw_7.GetItemString(ii, 'name')
	 ls_zipcode     = tab_1.tabpage_3.dw_7.GetItemString(ii, 'zip_code')
	 ls_zipaddr     = tab_1.tabpage_3.dw_7.GetItemString(ii, 'zip_addr')
	 ls_tel         = tab_1.tabpage_3.dw_7.GetItemString(ii, 'tel')
	 ls_dept        = tab_1.tabpage_3.dw_7.GetItemString(ii, 'dept')
	 ls_daehak      = tab_1.tabpage_3.dw_7.GetItemString(ii, 'daehak')
	 jj          = jj  +  1
	 ls_seq      = string(jj, '0')
 	 IF isnull(ls_name) OR ls_name = '' THEN
	 ELSE
		 i2       = i2 + 1
		 IF i2    = 1 THEN
			 ls_outgwa    = ls_dept
			 ls_outhname  = ls_name
			 ls_outtel    = ls_tel
			 ls_daehak1   = ls_daehak
		 END IF
		 INSERT INTO HAKSA.SUM250TL(hakbun,       seq,        area_tp,       name,
											 zip_code,     zip_addr,   tel,           dept,
											 daehak,       worker,
											 ipaddr,                   work_date)
								 VALUES  (:ls_hakbun,   :ls_seq,    '2',           :ls_name,
											 :ls_zipcode,  :ls_zipaddr,:ls_tel,       :ls_dept,
											 :ls_daehak,   :gstru_uid_uname.uid,
											 :gstru_uid_uname.address, sysdate);
					IF sqlca.sqlcode <> 0 THEN
						messagebox("저장", '교외친구 저장중 오류' + sqlca.sqlerrtext)
						rollback;
						return -1
					END IF
	 END IF
NEXT
IF i2     = 0 THEN
	INSERT INTO HAKSA.SUM250TL(hakbun,       seq,        area_tp,       name,
										zip_code,     zip_addr,   tel,           dept,
										worker,
										ipaddr,                   work_date)
							 VALUES (:ls_hakbun,   '4',        '2',           '',
										'',           '',         '',            '',
										:gstru_uid_uname.uid,
										:gstru_uid_uname.address, sysdate);
					IF sqlca.sqlcode <> 0 THEN
						messagebox("저장", '교외친구 저장중 오류2' + sqlca.sqlerrtext)
						rollback;
						return -1
					END IF
END IF

ls_cname   = tab_1.tabpage_1.dw_main.GetItemString(1, 'cname')
ls_ename   = tab_1.tabpage_1.dw_main.GetItemString(1, 'ename')
ls_email   = tab_1.tabpage_1.dw_main.GetItemString(1, 'email')
ls_tel     = tab_1.tabpage_1.dw_main.GetItemString(1, 'tel')
ls_hp      = tab_1.tabpage_1.dw_main.GetItemString(1, 'hp')
ls_boname  = tab_1.tabpage_1.dw_main.GetItemString(1, 'ft_name')
ls_bojob   = tab_1.tabpage_1.dw_main.GetItemString(1, 'ft_job')
ls_gwangye = tab_1.tabpage_1.dw_main.GetItemString(1, 'ft_relation')
ls_bogrd   = tab_1.tabpage_1.dw_main.GetItemString(1, 'ft_school_grd')
ls_zipcd   = tab_1.tabpage_1.dw_main.GetItemString(1, 'ft_zip_code')
ls_boaddr  = tab_1.tabpage_1.dw_main.GetItemString(1, 'ft_zip_addr')
ls_botel   = tab_1.tabpage_1.dw_main.GetItemString(1, 'ft_cel_hp')
ls_account = tab_1.tabpage_1.dw_main.GetItemString(1, 'account_cd')
ls_bank    = tab_1.tabpage_1.dw_main.GetItemString(1, 'account_bank')
ls_gunbyul = tab_1.tabpage_1.dw_main.GetItemString(1, 'mil_kind')
ls_yukjong = tab_1.tabpage_1.dw_main.GetItemString(1, 'mil_kind_tp')
ls_grade   = tab_1.tabpage_1.dw_main.GetItemString(1, 'mil_grd')
ls_gunbun  = tab_1.tabpage_1.dw_main.GetItemString(1, 'mil_no')
ls_ipdate  = String(tab_1.tabpage_1.dw_main.GetItemDateTime(1, 'mil_ipdae_date'), 'YYYYMMDD')
ls_jundate = string(tab_1.tabpage_1.dw_main.GetItemDateTime(1, 'mil_jukyuk_date'), 'YYYYMMDD')
ls_blood   = tab_1.tabpage_1.dw_main.GetItemString(1, 'blood')
ls_chuimi  = tab_1.tabpage_1.dw_main.GetItemString(1, 'fa_skill')
ls_tukgi   = tab_1.tabpage_1.dw_main.GetItemString(1, 'special')
ls_jonggyo = tab_1.tabpage_1.dw_main.GetItemString(1, 'reglion')

IF is_sangtae = '1' THEN
	UPDATE haksa.jaehak_hakjuk
		SET cname         = :ls_cname,
			 ename         = :ls_ename,
			 tel           = :ls_tel,
			 hp            = :ls_hp,
			 email         = :ls_email,
			 bo_zip_id     = :ls_zipcd,
			 bo_addr       = :ls_boaddr,
			 bo_tel        = :ls_botel,
			 bo_name       = :ls_boname,
			 bo_gwangye    = :ls_gwangye,
			 bo_job        = :ls_bojob,
			 bo_grade      = :ls_bogrd,
			 gunbun        = :ls_gunbun,
			 ipdae_date    = :ls_ipdate,
			 junyuk_date   = :ls_jundate,
			 yukjong_id    = :ls_yukjong,
			 gunbyul_id    = :ls_gunbyul,
			 grade_id      = :ls_grade,
			 bank_id       = :ls_bank,
			 account_no    = :ls_account
	 WHERE hakbun        = :ls_hakbun;
	
	SELECT nvl(count(*), 0)
	  INTO :l_cnt
	  FROM haksa.jaehak_sinsang
	 WHERE hakbun        = :ls_hakbun;
	
	IF l_cnt             = 0 THEN
		INSERT INTO haksa.jaehak_sinsang (hakbun,      blood,        chuimi,      tukgi,
													 jonggyo,     in_gwa,       in_hname,    in_tel,
													 out_gwa,     out_hname,    out_tel,     out_daehak,
													 worker,
													 ipaddr,      work_date)
										VALUES   (:ls_hakbun,  :ls_blood,    :ls_chuimi,  :ls_tukgi,
													 :ls_jonggyo, :ls_ingwa,    :ls_inhname, :ls_intel,
													 :ls_outgwa,  :ls_outhname, :ls_outtel,  :ls_daehak1,
													 :gstru_uid_uname.uid,
													 :gstru_uid_uname.address,  sysdate);
						IF sqlca.sqlcode <> 0 THEN
							messagebox("저장", '재학생신상 저장중 오류' + sqlca.sqlerrtext)
							rollback;
							return -1
						END IF
	ELSE
		UPDATE haksa.jaehak_sinsang
			SET blood         = :ls_blood,
				 chuimi        = :ls_chuimi,
				 tukgi         = :ls_tukgi,
				 jonggyo       = :ls_jonggyo,
				 in_gwa        = :ls_ingwa,
				 in_hname      = :ls_inhname,
				 in_tel        = :ls_intel,
				 out_gwa       = :ls_outgwa,
				 out_hname     = :ls_outhname,
				 out_tel       = :ls_outtel,
				 out_daehak    = :ls_daehak1
		 WHERE hakbun        = :ls_hakbun;
		IF sqlca.sqlcode <> 0 THEN
			messagebox("저장", '재학생신상 수정중 오류' + sqlca.sqlerrtext)
			rollback;
			return -1
		END IF
	END IF
ELSEIF is_sangtae = '2' THEN
	UPDATE haksa.jolup_hakjuk
		SET cname         = :ls_cname,
			 ename         = :ls_ename,
			 tel           = :ls_tel,
			 hp            = :ls_hp,
			 email         = :ls_email,
			 bo_zip_id     = :ls_zipcd,
			 bo_addr       = :ls_boaddr,
			 bo_tel        = :ls_botel,
			 bo_name       = :ls_boname,
			 bo_gwangye    = :ls_gwangye,
			 bo_job        = :ls_bojob,
			 bo_grade      = :ls_bogrd,
			 gunbun        = :ls_gunbun,
			 ipdae_date    = :ls_ipdate,
			 junyuk_date   = :ls_jundate,
			 yukjong_id    = :ls_yukjong,
			 gunbyul_id    = :ls_gunbyul,
			 grade_id      = :ls_grade,
			 bank_id       = :ls_bank,
			 account_no    = :ls_account
	 WHERE hakbun        = :ls_hakbun;
	
	SELECT nvl(count(*), 0)
	  INTO :l_cnt
	  FROM haksa.jolup_sinsang
	 WHERE hakbun        = :ls_hakbun;
	
	IF l_cnt             = 0 THEN
		INSERT INTO haksa.jolup_sinsang (hakbun,      blood,        chuimi,      tukgi,
													 jonggyo,     in_gwa,       in_hname,    in_tel,
													 out_gwa,     out_hname,    out_tel,     out_daehak,
													 worker,
													 ipaddr,      work_date)
										VALUES   (:ls_hakbun,  :ls_blood,    :ls_chuimi,  :ls_tukgi,
													 :ls_jonggyo, :ls_ingwa,    :ls_inhname, :ls_intel,
													 :ls_outgwa,  :ls_outhname, :ls_outtel,  :ls_daehak1,
													 :gstru_uid_uname.uid,
													 :gstru_uid_uname.address,  sysdate);
						IF sqlca.sqlcode <> 0 THEN
							messagebox("저장", '졸업생신상 저장중 오류' + sqlca.sqlerrtext)
							rollback;
							return -1
						END IF
	ELSE
		UPDATE haksa.jolup_sinsang
			SET blood         = :ls_blood,
				 chuimi        = :ls_chuimi,
				 tukgi         = :ls_tukgi,
				 jonggyo       = :ls_jonggyo,
				 in_gwa        = :ls_ingwa,
				 in_hname      = :ls_inhname,
				 in_tel        = :ls_intel,
				 out_gwa       = :ls_outgwa,
				 out_hname     = :ls_outhname,
				 out_tel       = :ls_outtel,
				 out_daehak    = :ls_daehak1
		 WHERE hakbun        = :ls_hakbun;
		IF sqlca.sqlcode <> 0 THEN
			messagebox("저장", '졸업생신상 수정중 오류' + sqlca.sqlerrtext)
			rollback;
			return -1
		END IF
	END IF
END IF
 
commit;

//저장확인 메세지 출력
uf_messagebox(2)


end event

event open;call super::open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	FALSE)
//wf_setmenu('DELETE', 	FALSE)
//wf_setmenu('SAVE', 		TRUE)
//wf_setmenu('PRINT', 		TRUE)
end event

event ue_open;call super::ue_open;func.of_design_con( dw_con )

dw_con.insertrow(0)
tab_1.tabpage_1.dw_main.InsertRow(0)

idw_print = dw_print
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "학생환경기록카드")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_condition_window`ln_templeft within w_hsg320a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsg320a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsg320a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsg320a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsg320a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsg320a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsg320a
end type

type uc_insert from w_condition_window`uc_insert within w_hsg320a
end type

type uc_delete from w_condition_window`uc_delete within w_hsg320a
end type

type uc_save from w_condition_window`uc_save within w_hsg320a
end type

type uc_excel from w_condition_window`uc_excel within w_hsg320a
end type

type uc_print from w_condition_window`uc_print within w_hsg320a
end type

type st_line1 from w_condition_window`st_line1 within w_hsg320a
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_condition_window`st_line2 within w_hsg320a
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_condition_window`st_line3 within w_hsg320a
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsg320a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsg320a
end type

type gb_1 from w_condition_window`gb_1 within w_hsg320a
integer height = 192
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_2 from w_condition_window`gb_2 within w_hsg320a
integer y = 192
integer height = 2320
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_3 from statictext within w_hsg320a
integer x = 1061
integer y = 64
integer width = 1157
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_hsg320a
boolean visible = false
integer x = 23
integer y = 1596
integer width = 3831
integer height = 908
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type tab_1 from tab within w_hsg320a
event create ( )
event destroy ( )
integer x = 50
integer y = 348
integer width = 4384
integer height = 1936
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1816
string text = "기본사항"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_main dw_main
end type

on tabpage_1.create
this.dw_main=create dw_main
this.Control[]={this.dw_main}
end on

on tabpage_1.destroy
destroy(this.dw_main)
end on

type dw_main from datawindow within tabpage_1
integer y = 8
integer width = 4338
integer height = 1804
integer taborder = 10
string title = "기본사항"
string dataobject = "d_hsg320a_1"
boolean border = false
boolean livescroll = true
end type

event itemfocuschanged;This.SelectText(1, 100)
end event

event clicked;String ls_param,   ls_zip_id,   ls_addr
Int    li_len

CHOOSE CASE dwo.name
	case	'b_1'
		Open(w_zipcode)
		
		ls_param    = Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		tab_1.tabpage_1.dw_main.setitem(1, "bonjuk_zip_code" , ls_zip_id)
		tab_1.tabpage_1.dw_main.setitem(1, "bonjuk_zip_addr" , ls_addr)
		
		tab_1.tabpage_1.dw_main.setcolumn("bonjuk_zip_addr")
	case	'b_2'
		Open(w_zipcode)
		
		ls_param    = Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		tab_1.tabpage_1.dw_main.setitem(1, "zip_code" , ls_zip_id)
		tab_1.tabpage_1.dw_main.setitem(1, "zip_addr" , ls_addr)
		
		tab_1.tabpage_1.dw_main.setcolumn("zip_addr")
	case	'b_3'
		Open(w_zipcode)
		
		ls_param    = Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		tab_1.tabpage_1.dw_main.setitem(1, "house_zip_code" , ls_zip_id)
		tab_1.tabpage_1.dw_main.setitem(1, "house_zip_addr" , ls_addr)
		
		tab_1.tabpage_1.dw_main.setcolumn("house_zip_addr")
	case	'b_4'
		Open(w_zipcode)
		
		ls_param    = Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		tab_1.tabpage_1.dw_main.setitem(1, "ft_zip_code" , ls_zip_id)
		tab_1.tabpage_1.dw_main.setitem(1, "ft_zip_addr" , ls_addr)
		
		tab_1.tabpage_1.dw_main.setcolumn("ft_zip_addr")
END CHOOSE
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1816
string text = "출신학교,자격증,가족,외국어"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type

on tabpage_2.create
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1}
end on

on tabpage_2.destroy
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type dw_4 from uo_dwgrid within tabpage_2
integer x = 3200
integer y = 8
integer width = 1143
integer height = 884
integer taborder = 30
boolean titlebar = true
string title = "외국어"
string dataobject = "d_hsg320a_5"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 100)
end event

type dw_3 from uo_dwgrid within tabpage_2
integer y = 892
integer width = 4343
integer height = 860
integer taborder = 40
boolean titlebar = true
string title = "가족관계"
string dataobject = "d_hsg320a_4"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;String ls_param,   ls_zip_id,   ls_addr
Int    li_len

CHOOSE CASE dwo.name
	case	'b_1'
		Open(w_zipcode)
		
		ls_param    = Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		tab_1.tabpage_2.dw_3.setitem(row, "zip_code" , ls_zip_id)
		tab_1.tabpage_2.dw_3.setitem(row, "zip_addr" , ls_addr)
		
		tab_1.tabpage_2.dw_3.SetColumn('zip_addr')
      tab_1.tabpage_2.dw_3.SetFocus()
      tab_1.tabpage_2.dw_3.ScrollToRow(row)
END CHOOSE
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 100)
end event

type dw_2 from uo_dwgrid within tabpage_2
integer y = 444
integer width = 3186
integer height = 452
integer taborder = 30
boolean titlebar = true
string title = "자격증"
string dataobject = "d_hsg320a_3"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 100)
end event

type dw_1 from uo_dwgrid within tabpage_2
integer y = 8
integer width = 3186
integer height = 440
integer taborder = 20
boolean titlebar = true
string title = "출신학교"
string dataobject = "d_hsg320a_2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 100)
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1816
string text = "교우,지도사항"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_7 dw_7
dw_6 dw_6
dw_5 dw_5
end type

on tabpage_3.create
this.dw_7=create dw_7
this.dw_6=create dw_6
this.dw_5=create dw_5
this.Control[]={this.dw_7,&
this.dw_6,&
this.dw_5}
end on

on tabpage_3.destroy
destroy(this.dw_7)
destroy(this.dw_6)
destroy(this.dw_5)
end on

type dw_7 from uo_dwgrid within tabpage_3
integer y = 1324
integer width = 4343
integer height = 468
integer taborder = 70
boolean titlebar = true
string title = "교외친구"
string dataobject = "d_hsg320a_8"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;String ls_param,   ls_zip_id,   ls_addr
Int    li_len

CHOOSE CASE dwo.name
	case	'b_1'
		Open(w_zipcode)
		
		ls_param    = Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		tab_1.tabpage_3.dw_7.setitem(row, "zip_code" , ls_zip_id)
		tab_1.tabpage_3.dw_7.setitem(row, "zip_addr" , ls_addr)
		
		tab_1.tabpage_3.dw_7.SetColumn('zip_addr')
      tab_1.tabpage_3.dw_7.SetFocus()
      tab_1.tabpage_3.dw_7.ScrollToRow(row)
END CHOOSE
end event

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 100)
end event

type dw_6 from uo_dwgrid within tabpage_3
integer y = 856
integer width = 4343
integer height = 468
integer taborder = 60
boolean titlebar = true
string title = "교내친구"
string dataobject = "d_hsg320a_7"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 100)
end event

event clicked;call super::clicked;String ls_param,   ls_zip_id,   ls_addr
Int    li_len

CHOOSE CASE dwo.name
	case	'b_1'
		Open(w_zipcode)
		
		ls_param    = Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		tab_1.tabpage_3.dw_6.setitem(row, "zip_code" , ls_zip_id)
		tab_1.tabpage_3.dw_6.setitem(row, "zip_addr" , ls_addr)
		
		tab_1.tabpage_3.dw_6.SetColumn('zip_addr')
      tab_1.tabpage_3.dw_6.SetFocus()
      tab_1.tabpage_3.dw_6.ScrollToRow(row)
END CHOOSE
end event

type dw_5 from uo_dwgrid within tabpage_3
integer y = 12
integer width = 4343
integer height = 844
integer taborder = 50
boolean titlebar = true
string title = "지도사항"
string dataobject = "d_hsg320a_6"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_print from datawindow within w_hsg320a
boolean visible = false
integer x = 3026
integer width = 686
integer height = 400
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hsg130p_1"
boolean border = false
boolean livescroll = true
end type

type uo_1 from u_tab within w_hsg320a
integer x = 1655
integer y = 300
integer taborder = 40
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type dw_con from uo_dw within w_hsg320a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 20
string dataobject = "d_hsg320a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_hakbun
This.accepttext()
ls_KName =  trim(this.object.kname[1])



OpenWithParm(w_hsg_hakjuk,ls_kname)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[2]	//성명
ls_hakbun            = lstr_com.ls_item[1]	//학번
this.object.kname[1]        = ls_kname					//성명
This.object.hakbun[1]     = ls_hakbun				//개인번호
Parent.post event ue_retrieve()	
return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_kname

This.accepttext()
Choose Case	dwo.name
	Case	'hakbun','kname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'kname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'kname'	, '')			
			RETURN
		End If
		
		SELECT HAKBUN, HNAME
		INTO :ls_hakbun , :ls_kname
		FROM  (	SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JAEHAK_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JOLUP_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.D_HAKJUK	A	)	A
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_kname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.hakbun[row] = ls_hakbun
			This.object.kname[row] = ls_kname
			Parent.post event ue_retrieve()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
End Choose


end event

type uo_create from uo_imgbtn within w_hsg320a
integer x = 46
integer y = 36
integer taborder = 60
boolean bringtotop = true
string btnname = "학생생활기록카드 일괄생성"
end type

on uo_create.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String ls_err

INSERT INTO HAKSA.SUM220TL
(    
    HAKBUN                   
       ,JUMIN_NO             
       ,GWA                  
       ,IPHAK_YEAR           
       ,HNAME                
       ,CNAME                
       ,ENAME                
       ,SEX     
      ,BIRTH_DT             
       ,ZIP_CODE              
       ,ZIP_ADDR              
       ,HOUSE_ZIP_CODE        
       ,HOUSE_ZIP_ADDR          
       ,TEL                     
       ,HOUSE_TEL               
       ,HP                      
       ,EMAIL                   
       ,ACCOUNT_CD              
       ,ACCOUNT_BANK            
      ,MIL_KIND                  
       ,MIL_KIND_TP               
       ,MIL_GRD                   
       ,MIL_NO                    
       ,MIL_IPDAE_DATE           
       ,MIL_JUKYUK_DATE          
       ,FT_NAME                   
       ,FT_JOB                    
       ,FT_SCHOOL_GRD             
       ,FT_RELATION               
       ,FT_ZIP_CODE               
       ,FT_ZIP_ADDR               
       ,FT_TEL                    
       ,AGE_YEAR                
      ,WORKER                    
       ,IPADDR                   
       ,WORK_DATE                 
       ,JOB_UID                   
       ,JOB_ADD                   
       ,JOB_DATE                
     )
SELECT 
        HAKBUN                    
       ,JUMIN_NO                  
       ,GWA                       
       ,(CASE WHEN IPHAK_DATE IS NOT NULL THEN SUBSTR(IPHAK_DATE, 1, 4) ELSE '' END)               
       ,HNAME                     
       ,CNAME                    
       ,ENAME                    
       ,SEX           
       ,(CASE WHEN JUMIN_NO IS NOT NULL THEN TO_DATE((SUBSTR(JUMIN_NO, 1, 2) || '/' || SUBSTR(JUMIN_NO, 3,2) || '/' || SUBSTR(JUMIN_NO, 5,2)))
               ELSE NULL END)            
        ,BO_ZIP_ID                 
       ,TRIM(BO_ADDR)                   
       ,ZIP_ID                    
       ,TRIM(ADDR)                      
        ,BO_TEL                   
       ,TEL                      
       ,HP                        
       ,EMAIL                     
       ,ACCOUNT_NO               
       ,BANK_ID                   
       ,SUBSTR(TRIM(GUNBYUL_ID), 1, 6)                     
       ,YUKJONG_ID               
       ,GRADE_ID                   
        ,GUNBUN                   
       ,(CASE WHEN IPDAE_DATE IS  NULL OR trim(ipdae_date) =  '' 
            OR HAKBUN = '20000002' OR NVL(LENGTH(TRIM(IPDAE_DATE)), 0) <> 8 THEN   NULL ELSE 
                TO_DATE(IPDAE_DATE) END)             
       ,(CASE WHEN JUNYUK_DATE IS  NULL OR trim(JUNYUK_DATE) =  '' OR HAKBUN IN ('99111035', '20000022', '20000026')
       OR NVL(LENGTH(TRIM(JUNYUK_DATE)), 0) <> 8 THEN  NULL
   ELSE  TO_DATE(JUNYUK_DATE) END)           
        ,BO_NAME                   
      ,BO_JOB                    
       ,BO_GRADE                  
          ,BO_GWANGYE                
        ,BO_ZIP_ID                 
       ,TRIM(BO_ADDR)                   
        ,BO_TEL                  
       ,TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER((CASE WHEN SUBSTR(JUMIN_NO, 7, 1) IN ('1','2','5', '6') THEN '19' || SUBSTR(JUMIN_NO, 1, 2)
            ELSE '20' || SUBSTR(JUMIN_NO, 1, 2) END) )
        ,:gs_empcode
        , :gs_ip
        ,sysdate
        ,:gs_empcode
        , :gs_ip
        ,sysdate                 
 FROM HAKSA.JAEHAK_HAKJUK A
 WHERE NOT EXISTS(SELECT 1 FROM HAKSA.SUM220TL
                        WHERE HAKBUN = A.HAKBUN) 
USING SQLCA;		    

If SQLCA.SQLCODE = 0 Then
	If SQLCA.SQLNROWS > 0 Then
		ls_err = String( SQLCA.SQLNROWS)
		Commit using sqlca;
		Messagebox("일괄 생성", ls_err + '건 학생생활기록카드 생성 완료!')
	Else
		Messagebox("일괄 생성",  '생성된 데이터가 없습니다.')
	End If
Else
	ls_err = sqlca.sqlerrtext
	ROLLBACK USING SQLCA;
	
	Messagebox("일괄 생성",  ls_err)
End If
end event

