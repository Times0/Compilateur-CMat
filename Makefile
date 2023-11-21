CC ?= gcc
CFLAGS ?=
LDLIBS ?=

INCLUDE_PATH = ./include

TARGET = CmatCompiler
PREFIX = Cmat

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

.PHONY: all tests

all: $(BINDIR)/$(TARGET)

tests: CFLAGS += -DTEST
tests: $(BINDIR)/cmat_test_version

$(BINDIR)/$(TARGET) $(BINDIR)/cmat_test_version: $(TARGET_OBJ)
	mkdir -p $(BINDIR)
	$(CC) -o $@ $^ $(CFLAGS) $(LDLIBS)
	@echo "Linking complete!"

$(LEXER_SRCS): $(SRCDIR)/%.c : $(SRCDIR)/%.l
	flex -o $@ $<

$(PARSER_SRCS): $(SRCDIR)/%.c : $(SRCDIR)/%.y
	bison -o $@ $<

$(TARGET_OBJ): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	mkdir -p $(OBJDIR)
	$(CC) -o $@ -c $< $(CFLAGS) -I$(INCLUDE_PATH)

clean:
	rm -f $(OBJDIR)/*.o
	rm -f $(OBJDIR)/*.gcda
	rm -f $(OBJDIR)/*.gcno
	rm -f $(BINDIR)/$(TARGET) $(BINDIR)/cmat_test_version
	rm -f $(LEXER_SRCS) $(PARSER_SRCS)
