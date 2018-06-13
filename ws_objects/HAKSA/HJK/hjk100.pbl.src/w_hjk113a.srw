$PBExportHeader$w_hjk113a.srw
$PBExportComments$[청운대] 실습학기제정보
forward
global type w_hjk113a from w_window
end type
type dw_main from uo_grid within w_hjk113a
end type
type dw_con from uo_dw within w_hjk113a
end type
type p_1 from picture within w_hjk113a
end type
type st_main from statictext within w_hjk113a
end type
end forward

global type w_hjk113a from w_window
dw_main dw_main
dw_con dw_con
p_1 p_1
st_main st_main
end type
global w_hjk113a w_hjk113a

forward prototypes
public function integer wf_validall ()
end prototypes

public function integer wf_validall ();Integer	li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

end function

on w_hjk113a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.p_1=create p_1
this.st_main=create st_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_main
end on

on w_hjk113a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.p_1)
destroy(this.st_main)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)

Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'silsub_gb')  //구분
lvc_data.setProperty('key1', 'HJK07')
func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)

idw_update[1]	= dw_main
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

ll_rv = dw_main.Event ue_InsertRow()

ls_txt = "[신규] "

If ll_rv = 1 Then
	
		f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
		dw_main.Object.silsub_gb[dw_main.GetRow()] = dw_con.Object.silsub_gb[dw_con.GetRow()]
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If
end event

event ue_delete;call super::ue_delete;Long		ll_rv
String		ls_txt

ll_rv = dw_main.Event ue_DeleteRow()

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

type ln_templeft from w_window`ln_templeft within w_hjk113a
end type

type ln_tempright from w_window`ln_tempright within w_hjk113a
end type

type ln_temptop from w_window`ln_temptop within w_hjk113a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hjk113a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hjk113a
end type

type ln_tempstart from w_window`ln_tempstart within w_hjk113a
end type

type uc_retrieve from w_window`uc_retrieve within w_hjk113a
end type

event uc_retrieve::clicked;call super::clicked;string ls_silsub_gb

	ls_silsub_gb = dw_con.object.silsub_gb[dw_con.GetRow()]

IF isnull(ls_silsub_gb) OR ls_silsub_gb = '' THEN
	messagebox("조회", '실습구분을 선택한 후 조회하시기 바랍니다.')
	return -1
END IF
end event

type uc_insert from w_window`uc_insert within w_hjk113a
end type

type uc_delete from w_window`uc_delete within w_hjk113a
end type

type uc_save from w_window`uc_save within w_hjk113a
end type

type uc_excel from w_window`uc_excel within w_hjk113a
end type

type uc_print from w_window`uc_print within w_hjk113a
end type

type st_line1 from w_window`st_line1 within w_hjk113a
end type

type st_line2 from w_window`st_line2 within w_hjk113a
end type

type st_line3 from w_window`st_line3 within w_hjk113a
end type

type uc_excelroad from w_window`uc_excelroad within w_hjk113a
end type

type dw_main from uo_grid within w_hjk113a
event type long ue_retrieve ( )
integer x = 50
integer y = 388
integer width = 4384
integer height = 1876
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk113a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

event type long ue_retrieve();String		ls_silsub_gb, ls_hakbun
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_silsub_gb = dw_con.object.silsub_gb[dw_con.GetRow()]
ls_hakbun = func.of_nvl(dw_con.object.hakbun[dw_con.GetRow()],'%')
ll_rv = THIS.Retrieve(ls_silsub_gb, ls_hakbun)

RETURN ll_rv

end event

event itemchanged;call super::itemchanged;String		ls_hakbun	,ls_kname, ls_silsub_gb, ls_accept_yn, ls_yn
long l_seq, ll_find,l_etc_amt1, l_etc_amt2, l_cnt, l_acc_hakjum, l_hakjum,l_cnt_sum, l_sum


This.accepttext()
Choose Case	dwo.name
	Case	'hakbun','kname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'kname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'kname'	, '')
			This.Post SetItem(row, 'seq' , 0)
			RETURN
		End If
		
		ls_silsub_gb = This.object.silsub_gb[row]
		
		SELECT nvl(max(seq),0) + 1
		INTO :l_seq
		FROM haksa.jaehak_silsub
		WHERE hakbun = :ls_hakbun
		AND      silsub_gb = :ls_silsub_gb
		USING SQLCA;
		
		
		SELECT HAKBUN, HNAME
		INTO :ls_hakbun , :ls_kname
		FROM  (	SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JAEHAK_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JOLUP_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.D_HAKJUK	A	)	A
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_kname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.hakbun[row] = ls_hakbun
			This.object.kname[row] = ls_kname
			
			If isnull(l_seq)   Then l_seq = 1
			
			ll_find = This.find( "silsub_gb = '" + ls_silsub_gb + "' and seq >= " + String(l_seq) + " and hakbun = '" + ls_hakbun + "'",  this.rowcount(), 1)
			If ll_find > 0 Then
				l_seq =  this.object.seq[ll_find] + 1
			End if
				
			This.object.seq[row] = l_seq 
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	

case 'acc_hakjum'
	ls_silsub_gb = this.object.silsub_gb[row]
	if ls_silsub_gb = '1' then
		ls_hakbun = this.object.hakbun[row]
		l_hakjum = this.object.acc_hakjum[row]
		ls_accept_yn = this.object.accept_yn[row]
		select	sum(acc_hakjum)
		into :l_acc_hakjum
		from	haksa.jaehak_silsub
		where	hakbun = :ls_hakbun
		and	silsub_gb = '1'
   		and	accept_yn = 'Y'
		using sqlca;
	
		if ls_accept_yn = 'Y' then
			l_sum = l_acc_hakjum + l_hakjum
		else
			l_sum = l_acc_hakjum
		end if

		select	etc_amt1
		into	:l_etc_amt1
		from cddb.kch102d
		where code_gb = 'HJK08'
		using sqlca;

		if l_sum > l_etc_amt1 then
			this.post setitem(row, 'accept_yn', 'N')
			messagebox("알림", "인정학점이 초과되었습니다.")
		end if
	end if
	
	case 'accept_yn'
	ls_silsub_gb = this.object.silsub_gb[row]
	if ls_silsub_gb = '1' then
		ls_hakbun = this.object.hakbun[row]
		l_hakjum = this.object.acc_hakjum[row]
		ls_accept_yn = data
		select	sum(acc_hakjum),count(*)
		into :l_acc_hakjum, :l_cnt
		from	haksa.jaehak_silsub
		where	hakbun = :ls_hakbun
		and	silsub_gb = '1'
   		and	accept_yn = 'Y'
		using sqlca;
	
		if ls_accept_yn = 'Y' then
			l_sum = l_acc_hakjum + l_hakjum
			l_cnt_sum = l_cnt + 1
		else
			l_sum = l_acc_hakjum
			l_cnt_sum = l_cnt
		end if

		select	etc_amt1, etc_amt2
		into	:l_etc_amt1, :l_etc_amt2
		from cddb.kch102d
		where code_gb = 'HJK08'
		using sqlca;

		if l_sum > l_etc_amt1 then
			this.post setitem(row, 'accept_yn', 'N')
			messagebox("알림", "인정학점이 초과되었습니다.")
		end if
		
		if l_cnt_sum > l_etc_amt2 then
			this.post setitem(row, 'accept_yn', 'N')
			messagebox("알림", "성적인정수가 초과되었습니다.")
		end if
	end if
	
End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_hakbun
This.accepttext()
ls_KName =  trim(this.object.kname[row])



OpenWithParm(w_hsg_hakjuk,ls_kname)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_main.SetFocus()
	dw_main.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[2]	//성명
ls_hakbun            = lstr_com.ls_item[1]	//학번
this.object.kname[row]        = ls_kname					//성명
This.object.hakbun[row]     = ls_hakbun				//개인번호
return 1
End If
end event

type dw_con from uo_dw within w_hjk113a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk113a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_hakbun
This.accepttext()
ls_KName =  trim(this.object.kname[1])



OpenWithParm(w_hsg_hakjuk,ls_kname)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[2]	//성명
ls_hakbun            = lstr_com.ls_item[1]	//학번
this.object.kname[1]        = ls_kname					//성명
This.object.hakbun[1]     = ls_hakbun				//개인번호
Parent.post event ue_inquiry()	
return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_kname, ls_silsub_gb

This.accepttext()
Choose Case	dwo.name
	Case	'hakbun','kname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'kname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'kname'	, '')			
			RETURN
		End If
		
		SELECT HAKBUN, HNAME
		INTO :ls_hakbun , :ls_kname
		FROM  (	SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JAEHAK_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JOLUP_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.D_HAKJUK	A	)	A
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_kname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.hakbun[row] = ls_hakbun
			This.object.kname[row] = ls_kname
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
End Choose


end event

type p_1 from picture within w_hjk113a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hjk113a
integer x = 114
integer y = 312
integer width = 1051
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "어학(실습)정보"
boolean focusrectangle = false
end type

