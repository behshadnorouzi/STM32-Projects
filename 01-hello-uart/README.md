# 01 - Hello UART

Prints `Hello World` once per second on USART1. The simplest check that the
toolchain, clock setup and UART wiring are all correct.

## Configuration

| Item   | Setting |
|--------|---------|
| Clock  | HSI 8 MHz |
| USART1 | 115200 8N1, single-wire (half-duplex) mode on PA9 |

## Wiring

| Blue Pill | USB-UART adapter |
|-----------|------------------|
| PA9       | RX               |
| GND       | GND              |

In single-wire mode PA9 is open-drain. Most adapters have a pull-up on RX;
if nothing shows up, add a 10 kΩ pull-up from PA9 to 3.3 V.

## Output

```
Hello World
Hello World
...
```
