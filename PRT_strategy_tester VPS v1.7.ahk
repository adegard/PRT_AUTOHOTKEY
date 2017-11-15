SetWorkingDir %A_ScriptDir%
#Include strings.ahk
Sleep, 250
FileDelete, ResFile.txt
FileDelete, LogFile.txt

;gui parameters windows
Gui, Add, Tab2,, Parameters|Options|Comments&Start  ; Tab2 vs. Tab requires v1.0.47.05.
Gui, Add, Text,, Min. Gain/Loss:
Gui, Add, Edit, vMGL  , 1.5 ; The ym option starts a new column of controls.
Gui, Add, Text,, Min. trades number:
Gui, Add, Edit, vMTN , 10
Gui, Add, Text,, Min. Stop loss:
Gui, Add, Edit, vSL , 0.6
Gui, Tab, 2
Gui, Add, ListBox, vIndiChoice, Bestindicators.txt|indicators.txt
Gui, Add, Checkbox, vcheckTS, Trailing stop 
Gui, Add, ListBox, vTSChoice, TS_Normal.txt|TS_50PERCENT.txt|TS_BREAKEVEN.txt
Gui, Tab, 3
Gui, Add, Edit, vMComment r5  ; r5 means 5 rows tall.
Gui, Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Show
return

ButtonOK:
GuiClose:
GuiEscape:
Gui, Submit  ; Save each control's contents to its associated variable.
;MsgBox `n%IndiChoice% `n %TSChoice% 

Sleep, 3000 

;retrieve name of security to test

WinActivate Rapporto dettagliato
;Sleep, 500 
;WinActivate Rapporto dettagliato
Sleep, 300 
Click 72, 33 ; left corner
Sleep, 300 
Click 72, 33 ; left corner
Sleep, 500
clipboard =  ; Start off empty 
Send #q
Sleep, 550
Click 259, 59 ;right corner
Sleep, 550
Click 259, 59 ;right corner
Sleep, 550
ClipWait  ; Wait for the clipboard to contain text.
Sleep, 400
name=%clipboard%
Sleep, 250 



;append comment in logfile
	FormatTime, Time, ,yyyy/MM/dd h:mm tt

	FileAppend,
	(
	`n
	%Time%
	Security: %name%
	), LogFile.txt
		
		

Loop, Read, %IndiChoice%
{
   total_lines = %A_Index%
}

Loop, %total_lines%
{

WinActivate Rapporto dettagliato


Sleep, 500 
Click 620, 49 ; pulsante modifica

Sleep, 250
clipboard =  ; Start off empty 

Sleep, 100 

; wait for white pixel in strategy window
PixelGetColor, color, 852, 172
While !(color = "0xFFFFFF")
PixelGetColor, color, 852, 172
;------------------------

Click 467, 178 ;select
Sleep, 250
Click 467, 178 ;select
Send, ^a ; select all text with 'control + a'
Sleep 200



; INSERT PARAM TXT 
Sleep, 200
clipboard =  ; Start off empty 
Sleep, 200
FileRead, FileContents0, Strat_param.txt
Sleep 200
clipboard :=FileContents0
Sleep 200
Send ^v
Sleep 200
Send %SL%
Sleep 250
SendInput {enter}


;INSERT INTRO TXT
FileRead, FileContents, Strat_intro.txt
Sleep 400
clipboard :=FileContents
Sleep 400
Send ^v

Sleep, 450
clipboard =  ; Start off empty 
Sleep, 250
FileReadLine, indi, %IndiChoice%, %A_Index%
Sleep 200
clipboard :=indi
Sleep 200
Send ^v
Sleep 250
SendInput {enter}


;append comment in logfile
	FormatTime, Time, ,yyyy/MM/dd h:mm tt

	FileAppend,
	(
	`n
	%Time%: backtest %indi%
	), LogFile.txt
		
		
;INSERT ENTRY  STRATEGY
Sleep, 200
clipboard =  ; Start off empty 
Sleep, 200
FileRead, FileContents2, Strat_end.txt
Sleep 300
clipboard :=FileContents2
Sleep 300
Send ^v
Sleep 250
SendInput {enter}

	;MsgBox Trailing stop check: %checkTS%

	if checkTS=1
	{
	Sleep, 400
	clipboard =  ; Start off empty 
	Sleep, 300
	FileRead, FileEnd2, %TSChoice%
	Sleep 300
	clipboard :=FileEnd2
	Sleep 300
	Send ^v
	}
	

Sleep, 200
Click 1114, 734 ;Probackesta pulsante

Sleep 200
clipboard =  ; Start off empty 


WinActivate Rapporto dettagliato
Sleep, 300

PixelGetColor, color, 932, 205
if color = "0xA1DAA1" ; wait for result pixels green
Sleep, 100 
else Sleep, 2000 

;G/L
Click 341, 233 ;left corner
Sleep, 550
Click 341, 233 ;left corner
Sleep, 550
Send #q
Sleep, 750
Click 398, 259 ;right corner
Sleep, 550
Click 398, 259 ;right corner
ClipWait  ; Wait for the clipboard to contain text.
Sleep, 250
ratio=%clipboard%
Sleep, 250 

		
if ratio >=%MGL%   ; If an IF has more than one line, enclose those lines in braces:
		{
		 
		;number of trades
		Click 261, 302 ;left corner
		Sleep, 550
		Send #q
		Sleep, 650
		Click 285, 320 ;right corner
		Sleep, 250
		Click 285, 320 ;right corner		
		Sleep, 550
		ClipWait  ; Wait for the clipboard to contain text.
		Sleep, 250
		numtrades=%clipboard%
		Sleep, 250 
		
	if numtrades >=%MTN%   ; numb min of trades
		{	

		;guadagno
		Click 192, 120 ;left corner
		Sleep, 550
		Send #q
		Sleep, 550
		Click 430, 142 ;right corner
		Sleep, 550
		ClipWait  ; Wait for the clipboard to contain text.
		Sleep, 250
		res=%clipboard%
		Sleep, 550 

		
		;trade vincenti
		Click 258, 323 ;left corner
		Sleep, 550
		Send #q
		Sleep, 550
		Click 281, 340 ;right corner
		Sleep, 450
		ClipWait  ; Wait for the clipboard to contain text.
		Sleep, 250
		trade=%clipboard%
		Sleep, 250 

		
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

		Sleep, 500
		
				
		}  ;enf if

					
}  ;enf if

		Sleep, 500
		
}  ;end loop 

;SoundBeep  

SetTimer, WinMoveMsgBox, 100
MsgBox, Completed!
ExitApp
Return

WinMoveMsgBox:
SetTimer, WinMoveMsgBox, OFF
WinMove, %A_ScriptName%, Text, 100, 50 
Return

ExitApp