$PBExportHeader$w_hjk101a.srw
$PBExportComments$[청운대]학적기본사항관리
forward
global type w_hjk101a from w_common_tab
end type
type dw_tab1 from uo_dwfree within tabpage_1
end type
type p_photo from picture within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tab2 from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_tab2 dw_tab2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_tab3 from uo_grid within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_tab3 dw_tab3
end type
type tabpage_4 from userobject within tab_1
end type
type st_2 from statictext within tabpage_4
end type
type st_1 from statictext within tabpage_4
end type
type dw_tab4_1 from uo_grid within tabpage_4
end type
type dw_tab4 from uo_grid within tabpage_4
end type
type tabpage_4 from userobject within tab_1
st_2 st_2
st_1 st_1
dw_tab4_1 dw_tab4_1
dw_tab4 dw_tab4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_tab5 from uo_grid within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_tab5 dw_tab5
end type
type uo_2 from uo_imgbtn within w_hjk101a
end type
end forward

global type w_hjk101a from w_common_tab
uo_2 uo_2
end type
global w_hjk101a w_hjk101a

type variables
string	is_hakbun
integer	ii_index
DataWindowChild idwc_sayu
end variables

on w_hjk101a.create
int iCurrent
call super::create
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
end on

on w_hjk101a.destroy
call super::destroy
destroy(this.uo_2)
end on

event ue_retrieve;call super::ue_retrieve;string	ls_name,  	ls_sangtae,		ls_hakbun,	ls_hname
int		li_count, 		li_count1,		li_count2	,	li_row	,		li_rtn

dw_con.AcceptText()

ls_name		= dw_con.Object.hname[1]
ls_hakbun	= dw_con.Object.hakbun[1]
ls_sangtae   = dw_con.Object.sangtae[1]

if ls_hakbun = '' Or Isnull(ls_hakbun) Then
	messagebox("확인","학번을 입력하세요!")
	dw_con.setfocus()
	dw_con.setColumn("hakbun")
	return -1
end if

if ls_name = '' Or Isnull(ls_name) Then
	messagebox("확인","성명을 입력하세요!")
	dw_con.setfocus()
	dw_con.setColumn("hname")
	return -1
end if

if ls_sangtae = '1' then
	SELECT	count( JAEHAK_HAKJUK.HAKBUN )  
  	INTO		:li_count1
  	FROM		HAKSA.JAEHAK_HAKJUK  
  	WHERE		( JAEHAK_HAKJUK.HAKBUN	LIKE :ls_hakbun||'%'	)
	    AND       	( JAEHAK_HAKJUK.HNAME	LIKE :ls_name||'%'	)
     USING SQLCA	;
Else

   SELECT	count( JOLUP_HAKJUK.HAKBUN )  
   INTO 		:li_count2
   FROM 		HAKSA.JOLUP_HAKJUK  
   WHERE 	( JOLUP_HAKJUK.HAKBUN	LIKE :ls_hakbun||'%'	)	
	AND     	( JOLUP_HAKJUK.HNAME 	LIKE :ls_name||'%'	)
   USING SQLCA ;
end if

li_count	= li_count1 + li_count2

if li_count = 0 then
	messagebox("확인", "해당 학생은 존재하지 않습니다.!", Exclamation!)
	dw_con.setfocus()
	dw_con.SetColumn("hname")
	return -1

elseif li_count = 1 then
	
	if li_count1 = 1 then
		
		SELECT	JAEHAK_HAKJUK.HAKBUN,
					JAEHAK_HAKJUK.HNAME
		INTO		:is_hakbun,
					:ls_hname
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE		( JAEHAK_HAKJUK.HNAME	like :ls_name||'%'	)
		and		( JAEHAK_HAKJUK.HAKBUN	like :ls_hakbun||'%'	)
		USING SQLCA	;
		
		dw_con.Object.hname[1] = ls_hname
		tab_1.tabpage_1.dw_tab1.dataobject	= 'd_hjk101a_1'
		tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
		li_row	= tab_1.tabpage_1.dw_tab1.retrieve(is_hakbun)
		tab_1.tabpage_1.dw_tab1.setfocus()
				
	elseif li_count2 = 1 then
		
		SELECT	JOLUP_HAKJUK.HAKBUN,
					JOLUP_HAKJUK.HNAME
		INTO 		:is_hakbun,
					:ls_hname
		FROM 		HAKSA.JOLUP_HAKJUK
		WHERE 	( JOLUP_HAKJUK.HNAME 	like :ls_name||'%' )
		and		( JOLUP_HAKJUK.HAKBUN	like :ls_hakbun||'%')
		USING SQLCA	;		

		dw_con.Object.hname[1] = ls_hname
		tab_1.tabpage_1.dw_tab1.dataobject	= 'd_hjk101a_2'
		tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
		li_row	= tab_1.tabpage_1.dw_tab1.retrieve(is_hakbun)
		tab_1.tabpage_1.dw_tab1.setfocus()

	end if	
	
	if li_row = 0 then
		// 조회 자료가 없을 경우 나머지tab 부분은 control할 수 없도록 한다.
		tab_1.tabpage_1.dw_tab1.reset()
		tab_1.tabpage_2.enabled = FALSE
		tab_1.tabpage_3.enabled = FALSE
		tab_1.tabpage_4.enabled = FALSE
		tab_1.tabpage_5.enabled = FALSE
		//조회한 자료가 없을때 메세지 출력
		messagebox("확인", "해당 학생은 존재하지 않습니다.!", Exclamation!)

		dw_con.setfocus()
		dw_con.SetColumn("hname")
		return -1
	elseif li_row = -1 then
		tab_1.tabpage_1.dw_tab1.reset()
		tab_1.tabpage_2.enabled = FALSE
		tab_1.tabpage_3.enabled = FALSE
		tab_1.tabpage_4.enabled = FALSE
		tab_1.tabpage_5.enabled = FALSE		
		//조회시 오류가 발생했을때 메세지 출력
         f_set_message("조회시 오류가 발생하였습니다!", '', parentwin)
		dw_con.setfocus()
		dw_con.SetColumn("hname")
		return -1
	else
		tab_1.tabpage_2.enabled = true
		tab_1.tabpage_3.enabled = true
		tab_1.tabpage_4.enabled = true
		tab_1.tabpage_5.enabled = true

		tab_1.tabpage_1.dw_tab1.setcolumn('hakbun')
	end if
	
elseif li_count >=2 then
	
	
	OpenWithParm(w_hjk101pp, ls_name)
	
	is_hakbun	= Message.StringParm
	
	SELECT	count(JAEHAK_HAKJUK.HAKBUN)  
  	INTO		:li_count1
  	FROM		HAKSA.JAEHAK_HAKJUK  
  	WHERE	( JAEHAK_HAKJUK.HAKBUN	= :is_hakbun)
	USING SQLCA	;           

	SELECT	count( JOLUP_HAKJUK.HAKBUN )  
    INTO 		:li_count2
    FROM 	HAKSA.JOLUP_HAKJUK  
    WHERE 	( JOLUP_HAKJUK.HAKBUN	= :is_hakbun)
	USING SQLCA	;
	
	if li_count1 = 1 then
		
		SELECT	JAEHAK_HAKJUK.HNAME
		INTO		:ls_hname
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE	( JAEHAK_HAKJUK.HAKBUN		like :is_hakbun||'%')
		USING SQLCA	;
		
		dw_con.Object.hname[1] = ls_hname
		tab_1.tabpage_1.dw_tab1.dataobject	= 'd_hjk101a_1'
		tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
		li_row	= tab_1.tabpage_1.dw_tab1.retrieve(is_hakbun)
		tab_1.tabpage_1.dw_tab1.setfocus()
		
	elseif li_count2 = 1 then
		
		SELECT	JOLUP_HAKJUK.HNAME
		INTO		:ls_hname
		FROM		HAKSA.JOLUP_HAKJUK  
		WHERE		( JOLUP_HAKJUK.HAKBUN		like :is_hakbun||'%')
		USING SQLCA	;	
		
		dw_con.Object.hname[1] = ls_hname
		tab_1.tabpage_1.dw_tab1.dataobject	= 'd_hjk101a_2'
		tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
		li_row	= tab_1.tabpage_1.dw_tab1.retrieve(is_hakbun)
		tab_1.tabpage_1.dw_tab1.setfocus()
		
	end if
	
	if li_row = 0 then
		// 조회 자료가 없을 경우 나머지tab 부분은 control할 수 없도록 한다.
		tab_1.tabpage_1.dw_tab1.reset()
		
		tab_1.tabpage_2.enabled = FALSE
		tab_1.tabpage_3.enabled = FALSE
		tab_1.tabpage_4.enabled = FALSE
		tab_1.tabpage_5.enabled = FALSE		
		//조회한 자료가 없을때 메세지 출력
		messagebox("확인", "해당 학생은 존재하지 않습니다.!", Exclamation!)
		dw_con.setfocus()
		dw_con.SetColumn("hname")
		return -1
	elseif li_row = -1 then
		tab_1.tabpage_1.dw_tab1.reset()
		tab_1.tabpage_2.enabled = FALSE
		tab_1.tabpage_3.enabled = FALSE
		tab_1.tabpage_4.enabled = FALSE
		tab_1.tabpage_5.enabled = FALSE		
		//조회시 오류가 발생했을때 메세지 출력
		f_set_message("조회시 오류가 발생하였습니다!", '', parentwin)
		dw_con.setfocus()
		dw_con.SetColumn("hname")
		return -1
	else
		tab_1.tabpage_2.enabled = TRUE
		tab_1.tabpage_3.enabled = TRUE
		tab_1.tabpage_4.enabled = TRUE
		tab_1.tabpage_5.enabled = TRUE
		
		tab_1.tabpage_1.dw_tab1.setcolumn('hakbun')
	end if
	
end if

func.of_design_dw(tab_1.tabpage_1.dw_tab1)

tab_1.tabpage_1.p_photo.picturename = '.\image\img2.jpg'

end event

event ue_insert;call super::ue_insert;String ls_gubun

dw_con.Accepttext()
ls_gubun = dw_con.Object.sangtae[1]

if ls_gubun = '1' Then
	long ll_line
	string ls_hakbun
	
	CHOOSE case ii_index
			 case	1
					messagebox("확인","'학번','이름','학부,전공',학년'은 ~n 반드시 기입하시기 바랍니다")
					ll_line = tab_1.tabpage_1.dw_tab1.insertrow(0)
					tab_1.tabpage_1.dw_tab1.object.sangtae[ll_line]   = '01'
					tab_1.tabpage_1.dw_tab1.object.hjmod_id[ll_line] = 'A'
					
					if ll_line <> -1 then
						tab_1.tabpage_1.dw_tab1.scrolltorow(ll_line)
						tab_1.tabpage_1.dw_tab1.setcolumn(1)
						tab_1.tabpage_1.dw_tab1.setfocus()
					end if
	END CHOOSE

else
	messagebox("확인","졸업자는 조회만 가능합니다!")
end if	

end event

event ue_saveend;call super::ue_saveend;int li_ans, l_cnt
string ls_hakbun,  ls_gwa,  ls_year

tab_1.tabpage_1.dw_tab1.accepttext()

CHOOSE case ii_index
		 case	1
			ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[1]
			ls_gwa     = tab_1.tabpage_1.dw_tab1.object.gwa[1]
			
			select max(year)
			  into :ls_year
			  from haksa.haksa_iljung
			 using sqlca ;
			  
		   update haksa.bokhakja_list
			   set gwa      = :ls_gwa
			 where year   = :ls_year
			   and hakbun = :ls_hakbun
			 using sqlca ;
	
END CHOOSE

Return 1

end event

event open;call super::open;tab_1.tabpage_1.dw_tab1.SetTransObject(sqlca)
tab_1.tabpage_2.dw_tab2.SetTransObject(sqlca)
tab_1.tabpage_3.dw_tab3.SetTransObject(sqlca)
tab_1.tabpage_4.dw_tab4.SetTransObject(sqlca)
tab_1.tabpage_4.dw_tab4_1.SetTransObject(sqlca)
tab_1.tabpage_5.dw_tab5.SetTransObject(sqlca)

tab_1.tabpage_2.enabled = FALSE
tab_1.tabpage_3.enabled = FALSE
tab_1.tabpage_4.enabled = FALSE
tab_1.tabpage_5.enabled = FALSE

tab_1.tabpage_1.dw_tab1.insertrow(0)
tab_1.tabpage_2.dw_tab2.insertrow(0)
end event

type ln_templeft from w_common_tab`ln_templeft within w_hjk101a
end type

type ln_tempright from w_common_tab`ln_tempright within w_hjk101a
end type

type ln_temptop from w_common_tab`ln_temptop within w_hjk101a
end type

type ln_tempbuttom from w_common_tab`ln_tempbuttom within w_hjk101a
end type

type ln_tempbutton from w_common_tab`ln_tempbutton within w_hjk101a
end type

type ln_tempstart from w_common_tab`ln_tempstart within w_hjk101a
end type

type uc_retrieve from w_common_tab`uc_retrieve within w_hjk101a
end type

type uc_insert from w_common_tab`uc_insert within w_hjk101a
end type

type uc_delete from w_common_tab`uc_delete within w_hjk101a
end type

type uc_save from w_common_tab`uc_save within w_hjk101a
end type

type uc_excel from w_common_tab`uc_excel within w_hjk101a
end type

type uc_print from w_common_tab`uc_print within w_hjk101a
end type

type st_line1 from w_common_tab`st_line1 within w_hjk101a
end type

type st_line2 from w_common_tab`st_line2 within w_hjk101a
end type

type st_line3 from w_common_tab`st_line3 within w_hjk101a
end type

type uc_excelroad from w_common_tab`uc_excelroad within w_hjk101a
end type

type ln_dwcon from w_common_tab`ln_dwcon within w_hjk101a
end type

type tab_1 from w_common_tab`tab_1 within w_hjk101a
boolean boldselectedtext = true
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
this.Control[iCurrent+4]=this.tabpage_5
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event tab_1::selectionchanged;call super::selectionchanged;long	ll_newrow

ii_index	= newindex

string 	ls_hakbun,ls_hname,ls_hakgwa,ls_hakyun, ls_hakbun1, ls_hakgi, ls_gubun
int	 	     li_ans
long		ans	,ll_row

dw_con.AcceptText()
ls_gubun   = dw_con.Object.sangtae[1]
ls_hakbun  = dw_con.Object.hakbun[1]
ls_hname  = dw_con.Object.hname[1]

if ls_gubun = '1' Then         //*******************************************************재학생관리

	CHOOSE CASE ii_index	
			
		CASE 1 /*기본자료*/ 
			
//			wf_setmenu('RETRIEVE', 	TRUE)
//			wf_setmenu('INSERT', 	TRUE)
//			wf_setmenu('DELETE', 	FALSE)
//			wf_setmenu('SAVE', 		TRUE)
//			wf_setmenu('PRINT', 		FALSE)

		CASE 2 /*학적신상자료*/
			
			if ls_hakbun <> ""  Or Isnull(ls_hakbun) = False then    // 기본자료부터 조회하지 않고 학번만 입력한 후 
				is_hakbun = ls_hakbun   // 기타사항들을 조회하고자 할때 학번을 받아들이는 줄
			else
				tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
				is_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[tab_1.tabpage_1.dw_tab1.getrow()]
			end if
			
			/***********************************학번을 가지고 신상테이블에 그 학번이 있는지 조회***************/		
			  SELECT	JAEHAK_SINSANG.HAKBUN
			  INTO	:ls_hakbun
			  FROM 	HAKSA.JAEHAK_SINSANG                                                                        
			  WHERE JAEHAK_SINSANG.HAKBUN = :is_hakbun 
			  USING SQLCA	  ;                                                  
			/**************************************************************************************************/
						
			/***************************만일 학번이 신상테이블에  존재하지 않는다면 학번을 인서트하고서********/
			if SQLCA.SQLCODE  = 100 then																																																						  
				ans = tab_1.tabpage_2.dw_tab2.insertrow(0)																		  
				tab_1.tabpage_2.dw_tab2.SetItem( ans, 'hakbun', is_hakbun )													 
				tab_1.tabpage_2.dw_tab2.settransobject(sqlca)																	  
				tab_1.tabpage_2.dw_tab2.update()																						  
				commit;  
			else																											  
				tab_1.tabpage_2.dw_tab2.dataobject = 'd_hjk101a_3'
				tab_1.tabpage_2.dw_tab2.Event constructor()
				tab_1.tabpage_2.dw_tab2.settransobject(sqlca)
				tab_1.tabpage_2.dw_tab2.retrieve(is_hakbun)

			end if	
			
			
		CASE 3 /*학적변동이력*/
			
//			wf_setmenu('RETRIEVE', 	TRUE)
//			wf_setmenu('INSERT', 	FALSE)
//			wf_setmenu('DELETE', 	FALSE)
//			wf_setmenu('SAVE', 		FALSE)
//			wf_setmenu('PRINT', 		FALSE)

			if ls_hakbun <> ""  Or Isnull(ls_hakbun) = False then    // 기본자료부터 조회하지 않고 학번만 입력한 후 
				ls_hakbun = ls_hakbun      // 기타사항들을 조회하고자 할때 학번을 받아들이는 줄
			else
				tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
				ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[tab_1.tabpage_1.dw_tab1.getrow()]
			end if

			tab_1.tabpage_3.dw_tab3.dataobject = 'd_hjk101q_1'
			tab_1.tabpage_3.dw_tab3.Event constructor()
			tab_1.tabpage_3.dw_tab3.settransobject(sqlca)
			tab_1.tabpage_3.dw_tab3.retrieve(ls_hakbun)
			
//			tab_1.tabpage_3.dw_tab3.of_setstyle()
			
		CASE 4 /*수강성적이력*/
			
//			wf_setmenu('RETRIEVE', 	TRUE)
//			wf_setmenu('INSERT', 	FALSE)
//			wf_setmenu('DELETE', 	FALSE)
//			wf_setmenu('SAVE', 		FALSE)
//			wf_setmenu('PRINT', 		FALSE)

			if ls_hakbun <> ""  Or Isnull(ls_hakbun) = False then    // 기본자료부터 조회하지 않고 학번만 입력한 후 
				ls_hakbun = ls_hakbun      // 기타사항들을 조회하고자 할때 학번을 받아들이는 줄
			else
				tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
				ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[tab_1.tabpage_1.dw_tab1.getrow()]
			end if
			
			tab_1.tabpage_4.dw_tab4.dataobject = 'd_hjk101q_3'
			tab_1.tabpage_4.dw_tab4_1.dataobject = 'd_hjk101q_7'

			tab_1.tabpage_4.dw_tab4.Event constructor()
			tab_1.tabpage_4.dw_tab4_1.Event constructor()
			
			tab_1.tabpage_4.dw_tab4.settransobject(sqlca)
			tab_1.tabpage_4.dw_tab4_1.settransobject(sqlca)
			
			tab_1.tabpage_4.dw_tab4.retrieve(ls_hakbun)
			

		CASE 5 /*장학/등록이력*/
			
//			wf_setmenu('RETRIEVE', 	TRUE)
//			wf_setmenu('INSERT', 	FALSE)
//			wf_setmenu('DELETE', 	FALSE)
//			wf_setmenu('SAVE', 		FALSE)
//			wf_setmenu('PRINT', 		FALSE)

			if ls_hakbun <> ""   Or Isnull(ls_hakbun) = False then    // 기본자료부터 조회하지 않고 학번만 입력한 후 
				ls_hakbun = ls_hakbun      // 기타사항들을 조회하고자 할때 학번을 받아들이는 줄
			else
				tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
				ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[tab_1.tabpage_1.dw_tab1.getrow()]
			end if

			tab_1.tabpage_5.dw_tab5.dataobject = 'd_hjk101q_5'
			tab_1.tabpage_5.dw_tab5.Event constructor()
			tab_1.tabpage_5.dw_tab5.settransobject(sqlca)
			tab_1.tabpage_5.dw_tab5.retrieve(ls_hakbun)

END CHOOSE	
	
//////////////////////////////////////////    졸업생관리   ////////////////////////////////////////////////	
	
Else     
 
	CHOOSE CASE ii_index	
		CASE 1 /*기본자료*/
//			wf_setmenu('RETRIEVE', 	TRUE)
//			wf_setmenu('INSERT', 	TRUE)
//			wf_setmenu('DELETE', 	FALSE)
//			wf_setmenu('SAVE', 		TRUE)
//			wf_setmenu('PRINT', 		FALSE)
	
		CASE 2 /*신상*/
			
//			wf_setmenu('RETRIEVE', 	TRUE)
//			wf_setmenu('INSERT', 	FALSE)
//			wf_setmenu('DELETE', 	FALSE)
//			wf_setmenu('SAVE', 		FALSE)
//			wf_setmenu('PRINT', 		FALSE)
			
			if ls_hakbun <> ""  Or Isnull(ls_hakbun) = False then    // 기본자료부터 조회하지 않고 학번만 입력한 후 
				ls_hakbun = ls_hakbun   // 기타사항들을 조회하고자 할때 학번을 받아들이는 줄
			else
				ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[tab_1.tabpage_1.dw_tab1.getrow()]
			end if

			tab_1.tabpage_2.dw_tab2.dataobject = 'd_hjk101a_4'
			tab_1.tabpage_2.dw_tab2.Event constructor()
			tab_1.tabpage_2.dw_tab2.settransobject(sqlca)
			tab_1.tabpage_2.dw_tab2.retrieve( ls_hakbun )

		CASE 3 /*학적변동이력*/
			
//			wf_setmenu('RETRIEVE', 	TRUE)
//			wf_setmenu('INSERT', 	FALSE)
//			wf_setmenu('DELETE', 	FALSE)
//			wf_setmenu('SAVE', 		FALSE)
//			wf_setmenu('PRINT', 		FALSE)

			if ls_hakbun <> ""   Or Isnull(ls_hakbun) = False then    // 기본자료부터 조회하지 않고 학번만 입력한 후 
				ls_hakbun = ls_hakbun      // 기타사항들을 조회하고자 할때 학번을 받아들이는 줄
			else
				tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
				ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[tab_1.tabpage_1.dw_tab1.getrow()]
			end if

			tab_1.tabpage_3.dw_tab3.dataobject = 'd_hjk101q_2'
			tab_1.tabpage_3.dw_tab3.Event constructor()
			tab_1.tabpage_3.dw_tab3.settransobject(sqlca)
			tab_1.tabpage_3.dw_tab3.retrieve(ls_hakbun)
			
		CASE 4 /*수강성적이력*/
			
//			wf_setmenu('RETRIEVE', 	TRUE)
//			wf_setmenu('INSERT', 	FALSE)
//			wf_setmenu('DELETE', 	FALSE)
//			wf_setmenu('SAVE', 		FALSE)
//			wf_setmenu('PRINT', 		FALSE)

			if ls_hakbun <> ""  Or Isnull(ls_hakbun) = False then    // 기본자료부터 조회하지 않고 학번만 입력한 후 
				ls_hakbun = ls_hakbun      // 기타사항들을 조회하고자 할때 학번을 받아들이는 줄
			else
				tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
				ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[tab_1.tabpage_1.dw_tab1.getrow()]
			end if
			
			tab_1.tabpage_4.dw_tab4.dataobject = 'd_hjk101q_4'
			tab_1.tabpage_4.dw_tab4_1.dataobject = 'd_hjk101q_8'
			
			tab_1.tabpage_4.dw_tab4.Event constructor()
			tab_1.tabpage_4.dw_tab4_1.Event constructor()
			
			tab_1.tabpage_4.dw_tab4.settransobject(sqlca)
			tab_1.tabpage_4.dw_tab4_1.settransobject(sqlca)
			
			tab_1.tabpage_4.dw_tab4.retrieve(ls_hakbun)
	
		CASE 5 /*장학/등록이력*/
			
//			wf_setmenu('RETRIEVE', 	TRUE)
//			wf_setmenu('INSERT', 	FALSE)
//			wf_setmenu('DELETE', 	FALSE)
//			wf_setmenu('SAVE', 		FALSE)
//			wf_setmenu('PRINT', 		FALSE)

			if ls_hakbun <> ""  Or Isnull(ls_hakbun) = False then    // 기본자료부터 조회하지 않고 학번만 입력한 후 
				ls_hakbun = ls_hakbun      // 기타사항들을 조회하고자 할때 학번을 받아들이는 줄
			else
				tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
				ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[tab_1.tabpage_1.dw_tab1.getrow()]
			end if
			
			tab_1.tabpage_5.dw_tab5.dataobject = 'd_hjk101q_6'
			tab_1.tabpage_5.dw_tab5.Event constructor()
			tab_1.tabpage_5.dw_tab5.settransobject(sqlca)
			tab_1.tabpage_5.dw_tab5.retrieve(ls_hakbun)		

	   END CHOOSE

end if
end event

event tab_1::selectionchanging;call super::selectionchanging;/****************************변경후 저장 버튼 누르지 않고 텝페이지 이동하려 할때************************/
	
integer  kth , li_ans
long     ll_row
string   ls_hakbun, ls_hakbun1,  ls_hakbun2, ls_hname, ls_gubun

dw_con.AcceptText()
ls_gubun   = dw_con.Object.sangtae[1]
ls_hakbun  = dw_con.Object.hakbun[1]
ls_hname  = dw_con.Object.hname[1]

if ls_gubun = '1'  Then
	
	CHOOSE CASE ii_index
		CASE 1
				tab_1.tabpage_1.dw_tab1.accepttext()
				li_ans = tab_1.tabpage_1.dw_tab1.update()
			
		CASE 2  
			
			if ls_hakbun <> ""  Or Isnull(ls_hakbun) = False then    //학번을 입력후 시작한 경우 학번
				ls_hakbun = ls_hakbun
			else                        //학번을 입력하지 않고 시작한경우 학번
				ls_hakbun = tab_1.tabpage_2.dw_tab2.object.hakbun[tab_1.tabpage_2.dw_tab2.getrow()]
			end if
			/***********************************학번을 가지고 신상테이블에 그 학번이 있는지 조회***************/		
			  SELECT	jaehak_sinsang.hakbun                                                                
			  INTO 	:ls_hakbun1                                                                                 
			  FROM 	HAKSA.jaehak_sinsang                                                                         
			  where 	jaehak_sinsang.hakbun = :ls_hakbun
			  using sqlca ;                                                 
			/**************************************************************************************************/
			
			
			/****************************만일 학번이 신상테이블에 이미 존재하고 있다면 그냥 업데이트***********/
			if ls_hakbun = ls_hakbun1 then          																			  //
				tab_1.tabpage_2.dw_tab2.accepttext()																				  //
				li_ans = tab_1.tabpage_2.dw_tab2.update()																			  //
			/**************************************************************************************************/
		
			end if
	END CHOOSE

end if


end event

type tabpage_1 from w_common_tab`tabpage_1 within tab_1
string text = "학적기본"
dw_tab1 dw_tab1
p_photo p_photo
end type

on tabpage_1.create
this.dw_tab1=create dw_tab1
this.p_photo=create p_photo
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tab1
this.Control[iCurrent+2]=this.p_photo
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_tab1)
destroy(this.p_photo)
end on

type uo_1 from w_common_tab`uo_1 within w_hjk101a
integer x = 745
integer y = 300
end type

type dw_con from w_common_tab`dw_con within w_hjk101a
integer y = 168
string dataobject = "d_hjk101a_c1"
end type

event dw_con::itemchanged;call super::itemchanged;String ls_hakbun, ls_hname
int    li_ans
vector    lvc_data

lvc_data   = create vector

Choose Case dwo.name
	Case 'sangtae'
		
		This.AcceptText()
		This.Object.hakbun[1] = ''
		This.Object.hname[1] = ''
		
		This.setfocus()
		
		ls_hakbun = This.Object.hakbun[1] +'%'
		ls_hname  = This.Object.hname[1] +'%'
		
		tab_1.tabpage_1.p_photo.visible = false
		
		If data = '1' Then
			
			// 재학생 Datawindow처리
			tab_1.tabpage_1.dw_tab1.reset()
			tab_1.tabpage_1.dw_tab1.dataobject = 'd_hjk101a_1'
			tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
			
			li_ans = tab_1.tabpage_1.dw_tab1.insertrow(0)
		
			tab_1.tabpage_1.dw_tab1.setfocus()
			tab_1.tabpage_1.dw_tab1.setcolumn('hakbun')
			
			This.SetFocus()
			This.SetColumn("hakbun")
		Else
			tab_1.tabpage_1.dw_tab1.Object.DataWindow.ReadOnly="Yes"
			// 졸업생 Datawindow처리
			tab_1.tabpage_1.dw_tab1.reset()
			tab_1.tabpage_1.dw_tab1.dataobject = 'd_hjk101a_2'
			tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
			
			tab_1.tabpage_2.enabled = false
			tab_1.tabpage_3.enabled = false
			tab_1.tabpage_4.enabled = false
			tab_1.tabpage_5.enabled = false
			
			li_ans = tab_1.tabpage_1.dw_tab1.insertrow(0)
		
			tab_1.tabpage_1.dw_tab1.setfocus()
			tab_1.tabpage_1.dw_tab1.setcolumn('hakbun')
		End If
		
		func.of_design_dw(tab_1.tabpage_1.dw_tab1)
		
	Case 'hakbun', 'hname'
		If dwo.name = 'hakbun'  Then ls_hakbun = data ;
		If dwo.name = 'hname'  Then ls_hname  = data ;
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'   , '')
			This.Post SetItem(row, 'hname'  ,  '')
			RETURN
		End If
		
		Choose Case  f_hakjuk_search(ls_hakbun, ls_hname, lvc_data)
			Case	1
				This.Object.hakbun[row]	 = lvc_data.GetProperty('hakbun'	)
				This.Object.hname[row]  = lvc_data.GetProperty('hname'	)
					
				Return 2
			Case Else
				This.Trigger Event clicked(-1, 0, row, This.object.p_emp)
		End Choose
		
End Choose

Destroy lvc_data



end event

event dw_con::clicked;call super::clicked;
Vector lvc_data

This.AcceptText()
lvc_data = Create Vector

Choose Case dwo.name
		
	Case 'p_emp'
		 lvc_data.setproperty('parm_cnt' , '1')		
		 lvc_data.setProperty('hakbun'  , This.object.hakbun[row] )
	 	 lvc_data.setProperty('hname'   , This.object.hname[row])
			
		If	openwithparm(w_hakjuk_pop, lvc_data) = 1 Then
			lvc_data = message.powerobjectparm
			If isvalid(lvc_data) Then
				If Long(lvc_data.GetProperty("parm_cnt")) = 0 Then RETURN ;		
				This.Object.hakbun[row]	 = lvc_data.GetProperty("hakbun1")
				This.Object.hname[row]	 = lvc_data.GetProperty("hname1")		
			End If
		End If
End Choose

Destroy lvc_data
end event

type dw_tab1 from uo_dwfree within tabpage_1
integer width = 4347
integer height = 1784
integer taborder = 40
string dataobject = "d_hjk101a_1"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
func.of_design_dw(dw_tab1)

end event

event buttonclicked;call super::buttonclicked;string	ls_param		,&
			ls_zip_id	,&
			ls_addr
blob		b_total_pic	,&
			b_pic
int		li_ans		,&
			li_rtn		,&
			li_filenum	,&
			li_len
string 	ls_path		,&
			ls_filename	,&
			ls_extension,&
			ls_filter
long 		ll_filelen	,&
			ll_loop		,&
			ll_count

choose case dwo.name
	case	'b_insert'
		
		if is_hakbun <> '' then
			SetPointer(HourGlass!)
			
			SELECTBLOB	P_IMAGE
			INTO			:b_total_pic
			FROM			HAKSA.PHOTO
			WHERE 		HAKBUN	= :is_hakbun
			USING SQLCA
			;
			
			if sqlca.sqlcode = 0 then
				p_photo.visible = true
				p_photo.setpicture(b_total_pic)
				
			elseif sqlca.sqlcode = 100 then
				li_ans = messagebox("확인","조회한 학생의 사진이 존재하지 않습니다."	&
													+ "~n사진을 입력하시겠습니까?", question!, yesno!, 1)
				
				if li_ans = 1 then
					
					ls_extension	= "BMP"
					ls_filter		= "Jpg Files (*.jpg),*.jpg"
					
					li_rtn = GetFileOpenName("Open BMP, JPEG", ls_path	, ls_filename, ls_extension, ls_filter)
					
					if li_rtn = 1 then
						li_filenum = FileOpen(ls_filename, StreamMode!)
												
						if li_filenum <> -1 then
							ll_filelen = filelength(ls_filename)
							
							/*****************************************
							//	파일을 클 경우 한번에 전부 읽을 수 없다.
							// 32765Byte 읽을 수 있다. 
							****************************************/
							if ll_filelen > 32765 then
								if mod(ll_filelen, 32765) = 0 then
									ll_loop = ll_filelen/32765
								else
									ll_loop = ll_filelen/32765 + 1
								end if
							else
								ll_loop = 1
							end if
							
							for ll_count = 1 to ll_loop
								FileRead(li_filenum, b_pic)
								b_total_pic = b_total_pic + b_pic
							next
							
							FileClose(li_filenum)
							
							li_ans = p_photo.setpicture(b_total_pic)
								
							if li_ans = 1 then
								li_ans = messagebox("확인", "자료를 저장하시겠씁니까?", question!, yesno!, 1)
								SetPointer(HourGlass!)
								
								if li_ans = 1 then
									/**************** 사진 저장  ********************/
									/*사진을 바로 Insert 할 수 없고 학번을 저장한 후*/
									/*사진을 Update 한다.                         	*/
									/************************************************/
									INSERT INTO	HAKSA.PHOTO
													(	HAKBUN		,
												 		P_IMAGE		)
									VALUES		(	:is_hakbun	,
														null			)
									USING SQLCA
									;
										
									if sqlca.sqlcode = 0 then
										
										UPDATEBLOB	HAKSA.PHOTO
										SET			P_IMAGE = :b_total_pic
										WHERE			HAKBUN = :is_hakbun
										USING SQLCA
										;
							
										if sqlca.sqlcode = 0 then
											commit USING SQLCA;
//											uf_messagebox(2)
										else
											rollback USING SQLCA;
//											uf_messagebox(3)
										end if
							
									end if
								end if
							end if
						end if
					end if
				end if
			end if
		end if
		
	case	'b_delete'
		
		if is_hakbun <> '' then			
		
			li_ans = messagebox("확인", "사진을 삭제하시겠습니까?", question!, yesno!, 2)
						
			if li_ans = 1 then
						
	//			ls_hakbun = dw_main.object.hakbun[row]
			
				DELETE FROM	HAKSA.PHOTO
				WHERE			HAKBUN = :is_hakbun
				USING SQLCA
				;
							
				if sqlca.sqlcode = -1 then
//					uf_messagebox(6)          //삭제오류 메세지 출력
					ROLLBACK USING SQLCA;     
				else
					COMMIT USING SQLCA;		  
//					uf_messagebox(5)
					
					p_photo.visible = true
					p_photo.picturename = '.\image\img2.jpg'
					
				end if
				
			else
				return
			end if
		end if
		
	case	'b_search1'
		Open(w_zipcode)
		
		ls_param	= Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		dw_tab1.setitem(row, "zip_id"	, ls_zip_id)
		dw_tab1.setitem(row, "addr"	, ls_addr)
		
		dw_tab1.setcolumn("addr")
		//Keyboard입력을 동적으로 사용(글로벌함수)
		//SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"
//		Keybd_event( 35, 1, 0, 0 ) //End Key를 친것과 같음..커서를 주소 맨 마지막에 보낼려고
		
	case	'b_search2'
		Open(w_zipcode)
		
		ls_param	= Message.StringParm
		
		li_len		= len(ls_param)
		ls_zip_id	= mid(ls_param, 1, 6)
		ls_addr		= mid(ls_param, 7, li_len)
		
		dw_tab1.setitem(row, "bo_zip_id"	, ls_zip_id)
		dw_tab1.setitem(row, "bo_addr"	, ls_addr)
		
		dw_tab1.setcolumn("bo_addr")
		//Keyboard입력을 동적으로 사용(글로벌함수)
		//SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"
//		Keybd_event( 35, 1, 0, 0 ) //End Key를 친것과 같음..커서를 주소 맨 마지막에 보낼려고
end choose
								
end event

event itemchanged;call super::itemchanged;string 	ls_sex, 	&
			ls_hjmod,&
			ls_addr
string   ls_gwa,  ls_hakbun,  ls_hakyun,  ls_year
Int      l_cnt

CHOOSE CASE dwo.name
		
	CASE 'jumin_no'
		
		tab_1.tabpage_1.dw_tab1.Accepttext()
		ls_sex = mid(tab_1.tabpage_1.dw_tab1.object.jumin_no[row],7,1)
		if ls_sex = '1' then
			tab_1.tabpage_1.dw_tab1.object.sex[row] = ls_sex
		elseif ls_sex = '2' then
			tab_1.tabpage_1.dw_tab1.object.sex[row] = ls_sex
		else
			return 0
		end if
	CASE	'bo_zip_id'
		
		SELECT	ZIP_NAME1 || ' ' || ZIP_NAME2 || ' ' || ZIP_NAME3 || ' '
		INTO		:ls_addr
		FROM		HAKSA.ZIPCODES
		WHERE		ZIP_ID	= :data
		AND		SERIAL	= (	SELECT	MIN(SERIAL)
										FROM		HAKSA.ZIPCODES
										WHERE		ZIP_ID = :data	)
	    USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			messagebox('입력오류!', '해당 우편번호는 존재하지 않습니다!')
			return 1
			
		elseif sqlca.sqlcode = 0 then
			
			this.setitem(row, "bo_addr"	, ls_addr)			
			this.setcolumn("bo_addr")
			
			//Keyboard입력을 동적으로 사용(글로벌함수)
			//SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"
//			Keybd_event( 35, 1, 0, 0 ) //End Key를 친것과 같음..커서를 주소 맨 마지막에 보낼려고		
			
		end if	
		
	CASE	'zip_id'
		
		SELECT	ZIP_NAME1 || ' ' || ZIP_NAME2 || ' ' || ZIP_NAME3 || ' '
		INTO		:ls_addr
		FROM		HAKSA.ZIPCODES
		WHERE		ZIP_ID	= :data
		AND		SERIAL	= (	SELECT	MIN(SERIAL)
										FROM		HAKSA.ZIPCODES
										WHERE		ZIP_ID = :data	)
		USING SQLCA ;
		
		if sqlca.sqlcode = 100 then
			messagebox('입력오류!', '해당 우편번호는 존재하지 않습니다!')
			return 1
			
		elseif sqlca.sqlcode = 0 then
			
			this.setitem(row, "addr"	, ls_addr)			
			this.setcolumn("addr")
			
			//Keyboard입력을 동적으로 사용(글로벌함수)
			//SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"
//			Keybd_event( 35, 1, 0, 0 ) //End Key를 친것과 같음..커서를 주소 맨 마지막에 보낼려고		
			
		end if				
		
	CASE	'su_hakyun'		
		ls_hakbun = tab_1.tabpage_1.dw_tab1.object.hakbun[row]
		SELECT nvl(count(*), 0)
		  INTO :l_cnt
		  FROM haksa.bokhakja_list
		 where hakbun  = :ls_hakbun
		 USING SQLCA ;
		 
		IF l_cnt       > 0 THEN
			SELECT trim(max(year))
			  INTO :ls_year
			  FROM haksa.bokhakja_list
		    where hakbun  = :ls_hakbun
			USING SQLCA ;
			 
         ls_gwa   = uf_hakgwa_chk(ls_year, ls_hakbun, data)
		   tab_1.tabpage_1.dw_tab1.object.gwa[1] = ls_gwa
		END IF
END CHOOSE
end event

type p_photo from picture within tabpage_1
integer x = 27
integer y = 28
integer width = 530
integer height = 624
boolean bringtotop = true
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1792
long backcolor = 16777215
string text = "학적신상"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab2 dw_tab2
end type

on tabpage_2.create
this.dw_tab2=create dw_tab2
this.Control[]={this.dw_tab2}
end on

on tabpage_2.destroy
destroy(this.dw_tab2)
end on

type dw_tab2 from uo_dwfree within tabpage_2
integer width = 4343
integer height = 1788
integer taborder = 30
string dataobject = "d_hjk101a_3"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
func.of_design_dw(dw_tab2)

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1792
long backcolor = 16777215
string text = "학적변동내역"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab3 dw_tab3
end type

on tabpage_3.create
this.dw_tab3=create dw_tab3
this.Control[]={this.dw_tab3}
end on

on tabpage_3.destroy
destroy(this.dw_tab3)
end on

type dw_tab3 from uo_grid within tabpage_3
integer width = 4338
integer height = 1788
integer taborder = 30
string dataobject = "d_hjk101q_1"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean sortvisible = false
boolean rowselect = false
boolean ib_end_add = true
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1792
long backcolor = 16777215
string text = "성적내역"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_2 st_2
st_1 st_1
dw_tab4_1 dw_tab4_1
dw_tab4 dw_tab4
end type

on tabpage_4.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_tab4_1=create dw_tab4_1
this.dw_tab4=create dw_tab4
this.Control[]={this.st_2,&
this.st_1,&
this.dw_tab4_1,&
this.dw_tab4}
end on

on tabpage_4.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_tab4_1)
destroy(this.dw_tab4)
end on

type st_2 from statictext within tabpage_4
integer x = 69
integer y = 724
integer width = 1074
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 25633721
string text = "< 학    기    별    성    적    내    역 >"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_4
integer x = 69
integer y = 8
integer width = 1074
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 25633721
string text = "< 성   적   내   역 >"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_tab4_1 from uo_grid within tabpage_4
integer y = 792
integer width = 4338
integer height = 1000
integer taborder = 30
string dataobject = "d_hjk101q_8"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean sortvisible = false
boolean rowselect = false
boolean ib_end_add = true
end type

type dw_tab4 from uo_grid within tabpage_4
integer y = 76
integer width = 4338
integer height = 628
integer taborder = 30
string dataobject = "d_hjk101q_3"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean sortvisible = false
boolean rowselect = false
boolean ib_end_add = true
end type

event ue_clicked;call super::ue_clicked;integer 	li_row
string	ls_hakbun, ls_year, ls_hakgi

if row > 0 then
	
	ls_hakbun 	= dw_tab4.object.hakbun[row]
	ls_year 		= dw_tab4.object.year[row]
	ls_hakgi		= dw_tab4.object.hakgi[row]
	
end if

li_row = dw_tab4_1.retrieve( ls_hakbun, ls_year, ls_hakgi)
	
if li_row = 0 then
    f_set_message("조회된 데이타가 없습니다!", '', parentwin)
	
elseif li_row = -1 then
    f_set_message("조회 중 오류가 발생하였습니다!", '', parentwin)
end if

dw_tab4_1.setfocus()	
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1792
long backcolor = 16777215
string text = "장학/등록내역"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_tab5 dw_tab5
end type

on tabpage_5.create
this.dw_tab5=create dw_tab5
this.Control[]={this.dw_tab5}
end on

on tabpage_5.destroy
destroy(this.dw_tab5)
end on

type dw_tab5 from uo_grid within tabpage_5
integer width = 4338
integer height = 1788
integer taborder = 40
string dataobject = "d_hjk101q_5"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean sortvisible = false
boolean rowselect = false
boolean ib_end_add = true
end type

type uo_2 from uo_imgbtn within w_hjk101a
boolean visible = false
integer x = 402
integer y = 40
integer width = 864
integer taborder = 50
boolean bringtotop = true
string btnname = "학기(점)제구분 일괄생성"
end type

on uo_2.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;Int         li_gubun
String    ls_hakbun, ls_hakgi_chk

li_gubun = Messagebox('확인', '학기(점)제 구분을 일괄 생성하시겠습니까?', Question!, YesNo!)

If li_gubun = 2 Then Return ;

DECLARE c_pro PROCEDURE FOR
			HAKSA.SP_HAKGI_CHK;
EXECUTE c_pro;
CLOSE   c_pro;

//DECLARE CUR CURSOR FOR
//	SELECT HAKBUN
//	   FROM HAKSA.JAEHAK_HAKJUK
//        USING SQLCA ;
//
//OPEN CUR ;
//			
//DO WHILE TRUE
//	
//	FETCH CUR INTO :ls_hakbun ;
//	
//	IF sqlca.sqlcode <> 0 THEN EXIT ;
//	
//	ls_hakgi_chk = uf_hakgi_chk( '', '', ls_hakbun )
//	
//	UPDATE HAKSA.JAEHAK_HAKJUK
//		  SET HAKGI_CHK = :ls_hakgi_chk
//	WHERE HAKBUN = :ls_hakbun
//	 USING SQLCA ;
//	
//LOOP	
//
//CLOSE CUR ;

COMMIT USING SQLCA ;

Messagebox('확인', '학기(점)제 구분이 적용되었습니다!!')
end event

