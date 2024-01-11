CC ?= gcc
LDLIBS ?=
CFLAGS ?= #-fprofile-arcs -ftest-coverage 

ifeq ($(MAKECMDGOALS),tests)
    CFLAGS += -DTEST
else
    CFLAGS += -Werror
endif

INCLUDE_PATH = ./include

TARGET = cmat
PREFIX = cmat

SRCDIR = src
OBJDIR = obj
BINDIR = bin

SOURCES := $(wildcard $(SRCDIR)/*.c)
INCLUDES := $(wildcard $(INCLUDE_PATH)/*.h)
OBJECTS := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

LEXERS := $(wildcard $(SRCDIR)/*.l)
LEXER_SRCS := $(LEXERS:$(SRCDIR)/%.l=$(SRCDIR)/%.c)
LEXER_OBJS := $(LEXER_SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

PARSERS := $(wildcard $(SRCDIR)/*.y)
PARSER_SRCS := $(PARSERS:$(SRCDIR)/%.y=$(SRCDIR)/%.c)
PARSER_OBJS := $(PARSER_SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

TARGET_OBJ := $(OBJECTS) $(LEXER_OBJS) $(PARSER_OBJS)

.PHONY: all tests clean check_tools

all: check_tools $(BINDIR)/$(TARGET)

$(BINDIR)/$(TARGET) $(BINDIR)/$(TARGET_TEST): $(TARGET_OBJ) 
	mkdir -p $(BINDIR)
	$(CC) -o $@ $^ $(CFLAGS) $(LDLIBS)
	@echo "Linking complete!"

$(LEXER_SRCS): $(SRCDIR)/%.c : $(SRCDIR)/%.l
	flex --header-file=$(INCLUDE_PATH)/$*.h -o $@ $<

$(PARSER_SRCS) : $(SRCDIR)/%.c : $(SRCDIR)/%.y
	bison -o $@ --header=$(INCLUDE_PATH)/$*.h $<

$(TARGET_OBJ): $(OBJDIR)/%.o : $(SRCDIR)/%.c $(PARSER_SRCS) $(LEXER_SRCS) 
	mkdir -p $(OBJDIR)
	$(CC) -o $@ -c $< $(CFLAGS) -I$(INCLUDE_PATH)

clean:
	rm -f $(OBJDIR)/*.o
	rm -f $(BINDIR)/$(TARGET)
	rm -f $(LEXER_SRCS) $(PARSER_SRCS)
	rm -f $(INCLUDE_PATH)/$(PREFIX).*.h
	rm -f $(OBJDIR)/*.gcno $(OBJDIR)/*.gcda


# Required to run tests before generating coverage
cov:
	lcov --capture --directory . --output-file coverage.info
	genhtml coverage.info --output-directory out


# Check if Flex and Bison are installed
check_tools:
	@command -v flex >/dev/null 2>&1 || { echo >&2 "Flex is required but not installed. Aborting."; exit 1; }
	@command -v bison >/dev/null 2>&1 || { echo >&2 "Bison is required but not installed. Aborting."; exit 1; }

