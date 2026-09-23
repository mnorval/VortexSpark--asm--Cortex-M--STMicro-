CC      = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
SRC     = src/startup.s
ELF     = build/vortex.elf
BIN     = build/vortex.bin

CFLAGS  = -mcpu=cortex-m3 -mthumb -nostdlib -T linker.ld -Wl,-Map=build/vortex.map

all: $(BIN)

$(ELF): $(SRC) linker.ld
	mkdir -p build
	$(CC) $(CFLAGS) -o $(ELF) $(SRC)

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $(ELF) $(BIN)

clean:
	rm -rf build
.PHONY: all clean
