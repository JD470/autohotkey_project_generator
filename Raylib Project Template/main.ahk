#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinGetPos,,, screen_width, screen_height, Program Manager
width := 250
height := 200
posx := screen_width / 2 - %width% / 2
posy := screen_height / 2 - %height% / 2

InputBox, var, Creating a new raylib project, What would you like to name your project?,, %width%, %height%, %posx%, %posy%
if (ErrorLevel){ ; If the input box is closed or if it times out: exit
    ExitApp
}

FileCopyDir, %A_ScriptDir%\template, %A_ScriptDir%\..\%var%

SendInput, !{Up} ; Goes to parent directory
SendInput, ^l ; Opens the address bar(Path)
SendInput, {Right}
SendInput, \%var%{Enter}
Sleep, 100

; Opens VS Code for main.cpp

SendInput, ^l ; Opens the address bar(Path)
SendInput, {BackSpace}cmd{Enter}
Sleep, 1000
SendInput, code main.cpp{Enter}
SendInput, exit{Enter}
ExitApp
