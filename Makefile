NASM := nasm -felf
# macOS
# NASM := nasm -fmacho

all : helloworld helloworld-len helloworld-inc helloworld-lf

helloworld : helloworld.o
	ld $^ -o $@
helloworld-len : helloworld-len.o
	ld $^ -o $@
helloworld-inc : helloworld-inc.o
	ld $^ -o $@
helloworld-lf : helloworld-lf.o
	ld $^ -o $@

%.o : %.asm
	$(NASM) $<
helloworld-inc.o helloworld-lf.o : funcs.asm
