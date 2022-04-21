#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

GetFoldersInDirectory(dir){
    to_return := []
    Loop, % dir "\*", 2
    {   
        cur := A_LoopFileFullPath . ""
        to_return.Push(cur)
    }
    return to_return
}

GetParentProject(dir){
    FileRead, to_return, %A_ScriptDir%\%dir%\project-parent.txt
    if (ErrorLevel or !to_return){
        FileRead, to_return, %A_ScriptDir%\project-parent.txt
        if (ErrorLevel or !to_return){
            to_return := "\.."
        }
    }
    return to_return
}

; Getting all the folders in the script's directory

folders := GetFoldersInDirectory(A_ScriptDir)
folders_ddl := ""
for i in folders{
    cur := folders[i]
    SplitPath, cur, parent
    folders_ddl := folders_ddl . "|" . parent
}
templates := SubStr(folders_ddl, 2)

; Default value for the directory

cur := folders[1]
SplitPath, cur, parent

; Where and how the GUI is made

Gui, New,, Creating a project...
Gui, Font, s10
Gui, Add, Text, x0 Center w300, What would you like to call your project?
Gui, Font, s9
Gui, Add, Text, x0 Center y33 w300, Project name:
Gui, Add, Edit, r1 x50 y50 w200 vNAME,
Gui, Add, Text, x0 Center y80 w300, Parent directory: 
Gui, Add, Edit, r1 x50 y100 w200 vDIR, % GetParentProject(parent)
Gui, Add, Text, x0 Center y130 w300, Template:
Gui, Add, DropDownList, gDropDownListTemplates vTemp Choose1 x50 y150 w200, % templates
gui, add, button, x100 y195 w100 Default, Enter

Gui, Show, xCenter yCenter w300 h225, Creating a project...
Return ; Important or else any label below won't work

DropDownListTemplates:
Gui, Submit, NoHide
directory := GetParentProject(Temp)
GuiControl,, DIR, % directory
return

ButtonEnter:
Gui, Submit, NoHide
if (SubStr(DIR, 1, 1) = "\" or SubStr(DIR, 1, 1) = "/"){ ; Checks if the path is relative, in that case, it will put the path of the script in front of it.
    DIR := A_ScriptDir . DIR
}

FileCopyDir, %A_ScriptDir%\%Temp%, %DIR%\%NAME%
FileDelete, %DIR%\%NAME%\auto-open.txt ; Deletes the auto-open.txt file since it should only be in the template
FileDelete, %DIR%\%NAME%\project-parent.txt ; Deletes the project-parent.txt file since it should only be in the template
Gui, Destroy

#IfWinActive ahk_class CabinetWClass ; Only types the path of the project if the file explorer is active

SendInput, ^l ; Opens the address bar(Path)
SendInput, %DIR%\%NAME%{Enter}

#IfWinActive

;MsgBox, %DIR%\%NAME%
;MsgBox, %A_ScriptDir%\%Temp%

ExitApp

GuiClose: ; Exits the program on close
ExitApp

; Dev
^r::
Reload
Return

^Shift::
ExitApp