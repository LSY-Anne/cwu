$PBExportHeader$w_dip406a.srw
$PBExportComments$[대학원입시] 등록금납부관리
forward
global type w_dip406a from w_condition_window
end type
type dw_con from uo_dwfree within w_dip406a
end type
type dw_main from uo_dwfree within w_dip406a
end type
type dw_1 from uo_dwfree within w_dip406a
end type
end forward

global type w_dip406a from w_condition_window
dw_con dw_con
dw_main dw_main
dw_1 dw_1
end type
global w_dip406a w_dip406a

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

on w_dip406a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.dw_1
end on

on w_dip406a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.dw_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_hakgwa, ls_jungong, ls_suhum, ls_gyeyul_id
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakgwa 	=	func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_gyeyul_id =  func.of_nvl(dw_con.Object.gyeyul_id[1], '%') + '%'
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
dw_1.SetTransObject(sqlca)

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
long ll_line, ll_row = 0

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if (Isnull(ls_year) or ls_year = '') or ( Isnull(ls_hakgi) or ls_hakgi = '') then
	messagebox("확인","년도, 학기를 입력하세요.")
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
end if

ll_row = dw_main.getrow()

ll_line = dw_main.insertrow(ll_row + 1)
dw_main.scrolltorow(ll_line)

dw_main.object.di_dungrok_year[ll_line]			    =	ls_year
dw_main.object.di_dungrok_hakgi[ll_line]			=	ls_hakgi
dw_main.object.di_dungrok_napbu_date[ll_line]	=	string(f_sysdate(), 'YYYYMMDD')
dw_main.object.di_dungrok_bank_id[ll_line]		=	'1'

dw_main.SetColumn('di_dungrok_suhum_no')
dw_main.setfocus()

end event

event ue_delete;call super::ue_delete;int li_ans, li_chasu

li_chasu	=	dw_main.object.di_dungrok_chasu[dw_main.getrow()]

if li_chasu > 1 then
	messagebox("오류","차수가 1인 자료는 삭제할 수 없습니다.")
	return
end if

//삭제확인
if uf_messagebox(4) = 2 then return

dw_main.deleterow(0)
li_ans = dw_main.update()								

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback using sqlca ;
else	
	commit using sqlca ;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

event ue_save;// 저장되면 DI_WONSEO의 등록여부도 체크해야함.(차수가 1인 자료만 해당됨.)
int	li_ans
string ls_year, ls_hakgi, ls_dung, ls_suhum
long  ll_row, ll_chasu, ll_cnt

dw_con.AcceptText()
dw_main.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

ll_cnt = dw_main.RowCount()
			
DO WHILE ll_row <= ll_cnt
	
		ll_row = dw_main.GetNextModified(ll_row, Primary!)

		IF ll_row > 0 THEN
			
			ll_chasu = dw_main.object.di_dungrok_chasu[ll_row]
			
			if ll_chasu = 1 then 
				ls_dung	=	dw_main.object.di_dungrok_dung_yn[ll_row]

				ls_suhum	=	dw_main.object.di_dungrok_suhum_no[ll_row]
				
				UPDATE DIPSI.DI_WONSEO
				SET	DUNG_YN	=	:ls_dung
				WHERE	YEAR		=	:ls_year
				AND	HAKGI		=	:ls_hakgi
				AND	SUHUM_NO	=	:ls_suhum
				USING SQLCA ;
				
				if sqlca.sqlcode <> 0 then
					messagebox("오류","DI_WONSEO 저장중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
					rollback USING SQLCA ;
					return -1
				end if
				
			end if			
						
		ELSE
			ll_row = ll_cnt + 1
		END IF
LOOP

li_ans = dw_main.update()
					
if li_ans = -1 then
	//저장 오류 메세지 출력
	rollback USING SQLCA ;
	uf_messagebox(3)
	
else	
	commit USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(2)
end if

Return 1



end event

event ue_postopen;call super::ue_postopen;wf_con_protect()
end event

type ln_templeft from w_condition_window`ln_templeft within w_dip406a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dip406a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dip406a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dip406a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dip406a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dip406a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dip406a
end type

type uc_insert from w_condition_window`uc_insert within w_dip406a
end type

type uc_delete from w_condition_window`uc_delete within w_dip406a
end type

type uc_save from w_condition_window`uc_save within w_dip406a
end type

type uc_excel from w_condition_window`uc_excel within w_dip406a
end type

type uc_print from w_condition_window`uc_print within w_dip406a
end type

type st_line1 from w_condition_window`st_line1 within w_dip406a
end type

type st_line2 from w_condition_window`st_line2 within w_dip406a
end type

type st_line3 from w_condition_window`st_line3 within w_dip406a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dip406a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dip406a
end type

type gb_1 from w_condition_window`gb_1 within w_dip406a
end type

type gb_2 from w_condition_window`gb_2 within w_dip406a
end type

type dw_con from uo_dwfree within w_dip406a
integer x = 50
integer y = 164
integer width = 4384
integer height = 204
integer taborder = 220
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

type dw_main from uo_dwfree within w_dip406a
integer x = 50
integer y = 380
integer width = 4384
integer height = 1428
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dip406a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string	ls_year, ls_hakgi, ls_name, ls_suhum, ls_wan
string	ls_chk1, ls_chk2
long		ll_chasu, ll_sil_i, ll_sil_d, ll_sil_w, ll_row

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

CHOOSE CASE DWO.NAME
	CASE	'di_dungrok_suhum_no'
				
		SELECT	A.HNAME,
					MAX(B.CHASU) + 1
		INTO	:ls_name,
				:ll_chasu
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
			messagebox("오류","잘못된 수험번호입니다.~r~n" + sqlca.sqlerrtext)
			this.object.di_dungrok_suhum_no[row] = ''
			return 1
			
		end if
		
		ll_row = dw_1.retrieve(ls_year, ls_hakgi, data)
		
		if ll_row <= 0 then
			messagebox("오류","등록금 생성 내역을 확인하세요.")
			this.object.di_dungrok_suhum_no[row] = ''
			return 1
			
		end if
		
		//현재까지 낸 금액을 가져와서 SETTING
		ll_sil_i	=	dw_1.object.sil_i[1]
		ll_sil_d	=	dw_1.object.sil_d[1]
		ll_sil_w	=	dw_1.object.sil_w[1]
		
		if ll_sil_i + ll_sil_d + ll_sil_w = 0 then
			messagebox("오류","등록금을 완납하였습니다.")
			this.object.di_dungrok_suhum_no[row] = ''
			return 1
		end if
		
		this.object.di_wonseo_hname[row]		=	ls_name
		this.object.di_dungrok_chasu[row]		=	ll_chasu
		this.object.di_dungrok_napbu_date[row]	=	string(f_sysdate(), 'yyyymmdd')
		
		this.object.di_dungrok_iphak_n[row]		=	long(dw_1.object.sil_i[1])
		this.object.di_dungrok_dungrok_n[row]	=	long(dw_1.object.sil_d[1])
		this.object.di_dungrok_wonwoo_n[row]	=	long(dw_1.object.sil_w[1])
		
		this.object.di_dungrok_wan_yn[row]	=	'1'
		
		if ll_chasu = 1 then
			this.object.di_dungrok_dung_yn[row]	=	'1'
		else
			//차수가 2이상인 경우는 완납일 경우가 많으므로 완납에 default로 '1'로 한다.
			this.object.di_dungrok_dung_yn[row]	=	'0'
			this.object.di_dungrok_wan_yn[row]	=	'1'
		end if
		
	CASE	'di_dungrok_chu_yn'
		ll_chasu	=	this.object.di_dungrok_chasu[row]
		ls_chk1	=	this.object.di_dungrok_bun_yn[row]
		ls_chk2	=	this.object.di_dungrok_wan_yn[row]
		
		if data = '1' then
			
			//이미 원우회비를 납부하였는지 check - 냈으면 추가납을 '0', 금액도 0으로 set
			ll_sil_w	=	dw_1.object.sil_w[1]
			
			if ll_sil_w = 0 then
				messagebox("오류","원우회비를 납부하였습니다.")
				this.object.di_dungrok_chu_yn[row]		=	'0'
				this.object.di_dungrok_wonwoo_n[row]	=	'0'
				return 1
			end if
			
			//추가납은 원우회비만 가능하므로 입학금과 등록금은 0원으로 한다.
			this.object.di_dungrok_iphak_n[row]		=	0
			this.object.di_dungrok_dungrok_n[row]	=	0
			this.object.di_dungrok_wonwoo_n[row]	=	dw_1.object.sil_w[1]
			this.object.di_dungrok_napbu_date[row]	=	string(f_sysdate(), 'yyyymmdd')
		else
			this.object.di_dungrok_wonwoo_n[row]	=	0
			
			//납부일자 SETTING
			if ls_chk1 = '0' and ls_chk2 = '0' then
				this.object.di_dungrok_napbu_date[row]	=	''
				
			end if
		end if
		
	CASE	'di_dungrok_wan_yn'
		//납부일자를 SETTING 하기위함.
		ls_chk1 = this.object.di_dungrok_bun_yn[row]
		ls_chk2 = this.object.di_dungrok_chu_yn[row]
		
		if data = '0' then
			if ls_chk1 = '0' and ls_chk2 = '0' then
				this.object.di_dungrok_napbu_date[row]	=	''
				this.object.di_dungrok_bank_id[row]		=	''
			end if
			
		else
			this.object.di_dungrok_napbu_date[row]	=	string(f_sysdate(), 'yyyymmdd')
			this.object.di_dungrok_bank_id[row]		=	'1'
			
			this.object.di_dungrok_iphak_n[row]		=	long(dw_1.object.sil_i[1])
			this.object.di_dungrok_dungrok_n[row]	=	long(dw_1.object.sil_d[1])
			this.object.di_dungrok_wonwoo_n[row]	=	long(dw_1.object.sil_w[1])
			
		end if
		
		//차수가 1이면 등록chk
		ll_chasu	=	this.object.di_dungrok_chasu[row]
		
		if ll_chasu = 1 then
			this.object.di_dungrok_dung_yn[row]	=	'1'
		end if
		
	CASE	'di_dungrok_bun_yn'
		//납부일자를 SETTING 하기위함.
		ls_chk1 = this.object.di_dungrok_wan_yn[row]
		ls_chk2 = this.object.di_dungrok_chu_yn[row]
		
		if data = '0' then
			if ls_chk1 = '0' and ls_chk2 = '0' then
				this.object.di_dungrok_napbu_date[row]	=	''
				
			end if
			
		else
			this.object.di_dungrok_napbu_date[row]	=	string(f_sysdate(), 'yyyymmdd')
		end if		
		
		//차수가 1이면 등록chk
		ll_chasu	=	this.object.di_dungrok_chasu[row]
		
		if ll_chasu = 1 then
			this.object.di_dungrok_dung_yn[row]	=	'1'
		end if
		
END CHOOSE
		

end event

event clicked;call super::clicked;string ls_year, ls_hakgi, ls_suhum

if ROW > 0 then

	ls_year	=	this.object.di_dungrok_year[row]
	ls_hakgi	=	this.object.di_dungrok_hakgi[row]
	ls_suhum	=	this.object.di_dungrok_suhum_no[row]
	
	dw_1.retrieve(ls_year, ls_hakgi, ls_suhum)
end if
end event

event itemerror;call super::itemerror;return 2
end event

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

type dw_1 from uo_dwfree within w_dip406a
integer x = 50
integer y = 1836
integer width = 4384
integer height = 428
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_dip406a_1"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_dw(dw_1)
end event

