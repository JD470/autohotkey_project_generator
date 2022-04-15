@echo off
g++ *.cpp -o main.exe -mwindows -Wall -Wno-missing-braces -I include/ -L lib/ -lraylib -lopengl32 -lgdi32 -lwinmm
:: upx -9 -qqq main.exe
pause