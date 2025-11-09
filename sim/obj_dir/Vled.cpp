// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vled__pch.h"

//============================================================
// Constructors

Vled::Vled(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vled__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , led{vlSymsp->TOP.led}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vled::Vled(const char* _vcname__)
    : Vled(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vled::~Vled() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vled___024root___eval_debug_assertions(Vled___024root* vlSelf);
#endif  // VL_DEBUG
void Vled___024root___eval_static(Vled___024root* vlSelf);
void Vled___024root___eval_initial(Vled___024root* vlSelf);
void Vled___024root___eval_settle(Vled___024root* vlSelf);
void Vled___024root___eval(Vled___024root* vlSelf);

void Vled::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vled::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vled___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vled___024root___eval_static(&(vlSymsp->TOP));
        Vled___024root___eval_initial(&(vlSymsp->TOP));
        Vled___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vled___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vled::eventsPending() { return false; }

uint64_t Vled::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vled::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vled___024root___eval_final(Vled___024root* vlSelf);

VL_ATTR_COLD void Vled::final() {
    Vled___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vled::hierName() const { return vlSymsp->name(); }
const char* Vled::modelName() const { return "Vled"; }
unsigned Vled::threads() const { return 1; }
void Vled::prepareClone() const { contextp()->prepareClone(); }
void Vled::atClone() const {
    contextp()->threadPoolpOnClone();
}
