$PBExportHeader$w_hfn_temp.srw
forward
global type w_hfn_temp from w_msheet
end type
type sle_hakbun from singlelineedit within w_hfn_temp
end type
type cb_7 from commandbutton within w_hfn_temp
end type
type st_1 from statictext within w_hfn_temp
end type
type cb_6 from commandbutton within w_hfn_temp
end type
type cb_5 from commandbutton within w_hfn_temp
end type
type cb_4 from commandbutton within w_hfn_temp
end type
type cb_3 from commandbutton within w_hfn_temp
end type
type cb_2 from commandbutton within w_hfn_temp
end type
type cb_1 from commandbutton within w_hfn_temp
end type
type dw_1 from datawindow within w_hfn_temp
end type
end forward

global type w_hfn_temp from w_msheet
sle_hakbun sle_hakbun
cb_7 cb_7
st_1 st_1
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_hfn_temp w_hfn_temp

type variables
long il_getrow

end variables

on w_hfn_temp.create
int iCurrent
call super::create
this.sle_hakbun=create sle_hakbun
this.cb_7=create cb_7
this.st_1=create st_1
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_hakbun
this.Control[iCurrent+2]=this.cb_7
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_6
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.cb_4
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_1
end on

on w_hfn_temp.destroy
call super::destroy
destroy(this.sle_hakbun)
destroy(this.cb_7)
destroy(this.st_1)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type ln_templeft from w_msheet`ln_templeft within w_hfn_temp
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn_temp
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn_temp
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn_temp
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn_temp
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn_temp
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn_temp
end type

type uc_insert from w_msheet`uc_insert within w_hfn_temp
end type

type uc_delete from w_msheet`uc_delete within w_hfn_temp
end type

type uc_save from w_msheet`uc_save within w_hfn_temp
end type

type uc_excel from w_msheet`uc_excel within w_hfn_temp
end type

type uc_print from w_msheet`uc_print within w_hfn_temp
end type

type st_line1 from w_msheet`st_line1 within w_hfn_temp
end type

type st_line2 from w_msheet`st_line2 within w_hfn_temp
end type

type st_line3 from w_msheet`st_line3 within w_hfn_temp
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn_temp
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn_temp
end type

type sle_hakbun from singlelineedit within w_hfn_temp
integer x = 626
integer y = 384
integer width = 526
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_7 from commandbutton within w_hfn_temp
integer x = 3205
integer y = 148
integer width = 558
integer height = 204
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "picture save"
end type

event clicked;blob 		lbb_photo, lbb_null_blob, lbb_b
string 	ls_hakbun, ls_docname, ls_named
integer 	li_FileNum, li_loops, li_ii, li_value
long 		ll_flen


ls_hakbun = trim(sle_hakbun.text)


li_value = GetFileSaveName("Select File", ls_docname, ls_named, "JPG", "JPG Files (*.jpg), *.jpg")

if li_value = 1 then
	li_FileNum = FileOpen(ls_docname, StreamMode!, Write!, LockWrite!, Replace!)
else
	return
end if


SELECTBLOB P_IMAGE INTO :lbb_photo FROM HAKSA.PHOTO WHERE HAKBUN = :ls_hakbun ;

if sqlca.sqlcode = 0 then
	ll_flen = len(lbb_photo)

	IF li_FileNum <> -1 THEN
		IF ll_flen > 32765 THEN
			IF Mod(ll_flen, 32765) = 0 THEN
				li_loops = ll_flen / 32765
				ll_flen = 0
			ELSE
				li_loops = (ll_flen / 32765) + 1
				ll_flen = Mod(ll_flen, 32765)
			END IF
		ELSE
			li_loops = 1
		END IF
		
		if li_loops = 1 then
			Filewrite(li_FileNum, lbb_photo)
		else
			FOR li_ii = 1 to li_loops
				if li_ii = li_loops then
					if ll_flen = 0 then
						lbb_b = blobmid(lbb_photo, ((li_ii - 1) * 32765) + 1, 32765)
					else
						lbb_b = blobmid(lbb_photo, ((li_ii - 1) * 32765) + 1, ll_flen)
					end if
				else
					lbb_b = blobmid(lbb_photo, ((li_ii - 1) * 32765) + 1, 32765)
				end if

				Filewrite(li_FileNum, lbb_b)
			NEXT
		end if
	END IF
	
	FileClose(li_FileNum)
	
end if

messagebox('확인', '저장완료')

end event

type st_1 from statictext within w_hfn_temp
integer x = 905
integer y = 396
integer width = 457
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
long bordercolor = 16711680
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_hfn_temp
integer x = 2615
integer y = 148
integer width = 558
integer height = 204
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "picture"
end type

event clicked;datetime	ldt_date
integer 	li_FileNum
string	ls_item_no, ls_item_stand_size
string 	ls_docname, ls_named
integer 	li_value
blob		lb_img
long		ll_count

li_value = GetFileSaveName("Select File", ls_docname, ls_named, "XLS", "Excel Files (*.xls), *.xls")

if li_value = 1 then
	li_FileNum = FileOpen(ls_docname, LineMode!, Write!, LockWrite!, Append!)
else
	return
end if

DECLARE stdb_cur CURSOR FOR  
SELECT 	ITEM_NO,		ITEM_STAND_SIZE,		WORK_DATE  
FROM 		STDB.HST026H  
WHERE		ITEM_STAND_SIZE = '모듈 ROLAND SC-88(중고)'
ORDER BY WORK_DATE ASC,   
         ITEM_NO ASC  ;
OPEN stdb_cur;
DO WHILE TRUE
	FETCH NEXT stdb_cur INTO :ls_item_no, :ls_item_stand_size, :ldt_date ;
	if sqlca.sqlcode <> 0 then exit
	
	SELECTBLOB	ITEM_IMG
	INTO			:lb_img
	FROM			STDB.HST026H  
	WHERE			ITEM_NO 				= :ls_item_no
	AND			ITEM_STAND_SIZE 	= :ls_item_stand_size
	;
	
	filewrite(li_FileNum, string(ldt_date) + '~t' + ls_item_no + '~t' + ls_item_stand_size + '~t' + string(long(lb_img)))
	
	ll_count ++
	st_1.text = string(ll_count)
LOOP
CLOSE stdb_cur;


fileclose(li_FileNum)

messagebox('ok', 'complete!')

end event

type cb_5 from commandbutton within w_hfn_temp
integer x = 206
integer y = 240
integer width = 539
integer height = 116
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "배정에산(<>)"
end type

event clicked;double acct_class, temp_gyul_amt, real_gyul_amt, temp_jun_amt, real_jun_amt
string gwa, acct_code, slip_class
                                            
declare hac012m_cur cursor for														  
select 	aaa.acct_class					acct_class,
			aaa.gwa							gwa,
			aaa.acct_code					acct_code,
			aaa.slip_class					slip_class,
			sum(aaa.temp_gyul_amt)		temp_gyul_amt,
			sum(aaa.real_gyul_amt)		real_gyul_amt,
			sum(aaa.temp_jun_amt)		temp_jun_amt,
			sum(aaa.real_jun_amt)		real_jun_amt
from	(
		select	a.acct_class            acct_class,
					a.bdgt_year             bdgt_year,
					a.resol_gwa					gwa,
					b.acct_code					acct_code,
					to_char(a.slip_class)	slip_class,
					sum(b.resol_amt)			temp_gyul_amt,
					0								real_gyul_amt,
					0								temp_bae_amt,
					0								real_bae_amt,
					0								temp_jun_amt,
					0								real_jun_amt
		from 		fndb.hfn101m a, fndb.hfn102m b
		where 	a.resol_date||a.resol_no = b.resol_date||b.resol_no
		and		a.bdgt_year = 		'2004'
		and		a.step_opt	<>      '5'
		group by a.acct_class, a.bdgt_year, a.resol_gwa, b.acct_code, a.slip_class
		union
		select 	a.acct_class            acct_class,
					a.bdgt_year             bdgt_year,
					a.resol_gwa					gwa,
					b.acct_code					acct_code,
					to_char(a.slip_class)	slip_class,
					0								temp_gyul_amt,
					sum(b.resol_amt)			real_gyul_amt, 
					0								temp_bae_amt,
					0								real_bae_amt,
					0								temp_jun_amt,
					0								real_jun_amt
		from 		fndb.hfn101m a, fndb.hfn102m b
		where 	a.resol_date||a.resol_no = b.resol_date||b.resol_no
		and		a.bdgt_year = 		'2004'
		and		a.step_opt	= 		'5'
		group by a.acct_class, a.bdgt_year, a.resol_gwa, b.acct_code, a.slip_class
		union
		select	acct_class              acct_class,
					bdgt_year               bdgt_year,
					gwa							gwa,
					acct_code					acct_code,
					io_gubun						slip_class,
					0								temp_gyul_amt,
					0								real_gyul_amt, 
					nvl(assn_temp_amt,0)		temp_bae_amt,
					nvl(assn_real_amt,0)		real_bae_amt,
					0								temp_jun_amt,
					0								real_jun_amt
		from		acdb.hac012m
		where		bdgt_year	=		'2004'
		union
		select 	a.acct_class            acct_class,
					a.bdgt_year             bdgt_year,
					a.slip_gwa					gwa,
					b.acct_code					acct_code,
					to_char(a.slip_class)	slip_class,
					0								temp_gyul_amt,
					0								real_gyul_amt,
					0								temp_bae_amt,
					0								real_bae_amt,
					sum(b.slip_amt)			temp_jun_amt,
					0								real_jun_amt
		from 		fndb.hfn201m a, fndb.hfn202m b
		where 	a.slip_date||a.slip_no = b.slip_date||b.slip_no
		and		a.bdgt_year = 		'2004'
		and		a.step_opt	<> 	'5'
		and		a.resol_date is null		/*전표등록한것만*/
		group by a.acct_class, a.bdgt_year, a.slip_gwa, b.acct_code, a.slip_class
		union
		select 	a.acct_class            acct_class,
					a.bdgt_year             bdgt_year,
					a.slip_gwa					gwa,
					b.acct_code					acct_code,
					to_char(a.slip_class)	slip_class,
					0								temp_gyul_amt,
					0								real_gyul_amt, 
					0								temp_bae_amt,
					0								real_bae_amt,
					0								temp_jun_amt,
					sum(b.slip_amt)			real_jun_amt
		from 		fndb.hfn201m a, fndb.hfn202m b
		where 	a.slip_date||a.slip_no = b.slip_date||b.slip_no
		and		a.bdgt_year = 		'2004'
		and		a.step_opt	= 		'5'
		and		a.resol_date is null		/*전표등록한것만*/
		group by a.acct_class, a.bdgt_year, a.slip_gwa, b.acct_code, a.slip_class
	)	aaa, 
	acdb.hac012m	hac012m
where		hac012m.bdgt_year    = aaa.bdgt_year
and		hac012m.gwa         	= aaa.gwa
and		hac012m.acct_code		= aaa.acct_code
and    	hac012m.acct_class 	= aaa.acct_class
and		hac012m.io_gubun		= aaa.slip_class
and		aaa.slip_class <> '3'			/*대체전표는 제외*/
group by	aaa.acct_class, aaa.gwa, aaa.acct_code, aaa.slip_class
having	sum(aaa.temp_gyul_amt + aaa.real_gyul_amt + aaa.temp_jun_amt + aaa.real_jun_amt) <> sum(aaa.temp_bae_amt + aaa.real_bae_amt)
;
open hac012m_cur ;
do while true
	fetch next hac012m_cur 
	into :acct_class, :gwa, :acct_code, :slip_class, :temp_gyul_amt, :real_gyul_amt, :temp_jun_amt, :real_jun_amt  ;
	if sqlca.sqlcode <> 0 then exit
	
	update  	acdb.hac012m    hac012m
	set     	hac012m.assn_temp_amt = :temp_gyul_amt + :temp_jun_amt,
			  	hac012m.assn_real_amt = :real_gyul_amt + :real_jun_amt
	where   	hac012m.bdgt_year 	= '2004'
	and		hac012m.gwa         	= :gwa
	and		hac012m.acct_code		= :acct_code
	and    	hac012m.acct_class 	= :acct_class
	and		hac012m.io_gubun		= :slip_class ;

	if sqlca.sqlcode <> 0 then 
		rollback;
		messagebox('error', 'error!!!', exclamation!)
		return
	end if
loop
close hac012m_cur; 

commit;
messagebox('ok', 'ok!!!')

end event

type cb_4 from commandbutton within w_hfn_temp
integer x = 206
integer y = 108
integer width = 539
integer height = 116
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "배정에산(=)"
end type

event clicked;double acct_class, temp_gyul_amt, real_gyul_amt
string gwa, acct_code, slip_class
                                            
declare hac012m_cur cursor for														  
select 	aaa.acct_class					acct_class,
			aaa.gwa							gwa,
			aaa.acct_code					acct_code,
			aaa.slip_class					slip_class,
			sum(aaa.temp_gyul_amt)		temp_gyul_amt,
			sum(aaa.real_gyul_amt)		real_gyul_amt
from	(
		select	a.acct_class            acct_class,
					a.bdgt_year             bdgt_year,
					a.resol_gwa					gwa,
					b.acct_code					acct_code,
					to_char(a.slip_class)	slip_class,
					sum(b.resol_amt)			temp_gyul_amt,
					0								real_gyul_amt,
					0								temp_bae_amt,
					0								real_bae_amt,
					0								temp_jun_amt,
					0								real_jun_amt
		from 		fndb.hfn101m a, fndb.hfn102m b
		where 	a.resol_date||a.resol_no = b.resol_date||b.resol_no
		and		a.bdgt_year = 		'2004'
		and		a.step_opt	<>      '5'
		group by a.acct_class, a.bdgt_year, a.resol_gwa, b.acct_code, a.slip_class
		union
		select 	a.acct_class            acct_class,
					a.bdgt_year             bdgt_year,
					a.resol_gwa					gwa,
					b.acct_code					acct_code,
					to_char(a.slip_class)	slip_class,
					0								temp_gyul_amt,
					sum(b.resol_amt)			real_gyul_amt, 
					0								temp_bae_amt,
					0								real_bae_amt,
					0								temp_jun_amt,
					0								real_jun_amt
		from 		fndb.hfn101m a, fndb.hfn102m b
		where 	a.resol_date||a.resol_no = b.resol_date||b.resol_no
		and		a.bdgt_year = 		'2004'
		and		a.step_opt	= 		'5'
		group by a.acct_class, a.bdgt_year, a.resol_gwa, b.acct_code, a.slip_class
		union
		select	acct_class              acct_class,
					bdgt_year               bdgt_year,
					gwa							gwa,
					acct_code					acct_code,
					io_gubun						slip_class,
					0								temp_gyul_amt,
					0								real_gyul_amt, 
					nvl(assn_temp_amt,0)		temp_bae_amt,
					nvl(assn_real_amt,0)		real_bae_amt,
					0								temp_jun_amt,
					0								real_jun_amt
		from		acdb.hac012m
		where		bdgt_year	=		'2004'
		union
		select 	a.acct_class            acct_class,
					a.bdgt_year             bdgt_year,
					a.slip_gwa					gwa,
					b.acct_code					acct_code,
					to_char(a.slip_class)	slip_class,
					0								temp_gyul_amt,
					0								real_gyul_amt,
					0								temp_bae_amt,
					0								real_bae_amt,
					sum(b.slip_amt)			temp_jun_amt,
					0								real_jun_amt
		from 		fndb.hfn201m a, fndb.hfn202m b
		where 	a.slip_date||a.slip_no = b.slip_date||b.slip_no
		and		a.bdgt_year = 		'2004'
		and		a.step_opt	<> 	'5'
		and		a.resol_date is null		/*전표등록한것만*/
		group by a.acct_class, a.bdgt_year, a.slip_gwa, b.acct_code, a.slip_class
		union
		select 	a.acct_class            acct_class,
					a.bdgt_year             bdgt_year,
					a.slip_gwa					gwa,
					b.acct_code					acct_code,
					to_char(a.slip_class)	slip_class,
					0								temp_gyul_amt,
					0								real_gyul_amt, 
					0								temp_bae_amt,
					0								real_bae_amt,
					0								temp_jun_amt,
					sum(b.slip_amt)			real_jun_amt
		from 		fndb.hfn201m a, fndb.hfn202m b
		where 	a.slip_date||a.slip_no = b.slip_date||b.slip_no
		and		a.bdgt_year = 		'2004'
		and		a.step_opt	= 		'5'
		and		a.resol_date is null		/*전표등록한것만*/
		group by a.acct_class, a.bdgt_year, a.slip_gwa, b.acct_code, a.slip_class
	)	aaa, 
	acdb.hac012m	hac012m
where		hac012m.bdgt_year    = aaa.bdgt_year
and		hac012m.gwa         	= aaa.gwa
and		hac012m.acct_code		= aaa.acct_code
and    	hac012m.acct_class 	= aaa.acct_class
and		hac012m.io_gubun		= aaa.slip_class
and		aaa.slip_class <> '3'			/*대체전표는 제외*/
group by	aaa.acct_class, aaa.gwa, aaa.acct_code, aaa.slip_class
having  (sum(aaa.temp_gyul_amt + aaa.real_gyul_amt) <> 0 or sum(aaa.temp_bae_amt + aaa.real_bae_amt) <> 0) 
and     	sum(aaa.temp_gyul_amt + aaa.real_gyul_amt + aaa.temp_jun_amt + aaa.real_jun_amt) = sum(aaa.temp_bae_amt + aaa.real_bae_amt)
;
open hac012m_cur ;
do while true
	fetch next hac012m_cur 
	into :acct_class, :gwa, :acct_code, :slip_class, :temp_gyul_amt, :real_gyul_amt  ;
	if sqlca.sqlcode <> 0 then exit
	
	update  	acdb.hac012m    hac012m
	set     	hac012m.assn_temp_amt = :temp_gyul_amt,
			  	hac012m.assn_real_amt = :real_gyul_amt
	where   	hac012m.bdgt_year 	= '2004'
	and		hac012m.gwa         	= :gwa
	and		hac012m.acct_code		= :acct_code
	and    	hac012m.acct_class 	= :acct_class
	and		hac012m.io_gubun		= :slip_class ;

	if sqlca.sqlcode <> 0 then 
		rollback;
		messagebox('error', 'error!!!', exclamation!)
		return
	end if
loop
close hac012m_cur; 

commit;
messagebox('ok', 'ok!!!')

end event

type cb_3 from commandbutton within w_hfn_temp
integer x = 2002
integer y = 148
integer width = 507
integer height = 204
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "ADD"
end type

event clicked;long ll_ins_row

ll_ins_row = dw_1.insertrow(0)
dw_1.object.aa[ll_ins_row] = 'nookie'
dw_1.object.bb[ll_ins_row] = 'bullgod'
dw_1.object.dd[ll_ins_row] = 'NN'

end event

type cb_2 from commandbutton within w_hfn_temp
integer x = 1408
integer y = 148
integer width = 507
integer height = 204
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Report"
end type

event clicked;string ls_report

ls_report = dw_1.Describe("evaluate('if(isRowNew(),1,0)', "+string(il_getrow)+")")

messagebox('', ls_report)

end event

type cb_1 from commandbutton within w_hfn_temp
integer x = 814
integer y = 148
integer width = 507
integer height = 204
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "OK"
end type

event clicked;long		ll_cnt, ll_find, ll_end
string	ls_message

ll_cnt = 0

ll_end  = dw_1.rowcount()

do while	ll_cnt <= ll_end
	ll_cnt ++

	dw_1.setitem(ll_cnt, 'dd', 'NN')
loop

ll_cnt = 0
ll_find = dw_1.find("cc = 'Y'", 1, ll_end)

do while	ll_find > 0
	
	dw_1.setitem(ll_find, 'dd', 'Y')

	ll_cnt ++
	ll_find ++
	if ll_find > ll_end then exit
	ll_find = dw_1.find("cc = 'Y'", ll_find, ll_end)
loop

end event

type dw_1 from datawindow within w_hfn_temp
integer x = 46
integer y = 492
integer width = 3767
integer height = 1964
integer taborder = 10
string title = "none"
string dataobject = "d_temp"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row <= 0 then return

//this.selectrow(0, false)
//this.selectrow(row, true)

il_getrow = row

end event

