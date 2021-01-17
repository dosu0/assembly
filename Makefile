NASM := nasm -felf
# macOS
# NASM := nasm -fmacho

PROGRAMS = helloworld helloworld-len helloworld-inc helloworld-lf \
 	helloworld-args

OBJECTS = $(addsuffix .o,$(PROGRAMS)) 

all : $(PROGRAMS)

% : %.o
	$(LD) $(LDFLAGS) $^ -o $@

%.o : %.asm
	$(NASM) -M $^
	$(NASM)	$^

.PHONY: clean
clean :
	rm -rf $(OBJECTS) $(PROGRAMS)
