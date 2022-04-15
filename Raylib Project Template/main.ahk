#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SysGet, scr, Monitor
width := 300
height := 200
posx := %scrRight% / 2 - %width% / 2
posy := %scrBottom% / 2 - %height% / 2

InputBox, project_name, Creating a new project, What would you like to name your project?,, %width%, %height%, %posx%, %posy%
if (ErrorLevel){ ; If the input box is closed or if it times out: exit
    ExitApp
}
FileCopyDir, %A_ScriptDir%\template, %A_ScriptDir%\..\%project_name%

SendInput, !{Up} ; Goes to parent directory
SendInput, ^l ; Opens the address bar(Path)
SendInput, {Right}
SendInput, \%project_name%{Enter}
Sleep, 100

; Opens VS Code for main.cpp

SendInput, ^l ; Opens the address bar(Path)
SendInput, {BackSpace}cmd{Enter}
Sleep, 1000
SendInput, code main.cpp{Enter}
SendInput, exit{Enter}
ExitApp
