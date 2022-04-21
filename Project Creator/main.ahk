#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


GetFoldersInDirectory(dir){
    to_return := []
    Loop, % dir "\*", 2
    {   
        cur := A_LoopFileFullPath . ""
        to_return.Push(cur)
    }
    return to_return
}

; Getting all the files in 

folders := GetFoldersInDirectory(A_ScriptDir)
folders_ddl := ""
for i in folders{
    cur := folders[i]
    SplitPath, cur, parent
    folders_ddl := folders_ddl . "|" . parent
}
templates := SubStr(folders_ddl, 2)

; Where and how the GUI is made

Gui, New,, Creating a project...
Gui, Font, s10
Gui, Add, Text, x0 Center w300, What would you like to call your project?
Gui, Font, s9
Gui, Add, Text, x0 Center y33 w300, Project name:
Gui, Add, Edit, r1 x50 y50 w200 vNAME,
Gui, Add, Text, x0 Center y80 w300, Parent directory: 
Gui, Add, Edit, r1 x50 y100 w200 vDIR,
Gui, Add, Text, x0 Center y130 w300, Template:
Gui, Add, DropDownList, gDropDownListTemplates vTemp x50 y150 w200, % templates
gui, add, button, x100 y225 w100 Default, Enter

Gui, Show, xCenter yCenter w300 h250, Creating a project...
Return ; Important or else any label below won't work

DropDownListTemplates:
Gui, Submit, NoHide
FileRead, directory, %A_ScriptDir%\%Temp%\project-parent.txt
if (ErrorLevel or !directory){
    FileRead, directory, %A_ScriptDir%\project-parent.txt
    if (ErrorLevel or !directory){
        directory := "\.."
    }
}
GuiControl,, DIR, % directory
return

ButtonEnter:
Gui, Submit, NoHide
if (SubStr(DIR, 1, 1) = "\" or SubStr(DIR, 1, 1) = "/"){ ; Checks if the path is relative, in that case, it will put the path of the script in front of it.
    DIR := A_ScriptDir . DIR
}
MsgBox, %DIR%\%NAME%
gui, Destroy
ExitApp

GuiClose: ; Exits the program on close
ExitApp

; Dev
^r::
Reload
Return

^Shift::
ExitApp