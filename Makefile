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

$(BINDIR)/$(TARGET): $(OBJECTS) $(LEXER_OBJS)
	mkdir -p $(BINDIR)
	$(CC) -o $@ $^ $(CFLAGS) $(LDLIBS)
	@echo "Linking complete!"

$(LEXER_SRCS): $(SRCDIR)/%.c : $(SRCDIR)/%.l
	flex -o $@ $<

$(OBJECTS) $(LEXER_OBJS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	mkdir -p $(OBJDIR)
	$(CC) -o $@ -c $< $(CFLAGS) -I $(INCLUDE_PATH)

.PHONY: clean cov

clean:
	rm -f $(OBJDIR)/*.o
	rm -f $(OBJDIR)/*.gcda
	rm -f $(OBJDIR)/*.gcno
	rm -f $(BINDIR)/$(TARGET)
	rm -f $(LEXER_SRCS)

