#include "verilated.h"
#include "Vtop.h"  // Verilator 自动生成的顶层模块头文件
#include <iostream>
#include <thread>
#include <chrono>

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Vtop* top = new Vtop;  // 实例化模块

    while (!Verilated::gotFinish()) {
        // 生成时钟（低电平）
        top->clk = 0;
        top->eval();  // 计算逻辑
        std::this_thread::sleep_for(std::chrono::nanoseconds(5));  // 模拟时钟周期

        // 生成时钟（高电平）
        top->clk = 1;
        top->eval();  // 计算逻辑
        std::this_thread::sleep_for(std::chrono::nanoseconds(5));

        // 打印 LED 状态
        std::cout << "LED: " << (top->led ? "ON" : "OFF") << std::endl;
    }

    delete top;
    return 0;
}
