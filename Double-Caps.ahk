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