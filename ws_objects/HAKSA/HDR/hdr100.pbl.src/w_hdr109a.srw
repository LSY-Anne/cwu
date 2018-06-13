$PBExportHeader$w_hdr109a.srw
$PBExportComments$[청운대]납부관리(납입할금액수정)
forward
global type w_hdr109a from w_condition_window
end type
type dw_con from uo_dwfree within w_hdr109a
end type
type dw_main from uo_dwfree within w_hdr109a
end type
end forward

global type w_hdr109a from w_condition_window
dw_con dw_con
dw_main dw_main
end type
global w_hdr109a w_hdr109a

on w_hdr109a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hdr109a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;string ls_year, ls_hakgi, ls_hakbun
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakbun   	=	dw_con.Object.hakbun[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi)  or ls_hakbun ='' or isnull(ls_hakbun)  then
	messagebox('확인', "년도, 학기, 학번을 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_main.SetTransObject(sqlca)
dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

event ue_insert;string ls_year, ls_hakgi, ls_dhw, ls_hakgwa, ls_gwajung
long ll_line, ll_row = 0

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi)  then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_row = dw_main.getrow()

ll_line = dw_main.insertrow(ll_row + 1)
dw_main.scrolltorow(ll_line)

dw_main.object.dungrok_gwanri_year[ll_line]	=	ls_year
dw_main.object.dungrok_gwanri_hakgi[ll_line]	=	ls_hakgi
dw_main.object.japbu_check[ll_line] = 'Y'

dw_main.SetColumn('dungrok_gwanri_hakbun')
dw_main.setfocus()

end event

event ue_delete;int li_ans

//삭제확인
if uf_messagebox(4) = 2 then return

dw_main.deleterow(0)
li_ans = dw_main.update()				

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback USING SQLCA ;
else	
	commit USING SQLCA ;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr109a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr109a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr109a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr109a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr109a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr109a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr109a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr109a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr109a
end type

type uc_save from w_condition_window`uc_save within w_hdr109a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr109a
end type

type uc_print from w_condition_window`uc_print within w_hdr109a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr109a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr109a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr109a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr109a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr109a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr109a
end type

type gb_2 from w_condition_window`gb_2 within w_hdr109a
end type

type dw_con from uo_dwfree within w_hdr109a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hdr102a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dwfree within w_hdr109a
integer x = 55
integer y = 292
integer width = 4375
integer height = 1972
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hdr109a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;int		li_chasu
long		ll_jang, ll_haksengwhe, ll_gyojae, ll_album, ll_memorial, ll_dongchangwhe, ll_japbu, ll_japbu_n
string	ls_year, ls_hakgi, ls_hakbun, ls_name, ls_hakgwa, ls_chk, ls_hakyun, ls_dung_gubun

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

CHOOSE CASE	DWO.NAME
	//완납을 체크하면 금액이 setting
	CASE	'dungrok_gwanri_wan_yn'
		if data = 'Y' then
			
			dw_main.object.dungrok_gwanri_bank_id[row]		=	'1'
			dw_main.object.dungrok_gwanri_napbu_date[row]	=	string(date(f_sysdate()), 'yyyymmdd')
			dw_main.object.dungrok_gwanri_iphak_n[row]		=	dw_main.object.dungrok_gwanri_iphak[row]
			
			ll_jang = dw_main.object.dungrok_gwanri_d_janghak[row]
			if isnull(ll_jang) then
				ll_jang = 0 
			end if
			
			dw_main.object.dungrok_gwanri_dungrok_n[row]			=	dw_main.object.dungrok_gwanri_dungrok[row] - ll_jang
			
			dw_main.object.dungrok_gwanri_haksengwhe_n[row]		=	dw_main.object.dungrok_gwanri_haksengwhe[row]
			dw_main.object.dungrok_gwanri_gyojae_n[row]			=	dw_main.object.dungrok_gwanri_gyojae[row]
			dw_main.object.dungrok_gwanri_album_n[row]			=	dw_main.object.dungrok_gwanri_album[row]
			dw_main.object.dungrok_gwanri_memorial_n[row]		=	dw_main.object.dungrok_gwanri_memorial[row]
			dw_main.object.dungrok_gwanri_dongchangwhe_n[row]	=	dw_main.object.dungrok_gwanri_dongchangwhe[row]
			
			li_chasu = dw_main.object.dungrok_gwanri_chasu[row]
			ls_chk = dw_main.object.japbu_check[row]
			
			//차수가 1이면 등록을 자동 체크한다.(단, 잡부비 입력을 위한 부분이 체크되어 있으면 등록이 안됨)
			if li_chasu = 1 and ls_chk = 'N'   then
				dw_main.object.dungrok_gwanri_dung_yn[row]	=	'Y'
			end if
			
			//잡부비 입력하는 컬럼이 check 되어 있으면 잡부비를 자동세팅한다.
			if ls_chk = 'Y' then
				ls_hakbun = this.object.dungrok_gwanri_hakbun[row]
				
				SELECT	B.HAKSENGWHE,
							B.GYOJAE,
							B.ALBUM,
							B.MEMORIAL,
							B.DONGCHANGWHE
				INTO		:ll_haksengwhe,
							:ll_gyojae,
							:ll_album,
							:ll_memorial,
							:ll_dongchangwhe
				FROM		HAKSA.JAEHAK_HAKJUK A,
							HAKSA.DUNGROK_MODEL B
				WHERE		A.GWA		=	B.GWA
				AND		A.SU_HAKYUN = B.HAKYUN
				AND		B.YEAR	=	:ls_year
				AND		B.HAKGI	=	:ls_hakgi
				AND		A.HAKBUN	=	:ls_hakbun	
				USING SQLCA ;
				
				dw_main.object.dungrok_gwanri_haksengwhe_n[row] 	= ll_haksengwhe
				dw_main.object.dungrok_gwanri_gyojae_n[row]			= ll_gyojae
				dw_main.object.dungrok_gwanri_album_n[row]			= ll_album
				dw_main.object.dungrok_gwanri_memorial_n[row]		= ll_memorial
				dw_main.object.dungrok_gwanri_dongchangwhe_n[row]	= ll_dongchangwhe
			end if
			
		else
						
			dw_main.object.dungrok_gwanri_bank_id[row]		=	''
			dw_main.object.dungrok_gwanri_napbu_date[row]	=	''
			dw_main.object.dungrok_gwanri_dung_yn[row]		=	'N'
			
			setnull(ll_jang)
			
			dw_main.object.dungrok_gwanri_iphak_n[row]			= ll_jang
			dw_main.object.dungrok_gwanri_dungrok_n[row]			= ll_jang
			dw_main.object.dungrok_gwanri_haksengwhe_n[row] 	= ll_jang
			dw_main.object.dungrok_gwanri_gyojae_n[row]			= ll_jang
			dw_main.object.dungrok_gwanri_album_n[row]			= ll_jang
			dw_main.object.dungrok_gwanri_memorial_n[row]		= ll_jang
			dw_main.object.dungrok_gwanri_dongchangwhe_n[row]	= ll_jang
		end if
		
		
	CASE	'dungrok_gwanri_hakbun'
		
		SELECT	A.HNAME,
					A.GWA,
					A.SU_HAKYUN
		INTO		:ls_name,
					:ls_hakgwa,
					:ls_hakyun
		FROM		HAKSA.JAEHAK_HAKJUK	A
		WHERE		A.HAKBUN		=	:data		
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","잘못된 수험번호입니다.~r~n" + sqlca.sqlerrtext)
			this.object.dungrok_gwanri_hakbun[row] = ''
			return 1
			
		end if
		
		//잡부비 납부자인지 체크
		SELECT	NVL(SUM(HAKSENGWHE_N), 0) + NVL(SUM(GYOJAE_N), 0) + NVL(SUM(ALBUM_N), 0) + NVL(SUM(MEMORIAL_N), 0) + NVL(SUM(DONGCHANGWHE_N), 0),
					NVL(SUM(HAKSENGWHE), 0) + NVL(SUM(GYOJAE), 0) + NVL(SUM(ALBUM), 0) + NVL(SUM(MEMORIAL), 0) + NVL(SUM(DONGCHANGWHE), 0)
		INTO		:ll_japbu_n,
					:ll_japbu
		FROM		HAKSA.DUNGROK_GWANRI
		WHERE		YEAR		=	:ls_year
		AND		HAKGI		=	:ls_hakgi
		AND		HAKBUN	=	:data	
		USING SQLCA ;
		
		if ll_japbu = ll_japbu_n then
			messagebox("확인","이미 잡부비를 납부하셨습니다.~r~n" + sqlca.sqlerrtext)
			this.object.dungrok_gwanri_hakbun[row] = ''
			return 1
		end if
		
		//차수생성
		SELECT	MAX(CHASU) + 1
		INTO		:li_chasu
		FROM		HAKSA.DUNGROK_GWANRI
		WHERE		YEAR		=	:ls_year
		AND		HAKGI		=	:ls_hakgi
		AND		HAKBUN	=	:data		
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","차수생성중 오류가 발생되었습니다.~r~n" + sqlca.sqlerrtext)
			this.object.dungrok_gwanri_hakbun[row] = ''
			return 1	
		end if
		
		dw_main.object.dungrok_gwanri_year[row]		= ls_year
		dw_main.object.dungrok_gwanri_hakgi[row]		= ls_hakgi
		dw_main.object.dungrok_gwanri_chasu[row]		= li_chasu
		dw_main.object.dungrok_gwanri_su_hakyun[row] = ls_hakyun
		dw_main.object.jaehak_hakjuk_su_hakyun[row] 	= ls_hakyun

		dw_main.object.jaehak_hakjuk_hname[row]	= ls_name
		dw_main.object.jaehak_hakjuk_gwa[row]		= ls_hakgwa
				
		dw_main.object.dungrok_gwanri_chu_yn[row]	= 'Y'
		//잡부비만을 입력할 수 있게 Potect되어 있는 field값을 Y로 setting
		dw_main.object.japbu_check[row] = 'Y'
		
		//등록구분 입력
		
		//등록구분 체크
		SELECT	HJMOD_ID
		INTO	:ls_dung_gubun
		FROM	HAKSA.HAKJUKBYENDONG
		WHERE	YEAR		=	:ls_year
		AND	HAKGI		=	:ls_hakgi
		AND	HAKBUN	=	:data	
		AND	HJMOD_SIJUM	=	(	SELECT MAX(HJMOD_SIJUM)
										FROM	HAKSA.HAKJUKBYENDONG
										WHERE	YEAR		=	:ls_year
										AND	HAKGI		=	:ls_hakgi
										AND	HAKBUN	=	:data
									)	USING SQLCA ;
									
		if sqlca.sqlcode = 0 then
			if ls_dung_gubun = 'C' then
				ls_dung_gubun = '4'
				
			elseif ls_dung_gubun = 'I' then
				ls_dung_gubun = '5'
				
			else
				ls_dung_gubun = '1'
				
			end if
			
		elseif sqlca.sqlcode = 100 then
			ls_dung_gubun = '1'
			
		else 
			messagebox("확인","등록구분 확인중 오류발생~r~n" + sqlca.sqlerrtext)
			return
			
		end if		
		
		dw_main.object.dungrok_gwanri_dungrok_gubun[row] = ls_dung_gubun
		
END CHOOSE
end event

