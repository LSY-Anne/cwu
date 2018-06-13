$PBExportHeader$w_hjk222a.srw
$PBExportComments$[청운대]학적변동신청확정-신규
forward
global type w_hjk222a from w_window
end type
type dw_con from uo_dw within w_hjk222a
end type
type dw_detail from uo_dw within w_hjk222a
end type
type st_1 from statictext within w_hjk222a
end type
type st_2 from statictext within w_hjk222a
end type
type dw_1 from uo_grid within w_hjk222a
end type
type dw_2 from uo_grid within w_hjk222a
end type
type dw_main from uo_grid within w_hjk222a
end type
type dw_3 from uo_grid within w_hjk222a
end type
end forward

global type w_hjk222a from w_window
event type long ue_row_updatequery ( )
dw_con dw_con
dw_detail dw_detail
st_1 st_1
st_2 st_2
dw_1 dw_1
dw_2 dw_2
dw_main dw_main
dw_3 dw_3
end type
global w_hjk222a w_hjk222a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE
String     is_sign_nm
uo_comm_send u_comm_send
end variables

forward prototypes
public function integer wf_validall ()
public function integer wf_sungjuk_injung (string as_hakbun, string as_sungjuk_injung, string as_jogi)
end prototypes

event type long ue_row_updatequery();Long				ll_rv
Long				ll_cnt = 0
Long				ll_i
DataWindow	ldw_modified[]
Long				ll_dw_cnt

If Not uc_save.Enabled Then RETURN 1

If UpperBound(idw_modified) = 0 Then
	ldw_modified = idw_update
Else
	ldw_modified = idw_modified
End If

ll_dw_cnt = UpperBound(ldw_modified)

For ll_i = 1 To ll_dw_cnt
	If ib_list_chk	=	FALSE and ldw_modified[ll_i] = dw_detail Then Continue
	ldw_modified[ll_i].AcceptText()
//	ll_cnt += ldw_modified[ll_i].uf_ModifiedCount()
	ll_cnt += (ldw_modified[ll_i].ModifiedCount() + ldw_modified[ll_i].DeletedCount())
Next

If ll_cnt > 0 Then
	ll_rv = gf_message(parentwin, 2, '0007', '', '')
	Choose Case ll_rv
		Case 1
			If This.Event ue_save() = 1 Then 
				RETURN 1
			Else
				RETURN -1
			End IF
		Case 2
			If ib_updatequery_resetupdate Then
				ll_cnt = UpperBound(idw_update)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_update[ll_i] = dw_detail Then Continue
					idw_update[ll_i].resetUpdate()
				Next
				ll_cnt = UpperBound(idw_modified)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_modified[ll_i] = dw_detail Then Continue
					idw_modified[ll_i].resetUpdate()
				Next
			End If
			RETURN 2			
		Case 3
			RETURN 3
	End Choose 	
Else
	RETURN 1
End If

RETURN 1

end event

public function integer wf_validall ();Integer	li_rtn, i, li_row
String     ls_sign_status, ls_sign_status_nm

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next



end function

public function integer wf_sungjuk_injung (string as_hakbun, string as_sungjuk_injung, string as_jogi);string	 ls_hakgi,  ls_year, ls_nyear
Int		 li_count	, li_ans

/* 학사일정에 의한 학기 RETURN */
ls_year	= f_haksa_iljung_year()
ls_hakgi	= f_haksa_iljung_hakgi()

If as_sungjuk_injung = 'Y' Then
	
	/* 다음학기 수강신청 내역 성적인정여부를 'N'으로 변환한다. */
	If ls_hakgi	= '1' Then
		
		ls_nyear = ls_year
		
		SELECT	COUNT(HAKBUN)
		   INTO	:li_count
		  FROM	HAKSA.SUGANG_TRANS  
		WHERE	HAKBUN	= :as_hakbun
		    AND   HAKGI		= '2'
		    AND	YEAR		= :ls_nyear
		 USING SQLCA ;
		
		If li_count > 0 Then
			UPDATE 	HAKSA.SUGANG_TRANS  
			     SET 	SUNGJUK_INJUNG = 'N'  
			WHERE	HAKBUN	= :as_hakbun
			    AND  	HAKGI		= '2'
			   AND	YEAR		= :ls_nyear
			USING SQLCA ;
			
			If sqlca.sqlcode <> 0 Then
				Messagebox("처리실패", "성적인정여부 설정에 실패하였습니다.")
				Return  -1
			End If
			
			/* 다음학기 수강신청 내역에 포함된 학생의 인원수를 감소해줘야 한다. */
			UPDATE 	HAKSA.GAESUL_GWAMOK	A
			      SET	SU_INWON	=	SU_INWON - 1 
			WHERE	( YEAR, HAKGI, GWA, HAKYUN, BAN, GWAMOK_ID, GWAMOK_SEQ, BUNBAN ) IN
						(	SELECT	YEAR, HAKGI, GWA, HAKYUN, BAN, GWAMOK_ID, GWAMOK_SEQ, BUNBAN
							FROM		HAKSA.SUGANG_TRANS	B
							WHERE	A.YEAR			=	B.YEAR
							AND		A.HAKGI			=	B.HAKGI
							AND		A.GWA			=	B.GWA
							AND		A.HAKYUN		=	B.HAKYUN
							AND		A.BAN				=	B.BAN
							AND		A.GWAMOK_ID		=	B.GWAMOK_ID
							AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
							AND		A.BUNBAN			=	B.BUNBAN
							AND		B.YEAR 			=	:ls_nyear	
							AND		B.HAKGI			=	'2'
							AND		B.HAKBUN		=	:as_hakbun	
						)	USING SQLCA ;
			
			If sqlca.sqlcode <> 0 Then
				messagebox("처리실패", "수강신청인원을 감소 처리를 실패하였습니다.")
				Return  -1
			End If
			
			
		End If
				
	ElseIf ls_hakgi = '2' then
		
		ls_nyear = string(long(ls_year) + 1,'0000')
		
		SELECT	COUNT(HAKBUN)
		   INTO	:li_count
		  FROM	HAKSA.SUGANG_TRANS  
		WHERE	HAKBUN	= :as_hakbun
		    AND   HAKGI		= '1'
		    AND	YEAR		= :ls_nyear
		 USING SQLCA ;
		
		if li_count > 0 then

			UPDATE 	HAKSA.SUGANG_TRANS  
			     SET 	SUNGJUK_INJUNG = 'N'  
			WHERE	HAKBUN	= :as_hakbun
			    AND  	HAKGI		= '1'
			    AND	YEAR		= :ls_nyear
			 USING SQLCA ;
			
			If sqlca.sqlcode <> 0 Then
				Messagebox("처리실패", "성적인정여부 설정에 실패하였습니다.")
				Return  -1
			End If
			
			UPDATE 	HAKSA.GAESUL_GWAMOK	A
			      SET	SU_INWON	=	SU_INWON - 1 
			WHERE	( YEAR, HAKGI, GWA, HAKYUN, BAN, GWAMOK_ID, GWAMOK_SEQ, BUNBAN ) IN
						(	SELECT	YEAR, HAKGI, GWA, HAKYUN, BAN, GWAMOK_ID, GWAMOK_SEQ, BUNBAN
							FROM		HAKSA.SUGANG_TRANS	B
							WHERE	A.YEAR			=	B.YEAR
							AND		A.HAKGI			=	B.HAKGI
							AND		A.GWA			=	B.GWA
							AND		A.HAKYUN		=	B.HAKYUN
							AND		A.BAN				=	B.BAN
							AND		A.GWAMOK_ID		=	B.GWAMOK_ID
							AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
							AND		A.BUNBAN			=	B.BUNBAN
							AND		B.YEAR 			=	:ls_nyear	
							AND		B.HAKGI			=	'1'
							AND		B.HAKBUN		=	:as_hakbun	
						)	USING SQLCA ;
			
			If sqlca.sqlcode <> 0 Then
				messagebox("처리실패", "수강신청인원을 감소 처리를 실패하였습니다.")
				Return  -1
			End If

			
		End If
		
	End If


ElseIf as_sungjuk_injung = 'N' Then
	
	If as_jogi = 'Y' Then

		UPDATE 	HAKSA.SUGANG_TRANS  
		     SET 	JOGI_YN = 'Y'
		WHERE	HAKBUN	= :as_hakbun
		    AND	YEAR		= :ls_year
		    AND   HAKGI		= :ls_hakgi
		 USING SQLCA ;
		
		If sqlca.sqlcode <> 0 Then
			messagebox("처리실패", "조기시험여부 설정을 실패하였습니다.")
			Return  -1
		End If
		
	Elseif as_jogi = 'N' Then
		
		UPDATE 	HAKSA.SUGANG_TRANS  
		     SET 	SUNGJUK_INJUNG = 'N'
	 	WHERE	HAKBUN	= :as_hakbun
		    AND  	YEAR || (CASE WHEN (HAKGI = '3' AND YEAR = :ls_year) THEN '0' ELSE HAKGI END ) >= :ls_year || :ls_hakgi
		 USING SQLCA ;

		If sqlca.sqlcode <> 0 Then
			messagebox("처리실패", "성적인정여부 설정에 실패하였습니다.")
			Return  -1
		End If
		
	End If
				
End If

Return 1
end function

on w_hjk222a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_detail=create dw_detail
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_main=create dw_main
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_detail
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_main
this.Control[iCurrent+8]=this.dw_3
end on

on w_hjk222a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_detail)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_main)
destroy(this.dw_3)
end on

event ue_postopen;call super::ue_postopen;String	ls_year, ls_hakgi, ls_admin, ls_gwa, ls_bojik_code
Long   ll_cnt = 0

func.of_design_con( dw_con )

This.Event ue_resize_dw( st_line1, dw_main )
dw_con.settransobject(sqlca)
dw_con.insertrow(0)

dw_detail.insertrow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')

idw_update[1]	= dw_main

u_comm_send = Create uo_comm_send

// 테스트시
//is_sign_nm = '3'
//gs_empcode = 'A0003'

is_sign_nm = '3'
dw_con.Object.sign_nm[1] = is_sign_nm
  
// dddw 값 셋팅(공통코드)
//Vector lvc_data
//
//lvc_data = Create Vector
//
//lvc_data.setProperty('column1', 'sayu_id') // 휴학사유
//lvc_data.setProperty('key1', 'B')
//
//func.of_dddw( dw_main,lvc_data)
//func.of_dddw( dw_detail,lvc_data)

DataWindowChild	ldwc_child, ldwc_child1

dw_main.GetChild('sayu_id', ldwc_child)
ldwc_child.SetTransObject(SQLCA)
ldwc_child.Retrieve('B')

dw_detail.GetChild('sayu_id', ldwc_child1)
ldwc_child1.SetTransObject(SQLCA)
ldwc_child1.Retrieve('B')


//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_update[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_main

//Excel로부터 IMPORT 할 DataWindow가 있으면 지정
//If uc_excelroad.Enabled Then
//	idw_excelload	=	dw_main
//	is_file_name	=	'우편번호'
//	is_col_name[]	=	{'우편번호', '시도명', '시군구명', '읍면동명', '리명', '도서명', '번지', '아파트/건물명', '상세주소'}
//End If

//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

end event

event ue_insert;call super::ue_insert;Long		ll_rv
String		ls_txt

ll_rv = This.Event ue_updatequery() 

If  (ll_rv = 1 Or ll_rv = 2) Then

	ll_rv = dw_main.Event ue_InsertRow()
	
	dw_detail.Reset()
	dw_detail.Event ue_InsertRow()
	
	ls_txt = "[신규] "
	If ll_rv = 1 Then
		f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
	ElseIf ll_rv = 0 Then
		
	Else
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	End If

End If

end event

event ue_delete;call super::ue_delete;Long		ll_rv
String		ls_txt

ll_rv = dw_detail.Event ue_DeleteRow()

ls_txt = "[삭제] "
If ll_rv = 1 Then
	If Trigger Event ue_save() <> 1 Then
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	Else
		f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
	End If
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If

end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = This.Event ue_updatequery() 
If ll_rv <> 1 And ll_rv <> 2 Then RETURN -1

SetPointer(HourGlass!)
If ib_retrieve_wait Then
	gf_openwait()
End If
ll_rv = dw_main.Event ue_Retrieve()
If ll_rv > 0 Then
	f_set_message("[조회] " + String(ll_rv) + '건의 자료가 조회되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	f_set_message("[조회] " + '자료가 없습니다.', '', parentwin)
Else
	f_set_message("[조회] " + '오류가 발생했습니다.', '', parentwin)
End If
If ib_retrieve_wait Then
	gf_closewait()
End If
SetPointer(Arrow!)
ib_excl_yn = FALSE

RETURN ll_rv

end event

event ue_saveend;call super::ue_saveend;Long    ll_cnt, i,          ll_sms_cnt = 0,     ll_sms_cnt1 = 0
String  ls_apply_dt,     ls_hakbun,            ls_hakyun,             ls_sayu_id,            ls_sayu_remark,   ls_army_dt,   ls_discharge_dt,       &
          ls_hjmod_fdt,   ls_hjmod_tdt,        ls_bokhak_year,     ls_bokhak_hakyun, ls_bokhak_hakgi,   ls_zip, ls_addr,     ls_tel,    ls_hp,   ls_email, &
		 ls_sign_status, ls_old_sign_status, ls_sungjuk_injung, ls_dungrok_injung, ls_return_remark, ls_hjmod_gb, ls_hjmod_id,            &
		 ls_year,          ls_hakgi,                ls_sangtae,            ls_curr_hakgi,        ls_gwa,               ls_hname,      ls_jogi
String ls_name, ls_hp_no, ls_dest_info,   ls_dest_info1
dwItemStatus	ls_status

ll_cnt = dw_main.Rowcount()

For i = 1 To ll_cnt
 
    ls_status = dw_main.GetItemStatus(i, 0, Primary!)
	 
    ls_sign_status       = dw_main.Object.sign_status[i]
    ls_old_sign_status = dw_main.Object.sign_status.Original[i]
    ls_hakbun        = dw_main.Object.hakbun[i]
 
    If ls_status  = DataModified! and ls_old_sign_status <> '3' and ls_sign_status = '3' THEN
		ls_hjmod_gb = dw_main.Object.hjmod_gb[i]
		
		If ls_hjmod_gb = '2' Then
			ls_hjmod_id = 'C'
		Else
			ls_hjmod_id = 'B'
		End If
		
		ls_year         	= f_haksa_iljung_year()
         ls_curr_hakgi	= f_haksa_iljung_hakgi()
		ls_hakgi           = dw_main.Object.hakgi[i]
         ls_apply_dt      = dw_main.Object.apply_dt[i]
	   
		ls_hakyun        = dw_main.Object.hakyun[i]
		ls_sayu_id        = dw_main.Object.sayu_id[i]
		ls_sayu_remark    = dw_main.Object.sayu_remark[i]
		ls_army_dt       = dw_main.Object.army_dt[i]
		ls_discharge_dt = dw_main.Object.discharge_dt[i]
		ls_hjmod_fdt     = dw_main.Object.hjmod_fdt[i]
		ls_hjmod_tdt     = dw_main.Object.hjmod_tdt[i]
		ls_bokhak_year  = dw_main.Object.bokhak_year[i]
		ls_bokhak_hakyun    = dw_main.Object.bokhak_hakyun[i]
		ls_bokhak_hakgi = dw_main.Object.bokhak_hakgi[i]
		ls_zip                = dw_main.Object.zip_id[i]
		ls_addr              = dw_main.Object.addr[i]
		ls_tel                 = dw_main.Object.tel[i]
		ls_hp                = dw_main.Object.hp[i]
		ls_email            = dw_main.Object.email[i]
		ls_sungjuk_injung    = dw_main.Object.sungjuk_injung[i]
		ls_dungrok_injung    = dw_main.Object.dungrok_injung[i]
		ls_return_remark    = dw_main.Object.return_remark[i]
		ls_gwa                   = dw_main.Object.gwa[i]
		ls_hname                = dw_main.Object.hname[i]
		ls_jogi                  = dw_main.Object.jogi_test[i]
		
		// 학적변동테이블에 저장.
		 INSERT INTO HAKSA.HAKJUKBYENDONG  
					( HAKBUN,              HJMOD_ID,              SAYU_ID,              HJMOD_SIJUM,              YEAR,   
					  SU_HAKYUN,         HAKGI,                   JUPSU_ILJA,          SUNGJUK_INJUNG,          DUNGROK_INJUNG,   
					  BOKHAK_YEAR,     BOKHAK_HAKYUN,   BOKHAK_HAKGI,     DUNGROK_HAKJUM,        BEFORE_GWA,   
					  JOGI_TEST,         WORKER,               IPADDR,                 WORK_DATE,                JOB_UID,   
					  JOB_ADD,            JOB_DATE )  
		  VALUES ( :ls_hakbun,         :ls_hjmod_id,         :ls_sayu_id,           :ls_hjmod_fdt,               :ls_year,
						:ls_hakyun,         :ls_hakgi,              :ls_apply_dt,         :ls_sungjuk_injung,        :ls_dungrok_injung,
						:ls_bokhak_year, :ls_bokhak_hakyun, :ls_bokhak_hakgi,  0,                                 NULL,
						'N',                     :gs_empcode,         :gs_ip,                 SYSDATE,                      :gs_empcode,
						:gs_ip,                SYSDATE ) USING SQLCA ;
						
			If SQLCA.SQLCODE <> 0 Then
				Messagebox("오류", "학적변동내역 저장 시 오류발생!" + &
														"~n" + sqlca.sqlerrtext )
				RETURN -1
			End If
			
		If ls_hjmod_id = 'B' Then // 휴학
		
			/* 수강트랜스 성적인정여부 체크 */
			If wf_sungjuk_injung(ls_hakbun, ls_sungjuk_injung, ls_jogi)	 < 0 Then
				Return -1
			End If
				
				SELECT	SANGTAE
					INTO	:ls_sangtae
				 FROM	HAKSA.JAEHAK_HAKJUK  
				WHERE	HAKBUN	=	:ls_hakbun
				USING SQLCA ;
			
		
				UPDATE	HAKSA.JAEHAK_HAKJUK  
					SET	SANGTAE				= '02'
						 ,	HJMOD_ID				= 'B'
						 ,	HJMOD_SAYU_ID		= :ls_sayu_id
						 ,	HJMOD_DATE			= :ls_hjmod_fdt
						 ,  HUHAK_DATE             = DECODE( :ls_sangtae, '02', NULL, :ls_hjmod_fdt )
						 ,  ZIP_ID                       = :ls_zip
						 ,  ADDR                        = :ls_addr
						 ,  TEL                           = :ls_tel
						 ,  HP                            = :ls_hp
						 , EMAIL                        = :ls_email
				WHERE HAKBUN	= :ls_hakbun   
				USING SQLCA ;
			
				If sqlca.sqlNrows < 1 Then
					messagebox("오류", "학적에 저장시 오류가 발생하였습니다.")
					Return -1
				End If
		End If
		
		If ls_hjmod_id = 'C' Then //복학
		
		    SELECT SANGTAE
			  INTO  :ls_sangtae
			 FROM HAKSA.JAEHAK_HAKJUK
		   WHERE HAKBUN	=	:ls_hakbun
		   USING SQLCA ;
			
			If ls_sangtae <> '02' Then
				Messagebox("확인","휴학생이 아닙니다...확인하세요!")
				Return -1
			End If
		
			  UPDATE	HAKSA.JAEHAK_HAKJUK  
					SET	SANGTAE				= '01'
					     ,   SU_HAKYUN              = :ls_bokhak_hakyun
						,    DR_HAKYUN             = :ls_bokhak_hakyun
						,    HAKGI                      = :ls_bokhak_hakgi
						 ,	HJMOD_ID				= :ls_hjmod_id
						 ,	HJMOD_SAYU_ID		= :ls_sayu_id
						 ,	HJMOD_DATE			= :ls_hjmod_fdt
						 ,  GWA                         = :ls_gwa
						 ,  ZIP_ID                       = :ls_zip
						 ,  ADDR                        = :ls_addr
						 ,  TEL                           = :ls_tel
						 ,  HP                            = :ls_hp
						 , EMAIL                        = :ls_email
				WHERE HAKBUN	= :ls_hakbun   
				USING SQLCA ;
			
				If sqlca.sqlNrows < 1 Then
					messagebox("복학오류", "학적에 저장시 오류가 발생하였습니다.")
					Return -1
				End If
			
			// 복학자_LIST 테이블 INSERT.
			INSERT INTO HAKSA.BOKHAKJA_LIST
					( 		YEAR,			         HAKGI,		          HAKBUN,			HNAME,			GWA, 
							WORKER, 			IPADDR,			     WORK_DATE,   	JOB_UID,		    JOB_ADD, 	JOB_DATE	)  
			VALUES 
					( 		:ls_bokhak_year,	:ls_bokhak_hakgi,	:ls_hakbun, 	        :ls_hname, 		:ls_gwa,
							:gs_empcode,	    :gs_ip,		         SYSDATE,    		NULL,			NULL,			NULL	) USING SQLCA ;
			If SQLCA.SQLCODE <> 0 Then
				Messagebox("오류", "복학자 리스트에 저장 시 오류발생!" + &
														"~n" + sqlca.sqlerrtext )
				RETURN -1
			End If		
		
		End If
		
		// SMS 발송.
		 SELECT HNAME,    HP
			INTO :ls_name, :ls_hp_no
			FROM HAKSA.JAEHAK_HAKJUK
		  WHERE HAKBUN = :ls_hakbun
			USING SQLCA ;
		  
		If sqlca.sqlcode = 0 Then
			ll_sms_cnt = ll_sms_cnt + 1
			ls_dest_info = ls_name + "^" + ls_hp_no + "|"
		End If
		
	End If
	
	If ls_status  = DataModified! and ls_old_sign_status <> '9' and ls_sign_status = '9' THEN
		// SMS 발송.
		 SELECT HNAME,    HP
			INTO :ls_name, :ls_hp_no
			FROM HAKSA.JAEHAK_HAKJUK
		  WHERE HAKBUN = :ls_hakbun
			USING SQLCA ;
		  
		If sqlca.sqlcode = 0 Then
			ll_sms_cnt1 = ll_sms_cnt1 + 1
			ls_dest_info1 = ls_name + "^" + ls_hp_no + "|"
		End If
	End If
	
Next

If ll_sms_cnt > 0 Then
	u_comm_send.of_send_sms( 'HJK09', '0001', 'academic', string(ll_sms_cnt), ls_dest_info, '' )
End If
If ll_sms_cnt1 > 0 Then
	u_comm_send.of_send_sms( 'HJK09', '0002', 'academic', string(ll_sms_cnt1), ls_dest_info1, '' )
End If

Return 1
end event

event ue_savestart;call super::ue_savestart;Long ll_rtn

ll_rtn = Messagebox('확인', '확정처리를 하시겠습니까?', Question!, YesNo!)

If ll_rtn = 2 Then Return -1;

Return 1
end event

type ln_templeft from w_window`ln_templeft within w_hjk222a
end type

type ln_tempright from w_window`ln_tempright within w_hjk222a
end type

type ln_temptop from w_window`ln_temptop within w_hjk222a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hjk222a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hjk222a
end type

type ln_tempstart from w_window`ln_tempstart within w_hjk222a
end type

type uc_retrieve from w_window`uc_retrieve within w_hjk222a
end type

type uc_insert from w_window`uc_insert within w_hjk222a
end type

type uc_delete from w_window`uc_delete within w_hjk222a
end type

type uc_save from w_window`uc_save within w_hjk222a
end type

type uc_excel from w_window`uc_excel within w_hjk222a
end type

type uc_print from w_window`uc_print within w_hjk222a
end type

type st_line1 from w_window`st_line1 within w_hjk222a
end type

type st_line2 from w_window`st_line2 within w_hjk222a
end type

type st_line3 from w_window`st_line3 within w_hjk222a
end type

type uc_excelroad from w_window`uc_excelroad within w_hjk222a
end type

type dw_con from uo_dw within w_hjk222a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk222a_c1"
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
		
	Case 'p_to_dt'
		ls_to_dt 	= String(This.Object.to_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'to_dt' , ls_to_dt)
		
		ls_to_dt 	= left(ls_to_dt, 4) + mid(ls_to_dt, 6, 2) + right(ls_to_dt, 2)
		This.SetItem(row, 'to_dt',  ls_to_dt)
End Choose
end event

event itemchanged;call super::itemchanged;DataWindowChild	ldwc_child, ldwc_child1

Choose Case dwo.name
	Case 'hjmod_gb'
		dw_main.SetRedraw(False)
		dw_detail.SetRedraw(False)
		
		If data = '2' Then
			
			dw_main.DataObject  = 'd_hjk222a_3'
			dw_detail.DataObject = 'd_hjk222a_4'
			
			dw_main.SetTransObject(sqlca)
			
			dw_main.GetChild('sayu_id', ldwc_child)
			ldwc_child.SetTransObject(SQLCA)
			ldwc_child.Retrieve('C')
			
			dw_detail.GetChild('sayu_id', ldwc_child1)
			ldwc_child1.SetTransObject(SQLCA)
			ldwc_child1.Retrieve('C')
			
//			dw_main.Event constructor()
			dw_detail.Event constructor()
			
		Else
			dw_main.DataObject  = 'd_hjk222a_1'
			dw_detail.DataObject = 'd_hjk222a_2'
			
			dw_main.GetChild('sayu_id', ldwc_child)
			ldwc_child.SetTransObject(SQLCA)
			ldwc_child.Retrieve('B')
			
			dw_detail.GetChild('sayu_id', ldwc_child1)
			ldwc_child1.SetTransObject(SQLCA)
			ldwc_child1.Retrieve('B')
			
			dw_main.Event constructor()
			dw_detail.Event constructor()
			
		End If

		dw_detail.insertrow(0)
		
		If data = '3' Then
			dw_2.Visible = False
			dw_3.Visible = True
			st_2.text = '< 학적변동내역 >'
		Else
			dw_2.Visible = True
			dw_3.Visible = False
			st_2.text = '< 성적내역 >'
		End If

		dw_main.SetRedraw(True)
		dw_detail.SetRedraw(True)
End Choose
end event

type dw_detail from uo_dw within w_hjk222a
integer x = 50
integer y = 804
integer width = 4384
integer height = 976
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk222a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_constructor;call super::ue_constructor;func.of_design_dw(dw_detail)
end event

type st_1 from statictext within w_hjk222a
integer x = 114
integer y = 1804
integer width = 466
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
string text = "< 등록금내역 >"
boolean focusrectangle = false
end type

type st_2 from statictext within w_hjk222a
integer x = 2400
integer y = 1804
integer width = 553
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 16777215
string text = "< 성적내역 >"
boolean focusrectangle = false
end type

type dw_1 from uo_grid within w_hjk222a
integer x = 50
integer y = 1860
integer width = 2295
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hjk210p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_2 from uo_grid within w_hjk222a
integer x = 2359
integer y = 1860
integer width = 2075
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hjk210p_2"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_grid within w_hjk222a
event type long ue_retrieve ( )
integer x = 50
integer y = 292
integer width = 4384
integer height = 508
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk222a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();String		ls_from_dt, ls_to_dt, ls_sign_gb, ls_sign_status[], ls_hjmod_gb, ls_gwa
Long		ll_rv,          ll_row

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ll_row = dw_con.GetRow()

ls_from_dt = dw_con.Object.from_dt[ll_row]
ls_to_dt     = dw_con.Object.to_dt[ll_row]
ls_sign_gb = dw_con.Object.sign_gb[ll_row]
ls_hjmod_gb = dw_con.Object.hjmod_gb[ll_row]
ls_gwa      = func.of_nvl(dw_con.Object.gwa[ll_row], '%')

Choose Case is_sign_nm
	Case '3'
		If ls_hjmod_gb = '1' Then
			If ls_sign_gb = '1' Then
				ls_sign_status[1] = '0'
				ls_sign_status[2] = '1'
				ls_sign_status[3] = '2'
				ls_sign_status[4] = '3'
				ls_sign_status[5] = '9'
			ElseIf ls_sign_gb = '2' Then
				ls_sign_status[1] = '2'
			Else
				ls_sign_status[1] = '3'
				ls_sign_status[2] = '9'
			End If
		Else
			If ls_sign_gb = '1' Then
				ls_sign_status[1] = '0'
				ls_sign_status[2] = '3'
				ls_sign_status[3] = '9'
			ElseIf ls_sign_gb = '2' Then
				ls_sign_status[1] = '0'
			Else
				ls_sign_status[1] = '3'
				ls_sign_status[2] = '9'
			End If
		End If
End Choose

ll_rv = This.Retrieve(ls_from_dt, ls_to_dt, ls_hjmod_gb, ls_sign_status, ls_gwa )

RETURN ll_rv

end event

event rowfocuschanged;call super::rowfocuschanged;String ls_apply_dt, ls_hakbun, ls_hjmod_id
Long   ll_apply_seq

If This.GetRow() < 1 Then Return ;

ls_apply_dt     = This.Object.apply_dt[currentrow]
ll_apply_seq   = This.Object.apply_seq[currentrow]
ls_hakbun       = This.Object.hakbun[currentrow]
ls_hjmod_id    = This.Object.hjmod_gb[currentrow]

dw_detail.Retrieve( ls_apply_dt, ls_hjmod_id, ll_apply_seq )
dw_1.Retrieve( ls_hakbun )
dw_2.Retrieve( ls_hakbun )
dw_3.Retrieve( ls_hakbun )

Return 
end event

event itemchanged;call super::itemchanged;String ls_old_sign_status, ls_hjmod_gb, ls_year, ls_hakgi, ls_dung_yn, ls_hakbun

Choose Case dwo.name
	Case 'sign_status'
		ls_old_sign_status = This.Object.sign_status.Original[row]
		ls_hjmod_gb         = This.Object.hjmod_gb[row]
		ls_year	 = f_haksa_iljung_year()
		ls_hakgi	 = f_haksa_iljung_hakgi()
		ls_hakbun = This.Object.hakbun[row]
		
		Choose Case ls_hjmod_gb
     		Case '1' // 휴학신청
				If ls_old_sign_status = '3' Then
					Messagebox('확인', '이미 확정처리 되었으므로 수정할 수 없습니다..')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End If
				
				If ls_old_sign_status = '9' Then
					Messagebox('확인', '이미 반려처리 되었으므로 수정할 수 없습니다..')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End If
				
				If ls_old_sign_status = '0' or ls_old_sign_status = '1' Then
					Messagebox('확인', '아직 결재 진행중입니다!')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End If
				
				If data = '0' Or data = '1'  Then
					Messagebox('확인', '해당 결재는 권한이 없습니다.')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End IF

				If data = '3' Then	
					// 등록금 등록만 되어도 'Y'
					SELECT NVL(DUNG_YN, 'N')
						  INTO :ls_dung_yn
						 FROM HAKSA.DUNGROK_GWANRI
					  WHERE HAKBUN = :ls_hakbun
						  AND YEAR    = :ls_year
						 AND HAKGI   = :ls_hakgi
					 USING SQLCA ;
					 
					 If sqlca.sqlcode <> 0 Then ls_dung_yn = 'N' ;
					 
					 This.Object.dungrok_injung[row] = ls_dung_yn
					 This.Object.sungjuk_injung[row] = 'Y'
					 This.Object.jogi_test[row]          = 'N'
					 This.Object.sign_status[row]       = '3'
				End If
				
				This.Object.member_no[row] = gs_empcode
				This.Object.sign_date[row]     = func.of_get_datetime()
				
			Case '2' // 복학신청
				If ls_old_sign_status = '3' Then
					Messagebox('확인', '이미 확정처리 되었으므로 수정할 수 없습니다..')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End If
				
				If ls_old_sign_status = '9' Then
					Messagebox('확인', '이미 반려처리 되었으므로 수정할 수 없습니다..')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End If
				
				This.Object.member_no[row] = gs_empcode
				This.Object.sign_date[row]    = func.of_get_datetime()
				
			Case '3', '4' // 휴학연기(변경)
				If ls_old_sign_status = '3' Then
					Messagebox('확인', '이미 확정처리 되었으므로 수정할 수 없습니다..')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End If
				
				If ls_old_sign_status = '9' Then
					Messagebox('확인', '이미 반려처리 되었으므로 수정할 수 없습니다..')
					This.Post SetItem(row, "sign_status", ls_old_sign_status )
					Return 1
				End If
				
				If data = '3' Then	
					// 등록금 등록만 되어도 'Y'
					SELECT NVL(DUNG_YN, 'N')
						  INTO :ls_dung_yn
						 FROM HAKSA.DUNGROK_GWANRI
					  WHERE HAKBUN = :ls_hakbun
						  AND YEAR    = :ls_year
						 AND HAKGI   = :ls_hakgi
					 USING SQLCA ;
					 
					 If sqlca.sqlcode <> 0 Then ls_dung_yn = 'N' ;
					 
					 This.Object.dungrok_injung[row] = ls_dung_yn
					 This.Object.sungjuk_injung[row] = 'N'
					  This.Object.jogi_test[row]         = 'N'
					 This.Object.sign_status[row]       = '3'
				End If
		
				This.Object.member_no[row] = gs_empcode
				This.Object.sign_date[row]    = func.of_get_datetime()
		End Choose
			
End Choose
end event

event retrieveend;call super::retrieveend;If rowcount > 0 Then This.event rowfocuschanged(1)
end event

type dw_3 from uo_grid within w_hjk222a
boolean visible = false
integer x = 2359
integer y = 1860
integer width = 2075
integer taborder = 30
string dataobject = "d_hjk222a_5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

