CC = gcc
CFLAGS1 = -o
CFLAGS2 = -msse4 -o
SRC1 = generate_data.c
SRC2 = hw07.c
SRC3 = hw07_SIMD.c
OBJ = ${SRC:.c=.o}
EXE1 = generate_data
EXE2 = hw07.exe
EXE3 = hw07_SIMD.exe

all:
	$(CC) $(CFLAGS1) $(EXE1) $(SRC1)
	$(CC) $(CFLAGS1) $(EXE2) $(SRC2)
	$(CC) $(CFLAGS2) $(EXE3) $(SRC3)
  
clean:
	rm  -f $(EXE1) $(EXE2) $(EXE3)