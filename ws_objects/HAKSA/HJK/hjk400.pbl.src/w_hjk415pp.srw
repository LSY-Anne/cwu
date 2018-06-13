$PBExportHeader$w_hjk415pp.srw
$PBExportComments$[청운대]발급번호 관리
forward
global type w_hjk415pp from w_popup
end type
type rb_4 from radiobutton within w_hjk415pp
end type
type st_4 from statictext within w_hjk415pp
end type
type rb_3 from radiobutton within w_hjk415pp
end type
type rb_2 from radiobutton within w_hjk415pp
end type
type rb_1 from radiobutton within w_hjk415pp
end type
type em_ilja from uo_date within w_hjk415pp
end type
type st_2 from statictext within w_hjk415pp
end type
type pb_cancel from picturebutton within w_hjk415pp
end type
type pb_save from picturebutton within w_hjk415pp
end type
type st_13 from statictext within w_hjk415pp
end type
type em_count from editmask within w_hjk415pp
end type
type em_year from uo_em_year within w_hjk415pp
end type
type st_6 from statictext within w_hjk415pp
end type
type st_1 from statictext within w_hjk415pp
end type
type gb_1 from uo_no_main_groupbox within w_hjk415pp
end type
end forward

global type w_hjk415pp from w_popup
integer width = 1541
integer height = 1180
string title = "발급번호관리"
rb_4 rb_4
st_4 st_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
em_ilja em_ilja
st_2 st_2
pb_cancel pb_cancel
pb_save pb_save
st_13 st_13
em_count em_count
em_year em_year
st_6 st_6
st_1 st_1
gb_1 gb_1
end type
global w_hjk415pp w_hjk415pp

type variables
string 	is_hakbun, is_id, is_gwa, is_hakyun, is_gubun, is_name, is_jumin
long 		il_money
datawindow idwc
window iw_win
end variables

on w_hjk415pp.create
int iCurrent
call super::create
this.rb_4=create rb_4
this.st_4=create st_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.em_ilja=create em_ilja
this.st_2=create st_2
this.pb_cancel=create pb_cancel
this.pb_save=create pb_save
this.st_13=create st_13
this.em_count=create em_count
this.em_year=create em_year
this.st_6=create st_6
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_4
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.rb_3
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.em_ilja
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.pb_cancel
this.Control[iCurrent+9]=this.pb_save
this.Control[iCurrent+10]=this.st_13
this.Control[iCurrent+11]=this.em_count
this.Control[iCurrent+12]=this.em_year
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.gb_1
end on

on w_hjk415pp.destroy
call super::destroy
destroy(this.rb_4)
destroy(this.st_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.em_ilja)
destroy(this.st_2)
destroy(this.pb_cancel)
destroy(this.pb_save)
destroy(this.st_13)
destroy(this.em_count)
destroy(this.em_year)
destroy(this.st_6)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;call super::open;string 	ls_addr

//학번,증명발급종류코드를 넘겨받음//////////////////////////////////////////////////////////////////
str_parms str_balgup
str_balgup = Message.PowerObjectParm

is_hakbun 	= str_balgup.s[1] 		// 학번
is_id 		= str_balgup.s[2]      	// 증명서 종류
is_gubun		= str_balgup.s[3]			// 한글증명서01, 영문증명서 02
iw_win		= str_balgup.w[1]
idwc			= str_balgup.dw[1]
em_count.text = '1'

choose case is_id
		
	case '01','02','03','04','07','08','09','10','11','12','13','14','15','16'
		
		SELECT 	GWA,
					DR_HAKYUN,
					HNAME,
					JUMIN_NO
		INTO		:is_gwa,
					:is_hakyun,
					:is_name,
					:is_jumin
		FROM		HAKSA.JAEHAK_HAKJUK
		WHERE  	HAKBUN = :is_hakbun
		
		UNION		
		SELECT 	GWA,
					DR_HAKYUN,
					HNAME,
					JUMIN_NO
		FROM		HAKSA.JOLUP_HAKJUK
		WHERE  	HAKBUN = :is_hakbun	
		USING SQLCA ;

		SELECT 	B_MONEY
		INTO		:il_money
		FROM		HAKSA.JUNGMYUNG_CODE
		WHERE  	JUNGMYUNG_ID = :is_id
		USING SQLCA ;
		
	case '05','06'
		SELECT 	GWA,
					DR_HAKYUN,
					HNAME,
					JUMIN_NO
		INTO		:is_gwa,
					:is_hakyun,
					:is_name,
					:is_jumin
		FROM		HAKSA.JOLUP_HAKJUK
		WHERE  	HAKBUN = :is_hakbun
		USING SQLCA ;

		SELECT 	B_MONEY
		INTO		:il_money
		FROM		HAKSA.JUNGMYUNG_CODE
		WHERE  	JUNGMYUNG_ID = :is_id
		USING SQLCA ;	

end choose
end event

type p_msg from w_popup`p_msg within w_hjk415pp
end type

type st_msg from w_popup`st_msg within w_hjk415pp
end type

type uc_printpreview from w_popup`uc_printpreview within w_hjk415pp
end type

type uc_cancel from w_popup`uc_cancel within w_hjk415pp
end type

type uc_ok from w_popup`uc_ok within w_hjk415pp
end type

type uc_excelroad from w_popup`uc_excelroad within w_hjk415pp
end type

type uc_excel from w_popup`uc_excel within w_hjk415pp
end type

type uc_save from w_popup`uc_save within w_hjk415pp
end type

type uc_delete from w_popup`uc_delete within w_hjk415pp
end type

type uc_insert from w_popup`uc_insert within w_hjk415pp
end type

type uc_retrieve from w_popup`uc_retrieve within w_hjk415pp
end type

type ln_temptop from w_popup`ln_temptop within w_hjk415pp
end type

type ln_1 from w_popup`ln_1 within w_hjk415pp
end type

type ln_2 from w_popup`ln_2 within w_hjk415pp
end type

type ln_3 from w_popup`ln_3 within w_hjk415pp
end type

type r_backline1 from w_popup`r_backline1 within w_hjk415pp
end type

type r_backline2 from w_popup`r_backline2 within w_hjk415pp
end type

type r_backline3 from w_popup`r_backline3 within w_hjk415pp
end type

type uc_print from w_popup`uc_print within w_hjk415pp
end type

type rb_4 from radiobutton within w_hjk415pp
integer x = 809
integer y = 780
integer width = 517
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "해외유학생용"
end type

event clicked;if this.checked = true then
	rb_1.checked = false
	rb_2.checked = false	
end if
end event

type st_4 from statictext within w_hjk415pp
integer x = 210
integer y = 616
integer width = 512
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "발행  용도"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_3 from radiobutton within w_hjk415pp
integer x = 357
integer y = 780
integer width = 411
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "Fax발급용"
end type

event clicked;if this.checked = true then
	rb_1.checked = false
	rb_2.checked = false	
end if
end event

type rb_2 from radiobutton within w_hjk415pp
integer x = 809
integer y = 700
integer width = 517
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "확인용"
end type

event clicked;if this.checked = true then
	rb_1.checked = false
	rb_3.checked = false	
end if
end event

type rb_1 from radiobutton within w_hjk415pp
integer x = 357
integer y = 700
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "발급용"
boolean checked = true
end type

event clicked;if this.checked = true then
	rb_2.checked = false
	rb_3.checked = false	
end if
end event

type em_ilja from uo_date within w_hjk415pp
integer x = 731
integer y = 420
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_2 from statictext within w_hjk415pp
integer x = 210
integer y = 424
integer width = 512
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "발급  일자"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_cancel from picturebutton within w_hjk415pp
integer x = 1033
integer y = 904
integer width = 416
integer height = 96
integer taborder = 140
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "취소"
string picturename = "D:\청운대\CWU\BMP\P_CANCES.BMP"
end type

event clicked; Close(Parent)
end event

type pb_save from picturebutton within w_hjk415pp
integer x = 585
integer y = 904
integer width = 416
integer height = 96
integer taborder = 130
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "확인"
string picturename = "D:\청운대\CWU\BMP\P_CHECKE.BMP"
end type

event clicked;integer 	li_i,			&
			li_surang,  &
			li_max,		&
			li_ans
string 	ls_year,		&	
			ls_yongdo, 	&
			ls_ilja,		& 
			ls_gwa,		&
			ls_bunho,	&
			ls_uid,		&
			ls_ip,		&
			ls_max
long 		ll_num	
datetime	ld_date


ls_uid 	= gs_empcode	//작성자
ls_ip   	= gs_ip	         //ipaddr
ld_date	= f_sysdate()
 
 
 if em_year.text = "" or em_count.text = "" or em_ilja.text = "" then
	 messagebox ("입력오류","발급년도, 매수, 발급일자는 ~n" &
	          + "반드시 입력해야 합니다.")
	 em_year.setfocus()			 
 else	 
		
	li_surang 	= integer(em_count.text)
	ls_ilja 		= string(date(em_ilja.text), 'yyyymmdd')
	ls_year		= string(em_year.text)
	
//***********************************************************************
// 발급대장에 등록하는 모듈
// 수량 만큼 발급번호 부여
//***********************************************************************


//***********************************************************************
// 발급용 데이터베이스저장 및 출력

	if rb_1.checked = true then
		
		ls_yongdo = '01'
		
				
		for li_i = 1 to li_surang
			
			//삭제 번호 채번
			SELECT	lpad(TO_CHAR(MIN(BUNHO)),5,'0')
			INTO		:ls_max
			FROM		HAKSA.BALGUP_DAEJANG_BACKUP
			WHERE		YONGDO_ID	= :ls_yongdo
			AND		STATUS		= 'D'
			AND		CHEBUN_YABU	= '0'
			AND		YEAR			= :ls_year
			USING SQLCA ;
		
		
			if trim(ls_max) = '' or isnull(ls_max) then
				
				//기존 다음번호 채번
				SELECT 	lpad(to_char(nvl(MAX(BUNHO), 0) + 1),5,'0') 
				INTO		:ls_max
				FROM		HAKSA.BALGUP_DAEJANG
				WHERE		YONGDO_ID = :ls_yongdo
				AND		YEAR			= :ls_year			
				USING SQLCA ;
				
				if sqlca.sqlcode = -1 then		
					messagebox('경고!', '채번을 실패하였습니다!')
					return
				end if
				
				ls_bunho = ls_max

			else
				//백업 테이블 삭제된 데이터 chebun_yabu = '1' setting
								
				ls_bunho = ls_max
				
				UPDATE	HAKSA.BALGUP_DAEJANG_BACKUP
				SET		CHEBUN_YABU	= '1'
				WHERE		YONGDO_ID	= :ls_yongdo
				AND		BUNHO 		= :ls_max
				AND		YEAR			= :ls_year
				AND		STATUS		= 'D'
				AND		CHEBUN_YABU	= '0'
				USING SQLCA ;
				
				if sqlca.sqlcode = 0 then
					COMMIT USING SQLCA ;
				end if
			end if
			
			INSERT INTO HAKSA.BALGUP_DAEJANG  
					( 	YEAR,   
						BUNHO,  
						YONGDO_ID, 
						JUNGMYUNG_ID,
						HAKBUN,
						GWA,
						SU_HAKYUN,
						B_ILJA,
						B_MONEY,   
						WORKER,
						IPADDR,
						WORK_DATE 
					)   
			VALUES ( :ls_year,        					//년도
						:ls_bunho,        				//발급번호
						:ls_yongdo,							//발급용도
						:is_id,           				//증명서종류
						:is_hakbun,   		  				//학번
						:is_gwa,          				//학과
						:is_hakyun,			     			//학년
						:ls_ilja,       					//발행일자
						:il_money,      					//발행금액
						:ls_uid,								//작성자
						:ls_ip,								//ipaddr
						:ld_date
					 ) USING SQLCA ;
	  
			if sqlca.sqlcode = 0 then
				
				choose case is_gubun
					case '01'
						idwc.dataobject= 'd_hjk406p_3'
						idwc.settransobject(sqlca)
					case '02'
						idwc.dataobject= 'd_hjk406p_4'
						idwc.settransobject(sqlca)	
				end choose
				idwc.retrieve(is_hakbun, is_name, is_jumin)
				
				parent.idwc.object.t_num.text = ls_year + '-' + ls_bunho
				parent.idwc.print()
     		else
		  		messagebox('에러',sqlca.sqlerrtext)
	     		rollback  USING SQLCA ;
	     	end if
			  
		next
		li_ans = MessageBox('확인', " 증명서출력이 성공적으로 처리되었습니까?", &
		Exclamation!, OKCancel!, 2) 
		
		IF li_ans = 1 THEN
			commit USING SQLCA ;
			closewithreturn(parent,1)
		ELSE
			rollback USING SQLCA ;
		END IF
		
//***********************************************************************
// 확인용 출력	

	elseif rb_2.checked = true then
		
		ls_yongdo = '02'
		
		for li_i = 1 to li_surang
			
			choose case is_gubun
				case '01'
					idwc.dataobject= 'd_hjk406p_1'
					idwc.settransobject(sqlca)
				case '02'
					idwc.dataobject= 'd_hjk406p_2'
					idwc.settransobject(sqlca)	
			end choose
			idwc.retrieve(is_hakbun, is_name, is_jumin)
			
			parent.idwc.object.t_num.text = '확인용'
			parent.idwc.print()
			  
		next
		
		closewithreturn(parent,1)
//***********************************************************************
// Fax용 데이터베이스저장 및 출력

	elseif rb_3.checked = true then
		
		ls_yongdo = '03'
		
		SELECT 	SUBSTR(MAX(BUNHO),2,4) 
		INTO		:li_max
		FROM		HAKSA.BALGUP_DAEJANG
		WHERE		YONGDO_ID = :ls_yongdo
		AND		YEAR			= :ls_year
		USING SQLCA ;
		
		if isnull(li_max) then li_max = 0
		
		for li_i = 1 to li_surang
			
			ls_bunho = string(li_max + li_i , 'F0000')
			
			INSERT INTO HAKSA.BALGUP_DAEJANG  
					( 	YEAR,   
						BUNHO,  
						YONGDO_ID, 
						JUNGMYUNG_ID,
						HAKBUN,
						GWA,
						SU_HAKYUN,
						B_ILJA,
						B_MONEY,   
						WORKER,
						IPADDR,
						WORK_DATE )   
			VALUES ( :ls_year,        					//년도
						:ls_bunho,        				//발급번호
						:ls_yongdo,							//발급용도
						:is_id,           				//증명서종류
						:is_hakbun,   		  				//학번
						:is_gwa,          				//학과
						:is_hakyun,			     			//학년
						:ls_ilja,       					//발행일자
						1000,      					//발행금액
						:ls_uid,								//작성자
						:ls_ip,								//ipaddr
						:ld_date
					 ) USING SQLCA ;
	  
			if sqlca.sqlcode = 0 then
				
				choose case is_gubun
					case '01'
						idwc.dataobject= 'd_hjk406p_3'
						idwc.settransobject(sqlca)
					case '02'
						idwc.dataobject= 'd_hjk406p_4'
						idwc.settransobject(sqlca)	
				end choose
				idwc.retrieve(is_hakbun, is_name, is_jumin)
				
				parent.idwc.object.t_num.text = ls_year + '-' + ls_bunho
				parent.idwc.print()
     		else
		  		messagebox('에러',sqlca.sqlerrtext)
	     		rollback USING SQLCA ;
	     	end if
			  
		next
		
		li_ans = MessageBox('확인', " 증명서출력이 성공적으로 처리되었습니까?", &
		Exclamation!, OKCancel!, 2) 
		
		IF li_ans = 1 THEN
			commit USING SQLCA ;
			closewithreturn(parent,1)
		ELSE
			rollback USING SQLCA ;
		END IF
		
//***********************************************************************
// 해외유학생용 데이터베이스저장 및 출력 /2009. 5. 1
// 천진공업대학으로 2+2학생용 1,2학년성적만 나오게 처리

		
	elseif rb_4.checked = true then
		
		ls_yongdo = '01'
		
				
		for li_i = 1 to li_surang
			
			//삭제 번호 채번
			SELECT	lpad(TO_CHAR(MIN(BUNHO)),5,'0')
			INTO		:ls_max
			FROM		HAKSA.BALGUP_DAEJANG_BACKUP
			WHERE		YONGDO_ID	= :ls_yongdo
			AND		STATUS		= 'D'
			AND		CHEBUN_YABU	= '0'
			AND		YEAR			= :ls_year
			USING SQLCA ;
		
		
			if trim(ls_max) = '' or isnull(ls_max) then
				
				//기존 다음번호 채번
				SELECT 	lpad(to_char(nvl(MAX(BUNHO), 0) + 1),5,'0') 
				INTO		:ls_max
				FROM		HAKSA.BALGUP_DAEJANG
				WHERE		YONGDO_ID = :ls_yongdo
				AND		YEAR			= :ls_year			
				USING SQLCA ;
				
				if sqlca.sqlcode = -1 then		
					messagebox('경고!', '채번을 실패하였습니다!')
					return
				end if
				
				ls_bunho = ls_max

			else
				//백업 테이블 삭제된 데이터 chebun_yabu = '1' setting
								
				ls_bunho = ls_max
				
				UPDATE	HAKSA.BALGUP_DAEJANG_BACKUP
				SET		CHEBUN_YABU	= '1'
				WHERE		YONGDO_ID	= :ls_yongdo
				AND		BUNHO 		= :ls_max
				AND		YEAR			= :ls_year
				AND		STATUS		= 'D'
				AND		CHEBUN_YABU	= '0'
				USING SQLCA ;
				
				if sqlca.sqlcode = 0 then
					COMMIT USING SQLCA ;
				end if
			end if
			
			INSERT INTO HAKSA.BALGUP_DAEJANG  
					( 	YEAR,   
						BUNHO,  
						YONGDO_ID, 
						JUNGMYUNG_ID,
						HAKBUN,
						GWA,
						SU_HAKYUN,
						B_ILJA,
						B_MONEY,   
						WORKER,
						IPADDR,
						WORK_DATE 
					)   
			VALUES ( :ls_year,        					//년도
						:ls_bunho,        				//발급번호
						:ls_yongdo,							//발급용도
						:is_id,           				//증명서종류
						:is_hakbun,   		  				//학번
						:is_gwa,          				//학과
						:is_hakyun,			     			//학년
						:ls_ilja,       					//발행일자
						:il_money,      					//발행금액
						:ls_uid,								//작성자
						:ls_ip,								//ipaddr
						:ld_date
					 ) USING SQLCA ;
	  
			if sqlca.sqlcode = 0 then
				
				choose case is_gubun
					case '01'
//						idwc.dataobject= 'd_hjk406p_1'
//						idwc.settransobject(sqlca)
				  		messagebox('확인','해외유학생(2+2, 3+1)학생의 국문성적은 개발 미완료 상태입니다')
	     				rollback USING SQLCA ;
					case '02'
						idwc.dataobject= 'd_hjk406p_6'
						idwc.settransobject(sqlca)	
				end choose
				idwc.retrieve(is_hakbun, is_name, is_jumin)
				
				parent.idwc.object.t_num.text = ls_year + '-' + ls_bunho
				parent.idwc.print()
     		else
		  		messagebox('에러',sqlca.sqlerrtext)
	     		rollback USING SQLCA ;
	     	end if
			  
		next
		li_ans = MessageBox('확인', " 증명서출력이 성공적으로 처리되었습니까?", &
		Exclamation!, OKCancel!, 2) 
		
		IF li_ans = 1 THEN
			commit USING SQLCA ;
			closewithreturn(parent,1)
		ELSE
			rollback USING SQLCA ;
		END IF
				
		
	end if
			 
end if

end event

type st_13 from statictext within w_hjk415pp
integer x = 69
integer y = 128
integer width = 1371
integer height = 108
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 8388736
string text = "증명서 발급대장 관리"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_count from editmask within w_hjk415pp
integer x = 731
integer y = 512
integer width = 402
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 1090519039
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
double increment = 1
string minmax = "1~~99"
end type

type em_year from uo_em_year within w_hjk415pp
integer x = 731
integer y = 328
integer width = 242
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_6 from statictext within w_hjk415pp
integer x = 210
integer y = 520
integer width = 512
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "발행  매수"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_hjk415pp
integer x = 210
integer y = 332
integer width = 512
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "발급  년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from uo_no_main_groupbox within w_hjk415pp
integer x = 55
integer y = 76
integer width = 1403
integer height = 812
integer taborder = 0
long backcolor = 16777215
end type

