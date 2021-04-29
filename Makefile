.SUFFIXES: .asm .inc .o
vpath %.inc $(LIBRARY_DIR)

OS = $(shell uname -s)

BINARY_DIR = bin
LIBRARY_DIR = lib
SOURCE_DIR = src

LD = ld
LDFLAGS =

AS = nasm
ASFLAGS = -g -I$(LIBRARY_DIR)/ -Wall -Werror

ifeq ($(OS),Darwin)
#   SDKPATH = $(shell xcode-select -p)/SDKs/MacOSX.sdk/usr/lib
   ASFLAGS += -f macho64
   LDFLAGS += -e _start -macos_version_min 10.7.0 # -L$(SDKPATH) -lSystem
else
ifeq ($(OS),Linux)
    ASFLAGS += -f elf64
endif
endif

SOURCES = $(notdir $(wildcard src/*.asm))
PROGRAMS = $(basename $(SOURCES))
OBJECTS = $(addsuffix .o,$(PROGRAMS))
BINARIES = $(addprefix $(BINARY_DIR)/,$(PROGRAMS))

.PHONY: all
all: $(BINARIES)

$(BINARY_DIR)/%: %.o
	mkdir -p $(BINARY_DIR)
	$(LD) $(LDFLAGS) -o $@ $< 

%.o: src/%.asm
	$(AS) $(ASFLAGS) -o $@ $<

.PHONY: clean
clean:
	rm -rf $(BINARIES) src/*.o

.PHONY: run
run: all
	./bin/args foo bar
	./bin/exec
	./bin/count
	./bin/input
	./bin/prime 10
