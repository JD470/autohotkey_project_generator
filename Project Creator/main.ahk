#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
 #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SysGet, scr, Monitor
width := 300
height := 125
posx := (%scrRight% - %width%) / 2
posy := (%scrBottom% - %height%) / 2

; Get the project's name

InputBox, project_name, Creating a new project, What would you like to name your project?,, %width%, %height%, %posx%, %posy%
if ErrorLevel or !project_name ; If the input box is closed, if it times out or if the input is empty
    ExitApp

; Get where should the project be placed from project-parent.txt

FileRead, project_parent, %A_ScriptDir%\project-parent.txt
if ErrorLevel or !project_parent
    project_parent := A_ScriptDir . "\.." ; Defaults the parent folder of the project to the parent of the script's parent

if SubStr(project_parent, 1, 1) = "\" ; If the first character is a backslash(if the path given is relative), it will put the path of where the script is before
    project_parent := A_ScriptDir . project_parent

FileCopyDir, %A_ScriptDir%\template, %project_parent%\%project_name%
FileDelete, %project_parent%\%project_name%\auto-open.txt ; Deletes the auto-open.txt file since it should only be in the template

; Goes to created project's directory

SendInput, ^l ; Opens the address bar(Path)
SendInput, %project_parent%\%project_name%{Enter}

; Runs automatically the files in auto-open.txt

autorun := A_ScriptDir . "\template\auto-open.txt"
FileRead, read_file, %autorun%
if ErrorLevel or !read_file
    ExitApp

sort_by_newlines := StrSplit(read_file, "`n")
for i in sort_by_newlines{
    current_file := sort_by_newlines[i]
    if (i != sort_by_newlines.Length()){
        len := StrLen(current_file) - 1
    }
    else{
        len := StrLen(current_file)
    }
    current_file := SubStr(current_file, 1, len)
    Run, %project_parent%\%project_name%\%current_file%
}
ExitApp
