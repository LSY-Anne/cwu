$PBExportHeader$n_func.sru
$PBExportComments$Global Function
forward
global type n_func from nonvisualobject
end type
end forward

global type n_func from nonvisualobject
event ue_constructor ( )
end type
global n_func n_func

type variables
Datastore ids


end variables

forward prototypes
public function string of_nvl (string str1, string str2)
public function string of_get_token (ref string source, string separator)
public function boolean of_check_day (string sdate, string sformat)
public function datetime of_get_datetime ()
public function string of_get_sdate (readonly string as_format)
public function boolean of_reg_no_check (string arg_reg_no)
public function boolean or_reg_no_law_check (string arg_reg_no)
public function integer of_setvalue (ref datawindow ad_dw, long ai_row, string as_colname, any aa_value, string as_mode)
public function dwitemstatus of_getrowstatus (ref datawindow ad_dw, long row)
public function integer of_setsysdate (ref datawindow ad_dw, long ai_row, string as_colname, string as_mode)
public function string of_getcoltype (datawindow ad_dw, string as_column)
public function any of_getitem (ref datawindow ad_dw, long ai_row, string as_column, dwbuffer adwbuffer, boolean ab_ori)
public function any of_getitem (ref datawindow ad_dw, long ai_row, string as_column)
public function integer of_checknull (ref datawindow ad_dw)
public function string of_replace (string str, string fstr, string tstr)
public subroutine of_design_dw (ref datawindow adw)
public function integer of_setsysdate (ref datastore ads_dw, integer ai_row, string as_colname, string as_mode)
public function integer of_setvalue (ref datastore ads_dw, long ai_row, string as_colname, any aa_value, string as_mode)
public function string of_getcoltype (ref datastore ads_dw, string as_column)
public function integer of_dddw (ref datawindow ad_dw, vector avc_data)
public function integer of_checknull (ref datawindow ad_dw, vector avc_data)
public function integer of_dddw (ref datawindow ad_dw, vector avc_data, long al_width)
public function integer of_dddw (ref datawindow ad_dw, vector avc_data, boolean arg_all_yn, boolean arg_null_yn)
public subroutine of_set_pb (ref powerobject a_po, ref long al_x, long al_y)
public subroutine of_resetarray (ref any aa_arr[])
public subroutine of_resetarray (ref long al_arr[])
public subroutine of_resetarray (ref string as_arr[])
public function string of_date_add (string arg_date, integer arg_add_day)
public function long of_day_diff_comp (string arg_date1, string arg_date2)
public function long of_mon_diff_comp (string arg_new_day, string arg_old_day)
public function string of_month_add (string arg_date, integer arg_add_month)
public function string of_week_day_add (string arg_week_day, integer arg_add_day)
public function boolean of_time_valid (string as_time, string as_name)
public function boolean of_time_valid_nomsg (string as_time)
public function string of_ym_end (string arg_ym)
public function string of_inq_str_set (string arg_str)
public subroutine of_setfocus (datawindow dw, integer row, string column)
public subroutine of_protect (ref datawindow arg_dw, string arg_column, string arg_cond)
public subroutine of_resetarray (ref datawindow arg_dw[])
public subroutine of_essential (ref datawindow arg_dw, string arg_column, string arg_cond)
public function long of_nvl (long as_num1, long as_num2)
public function boolean of_reg_no_check2 (string arg_reg_no)
public subroutine of_resetarray (ref datastore arg_ds[])
public subroutine of_design_con (ref datawindow adw)
public function integer of_get_addr (string as_zipcode, ref string as_zipaddr)
end prototypes

event ue_constructor();// 공통코드 list retrieve
IF not isValid(ids) THEN ids = CREATE Datastore
ids.dataobject = "d_dddw_code"
ids.SetTransObject(sqlca)
ids.Retrieve()

end event

public function string of_nvl (string str1, string str2);//str1이 NULL혹은 "" 일 경우 str2로 변경
IF IsNull(String(str1)) or Trim(string(str1)) = '' THEN
	RETURN str2
ELSE
	RETURN str1
END IF
end function

public function string of_get_token (ref string source, string separator);//문자열 tokenize (source는 분리된 나머지 데이터만 가지고 있음) 
Integer	P
String 	Ret

P = Pos(Source, Separator)                 

If P = 0 Then                               
	Ret = Source                              
	Source = ""                               
Else
	Ret = Mid(Source, 1, P - 1)               
	Source = Right(Source, Len(Source) - p - Len(separator) + 1 ) 
End If                                      
Return Ret
end function

public function boolean of_check_day (string sdate, string sformat);// 문자형 날짜 체크 ( 날짜, format )
If IsNull(sDate) Then
	Return True
End If
If Trim(sDate) = '' Then
	Return True
End If
IF NOT IsNumber(sDate) Then
	RETURN FALSE
END IF

Choose Case Upper(sformat)
	Case 'YYYY', 'Y'
		IF Len(sDate) = 4 AND IsDate(STRING(sdate+"0101","@@@@.@@.@@")) Then
			RETURN TRUE
		ELSE
			RETURN FALSE
		END IF
	Case 'YYYYMM', 'YM', 'YYYY/MM'
		IF Len(sDate) = 6 AND IsDate(STRING(sdate+"01","@@@@.@@.@@")) Then
			RETURN TRUE
		ELSE
			RETURN FALSE
		END IF
	Case 'YMD', 'YYYYMMDD', 'YYYY/MM/DD'
		IF Len(sDate) = 8 AND IsDate(STRING(sdate,"@@@@.@@.@@")) Then
			RETURN TRUE
		ELSE
			RETURN FALSE
		END IF
	CASE ''
		IF Len(sDate) = 8 AND &
				(IsDate(STRING(sdate,"@@@@.@@.@@")) OR of_nvl(Trim(sDate), '') = '') Then
			RETURN TRUE
		ELSE
			RETURN FALSE
		END IF		
END Choose

end function

public function datetime of_get_datetime ();DateTime	ldt_GetDate                                    
Integer		li_err_code
String			ls_err_text
/*----------------------------------------------------------------------------*/
/* System Date를 Select.                                                             */
/*----------------------------------------------------------------------------*/
SELECT	SYSDATE                                         
INTO		:ldt_GetDate                                    
FROM		Dual                                          
USING	SQLCA ;
If SQLCA.SQLCODE <> 0 Then
	li_err_code	= SQLCA.SQLDBCode
	ls_err_text	= SQLCA.SQLErrText
	gf_sqlerr_msg('UserObject ' + THIS.Classname(), 'Function of_get_datetime', String(7), 'SELECT DUAL', li_err_code, ls_err_text)
End If

Return ldt_GetDate

end function

public function string of_get_sdate (readonly string as_format);DateTime	ldt_GetDate                                       
Integer		li_err_code
String			ls_err_text

SELECT	SYSDATE                                         
INTO		:ldt_GetDate                                    
FROM		Dual                                          
USING	SQLCA ;
If SQLCA.SQLCODE <> 0 Then
	li_err_code	= SQLCA.SQLDBCode
	ls_err_text	= SQLCA.SQLErrText
	gf_sqlerr_msg('UserObject ' + THIS.Classname(), 'Function of_get_datetime', String(5), 'SELECT DUAL', li_err_code, ls_err_text)
End If

/*----------------------------------------------------------------------------*/
/* Date형식 존재여부 확인.                                                    */
/*----------------------------------------------------------------------------*/
CHOOSE CASE LOWER(as_format)
       CASE "yyyy", "yyyymm", "yyyy.mm", "yyyy/mm", "yyyymmdd", "yyyy.mm.dd", &
            "yyyy/mm/dd", "yyyy.mm.dd hh:mm:ss", "yyyy/mm/dd hh:mm:ss",       &
            "hh:mm:ss", "yyyymmddhhmmss","hhmmss"
            Return String(ldt_GetDate, as_format)
       /*---------------------------------------------------------------------*/
       /* 지정한 Date형식이 존재하지 않은 경우. format 없이 날짜만 return */
       /*---------------------------------------------------------------------*/
       CASE ELSE
            Return String(ldt_GetDate, 'YYYYMMDD' )
END    CHOOSE

end function

public function boolean of_reg_no_check (string arg_reg_no);/*-------------------------------------------------------------------------------------------*/
/* Function  : gf_reg_no_check                                                                        */
/* 내    용  : 사업자, 주민등록번호 오류여부 Check                                    */
/* Scope     : public                                                                                         */
/* Arguments : String arg_reg_no                                                                     */
/* Returns   : 사업자등록번호 -> Boolean ( True: 정상, False :오류 )             */
/* Returns   : 주  민등록번호 -> Boolean ( True: 정상, False :오류 )               */
/* 비     고 :                                                                                                    */
/*            1. 사업자등록번호 Check 방법                                                        */
/*                                                                                                                    */
/*               (A) XXX-XX-XXXxz  <= 주민등록번호                                             */
/*               (B) 137 13 7135                                                                               */
/*               ------------------                                                                                */
/*               (C) MMM MM MMMQZ  <= M : MOD((A)의 각자리 × (B)의 각자리,10)   */
/*                                    Q : (A)의 x × (B)의 5 => 십자리 + 일자리                 */
/*                                        예) x(= 7)×5 = 35 => 3 + 5 = 8 (<= Q)                    */
/*                                    Z : (A)의 z값과 동일                                                  */
/*               (D) = Σ(C)                                                                                        */
/*               IF MOD( (D) , 10 ) = 0 THEN RETURN 0                                               */
/*                                     <= (C)의 합을 10로 나눈 나머지가 0이면 OK           */
/*                                                                                                                       */
/*             2. 주민등록번호 Check 방법                                                              */
/*                                                                                                                       */
/*               (A) yymmdd-XXXXXXz  <= 주민등록번호                                          */
/*               (B) 234567 892345                                                                             */
/*               ------------------                                                                                  */
/*               (C) MMMMMM MMMMMM   <= M : (A)의 각자리 × (B)의 각자리         */
/*                                                                                                                        */
/*               (D) = SUM(C)                                                                                      */
/*               (E) = MOD( (D) , 11 )                                                                            */
/*               IF (11 - (E)) = z THEN 0 <= (11-(C)의 합을 11로 나눈 나머지)와         */
/*                                      z (주민등록번호 끝자리)가 같으면 OK                       */
/*-------------------------------------------------------------------------------------------------*/
Integer   li_len        = 0
Integer   li_find_dash1 = 0
Integer   li_find_dash2 = 0
Integer   li_tot        = 0
Integer   i             = 0
Integer   li_tmp        = 0
Integer   li_return_val = 0
String    ls_chk_code   = ''

li_len        = Len(arg_reg_no)
li_find_dash1 = Pos(arg_reg_no, '-', 1)                 // 등록번호의 첫번째 '-' 기호 위치
li_find_dash2 = Pos(arg_reg_no, '-', li_find_dash1 + 1)   // 등록번호의 두번째 '-' 기호 위치
/*-------------------------------------------------------------------------------*/
/* 사업자 등록번호                                                               */
/* (12자리이면서4,7번째에 '-'를포함하거나10자리이면서 '-'를포함하지않는것만정상) */
/*-------------------------------------------------------------------------------*/
IF  ((li_len = 12 AND li_find_dash1 = 4 AND li_find_dash2 = 7) OR (li_len = 10 AND li_find_dash1 = 0 AND li_find_dash2 = 0)) AND NOT IsNull(li_len) THEN
    /*---------------------------------------------------------------------------*/
    /* 사업자등록번호 Check용 code                                               */
    /*---------------------------------------------------------------------------*/
    ls_chk_code = '137137135'
    /*---------------------------------------------------------------------------*/
    /* 사업자등록번호 Check용 code                                               */
    /*---------------------------------------------------------------------------*/
    IF  li_find_dash1 = 4 AND li_find_dash2 = 7 THEN
        arg_reg_no    = Left(arg_reg_no,3) + Mid(arg_reg_no,5,2) + Right(arg_reg_no,5)
        li_len        = Len(arg_reg_no)
    END IF
    FOR i = 1 TO li_len - 2
        li_tot = li_tot + Mod(Integer(Mid(arg_reg_no,i,1)) * Integer(Mid(ls_chk_code,i,1)), 10)
    NEXT
    /*---------------------------------------------------------------------------*/
    /* 사업자등록번호의 9번째자리 처리                                           */
    /*---------------------------------------------------------------------------*/
    li_tmp = Integer(Mid(arg_reg_no,9,1)) * Integer(Mid(ls_chk_code,9,1))
    li_tot = li_tot + Int(li_tmp / 10) + Mod(li_tmp,10)
    /*---------------------------------------------------------------------------*/
    /* 사업자등록번호의 10번째자리 처리                                          */
    /*---------------------------------------------------------------------------*/
    li_tot = li_tot + Integer(Mid(arg_reg_no,10,1))

    IF  Mod(li_tot, 10) = 0 THEN
        Return True
    ELSE
        MessageBox('Validation Check',' 유효한 사업자 등록번호가 아닙니다.', Exclamation!)
        Return False
    END IF
/*-------------------------------------------------------------------------------*/
/* 주민 등록번호                                                                 */
/* (14자리이면서7번째자리에'-'를 포함하거나13자리이면서'-'를포함하지않는것만정상)*/
/*-------------------------------------------------------------------------------*/
ELSEIF  ((li_len = 14 AND li_find_dash1 = 7) OR (li_len = 13 AND li_find_dash1 = 0)) AND NOT IsNull(li_len) THEN
        /*-----------------------------------------------------------------------*/
        /* 주민등록번호 Check용 code                                             */
        /*-----------------------------------------------------------------------*/
        ls_chk_code = '234567892345'
        /*-----------------------------------------------------------------------*/
        /*  14자리 이면서 7번째자리에 '-'를 포함하면 '-' 기호 제거               */
        /*-----------------------------------------------------------------------*/
        IF  li_find_dash1  = 7 THEN
            arg_reg_no = Left(arg_reg_no,6) + Right(arg_reg_no,7)
            li_len     = Len(arg_reg_no)
        END IF

        FOR i = 1 TO li_len - 1
            li_tot = li_tot + (Integer(Mid(arg_reg_no,i,1)) * Integer(Mid(ls_chk_code,i,1)))
        NEXT

        IF  MOD((11 - Mod(li_tot, 11)), 10) = Integer(Mid(arg_reg_no,13,1)) THEN
            Return True
        ELSE
            MessageBox('Validation Check',' 유효한 주민등록번호가 아닙니다.', Exclamation!)
            Return False
        END IF
/*-------------------------------------------------------------------------------*/
/* 잘못된 Argument값이면 Return False                                            */
/*-------------------------------------------------------------------------------*/
ELSE
    MessageBox('Validation Check',' 유효한 등록번호가 아닙니다.', Exclamation!)
    Return False
END IF

end function

public function boolean or_reg_no_law_check (string arg_reg_no);/*-------------------------------------------------------------------------------*/
/* Function  : gf_reg_no_law_check                                               */
/* 내    용  : 법인등록번호 오류여부 Check                              */
/* Scope     : public                                                                     */
/* Arguments : String  arg_reg_no                                                */
/* Returns   : Boolean ( True: 정상, False :오류 )                         */
/* 비     고 :                                                                               */
/*             < 법인번호 Check 방법 >                                           */
/*            (A) XXXXXX-XXXXXXz                                                   */
/*            (B) 121212 121212                                                        */
/*            ------------------                                                             */
/*            (C) MMMMMM MMMMMM   <= M : (A)의 각자리 × (B)의 각자리  */
/*            (D) = SUM(C)                                                                              */
/*            (E) = MOD( (D) , 10 ) (※ 주민등록번호는 11로 나눔)                */
/*            IF (10 - (E)) = z THEN 0   <= (11-(C)의 합을 10으로 나눈 나머지)와 */
/*                                   z (법인등록번호 끝자리)가 같으면 OK              */
/*-------------------------------------------------------------------------------*/
Integer li_len        = 0
Integer li_find_dash  = 0
Integer li_tot        = 0
Integer i             = 0
Integer li_tmp        = 0
Integer li_return_val = 0
String  ls_chk_code   = ''

li_len       = Len(arg_reg_no)
li_find_dash = Pos(arg_reg_no, '-', 1)   // 법인등록번호의 첫번째 '-' 기호 위치

/*-------------------------------------------------------------------------------*/
/*  법인등록번호                                                                 */
/* (14자리이면서7번째자리에'-'를포함하거나13자리이면서'-'를포함하지않는것만정상) */
/*-------------------------------------------------------------------------------*/
IF  ((li_len = 14 AND li_find_dash = 7) OR (li_len = 13 AND li_find_dash = 0)) AND NOT IsNull(li_len) THEN
    /*---------------------------------------------------------------------------*/
    /* 법인등록번호 Check용 code                                                 */
    /*---------------------------------------------------------------------------*/
    ls_chk_code = '121212121212'
    /*---------------------------------------------------------------------------*/
    /* 14자리 이면서 7번째자리에 '-'를 포함하면 '-' 기호 제거                    */
    /*---------------------------------------------------------------------------*/
    IF  li_find_dash  = 7 THEN
        arg_reg_no = Left(arg_reg_no,6) + Right(arg_reg_no,7)
        li_len     = Len(arg_reg_no)
     END IF

     FOR i = 1 TO li_len - 1
         li_tot = li_tot + (Integer(Mid(arg_reg_no,i,1)) * Integer(Mid(ls_chk_code,i,1)))
     NEXT

     IF  MOD((10 - Mod(li_tot, 10)), 10) = Integer(Mid(arg_reg_no,13,1)) THEN
         Return True
     ELSE
         MessageBox('Validation Check',' 유효한 법인등록번호가 아닙니다.', Exclamation!)
         Return False
     END IF
/*-------------------------------------------------------------------------------*/
/*  잘못된 Argument값이면 Return False                                           */
/*-------------------------------------------------------------------------------*/
ELSE
    MessageBox("오류","법인등록확인시 오류가 발생했습니다.", Stopsign!)
    Return False
END IF

end function

public function integer of_setvalue (ref datawindow ad_dw, long ai_row, string as_colname, any aa_value, string as_mode);LONG				i, cnt
dwItemStatus 	l_status

ad_dw.acceptText()

IF ai_row = 0 THEN
	cnt = ad_dw.rowcount()
	FOR i = 1 TO cnt
		l_status = of_getrowstatus(ad_dw,i)

		CHOOSE CASE Upper(as_mode)
			CASE "A"
				
			CASE "M"
				IF l_status <> DataModified! THEN Continue
			CASE "N"
				IF l_status <> NewModified! THEN Continue
			CASE ELSE
				RETURN -1
		END CHOOSE
		
		ad_dw.SetItem(i, as_colname, aa_value)
		
	NEXT
	
ELSE
	ad_dw.SetItem(ai_row, as_colname, aa_value)
END IF

RETURN 1

end function

public function dwitemstatus of_getrowstatus (ref datawindow ad_dw, long row);RETURN ad_dw.GetItemStatus(row, 0, Primary!)
end function

public function integer of_setsysdate (ref datawindow ad_dw, long ai_row, string as_colname, string as_mode);STRING		ls_rv, ls_date, ls_time
Datetime		ldt
String			ls_datetime
Integer		li_err_code
String			ls_err_text

If Lower(of_getColtype(ad_dw, as_colname)) <> "datetime" Then Return -1

SELECT	TO_CHAR(sysdate,'yyyy/mm/dd hh24:mi:ss')
INTO		:ls_datetime
FROM		DUAL
USING	SQLCA ;
If SQLCA.SQLCODE <> 0 Then
	li_err_code	= SQLCA.SQLDBCode
	ls_err_text	= SQLCA.SQLErrText
	ROLLBACK USING SQLCA;
	gf_sqlerr_msg('UserObject ' + THIS.Classname(), 'Function of_setsysdate', String(9), 'SELECT DUAL', li_err_code, ls_err_text)
	Return -1
End If

ls_date	= of_get_token(ls_datetime," ")
ls_time	= ls_datetime
ldt			= DateTime(Date(ls_date),Time(ls_time))

RETURN of_setValue(ad_dw,ai_row, as_colname, ldt, as_mode)

end function

public function string of_getcoltype (datawindow ad_dw, string as_column);/*
┌────────────────────────────────────
│	. NAME   	: of_GetColType																													
│	. RETURN 	: String                         
│	. DESC   		: get Column's ColType from Column Name
└────────────────────────────────────
*/
STRING ls_Type

ls_Type = ad_dw.Describe(as_Column + ".ColType")
ls_Type = of_get_token(ls_Type,"(")

CHOOSE CASE lower(ls_Type)
	CASE 'date', 'datetime', 'time', 'timestamp', 'int', 'long', 'number', 'real', 'ulong', 'char', 'decimal'
		RETURN ls_Type			
	CASE ELSE		
		RETURN ''
END CHOOSE

end function

public function any of_getitem (ref datawindow ad_dw, long ai_row, string as_column, dwbuffer adwbuffer, boolean ab_ori);/*
┌────────────────────────────────────
│	. NAME     	: of_GetItem																													
│	. RETURN 	: ANY                         
│	. DESC   		: get Column's Data with Column Name
└────────────────────────────────────
*/
STRING ls_Null, ls_coltype
SetNull(ls_NULL)

IF ai_row < 1 THEN
	RETURN ls_Null
END IF

ls_coltype = of_GetColType(ad_dw, as_column)
	CHOOSE CASE lower(ls_coltype)
		CASE "char"
			RETURN  ad_dw.getItemString(ai_row, as_column, adwbuffer, ab_ori)
		CASE "date"
			RETURN  ad_dw.getItemDate(ai_row, as_column, adwbuffer, ab_ori)
		CASE "datetime"
			RETURN  ad_dw.getItemDateTime(ai_row, as_column, adwbuffer, ab_ori)
		CASE "decimal"
			RETURN  ad_dw.getItemDecimal(ai_row, as_column, adwbuffer, ab_ori)	
		CASE "int", "long", "number"
			RETURN  ad_dw.getItemNumber(ai_row, as_column, adwbuffer, ab_ori)
		CASE "time"
			RETURN  ad_dw.getItemTime(ai_row, as_column, adwbuffer, ab_ori)
		CASE else
			RETURN ls_NULL
	END CHOOSE
		
end function

public function any of_getitem (ref datawindow ad_dw, long ai_row, string as_column);RETURN of_getItem(ad_dw,ai_row, as_column, Primary!, FALSE)
end function

public function integer of_checknull (ref datawindow ad_dw);/*
 NAME  	 	: of_CheckNull																													
 RETURN 	: Long ( Success : 0, Fail : OTHERS )                         
 DESC   	: Check Column If it is Not Null
          		  Column's Tag Properties = NOTNULL(Coulmn Name)
*/
INTEGER 	li_Row, li_RowCount, li_rv
INTEGER 	li_Column, li_ColumnCount
STRING  		ls_Column, ls_Tag, ls_Name, ls_gubun, ls_msgcode, ls_compare
ANY 			la_Value
Long			ll_pos
String			ls_tab_page
Long			ll_tab
Long			ll_old_tab
Tab			lt_tab

li_ColumnCount = INTEGER(ad_dw.Object.DataWindow.Column.Count)

li_Row = ad_dw.GetNextModIFied(0, Primary!)

DO While(li_Row > 0)

   FOR li_Column = 1 TO li_ColumnCount
		li_rv = 1
       	ls_Column = ad_dw.Describe("#" + STRING(li_Column) + '.Name')
       	ls_Tag    = Trim(ad_dw.Describe(ls_Column + '.Tag'))
		If Pos(Upper(ls_Tag), 'KOR') > 0 Then
			ll_pos = Pos(Upper(ls_Tag), 'KOR')
			ls_Tag = Replace(ls_Tag, ll_pos, 3, '')
		End If
		If Pos(Upper(ls_Tag), 'YYYY') > 0 Then
			ll_pos = Pos(Upper(ls_Tag), 'YYYY')
			ls_Tag = Replace(ls_Tag, ll_pos, 4, '')
		ElseIf Pos(Upper(ls_Tag), 'YYMM') > 0 Then
			ll_pos = Pos(Upper(ls_Tag), 'YYMM')
			ls_Tag = Replace(ls_Tag, ll_pos, 4, '')
		ElseIf Pos(Upper(ls_Tag), 'DATE') > 0 Then
			ll_pos = Pos(Upper(ls_Tag), 'DATE')
			ls_Tag = Replace(ls_Tag, ll_pos, 4, '')
		ElseIf Pos(Upper(ls_Tag), 'TIME') > 0 Then
			ll_pos = Pos(Upper(ls_Tag), 'TIME')
			ls_Tag = Replace(ls_Tag, ll_pos, 4, '')
		End If
		ls_gubun = of_get_token(ls_Tag, '(')
		ls_Name   = of_get_Token(ls_Tag, ')')
		
		la_Value = STRING(of_GetItem(ad_dw,li_row, ls_Column))
		
		IF ls_gubun = "NOTNULL" OR ls_gubun = "NOTZERO" OR ls_gubun = "NOTMINUS" THEN
			IF of_nvl(la_Value, "") = "" THEN 
				li_rv = -1
				ls_msgcode = "은(는) 필수 입력 항목 입니다"
			ELSE
				CHOOSE CASE ls_gubun
					CASE "NOTZERO"
						IF isNumber(la_Value) THEN
							IF Double(la_Value) <= 0 THEN
								li_rv = -1
								ls_msgcode = "에는 0보다 큰값만 입력가능합니다"
							END IF
						ELSE
							ls_msgcode = "의 입력 오류 입니다. 확인하십시오"
							li_rv = -1
						END IF
					CASE "NOTMINUS"
						IF isNumber(la_Value) THEN
							IF Double(la_Value) < 0 THEN 
								li_rv = -1
								ls_msgcode = "에는 음수값을 입력할 수 없습니다"
							END IF
						ELSE
							ls_msgcode = "의 입력 오류 입니다. 확인하십시오"
							li_rv = -1
						END IF
					CASE ELSE
						
				END CHOOSE
			END IF
		END IF
		
		IF li_rv <> 1 THEN
				MessageBox('확인',ls_Name+ls_msgcode,Information!,Ok!,1)
				If Pos(Upper(ad_dw.ClassName()), 'TAB') > 0 Then
					lt_tab = ad_dw.GetParent().GetParent()
					ls_tab_page = ad_dw.GetParent().ClassName()
					If LastPos(ls_tab_page, '_') > 0 Then
						ll_tab = Long(Mid(ls_tab_page, LastPos(ls_tab_page, '_') + 1))
						ll_old_tab = lt_tab.SelectedTab
						If ll_old_tab <> ll_tab Then
							lt_tab.SelectTab(ll_tab)
						End If
					End If
				End If
				ad_dw.SetRow(li_Row)
				ad_dw.ScrollToRow(li_Row)
				ad_dw.SetColumn(li_Column)
				ad_dw.SetFocus()
				RETURN li_rv
		END IF
   NEXT

   li_Row = ad_dw.GetNEXTModIFied(li_Row, Primary!)

LOOP

RETURN 0 // Update Continue;

end function

public function string of_replace (string str, string fstr, string tstr);int 	iPos

iPos = Pos(str, fstr)

DO WHILE(iPos > 0)
	str  = Replace(str, iPos, Len(fstr), tstr)
	iPos = Pos(str, fstr, iPos+Len(tstr))
LOOP

RETURN str
end function

public subroutine of_design_dw (ref datawindow adw);String			ls_ObjectList
String			ls_object
String			ls_sep
String			ls_ObjType
String			ls_Tag
String			ls_displayonly
Long				ll_pos
String			ls_height
String			ls_syntax

ls_sep = '~t'

adw.setRedraw(FALSE)

ls_syntax += "DataWindow.detail.Color='0~trgb(232,236,239)'"
ls_syntax += "~n DataWindow.Header.Height='4'"
ls_syntax += "~n DataWindow.Detail.Height='" + String(long(adw.Object.DataWindow.Detail.Height)) + "'"
ls_syntax += "~n create line(band=header x1='0' y1='0' x2='" + String(adw.Width) + "' y2='0'  name=l_top visible='1' pen.style='0' pen.width='5' pen.color='29738437'  background.mode='2' background.color='16777215')"
ls_syntax += "~n create line(band=detail x1='0' y1='" + String(long(adw.Object.DataWindow.Detail.Height) - 12) + "' x2='" + String(adw.Width) + "' y2='" + String(long(adw.Object.DataWindow.Detail.Height) - 12) + "'  name=l_bottom visible='1' pen.style='0' pen.width='5' pen.color='29738437'  background.mode='2' background.color='16777215' )"

ls_ObjectList = adw.Describe("DataWindow.Objects")
DO WHILE len(ls_ObjectList) > 0
	ll_pos = Pos(ls_ObjectList, ls_sep)
	If ll_pos = 0 Then
		ls_object = ls_ObjectList
		ls_ObjectList = ""
	Else
		ls_object = Mid(ls_ObjectList, 1, ll_pos - 1)
		ls_ObjectList = Right(ls_ObjectList, Len(ls_ObjectList) - ll_pos - Len(ls_sep) + 1 ) 
	End If

	ls_ObjType =Lower(adw.Describe(ls_object+".Type"))
	ls_Tag = of_replace(Lower(adw.Describe(ls_object+".Tag")),"?","")
	CHOOSE CASE  ls_ObjType
		CASE "text"
			
			ls_syntax += "~n " + ls_object + ".Height='64'"
			ls_syntax += "~n " + ls_object + ".Font.Face='Tahoma'"
			ls_syntax += "~n " + ls_object + ".Font.Height='-9'"
			ls_syntax += "~n " + ls_object + ".Font.Weight='700'"
			
			
			IF ls_Tag = "ess" THEN
				// 필수
				ls_syntax += "~n " + ls_object + ".Color='0~trgb(185,35,135)'"
			ELSE
				// 그외
				ls_syntax += "~n " + ls_object + ".Color='0~trgb(99,99,99)'"
				
			END IF
		CASE "column"
			ls_height = adw.Describe(ls_object + ".Height")
			If Long(ls_height) < 80 Then
				ls_syntax += "~n " + ls_object + ".Height='64'"
			End If
			
			ls_syntax += "~n " + ls_object + ".Font.Face='Tahoma'"
			ls_syntax += "~n " + ls_object + ".Font.Height='-9'"
			ls_syntax += "~n " + ls_object + ".Font.Weight='400'"
			ls_syntax += "~n " + ls_object + ".Color='0~trgb(104,105,107)'"
			ls_syntax += "~n " + ls_object + ".Background.Mode='2'"
			
			ls_displayonly = Lower(adw.Describe(ls_object + ".Edit.DisplayOnly"))
			If ls_displayonly = 'yes' Then
				ls_syntax += "~n " + ls_object + ".Background.Color='0~trgb(207,213,225)'"
			Else
				If Integer(adw.Describe(ls_object + ".tabsequence")) = 0 Then 
					ls_syntax += "~n " + ls_object + ".Background.Color='0~trgb(207,213,225)'"
				Else
					string ls_ObjStyleType
					ls_ObjStyleType =Lower(adw.Describe(ls_object+".Edit.Style"))
					If ls_ObjStyleType = 'radiobuttons' or ls_ObjStyleType = 'checkbox' THen 
						ls_syntax += "~n " + ls_object + ".Background.Color='0~trgb(232,236,239)'"
					ELse
						ls_syntax += "~n " + ls_object + ".Background.Color='0~trgb(255,255,255)'"
					End if
				End If
			End If
			
		CASE ELSE

	END CHOOSE
	ls_syntax = adw.Modify(ls_syntax)
	ls_syntax = ""
LOOP


adw.setRedraw(TRUE)

end subroutine

public function integer of_setsysdate (ref datastore ads_dw, integer ai_row, string as_colname, string as_mode);STRING		ls_rv, ls_date, ls_time
Datetime		ldt
String			ls_datetime
Integer		li_err_code
String			ls_err_text

If Lower(of_getColtype(ads_dw, as_colname)) <> "datetime" Then Return -1

SELECT	TO_CHAR(sysdate,'yyyy/mm/dd hh24:mi:ss')
INTO		:ls_datetime
FROM		DUAL
USING	SQLCA ;
If SQLCA.SQLCODE <> 0 Then
	li_err_code	= SQLCA.SQLDBCode
	ls_err_text	= SQLCA.SQLErrText
	ROLLBACK USING SQLCA;
	gf_sqlerr_msg('UserObject ' + THIS.Classname(), 'Function of_setsysdate', String(9), 'SELECT DUAL', li_err_code, ls_err_text)
	Return -1
End If

ls_date	= of_get_token(ls_datetime," ")
ls_time	= ls_datetime
ldt			= DateTime(Date(ls_date),Time(ls_time))

Return of_setValue(ads_dw,ai_row, as_colname, ldt, as_mode)

end function

public function integer of_setvalue (ref datastore ads_dw, long ai_row, string as_colname, any aa_value, string as_mode);LONG				i, cnt
dwItemStatus 	l_status

ads_dw.acceptText()

IF ai_row = 0 THEN
	cnt = ads_dw.rowcount()
	FOR i = 1 TO cnt
	    l_status = ads_dw.GetItemStatus(i, 0, Primary!)
		 
		CHOOSE CASE Upper(as_mode)
			CASE "A"
				
			CASE "M"
				IF l_status <> DataModified! THEN Continue
			CASE "N"
				IF l_status <> NewModified! THEN Continue
			CASE ELSE
				RETURN -1
		END CHOOSE
		
		ads_dw.SetItem(i, as_colname, aa_value)
		
	NEXT
	
ELSE
	ads_dw.SetItem(ai_row, as_colname, aa_value)
END IF

RETURN 1
end function

public function string of_getcoltype (ref datastore ads_dw, string as_column);/*
┌────────────────────────────────────
│	. NAME   	: of_GetColType																													
│	. RETURN 	: String                         
│	. DESC   		: get Column's ColType from Column Name
└────────────────────────────────────
*/
STRING ls_Type

ls_Type = ads_dw.Describe(as_Column + ".ColType")
ls_Type = of_get_token(ls_Type,"(")

CHOOSE CASE lower(ls_Type)
	CASE 'date', 'datetime', 'time', 'timestamp', 'int', 'long', 'number', 'real', 'ulong', 'char', 'decimal'
		RETURN ls_Type			
	CASE ELSE		
		RETURN ''
END CHOOSE

end function

public function integer of_dddw (ref datawindow ad_dw, vector avc_data);/*=================================================================
  처리내용:  공통코드 dddw 
                    프로그램에서 넘어온 argument를 filter로 처리한다.
=================================================================*/
string DWfilter, ls_temp
Int li_cnt
Integer	li_count, i
li_count = avc_data.getfindkeycount('column')
FOR i = 1 TO li_count
	DWfilter = "cls_cd ='" + avc_data.getproperty('key' + String(i)) + "'"
	ls_temp = avc_data.getproperty('subcol' + String(i))
	IF ls_temp <> '' THEN
		DWfilter += " and " + ls_temp + " like '" + avc_data.getproperty('subkey' + String(i)) + "'"
	END IF

	ids.SetFilter(dwfilter)
	ids.Filter()
	
	ls_temp = avc_data.getproperty('column' + String(i))
	IF Not ( ad_dw.Describe(ls_temp+".DDDW.Name") = "?" or ad_dw.Describe(ls_temp+".DDDW.Name") = "!"  or  &
		ad_dw.Describe(ls_temp+".DDDW.Name") <> "d_dddw_code") THEN
		
		DataWindowChild ldw_child
		
		ad_dw.GetChild( ls_temp , ldw_child )
		
		If li_count = 1 Then  // open에서 2개를 한번에 조회할때는 reset하면 뒤에 코드는 안나온다.1일때만 reset적용.
			ldw_child.Reset()	
		End if
					
		ids.RowsCopy(1,  ids.RowCount(), primary!, ldw_child , 1 ,primary!)
	
		ldw_child.SetSort('seq A, cd A')
		ldw_child.Sort()

	END IF
NEXT

Return 0
end function

public function integer of_checknull (ref datawindow ad_dw, vector avc_data);/*
 NAME  	 	: of_CheckNull																													
 RETURN 	: Long ( Success : 0, Fail : OTHERS )                         
 DESC   	: Check Column If it is Not Null
 				  함수 호출시 vector 이용해서 체크 
*/
INTEGER 	li_Row, li_rv=0
STRING  		ls_Column, ls_temp
String			ls_tab_page
Long			ll_tab
Long			ll_old_tab
Tab			lt_tab


li_Row = ad_dw.GetNextModIFied(0, Primary!)

DO While(li_Row > 0)
	
	ls_column = avc_data.getFirstproperty()
	do while ls_column <> ''
		ls_temp = STRING(of_GetItem(ad_dw,li_row, ls_Column))
		IF of_nvl(ls_temp, "") = "" THEN 
			ls_temp = avc_data.getproperty(ls_column) +  "은(는) 필수 입력 항목 입니다"
			li_rv = -1
			Exit
		END IF
		ls_column = avc_data.getNextProperty()
	loop
	
	IF li_rv = -1 THEN 
		MessageBox('확인',ls_temp,Information!,Ok!,1)
		If Pos(Upper(ad_dw.ClassName()), 'TAB') > 0 Then
			lt_tab = ad_dw.GetParent().GetParent()
			ls_tab_page = ad_dw.GetParent().ClassName()
			If LastPos(ls_tab_page, '_') > 0 Then
				ll_tab = Long(Mid(ls_tab_page, LastPos(ls_tab_page, '_') + 1))
				ll_old_tab = lt_tab.SelectedTab
				If ll_old_tab <> ll_tab Then
					lt_tab.SelectTab(ll_tab)
				End If
			End If
		End If
		ad_dw.SetRow(li_Row)
		ad_dw.ScrollToRow(li_Row)
		ad_dw.SetColumn(ls_Column)
		ad_dw.SetFocus()
		Exit
	END IF

   li_Row = ad_dw.GetNEXTModIFied(li_Row, Primary!)

LOOP


RETURN li_rv // Update Continue;

end function

public function integer of_dddw (ref datawindow ad_dw, vector avc_data, long al_width);/*=================================================================
  처리내용:  공통코드 dddw 
                    프로그램에서 넘어온 argument를 filter로 처리한다.
=================================================================*/
string DWfilter, ls_temp
Int li_cnt
Integer	li_count, i
li_count = avc_data.getfindkeycount('column')
FOR i = 1 TO li_count
	DWfilter = "cls_cd ='" + avc_data.getproperty('key' + String(i)) + "'"
	ls_temp = avc_data.getproperty('subcol' + String(i))
	IF ls_temp <> '' THEN
		DWfilter += " and " + ls_temp + " like '" + avc_data.getproperty('subkey' + String(i)) + "'"
	END IF

	ids.SetFilter(dwfilter)
	ids.Filter()
	
	ls_temp = avc_data.getproperty('column' + String(i))
	IF Not ( ad_dw.Describe(ls_temp+".DDDW.Name") = "?" or ad_dw.Describe(ls_temp+".DDDW.Name") = "!"  or  &
		ad_dw.Describe(ls_temp+".DDDW.Name") <> "d_dddw_code") THEN
		DataWindowChild ldw_child
		
		ad_dw.GetChild( ls_temp , ldw_child )
		
		If li_count = 1 Then  // open에서 2개를 한번에 조회할때는 reset하면 뒤에 코드는 안나온다.1일때만 reset적용.
			ldw_child.Reset()	
		End if
				
		ids.RowsCopy(1,  ids.RowCount(), primary!, ldw_child , 1 ,primary!)
	
		ldw_child.SetSort('seq A, cd A')
		ldw_child.Sort()
		// d_dddw_code의 cd width지정 
		ldw_child.Modify("cd.width= " + string(al_width))
	END IF
NEXT

Return 0
end function

public function integer of_dddw (ref datawindow ad_dw, vector avc_data, boolean arg_all_yn, boolean arg_null_yn);/*=================================================================
  처리내용:  공통코드 dddw 
                    프로그램에서 넘어온 argument를 filter로 처리한다.
	  arg_all_yn : TRUE '% 전체' 포함 
	  arg_null_yn : TRUE ' '(빈칸) 포함 
=================================================================*/
string DWfilter, ls_temp
Int li_cnt
Integer	li_count, i
li_count = avc_data.getfindkeycount('column')
FOR i = 1 TO li_count
	DWfilter = "cls_cd ='" + avc_data.getproperty('key' + String(i)) + "'"
	ls_temp = avc_data.getproperty('subcol' + String(i))
	IF ls_temp <> '' THEN
		DWfilter += " and " + ls_temp + " like '" + avc_data.getproperty('subkey' + String(i)) + "'"
	END IF
	If arg_all_yn = True Then
		DWfilter = "(" + DWfilter + ") OR (cd = '%' AND CLS_CD = '%') "
	End If
	If arg_null_yn = True Then
		DWfilter = "(" + DWfilter + ") OR (IsNull(cd))"
	End If
	
	ids.SetFilter(dwfilter)
	ids.Filter()
	
	ls_temp = avc_data.getproperty('column' + String(i))
	IF Not ( ad_dw.Describe(ls_temp+".DDDW.Name") = "?" or ad_dw.Describe(ls_temp+".DDDW.Name") = "!"  or  &
		ad_dw.Describe(ls_temp+".DDDW.Name") <> "d_dddw_code") THEN
		DataWindowChild ldw_child
		
		ad_dw.GetChild( ls_temp , ldw_child )

		If li_count = 1 Then  // open에서 2개를 한번에 조회할때는 reset하면 뒤에 코드는 안나온다.1일때만 reset적용.
			ldw_child.Reset()	
		End if			
	
		
		ids.RowsCopy(1,  ids.RowCount(), primary!, ldw_child , 1 ,primary!)
	
		ldw_child.SetSort('seq A, cd A')
		ldw_child.Sort()
	END IF
NEXT

Return 0
end function

public subroutine of_set_pb (ref powerobject a_po, ref long al_x, long al_y);
CHOOSE CASE a_po.Typeof()
	CASE PictureButton!
		PictureButton lpb
		lpb = a_po
		
		If lpb.Enabled = False Then
		   lpb.visible = False
		Else
			al_x = al_x - lpb.width -14
			lpb.x = al_x
			lpb.y = al_y
		End if

	CASE Picture!
		Picture lp
		lp = a_po
		
		If lp.Enabled = False Then
		   lp.visible = False
		Else
			if lp.visible = True Then 
				al_x = al_x - lp.width -14
				lp.x = al_x
				lp.y = al_y
			Else
				lp.visible = False
			End if
		End if
	CASE UserObject!
		UserObject luo
		luo = a_po
		
		If luo.Enabled = False Then
		   luo.visible = False
		Else
			al_x = al_x - luo.width -14
			luo.x = al_x
			luo.y = al_y
		End if
End CHoose
		
//If a_pb.enabled = false Then 
//	a_pb.visible = False
//Else
//	al_x = al_x - a_pb .width - 14
//	a_pb .x = al_x
//	a_pb .y = al_y
//end if

end subroutine

public subroutine of_resetarray (ref any aa_arr[]);Any	arr[]
aa_arr = arr

end subroutine

public subroutine of_resetarray (ref long al_arr[]);Long	arr[]
al_arr = arr

end subroutine

public subroutine of_resetarray (ref string as_arr[]);String	arr[]
as_arr = arr

end subroutine

public function string of_date_add (string arg_date, integer arg_add_day);/*
 Function : of_date_add
 Purpose  : String형의 일자에 일수를 가감한 String형 일자를 Return
 Scope    : public
 Arguments: String      arg_date
				   Integer     arg_add_day
 Returns  : String
 */

Date      ld_date
String    ls_ret_date
Date      ld_add_date

ld_date        = Date(Mid(arg_date, 1, 4) + '/' + Mid(arg_date, 5, 2) + '/' + Mid(arg_date, 7, 2))
ld_add_date = RelativeDate(ld_date, arg_add_day)

ls_ret_date   = String(ld_add_date, 'yyyymmdd')

Return ls_ret_date

end function

public function long of_day_diff_comp (string arg_date1, string arg_date2);////////////////////////////////////////////////////////////////////////////////////////////
//
// Function : of_day_diff_comp
//
// Purpose  : String형의 두 일자간의 일수를 계산한 날자수를 Return
//
// Scope    : public
//
// Arguments: String      arg_date1
//				   String      arg_date2
//
// Returns  : Long
//
////////////////////////////////////////////////////////////////////////////////////////////

Date		ld_date1
Date		ld_date2
Long		ll_day_cnt

ld_date1 = Date(Mid(arg_date1, 1, 4) + '.' + Mid(arg_date1, 5, 2) + '.' + Mid(arg_date1, 7, 2))
ld_date2 = Date(Mid(arg_date2, 1, 4) + '.' + Mid(arg_date2, 5, 2) + '.' + Mid(arg_date2, 7, 2))

ll_day_cnt = DaysAfter(ld_date1, ld_date2)

Return ll_day_cnt

end function

public function long of_mon_diff_comp (string arg_new_day, string arg_old_day);////////////////////////////////////////////////////////////////////////////////////////////
//
// Function : of_mon_diff_comp
//
// Purpose  : 두 날짜 사이의 월의 차이수를 Return
//
// Scope    : public
//
// Arguments: String      arg_new_day
//				   String      arg_old_day
//
// Returns  : Long
//
////////////////////////////////////////////////////////////////////////////////////////////

Long		ll_retn_mon
String		ls_new_yyyy
String		ls_new_mm
String		ls_old_yyyy
String		ls_old_mm

ls_new_yyyy	= Left(arg_new_day, 4)
ls_new_mm	= Mid(arg_new_day, 5, 2)
ls_old_yyyy	= Left(arg_old_day, 4)
ls_old_mm	= Mid(arg_old_day, 5, 2)
If ls_new_yyyy = ls_old_yyyy Then
	ll_retn_mon = Long(ls_new_mm) - Long(ls_old_mm)
Else
	ll_retn_mon = (Long(ls_new_yyyy) * 12 + Long(ls_new_mm)) - (Long(ls_old_yyyy) * 12 + Long(ls_old_mm))
End If

If ll_retn_mon < 0 Then
	ll_retn_mon = ll_retn_mon * -1
End If

Return ll_retn_mon

end function

public function string of_month_add (string arg_date, integer arg_add_month);////////////////////////////////////////////////////////////////////////////////////////////
//
// Function : of_month_add
//
// Purpose  : String형의 일자에 달을 가감한 String형 일자를 Return
//
// Scope    : public
//
// Arguments: String      arg_date
//				   Integer     arg_add_month
//
// Returns  : String
//
////////////////////////////////////////////////////////////////////////////////////////////

String		ls_ret_date
String		ls_year
String		ls_month
String		ls_day
Integer	li_year
Integer	li_month
Integer	li_add_year
Integer	li_day
Boolean	lb_chk

ls_year	=	Mid(arg_date, 1, 4)
ls_month	=	Mid(arg_date, 5, 2)
ls_day	=	Mid(arg_date, 7, 2)
li_year	=	Integer(ls_year)
li_month	=	Integer(ls_month)
li_day		=	Integer(ls_day)
li_month	=	li_month	+	arg_add_month

li_add_year	=	li_month / 12
li_month		=	Mod(li_month, 12)
If li_month	<=	0 Then
	li_add_year	--
	li_month	=	li_month	+	12
End If
li_year	=	li_year	+	li_add_year
If li_month = 2 Then
	If Mod(li_year, 400) = 0 Then
		lb_chk = True
	ElseIf Mod(li_year, 100) = 0 Then
		lb_chk = False
	ElseIf Mod(li_year, 4) = 0 Then
		lb_chk = True
	Else
		lb_chk = False
	End If
	If li_day = 31 or li_day = 30 or li_day = 29 Then
		If lb_chk = True Then
			li_day = 29
		Else
			li_day = 28
		End If
	End If
ElseIf li_month = 4 or li_month = 6 or li_month = 9 or li_month = 11 Then
	If li_day = 31 Then
		li_day = 30
	End If
End If

ls_ret_date   = Trim(String(li_year, '0000')) + Trim(String(li_month, '00')) + Trim(String(li_day, '00'))

Return ls_ret_date

end function

public function string of_week_day_add (string arg_week_day, integer arg_add_day);////////////////////////////////////////////////////////////////////////////////////////////
//
// Function : of_week_day_add
//
// Purpose  : 요일에 일수를 가감한 일자의 String형 요일을 Return
//
// Scope    : public
//
// Arguments: String      arg_week_day
//				   Integer     arg_add_day
//
// Returns  : String
//
////////////////////////////////////////////////////////////////////////////////////////////

Long		ll_add_day
String		ls_week_day[]
Long		ll_stnd_day
Long		ll_retn_day
Long		ll_i

ls_week_day[1] = '일'
ls_week_day[2] = '월'
ls_week_day[3] = '화'
ls_week_day[4] = '수'
ls_week_day[5] = '목'
ls_week_day[6] = '금'
ls_week_day[7] = '토'

ll_add_day = Mod(arg_add_day, 7)
For ll_i = 1 To 7
	If ls_week_day[ll_i] = arg_week_day Then
		ll_stnd_day = ll_i
	End If
Next
ll_retn_day = ll_stnd_day + ll_add_day
If ll_retn_day > 7 Then
	ll_retn_day = ll_retn_day - 7
ElseIf ll_retn_day <= 0 Then
	ll_retn_day = ll_retn_day + 7
End If

Return ls_week_day[ll_retn_day]

end function

public function boolean of_time_valid (string as_time, string as_name);////////////////////////////////////////////////////////////////////////////////////////////
//
// Function : of_time_valid
//
// Purpose  : String형의 데이터가 시간 형식인지 아닌지 check
//
// Scope    : public
//
// Arguments: String      as_time(입력한 시간 데이터)
//	                 String      as_name(입력 컬럼명)
//
// Returns  : Boolean   True(시간형식)
//
////////////////////////////////////////////////////////////////////////////////////////////

String   ls_hour
String   ls_minute
Integer li_i

If as_time <> '    ' and Not IsNull(as_time)Then
	For li_i = 1 To 4
		 If Mid(as_time, li_i, 1) = ' ' Then
			 If li_i <= 2 Then
				 MessageBox('ERROR', as_name + '의 시간 입력이 잘못되었읍니다.')
				 Return False
			 Else
				 MessageBox('ERROR', as_name + '의 분 입력이 잘못되었읍니다.')
				 Return False
			 End If
		 End If
	Next
//	If as_time = '0000' Then
//		MessageBox('ERROR', as_name + '이 0 일 수는 없읍니다.')
//		Return False
//	End If
//	If as_time > '2400' Then
//		MessageBox('ERROR', as_name + '은 최대 24:00까지만 입력할 수 있읍니다.')
//		Return False
//	End If
	If as_time >= '2400' Then
		MessageBox('ERROR', as_name + '은 24:00 보다 작아야 합니다.')
		Return False
	End If
	ls_hour   = Left(as_time,  2)
	ls_minute = Right(as_time, 2)
	If ls_hour < '00' or ls_hour > '24' Then
		MessageBox('ERROR', as_name + '의 시간 입력이 잘못되었읍니다.')
		Return False
	End If
	If ls_minute < '00' or ls_minute >= '60' Then
		MessageBox('ERROR', as_name + '의 분 입력이 잘못되었읍니다.')
		Return False
	End If
End If

Return True

end function

public function boolean of_time_valid_nomsg (string as_time);////////////////////////////////////////////////////////////////////////////////////////////
//
// Function : of_time_valid_nomsg
//
// Purpose  : String형의 데이터가 시간 형식인지 아닌지 check
//
// Scope    : public
//
// Arguments: String      as_time(입력한 시간 데이터)
//
// Returns  : Boolean   True(시간형식)
//
////////////////////////////////////////////////////////////////////////////////////////////

String   ls_hour
String   ls_minute
Integer li_i

If as_time <> '    ' and Not IsNull(as_time)Then
	For li_i = 1 To 4
		 If Mid(as_time, li_i, 1) = ' ' Then
			 If li_i <= 2 Then
				 Return False
			 Else
				 Return False
			 End If
		 End If
	Next
//	If as_time = '0000' Then
//		Return False
//	End If
//	If as_time > '2400' Then
//		Return False
//	End If
	If as_time >= '2400' Then
		Return False
	End If
	ls_hour   = Left(as_time,  2)
	ls_minute = Right(as_time, 2)
	If ls_hour < '00' or ls_hour > '24' Then
		Return False
	End If
	If ls_minute < '00' or ls_minute >= '60' Then
		Return False
	End If
End If

Return True

end function

public function string of_ym_end (string arg_ym);
/////////////////////////////////////////////////////////////////////////////
//
// Function: of_ym_end
//
// Purpose: 년월(yyyy/mm or yyyymm) 또는 년월일(yyyy/mm/dd) 을 Input Argument로 받아서 
//          그 달의 마지막 일자를 계산하여 Return 한다.
//
// Scope: public
//
// Arguments: string arg_ym
//
// Returns: string l_last_date
//
/////////////////////////////////////////////////////////////////////////////

String l_last_date
Integer l_end_day, l_i

if Len(arg_ym) = 6 Then
	arg_ym = Left(arg_ym,4) + '/' + Right(arg_ym,2)
End if

l_last_date = Left(arg_ym,7) + '/31'

For l_i = 1 to 31 
	if IsDate(l_last_date) Then
		l_last_date = Left(l_last_date,4) + mid(l_last_date,6,2) + right(l_last_date,2)
		
 	   Return l_last_date
	Else
		l_end_day = Integer(Right(l_last_date,2)) - 1
		l_last_date = Left(arg_ym,7) + '/' + String(l_end_day,'00')
	End if	 
Next	

l_last_date = Left(l_last_date,4) + mid(l_last_date,6,2) + right(l_last_date,2)

Return l_last_date

end function

public function string of_inq_str_set (string arg_str);////////////////////////////////////////////////////////////////////////////////////////////
//
// Function : of_inq_str_set
//
// Purpose  : String형의 데이터를 검색 조회조건으로 변경하여 Return
//
// Scope    : public
//
// Arguments: String      arg_str
//
// Returns  : String
//
////////////////////////////////////////////////////////////////////////////////////////////

Integer li_len
Integer li_i
String   ls_ret_str

ls_ret_str = Upper(arg_str)
li_len = Len(Trim(arg_str))

If li_len = 0 or IsNull(arg_str) Then
	ls_ret_str = '%%'
Else
	For li_i = 1 To li_len
		 If Mid(ls_ret_str, li_i, 1) = ' ' Then
			If li_i > 1 and Mid(ls_ret_str, li_i - 1, 1) = '%' Then
				ls_ret_str = Replace(ls_ret_str, li_i, 1, '')
				li_i --
			Else
				ls_ret_str = Replace(ls_ret_str, li_i, 1, '%')
			End If
		 End If
	Next
	
	ls_ret_str = '%' + ls_ret_str + '%'
End If

Return ls_ret_str

end function

public subroutine of_setfocus (datawindow dw, integer row, string column);////////////////////////////////////////////////////////////////////////////////////////////
//
// Function : of_setfocus
//
// Purpose  : Datawindow를 Setfocus하고 SetColumn, SetRow한다.
//
// Scope    : public
//
// Arguments: datawindow dw        (Datawindow)
//				  Integer    row       (row)
//            String     Column    (Column)
//
// Returns  : None
//
////////////////////////////////////////////////////////////////////////////////////////////

dw.SetRedraw(FALSE)
dw.Setfocus()
if row <> 0 Then dw.ScrollTorow(row)
if column <> '' Then 
	if	Integer(dw.Describe(column+".TabSequence")) <> 0 Then
		dw.SetColumn(column)
	End if	
End if	
dw.SetRedraw(TRUE)
end subroutine

public subroutine of_protect (ref datawindow arg_dw, string arg_column, string arg_cond);String			ls_modstring

If arg_dw.Describe(arg_column + ".Coltype") = '!' Then
	ls_modstring	= arg_column + ".Visible=~"1~tIf(" + arg_cond + ", 0, 1)~""
	arg_dw.Modify(ls_modstring)
Else
	ls_modstring = arg_column + ".BackGround.Color=~"" + String(RGB(255, 255, 255)) + "~tIf(" + arg_cond + "," + String(RGB(219, 215, 206)) + "," + String(RGB(255, 255, 255)) + ")~""
	arg_dw.Modify(ls_modstring)
	ls_modstring = arg_column + ".Protect=~"0~tIf(" + arg_cond + ", 1, 0)~""
	arg_dw.Modify(ls_modstring)
End If

end subroutine

public subroutine of_resetarray (ref datawindow arg_dw[]);DataWindow	ldw[]

arg_dw = ldw

end subroutine

public subroutine of_essential (ref datawindow arg_dw, string arg_column, string arg_cond);String			ls_modstring

ls_modstring = arg_column + ".Color=~"" + String(RGB(111,92,72)) + "~tIf(" + arg_cond + "," + String(RGB(182,135,50)) + "," + String(RGB(111,92,72)) + ")~""
arg_dw.Modify(ls_modstring)

end subroutine

public function long of_nvl (long as_num1, long as_num2);//as_num1이 NULL일 경우 as_num2로 변경
If IsNull(as_num1) Then
	RETURN as_num2
Else
	RETURN as_num1
End If

end function

public function boolean of_reg_no_check2 (string arg_reg_no);/*-------------------------------------------------------------------------------------------*/
/* Function  : gf_reg_no_check                                                                        */
/* 내    용  : 사업자, 주민등록번호 오류여부 Check                                    */
/* Scope     : public                                                                                         */
/* Arguments : String arg_reg_no                                                                     */
/* Returns   : 사업자등록번호 -> Boolean ( True: 정상, False :오류 )             */
/* Returns   : 주  민등록번호 -> Boolean ( True: 정상, False :오류 )               */
/* 비     고 :                                                                                                    */
/*            1. 사업자등록번호 Check 방법                                                        */
/*                                                                                                                    */
/*               (A) XXX-XX-XXXxz  <= 주민등록번호                                             */
/*               (B) 137 13 7135                                                                               */
/*               ------------------                                                                                */
/*               (C) MMM MM MMMQZ  <= M : MOD((A)의 각자리 × (B)의 각자리,10)   */
/*                                    Q : (A)의 x × (B)의 5 => 십자리 + 일자리                 */
/*                                        예) x(= 7)×5 = 35 => 3 + 5 = 8 (<= Q)                    */
/*                                    Z : (A)의 z값과 동일                                                  */
/*               (D) = Σ(C)                                                                                        */
/*               IF MOD( (D) , 10 ) = 0 THEN RETURN 0                                               */
/*                                     <= (C)의 합을 10로 나눈 나머지가 0이면 OK           */
/*                                                                                                                       */
/*             2. 주민등록번호 Check 방법                                                              */
/*                                                                                                                       */
/*               (A) yymmdd-XXXXXXz  <= 주민등록번호                                          */
/*               (B) 234567 892345                                                                             */
/*               ------------------                                                                                  */
/*               (C) MMMMMM MMMMMM   <= M : (A)의 각자리 × (B)의 각자리         */
/*                                                                                                                        */
/*               (D) = SUM(C)                                                                                      */
/*               (E) = MOD( (D) , 11 )                                                                            */
/*               IF (11 - (E)) = z THEN 0 <= (11-(C)의 합을 11로 나눈 나머지)와         */
/*                                      z (주민등록번호 끝자리)가 같으면 OK                       */
/*-------------------------------------------------------------------------------------------------*/
Integer   li_len        = 0
Integer   li_find_dash1 = 0
Integer   li_find_dash2 = 0
Integer   li_tot        = 0
Integer   i             = 0
Integer   li_tmp        = 0
Integer   li_return_val = 0
String    ls_chk_code   = ''

li_len        = Len(arg_reg_no)
li_find_dash1 = Pos(arg_reg_no, '-', 1)                 // 등록번호의 첫번째 '-' 기호 위치
li_find_dash2 = Pos(arg_reg_no, '-', li_find_dash1 + 1)   // 등록번호의 두번째 '-' 기호 위치
/*-------------------------------------------------------------------------------*/
/* 사업자 등록번호                                                               */
/* (12자리이면서4,7번째에 '-'를포함하거나10자리이면서 '-'를포함하지않는것만정상) */
/*-------------------------------------------------------------------------------*/
IF  ((li_len = 12 AND li_find_dash1 = 4 AND li_find_dash2 = 7) OR (li_len = 10 AND li_find_dash1 = 0 AND li_find_dash2 = 0)) AND NOT IsNull(li_len) THEN
    /*---------------------------------------------------------------------------*/
    /* 사업자등록번호 Check용 code                                               */
    /*---------------------------------------------------------------------------*/
    ls_chk_code = '137137135'
    /*---------------------------------------------------------------------------*/
    /* 사업자등록번호 Check용 code                                               */
    /*---------------------------------------------------------------------------*/
    IF  li_find_dash1 = 4 AND li_find_dash2 = 7 THEN
        arg_reg_no    = Left(arg_reg_no,3) + Mid(arg_reg_no,5,2) + Right(arg_reg_no,5)
        li_len        = Len(arg_reg_no)
    END IF
    FOR i = 1 TO li_len - 2
        li_tot = li_tot + Mod(Integer(Mid(arg_reg_no,i,1)) * Integer(Mid(ls_chk_code,i,1)), 10)
    NEXT
    /*---------------------------------------------------------------------------*/
    /* 사업자등록번호의 9번째자리 처리                                           */
    /*---------------------------------------------------------------------------*/
    li_tmp = Integer(Mid(arg_reg_no,9,1)) * Integer(Mid(ls_chk_code,9,1))
    li_tot = li_tot + Int(li_tmp / 10) + Mod(li_tmp,10)
    /*---------------------------------------------------------------------------*/
    /* 사업자등록번호의 10번째자리 처리                                          */
    /*---------------------------------------------------------------------------*/
    li_tot = li_tot + Integer(Mid(arg_reg_no,10,1))

    IF  Mod(li_tot, 10) = 0 THEN
        Return True
    ELSE
        Return False
    END IF
/*-------------------------------------------------------------------------------*/
/* 주민 등록번호                                                                 */
/* (14자리이면서7번째자리에'-'를 포함하거나13자리이면서'-'를포함하지않는것만정상)*/
/*-------------------------------------------------------------------------------*/
ELSEIF  ((li_len = 14 AND li_find_dash1 = 7) OR (li_len = 13 AND li_find_dash1 = 0)) AND NOT IsNull(li_len) THEN
        /*-----------------------------------------------------------------------*/
        /* 주민등록번호 Check용 code                                             */
        /*-----------------------------------------------------------------------*/
        ls_chk_code = '234567892345'
        /*-----------------------------------------------------------------------*/
        /*  14자리 이면서 7번째자리에 '-'를 포함하면 '-' 기호 제거               */
        /*-----------------------------------------------------------------------*/
        IF  li_find_dash1  = 7 THEN
            arg_reg_no = Left(arg_reg_no,6) + Right(arg_reg_no,7)
            li_len     = Len(arg_reg_no)
        END IF

        FOR i = 1 TO li_len - 1
            li_tot = li_tot + (Integer(Mid(arg_reg_no,i,1)) * Integer(Mid(ls_chk_code,i,1)))
        NEXT

        IF  MOD((11 - Mod(li_tot, 11)), 10) = Integer(Mid(arg_reg_no,13,1)) THEN
            Return True
        ELSE
            Return False
        END IF
/*-------------------------------------------------------------------------------*/
/* 잘못된 Argument값이면 Return False                                            */
/*-------------------------------------------------------------------------------*/
ELSE
    Return False
END IF

end function

public subroutine of_resetarray (ref datastore arg_ds[]);DataStore	lds[]

arg_ds = lds

end subroutine

public subroutine of_design_con (ref datawindow adw);String			ls_ObjectList
String			ls_object
String			ls_sep
String			ls_ObjType
String			ls_Tag
String			ls_displayonly
Long				ll_pos
String			ls_height
String			ls_syntax

ls_sep = '~t'

adw.setRedraw(FALSE)

ls_syntax += "DataWindow.detail.Color='0~trgb(174,189,218)'"
ls_syntax += "~n DataWindow.Header.Height='4'"
ls_syntax += "~n DataWindow.Detail.Height='" + String(adw.Height - 4) + "'"
ls_syntax += "~n create line(band=header x1='0' y1='0' x2='" + String(adw.Width) + "' y2='0'  name=l_top visible='1' pen.style='0' pen.width='5' pen.color='29738437'  background.mode='2' background.color='16777215')"
ls_syntax += "~n create line(band=detail x1='0' y1='" + String(adw.Height - 12) + "' x2='" + String(adw.Width) + "' y2='" + String(adw.Height - 12) + "'  name=l_bottom visible='1' pen.style='0' pen.width='5' pen.color='29738437'  background.mode='2' background.color='16777215' )"

ls_ObjectList = adw.Describe("DataWindow.Objects")
DO WHILE len(ls_ObjectList) > 0
	ll_pos = Pos(ls_ObjectList, ls_sep)
	If ll_pos = 0 Then
		ls_object = ls_ObjectList
		ls_ObjectList = ""
	Else
		ls_object = Mid(ls_ObjectList, 1, ll_pos - 1)
		ls_ObjectList = Right(ls_ObjectList, Len(ls_ObjectList) - ll_pos - Len(ls_sep) + 1 ) 
	End If

	ls_ObjType =Lower(adw.Describe(ls_object+".Type"))
	ls_Tag = of_replace(Lower(adw.Describe(ls_object+".Tag")),"?","")
	CHOOSE CASE  ls_ObjType
		CASE "text"
			
			ls_syntax += "~n " + ls_object + ".Height='64'"
			ls_syntax += "~n " + ls_object + ".Font.Face='Tahoma'"
			ls_syntax += "~n " + ls_object + ".Font.Height='-9'"
			ls_syntax += "~n " + ls_object + ".Font.Weight='700'"
			
			
			IF ls_Tag = "ess" THEN
				// 필수
				ls_syntax += "~n " + ls_object + ".Color='0~trgb(185,35,135)'"
			ELSE
				// 그외
				ls_syntax += "~n " + ls_object + ".Color='0~trgb(30,30,30)'"
				
			END IF
		CASE "column"
			ls_height = adw.Describe(ls_object + ".Height")
			If Long(ls_height) < 80 Then
				ls_syntax += "~n " + ls_object + ".Height='64'"
			End If
			
			ls_syntax += "~n " + ls_object + ".Font.Face='Tahoma'"
			ls_syntax += "~n " + ls_object + ".Font.Height='-9'"
			ls_syntax += "~n " + ls_object + ".Font.Weight='400'"
			ls_syntax += "~n " + ls_object + ".Color='0~trgb(30,30,30)'"
			ls_syntax += "~n " + ls_object + ".Background.Mode='2'"
			
			ls_displayonly = Lower(adw.Describe(ls_object + ".Edit.DisplayOnly"))
			If ls_displayonly = 'yes' Then
				ls_syntax += "~n " + ls_object + ".Background.Color='0~trgb(174,189,218)'"
			Else
				If Integer(adw.Describe(ls_object + ".tabsequence")) = 0 Then 
					ls_syntax += "~n " + ls_object + ".Background.Color='0~trgb(174,189,218)'"
				Else
					string ls_ObjStyleType
					ls_ObjStyleType =Lower(adw.Describe(ls_object+".Edit.Style"))
					If ls_ObjStyleType = 'radiobuttons' or ls_ObjStyleType = 'checkbox' THen 
						ls_syntax += "~n " + ls_object + ".Background.Color='0~trgb(174,189,218)'"
					ELse
						ls_syntax += "~n " + ls_object + ".Background.Color='0~trgb(255,255,255)'"
					End if
				End If
			End If
			
		CASE ELSE

	END CHOOSE
	ls_syntax = adw.Modify(ls_syntax)
	ls_syntax = ""
LOOP


adw.setRedraw(TRUE)

end subroutine

public function integer of_get_addr (string as_zipcode, ref string as_zipaddr);// 리턴받은 우편번호에 대한 우편주소를 확인한다.

String	ls_err_text
Integer	li_err_code

SELECT		TRIM(A.ZIP_NAME1) || ' ' || TRIM(A.ZIP_NAME2) || ' '|| TRIM(A.ZIP_NAME3)
  INTO		:as_zipaddr
  FROM		HAKSA.ZIPCODES A
 WHERE	A.ZIP_ID = :as_zipcode
USING SQLCA ;

Choose Case	SQLCA.SQLCODE
	Case	-1
		gf_sqlerr_msg(THIS.Classname(), 'of_get_addr', String(31), 'SELECT ZIP_ADDRESS FROM HAKSA.ZIPCODES', li_err_code, ls_err_text)
		Return -1
	Case	100
		Return 0
	Case	0
		Return 1
End Choose
end function

on n_func.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_func.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// 공통코드 list retrieve
//IF not isValid(ids) THEN ids = CREATE Datastore
//ids.dataobject = "d_dddw_code"
//ids.SetTransObject(sqlca)
//ids.Retrieve()
//
Post Event ue_constructor()

end event

