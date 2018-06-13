$PBExportHeader$w_hsu201a.srw
$PBExportComments$[청운대]수강신청
forward
global type w_hsu201a from w_condition_window
end type
type st_9 from statictext within w_hsu201a
end type
type st_10 from statictext within w_hsu201a
end type
type st_8 from statictext within w_hsu201a
end type
type st_11 from statictext within w_hsu201a
end type
type uo_1 from uo_imgbtn within w_hsu201a
end type
type dw_main from uo_dwfree within w_hsu201a
end type
type dw_2 from uo_dwfree within w_hsu201a
end type
type dw_3 from uo_dwfree within w_hsu201a
end type
type st_2 from statictext within w_hsu201a
end type
type dw_con from uo_dwfree within w_hsu201a
end type
end forward

global type w_hsu201a from w_condition_window
integer width = 4507
st_9 st_9
st_10 st_10
st_8 st_8
st_11 st_11
uo_1 uo_1
dw_main dw_main
dw_2 dw_2
dw_3 dw_3
st_2 st_2
dw_con dw_con
end type
global w_hsu201a w_hsu201a

type variables
string 	is_hakbun, is_hakyun, is_gwa, is_jungjung, is_sangtae

end variables

forward prototypes
public subroutine wf_sigan_set (string p_sigan)
public subroutine wf_sigan_clear ()
public subroutine wf_sigan_set_click (string p_sigan)
public subroutine wf_siganpyo (string p_year, string p_hakgi, string p_hakbun)
public subroutine sugangsave_season (string p_hakbun, string p_year, string p_hakgi, string p_gwa, string p_hakyun, string p_ban, string p_gwamok, long p_gwamok_seq, string p_bunban)
public subroutine sugangdelete (string p_hakbun, string p_year, string p_hakgi, string p_gwa, string p_hakyun, string p_ban, string p_gwamok, integer p_gwamok_seq, string p_bunban)
public subroutine sugangsave (string p_hakbun, string p_year, string p_hakgi, string p_gwa, string p_hakyun, string p_ban, string p_gwamok, long p_gwamok_seq, string p_bunban)
end prototypes

public subroutine wf_sigan_set (string p_sigan);//시간표에 Setting		   

dw_3.Modify(p_sigan + ".Background.Color='" + String(RGB(128,0,128)) + "'")

//CHOOSE CASE p_sigan	
//		
//	CASE 'a1'
//		dw_3.object.a1.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a2'
//		dw_3.object.a2.Background.Color = RGB(128, 0, 128)
//				
//	CASE 'a3'
//		dw_3.object.a3.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a4'
//		dw_3.object.a4.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a5'
//		dw_3.object.a5.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a6'
//		dw_3.object.a6.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a7'
//		dw_3.object.a7.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a8'
//		dw_3.object.a8.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a9'
//		dw_3.object.a9.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a10'
//		dw_3.object.a10.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a11'
//		dw_3.object.a11.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a12'
//		dw_3.object.a12.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a13'
//		dw_3.object.a13.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'a14'
//		dw_3.object.a14.Background.Color = RGB(128, 0, 128)
//	
//	CASE 'b1'
//		dw_3.object.b1.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b2'
//		dw_3.object.b2.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b3'
//		dw_3.object.b3.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b4'
//		dw_3.object.b4.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b5'
//		dw_3.object.b5.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b6'
//		dw_3.object.b6.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b7'
//		dw_3.object.b7.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b8'
//		dw_3.object.b8.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b9'
//		dw_3.object.b9.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b10'
//		dw_3.object.b10.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b11'
//		dw_3.object.b11.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b12'
//		dw_3.object.b12.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b13'
//		dw_3.object.b13.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'b14'
//		dw_3.object.b14.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c1'
//		dw_3.object.c1.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c2'
//		dw_3.object.c2.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c3'
//		dw_3.object.c3.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c4'
//		dw_3.object.c4.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c5'
//		dw_3.object.c5.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c6'
//		dw_3.object.c6.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c7'
//		dw_3.object.c7.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c8'
//		dw_3.object.c8.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c9'
//		dw_3.object.c9.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c10'
//		dw_3.object.c10.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c11'
//		dw_3.object.c11.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c12'
//		dw_3.object.c12.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c13'
//		dw_3.object.c13.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'c14'
//		dw_3.object.c14.Background.Color = RGB(128, 0, 128)
//			
//	CASE 'd1'
//		dw_3.object.d1.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd2'
//		dw_3.object.d2.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd3'
//		dw_3.object.d3.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd4'
//		dw_3.object.d4.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd5'
//		dw_3.object.d5.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd6'
//		dw_3.object.d6.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd7'
//		dw_3.object.d7.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd8'
//		dw_3.object.d8.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd9'
//		dw_3.object.d9.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd10'
//		dw_3.object.d10.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd11'
//		dw_3.object.d11.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd12'
//		dw_3.object.d12.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd13'
//		dw_3.object.d13.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'd14'
//		dw_3.object.d14.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e1'
//		dw_3.object.e1.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e2'
//		dw_3.object.e2.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e3'
//		dw_3.object.e3.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e4'
//		dw_3.object.e4.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e5'	
//		dw_3.object.e5.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e6'
//		dw_3.object.e6.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e7'
//		dw_3.object.e7.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e8'
//		dw_3.object.e8.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e9'
//		dw_3.object.e9.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e10'
//		dw_3.object.e10.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e11'
//		dw_3.object.e11.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e12'
//		dw_3.object.e12.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e13'
//		dw_3.object.e13.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'e14'
//		dw_3.object.e14.Background.Color = RGB(128, 0, 128)
//	
//	CASE 'f1'
//		dw_3.object.f1.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f2'
//		dw_3.object.f2.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f3'
//		dw_3.object.f3.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f4'
//		dw_3.object.f4.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f5'
//		dw_3.object.f5.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f6'
//		dw_3.object.f6.Background.Color = RGB(128, 0, 128)
//		  
//	CASE 'f7'
//		dw_3.object.f7.Background.Color = RGB(128, 0, 128)
//		  
//	CASE 'f8'
//		dw_3.object.f8.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f9'
//		dw_3.object.f9.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f10'
//		dw_3.object.f10.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f11'
//		dw_3.object.f11.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f12'
//		dw_3.object.f12.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f13'
//		dw_3.object.f13.Background.Color = RGB(128, 0, 128)
//		
//	CASE 'f14'
//		dw_3.object.f14.Background.Color = RGB(128, 0, 128)		
//		
//END CHOOSE
//







end subroutine

public subroutine wf_sigan_clear ();//시간표에 Setting		   
String	ls_p_sigan
Integer	i

For i = 1 To 14
	ls_p_sigan = 'a'+String(i)
	dw_3.Modify(ls_p_sigan + ".Background.Color='" + String(RGB(192,192,192)) + "'")
Next
For i = 1 To 14
	ls_p_sigan = 'b'+String(i)
	dw_3.Modify(ls_p_sigan + ".Background.Color='" + String(RGB(192,192,192)) + "'")
Next
For i = 1 To 14
	ls_p_sigan = 'c'+String(i)
	dw_3.Modify(ls_p_sigan + ".Background.Color='" + String(RGB(192,192,192)) + "'")
Next
For i = 1 To 14
	ls_p_sigan = 'd'+String(i)
	dw_3.Modify(ls_p_sigan + ".Background.Color='" + String(RGB(192,192,192)) + "'")
Next
For i = 1 To 14
	ls_p_sigan = 'e'+String(i)
	dw_3.Modify(ls_p_sigan + ".Background.Color='" + String(RGB(192,192,192)) + "'")
Next
For i = 1 To 14
	ls_p_sigan = 'f'+String(i)
	dw_3.Modify(ls_p_sigan + ".Background.Color='" + String(RGB(192,192,192)) + "'")
Next

//dw_3.object.a1.Background.Color = RGB(192, 192, 192)
//dw_3.object.a2.Background.Color = RGB(192, 192, 192)
//dw_3.object.a3.Background.Color = RGB(192, 192, 192)
//dw_3.object.a4.Background.Color = RGB(192, 192, 192)
//dw_3.object.a5.Background.Color = RGB(192, 192, 192)
//dw_3.object.a6.Background.Color = RGB(192, 192, 192)
//dw_3.object.a7.Background.Color = RGB(192, 192, 192)
//dw_3.object.a8.Background.Color = RGB(192, 192, 192)
//dw_3.object.a9.Background.Color = RGB(192, 192, 192)
//dw_3.object.a10.Background.Color = RGB(192, 192, 192)
//dw_3.object.a11.Background.Color = RGB(192, 192, 192)
//dw_3.object.a12.Background.Color = RGB(192, 192, 192)
//dw_3.object.a13.Background.Color = RGB(192, 192, 192)
//dw_3.object.a14.Background.Color = RGB(192, 192, 192)
//dw_3.object.b1.Background.Color = RGB(192, 192, 192)
//dw_3.object.b2.Background.Color = RGB(192, 192, 192)
//dw_3.object.b3.Background.Color = RGB(192, 192, 192)
//dw_3.object.b4.Background.Color = RGB(192, 192, 192)
//dw_3.object.b5.Background.Color = RGB(192, 192, 192)
//dw_3.object.b6.Background.Color = RGB(192, 192, 192)
//dw_3.object.b7.Background.Color = RGB(192, 192, 192)
//dw_3.object.b8.Background.Color = RGB(192, 192, 192)
//dw_3.object.b9.Background.Color = RGB(192, 192, 192)
//dw_3.object.b10.Background.Color = RGB(192, 192, 192)
//dw_3.object.b11.Background.Color = RGB(192, 192, 192)
//dw_3.object.b12.Background.Color = RGB(192, 192, 192)
//dw_3.object.b13.Background.Color = RGB(192, 192, 192)
//dw_3.object.b14.Background.Color = RGB(192, 192, 192)
//dw_3.object.c1.Background.Color = RGB(192, 192, 192)
//dw_3.object.c2.Background.Color = RGB(192, 192, 192)
//dw_3.object.c3.Background.Color = RGB(192, 192, 192)
//dw_3.object.c4.Background.Color = RGB(192, 192, 192)
//dw_3.object.c5.Background.Color = RGB(192, 192, 192)
//dw_3.object.c6.Background.Color = RGB(192, 192, 192)
//dw_3.object.c7.Background.Color = RGB(192, 192, 192)
//dw_3.object.c8.Background.Color = RGB(192, 192, 192)
//dw_3.object.c9.Background.Color = RGB(192, 192, 192)
//dw_3.object.c10.Background.Color = RGB(192, 192, 192)
//dw_3.object.c11.Background.Color = RGB(192, 192, 192)
//dw_3.object.c12.Background.Color = RGB(192, 192, 192)
//dw_3.object.c13.Background.Color = RGB(192, 192, 192)
//dw_3.object.c14.Background.Color = RGB(192, 192, 192)
//dw_3.object.d1.Background.Color = RGB(192, 192, 192)
//dw_3.object.d2.Background.Color = RGB(192, 192, 192)
//dw_3.object.d3.Background.Color = RGB(192, 192, 192)
//dw_3.object.d4.Background.Color = RGB(192, 192, 192)
//dw_3.object.d5.Background.Color = RGB(192, 192, 192)
//dw_3.object.d6.Background.Color = RGB(192, 192, 192)
//dw_3.object.d7.Background.Color = RGB(192, 192, 192)
//dw_3.object.d8.Background.Color = RGB(192, 192, 192)
//dw_3.object.d9.Background.Color = RGB(192, 192, 192)
//dw_3.object.d10.Background.Color = RGB(192, 192, 192)
//dw_3.object.d11.Background.Color = RGB(192, 192, 192)
//dw_3.object.d12.Background.Color = RGB(192, 192, 192)
//dw_3.object.d13.Background.Color = RGB(192, 192, 192)
//dw_3.object.d14.Background.Color = RGB(192, 192, 192)
//dw_3.object.e1.Background.Color = RGB(192, 192, 192)
//dw_3.object.e2.Background.Color = RGB(192, 192, 192)
//dw_3.object.e3.Background.Color = RGB(192, 192, 192)
//dw_3.object.e4.Background.Color = RGB(192, 192, 192)
//dw_3.object.e5.Background.Color = RGB(192, 192, 192)
//dw_3.object.e6.Background.Color = RGB(192, 192, 192)
//dw_3.object.e7.Background.Color = RGB(192, 192, 192)
//dw_3.object.e8.Background.Color = RGB(192, 192, 192)
//dw_3.object.e9.Background.Color = RGB(192, 192, 192)
//dw_3.object.e10.Background.Color = RGB(192, 192, 192)
//dw_3.object.e11.Background.Color = RGB(192, 192, 192)
//dw_3.object.e12.Background.Color = RGB(192, 192, 192)
//dw_3.object.e13.Background.Color = RGB(192, 192, 192)
//dw_3.object.e14.Background.Color = RGB(192, 192, 192)
//dw_3.object.f1.Background.Color = RGB(192, 192, 192)
//dw_3.object.f2.Background.Color = RGB(192, 192, 192)
//dw_3.object.f3.Background.Color = RGB(192, 192, 192)
//dw_3.object.f4.Background.Color = RGB(192, 192, 192)
//dw_3.object.f5.Background.Color = RGB(192, 192, 192)
//dw_3.object.f6.Background.Color = RGB(192, 192, 192)
//dw_3.object.f7.Background.Color = RGB(192, 192, 192)
//dw_3.object.f8.Background.Color = RGB(192, 192, 192)
//dw_3.object.f9.Background.Color = RGB(192, 192, 192)
//dw_3.object.f10.Background.Color = RGB(192, 192, 192)
//dw_3.object.f11.Background.Color = RGB(192, 192, 192)
//dw_3.object.f12.Background.Color = RGB(192, 192, 192)
//dw_3.object.f13.Background.Color = RGB(192, 192, 192)
//dw_3.object.f14.Background.Color = RGB(192, 192, 192)		

end subroutine

public subroutine wf_sigan_set_click (string p_sigan);//시간표에 Setting		   

dw_3.Modify(p_sigan + ".Background.Color='" + String(RGB(0,255,255)) + "'")

//CHOOSE CASE p_sigan	
//		
//	CASE 'a1'
//		dw_3.object.a1.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a2'
//		dw_3.object.a2.Background.Color = RGB(0, 255, 255)
//				
//	CASE 'a3'
//		dw_3.object.a3.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a4'
//		dw_3.object.a4.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a5'
//		dw_3.object.a5.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a6'
//		dw_3.object.a6.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a7'
//		dw_3.object.a7.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a8'
//		dw_3.object.a8.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a9'
//		dw_3.object.a9.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a10'
//		dw_3.object.a10.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a11'
//		dw_3.object.a11.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a12'
//		dw_3.object.a12.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a13'
//		dw_3.object.a13.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'a14'
//		dw_3.object.a14.Background.Color = RGB(0, 255, 255)
//	
//	CASE 'b1'
//		dw_3.object.b1.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b2'
//		dw_3.object.b2.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b3'
//		dw_3.object.b3.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b4'
//		dw_3.object.b4.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b5'
//		dw_3.object.b5.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b6'
//		dw_3.object.b6.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b7'
//		dw_3.object.b7.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b8'
//		dw_3.object.b8.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b9'
//		dw_3.object.b9.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b10'
//		dw_3.object.b10.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b11'
//		dw_3.object.b11.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b12'
//		dw_3.object.b12.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b13'
//		dw_3.object.b13.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'b14'
//		dw_3.object.b14.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c1'
//		dw_3.object.c1.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c2'
//		dw_3.object.c2.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c3'
//		dw_3.object.c3.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c4'
//		dw_3.object.c4.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c5'
//		dw_3.object.c5.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c6'
//		dw_3.object.c6.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c7'
//		dw_3.object.c7.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c8'
//		dw_3.object.c8.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c9'
//		dw_3.object.c9.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c10'
//		dw_3.object.c10.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c11'
//		dw_3.object.c11.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c12'
//		dw_3.object.c12.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c13'
//		dw_3.object.c13.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'c14'
//		dw_3.object.c14.Background.Color = RGB(0, 255, 255)
//			
//	CASE 'd1'
//		dw_3.object.d1.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd2'
//		dw_3.object.d2.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd3'
//		dw_3.object.d3.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd4'
//		dw_3.object.d4.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd5'
//		dw_3.object.d5.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd6'
//		dw_3.object.d6.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd7'
//		dw_3.object.d7.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd8'
//		dw_3.object.d8.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd9'
//		dw_3.object.d9.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd10'
//		dw_3.object.d10.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd11'
//		dw_3.object.d11.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd12'
//		dw_3.object.d12.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd13'
//		dw_3.object.d13.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'd14'
//		dw_3.object.d14.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e1'
//		dw_3.object.e1.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e2'
//		dw_3.object.e2.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e3'
//		dw_3.object.e3.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e4'
//		dw_3.object.e4.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e5'	
//		dw_3.object.e5.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e6'
//		dw_3.object.e6.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e7'
//		dw_3.object.e7.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e8'
//		dw_3.object.e8.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e9'
//		dw_3.object.e9.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e10'
//		dw_3.object.e10.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e11'
//		dw_3.object.e11.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e12'
//		dw_3.object.e12.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e13'
//		dw_3.object.e13.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'e14'
//		dw_3.object.e14.Background.Color = RGB(0, 255, 255)
//	
//	CASE 'f1'
//		dw_3.object.f1.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f2'
//		dw_3.object.f2.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f3'
//		dw_3.object.f3.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f4'
//		dw_3.object.f4.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f5'
//		dw_3.object.f5.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f6'
//		dw_3.object.f6.Background.Color = RGB(0, 255, 255)
//		  
//	CASE 'f7'
//		dw_3.object.f7.Background.Color = RGB(0, 255, 255)
//		  
//	CASE 'f8'
//		dw_3.object.f8.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f9'
//		dw_3.object.f9.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f10'
//		dw_3.object.f10.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f11'
//		dw_3.object.f11.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f12'
//		dw_3.object.f12.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f13'
//		dw_3.object.f13.Background.Color = RGB(0, 255, 255)
//		
//	CASE 'f14'
//		dw_3.object.f14.Background.Color = RGB(0, 255, 255)		
//		
//END CHOOSE








end subroutine

public subroutine wf_siganpyo (string p_year, string p_hakgi, string p_hakbun);string ls_sigan

DECLARE	CUR_SIGAN CURSOR FOR
SELECT	B.YOIL||B.SIGAN			
FROM	HAKSA.SUGANG_TRANS	A,
		HAKSA.SIGANPYO			B		
WHERE	A.YEAR			=	B.YEAR
AND	A.HAKGI			=	B.HAKGI
AND	A.GWA				=	B.GWA
AND	A.HAKYUN			=	B.HAKYUN
AND	A.BAN				=	B.BAN
AND	A.GWAMOK_ID		=	B.GWAMOK_ID
AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
AND	A.BUNBAN			=	B.BUNBAN
AND	A.YEAR			=	:p_year
AND	A.HAKGI			=	:p_hakgi
AND	A.HAKBUN			=	:p_hakbun	
ORDER BY B.YOIL,
			B.SIGAN	
USING SQLCA ;

OPEN CUR_SIGAN	;
DO
	FETCH	CUR_SIGAN INTO	:ls_sigan	;
	
	IF SQLCA.SQLCODE <> 0 THEN EXIT
	
	wf_sigan_set(ls_sigan)
		
LOOP WHILE TRUE
CLOSE CUR_SIGAN ;
end subroutine

public subroutine sugangsave_season (string p_hakbun, string p_year, string p_hakgi, string p_gwa, string p_hakyun, string p_ban, string p_gwamok, long p_gwamok_seq, string p_bunban);//과목정보
string	ls_isu_id, ls_gwamok_juya, ls_pass
integer	li_hakjum

//재수강
string	ls_j_year,	ls_j_hakgi, ls_j_gwamok, ls_hwansan_jumsu
integer	li_j_gwamok_seq
double	ld_j_pyengjum

//학적정보
string	ls_sangtae, ls_juya, ls_su_hakyun, ls_gwa, ls_jungong_id, ls_bujungong_id, ls_jungong_gubun

//학점체크
double	ld_before_pyengjum
integer	li_tot_hakjum, li_hakgi_hakjum, li_year_hakjum, li_hakjum_30, li_jesu_cnt, li_jesu_cnt1

//인원초과 체크
integer	li_inwon, li_su_inwon

//시간중복 체크
string	ls_yoil, ls_sigan, ls_gwamok_id
integer	li_chk

//복수 부전공 체크
string	ls_bujun_id, ls_bujun_gubun

//History 일련번호
long		ll_seq_no

//비교
long		ll_count

String   ls_gwamok
Long     l_gwamok_seq

//------------- 선택한 과목정보를 가져온다.
SELECT	ISU_ID,
			JUYA_GUBUN,
			HAKJUM,
			PASS_GUBUN
INTO	:ls_isu_id,
		:ls_gwamok_juya,
		:li_hakjum,
		:ls_pass
FROM	HAKSA.GAESUL_GWAMOK
WHERE	YEAR 			=	:p_year
AND	HAKGI			=	:p_hakgi
AND	GWA			=	:p_gwa
AND	HAKYUN		=	:p_hakyun
AND	BAN			=	:p_ban
AND	GWAMOK_ID	=	:p_gwamok
AND	GWAMOK_SEQ	=	:p_gwamok_seq
AND	BUNBAN		=	:p_bunban
USING SQLCA ;

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(1)~R~N" + SQLCA.SQLERRTEXT)
END IF

//------------- 학적정보를 가져온다.
SELECT	JUYA_GUBUN,
			SANGTAE,
			SU_HAKYUN,
			GWA,
			NVL(JUNGONG_ID, ' ') JUNGONG_ID,
			NVL(BUJUNGONG_ID, ' ') BUJUNGONG_ID,
			NVL(JUNGONG_GUBUN, '')
INTO		:ls_juya,
			:ls_sangtae,
			:ls_su_hakyun,
			:ls_gwa,
			:ls_jungong_id, 
			:ls_bujungong_id,
			:ls_jungong_gubun
FROM		HAKSA.JAEHAK_HAKJUK
WHERE		HAKBUN	=	:p_hakbun
USING SQLCA ;

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(2)~R~N" + SQLCA.SQLERRTEXT)
END IF

//재학생만 수강신청 가능
if		ls_sangtae	<>	'01' then
		messagebox("확인","재학생만 수강신청 가능합니다.", Exclamation!)
		return
end if


//---------------------------    대표개설과목으로 체크(사이버과목에 따른 과목증설로 인하여)
SELECT TMT_GWAMOK_ID,    TMT_GWAMOK_SEQ
  INTO :ls_gwamok,       :l_gwamok_seq
  FROM haksa.gaesul_gwamok
 WHERE YEAR       = :p_year
   AND HAKGI      = :p_hakgi
   AND GWA        = :p_gwa
   AND HAKYUN     = :p_hakyun
   AND BAN        = :p_ban
   AND GWAMOK_ID  = :p_gwamok
   AND GWAMOK_SEQ = :p_gwamok_seq
   AND BUNBAN     = :p_bunban
   USING SQLCA ;

//--------------------------		이미 신청한 과목인지 check
SELECT	count(*)
INTO		:ll_count
FROM		HAKSA.SUGANG_TRANS
WHERE		YEAR			=	:p_year
AND		HAKGI			=	:p_hakgi
AND		HAKBUN		=	:p_hakbun
AND	 ((GWAMOK_ID || GWAMOK_SEQ = :ls_gwamok || :l_gwamok_seq)
 OR     (GWAMOK_ID || GWAMOK_SEQ = :p_gwamok  || :p_gwamok_seq)) 
 USING SQLCA ;

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(3)~R~N" + SQLCA.SQLERRTEXT)
END IF

if	ll_count	>	0	then
	messagebox("확인","이미 신청한 과목 입니다.", Exclamation!)
	return
end if

////----------------------------		상급 수강신청 check
//if	ls_isu_id	=	'21'	or	ls_isu_id	=	'22'	then
//	if	ls_su_hakyun	<	p_hakyun		then
//		messagebox("확인","하위학년이 상위학년 전공과목을 신청할 수 없습니다.", Exclamation!)
//		return
//	end if
//end if
//
////--------------------------------------	주간, 야간 교차수강 불가
//if		ls_juya	<>	ls_gwamok_juya	then
//		messagebox("확인","주간 야간 교차수강을 할 수 없습니다.", Exclamation!)
//		return
//end if

//---------------------------		재수강인지 아닌지 체크(대체과목에서도 체크해야함)
SELECT	YEAR,
			HAKGI,
			GWAMOK_ID,
			GWAMOK_SEQ,
			PYENGJUM,
			HWANSAN_JUMSU
INTO		:ls_j_year,
			:ls_j_hakgi,
			:ls_j_gwamok,
			:li_j_gwamok_seq,
			:ld_j_pyengjum,
			:ls_hwansan_jumsu 
FROM		HAKSA.SUGANG
WHERE		HAKBUN			=	:p_hakbun
AND	 ((GWAMOK_ID || GWAMOK_SEQ = :ls_gwamok || :l_gwamok_seq)
 OR     (GWAMOK_ID || GWAMOK_SEQ = :p_gwamok  || :p_gwamok_seq))
AND		SUNGJUK_INJUNG	=	'Y'	
USING SQLCA ;


IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(4)~R~N" + SQLCA.SQLERRTEXT)
	RETURN
END IF

IF sqlca.sqlcode = 0 THEN
	if (ld_j_pyengjum >= 3.0 or ls_hwansan_jumsu = 'P')then
		messagebox("확인",ls_j_year + "년도 " + ls_j_hakgi + "학기에 수강한 과목입니다.")
		return
	end if
	
	if messagebox("확인","이미 수강한 과목입니다.~r~n재수강 하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	
	//재수강이면 체크하여 학점초과 여부 체크시 사용한다.
	li_jesu_cnt1 = 1
	
ELSE
	//------------------------		재수강에서 체크안된 과목은 대체과목에서 재수강인지 체크도 해야함.
	SELECT	YEAR,
				HAKGI,
				GWAMOK_ID,
				GWAMOK_SEQ,
				PYENGJUM
	INTO		:ls_j_year,
				:ls_j_hakgi,
				:ls_j_gwamok,
				:li_j_gwamok_seq,
				:ld_j_pyengjum
	FROM	HAKSA.SUGANG
	WHERE	HAKBUN	=	:p_hakbun
	AND	SUNGJUK_INJUNG	=	'Y'
	AND	(GWAMOK_ID, GWAMOK_SEQ ) IN (	SELECT	GWAMOK_ID_BEFORE,	GWAMOK_SEQ_BEFORE
													FROM	HAKSA.DAECHE_GWAMOK
													WHERE	GWAMOK_ID_AFTER || GWAMOK_SEQ_AFTER	= :ls_gwamok || :l_gwamok_seq
														OR GWAMOK_ID_AFTER || GWAMOK_SEQ_AFTER	= :p_gwamok  || :p_gwamok_seq	)
    USING SQLCA ;
	
	if sqlca.sqlcode = 0 then
//		if ld_j_pyengjum <= 2.5 then
		if (ld_j_pyengjum >= 3.0  or ls_hwansan_jumsu = 'P') then
			messagebox("확인",ls_j_year + "년도 " + ls_j_hakgi + "학기에 수강한 과목입니다.(대체)")
			return
		end if
		
		if messagebox("확인","이미 수강한 과목입니다.~r~n재수강(대체) 하시겠습니까?", Question!, YesNo!, 2) = 2 then return
		
		//재수강이면 체크하여 학점초과 여부 체크시 사용한다.
		li_jesu_cnt1 = 1
	end if
	
END IF



//---------- 수강신청 최대학점 계산

//수강가능 학점 체크
//매학기 6학점까지, 매학년도 42학점까지
//재수강 있을경우 매학기 6학점, 매학년도 46학점까지
//선이수, 해외어학연수, 현장실습은 포함하지 않는다.
//직전학기 4.0이상일때는 4학점을 까지 추가 가능(매학년도 48학점을 초과할 수는 없다.)


//직전학기 4.0이상인자 4학점 초과 신청할 수 있음.
//계절학기는 체크하지 않음.
//SELECT 	AVG_PYENGJUM
//INTO		:ld_before_pyengjum
//FROM		HAKSA.SUNGJUKGYE
//WHERE		HAKBUN		=	:p_hakbun
//AND		YEAR||HAKGI	=	(	SELECT	MAX(YEAR||HAKGI)
//									FROM	HAKSA.SUNGJUKGYE
//									WHERE	HAKBUN	=	:p_hakbun	)	;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MESSAGEBOX("오류","DATABASE 오류(5)~R~N" + SQLCA.SQLERRTEXT)
//END IF

////금년도에 신청한 학점
//SELECT	SUM(A.HAKJUM)
//INTO	:li_year_hakjum
//FROM	HAKSA.SUGANG			A,
//		HAKSA.GWAMOK_CODE		B
//WHERE	A.GWAMOK_ID		=	B.GWAMOK_ID
//AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//AND	A.HAKBUN			=	:p_hakbun
//AND	A.YEAR			=	:p_year
//AND	NVL(B.PASS_GUBUN, 'N')	<>	'Y'
//AND	A.SUNGJUK_INJUNG			=	'Y'	;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MESSAGEBOX("오류","DATABASE 오류(6)~R~N" + SQLCA.SQLERRTEXT)
//END IF
//
//
//// 이번학기 직전까지 신청한 학점, 재수강체크, 선이수학점
//SELECT	SUM(A.HAKJUM),
//			SUM(DECODE(A.JESU_YEAR, NULL, 0, 1)),
//			SUM(DECODE(A.ISU_ID, '30', A.HAKJUM, 0))
//INTO	:li_hakgi_hakjum,
//		:li_jesu_cnt,
//		:li_hakjum_30
//FROM	HAKSA.SUGANG_TRANS	A,
//		HAKSA.GWAMOK_CODE		B
//WHERE	A.GWAMOK_ID		=	B.GWAMOK_ID
//AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//AND	A.HAKBUN			=	:p_hakbun
//AND	A.YEAR			=	:p_year
//AND	A.HAKGI			=	:p_hakgi
//AND	A.ISU_ID			<>	'30'
//AND	NVL(B.PASS_GUBUN, 'N')	<>	'Y'
//AND	A.SUNGJUK_INJUNG			=	'Y'	;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MESSAGEBOX("오류","DATABASE 오류(7)~R~N" + SQLCA.SQLERRTEXT)
//END IF
//
////----------------		년간 이수 가능학점 체크
//if li_jesu_cnt + li_jesu_cnt1 = 0 then
//	if li_year_hakjum + li_hakjum > 42 then
//		messagebox("확인","년간 신청가능학점을 초과하였습니다.", Exclamation!)
//		return
//	end if
//	
//else
//	if li_year_hakjum + li_hakjum > 46 then
//		messagebox("확인","년간 신청가능학점을 초과하였습니다.", Exclamation!)
//		return
//	end if
//	
//end if	
//
////----------------------	 학기별 이수가능학점 체크
////계절학기는 무조건 학한기에 6학점을 초과할 수 없다.
//
//if li_hakgi_hakjum + li_hakjum > 6 then
//	messagebox("확인","학기별 신청가능학점을 초과하였습니다.", Exclamation!)
//	return
//end if
//		

////2003년도 부터 선이수과목은 이수하지 않기로 함.
////---------------------		선이수 과목 6학점 초과 check...
//if	ls_isu_id	=	'30'	then
//	if		(li_hakjum_30 + li_hakjum) 	>	6	then
//			messagebox("확인","선이수과목은 6학점 초과할 수 없읍니다.", Exclamation!)
//			return
//	end if
//
//end if

////----------		교직이수자가 아닌 학생이 교직과목 선택시 일반선택으로 변환
//---	교직담당자와 업무협의 필요.
//SELECT	count(*)
//INTO	:
//FROM	HAKSA.GJ_SINCHUNG
//WHERE	YEAR		=	:p_year
//AND	HAKGI		=	:p_hakgi
//AND	HAKBUN	=	:p_hakbun	;



//----------		주전공과목 타학과학생이 신청시는 일반선택으로 이수구분변환
if	ls_isu_id	=	'21'	or		ls_isu_id	=	'22'	then
	
	//ls_gwa => 개설학과, p_gwa => 학생 학적학과
	if	left(ls_gwa, 3)	<>	left(p_gwa, 3)	then
		ls_isu_id	=	'80'
	end if
	
end if

//--------------------------------------- 복수전공, 부전공 체크 넣기
SELECT	BUJUNGONG_ID,
			JUNGONG_GUBUN
INTO	:ls_bujun_id,
		:ls_bujun_gubun
FROM	HAKSA.JAEHAK_HAKJUK
WHERE	HAKBUN	=	:p_hakbun
USING SQLCA ;

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(복수/부전공 체크)~R~N" + SQLCA.SQLERRTEXT)
END IF

IF SQLCA.SQLCODE = 0 THEN
	if ls_bujun_gubun = '1' then
		//복수
		if mid(p_gwa, 1, 3)	=	mid(ls_bujun_id, 1, 3) then
			ls_isu_id = '60'
			
		end if
				
	elseif ls_bujun_gubun = '2' then
		//부전공
		if mid(p_gwa, 1, 3)	=	mid(ls_bujun_id, 1, 3) then
			ls_isu_id = '50'
			
		end if
		
	end if
		
END IF


////8. 수강신청 시간 중복 check.
//DECLARE CUR_SIGAN CURSOR FOR
//SELECT	ILJA,
//			SIGAN
//FROM	HAKSA.SIGANPYO_SEASON
//WHERE	YEAR 			=	:p_year
//AND	HAKGI			=	:p_hakgi
//AND	GWA			=	:p_gwa
//AND	HAKYUN		=	:p_hakyun
//AND	BAN			=	:p_ban
//AND	GWAMOK_ID	=	:p_gwamok
//AND	GWAMOK_SEQ	=	:p_gwamok_seq
//AND	BUNBAN		=	:p_bunban		;
//
//OPEN CUR_SIGAN	;
//DO
//	FETCH	CUR_SIGAN	INTO	:ls_yoil, :ls_sigan	;
//	
//	IF SQLCA.SQLCODE <> 0 THEN EXIT
//	
//		SELECT	COUNT(A.HAKBUN)
//		INTO	:li_chk
//		FROM 	HAKSA.SUGANG_TRANS		A,
//				HAKSA.SIGANPYO_SEASON	B			
//		WHERE	A.YEAR			=	B.YEAR
//		AND	A.HAKGI			=	B.HAKGI
//		AND	A.GWA				=	B.GWA
//		AND	A.HAKYUN			=	B.HAKYUN
//		AND	A.BAN				=	B.BAN
//		AND	A.GWAMOK_ID		=	B.GWAMOK_ID
//		AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//		AND	A.BUNBAN			=	B.BUNBAN
//		AND	A.YEAR 			=	:p_year
//		AND	A.HAKGI			=	:p_hakgi
//		AND	A.HAKBUN			=	:p_hakbun
//		AND	B.YOIL			=	:ls_yoil
//		AND	B.SIGAN			=	:ls_sigan	;
//		
//		IF SQLCA.SQLCODE = -1 THEN
//			MESSAGEBOX("오류","DATABASE 오류(8)~R~N" + SQLCA.SQLERRTEXT)
//		END IF
//		
//		if li_chk > 0 then
//			messagebox("확인","이미 신청한 과목과 수업시간이 중복됩니다.", Exclamation!)
//			return
//		end if		
//	
//LOOP WHILE TRUE
//CLOSE CUR_SIGAN	;

//8. 수강신청 시간 중복 check.
SELECT	GWAMOK_ID
INTO	:ls_gwamok_id
FROM
	(
	SELECT	GWAMOK_ID	AS GWAMOK_ID,
				YOIL			AS YOIL,
				SIGAN			AS SIGAN
	FROM 	HAKSA.SIGANPYO		
	WHERE	YEAR 			=	:p_year
	AND	HAKGI			=	:p_hakgi
	AND	GWA			=	:p_gwa
	AND	HAKYUN		=	:p_hakyun
	AND	BAN			=	:p_ban
	AND	GWAMOK_ID	=	:p_gwamok
	AND	GWAMOK_SEQ	=	:p_gwamok_seq
	AND	BUNBAN		=	:p_bunban
	) T1,
	(
	SELECT	B.YOIL	AS YOIL,
				B.SIGAN	AS SIGAN
	FROM 	HAKSA.SUGANG_TRANS	A,
			HAKSA.SIGANPYO			B			
	WHERE	A.YEAR			=	B.YEAR
	AND	A.HAKGI			=	B.HAKGI
	AND	A.GWA				=	B.GWA
	AND	A.HAKYUN			=	B.HAKYUN
	AND	A.BAN				=	B.BAN
	AND	A.GWAMOK_ID		=	B.GWAMOK_ID
	AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
	AND	A.BUNBAN			=	B.BUNBAN
	AND	A.YEAR 			=	:p_year
	AND	A.HAKGI			=	:p_hakgi
	AND	A.HAKBUN			=	:p_hakbun
	) T2
WHERE T1.YOIL	=	T2.YOIL
AND	T1.SIGAN	=	T2.SIGAN
AND	ROWNUM	=	1
USING SQLCA ;


IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(시간중복Check)~R~N" + SQLCA.SQLERRTEXT)
	return
	
ELSEIF SQLCA.SQLCODE = 0 THEN
	messagebox("확인","이미 신청한 과목과 수업시간이 중복됩니다.", Exclamation!)
	return
	
END IF

//----------------------------------- 수강인원 check...
SELECT	NVL(INWON, 0),
			NVL(SU_INWON, 0)
INTO		:li_inwon,
			:li_su_inwon
FROM		HAKSA.GAESUL_GWAMOK
WHERE	YEAR			=	:p_year
AND	HAKGI			=	:p_hakgi
AND	GWA			=	:p_gwa
AND	HAKYUN		=	:p_hakyun
AND	BAN			=	:p_ban
AND	GWAMOK_ID	=	:p_gwamok
AND	GWAMOK_SEQ	=	:p_gwamok_seq
AND	BUNBAN		=	:p_bunban
USING SQLCA ;

if	li_inwon	<=	li_su_inwon	then
	messagebox("오류","수강과목 인원 초과 입니다.", Exclamation!)
	return
end if
//--------------------------수강신청 제한사항 체크 완료----------------------------------

//////////////////////////////////////////////////////////////////////////////////////////////////		데이타 저장
//----------------------	수강신청인원 증가
UPDATE	HAKSA.GAESUL_GWAMOK
SET		SU_INWON		=	NVL(SU_INWON, 0) + 1
WHERE	YEAR			=	:p_year
AND	HAKGI			=	:p_hakgi
AND	GWA			=	:p_gwa	
AND	HAKYUN		=	:p_hakyun
AND	BAN			=	:p_ban
AND	GWAMOK_ID	=	:p_gwamok
AND	GWAMOK_SEQ	=  :p_gwamok_seq
AND	BUNBAN		= 	:p_bunban
USING SQLCA ;

if	sqlca.sqlcode	<>	0	then
	messagebox("오류","수강신청 인원저장중 오류 발생~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	return
end if

//-----------------------			수강신청저장		-----------------

INSERT	INTO 	HAKSA.SUGANG_TRANS
			(	HAKBUN,		YEAR,					HAKGI,				GWA,					HAKYUN,				BAN,
				GWAMOK_ID,	GWAMOK_SEQ,			BUNBAN,				ISU_ID,				HAKJUM,				SUNGJUK_INJUNG,
				JOGI_YN,		JESU_YEAR,			JESU_HAKGI,			JESU_GWAMOK_ID,	JESU_GWAMOK_SEQ,
				WORKER,		IPADDR,				WORK_DATE																)
values	(	:p_hakbun,	:p_year,				:p_hakgi,			:p_gwa,				:p_hakyun,			:p_ban,
				:p_gwamok,	:p_gwamok_seq,		:p_bunban,			:ls_isu_id,			:li_hakjum,			'Y',
				'0',			:ls_j_year,			:ls_j_hakgi,		:ls_j_gwamok,		:li_j_gwamok_seq,
				:gs_empcode,	:gs_ip,    	sysdate										)
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("오류","수강신청내역 저장중 오류발생~r~n" + sqlca.sqlerrtext)
	rollback ;
	return
end if


//수강신청 History 저장
SELECT	nvl(max(SEQ_NO), 0)	+ 1
INTO		:ll_seq_no
FROM	HAKSA.SUGANG_HIS
WHERE	HAKBUN		=	:p_hakbun
AND	YEAR			=	:p_year
AND	HAKGI			=	:p_hakgi
AND	GWAMOK_ID	=	:p_gwamok
AND	GWAMOK_SEQ	=  :p_gwamok_seq
USING SQLCA ;

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(9)~R~N" + SQLCA.SQLERRTEXT)
END IF

INSERT INTO HAKSA.SUGANG_HIS
			(	HAKBUN,			SEQ_NO,			YEAR,				HAKGI,		GWA,		HAKYUN,	
				BUN,				GWAMOK_ID,		GWAMOK_SEQ,		BUNBAN,		STATUS,
				WORKER,			IPADDR,			WORK_DATE												)
values	(	:p_hakbun,		:ll_seq_no,		:p_year,			:p_hakgi,	:p_gwa,	:p_hakyun,
				:p_ban,			:p_gwamok,		:p_gwamok_seq,	:p_bunban,	'I',
				:gs_empcode,	:gs_ip,	sysdate)	USING SQLCA ;

if sqlca.sqlcode = 0 then
	commit USING SQLCA ;
	
else
	
	messagebox("오류","수강신청HISTORY 저장중 오류발생~r~n" + sqlca.sqlerrtext, stopsign!)
	rollback USING SQLCA ;
	return
	
end if

end subroutine

public subroutine sugangdelete (string p_hakbun, string p_year, string p_hakgi, string p_gwa, string p_hakyun, string p_ban, string p_gwamok, integer p_gwamok_seq, string p_bunban);//수강신청 삭제

long		ll_seq_no, ll_bunnap_count
string	ls_wan, ls_bun

// 학기제 체크-------------------
String ls_hakyun,   ls_iphakgb,   ls_chk,   ls_iphakdt,   ls_jaeipdt,  ls_hjmod
Int    li_hakgi

SELECT su_hakyun,
       case when nvl(iphak_gubun, ' ') = '04' then '2' else '1' end,
		 iphak_date,
		 substr(jaeiphak_date, 1, 4),
		 hjmod_id
  INTO :ls_hakyun,
       :ls_iphakgb,
		 :ls_iphakdt,
		 :ls_jaeipdt,
		 :ls_hjmod
  FROM haksa.jaehak_hakjuk
 WHERE hakbun   = :p_hakbun
 USING SQLCA ;
 
IF sqlca.sqlnrows = 0 THEN
	messagebox("알림", p_hakbun + '의 학번이 재학자료에 없으니 확인바랍니다.')
	return 
END IF

ls_chk          = 'N'

// 재입학당시의 년도,학적구분,학년을 가져 오기
SELECT	su_hakyun,
			HJMOD_ID,
			substr(HJMOD_SIJUM, 1, 4)
INTO	 	:ls_hakyun,
			:ls_hjmod,
		 	:ls_jaeipdt
FROM 		haksa.HAKJUKBYENDONG
WHERE 	hakbun   = :p_hakbun
AND		HJMOD_ID = 'I'
AND		HJMOD_SIJUM = (	SELECT 	MAX(HJMOD_SIJUM)
									FROM		haksa.HAKJUKBYENDONG
									WHERE 	hakbun   = :p_hakbun
									AND		HJMOD_ID = 'I')
 USING SQLCA ;
									
/* 재입학생 학기제 적용 */
IF ls_hjmod     = 'I' THEN
	IF ls_jaeipdt      = '2009' THEN
		ls_chk       = 'Y'
	ELSEIF ls_jaeipdt  = '2006' THEN
		IF ls_hakyun = '1'    THEN
			ls_chk    = 'Y'
		END IF
	ELSEIF ls_jaeipdt  = '2007' THEN
		IF ls_hakyun = '1' OR ls_hakyun = '2' THEN
			ls_chk    = 'Y'
		END IF
	ELSEIF ls_jaeipdt  = '2008' THEN
		IF ls_hakyun = '1' OR ls_hakyun = '2' OR ls_hakyun = '3' THEN
			ls_chk    = 'Y'
		END IF
	END IF
ELSE
	/* 신입생은 입학일자가 2006년 1월 1일 이후 학기제 적용 */
	IF ls_iphakgb   = '1' THEN
		IF ls_iphakdt  >= '20060101' THEN
			ls_chk       = 'Y'
		END IF
	END IF
	/* 편입생은 입학일자가 2008년 1월 1일 이후 학기제 적용 */
	IF ls_iphakgb   = '2' THEN
		IF ls_iphakdt  >= '20080101' THEN
			ls_chk       = 'Y'
		END IF
	END IF

END IF

/* 등록학기 체크 */
SELECT nvl(COUNT(HAKGI), 0)
  INTO :li_hakgi
  FROM HAKSA.SUNGJUKGYE
 WHERE hakgi in('1', '2')
	AND HAKBUN     = :p_hakbun
 USING SQLCA ;
IF sqlca.sqlnrows = 0 THEN
	li_hakgi       = 0
END IF

IF ls_chk         = 'Y' THEN
	IF ls_iphakgb  = '1'    AND li_hakgi >= 8 THEN
		ls_chk      = 'N'
	ELSEIF ls_iphakgb = '2' AND li_hakgi >= 4 THEN
		ls_chk      = 'N'
	END IF
END IF
//------------ 이곳까지 학기제인지 Y 학점제인지 N 체크 : ls_chk
SELECT	WAN_YN,
			BUN_YN
INTO		:ls_wan,
			:ls_bun
FROM		HAKSA.DUNGROK_GWANRI
WHERE		YEAR		=	:p_year
AND		HAKGI		=	:p_hakgi
AND		HAKBUN	=	:p_hakbun
AND		CHASU		=	1
 USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	if	ls_chk ='N' then
		if ls_wan = 'N' and ls_bun = 'Y' then
			messagebox("확인","등록금 분납자는 완납시까지 수강정정을 할 수 없습니다.")
			return
		end if
	end if
END IF


SELECT	COUNT(*)
INTO		:ll_bunnap_count
FROM		HAKSA.BUNNAP_GWANRI A,
			HAKSA.DUNGROK_GWANRI	B
WHERE		A.HAKBUN		=	B.HAKBUN
AND		A.YEAR 		=	B.YEAR
AND		A.HAKGI		=	B.HAKGI
AND		A.YEAR		=	:p_year
AND		A.HAKGI		=	:p_hakgi
AND		A.HAKBUN		=	:p_hakbun
AND		B.CHASU 		= 1
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	if ls_wan = 'Y' and ls_bun = 'Y' then
	ELSE
		if	ls_chk ='N' then
			if ll_bunnap_count > 0 then
				messagebox("확인","등록금 분납예정자는 완납시까지 수강정정을 할 수 없습니다.")
				return
			end if	
		end if	
	end if			
END IF

DELETE	HAKSA.SUGANG_TRANS
WHERE	HAKBUN		=	:p_hakbun
AND	YEAR			= 	:p_year
AND	HAKGI  		= 	:p_hakgi
AND	GWAMOK_ID	=	:p_gwamok
AND	GWAMOK_SEQ	=	:p_gwamok_seq
 USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("오류","수강신청 삭제중 오류 발생(1)~r~n" + sqlca.sqlerrtext)
	rollback  USING SQLCA ;
	return
end if

//수강신청인원 delete....
UPDATE	HAKSA.GAESUL_GWAMOK
SET	SU_INWON		=	( DECODE(SU_INWON, 0, 0, SU_INWON - 1))
WHERE	YEAR			=	:p_year
AND	HAKGI			=	:p_hakgi
AND	GWA			=	:p_gwa
AND	HAKYUN		=	:p_hakyun
AND	BAN			=	:p_ban
AND	GWAMOK_ID	=	:p_gwamok
AND	GWAMOK_SEQ	=  :p_gwamok_seq
AND	BUNBAN		= 	:p_bunban
 USING SQLCA ;
 
if sqlca.sqlcode <> 0 then
	messagebox("오류","수강신청 삭제중 오류 발생(2)~r~n" + sqlca.sqlerrtext)
	rollback  USING SQLCA ;
	return
end if 

//수강신청 History 저장
SELECT	nvl(max(SEQ_NO), 0)	+ 1
INTO		:ll_seq_no
FROM	HAKSA.SUGANG_HIS
WHERE	HAKBUN		=	:p_hakbun
AND	YEAR			=	:p_year
AND	HAKGI			=	:p_hakgi
AND	GWAMOK_ID	=	:p_gwamok
AND	GWAMOK_SEQ	=  :p_gwamok_seq
 USING SQLCA ;

INSERT INTO HAKSA.SUGANG_HIS
			(	HAKBUN,			SEQ_NO,			YEAR,				HAKGI,		GWA,		HAKYUN,	
				BUN,				GWAMOK_ID,		GWAMOK_SEQ,		BUNBAN,		STATUS,
				WORKER,			IPADDR,			WORK_DATE												)
values	(	:p_hakbun,		:ll_seq_no,		:p_year,			:p_hakgi,	:p_gwa,	:p_hakyun,
				:p_ban,			:p_gwamok,		:p_gwamok_seq,	:p_bunban,	'D',
				:gs_empcode,	:gs_ip,         	sysdate)	 USING SQLCA ;

if	sqlca.sqlcode	=	0	then	      	   
	commit  USING SQLCA ;
  		
else
	messagebox("오류","수강신청 삭제중 오류 발생(3)~r~n" + sqlca.sqlerrtext)
	rollback  USING SQLCA ;
	
end if
end subroutine

public subroutine sugangsave (string p_hakbun, string p_year, string p_hakgi, string p_gwa, string p_hakyun, string p_ban, string p_gwamok, long p_gwamok_seq, string p_bunban);//과목정보
string	ls_isu_id, ls_gwamok_juya, ls_pass
integer	li_hakjum, li_hakjum1, li_hakjum_tot, li_siljea_hakjum

//학적정보
string	ls_sangtae, ls_juya, ls_su_hakyun, ls_gwa, ls_iphak_gubun
string	ls_jungong_id, ls_bujungong_id, ls_jungong_gubun, ls_iphak_date

//등록금 납부 체크
string 	ls_wan, ls_bun

//재수강
string	ls_j_year,	ls_j_hakgi, ls_j_gwamok, ls_hwansan_jumsu
integer	li_j_gwamok_seq
double	ld_j_pyengjum

//학점체크
double	ld_before_pyengjum
integer	li_tot_hakjum, li_hakgi_hakjum, li_year_hakjum, li_hakjum_30, li_jesu_cnt, li_jesu_cnt1
integer	li_year_hakjum1, li_hakjum_tot1, li_hakgi_hakjum1

//인원초과 체크
integer	li_inwon, li_su_inwon

//복수 부전공 체크
string	ls_bujun_id, ls_bujun_gubun

//시간중복 체크
string	ls_yoil, ls_sigan, ls_gwamok_id
integer	li_chk

//교직 체크
string	ls_yejung_yn, ls_sinchung_yn

//History 일련번호
long		ll_seq_no

//비교				 //분납카운트	
long		ll_count, ll_bunnap_count

//학습구분가능학과 체크
string	ls_haksub_gwa, ls_haksub_hakyun, ls_haksub_ganung_gubun

String   ls_gwamok, ls_gaesul_gwamok
Long     l_gwamok_seq, l_gaesul_gwamok_seq

//MESSAGEBOX("1","A")

// 학기제 체크-------------------
String ls_hakyun,   ls_iphakgb,   ls_chk,   ls_iphakdt,   ls_jaeipdt,  ls_hjmod
Int    li_hakgi

SELECT su_hakyun,
       case when nvl(iphak_gubun, ' ') = '04' then '2' else '1' end,
		 iphak_date,
		 substr(jaeiphak_date, 1, 4),
		 hjmod_id
  INTO :ls_hakyun,
       :ls_iphakgb,
		 :ls_iphakdt,
		 :ls_jaeipdt,
		 :ls_hjmod
  FROM haksa.jaehak_hakjuk
 WHERE hakbun   = :p_hakbun
 USING SQLCA ;
 
IF sqlca.sqlnrows = 0 THEN
	messagebox("알림", p_hakbun + '의 학번이 재학자료에 없으니 확인바랍니다.')
	return 
END IF

ls_chk          = 'N'
// 재입학당시의 년도,학적구분,학년을 가져 오기
SELECT	su_hakyun,
			HJMOD_ID,
			substr(HJMOD_SIJUM, 1, 4)
INTO	 	:ls_hakyun,
			:ls_hjmod,
		 	:ls_jaeipdt
FROM 		haksa.HAKJUKBYENDONG
WHERE 	hakbun   = :p_hakbun
AND		HJMOD_ID = 'I'
AND		HJMOD_SIJUM = (	SELECT 	MAX(HJMOD_SIJUM)
									FROM		haksa.HAKJUKBYENDONG
									WHERE 	hakbun   = :p_hakbun
									AND		HJMOD_ID = 'I')
 USING SQLCA ;
									
/* 재입학생 학기제 적용 */
IF ls_hjmod     = 'I' THEN
	IF ls_jaeipdt	 = '2009' THEN
		ls_chk       = 'Y'
	ELSEIF ls_jaeipdt	= '2006' THEN
		IF ls_hakyun = '1'    THEN
			ls_chk    = 'Y'
		END IF
	ELSEIF ls_jaeipdt	= '2007' THEN
		IF ls_hakyun = '1' OR ls_hakyun = '2' THEN
			ls_chk    = 'Y'
		END IF
	ELSEIF ls_jaeipdt	= '2008' THEN
		IF ls_hakyun 	= '1' OR ls_hakyun = '2' OR ls_hakyun = '3' THEN
			ls_chk    	= 'Y'
		END IF
	END IF
ELSE
	/* 신입생은 입학일자가 2006년 1월 1일 이후 학기제 적용 */
	IF ls_iphakgb   = '1' THEN
		IF ls_iphakdt  >= '20060101' THEN
			ls_chk       = 'Y'
		END IF
	END IF
	/* 편입생은 입학일자가 2008년 1월 1일 이후 학기제 적용 */
	IF ls_iphakgb   = '2' THEN
		IF ls_iphakdt  >= '20080101' THEN
			ls_chk       = 'Y'
		END IF
	END IF

END IF

/* 등록학기 체크 */
SELECT nvl(COUNT(HAKGI), 0)
  INTO :li_hakgi
  FROM HAKSA.SUNGJUKGYE
 WHERE hakgi in('1', '2')
	AND HAKBUN     = :p_hakbun
 USING SQLCA ;
IF sqlca.sqlnrows = 0 THEN
	li_hakgi       = 0
END IF

IF ls_chk         = 'Y' THEN
	IF ls_iphakgb  = '1'    AND li_hakgi >= 8 THEN
		ls_chk      = 'N'
	ELSEIF ls_iphakgb = '2' AND li_hakgi >= 4 THEN
		ls_chk      = 'N'
	END IF
END IF

//------------ 이곳까지 학기제인지 Y 학점제인지 N 체크 : ls_chk

//------------- 선택한 과목정보를 가져온다.2005학번 이하인자만..
SELECT	ISU_ID,
			JUYA_GUBUN,
			DECODE(NVL(PASS_GUBUN, 'N'), 'Y', 0, HAKJUM) HAKJUM1,
			HAKJUM,
			PASS_GUBUN
INTO		:ls_isu_id,
			:ls_gwamok_juya,
			:li_hakjum,
			:li_siljea_hakjum,
			:ls_pass
FROM		HAKSA.GAESUL_GWAMOK
WHERE		YEAR 			=	:p_year
AND		HAKGI			=	:p_hakgi
AND		GWA			=	:p_gwa
AND		HAKYUN		=	:p_hakyun
AND		BAN			=	:p_ban
AND		GWAMOK_ID	=	:p_gwamok
AND		GWAMOK_SEQ	=	:p_gwamok_seq
AND		BUNBAN		=	:p_bunban
 USING SQLCA ;

//------------- 선택한 과목정보를 가져온다.2006학번의 신입생과 2008학번의 편입생이후부터..
SELECT	HAKJUM
INTO		:li_hakjum1
FROM		HAKSA.GAESUL_GWAMOK
WHERE		YEAR 			=	:p_year
AND		HAKGI			=	:p_hakgi
AND		GWA			=	:p_gwa
AND		HAKYUN		=	:p_hakyun
AND		BAN			=	:p_ban
AND		GWAMOK_ID	=	:p_gwamok
AND		GWAMOK_SEQ	=	:p_gwamok_seq
AND		BUNBAN		=	:p_bunban		
AND		NVL(PASS_GUBUN, 'N')	<>	'Y'
 USING SQLCA ;


IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(1)~R~N" + SQLCA.SQLERRTEXT)
END IF

//------------- 학적정보를 가져온다.
SELECT	JUYA_GUBUN,
			SANGTAE,
			SU_HAKYUN,
			GWA,
			NVL(JUNGONG_ID, ' ') JUNGONG_ID,
			NVL(BUJUNGONG_ID, ' ') BUJUNGONG_ID,
			NVL(JUNGONG_GUBUN, ''),
			IPHAK_GUBUN,
			SUBSTR(IPHAK_DATE, 1, 4)
INTO		:ls_juya,
			:ls_sangtae,
			:ls_su_hakyun,
			:ls_gwa,
			:ls_jungong_id, 
			:ls_bujungong_id,
			:ls_jungong_gubun,
			:ls_iphak_gubun,
			:ls_iphak_date
FROM		HAKSA.JAEHAK_HAKJUK
WHERE		HAKBUN	=	:p_hakbun
 USING SQLCA ;

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(2)~R~N" + SQLCA.SQLERRTEXT)
END IF

//재학생만 수강신청 가능
if		ls_sangtae	<>	'01' then
		messagebox("확인","재학생만 수강신청 가능합니다.", Exclamation!)
		return
end if

//-------------------------	분납자는 완납시까지 수강신청을 할 수 없다.(정정기간에만 해당)
SELECT	WAN_YN,
			BUN_YN
INTO		:ls_wan,
			:ls_bun
FROM		HAKSA.DUNGROK_GWANRI
WHERE		YEAR		=	:p_year
AND		HAKGI		=	:p_hakgi
AND		HAKBUN	=	:p_hakbun
AND		CHASU		=	1
 USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	if	ls_chk	=	'N' THEN
		if ls_wan = 'N' and ls_bun = 'Y' then
			messagebox("확인","등록금 분납자는 완납시까지 수강정정을 할 수 없습니다.")
			return
		end if
	end if
END IF


SELECT	COUNT(*)
INTO		:ll_bunnap_count
FROM		HAKSA.BUNNAP_GWANRI A,
			HAKSA.DUNGROK_GWANRI	B
WHERE		A.HAKBUN		=	B.HAKBUN
AND		A.YEAR 		=	B.YEAR
AND		A.HAKGI		=	B.HAKGI
AND		A.YEAR		=	:p_year
AND		A.HAKGI		=	:p_hakgi
AND		A.HAKBUN		=	:p_hakbun
AND		B.CHASU 		= 1
 USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	if	ls_chk	=	'N'	THEN
		if ls_wan = 'Y' and ls_bun = 'Y' then
		ELSE
			if ll_bunnap_count > 0 then
				messagebox("확인","등록금 분납예정자는 완납시까지 수강정정을 할 수 없습니다.")
				return
			end if	
		end if		
	end if			
END IF	

//---------------------------    대표개설과목으로 체크(사이버과목에 따른 과목증설로 인하여)
SELECT TMT_GWAMOK_ID,    TMT_GWAMOK_SEQ,	GWAMOK_ID,				GWAMOK_SEQ
  INTO :ls_gwamok,       :l_gwamok_seq,	:ls_gaesul_gwamok, 	:l_gaesul_gwamok_seq
  FROM haksa.gaesul_gwamok
 WHERE YEAR       = :p_year
   AND HAKGI      = :p_hakgi
   AND GWA        = :p_gwa
   AND HAKYUN     = :p_hakyun
   AND BAN        = :p_ban
   AND GWAMOK_ID  = :p_gwamok
   AND GWAMOK_SEQ = :p_gwamok_seq
   AND BUNBAN     = :p_bunban
 USING SQLCA ;

//--------------------------		이미 신청한 과목인지 check
SELECT	count(*)
INTO		:ll_count
FROM		HAKSA.SUGANG_TRANS a, haksa.gaesul_gwamok b
WHERE		a.YEAR	   =	:p_year
AND		a.HAKGI		=	:p_hakgi
AND		a.HAKBUN		=	:p_hakbun
AND      a.year      =  b.year
AND      a.hakgi     =  b.hakgi
AND      a.gwa       =  b.gwa
AND      a.hakyun    =  b.hakyun
AND      a.ban       =  b.ban
AND      a.bunban    =  b.bunban
AND      a.gwamok_id =  b.gwamok_id
AND      a.gwamok_seq = b.gwamok_seq
AND	   b.TMT_GWAMOK_ID || b.TMT_GWAMOK_SEQ = :ls_gwamok || :l_gwamok_seq
USING SQLCA ;

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(3)~r~n" + SQLCA.SQLERRTEXT)
END IF

if	ll_count	>	0	then
	messagebox("확인","이미 신청한 과목 입니다.", Exclamation!)
	return
end if

//--------------------------		학습구분가능학과 인지  check
SELECT	A.GWA,
			A.HAKYUN,
			A.GANUNG_GUBUN
INTO		:ls_haksub_gwa, 
			:ls_haksub_hakyun, 
			:ls_haksub_ganung_gubun					
FROM		HAKSA.HAKSUB_GUBUN A,
			HAKSA.JAEHAK_HAKJUK B
WHERE		A.GWA		 	= B.GWA
AND		A.HAKYUN		= B.SU_HAKYUN
AND		B.HAKBUN 	= :p_hakbun
 USING SQLCA ;

//---------------------------		재수강인지 아닌지 체크(대체과목에서도 체크해야함)
SELECT	MAX(a.YEAR),
			MAX(a.HAKGI),
			a.GWAMOK_ID,
			a.GWAMOK_SEQ,
			a.PYENGJUM,
			a.HWANSAN_JUMSU
INTO		:ls_j_year,
			:ls_j_hakgi,
			:ls_j_gwamok,
			:li_j_gwamok_seq,
			:ld_j_pyengjum,
			:ls_hwansan_jumsu 
FROM		HAKSA.SUGANG a, haksa.gaesul_gwamok b
WHERE		a.HAKBUN			=	:p_hakbun
AND      a.year      =  b.year
AND      a.hakgi     =  b.hakgi
AND      a.gwamok_id =  b.gwamok_id
AND      a.gwamok_seq = b.gwamok_seq
AND	   (	b.TMT_GWAMOK_ID || b.TMT_GWAMOK_SEQ = :ls_gwamok || :l_gwamok_seq
OR	  			b.GWAMOK_ID || b.GWAMOK_SEQ = :ls_gaesul_gwamok || :l_gaesul_gwamok_seq)
AND		a.SUNGJUK_INJUNG	=	'Y'
GROUP BY a.GWAMOK_ID,
			a.GWAMOK_SEQ,
			a.PYENGJUM,
			a.HWANSAN_JUMSU
USING SQLCA ;
			
IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","재수강 Check중 오류발생~r~n전산소에 문의하세요~r~n" + SQLCA.SQLERRTEXT)
	RETURN
END IF

IF sqlca.sqlcode = 0 THEN
	if ( ld_j_pyengjum >= 3.0  or ls_hwansan_jumsu = 'P')then
		messagebox("확인",ls_j_year + "년도 " + ls_j_hakgi + "학기에 수강한 과목입니다.")
		return
	end if
	
	if messagebox("확인","이미 수강한 과목입니다.~r~n재수강 하시겠습니까?", Question!, YesNo!, 2) = 2 then return
	
	if ls_hwansan_jumsu = 'W' then
	else
	//재수강이면 체크하여 학점초과 여부 체크시 사용한다.
	li_jesu_cnt1 = 1
	end if
	
ELSE
	//------------------------		재수강에서 체크안된 과목은 대체과목에서 재수강인지 체크도 해야함.
	SELECT	YEAR,
				HAKGI,
				GWAMOK_ID,
				GWAMOK_SEQ,
				PYENGJUM
	INTO		:ls_j_year,
				:ls_j_hakgi,
				:ls_j_gwamok,
				:li_j_gwamok_seq,
				:ld_j_pyengjum
	FROM	HAKSA.SUGANG
	WHERE	HAKBUN			=	:p_hakbun
	AND	SUNGJUK_INJUNG	=	'Y'
	AND	(GWAMOK_ID, GWAMOK_SEQ ) IN (	SELECT	GWAMOK_ID_BEFORE,	GWAMOK_SEQ_BEFORE
													FROM	HAKSA.DAECHE_GWAMOK
													WHERE	GWAMOK_ID_AFTER || GWAMOK_SEQ_AFTER	= :ls_gwamok || :l_gwamok_seq
														OR GWAMOK_ID_AFTER || GWAMOK_SEQ_AFTER	= :p_gwamok  || :p_gwamok_seq	)
     USING SQLCA ;
	
	if sqlca.sqlcode = 0 then
		
//		if ld_j_pyengjum <= 2.5 then
		if (ld_j_pyengjum >= 3.0  or ls_hwansan_jumsu = 'P') then
			messagebox("확인",ls_j_year + "년도 " + ls_j_hakgi + "학기에 수강한 과목입니다.(대체)")
			return
		end if
		
		if messagebox("확인","이미 수강한 과목입니다.~r~n재수강(대체) 하시겠습니까?", Question!, YesNo!, 2) = 2 then return
		
		//재수강이면 체크하여 학점초과 여부 체크시 사용한다.
		li_jesu_cnt1 = 1
	end if
	
END IF


//////---------- 수강신청 최대학점 계산
//
////수강가능 학점 체크
////매학기 23학점까지, 매학년도 42학점까지
////재수강 있을경우 매학기 26학점, 매학년도 46학점까지
////선이수, 해외어학연수, 현장실습은 포함하지 않는다.
////직전학기 4.0이상일때는 4학점을 까지 추가 가능(매학년도 48학점을 초과할 수는 없다.)
////--2006학년도 신입 or 2008학년도 편입생은 12학점 ~ 19학점(재수강포함, pass과목미포함) 2006.11.28
////--매학년도 42학점 초과할수 없다(계절학기포함)
////--단, 직적학기 17학점이상에 4.25이상일때는 계절학기포함 44학점초과할수 없다.
//
//
////직전학기 4.0이상인자 4학점 초과 신청할 수 있음. 2005학번까지만
////직전학기 4.25이상인자 3학점 초과 신청할 수 있음. 2006학번 신입생부터
//SELECT 	AVG_PYENGJUM
//INTO		:ld_before_pyengjum
//FROM		HAKSA.SUNGJUKGYE
//WHERE		HAKBUN		=	:p_hakbun
//AND		YEAR||HAKGI	=	(	SELECT	MAX(YEAR||HAKGI)
//									FROM	HAKSA.SUNGJUKGYE
//									WHERE	HAKBUN	=	:p_hakbun	)	;					
//
//IF SQLCA.SQLCODE = -1 THEN
//	MESSAGEBOX("오류","DATABASE 오류(5)~R~N" + SQLCA.SQLERRTEXT)
//END IF
//
////금년도에 신청한 학점 2005학번 이하인자만..
//SELECT	SUM(A.HAKJUM)
//INTO		:li_year_hakjum
//FROM		HAKSA.SUGANG_TRANS	A,
//			HAKSA.GWAMOK_CODE		B
//WHERE		A.GWAMOK_ID		=	B.GWAMOK_ID
//AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//AND		A.HAKBUN			=	:p_hakbun
//AND		A.YEAR			=	:p_year
//AND		NVL(B.PASS_GUBUN, 'N')	<>	'Y'
//AND		A.SUNGJUK_INJUNG			=	'Y'	;
//
////금년도에 신청한 학점 2006학번의 신입생과 2008학번의 편입생이후부터..
//SELECT	SUM(A.HAKJUM)
//INTO		:li_year_hakjum1
//FROM		HAKSA.SUGANG_TRANS	A,
//			HAKSA.GWAMOK_CODE		B
//WHERE		A.GWAMOK_ID		=	B.GWAMOK_ID
//AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//AND		A.HAKBUN			=	:p_hakbun
//AND		A.YEAR			=	:p_year
//AND		NVL(B.PASS_GUBUN, 'N')	<>	'Y'
//AND		A.SUNGJUK_INJUNG			=	'Y'	;
//
//
////금학기 신청한 학점 2005학번 이하인자만..
//SELECT	SUM(A.HAKJUM),
//			SUM(DECODE(A.JESU_YEAR, NULL, 0, 1))
//INTO		:li_hakjum_tot,
//			:li_jesu_cnt1
//FROM		HAKSA.SUGANG_TRANS	A,
//			HAKSA.GWAMOK_CODE		B
//WHERE		A.GWAMOK_ID		=	B.GWAMOK_ID
//AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//AND		A.HAKBUN			=	:p_hakbun
//AND		A.YEAR			=	:p_year
//AND		A.HAKGI			=	:p_hakgi
//AND		NVL(B.PASS_GUBUN, 'N')	<>	'Y'
//AND		A.SUNGJUK_INJUNG			=	'Y'	;
//
////금학기 신청한 학점 2006학번의 신입생과 2008학번의 편입생이후부터..
//SELECT	SUM(A.HAKJUM)
//INTO		:li_hakjum_tot1
//FROM		HAKSA.SUGANG_TRANS	A,
//			HAKSA.GWAMOK_CODE		B
//WHERE		A.GWAMOK_ID		=	B.GWAMOK_ID
//AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//AND		A.HAKBUN			=	:p_hakbun
//AND		A.YEAR			=	:p_year
//AND		A.HAKGI			=	:p_hakgi
//AND		NVL(B.PASS_GUBUN, 'N')	<>	'Y'
//AND		A.SUNGJUK_INJUNG			=	'Y'	;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MESSAGEBOX("오류","DATABASE 오류(6)~R~N" + SQLCA.SQLERRTEXT)
//END IF
//
//
//// 이번학기 직전까지 신청한 학점, 재수강체크, 선이수학점 2005학번 이하인자만..
//SELECT	SUM(A.HAKJUM),
//			SUM(DECODE(A.JESU_YEAR, NULL, 0, 1)),
//			SUM(DECODE(A.ISU_ID, '30', A.HAKJUM, 0))
//INTO		:li_hakgi_hakjum,
//			:li_jesu_cnt,
//			:li_hakjum_30
//FROM		HAKSA.SUGANG_TRANS	A,
//			HAKSA.GWAMOK_CODE		B
//WHERE		A.GWAMOK_ID		=	B.GWAMOK_ID
//AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//AND		A.HAKBUN			=	:p_hakbun
//AND		A.YEAR			=	:p_year
//AND		A.HAKGI			=	DECODE(:p_hakgi , '2', '1', :p_hakgi)
//AND		A.ISU_ID			<>	'30'
//AND		NVL(B.PASS_GUBUN, 'N')	<>	'Y'
//AND		A.SUNGJUK_INJUNG			=	'Y'	;
//
//// 이번학기 직전까지 신청한 학점, 재수강체크, 선이수학점 2006학번의 신입생과 2008학번의 편입생이후부터..
//SELECT	SUM(A.HAKJUM)
//INTO		:li_hakgi_hakjum1
//FROM		HAKSA.SUGANG_TRANS	A,
//			HAKSA.GWAMOK_CODE		B
//WHERE		A.GWAMOK_ID		=	B.GWAMOK_ID
//AND		A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//AND		A.HAKBUN			=	:p_hakbun
//AND		A.YEAR			=	:p_year
//AND		A.HAKGI			=	DECODE(:p_hakgi , '2', '1', :p_hakgi)
//AND		A.ISU_ID			<>	'30'
//AND		NVL(B.PASS_GUBUN, 'N')	<>	'Y'
//AND		A.SUNGJUK_INJUNG			=	'Y'	;
//
//
//IF SQLCA.SQLCODE = -1 THEN
//	MESSAGEBOX("오류","DATABASE 오류(7)~R~N" + SQLCA.SQLERRTEXT)
//END IF
//
////이수 가능학점 체크 : 정정기간과 복학생 수강신청기간에는 직전하기 평점을 체크하고 최초수강신청기간에는 체크하지 않음
////----------------		년간 이수 가능학점 체크
////단, 2006학번 신입생과 2008학번 편입생은  직전학기평점이 4.25이상 직전학점 17학점이상일경우 3학점 초과신청가능
//if (ls_iphak_date >= '2006' and ls_iphak_gubun < '04') or (ls_iphak_date >= '2008' and ls_iphak_gubun = '04') or (ls_chk = 'Y') then
//	if ld_before_pyengjum >= 4.25 and li_hakgi_hakjum >= 17 then
//		//직전학기 평점이 4.25을 넘을 경우 직전학기 17학점 이수한경우 44학점으로 년간 신청가능학점 처리
//		if li_year_hakjum1 + li_hakjum1 > 44 then
//			messagebox("확인","년간 신청가능학점을 초과하였습니다.", Exclamation!)
//			return
//		end if
//	else
//		//직전학기 평점이 4.25이 안될 경우 42학점으로 년간 신청가능학점 처리
//		if li_year_hakjum1 + li_hakjum1 > 42 then
//			messagebox("확인","년간 신청가능학점을 초과하였습니다.1", Exclamation!)
//			return
//		end if
//	end if
//else 
//	if ld_before_pyengjum >= 4.0 and is_jungjung = '1' then
//		//직전학기 평점이 4.0을 넘을 경우
//		//재수강이 없더라고 48학점으로 년간 신청가능학점 처리
//		if li_jesu_cnt + li_jesu_cnt1 = 0 then
//			//재수강이 없을 경우
//			if li_year_hakjum + li_hakjum > 48 then
//				messagebox("확인","년간 신청가능학점을 초과하였습니다.", Exclamation!)
//				return
//			end if
//			
//		else
//			//재수강이 있을 경우
//			if li_year_hakjum + li_hakjum > 48 then
//				messagebox("확인","년간 신청가능학점을 초과하였습니다.", Exclamation!)
//				return
//			end if
//			
//		end if	
//		
//	else
//		//직전학기 평점이 4.0이 안될 경우
//
//		if li_jesu_cnt + li_jesu_cnt1 = 0 then
//			if li_year_hakjum + li_hakjum > 42 then
//				messagebox("확인","년간 신청가능학점을 초과하였습니다.1", Exclamation!)
//				return
//			end if
//			
//		else
//			if li_year_hakjum + li_hakjum > 46 then
//				messagebox("확인","년간 신청가능학점을 초과하였습니다.2", Exclamation!)
//				return
//			end if
//			
//		end if	
//		
//	end if
//end if				
////----------------------	 학기별 이수가능학점 체크
//
//if (ls_iphak_date >= '2006' and ls_iphak_gubun < '04') or (ls_iphak_date >= '2008' and ls_iphak_gubun = '04')  or (ls_chk = 'Y') then
//	if ld_before_pyengjum >= 4.25  and li_hakgi_hakjum >= 23 then
//		if li_hakjum_tot1 + li_hakjum1 >= 22 then
//			messagebox("확인","학기별 신청가능학점을 초과하였습니다.", Exclamation!)
//			return
//		end if
//	else
//		messagebox('확인2',li_hakjum_tot1)
//		if li_hakjum_tot1 + li_hakjum1 >19 then
//			messagebox("확인","학기별 신청가능학점을 초과하였습니다.(19)", Exclamation!)
//			return
//			messagebox('확인3',li_hakgi_hakjum)
//		end if
//	end if
//	
//else
//	if ld_before_pyengjum >= 4.0  and is_jungjung = '1' then
//	
//		if li_jesu_cnt + li_jesu_cnt1 = 0 then
//			
//			if li_hakjum_tot + li_hakjum > 27 then
//				messagebox("확인","학기별 신청가능학점을 초과하였습니다.", Exclamation!)
//				return
//			end if
//			
//		else
//			if li_hakjum_tot + li_hakjum > 30 then
//				messagebox("확인","학기별 신청가능학점을 초과하였습니다.", Exclamation!)
//				return
//			end if
//			
//		end if	
//		
//	else
//	
//		if li_jesu_cnt1 = 0 then
//			
//			if li_hakjum_tot + li_hakjum > 23 then
//				messagebox("확인","학기별 신청가능학점을 초과하였습니다.(23)", Exclamation!)
//				return
//			end if
//			
//		else
//			
//			messagebox('li_hakjum',li_hakjum)
//			if li_hakjum_tot + li_hakjum > 26 then
//				messagebox("확인","학기별 신청가능학점을 초과하였습니다.(26)", Exclamation!)
//				return
//			end if
//			
//		end if	
//		
//		
//	end if
//end if
////---------------------	
//

////2003년도 부터 선이수과목은 이수하지 않기로 함.
////---------------------		선이수 과목 6학점 초과 check...
//if	ls_isu_id	=	'30'	then
//	if		(li_hakjum_30 + li_hakjum) 	>	6	then
//			messagebox("확인","선이수과목은 6학점 초과할 수 없읍니다.", Exclamation!)
//			return
//	end if
//
//end if

//----------		교직이수자가 아닌 학생이 교직과목 선택시 일반선택으로 변환

if ls_isu_id = '40' then
	
//	SELECT	NVL(A.YEJUNG_YN, 'N')
//	INTO		:ls_yejung_yn
//	FROM		HAKSA.GJ_YEJUNGJA A, HAKSA.JAEHAK_HAKJUK B
//	WHERE		A.HAKBUN(+)	= B.HAKBUN
//	AND		B.HAKBUN		= :p_hakbun	;

	SELECT	NVL(YEJUNG_YN, 'N')
	INTO		:ls_yejung_yn
	FROM		HAKSA.GJ_YEJUNGJA
	WHERE		HAKBUN	=	:p_hakbun
    USING SQLCA ;

//	if sqlca.sqlcode = 0 then
//		//예정자의 YEJUNG_YN = 'N'경우는 일반선택으로 ..
//		if ls_yejung_yn = 'N' OR isnull(ls_yejung_yn) then	
//			ls_isu_id	=	'80'			
//		end if
//
//	elseif sqlca.sqlcode = 100 then
//
//		SELECT	SUNBAL_YN
//		INTO	:ls_sinchung_yn
//		FROM	HAKSA.GJ_SINCHUNG
//		WHERE	HAKBUN	=	:p_hakbun	;
//		
//		//신청자 테이블에 YEJUNG_YN = 'N 경우 일반선택으로 ..		
//		if ls_sinchung_yn = 'N' OR isnull(ls_sinchung_yn) then
//			ls_isu_id	=	'80'						
//		end if
//		
//	elseif sqlca.sqlcode = -1 then	
//		//예정자, 신청자 테이블에 DATA가 없을경우 일반선택으로 ..
//			ls_isu_id	=	'80'				
//	end if

	if sqlca.sqlcode = 0 then
		//예정자의 YEJUNG_YN = 'N'경우는 일반선택으로 ..
		if ls_yejung_yn = 'N' OR isnull(ls_yejung_yn) then	
			ls_isu_id	=	'80'			
		end if
	else
		//예정자 테이블에 DATA가 없을경우 일반선택으로 ..
			ls_isu_id	=	'80'	
	end if
	
	SELECT	SUNBAL_YN
	INTO	:ls_sinchung_yn
	FROM	HAKSA.GJ_SINCHUNG
	WHERE	HAKBUN	=	:p_hakbun
	 USING SQLCA ;
	
	if sqlca.sqlcode = 0 then		
		//신청자 테이블에 YEJUNG_YN = 'N 경우 일반선택으로 ..		
		if ls_sinchung_yn = 'N' OR isnull(ls_sinchung_yn) then
			ls_isu_id	=	'80'
		else 
			ls_isu_id	=	'40'
		end if		
	else	
		//신청자 테이블에 DATA가 없을경우 일반선택으로 ..
			ls_isu_id	=	'80'				
	end if

end if

//----------		주전공과목 타학과학생이 신청시는 일반선택으로 이수구분변환
if	ls_isu_id	=	'21'	or		ls_isu_id	=	'22'	then
	
	//ls_gwa => 개설학과, p_gwa => 학생 학적학과
	if	left(ls_gwa, 3)	<>	left(p_gwa, 3)	then
		ls_isu_id	=	'80'
	end if
	
end if

//--------------------------------------- 복수전공, 부전공 체크 넣기
SELECT	BUJUNGONG_ID,
			JUNGONG_GUBUN
INTO	:ls_bujun_id,
		:ls_bujun_gubun
FROM	HAKSA.JAEHAK_HAKJUK
WHERE	HAKBUN	=	:p_hakbun
USING SQLCA ;

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(복수/부전공 체크)~R~N" + SQLCA.SQLERRTEXT)
END IF

IF SQLCA.SQLCODE = 0 THEN
	if mid(p_gwamok, 1, 3) <> 'TAA' then	
		if ls_bujun_gubun = '1' then
			//복수
			if mid(p_gwa, 1, 3)	=	mid(ls_bujun_id, 1, 3) then
				ls_isu_id = '60'
				
			end if
					
		elseif ls_bujun_gubun = '2' then
			//부전공
			if mid(p_gwa, 1, 3)	=	mid(ls_bujun_id, 1, 3) then
				ls_isu_id = '50'
				
			end if
			
		end if
	end if		
END IF


//8. 수강신청 시간 중복 check.
SELECT	GWAMOK_ID
INTO	:ls_gwamok_id
FROM
	(
	SELECT	GWAMOK_ID	AS GWAMOK_ID,
				YOIL			AS YOIL,
				SIGAN			AS SIGAN
	FROM 	HAKSA.SIGANPYO		
	WHERE	YEAR 			=	:p_year
	AND	HAKGI			=	:p_hakgi
	AND	GWA			=	:p_gwa
	AND	HAKYUN		=	:p_hakyun
	AND	BAN			=	:p_ban
	AND	GWAMOK_ID	=	:p_gwamok
	AND	GWAMOK_SEQ	=	:p_gwamok_seq
	AND	BUNBAN		=	:p_bunban
	) T1,
	(
	SELECT	B.YOIL	AS YOIL,
				B.SIGAN	AS SIGAN
	FROM 	HAKSA.SUGANG_TRANS	A,
			HAKSA.SIGANPYO			B			
	WHERE	A.YEAR			=	B.YEAR
	AND	A.HAKGI			=	B.HAKGI
	AND	A.GWA				=	B.GWA
	AND	A.HAKYUN			=	B.HAKYUN
	AND	A.BAN				=	B.BAN
	AND	A.GWAMOK_ID		=	B.GWAMOK_ID
	AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
	AND	A.BUNBAN			=	B.BUNBAN
	AND	A.YEAR 			=	:p_year
	AND	A.HAKGI			=	:p_hakgi
	AND	A.HAKBUN			=	:p_hakbun
	) T2
WHERE T1.YOIL	=	T2.YOIL
AND	T1.SIGAN	=	T2.SIGAN
AND	ROWNUM	=	1
USING SQLCA ;


IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(시간중복Check)~R~N" + SQLCA.SQLERRTEXT)
	return
	
ELSEIF SQLCA.SQLCODE = 0 THEN
	messagebox("확인","이미 신청한 과목과 수업시간이 중복됩니다.", Exclamation!)
	return
	
END IF

//DECLARE CUR_SIGAN CURSOR FOR
//SELECT	B.YOIL,
//			B.SIGAN
//FROM 	HAKSA.GAESUL_GWAMOK	A,
//		HAKSA.SIGANPYO			B			
//WHERE	A.YEAR			=	B.YEAR
//AND	A.HAKGI			=	B.HAKGI
//AND	A.GWA				=	B.GWA
//AND	A.HAKYUN			=	B.HAKYUN
//AND	A.BAN				=	B.BAN
//AND	A.GWAMOK_ID		=	B.GWAMOK_ID
//AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//AND	A.BUNBAN			=	B.BUNBAN
//AND	A.YEAR 			=	:p_year
//AND	A.HAKGI			=	:p_hakgi
//AND	A.GWA				=	:p_gwa
//AND	A.HAKYUN			=	:p_hakyun
//AND	A.BAN				=	:p_ban
//AND	A.GWAMOK_ID		=	:p_gwamok
//AND	A.GWAMOK_SEQ	=	:p_gwamok_seq
//AND	A.BUNBAN			=	:p_bunban		;
//
//OPEN CUR_SIGAN	;
//DO
//	FETCH	CUR_SIGAN	INTO	:ls_yoil, :ls_sigan	;
//	
//	IF SQLCA.SQLCODE <> 0 THEN EXIT
//	
//		SELECT	COUNT(A.HAKBUN)
//		INTO	:li_chk
//		FROM 	HAKSA.SUGANG_TRANS	A,
//				HAKSA.SIGANPYO			B			
//		WHERE	A.YEAR			=	B.YEAR
//		AND	A.HAKGI			=	B.HAKGI
//		AND	A.GWA				=	B.GWA
//		AND	A.HAKYUN			=	B.HAKYUN
//		AND	A.BAN				=	B.BAN
//		AND	A.GWAMOK_ID		=	B.GWAMOK_ID
//		AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
//		AND	A.BUNBAN			=	B.BUNBAN
//		AND	A.YEAR 			=	:p_year
//		AND	A.HAKGI			=	:p_hakgi
//		AND	A.HAKBUN			=	:p_hakbun
//		AND	B.YOIL			=	:ls_yoil
//		AND	B.SIGAN			=	:ls_sigan	;
//		
//		IF SQLCA.SQLCODE = -1 THEN
//			MESSAGEBOX("오류","DATABASE 오류(시간중복Check)~R~N" + SQLCA.SQLERRTEXT)
//			return
//		END IF
//		
//		if li_chk > 0 then
//			messagebox("확인","이미 신청한 과목과 수업시간이 중복됩니다.", Exclamation!)
//			return
//		end if		
//	
//LOOP WHILE TRUE
//CLOSE CUR_SIGAN	;
	

//----------------------------------- 수강인원 check...
SELECT	NVL(INWON, 0),
			NVL(SU_INWON, 0)
INTO		:li_inwon,
			:li_su_inwon
FROM		HAKSA.GAESUL_GWAMOK
WHERE	YEAR			=	:p_year
AND	HAKGI			=	:p_hakgi
AND	GWA			=	:p_gwa
AND	HAKYUN		=	:p_hakyun
AND	BAN			=	:p_ban
AND	GWAMOK_ID	=	:p_gwamok
AND	GWAMOK_SEQ	=	:p_gwamok_seq
AND	BUNBAN		=	:p_bunban
USING SQLCA ;

if	li_inwon	<	li_su_inwon	then
	messagebox("오류","수강과목 인원 초과 입니다.", Exclamation!)
	return
end if
//--------------------------수강신청 제한사항 체크 완료----------------------------------

//////////////////////////////////////////////////////////////////////////////////////////////////		데이타 저장
//----------------------	수강신청인원 증가(인원초과를 최대한 방지하기 위해 먼저Update)
UPDATE	HAKSA.GAESUL_GWAMOK
SET		SU_INWON		=	NVL(SU_INWON, 0) + 1
WHERE	YEAR			=	:p_year
AND	HAKGI			=	:p_hakgi
AND	GWA			=	:p_gwa	
AND	HAKYUN		=	:p_hakyun
AND	BAN			=	:p_ban
AND	GWAMOK_ID	=	:p_gwamok
AND	GWAMOK_SEQ	=  :p_gwamok_seq
AND	BUNBAN		= 	:p_bunban
USING SQLCA ;

if	sqlca.sqlcode	<>	0	then
	messagebox("오류","수강신청 인원저장중 오류 발생~r~n" + sqlca.sqlerrtext)
	rollback USING SQLCA ;
	return
end if

//-----------------------			수강신청저장		-----------

INSERT	INTO 	HAKSA.SUGANG_TRANS
			(	HAKBUN,		YEAR,					HAKGI,				GWA,					HAKYUN,				BAN,
				GWAMOK_ID,	GWAMOK_SEQ,			BUNBAN,				ISU_ID,				HAKJUM,				SUNGJUK_INJUNG,
				JOGI_YN,		JESU_YEAR,			JESU_HAKGI,			JESU_GWAMOK_ID,	JESU_GWAMOK_SEQ,
				WORKER,		IPADDR,				WORK_DATE																)
values	(	:p_hakbun,	:p_year,				:p_hakgi,			:p_gwa,				:p_hakyun,			:p_ban,
				:p_gwamok,	:p_gwamok_seq,		:p_bunban,			:ls_isu_id,			:li_siljea_hakjum,			'Y',
				'0',			:ls_j_year,			:ls_j_hakgi,		:ls_j_gwamok,		:li_j_gwamok_seq,
				:gs_empcode,	:gs_ip, 	SYSDATE										)	 USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("오류","수강신청내역 저장중 오류발생~r~n" + sqlca.sqlerrtext)
	rollback  USING SQLCA ;
	return
end if


//수강신청 History 저장
SELECT	nvl(max(SEQ_NO), 0)	+ 1
INTO		:ll_seq_no
FROM	HAKSA.SUGANG_HIS
WHERE	HAKBUN		=	:p_hakbun
AND	YEAR			=	:p_year
AND	HAKGI			=	:p_hakgi
AND	GWAMOK_ID	=	:p_gwamok
AND	GWAMOK_SEQ	=  :p_gwamok_seq
USING SQLCA ;

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("오류","DATABASE 오류(수강신청History)~R~N" + SQLCA.SQLERRTEXT)
	return
END IF

INSERT INTO HAKSA.SUGANG_HIS
			(	HAKBUN,			SEQ_NO,			YEAR,				HAKGI,		GWA,		HAKYUN,	
				BUN,				GWAMOK_ID,		GWAMOK_SEQ,		BUNBAN,		STATUS,
				WORKER,			IPADDR,			WORK_DATE												)
values	(	:p_hakbun,		:ll_seq_no,		:p_year,			:p_hakgi,	:p_gwa,	:p_hakyun,
				:p_ban,			:p_gwamok,		:p_gwamok_seq,	:p_bunban,	'I',
				:gs_empcode,	:gs_ip,	sysdate)	 USING SQLCA ;

if sqlca.sqlcode = 0 then
	commit  USING SQLCA ;
	
else
	
	messagebox("오류","수강신청HISTORY 저장중 오류발생~r~n" + sqlca.sqlerrtext, stopsign!)
	rollback  USING SQLCA ;
	return
	
end if

end subroutine

on w_hsu201a.create
int iCurrent
call super::create
this.st_9=create st_9
this.st_10=create st_10
this.st_8=create st_8
this.st_11=create st_11
this.uo_1=create uo_1
this.dw_main=create dw_main
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_2=create st_2
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_9
this.Control[iCurrent+2]=this.st_10
this.Control[iCurrent+3]=this.st_8
this.Control[iCurrent+4]=this.st_11
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.dw_main
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_con
end on

on w_hsu201a.destroy
call super::destroy
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_8)
destroy(this.st_11)
destroy(this.uo_1)
destroy(this.dw_main)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.dw_con)
end on

event ue_retrieve;string ls_hakbun, ls_gwa_nm, ls_gwa, ls_dr_hakyun, ls_bunban, ls_juya_gubun, ls_hname, ls_year, ls_hakgi, ls_sangtae, ls_ban
int 	 li_ans, li_ans1

//아래쪽의 시간표를 clear한다.
wf_sigan_clear()
dw_3.insertrow(0)

dw_con.accepttext()

ls_hakbun    =	dw_con.Object.hakbun[1]
ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if	ls_hakbun = "" or isnull(ls_hakbun) then
	uf_messagebox(15)
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return -1
	
elseif	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1
		
elseif	ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
		
end if

SELECT	B.FNAME,
			A.SU_HAKYUN,
			DECODE(A.JUYA_GUBUN,'1','주간','야간'),
			A.HNAME,
			A.GWA,
			A.DR_HAKYUN,
			A.SANGTAE,
			NVL(A.BAN, '%')
INTO		:ls_gwa_nm,
			:is_hakyun,
			:ls_juya_gubun,
			:ls_hname,
			:ls_gwa,
			:ls_dr_hakyun,
			:is_sangtae,
			:ls_ban
FROM		HAKSA.JAEHAK_HAKJUK	A,
			HAKSA.GWA_SYM			B
WHERE		A.GWA		=	B.GWA
AND		A.HAKBUN	=	:ls_hakbun
USING SQLCA ;

if sqlca.sqlcode <> 0 then
	messagebox("확인","존재하지 않는 학번입니다.")
	dw_con.Object.hakbun[1] = ''
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
	return -1
else
	is_hakbun	=	ls_hakbun
	is_gwa		=	ls_gwa
end if

//기본자료 set
st_2.text	=	ls_hname + '   ' + ls_gwa_nm + '   ' + is_hakyun + '학년' + '   ' + ls_ban + '   ' + ls_juya_gubun

dw_con.Object.gwa[1]     = ls_gwa
dw_con.Object.hakyun[1] = is_hakyun

li_ans	=	dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, is_hakyun, ls_ban, '%')

li_ans1	=	dw_2.retrieve(ls_year, ls_hakgi, is_hakbun)

//시간표 setting
wf_siganpyo(ls_year, ls_hakgi, is_hakbun)

if li_ans < 1 then
	messagebox("확인","해당 학과의 시간표가 존재하지 않습니다.")
end if

Return 1
end event

event open;call super::open;string	ls_year_now, ls_hakgi_now, ls_year,	ls_hakgi, ls_chk

idw_update[1] = dw_2

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	YEAR,
			HAKGI,
			NEXT_YEAR,
			NEXT_HAKGI
INTO		:ls_year_now,
			:ls_hakgi_now,
			:ls_year,
			:ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG	=	'Y'
USING SQLCA ;

dw_con.Object.year[1] 	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi

//지금이 수강신청 기간인지 정정기간 또는 복학생수강신청기간 인지 CHECK(수강신청 가능학점 체크시 필요함.)
SELECT	YEAR
INTO	:ls_chk
FROM HAKSA.HAKSA_ILJUNG
WHERE	YEAR	=	:ls_year_now
AND	HAKGI	=	:ls_hakgi_now
AND	( TO_CHAR(SYSDATE, 'YYYYMMDDHHMMSS')	BETWEEN	SUGANG_MOD1_FROM	AND	SUGANG_MOD4_TO )
OR		( TO_CHAR(SYSDATE, 'YYYYMMDDHHMMSS')	BETWEEN	SUGANG_BOK_FROM	AND	SUGANG_BOK_TO ) 
USING SQLCA ;

if sqlca.sqlcode = 0  then
	is_jungjung = '1'
	
else
	is_jungjung = '0'
	
end if

dw_3.insertrow(0)
end event

event ue_postopen;call super::ue_postopen;st_2.setPosition(totop!)
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu201a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu201a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu201a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu201a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu201a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu201a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu201a
end type

type uc_insert from w_condition_window`uc_insert within w_hsu201a
end type

type uc_delete from w_condition_window`uc_delete within w_hsu201a
end type

type uc_save from w_condition_window`uc_save within w_hsu201a
end type

type uc_excel from w_condition_window`uc_excel within w_hsu201a
end type

type uc_print from w_condition_window`uc_print within w_hsu201a
end type

type st_line1 from w_condition_window`st_line1 within w_hsu201a
end type

type st_line2 from w_condition_window`st_line2 within w_hsu201a
end type

type st_line3 from w_condition_window`st_line3 within w_hsu201a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu201a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu201a
end type

type gb_1 from w_condition_window`gb_1 within w_hsu201a
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsu201a
integer taborder = 90
end type

type st_9 from statictext within w_hsu201a
integer x = 50
integer y = 1196
integer width = 3579
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = " 수강신청내역"
boolean border = true
boolean focusrectangle = false
end type

type st_10 from statictext within w_hsu201a
integer x = 50
integer y = 388
integer width = 4384
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = " 개설강좌"
boolean border = true
boolean focusrectangle = false
end type

type st_8 from statictext within w_hsu201a
integer x = 59
integer y = 1124
integer width = 1897
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "♣수강신청을 원하는 과목을 DoubleCick하시면 수강신청이 됩니다."
boolean focusrectangle = false
end type

type st_11 from statictext within w_hsu201a
integer x = 59
integer y = 2272
integer width = 1998
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "♣삭제를 원하시면 해당과목을 DoubleClick하시면 됩니다."
boolean focusrectangle = false
end type

type uo_1 from uo_imgbtn within w_hsu201a
integer x = 338
integer y = 40
integer width = 457
integer taborder = 80
boolean bringtotop = true
string btnname = "개설과목조회"
end type

event clicked;call super::clicked;string	ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_isugubun
long		li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_ban         =  func.of_nvl(dw_con.Object.ban[1], '%')
ls_isugubun	=	func.of_nvl(dw_con.Object.isu_id[1], '%')

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return
		
elseif	ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return
		
end if

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_isugubun)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(20)
	return
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return
else
	dw_con.SetFocus()
	dw_con.SetColumn("hakbun")
end if
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on

type dw_main from uo_dwfree within w_hsu201a
integer x = 50
integer y = 460
integer width = 4384
integer height = 640
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_hsu200a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event doubleclicked;call super::doubleclicked;string	ls_year,	ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban, ls_isugubun, ls_hakyun1
integer	li_ans, li_gwamok_seq
string   ll_jaehan_chk, ll_bujungong_id, ll_jungong_gubun, ll_fname, ll_jungong_name
string   ls_hakbun, ls_wan, ls_bun

integer 	ll_bunnap_count

dw_con.AcceptText()
ls_hakbun = dw_con.Object.hakbun[1]

if	row	<=	0	then	return

ls_year			=	this.object.year[row]
ls_hakgi			=	this.object.hakgi[row]
ls_gwa			=	this.object.gwa[row]
ls_hakyun		=	this.object.hakyun[row]
ls_ban			=	this.object.ban[row]
ls_gwamok		=	this.object.gwamok_id[row]
li_gwamok_seq	=	this.object.gwamok_seq[row]
ls_bunban  		=	this.object.bunban[row]

select	jaehan_chk 
into 		:ll_jaehan_chk
from 		haksa.gaesul_gwamok
where 	year = :ls_year 
and		hakgi = :ls_hakgi
and		GWAMOK_ID = :ls_gwamok
and		GWAMOK_SEQ = :li_gwamok_seq
USING SQLCA ;
		
select 	NVL(bujungong_id, '0'), NVL(jungong_gubun, '0')
into 		:ll_bujungong_id, :ll_jungong_gubun
from 		haksa.jaehak_hakjuk
where 	hakbun = :ls_hakbun
USING SQLCA ;
	
select 	fname 
into 		:ll_fname 
from 		cddb.kch003M
where 	gwa = :ll_bujungong_id
USING SQLCA ;
	
if ll_jungong_gubun = '1' then
	ll_jungong_name = '복수전공'
elseif ll_jungong_gubun = '2' then
	ll_jungong_name = '부전공'
else
	ll_jungong_name = ' '
end if

IF ( ll_jungong_name = '1' or ll_jungong_name = '2') then
	IF mid(ls_gwa, 1, 3) = mid(ll_bujungong_id, 1, 3) THEN
		if ll_bujungong_id <> '0' or isnull(ll_bujungong_id) then
				if messagebox("부전공 및 복수,부전공", "복수,부전공 신청자 입니다. ~r~n" +&
							" ~r~n" +&
							"부전공 학과 : " +ll_fname+"~r~n" +&
							" ~r~n" +&
							"복수전공부전공구분 : " +ll_jungong_name+"~r~n" +&
							" ~r~n" +&						
							"계속하시겠습니까? ", Question!, YesNo!, 2) = 2 then
						  return 1
				end if
		end if
	end if
end if
if ll_jaehan_chk = 'Y' then 
		if messagebox("확인","수강제한 과목입니다. ~r~n" +&
					" " +&
					"계속하시겠습니까? ", Question!, YesNo!, 2) = 2 then
				  return 1
		end if
end if

// 학기제 체크-------------------
String ls_iphakgb,   ls_chk,   ls_iphakdt,   ls_jaeipdt,  ls_hjmod, ls_hakgi_hakyun
Int    li_hakgi

SELECT su_hakyun,
       case when nvl(iphak_gubun, ' ') = '04' then '2' else '1' end,
		 iphak_date,
		 substr(jaeiphak_date, 1, 4),
		 hjmod_id
  INTO :ls_hakgi_hakyun,
          :ls_iphakgb,
		 :ls_iphakdt,
		 :ls_jaeipdt,
		 :ls_hjmod
  FROM haksa.jaehak_hakjuk
 WHERE hakbun   = :is_hakbun
 USING SQLCA ;
 
IF sqlca.sqlnrows = 0 THEN
	messagebox("알림", is_hakbun + '의 학번이 재학자료에 없으니 확인바랍니다.')
	return 
END IF

ls_chk          = 'N'

// 재입학당시의 년도,학적구분,학년을 가져 오기
SELECT	su_hakyun,
			HJMOD_ID,
			substr(HJMOD_SIJUM, 1, 4)
INTO	 	:ls_hakyun1,
			:ls_hjmod,
		 	:ls_jaeipdt
FROM 		haksa.HAKJUKBYENDONG
WHERE 	hakbun   = :is_hakbun
AND		HJMOD_ID = 'I'
AND		HJMOD_SIJUM = (	SELECT 	MAX(HJMOD_SIJUM)
									FROM		haksa.HAKJUKBYENDONG
									WHERE 	hakbun   = :is_hakbun
									AND		HJMOD_ID = 'I')
USING SQLCA ;
									
/* 재입학생 학기제 적용 */
IF ls_hjmod     = 'I' THEN
	IF ls_jaeipdt	 >= '2009' THEN
		ls_chk       = 'Y'
	ELSEIF ls_jaeipdt	= '2006' THEN
		IF ls_hakyun1 = '1'    THEN
			ls_chk    = 'Y'
		END IF
	ELSEIF ls_jaeipdt	= '2007' THEN
		IF ls_hakyun1 = '1' OR ls_hakyun1 = '2' THEN
			ls_chk    = 'Y'
		END IF
	ELSEIF ls_jaeipdt	= '2008' THEN
		IF ls_hakyun1 	= '1' OR ls_hakyun1 = '2' OR ls_hakyun1 = '3' THEN
			ls_chk    	= 'Y'
		END IF
	END IF
ELSE
	/* 신입생은 입학일자가 2006년 1월 1일 이후 학기제 적용 */
	IF ls_iphakgb   = '1' THEN
		IF ls_iphakdt  >= '20060101' THEN
			ls_chk       = 'Y'
		END IF
	END IF
	/* 편입생은 입학일자가 2008년 1월 1일 이후 학기제 적용 */
	IF ls_iphakgb   = '2' THEN
		IF ls_iphakdt  >= '20080101' THEN
			ls_chk       = 'Y'
		END IF
	END IF

END IF

/* 등록학기 체크 */
SELECT nvl(COUNT(HAKGI), 0)
  INTO :li_hakgi
  FROM HAKSA.SUNGJUKGYE
 WHERE hakgi in('1', '2')
	AND HAKBUN     = :is_hakbun
 USING SQLCA ;
 
IF sqlca.sqlnrows = 0 THEN
	li_hakgi       = 0
END IF

IF ls_chk         = 'Y' THEN
	IF ls_iphakgb  = '1'    AND li_hakgi >= 8 THEN
		ls_chk      = 'N'
	ELSEIF ls_iphakgb = '2' AND li_hakgi >= 4 THEN
		ls_chk      = 'N'
	END IF
END IF
//------------ 이곳까지 학기제인지 Y 학점제인지 N 체크 : ls_chk


//-------------------------	분납자는 완납시까지 수강신청을 할 수 없다.(정정기간에만 해당)
SELECT	WAN_YN,
			BUN_YN
INTO		:ls_wan,
			:ls_bun
FROM		HAKSA.DUNGROK_GWANRI
WHERE		YEAR		=	:ls_year
AND		HAKGI		=	:ls_hakgi
AND		HAKBUN	=	:ls_hakbun
AND		CHASU		=	1
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	if ls_chk ='N' then
		if ls_wan = 'N' and ls_bun = 'Y' then
			messagebox("확인","등록금 분납자는 완납시까지 수강정정을 할 수 없습니다.")
			return 1
		end if
	end if
	
END IF
SELECT	COUNT(*)
INTO		:ll_bunnap_count
FROM		HAKSA.BUNNAP_GWANRI A,
			HAKSA.DUNGROK_GWANRI	B
WHERE		A.HAKBUN		=	B.HAKBUN
AND		A.YEAR 		=	B.YEAR
AND		A.HAKGI		=	B.HAKGI
AND		A.YEAR		=	:ls_year
AND		A.HAKGI		=	:ls_hakgi
AND		A.HAKBUN		=	:ls_hakbun
AND		B.CHASU 		= 1
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	if ls_chk ='N' then
		if ls_wan = 'Y' and ls_bun = 'Y' then
		ELSE
			if ll_bunnap_count = 1 then
				messagebox("확인","등록금 분납예정자는 완납시까지 수강정정을 할 수 없습니다.")
				return 1
			end if	
		end if		
	end if			
END IF


if ls_hakgi = '1' or ls_hakgi = '2' then
	sugangsave(is_hakbun, ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, li_gwamok_seq, ls_bunban)
	
else
	sugangsave_season(is_hakbun, ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, li_gwamok_seq, ls_bunban)
	
end if

li_ans = dw_2.retrieve(ls_year, ls_hakgi, is_hakbun)

wf_siganpyo(ls_year, ls_hakgi, is_hakbun)

//개설강좌 재조회 - 인원변경사항을 보여주기위해
ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	dw_con.Object.gwa[1]
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_ban         =  func.of_nvl(dw_con.Object.ban[1], '%')
ls_isugubun	=	func.of_nvl(dw_con.Object.isu_id[1], '%')

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_isugubun)

end event

event constructor;call super::constructor;This.settransobject(sqlca)
end event

type dw_2 from uo_dwfree within w_hsu201a
integer x = 50
integer y = 1252
integer width = 3579
integer height = 1004
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_hsu200a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;string ls_year, ls_hakgi, ls_sigan, ls_gwamok
integer	li_gwamok_seq

if	row	<=	0	then
	return
else
	
	ls_year			= this.object.year[row]
	ls_hakgi			= this.object.hakgi[row]
	ls_gwamok		= this.object.gwamok_id[row]
	li_gwamok_seq	=	this.object.gwamok_seq[row]

	wf_sigan_clear()

	//수강신청한 과목의 시간표를 보여주기위한 것.
	
	wf_siganpyo(ls_year, ls_hakgi, is_hakbun)

	DECLARE	CUR_SIGAN CURSOR FOR
		SELECT	B.YOIL||B.SIGAN			
		 FROM	HAKSA.SUGANG_TRANS	A,
					 HAKSA.SIGANPYO			B		
		WHERE	A.YEAR			=	B.YEAR
		AND	A.HAKGI			=	B.HAKGI
		AND	A.GWA				=	B.GWA
		AND	A.HAKYUN			=	B.HAKYUN
		AND	A.BAN				=	B.BAN
		AND	A.GWAMOK_ID		=	B.GWAMOK_ID
		AND	A.GWAMOK_SEQ	=	B.GWAMOK_SEQ
		AND	A.BUNBAN			=	B.BUNBAN
		AND	A.YEAR			=	:ls_year
		AND	A.HAKGI			=	:ls_hakgi
		AND	A.HAKBUN			=	:is_hakbun
		AND	A.GWAMOK_ID		=	:ls_gwamok
		AND	A.GWAMOK_SEQ	=	:li_gwamok_seq
		ORDER BY B.YOIL,
					B.SIGAN
		USING SQLCA ;
	
	OPEN CUR_SIGAN	;
	DO
		FETCH	CUR_SIGAN INTO	:ls_sigan	;
		
		IF SQLCA.SQLCODE <> 0 THEN EXIT ;
		
		wf_sigan_set_click(ls_sigan)
			
	LOOP WHILE TRUE
	CLOSE CUR_SIGAN ;
	
end if

end event

event doubleclicked;call super::doubleclicked;string	ls_year,	ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ls_bunban, ls_isugubun
string	ls_wan, ls_bun
long		li_ans, ll_gwamok_seq, ll_bunnap_count

if	row	<=	0	then	return

if is_sangtae <> '01' then
	messagebox("확인","재학생인 아니므로 수강자료를 삭제할 수 없습니다.")
	return
end if

if messagebox("확인","수강신청 자료를 삭제하시겠습니까?", Question!, YesNo!, 2) = 2 then return

ls_year			=	this.object.year[row]
ls_hakgi			=	this.object.hakgi[row]
ls_gwa			=	this.object.gwa[row]
ls_hakyun		=	this.object.hakyun[row]
ls_ban			=	this.object.ban[row]
ls_gwamok		=	this.object.gwamok_id[row]
ll_gwamok_seq	=	this.object.gwamok_seq[row]
ls_bunban		=  this.object.bunban[row]

// 학기제 체크-------------------
String ls_iphakgb,   ls_chk,   ls_iphakdt,   ls_jaeipdt,  ls_hjmod, ls_hakgi_hakyun
Int    li_hakgi

SELECT su_hakyun,
       case when nvl(iphak_gubun, ' ') = '04' then '2' else '1' end,
		 iphak_date,
		 substr(jaeiphak_date, 1, 6),
		 hjmod_id
  INTO :ls_hakgi_hakyun,
       :ls_iphakgb,
		 :ls_iphakdt,
		 :ls_jaeipdt,
		 :ls_hjmod
  FROM haksa.jaehak_hakjuk
 WHERE hakbun   = :is_hakbun
 USING SQLCA ;
 
IF sqlca.sqlnrows = 0 THEN
	messagebox("알림", is_hakbun + '의 학번이 재학자료에 없으니 확인바랍니다.')
	return 
END IF

ls_chk          = 'N'

/* 재입학생 학기제 적용 */
IF ls_hjmod     = 'I' THEN
	IF ls_year      = '2009' THEN
		ls_chk       = 'Y'
	ELSEIF ls_year  = '2006' THEN
		IF ls_hakgi_hakyun = '1'    THEN
			ls_chk    = 'Y'
		END IF
	ELSEIF ls_year  = '2007' THEN
		IF ls_hakgi_hakyun = '1' OR ls_hakgi_hakyun = '2' THEN
			ls_chk    = 'Y'
		END IF
	ELSEIF ls_year  = '2008' THEN
		IF ls_hakgi_hakyun = '1' OR ls_hakgi_hakyun = '2' OR ls_hakgi_hakyun = '3' THEN
			ls_chk    = 'Y'
		END IF
	END IF
ELSE
	/* 신입생은 입학일자가 2006년 1월 1일 이후 학기제 적용 */
	IF ls_iphakgb   = '1' THEN
		IF ls_iphakdt  >= '20060101' THEN
			ls_chk       = 'Y'
		END IF
	END IF
	/* 편입생은 입학일자가 2008년 1월 1일 이후 학기제 적용 */
	IF ls_iphakgb   = '2' THEN
		IF ls_iphakdt  >= '20080101' THEN
			ls_chk       = 'Y'
		END IF
	END IF

END IF

/* 등록학기 체크 */
SELECT nvl(COUNT(HAKGI), 0)
  INTO :li_hakgi
  FROM HAKSA.SUNGJUKGYE
 WHERE hakgi in('1', '2')
	AND HAKBUN     = :is_hakbun
 USING SQLCA ;
 
IF sqlca.sqlnrows = 0 THEN
	li_hakgi       = 0
END IF

IF ls_chk         = 'Y' THEN
	IF ls_iphakgb  = '1'    AND li_hakgi >= 8 THEN
		ls_chk      = 'N'
	ELSEIF ls_iphakgb = '2' AND li_hakgi >= 4 THEN
		ls_chk      = 'N'
	END IF
END IF
//------------ 이곳까지 학기제인지 Y 학점제인지 N 체크 : ls_chk

//-------------------------	분납자는 완납시까지 수강신청을 할 수 없다.(정정기간에만 해당)
SELECT	WAN_YN,
			BUN_YN
INTO		:ls_wan,
			:ls_bun
FROM		HAKSA.DUNGROK_GWANRI
WHERE	YEAR		=	:ls_year
AND		HAKGI		=	:ls_hakgi
AND		HAKBUN	=	:is_hakbun
AND		CHASU		=	1
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	if	ls_chk	='N' then
		if ls_wan = 'N' and ls_bun = 'Y' then
			messagebox("확인","등록금 분납자는 완납시까지 수강정정을 할 수 없습니다.")
			return 1
		end if
	end if
END IF
SELECT	COUNT(*)
INTO		:ll_bunnap_count
FROM		HAKSA.BUNNAP_GWANRI A,
			HAKSA.DUNGROK_GWANRI	B
WHERE	A.HAKBUN		=	B.HAKBUN
AND		A.YEAR 		=	B.YEAR
AND		A.HAKGI		=	B.HAKGI
AND		A.YEAR		=	:ls_year
AND		A.HAKGI		=	:ls_hakgi
AND		A.HAKBUN		=	:is_hakbun
AND		B.CHASU 		= 1
USING SQLCA ;

IF SQLCA.SQLCODE = 0 THEN
	if	ls_chk	='N' then
		if ls_wan = 'Y' and ls_bun = 'Y' then
		ELSE
			if ll_bunnap_count = 1 then
				messagebox("확인","등록금 분납예정자는 완납시까지 수강정정을 할 수 없습니다.")
				return 1
			end if	
		end if		
	end if			
END IF

sugangdelete(is_hakbun, ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_gwamok, ll_gwamok_seq, ls_bunban)

li_ans = dw_2.retrieve(ls_year, ls_hakgi, is_hakbun)

//수강신청한 과목의 시간표를 보여주기위한 것.
wf_sigan_clear()
wf_siganpyo(ls_year, ls_hakgi, is_hakbun)

//개설강좌 재조회 - 인원변경사항을 보여주기위해
ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	dw_con.Object.gwa[1]
ls_hakyun	=	func.of_nvl(dw_con.Object.hakyun[1], '%')
ls_ban         =  func.of_nvl(dw_con.Object.ban[1], '%')
ls_isugubun	=	func.of_nvl(dw_con.Object.isu_id[1], '%')

li_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban, ls_isugubun)

end event

event constructor;call super::constructor;This.settransobject(sqlca)
end event

type dw_3 from uo_dwfree within w_hsu201a
integer x = 3639
integer y = 1100
integer width = 791
integer height = 1156
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_hsu200a_2_1"
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

type st_2 from statictext within w_hsu201a
integer x = 823
integer y = 188
integer width = 2240
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 31112622
string text = "  "
boolean focusrectangle = false
end type

event constructor;this.setPosition(totop!)
end event

type dw_con from uo_dwfree within w_hsu201a
integer x = 55
integer y = 168
integer width = 4379
integer height = 216
integer taborder = 50
string dataobject = "d_hsu201a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

