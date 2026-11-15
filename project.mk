# Builds one STM32CubeIDE project from the command line.
# Compiler and linker flags mirror the CubeIDE "Debug" configuration.
#
#   make -f project.mk PROJECT=02-led-blink
#
# Normally called from the top-level Makefile.

ifndef PROJECT
$(error PROJECT is not set, e.g. make -f project.mk PROJECT=02-led-blink)
endif

PREFIX  ?= arm-none-eabi-
CC      := $(PREFIX)gcc
OBJCOPY := $(PREFIX)objcopy
SIZE    := $(PREFIX)size

BUILD   := build/$(PROJECT)
TARGET  := $(BUILD)/$(PROJECT)

C_SRCS   := $(wildcard $(PROJECT)/Core/Src/*.c) \
            $(wildcard $(PROJECT)/Drivers/STM32F1xx_HAL_Driver/Src/*.c)
ASM_SRCS := $(wildcard $(PROJECT)/Core/Startup/*.s)
LDSCRIPT := $(wildcard $(PROJECT)/*_FLASH.ld)

OBJS := $(C_SRCS:$(PROJECT)/%.c=$(BUILD)/%.o) \
        $(ASM_SRCS:$(PROJECT)/%.s=$(BUILD)/%.o)

CPU  := -mcpu=cortex-m3 -mthumb -mfloat-abi=soft
DEFS := -DDEBUG -DUSE_HAL_DRIVER -DSTM32F103xB
INCS := -I$(PROJECT)/Core/Inc \
        -I$(PROJECT)/Drivers/STM32F1xx_HAL_Driver/Inc \
        -I$(PROJECT)/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy \
        -I$(PROJECT)/Drivers/CMSIS/Device/ST/STM32F1xx/Include \
        -I$(PROJECT)/Drivers/CMSIS/Include

CFLAGS  := $(CPU) -std=gnu11 -O0 -g3 $(DEFS) $(INCS) \
           -ffunction-sections -fdata-sections -Wall --specs=nano.specs -MMD -MP
ASFLAGS := $(CPU) -g3 -DDEBUG -x assembler-with-cpp --specs=nano.specs -MMD -MP
LDFLAGS := $(CPU) -T$(LDSCRIPT) --specs=nosys.specs --specs=nano.specs \
           -Wl,-Map=$(TARGET).map -Wl,--gc-sections -static \
           -Wl,--start-group -lc -lm -Wl,--end-group

.PHONY: all
all: $(TARGET).elf $(TARGET).bin $(TARGET).hex

$(TARGET).elf: $(OBJS) $(LDSCRIPT)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)
	$(SIZE) $@

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

%.hex: %.elf
	$(OBJCOPY) -O ihex $< $@

$(BUILD)/%.o: $(PROJECT)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/%.o: $(PROJECT)/%.s
	@mkdir -p $(dir $@)
	$(CC) $(ASFLAGS) -c $< -o $@

-include $(OBJS:.o=.d)
