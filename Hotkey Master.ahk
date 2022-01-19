#NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

scripts_path := "C:\Users\98joh\OneDrive\Documents\AutoHotkeyScripts"
#include C:\Users\98joh\OneDrive\Documents\AutoHotkeyScripts\ShowApps.ahk

; Hwnd of each of the monitors
Monitor1 := 852919
Monitor2 := 132295

================================================================================================
;  CapsLock processing.  Must double tap CapsLock to toggle CapsLock mode on or off.
;================================================================================================
; Must double tap CapsLock to toggle CapsLock mode on or off.
; CapsLock::
;     KeyWait, CapsLock                                                   ; Wait forever until Capslock is released.
;     KeyWait, CapsLock, D T0.1                                        ; ErrorLevel = 1 if CapsLock not down within 0.2 seconds.
;     if ((ErrorLevel = 0) && (A_PriorKey = "CapsLock") )                 ; Is a double tap on CapsLock?
;         {
;         SetCapsLockState, % GetKeyState("CapsLock","T") ? "Off" : "On"  ; Toggle the state of CapsLock LED
;         }
; returnw

#MaxThreadsPerHotkey, 1

; Toggle finder for windows
CapsLock::
    KeyWait, CapsLock                                                   ; Wait forever until Capslock is released.
    KeyWait, CapsLock, D T0.4                                          ; ErrorLevel = 1 if CapsLock not down within 0.2 seconds.
    if ((ErrorLevel = 0) && (A_PriorKey = "CapsLock") )                 ; Is a double tap on CapsLock?
    {
        toggle:=true
        while, toggle
        {
            ;MsgBox started
            Input, KeyCombo, T3 L3 M, {enter}.{esc}{tab}, vsc,esc,run,set,sti,gma,dic,you,mus,dis,vch,vlc,ank,fex,pow,app,cal,dcc,dcd,inf,res,vad,new,ter,wet,map,spy,pia,sm1,sm2
            switch ErrorLevel
            { 
            case "Max":
                ; MsgBox, You entered "%KeyCombo%", which is the maximum length of text.
                ; goto End
            case "Timeout":
                ; MsgBox, You entered "%KeyCombo%" at which time the input timed out.
                goto End
            case "NewInput":
                goto End
            default:
                if InStr(ErrorLevel, "EndKey:")
                {
                    ; MsgBox, You entered "%KeyCombo%" and terminated the input with %ErrorLevel%.
                    goto End
                }
            }
            switchBlock:
            Switch KeyCombo
            {
                ; Set monitor 1

                ; Set monitor 2
                Case "sm2": SetMonitor2()
                ; Open piano
                Case "pia": OpenOrShowAppBasedOnAppModelUserID("Pianoteq", "{6D809377-6AF0-444B-8957-A3773F02200E}\Modartt\Pianoteq 7\Pianoteq 7.exe")
                ; Open window spy
                Case "spy": OpenOrShowAppBasedOnAppModelUserID("Window Spy", "{6D809377-6AF0-444B-8957-A3773F02200E}\AutoHotkey\WindowSpy.ahk")
                ; Open mapspy
                Case "map": OpenOrShowAppBasedOnAppModelUserID("Google 지도", "Chrome._crx_mnhkaebcjjkapnbdaogjamfbcj")
                ; Open weather
                Case "wet": OpenOrShowAppBasedOnAppModelUserID("날씨", "Microsoft.BingWeather_8wekyb3d8bbwe!App")
                ; Open terminal
                Case "ter": OpenOrShowAppBasedOnAppModelUserIDAndExe("WindowsTerminal.exe", "Microsoft.WindowsTerminal_8wekyb3d8bbwe!App")
                ; Open Naver news
                Case "new": OpenOrShowAppBasedOnAppModelUserID("네이버 뉴스", "Chrome._crx_ncncifmmacfekhnafjkdpackopew")
                ; Open Volume mixer
                Case "vad": Send ^+v
                ; Discord join 러비더비
                Case "dcd": DiscordJoinChannel()
                ; Discord camera toggle
                Case "dcc": DiscordCameraToggle()
                ; Show apps
                Case "app": OpenAppsFolder()
                ; Open or show calculator
                Case "cal": OpenOrShowAppBasedOnAppModelUserID("계산기", "Microsoft.WindowsCalculator_8wekyb3d8bbwe!App")
                ; Open or Show Powerpoint
                Case "pow": OpenOrShowAppBasedOnAppModelUserID("PowerPoint", "Microsoft.Office.POWERPNT.EXE.15")
                ; Send escape
                Case "esc": Send {Esc}
                ; Open or show VSCode
                Case "vsc": OpenOrShowAppBasedOnAppModelUserID("Visual Studio Code", "Microsoft.VisualStudioCode")
                ; Open run dialogue
                Case "run": Send, #r
                ; Open or show settings
                Case "set": OpenOrShowAppBasedOnAppModelUserID("설정", "windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel")
                ; Open or show sticky notes
                Case "sti": OpenOrShowAppBasedOnAppModelUserID("Sticky Notes", "Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe!App")
                ; Open or show gmail
                Case "gma": OpenOrShowAppBasedOnAppModelUserID("Gmail", "Chrome._crx_kmhopmchchjodmpfaaphdclmlj")
                ; Open or show dictionary
                Case "dic": OpenShowNaverDict()
                ; Open or show youtube
                Case "you": OpenOrShowAppBasedOnAppModelUserID("YouTube", "Chrome._crx_aimnkijcamfeangaknmldooml")
                ; Open or show discord chat
                Case "dis": OpenOrShowAppBasedOnAppModelUserID("Discord", "com.squirrel.Discord.Discord")
                ; Open or show discord call window
                Case "vch": OpenOrShowAppBasedOnAppModelUserID("러비더비", "com.squirrel.Discord.Discord", 3)
                ; Open or show VLC player
                Case "vlc": OpenOrShowAppBasedOnExeName("C:\Program Files\VideoLAN\VLC\vlc.exe")
                ; Open or show Anki
                Case "ank": OpenOrShowAppBasedOnAppModelUserID("Anki", "{6D809377-6AF0-444B-8957-A3773F02200E}\Anki\anki.exe")
                ; Open or show Youtube Music
                Case "mus": OpenOrShowAppBasedOnAppModelUserID("YouTube Music", "Chrome._crx_cinhimbnkkghhklpknlkffjgod")
                ; Open File explorer
                Case "fex": OpenOrShowExplorer()
                ; Get information about the monitor. Used to find the magic numbers used in FocusAppOnMonitor; the function used to open an application on a specific monitor
                Case "inf": GetMonitorInfo()
                Case "res": ResetAutohotkey()
            }
            End:
            GetKeyState, state, CapsLock
            if (state = "D")
            {
                ;MsgBox "CapsLock is still down, continuing"
                toggle:=true
            }
            else
            {
                ;MsgBox "CapsLock has been released, ending"
                toggle:=false
            }
        }
        SetCapsLockState, % "Off"  ; Toggle the state of CapsLock LED
        return
    }
Return


;================================================================================================
; Hotkey Helper functions
;================================================================================================

ShowChromeOn(Monitor)
{
    AppModelUserID := "Chrome"

    SetTitleMatchMode, 2
    WinGet, Windows, List, %AppModelUserID%

    Loop, %Windows%
    {
        this_windowHwnd := Windows%A_Index%
        currentMonitorHwnd := MDMF_FromHWND(this_windowHwnd)
        ; MsgBox "Loop Number" %A_Index%. MonitorHWND: %currentMonitorHwnd%. Target: %Monitor1%
        If (currentMonitorHwnd = Monitor)
        {
            ; MsgBox Found a window. %A_Index%
            If WinActive("ahk_id" this_windowHwnd)
            {
                ;MsgBox Already active. Minimizing
                WinMinimize, ahk_id %this_windowHwnd%
                Return
            }
            else
            {
                ;MsgBox "Inactive window. Activating"
                WinActivateBottom ahk_id %this_windowHwnd%
                Return
            }        
        }
    }
    ; MsgBox Found nothing
    Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
    If ErrorLevel
    {
        Msgbox, File %AppModelUserID% Not Found
        Return
    }
    Return
}

ShowFirefoxOn(Monitor)
{
    AppModelUserID := "308046B0AF4A39CB"
    Title := "Firefox"

    SetTitleMatchMode, 2
    WinGet, Windows, List, %Title%

    Loop, %Windows%
    {
        this_windowHwnd := Windows%A_Index%
        currentMonitorHwnd := MDMF_FromHWND(this_windowHwnd)
        ; MsgBox "Loop Number" %A_Index%. MonitorHWND: %currentMonitorHwnd%. Target: %Monitor1%
        If (currentMonitorHwnd = Monitor)
        {
            ; MsgBox Found a window. %A_Index%
            If WinActive("ahk_id" this_windowHwnd)
            {
                ;MsgBox Already active. Minimizing
                WinMinimize, ahk_id %this_windowHwnd%
                Return
            }
            else
            {
                ;MsgBox "Inactive window. Activating"
                WinActivateBottom ahk_id %this_windowHwnd%
                Return
            }        
        }
    }
    ; MsgBox Found nothing
    Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
    If ErrorLevel
    {
        Msgbox, File %AppModelUserID% Not Found
        Return
    }
    Return
}

FocusChromeOn(Monitor)
{
    AppModelUserID := "Chrome"

    SetTitleMatchMode, 2
    WinGet, Windows, List, %AppModelUserID%

    Loop, %Windows%
    {
        this_windowHwnd := Windows%A_Index%
        currentMonitorHwnd := MDMF_FromHWND(this_windowHwnd)
        ; MsgBox "Loop Number" %A_Index%. MonitorHWND: %currentMonitorHwnd%. Target: %Monitor1%
        If (currentMonitorHwnd = Monitor)
        {
            ; MsgBox Found a window. %A_Index%
            If WinActive("ahk_id" this_windowHwnd)
            {
                ;MsgBox Already active. Minimizing
                ;WinMinimize, ahk_id %this_windowHwnd%
                Return
            }
            else
            {
                ;MsgBox "Inactive window. Activating"
                WinActivateBottom ahk_id %this_windowHwnd%
                Return
            }        
        }
    }
    ; MsgBox Found nothing
    Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
    If ErrorLevel
    {
        Msgbox, File %AppModelUserID% Not Found
        Return
    }
    Return
}

OpenAppsFolder()
{
    Run, shell:Appsfolder
    Sleep 1000
    WinGetPos, X, Y, W, H, A
    x:= W - 100
    y:= 90
    Click %x% %y%
    Sleep 30
    x := 50
    y := 185
    Click %x% %y%
    Sleep 30
    Send !vh
    Sleep 100
    x:=30
    y:=155
    Click %x% %y%
    Send {Enter}
}

OpenOrShowExplorer()
{
    SetTitleMatchMode, 2

    if WinExist("ahk_class CabinetWClass") || WinExist("ahk_class ExploreWClass")
    {    

        IfWinActive
        {
            ; MsgBox Found Explorer.EXE as active window
            WinMinimize
            Return false
        }
        else
        {
            ; MsgBox Found Explorer.EXE as inactive window
            WinActivate
            Return true
        }
    }
    else
    {
        ; MsfgBox NotFound
        Run, Explorer.exe  /n`,/e`
    }
}

ResetAutohotkey()
{
    Send #
    Return
}

DiscordJoinChannel() {
    AppTitle := "Discord"
	SetTitleMatchMode, 2

    IfWinExist, %AppTitle%
    {    

		IfWinActive
		{
			;MsgBox Found %AppTitle% as active window
			goto ToggleVoiceChat
		}
		else
		{
			; MsgBox Found %AppTitle% as inactive window
			WinActivateBottom %AppTitle%
			goto ToggleVoiceChat
		}
        ToggleVoiceChat:
        WinGetPos, X, Y, W, H, Discord
        CoordMode, Click, Client
        x:= 145
        y:= 205
        Click %x% %y%
        ;MsgBox w %W% h %H%, x %x% y %y%
    }
    else
    {
        ; MsgBox %AppTitle% Not found
        Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
        If ErrorLevel
        {
            ; Msgbox, File %AppModelUserID% Not Found
            Return true
        }
    }
}

DiscordCameraToggle() {
    AppTitle := "Discord"
	SetTitleMatchMode, 2

    IfWinExist, %AppTitle%
    {    

		IfWinActive
		{
			;MsgBox Found %AppTitle% as active window
			goto ToggleCamera
		}
		else
		{
			; MsgBox Found %AppTitle% as inactive window
			WinActivateBottom %AppTitle%
			goto ToggleCamera
		}
        ToggleCamera:
        WinGetPos, X, Y, W, H, Discord
        CoordMode, Click, Client
        x:= 145
        y:= H - 80
        Click %x% %y%
        Sleep 10
        x:=W-70
        y:= H-45
        Click %x% %y%
        Sleep 10
        Send {Esc}
        ;MsgBox w %W% h %H%, x %x% y %y%
    }
    else
    {
        ; MsgBox %AppTitle% Not found
        Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
        If ErrorLevel
        {
            ; Msgbox, File %AppModelUserID% Not Found
            Return true
        }
    }
}

TabHotkey() {
    WinGet, ActiveProcess, ProcessName, A
    WinGet, OpenWindowsAmount, Count, ahk_exe %ActiveProcess%

    If OpenWindowsAmount = 1  ; If only one Window exist, do nothing
        Return

    Else
        {
            WinGetTitle, FullTitle, A
            AppTitle := ExtractAppTitle(FullTitle)

            SetTitleMatchMode, 2
            WinGet, WindowsWithSameTitleList, List, %AppTitle%

            If WindowsWithSameTitleList > 1 ; If several Window of same type (title checking) exist
            {
                WinActivate, % "ahk_id " WindowsWithSameTitleList%WindowsWithSameTitleList%	; Activate next Window
            }
        }
    Return
}

FocusAppOnMonitor(AppModelUserID, TargetMonitorHWND) {
    SetTitleMatchMode, 2
    WinGet, Windows, List, %AppModelUserID%

    Loop, %Windows%
    {
        this_windowHwnd := Windows%A_Index%
        currentMonitorHwnd := MDMF_FromHWND(this_windowHwnd)
        ; MsgBox "Loop Number" %A_Index%. MonitorHWND: %currentMonitorHwnd%. Target: %Monitor2%
        If (currentMonitorHwnd = TargetMonitorHWND)
        {
            ; MsgBox Found a window. %A_Index%
            If WinActive("ahk_id" this_windowHwnd)
            {
                ;MsgBox Already active. Minimizing
                WinMinimize, ahk_id %this_windowHwnd%
                Return
            }
            else
            {
                ;MsgBox "Inactive window. Activating"
                WinActivateBottom ahk_id %this_windowHwnd%
                Return
            }        
        }
    }
    ; MsgBox Found nothing
    Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
    If ErrorLevel
    {
        Msgbox, File %AppModelUserID% Not Found
    }
    Return
}

jKeyHandler()
{
    If (GetKeyState("Ctrl"))
    {
        ;MsgBox 1
        Send ^{Left}
    }
    Else if (GetKeyState("Shift"))
    {
        ;MsgBox 2
        Send +{Left}
    }
    Else if (GetKeyState("Alt"))
    {
        ;MsgBox 2
        Send !{Left}
    }    
    Else
    {
        ;MsgBox 2
        Send {Left}
    }
    return
}

lKeyHandler()
{
    If (GetKeyState("Ctrl"))
    {
        ;MsgBox 1
        Send ^{Right}
    }
    Else if (GetKeyState("Shift"))
    {
        ;MsgBox 2
        Send +{Right}
    }
    Else if (GetKeyState("Alt"))
    {
        ;MsgBox 2
        Send !{Right}
    }    
    Else
    {
        ;MsgBox 2
        Send {Right}
    }
    return
}

iKeyHandler()
{
    If (GetKeyState("Ctrl"))
    {
        ;MsgBox 1
        Send ^{Up}
    }
    Else if (GetKeyState("Shift"))
    {
        ;MsgBox 2
        Send +{Up}
    }
    Else if (GetKeyState("Alt"))
    {
        ;MsgBox 2
        Send !{Up}
    }    
    Else
    {
        ;MsgBox 2
        Send {Up}
    }
    return
}

kKeyHandler()
{
    If (GetKeyState("Ctrl"))
    {
        ;MsgBox 1
        Send ^{Down}
    }
    Else if (GetKeyState("Shift"))
    {
        ;MsgBox 2
        Send +{Down}
    }
    Else if (GetKeyState("Alt"))
    {
        ;MsgBox 2
        Send !{Down}
    }    
    Else
    {
        ;MsgBox 2
        Send {Down}
    }
    return
}

GetMonitorInfo()
{
    WinGet, activeWindowHwnd, ID, A
    activeMonitorHwnd := MDMF_FromHWND(activeWindowHwnd)
    monitors := MDMF_Enum()

    monitorHwndList := []
    For currentMonitorHwnd, info In monitors
    {
        monitorHwndList[A_Index] := currentMonitorHwnd
    }
    activeMonitor := MDMF_GetInfo(activeMonitorHwnd)
    MsgBox %activeMonitorHwnd%
    Return
}

SetMonitor1()
{
    WinGet, activeWindowHwnd, ID, A
    activeMonitorHwnd := MDMF_FromHWND(activeWindowHwnd)
    Monitor1 = %activeMonitorHwnd%
}

SetMonitor2()
{
    WinGet, activeWindowHwnd, ID, A
    activeMonitorHwnd := MDMF_FromHWND(activeWindowHwnd)
    Monitor2 = %activeMonitorHwnd%
}

; OpenShowKoreanDict()
; {
;     SetTitleMatchMode, 2
; 	; AppTitle := "국립국어원 표준국어대사전"
;     AppTitle := "네이버 국어사전"
;     ;AppModelUserID := "Chrome._crx_doibdgamfnkjadnjlenpjnbbgceiaaai"
;     AppModelUserID := "Chrome._crx_fhgbkobfgpdideoaghpgjhanicidmpfo"

;     IfWinExist, %AppTitle%
;     {    
;         ;MsgBox found
; 		IfWinActive
; 		{
; 			; WinMinimize
; 			Return false
; 		}
; 		else
; 		{
; 			WinActivate
; 			Return true
; 		}
; 	}
;     else
;     {
;         ; MsgBox %AppTitle% Not found
;         Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
;         If ErrorLevel
;         {
;             ; Msgbox, File %AppModelUserID% Not Found
;             Return "opened"
;         }
;     }
; 	return false
; }

OpenShowKoreanDict()
{
    OpenOrShowAppBasedOnAppModelUserID("네이버 국어사전$", "Chrome._crx_fhgbkobfgpdideoaghpgjhanicidmpfo","Regex")
    Return
}


OpenShowNaverDict()
{
    SetTitleMatchMode, 2
	AppTitle := "Lingoes"

    IfWinExist, %AppTitle%
    {    
        ;MsgBox found
		IfWinActive
		{
			; WinMinimize
			Return false
		}
		else
		{
			WinActivate
			Return true
		}
	
	}
    ; If (OpenOrShowAppBasedOnAppModelUserID("네이버 영어사전", "Chrome._crx_ojjhnnaaabjpfgdblnfhpjkjof") = "maximized")
    ; If (OpenOrShowAppBasedOnAppModelUserID("StarDict", "Chrome._crx_ojjhnnaaabjpfgdblnfhpjkjof") = "maximized")
    ; {
    ;     ; Sleep 10
    ;     ; Send a
    ;     ; Sleep 10
    ;     ; Send ^a
    ;     ; Sleep 10
    ;     ; Send {BackSpace}
    ; }
    ; Return
}

OpenShowYoutube()
{
    OpenOrShowAppBasedOnAppModelUserID("YouTube$", "Chrome._crx_agimnkijcamfeangaknmldooml","Regex")
    Return
}

;================================================================================================
; Hot keys with CapsLock modifier.  See https://autohotkey.com/docs/Hotkeys.htm#combo
;================================================================================================

CapsLock & 1::
    FocusChromeOn(Monitor2)
    Sleep 25 
    Send ^l
    Sleep 25
    Send google.com
    Sleep 25
    Send {Tab}
Return

CapsLock & 2::
    FocusChromeOn(Monitor2)
    Sleep 25   
    Send ^l
    Sleep 25
    Send naver.com
    Sleep 25
    Send {Tab}
Return

CapsLock & 3::
    FocusChromeOn(Monitor2)
    Sleep 25   
    Send ^l
    Sleep 25
    Send translate.google.com
    Sleep 25
    Send {Tab}
Return

CapsLock & z::
    OpenOrShowAppBasedOnAppModelUserID("Ableton Live 11 Trial", "{6D809377-6AF0-444B-8957-A3773F02200E}\Anki\anki.exe")
    ; OpenOrShowAppBasedOnAppModelUserID("Pianoteq", "{6D809377-6AF0-444B-8957-A3773F02200E}\Modartt\Pianoteq 7\Pianoteq 7.exe")
Return

CapsLock & t::
    OpenOrShowAppBasedOnAppModelUserIDAndExe("WindowsTerminal.exe", "Microsoft.WindowsTerminal_8wekyb3d8bbwe!App")
Return

CapsLock & u::
    OpenOrShowAppBasedOnAppModelUserID("네이버 뉴스", "Chrome._crx_ncncifmmacfekhnafjkdpackop")
Return

CapsLock & h::  
    OpenOrShowAppBasedOnAppModelUserID("설정", "windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel")
Return

; CapsLock + x - Open||Show "Sticky Notes"
CapsLock & x:: 
    OpenOrShowAppBasedOnAppModelUserID("Note", "{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}\ulazy1\NoteTaker\NoteTaker.exe")
Return

/*
; CapsLock + c  - Open||Show "Chrome"
CapsLock & c:: 
    OpenOrShowAppBasedOnAppModelUserID("Chrome", "Chrome")
Return
*/

; CapsLock + g  - Open||Show "Gmail as Chrome App"
CapsLock & g:: 
    OpenOrShowAppBasedOnAppModelUserID("Gmail", "Chrome._crx_kmhopmchchjodmpfaaphdclmlj")
Return

; CapsLock & f - Open||Show 
CapsLock & f:: OpenShowKoreanDict()
Return

; CapsLock+d - Open||Show "Naver Dictionary"
CapsLock & d:: OpenShowNaverDict()
Return

; CapsLock+s - Open||Show "Youtube Music" or 
CapsLock & s::
    OpenOrShowAppBasedOnAppModelUserID("YouTube Music", "Chrome._crx_cinhimbnkkghhklpknlkffjgod")
Return

; CapsLock+r - Open||Show "Anki web" or 
CapsLock & r::
    OpenOrShowAppBasedOnAppModelUserID("AnkiWeb", "Chrome._crx_kdaapfkcghpblmgcpkkbbnodnc")
Return


CapsLock & n::
    OpenOrShowAppBasedOnAppModelUserID("Netflix", "Chrome._crx_eppojlglocmnohnlnionkobfln")
Return

; CapsLock+y - Open||Show "Youtube"
CapsLock & y:: OpenShowYoutube()
Return

; CapsLock+a - Open||Show "Discord chat"
CapsLock & a:: 
    OpenOrShowAppBasedOnAppModelUserID("Discord", "com.squirrel.Discord.Discord")
Return

; CapsLock +6 - Open||Show "Discord call"
CapsLock & 6:: 
    If (Not OpenOrShowAppBasedOnAppModelUserID("러비더비", "com.squirrel.Discord.Discord", 3))
    {
        ; MsgBox notfound
        AppTitle := "Discord"
        SetTitleMatchMode, 2

        IfWinExist, %AppTitle%
        {    

            IfWinActive
            {
                ;MsgBox Found %AppTitle% as active window
                goto OpenCallWindow
            }
            else
            {
                ; MsgBox Found %AppTitle% as inactive window
                WinActivateBottom %AppTitle%
                goto OpenCallWindow
            }
            OpenCallWindow:
            WinGetPos, X, Y, W, H, Discord
            CoordMode, Click, Client
            x:= W - 200
            y:= 200
            Click %x% %y%
            Click %x% %y%

            Sleep 10
            x:=W-70
            y:= H-45
            Click %x% %y%
            Sleep 10
            Send {Esc}
            ;MsgBox w %W% h %H%, x %x% y %y%
        }
        else
        {
            ; MsgBox %AppTitle% Not found
            Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
            If ErrorLevel
            {
                ; Msgbox, File %AppModelUserID% Not Found
                Return
            }
        }
    }
    Return

; CapsLock+b - Open||Show "Edge"
CapsLock & b:: 
    OpenOrShowAppBasedOnAppModelUserID("Microsoft​ Edge", "MSEdge")
Return

; CapsLock+w - Open||Show "VScode"
CapsLock & w:: 
    OpenOrShowAppBasedOnAppModelUserID("Visual Studio Code", "Microsoft.VisualStudioCode")
Return

; CapsLock+e - Open||Show "Explorer"
CapsLock & e:: 
    OpenOrShowExplorer()
Return

;CapsLock + ` -  Activate NEXT Window of same type (title checking) of the current APP
CapsLock & Tab::
    WinGet, ActiveProcess, ProcessName, A
    WinGet, OpenWindowsAmount, Count, ahk_exe %ActiveProcess%

    If OpenWindowsAmount = 1  ; If only one Window exist, do nothing
        Return

    Else
        {
            WinGetTitle, FullTitle, A
            AppTitle := ExtractAppTitle(FullTitle)

            SetTitleMatchMode, 2
            WinGet, WindowsWithSameTitleList, List, %AppTitle%

            If WindowsWithSameTitleList > 1 ; If several Window of same type (title checking) exist
            {
                WinActivate, % "ahk_id " WindowsWithSameTitleList%WindowsWithSameTitleList%	; Activate next Window
            }
        }
Return

; CapsLock + v - Activate the chrome window on the second monitor
CapsLock & v::
    ShowFirefoxOn(Monitor2)
Return

;CapsLock + c - Activate the chrome window on the first monitor
CapsLock & c::
    ShowFirefoxOn(Monitor1)
Return

CapsLock & j::
    If (GetKeyState("Ctrl"))
    {
        ;MsgBox 1
        Send ^{Left}
    }
    Else if (GetKeyState("Shift"))
    {
        ;MsgBox 2
        Send +{Left}
    }
    Else if (GetKeyState("Alt"))
    {
        ;MsgBox 2
        Send !{Left}
    }    
    Else
    {
        ;MsgBox 2
        Send {Left}
    }
return

CapsLock & l::
    If (GetKeyState("Ctrl"))
    {
        ;MsgBox 1
        Send ^{Right}
    }
    Else if (GetKeyState("Shift"))
    {
        ;MsgBox 2
        Send +{Right}
    }
    Else if (GetKeyState("Alt"))
    {
        ;MsgBox 2
        Send !{Right}
    }    
    Else
    {
        ;MsgBox 2
        Send {Right}
    }
return


CapsLock & i::
    If (GetKeyState("Ctrl"))
    {
        ;MsgBox 1
        Send ^{Up}
    }
    Else if (GetKeyState("Shift"))
    {
        ;MsgBox 2
        Send +{Up}
    }
    Else if (GetKeyState("Alt"))
    {
        ;MsgBox 2
        Send !{Up}
    }    
    Else
    {
        ;MsgBox 2
        Send {Up}
    }
return

CapsLock & k::
If (GetKeyState("Ctrl"))
{
    ;MsgBox 1
    Send ^{Down}
}
Else if (GetKeyState("Shift"))
{
    ;MsgBox 2
    Send +{Down}
}
Else if (GetKeyState("Alt"))
{
    ;MsgBox 2
    Send !{Down}
}    
Else
{
    ;MsgBox 2
    Send {Down}
}
return

;MEDIA CONTROLS
CapsLock & Space:: Send {Media_Play_Pause}
CapsLock & MButton:: Send {Media_Play_Pause}
CapsLock & Left:: Send {Media_Prev}
CapsLock & Right:: Send {Media_Next}
CapsLock & Up:: Send {Volume_Up}
CapsLock & WheelUp::
{
    If GetKeyState("Ctrl")
    {
        Send {WheelUp}
        Send {WheelUp}
        Send {WheelUp}

        Return
    }
    If GetKeyState("Shift")
    {
        Send {Up}
        Return
    }
    Else
    {
        Send {Volume_Up}
        Return
    }
}

CapsLock & Down:: Send {Volume_Down}
CapsLock & WheelDown::
{
    If GetKeyState("Ctrl")
    {
        Send {WheelDown}
        Send {WheelDown}
        Send {WheelDown}

        Return
    }
    If GetKeyState("Shift")
    {
        Send {Down}
        Return
    }
    Else
    {
        Send {Volume_Down}
        Return
    }
}
CapsLock & m:: Send {Volume_Mute}
;Delete
CapsLock & BackSpace::Send {Delete}
; Send escape
CapsLock & q:: Send {Esc}

CapsLock & LButton:: 
{
    If GetKeyState("Ctrl")
    {
        Send {Left}
    }
    Else
    {
        Send ^/
    }
    Return
}
CapsLock & XButton1:: ^]
CapsLock & XButton2:: ^[
CapsLock & RButton:: 
{
    If GetKeyState("Ctrl")
    {
        Send {Right}
    }
    Else
    {
        Send {BackSpace}
    }
    Return
}

CapsLock & [:: Send {PgUp}
CapsLock & ]:: Send {PgDn}

CapsLock & -:: Send {Home}
CapsLock & =:: Send {End}

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;Credits to "just me" for the following code:

; ======================================================================================================================
; Multiple Display Monitors Functions -> msdn.microsoft.com/en-us/library/dd145072(v=vs.85).aspx =======================
; ======================================================================================================================
; Enumerates display monitors and returns an object containing the properties of all monitors or the specified monitor.
; ======================================================================================================================
MDMF_Enum(HMON := "") {
   Static EnumProc := RegisterCallback("MDMF_EnumProc")
   Static Monitors := {}
   If (HMON = "") ; new enumeration
      Monitors := {}
   If (Monitors.MaxIndex() = "") ; enumerate
      If !DllCall("User32.dll\EnumDisplayMonitors", "Ptr", 0, "Ptr", 0, "Ptr", EnumProc, "Ptr", &Monitors, "UInt")
         Return False
   Return (HMON = "") ? Monitors : Monitors.HasKey(HMON) ? Monitors[HMON] : False
}
; ======================================================================================================================
;  Callback function that is called by the MDMF_Enum function.
; ======================================================================================================================
MDMF_EnumProc(HMON, HDC, PRECT, ObjectAddr) {
   Monitors := Object(ObjectAddr)
   Monitors[HMON] := MDMF_GetInfo(HMON)
   Return True
}
; ======================================================================================================================
;  Retrieves the display monitor that has the largest area of intersection with a specified window.
; ======================================================================================================================
MDMF_FromHWND(HWND) {
   Return DllCall("User32.dll\MonitorFromWindow", "Ptr", HWND, "UInt", 0, "UPtr")
}
; ======================================================================================================================
; Retrieves the display monitor that contains a specified point.
; If either X or Y is empty, the function will use the current cursor position for this value.
; ======================================================================================================================
MDMF_FromPoint(X := "", Y := "") {
   VarSetCapacity(PT, 8, 0)
   If (X = "") || (Y = "") {
      DllCall("User32.dll\GetCursorPos", "Ptr", &PT)
      If (X = "")
         X := NumGet(PT, 0, "Int")
      If (Y = "")
         Y := NumGet(PT, 4, "Int")
   }
   Return DllCall("User32.dll\MonitorFromPoint", "Int64", (X & 0xFFFFFFFF) | (Y << 32), "UInt", 0, "UPtr")
}
; ======================================================================================================================
; Retrieves the display monitor that has the largest area of intersection with a specified rectangle.
; Parameters are consistent with the common AHK definition of a rectangle, which is X, Y, W, H instead of
; Left, Top, Right, Bottom.
; a======================================================================================================================
MDMF_FromRect(X, Y, W, H) {
   VarSetCapacity(RC, 16, 0)
   NumPut(X, RC, 0, "Int"), NumPut(Y, RC, 4, Int), NumPut(X + W, RC, 8, "Int"), NumPut(Y + H, RC, 12, "Int")
   Return DllCall("User32.dll\MonitorFromRect", "Ptr", &RC, "UInt", 0, "UPtr")
}
; ======================================================================================================================
; Retrieves information about a display monitor.
; ======================================================================================================================
MDMF_GetInfo(HMON) {
   NumPut(VarSetCapacity(MIEX, 40 + (32 << !!A_IsUnicode)), MIEX, 0, "UInt")
   If DllCall("User32.dll\GetMonitorInfo", "Ptr", HMON, "Ptr", &MIEX) {
      MonName := StrGet(&MIEX + 40, 32)    ; CCHDEVICENAME = 32
      MonNum := RegExReplace(MonName, ".*(\d+)$", "$1")
      Return {Name:      (Name := StrGet(&MIEX + 40, 32))
            , Num:       RegExReplace(Name, ".*(\d+)$", "$1")
            , Left:      NumGet(MIEX, 4, "Int")    ; display rectangle
            , Top:       NumGet(MIEX, 8, "Int")    ; "
            , Right:     NumGet(MIEX, 12, "Int")   ; "
            , Bottom:    NumGet(MIEX, 16, "Int")   ; "
            , WALeft:    NumGet(MIEX, 20, "Int")   ; work area
            , WATop:     NumGet(MIEX, 24, "Int")   ; "
            , WARight:   NumGet(MIEX, 28, "Int")   ; "
            , WABottom:  NumGet(MIEX, 32, "Int")   ; "
            , Primary:   NumGet(MIEX, 36, "UInt")} ; contains a non-zero value for the primary monitor.
   }
   Return False
}