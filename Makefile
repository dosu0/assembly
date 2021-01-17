NASM := nasm -felf
NASMFLAGS := -Iinclude/
VPATH = src:include
# macOS
# NASM := nasm -fmacho
# LDFLAGS = -e _start -macos-min-version 10.7.0

PROGS = len inc ln args input
PROGRAMS = $(addprefix hello-, $(PROGS))
PROGRAMS += hello count
OBJECTS = $(addsuffix .o,$(PROGRAMS)) 

.PHONY: all
all : $(PROGRAMS)

% : src/%.o
	$(LD) $(LDFLAGS) $^ -o $@ 

%.o : %.asm
	$(NASM) -M $< > $<.dep
	$(NASM) $(NASMFLAGS) $^

.PHONY: clean
clean :
	rm -rf src/*.o $(PROGRAMS)

