OS=$(shell uname -s)
ARCH=$(shell uname -m)

ifeq ($(ARCH), x86_64)
    VPATH = lib/x64:src/x64
    NASMFLAGS = -Ilib/x64
    ARCH = x64
    SRC = src/x64
else
	ifeq ($(ARCH),i686)
        VPATH = lib/x64:src/x64
        NASMFLAGS = -Ilib/x64
        ARCH = x86
        SRC = src/x86
	endif
endif

ifeq ($(OS),Darwin)
    NASM = nasm -fmacho64
    LDFLAGS = -e _start -macosx_version_min 10.7.0
else
	ifeq ($(OS),Linux)
        NASM = nasm -felf
#       LDFLAGS = -m
	endif
endif

.SUFFIXES: .asm .o

#PROGAMS = len inc ln args input
#PROGRAMS := $(addprefix hello-, $(PROGRAMS))
#PROGRAMS += hello count

PROGRAMS = prime

OBJECTS = $(addsuffix .o,$(PROGRAMS)) 

.PHONY: all
all : $(PROGRAMS)

% : $(SRC)/%.o bin
	ld $(LDFLAGS) $< -o bin/$@

%.o : %.asm
	$(NASM) -M -MF $(SRC)/.deps/$(notdir $<).dep $< 

%.o : %.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

bin :
	mkdir bin 
 
.PHONY: clean
clean :
	rm -rf src/*.o $(PROGRAMS)