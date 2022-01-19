#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

app := "Youtube"
SetTitleMatchMode, 2
^!a::
WinGet, PID, PID, A
FullEXEPath := GetModuleFileNameEx( PID )
MsgBox "%FullEXEPath%"

IfWinExist, %app%
	{
		IfWinActive
		{
			MsgBox Found %app% as active window
		}
		else
		{
			MsgBox Found %app% as inactive window
		}
				
	}
	else
	{	
		MsgBox %app% Not found
	}

/*
WinGet, active_id, ID, A
MsgBox, "%active_id%\n %ID%"
MsgBox, "%ID%"
WinGetClass, class, A
MsgBox, "%class%"
*/

^!t::
WinGetTitle, title, A
MsgBox, "%title%"

^F2::
 WinGet, PID, PID, A
 FullEXEPath := GetModuleFileNameEx( PID )
 FileGetVersion, Version, %FullEXEPath%
 MsgBox, 0, %Version%, %FullEXEPath%
Return

GetModuleFileNameEx( p_pid ) ; by shimanov -  www.autohotkey.com/forum/viewtopic.php?t=9000
{
   if A_OSVersion in WIN_95,WIN_98,WIN_ME
   {
      MsgBox, This Windows version (%A_OSVersion%) is not supported.
      return
   }

   h_process := DllCall( "OpenProcess", "uint", 0x10|0x400, "int", false, "uint", p_pid )
   if ( ErrorLevel or h_process = 0 )
      return

   name_size = 255
   VarSetCapacity( name, name_size )

   result := DllCall( "psapi.dll\GetModuleFileNameEx" [color=#FF0000]( A_IsUnicode ? "W" : "A" )[/color]
                 , "uint", h_process, "uint", 0, "str", name, "uint", name_size )

   DllCall( "CloseHandle", h_process )

   return, name
}

^!x::
winHandle := WinExist("A") ; Get a handle to the active window
; MonitorFromWindow https://msdn.microsoft.com/en-us/library/windows/desktop/dd145064%28v=vs.85%29.aspx
; GetMonitorInfo https://msdn.microsoft.com/en-us/library/windows/desktop/dd144901%28v=vs.85%29.aspx
; MONITORINFO https://msdn.microsoft.com/en-us/library/windows/desktop/dd145065%28v=vs.85%29.aspx
VarSetCapacity(monitorInfo, 40), NumPut(40, monitorInfo)
if (monitorHandle := DllCall("MonitorFromWindow", "Ptr", winHandle, "UInt", 0x2)) 
    && DllCall("GetMonitorInfo", "Ptr", monitorHandle, "Ptr", &monitorInfo) {
    monitorLeft   := NumGet(monitorInfo,  4, "Int")
    monitorTop    := NumGet(monitorInfo,  8, "Int")
    monitorRight  := NumGet(monitorInfo, 12, "Int")
    monitorBottom := NumGet(monitorInfo, 16, "Int")
    workLeft      := NumGet(monitorInfo, 20, "Int")
    workTop       := NumGet(monitorInfo, 24, "Int")
    workRight     := NumGet(monitorInfo, 28, "Int")
    workBottom    := NumGet(monitorInfo, 32, "Int")
    isPrimary     := NumGet(monitorInfo, 36, "Int") & 1
    MsgBox, % "monitorLeft:`t"      monitorLeft   "`n"
            . "monitorTop:`t"       monitorTop    "`n"
            . "monitorRight:`t"     monitorRight  "`n"
            . "monitorBottom:`t"    monitorBottom "`n"
            . "workLeft:`t`t"       workLeft      "`n"
            . "workTop:`t`t"        workTop       "`n"
            . "workRight:`t"        workRight     "`n"
            . "workBottom:`t"       workBottom    "`n"
            . "isPrimary:`t`t"      isPrimary   
}
else
    MsgBox, Failed to get monitor info.
return
