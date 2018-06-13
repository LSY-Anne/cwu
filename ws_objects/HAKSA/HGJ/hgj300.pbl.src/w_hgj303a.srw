$PBExportHeader$w_hgj303a.srw
$PBExportComments$[청운대]인적사항변동관리
forward
global type w_hgj303a from w_condition_window
end type
type dw_con from uo_dwfree within w_hgj303a
end type
type dw_main from uo_dwfree within w_hgj303a
end type
end forward

global type w_hgj303a from w_condition_window
dw_con dw_con
dw_main dw_main
end type
global w_hgj303a w_hgj303a

on w_hgj303a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hgj303a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;string ls_jaguk
long ll_ans

dw_con.AcceptText()

ls_jaguk	    = dw_con.Object.jaguk_id[1]

if trim(ls_jaguk) = ''  Or Isnull(ls_jaguk) then
	messagebox("확인","자격명을 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("jaguk_id")
	return	 -1
end if

ll_ans = dw_main.retrieve(ls_jaguk)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)


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

event ue_insert;call super::ue_insert;long	ll_row

ll_row		=	dw_main.insertrow(0)

end event

type ln_templeft from w_condition_window`ln_templeft within w_hgj303a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hgj303a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hgj303a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hgj303a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hgj303a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hgj303a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hgj303a
end type

type uc_insert from w_condition_window`uc_insert within w_hgj303a
end type

type uc_delete from w_condition_window`uc_delete within w_hgj303a
end type

type uc_save from w_condition_window`uc_save within w_hgj303a
end type

type uc_excel from w_condition_window`uc_excel within w_hgj303a
end type

type uc_print from w_condition_window`uc_print within w_hgj303a
end type

type st_line1 from w_condition_window`st_line1 within w_hgj303a
end type

type st_line2 from w_condition_window`st_line2 within w_hgj303a
end type

type st_line3 from w_condition_window`st_line3 within w_hgj303a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hgj303a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hgj303a
end type

type gb_1 from w_condition_window`gb_1 within w_hgj303a
end type

type gb_2 from w_condition_window`gb_2 within w_hgj303a
end type

type dw_con from uo_dwfree within w_hgj303a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hgj303a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hgj303a
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hgj303a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string	ls_jaguk, ls_jung_no, ls_hakgwa, ls_hname, ls_jumin

CHOOSE CASE dwo.name
	CASE 'hakbun'
				
		SELECT	A.HNAME,	A.GWA, A.JUMIN_NO, B.JAGUK_ID, B.JUNG_NO
		INTO		:ls_hname, :ls_hakgwa, :ls_jumin, :ls_jaguk, :ls_jung_no
		FROM		HAKSA.JAEHAK_HAKJUK	A,
					HAKSA.GJ_SAJUNG		B
		WHERE		A.HAKBUN	= B.HAKBUN
		AND		B.HAPGYUK_YN	= 'Y'
		AND		A.HAKBUN	= :data		
		UNION
		SELECT	A.HNAME,	A.GWA, A.JUMIN_NO, B.JAGUK_ID, B.JUNG_NO
		FROM		HAKSA.JOLUP_HAKJUK	A,
					HAKSA.GJ_SAJUNG		B
		WHERE		A.HAKBUN	= B.HAKBUN
		AND		B.HAPGYUK_YN	= 'Y'
		AND		A.HAKBUN	= :data
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox('확인!', '존재하지 않거나 자격증발급자가 아닙니다!')
			this.object.hakbun[row] = ''
			
			this.object.gj_sajung_jaguk_id[row]	= ''
			this.object.gj_sajung_jung_no[row]	= ''
			this.object.jaehak_hakjuk_gwa[row]	= ''
			this.object.gj_injuk_name_old[row]	= ''
			this.object.gj_injuk_jumin_old[row]	= ''
			this.object.gj_injuk_name_new[row]	= ''
			this.object.gj_injuk_jumin_new[row]	= ''
			return 1
			
		else
			this.object.gj_sajung_jaguk_id[row]	= ls_jaguk
			this.object.gj_sajung_jung_no[row]	= ls_jung_no
			this.object.jaehak_hakjuk_gwa[row]	= ls_hakgwa
			this.object.gj_injuk_name_old[row]	= ls_hname
			this.object.gj_injuk_jumin_old[row]	= ls_jumin
			this.object.gj_injuk_name_new[row]	= ls_hname
			this.object.gj_injuk_jumin_new[row]	= ls_jumin
			
		end if
		
END CHOOSE

end event

event itemerror;call super::itemerror;return 2
end event

