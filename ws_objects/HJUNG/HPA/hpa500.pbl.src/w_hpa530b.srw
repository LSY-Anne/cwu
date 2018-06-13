$PBExportHeader$w_hpa530b.srw
$PBExportComments$강사료 확정작업
forward
global type w_hpa530b from w_msheet
end type
type uo_yyhakgi from cuo_yearschoolterm within w_hpa530b
end type
type uo_month from cuo_mm within w_hpa530b
end type
type hpb_proc from hprogressbar within w_hpa530b
end type
type cb_cancel from commandbutton within w_hpa530b
end type
type cb_ok from commandbutton within w_hpa530b
end type
type st_1 from statictext within w_hpa530b
end type
type st_2 from statictext within w_hpa530b
end type
type dw_list from datawindow within w_hpa530b
end type
type uo_member from cuo_insa_member within w_hpa530b
end type
end forward

global type w_hpa530b from w_msheet
uo_yyhakgi uo_yyhakgi
uo_month uo_month
hpb_proc hpb_proc
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
st_2 st_2
dw_list dw_list
uo_member uo_member
end type
global w_hpa530b w_hpa530b

on w_hpa530b.create
int iCurrent
call super::create
this.uo_yyhakgi=create uo_yyhakgi
this.uo_month=create uo_month
this.hpb_proc=create hpb_proc
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.st_2=create st_2
this.dw_list=create dw_list
this.uo_member=create uo_member
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_yyhakgi
this.Control[iCurrent+2]=this.uo_month
this.Control[iCurrent+3]=this.hpb_proc
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_list
this.Control[iCurrent+9]=this.uo_member
end on

on w_hpa530b.destroy
call super::destroy
destroy(this.uo_yyhakgi)
destroy(this.uo_month)
destroy(this.hpb_proc)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_list)
destroy(this.uo_member)
end on

type ln_templeft from w_msheet`ln_templeft within w_hpa530b
end type

type ln_tempright from w_msheet`ln_tempright within w_hpa530b
end type

type ln_temptop from w_msheet`ln_temptop within w_hpa530b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hpa530b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hpa530b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hpa530b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hpa530b
end type

type uc_insert from w_msheet`uc_insert within w_hpa530b
end type

type uc_delete from w_msheet`uc_delete within w_hpa530b
end type

type uc_save from w_msheet`uc_save within w_hpa530b
end type

type uc_excel from w_msheet`uc_excel within w_hpa530b
end type

type uc_print from w_msheet`uc_print within w_hpa530b
end type

type st_line1 from w_msheet`st_line1 within w_hpa530b
end type

type st_line2 from w_msheet`st_line2 within w_hpa530b
end type

type st_line3 from w_msheet`st_line3 within w_hpa530b
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hpa530b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hpa530b
end type

type uo_yyhakgi from cuo_yearschoolterm within w_hpa530b
event destroy ( )
integer x = 1033
integer y = 744
integer height = 84
integer taborder = 40
boolean bringtotop = true
end type

on uo_yyhakgi.destroy
call cuo_yearschoolterm::destroy
end on

type uo_month from cuo_mm within w_hpa530b
event destroy ( )
integer x = 2071
integer y = 744
integer height = 92
integer taborder = 50
boolean bringtotop = true
end type

on uo_month.destroy
call cuo_mm::destroy
end on

type hpb_proc from hprogressbar within w_hpa530b
integer x = 1138
integer y = 1088
integer width = 1979
integer height = 96
boolean bringtotop = true
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type cb_cancel from commandbutton within w_hpa530b
integer x = 1595
integer y = 1456
integer width = 974
integer height = 224
integer taborder = 30
boolean bringtotop = true
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "취소"
end type

event clicked;// ------------------------------------------------------------------------------------------
// 강사료 취소작업
// ------------------------------------------------------------------------------------------

long		ll_cnt, ll_count, i
string	ls_member_no, ls_yearmonth, ls_hakgi, ls_kname, ls_memberno

ls_yearmonth  = uo_yyhakgi.em_year.Text + String(integer(uo_month.em_mm.Text),"00")
ls_hakgi          = uo_yyhakgi.em_term.Text
ls_kname        = TRIM(uo_member.sle_kname.Text)
ls_memberno  = TRIM(uo_member.sle_member_no.Text)

If ls_memberno = '' Or Isnull(ls_memberno) Then ls_memberno = '%' ;

ll_cnt = dw_list.retrieve(left(ls_yearmonth,4), ls_hakgi, integer(mid(ls_yearmonth,5,2)), ls_memberno)

// 강사료가 있는지 확인한다.
if ll_cnt < 1 or isnull(ll_cnt) then
	f_messagebox('1', '월 강사료가 존재하지 않습니다.~n~n월 강사료를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if
ll_count = dw_list.Rowcount()
// Process Bar Setting
hpb_proc.setrange(1, ll_count + 1)
hpb_proc.setstep 	= 1
hpb_proc.position	= 0

setpointer(hourglass!)

//  Loop
for i	= 1 to ll_count

	ls_member_no = dw_list.GetitemString(i,'member_no')

	insert into padb.hpa021m
				( member_no, year_month, chasu, confirm_gbn)
		values( :ls_member_no, :ls_yearmonth, '1', 0);
	if  sqlca.sqlcode <> 0 then
		update padb.hpa021m 
			 set confirm_gbn = 0
		  where member_no  = :ls_member_no
			 and year_month = :ls_yearmonth
			 and chasu      = '1';
   end if
	hpb_proc.position += 1
next

commit USING SQLCA ;
f_messagebox('1', string(ll_count, '#0') + '건의 자료를 취소 했습니다.!')
hpb_proc.position += 1
SetPointer(Arrow!)

//// 인사의 재직여부를 퇴직을 퇴직예정으로 Update
//update	indb.hin001m
//set		jaejik_opt	=	3
//where		member_no	in	(	select	member_no
//									from		padb.hpa116T
//									 WHERE YEAR		=	substr(:ls_yearmonth,1,4)
//									 AND	 MONTH  	=	to_number(substr(:ls_yearmonth,5,2))
//									 AND	 HAKGI  	=	:ls_hakgi ) 
//AND		JAEJIK_OPT	=	2
//AND		RETIRE_DATE LIKE	:ls_yearmonth||'%';
									
if sqlca.sqlcode <> 0 then
	f_messagebox('3', '인사의 퇴직예정을 수정하지 못했습니다.')
	rollback using sqlca ;
else
	commit using sqlca ;
	f_messagebox('3', '인사의 퇴직을 수정하였습니다.')
end if

end event

type cb_ok from commandbutton within w_hpa530b
integer x = 1595
integer y = 1216
integer width = 974
integer height = 224
integer taborder = 20
boolean bringtotop = true
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "확정"
end type

event clicked;// ------------------------------------------------------------------------------------------
// 강사료 확정작업
// ------------------------------------------------------------------------------------------

long		ll_cnt, ll_count, i
string	ls_member_no, ls_yearmonth, ls_hakgi, ls_kname, ls_memberno

ls_yearmonth  = uo_yyhakgi.em_year.Text + String(integer(uo_month.em_mm.Text),"00")
ls_hakgi          = uo_yyhakgi.em_term.Text
ls_kname        = TRIM(uo_member.sle_kname.Text)
ls_memberno  = TRIM(uo_member.sle_member_no.Text)

If ls_memberno = '' Or Isnull(ls_memberno) Then ls_memberno = '%' ;

ll_cnt = dw_list.retrieve(left(ls_yearmonth,4), ls_hakgi, integer(mid(ls_yearmonth,5,2)), ls_memberno)


// 강사료가 있는지 확인한다.

if ll_cnt < 1 or isnull(ll_cnt) then
	f_messagebox('1', '월 강사료가 존재하지 않습니다.~n~n월 강사료를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if
ll_count = dw_list.Rowcount()
// Process Bar Setting
hpb_proc.setrange(1, ll_count + 1)
hpb_proc.setstep 	= 1
hpb_proc.position	= 0

setpointer(hourglass!)

for i	= 1 to ll_count
	
	ls_member_no = dw_list.GetitemString(i,'member_no')
	
	insert into padb.hpa021m
				( member_no, year_month, chasu, confirm_gbn)
		values( :ls_member_no, :ls_yearmonth, '1', 9);
	if	sqlca.sqlcode <> 0 then
		update padb.hpa021m 
			 set confirm_gbn = 9
		  where member_no  = :ls_member_no
			 and year_month = :ls_yearmonth
			 and chasu      = '1';
   end if
	hpb_proc.position += 1
next

commit USING SQLCA ;
f_messagebox('1', string(ll_cnt, '#0') + '건의 자료를 확정처리했습니다.!')
hpb_proc.position += 1
SetPointer(Arrow!)

//2006.06.22//
//// 인사의 재직여부를 퇴직예정자를 퇴직으로 Update
//update	indb.hin001m
//set		jaejik_opt	=	3
//where		member_no	in	(	select	member_no
//									from		padb.hpa116t
//									 WHERE YEAR		=	substr(:ls_yearmonth,1,4)
//									 AND	 MONTH  	=	to_number(substr(:ls_yearmonth,5,2))
//									 AND	 HAKGI  	=	:ls_hakgi ) 
//AND		JAEJIK_OPT	=	2
//AND		RETIRE_DATE	LIKE	:ls_yearmonth||'%' ;
								
//if sqlca.sqlcode <> 0 then
//	f_messagebox('3', '인사의 재직여부를 수정하지 못했습니다.')
//	rollback;
//else
//	commit;
//	f_messagebox('3', '인사의 재직여부를 수정하였습니다.')
//end if

end event

type st_1 from statictext within w_hpa530b
integer x = 1449
integer y = 476
integer width = 1353
integer height = 156
boolean bringtotop = true
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "강사료 확정작업"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_hpa530b
integer x = 1111
integer y = 904
integer width = 2208
integer height = 144
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 67108864
string text = "강사료 확정작업을 합니다. 확정작업을 하신 다음에는 확정취소가 안되면 갱신작업을 할 수가 없습니다"
boolean focusrectangle = false
end type

type dw_list from datawindow within w_hpa530b
boolean visible = false
integer x = 3269
integer y = 324
integer width = 686
integer height = 400
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hpa530b_1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
end event

type uo_member from cuo_insa_member within w_hpa530b
integer x = 2487
integer y = 748
integer height = 84
integer taborder = 60
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

