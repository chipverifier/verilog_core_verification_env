// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vled_top.h for the primary calling header

#include "Vled_top__pch.h"
#include "Vled_top__Syms.h"
#include "Vled_top___024root.h"

void Vled_top___024root___ctor_var_reset(Vled_top___024root* vlSelf);

Vled_top___024root::Vled_top___024root(Vled_top__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vled_top___024root___ctor_var_reset(this);
}

void Vled_top___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vled_top___024root::~Vled_top___024root() {
}
