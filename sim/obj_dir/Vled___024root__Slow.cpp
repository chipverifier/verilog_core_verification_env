// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vled.h for the primary calling header

#include "Vled__pch.h"
#include "Vled__Syms.h"
#include "Vled___024root.h"

void Vled___024root___ctor_var_reset(Vled___024root* vlSelf);

Vled___024root::Vled___024root(Vled__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vled___024root___ctor_var_reset(this);
}

void Vled___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vled___024root::~Vled___024root() {
}
