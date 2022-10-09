# export PATH=$PATH:/usr/bin
# PATH := bin:$(PATH)
CC = arm-none-eabi-gcc_softlink 
CFLAGS = -g
CFLAGS2 = -o
SRC != ls *.s
OBJ = ${SRC:.s=.o}
EXE = hw4.exe


all:
	sudo ln -s arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc_softlink && $(CC) $(CFLAGS) $(SRC) $(CFLAGS2) $(EXE) 

# $(EXE):$(SRC)
# $(CC) $(CFLAGS) $(SRC) $(CFLAGS2) $(EXE)
clean:
	rm  -f $(EXE) 