#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Reads the directory where the project will be copied to in the template it self or then it will look at the project-parent.txt file next to the script or it will default anyways to \..

FileRead, directory, %A_ScriptDir%\template\project-parent.txt
if (ErrorLevel or !directory){
    FileRead, directory, %A_ScriptDir%\project-parent.txt
    if (ErrorLevel or !directory){
        directory := "\.."
    }
}

; Where and how the GUI is made

Gui, New,, Creating a project...
Gui, Font, s10
Gui, Add, Text, x0 Center w300, What would you like to call your project?
Gui, Font, s9
Gui, Add, Text, x0 Center y33 w300, Project name:
Gui, Add, Edit, r1 x50 y50 w200 vNAME,
Gui, Add, Text, x0 Center y80 w300, Parent directory: 
Gui, Add, Edit, r1 x50 y100 w200 vDIR, %directory%
gui, add, button, x100 y175 w100 Default, Enter

Gui, Show, xCenter yCenter w300 h200, Creating a project...
Return ; Important or else any label below won't work

ButtonEnter:
Gui, Submit, NoHide
if (SubStr(DIR, 1, 1) = "\" or SubStr(DIR, 1, 1) = "/"){ ; Checks if the path is relative, in that case, it will put the path of the script in front of it.
    DIR := A_ScriptDir . DIR
}
msgbox, %DIR%\%NAME%
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