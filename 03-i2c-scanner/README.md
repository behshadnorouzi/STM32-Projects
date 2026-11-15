# 03 - I2C Scanner

Probes every 7-bit address on I2C1 once after reset and prints the ones that
acknowledge. Useful for checking wiring and finding the address of an
unknown module.

## Configuration

| Item   | Setting |
|--------|---------|
| Clock  | HSI 8 MHz |
| I2C1   | 100 kHz standard mode, SCL = PB6, SDA = PB7 |
| USART1 | 115200 8N1, TX = PA9, RX = PA10 |

## Wiring

| Blue Pill | I2C device | USB-UART adapter |
|-----------|------------|------------------|
| PB6       | SCL        |                  |
| PB7       | SDA        |                  |
| PA9       |            | RX               |
| 3.3V      | VCC        |                  |
| GND       | GND        | GND              |

SDA and SCL need pull-ups (4.7 kΩ to 3.3 V). Most breakout boards already
have them; add them yourself if the scan finds nothing.

## Output

Example with an SSD1306 OLED and an MPU-6050 on the bus:

```
Scanning I2C bus...
  device at 0x3C
  device at 0x68
Done, 2 device(s) found
```

Press reset to scan again.
