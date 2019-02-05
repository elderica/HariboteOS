IMG = helloos.img
OBJ = helloos.o
LST = helloos.lst

KAWAI_IMG = helloos3.img

SRC = helloos.asm
LS  = linker.ld

$(IMG): $(SRC) $(LS)
	as --32 -a -o $(OBJ) $(SRC) > $(LST)
	ld -T $(LS) -o $(IMG) $(OBJ)

.PHONY: clean cmp disasm

clean:
	rm $(IMG) $(OBJ) $(LST)

cmp: $(IMG)
	cmp -l $(IMG) $(KAWAI_IMG)  | perl -ane 'printf("%08X %02X %02X\n", @F)'

disasm:
	objdump -D -Mintel,i8086 -b binary -m i386 $(IMG)
