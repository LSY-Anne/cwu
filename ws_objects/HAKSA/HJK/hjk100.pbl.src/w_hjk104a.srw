$PBExportHeader$w_hjk104a.srw
$PBExportComments$[청운대]전공부전공관리
forward
global type w_hjk104a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjk104a
end type
type dw_con from uo_dwfree within w_hjk104a
end type
end forward

global type w_hjk104a from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hjk104a w_hjk104a

on w_hjk104a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjk104a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string ls_gwa, ls_hakbun, ls_year, ls_hakgi
int li_ans
dw_con.AcceptText()

//조회조건
ls_year		= dw_con.Object.year[1]
ls_hakgi		= dw_con.Object.hakgi[1]
ls_gwa		= func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun 	= func.of_nvl(dw_con.Object.hakbun[1], '%')

if (Isnull(ls_year) or ls_year ='' ) or (Isnull(ls_hakgi) or ls_hakgi= '') then
	messagebox( '확인', " 년도 ,학기를 입력하세요.")
	return 1
	dw_con.Setfocus()
	dw_con.Setcolumn("year")
end if

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun, ls_gwa)

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

event ue_insert;long ll_line, ll_row = 0

ll_row = dw_main.getrow()

ll_line = dw_main.insertrow(ll_row + 1)
dw_main.scrolltorow(ll_line)

dw_main.SetColumn('hakbun')
dw_main.setfocus()
end event

event open;call super::open;String ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

ls_year = func.of_get_sdate('YYYY')

dw_con.Object.year[1] = ls_year
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk104a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk104a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk104a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk104a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk104a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk104a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk104a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk104a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk104a
end type

type uc_save from w_condition_window`uc_save within w_hjk104a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk104a
end type

type uc_print from w_condition_window`uc_print within w_hjk104a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk104a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk104a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk104a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk104a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk104a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk104a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk104a
end type

type dw_main from uo_input_dwc within w_hjk104a
integer x = 55
integer y = 296
integer width = 4375
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk104a_1"
boolean hscrollbar = false
boolean livescroll = false
end type

event itemchanged;string	ls_name, ls_gubun, ls_hakbun, ls_gwa, ls_jumin, ls_dr_hakyun, ls_jungong_gubun
integer	li_ans, li_net, li_chj

CHOOSE CASE dwo.name
		
	CASE 'hakbun'
		ls_hakbun = data
		
		SELECT	A.GWA,
					A.HNAME,
					A.JUMIN_NO,
					A.DR_HAKYUN,
					B.CHJ
		INTO		:ls_gwa,
					:ls_name,
					:ls_jumin,
					:ls_dr_hakyun,
					:li_chj
		FROM		HAKSA.JAEHAK_HAKJUK A,
					(	SELECT	HAKBUN,
									SUM(CHIDK_HAKJUM)CHJ
						FROM		HAKSA.SUNGJUKGYE
						WHERE		HAKBUN = :ls_hakbun
						GROUP BY HAKBUN
					) B
		WHERE		A.HAKBUN = B.HAKBUN
		AND		A.HAKBUN = :ls_hakbun
		USING SQLCA ;
		
		dw_main.object.gwa[row] 		= ls_gwa
		dw_main.object.hname[row] 		= ls_name
		dw_main.object.jumin_no[row] 		= ls_jumin
		dw_main.object.dr_hakyun[row] = ls_dr_hakyun
		
		dw_main.SetColumn('bujungong_id')
		dw_main.setfocus()
		
	CASE 'jungong_gubun'
		ls_gubun = data
		ls_hakbun = dw_main.object.hakbun[row]
		
		if ls_gubun = '0' then
			li_ans = messagebox('확인', "복수및 부전공을 취소하시겠습니까?", Exclamation!, OKCancel!, 2)

			IF li_ans = 1 THEN
			
			 	UPDATE 	HAKSA.SUGANG
				SET	   TMT_ISU_ID = ISU_ID,
				         ISU_ID     = '80'
				WHERE   (ISU_ID    IN ('50', '60') OR TMT_ISU_ID IN('50', '60'))
				AND		HAKBUN = :ls_hakbun
				USING SQLCA ;
				
				if sqlca.sqlcode = 0 then
					li_net = messagebox("확인", "기존 복수및 부전공 이수구분을 일반선택으로 바꾸시겠습니까?", Exclamation!, OKCancel!, 2)

					if li_net = 1 then
						dw_main.update()
						commit USING SQLCA ;
					else
						rollback USING SQLCA ;
						return 1
					end if
				else
					return 1
				end if
							
			ELSE
				return 1			
			END IF
			
		elseif ls_gubun = '2'then
			
			li_ans = messagebox('확인', "부전공을 선택하셨습니까?", Exclamation!, OKCancel!, 2)

			IF li_ans = 1 THEN
				SELECT JUNGONG_GUBUN
				    INTO :ls_jungong_gubun
				    FROM HAKSA.JAEHAK_HAKJUK
				 WHERE HAKBUN = :ls_hakbun
				 USING SQLCA ;
				 
				If ls_jungong_gubun = '1' Then
			
					UPDATE 	HAKSA.SUGANG
					SET		TMT_ISU_ID = ISU_ID,
								ISU_ID     = '50'
					WHERE   (ISU_ID    IN ('60') OR TMT_ISU_ID IN('50','60'))
					AND		HAKBUN = :ls_hakbun
					USING SQLCA ;
	
					if sqlca.sqlcode = 0 then
						li_net = messagebox("확인", "기존 복수및 부전공 이수구분을 부전공으로 바꾸시겠습니까?", Exclamation!, OKCancel!, 2)
	
						if li_net = 1 then
							dw_main.update()
							commit USING SQLCA ;
						else
							rollback USING SQLCA ;
							return 1
						end if
					else
						return 1
					end if
				
				Else
					dw_main.update()
					commit USING SQLCA ;
				End If

			ELSE
				return 1			
			END IF
		end if
		
END CHOOSE
end event

type dw_con from uo_dwfree within w_hjk104a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk104a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

