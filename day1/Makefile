IMG := helloos.img
OBJ := helloos.o

SRC := helloos.asm
LS  := linker.ld

$(IMG): $(SRC) $(LS)
	as --32 -o $(OBJ) $(SRC)
	ld -T $(LS) -o $(IMG) $(OBJ)

clean:
	rm $(IMG) $(OBJ)