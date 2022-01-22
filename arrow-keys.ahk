Left()
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

}

Up()
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

}

Right()
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

}

Down()
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
}