$PBExportHeader$cuo_cal.sru
$PBExportComments$수식
forward
global type cuo_cal from commandbutton
end type
end forward

global type cuo_cal from commandbutton
integer width = 247
integer height = 108
integer taborder = 1
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "none"
end type
global cuo_cal cuo_cal

type variables
dec    DVAL[101]
dec	 id_qty, id_price
string OPER
end variables

forward prototypes
public function integer in_fix_get_oper (string gongsik)
public function integer in_fix_move_oper (integer n_op)
public function integer in_fix_move_dval (integer n_val)
public function boolean in_fix_cal (ref decimal dval1, decimal dval2, string operand)
public function integer in_fix_operand ()
public function decimal in_fix_compute (string gongsik)
end prototypes

public function integer in_fix_get_oper (string gongsik);
int i

OPER=''
FOR i=1 TO len(gongsik)
   IF pos("0123456789.+-*/()",mid(gongsik,i,1)) > 0 THEN
      OPER += mid(gongsik,i,1);
   END IF
NEXT
OPER += "="

return 1
end function

public function integer in_fix_move_oper (integer n_op);string temp,temp1

temp = mid(OPER,1,n_op - 2)
temp1= mid(OPER,n_op + 2,len(OPER))
OPER = temp + 'v' + temp1

return 1


end function

public function integer in_fix_move_dval (integer n_val);DO WHILE n_val+1 < 100
   DVAL[n_val] = DVAL[n_val+1]
   n_val++;
LOOP

return 1
end function

public function boolean in_fix_cal (ref decimal dval1, decimal dval2, string operand);CHOOSE CASE operand
	CASE "*"
		dval1 *= dval2
	CASE "/"
      IF dval2<>0 THEN  dval1 /= dval2
	CASE "+"
		dval1 += dval2
	CASE "-"
		dval1 -= dval2
   CASE ELSE
      Return False
END CHOOSE

Return True

end function

public function integer in_fix_operand ();
int  k, i,n_op,s_op,e_op, &
     n_level,s_level,e_level, &
     check_galho,n_val,lenval, &      
     loop_count 


  loop_count = 0;
  
For k = 1 To 10
	
  loop_count++
  lenval = Len(OPER);
  if lenval=1 then    Return  1;
  if lenval=0 OR lenval=2 then  Return  -1;
  if loop_count>200       then  Return  -3;    // 공식에러,무한루프 

  check_galho =0;
  s_op =1; e_op =lenval;
  n_level =0;  s_level =0; e_level=0;

  FOR i=1 TO lenval
      IF mid(OPER,i,1)='(' THEN
         n_level ++;
         check_galho =1;
         IF n_level>s_level THEN
             s_op =i+1;
             s_level =n_level;
         END IF
      ELSEIF mid(OPER,i,1)=')' THEN
         if n_level>e_level THEN  
            e_op   =i - 1; 
            e_level=n_level;
         END IF
         n_level --;
      END IF
  NEXT
  IF n_level<>0 THEN   Return -2;  // 괄호 짝이 틀림 
  
  id_qty 	= DVAL[1]
  id_price 	= DVAL[2]

// ==========================현위치부터 연산  *,/ =============
  n_val=1; 
  FOR i=1 TO s_op - 1
     IF mid(OPER,i,1) ='v' THEN n_val++
  NEXT
  FOR n_op=s_op TO e_op - 1
     IF mid(OPER,n_op,1)='*'  OR   mid(OPER,n_op,1)='/' THEN
        in_fix_cal(DVAL[n_val - 1],DVAL[n_val],mid(OPER,n_op,1));
        in_fix_move_dval(n_val);
        in_fix_move_oper(n_op);
        n_op --
        e_op =e_op - 2;
     ELSEIF mid(OPER,n_op,1)='v' THEN
        n_val ++
     END IF
  NEXT
//==========================현위치부터 연산  +,- =============
  n_val=1; 
  FOR i=1 TO s_op - 1
     IF mid(OPER,i,1) ='v' THEN n_val++
  NEXT
  FOR n_op=s_op TO e_op - 1
     IF mid(OPER,n_op,1)='+'  OR   mid(OPER,n_op,1)='-' THEN
        in_fix_cal(DVAL[n_val - 1],DVAL[n_val],mid(OPER,n_op,1));
        in_fix_move_dval(n_val);
        in_fix_move_oper(n_op);
        n_op --;
        e_op =e_op - 2;
     ELSEIF mid(OPER,n_op,1)='v' THEN
        n_val++
     END IF
  NEXT
//======================================================
  IF check_galho=1 THEN in_fix_move_oper(s_op);

 k = 2
Next 

Return 1
end function

public function decimal in_fix_compute (string gongsik);string   Temp,out
double   val_dval,Biyul
int      top_dval, top_out,  cnt_oper, top_oper
int      sw      , sw_code,  val     , count   
int      len,len1,i,j,k,rtn 
boolean  button 

  Temp = Trim(gongsik)
  IF len(Temp)<1 THEN  Return 0

  in_fix_get_oper(gongsik);
  out ='';
  top_out =1; val=0; sw=0;
  top_dval=1;

  FOR cnt_oper=1 TO len(OPER)
    IF pos('0123456789.',mid(OPER,cnt_oper,1))>0 THEN
       sw=1;  val++;
    ELSEIF pos('*/+-()=',mid(OPER,cnt_oper,1))>0 THEN
       IF sw=1 THEN
          out += 'v';
          temp =mid(OPER,(cnt_oper - val),val);
          DVAL[top_dval] = Dec(temp);
          top_dval++;
       END IF
       out += mid(OPER,cnt_oper,1);
       sw=0; val=0;
    END IF
  NEXT
  OPER = mid(out,1,(Len(out)-1));
  rtn =in_fix_operand();
 
 CHOOSE CASE rtn
	CASE -1
//		dval[1] = 0  2003/12/01
		dval[1] = dval[1] * -1
		return	dval[1]
	CASE -2
		Messagebox('확인','공식에러입니다. 괄호 확인하세요');
	CASE -3
		Messagebox('확인','공식에러입니다.');
 END CHOOSE

IF rtn<>1 THEN   Return -1

Return DVAL[1]

end function

on cuo_cal.create
end on

on cuo_cal.destroy
end on

