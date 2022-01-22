#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; This AutoHotkey script is to Open, Restore or Minimize the desires Apps using the configured shortcuts key (hotkeys) you want.
; There are three functions you can use for this: 
;
;
; a) OpenOrShowAppBasedOnExeName(AppAddress) //Useful for regular Window Apps

; b) OpenOrShowAppBasedOnWindowTitle(WindowTitleWord, AppAddress)  //Specially useful for Chrome Apps and Chrome Shortcuts 

; c) OpenOrShowAppBasedOnAppModelUserID(AppTitle, AppModelUserID) //Useful for Windows Store Apps (contained in the "shell:AppsFolder\")


; Additionally, pressing Alt + ` (key above Tab key) you can switch between open Windows of the same "type" and same App (.exe)
; The "type" checking is based on the App's Title convention that stipulates that the App name should be at the end of the Window title (Eg: New Document - Word )



/* ;
*****************************
***** UTILITY FUNCTIONS *****
*****************************
*/


#WinActivateForce ; Prevent task bar buttons from flashing when different windows are activated quickly one after the other.

; AppAddress: The address to the .exe (Eg: "C:\Windows\System32\SnippingTool.exe")

OpenOrShowAppBasedOnExeName(AppAddress)
{


	AppExeName := SubStr(AppAddress, InStr(AppAddress, "\", false, -1) + 1)
		

	IfWinExist ahk_exe %AppExeName%
	{
	
		IfWinActive
		{
			WinMinimize
			Return false
		}
		else
		{
			WinActivate
			Return true
		}
				
	}
	else
	{	
	
		Run, %AppAddress%, UseErrorLevel
        If ErrorLevel
        {
            ; Msgbox, File %AppAddress% Not Found
            Return false
        }
		else
		{
			WinWait, ahk_exe %AppExeName%
			WinActivate ahk_exe %AppExeName%			
			Return true
		}			
		
	}
}


; WindowTitleWord: Usually the word at the end of the app window title (Eg: in: "New Document - Word" will be "Word")
; AppAddress: The address to the .exe (Eg: "C:\Windows\System32\SnippingTool.exe")

OpenOrShowAppBasedOnWindowTitle(WindowTitleWord, AppAddress)
{

    SetTitleMatchMode, 2
	

    IfWinExist, %WindowTitleWord%
    {    

		IfWinActive
		{
			WinMinimize
			Return false
		}
		else
		{
			WinActivate
			Return true
		}
	
	}
    else
    {
        Run, %AppAddress%, UseErrorLevel
        If ErrorLevel
        {
            ; Msgbox, File %AppAddress% Not Found
            Return false
        }
		else
		{
			WinActivate
			Return true
		}
    }
}



; AppTitle: Usually the word at the end of the app window title(Eg: in: "New Document - Word" will be "Word")
; AppModelUserID: A comprehensive guide on how to find the AppModelUserID of a windows store app can be found here: https://jcutrer.com/windows/find-aumid

OpenOrShowAppBasedOnAppModelUserID(AppTitle, AppModelUserID, TitleMatchMode=2)
{	
	SetTitleMatchMode, %TitleMatchMode%
	;MsgBox %TitleMatchMode%

    IfWinExist, %AppTitle%
    {    

		IfWinActive
		{
			; MsgBox Found %AppTitle% as active window
			WinMinimize
			Return "minimized"
		}
		else
		{
			; MsgBox Found %AppTitle% as inactive window
			WinActivateBottom %AppTitle%
			Return "maximized"
		}
		
	}
    else
    {
        ; MsgBox %AppTitle% Not found
        Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
        If ErrorLevel
        {
            ; Msgbox, File %AppModelUserID% Not Found
            Return "opened"
        }
    }
	return false
}

OpenOrShowAppBasedOnAppModelUserIDAndExe(AppExeName, AppModelUserID)
{		
	IfWinExist ahk_exe %AppExeName%
	{
	
		IfWinActive
		{
			WinMinimize
			Return false
		}
		else
		{
			WinActivate
			Return true
		}
				
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



ExtractAppTitle(FullTitle)
{
	AppTitle := SubStr(FullTitle, InStr(FullTitle, " ", false, -1) + 1)
	Return AppTitle
}


/* ;
***********************************
***** SHORTCUTS CONFIGURATION EXAMPLES*****
***********************************
*/

/*
; F6 - Open||Show "SnippingTool"
F6:: OpenOrShowAppBasedOnExeName("C:\Program Files\Google\Chrome\Application\chrome_proxy.exe --profile-directory=Default --app-id=kmhopmchchfpfdcdjodmpfaaphdclmlj")

; F9 - Open||Show "Windows store Calculator app"
F9:: OpenOrShowAppBasedOnAppModelUserID("Calculator", "Microsoft.WindowsCalculator_8wekyb3d8bbwe!App")

; F7 - Open||Show "SnippingTool"
F7:: OpenOrShowAppBasedOnExeName("C:\Windows\System32\SnippingTool.exe")

; F8 - Open||Show "Gmail as Chrome App"
F8:: OpenOrShowAppBasedOnWindowTitle("Gmail", "C:\Program Files\Google\Chrome\Application\chrome.exe --app=https://mail.google.com/mail/")
*/