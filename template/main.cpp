#include "include/raylib.h"

#include <iostream>

#define WIDTH 800
#define HEIGHT 600

int main(){
    InitWindow(WIDTH, HEIGHT, "");
    SetExitKey(0);
    SetTargetFPS(60);

    while (!WindowShouldClose()){
        BeginDrawing();
        ClearBackground(BLACK);

        EndDrawing();
    }
    CloseWindow();

    return 0;
}