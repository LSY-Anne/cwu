$PBExportHeader$w_hdr107a.srw
$PBExportComments$[청운대]분납예정등록관리
forward
global type w_hdr107a from w_condition_window
end type
type dw_con from uo_dwfree within w_hdr107a
end type
type dw_main from uo_dwfree within w_hdr107a
end type
end forward

global type w_hdr107a from w_condition_window
dw_con dw_con
dw_main dw_main
end type
global w_hdr107a w_hdr107a

on w_hdr107a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hdr107a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;string ls_year, ls_hakgi, ls_gwa, ls_hakbun, ls_hakyun, ls_sangtae, ls_hjmod_date, ls_hname
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun   =  func.of_nvl(dw_con.Object.hakbun[1], '%')

if ls_year = '' or isnull(ls_year) or ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","년도, 학기를 입력하세요.")
	return 1	
end if

SELECT	A.SANGTAE, A.HJMOD_DATE, A.HNAME
INTO  	:ls_sangtae,
			:ls_hjmod_date,
			:ls_hname
FROM		HAKSA.JAEHAK_HAKJUK A
WHERE		A.HAKBUN	= SUBSTR(:ls_hakbun,1,8)
USING SQLCA ;

if ls_sangtae = '03' then
	IF messagebox('확인', ls_hname + "(" + MID(ls_hakbun,1,8) + ") 이 학생은 " + MID(ls_hjmod_date,1,4) + "년" + MID(ls_hjmod_date,5,2) + "월" + MID(ls_hjmod_date,7,2) + "일" + "에 제적한 학생입니다.", Question!, YesNo!, 2) = 2 then
  return 1
	end if
end if
ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;//idw_update[1] = dw_main

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

dw_main.setfocus()

end event

event ue_insert;string 	ls_code
  long	ll_newrow

ll_newrow	= dw_main.InsertRow(0)//	데이타윈도우의 마지막 행에 추가

IF ll_newrow <> -1 THEN
   dw_main.ScrollToRow(ll_newrow)		//	추가된 행에 스크롤
	dw_main.SetItem(ll_newrow, 'bunnap_date', string(f_sysdate(), 'YYYYMMDD'))
	dw_main.setcolumn(1)              	//	추가된 행의 첫번째 컬럼에 커서 위치
	dw_main.setfocus()                	//	dw_main 포커스 이동
END IF

end event

event ue_save;int	 	li_ans,    ii,        l_cnt, li_chasu, li_max_chasu
long		ll_bun_dungrok, ll_dungrok, ll_dr, ll_tot_dungrok, ll_tot_dungrok2, ll_row
String 	ls_year,   ls_hakgi,  ls_hakbun, ls_hakbun_tmp
dwItemStatus l_status, l_status2

dw_main.AcceptText()
dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

//차수 카운트, 등록금 체크
FOR ii = 1 TO dw_main.RowCount()
	l_status = dw_main.GetItemStatus(ii, 0, Primary!)
	
	ls_hakbun   = dw_main.GetItemString(ii, 'hakbun')
	ll_dungrok  = dw_main.GetItemNumber(ii, 'dungrok')
	ll_dr			= dw_main.GetItemNumber(ii, 'dr')
	
	if ll_dungrok = 0 then
		messagebox('저장오류', '분납 등록금을 입력해주세요', exclamation!)
		dw_main.scrolltorow(ii)
		dw_main.setcolumn('dungrok')
		return -1
	end if
	
	if ls_hakbun_tmp <> ls_hakbun then
		//DB에 저장된 차수와 분납 등록금액
		select 	nvl(max(chasu),0), 	nvl(sum(dungrok),0)	
		into 		:li_max_chasu, 		:ll_bun_dungrok
		from 		haksa.bunnap_gwanri
		where		year||hakgi = :ls_year||:ls_hakgi
		and		hakbun 		= :ls_hakbun
		USING SQLCA ;

		li_chasu = 1
		ll_tot_dungrok = 0
	else
		if l_status = New! or l_status = NewModified! then	li_chasu++
		ll_tot_dungrok2 += ll_dungrok
	end if
	
	
	if (ls_hakbun_tmp <> ls_hakbun and ii > 1) or ii = dw_main.rowcount() then
		if ls_hakbun_tmp <> ls_hakbun and ii > 0 then
			ll_row = ii - 1
		elseif ii = dw_main.rowcount() then
			ll_row = ii
		end if
		
		if ll_tot_dungrok2 <> dw_main.GetItemNumber(ll_row, 'dr') then
			messagebox('분납등록금 오류', '학번:'+ls_hakbun_tmp+' 데이타 오류~r~n분할 등록금액의 합계와 납부할 금액이 다릅니다.', exclamation!)
			dw_main.scrolltorow(ll_row)
			dw_main.setcolumn('dungrok')
			return -1
		end if
	end if

	if ls_hakbun_tmp <> ls_hakbun then
		ls_hakbun_tmp = ls_hakbun
		ll_tot_dungrok2 = ll_dungrok
	end if

	//등록금
	if l_status = New! or l_status = NewModified! then
		ll_tot_dungrok += ll_dungrok
		
		if ll_tot_dungrok + ll_bun_dungrok > ll_dr then
			messagebox('분납등록금 오류', string(ii)+'번째 데이타 오류~r~n입력한 등록금액이 납부할 금액보다 큽니다.', exclamation!)
			dw_main.scrolltorow(ii)
			dw_main.setcolumn('dungrok')
			return -1
		end if
	end if
	
	//차수
	if l_status = New! or l_status = NewModified! then
		if li_chasu+li_max_chasu > 3 then
			messagebox('차수오류', string(ii)+'번째 데이타 오류~r~n차수가 3차 이상입니다.', exclamation!)
			dw_main.scrolltorow(ii)
			dw_main.setcolumn('hakbun')
			return -1
		end if
		
		dw_main.setitem(ii, 'chasu', li_chasu+li_max_chasu)
	end if
NEXT


li_ans = dw_main.update()		//	자료의 저장

IF li_ans = -1  THEN
	ROLLBACK USING SQLCA;
	uf_messagebox(3)       	//	저장오류 메세지 출력

ELSE
	COMMIT USING SQLCA;
	uf_messagebox(2)       //	저장확인 메세지 출력
END IF

end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr107a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr107a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr107a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr107a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr107a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr107a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr107a
end type

type uc_insert from w_condition_window`uc_insert within w_hdr107a
end type

type uc_delete from w_condition_window`uc_delete within w_hdr107a
end type

type uc_save from w_condition_window`uc_save within w_hdr107a
end type

type uc_excel from w_condition_window`uc_excel within w_hdr107a
end type

type uc_print from w_condition_window`uc_print within w_hdr107a
end type

type st_line1 from w_condition_window`st_line1 within w_hdr107a
end type

type st_line2 from w_condition_window`st_line2 within w_hdr107a
end type

type st_line3 from w_condition_window`st_line3 within w_hdr107a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr107a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr107a
end type

type gb_1 from w_condition_window`gb_1 within w_hdr107a
end type

type gb_2 from w_condition_window`gb_2 within w_hdr107a
end type

type dw_con from uo_dwfree within w_hdr107a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_hdr107a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gubun'
		
		If data =  '1' Then
			dw_main.reset()
			dw_main.dataobject = 'd_hdr107a'	
			dw_main.settransobject(sqlca)
		Else
			dw_main.reset()
			dw_main.dataobject = 'd_hdr107a_1'	
			dw_main.settransobject(sqlca)
		End If
		
End Choose
end event

type dw_main from uo_dwfree within w_hdr107a
integer x = 55
integer y = 296
integer width = 4379
integer height = 1964
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hdr107a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;string	ls_year, ls_hakgi, ls_hakbun, ls_gwa
integer	ll_chasu
DataStore lds_report

THIS.ACCEPTTEXT()
CHOOSE CASE DWO.NAME
	CASE 'b_1'
				
		ls_year 		= this.object.year[row]
		ls_hakgi 	= this.object.hakgi[row]
		ls_gwa		= this.object.gwa[row]
		ls_hakbun 	= this.object.hakbun[row]
		ll_chasu 	= this.object.chasu[row]
		
		lds_report = Create DataStore    // 메모리에 할당
//		lds_report.DataObject = "d_hdr324p_1"
      lds_report.DataObject = "d_hdr331p_2"
		lds_report.SetTransObject(sqlca)
		
		lds_report.Retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakbun, ll_chasu)
		lds_report.Object.DataWindow.Zoom = 50
		lds_report.Print()
		
		Destroy lds_report
END CHOOSE
end event

event itemchanged;call super::itemchanged;string	ls_year, ls_hakgi, ls_hakbun, ls_hname, ls_hakgwa, ls_gwa
long		ll_ip, ll_dr, ll_cnt, ll_chasu
double   ll_ipk, ll_drk, ll_hsw, ll_gyjae, ll_dcw, ll_mor, ll_album, ll_tot, l_cnt
DataStore lds_report

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

CHOOSE CASE	DWO.NAME
	
	CASE	'hakbun'
		//학번이 입력되면 기본사항을 가져온다.
		
		SELECT	GWA,
					HNAME
		INTO		:ls_hakgwa,
					:ls_hname
		FROM		HAKSA.JAEHAK_HAKJUK
		WHERE	HAKBUN	=	:data
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","잘못된 학번을 입력하였습니다.")
			this.object.hakbun[row]	=	''
			return 1
		end if

      SELECT nvl(count(*), 0)
		  INTO :l_cnt
		  FROM haksa.daichul_gwanri
		 WHERE year      = :ls_year
		   AND hakgi     = :ls_hakgi
			AND hakbun    = :data
		 USING SQLCA ;
		 
      IF sqlca.sqlnrows  = 0 THEN
			l_cnt         = 0
		END IF
		IF l_cnt         > 0 THEN
			messagebox("알림", '학자금 대출 신청자는 분납예정등록을 할 수 없습니다.')
			return
		END IF
		
		SELECT 	SUM(B.IPHAK) IP,
					SUM(B.DUNGROK) DR
		INTO		:ll_ip,
					:ll_dr
		FROM		HAKSA.DUNGROK_GWANRI B
		WHERE		B.YEAR	= :ls_year
		AND		B.HAKGI	= :ls_hakgi
		AND		B.HAKBUN = :data
		USING SQLCA ;
		
		this.object.year[row]		=  ls_year
		this.object.hakgi[row]		=  ls_hakgi
//		this.object.chasu[row]		=	ll_chasu
		this.object.hname[row]		=	ls_hname
		this.object.gwa[row]			=	ls_hakgwa
		this.object.ip[row]			=  ll_ip
		this.object.dr[row]			=  ll_dr
		
	CASE	'iphak', 'dungrok', 'haksengwhe', 'gyojae', 'dongchangwhe', 'memorial', 'album'
		
		this.AcceptText()
		
		ll_ipk		=	this.object.iphak[row]		
		ll_drk		=	this.object.dungrok[row]	
		ll_hsw		=	this.object.haksengwhe[row]	
		ll_gyjae		=	this.object.gyojae[row]	
		ll_dcw		=	this.object.dongchangwhe[row]
		ll_mor		=  this.object.memorial[row]
		ll_album		=  this.object.album[row]
		
		if isnull(ll_ipk) 	then ll_ipk = 0
		if isnull(ll_drk) 	then ll_drk = 0
		if isnull(ll_hsw) 	then ll_hsw = 0
		if isnull(ll_gyjae) 	then ll_gyjae = 0
		if isnull(ll_dcw) 	then ll_dcw = 0
		if isnull(ll_mor) 	then ll_mor = 0
		if isnull(ll_album) 	then ll_album = 0
		ll_tot	= 	ll_ipk +	ll_drk +	ll_hsw + ll_gyjae + ll_dcw	+ ll_mor	+ ll_album
		this.object.bunnap_total[row] = ll_tot
		//학번이 입력되면 기본사항을 가져온다.
END CHOOSE

end event

