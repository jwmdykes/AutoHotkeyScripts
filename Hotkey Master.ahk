#NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
n := "Hotkey Master" ; name of script

scripts_path := "C:\code\AutoHotkeyScripts"
#include ShowApps.ahk
#include specific-helpers.ahk
#include arrow-keys.ahk


; Reload script
^!r:: Reload
;Make capslock always off
CapsLock::return

; Test hotkey
CapsLock & `::
    MsgBox, No test hotkey available
    ; OpenAppsFolder()
Return

; CapsLock & 1::
;     GetMonitor(,,debug := true)
; Return

;================================================================================================
; Hot keys with CapsLock modifier.  See https://autohotkey.com/docs/Hotkeys.htm#combo
;================================================================================================

; Focus on firefox on first monitor
CapsLock & v::
    FocusAppOnMonitor(Name := "Mozilla Firefox", AppModelUserID := "308046B0AF4A39CB", TargetMonitor := 2, MinimizeWindow := False)
Return

CapsLock & c::
    FocusAppOnMonitor(Name := "Mozilla Firefox", AppModelUserID := "308046B0AF4A39CB", TargetMonitor := 1, MinimizeWindow := False)
Return

; ;CapsLock + c - Run python program to add to anki deck
; CapsLock & c::
;     CoordMode, Mouse, Screen    
;     MouseGetPos, xpos, ypos
;     ; MsgBox, The cursor is at X%xpos% Y%ypos%.
;     SetWorkingDir, C:/code/add-to-anki/
;     Run C:/Users/98joh/AppData/Local/Programs/Python/Python310/pythonw.exe main.pyw %xpos% %ypos%
;     sleep, 1000
;     if WinExist("Input a Korean English pair")
;         WinActivate

;open ankiweb app
CapsLock & r::
    OpenOrShowAppBasedOnAppModelUserID("Anki", "{6D809377-6AF0-444B-8957-A3773F02200E}\Anki\anki.exe")
Return

;open terminal
CapsLock & t::
    OpenOrShowAppBasedOnAppModelUserIDAndExeNoMinimize("WindowsTerminal.exe", "Microsoft.WindowsTerminal_8wekyb3d8bbwe!App")
Return

;open settings
CapsLock & h::  
    OpenOrShowAppBasedOnAppModelUserID("설정", "windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel")
Return

; CapsLock + g  - Open||Show "Gmail as Chrome App"
CapsLock & g:: 
    OpenOrShowAppBasedOnAppModelUserID("Gmail", "Chrome._crx_kmhopmchchjodmpfaaphdclmlj")
Return
;Open korean dictionary
CapsLock & f::
    OpenOrShowAppBasedOnAppModelUserIDNoMinimize("국립국어원 표준국어대사전", "Chrome._crx_lmfljdbcmdlfkpoeldhhajnghm")
Return
; Open korean dictionary
CapsLock & d::
    OpenOrShowAppBasedOnAppModelUserIDNoMinimize("한국어기초사전", "Chrome._crx_cffcckajjofbfnflmfaabejcoa")
Return

; CapsLock+s - Open||Show "Youtube Music" or 
CapsLock & s::
    OpenOrShowAppBasedOnAppModelUserID("YouTube Music", "Chrome._crx_cinhimbnkkghhklpknlkffjgod")
Return

; CapsLock+r - Open||Show "Anki" 
CapsLock & z::
    OpenOrShowAppBasedOnAppModelUserID("AnkiWeb", "Chrome._crx_kdaapfkcghpblmgcpkkbbnodnc")
Return

; CapsLock+a - Open||Show "Discord chat"
CapsLock & a:: 
    OpenOrShowAppBasedOnAppModelUserID("Discord", "com.squirrel.Discord.Discord")
Return

; CapsLock +6 - Open||Show "Discord call"
CapsLock & 6:: 
    OpenDiscordCall()
Return

; CapsLock+w - Open||Show "VScode"
CapsLock & w:: 
    OpenOrShowAppBasedOnAppModelUserIDNoMinimize("Visual Studio Code", "Microsoft.VisualStudioCode")
Return

; CapsLock+e - Open||Show "Files v2 file explorer"
CapsLock & e::
  OpenOrShowAppBasedOnWindowTitle("- Files", "C:\Users\98joh\OneDrive\Desktop\Shortcuts\Files - 바로 가기.lnk")  
Return

;CapsLock + ` -  Activate NEXT Window of same type (title checking) of the current APP
CapsLock & Tab::
    ActivateNextWindowOfCurrentApp()
Return

CapsLock & j::
    Left()
return

CapsLock & l::
    Right()
return


CapsLock & i::
    Up()
return

CapsLock & k::
    Down()
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

