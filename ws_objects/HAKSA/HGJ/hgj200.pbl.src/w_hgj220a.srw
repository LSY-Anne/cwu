$PBExportHeader$w_hgj220a.srw
$PBExportComments$[청운대]교직신청자관리
forward
global type w_hgj220a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hgj220a
end type
type dw_con from uo_dwfree within w_hgj220a
end type
end forward

global type w_hgj220a from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hgj220a w_hgj220a

on w_hgj220a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hgj220a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string ls_year, ls_jaguk, ls_pyosi, ls_hakgwa, ls_gubun
long ll_ans

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = func.of_nvl(dw_con.Object.pyosi_id[1], '%') + '%'
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_gubun    = dw_con.Object.gubun[1]

if (trim(ls_year) = '' Or Isnull(ls_year)) or (trim(ls_jaguk) = '' Or Isnull(ls_jaguk)) then
	messagebox("확인","신청년도, 자격명을 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("jaguk_id")
	return	 -1
end if

if ls_gubun = '1' Then
	dw_main.setsort( "jaguk_id A, pyosi_id A, jaehak_hakjuk_gwa A, hakbun A")
Else
	dw_main.setsort( "jaguk_id A, pyosi_id A, jaehak_hakjuk_gwa A, pyungjum D, siljum D")
end if

dw_main.sort()

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

dw_con.Object.year[1]   = ls_year
end event

event ue_delete;call super::ue_delete;String ls_hakbun, ls_sunbal
long	 li_ans,    l_row

IF dw_main.RowCount() < 1 THEN return
l_row       = dw_main.Getrow()

ls_hakbun   = dw_main.GetItemString(l_row, 'hakbun')

SELECT nvl(sunbal_yn, 'N')
  INTO :ls_sunbal
  FROM haksa.gj_sinchung
 WHERE hakbun     = :ls_hakbun
 USING SQLCA ;
 
IF sqlca.sqlnrows = 0 THEN
	ls_sunbal      = 'N'
END IF

IF ls_sunbal     = 'Y' THEN
	messagebox("알림", '선발된 학번은 삭제할 수 없습니다')
	return
END IF

dw_main.deleterow(l_row);

li_ans = dw_main.update()	

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback  USING SQLCA ;
else	
	commit  USING SQLCA ;
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
	messagebox("확인","신청년도, 자격명, 표시과목을 입력하세요!")
	return	
end if

ll_row		=	dw_main.insertrow(0)

dw_main.setitem(ll_row, "year", ls_year)
dw_main.setitem(ll_row, "jaguk_id", ls_jaguk)
dw_main.setitem(ll_row, "pyosi_id", ls_pyosi)
dw_main.SetColumn('hakbun')
dw_main.SetFocus()
dw_main.ScrollToRow(ll_row)
end event

type ln_templeft from w_condition_window`ln_templeft within w_hgj220a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hgj220a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hgj220a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hgj220a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hgj220a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hgj220a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hgj220a
end type

type uc_insert from w_condition_window`uc_insert within w_hgj220a
end type

type uc_delete from w_condition_window`uc_delete within w_hgj220a
end type

type uc_save from w_condition_window`uc_save within w_hgj220a
end type

type uc_excel from w_condition_window`uc_excel within w_hgj220a
end type

type uc_print from w_condition_window`uc_print within w_hgj220a
end type

type st_line1 from w_condition_window`st_line1 within w_hgj220a
end type

type st_line2 from w_condition_window`st_line2 within w_hgj220a
end type

type st_line3 from w_condition_window`st_line3 within w_hgj220a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hgj220a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hgj220a
end type

type gb_1 from w_condition_window`gb_1 within w_hgj220a
integer height = 300
end type

type gb_2 from w_condition_window`gb_2 within w_hgj220a
end type

type dw_main from uo_input_dwc within w_hgj220a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hgj220a"
end type

event itemchanged;string	ls_hakbun, ls_hname, ls_hakgwa, ls_year_sql, ls_iphak_gubun
double	ld_pyungjum, ld_siljum
int		li_chidk

CHOOSE CASE dwo.name
	CASE 'hakbun'
		
		//기 신청여부
		SELECT	YEAR
		INTO		:ls_year_sql
		FROM		HAKSA.GJ_SINCHUNG
		WHERE	HAKBUN	= :data
		USING SQLCA ;
		
		if sqlca.sqlcode = 0 then
			messagebox('확인!', ls_year_sql + '년도에 교원자격을 신청하였습니다!')
			this.object.hakbun[row] = ''
			return 1
		end if
		
		//성명
		SELECT	HNAME,	GWA, IPHAK_GUBUN
		INTO		:ls_hname, :ls_hakgwa, :ls_iphak_gubun
		FROM		HAKSA.JAEHAK_HAKJUK
		WHERE	HAKBUN	= :data
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox('확인!', '존재하지 않는 학번입니다!')
			this.object.hakbun[row] = ''
			this.object.jaehak_hakjuk_hname[row]	= ''
			this.object.jaehak_hakjuk_gwa[row]		= ''
			this.object.pyungjum[row] = 0
			return 1
			
		else
			this.object.jaehak_hakjuk_hname[row]	= ls_hname
			this.object.jaehak_hakjuk_gwa[row]		= ls_hakgwa
			
		end if
		
		if ls_iphak_gubun ='04' then   // 편입인경우
			//평점평균
			SELECT	ROUND(SUM(PYENGJUM * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, HAKJUM)), 2) ,
						ROUND(SUM(JUMSU * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, HAKJUM)), 2),
						SUM(DECODE(HWANSAN_JUMSU, 'F', 0, HAKJUM))
			INTO		:ld_pyungjum	,
						:ld_siljum,
						:li_chidk
			FROM 		HAKSA.SUGANG
			WHERE 	HAKYUN		= '3'
			AND		HAKBUN 			= :data
			AND		SUNGJUK_INJUNG = 'Y'
			GROUP BY HAKBUN
			USING SQLCA ;
		else			//신입인경우
			//평점평균
			SELECT	ROUND(SUM(PYENGJUM * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, HAKJUM)), 2) ,
						ROUND(SUM(JUMSU * HAKJUM) / SUM(DECODE(HWANSAN_JUMSU, 'P', 0, HAKJUM)), 2),
						SUM(DECODE(HWANSAN_JUMSU, 'F', 0, HAKJUM))
			INTO		:ld_pyungjum	,
						:ld_siljum,
						:li_chidk
			FROM 		HAKSA.SUGANG
			WHERE 	HAKYUN		= '1'
			AND		HAKBUN 			= :data
			AND		SUNGJUK_INJUNG = 'Y'
			GROUP BY HAKBUN
			USING SQLCA ;
		end if
		
		if sqlca.sqlcode <> 0 then
			messagebox('확인!', '평점평균계산을 실패하였습니다!')
			return 1
		else
			this.object.pyungjum[row]	= ld_pyungjum
			this.object.siljum[row]	    = ld_siljum
			this.object.chidk[row]	         = li_chidk
		end if
		
END CHOOSE

end event

event itemerror;call super::itemerror;return 2
end event

type dw_con from uo_dwfree within w_hgj220a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hgj220a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gubun'
		If data = '1' Then
			dw_main.setsort( "jaguk_id A, pyosi_id A, jaehak_hakjuk_gwa A, hakbun A")
			dw_main.sort()
		Else
			dw_main.setsort( "jaguk_id A, pyosi_id A, jaehak_hakjuk_gwa A, pyungjum D, siljum D")
			dw_main.sort()
		End If
End Choose
end event

