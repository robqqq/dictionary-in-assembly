NASM := nasm -f elf64 -o

main: main.o lib.o dict.o
	ld -o $@ $^

main.o: main.asm lib.o dict.o words.inc colon.inc
	$(NASM) $@ $<

dict.o: dict.asm lib.o
	$(NASM)  $@ $<

%.o: %.inc
	$(NASM)  $@ $<

clean:
	rm *.o