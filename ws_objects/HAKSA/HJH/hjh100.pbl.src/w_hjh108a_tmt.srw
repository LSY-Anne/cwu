$PBExportHeader$w_hjh108a_tmt.srw
$PBExportComments$[청운대]입학성적장학생등록관리
forward
global type w_hjh108a_tmt from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjh108a_tmt
end type
type dw_con from uo_dwfree within w_hjh108a_tmt
end type
end forward

global type w_hjh108a_tmt from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hjh108a_tmt w_hjh108a_tmt

type variables

end variables

forward prototypes
public function any uf_baejung90 (long as_inwon)
public function any uf_baejung80 (long as_inwon)
public function any uf_baejung70 (long as_inwon)
public function any uf_baejung120 (long as_inwon)
public function any uf_baejung130 (long as_inwon)
public function any uf_baejung180 (long as_inwon)
public function any uf_baejung160 (long as_inwon)
public function any uf_baejung60 (long as_inwon)
public function any uf_baejung40 (long as_inwon)
public function any uf_baejung30 (long as_inwon)
public function any uf_baejung110 (long as_inwon)
public function integer wf_validall ()
end prototypes

public function any uf_baejung90 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 68  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 3
	ll_woosu4 = 0
elseif as_inwon >= 54 and as_inwon <= 67 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon >= 45 and as_inwon <= 53 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 45 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung80 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 60  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 3
	ll_woosu4 = 0
elseif as_inwon >= 48 and as_inwon <= 59 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon >= 40 and as_inwon <= 47 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 40 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung70 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 53  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 3
	ll_woosu4 = 0
elseif as_inwon >= 42 and as_inwon <= 52 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon >= 35 and as_inwon <= 41 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 35 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung120 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 90  then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 72 and as_inwon <= 89 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 60 and as_inwon <= 71 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon < 60 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 2
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung130 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 98  then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 78 and as_inwon <= 97 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 65 and as_inwon <= 77 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon < 65 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 2
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung180 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 135  then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 7
	ll_woosu4 = 0
elseif as_inwon >= 108 and as_inwon <= 134 then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 5
	ll_woosu4 = 0
elseif as_inwon >= 90 and as_inwon <= 107 then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 3
	ll_woosu4 = 0
elseif as_inwon < 90 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 2
	ll_woosu4 = 2
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung160 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 120  then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 7
	ll_woosu4 = 0
elseif as_inwon >= 96 and as_inwon <= 119 then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 5
	ll_woosu4 = 0
elseif as_inwon >= 80 and as_inwon <= 95 then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 3
	ll_woosu4 = 0
elseif as_inwon < 80 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 2
	ll_woosu4 = 2
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung60 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 45  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon >= 36 and as_inwon <= 44 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 0
	ll_woosu4 = 0
elseif as_inwon >= 30 and as_inwon <= 35 then
	ll_woosu1 = 1
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 30 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung40 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 30  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon >= 24 and as_inwon <= 29 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 0
	ll_woosu4 = 0
elseif as_inwon >= 20 and as_inwon <= 23 then
	ll_woosu1 = 1
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 20 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung30 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 23  then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon >= 18 and as_inwon <= 22 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 0
	ll_woosu4 = 0
elseif as_inwon >= 15 and as_inwon <= 17 then
	ll_woosu1 = 1
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
elseif as_inwon < 15 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 1
	ll_woosu4 = 0
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function any uf_baejung110 (long as_inwon);long ll_woosu1, ll_woosu2, ll_woosu3, ll_woosu4

if as_inwon >= 83  then
	ll_woosu1 = 1
	ll_woosu2 = 2
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 66 and as_inwon <= 82 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 4
	ll_woosu4 = 0
elseif as_inwon >= 55 and as_inwon <= 65 then
	ll_woosu1 = 1
	ll_woosu2 = 1
	ll_woosu3 = 2
	ll_woosu4 = 0
elseif as_inwon < 55 then
	ll_woosu1 = 0
	ll_woosu2 = 0
	ll_woosu3 = 2
	ll_woosu4 = 1
end if

str_parms str_baejung
str_baejung.l[1] 	= ll_woosu1
str_baejung.l[2] 	= ll_woosu2
str_baejung.l[3]	= ll_woosu3
str_baejung.l[4] 	= ll_woosu4

return str_baejung
end function

public function integer wf_validall ();String ls_hakbun, ls_janghak
Int    ii,        l_cnt,     li_ans
DateTime ls_date
dwItemStatus	lsStatus

FOR ii          = 1 TO dw_main.RowCount()
	 ls_hakbun   = dw_main.GetItemString(ii, 'hakbun')
	 ls_janghak  = dw_main.GetItemString(ii, 'janghak_id')
     lsStatus    = dw_main.GetItemStatus(ii, 0, Primary!)

    IF lsStatus = DataModified! OR lsStatus   = New! OR lsStatus   = NewModified! THEN
		
		 SELECT nvl(count(*), 0)
		   INTO :l_cnt
			FROM haksa.jaehak_hakjuk
		  WHERE hakbun     = :ls_hakbun
		  USING SQLCA ;
		  
		 IF sqlca.sqlnrows = 0 THEN
			 l_cnt          = 0
		 END IF
		 IF l_cnt          = 0 THEN
			 messagebox("저장", ls_hakbun + '의 학번은 존재하지 않으니 확인바랍니다.')
			 dw_main.SetColumn('hakbun')
			 dw_main.SetFocus()
			 dw_main.ScrollToRow(ii)
          	 return -1
		 END IF
		 IF isnull(ls_janghak) OR ls_janghak = '' THEN
			 messagebox("저장", ls_hakbun + '학번의 장학모델을 선택하시기 바랍니다.')
			 dw_main.SetColumn('janghak_id')
			 dw_main.SetFocus()
			 dw_main.ScrollToRow(ii)
               return -1
		 END IF
	 END IF
NEXT

Return 1
end function

on w_hjh108a_tmt.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjh108a_tmt.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;integer	li_row
string	ls_year, ls_gwa, ls_hakbun

dw_con.AcceptText()

//조회조건
ls_year		= dw_con.Object.year[1]
ls_gwa		= func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun 	= func.of_nvl(dw_con.Object.hakbun[1], '%')

li_row = dw_main.retrieve(ls_year, ls_gwa, ls_hakbun)

if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year


end event

event ue_insert;long   ll_newrow
string ls_year, ls_hakgi, ls_hakyun, ls_gwa, ls_month

dw_con.AcceptText()

//조회조건
ls_year		= dw_con.Object.year[1]

IF isnull(ls_year) OR ls_year = '' THEN
	messagebox('확인', "입학성작 장학 발생년도를 입력하세요!")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if    

ll_newrow	= dw_main.InsertRow(0)//	데이타윈도우의 마지막 행에 추가

dw_main.object.year[ll_newrow]       = ls_year
dw_main.object.worker[ll_newrow]   = gs_empcode
dw_main.object.ipaddr[ll_newrow]    = gs_ip
//dw_main.object.work_date[ll_newrow] = getdate()

IF ll_newrow <> -1 THEN
   dw_main.ScrollToRow(ll_newrow)		//	추가된 행에 스크롤
	dw_main.setcolumn(1)              	//	추가된 행의 첫번째 컬럼에 커서 위치
	dw_main.setfocus()                	//	dw_main 포커스 이동
END IF

end event

event ue_delete;int	li_ans1	,&
		li_ans2

li_ans1 = uf_messagebox(4)		//	삭제확인 메세지 출력

IF li_ans1 = 1 THEN
	dw_main.deleterow(0)          //	현재 행을 삭제
	li_ans2 = dw_main.update()    //	삭제된 내용을 저장
	
	IF li_ans2 = -1 THEN
		ROLLBACK USING SQLCA;     
		uf_messagebox(6)        //	삭제오류 메세지 출력
	
	ELSE
      COMMIT USING SQLCA;		  
		uf_messagebox(5)       //	삭제완료 메시지 출력
	END IF
END IF

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjh108a_tmt
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjh108a_tmt
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjh108a_tmt
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjh108a_tmt
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjh108a_tmt
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjh108a_tmt
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjh108a_tmt
end type

type uc_insert from w_condition_window`uc_insert within w_hjh108a_tmt
end type

type uc_delete from w_condition_window`uc_delete within w_hjh108a_tmt
end type

type uc_save from w_condition_window`uc_save within w_hjh108a_tmt
end type

type uc_excel from w_condition_window`uc_excel within w_hjh108a_tmt
end type

type uc_print from w_condition_window`uc_print within w_hjh108a_tmt
end type

type st_line1 from w_condition_window`st_line1 within w_hjh108a_tmt
end type

type st_line2 from w_condition_window`st_line2 within w_hjh108a_tmt
end type

type st_line3 from w_condition_window`st_line3 within w_hjh108a_tmt
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjh108a_tmt
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjh108a_tmt
end type

type gb_1 from w_condition_window`gb_1 within w_hjh108a_tmt
end type

type gb_2 from w_condition_window`gb_2 within w_hjh108a_tmt
end type

type dw_main from uo_input_dwc within w_hjh108a_tmt
integer x = 50
integer y = 300
integer width = 4384
integer height = 1964
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hjh108a_1"
end type

event itemchanged;string	ls_hakbun, ls_hakbun1, ls_hakyun, ls_gwa, ls_name
integer	li_cnt

CHOOSE CASE DWO.NAME
	CASE 'hakbun'

		SELECT hname,     gwa
		  INTO :ls_name,  :ls_gwa
		  FROM haksa.jaehak_hakjuk
		 WHERE hakbun     = :data;
		IF sqlca.sqlnrows = 0 THEN
			messagebox("알림", '해당 학번은 존재하지 않으니 확인바랍니다')
			dw_main.SetColumn('hakbun')
         dw_main.SetFocus()
         dw_main.ScrollToRow(row)
			return 1
		END IF
		dw_main.object.hname[row] = ls_name
		dw_main.object.gwa[row]   = ls_gwa
END CHOOSE		
		
end event

event itemerror;RETURN 2
end event

event clicked;call super::clicked;This.SetRow(row)
end event

type dw_con from uo_dwfree within w_hjh108a_tmt
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hjh108a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

