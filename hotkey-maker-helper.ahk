+1:: getMousePos()
; +2:: getMousePos(relative:=true)

; ; Reload script
; ^!r:: Reload


getMousePos(relative := false) {
    ; MsgBox, %relative%
    if (relative == true) {
        CoordMode, Mouse, Relative
    }
    MouseGetPos, xpos, ypos
    xy := "x" xpos " y" ypos
    ToolTip %xy%
    Clipboard := xy
    SetTimer toolTipClear, -1000
}

tooltipClear() {
    ToolTip
}