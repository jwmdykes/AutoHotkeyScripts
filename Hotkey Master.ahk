#NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
n := "Hotkey Master" ; name of script

SetCapsLockState, AlwaysOff
*CapsLock::Return

#include specific-helpers.ahk
#include ShowApps.ahk
#include arrow-keys.ahk
; press alt and left click to move window
; press and and right click to resize window
#include AltMoveWindowResizeWindow.ahk

; Reload script
^!r:: Reload
Return

; Test hotkey
CapsLock & `::
    MsgBox, TEST HOTKEY SUCCESS!
Return

;================================================================================================
; Hot keys with CapsLock modifier.  See https://autohotkey.com/docs/Hotkeys.htm#combo
;================================================================================================

CapsLock & q::
    WinClose A
Return

; Focus on firefox on first monitor
CapsLock & v::
    FocusAppOnMonitor(Name := "— Mozilla Firefox", AppModelUserID := "308046B0AF4A39CB", TargetMonitor := 1, MinimizeWindow := False)
Return

CapsLock & c::
    FocusAppOnMonitor(Name := "— Mozilla Firefox", AppModelUserID := "308046B0AF4A39CB", TargetMonitor := 2, MinimizeWindow := False)
Return

;open terminal
CapsLock & t::
    OpenOrShowAppBasedOnAppModelUserIDAndExeNoMinimize("WindowsTerminal.exe", "Microsoft.WindowsTerminal_8wekyb3d8bbwe!App")
Return

;open settings
CapsLock & h::  
    OpenOrShowAppBasedOnAppModelUserID("설정", "windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel")
Return

; CapsLock+w - Open||Show "VScode"
CapsLock & w:: 
    OpenOrShowAppBasedOnAppModelUserIDNoMinimize("Visual Studio Code", "Microsoft.VisualStudioCode")
Return

; CapsLock+e - Open||Show "Files v2 file explorer"
CapsLock & e::
    OpenOrShowAppBasedOnAppModelUserID("- Files", "Files_wvne1zexy08sa!App")  
Return

;CapsLock + ` -  Activate NEXT Window of same type (title checking) of the current APP
CapsLock & Tab::
    ActivateNextWindowOfCurrentApp()
Return

;MEDIA CONTROLS
CapsLock & Space:: Send {Media_Play_Pause}
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
