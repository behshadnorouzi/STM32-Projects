# 02 - LED Blink

Blinks the on-board LED on PC13, one second on and one second off. Unlike the
other projects, this one runs from the external 8 MHz crystal through the
PLL, so it also confirms the HSE oscillator works.

## Configuration

| Item  | Setting |
|-------|---------|
| Clock | HSE 8 MHz x 9 (PLL) = 72 MHz SYSCLK |
| PC13  | Push-pull output, label `LED Blink` |

The Blue Pill LED is connected between 3.3 V and PC13, so it is **active
low**: writing `GPIO_PIN_RESET` turns it on.

No external wiring is needed.
