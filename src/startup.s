@ VortexSpark-Cortex
@ STM32F103 (Cortex-M3) Thumb — blink PC13 + SysTick
@ arm-none-eabi-as -mcpu=cortex-m3 -mthumb

    .syntax unified
    .cpu cortex-m3
    .thumb

    .section .isr_vector, "a"
    .word _estack
    .word reset + 1
    .word hang + 1          @ NMI
    .word hang + 1          @ HardFault
    .rept 11
    .word hang + 1
    .endr
    .word systick + 1       @ SysTick @ 15

    .section .text
    .thumb_func
reset:
    ldr r0, =0x40021018     @ RCC_APB2ENR
    ldr r1, [r0]
    orr r1, r1, #(1 << 4)   @ IOPCEN
    str r1, [r0]

    ldr r0, =0x40011004     @ GPIOC_CRH
    ldr r1, [r0]
    bic r1, r1, #(0xF << 20)
    orr r1, r1, #(0x2 << 20) @ PC13 push-pull 2 MHz
    str r1, [r0]

    ldr r0, =0xE000E014     @ SYST_RVR
    ldr r1, =8000000        @ ~1 Hz if 8 MHz HSI
    str r1, [r0]
    ldr r0, =0xE000E010     @ SYST_CSR
    mov r1, #7              @ enable + tickint + clksource
    str r1, [r0]

idle:
    wfi
    b idle

    .thumb_func
systick:
    ldr r0, =0x4001100C     @ GPIOC_ODR
    ldr r1, [r0]
    eor r1, r1, #(1 << 13)
    str r1, [r0]
    bx lr

    .thumb_func
hang:
    b hang

    .section .stack
    .word 0
    .global _estack
    .equ _estack, 0x20005000
