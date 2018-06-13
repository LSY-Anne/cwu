$PBExportHeader$w_dip407a.srw
$PBExportComments$[대학원입시] 등록금환불관리
forward
global type w_dip407a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dip407a
end type
type dw_con from uo_dwfree within w_dip407a
end type
end forward

global type w_dip407a from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_dip407a w_dip407a

type variables
DataWindowChild ldwc_hjmod
end variables

forward prototypes
public subroutine wf_con_protect ()
end prototypes

public subroutine wf_con_protect ();// 계열, 학과, 전공 사용유무를 체크하여 protect한다.
// ls_chk1 : 계열, ls_chk2 : 학과, ls_chk3 : 전공
// Y: 사용, N: 미사용

String ls_chk1, ls_chk2, ls_chk3
Int      li_chk1, li_chk2, li_chk3

SELECT ETC_CD1, ETC_CD2, ETC_CD3
   INTO :ls_chk1, :ls_chk2, :ls_chk3
  FROM CDDB.KCH102D
 WHERE CODE_GB = 'DHW01'
 USING SQLCA ;
 
If  ls_chk1 = 'Y' Then
	li_chk1 = 0
Else
	li_chk1 = 1
End If

If  ls_chk2 = 'Y' Then
	li_chk2 = 0
Else
	li_chk2 = 1
End If

If  ls_chk3 = 'Y' Then
	li_chk3 = 0
Else
	li_chk3 = 1
End If
 
dw_con.Object.gyeyul_id.Protect = li_chk1
dw_con.Object.gwa.Protect        = li_chk2
dw_con.Object.jungong_id.Protect   = li_chk3

//dw_main.Object.gyeyul_id.Protect    = li_chk1
//dw_main.Object.gwa_id.Protect       = li_chk2
//dw_main.Object.jungong_id.Protect  = li_chk3
end subroutine

on w_dip407a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_dip407a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_hakgwa, ls_jungong, ls_suhum, ls_gyeyul_id
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gyeyul_id =  func.of_nvl(dw_con.Object.gyeyul_id[1], '%') + '%'
ls_hakgwa 	=	func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_jungong 	=	func.of_nvl(dw_con.Object.jungong_id[1], '%') + '%'
ls_suhum    =	func.of_nvl(dw_con.Object.suhum_no[1], '%') + '%'

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gyeyul_id, ls_hakgwa, ls_jungong, ls_suhum)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1

end event

event open;call super::open;string	ls_hakgi, ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	NEXT_YEAR,      NEXT_HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi



end event

event ue_insert;call super::ue_insert;string ls_year, ls_hakgi, ls_dhw, ls_hakgwa, ls_gwajung
long ll_line

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
end if

ll_line = dw_main.insertrow(0)
dw_main.scrolltorow(ll_line)

dw_main.object.di_dungrok_hwan_year[ll_line]	=	ls_year
dw_main.object.di_dungrok_hwan_hakgi[ll_line]	=	ls_hakgi

dw_main.SetColumn('di_dungrok_hwan_suhum_no')
dw_main.setfocus()
end event

event ue_delete;call super::ue_delete;int li_row, li_ans, li_chasu
string	ls_year, ls_hakgi, ls_suhum

//삭제확인
if uf_messagebox(4) = 2 then return

li_row = dw_main.getrow()

ls_year	=	dw_main.object.di_dungrok_hwan_year[li_row]
ls_hakgi	=	dw_main.object.di_dungrok_hwan_hakgi[li_row]
ls_suhum =	dw_main.object.di_dungrok_hwan_suhum_no[li_row]

dw_main.deleterow(0)
li_ans = dw_main.update()								

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback USING SQLCA ;
else
	UPDATE	DIPSI.DI_DUNGROK
	SET		HWAN_YN	=	'1'
	WHERE		YEAR		=	:ls_year
	AND		HAKGI		=	:ls_hakgi
	AND		SUHUM_NO	=	:ls_suhum
	 USING SQLCA ;
	
	IF SQLCA.SQLCODE = 0 THEN
		COMMIT  USING SQLCA ;
		uf_messagebox(5)
		
	ELSE
		ROLLBACK  USING SQLCA ;
		messagebox("오류","환불내역생성중 오류발생~r~n" + sqlca.sqlerrtext)
	END IF

end if
end event

event ue_save;int 	li_ans
long	ll_row		,&
		ll_rowcount
dwItemStatus l_status
string	ls_suhum	,&
			ls_year	,&
			ls_hakgi

dw_main.accepttext()
ll_rowcount	= dw_main.rowcount()

SetPointer(hourglass!)

for ll_row = 1 to ll_rowcount
	l_status = dw_main.GetItemStatus(ll_row, 0, PRIMARY!)
	
	if l_status = NEWMODIFIED! then
		ls_suhum	= dw_main.object.di_dungrok_hwan_suhum_no[ll_row]
		ls_year	= dw_main.object.di_dungrok_hwan_year[ll_row]
		ls_hakgi = dw_main.object.di_dungrok_hwan_hakgi[ll_row]
		
		//등록테이블 Update
			UPDATE	DIPSI.DI_DUNGROK
			SET		HWAN_YN	= '1'
			WHERE		YEAR		=	:ls_year
			AND		HAKGI		=	:ls_hakgi
			AND		SUHUM_NO	=	:ls_suhum
			USING SQLCA ;
			
			if sqlca.sqlcode <> 0 then
				Messagebox('확인!', '등록 테이블 UPDATE 실패!~r~n' + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return -1
			end if
			
			UPDATE DIPSI.DI_WONSEO
			SET	DUNG_YN	=	'0'
			WHERE	YEAR		=	:ls_year
			AND	HAKGI		=	:ls_hakgi
			AND	SUHUM_NO	=	:ls_suhum
			USING SQLCA ;
			
			if sqlca.sqlcode <> 0 then
				Messagebox('확인!', '원서 UPDATE 실패!~r~n' + sqlca.sqlerrtext)
				rollback USING SQLCA ;
				return -1
			end if
					
	end if
	
next

li_ans = dw_main.update()

if li_ans = -1 then
	//저장 오류 메세지 출력
	rollback USING SQLCA ;
	uf_messagebox(3)
	
else	
	commit USING SQLCA ;
	uf_messagebox(2)
end if

Return 1
end event

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dip407a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dip407a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dip407a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dip407a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dip407a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dip407a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dip407a
end type

type uc_insert from w_condition_window`uc_insert within w_dip407a
end type

type uc_delete from w_condition_window`uc_delete within w_dip407a
end type

type uc_save from w_condition_window`uc_save within w_dip407a
end type

type uc_excel from w_condition_window`uc_excel within w_dip407a
end type

type uc_print from w_condition_window`uc_print within w_dip407a
end type

type st_line1 from w_condition_window`st_line1 within w_dip407a
end type

type st_line2 from w_condition_window`st_line2 within w_dip407a
end type

type st_line3 from w_condition_window`st_line3 within w_dip407a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dip407a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dip407a
end type

type gb_1 from w_condition_window`gb_1 within w_dip407a
end type

type gb_2 from w_condition_window`gb_2 within w_dip407a
end type

type dw_main from uo_input_dwc within w_dip407a
integer x = 50
integer y = 372
integer width = 4384
integer height = 1892
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dip407a"
end type

event itemchanged;call super::itemchanged;string	ls_name, ls_year, ls_hakgi
long		ll_iphak, ll_dungrok, ll_wonwoo, ll_i_jang, ll_d_jang

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

CHOOSE CASE DWO.NAME
	CASE	'di_dungrok_hwan_suhum_no'
		SELECT	A.HNAME,
					NVL(SUM(B.IPHAK_N), 0),
					NVL(SUM(B.DUNGROK_N), 0),
					NVL(SUM(B.WONWOO_N), 0),
					NVL(SUM(B.I_JANGHAK), 0),
					NVL(SUM(B.D_JANGHAK), 0)
		INTO	:ls_name,
				:ll_iphak,
				:ll_dungrok,
				:ll_wonwoo,
				:ll_i_jang,
				:ll_d_jang
		FROM	DIPSI.DI_WONSEO	A,
				DIPSI.DI_DUNGROK	B
		WHERE	A.YEAR		=	B.YEAR
		AND	A.HAKGI		=	B.HAKGI
		AND	A.SUHUM_NO	=	B.SUHUM_NO
		AND	A.YEAR		=	:ls_year
		AND	A.HAKGI		=	:ls_hakgi
		AND	A.SUHUM_NO	=	:data	
		GROUP BY HNAME
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","잘못된 수험번호입니다.")
			this.object.di_dungrok_hwan_suhum_no[row] = ''
			return 1
			
		end if
		
		if ll_iphak + ll_dungrok + ll_wonwoo = 0 then
			messagebox("오류","등록내역이 존재하지 않습니다.")
			this.object.di_dungrok_hwan_suhum_no[row] = ''
			return 1
		end if
		
		this.object.di_wonseo_hname[row]	=	ls_name
		
		this.object.di_dungrok_hwan_iphak[row]		=	ll_iphak
		this.object.di_dungrok_hwan_dungrok[row]	=	ll_dungrok
		this.object.di_dungrok_hwan_wonwoo[row]	=	ll_wonwoo
		
		this.object.di_dungrok_hwan_i_janghak[row]	=	ll_i_jang
		this.object.di_dungrok_hwan_d_janghak[row]	=	ll_d_jang
		
		this.object.di_dungrok_hwan_hwan_date[row]	=	string(f_sysdate(), 'yyyymmdd')

		
END CHOOSE
	
end event

event itemerror;call super::itemerror;RETURN 2
end event

type dw_con from uo_dwfree within w_dip407a
integer x = 50
integer y = 164
integer width = 4384
integer height = 200
integer taborder = 230
boolean bringtotop = true
string dataobject = "d_dip406a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;dw_con.getchild('jungong_id', ldwc_hjmod)
ldwc_hjmod.SetTransObject(sqlca)	
ldwc_hjmod.retrieve('%')
end event

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gwa'
		ldwc_hjmod.Retrieve(data)
End Choose
end event

