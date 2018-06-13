$PBExportHeader$w_hjk108a.srw
$PBExportComments$[청운대]학적기본사항관리_조회
forward
global type w_hjk108a from w_common_tab
end type
type p_photo from picture within tabpage_1
end type
type dw_tab1 from uo_dw within tabpage_1
end type
end forward

global type w_hjk108a from w_common_tab
end type
global w_hjk108a w_hjk108a

type variables
string	is_hakbun
integer	ii_index
DataWindowChild idwc_sayu
end variables

on w_hjk108a.create
int iCurrent
call super::create
end on

on w_hjk108a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;/*
ii_index = 1  : 학적기본자료
ii_index = 2  : 학적신상자료
ii_index = 3  : 학적변동자료
ii_index = 4  : 
ii_index = 5  : 
ii_index = 6  : 
ii_index = 7  : 
*/

string	ls_name		,&
			ls_sangtae	,&
			ls_hakbun	,&
			ls_hname
int		li_count		,&
			li_count1	,&
			li_count2	,&
			li_row	,&
			li_rtn

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

if ls_sangtae = '1' Then
	
	SELECT	count( JAEHAK_HAKJUK.HAKBUN )  
  	INTO		:li_count1
  	FROM		HAKSA.JAEHAK_HAKJUK  
  	WHERE		( JAEHAK_HAKJUK.HAKBUN	LIKE :ls_hakbun||'%'	)	AND
         	( JAEHAK_HAKJUK.HNAME	LIKE :ls_name||'%'	)
	USING SQLCA
	;
Else

	SELECT	count( JOLUP_HAKJUK.HAKBUN )  
   INTO 		:li_count2
   FROM 		HAKSA.JOLUP_HAKJUK  
   WHERE 	( JOLUP_HAKJUK.HAKBUN	LIKE :ls_hakbun||'%'	)	
	AND     	( JOLUP_HAKJUK.HNAME 	LIKE :ls_name||'%'	)
   USING SQLCA
	;
end if

li_count	= li_count1 + li_count2

if li_count = 0 then
	messagebox("확인", "해당 학생은 존재하지 않습니다.!", Exclamation!)
	dw_con.setfocus()
	dw_con.SetColumn("hakbun")
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
	     USING SQLCA
		;
		
		dw_con.Object.sangtae[1] = '1'
		dw_con.Object.hname[1]  = ls_hname
		tab_1.tabpage_1.dw_tab1.dataobject	= 'd_hjk108a_1'
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
		USING SQLCA
		;		
		
		dw_con.Object.sangtae[1] = '2'
		dw_con.Object.hname[1]  = ls_hname
		tab_1.tabpage_1.dw_tab1.dataobject	= 'd_hjk108a_2'
		tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
		li_row	= tab_1.tabpage_1.dw_tab1.retrieve(is_hakbun)
		tab_1.tabpage_1.dw_tab1.setfocus()

	end if	
	
elseif li_count >=2 then
	
	OpenWithParm(w_hjk108pp, ls_name)
	
	is_hakbun	= Message.StringParm
	
	SELECT	count(JAEHAK_HAKJUK.HAKBUN)  
  	INTO		:li_count1
  	FROM		HAKSA.JAEHAK_HAKJUK  
  	WHERE		( JAEHAK_HAKJUK.HAKBUN	= :is_hakbun)
	USING SQLCA
	;           

	SELECT	count( JOLUP_HAKJUK.HAKBUN )  
   INTO 		:li_count2
   FROM 		HAKSA.JOLUP_HAKJUK  
   WHERE 	( JOLUP_HAKJUK.HAKBUN	= :is_hakbun)
   USING SQLCA
	;
	
	if li_count1 = 1 then
		
		SELECT	JAEHAK_HAKJUK.HNAME
		INTO		:ls_hname
		FROM		HAKSA.JAEHAK_HAKJUK  
		WHERE		( JAEHAK_HAKJUK.HAKBUN		like :is_hakbun||'%')
		USING SQLCA
		;
		
		dw_con.Object.sangtae[1] = '1'
		dw_con.Object.hname[1]  = ls_hname
		tab_1.tabpage_1.dw_tab1.dataobject	= 'd_hjk108a_1'
		tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
		li_row	= tab_1.tabpage_1.dw_tab1.retrieve(is_hakbun)
		tab_1.tabpage_1.dw_tab1.setfocus()
		
	elseif li_count2 = 1 then
		
		SELECT	JOLUP_HAKJUK.HNAME
		INTO		:ls_hname
		FROM		HAKSA.JOLUP_HAKJUK  
		WHERE		( JOLUP_HAKJUK.HAKBUN		like :is_hakbun||'%')
		USING SQLCA
		;	
		
		dw_con.Object.sangtae[1] = '2'
		dw_con.Object.hname[1]  = ls_hname
		tab_1.tabpage_1.dw_tab1.dataobject	= 'd_hjk108a_2'
		tab_1.tabpage_1.dw_tab1.settransobject(sqlca)
		li_row	= tab_1.tabpage_1.dw_tab1.retrieve(is_hakbun)
		tab_1.tabpage_1.dw_tab1.setfocus()
		
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

event open;call super::open;tab_1.tabpage_1.dw_tab1.SetTransObject(sqlca)
tab_1.tabpage_1.dw_tab1.insertrow(0)

end event

type ln_templeft from w_common_tab`ln_templeft within w_hjk108a
end type

type ln_tempright from w_common_tab`ln_tempright within w_hjk108a
end type

type ln_temptop from w_common_tab`ln_temptop within w_hjk108a
end type

type ln_tempbuttom from w_common_tab`ln_tempbuttom within w_hjk108a
end type

type ln_tempbutton from w_common_tab`ln_tempbutton within w_hjk108a
end type

type ln_tempstart from w_common_tab`ln_tempstart within w_hjk108a
end type

type uc_retrieve from w_common_tab`uc_retrieve within w_hjk108a
end type

type uc_insert from w_common_tab`uc_insert within w_hjk108a
end type

type uc_delete from w_common_tab`uc_delete within w_hjk108a
end type

type uc_save from w_common_tab`uc_save within w_hjk108a
end type

type uc_excel from w_common_tab`uc_excel within w_hjk108a
end type

type uc_print from w_common_tab`uc_print within w_hjk108a
end type

type st_line1 from w_common_tab`st_line1 within w_hjk108a
end type

type st_line2 from w_common_tab`st_line2 within w_hjk108a
end type

type st_line3 from w_common_tab`st_line3 within w_hjk108a
end type

type uc_excelroad from w_common_tab`uc_excelroad within w_hjk108a
end type

type ln_dwcon from w_common_tab`ln_dwcon within w_hjk108a
end type

type tab_1 from w_common_tab`tab_1 within w_hjk108a
integer height = 1916
boolean boldselectedtext = true
end type

type tabpage_1 from w_common_tab`tabpage_1 within tab_1
integer height = 1796
string text = "학적기본"
p_photo p_photo
dw_tab1 dw_tab1
end type

on tabpage_1.create
this.p_photo=create p_photo
this.dw_tab1=create dw_tab1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_photo
this.Control[iCurrent+2]=this.dw_tab1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.p_photo)
destroy(this.dw_tab1)
end on

type uo_1 from w_common_tab`uo_1 within w_hjk108a
end type

type dw_con from w_common_tab`dw_con within w_hjk108a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
string dataobject = "d_hjk108a_c1"
end type

event dw_con::itemchanged;call super::itemchanged;String ls_hakbun, ls_hname
int    li_ans
vector    lvc_data

lvc_data   = create vector

Choose Case dwo.name
		
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

type p_photo from picture within tabpage_1
integer x = 27
integer y = 28
integer width = 530
integer height = 624
boolean originalsize = true
boolean focusrectangle = false
end type

type dw_tab1 from uo_dw within tabpage_1
integer width = 4347
integer height = 1796
integer taborder = 20
string dataobject = "d_hjk108a_1"
boolean vscrollbar = true
boolean resizable = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_dw(dw_tab1)
end event

