; Practicing with autohotkey

Gui, Add, Text, x30 y5 w110 h20, 매크로 프로그램
Gui, Add, Button, x20 y25 w110 h20, 시작
Gui, Add, Button, x20 y5 w110 h20, 종료
Gui, Show, , 메크로
return

Button시작:
{
    CoordMode, Mouse, Screen
    Send {Click 10, 10}
}
return

Button종료:
{
    ExitApp
}
return

GuiClose:
{
    ExitApp
}
return