$PBExportHeader$w_hsg102pp.srw
$PBExportComments$[청운대]학생조회popup
forward
global type w_hsg102pp from window
end type
type dw_4 from uo_dwgrid within w_hsg102pp
end type
type dw_3 from datawindow within w_hsg102pp
end type
type dw_2 from datawindow within w_hsg102pp
end type
type dw_1 from datawindow within w_hsg102pp
end type
end forward

global type w_hsg102pp from window
integer width = 2647
integer height = 2568
boolean titlebar = true
string title = "학생조회"
boolean controlmenu = true
windowtype windowtype = response!
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type
global w_hsg102pp w_hsg102pp

on w_hsg102pp.create
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1}
end on

on w_hsg102pp.destroy
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;String ls_hakbun

f_centerme(this)

ls_hakbun = Message.StringParm

dw_1.Retrieve(ls_hakbun)

dw_2.SetTransobject(sqlca)

dw_2.Retrieve(ls_hakbun)

dw_3.SetTransobject(sqlca)

dw_3.Retrieve(ls_hakbun)



blob lbBmp
int li_cnt, i

int FP, Li_x, Li_count
long LL_size, LL_start, LL_write
blob imagedata, Lblb_part

IF DirectoryExists ('c:\emp_image') THEN
ELSE
   CreateDirectory ('c:\emp_image')
END IF

 SELECTBLOB	P_IMAGE
		 INTO :lbBmp
		 FROM HAKSA.PHOTO
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
	 dw_1.SetItem(1, 'bmp_hakbun', 'C:\emp_image\' + ls_hakbun + '.jpg')
ELSE
	 dw_1.SetItem(1, 'bmp_hakbun', 'C:\emp_image\space.jpg')
END IF
end event

type dw_4 from uo_dwgrid within w_hsg102pp
integer x = 18
integer y = 1936
integer width = 2601
integer height = 540
integer taborder = 30
string dataobject = "d_hsg102pp_5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;This.settransobject(sqlca)
end event

type dw_3 from datawindow within w_hsg102pp
integer x = 14
integer y = 984
integer width = 2039
integer height = 284
integer taborder = 20
string title = "none"
string dataobject = "d_hsg102pp_4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_hsg102pp
integer x = 9
integer y = 1440
integer width = 2601
integer height = 492
integer taborder = 20
boolean titlebar = true
string title = "개인별 성적"
string dataobject = "d_hsg102pp_3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;

This.AcceptText()


If currentrow > 0  Then
	String ls_hakbun, ls_year, ls_hakgi
	
	ls_year = This.object.year[currentrow]
	ls_hakgi = this.object.hakgi[currentrow]
	ls_hakbun = this.object.hakbun[currentrow]
	
	dw_4.retrieve(ls_hakbun ,ls_year, ls_hakgi)
	
	
End If



end event

event retrieveend;This.AcceptText()


If rowcount > 0  Then
	
	This.setrow(1)
	
	String ls_hakbun, ls_year, ls_hakgi
	
	ls_year = This.object.year[1]
	ls_hakgi = this.object.hakgi[1]
	ls_hakbun = this.object.hakbun[1]
	
	dw_4.retrieve(ls_hakbun, ls_year, ls_hakgi )
	
	
End If
end event

type dw_1 from datawindow within w_hsg102pp
integer x = 9
integer y = 8
integer width = 2601
integer height = 1432
integer taborder = 10
string dataobject = "d_hsg102pp_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve(Message.StringParm)
end event

event doubleclicked;//string	ls_hakbun
//int		li_row
//
//if row > 0 then
//	li_row = this.getrow()
//	
//	ls_hakbun = this.getitemstring(li_row, 'hakbun')
//	
//	CloseWithReturn(Parent, ls_hakbun)
//end if
end event

event clicked;String ls_pwd,    ls_pwd1,   ls_hakbun,   ls_hakbun1,  ls_email,  ls_tel,  ls_hp
String ls_chuimi, ls_tukgi
Int    li_ans,    l_cnt

dw_1.AcceptText()

IF dwo.name  = 'b_1' THEN
ELSE
	return
END IF

ls_hakbun    = dw_1.GetItemString(1, 'hakbun')
ls_hakbun1   = dw_1.GetItemString(1, 'hakbun1')
ls_pwd       = dw_1.GetItemString(1, 'password')
ls_pwd1      = dw_1.GetItemString(1, 'password1')
IF ls_hakbun = ls_hakbun1 AND ls_pwd = ls_pwd1 THEN
ELSE
	messagebox("알림", '해당 학번과 비밀번호가 틀리니 확인바랍니다.')
	return
END IF

li_ans    = dw_1.update()
if li_ans = -1 then
	//저장 오류 메세지 출력
	messagebox("알림", '저장시 오류발생')
	rollback;
end if

ls_email   = dw_1.GetItemString(1, 'email')
ls_tel     = dw_1.GetItemString(1, 'tel')
ls_hp      = dw_1.GetItemString(1, 'hp')
ls_chuimi  = dw_1.GetItemString(1, 'fa_skill')
ls_tukgi   = dw_1.GetItemString(1, 'special')

SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM haksa.jaehak_hakjuk
 WHERE hakbun   = :ls_hakbun;
IF l_cnt        > 0 THEN
	UPDATE haksa.jaehak_hakjuk
	   SET tel           = :ls_tel,
			 hp            = :ls_hp,
			 email         = :ls_email
	 WHERE hakbun        = :ls_hakbun;
ELSE
	UPDATE haksa.jolup_hakjuk
	   SET tel           = :ls_tel,
			 hp            = :ls_hp,
			 email         = :ls_email
	 WHERE hakbun        = :ls_hakbun;
END IF
			 
IF sqlca.sqlcode       <> 0 THEN
	messagebox("알림", '학적 정보에 없습니다.')
	rollback;
	return
END IF

l_cnt     = 0

SELECT nvl(count(*), 0)
  INTO :l_cnt
  FROM haksa.jaehak_sinsang
 WHERE hakbun   = :ls_hakbun;
IF l_cnt        > 0 THEN
	UPDATE haksa.jaehak_sinsang
	   SET chuimi        = :ls_chuimi,
			 tukgi         = :ls_tukgi
	 WHERE hakbun        = :ls_hakbun;
ELSE
	UPDATE haksa.jolup_sinsang
	   SET chuimi        = :ls_chuimi,
			 tukgi         = :ls_tukgi
	 WHERE hakbun        = :ls_hakbun;
END IF

commit;

messagebox("알림", '정상적으로 수정되었습니다.')

dw_1.SetItem(1, 'hakbun1', '')
dw_1.SetItem(1, 'password1', '')


end event

