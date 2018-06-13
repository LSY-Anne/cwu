$PBExportHeader$w_sch208p.srw
$PBExportComments$[w_print] 사생카드
forward
global type w_sch208p from w_window
end type
type dw_con from uo_dwfree within w_sch208p
end type
type dw_main from datawindow within w_sch208p
end type
type uo_schphoto_update from uo_imgbtn within w_sch208p
end type
type uo_schphoto_down from uo_imgbtn within w_sch208p
end type
end forward

global type w_sch208p from w_window
dw_con dw_con
dw_main dw_main
uo_schphoto_update uo_schphoto_update
uo_schphoto_down uo_schphoto_down
end type
global w_sch208p w_sch208p

event ue_postopen;call super::ue_postopen;func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)


Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
func.of_dddw( dw_con,lvc_data)

dw_con.object.std_year[dw_con.getrow()] = func.of_get_sdate('yyyy')

dw_main.Modify("DataWindow.Print.Preview=Yes")

ib_retrieve_wait = True

idw_print = dw_main


If len(trim(gvc_val.getproperty('w_sch208p_hakbun'))) <> 0 Then
	dw_con.object.hakbun[dw_con.Getrow()] = gvc_val.getproperty('w_sch208p_hakbun')
	dw_con.object.kname[dw_con.Getrow()] = gvc_val.getproperty('w_sch208p_kname')
	    dw_con.object.house_gb[dw_con.Getrow()] = gvc_val.getproperty('w_sch208p_house_gb')
	    dw_con.object.std_year[dw_con.Getrow()] = gvc_val.getproperty('w_sch208p_std_year')
	    This.post event ue_inquiry()
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

on w_sch208p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
this.uo_schphoto_update=create uo_schphoto_update
this.uo_schphoto_down=create uo_schphoto_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.uo_schphoto_update
this.Control[iCurrent+4]=this.uo_schphoto_down
end on

on w_sch208p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.uo_schphoto_update)
destroy(this.uo_schphoto_down)
end on

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "사생카드")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

event close;call super::close;gvc_val.setproperty('w_sch208p_hakbun', '')
end event

type ln_templeft from w_window`ln_templeft within w_sch208p
end type

type ln_tempright from w_window`ln_tempright within w_sch208p
end type

type ln_temptop from w_window`ln_temptop within w_sch208p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch208p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch208p
end type

type ln_tempstart from w_window`ln_tempstart within w_sch208p
end type

type uc_retrieve from w_window`uc_retrieve within w_sch208p
end type

type uc_insert from w_window`uc_insert within w_sch208p
end type

type uc_delete from w_window`uc_delete within w_sch208p
end type

type uc_save from w_window`uc_save within w_sch208p
end type

type uc_excel from w_window`uc_excel within w_sch208p
end type

type uc_print from w_window`uc_print within w_sch208p
end type

type st_line1 from w_window`st_line1 within w_sch208p
end type

type st_line2 from w_window`st_line2 within w_sch208p
end type

type st_line3 from w_window`st_line3 within w_sch208p
end type

type uc_excelroad from w_window`uc_excelroad within w_sch208p
end type

type dw_con from uo_dwfree within w_sch208p
integer x = 50
integer y = 176
integer width = 4379
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch208p_con"
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

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_kname

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

type dw_main from datawindow within w_sch208p
event type long ue_retrieve ( )
integer x = 50
integer y = 368
integer width = 4379
integer height = 1884
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_sch208p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();Long		ll_rv
string     ls_house_gb, ls_std_year, ls_hakbun

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_house_gb = dw_con.object.house_gb[dw_con.GetRow()]
ls_std_year = dw_con.object.std_year[dw_con.GetRow()]
ls_hakbun = dw_con.object.hakbun[dw_con.Getrow()]

IF isnull(ls_house_gb) OR ls_house_gb = '' THEN
	messagebox("조회", ' 기숙사구분을 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

IF isnull(ls_std_year) OR ls_std_year = '' THEN
	messagebox("조회", '학년도를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

If isnull(ls_hakbun) Or ls_hakbun = '' Then
	Messagebox("조회", "학번을 입력하세요!")
	RETURN -1
End If

ll_rv = THIS.Retrieve(ls_house_gb, ls_std_year, ls_hakbun)

If ll_rv > 0 Then

blob lbBmp
int li_cnt, i

int FP, Li_x, Li_count
long LL_size, LL_start, LL_write
blob imagedata, Lblb_part

IF DirectoryExists ('c:\emp_image') THEN
ELSE
   CreateDirectory ('c:\emp_image')
END IF
// FROM HAKSA.PHOTO

 SELECTBLOB	P_IMAGE
		 INTO :lbBmp		
		 FROM SCH.SAZ150M
		WHERE HAKBUN	= :ls_hakbun;
 IF sqlca.sqlcode = 0 then
	
	 LL_size = Len(lbBmp)
	 IF LL_size > 32765 THEN
		 IF Mod(LL_size, 32765) = 0 THEN
			 Li_count = LL_size / 32765
		 ELSE
			 Li_count = (LL_size / 32765) + 1
		 END IF
	 ELSE
		 Li_count = 1
	 END IF
	
	 FP = FileOpen("c:\emp_image\" + ls_hakbun + ".jpg", StreamMode!, Write!, Shared!, Replace!)
	
	 FOR i = 1 to Li_count
		  LL_write    = FileWrite(fp,lbBmp )
		  IF LL_write = 32765 THEN
			  lbBmp    = BlobMid(lbBmp, 32766)
		  END IF
	 NEXT
	 FileClose(FP)
	 dw_main.SetItem(1, 'photo_path', 'C:\emp_image\' + ls_hakbun + '.jpg')
ELSE
	 dw_main.SetItem(1, 'photo_path', 'C:\emp_image\space.jpg')
END IF
End If

RETURN ll_rv

end event

event constructor;this.SetTransObject(Sqlca)
end event

type uo_schphoto_update from uo_imgbtn within w_sch208p
integer x = 279
integer y = 32
integer taborder = 20
boolean bringtotop = true
string btnname = "사진업데이트"
end type

on uo_schphoto_update.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;uo_hjfunc lvc_sch

lvc_sch = create uo_hjfunc

Long		ll_rv
string     ls_house_gb, ls_std_year, ls_hakbun

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN
End If

ls_house_gb = dw_con.object.house_gb[dw_con.GetRow()]
ls_std_year = dw_con.object.std_year[dw_con.GetRow()]
ls_hakbun = func.of_nvl(dw_con.object.hakbun[dw_con.Getrow()],'%')

ll_rv = lvc_sch.of_schphoto_update(ls_house_gb, ls_std_year, ls_hakbun)

IF ll_rv =1 then 
	 COMMIT USING sqlca ;
	 messagebox('알림','사진업데이트 완료')
end if 


destroy lvc_sch
end event

type uo_schphoto_down from uo_imgbtn within w_sch208p
integer x = 631
integer y = 32
integer taborder = 30
boolean bringtotop = true
string btnname = "사진다운로드"
end type

on uo_schphoto_down.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;uo_hjfunc lvc_sch

lvc_sch = create uo_hjfunc

Long		ll_rv
string     ls_house_gb, ls_std_year, ls_hakbun

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN
End If

ls_house_gb = dw_con.object.house_gb[dw_con.GetRow()]
ls_std_year = dw_con.object.std_year[dw_con.GetRow()]
ls_hakbun = func.of_nvl(dw_con.object.hakbun[dw_con.Getrow()],'%')

ll_rv = lvc_sch.of_schphoto_down(ls_house_gb, ls_std_year, ls_hakbun)

IF ll_rv =1 then 
	 messagebox('알림','사진다운로드 완료')
end if 


destroy lvc_sch
end event

