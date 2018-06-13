$PBExportHeader$w_hsu105a.srw
$PBExportComments$[청운대]시간표입력
forward
global type w_hsu105a from w_condition_window
end type
type dw_2 from datawindow within w_hsu105a
end type
type st_7 from statictext within w_hsu105a
end type
type dw_main from uo_input_dwc within w_hsu105a
end type
type dw_con from uo_dwfree within w_hsu105a
end type
type uo_1 from uo_imgbtn within w_hsu105a
end type
end forward

global type w_hsu105a from w_condition_window
integer width = 4507
dw_2 dw_2
st_7 st_7
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hsu105a w_hsu105a

type variables
long 		il_row, il_seq_no, il_gwamok_seq
string 	is_year, is_hakgi, is_gwa,	is_hakyun, is_ban, is_bunban
string	is_member_no,  is_hosil, is_ban_bunhap
string	is_chk, is_gwamok, is_gwamok_name

end variables

forward prototypes
public subroutine sigan_set (string as_sigan, string as_sigan_value)
public subroutine clear_sigan (string p_suup)
public subroutine wf_siganpyo (string as_year, string as_hakgi, string as_gwa, string as_hakyun, string as_ban)
end prototypes

public subroutine sigan_set (string as_sigan, string as_sigan_value);//시간표에 Setting		   
string ls_sigan, ls_set

ls_sigan = dw_2.GetitemString(1, as_sigan)

If isNull(ls_sigan) Or ls_sigan = '' Then
	ls_set = as_sigan_value
Else
	ls_set = ls_sigan + '~n' + as_sigan_value
End If

dw_2.SetItem(1, as_sigan, ls_set)

//CHOOSE CASE as_sigan	
//		
//	CASE 'a1'
//		ls_sigan = dw_2.object.a1[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		
//		dw_2.object.a1[1] =  ls_set
//		 
//	CASE 'a2'
//		ls_sigan = dw_2.object.a2[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		
//	 	dw_2.object.a2[1] =  ls_set
//	CASE 'a3'
//		ls_sigan = dw_2.object.a3[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a3[1] =  ls_set
//		
//	CASE 'a4'
//		ls_sigan = dw_2.object.a4[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a4[1] =  ls_set
//		
//	CASE 'a5'
//		ls_sigan = dw_2.object.a5[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.a5[1] =  ls_set
//		
//	CASE 'a6'
//		ls_sigan = dw_2.object.a6[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a6[1] =  ls_set
//		
//	CASE 'a7'
//		ls_sigan = dw_2.object.a7[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a7[1] =  ls_set
//		
//	CASE 'a8'
//		ls_sigan = dw_2.object.a8[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a8[1] =  ls_set
//		
//	CASE 'a9'
//		ls_sigan = dw_2.object.a9[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a9[1] =  ls_set
//		
//	CASE 'a10'
//		ls_sigan = dw_2.object.a10[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a10[1] =  ls_set
//		
//	CASE 'a11'
//		ls_sigan = dw_2.object.a11[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a11[1] =  ls_set
//		
//	CASE 'a12'
//		ls_sigan = dw_2.object.a12[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a12[1] =  ls_set
//		
//	CASE 'a13'
//		ls_sigan = dw_2.object.a13[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a13[1] =  ls_set
//		
//	CASE 'a14'
//		ls_sigan = dw_2.object.a14[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.a14[1] =  ls_set
//	
//	CASE 'b1'
//		ls_sigan = dw_2.object.b1[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b1[1] =  ls_set
//		
//	CASE 'b2'
//		ls_sigan = dw_2.object.b2[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b2[1] =  ls_set
//		
//	CASE 'b3'
//		ls_sigan = dw_2.object.b3[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b3[1] =  ls_set
//		
//	CASE 'b4'
//		ls_sigan = dw_2.object.b4[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b4[1] =  ls_set
//		
//	CASE 'b5'
//		ls_sigan = dw_2.object.b5[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b5[1] =  ls_set
//		
//	CASE 'b6'
//		ls_sigan = dw_2.object.b6[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b6[1] =  ls_set
//		
//	CASE 'b7'
//		ls_sigan = dw_2.object.b7[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b7[1] =  ls_set
//		
//	CASE 'b8'
//		ls_sigan = dw_2.object.b8[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b8[1] =  ls_set
//		
//	CASE 'b9'
//		ls_sigan = dw_2.object.b9[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b9[1] =  ls_set
//		
//	CASE 'b10'
//		ls_sigan = dw_2.object.b10[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b10[1] =  ls_set
//		
//	CASE 'b11'
//		ls_sigan = dw_2.object.b11[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b11[1] =  ls_set
//		
//	CASE 'b12'
//		ls_sigan = dw_2.object.b12[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b12[1] =  ls_set
//		
//	CASE 'b13'
//		ls_sigan = dw_2.object.b13[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b13[1] =  ls_set
//		
//	CASE 'b14'
//		ls_sigan = dw_2.object.b14[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.b14[1] =  ls_set	
//		
//	CASE 'c1'
//		ls_sigan = dw_2.object.c1[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.c1[1] =  ls_set
//		
//	CASE 'c2'
//		ls_sigan = dw_2.object.c2[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.c2[1] =  ls_set
//		
//	CASE 'c3'
//		ls_sigan = dw_2.object.c3[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.c3[1] =  ls_set
//		
//	CASE 'c4'
//		ls_sigan = dw_2.object.c4[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.c4[1] =  ls_set
//		
//	CASE 'c5'
//		ls_sigan = dw_2.object.c5[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.c5[1] =  ls_set
//		
//	CASE 'c6'
//		ls_sigan = dw_2.object.c6[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if		
//		dw_2.object.c6[1] =  ls_set
//		
//	CASE 'c7'
//		ls_sigan = dw_2.object.c7[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.c7[1] =   ls_set
//		
//	CASE 'c8'
//		ls_sigan = dw_2.object.c8[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.c8[1] =  ls_set
//		
//	CASE 'c9'
//		ls_sigan = dw_2.object.c9[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.c9[1] =  ls_set
//		
//	CASE 'c10'
//		ls_sigan = dw_2.object.c10[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.c10[1] =  ls_set
//		
//	CASE 'c11'
//		ls_sigan = dw_2.object.c11[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.c11[1] =  ls_set
//		
//	CASE 'c12'
//		ls_sigan = dw_2.object.c12[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.c12[1] =  ls_set
//		
//	CASE 'c13'
//		ls_sigan = dw_2.object.c13[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.c13[1] =  ls_set
//		
//	CASE 'c14'
//		ls_sigan = dw_2.object.c14[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.c14[1] =  ls_set
//		
//	
//	CASE 'd1'
//		ls_sigan = dw_2.object.d1[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d1[1] =  ls_set
//		
//	CASE 'd2'
//		ls_sigan = dw_2.object.d2[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d2[1] =  ls_set
//		
//	CASE 'd3'
//		ls_sigan = dw_2.object.d3[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d3[1] =  ls_set
//		
//	CASE 'd4'
//		ls_sigan = dw_2.object.d4[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d4[1] =  ls_set
//		
//	CASE 'd5'
//		ls_sigan = dw_2.object.d5[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d5[1] =  ls_set
//		
//	CASE 'd6'
//		
//		//messagebox("a", as_sigan + '  -  ' + as_sigan_value)
//		ls_sigan = dw_2.object.d6[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d6[1] =  ls_set
//		
//	CASE 'd7'
//		ls_sigan = dw_2.object.d7[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d7[1] =  ls_set
//		
//	CASE 'd8'
//		ls_sigan = dw_2.object.d8[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d8[1] =  ls_set
//		
//	CASE 'd9'
//		ls_sigan = dw_2.object.d9[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d9[1] =  ls_set
//		
//	CASE 'd10'
//		ls_sigan = dw_2.object.d10[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d10[1] =  ls_set
//		
//	CASE 'd11'
//		ls_sigan = dw_2.object.d11[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d11[1] =  ls_set
//		
//	CASE 'd12'
//		ls_sigan = dw_2.object.d12[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d12[1] =  ls_set
//		
//	CASE 'd13'
//		ls_sigan = dw_2.object.d13[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d13[1] =  ls_set
//		
//	CASE 'd14'
//		ls_sigan = dw_2.object.d14[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.d14[1] =  ls_set
//		
//		
//	CASE 'e1'
//		ls_sigan = dw_2.object.e1[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e1[1] =  ls_set
//		
//	CASE 'e2'
//		ls_sigan = dw_2.object.e2[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e2[1] =  ls_set
//		
//	CASE 'e3'
//		ls_sigan = dw_2.object.e3[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e3[1] =  ls_set
//		
//	CASE 'e4'
//		ls_sigan = dw_2.object.e4[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e4[1] =  ls_set
//		
//	CASE 'e5'	
//		ls_sigan = dw_2.object.e5[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e5[1] =  ls_set
//		
//	CASE 'e6'
//		ls_sigan = dw_2.object.e6[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e6[1] =  ls_set
//		
//	CASE 'e7'
//		ls_sigan = dw_2.object.e7[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e7[1] =  ls_set
//		
//	CASE 'e8'
//		ls_sigan = dw_2.object.e8[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e8[1] =  ls_set
//		
//	CASE 'e9'
//		ls_sigan = dw_2.object.e9[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e9[1] =  ls_set
//		
//	CASE 'e10'
//		ls_sigan = dw_2.object.e10[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e10[1] =  ls_set
//		
//	CASE 'e11'
//		ls_sigan = dw_2.object.e11[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e11[1] =  ls_set
//		
//	CASE 'e12'
//		ls_sigan = dw_2.object.e12[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e12[1] =  ls_set
//		
//	CASE 'e13'
//		ls_sigan = dw_2.object.e13[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e13[1] =  ls_set
//		
//	CASE 'e14'
//		ls_sigan = dw_2.object.e14[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.e14[1] =  ls_set
//	
//	CASE 'f1'
//		ls_sigan = dw_2.object.f1[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f1[1] =  ls_set
//		
//	CASE 'f2'
//		ls_sigan = dw_2.object.f2[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f2[1] =  ls_set
//		
//	CASE 'f3'
//		ls_sigan = dw_2.object.f3[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f3[1] =  ls_set
//		
//	CASE 'f4'
//		ls_sigan = dw_2.object.f4[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f4[1] =  ls_set
//		
//	CASE 'f5'
//		ls_sigan = dw_2.object.f5[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f5[1] =  ls_set
//		
//	CASE 'f6'
//		ls_sigan = dw_2.object.f6[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//	  	dw_2.object.f6[1] =  ls_set
//		  
//	CASE 'f7'
//		ls_sigan = dw_2.object.f7[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//	  	dw_2.object.f7[1] =  ls_set
//		  
//	CASE 'f8'
//		ls_sigan = dw_2.object.f8[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f8[1] =  ls_set
//		
//	CASE 'f9'
//		ls_sigan = dw_2.object.f9[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f9[1] =  ls_set
//		
//	CASE 'f10'
//		ls_sigan = dw_2.object.f10[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f10[1] =  ls_set
//		
//	CASE 'f11'
//		ls_sigan = dw_2.object.f11[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f11[1] =  ls_set
//		
//	CASE 'f12'
//		ls_sigan = dw_2.object.f12[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f12[1] =  ls_set
//		
//	CASE 'f13'
//		ls_sigan = dw_2.object.f13[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f13[1] =  ls_set
//		
//	CASE 'f14'
//		ls_sigan = dw_2.object.f14[1]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~n' + as_sigan_value
//		end if
//		dw_2.object.f14[1] =  ls_set	
//		
//		
//END CHOOSE
end subroutine

public subroutine clear_sigan (string p_suup);//시간표에도 지워주는 로직..			   

dw_2.SetItem(1, p_suup, '')

//CHOOSE CASE p_suup
//	CASE 'a1'
//	 	dw_2.object.a1[1] =  ''
//	CASE 'a2'
//	 	dw_2.object.a2[1] =  ''
//	CASE 'a3'
//		dw_2.object.a3[1] =  ''
//	CASE 'a4'
//		dw_2.object.a4[1] =  ''
//	CASE 'a5'
//		dw_2.object.a5[1] =  ''
//	CASE 'a6'
//		dw_2.object.a6[1] =  ''
//	CASE 'a7'
//		dw_2.object.a7[1] =  ''
//	CASE 'a8'
//		dw_2.object.a8[1] =  ''
//	CASE 'a9'
//		dw_2.object.a9[1] =  ''
//	CASE 'a10'
//		dw_2.object.a10[1] =  ''
//	
//	CASE 'b1'
//		dw_2.object.b1[1] =  ''
//	CASE 'b2'
//		dw_2.object.b2[1] =  ''
//	CASE 'b3'
//		dw_2.object.b3[1] =  ''
//	CASE 'b4'
//		dw_2.object.b4[1] =  ''
//	CASE 'b5'
//		dw_2.object.b5[1] =  ''
//	CASE 'b6'
//		dw_2.object.b6[1] =  ''
//	CASE 'b7'
//		dw_2.object.b7[1] =  ''
//	CASE 'b8'
//		dw_2.object.b8[1] =  ''
//	CASE 'b9'
//		dw_2.object.b9[1] =  ''
//	CASE 'b10'
//		dw_2.object.b10[1] =  ''
//	
//	CASE 'c1'
//		dw_2.object.c1[1] =  ''
//	CASE 'c2'
//		dw_2.object.c2[1] =  ''
//	CASE 'c3'
//		dw_2.object.c3[1] =  ''
//	CASE 'c4'
//		dw_2.object.c4[1] =  ''
//	CASE 'c5'
//		dw_2.object.c5[1] =  ''
//	CASE 'c6'
//		dw_2.object.c6[1] =  ''
//	CASE 'c7'
//		dw_2.object.c7[1] =   ''
//	CASE 'c8'
//		dw_2.object.c8[1] =  ''
//	CASE 'c9'
//		dw_2.object.c9[1] =  ''
//	CASE 'c10'
//		dw_2.object.c10[1] =  ''
//	
//	CASE 'd1'
//		dw_2.object.d1[1] =  ''
//	CASE 'd2'
//		dw_2.object.d2[1] =  ''
//	CASE 'd3'
//		dw_2.object.d3[1] =  ''
//	CASE 'd4'
//		dw_2.object.d4[1] =  ''
//	CASE 'd5'
//		dw_2.object.d5[1] =  ''
//	CASE 'd6'
//		dw_2.object.d6[1] =  ''
//	CASE 'd7'
//		dw_2.object.d7[1] =  ''
//	CASE 'd8'
//		dw_2.object.d8[1] =  ''
//	CASE 'd9'
//		dw_2.object.d9[1] =  ''
//	CASE 'd10'
//		dw_2.object.d10[1] =  ''
//	
//	CASE 'e1'
//		dw_2.object.e1[1] =  ''
//	CASE 'e2'
//		dw_2.object.e2[1] =  ''
//	CASE 'e3'
//		dw_2.object.e3[1] =  ''
//	CASE 'e4'
//		dw_2.object.e4[1] =  ''
//	CASE 'e5'	
//		dw_2.object.e5[1] =  ''
//	CASE 'e6'
//		dw_2.object.e6[1] =  ''
//	CASE 'e7'
//		dw_2.object.e7[1] =  ''
//	CASE 'e8'
//		dw_2.object.e8[1] =  ''
//	CASE 'e9'
//		dw_2.object.e9[1] =  ''
//	CASE 'e10'
//		dw_2.object.e10[1] =  ''
//	
//	CASE 'f1'
//		dw_2.object.f1[1] =  ''
//	CASE 'f2'
//		dw_2.object.f2[1] =  ''
//	CASE 'f3'
//		dw_2.object.f3[1] =  ''
//	CASE 'f4'
//		dw_2.object.f4[1] =  ''
//	CASE 'f5'
//		dw_2.object.f5[1] =  ''
//	CASE 'f6'
//	  	dw_2.object.f6[1] =  ''
//	CASE 'f7'
//	  	dw_2.object.f7[1] =  ''
//	CASE 'f6'
//		dw_2.object.f8[1] =  ''
//	CASE 'f9'
//		dw_2.object.f9[1] =  ''
//	CASE 'f10'
//		dw_2.object.f10[1] =  ''
//END CHOOSE
end subroutine

public subroutine wf_siganpyo (string as_year, string as_hakgi, string as_gwa, string as_hakyun, string as_ban);string ls_gwamok, ls_prof, ls_sigan, ls_set, ls_hosil, ls_hosil_name


DECLARE	CUR_SIGAN CURSOR FOR
SELECT	C.GWAMOK_HNAME,
			NVL(D.NAME, '-미정-'),
			A.YOIL||A.SIGAN,
			nvl(A.HOSIL_CODE, '-미정-')
FROM	HAKSA.SIGANPYO			A,
		HAKSA.GAESUL_GWAMOK	B,
		HAKSA.GWAMOK_CODE		C,
		HAKSA.PROF_SYM			D
WHERE	A.YEAR			=	B.YEAR
AND	A.HAKGI			=	B.HAKGI
AND	A.GWA				=	B.GWA
AND	A.HAKYUN			=	B.HAKYUN
AND	A.BAN				=	B.BAN
AND	A.GWAMOK_ID		=	B.GWAMOK_ID
AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
AND	A.BUNBAN			=	B.BUNBAN
AND	A.GWAMOK_ID		=	C.GWAMOK_ID
AND	A.GWAMOK_SEQ	=	C.GWAMOK_SEQ
AND	B.MEMBER_NO		=	D.MEMBER_NO(+)
AND	A.YEAR			=	:as_year
AND	A.HAKGI			=	:as_hakgi
AND	A.GWA				=	:as_gwa	
AND	A.HAKYUN			=	:as_hakyun
AND	A.BAN				=	:as_ban
AND	A.YOIL	IS NOT NULL
USING SQLCA ;

OPEN CUR_SIGAN	;
DO
	FETCH	CUR_SIGAN INTO	:ls_gwamok, :ls_prof, :ls_sigan, :ls_hosil	;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	

	//호실가져옴
	SELECT  	HST242M.ROOM_NAME     
	INTO		:ls_hosil_name
	FROM 		STDB.HST242M 
	WHERE		HST242M.ROOM_CODE	=	:ls_hosil
	USING SQLCA ;
	
		
	ls_set = ls_gwamok + '~n' + ls_prof + '(' + ls_hosil_name + ')'
	
	sigan_set(ls_sigan, ls_set)
		
LOOP WHILE TRUE
CLOSE CUR_SIGAN ;
end subroutine

on w_hsu105a.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_7=create st_7
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_7
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.dw_con
this.Control[iCurrent+5]=this.uo_1
end on

on w_hsu105a.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.st_7)
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;string	ls_year, ls_hakyun, ls_hakgi, ls_ban, ls_gwa
int 	 	li_ans
long		ll_i

//조회조건
dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakyun	=	dw_con.Object.hakyun[1]
ls_gwa		=	dw_con.Object.gwa[1]
ls_ban         =  dw_con.Object.ban[1]

if	(Isnull(ls_year) or ls_year = "") or (Isnull(ls_hakyun) or ls_hakyun = "")  or (Isnull(ls_hakgi) or ls_hakgi = "") or (Isnull(ls_gwa) or ls_gwa = "") or (Isnull(ls_gwa) or ls_ban = "" )then
	messagebox("확인", "검색조건을 모두 입력하세요.")
	dw_con.SetFocus()
	return -1
end if

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)

dw_2.reset()
ll_i = dw_2.insertrow(0)

wf_siganpyo(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	//uf_messagebox(7)

elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return -1
end if

Return 1
end event

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
dw_con.Object.hakyun[1] =  '1'
dw_con.Object.ban[1]      =  'A'

dw_2.settransobject(sqlca)
dw_2.insertrow(0)
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu105a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu105a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu105a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu105a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu105a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu105a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu105a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu105a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu105a
end type

type uc_save from w_condition_window`uc_save within w_hsu105a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu105a
end type

type uc_print from w_condition_window`uc_print within w_hsu105a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu105a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu105a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu105a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu105a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu105a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu105a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu105a
integer taborder = 90
end type

type dw_2 from datawindow within w_hsu105a
integer x = 2158
integer y = 296
integer width = 2272
integer height = 1964
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hsu100a_5_2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;this.retrieve()

end event

event doubleclicked;/*-----------------------------------------------------------------
	1. 지정된 시간을 삭제하기 위한 script...
-----------------------------------------------------------------*/
string  	ls_year, ls_hakyun, ls_hakgi, ls_ban, ls_juya, ls_gwa, ls_gwamok_id, ls_member_no
string  	ls_col, ls_col_temp, ls_yoil, ls_sigan, ls_check_sigan

long 		ll_start, ll_mess, ll_select_row

//-------   검색조건 가져옴   ----------

dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakyun	=	dw_con.Object.hakyun[1]
ls_gwa		=	dw_con.Object.gwa[1]
ls_ban         =  dw_con.Object.ban[1]

/*--------------------------------------------------------------------------------
	1. 수업시간코드 가져옴 (external의 각 컬럼값이 수업시간임 예) a1, a2, a3,.....)
---------------------------------------------------------------------------------*/
ls_col 	=	dwo.name 
ls_yoil	=	mid(ls_col, 1, 1)				//요일
ls_sigan	=	trim(mid(ls_col, 2, 2))		//시간

/*--------------------------------------------------------------------------------
	2. 더블클릭한 수업시간을 시간표 테이블에서 update...
---------------------------------------------------------------------------------*/

UPDATE	HAKSA.SIGANPYO
SET		YOIL	=	null,
			SIGAN	=	null
WHERE	YEAR		=	:ls_year
AND	HAKGI		=	:ls_hakgi
AND	GWA		=	:ls_gwa
AND	HAKYUN	=	:ls_hakyun
AND	BAN		=	:ls_ban
AND	YOIL		=	:ls_yoil
AND	SIGAN		=	:ls_sigan	
USING SQLCA;

if sqlca.sqlcode <> 0 then
	messagebox("오류","작업중 오류가 발생되었습니다.(2)~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA;
	return
end if


/*--------------------------------------------------------------------------------
	3. 개설과목 에서 해당 시간 삭제
---------------------------------------------------------------------------------*/
UPDATE	HAKSA.GAESUL_GWAMOK
SET		SIGAN =  null
WHERE		YEAR		=	:ls_year
AND		HAKGI		=	:ls_hakgi
AND		GWA		=	:ls_gwa
AND		HAKYUN	=	:ls_hakyun
AND		BAN		=	:ls_ban
AND		GWAMOK_ID||GWAMOK_SEQ = (
												SELECT	GWAMOK_ID||GWAMOK_SEQ
												FROM	HAKSA.SIGANPYO
												WHERE	YEAR		=	:ls_year
												AND	HAKGI		=	:ls_hakgi
												AND	GWA		=	:ls_gwa
												AND	HAKYUN	=	:ls_hakyun
												AND	BAN		=	:ls_ban
												AND	YOIL		=	:ls_yoil
												AND	SIGAN		=	:ls_sigan )
 USING SQLCA;

if sqlca.sqlcode <> 0 then
	messagebox("오류","작업중 오류가 발생되었습니다.(3)~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA;
	return
end if


commit USING SQLCA;
/*--------------------------------------------------------------------------------
	1. 데이터윈도우에서 지우는 함수
---------------------------------------------------------------------------------*/
clear_sigan(ls_col)				
		
dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)

end event

event dragdrop;/*------------------------------------------------------------------------------
		1. drag하여 놓았을때 처리되는 Script
		2. 시간표 입력시 Error Check 및 입력된 과목 및 교수를 Display함.
------------------------------------------------------------------------------*/
string 	ls_year, ls_hakyun, ls_hakgi, ls_ban, ls_juya, ls_gwa, ls_member_no, ls_hosil_name, ls_bunban, ls_member_name
String	ls_yoil, ls_sigan
int		li_dup_check, li_rtn
long		ll_seq_no, ll_gwamok_seq

string ls_before_suup,ls_after_suup,ls_suup,ls_su1,ls_su2
string ls_gwamok, ls_hosil, ls_gang_gubun, ls_hapban
string ls_tot, ls_chk

string   lll_member_no, lll_sigan, lll_gwamok, lll_bunban, lll_yoil, lll_room_name, lll_gwamok_name, lll_yoil_na
string   lll_hosil
integer  lll_gwamok_seq


// ************************************************************
//            드래그했던 자료들을 가져옴
// ************************************************************
ls_year        = is_year					// 년도
ls_hakgi       = is_hakgi          		// 학기
ls_gwa      	= is_gwa            		// 학부코드
ls_hakyun      = is_hakyun         		// 학년
ls_ban         = is_ban            		// 반(과목이 개설된 반)

ls_gwamok      = is_gwamok        		// 과목코드
ll_gwamok_seq  = il_gwamok_seq     		// 과목순번
ls_bunban		= is_bunban					// 분반(과목의 분반)	

ls_member_no   = is_member_no				// 담당교수
ll_seq_no	   = il_seq_no         		// 시수의 차수
ls_hosil       = is_hosil          		// 강의실코드

ls_suup        = DWO.NAME          			// drop했을때의 컬럼명 (ex: a11)
ls_yoil        = trim(mid(ls_suup,1,1))  	// 컬럼명의 요일부분 (ex: a, b, c)
ls_sigan       = trim(mid(ls_suup,2,2))  	// 컬럼명의 교시부분 (ex: 1, 2, 3)
ls_after_suup  = ls_suup   				  	// dw_2컬럼명의 요일+교시부분 (ex: a1, a2, a3...)
//ls_before_suup = trim(is_yoil + is_sigan)	// dw_main에서 rbuttondown했을때 컬럼명의 요일+교시부분

//ls_ban_bunhap  = is_ban_bunhap     		// 합반여부 (0:일반, 1:합반, 2:분반)

// ************************************************************
//            DragObject 선언 및 초기화
// ************************************************************

DragObject 	ldo_which_control      					//dragobject 선언
Datawindow 	ldw                    					//datawindow 선언
ldo_which_control = ldw           					//dragobject 초기화
ldo_which_control = DraggedObject()  

/*-------------------------------------------------------------------------------------
		1. drag한 object가 datawindow인지 
--------------------------------------------------------------------------------------*/
if TypeOf(ldo_which_control) = Datawindow! then
	ldw = ldo_which_control
	
	//1. 선택한 과목이 이미 선택한 시간에 배정이 되었는지 확인
	SELECT	YEAR
	INTO	:ls_chk
	FROM	HAKSA.SIGANPYO
	WHERE	YEAR			=	:ls_year
	AND	HAKGI			=	:ls_hakgi
	AND	GWA			=	:ls_gwa
	AND	HAKYUN		=	:ls_hakyun
	AND	BAN			=	:ls_ban
	AND	GWAMOK_ID	=	:ls_gwamok
	AND	GWAMOK_SEQ	=	:ll_gwamok_seq
	AND	BUNBAN		=	:ls_bunban
	AND	YOIL			=	:ls_yoil
	AND	SIGAN			=	:ls_sigan 
	AND	ROWNUM		=	1				;
	
	SELECT	GWAMOK_ID, BUNBAN, YOIL, SIGAN, GWAMOK_SEQ
		INTO	:lll_gwamok, :lll_bunban, :lll_yoil, :lll_sigan, :lll_gwamok_seq
		FROM	HAKSA.SIGANPYO
		WHERE	YEAR			=	:ls_year
		AND	HAKGI			=	:ls_hakgi
		AND	YOIL			=	:ls_yoil
		AND   HOSIL_code  =  :ls_hosil
		AND	SIGAN			=	:ls_sigan
		AND   ROWNUM = 1 USING SQLCA;
		
		SELECT 	B.MEMBER_NO
			INTO	:lll_member_no
			FROM 	HAKSA.SIGANPYO			A,
					HAKSA.GAESUL_GWAMOK	B
			WHERE	A.YEAR			=	B.YEAR
			AND	A.HAKGI			=	B.HAKGI
			AND	A.GWAMOK_ID		=	B.GWAMOK_ID
//			AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
			AND	A.BUNBAN			=	B.BUNBAN
			AND	A.YEAR			=	:ls_year
			AND 	A.HAKGI 			=	:ls_hakgi
			AND 	A.YOIL			=	:ls_yoil
			AND 	A.SIGAN			=	:ls_sigan
			AND	ROWNUM = 1 USING SQLCA;
			
		
		SELECT  	ROOM_NAME
		INTO		:lll_room_name
		FROM 		STDB.HST242M 
		WHERE		ROOM_CODE = :lll_hosil;  	
		
		SELECT  	GWAMOK_HNAME
		INTO		:lll_gwamok_name
		FROM 		HAKSA.GWAMOK_CODE  
		WHERE		GWAMOK_ID	=	:lll_gwamok
		AND		GWAMOK_SEQ	=	:lll_gwamok_seq;		
		
		CHOOSE CASE lll_yoil
			CASE 'a'
				lll_yoil_na = '월요일' 
			CASE 'b'
				lll_yoil_na = '화요일' 
			CASE 'c'
				lll_yoil_na = '수요일' 
			CASE 'd'
				lll_yoil_na = '목요일' 
			CASE 'e'
				lll_yoil_na = '금요일' 
		END CHOOSE 
		
	if sqlca.sqlcode = 0 then
	   IF messagebox("확인","<< 교강사 중복 >> 학수번호간의 교강사 중복이 발생했습니다.~r~n~r~n" +&
										"중복학수번호 : "+lll_gwamok + lll_bunban + "[ "+lll_gwamok_name+" ]~r~n"+&
										"중복교강사    : "+lll_member_no+"~r~n"         +&
										"중복요일       : "+lll_yoil_na+"~r~n"       +&
										"중복시간       : "+lll_sigan+"교시"+"~r~n"+&
										"계속하시겠습니까? ", Question!, YesNO!, 2) = 2 then
				return
	   end if
	END IF
			
	
	//합반이면 교수 및 시간중복체크를 하지 않음.
	if is_ban_bunhap = '2' then
		
	else
			//2. 해당시간에 이미 등록한 교수가 있는 지를 확인한다.
			//		교수가 입력되어 있지 않으면 체크하지 않음.
			if isnull(ls_member_no) or ls_member_no = '' then
				
			else
				SELECT 	A.YEAR
				INTO	:ls_chk
				FROM 	HAKSA.SIGANPYO			A,
						HAKSA.GAESUL_GWAMOK	B
				WHERE	A.YEAR			=	B.YEAR
				AND	A.HAKGI			=	B.HAKGI
				AND	A.GWA				=	B.GWA
				AND	A.HAKYUN			=	B.HAKYUN
				AND	A.BAN				=	B.BAN
				AND	A.GWAMOK_ID		=	B.GWAMOK_ID
				AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
				AND	A.BUNBAN			=	B.BUNBAN
				AND	A.YEAR			=	:ls_year
				AND 	A.HAKGI 			=	:ls_hakgi
				AND	B.MEMBER_NO		=	:ls_member_no
				AND 	A.YOIL			=	:ls_yoil
				AND 	A.SIGAN			=	:ls_sigan	;
		
				if sqlca.sqlcode = 0 then
					messagebox("시간표입력 error","해당시간에 이미 등록된 교수입니다!")
					return
				end if		
				
			end if
	
		//3. 강의실 중복체크
		SELECT	YEAR
		INTO	:ls_chk
		FROM	HAKSA.SIGANPYO
		WHERE	YEAR			=	:ls_year
		AND	HAKGI			=	:ls_hakgi
		AND	HOSIL_CODE	=	:ls_hosil
		AND	YOIL			=	:ls_yoil
		AND	SIGAN			=	:ls_sigan 
		AND	ROWNUM		=	1				;
		
		if sqlca.sqlcode = 0 then
			messagebox("확인","타과목과 강의실이 중복됩니다.")
			return
		end if	
		
	end if
	

// ************************************************************
//      dw_main에서 드래그해온 정보에 대해서 처리 (입력용)
// ************************************************************
	if is_chk = "dw_main" then
		
//		MESSAGEBOX("년도학기", ls_year + '   ' + ls_hakgi)
//		MESSAGEBOX("과", ls_gwa)
//		MESSAGEBOX("학년", ls_hakyun)
//		MESSAGEBOX("반", ls_ban)
//		MESSAGEBOX("과목", ls_gwamok)
//		MESSAGEBOX("시", ll_gwamok_seq)
//		MESSAGEBOX("", ls_ban)
//		MESSAGEBOX("", ll_seq_no)
		
		
		UPDATE	HAKSA.SIGANPYO
		SET		YOIL			= 	:ls_yoil, 
					SIGAN			= 	:ls_sigan
		WHERE		YEAR			=	:ls_year
		AND		HAKGI			= 	:ls_hakgi
		AND		GWA			=	:ls_gwa
		AND		HAKYUN		= 	:ls_hakyun
		AND		BAN			=	:ls_ban
		AND		GWAMOK_ID	=	:ls_gwamok
		AND		GWAMOK_SEQ	=	:ll_gwamok_seq
		AND		BUNBAN		=	:ls_bunban
		AND		SEQ_NO		=	:ll_seq_no 	;
		
				
		if	sqlca.sqlcode	<> 0	then
			messagebox("오류", "오류발생(1)~R~N" + sqlca.sqlerrtext)
			rollback;
			return
			
		else
			COMMIT USING SQLCA ;
			
		end if
			
		//교수명 가져옴 
		select	name
		into		:ls_member_name
		from		indb.hin001m  
		where		member_no	= :ls_member_no   ;
		
		//호실가져옴
		SELECT  	HST242M.ROOM_NAME     
		INTO		:ls_hosil_name
		FROM 		STDB.HST242M 
		WHERE		HST242M.ROOM_CODE	=	:ls_hosil	;

		ls_tot	=	is_gwamok_name + '~r' + ls_member_name + '(' + ls_hosil_name + ')'
		
		sigan_set(ls_after_suup, ls_tot)
						
		li_rtn = uf_gaesul_sigan(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ll_gwamok_seq, ls_bunban)
					
		if li_rtn = -1 then
			messagebox("오류","개설과목 시간 입력중 오류발생~r~n" + sqlca.sqlerrtext)
			rollback ;
			return
			
		else
			commit ;
		end if
			
	end if	
			
end if


dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban)
dw_main.setfocus()

end event

event rbuttondown;///*---------------------------------------------------------------------------
//		1. 마우스 오른쪽 버튼을 클릭함과 동시에 처리되는 Script (수정용)
//----------------------------------------------------------------------------*/
////dw_2.drag(begin!)
// 
//is_chk = "dw_2"      // 데이타윈도우 구분용으로 사용하며, 나중에 수정용임을 표시하기 위한 것임.
//                     // 참고로, dw_2는 입력용임을 뜻함.
////is_col2 = dwo.Name //오른쪽 마우스버튼을  클릭한 datawindow의 column명 저장!
end event

type st_7 from statictext within w_hsu105a
integer x = 55
integer y = 292
integer width = 2075
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "요일/시간이 확정되지 않은 시간표"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_main from uo_input_dwc within w_hsu105a
integer x = 59
integer y = 380
integer width = 2066
integer height = 1884
integer taborder = 80
string dragicon = "..\BMP\project.ico"
boolean bringtotop = true
string dataobject = "d_hsu100a_5_1"
end type

event itemchanged;call super::itemchanged;dw_main.accepttext()
dw_main.update()
commit;
end event

event rbuttondown;//******************************************************************************//
//  내    용 : 마우스 오른쪽 버튼을 클릭함과 동시에 처리되는 Script
//******************************************************************************//
string	ls_year, ls_hakyun, ls_hakgi, ls_ban, ls_juya, ls_gwa, ls_gwamok, ls_member_no

// ************************************************************
//                검 색 조 건  가 져 옴 
// ************************************************************
dw_con.accepttext()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hakyun	=	dw_con.Object.hakyun[1]
ls_gwa		=	dw_con.Object.gwa[1]
ls_ban         =  dw_con.Object.ban[1]

il_row 		= row   							//현재row의 위치를 il_row(instance 변수)에 저장

// ************************************************************
//                선택한 row에 대한 처리
// ************************************************************
if il_row > 0 then
	
//	dw_main.SelectRow(0, false)  							// 선택한 row을 반전처리
//	dw_main.SelectRow(il_row, true)
	
   // 선택한 row에 대한 여러정보를 저장함.
	is_year       = this.object.year[row]
	is_hakgi      = this.object.hakgi[row]
	is_gwa        = this.object.gwa[row]
   is_hakyun     = this.object.hakyun[row]
	is_ban        = this.object.ban[row]
	is_bunban     = this.object.bunban[row]
	
	is_gwamok     = this.object.gwamok_id[row]
	il_gwamok_seq = this.object.gwamok_seq[row]
   	
	is_member_no  = this.object.member_no[row]
	
	il_seq_no     = this.object.seq_no[row]
	is_hosil      = this.object.hosil_code[row]
	is_ban_bunhap = this.object.ban_bunhap[row]


   //호실 입력여부 확인	
	if isnull(is_hosil) = true then
		//이부분 체크해서 토의해야 함.
		messagebox("확인","강의실을 선택하십시요!")
	else
		// 호실 입력이 되었을 때, 과목명과 교수명을 가져옴	
		dw_main.drag(begin!)
	   is_chk = "dw_main"  // 데이터윈도우 구분용으로 사용하며, 나중에 입력용임을 표시하기 위한 것임.
		                 // 참고로, dw_3은 수정용을 뜻함.

		//과목명 가져옴 
		select	gwamok_hname  
		into		:is_gwamok_name
		from  	haksa.gwamok_code
		where 	gwamok_id  = :is_gwamok
		and		gwamok_seq = :il_gwamok_seq
		using sqlca;

	end if
end if

end event

type dw_con from uo_dwfree within w_hsu105a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hsu105a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hsu105a
integer x = 626
integer y = 44
integer width = 645
integer taborder = 90
boolean bringtotop = true
string btnname = "개설정보조회"
end type

event clicked;call super::clicked;str_parms s_parms

dw_con.accepttext()

s_parms.s[1] 	= dw_con.Object.year[1]
s_parms.s[2] 	= dw_con.Object.hakgi[1]
s_parms.s[3] 	= dw_con.Object.gwa[1]
s_parms.s[4] 	= dw_con.Object.hakyun[1]
s_parms.s[5]	= dw_con.Object.ban[1]

openwithparm(w_hsu105a_p, s_parms)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

