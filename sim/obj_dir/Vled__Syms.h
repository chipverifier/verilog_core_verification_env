// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VLED__SYMS_H_
#define VERILATED_VLED__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vled.h"

// INCLUDE MODULE CLASSES
#include "Vled___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES) Vled__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vled* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vled___024root                 TOP;

    // CONSTRUCTORS
    Vled__Syms(VerilatedContext* contextp, const char* namep, Vled* modelp);
    ~Vled__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
