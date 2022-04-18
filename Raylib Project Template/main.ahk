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
FileDelete, %A_ScriptDir%\..\%project_name%\auto-open.txt

; Goes to created project's directory

SendInput, ^l{Right} ; Opens the address bar(Path)
SendInput, \..\%project_name%{Enter}

; Runs automatically the files in auto-open.txt

autorun := A_ScriptDir . "\template\auto-open.txt"
FileRead, readed, %autorun%
sort_by_newlines := StrSplit(readed, "`n")
for i in sort_by_newlines{
    currentFile := sort_by_newlines[i]
    if (i != sort_by_newlines.Length()){
        len := StrLen(currentFile) - 1
    }
    else{
        len := StrLen(currentFile)
    }
    currentFile := SubStr(currentFile, 1, len)
    Run, %A_ScriptDir%\..\%project_name%\%currentFile%
}

ExitApp
