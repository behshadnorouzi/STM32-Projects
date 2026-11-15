# STM32F103 Projects

[![Build](https://github.com/behshadnorouzi/STM32-Projects/actions/workflows/build.yml/badge.svg)](https://github.com/behshadnorouzi/STM32-Projects/actions/workflows/build.yml)

Small, self-contained STM32CubeIDE projects for the STM32F103C8T6 ("Blue
Pill"), using the STM32 HAL. Each project brings up one peripheral and
prints its result over UART, so they double as quick bring-up checks for
new boards.

| # | Project | Peripherals | What it shows |
|---|---------|-------------|---------------|
| 01 | [hello-uart](01-hello-uart) | USART1 (TX only) | Clock and UART bring-up, prints `Hello World` every second |
| 02 | [led-blink](02-led-blink) | GPIO, HSE + PLL | 72 MHz clock from the external crystal, blinks the PC13 LED |
| 03 | [i2c-scanner](03-i2c-scanner) | I2C1, USART1 | Probes all 7-bit addresses and lists the devices that ACK |
| 04 | [ldr-adc](04-ldr-adc) | ADC1, USART1 | Calibrated 12-bit ADC reading of a light sensor, 10 samples/s |

## Hardware

- STM32F103C8T6 board (Blue Pill)
- ST-LINK V2 (SWD: SWDIO, SWCLK, GND, 3.3V)
- USB-to-UART adapter at 3.3 V logic for the serial output

UART settings for every project: **115200 baud, 8N1**, board TX on **PA9**.

## Building

### STM32CubeIDE

*File → Import → General → Existing Projects into Workspace*, select the
repository folder and tick the projects you need. Build and flash with the
`Debug` launch configuration included in each project.

### Command line

With the [Arm GNU toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
and `make` on your PATH:

```sh
make                  # all projects
make 03-i2c-scanner   # one project
```

Output goes to `build/<project>/` as `.elf`, `.bin` and `.hex`. The flags
match the CubeIDE Debug configuration. Flash with STM32CubeProgrammer or
OpenOCD, for example:

```sh
openocd -f interface/stlink.cfg -f target/stm32f1x.cfg \
        -c "program build/02-led-blink/02-led-blink.elf verify reset exit"
```

CI builds every project on each push.

## Project layout

Each folder is a complete CubeIDE project generated from its `.ioc` file.
Application code is kept inside the `USER CODE BEGIN/END` blocks, so the
projects can be regenerated in CubeMX without losing changes.

```
NN-name/
  Core/Inc, Core/Src     application and CubeMX-generated init code
  Core/Startup           startup assembly
  Drivers/               STM32F1 HAL and CMSIS (copied by CubeMX)
  *.ioc                  CubeMX configuration
  STM32F103C8TX_FLASH.ld linker script
```

## License

Application code is released under the [MIT License](LICENSE). The HAL and
CMSIS files under each `Drivers/` folder are provided by STMicroelectronics
and ARM under the license files included next to them.
