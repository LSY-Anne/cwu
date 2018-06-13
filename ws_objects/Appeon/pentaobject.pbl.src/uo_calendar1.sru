$PBExportHeader$uo_calendar1.sru
$PBExportComments$년월라인한줄용
forward
global type uo_calendar1 from userobject
end type
type st_1 from statictext within uo_calendar1
end type
type em_date from editmask within uo_calendar1
end type
type p_next from picture within uo_calendar1
end type
type p_prev from picture within uo_calendar1
end type
type dw_cal from datawindow within uo_calendar1
end type
type p_nextyear from picture within uo_calendar1
end type
type p_prevyear from picture within uo_calendar1
end type
end forward

global type uo_calendar1 from userobject
integer width = 782
integer height = 660
long backcolor = 16777215
long tabtextcolor = 33554432
event ue_doubleclicked ( unsignedlong wparam,  long lparam )
event ue_clicked ( )
event ue_schedule ( )
st_1 st_1
em_date em_date
p_next p_next
p_prev p_prev
dw_cal dw_cal
p_nextyear p_nextyear
p_prevyear p_prevyear
end type
global uo_calendar1 uo_calendar1

type variables
integer	nDay
integer	nMonth
integer	nYear
integer	nDaysInMonth
Integer	nStartCell

integer	i_old_column
integer 	nClickedColumn
integer	i_old_start
integer	i_old_end
integer	ii_start_day_cell
integer	oldTodayCell
string	strDateFormat
date		id_Date_Selected

Boolean  weekday    = false

Protected 	String		stdt
Protected	String		endt
end variables

forward prototypes
public function integer days_in_month (integer month, integer year)
public subroutine enter_day_numbers (integer start_day_num, integer days_in_month)
public function integer get_month_number (string month)
public function string get_month_string (integer month)
public subroutine set_date_format (string date_format)
public subroutine uf_change_day (integer ai_col)
public subroutine draw_month (integer year, integer month)
public function date uf_get_selected_date ()
public subroutine init_cal (date start_date)
public subroutine uf_change_week (integer ai_col)
public subroutine getperioddate (ref string as_stdt, ref string as_endt)
public subroutine uf_scheduleday (integer ai_day[])
public subroutine check_today (integer nfirstdaynum)
end prototypes

public function integer days_in_month (integer month, integer year);//-----------------------------------------------------------------------------
// 목적 : 칼렌더를 위한 함수 
//
// 설명 : 윤달에는 2월이 29 일 까지고, 다른 경우는 28일
// 
// 매개변수 : month
//            year
//
// 반환값 : 
//-----------------------------------------------------------------------------
Int li_DaysInMonth
Boolean bLeapYear

CHOOSE CASE month
	CASE 1, 3, 5, 7, 8, 10, 12
		li_DaysInMonth = 31
	CASE 4, 6, 9, 11
		li_DaysInMonth = 30
	CASE 2
		If Mod(year,100) = 0 then
			bLeapYear = False
		ElseIf Mod(year,4) = 0 then 
			bLeapYear = True
		Else 
			bLeapYear = False
		End If
		If bLeapYear then
			li_DaysInMonth = 29
		Else
			li_DaysInMonth = 28
		End If

END CHOOSE

return li_DaysInMonth

end function

public subroutine enter_day_numbers (integer start_day_num, integer days_in_month);//-----------------------------------------------------------------------------
// 목적 : 달력의 해당 일자 
//
// 설명 : 달력의 해당 일자
// 
// 매개변수 : month
//            year
//
// 반환값 : 
//-----------------------------------------------------------------------------
Int nCount, nDayCount
string	strmodify, strReturn
Long  ll_color

//-----------------------------------------------------------------------------
// Blank the columns before the first day of the month
//-----------------------------------------------------------------------------
ii_start_day_cell = start_day_num

For nCount = 1 to start_day_num
	dw_cal.SetItem(1,nCount,"")
Next

//-----------------------------------------------------------------------------
// Set the columns for the days to the String of their Day number
//-----------------------------------------------------------------------------
For nCount = 1 to days_in_month
	nDayCount = start_day_num + nCount - 1
	dw_cal.SetItem(1,nDayCount,String(nCount))
Next

//-----------------------------------------------------------------------------
// 다음 컬럼으로 이동
//-----------------------------------------------------------------------------
nDayCount = nDayCount + 1

//-----------------------------------------------------------------------------
// Blank remainder of columns
//-----------------------------------------------------------------------------
For nCount = nDayCount to 42
	dw_cal.SetItem(1,nCount,"")
Next

/*
If i_old_column <> 0 then
	strModify = "#" + string(i_old_Column) + ".background.color='8421504'"
	strReturn = Modify(dw_cal,strModify)
	If strReturn <> "" then MessageBox("Error",strReturn)
   ll_color = RGB(103,103,101)
   strModify = "#" + string(i_old_column) + ".font.weight='400'"
   strModify = strModify + " " + "#" + string(i_old_column) + ".color='"+String(ll_color)+"'"

   ll_color = rgb(243,250,255)
   strModify = strModify + " " + "r"+string(i_old_column) + ".brush.color='"+String(ll_color)+"'"
	strReturn = dw_cal.Modify(strModify)
   IF (strReturn <> "") THEN
		MessageBox("Error",strReturn+':'+strModify)
	END IF
End If
*/

//i_old_column = 0


end subroutine

public function integer get_month_number (string month);//-----------------------------------------------------------------------------
// 목적 : 달력의 해당 월 
//
// 설명 : 달력의 해당 원
// 
// 매개변수 : month
//
// 반환값 : 
//-----------------------------------------------------------------------------
Int month_number

CHOOSE CASE month
	CASE "Jan"
		month_number = 1
	CASE "Feb"
		month_number = 2
	CASE "Mar"
		month_number = 3
	CASE "Apr"
		month_number = 4
	CASE "May"
		month_number = 5
	CASE "Jun"
		month_number = 6
	CASE "Jul"
		month_number = 7
	CASE "Aug"
		month_number = 8
	CASE "Sep"
		month_number = 9
	CASE "Oct"
		month_number = 10
	CASE "Nov"
		month_number = 11
	CASE "Dec"
		month_number = 12
END CHOOSE

return month_number
end function

public function string get_month_string (integer month);//-----------------------------------------------------------------------------
// 목적 : 달력의 해당 월 명칭 
//
// 설명 : 달력의 해당 월 명칭
// 
// 매개변수 : month
//
// 반환값 : 
//-----------------------------------------------------------------------------
String strMonth

CHOOSE CASE month
	CASE 1
		strMonth = "1월"
	CASE 2
		strMonth = "2월"
	CASE 3
		strMonth = "3월"
	CASE 4
		strMonth = "4월"
	CASE 5
		strMonth = "5월"
	CASE 6
		strMonth = "6월"
	CASE 7
		strMonth = "7월"
	CASE 8
		strMonth = "8월"
	CASE 9
		strMonth = "9월"
	CASE 10
		strMonth = "10월"
	CASE 11
		strMonth = "11월"
	CASE 12
		strMonth = "12월"
END CHOOSE

return strMonth

end function

public subroutine set_date_format (string date_format);
strDateFormat = date_format
end subroutine

public subroutine uf_change_day (integer ai_col);//-----------------------------------------------------------------------------
// 목적 : 일자변경 
//
// 설명 : 일자변경
// 
// 매개변수 : ai_col
//
// 반환값 : 
//-----------------------------------------------------------------------------
int    nLength
string strOld, strOldNum, strDay, strModify, strReturn
Long   ll_color 

IF (ai_col = 0) THEN RETURN

strDay = dw_cal.GetItemString(1, ai_col)

IF (strDay = "") THEN RETURN

dw_cal.SetReDraw(False)
//-----------------------------------------------------------------------------
// Convert to a number and place in Instance variable
//-----------------------------------------------------------------------------
nDay = Integer(strDay)

dw_cal.SetItem(1, ai_col, strDay)

//-----------------------------------------------------------------------------
// Highlight chosen day
//-----------------------------------------------------------------------------
ll_color = rgb(255,255,255)
//strModify = "#" + string(ai_col) + ".font.weight='700'"
//strModify = strModify + " " + "#" + string(ai_col) + ".color='"+String(ll_color)+"'"

//ll_color = rgb(255,99,0)
ll_color = RGB(255,196,104)
strModify = strModify + " " + "r"+string(ai_col) + ".brush.color='"+String(ll_color)+"'"
strReturn = dw_cal.Modify(strModify)

If (strReturn <> "") THEN
	MessageBox("Error", strReturn+':'+strModify)
END IF

//-----------------------------------------------------------------------------
// previous column (i_old_column = 0)이 highlight 되면
// set the border of the old column back to normal
//-----------------------------------------------------------------------------

IF (i_old_column <> 0) AND (i_old_column <> ai_col) THEN
   ll_color = RGB(103,103,101)
//   strModify = "#" + string(i_old_column) + ".font.weight='400'"
//   strModify = strModify + " " + "#" + string(i_old_column) + ".color='"+String(ll_color)+"'"

   ll_color = rgb(243,250,255)
   strModify = strModify + " " + "r"+string(i_old_column) + ".brush.color='"+String(ll_color)+"'"
	strReturn = dw_cal.Modify(strModify)
   IF (strReturn <> "") THEN
		MessageBox("Error",strReturn+':'+strModify)
	END IF
END IF

dw_cal.SetReDraw(True)

//-----------------------------------------------------------------------------
//Set the old column for next time
//-----------------------------------------------------------------------------
i_old_column = ai_col
nclickedcolumn = ai_col

//-----------------------------------------------------------------------------
//Return the chosen date into the SingleLineEdit in the chosen format
//-----------------------------------------------------------------------------
em_date.text = String(Date(nYear, nMonth, nDay), strDateFormat)
id_Date_Selected = Date(nYear, nMonth, nDay)


//check_today(nStartCell)

end subroutine

public subroutine draw_month (integer year, integer month);//-----------------------------------------------------------------------------
// 목적 : 달력의 해당 월을 확인 
//
// 설명 : 달력의 해당월
// 
// 매개변수 : month
//            year
//
// 반환값 : 
//-----------------------------------------------------------------------------
Int nFirstDayNum, nCell, li_DaysInMonth
Date dFirstDay
String strYear, strMonth, strModify, strReturn
Long ll_color

SetPointer(Hourglass!)
dw_cal.SetRedraw(FALSE)

//-----------------------------------------------------------------------------
// Set Instance variables to arguments
//-----------------------------------------------------------------------------
nMonth = month
nYear = year

//-----------------------------------------------------------------------------
// 해달 월의 일자 수
//-----------------------------------------------------------------------------
li_DaysInMonth = days_in_month(nMonth,nYear)

//-----------------------------------------------------------------------------
// 그 달의 첫번째 일자를 확인
//-----------------------------------------------------------------------------
dFirstDay = Date(nYear,nMonth,1)

//-----------------------------------------------------------------------------
// Find what day of the week this is
//-----------------------------------------------------------------------------
nFirstDayNum = DayNumber(dFirstDay)

//-----------------------------------------------------------------------------
// Set the first cell
//-----------------------------------------------------------------------------
nCell = nFirstDayNum + nDay - 1

//-----------------------------------------------------------------------------
// If there was an old column turn off the highlight
//-----------------------------------------------------------------------------
//If i_old_column <> 0 then
////	strModify = "#" + string(i_old_Column) + ".background.color='8421504'"
////	strReturn = Modify(dw_cal,strModify)
//   ll_color = RGB(103,103,101)
//   strModify = "#" + string(i_old_column) + ".font.weight='400'"
//   strModify = strModify + " " + "#" + string(i_old_column) + ".color='"+String(ll_color)+"'"
//
//   ll_color = rgb(243,250,255)
//   strModify = strModify + " " + "r"+string(i_old_column) + ".brush.color='"+String(ll_color)+"'"
//	strReturn = dw_cal.Modify(strModify)
//   IF (strReturn <> "") THEN
//		MessageBox("Error",strReturn+':'+strModify)
//	END IF
//End If

//-----------------------------------------------------------------------------
// 타이틀
//-----------------------------------------------------------------------------
strMonth = String(nMonth, '00') + '월' //get_month_string(nMonth) 
strYear  = string(nYear) + '년'
dw_cal.Modify("st_month.text=~"" + strMonth + "~"")
dw_cal.Modify("st_year.text=~"" + strYear + "~"")

//-----------------------------------------------------------------------------
// 데이타윈도우에 일자의 수를 Enter 
//-----------------------------------------------------------------------------
enter_day_numbers(nFirstDayNum,li_DaysInMonth)

dw_cal.SetItem(1,nCell,String(nDay))

//-----------------------------------------------------------------------------
// 현재 일자를 밝게
//-----------------------------------------------------------------------------
//strModify = "#" + string(nCell) + ".background.color='255'"
//strReturn = Modify(dw_cal,strModify)
//ll_color = rgb(255,255,255)
//strModify = "#" + string(nCell) + ".font.weight='700'"
//strModify = strModify + " " + "#" + string(nCell) + ".color='"+String(ll_color)+"'"
//
//ll_color = rgb(255,99,0)
//strModify = strModify + " " + "r"+string(nCell) + ".brush.color='"+String(ll_color)+"'"
//strReturn = dw_cal.Modify(strModify)
//If (strReturn <> "") THEN
//	MessageBox("Error", strReturn+':'+strModify)
//END IF

//-----------------------------------------------------------------------------
// Set the old column for next time
//-----------------------------------------------------------------------------
//i_old_column = nCell
//nclickedcolumn = nCell

//-----------------------------------------------------------------------------
// Reset the pointer and Redraw
//-----------------------------------------------------------------------------
SetPointer(Arrow!)
dw_cal.SetRedraw(TRUE)

end subroutine

public function date uf_get_selected_date ();return id_date_selected
end function

public subroutine init_cal (date start_date);//-----------------------------------------------------------------------------
// 목적 : 달력의 초기화 
//
// 설명 : 달력의 초기화
// 
// 매개변수 : ai_col
//
// 반환값 : 
//-----------------------------------------------------------------------------
Int nFirstDayNum, nCell, today_Cell
String strYear, strMonth, strModify, strReturn, str_today
Date dFirstDay
Long  ll_color, ll_today_color

//-----------------------------------------------------------------------------
// Insert a row into the script datawindow
//-----------------------------------------------------------------------------
IF (dw_cal.RowCount() < 1) THEN dw_cal.InsertRow(0)

//-----------------------------------------------------------------------------
//Set the variables for Day, Month and Year from the date passed to
//the function
//-----------------------------------------------------------------------------
nMonth = Month(start_date)
nYear = Year(start_date)
nDay = Day(start_date)

//-----------------------------------------------------------------------------
//Find how many days in the relevant month
//-----------------------------------------------------------------------------
nDaysInMonth = days_in_month(nMonth, nYear)

//-----------------------------------------------------------------------------
//Find the date of the first day of this month
//-----------------------------------------------------------------------------
dFirstDay = Date(nYear, nMonth, 1)

//-----------------------------------------------------------------------------
//What day of the week is the first day of the month
//-----------------------------------------------------------------------------
nFirstDayNum = DayNumber(dFirstDay)

nStartCell = nFirstdayNum
//-----------------------------------------------------------------------------
//Set the starting "cell" in the datawindow. i.e the column in which
//the first day of the month will be displayed
//-----------------------------------------------------------------------------

nCell = nFirstDayNum + nDay - 1
nclickedcolumn = nCell
 
//-----------------------------------------------------------------------------
//Set the Title of the calendar with the Month and Year
//-----------------------------------------------------------------------------
//strMonth = get_month_string(nMonth) 
//strYear =  string(nYear)
strMonth = String(nMonth, '00') + '월'
strYear  = string(nYear) + '년'
dw_cal.Modify("st_month.text=~"" + strMonth + "~"")
dw_cal.Modify("st_year.text=~"" + strYear + "~"")

//-----------------------------------------------------------------------------
//Enter the numbers of the days
//-----------------------------------------------------------------------------
enter_day_numbers(nFirstDayNum, nDaysInMonth)

dw_cal.SetItem(1, nCell, String(Day(start_date)))

//-----------------------------------------------------------------------------
//Display the first day in bold (or 3D)
//strModify = "#" + string(nCell) + ".font.weight=~"700~""
//-----------------------------------------------------------------------------
//strModify = "#" + string(nCell) + ".background.color='255'"
//strReturn = Modify(dw_cal,strModify)
//If strReturn <> "" then MessageBox("Error",strReturn)
//ll_color = rgb(255,255,255)
//strModify = "#" + string(nCell) + ".font.weight='700'"
//strModify = strModify + " " + "#" + string(nCell) + ".color='"+String(ll_color)+"'"
//
//ll_color = rgb(255,99,0)
//strModify = strModify + " " + "r"+string(nCell) + ".brush.color='"+String(ll_color)+"'"
//strReturn = dw_cal.Modify(strModify)
//
//
//If (strReturn <> "") THEN
//	MessageBox("Error", strReturn+':'+strModify)
//END IF

IF weekday THEN
	uf_change_week(nCell)
ELSE
	uf_change_day(nCell)
END IF


check_today(nFirstDayNum)
//-----------------------------------------------------------------------------
//Set the instance variable i_old_column to hold the current cell, so
//when we change it, we know the old setting
//-----------------------------------------------------------------------------
i_old_column = nCell

em_date.text = String(Date(nYear, nMonth, nDay), strDateFormat)
id_date_selected = Date(nYear,nMonth, nDay)

//This.Event ue_schedule()

end subroutine

public subroutine uf_change_week (integer ai_col);//-----------------------------------------------------------------------------
// 목적 : 주변경 
//
// 설명 : 주변경
// 
// 매개변수 : ai_col
//
// 반환값 : 
//-----------------------------------------------------------------------------
int    nLength, li_DaysInMonth
string strOld, strOldNum, strDay, strModify, strReturn
Long   ll_color
Integer	li_start, li_end, i

li_start = (7 * Truncate( (ai_col -1) / 7, 0)) + 2

li_end = (7 * Truncate( (ai_col - 1) / 7, 0 )) + 8


IF (ai_col = 0) THEN RETURN

strDay = dw_cal.GetItemString(1, ai_col)

IF (strDay = "") THEN RETURN

dw_cal.SetReDraw(False)
//-----------------------------------------------------------------------------
// Convert to a number and place in Instance variable
//-----------------------------------------------------------------------------
nDay = Integer(strDay)

dw_cal.SetItem(1, ai_col, strDay)

//-----------------------------------------------------------------------------
// Highlight chosen day
//-----------------------------------------------------------------------------
IF li_start < 1 THEN li_start = 1
IF li_end > 42 THEN	li_end = 42

strModify = ''

FOR i = li_start TO li_end
	strModify += "#" + string(i) + ".font.weight='700' "
	
	ll_color = RGB(255,196,104)
	strModify += "r"+string(i) + ".brush.color='"+String(ll_color)+"' "
NEXT

strReturn = dw_cal.Modify(strModify)

If (strReturn <> "") THEN
	MessageBox("Error", strReturn+':'+strModify)
END IF


//-----------------------------------------------------------------------------
// previous column (i_old_column = 0)이 highlight 되면
// set the border of the old column back to normal
//-----------------------------------------------------------------------------

strModify = ''

IF (i_old_start <> 0) AND (i_old_start <> li_start) THEN
	FOR i = i_old_start TO i_old_end
		strModify += "#" + string(i) + ".font.weight='400' "
		
		ll_color   = rgb(243,250,255)
		strModify += "r"+string(i) + ".brush.color='"+String(ll_color)+"' "
	NEXT

	strReturn = dw_cal.Modify(strModify)
	IF (strReturn <> "") THEN
		MessageBox("Error",strReturn+':'+strModify)
	END IF

END IF
strModify = ''

dw_cal.SetReDraw(True)

//-----------------------------------------------------------------------------
//Set the old column for next time
//-----------------------------------------------------------------------------
//i_old_column = ai_col
i_old_start	= li_start
i_old_end	= li_end
nclickedcolumn = ai_col

//-----------------------------------------------------------------------------
//Return the chosen date into the SingleLineEdit in the chosen format
//-----------------------------------------------------------------------------
em_date.text = String(Date(nYear, nMonth, nDay), strDateFormat)
//id_Date_Selected = Date(nYear, nMonth, nDay)

String ls_st, ls_et
ls_st = dw_cal.getItemString(1, li_start)
ls_et = dw_cal.getItemString(1, li_end)

stdt = String(Date(nyear, nmonth, Integer(ls_st)), strDateFormat)
endt = String(Date(nyear, nmonth, Integer(ls_et)), strDateFormat)		


Integer	li_year, li_month

IF ls_st = '' OR IsNull(ls_st) THEN 
		IF nMonth = 1 THEN 
		li_month = 12
		li_year = nYear -1
	ELSE
		li_month = nMonth - 1
		li_year = nYear
	END IF

	li_DaysInMonth = days_in_month(li_month,li_year)

	ls_st = String(li_DaysInMonth - (7 - Integer(ls_et)) + 1)
	stdt = String(Date(li_year, li_month, Integer(ls_st)), strDateFormat)
END IF

IF ls_et = '' OR IsNull(ls_et) THEN 
	li_DaysInMonth = days_in_month(nMonth,nYear)
	ls_et = String(7 - (li_daysinmonth - Integer(ls_st) + 1))
	
	IF nMonth + 1 > 12 THEN 
		li_month = 1
		li_year = nYear + 1
	ELSE
		li_month = nMonth + 1
		li_year = nYear
	END IF
	endt = String(Date(li_year, li_month, Integer(ls_et )), strDateFormat)		
END IF

end subroutine

public subroutine getperioddate (ref string as_stdt, ref string as_endt);as_stdt = stdt
as_endt = endt
end subroutine

public subroutine uf_scheduleday (integer ai_day[]);//-----------------------------------------------------------------------------
// 목적 : 주변경 
//
// 설명 : 주변경
// 
// 매개변수 : ai_col
//
// 반환값 : 
//-----------------------------------------------------------------------------
Integer	li_cnt, li_start, i
String	strModify, strReturn

strModify = ''
FOR i = 1 TO 42
		strModify += "#" + string(i) + ".font.weight='400' "
NEXT

strReturn = dw_cal.Modify(strModify)

If (strReturn <> "") THEN
	MessageBox("Error", strReturn+':'+strModify)
END IF

strModify = ''

li_cnt = UpperBound(ai_day)

FOR i = 1 TO li_cnt
	strModify += "#" + string(ii_start_day_cell + ai_day[i] - 1) + ".font.weight='700' "
NEXT

strReturn = dw_cal.Modify(strModify)

If (strReturn <> "") THEN
	MessageBox("Error", strReturn+':'+strModify)
END IF


//-----------------------------------------------------------------------------
// previous column (i_old_column = 0)이 highlight 되면
// set the border of the old column back to normal
//-----------------------------------------------------------------------------

end subroutine

public subroutine check_today (integer nfirstdaynum);integer		today_cell
Long			ll_color
String		strmodify, strreturn
String 		ls_tmonth, ls_day

ls_tmonth 	= String(today(), 'yyyymm')
ls_day  		= String(today(), 'dd')

//오늘날짜 셋팅 
IF String(nYear) + String(nMonth, '00') = ls_tmonth THEN
	today_Cell = nFirstDayNum + Integer(ls_day) - 1
	
	IF oldtodayCell > 0 THEN
		ll_color = RGB(103,103,101)
		strModify = strModify + " " + "#"+string(oldTodayCell) + ".color='"+String(ll_color)+"'"
		strReturn = dw_cal.Modify(strModify)
		
		If (strReturn <> "") THEN
			MessageBox("Error", strReturn+':'+strModify)
		END IF
	END IF
	
	ll_color = rgb(255,100,100)
	strModify = strModify + " " + "#"+string(today_Cell) + ".color='"+String(ll_color)+"'"
	strReturn = dw_cal.Modify(strModify)
	
	If (strReturn <> "") THEN
		MessageBox("Error", strReturn+':'+strModify)
	END IF
	
	oldTodayCell = today_Cell
ELSE
	IF oldTodayCell > 0 THEN
		ll_color = RGB(103,103,101)
		strModify = strModify + " " + "#"+string(oldTodayCell) + ".color='"+String(ll_color)+"'"
		strReturn = dw_cal.Modify(strModify)
		
		If (strReturn <> "") THEN
			MessageBox("Error", strReturn+':'+strModify)
		END IF
	END IF
END IF
end subroutine

on uo_calendar1.create
this.st_1=create st_1
this.em_date=create em_date
this.p_next=create p_next
this.p_prev=create p_prev
this.dw_cal=create dw_cal
this.p_nextyear=create p_nextyear
this.p_prevyear=create p_prevyear
this.Control[]={this.st_1,&
this.em_date,&
this.p_next,&
this.p_prev,&
this.dw_cal,&
this.p_nextyear,&
this.p_prevyear}
end on

on uo_calendar1.destroy
destroy(this.st_1)
destroy(this.em_date)
destroy(this.p_next)
destroy(this.p_prev)
destroy(this.dw_cal)
destroy(this.p_nextyear)
destroy(this.p_prevyear)
end on

type st_1 from statictext within uo_calendar1
string tag = "E.Text=Date;K.Text=일자;"
integer x = 146
integer y = 576
integer width = 206
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "오늘"
boolean focusrectangle = false
end type

type em_date from editmask within uo_calendar1
integer x = 261
integer y = 576
integer width = 352
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean border = false
alignment alignment = center!
integer accelerator = 100
maskdatatype maskdatatype = datemask!
string mask = "yyyy.mm.dd"
string displaydata = ""
end type

event modified;//-----------------------------------------------------------------------------
// 일자 포맷
//-----------------------------------------------------------------------------
date ld_date

ld_date = Date( em_date.Text )

//-----------------------------------------------------------------------------
// 일자가 정확하지 않을 경우
//-----------------------------------------------------------------------------

IF ld_date = Date("1900-01-01") THEN
	ld_date = Date(integer(right( em_date.text ,4)), integer(left (em_date.text,2)) , 1)	
END IF

id_date_selected = ld_date
init_cal(ld_date)
end event

type p_next from picture within uo_calendar1
integer x = 603
integer y = 24
integer width = 59
integer height = 52
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "..\img\icon\cal_02.gif"
end type

event clicked;int DayInMonth

//-----------------------------------------------------------------------------
//달을 증가시킨다.
//13이면, 1로 다시 되돌린다.(1월달)
//-----------------------------------------------------------------------------

nMonth = nMonth + 1
If nMonth = 13 then
	nMonth = 1
	nYear = nYear + 1
End If

DayInMonth = days_in_month (nMonth,nYear)
IF (nDay > DayInMonth) THEN
	nDay = DayInMonth
END IF

nDaysInMonth = DayInMonth

//-----------------------------------------------------------------------------
//달을 적는다.
//-----------------------------------------------------------------------------

draw_month (nYear, nMonth)

em_date.text = String( Date(nYear,nMonth,nDay), strDateFormat )
id_date_selected = Date(String(nYear, '0000') + "/" + String(nMonth, '00') + "/" + String(nDay, '00'))

init_cal(id_date_selected)
Parent.Event ue_schedule()
Parent.PostEvent( "ue_clicked" )
end event

type p_prev from picture within uo_calendar1
integer x = 119
integer y = 24
integer width = 59
integer height = 52
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "..\img\icon\cal_01.gif"
end type

event clicked;
int  DayInMonth

//-----------------------------------------------------------------------------
//달을 감소시킨다.
//값이 0이면, 12을 return
//-----------------------------------------------------------------------------

nMonth = nMonth - 1
If nMonth = 0 then
	nMonth = 12
	nYear = nYear - 1
End If

DayInMonth = days_in_month (nMonth,nYear)
IF (nDay > DayInMonth) THEN
	nDay = DayInMonth
END IF

nDaysInMonth = DayInMonth

//-----------------------------------------------------------------------------
//달을 적는다
//-----------------------------------------------------------------------------
draw_month ( nYear, nMonth )

em_date.text = String( Date(nYear,nMonth,nDay), strDateFormat )
id_date_selected = Date(String(nYear, '0000') + "/" + String(nMonth, '00') + "/" + String(nDay, '00'))

init_cal(id_date_selected)

Parent.Event ue_schedule()
Parent.PostEvent( "ue_clicked" )
end event

type dw_cal from datawindow within uo_calendar1
event ue_keydown pbm_dwnkey
integer width = 782
integer height = 572
integer taborder = 20
string dataobject = "d_calendar_ym"
boolean border = false
end type

event ue_keydown;date  l_date

IF	Not weekday THEN
	CHOOSE CASE (True)
		CASE (KeyDown(keyControl!) AND KeyDown(keyPageDown!)) 
			p_nextyear.TriggerEvent (clicked!)
	
		CASE (KeyDown(keyControl!) AND KeyDown(keyPageUp!)) 
			p_prevyear.TriggerEvent (clicked!)
	
		CASE (KeyDown(keyPageDown!)) 
			p_next.TriggerEvent (clicked!)
	
		CASE (KeyDown(keyPageUp!)) 
			p_prev.TriggerEvent (clicked!)
	
		CASE (KeyDown(keyLeftArrow!)) 
			IF (nDay = 1) THEN
				nmonth = nmonth - 1
				If nMonth = 0 then
					nMonth = 12
					nYear = nYear - 1
					End If
				nday = days_in_month (nmonth,nyear)			 
				init_cal (date(nYear,nMonth,nDay))
			ELSE
				uf_change_day (nclickedcolumn - 1)
			END IF
	
		CASE (KeyDown(keyRightArrow!))  
			IF (nDay = nDaysInMonth) THEN 
				nmonth = nmonth + 1
				If nMonth = 13 then
					nMonth = 1
					nYear = nYear + 1
					End If
				nday = 1
				init_cal (date(nYear,nMonth,nDay))
			ELSE
				uf_change_day (nclickedcolumn + 1)
			END IF
	
		CASE	(KeyDown(keyUpArrow!)) 
			IF (nclickedcolumn - 7) > 0 THEN
				uf_change_day(nclickedcolumn - 7)
			END IF
	
		CASE (KeyDown(keyDownArrow!))
			IF ((nDay + 7) <= nDaysInMonth) THEN
				uf_change_day(nclickedcolumn + 7)
			END IF
	END CHOOSE
END IF
end event

event clicked;if dwo.name = 'datawindow' then return
if row = 0 then return
if Mid(dwo.name,1,4) = 'cell' THEN
	IF This.GetObjectAtPointer() <> "" THEN 
		IF weekday THEN
			
			uf_change_week(Integer(dwo.id))
		ELSE
			uf_change_day(Integer(dwo.id))
		END IF
	END IF
	Parent.Post Event ue_clicked()
END IF


end event

event doubleclicked;
IF  row = 0 then Return

Parent.TriggerEvent("ue_doubleclicked")


end event

type p_nextyear from picture within uo_calendar1
boolean visible = false
integer x = 407
integer y = 16
integer width = 59
integer height = 52
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "..\img\icon\cal_02.gif"
end type

event clicked;
nYear = nYear + 1

//-----------------------------------------------------------------------------
//달을 적는다
//-----------------------------------------------------------------------------

draw_month (nYear, nMonth)

em_date.text = String( Date(nYear,nMonth,nDay), strDateFormat )
id_date_selected = Date(String(nYear, '0000') + "/" + String(nMonth, '00') + "/" + String(nDay, '00'))

init_cal(id_date_selected)

Parent.Event ue_schedule()
Parent.PostEvent( "ue_clicked" )
end event

type p_prevyear from picture within uo_calendar1
boolean visible = false
integer x = 142
integer y = 24
integer width = 59
integer height = 52
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "..\img\icon\cal_01.gif"
end type

event clicked;
int  DayInMonth

nYear =  nYear -1

//-----------------------------------------------------------------------------
//달을 적는다
//-----------------------------------------------------------------------------

draw_month ( nYear, nMonth )

em_date.text 		= String( Date(nYear,nMonth,nDay), strDateFormat )
id_date_selected 	= Date(String(nYear, '0000') + "/" + String(nMonth, '00') + "/" + String(nDay, '00'))

init_cal(id_date_selected)

Parent.Event ue_schedule()
Parent.PostEvent( "ue_clicked" )
end event

