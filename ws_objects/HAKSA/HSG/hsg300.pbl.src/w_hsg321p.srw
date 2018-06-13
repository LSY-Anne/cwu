$PBExportHeader$w_hsg321p.srw
$PBExportComments$[청운대]학생환경기록카드 출력
forward
global type w_hsg321p from w_condition_window
end type
type st_3 from statictext within w_hsg321p
end type
type dw_1 from uo_dddw_dwc within w_hsg321p
end type
type dw_main from uo_search_dwc within w_hsg321p
end type
type st_5 from statictext within w_hsg321p
end type
type sle_1 from uo_sle_hakbun within w_hsg321p
end type
type st_1 from statictext within w_hsg321p
end type
type ddlb_1 from dropdownlistbox within w_hsg321p
end type
end forward

global type w_hsg321p from w_condition_window
integer width = 3927
st_3 st_3
dw_1 dw_1
dw_main dw_main
st_5 st_5
sle_1 sle_1
st_1 st_1
ddlb_1 ddlb_1
end type
global w_hsg321p w_hsg321p

type variables

end variables

forward prototypes
public function integer wf_disp_image ()
end prototypes

public function integer wf_disp_image ();string ls_param,    ls_hakbun
blob   b_total_pic, b_pic
Int    ii
int liSeq, i
int isqlcode; string lsErrMsg
blob lbBmp
int li_cnt

int FP, Li_x, Li_count
long LL_size, LL_start, LL_write
blob imagedata, Lblb_part

IF DirectoryExists ('c:\emp_image') THEN
ELSE
   CreateDirectory ('c:\emp_image')
END IF

FOR ii       = 1 TO dw_main.RowCount()
	 ls_hakbun    = dw_main.GetItemString(ii, 'hakbun')
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
//		 dw_main.modify("p_1.filename = '..\emp_image\"+ls_hakbun+".bmp'")
//		 dw_main.modify("p_1.expression = bitmap('c:\emp_image\'+hakbun+'.bmp') ")
       dw_main.SetItem(ii, 'bmp_hakbun', 'C:\emp_image\' + ls_hakbun + '.jpg')
	ELSE
//		 dw_main.modify("p_1.filename = 'C:\emp_image\space.jpg'")
       dw_main.SetItem(ii, 'bmp_hakbun', 'C:\emp_image\space.jpg')
	END IF
NEXT
		
return 0
end function

on w_hsg321p.create
int iCurrent
call super::create
this.st_3=create st_3
this.dw_1=create dw_1
this.dw_main=create dw_main
this.st_5=create st_5
this.sle_1=create sle_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.ddlb_1
end on

on w_hsg321p.destroy
call super::destroy
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.dw_main)
destroy(this.st_5)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.ddlb_1)
end on

event open;call super::open;wf_setmenu('RETRIEVE', 	TRUE)
wf_setmenu('INSERT', 	FALSE)
wf_setmenu('DELETE', 	FALSE)
wf_setmenu('SAVE', 		FALSE)
wf_setmenu('PRINT', 		TRUE)

String ls_gwa

SELECT gwa
  INTO :ls_gwa
  FROM indb.Hin001m
 WHERE member_no = :gstru_uid_uname.uid;
IF ls_gwa  = '1200' OR ls_gwa = '1201' OR ls_gwa = '2902' THEN
	dw_1.Object.DataWindow.ReadOnly="No"
ELSE
	dw_1.SeTitem(1, 'gwa', ls_gwa)
	dw_1.Object.DataWindow.ReadOnly="Yes"
END IF
end event

event ue_retrieve;call super::ue_retrieve;string ls_hakbun,  ls_hakyun,  ls_hakgwa,   ls_hakbun1
long   ll_row,     ii,         l_cnt

ls_hakyun   = ddlb_1.text + '%'
ls_hakgwa	= dw_1.gettext() + '%'
ls_hakbun   = sle_1.text + '%'

ll_row      = dw_main.retrieve(ls_hakyun, ls_hakgwa, ls_hakbun)

wf_disp_image()

if ll_row = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)

elseif ll_row = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

dw_main.modify("DataWindow.Print.Preview = yes")
return 1
end event

type gb_1 from w_condition_window`gb_1 within w_hsg321p
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsg321p
integer taborder = 90
end type

type st_3 from statictext within w_hsg321p
integer x = 923
integer y = 124
integer width = 197
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "학과"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from uo_dddw_dwc within w_hsg321p
integer x = 1115
integer y = 108
integer width = 795
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_list_daepyogwa"
end type

type dw_main from uo_search_dwc within w_hsg321p
integer x = 27
integer y = 312
integer width = 3826
integer height = 2164
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsg321p_1"
end type

type st_5 from statictext within w_hsg321p
integer x = 2030
integer y = 124
integer width = 206
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "학번"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from uo_sle_hakbun within w_hsg321p
integer x = 2240
integer y = 108
integer width = 379
integer taborder = 10
boolean bringtotop = true
end type

type st_1 from statictext within w_hsg321p
integer x = 178
integer y = 124
integer width = 197
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "학년"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_hsg321p
integer x = 379
integer y = 108
integer width = 279
integer height = 324
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean allowedit = true
string item[] = {"1","2","3","4"}
borderstyle borderstyle = stylelowered!
end type

