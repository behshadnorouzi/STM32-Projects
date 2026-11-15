# 04 - LDR ADC

Reads a light-dependent resistor on ADC1 channel 0 ten times per second and
prints the raw 12-bit value (0-4095) over UART.

## Configuration

| Item   | Setting |
|--------|---------|
| Clock  | HSI 8 MHz, ADC clock 4 MHz (PCLK2 / 2) |
| ADC1   | Channel 0 (PA0), single conversion, sampling time 239.5 cycles |
| USART1 | 115200 8N1, TX = PA9, RX = PA10 |

The ADC is calibrated once at startup. The long sampling time (about 63 µs
per conversion in total) gives the sample capacitor enough time to charge
through the source impedance of the divider, which is several kΩ. The
minimum of 1.5 cycles is only specified for sources well below 1 kΩ (see
the R<sub>AIN</sub> table in the STM32F103 datasheet).

## Wiring

```
3.3V ---[ LDR ]---+--- PA0
                  |
               [ 10 kΩ ]
                  |
                 GND
```

PA9 goes to the RX pin of a USB-UART adapter, plus a common GND.

More light means lower LDR resistance, so the reading goes up.

## Output

```
LDR: 2310
LDR: 2304
LDR: 3655
...
```
