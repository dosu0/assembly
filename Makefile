.SUFFIXES: .asm .inc .o
vpath %.inc $(LIBDIR)

OS = $(shell uname -s)

BINDIR = bin
LIBDIR = lib
DEPDIR = .deps

LD = ld

AS = nasm
ASFLAGS = -g -I$(LIBDIR)/ -Wall -Werror

VPATH = $(BINDIR)

ifeq ($(OS),Darwin)
#   SDKPATH = $(shell xcode-select -p)/SDKs/MacOSX.sdk/usr/lib
   ASFLAGS += -f macho64
   LDFLAGS = -e _start -macos_version_min 10.7.0 # -L$(SDKPATH) -lSystem
else
ifeq ($(OS),Linux)
    ASFLAGS += -f elf64
endif
endif

SOURCES = $(notdir $(wildcard src/*.asm))
PROGRAMS = $(basename $(SOURCES))
OBJECTS = $(addsuffix .o,$(PROGRAMS))
BINARIES = $(addprefix $(BINDIR)/, $(PROGRAMS))

.PHONY: all
all : $(BINARIES)

$(BINDIR)/% : %.o
	mkdir -p $(BINDIR)
	$(LD) $< $(LDFLAGS) -o $@

%.o : src/%.asm
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	rm -rf $(BINARIES) src/*.o
