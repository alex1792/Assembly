# export PATH=$PATH:/usr/bin
# PATH := bin:$(PATH)
CC = arm-none-eabi-gcc_softlink
CFLAGS = -g
CFLAGS2 = -o
SRC != ls *.s
OBJ = ${SRC:.s=.o}
EXE = hw6.exe


all:
	sudo ln -s /opt/bin/arm-none-eabi-gcc arm-none-eabi-gcc_softlink
	./$(CC) $(CFLAGS) $(SRC) $(CFLAGS2) $(EXE) 

# $(EXE):$(SRC)
# $(CC) $(CFLAGS) $(SRC) $(CFLAGS2) $(EXE)
clean:
	rm  -f $(EXE) result.txt $(CC)