$PBExportHeader$w_hjk202p.srw
$PBExportComments$[청운대]학적변동자명부출력
forward
global type w_hjk202p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjk202p
end type
type dw_con from uo_dwfree within w_hjk202p
end type
end forward

global type w_hjk202p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hjk202p w_hjk202p

type variables
DatawindowChild idwc_sayu
end variables

on w_hjk202p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjk202p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event open;call super::open;Vector lvc_data

idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')

dw_con.getchild('sayu_id',idwc_sayu)
idwc_sayu.SetTransObject(sqlca)
idwc_sayu.Retrieve('%')

// 제적-자퇴사유
lvc_data = Create Vector
lvc_data.setProperty('column1', 'drop_cd')  //업무구분
lvc_data.setProperty('key1', 'HJK01')

func.of_dddw( dw_con, lvc_data)
end event

event ue_retrieve;string	ls_gwa,		&
			ls_hjmod,	&
			ls_sayu,		&
			ls_from,		&
			ls_to,  ls_drop_cd, ls_hakyun, ls_hakbun
integer	li_ans, li_cnt

dw_con.AcceptText()

//조회조건
ls_hjmod	     = func.of_nvl(dw_con.Object.hjmod_id[1], '%') + '%'
ls_gwa		= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_sayu		= func.of_nvl(dw_con.Object.sayu_id[1], '%') + '%'
ls_from       = dw_con.Object.from_dt[1]
ls_to           = dw_con.Object.to_dt[1]
ls_drop_cd  = func.of_nvl(dw_con.Object.drop_cd[1], '%')
ls_hakyun   = func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_hakbun   = func.of_nvl(dw_con.Object.hakbun[1], '%')

li_ans = dw_main.retrieve( ls_gwa, ls_hjmod, ls_sayu, ls_from, ls_to, ls_drop_cd, ls_hakbun, ls_hakyun )

li_cnt = dw_main.rowcount()

f_set_message(string(li_cnt) + "건의 자료가 조회되었습니다.", '', parentwin)

if li_ans = 0 then
	uf_messagebox(7)

elseif li_ans = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1
end event

event ue_printstart;// 출력물 설정

avc_data.SetProperty('title', "출력물")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
avc_data.SetProperty('zoom', '88')

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk202p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk202p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk202p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk202p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk202p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk202p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk202p
end type

type uc_insert from w_condition_window`uc_insert within w_hjk202p
end type

type uc_delete from w_condition_window`uc_delete within w_hjk202p
end type

type uc_save from w_condition_window`uc_save within w_hjk202p
end type

type uc_excel from w_condition_window`uc_excel within w_hjk202p
end type

type uc_print from w_condition_window`uc_print within w_hjk202p
end type

type st_line1 from w_condition_window`st_line1 within w_hjk202p
end type

type st_line2 from w_condition_window`st_line2 within w_hjk202p
end type

type st_line3 from w_condition_window`st_line3 within w_hjk202p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk202p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk202p
end type

type gb_1 from w_condition_window`gb_1 within w_hjk202p
end type

type gb_2 from w_condition_window`gb_2 within w_hjk202p
end type

type dw_main from uo_search_dwc within w_hjk202p
integer x = 50
integer y = 376
integer width = 4384
integer height = 1888
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjk202p_1"
end type

type dw_con from uo_dwfree within w_hjk202p
integer x = 50
integer y = 164
integer width = 4384
integer height = 200
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk202p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String ls_hakbun, ls_hname
int    li_ans
vector    lvc_data

lvc_data   = create vector

Choose Case dwo.name
	Case	"hjmod_id"
		
		This.SetItem(row, 'sayu_id',"")
		
	Case 'sayu_id'
		If Data <> 'D19' Then
			This.Post SetItem(row, "drop_cd", "")
		End If
			
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

event itemfocuschanged;call super::itemfocuschanged;string	ls_hjmod	,	ls_jaguk

choose case dwo.name
	case	"sayu_id"
				
		ls_hjmod = this.getitemstring(row,'hjmod_id')
		
		if isnull(ls_hjmod) or trim(ls_hjmod) = '' then
			messagebox("확인", "학적변동코드를 선택하세요!")
			this.setcolumn(1)
			this.setfocus()
		end if
		
		this.getchild('sayu_id',idwc_sayu)
		idwc_sayu.settransobject(sqlca)	
		idwc_sayu.retrieve(ls_hjmod)
		
		this.SetItem(row, 'sayu_id',"")
end choose
end event

event clicked;call super::clicked;String ls_from_dt, ls_to_dt
Vector lvc_data

This.AcceptText()
lvc_data = Create Vector

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

