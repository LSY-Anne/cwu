$PBExportHeader$w_hgj203a.srw
$PBExportComments$[청운대]이수예정자관리
forward
global type w_hgj203a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hgj203a
end type
type dw_con from uo_dwfree within w_hgj203a
end type
type uo_1 from uo_imgbtn within w_hgj203a
end type
end forward

global type w_hgj203a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hgj203a w_hgj203a

type variables

end variables

on w_hgj203a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
end on

on w_hgj203a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;string	ls_year, ls_jaguk, ls_pyosi, ls_hakgwa
long ll_ans

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = func.of_nvl(dw_con.Object.pyosi_id[1], '%') + '%'
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'

if (trim(ls_year) = '' Or Isnull(ls_year)) or (trim(ls_jaguk) = '' Or Isnull(ls_jaguk)) then
	messagebox("확인","신청년도, 자격명을 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("jaguk_id")
	return	 -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_jaguk, ls_pyosi, ls_hakgwa)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;String ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

ls_year	= f_haksa_iljung_year()

dw_con.Object.year[1]        = ls_year
dw_con.Object.from_dt[1]   = func.of_get_sdate('YYYYMMDD')
end event

event ue_delete;call super::ue_delete;long	li_ans

dw_main.deleterow(0);

li_ans = dw_main.update()	

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback using sqlca ;
else	
	commit using sqlca ;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

event ue_insert;call super::ue_insert;string ls_year, ls_jaguk, ls_pyosi
long		ll_row

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = dw_con.Object.pyosi_id[1]

if trim(ls_year) = '' or trim(ls_jaguk) = '' or trim(ls_pyosi) = '' then
	messagebox("확인","선발년도, 자격명, 표시과목을 입력하세요!")
	return	
end if

ll_row		=	dw_main.insertrow(0)

dw_main.setitem(ll_row, "year", ls_year)
dw_main.setitem(ll_row, "jaguk_id", ls_jaguk)
dw_main.setitem(ll_row, "pyosi_id", ls_pyosi)
end event

type ln_templeft from w_condition_window`ln_templeft within w_hgj203a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hgj203a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hgj203a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hgj203a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hgj203a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hgj203a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hgj203a
end type

type uc_insert from w_condition_window`uc_insert within w_hgj203a
end type

type uc_delete from w_condition_window`uc_delete within w_hgj203a
end type

type uc_save from w_condition_window`uc_save within w_hgj203a
end type

type uc_excel from w_condition_window`uc_excel within w_hgj203a
end type

type uc_print from w_condition_window`uc_print within w_hgj203a
end type

type st_line1 from w_condition_window`st_line1 within w_hgj203a
end type

type st_line2 from w_condition_window`st_line2 within w_hgj203a
end type

type st_line3 from w_condition_window`st_line3 within w_hgj203a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hgj203a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hgj203a
end type

type gb_1 from w_condition_window`gb_1 within w_hgj203a
end type

type gb_2 from w_condition_window`gb_2 within w_hgj203a
end type

type dw_main from uo_input_dwc within w_hgj203a
integer x = 50
integer y = 360
integer width = 4384
integer height = 1904
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hgj203a"
end type

event itemchanged;string	ls_hakbun, ls_hname, ls_hakgwa, ls_iphak_gubun, ls_year_sql

CHOOSE CASE dwo.name
	CASE 'hakbun'
		
		//기 신청여부
		SELECT	YEAR
		INTO		:ls_year_sql
		FROM		HAKSA.GJ_YEJUNGJA
		WHERE		HAKBUN	= :data
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			messagebox('확인!', ls_year_sql + '년도에 교원자격을 신청하였습니다!')
			this.object.hakbun[row] = ''
			return 1
		end if
				
		//편입생여부
		SELECT	A.HNAME,	A.GWA, A.IPHAK_GUBUN
		INTO		:ls_hname, :ls_hakgwa, :ls_iphak_gubun
		FROM		HAKSA.JAEHAK_HAKJUK	A
		WHERE		A.HAKBUN	= :data
		USING SQLCA ;
		
		if ls_iphak_gubun = '04' then
			this.object.jaehak_hakjuk_hname[row]	= ls_hname
			this.object.jaehak_hakjuk_gwa[row]		= ls_hakgwa
			this.object.jaehak_hakjuk_iphak_gubun[row]	= ls_iphak_gubun
		else
			messagebox('확인!', '편입생 교직이수예정자 입력만 가능합니다!')
			this.object.hakbun[row] = ''
			return 1
		end if				
		
END CHOOSE

end event

event itemerror;call super::itemerror;return 2
end event

type dw_con from uo_dwfree within w_hgj203a
integer x = 50
integer y = 164
integer width = 4384
integer height = 184
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hgj203a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;String ls_from_dt

Choose Case dwo.name
	Case 'p_from_dt'
		ls_from_dt 	= String(This.Object.from_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'from_dt' , ls_from_dt)
		
		ls_from_dt 	= left(ls_from_dt, 4) + mid(ls_from_dt, 6, 2) + right(ls_from_dt, 2)
		This.SetItem(row, 'from_dt',  ls_from_dt)
End Choose
end event

type uo_1 from uo_imgbtn within w_hgj203a
integer x = 425
integer y = 40
integer width = 704
integer taborder = 20
boolean bringtotop = true
string btnname = "명부작성일부여"
end type

event clicked;call super::clicked;string	ls_jaksungil
string	ls_year, ls_jaguk,  ls_hakbun,  ls_yejung
Int      ii

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_jaguk	    = dw_con.Object.jaguk_id[1]

if trim(ls_year) = '' or trim(ls_jaguk) = ''  then
	messagebox("확인","선발년도, 자격명을 입력하세요!")
	return	
end if

ls_jaksungil	= dw_con.Object.from_dt[1]

if messagebox('확인','이수예정자명부 작성일을 일괄부여하시겠습니까?',question!,yesno!,2)=2 then return

FOR ii        = 1 TO dw_main.RowCount()
	 ls_yejung = dw_main.GetItemString(ii, 'yejung_yn')
	 ls_hakbun = dw_main.GetItemString(ii, 'hakbun')
	 IF ls_yejung   = 'Y' THEN
       UPDATE HAKSA.GJ_YEJUNGJA
          SET JAKSUNGIL   = :ls_jaksungil,
			     YEJUNG_YN   = 'Y'
        WHERE YEAR        = :ls_year
          AND JAGUK_ID    = :ls_jaguk
		 AND hakbun      = :ls_hakbun
		 USING SQLCA ;

    ELSE
       UPDATE HAKSA.GJ_YEJUNGJA
          SET JAKSUNGIL   = '',
			     YEJUNG_YN   = 'N'
        WHERE YEAR        = :ls_year
          AND JAGUK_ID    = :ls_jaguk
		 AND hakbun      = :ls_hakbun
		USING SQLCA ;
		
	 END IF
NEXT

if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	messagebox('확인','작업을 완료하였습니다!')
else
	rollback USING SQLCA ;
	messagebox('확인','작업을 실패하였습니다!')
	return
end if

parent.TriggerEvent('ue_retrieve')
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

