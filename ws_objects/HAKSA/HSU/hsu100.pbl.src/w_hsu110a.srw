$PBExportHeader$w_hsu110a.srw
$PBExportComments$[청운대]강의계획서
forward
global type w_hsu110a from w_condition_window
end type
type dw_gang from datawindow within w_hsu110a
end type
type st_4 from statictext within w_hsu110a
end type
type st_5 from statictext within w_hsu110a
end type
type dw_con from uo_dwfree within w_hsu110a
end type
type uo_1 from uo_imgbtn within w_hsu110a
end type
type uo_2 from uo_imgbtn within w_hsu110a
end type
type uo_3 from uo_imgbtn within w_hsu110a
end type
type dw_main from uo_dwfree within w_hsu110a
end type
end forward

global type w_hsu110a from w_condition_window
integer width = 4512
dw_gang dw_gang
st_4 st_4
st_5 st_5
dw_con dw_con
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
dw_main dw_main
end type
global w_hsu110a w_hsu110a

type variables
string	is_year,	is_hakgi, is_gwa, is_hakyun, is_ban, is_gwamok, is_bunban, is_prof
integer	ii_gwamok_seq
end variables

on w_hsu110a.create
int iCurrent
call super::create
this.dw_gang=create dw_gang
this.st_4=create st_4
this.st_5=create st_5
this.dw_con=create dw_con
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_gang
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.dw_con
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.uo_2
this.Control[iCurrent+7]=this.uo_3
this.Control[iCurrent+8]=this.dw_main
end on

on w_hsu110a.destroy
call super::destroy
destroy(this.dw_gang)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.dw_main)
end on

event ue_save;integer	li_ans, li_return
string	ls_pyung
string	ls_mokjuk, ls_mokpyo


dw_gang.AcceptText()

SetPointer(HourGlass!)

ls_mokjuk = dw_gang.object.mokjuk[1] 
ls_mokpyo = dw_gang.object.mokpyo[1] 

if		(isnull(ls_mokjuk) or ls_mokjuk = '') or (isnull(ls_mokpyo) or ls_mokpyo = '') then 
		MESSAGEBOX("확인","교육목적, 목표 내용이 없습니다." + sqlca.sqlerrtext)
		
		ROLLBACK	;	
else
		li_ans = dw_gang.update()
end if
	
if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(3)
	rollback using sqlca;
else
	
	li_return	=	uf_gangplan_save(is_year, is_hakgi, is_gwa, is_hakyun, is_ban, is_gwamok, ii_gwamok_seq, is_bunban)
	
	if li_return = 1 or li_return = 2 or li_return = 3 or li_return = 4 or li_return = 5 then
		rollback using sqlca;
		return -1
		
	end if
	
	//개설과목의 강의평가를 update한다.
	ls_pyung	=	dw_gang.object.pyungga_gubun[1]
	
	UPDATE	HAKSA.GAESUL_GWAMOK
	SET	PYUNGGA_GUBUN	=	:ls_pyung
	WHERE	YEAR			=	:is_year
	AND	HAKGI			=	:is_hakgi
	AND	GWA			=	:is_gwa
	AND	HAKYUN		=	:is_hakyun
	AND	BAN			=	:is_ban
	AND	GWAMOK_ID	=	:is_gwamok
	AND	GWAMOK_SEQ	=	:ii_gwamok_seq
	AND	BUNBAN		=	:is_bunban
	USING SQLCA ;
	
	IF SQLCA.SQLCODE = 0 THEN
		COMMIT USING SQLCA ;
		
	ELSE
		MESSAGEBOX("오류","저장중 오류가 발생되었습니다.(Gaesul_Gwamok)" + sqlca.sqlerrtext)
		ROLLBACK USING SQLCA ;
	END IF
	
end if

SetPointer(Arrow!)
end event

event open;call super::open;string	ls_bojik

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

SELECT 	BOJIK_CODE1
INTO 		:ls_bojik
FROM		INDB.HIN001M
WHERE	MEMBER_NO	= :gs_empcode
USING SQLCA ;

//사용자가 교수이면 검색조건의 교수를 ENABLED, 단 교무연구처장 보직은 true
if f_enabled_chk(gs_empcode) = 1 then
	if ls_bojik = '0003' then
	else
	dw_con.Object.prof_no[1] = gs_empcode
	dw_con.Object.prof_no.Protect = 1
	end if
end if
end event

event ue_retrieve;call super::ue_retrieve;string	ls_year, ls_hakgi, ls_prof
long 		ll_row

dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_prof	    =	func.of_nvl(dw_con.Object.prof_no[1], '%')

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

type ln_templeft from w_condition_window`ln_templeft within w_hsu110a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu110a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu110a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu110a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu110a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu110a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu110a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu110a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu110a
end type

type uc_save from w_condition_window`uc_save within w_hsu110a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu110a
end type

type uc_print from w_condition_window`uc_print within w_hsu110a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu110a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu110a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu110a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu110a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu110a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu110a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu110a
integer taborder = 90
end type

type dw_gang from datawindow within w_hsu110a
integer x = 55
integer y = 892
integer width = 4375
integer height = 1248
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hsu110a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type st_4 from statictext within w_hsu110a
integer x = 55
integer y = 296
integer width = 4375
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = " 개설강좌"
boolean focusrectangle = false
end type

type st_5 from statictext within w_hsu110a
integer x = 55
integer y = 832
integer width = 4375
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = " 강의계획서"
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hsu110a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hsu110a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hsu110a
integer x = 549
integer y = 40
integer width = 750
integer taborder = 20
boolean bringtotop = true
string btnname = "전년도 내용 가져오기"
end type

event clicked;call super::clicked;str_parms s_parms

dw_con.AcceptText()
if dw_main.getrow() <= 0 then
	messagebox("확인","개설강좌에서 복사할 강좌를 선택해 주세요")
	return
end if

is_prof = dw_con.Object.prof_no[1]

s_parms.s[1]	=	is_year
s_parms.s[2]	=	is_hakgi
s_parms.s[3]	=	is_gwa
s_parms.s[4]	=	is_hakyun
s_parms.s[5]	=	is_ban
s_parms.s[6]	=	is_gwamok
s_parms.s[7]	=	is_bunban
s_parms.s[8]	=	is_prof
s_parms.l[1]	=	ii_gwamok_seq

OpenWithParm(w_hsu110a_p2, s_parms)

dw_gang.retrieve(is_year,	is_hakgi, is_gwa, is_hakyun, is_ban, is_gwamok, ii_gwamok_seq, is_bunban)

end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type uo_2 from uo_imgbtn within w_hsu110a
integer x = 3163
integer y = 2156
integer taborder = 70
boolean bringtotop = true
string btnname = "출력"
end type

event clicked;call super::clicked;DataStore lds_report

lds_report = Create DataStore    // 메모리에 할당
lds_report.DataObject = "d_hsu110p_1"
lds_report.SetTransObject(sqlca)

lds_report.Retrieve(is_year, is_hakgi, is_gwa, is_hakyun, is_ban, is_gwamok, ii_gwamok_seq, is_bunban)
lds_report.Print()

Destroy lds_report
end event

on uo_2.destroy
call uo_imgbtn::destroy
end on

type uo_3 from uo_imgbtn within w_hsu110a
integer x = 3561
integer y = 2156
integer width = 677
integer taborder = 70
boolean bringtotop = true
string btnname = "주별 세부내역보기"
end type

event clicked;call super::clicked;integer li_cnt, li_ju, li_cnt2
str_parms s_parms
string ls_naeyong,  ls_errtext
Vector lvc_data

lvc_data = Create Vector

SELECT	COUNT(*)
INTO	:li_cnt
FROM	HAKSA.GANGPLAN
WHERE	YEAR			=	:is_year
AND	HAKGI			=	:is_hakgi
AND	GWA			=	:is_gwa
AND	HAKYUN		=	:is_hakyun
AND	BAN			=	:is_ban
AND	GWAMOK_ID	=	:is_gwamok
AND	GWAMOK_SEQ	=	:ii_gwamok_seq
AND	BUNBAN		=	:is_bunban
USING SQLCA;

SELECT	COUNT(*)
INTO	:li_cnt2
FROM	HAKSA.GANGPLAN_JU
WHERE	YEAR			=	:is_year
AND	HAKGI			=	:is_hakgi
AND	GWA			=	:is_gwa
AND	HAKYUN		=	:is_hakyun
AND	BAN			=	:is_ban
AND	GWAMOK_ID	=	:is_gwamok
AND	GWAMOK_SEQ	=	:ii_gwamok_seq
AND	BUNBAN		=	:is_bunban
USING SQLCA;

if li_cnt = 0 then 
	MessageBox('세부내역보기 오류', '강의계획서를 먼저 저장하세요', exclamation!)
elseif	li_cnt2 = 0 then 
			FOR li_ju = 1 TO	15
			
				//8주차와 15주차는 중간/기말고사를 넣어준다.
				if li_ju = 8 then
					ls_naeyong = '중간고사'
				elseif li_ju = 15 then
					ls_naeyong = '기말고사'
				else
					ls_naeyong = ''
				end if
			
				INSERT INTO HAKSA.GANGPLAN_JU
							(	YEAR,			HAKGI,				GWA,			HAKYUN,		BAN,		
								GWAMOK_ID,	GWAMOK_SEQ,			BUNBAN,		JU,			NAEYONG		)
				VALUES	(	:is_year,	:is_hakgi,			:is_gwa,		:is_hakyun,	:is_ban,
								:is_gwamok,	:ii_gwamok_seq,	:is_bunban,	:li_ju,		:ls_naeyong	) USING SQLCA;
			    
				 If sqlca.sqlcode <> 0 Then
					ls_errtext = sqlca.sqlerrtext
					ROLLBACK  using sqlca ;
					messagebox("오류","강의계획서_주별세부계획내역에 저장시 오류가 발생되었습니다(GANGPLAN_JU).~r~n" + ls_errtext )
					return
				End If
			NEXT
			
			if sqlca.sqlcode = 0 then
				commit using sqlca ;
			else
				ls_errtext = sqlca.sqlerrtext
				ROLLBACK  using sqlca ;
				messagebox("오류","강의계획서 조회중 오류 발생되었습니다(GANGPLAN_JU).~r~n" + ls_errtext )
				return
			end if	
		
		 lvc_data.setproperty('parm_cnt' , '1')		
		 lvc_data.setProperty('string1'  ,  is_year)
	 	 lvc_data.setProperty('string2'   , is_hakgi)
		 lvc_data.setProperty('string3'  ,  is_gwa)
	 	 lvc_data.setProperty('string4'   , is_hakyun)
          lvc_data.setProperty('string5'  ,  is_ban)
	 	 lvc_data.setProperty('string6'  , is_gwamok)
		 lvc_data.setProperty('string7'  ,  is_bunban)
	 	 lvc_data.setProperty('string8'   , string(ii_gwamok_seq))
		  
          openwithparm(w_hsu110a_p1, lvc_data)
	else		
		 lvc_data.setproperty('parm_cnt' , '1')		
		 lvc_data.setProperty('string1'  ,  is_year)
	 	 lvc_data.setProperty('string2'   , is_hakgi)
		 lvc_data.setProperty('string3'  ,  is_gwa)
	 	 lvc_data.setProperty('string4'   , is_hakyun)
          lvc_data.setProperty('string5'  ,  is_ban)
	 	 lvc_data.setProperty('string6'  , is_gwamok)
		 lvc_data.setProperty('string7'  ,  is_bunban)
	 	 lvc_data.setProperty('string8'   , string(ii_gwamok_seq))
		  
          openwithparm(w_hsu110a_p1, lvc_data)
end if

end event

on uo_3.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hsu110a
integer x = 50
integer y = 356
integer width = 4375
integer height = 464
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_hsu110a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;DWitemStatus ldis_Status_column1, ldis_Status_column2
long		ll_mod
integer	li_msg, li_ans, li_cnt, li_cnt2, li_ju
string	ls_naeyong, ls_report

if row <= 0 then return 

//다른 부분을 조회하기 전에 변경된 자료가 있으면 저장한다.
dw_gang.accepttext()
ll_mod = dw_gang.ModifiedCount()

ldis_Status_column1 = dw_gang.GetItemStatus(1, 'mokjuk', Primary!)
ldis_Status_column2 = dw_gang.GetItemStatus(1, 'mokpyo', Primary!)

//새로운 로우가 발생할때
ls_report = dw_gang.Describe("evaluate('if(isRowNew(),1,0)', 1)")

//만약 새로운 로우가 발생하고 목적,목표가 수정 또는 새로운 로우가 발생안하고 ll_mod가 1인경우
if (ls_report = '1' and (ldis_Status_column1 = DataModified! or ldis_Status_column2 = DataModified!)) or &
	(ls_report = '0' and ll_mod > 0) then
	li_msg = messagebox("확인","변경된 자료가 존재합니다.~r~n저장하시겠습니까?", Question!, YesNo!, 1)
	
	if li_msg = 1 then
		parent.triggerevent("ue_save", 0, 0)
	end if
	
end if

is_year				=	this.object.year[row]
is_hakgi				=	this.object.hakgi[row]
is_gwa				=	this.object.gwa[row]
is_hakyun			=	this.object.hakyun[row]
is_ban				=	this.object.ban[row]
is_gwamok			=	this.object.gwamok_id[row]
ii_gwamok_seq		=	this.object.gwamok_seq[row]
is_bunban			=	this.object.bunban[row]

//기존자료가 없으면 생성함.
SELECT	COUNT(*)
INTO	:li_cnt
FROM	HAKSA.GANGPLAN
WHERE	YEAR			=	:is_year
AND	HAKGI			=	:is_hakgi
AND	GWA			=	:is_gwa
AND	HAKYUN		=	:is_hakyun
AND	BAN			=	:is_ban
AND	GWAMOK_ID	=	:is_gwamok
AND	GWAMOK_SEQ	=	:ii_gwamok_seq
AND	BUNBAN		=	:is_bunban
USING SQLCA ;

IF li_cnt = 0 THEN
	dw_gang.reset()
	dw_gang.insertrow(0)
	dw_gang.object.year[1] 			= is_year
	dw_gang.object.hakgi[1] 		= is_hakgi
	dw_gang.object.gwa[1] 			= is_gwa
	dw_gang.object.hakyun[1] 		= is_hakyun
	dw_gang.object.ban[1] 			= is_ban
	dw_gang.object.gwamok_id[1] 	= is_gwamok
	dw_gang.object.gwamok_seq[1] 	= ii_gwamok_seq
	dw_gang.object.bunban[1] 		= is_bunban
ELSE
	li_ans = dw_gang.retrieve(is_year,	is_hakgi, is_gwa, is_hakyun, is_ban, is_gwamok, ii_gwamok_seq, is_bunban)
END IF



end event

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

