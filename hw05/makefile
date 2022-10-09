# export PATH=$PATH:/usr/bin
# PATH := bin:$(PATH)
CC = arm-none-eabi-gcc
CFLAGS = -g
CFLAGS2 = -o
SRC != ls *.s
OBJ = ${SRC:.s=.o}
EXE = hw5.exe


all:
	$(CC) $(CFLAGS) $(SRC) $(CFLAGS2) $(EXE) 

# $(EXE):$(SRC)
# $(CC) $(CFLAGS) $(SRC) $(CFLAGS2) $(EXE)
clean:
	rm  -f $(EXE) 