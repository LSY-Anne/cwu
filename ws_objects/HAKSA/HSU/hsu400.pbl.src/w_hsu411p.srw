$PBExportHeader$w_hsu411p.srw
$PBExportComments$[청운대]강의실별강의시간표
forward
global type w_hsu411p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hsu411p
end type
type cbx_1 from checkbox within w_hsu411p
end type
type dw_con from uo_dwfree within w_hsu411p
end type
end forward

global type w_hsu411p from w_condition_window
dw_main dw_main
cbx_1 cbx_1
dw_con dw_con
end type
global w_hsu411p w_hsu411p

type variables
datawindowchild ldwc_hjmod
end variables

forward prototypes
public subroutine wf_siganpyo (string as_year, string as_hakgi, string as_sigan, string as_sigan_value, integer al_row, string as_head_1, string as_head_2)
end prototypes

public subroutine wf_siganpyo (string as_year, string as_hakgi, string as_sigan, string as_sigan_value, integer al_row, string as_head_1, string as_head_2);//시간표에 Setting		   
string ls_sigan, ls_set

dw_main.object.t_year.text		=	as_year
dw_main.object.t_hakgi.text	=	as_hakgi

dw_main.object.head_1[al_row]	=	as_head_1
dw_main.object.head_2[al_row]	=	as_head_2

//ls_sigan = dw_main.GetItemString(al_row, as_sigan)
//
//If isNull(ls_sigan) Or ls_sigan = '' Then
//	ls_set	= as_sigan_value
//Else
//	ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//End If		
//
//dw_main.SetItem(al_row, as_sigan, ls_set)
//
//CHOOSE CASE as_sigan	
//		
//	CASE 'a1'
//		ls_sigan = dw_main.object.a1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		
//		dw_main.object.a1[al_row] =  ls_set
//		 
//	CASE 'a2'
//		ls_sigan = dw_main.object.a2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		
//	 	dw_main.object.a2[al_row] =  ls_set
//	CASE 'a3'
//		ls_sigan = dw_main.object.a3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a3[al_row] =  ls_set
//		
//	CASE 'a4'
//		ls_sigan = dw_main.object.a4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a4[al_row] =  ls_set
//		
//	CASE 'a5'
//		ls_sigan = dw_main.object.a5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.a5[al_row] =  ls_set
//		
//	CASE 'a6'
//		ls_sigan = dw_main.object.a6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a6[al_row] =  ls_set
//		
//	CASE 'a7'
//		ls_sigan = dw_main.object.a7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a7[al_row] =  ls_set
//		
//	CASE 'a8'
//		ls_sigan = dw_main.object.a8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a8[al_row] =  ls_set
//		
//	CASE 'a9'
//		ls_sigan = dw_main.object.a9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a9[al_row] =  ls_set
//		
//	CASE 'a10'
//		ls_sigan = dw_main.object.a10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a10[al_row] =  ls_set
//		
//	CASE 'a11'
//		ls_sigan = dw_main.object.a11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a11[al_row] =  ls_set
//		
//	CASE 'a12'
//		ls_sigan = dw_main.object.a12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a12[al_row] =  ls_set
//		
//	CASE 'a13'
//		ls_sigan = dw_main.object.a13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a13[al_row] =  ls_set
//		
//	CASE 'a14'
//		ls_sigan = dw_main.object.a4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a14[al_row] =  ls_set
//	
//	CASE 'b1'
//		ls_sigan = dw_main.object.b1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b1[al_row] =  ls_set
//		
//	CASE 'b2'
//		ls_sigan = dw_main.object.b2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b2[al_row] =  ls_set
//		
//	CASE 'b3'
//		ls_sigan = dw_main.object.b3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b3[al_row] =  ls_set
//		
//	CASE 'b4'
//		ls_sigan = dw_main.object.b4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b4[al_row] =  ls_set
//		
//	CASE 'b5'
//		ls_sigan = dw_main.object.b5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b5[al_row] =  ls_set
//		
//	CASE 'b6'
//		ls_sigan = dw_main.object.b6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b6[al_row] =  ls_set
//		
//	CASE 'b7'
//		ls_sigan = dw_main.object.b7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b7[al_row] =  ls_set
//		
//	CASE 'b8'
//		ls_sigan = dw_main.object.b8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b8[al_row] =  ls_set
//		
//	CASE 'b9'
//		ls_sigan = dw_main.object.b9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b9[al_row] =  ls_set
//		
//	CASE 'b10'
//		ls_sigan = dw_main.object.b10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b10[al_row] =  ls_set
//		
//	CASE 'b11'
//		ls_sigan = dw_main.object.b11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b11[al_row] =  ls_set
//		
//	CASE 'b12'
//		ls_sigan = dw_main.object.b12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b12[al_row] =  ls_set
//		
//	CASE 'b13'
//		ls_sigan = dw_main.object.b13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b13[al_row] =  ls_set
//		
//	CASE 'b14'
//		ls_sigan = dw_main.object.b14[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b14[al_row] =  ls_set	
//		
//	CASE 'c1'
//		ls_sigan = dw_main.object.c1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c1[al_row] =  ls_set
//		
//	CASE 'c2'
//		ls_sigan = dw_main.object.c2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c2[al_row] =  ls_set
//		
//	CASE 'c3'
//		ls_sigan = dw_main.object.c3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c3[al_row] =  ls_set
//		
//	CASE 'c4'
//		ls_sigan = dw_main.object.c4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c4[al_row] =  ls_set
//		
//	CASE 'c5'
//		ls_sigan = dw_main.object.c5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c5[al_row] =  ls_set
//		
//	CASE 'c6'
//		ls_sigan = dw_main.object.c6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c6[al_row] =  ls_set
//		
//	CASE 'c7'
//		ls_sigan = dw_main.object.c7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c7[al_row] =   ls_set
//		
//	CASE 'c8'
//		ls_sigan = dw_main.object.c8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c8[al_row] =  ls_set
//		
//	CASE 'c9'
//		ls_sigan = dw_main.object.c9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c9[al_row] =  ls_set
//		
//	CASE 'c10'
//		ls_sigan = dw_main.object.c10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c10[al_row] =  ls_set
//		
//	CASE 'c11'
//		ls_sigan = dw_main.object.c11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c11[al_row] =  ls_set
//		
//	CASE 'c12'
//		ls_sigan = dw_main.object.c12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c12[al_row] =  ls_set
//		
//	CASE 'c13'
//		ls_sigan = dw_main.object.c13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c13[al_row] =  ls_set
//		
//	CASE 'c14'
//		ls_sigan = dw_main.object.c14[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c14[al_row] =  ls_set
//		
//	
//	CASE 'd1'
//		ls_sigan = dw_main.object.d1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d1[al_row] =  ls_set
//		
//	CASE 'd2'
//		ls_sigan = dw_main.object.d2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d2[al_row] =  ls_set
//		
//	CASE 'd3'
//		ls_sigan = dw_main.object.d3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d3[al_row] =  ls_set
//		
//	CASE 'd4'
//		ls_sigan = dw_main.object.d4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d4[al_row] =  ls_set
//		
//	CASE 'd5'
//		ls_sigan = dw_main.object.d5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d5[al_row] =  ls_set
//		
//	CASE 'd6'
//		ls_sigan = dw_main.object.d6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d6[al_row] =  ls_set
//		
//	CASE 'd7'
//		ls_sigan = dw_main.object.d7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d7[al_row] =  ls_set
//		
//	CASE 'd8'
//		ls_sigan = dw_main.object.d8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d8[al_row] =  ls_set
//		
//	CASE 'd9'
//		ls_sigan = dw_main.object.d9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d9[al_row] =  ls_set
//		
//	CASE 'd10'
//		ls_sigan = dw_main.object.d10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d10[al_row] =  ls_set
//		
//	CASE 'd11'
//		ls_sigan = dw_main.object.d11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d11[al_row] =  ls_set
//		
//	CASE 'd12'
//		ls_sigan = dw_main.object.d12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d12[al_row] =  ls_set
//		
//	CASE 'd13'
//		ls_sigan = dw_main.object.d13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d13[al_row] =  ls_set
//		
//	CASE 'd14'
//		ls_sigan = dw_main.object.d14[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d14[al_row] =  ls_set
//		
//		
//	CASE 'e1'
//		ls_sigan = dw_main.object.e1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e1[al_row] =  ls_set
//		
//	CASE 'e2'
//		ls_sigan = dw_main.object.e2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e2[al_row] =  ls_set
//		
//	CASE 'e3'
//		ls_sigan = dw_main.object.e3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e3[al_row] =  ls_set
//		
//	CASE 'e4'
//		ls_sigan = dw_main.object.e4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e4[al_row] =  ls_set
//		
//	CASE 'e5'	
//		ls_sigan = dw_main.object.e5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e5[al_row] =  ls_set
//		
//	CASE 'e6'
//		ls_sigan = dw_main.object.e6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e6[al_row] =  ls_set
//		
//	CASE 'e7'
//		ls_sigan = dw_main.object.e7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e7[al_row] =  ls_set
//		
//	CASE 'e8'
//		ls_sigan = dw_main.object.e8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e8[al_row] =  ls_set
//		
//	CASE 'e9'
//		ls_sigan = dw_main.object.e9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e9[al_row] =  ls_set
//		
//	CASE 'e10'
//		ls_sigan = dw_main.object.e10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e10[al_row] =  ls_set
//		
//	CASE 'e11'
//		ls_sigan = dw_main.object.e11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e11[al_row] =  ls_set
//		
//	CASE 'e12'
//		ls_sigan = dw_main.object.e12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e12[al_row] =  ls_set
//		
//	CASE 'e13'
//		ls_sigan = dw_main.object.e13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e13[al_row] =  ls_set
//		
//	CASE 'e14'
//		ls_sigan = dw_main.object.e14[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e14[al_row] =  ls_set
//	
//	CASE 'f1'
//		ls_sigan = dw_main.object.f1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f1[al_row] =  ls_set
//		
//	CASE 'f2'
//		ls_sigan = dw_main.object.f2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f2[al_row] =  ls_set
//		
//	CASE 'f3'
//		ls_sigan = dw_main.object.f3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f3[al_row] =  ls_set
//		
//	CASE 'f4'
//		ls_sigan = dw_main.object.f4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f4[al_row] =  ls_set
//		
//	CASE 'f5'
//		ls_sigan = dw_main.object.f5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f5[al_row] =  ls_set
//		
//	CASE 'f6'
//		ls_sigan = dw_main.object.f6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//	  	dw_main.object.f6[al_row] =  ls_set
//		  
//	CASE 'f7'
//		ls_sigan = dw_main.object.f7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//	  	dw_main.object.f7[al_row] =  ls_set
//		  
//	CASE 'f6'
//		ls_sigan = dw_main.object.f8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f8[al_row] =  ls_set
//		
//	CASE 'f9'
//		ls_sigan = dw_main.object.f9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f9[al_row] =  ls_set
//		
//	CASE 'f10'
//		ls_sigan = dw_main.object.f10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f10[al_row] =  ls_set
//		
//	CASE 'f11'
//		ls_sigan = dw_main.object.f11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f11[al_row] =  ls_set
//		
//	CASE 'f12'
//		ls_sigan = dw_main.object.f12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f12[al_row] =  ls_set
//		
//	CASE 'f13'
//		ls_sigan = dw_main.object.f13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f13[al_row] =  ls_set
//		
//	CASE 'f14'
//		ls_sigan = dw_main.object.f14[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f14[al_row] =  ls_set	
//		
//		
//END CHOOSE
end subroutine

on w_hsu411p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.cbx_1=create cbx_1
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.cbx_1
this.Control[iCurrent+3]=this.dw_con
end on

on w_hsu411p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.cbx_1)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()
end event

event ue_retrieve;string	ls_year, ls_hakgi, ls_hosil
integer	count=0
long		ll_newrow=0

string	ls_prof_name, ls_gwamok_name, ls_gwa_name, ls_sigan, ls_tot, ls_inwon
integer	li_row

dw_main.reset()

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_hosil    	=  func.of_nvl(dw_con.Object.room_code[1], '%')

SetPointer(HourGlass!)

//개설 강의실 수만큼 
DECLARE CUR_PROF CURSOR FOR 
SELECT	B.HOSIL_CODE
FROM	HAKSA.GAESUL_GWAMOK	A,
		HAKSA.SIGANPYO			B
WHERE	A.YEAR			=	B.YEAR
AND	A.HAKGI			=	B.HAKGI
AND	A.GWA				=	B.GWA
AND	A.HAKYUN			=	B.HAKYUN
AND	A.BAN				=	B.BAN
AND	A.GWAMOK_ID		=	B.GWAMOK_ID
AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
AND	A.BUNBAN			=	B.BUNBAN
AND	A.YEAR			=		:ls_year
AND	A.HAKGI			=		:ls_hakgi
AND	B.HOSIL_CODE	like	trim(:ls_hosil)
AND	(A.PYEGANG_YN	=	'N' OR A.PYEGANG_YN IS NULL)
AND	B.HOSIL_CODE IS NOT NULL
GROUP BY B.HOSIL_CODE
USING SQLCA ;

OPEN CUR_PROF	;
DO
	FETCH CUR_PROF	INTO	:ls_hosil	;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	li_row = dw_main.insertrow(0)
	
	//해당 강의실의 시간수만큼 돌면서 해당시간에 자료입력
	DECLARE	CUR_SIGAN	CURSOR FOR
	SELECT	C.GWAMOK_HNAME,
				NVL(D.NAME, '미정'),
				E.SNAME,
				B.YOIL||B.SIGAN
	FROM	HAKSA.GAESUL_GWAMOK	A,
			HAKSA.SIGANPYO			B,
			HAKSA.GWAMOK_CODE		C,
			HAKSA.PROF_SYM			D,
			HAKSA.GWA_SYM			E
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
	AND	A.MEMBER_NO		=	D.MEMBER_NO(+)
	AND	A.GWA				=	TRIM(E.GWA)
	AND	A.YEAR			=	:ls_year
	AND	A.HAKGI			=	:ls_hakgi
	AND	B.HOSIL_CODE	=	trim(:ls_hosil)
	AND	( A.PYEGANG_YN	=	'N' OR A.PYEGANG_YN IS NULL)	
	USING SQLCA ;
	
	OPEN CUR_SIGAN	;
	DO
		FETCH	CUR_SIGAN	INTO	:ls_gwamok_name, :ls_prof_name, :ls_gwa_name, :ls_sigan	;
		
		IF SQLCA.SQLCODE = -1 THEN
			MESSAGEBOX("오류", "조회중 오류발생~R~N" + SQLCA.SQLERRTEXT)
			RETURN -1
		ELSEIF SQLCA.SQLCODE = 100 THEN
			EXIT
		END IF
		
		ls_tot	=	ls_gwamok_name + '~r' + ls_prof_name + '~r' + ls_gwa_name + '~r'
		
		SELECT	TO_CHAR(ROOM_INWON)
		INTO	:ls_inwon
		FROM	STDB.HST242M
		WHERE	ROOM_CODE = :ls_hosil 
		USING SQLCA ;
		
		wf_siganpyo(ls_year, ls_hakgi, ls_sigan, ls_tot, li_row, ls_hosil, ls_inwon)
				
	LOOP WHILE TRUE
	CLOSE CUR_SIGAN	;
	
LOOP WHILE TRUE
CLOSE	CUR_PROF	;

dw_main.Modify("datawindow.print.preview=yes")

dw_main.setfocus()

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu411p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu411p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu411p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu411p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu411p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu411p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu411p
end type

type uc_insert from w_condition_window`uc_insert within w_hsu411p
end type

type uc_delete from w_condition_window`uc_delete within w_hsu411p
end type

type uc_save from w_condition_window`uc_save within w_hsu411p
end type

type uc_excel from w_condition_window`uc_excel within w_hsu411p
end type

type uc_print from w_condition_window`uc_print within w_hsu411p
end type

type st_line1 from w_condition_window`st_line1 within w_hsu411p
end type

type st_line2 from w_condition_window`st_line2 within w_hsu411p
end type

type st_line3 from w_condition_window`st_line3 within w_hsu411p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu411p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu411p
end type

type gb_1 from w_condition_window`gb_1 within w_hsu411p
end type

type gb_2 from w_condition_window`gb_2 within w_hsu411p
end type

type dw_main from uo_search_dwc within w_hsu411p
integer x = 59
integer y = 296
integer width = 4370
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu400p_11"
end type

type cbx_1 from checkbox within w_hsu411p
integer x = 2363
integer y = 192
integer width = 297
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31577551
string text = "축소판"
end type

event clicked;if this.checked = true then
	dw_main.dataobject = 'd_hsu400p_11_small'	
	dw_main.settransobject(sqlca)
	dw_main.Modify("datawindow.print.preview=yes") 
	
else
	dw_main.dataobject = 'd_hsu400p_11'	
	dw_main.settransobject(sqlca)
	dw_main.Modify("datawindow.print.preview=yes") 
	
end if
end event

type dw_con from uo_dwfree within w_hsu411p
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 20
string dataobject = "d_hsu411p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

