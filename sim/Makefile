# -------------------------- 工具与路径配置（以sim目录为基准） --------------------------
# 仿真工具（iverilog开源工具，ModelSim可替换为vlog/vvs）
SIM_TOOL = iverilog    # 编译工具
SIM_EXEC = vvp         # 执行工具（iverilog配套）
# 路径定义（../表示sim的上级目录，即项目根目录）
SRC_DIR = ../src# 源文件目录（根目录下的src）
TB_DIR = ../tb# 测试文件目录（根目录下的tb）
LOG_DIR = ./logs# 日志目录（sim下的logs）
WAVE_DIR = ./waves# 波形目录（sim下的waves）
MODULE_DIR = combinational

# 自动创建日志/波形目录（若不存在）
$(shell mkdir -p $(LOG_DIR) $(WAVE_DIR))

# -------------------------- 核心规则：编译+仿真（直接在sim执行） --------------------------
# 1. 仿真规则（入口：make sim_模块名，例：make sim_and_gate）
sim_%: compile_%
	@echo "🚀 开始仿真模块：$*"
    	# 执行仿真，日志输出到LOG_DIR
	$(SIM_EXEC) $*.out > $(LOG_DIR)/$*.log
	@echo "✅ 仿真完成！"
	@echo "  📄 日志：$(LOG_DIR)/$*.log"
	@echo "  🌊 波形：$(WAVE_DIR)/tb_$*.vcd（需TB开启$dumpfile）"

# 2. 编译规则（自动触发，无需手动调用）
compile_%:
	@echo "🔨 开始编译模块：$*"
	# 自动匹配模块子目录（如combinational/sequential，通过模块名提取）
	# 例：and_gate→combinational，d_ff→sequential
	@echo "🔍 调试：提取的 MODULE_DIR 是 --> $(MODULE_DIR)"  # 新增这行，打印提取结果
	# 编译命令（-Wall显示警告，-o输出到sim目录）
	$(SIM_TOOL) -Wall -o $*.out $(SRC_DIR)/$(MODULE_DIR)/$*.v  $(TB_DIR)/$(MODULE_DIR)/tb_$*.v
	@echo "✅ 编译完成！输出：$*.out（sim目录下）"

# -------------------------- 辅助规则：清理+帮助 --------------------------
# 清理规则（删除sim下的编译产物、日志、波形）
clean:
	@echo "🗑️  清理sim目录下的仿真文件..."
	rm -rf $*.out $(LOG_DIR)/* $(WAVE_DIR)/*
	@echo "✅ 清理完成！"

# 帮助规则（查看可用命令）
help:
	@echo "📋 可用命令（模块名例：and_gate）："
	@echo "  make sim_模块名 → 编译+仿真指定模块（核心命令）"
	@echo "  make clean      → 清理sim目录下的仿真文件"
	@echo "  make help       → 查看帮助信息"
