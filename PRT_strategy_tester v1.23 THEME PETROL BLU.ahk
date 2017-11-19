#include FindText_function.ahk

SetWorkingDir %A_ScriptDir%
Sleep, 250
FileDelete, ResFile.txt
FileDelete, LogFile.txt

; TOOLTIP
CustomColor = EEAA99  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
Gui, Font, s32  ; Set a large font size (32-point).
Gui, Add, Text, vMyText cLime, Wait PRT graph...  ; XX & YY serve to auto-size the window.
WinSet, TransColor, %CustomColor% 150
Gui, Show, x200 y400 NoActivate  ; NoActivate avoids deactivating the currently active window.


;WHERE IS THE GRAPH WINDOW?
;image search--------------------
 imageAppeared := false
 Fx:=""
 Sx:=""
 Tx:=""
 delta:= 50
while(imageAppeared = false)
{
 PixelSearch, Fx, Fy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xC8C2B8, 3, Fast
 Sleep,10
 PixelSearch, Sx, Sy, Fx, Fy, Fx+delta, Fy+delta, 0x3535F2, 3, Fast
 Sleep,10
 PixelSearch, Tx, Ty, Fx, Fy, Fx+delta, Fy+delta, 0xC0EDC0, 3, Fast

		if(Fx<>"" && Sx<>"" && Tx<>"")
		{
			imageAppeared := true
			Gui, cancel
		}
}
;--------------------------------

WinGet, graph_id, ID, A
WingetTitle TitleVar, A ; Get title from Active window.
;WinMaximize, ahk_id %graph_id%
;MsgBox, The active window's ID is "%graph_id%".
Sleep, TMI
WinActivate % "ahk_id "graph_id
StringLeft, StratName, TitleVar, 10
;MsgBox %StratName%

;gui parameters windows
Gui, New
Gui, Add, Tab2,w630 h470, Parameters|Entry|Indicators|Trailing|Comments&Start  ; Tab2 vs. Tab requires v1.0.47.05.
Gui, Add, Text,, Min. Gain/Loss:
Gui, Add, Edit, vMGL  , 1 ; The ym option starts a new column of controls.
Gui, Add, Text,, Min. trades number:
Gui, Add, Edit, vMTN , 10
Gui, Add, Text,, Min. Stop loss:
Gui, Add, Edit, vSL , 0.6
Gui, Add, Text,, Timer interuptions:
Gui, Add, Edit, vTMI , 450
Gui, Tab, 2
Gui, Add, Text,, Please select entry logic:
Gui, Add, ListBox,w540 vEntryChoice, Strat_IndiCROSSbb.txt|Strat_PriceVsIndi.txt|Strat_entry1.txt|Strat_IndiCROSSmean.txt
Gui, Tab, 3
Gui, Add, Text,, Please select Indicator.txt for all indicators:
Gui, Add, ListBox,w540  vIndiChoice, indicators.txt|Bestindicators.txt
Gui, Tab, 4
Gui, Add, Checkbox, vcheckTS, Trailing stop 
Gui, Add, Text,, If checked, please select Trailing stop type:
Gui, Add, ListBox,w540 vTSChoice, TS_Normal.txt|TS_MFE.txt|TS_50PERCENT.txt|TS_BREAKEVEN.txt|TS_ATR.txt|TAKE_PROFIT.txt
Gui, Tab, 5
Gui, Add, Edit, vMComment w540 r5  ; r5 means 5 rows tall.
Gui, Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Add, Text,, Press OK to start
Gui, Add, Text,, Press ESC at any time to exit
Gui, Add, Text,, Consult ResFile.txt and LogFile.txt at the end

Gui, Show, w640 h480, PRT Backtester
return

ButtonOK:
GuiClose:
GuiEscape:
Gui, Submit  ; Save each control's contents to its associated variable
;end gui script
;append comment in logfile
	FormatTime, Time, ,yyyy/MM/dd h:mm tt

	FileAppend,
	(
	`n
	%Time%
	Security: %StratName%
	Comment: %MComment%
	), LogFile.txt
		
	
Sleep, TMI*2
;CLICK ADD BUTTON
;image search--------------------
 imageAppeared := false
 Fx:=""
 Sx:=""
 Tx:=""
 delta:= 50
while(imageAppeared = false)
{
 PixelSearch, Fx, Fy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xC8C2B8, 3, Fast
 Sleep,10
 PixelSearch, Sx, Sy, Fx, Fy, Fx+delta, Fy+delta, 0x3535F2, 3, Fast
 Sleep,10
 PixelSearch, Tx, Ty, Fx, Fy, Fx+delta, Fy+delta, 0xC0EDC0, 3, Fast

		if(Fx<>"" && Sx<>"" && Tx<>"")
		{
			imageAppeared := true
			;Gui, cancel
			Click, %Fx%, %Fy%
		}
}
;--------------------------------
  

Loop, Read, %IndiChoice%
{
   total_lines = %A_Index%
}


Sleep, TMI
;CLICK STRATEGY BACKTEST
;SKIPPED
;--------------------------------

Sleep, TMI
;CLICK NEW STRATEGY
;image search--------------------
 imageAppeared := false
 Fx:=""
 Sx:=""
 Tx:=""
 delta:= 100
while(imageAppeared = false)
{
 PixelSearch, Fx, Fy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xE3DCCD, 3, Fast
 Sleep,10
 PixelSearch, Sx, Sy, Fx, Fy, Fx+delta, Fy+delta, 0xB4B4B4, 3, Fast
 Sleep,10
 PixelSearch, Tx, Ty, Fx, Fy, Fx+delta, Fy+delta, 0xEAEAEA, 3, Fast

		if(Fx<>"" && Sx<>"" && Tx<>"")
		{
			imageAppeared := true
			;Gui, cancel
			Click, %Sx%, %Sy%
		}
}
;--------------------------------

Sleep, TMI
;Click tab BACKTEST CREATION
;image search--------------------
 imageAppeared := false
 Fx:=""
 Sx:=""
 Tx:=""
 delta:= 200
while(imageAppeared = false)
{
 PixelSearch, Fx, Fy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xEB9057, 3, Fast
 Sleep,10
 PixelSearch, Sx, Sy, Fx-10, Fy-10, Fx+delta, Fy+delta, 0xD1F4F4, 3, Fast
 Sleep,10
 PixelSearch, Tx, Ty, Fx-10, Fy-10, Fx+delta, Fy+delta, 0xF0F0F0, 3, Fast

		if(Fx<>"" && Sx<>"" && Tx<>"")
		{
			imageAppeared := true
			;Gui, cancel
			Tx:=Tx+20
			Click, %Tx%, %Ty%
		}
}
;--------------------------------
Sleep, TMI*2

;ENTERING STRATEGY NAME
;image search--------------------
 imageAppeared := false
 Fx:=""
 Sx:=""
 Tx:=""
 delta:= 200
while(imageAppeared = false)
{
 PixelSearch, Fx, Fy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xCEC0A1, 3, Fast
 Sleep,10
 PixelSearch, Sx, Sy, Fx-10, Fy-10, Fx+delta, Fy+delta, 0xFFFFFF, 3, Fast
 Sleep,10
 PixelSearch, Tx, Ty, Fx-10, Fy-10, Fx+delta, Fy+delta, 0xC9BB9C, 3, Fast

		if(Fx<>"" && Sx<>"" && Tx<>"")
		{
			imageAppeared := true
			;Gui, cancel
			Sx:=Sx+20
			Click, %Sx%, %Sy%
			Click, %Sx%, %Sy%
			Click, %Sx%, %Sy%
		}
}
;--------------------------------
Sleep, TMI
Send, %StratName%
Send, %A_Min%
Sleep, TMI

Loop, %total_lines%
{
clipboard =  ; Start off empty 

Gui, cancel

Sleep, TMI


;image search--------------------
 imageAppeared := false
 Fx:=""
 Sx:=""
 Tx:=""
 delta:= 200
while(imageAppeared = false)
{
 PixelSearch, Fx, Fy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x7CDFF4, 3, Fast
 Sleep,10
 PixelSearch, Sx, Sy, Fx-10, Fy-10, Fx+delta, Fy+delta, 0xFFFFFF, 3, Fast
 Sleep,10
 PixelSearch, Tx, Ty, Fx-10, Fy-10, Fx+delta, Fy+delta, 0xE6E6E6, 3, Fast

		if(Fx<>"" && Sx<>"" && Tx<>"")
		{
			imageAppeared := true
			;Gui, cancel
			Ty:=Ty+100
			Click, %Tx%, %Ty%
			Sleep, TMI
			Click, %Tx%, %Ty%
		}
}
;--------------------------------
;MsgBox stop
Sleep, TMI
Send, ^a ; select all text with 'control + a'
Sleep, TMI*2



; INSERT PARAM TXT 
Sleep, TMI
clipboard =  ; Start off empty 
Sleep, TMI
FileRead, FileContents0, Strat_param.txt
Sleep, TMI
clipboard :=FileContents0
Sleep, TMI
Send ^v
Sleep, TMI
Send %SL%
Sleep, TMI
SendInput {enter}


;INSERT INTRO TXT
FileRead, FileContents, Strat_intro.txt
Sleep, TMI
clipboard :=FileContents
Sleep, TMI
Send ^v

Sleep, TMI
clipboard =  ; Start off empty 
Sleep, TMI
FileReadLine, indi, %IndiChoice%, %A_Index%
Sleep, TMI
clipboard :=indi
Sleep, TMI
Send ^v
Sleep, TMI
SendInput {enter}


;append comment in logfile
	FormatTime, Time, ,yyyy/MM/dd h:mm tt

	FileAppend,
	(
	`n
	%Time%: backtest %indi%
	), LogFile.txt
		
		
;INSERT ENTRY STRATEGY CHOOSE
Sleep, TMI
clipboard =  ; Start off empty 
Sleep, TMI
FileRead, FileContent3, %EntryChoice%
Sleep, TMI
clipboard :=FileContent3
Sleep, TMI
Send ^v
Sleep, TMI
SendInput {enter}

;INSERT POSITION ORDERs
Sleep, TMI
clipboard =  ; Start off empty 
Sleep, TMI
FileRead, FileContents2, Strat_end.txt
Sleep, TMI
clipboard :=FileContents2
Sleep, TMI
Send ^v
Sleep, TMI
SendInput {enter}


Sleep, TMI
;insert Trailing choise
	if checkTS=1
	{
Sleep, TMI
	clipboard =  ; Start off empty 
Sleep, TMI
	FileRead, FileEnd2, %TSChoice%
Sleep, TMI
	clipboard :=FileEnd2
Sleep, TMI
	Send ^v
	}
	
	; TOOLTIP
Gui, new
CustomColor = EEAA99  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
Gui, Font, s32  ; Set a large font size (32-point).
Gui, Add, Text, vMyText cLime, %indi% ; XX & YY serve to auto-size the window.
WinSet, TransColor, %CustomColor% 150
Gui, Show, x200 y400 NoActivate  ; NoActivate avoids deactivating the currently active window.


Sleep, TMI
;CLICK Probackest SECTION 
;image search--------------------
 imageAppeared := false
 Fx:=""
 Sx:=""
 Tx:=""
 delta:= 150
while(imageAppeared = false)
{
 PixelSearch, Fx, Fy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xD08929, 3, Fast
 Sleep,10
 PixelSearch, Sx, Sy, Fx, Fy, Fx+delta, Fy+delta, 0xBCBCBC, 3, Fast
 Sleep,10
 PixelSearch, Tx, Ty, Fx, Fy, Fx+delta, Fy+delta, 0x01C001, 3, Fast

		if(Fx<>"" && Sx<>"" && Tx<>"")
		{
			imageAppeared := true
			;Gui, cancel
			Click, %Tx%, %Ty%
		}
}
;--------------------------------
Sleep, TMI


;CLICK Probackest BUTTON 
Text:="|<Modify>0x758C96@1.00$20.00007zw0000000000E004001000E004001000E004001000E004001000E00400100000000000001zz0008"
if (ok:=FindText(0, 0, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
Click, %X%, %Y%
}


Sleep, TMI

if report_id<>""
WinActivate, ahk_id %report_id%
else
{
; IS THERE REPORT WINDOW?
;image search--------------------
 imageAppeared := false
 Fx:=""
 Sx:=""
 Tx:=""
 delta:= 200
while(imageAppeared = false)
{
 PixelSearch, Fx, Fy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x3232E6, 3, Fast
 Sleep,10
 PixelSearch, Sx, Sy, Fx, Fy, Fx+delta, Fy+delta, 0xD0CAD4, 3, Fast
 Sleep,10
 PixelSearch, Tx, Ty, Fx, Fy, Fx+delta, Fy+delta, 0xC2BCD2, 3, Fast

		if(Fx<>"" && Sx<>"" && Tx<>"")
		{
			imageAppeared := true
			;Gui, cancel
			Click, %Tx%, %Ty%
			Sleep, TMI*2
			Click, %Tx%, %Ty%
		}
}
;--------------------------------



Sleep, TMI*2

;maximize report window
WinGet, report_id, ID, A
WingetTitle TitleReport, A ; Get title from Active window.
WinMaximize, ahk_id %report_id%
}
Sleep, TMI*2
clipboard =  ; Start off empty 

Sleep, TMI

MyTest:  ; wait for pixel color change --> no change
PixelGetColor, color, 932, 205
Sleep, TMI*3
PixelGetColor, color2, 932, 205
;MsgBox %color% - %color2%
if color = %color2%
Sleep, TMI
else 
Goto, MyTest
 

;G/L
Click 341, 233 ;left corner
Sleep, TMI
Click 341, 233 ;left corner
Sleep, TMI
Send #q
Sleep, TMI
Click 398, 259 ;right corner
Sleep, TMI
Click 398, 259 ;right corner
ClipWait  ; Wait for the clipboard to contain text.
Sleep, TMI
ratio=%clipboard%
Sleep, TMI

	; TOOLTIP
Gui, cancel
Gui, new
CustomColor = EEAA99  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
Gui, Font, s32  ; Set a large font size (32-point).
Gui, Add, Text, vMyText cLime, Gain/Loss: %ratio% ; XX & YY serve to auto-size the window.
WinSet, TransColor, %CustomColor% 150
Gui, Show, x200 y400 NoActivate  ; NoActivate avoids deactivating the currently active window.


		
if ratio >=%MGL%   ; If an IF has more than one line, enclose those lines in braces:
		{
		 
		;number of trades
		Click 261, 302 ;left corner
		Sleep, TMI
		Send #q
		Sleep, TMI
		Click 298, 319 ;right corner
		Sleep, TMI
		Click 298, 319 ;right corner		
		Sleep, TMI
		ClipWait  ; Wait for the clipboard to contain text.
		Sleep, TMI
		numtrades=%clipboard%
		Sleep, TMI
		
;	if numtrades >=%MTN%   ; numb min of trades
;		{	

		;guadagno
		Click 192, 120 ;left corner
		Sleep, TMI
		Send #q
		Sleep, TMI
		Click 430, 142 ;right corner
		Sleep, TMI
		ClipWait  ; Wait for the clipboard to contain text.
		Sleep, TMI
		res=%clipboard%
		Sleep, TMI

		
		;trade vincenti
		Click 258, 323 ;left corner
		Sleep, TMI
		Send #q
		Sleep, TMI
		Click 281, 340 ;right corner
		Sleep, TMI
		ClipWait  ; Wait for the clipboard to contain text.
		Sleep, TMI
		trade=%clipboard%
		Sleep, TMI

		
		FormatTime, Time, ,yyyy/MM/dd h:mm tt

		FileAppend,
		(
		`n
		%Time%
		Indicator: %indi%
		Result: %res% 
		Gain/loss: %ratio%
		Num. trades: %numtrades%
		Trade vincenti: %Trade%
		Perc: %Trade%/%numtrades%*100
		), ResFile.txt

		Sleep, TMI
		
				
;		}  ;enf if

					
}  ;enf if

		Sleep, TMI

;CLICK MODIFY BUTTON 		
;image search--------------------
 imageAppeared := false
 Fx:=""
 Sx:=""
 Tx:=""
 delta:= 100
while(imageAppeared = false)
{
 PixelSearch, Fx, Fy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x00574C, 3, Fast
 Sleep,10
 PixelSearch, Sx, Sy, Fx, Fy, Fx+delta, Fy+delta, 0x00574C, 3, Fast
 Sleep,10
 PixelSearch, Tx, Ty, Fx, Fy, Fx+delta, Fy+delta, 0xF9F9F9, 3, Fast
		if(Fx<>"" && Sx<>"" && Tx<>"")
		{
			imageAppeared := true
			;Gui, cancel
			Click, %Tx%, %Ty%
		}
}
;--------------------------------

		
}  ;end loop 

		;CLICK MODIFY BUTTON 
;image search--------------------
 imageAppeared := false
 Fx:=""
 Sx:=""
 Tx:=""
 delta:= 100
while(imageAppeared = false)
{
 PixelSearch, Fx, Fy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x00574C, 3, Fast
 Sleep,10
 PixelSearch, Sx, Sy, Fx, Fy, Fx+delta, Fy+delta, 0x00574C, 3, Fast
 Sleep,10
 PixelSearch, Tx, Ty, Fx, Fy, Fx+delta, Fy+delta, 0xF9F9F9, 3, Fast

		if(Fx<>"" && Sx<>"" && Tx<>"")
		{
			imageAppeared := true
			;Gui, cancel
			Click, %Tx%, %Ty%
		}
}
;--------------------------------

MsgBox, WORK Completed!
ExitApp
Return

Esc:: ExitApp

