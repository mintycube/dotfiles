CXX = clang++
CXXFLAGS = -std=c++20 --debug
SRCDIR := .
BUILDDIR := build
INCDIR := include
SRCS := $(wildcard $(SRCDIR)/*.cpp)
OBJS := $(patsubst $(SRCDIR)/%.cpp,$(BUILDDIR)/%.o,$(SRCS))
DEPS := $(OBJS:.o=.d)
EXEC := main
all: compile_msg build
compile_msg:
	@echo -e "\e[33m Compile: $(SRCS)\e[0m"
$(EXEC): $(OBJS)
	@echo -e "\n\e[33m Link: $(EXEC)\e[0m"
	$(CXX) $(CXXFLAGS) $(OBJS) -o $(EXEC)
build: $(EXEC)
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(BUILDDIR)
	$(CXX) $(CXXFLAGS) -I$(INCDIR) -MMD -MP -c $< -o $@
-include $(DEPS)
run: $(EXEC)
	@echo -e "\n\e[33m󱓞 Execute : $(EXEC)\e[0m"
	./$(EXEC)
clean:
	rm -rf $(BUILDDIR) $(EXEC)
.PHONY: all build run clean
