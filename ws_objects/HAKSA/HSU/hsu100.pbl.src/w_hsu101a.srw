$PBExportHeader$w_hsu101a.srw
$PBExportComments$[청운대]교과과정관리
forward
global type w_hsu101a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hsu101a
end type
type dw_con from uo_dwfree within w_hsu101a
end type
type uo_1 from uo_imgbtn within w_hsu101a
end type
end forward

global type w_hsu101a from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hsu101a w_hsu101a

on w_hsu101a.create
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

on w_hsu101a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakyun, ls_hakgi, ls_gwa
int li_ans

dw_con.accepttext()

ls_year		=	func.of_nvl(dw_con.Object.year[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_hakgi		=	func.of_nvl(dw_con.Object.hakgi[1], '%')
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')

li_ans = dw_main.retrieve(ls_year, ls_hakyun, ls_hakgi, ls_gwa)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_main.setfocus()
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()


end event

event ue_insert;call super::ue_insert;long		ll_row, ll_getrow
string	ls_year, ls_hakyun, ls_hakgi, ls_gwa

dw_con.accepttext()

ll_getrow	=	dw_main.getrow()
ll_row		=	dw_main.insertrow(ll_getrow + 1)

ls_year		=	dw_con.Object.year[1]
ls_hakyun	=	dw_con.Object.hakyun[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	dw_con.Object.gwa[1]

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
		
end if

dw_main.setitem(ll_row, 'year', ls_year)
dw_main.setitem(ll_row, 'hakgi', ls_hakgi)
dw_main.setitem(ll_row, 'hakyun', ls_hakyun)
dw_main.setitem(ll_row, 'gwa', ls_gwa)

IF right(ls_gwa, 1) = '0' or right(ls_gwa, 1) = '3' THEN
	dw_main.setitem(ll_row, 'juya_gubun', '1')
ELSE
	dw_main.setitem(ll_row, 'juya_gubun', right(ls_gwa, 1))
END IF 

end event

event ue_delete;call super::ue_delete;long	li_ans

if messagebox("확인","삭제하시겠습니까?", Question!, YesNo!, 2) = 2 then return

dw_main.deleterow(0);

li_ans = dw_main.update()	

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback using sqlca;
else	
	commit using sqlca;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu101a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu101a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu101a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu101a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu101a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu101a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu101a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu101a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu101a
end type

type uc_save from w_condition_window`uc_save within w_hsu101a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu101a
end type

type uc_print from w_condition_window`uc_print within w_hsu101a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu101a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu101a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu101a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu101a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu101a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu101a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu101a
end type

type dw_main from uo_input_dwc within w_hsu101a
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsu100a_1"
end type

event itemchanged;call super::itemchanged;integer	li_hakjum, li_iron, li_silgi, li_temp1, li_temp2
string	ls_isu, ls_pass, ls_gwamok_gubun

this.AcceptText()

CHOOSE CASE	DWO.NAME
	CASE	'gwamok'
		this.object.gwamok_id[row]		=	left(data, 7)
		this.object.gwamok_seq[row]	=	integer(mid(data, 8, 2))
		
		SELECT	ISU_GUBUN,
					HAKJUM,
					IRON_SISU,
					SILGI_SISU,
					GWAMOK_GUBUN,
					PASS_GUBUN
		INTO	:ls_isu,
				:li_hakjum,
				:li_iron,
				:li_silgi,
				:ls_gwamok_gubun,
				:ls_pass
		FROM	HAKSA.GWAMOK_CODE
		WHERE	GWAMOK_ID||GWAMOK_SEQ	=	:data
		USING SQLCA ;
		
		if isnull(li_iron) then 
			li_temp1 = 0
		else
			li_temp1 = li_iron
		end if
		
		if isnull(li_silgi) then 
			li_temp2 = 0
		else
			li_temp2 = li_silgi
		end if
		
		this.object.isu_id[row]			= ls_isu
		this.object.hakjum[row]			= li_hakjum
		this.object.sisu_iron[row]		= li_iron
		this.object.sisu_silsub[row]	= li_silgi
		this.object.sisu[row] 			= li_temp1 + li_temp2
		this.object.gwamok_gubun[row]	= ls_gwamok_gubun
		this.object.pass_gubun[row]	= ls_pass
				
	CASE	'sisu_iron', 'sisu_silsub'
		li_iron	= this.object.sisu_iron[row]
		li_silgi	= this.object.sisu_silsub[row]
		
		if isnull(li_iron) then li_iron = 0
		if isnull(li_silgi) then li_silgi = 0
		
		this.object.sisu[row] = li_iron + li_silgi
		
		
	CASE	'gwa'
				
		IF right(data, 1) ='0' THEN
			this.object.juya_gubun[row] = '1'
		ELSE
			this.object.juya_gubun[row] = right(data, 1)
		END IF 
		
END CHOOSE

end event

type dw_con from uo_dwfree within w_hsu101a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hsu101a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hsu101a
integer x = 631
integer y = 44
integer width = 718
integer taborder = 30
boolean bringtotop = true
string btnname = "전년도 교과과정복사"
end type

event clicked;call super::clicked;//**********************************************************************************//
// 전년도 교과과정을 불러와서 년도를 현재년도로 바꾸어서 이관하는 모듈임.
//**********************************************************************************//

string 	ls_year, ls_hakyun, ls_hakgi, ls_gwa, ls_pre_year
string	ls_chk

dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_hakgi		=	func.of_nvl(dw_con.Object.hakgi[1], '%')
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')

if	ls_year = "" or isnull(ls_year) then
	messagebox("확인","년도를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
end if

if messagebox("확인",ls_year + "년도 " + "교육과정을 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return ;

ls_pre_year = string(integer(ls_year) - 1)

//전년도 자료가 존재하는지 확인
SELECT	YEAR
INTO	:ls_chk
FROM	HAKSA.GYOGWA_GWAJUNG
WHERE	YEAR			=	:ls_pre_year
AND	HAKGI		like	:ls_hakgi
AND	HAKYUN	like	:ls_hakyun
AND	GWA		like	:ls_gwa	
AND	ROWNUM		=	1
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("확인","전년도 자료가 존재하지 않습니다.")
	RETURN
end if


//생성하고자 하는 년도의 자료가 있는지 확인
SELECT	YEAR
INTO	:ls_chk
FROM	HAKSA.GYOGWA_GWAJUNG
WHERE	YEAR			=	:ls_year
AND	HAKGI		like	:ls_hakgi
AND	HAKYUN	like	:ls_hakyun
AND	GWA		like	:ls_gwa	
AND	ROWNUM		=	1
USING SQLCA ;

if sqlca.sqlcode = 0 then
	if messagebox("확인",ls_year + "년도 " + ls_hakgi + "학기 자료가 존재합니다.~r~n" + &
								"삭제후 다시 생성하시겠습니까?", Question!, YesNo!, 2) = 2 then return ;
								
	DELETE FROM HAKSA.GYOGWA_GWAJUNG
			WHERE	YEAR			=	:ls_year
			AND	HAKGI		like	:ls_hakgi
			AND	HAKYUN	like	:ls_hakyun
			AND	GWA		like	:ls_gwa	
			USING SQLCA ;
			
		if sqlca.sqlcode<> 0 then
			messagebox("확인","기존자료 삭재중 오류발생~r~n" + sqlca.sqlerrtext)
			rollback USING SQLCA ;
			return 
		end if
	
end if

//자료생성
INSERT INTO	HAKSA.GYOGWA_GWAJUNG
(	SELECT	:ls_year,
				HAKYUN,
				HAKGI,
				GWA,
				JUYA_GUBUN,
				GWAMOK_ID,
				GWAMOK_SEQ,
				ISU_ID,
				HAKJUM,
				GWAMOK_GUBUN,
				SISU,
				SISU_IRON,
				SISU_SILSUB,
				PASS_GUBUN,
				:gs_empcode,
				:gs_ip,
				SYSDATE,
				NULL,
				NULL,
				NULL
	FROM	HAKSA.GYOGWA_GWAJUNG
	WHERE	YEAR			=	:ls_pre_year
	AND	HAKGI		like	:ls_hakgi
	AND	HAKYUN	like	:ls_hakyun
	AND	GWA		like	:ls_gwa		
)	USING SQLCA ;
	
	if sqlca.sqlcode <> 0 then
		messagebox("오류","저장중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
		rollback USING SQLCA ;
		return
	else
		commit USING SQLCA ;
		messagebox("확인","작업이 완료되었습니다.")
		
		dw_main.retrieve(ls_year + '%', ls_hakyun + '%', ls_hakgi + '%', ls_gwa )
	end if
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

