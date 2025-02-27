/* Copyright 2018 ETH Zurich and University of Bologna.
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the “License”); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 *
 * Description: Contains common system definitions.
 *
 */

package core_v_mini_mcu_pkg;

  import addr_map_rule_pkg::*;

  typedef enum logic {
    cv32e40p,
    cv32e20
  } cpu_type_e;

  localparam cpu_type_e CpuType = cv32e20;

  typedef enum logic {
    NtoM,
    onetoM
  } bus_type_e;

  localparam bus_type_e BusType = onetoM;

  //master idx
  localparam logic [31:0] CORE_INSTR_IDX = 0;
  localparam logic [31:0] CORE_DATA_IDX = 1;
  localparam logic [31:0] DEBUG_MASTER_IDX = 2;
  localparam logic [31:0] DMA_MASTER0_CH0_IDX = 3;
  localparam logic [31:0] DMA_MASTER1_CH0_IDX = 4;

  localparam SYSTEM_XBAR_NMASTER = 5;

  //slave mmap and idx
  //must be power of two
  localparam int unsigned MEM_SIZE = 32'h00010000;

  localparam SYSTEM_XBAR_NSLAVE = 8;

  localparam int unsigned LOG_SYSTEM_XBAR_NMASTER = SYSTEM_XBAR_NMASTER > 1 ? $clog2(SYSTEM_XBAR_NMASTER) : 32'd1;
  localparam int unsigned LOG_SYSTEM_XBAR_NSLAVE = SYSTEM_XBAR_NSLAVE > 1 ? $clog2(SYSTEM_XBAR_NSLAVE) : 32'd1;

  localparam int unsigned NUM_BANKS = 2;
  localparam int unsigned EXTERNAL_DOMAINS = 0;

  localparam logic[31:0] ERROR_START_ADDRESS = 32'hBADACCE5;
  localparam logic[31:0] ERROR_SIZE = 32'h00000001;
  localparam logic[31:0] ERROR_END_ADDRESS = ERROR_START_ADDRESS + ERROR_SIZE;
  localparam logic[31:0] ERROR_IDX = 32'd0;

  localparam logic [31:0] RAM0_START_ADDRESS = 32'h00000000;
  localparam logic [31:0] RAM0_SIZE = 32'h8000;
  localparam logic [31:0] RAM0_END_ADDRESS = RAM0_START_ADDRESS + RAM0_SIZE;
  localparam logic [31:0] RAM0_IDX = 32'd1;
  localparam logic [31:0] RAM1_START_ADDRESS = 32'h00008000;
  localparam logic [31:0] RAM1_SIZE = 32'h8000;
  localparam logic [31:0] RAM1_END_ADDRESS = RAM1_START_ADDRESS + RAM1_SIZE;
  localparam logic [31:0] RAM1_IDX = 32'd2;

  localparam logic[31:0] DEBUG_START_ADDRESS = 32'h10000000;
  localparam logic[31:0] DEBUG_SIZE = 32'h00100000;
  localparam logic[31:0] DEBUG_END_ADDRESS = DEBUG_START_ADDRESS + DEBUG_SIZE;
  localparam logic[31:0] DEBUG_IDX = 32'd3;

  localparam logic[31:0] AO_PERIPHERAL_START_ADDRESS = 32'h20000000;
  localparam logic[31:0] AO_PERIPHERAL_SIZE = 32'h00100000;
  localparam logic[31:0] AO_PERIPHERAL_END_ADDRESS = AO_PERIPHERAL_START_ADDRESS + AO_PERIPHERAL_SIZE;
  localparam logic[31:0] AO_PERIPHERAL_IDX = 32'd4;

  localparam logic[31:0] PERIPHERAL_START_ADDRESS = 32'h30000000;
  localparam logic[31:0] PERIPHERAL_SIZE = 32'h00100000;
  localparam logic[31:0] PERIPHERAL_END_ADDRESS = PERIPHERAL_START_ADDRESS + PERIPHERAL_SIZE;
  localparam logic[31:0] PERIPHERAL_IDX = 32'd5;

  localparam logic[31:0] EXT_SLAVE_START_ADDRESS = 32'hF0000000;
  localparam logic[31:0] EXT_SLAVE_SIZE = 32'h01000000;
  localparam logic[31:0] EXT_SLAVE_END_ADDRESS = EXT_SLAVE_START_ADDRESS + EXT_SLAVE_SIZE;
  localparam logic[31:0] EXT_SLAVE_IDX = 32'd6;

  localparam logic[31:0] FLASH_MEM_START_ADDRESS = 32'h40000000;
  localparam logic[31:0] FLASH_MEM_SIZE = 32'h01000000;
  localparam logic[31:0] FLASH_MEM_END_ADDRESS = FLASH_MEM_START_ADDRESS + FLASH_MEM_SIZE;
  localparam logic[31:0] FLASH_MEM_IDX = 32'd7;

  localparam addr_map_rule_t [SYSTEM_XBAR_NSLAVE-1:0] XBAR_ADDR_RULES = '{
      '{ idx: ERROR_IDX, start_addr: ERROR_START_ADDRESS, end_addr: ERROR_END_ADDRESS },
      '{ idx: RAM0_IDX, start_addr: RAM0_START_ADDRESS, end_addr: RAM0_END_ADDRESS },
      '{ idx: RAM1_IDX, start_addr: RAM1_START_ADDRESS, end_addr: RAM1_END_ADDRESS },
      '{ idx: DEBUG_IDX, start_addr: DEBUG_START_ADDRESS, end_addr: DEBUG_END_ADDRESS },
      '{ idx: AO_PERIPHERAL_IDX, start_addr: AO_PERIPHERAL_START_ADDRESS, end_addr: AO_PERIPHERAL_END_ADDRESS },
      '{ idx: PERIPHERAL_IDX, start_addr: PERIPHERAL_START_ADDRESS, end_addr: PERIPHERAL_END_ADDRESS },
      '{ idx: EXT_SLAVE_IDX, start_addr: EXT_SLAVE_START_ADDRESS, end_addr: EXT_SLAVE_END_ADDRESS },
      '{ idx: FLASH_MEM_IDX, start_addr: FLASH_MEM_START_ADDRESS, end_addr: FLASH_MEM_END_ADDRESS }
  };

  //always-on peripherals
  localparam AO_PERIPHERALS = 13;

  localparam logic[31:0] SOC_CTRL_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00000000;
  localparam logic[31:0] SOC_CTRL_SIZE = 32'h00010000;
  localparam logic[31:0] SOC_CTRL_END_ADDRESS = SOC_CTRL_START_ADDRESS + SOC_CTRL_SIZE;
  localparam logic[31:0] SOC_CTRL_IDX = 32'd0;

  localparam logic[31:0] BOOTROM_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00010000;
  localparam logic[31:0] BOOTROM_SIZE = 32'h00010000;
  localparam logic[31:0] BOOTROM_END_ADDRESS = BOOTROM_START_ADDRESS + BOOTROM_SIZE;
  localparam logic[31:0] BOOTROM_IDX = 32'd1;

  localparam logic[31:0] SPI_FLASH_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00020000;
  localparam logic[31:0] SPI_FLASH_SIZE = 32'h00008000;
  localparam logic[31:0] SPI_FLASH_END_ADDRESS = SPI_FLASH_START_ADDRESS + SPI_FLASH_SIZE;
  localparam logic[31:0] SPI_FLASH_IDX = 32'd2;

  localparam logic[31:0] SPI_MEMIO_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00028000;
  localparam logic[31:0] SPI_MEMIO_SIZE = 32'h00008000;
  localparam logic[31:0] SPI_MEMIO_END_ADDRESS = SPI_MEMIO_START_ADDRESS + SPI_MEMIO_SIZE;
  localparam logic[31:0] SPI_MEMIO_IDX = 32'd3;

  localparam logic[31:0] SPI_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00030000;
  localparam logic[31:0] SPI_SIZE = 32'h00010000;
  localparam logic[31:0] SPI_END_ADDRESS = SPI_START_ADDRESS + SPI_SIZE;
  localparam logic[31:0] SPI_IDX = 32'd4;

  localparam logic [31:0] POWER_MANAGER_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00040000;
  localparam logic [31:0] POWER_MANAGER_SIZE = 32'h00010000;
  localparam logic [31:0] POWER_MANAGER_END_ADDRESS = POWER_MANAGER_START_ADDRESS + POWER_MANAGER_SIZE;
  localparam logic [31:0] POWER_MANAGER_IDX = 32'd5;

  localparam logic [31:0] RV_TIMER_AO_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00050000;
  localparam logic [31:0] RV_TIMER_AO_SIZE = 32'h00010000;
  localparam logic [31:0] RV_TIMER_AO_END_ADDRESS = RV_TIMER_AO_START_ADDRESS + RV_TIMER_AO_SIZE;
  localparam logic [31:0] RV_TIMER_AO_IDX = 32'd6;

  localparam logic [31:0] DMA_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00060000;
  localparam logic [31:0] DMA_SIZE = 32'h00010000;
  localparam logic [31:0] DMA_END_ADDRESS = DMA_START_ADDRESS + DMA_SIZE;
  localparam logic [31:0] DMA_IDX = 32'd7;

  localparam logic[31:0] FAST_INTR_CTRL_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00070000;
  localparam logic[31:0] FAST_INTR_CTRL_SIZE = 32'h00010000;
  localparam logic[31:0] FAST_INTR_CTRL_END_ADDRESS = FAST_INTR_CTRL_START_ADDRESS + FAST_INTR_CTRL_SIZE;
  localparam logic[31:0] FAST_INTR_CTRL_IDX = 32'd8;

  localparam logic[31:0] EXT_PERIPH_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00080000;
  localparam logic[31:0] EXT_PERIPH_SIZE = 32'h00010000;
  localparam logic[31:0] EXT_PERIPH_END_ADDRESS = EXT_PERIPH_START_ADDRESS + EXT_PERIPH_SIZE;
  localparam logic[31:0] EXT_PERIPH_IDX = 32'd9;

  localparam logic[31:0] PAD_CONTROL_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00090000;
  localparam logic[31:0] PAD_CONTROL_SIZE = 32'h00010000;
  localparam logic[31:0] PAD_CONTROL_END_ADDRESS = PAD_CONTROL_START_ADDRESS + PAD_CONTROL_SIZE;
  localparam logic[31:0] PAD_CONTROL_IDX = 32'd10;

  localparam logic[31:0] GPIO_AO_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h000A0000;
  localparam logic[31:0] GPIO_AO_SIZE = 32'h00010000;
  localparam logic[31:0] GPIO_AO_END_ADDRESS = GPIO_AO_START_ADDRESS + GPIO_AO_SIZE;
  localparam logic[31:0] GPIO_AO_IDX = 32'd11;

  localparam logic[31:0] UART_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h000B0000;
  localparam logic[31:0] UART_SIZE = 32'h00010000;
  localparam logic[31:0] UART_END_ADDRESS = UART_START_ADDRESS + UART_SIZE;
  localparam logic[31:0] UART_IDX = 32'd12;

  localparam addr_map_rule_t [AO_PERIPHERALS-1:0] AO_PERIPHERALS_ADDR_RULES = '{
      '{ idx: SOC_CTRL_IDX, start_addr: SOC_CTRL_START_ADDRESS, end_addr: SOC_CTRL_END_ADDRESS },
      '{ idx: BOOTROM_IDX, start_addr: BOOTROM_START_ADDRESS, end_addr: BOOTROM_END_ADDRESS },
      '{ idx: SPI_FLASH_IDX, start_addr: SPI_FLASH_START_ADDRESS, end_addr: SPI_FLASH_END_ADDRESS },
      '{ idx: SPI_MEMIO_IDX, start_addr: SPI_MEMIO_START_ADDRESS, end_addr: SPI_MEMIO_END_ADDRESS },
      '{ idx: SPI_IDX, start_addr: SPI_START_ADDRESS, end_addr: SPI_END_ADDRESS },
      '{ idx: POWER_MANAGER_IDX, start_addr: POWER_MANAGER_START_ADDRESS, end_addr: POWER_MANAGER_END_ADDRESS },
      '{ idx: RV_TIMER_AO_IDX, start_addr: RV_TIMER_AO_START_ADDRESS, end_addr: RV_TIMER_AO_END_ADDRESS },
      '{ idx: DMA_IDX, start_addr: DMA_START_ADDRESS, end_addr: DMA_END_ADDRESS },
      '{ idx: FAST_INTR_CTRL_IDX, start_addr: FAST_INTR_CTRL_START_ADDRESS, end_addr: FAST_INTR_CTRL_END_ADDRESS },
      '{ idx: EXT_PERIPH_IDX, start_addr: EXT_PERIPH_START_ADDRESS, end_addr: EXT_PERIPH_END_ADDRESS },
      '{ idx: PAD_CONTROL_IDX, start_addr: PAD_CONTROL_START_ADDRESS, end_addr: PAD_CONTROL_END_ADDRESS },
      '{ idx: GPIO_AO_IDX, start_addr: GPIO_AO_START_ADDRESS, end_addr: GPIO_AO_END_ADDRESS },
      '{ idx: UART_IDX, start_addr: UART_START_ADDRESS, end_addr: UART_END_ADDRESS }
  };

  localparam int unsigned AO_PERIPHERALS_PORT_SEL_WIDTH = AO_PERIPHERALS > 1 ? $clog2(AO_PERIPHERALS) : 32'd1;

  //switch-on/off peripherals
  localparam PERIPHERALS = 4;

  localparam logic[31:0] PLIC_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00000000;
  localparam logic[31:0] PLIC_SIZE = 32'h00010000;
  localparam logic[31:0] PLIC_END_ADDRESS = PLIC_START_ADDRESS + PLIC_SIZE;
  localparam logic[31:0] PLIC_IDX = 32'd0;

  localparam logic[31:0] GPIO_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00020000;
  localparam logic[31:0] GPIO_SIZE = 32'h00010000;
  localparam logic[31:0] GPIO_END_ADDRESS = GPIO_START_ADDRESS + GPIO_SIZE;
  localparam logic[31:0] GPIO_IDX = 32'd1;

  localparam logic[31:0] I2C_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00030000;
  localparam logic[31:0] I2C_SIZE = 32'h00010000;
  localparam logic[31:0] I2C_END_ADDRESS = I2C_START_ADDRESS + I2C_SIZE;
  localparam logic[31:0] I2C_IDX = 32'd2;

  localparam logic [31:0] RV_TIMER_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00040000;
  localparam logic [31:0] RV_TIMER_SIZE = 32'h00010000;
  localparam logic [31:0] RV_TIMER_END_ADDRESS = RV_TIMER_START_ADDRESS + RV_TIMER_SIZE;
  localparam logic [31:0] RV_TIMER_IDX = 32'd3;

  localparam addr_map_rule_t [PERIPHERALS-1:0] PERIPHERALS_ADDR_RULES = '{
      '{ idx: PLIC_IDX, start_addr: PLIC_START_ADDRESS, end_addr: PLIC_END_ADDRESS },
      '{ idx: GPIO_IDX, start_addr: GPIO_START_ADDRESS, end_addr: GPIO_END_ADDRESS },
      '{ idx: I2C_IDX, start_addr: I2C_START_ADDRESS, end_addr: I2C_END_ADDRESS },
      '{ idx: RV_TIMER_IDX, start_addr: RV_TIMER_START_ADDRESS, end_addr: RV_TIMER_END_ADDRESS }
  };

  localparam int unsigned PERIPHERALS_PORT_SEL_WIDTH = PERIPHERALS > 1 ? $clog2(PERIPHERALS) : 32'd1;

  // Interrupts
  localparam PLIC_NINT = 64;
  localparam PLIC_USED_NINT = 49;
  localparam NEXT_INT = PLIC_NINT - PLIC_USED_NINT;

  localparam PAD_CLK = 0;
  localparam PAD_RST = 1;
  localparam PAD_BOOT_SELECT = 2;
  localparam PAD_EXECUTE_FROM_FLASH = 3;
  localparam PAD_JTAG_TCK = 4;
  localparam PAD_JTAG_TMS = 5;
  localparam PAD_JTAG_TRST = 6;
  localparam PAD_JTAG_TDI = 7;
  localparam PAD_JTAG_TDO = 8;
  localparam PAD_UART_RX = 9;
  localparam PAD_UART_TX = 10;
  localparam PAD_EXIT_VALID = 11;
  localparam PAD_GPIO_0 = 12;
  localparam PAD_GPIO_1 = 13;
  localparam PAD_GPIO_2 = 14;
  localparam PAD_GPIO_3 = 15;
  localparam PAD_GPIO_4 = 16;
  localparam PAD_GPIO_5 = 17;
  localparam PAD_GPIO_6 = 18;
  localparam PAD_GPIO_7 = 19;
  localparam PAD_GPIO_8 = 20;
  localparam PAD_GPIO_9 = 21;
  localparam PAD_GPIO_10 = 22;
  localparam PAD_GPIO_11 = 23;
  localparam PAD_GPIO_12 = 24;
  localparam PAD_GPIO_13 = 25;
  localparam PAD_GPIO_14 = 26;
  localparam PAD_GPIO_15 = 27;
  localparam PAD_GPIO_16 = 28;
  localparam PAD_GPIO_17 = 29;
  localparam PAD_GPIO_18 = 30;
  localparam PAD_GPIO_19 = 31;
  localparam PAD_GPIO_20 = 32;
  localparam PAD_GPIO_21 = 33;
  localparam PAD_GPIO_22 = 34;
  localparam PAD_GPIO_23 = 35;
  localparam PAD_GPIO_24 = 36;
  localparam PAD_GPIO_25 = 37;
  localparam PAD_GPIO_26 = 38;
  localparam PAD_GPIO_27 = 39;
  localparam PAD_GPIO_28 = 40;
  localparam PAD_GPIO_29 = 41;
  localparam PAD_SPI_FLASH_SCK = 42;
  localparam PAD_SPI_FLASH_CS_0 = 43;
  localparam PAD_SPI_FLASH_CS_1 = 44;
  localparam PAD_SPI_FLASH_SD_0 = 45;
  localparam PAD_SPI_FLASH_SD_1 = 46;
  localparam PAD_SPI_FLASH_SD_2 = 47;
  localparam PAD_SPI_FLASH_SD_3 = 48;
  localparam PAD_SPI_SCK = 49;
  localparam PAD_SPI_CS_0 = 50;
  localparam PAD_SPI_CS_1 = 51;
  localparam PAD_SPI_SD_0 = 52;
  localparam PAD_SPI_SD_1 = 53;
  localparam PAD_SPI_SD_2 = 54;
  localparam PAD_SPI_SD_3 = 55;
  localparam PAD_I2C_SCL = 56;
  localparam PAD_I2C_SDA = 57;

  localparam NUM_PAD = 58;
  localparam NUM_PAD_MUXED = 2;

  localparam int unsigned NUM_PAD_PORT_SEL_WIDTH = NUM_PAD > 1 ? $clog2(NUM_PAD) : 32'd1;


endpackage
