#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SysGet, scr, Monitor
width := 300
height := 125
posx := (%scrRight% - %width%) / 2
posy := (%scrBottom% - %height%) / 2

InputBox, project_name, Creating a new project, What would you like to name your project?,, %width%, %height%, %posx%, %posy%
if ErrorLevel or !project_name ; If the input box is closed, if it times out or if the input is empty
    ExitApp
FileCopyDir, %A_ScriptDir%\template, %A_ScriptDir%\..\%project_name%

; Goes to created project's directory

SendInput, ^l{Right} ; Opens the address bar(Path)
SendInput, \..\%project_name%{Enter}

Run, %A_ScriptDir%\..\%project_name%\main.cpp ; Opens main.cpp
ExitApp
