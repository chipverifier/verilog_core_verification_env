# sim/Makefile
tc ?= full_adder# 默认编译运行全加器，可通过tc=xxx指定其他模块
all:
	iverilog -gno-assertions -g2012 -Wall -o $(tc).out -y ../env/ ../src/combinational/ ../src/combinational/$(tc).v ../tb/combinational/$(tc)_tb.sv && vvp $(tc).out
