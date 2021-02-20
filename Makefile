OS=$(shell uname -s)
ARCH=$(shell uname -m)

LD=ld
.SUFFIXES: .asm .o

ifeq ($(OS),Darwin)
    NASM = nasm -fmacho64
    LDFLAGS = -e _start -macos_version_min 10.7
else
	ifeq ($(OS),Linux)
        NASM = nasm -felf64 
	endif
endif


PROGRAMS = args input count prime exec
OBJECTS = $(addsuffix .o,$(PROGRAMS)) 

NASMFLAGS += -g -Ilib

.PHONY: all
all : $(PROGRAMS)

% : src/%.o
	$(LD)  $< $(LDFLAGS) -o bin/$@

%.o : %.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

.PHONY: clean
clean :
	rm -rf src/*.o $(PROGRAMS)