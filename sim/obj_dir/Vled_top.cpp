// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vled_top__pch.h"

//============================================================
// Constructors

Vled_top::Vled_top(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vled_top__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , reset{vlSymsp->TOP.reset}
    , led{vlSymsp->TOP.led}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vled_top::Vled_top(const char* _vcname__)
    : Vled_top(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vled_top::~Vled_top() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vled_top___024root___eval_debug_assertions(Vled_top___024root* vlSelf);
#endif  // VL_DEBUG
void Vled_top___024root___eval_static(Vled_top___024root* vlSelf);
void Vled_top___024root___eval_initial(Vled_top___024root* vlSelf);
void Vled_top___024root___eval_settle(Vled_top___024root* vlSelf);
void Vled_top___024root___eval(Vled_top___024root* vlSelf);

void Vled_top::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vled_top::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vled_top___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vled_top___024root___eval_static(&(vlSymsp->TOP));
        Vled_top___024root___eval_initial(&(vlSymsp->TOP));
        Vled_top___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vled_top___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vled_top::eventsPending() { return false; }

uint64_t Vled_top::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vled_top::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vled_top___024root___eval_final(Vled_top___024root* vlSelf);

VL_ATTR_COLD void Vled_top::final() {
    Vled_top___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vled_top::hierName() const { return vlSymsp->name(); }
const char* Vled_top::modelName() const { return "Vled_top"; }
unsigned Vled_top::threads() const { return 1; }
void Vled_top::prepareClone() const { contextp()->prepareClone(); }
void Vled_top::atClone() const {
    contextp()->threadPoolpOnClone();
}
