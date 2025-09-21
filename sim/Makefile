# sim/Makefile
tc ?= full_adder# 默认编译运行全加器，可通过tc=xxx指定其他模块
all:
	iverilog -g2012 -Wall -o $(tc).out -y ../src/combinational/ ../src/combinational/$(tc).v ../tb/combinational/tb_$(tc).sv && vvp $(tc).out
