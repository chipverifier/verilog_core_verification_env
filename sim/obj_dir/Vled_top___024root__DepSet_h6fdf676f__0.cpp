// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vled_top.h for the primary calling header

#include "Vled_top__pch.h"
#include "Vled_top___024root.h"

void Vled_top___024root___eval_act(Vled_top___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled_top___024root___eval_act\n"); );
    Vled_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

void Vled_top___024root___nba_sequent__TOP__0(Vled_top___024root* vlSelf);

void Vled_top___024root___eval_nba(Vled_top___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled_top___024root___eval_nba\n"); );
    Vled_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        Vled_top___024root___nba_sequent__TOP__0(vlSelf);
    }
}

VL_INLINE_OPT void Vled_top___024root___nba_sequent__TOP__0(Vled_top___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled_top___024root___nba_sequent__TOP__0\n"); );
    Vled_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __Vdly__led_top__DOT__counter;
    __Vdly__led_top__DOT__counter = 0;
    CData/*0:0*/ __Vdly__led;
    __Vdly__led = 0;
    // Body
    __Vdly__led_top__DOT__counter = vlSelfRef.led_top__DOT__counter;
    __Vdly__led = vlSelfRef.led;
    if (vlSelfRef.reset) {
        __Vdly__led_top__DOT__counter = 0U;
        __Vdly__led = 0U;
    } else if ((0xaU <= vlSelfRef.led_top__DOT__counter)) {
        __Vdly__led = (1U & (~ (IData)(vlSelfRef.led)));
        __Vdly__led_top__DOT__counter = 0U;
    } else {
        __Vdly__led_top__DOT__counter = ((IData)(1U) 
                                         + vlSelfRef.led_top__DOT__counter);
    }
    vlSelfRef.led_top__DOT__counter = __Vdly__led_top__DOT__counter;
    vlSelfRef.led = __Vdly__led;
}

void Vled_top___024root___eval_triggers__act(Vled_top___024root* vlSelf);

bool Vled_top___024root___eval_phase__act(Vled_top___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled_top___024root___eval_phase__act\n"); );
    Vled_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    VlTriggerVec<1> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vled_top___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelfRef.__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelfRef.__VactTriggered, vlSelfRef.__VnbaTriggered);
        vlSelfRef.__VnbaTriggered.thisOr(vlSelfRef.__VactTriggered);
        Vled_top___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vled_top___024root___eval_phase__nba(Vled_top___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled_top___024root___eval_phase__nba\n"); );
    Vled_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelfRef.__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vled_top___024root___eval_nba(vlSelf);
        vlSelfRef.__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vled_top___024root___dump_triggers__nba(Vled_top___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vled_top___024root___dump_triggers__act(Vled_top___024root* vlSelf);
#endif  // VL_DEBUG

void Vled_top___024root___eval(Vled_top___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled_top___024root___eval\n"); );
    Vled_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY(((0x64U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vled_top___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("../src/combinational/led_top.v", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelfRef.__VactIterCount = 0U;
        vlSelfRef.__VactContinue = 1U;
        while (vlSelfRef.__VactContinue) {
            if (VL_UNLIKELY(((0x64U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vled_top___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("../src/combinational/led_top.v", 1, "", "Active region did not converge.");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
            vlSelfRef.__VactContinue = 0U;
            if (Vled_top___024root___eval_phase__act(vlSelf)) {
                vlSelfRef.__VactContinue = 1U;
            }
        }
        if (Vled_top___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vled_top___024root___eval_debug_assertions(Vled_top___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled_top___024root___eval_debug_assertions\n"); );
    Vled_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (VL_UNLIKELY(((vlSelfRef.clk & 0xfeU)))) {
        Verilated::overWidthError("clk");
    }
    if (VL_UNLIKELY(((vlSelfRef.reset & 0xfeU)))) {
        Verilated::overWidthError("reset");
    }
}
#endif  // VL_DEBUG
