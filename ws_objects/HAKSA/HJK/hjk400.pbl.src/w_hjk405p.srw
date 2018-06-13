$PBExportHeader$w_hjk405p.srw
$PBExportComments$[청운대]재적증명서출력
forward
global type w_hjk405p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjk405p
end type
type dw_con from uo_dwfree within w_hjk405p
end type
end forward

global type w_hjk405p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hjk405p w_hjk405p

on w_hjk405p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjk405p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string 	ls_hakbun, ls_name, ls_jumin, ls_ename, ls_eaddr, ls_hakbun1, ls_name1, ls_jumin1, ls_gubun
integer 	li_ans, li_count
      
dw_con.AcceptText()

 //조회조건
ls_hakbun	= dw_con.Object.hakbun[1]
ls_name		= dw_con.Object.hname[1]
ls_jumin      = dw_con.Object.jumin_no[1]
ls_gubun     = dw_con.Object.sangtae[1]

if (Isnull(ls_hakbun) Or ls_hakbun = '') and (Isnull(ls_name) Or ls_name = '') and (Isnull(ls_jumin) Or ls_jumin = '') Then
	//학번을 입력하도록 함
	Messagebox("확인", "조회할 학번이나 이름을 입력하세요")
	dw_con.setfocus()
	dw_con.SetColumn("hakbun")
else
	ls_hakbun1 	= dw_con.Object.hakbun[1]
	ls_name1 	= dw_con.Object.hname[1]
	
	if left(ls_jumin,6) + right(ls_jumin,7) = '             ' then 
		ls_jumin1 =  ''
	else
		ls_jumin1 = ls_jumin
	end if

	SELECT	count( JAEHAK_HAKJUK.HAKBUN )  
  	INTO		:li_count
  	FROM		HAKSA.JAEHAK_HAKJUK  
  	WHERE	( HAKBUN		LIKE :ls_hakbun1||'%')	
	AND     	( HNAME		LIKE :ls_name1||'%'	)
	AND		( JUMIN_NO 	LIKE :ls_jumin1||'%'	)
	USING SQLCA
	;

	if li_count = 0 then
		messagebox("확인", "해당 학생은 존재하지 않습니다.!", Exclamation!)
		dw_con.setfocus()
	    dw_con.SetColumn("hakbun")
		return 1
	
	elseif li_count = 1 then
			
			SELECT	HAKBUN,
						HNAME,
						JUMIN_NO
			INTO		:ls_hakbun,
						:ls_name,
						:ls_jumin
			FROM		HAKSA.JAEHAK_HAKJUK  
			WHERE	( HNAME		like :ls_name1||'%'	)
			and		( HAKBUN		like :ls_hakbun1||'%'	)
			and		( JUMIN_NO  like :ls_jumin1||'%'	)
			USING SQLCA
			;
			
			dw_con.Object.hakbun[1]    = ls_hakbun
			dw_con.Object.hname[1]    = ls_name
			dw_con.Object.jumin_no[1] = ls_jumin
		
	elseif li_count >=2 then
		
		OpenWithParm(w_hjk101pp, ls_name1)
		
		ls_hakbun	= Message.StringParm
		
		SELECT	count(HAKBUN)  
		INTO		:li_count
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE		( HAKBUN	= :ls_hakbun)
		USING SQLCA
		;           
	
		if li_count = 1 then
			
			SELECT	HNAME,
						JUMIN_NO
			INTO		:ls_name,
						:ls_jumin
			FROM		HAKSA.JAEHAK_HAKJUK  
			WHERE	( HAKBUN		like :ls_hakbun||'%')
			USING SQLCA
			;
			
			dw_con.Object.hakbun[1]    = ls_hakbun
			dw_con.Object.hname[1]    = ls_name
			dw_con.Object.jumin_no[1] = ls_jumin
		end if
		
	end if
	
	if ls_gubun = '1' Then 	// 한글증명서
	 
			dw_main.dataobject= 'd_hjk405p_1'
			dw_main.settransobject(sqlca)
			dw_main.Modify("datawindow.print.preview=yes")
			li_ans = dw_main.retrieve(ls_hakbun, ls_name, ls_jumin)

		   if li_ans < 1 then
				uf_messagebox(7)
				dw_main.reset()
			end if
  
    elseif ls_gubun = '2' Then
						
			select	ename,
						addr_e
			into		:ls_ename,
						:ls_eaddr
			from		haksa.jaehak_hakjuk
			where		hakbun 	like :ls_hakbun
			and		hname	 	like :ls_name
			and		jumin_no	like :ls_jumin
			USING SQLCA
			;
			
			if ls_ename = '' or isnull(ls_ename) or ls_eaddr = '' or isnull(ls_eaddr) then
					// 구조체를 이용한 파라미터 값 넘기기
				str_parms str_search
				
				if ls_hakbun = ''or isnull(ls_hakbun) then
					
					if ls_name = '' or isnull(ls_name) then
						str_search.s[1] 	= ls_jumin
					else
						str_search.s[1]	= ls_name
					end if
				else 
					
					str_search.s[1]	= ls_hakbun
				end if
				
				openwithparm(w_hjk413pp,str_search)
				
				dw_main.dataobject= 'd_hjk405p_2'
				dw_main.settransobject(sqlca)
				dw_main.Modify("datawindow.print.preview=yes")
				li_ans = dw_main.retrieve(ls_hakbun, ls_name, ls_jumin)
			
			else
				dw_main.dataobject= 'd_hjk405p_2'
				dw_main.settransobject(sqlca)
				dw_main.Modify("datawindow.print.preview=yes")
				li_ans = dw_main.retrieve(ls_hakbun, ls_name, ls_jumin)
			end if	
				
			if li_ans < 1 then 
				uf_messagebox(7)
				dw_main.reset()
			end if
		
	  end if

end if

Return 1
end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)
end event

event ue_print;//override
string 	ls_hakbun,	&
			ls_hakyun,	&
			ls_gwa, ls_gubun
long		ll_check	,	&
			ll_money
			
dw_con.AcceptText()

//조회조건
ls_gubun     = dw_con.Object.sangtae[1]

if ls_gubun = '1' Then  // 한글 증명서
	
	ls_hakbun = dw_main.object.jaehak_hakjuk_hakbun[dw_main.getrow()]						
	
	// 구조체를 이용한 파라미터 값 넘기기
	str_parms str_balgup
	str_balgup.s[1] 	= ls_hakbun
	str_balgup.s[2] 	= '09' // 재적증명서
	str_balgup.w[1]	= w_hjk405p
	str_balgup.dw[1] 	= idw_print
	
	openwithparm(w_hjk411pp,str_balgup)

else  // 영문 증명서
   
	ls_hakbun = dw_main.object.jaehak_hakjuk_hakbun[dw_main.getrow()]
	
	// 구조체를 이용한 파라미터 값 넘기기
	str_parms str_balgup2
	str_balgup2.s[1] = ls_hakbun
	str_balgup2.s[2] = '10'
	str_balgup2.w[1]	= w_hjk405p	
	str_balgup2.dw[1] 	= idw_print		
	openwithparm(w_hjk411pp,str_balgup2)

end if	

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk405p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk405p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk405p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk405p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk405p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk405p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk405p
end type

type uc_insert from w_condition_window`uc_insert within w_hjk405p
end type

type uc_delete from w_condition_window`uc_delete within w_hjk405p
end type

type uc_save from w_condition_window`uc_save within w_hjk405p
end type

type uc_excel from w_condition_window`uc_excel within w_hjk405p
end type

type uc_print from w_condition_window`uc_print within w_hjk405p
end type

type st_line1 from w_condition_window`st_line1 within w_hjk405p
end type

type st_line2 from w_condition_window`st_line2 within w_hjk405p
end type

type st_line3 from w_condition_window`st_line3 within w_hjk405p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk405p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk405p
end type

type gb_1 from w_condition_window`gb_1 within w_hjk405p
end type

type gb_2 from w_condition_window`gb_2 within w_hjk405p
end type

type dw_main from uo_search_dwc within w_hjk405p
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk405p_1"
end type

type dw_con from uo_dwfree within w_hjk405p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk401p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

