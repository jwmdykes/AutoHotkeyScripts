;================================================================================================
; Hotkey Helper functions NOT CURRENTLY USED
;================================================================================================

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

OpenDiscordCall()
{
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
}

ActivateNextWindowOfCurrentApp()
{
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

}