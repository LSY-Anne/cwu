$PBExportHeader$w_hgj204a.srw
$PBExportComments$[청운대]이수예정자실습관리
forward
global type w_hgj204a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hgj204a
end type
type dw_con from uo_dwfree within w_hgj204a
end type
end forward

global type w_hgj204a from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hgj204a w_hgj204a

type variables

end variables

on w_hgj204a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hgj204a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string	ls_jaguk, ls_pyosi, ls_hakgwa, ls_hakyun
long ll_ans

dw_con.AcceptText()

ls_jaguk	    = dw_con.Object.jaguk_id[1]
ls_pyosi	    = func.of_nvl(dw_con.Object.pyosi_id[1], '%') + '%'
ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_hakyun	= func.of_nvl(dw_con.Object.hakyun[1], '%') + '%'

if trim(ls_jaguk) = ''  Or Isnull(ls_jaguk) then
	messagebox("확인","자격명을 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("jaguk_id")
	return	 -1
end if

ll_ans = dw_main.retrieve(ls_jaguk, ls_pyosi, ls_hakgwa, ls_hakyun)

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


end event

type ln_templeft from w_condition_window`ln_templeft within w_hgj204a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hgj204a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hgj204a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hgj204a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hgj204a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hgj204a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hgj204a
end type

type uc_insert from w_condition_window`uc_insert within w_hgj204a
end type

type uc_delete from w_condition_window`uc_delete within w_hgj204a
end type

type uc_save from w_condition_window`uc_save within w_hgj204a
end type

type uc_excel from w_condition_window`uc_excel within w_hgj204a
end type

type uc_print from w_condition_window`uc_print within w_hgj204a
end type

type st_line1 from w_condition_window`st_line1 within w_hgj204a
end type

type st_line2 from w_condition_window`st_line2 within w_hgj204a
end type

type st_line3 from w_condition_window`st_line3 within w_hgj204a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hgj204a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hgj204a
end type

type gb_1 from w_condition_window`gb_1 within w_hgj204a
end type

type gb_2 from w_condition_window`gb_2 within w_hgj204a
end type

type dw_main from uo_input_dwc within w_hgj204a
integer x = 55
integer y = 304
integer width = 4379
integer height = 1960
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hgj204a"
end type

event itemchanged;string	ls_hakbun, ls_hname, ls_hakgwa, ls_iphak_gubun, ls_year_sql

CHOOSE CASE dwo.name
	CASE 'hakbun'
		
		//기 신청여부
		SELECT	YEAR
		INTO		:ls_year_sql
		FROM		HAKSA.GJ_YEJUNGJA
		WHERE	HAKBUN	= :data
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

type dw_con from uo_dwfree within w_hgj204a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_hgj204a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

