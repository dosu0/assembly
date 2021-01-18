NASM := nasm -felf
NASMFLAGS := -Iinclude/
VPATH = src:include
.SUFFIXES: .asm .o
# macOS
# NASM := nasm -fmacho
# LDFLAGS = -e _start -macos-min-version 10.7.0

PROGS = len inc ln args input
PROGRAMS = $(addprefix hello-, $(PROGS))
PROGRAMS += hello count
OBJECTS = $(addsuffix .o,$(PROGRAMS)) 

.PHONY: all
all : $(PROGRAMS)

% : src/%.o bin
	ld $(LDFLAGS) $< -o bin/$@ 

%.o : %.asm
	$(NASM) $(NASMFLAGS) -o $@ -MD $<.dep $<

bin :
	mkdir bin  
.PHONY: clean
clean :
	rm -rf src/*.o $(PROGRAMS)

