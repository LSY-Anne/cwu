$PBExportHeader$w_commonresponse.srw
forward
global type w_commonresponse from window
end type
type uc_retrieve from u_picture within w_commonresponse
end type
type uc_cancel from u_picture within w_commonresponse
end type
type uc_close from u_picture within w_commonresponse
end type
type uc_ok from u_picture within w_commonresponse
end type
type ln_templeft from line within w_commonresponse
end type
type ln_temptop from line within w_commonresponse
end type
type ln_tempbutton from line within w_commonresponse
end type
type ln_tempstart from line within w_commonresponse
end type
type ln_4 from line within w_commonresponse
end type
type ln_tempright from line within w_commonresponse
end type
end forward

global type w_commonresponse from window
integer width = 3525
integer height = 1692
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event ue_postopen ( )
event ue_ok ( )
event ue_close ( )
event ue_retrieve ( )
event ue_cancel ( )
uc_retrieve uc_retrieve
uc_cancel uc_cancel
uc_close uc_close
uc_ok uc_ok
ln_templeft ln_templeft
ln_temptop ln_temptop
ln_tempbutton ln_tempbutton
ln_tempstart ln_tempstart
ln_4 ln_4
ln_tempright ln_tempright
end type
global w_commonresponse w_commonresponse

forward prototypes
protected subroutine wf_settransobject (powerobject apo)
end prototypes

event ue_postopen();uc_ok.of_enable(true)
uc_retrieve.of_enable(true)
uc_cancel.of_enable(true)
uc_close.of_enable(true)

wf_settransobject(this)
end event

event ue_ok();//
end event

event ue_close();//
end event

event ue_retrieve();//
end event

protected subroutine wf_settransobject (powerobject apo);Long	ll_rowcnt, ll_ctr_cnt, i

Choose Case apo.typeof()
	Case Datawindow!
		Datawindow ldw
		ldw = apo
		
		Vector  lvc_data
		lvc_data = getconvertcommandparm(ldw.tag)
		
		IF Lower( lvc_data.getProperty('settrans') ) = 'true' THEN 
			ldw.settransobject(sqlca)
		END IF
		
		Destroy lvc_data
	Case UserObject!
		UserObject  luo
		luo = apo
		IF Upper(luo.tag) <> 'TEXTSTYLEPICTUREBUTTON' THEN
			ll_ctr_cnt = UpperBound(luo.control)
			FOR i = ll_ctr_cnt TO 1 Step -1
				wf_settransobject(luo.control[i])
			NEXT
		END IF
	Case Tab!
		Tab  lt
		lt = apo
		ll_ctr_cnt = UpperBound(lt.control)
		FOR i = ll_ctr_cnt TO 1 Step -1
			wf_settransobject(lt.control[i])
		NEXT
	Case Window!
		window	lw
		lw = apo
		ll_ctr_cnt = UpperBound(lw.control)
		FOR i = ll_ctr_cnt TO 1 Step -1
			wf_settransobject(lw.control[i])
		NEXT
End Choose
end subroutine

on w_commonresponse.create
this.uc_retrieve=create uc_retrieve
this.uc_cancel=create uc_cancel
this.uc_close=create uc_close
this.uc_ok=create uc_ok
this.ln_templeft=create ln_templeft
this.ln_temptop=create ln_temptop
this.ln_tempbutton=create ln_tempbutton
this.ln_tempstart=create ln_tempstart
this.ln_4=create ln_4
this.ln_tempright=create ln_tempright
this.Control[]={this.uc_retrieve,&
this.uc_cancel,&
this.uc_close,&
this.uc_ok,&
this.ln_templeft,&
this.ln_temptop,&
this.ln_tempbutton,&
this.ln_tempstart,&
this.ln_4,&
this.ln_tempright}
end on

on w_commonresponse.destroy
destroy(this.uc_retrieve)
destroy(this.uc_cancel)
destroy(this.uc_close)
destroy(this.uc_ok)
destroy(this.ln_templeft)
destroy(this.ln_temptop)
destroy(this.ln_tempbutton)
destroy(this.ln_tempstart)
destroy(this.ln_4)
destroy(this.ln_tempright)
end on

event open;Post Event ue_postopen()
end event

type uc_retrieve from u_picture within w_commonresponse
integer x = 2592
integer y = 36
integer width = 206
integer height = 72
boolean originalsize = false
string picturename = "..\img\button\topBtn_retrieve.gif"
string is_event = "ue_retrieve"
end type

type uc_cancel from u_picture within w_commonresponse
integer x = 3040
integer y = 36
integer width = 206
integer height = 72
string picturename = "..\img\button\topBtn_cancel.gif"
string is_event = "ue_cancel"
end type

type uc_close from u_picture within w_commonresponse
integer x = 3264
integer y = 36
integer width = 206
integer height = 72
string picturename = "..\img\button\topBtn_close.gif"
string is_event = "ue_close"
end type

type uc_ok from u_picture within w_commonresponse
integer x = 2816
integer y = 36
integer width = 206
integer height = 72
boolean originalsize = false
string picturename = "..\img\button\topBtn_ok.gif"
string is_event = "ue_ok"
end type

type ln_templeft from line within w_commonresponse
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginx = 46
integer beginy = 24
integer endx = 46
integer endy = 2272
end type

type ln_temptop from line within w_commonresponse
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 36
integer endx = 3863
integer endy = 36
end type

type ln_tempbutton from line within w_commonresponse
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 120
integer endx = 3863
integer endy = 120
end type

type ln_tempstart from line within w_commonresponse
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 160
integer endx = 3863
integer endy = 160
end type

type ln_4 from line within w_commonresponse
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 1548
integer endx = 4471
integer endy = 1548
end type

type ln_tempright from line within w_commonresponse
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginx = 3465
integer beginy = 24
integer endx = 3465
integer endy = 2272
end type

