#NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

scripts_path := "C:\code\AutoHotkeyScripts"
#include C:\code\AutoHotkeyScripts\ShowApps.ahk
#include C:\code\AutoHotkeyScripts\specific-helpers.ahk

; Hwnd of each of the monitors
Monitor1 := 65602
Monitor2 := 131073


;================================================================================================
; Hot keys with CapsLock modifier.  See https://autohotkey.com/docs/Hotkeys.htm#combo
;================================================================================================

CapsLock & r::
    OpenOrShowAppBasedOnAppModelUserID("Anki", "{6D809377-6AF0-444B-8957-A3773F02200E}\Anki\anki.exe")
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

; CapsLock + g  - Open||Show "Gmail as Chrome App"
CapsLock & g:: 
    OpenOrShowAppBasedOnAppModelUserID("Gmail", "Chrome._crx_kmhopmchchjodmpfaaphdclmlj")
Return

CapsLock & f::
    OpenOrShowAppBasedOnAppModelUserID("국립국어원 표준국어대사전", "Chrome._crx_lmfljdbcmdlfkpoeldhhajnghm")
Return

CapsLock & d::
    OpenOrShowAppBasedOnAppModelUserID("한국어기초사전", "Chrome._crx_cffcckajjofbfnflmfaabejcoa")
Return

; CapsLock+s - Open||Show "Youtube Music" or 
CapsLock & s::
    OpenOrShowAppBasedOnAppModelUserID("YouTube Music", "Chrome._crx_cinhimbnkkghhklpknlkffjgod")
Return

; CapsLock+r - Open||Show "Anki web" or 
CapsLock & z::
    OpenOrShowAppBasedOnAppModelUserID("AnkiWeb", "Chrome._crx_kdaapfkcghpblmgcpkkbbnodnc")
Return


CapsLock & n::
    OpenOrShowAppBasedOnAppModelUserID("Netflix", "Chrome._crx_eppojlglocmnohnlnionkobfln")
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
; CapsLock & e:: 
;     OpenOrShowExplorer()
; Return

; CapsLock+e - Open||Show "Files v2 file explorer"
CapsLock & e::
  OpenOrShowAppBasedOnWindowTitle("- Files", "C:\Users\98joh\OneDrive\Desktop\Shortcuts\Files - 바로 가기.lnk")  
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

;CapsLock + c - Run python program to add to anki deck
CapsLock & c::
    CoordMode, Mouse, Screen    
    MouseGetPos, xpos, ypos
    ; MsgBox, The cursor is at X%xpos% Y%ypos%.
    SetWorkingDir, C:/code/add-to-anki/
    Run C:/Users/98joh/AppData/Local/Programs/Python/Python310/pythonw.exe main.pyw %xpos% %ypos%
    sleep, 1000
    if WinExist("Input a Korean English pair")
        WinActivate

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