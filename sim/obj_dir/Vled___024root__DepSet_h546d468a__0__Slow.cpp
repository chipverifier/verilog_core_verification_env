// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vled.h for the primary calling header

#include "Vled__pch.h"
#include "Vled___024root.h"

VL_ATTR_COLD void Vled___024root___eval_static__TOP(Vled___024root* vlSelf);

VL_ATTR_COLD void Vled___024root___eval_static(Vled___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled___024root___eval_static\n"); );
    Vled__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vled___024root___eval_static__TOP(vlSelf);
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
}

VL_ATTR_COLD void Vled___024root___eval_static__TOP(Vled___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled___024root___eval_static__TOP\n"); );
    Vled__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.top__DOT__counter = 0U;
}

VL_ATTR_COLD void Vled___024root___eval_initial(Vled___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled___024root___eval_initial\n"); );
    Vled__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vled___024root___eval_final(Vled___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled___024root___eval_final\n"); );
    Vled__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vled___024root___eval_settle(Vled___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled___024root___eval_settle\n"); );
    Vled__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vled___024root___dump_triggers__act(Vled___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled___024root___dump_triggers__act\n"); );
    Vled__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VactTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vled___024root___dump_triggers__nba(Vled___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled___024root___dump_triggers__nba\n"); );
    Vled__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VnbaTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vled___024root___ctor_var_reset(Vled___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vled___024root___ctor_var_reset\n"); );
    Vled__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16707436170211756652ull);
    vlSelf->led = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14009161575225144129ull);
    vlSelf->top__DOT__counter = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 6797571695291562472ull);
    vlSelf->__Vtrigprevexpr___TOP__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9526919608049418986ull);
}
