# SPI master/slave RTL

An educational SPI interface project containing master and slave RTL, clock-generation and control blocks, and a top-level stimulus testbench.

## Design overview

The default top-level configuration uses 8-bit data and a 2-bit slave address, with four slave-side parallel-data interfaces. The design connects the master and slave blocks through serial clock, chip-select, MOSI and MISO signals.

## Repository map

| File | Purpose |
| --- | --- |
| `SPI_TOP.v` | Top-level integration and parallel-data interfaces |
| `SPI_MASTER.v` | Master-side logic |
| `SPI_SLAVE.v` | Slave-side logic |
| `SPI_CLK.v` | SPI clock-generation block |
| `SPI_COUNTER.v` | Counter block |
| `SPI_FSM.v` | Control state machine |
| `SPI_TB.v` | Stimulus for the default four-slave configuration |

## Verification status

The included testbench drives different slave addresses and input data. It is a stimulus example, not evidence of an automated passing regression or protocol compliance across all SPI modes.

No fresh simulation results, coverage measurements or hardware validation are supplied by this documentation. Exact SPI mode support should be established by a separate design review and simulation before reuse.
