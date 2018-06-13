$PBExportHeader$w_hjk110a.srw
$PBExportComments$[청운대]사진down관리
forward
global type w_hjk110a from w_no_condition_window
end type
type st_2 from statictext within w_hjk110a
end type
type st_5 from statictext within w_hjk110a
end type
type sle_hakbun from uo_sle within w_hjk110a
end type
type cb_3 from commandbutton within w_hjk110a
end type
type rb_1 from radiobutton within w_hjk110a
end type
type rb_2 from radiobutton within w_hjk110a
end type
type st_1 from statictext within w_hjk110a
end type
end forward

global type w_hjk110a from w_no_condition_window
st_2 st_2
st_5 st_5
sle_hakbun sle_hakbun
cb_3 cb_3
rb_1 rb_1
rb_2 rb_2
st_1 st_1
end type
global w_hjk110a w_hjk110a

on w_hjk110a.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_5=create st_5
this.sle_hakbun=create sle_hakbun
this.cb_3=create cb_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.sle_hakbun
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.st_1
end on

on w_hjk110a.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_5)
destroy(this.sle_hakbun)
destroy(this.cb_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_1)
end on

type ln_templeft from w_no_condition_window`ln_templeft within w_hjk110a
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hjk110a
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hjk110a
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hjk110a
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hjk110a
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hjk110a
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hjk110a
end type

type uc_insert from w_no_condition_window`uc_insert within w_hjk110a
end type

type uc_delete from w_no_condition_window`uc_delete within w_hjk110a
end type

type uc_save from w_no_condition_window`uc_save within w_hjk110a
end type

type uc_excel from w_no_condition_window`uc_excel within w_hjk110a
end type

type uc_print from w_no_condition_window`uc_print within w_hjk110a
end type

type st_line1 from w_no_condition_window`st_line1 within w_hjk110a
end type

type st_line2 from w_no_condition_window`st_line2 within w_hjk110a
end type

type st_line3 from w_no_condition_window`st_line3 within w_hjk110a
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hjk110a
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hjk110a
end type

type gb_1 from w_no_condition_window`gb_1 within w_hjk110a
integer x = 64
integer y = 280
integer width = 4366
integer height = 1972
long backcolor = 16777215
end type

type st_2 from statictext within w_hjk110a
integer x = 777
integer y = 532
integer width = 2871
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8388608
string text = "사진 DOWN 관리"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_hjk110a
integer x = 1655
integer y = 1064
integer width = 389
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "학번 및 사번"
boolean focusrectangle = false
end type

type sle_hakbun from uo_sle within w_hjk110a
integer x = 2094
integer y = 1056
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type cb_3 from commandbutton within w_hjk110a
integer x = 1920
integer y = 1296
integer width = 549
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "저장"
end type

event clicked;blob 		lbb_photo, lbb_null_blob, lbb_b
string 	ls_hakbun, ls_docname, ls_named
integer 	li_FileNum, li_loops, li_ii, li_value
long 		ll_flen


ls_hakbun = trim(sle_hakbun.text)


li_value = GetFileSaveName("Select File", ls_docname, ls_named, "JPG", "JPG Files (*.jpg), *.jpg")

if li_value = 1 then
	li_FileNum = FileOpen(ls_docname, StreamMode!, Write!, LockWrite!, Replace!)
else
	return
end if


if rb_1.checked = true then
	SELECTBLOB P_IMAGE INTO :lbb_photo FROM HAKSA.PHOTO WHERE HAKBUN = :ls_hakbun ;
	
else
	SELECTBLOB MEMBER_IMG INTO :lbb_photo FROM INDB.HIN026M WHERE MEMBER_NO = :ls_hakbun;
	
end if


if sqlca.sqlcode = 0 then
	ll_flen = len(lbb_photo)

	IF li_FileNum <> -1 THEN
		IF ll_flen > 32765 THEN
			IF Mod(ll_flen, 32765) = 0 THEN
				li_loops = ll_flen / 32765
				ll_flen = 0
			ELSE
				li_loops = (ll_flen / 32765) + 1
				ll_flen = Mod(ll_flen, 32765)
			END IF
		ELSE
			li_loops = 1
		END IF
		
		if li_loops = 1 then
			Filewrite(li_FileNum, lbb_photo)
		else
			FOR li_ii = 1 to li_loops
				if li_ii = li_loops then
					if ll_flen = 0 then
						lbb_b = blobmid(lbb_photo, ((li_ii - 1) * 32765) + 1, 32765)
					else
						lbb_b = blobmid(lbb_photo, ((li_ii - 1) * 32765) + 1, ll_flen)
					end if
				else
					lbb_b = blobmid(lbb_photo, ((li_ii - 1) * 32765) + 1, 32765)
				end if

				Filewrite(li_FileNum, lbb_b)
			NEXT
		end if
	END IF
	
	FileClose(li_FileNum)
	
end if

messagebox('확인', '저장완료')

end event

type rb_1 from radiobutton within w_hjk110a
integer x = 1838
integer y = 904
integer width = 283
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "학생"
boolean checked = true
end type

type rb_2 from radiobutton within w_hjk110a
integer x = 2181
integer y = 904
integer width = 288
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "교직원"
end type

type st_1 from statictext within w_hjk110a
boolean visible = false
integer x = 457
integer y = 576
integer width = 2871
integer height = 1536
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

