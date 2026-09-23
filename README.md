# VortexSpark-Cortex

**Surprise stack:** Cortex-M3 Thumb assembly for **STM32F103** (Blue Pill).
No HAL, no CMSIS headers — vector table, SysTick, PC13 toggle (the onboard LED).

## Build
```bash
make    # arm-none-eabi-gcc
```

Flash `build/vortex.bin` at `0x08000000` with ST-Link / `st-flash write build/vortex.bin 0x08000000`.

Clock assumes 8 MHz HSI so SysTick ≈ 1 Hz blink. Adjust `SYST_RVR` if you enable PLL.
