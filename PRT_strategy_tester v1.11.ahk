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
Appeared := false
X=""
;Text:="|<Graph_add>*185$32.00000ES00040000103U72G0I1kYU5UQF81y74G0HNX40wH0V2A6EMEz8WAYl78KF8Vn3MHkQFw4M76E101kgCFk0C7YS3U1t7yzryFzjxzYzzzzt00000M00005zzzzz000008"
Text:="|<graph_puls>*185$32.zzzzzs00004000011s000E000040C0Q981E72G0K1l4U7sQF81BaAE3lA248kN1V3wW8mH4QVN4W7ABVD1l7kFUQN04072kt700sSFsC07YTvzTt7yzryHzzzzY00001U0000M"

while(Appeared = false)
{
    ok:=FindText(0, 0, 150000, 150000, 0, 0, Text)
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
  ;Click, %X%, %Y%
  Sleep, TMI*5
    if(X<>"")
    {
      Appeared := true
	 Gui, cancel
    }
}

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
Gui, Add, Tab2,, Parameters|Options|Comments&Start  ; Tab2 vs. Tab requires v1.0.47.05.
Gui, Add, Text,, Min. Gain/Loss:
Gui, Add, Edit, vMGL  , 1 ; The ym option starts a new column of controls.
Gui, Add, Text,, Min. trades number:
Gui, Add, Edit, vMTN , 10
Gui, Add, Text,, Min. Stop loss:
Gui, Add, Edit, vSL , 0.6
Gui, Add, Text,, Timer interuptions:
Gui, Add, Edit, vTMI , 450
Gui, Tab, 2
Gui, Add, Text,, Please select Indicator.txt for all indicators:
Gui, Add, ListBox, vIndiChoice, indicators.txt|Bestindicators.txt
Gui, Add, Checkbox, vcheckTS, Trailing stop 
Gui, Add, Text,, If checked, please select Trailing stop type:
Gui, Add, ListBox, vTSChoice, TS_Normal.txt|TS_MFE.txt|TS_50PERCENT.txt|TS_BREAKEVEN.txt|TS_ATR.txt|TAKE_PROFIT.txt
Gui, Tab, 3
Gui, Add, Edit, vMComment r5  ; r5 means 5 rows tall.
Gui, Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Add, Text,, Press OK to start
Gui, Add, Text,, Press ESC at any time to exit
Gui, Add, Text,, Consult ResFile.txt and LogFile.txt at the end

Gui, Show
return

ButtonOK:
GuiClose:
GuiEscape:
Gui, Submit  ; Save each control's contents to its associated variable.



;append comment in logfile
	FormatTime, Time, ,yyyy/MM/dd h:mm tt

	FileAppend,
	(
	`n
	%Time%
	Security: %StratName%
	Comment: %MComment%
	), LogFile.txt
		
	
Click, %X%, %Y%	

Loop, Read, %IndiChoice%
{
   total_lines = %A_Index%
}


Sleep, TMI*2
;CLICK STRATEGY BACKTEST
Text:="|<strat_backtest>*173$45.00001k000000C0000001k000000D0000s00k00070000000s000000700S0000E07s000000v010000CQ480203VVz01s0QCTs0T7z1rD07xzk7kE1vzy0w00SD00000zVs00007kC0k001w0kD000Q800s003XU07000sw00s004"
if (ok:=FindText(0, 0, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
  Click, %X%, %Y%
}
Sleep, TMI
;CLICK NEW STRATEGY
Text:="|<new_BT>*204$25.7U004800C7zs40zy20E5V082MsQ16SM0VX80ENw0DwAz0260013DzsVU00Ek008Mzy4A0026Tzl3000VbzwEk008Nzz4A003"
if (ok:=FindText(0, 0, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
   Click, %X%, %Y%
	Sleep, TMI
   Click, %X%, %Y%
}

Sleep, TMI
;Click tab BACKTEST CREATION
WinAppeared := false
X=""
Text:="|<creazione>*201$14.zzzzzzzzzk0w0701k0Q0701k0Q0701k0Q0701k0Q0701k0Tzz0000000008"
while(WinAppeared = false)
{
    ok:=FindText(0, 0, 150000, 150000, 0, 0, Text)
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
  ;Click, %X%, %Y%
  Sleep, TMI*3
    if(X<>"")
    {
      WinAppeared := true
	Click, %X%, %Y%
	Sleep, TMI
	Click, %X%, %Y%

    }
}
Sleep, TMI*2

;ENTERING STRATEGY NAME
Text:="|<Spread_chStratName>*213$71.000000000001zzzzzzzzzzzzzzzzzzzzzzzs0000007zzzzk0000001zzzzU0000003w1Tz00000007s2Ty0000000Dk4Tw0000000TUDzs0000000zCQzk0000001y10TU0000003wwQT00000007s9gS0000000Dnk8w0000000TV0ls0000000zC33k0000001yS47U0000003ww8T00000007s4Ey0000000Dzw7w0000000Tzzzs0000001zzzzzzzzzzzzzzzzzzzzzzzzzzzz000000000001"
if (ok:=FindText(540, 13, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
  Sleep, TMI
  Click, %X%, %Y%
  Click, %X%, %Y%
  Click, %X%, %Y%
}
Sleep, TMI
Send, %StratName%
Send, %A_Min%
Sleep, TMI

Loop, %total_lines%
{
clipboard =  ; Start off empty 

Gui, cancel

Sleep, TMI

; wait for white pixel in strategy window
PixelGetColor, color, 852, 172
While !(color = "0xFFFFFF")
PixelGetColor, color, 852, 172
;------------------------

Click 467, 178 ;select
Sleep, TMI
Click 467, 178 ;select
Send, ^a ; select all text with 'control + a'
Sleep, TMI



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
		
		
;INSERT ENTRY  STRATEGY
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

	;MsgBox Trailing stop check: %checkTS%

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
Text:="|<Probacktest>*155$71.0000000000000000000000000000000000000000000000003zzzzzU00000Dzrzjz000000Tzjzzy000000zzzzzw000001zzzzzw000Q0200000M000s0400000E001s0800000U003U0E00001000200U00002000001000004000002000008000E0400000E003k0800000U00DX0E00001000zi0U00002003rw100000400D7U200000807wD0400000E0DUQ0800000U0y0M0E0000103U01"
if (ok:=FindText(0, 0, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
  Click, %X%, %Y%
}
Sleep, TMI
;TEST ALREADY CHECKED SPREAD
Text:="|<Spread_checked>*181$69.Uzz0000000047zs00000000Uzz0000000047zs00000000Uzz0000000047zs00000000Uzz0000000047zs000E0000Uzz00zy000047zs040kT000Uzz00UC2A0047zs043EMDRtUzz00gu1tDNg7zs07yE1dvxUzz00bW6BDMQ7zs04METDNxUzz00X2010047zs040E0800Uzz00zy000047zs00000000Uzz0000000047zs00000000Uzz0000000047zs00000000Uzz000000004"
if (ok:=FindText(0, 0, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
  ; Click, %X%, %Y%
}
else
{
	;CLICK TO CHECK SPREAD
	Text:="|<Spread_check>*182$67.zz000000000TzU00000000Dzk000000007zs000000003zw000000001zy000000000zz000000000TzU00000000Dzk0DzU00007zs040ET0003zw02088k001zy010463rSSzz00U21tDNdzzU0E106bjrzzk080VXHq6Tzs040ETDNxzzw020804001zy010402000zz00zy00000TzU00000000Dzk000000007zs000000003zw000000001zy000000000zz000000000E"
	if (ok:=FindText(0, 0, 150000, 150000, 0, 0, Text))
	{
	  CoordMode, Mouse
	  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
	   Click, %X%, %Y%
	}
}
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



; IS THERE REPORT WINDOW?
ReportAppeared := false
X=""
Text:="|<report>*153$23.0000Dzz0E020U0410083zzk7zzUDzz0Tzy0zzw1zzs3zzk7zzUDzz0Tzy0zzw1zzs00000000Dzz0Tzy0zzw1zzs3zzk7zzV"

while(ReportAppeared = false)
{
    ok:=FindText(0, 0, 150000, 150000, 0, 0, Text)
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
  ;Click, %X%, %Y%
  Sleep, TMI*5
    if(X<>"")
    {
     ReportAppeared := true
	 Sleep, TMI
	 Click, %X%, %Y%
    }
}





;maximize report window
WinGet, report_id, ID, A
WingetTitle TitleReport, A ; Get title from Active window.
WinMaximize, ahk_id %report_id%

Sleep, TMI
clipboard =  ; Start off empty 

;Sleep, TMI
;WinActivate Rapporto dettagliato
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
Text:="|<Modify>0x758C96@1.00$20.00007zw0000000000E004001000E004001000E004001000E004001000E00400100000000000001zz0008"
if (ok:=FindText(639, 48, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
Click, %X%, %Y%
}

		
}  ;end loop 

		;CLICK MODIFY BUTTON 
Text:="|<Modify>0x758C96@1.00$20.00007zw0000000000E004001000E004001000E004001000E004001000E00400100000000000001zz0008"
if (ok:=FindText(639, 48, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
Click, %X%, %Y%
}

MsgBox, WORK Completed!
ExitApp
Return

Esc:: ExitApp

