CXX = clang++
CXXFLAGS = -std=c++20 --debug -I$(INCLUDE_DIR) -MMD -MP -MT '$(OBJ_DIR)/$*.o' -MF '$(OBJ_DIR)/$*.d'
INCLUDE_DIR = include
BUILD_DIR = build
TARGET_DIR = $(BUILD_DIR)
ASSEMBLY_DIR = $(BUILD_DIR)/asm
OBJ_DIR = $(BUILD_DIR)/obj
TARGET = $(TARGET_DIR)/$(notdir $(CURDIR))

SRCS = $(wildcard src/*.cpp)
OBJS = $(patsubst src/%.cpp,$(OBJ_DIR)/%.o,$(SRCS))
ASSEMBLY_OBJS = $(patsubst src/%.cpp,$(ASSEMBLY_DIR)/%.s,$(SRCS))

-include $(OBJS:.o=.d)

all: $(TARGET)

$(TARGET): $(OBJS) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS)

$(OBJ_DIR)/%.o: src/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(ASSEMBLY_DIR):
	mkdir -p $(ASSEMBLY_DIR)

$(ASSEMBLY_DIR)/%.s: src/%.cpp | $(ASSEMBLY_DIR)
	$(CXX) $(CXXFLAGS) -S -masm=intel $< -o $@

run: $(TARGET) $(ASSEMBLY_OBJS)
	./$(TARGET)

.PHONY: all clean run

clean:
	rm -rf $(BUILD_DIR)
