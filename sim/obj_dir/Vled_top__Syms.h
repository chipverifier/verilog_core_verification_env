// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VLED_TOP__SYMS_H_
#define VERILATED_VLED_TOP__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vled_top.h"

// INCLUDE MODULE CLASSES
#include "Vled_top___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES) Vled_top__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vled_top* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vled_top___024root             TOP;

    // CONSTRUCTORS
    Vled_top__Syms(VerilatedContext* contextp, const char* namep, Vled_top* modelp);
    ~Vled_top__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
