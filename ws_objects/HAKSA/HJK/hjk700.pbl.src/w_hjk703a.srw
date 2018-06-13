$PBExportHeader$w_hjk703a.srw
$PBExportComments$[청운대]변동사항Trans 생성(교육부보고)
forward
global type w_hjk703a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjk703a
end type
type dw_2 from uo_search_dwc within w_hjk703a
end type
type dw_con from uo_dwfree within w_hjk703a
end type
type uo_1 from uo_imgbtn within w_hjk703a
end type
end forward

global type w_hjk703a from w_condition_window
dw_main dw_main
dw_2 dw_2
dw_con dw_con
uo_1 uo_1
end type
global w_hjk703a w_hjk703a

type variables
date id_s, id_e, id_today

end variables

on w_hjk703a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_2=create dw_2
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_1
end on

on w_hjk703a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_2)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;int li_row
li_row = dw_main.retrieve()

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;//idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')


end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk703a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk703a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk703a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk703a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk703a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk703a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk703a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk703a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk703a
end type

type uc_save from w_condition_window`uc_save within w_hjk703a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk703a
end type

type uc_print from w_condition_window`uc_print within w_hjk703a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk703a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk703a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk703a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk703a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk703a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk703a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk703a
end type

type dw_main from uo_input_dwc within w_hjk703a
integer x = 55
integer y = 300
integer width = 4375
integer height = 1964
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hjk701a_1"
end type

type dw_2 from uo_search_dwc within w_hjk703a
boolean visible = false
integer x = 110
integer y = 1592
integer width = 1303
integer height = 416
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hjk701q_1"
end type

type dw_con from uo_dwfree within w_hjk703a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hjk701a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;String ls_from_dt, ls_to_dt

Choose Case dwo.name
	Case 'p_from_dt'
		ls_from_dt 	= String(This.Object.from_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'from_dt' , ls_from_dt)
		
		ls_from_dt 	= left(ls_from_dt, 4) + mid(ls_from_dt, 6, 2) + right(ls_from_dt, 2)
		This.SetItem(row, 'from_dt',  ls_from_dt)
End Choose
end event

type uo_1 from uo_imgbtn within w_hjk703a
integer x = 567
integer y = 48
integer width = 1019
integer taborder = 20
boolean bringtotop = true
string btnname = "교육부보고기초자료생성"
end type

event clicked;call super::clicked;int li_ans, i, j
long ll_rowcount,ll_rowcount1, ll_ans
string ls_hakbun, ls_sangtae, ls_ibhak_hakgwa
string ls_hjmod_id, ls_sayu_id, ls_sijum
string ls_from, ls_to, ls_today

dw_con.AcceptText()
ls_from 	= dw_con.Object.from_dt[1]

SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') 
INTO :ls_to 
FROM DUAL;

ls_today = string(today(),'yyyymmdd')

li_ans = messagebox('학적자료이관', "학적자료를 학적trans로 이관 하시겠습니까?" & 
						+ '~r~n기존에 저장되어 있는 학적trans자료는 삭제된 후 다시 생성됩니다.', information!, yesno!, 1)
						
SetPointer(HourGlass!)						
if li_ans = 2 then
	return
	
else
	
DELETE FROM HAKSA.JAEHAK_HAKJUK_TR USING SQLCA;
COMMIT;

INSERT INTO "HAKSA"."JAEHAK_HAKJUK_TR"  
	( 	"HAKBUN",   
		"GWA",   
		"SU_HAKYUN",   
		"HAKGI",   
		"SEX",   
		"SANGTAE",   
		"HJMOD_ID",   
		"SAYU_ID",   
		"HJMOD_DATE",   
		"IPHAK_DATE",   
		"IPHAK_GUBUN",   
		"IPHAK_JUNHYUNG",   
		"WORKER",   
		"IPADDR",   
		"WORK_DATE",   
		"JOB_UID",   
		"JOB_ADD",   
		"JOB_DATE" 
	)  
	SELECT 	"HAKSA"."JAEHAK_HAKJUK"."HAKBUN",   
				"HAKSA"."JAEHAK_HAKJUK"."GWA",   
				"HAKSA"."JAEHAK_HAKJUK"."DR_HAKYUN",   
				"HAKSA"."JAEHAK_HAKJUK"."HAKGI",   
				"HAKSA"."JAEHAK_HAKJUK"."SEX",   
				'01',   
				'A',   
				DECODE("JAEHAK_HAKJUK"."IPHAK_GUBUN", '04','A12','A11'),   
				"HAKSA"."JAEHAK_HAKJUK"."IPHAK_DATE",   
				"HAKSA"."JAEHAK_HAKJUK"."IPHAK_DATE",   
				"HAKSA"."JAEHAK_HAKJUK"."IPHAK_GUBUN",   
				"HAKSA"."JAEHAK_HAKJUK"."IPHAK_JUNHYUNG",   
				"HAKSA"."JAEHAK_HAKJUK"."WORKER",   
				"HAKSA"."JAEHAK_HAKJUK"."IPADDR",   
				"HAKSA"."JAEHAK_HAKJUK"."WORK_DATE",   
				"HAKSA"."JAEHAK_HAKJUK"."JOB_UID",   
				"HAKSA"."JAEHAK_HAKJUK"."JOB_ADD",   
				"HAKSA"."JAEHAK_HAKJUK"."JOB_DATE"  
	FROM 		"HAKSA"."JAEHAK_HAKJUK" 
	USING SQLCA
	;
/*	WHERE 	( 	HAKSA."JAEHAK_HAKJUK"."SANGTAE" in ('01','02') ) 
	OR    	(	HAKSA."JAEHAK_HAKJUK"."SANGTAE" in ('03','05') 
		AND  		HAKSA."JAEHAK_HAKJUK"."HJMOD_DATE" between :ls_from  and :ls_today) ;
*/
	IF SQLCA.SQLCODE = 0 THEN
		commit USING SQLCA;
	ELSE
		MESSAGEBOX('확인', "학적자료이관중 오류가 발생하였습니다." + SQLCA.SQLERRTEXT)
		RETURN
	END IF
	
	messagebox("확인","학적자료이관이 되었습니다.")
	
end if

DECLARE LC_HJMOD CURSOR FOR

	SELECT  	a.hakbun, 
				a.hjmod_sijum, 
				a.hjmod_id, 
				a.sayu_id
	FROM 		HAKSA.HAKJUKBYENDONG a 
	WHERE 	a.hjmod_sijum in (	SELECT 	max(b.hjmod_sijum) 
											FROM 		HAKSA.HAKJUKBYENDONG b
											WHERE 	a.hakbun = b.hakbun 
											AND		b.hjmod_id <> 'H'	
											AND		b.hjmod_sijum <= :ls_from
										)
	USING SQLCA
		;
 
setpointer(hourglass!)

open	LC_HJMOD ;
DO
FETCH LC_HJMOD into 	:ls_hakbun , :ls_sijum , :ls_hjmod_id, :ls_sayu_id;

	IF SQLCA.SQLCODE <> 0 THEN EXIT

		CHOOSE CASE	ls_hjmod_id
				
			CASE	'B'	/* 휴학		*/
				ls_sangtae	= '02'
			CASE	'C'	/* 복학		*/
				ls_sangtae	= '01'
			CASE	'D'	/* 제적		*/
				ls_sangtae	= '03'
			CASE	'E'	/* 퇴학		*/
				ls_sangtae	= '03'
			CASE	'F'	/* 전과		*/
				ls_sangtae	= '01'
			CASE	'I'	/* 재입학	*/
				ls_sangtae	= '01'				
		END CHOOSE	

		UPDATE 	HAKSA.JAEHAK_HAKJUK_TR
		SET 		SANGTAE 		= :ls_sangtae,
					HJMOD_ID 	= :ls_hjmod_id,
					SAYU_ID 		= :ls_sayu_id,
					HJMOD_DATE 	= :ls_sijum 
		WHERE 	HAKBUN 		= :ls_hakbun
		USING SQLCA;
	
LOOP WHILE TRUE;	
CLOSE LC_HJMOD;
	
commit USING SQLCA;

messagebox("확인","시점 이전 자료가 update 되었습니다.")
	
ll_ans = dw_main.update()

if ll_ans = -1 then
	Messagebox("확인", "dw_main저장 Update오류입니다.", Information!, Ok!)
	rollback using sqlca;
	return
else
	commit USING SQLCA;
end if
	Messagebox("확인", "학적변동 데이터 이관 완료", Information!, Ok!)	
	
	
parent.triggerevent("ue_retrieve")
	
	
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

