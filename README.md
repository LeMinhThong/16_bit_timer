# 16_bit_timer
- Using AMBA APB 3 protocol to communicate with the proccessor.
- 3 configuration register: timer control register, timer data register, timer status register.
- Overflow and underflow detector: only set by hardware, clear by software.
- Features:
  - Input clock prescale select bit: T*2, T*4, T*8, T*16.
  - Two operation modes: normal operation (count full 8 bits), count from timer data register.
  - Count up or down.
- Language: Verilog, SystemVerilog.
- Tools: QuestaSim, Vim.
