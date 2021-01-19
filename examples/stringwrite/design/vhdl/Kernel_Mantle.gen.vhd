-- Copyright 2018-2019 Delft University of Technology
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- This file was generated by Fletchgen. Modify this file at your own risk.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.Interconnect_pkg.all;

entity Kernel_Mantle is
  generic (
    INDEX_WIDTH        : integer := 32;
    TAG_WIDTH          : integer := 1;
    BUS_ADDR_WIDTH     : integer := 64;
    BUS_DATA_WIDTH     : integer := 512;
    BUS_LEN_WIDTH      : integer := 8;
    BUS_BURST_STEP_LEN : integer := 1;
    BUS_BURST_MAX_LEN  : integer := 16
  );
  port (
    bcd_clk            : in  std_logic;
    bcd_reset          : in  std_logic;
    kcd_clk            : in  std_logic;
    kcd_reset          : in  std_logic;
    mmio_awvalid       : in  std_logic;
    mmio_awready       : out std_logic;
    mmio_awaddr        : in  std_logic_vector(31 downto 0);
    mmio_wvalid        : in  std_logic;
    mmio_wready        : out std_logic;
    mmio_wdata         : in  std_logic_vector(31 downto 0);
    mmio_wstrb         : in  std_logic_vector(3 downto 0);
    mmio_bvalid        : out std_logic;
    mmio_bready        : in  std_logic;
    mmio_bresp         : out std_logic_vector(1 downto 0);
    mmio_arvalid       : in  std_logic;
    mmio_arready       : out std_logic;
    mmio_araddr        : in  std_logic_vector(31 downto 0);
    mmio_rvalid        : out std_logic;
    mmio_rready        : in  std_logic;
    mmio_rdata         : out std_logic_vector(31 downto 0);
    mmio_rresp         : out std_logic_vector(1 downto 0);
    wr_mst_wreq_valid  : out std_logic;
    wr_mst_wreq_ready  : in  std_logic;
    wr_mst_wreq_addr   : out std_logic_vector(BUS_ADDR_WIDTH-1 downto 0);
    wr_mst_wreq_len    : out std_logic_vector(BUS_LEN_WIDTH-1 downto 0);
    wr_mst_wdat_valid  : out std_logic;
    wr_mst_wdat_ready  : in  std_logic;
    wr_mst_wdat_data   : out std_logic_vector(BUS_DATA_WIDTH-1 downto 0);
    wr_mst_wdat_strobe : out std_logic_vector(BUS_DATA_WIDTH/8-1 downto 0);
    wr_mst_wdat_last   : out std_logic
  );
end entity;

architecture Implementation of Kernel_Mantle is
  component Kernel_Nucleus is
    generic (
      INDEX_WIDTH                       : integer := 32;
      TAG_WIDTH                         : integer := 1;
      STRINGWRITE_STRING_BUS_ADDR_WIDTH : integer := 64
    );
    port (
      kcd_clk                         : in  std_logic;
      kcd_reset                       : in  std_logic;
      mmio_awvalid                    : in  std_logic;
      mmio_awready                    : out std_logic;
      mmio_awaddr                     : in  std_logic_vector(31 downto 0);
      mmio_wvalid                     : in  std_logic;
      mmio_wready                     : out std_logic;
      mmio_wdata                      : in  std_logic_vector(31 downto 0);
      mmio_wstrb                      : in  std_logic_vector(3 downto 0);
      mmio_bvalid                     : out std_logic;
      mmio_bready                     : in  std_logic;
      mmio_bresp                      : out std_logic_vector(1 downto 0);
      mmio_arvalid                    : in  std_logic;
      mmio_arready                    : out std_logic;
      mmio_araddr                     : in  std_logic_vector(31 downto 0);
      mmio_rvalid                     : out std_logic;
      mmio_rready                     : in  std_logic;
      mmio_rdata                      : out std_logic_vector(31 downto 0);
      mmio_rresp                      : out std_logic_vector(1 downto 0);
      StringWrite_String_valid        : out std_logic;
      StringWrite_String_ready        : in  std_logic;
      StringWrite_String_dvalid       : out std_logic;
      StringWrite_String_last         : out std_logic;
      StringWrite_String_length       : out std_logic_vector(31 downto 0);
      StringWrite_String_count        : out std_logic_vector(0 downto 0);
      StringWrite_String_chars_valid  : out std_logic;
      StringWrite_String_chars_ready  : in  std_logic;
      StringWrite_String_chars_dvalid : out std_logic;
      StringWrite_String_chars_last   : out std_logic;
      StringWrite_String_chars        : out std_logic_vector(511 downto 0);
      StringWrite_String_chars_count  : out std_logic_vector(6 downto 0);
      StringWrite_String_unl_valid    : in  std_logic;
      StringWrite_String_unl_ready    : out std_logic;
      StringWrite_String_unl_tag      : in  std_logic_vector(TAG_WIDTH-1 downto 0);
      StringWrite_String_cmd_valid    : out std_logic;
      StringWrite_String_cmd_ready    : in  std_logic;
      StringWrite_String_cmd_firstIdx : out std_logic_vector(INDEX_WIDTH-1 downto 0);
      StringWrite_String_cmd_lastIdx  : out std_logic_vector(INDEX_WIDTH-1 downto 0);
      StringWrite_String_cmd_ctrl     : out std_logic_vector(STRINGWRITE_STRING_BUS_ADDR_WIDTH*2-1 downto 0);
      StringWrite_String_cmd_tag      : out std_logic_vector(TAG_WIDTH-1 downto 0)
    );
  end component;

  component Kernel_StringWrite is
    generic (
      INDEX_WIDTH                           : integer := 32;
      TAG_WIDTH                             : integer := 1;
      STRINGWRITE_STRING_BUS_ADDR_WIDTH     : integer := 64;
      STRINGWRITE_STRING_BUS_DATA_WIDTH     : integer := 512;
      STRINGWRITE_STRING_BUS_LEN_WIDTH      : integer := 8;
      STRINGWRITE_STRING_BUS_BURST_STEP_LEN : integer := 1;
      STRINGWRITE_STRING_BUS_BURST_MAX_LEN  : integer := 16
    );
    port (
      bcd_clk                            : in  std_logic;
      bcd_reset                          : in  std_logic;
      kcd_clk                            : in  std_logic;
      kcd_reset                          : in  std_logic;
      StringWrite_String_valid           : in  std_logic;
      StringWrite_String_ready           : out std_logic;
      StringWrite_String_dvalid          : in  std_logic;
      StringWrite_String_last            : in  std_logic;
      StringWrite_String_length          : in  std_logic_vector(31 downto 0);
      StringWrite_String_count           : in  std_logic_vector(0 downto 0);
      StringWrite_String_chars_valid     : in  std_logic;
      StringWrite_String_chars_ready     : out std_logic;
      StringWrite_String_chars_dvalid    : in  std_logic;
      StringWrite_String_chars_last      : in  std_logic;
      StringWrite_String_chars           : in  std_logic_vector(511 downto 0);
      StringWrite_String_chars_count     : in  std_logic_vector(6 downto 0);
      StringWrite_String_bus_wreq_valid  : out std_logic;
      StringWrite_String_bus_wreq_ready  : in  std_logic;
      StringWrite_String_bus_wreq_addr   : out std_logic_vector(STRINGWRITE_STRING_BUS_ADDR_WIDTH-1 downto 0);
      StringWrite_String_bus_wreq_len    : out std_logic_vector(STRINGWRITE_STRING_BUS_LEN_WIDTH-1 downto 0);
      StringWrite_String_bus_wdat_valid  : out std_logic;
      StringWrite_String_bus_wdat_ready  : in  std_logic;
      StringWrite_String_bus_wdat_data   : out std_logic_vector(STRINGWRITE_STRING_BUS_DATA_WIDTH-1 downto 0);
      StringWrite_String_bus_wdat_strobe : out std_logic_vector(STRINGWRITE_STRING_BUS_DATA_WIDTH/8-1 downto 0);
      StringWrite_String_bus_wdat_last   : out std_logic;
      StringWrite_String_cmd_valid       : in  std_logic;
      StringWrite_String_cmd_ready       : out std_logic;
      StringWrite_String_cmd_firstIdx    : in  std_logic_vector(INDEX_WIDTH-1 downto 0);
      StringWrite_String_cmd_lastIdx     : in  std_logic_vector(INDEX_WIDTH-1 downto 0);
      StringWrite_String_cmd_ctrl        : in  std_logic_vector(STRINGWRITE_STRING_BUS_ADDR_WIDTH*2-1 downto 0);
      StringWrite_String_cmd_tag         : in  std_logic_vector(TAG_WIDTH-1 downto 0);
      StringWrite_String_unl_valid       : out std_logic;
      StringWrite_String_unl_ready       : in  std_logic;
      StringWrite_String_unl_tag         : out std_logic_vector(TAG_WIDTH-1 downto 0)
    );
  end component;

  signal Kernel_Nucleus_inst_kcd_clk                                : std_logic;
  signal Kernel_Nucleus_inst_kcd_reset                              : std_logic;

  signal Kernel_Nucleus_inst_mmio_awvalid                           : std_logic;
  signal Kernel_Nucleus_inst_mmio_awready                           : std_logic;
  signal Kernel_Nucleus_inst_mmio_awaddr                            : std_logic_vector(31 downto 0);
  signal Kernel_Nucleus_inst_mmio_wvalid                            : std_logic;
  signal Kernel_Nucleus_inst_mmio_wready                            : std_logic;
  signal Kernel_Nucleus_inst_mmio_wdata                             : std_logic_vector(31 downto 0);
  signal Kernel_Nucleus_inst_mmio_wstrb                             : std_logic_vector(3 downto 0);
  signal Kernel_Nucleus_inst_mmio_bvalid                            : std_logic;
  signal Kernel_Nucleus_inst_mmio_bready                            : std_logic;
  signal Kernel_Nucleus_inst_mmio_bresp                             : std_logic_vector(1 downto 0);
  signal Kernel_Nucleus_inst_mmio_arvalid                           : std_logic;
  signal Kernel_Nucleus_inst_mmio_arready                           : std_logic;
  signal Kernel_Nucleus_inst_mmio_araddr                            : std_logic_vector(31 downto 0);
  signal Kernel_Nucleus_inst_mmio_rvalid                            : std_logic;
  signal Kernel_Nucleus_inst_mmio_rready                            : std_logic;
  signal Kernel_Nucleus_inst_mmio_rdata                             : std_logic_vector(31 downto 0);
  signal Kernel_Nucleus_inst_mmio_rresp                             : std_logic_vector(1 downto 0);

  signal Kernel_Nucleus_inst_StringWrite_String_valid               : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_ready               : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_dvalid              : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_last                : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_length              : std_logic_vector(31 downto 0);
  signal Kernel_Nucleus_inst_StringWrite_String_count               : std_logic_vector(0 downto 0);
  signal Kernel_Nucleus_inst_StringWrite_String_chars_valid         : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_chars_ready         : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_chars_dvalid        : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_chars_last          : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_chars               : std_logic_vector(511 downto 0);
  signal Kernel_Nucleus_inst_StringWrite_String_chars_count         : std_logic_vector(6 downto 0);

  signal Kernel_Nucleus_inst_StringWrite_String_unl_valid           : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_unl_ready           : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_unl_tag             : std_logic_vector(TAG_WIDTH-1 downto 0);

  signal Kernel_Nucleus_inst_StringWrite_String_cmd_valid           : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_cmd_ready           : std_logic;
  signal Kernel_Nucleus_inst_StringWrite_String_cmd_firstIdx        : std_logic_vector(INDEX_WIDTH-1 downto 0);
  signal Kernel_Nucleus_inst_StringWrite_String_cmd_lastIdx         : std_logic_vector(INDEX_WIDTH-1 downto 0);
  signal Kernel_Nucleus_inst_StringWrite_String_cmd_ctrl            : std_logic_vector(BUS_ADDR_WIDTH*2-1 downto 0);
  signal Kernel_Nucleus_inst_StringWrite_String_cmd_tag             : std_logic_vector(TAG_WIDTH-1 downto 0);

  signal Kernel_StringWrite_inst_bcd_clk                            : std_logic;
  signal Kernel_StringWrite_inst_bcd_reset                          : std_logic;

  signal Kernel_StringWrite_inst_kcd_clk                            : std_logic;
  signal Kernel_StringWrite_inst_kcd_reset                          : std_logic;

  signal Kernel_StringWrite_inst_StringWrite_String_valid           : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_ready           : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_dvalid          : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_last            : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_length          : std_logic_vector(31 downto 0);
  signal Kernel_StringWrite_inst_StringWrite_String_count           : std_logic_vector(0 downto 0);
  signal Kernel_StringWrite_inst_StringWrite_String_chars_valid     : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_chars_ready     : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_chars_dvalid    : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_chars_last      : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_chars           : std_logic_vector(511 downto 0);
  signal Kernel_StringWrite_inst_StringWrite_String_chars_count     : std_logic_vector(6 downto 0);

  signal Kernel_StringWrite_inst_StringWrite_String_bus_wreq_valid  : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_bus_wreq_ready  : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_bus_wreq_addr   : std_logic_vector(BUS_ADDR_WIDTH-1 downto 0);
  signal Kernel_StringWrite_inst_StringWrite_String_bus_wreq_len    : std_logic_vector(BUS_LEN_WIDTH-1 downto 0);
  signal Kernel_StringWrite_inst_StringWrite_String_bus_wdat_valid  : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_bus_wdat_ready  : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_bus_wdat_data   : std_logic_vector(BUS_DATA_WIDTH-1 downto 0);
  signal Kernel_StringWrite_inst_StringWrite_String_bus_wdat_strobe : std_logic_vector(BUS_DATA_WIDTH/8-1 downto 0);
  signal Kernel_StringWrite_inst_StringWrite_String_bus_wdat_last   : std_logic;

  signal Kernel_StringWrite_inst_StringWrite_String_cmd_valid       : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_cmd_ready       : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_cmd_firstIdx    : std_logic_vector(INDEX_WIDTH-1 downto 0);
  signal Kernel_StringWrite_inst_StringWrite_String_cmd_lastIdx     : std_logic_vector(INDEX_WIDTH-1 downto 0);
  signal Kernel_StringWrite_inst_StringWrite_String_cmd_ctrl        : std_logic_vector(BUS_ADDR_WIDTH*2-1 downto 0);
  signal Kernel_StringWrite_inst_StringWrite_String_cmd_tag         : std_logic_vector(TAG_WIDTH-1 downto 0);

  signal Kernel_StringWrite_inst_StringWrite_String_unl_valid       : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_unl_ready       : std_logic;
  signal Kernel_StringWrite_inst_StringWrite_String_unl_tag         : std_logic_vector(TAG_WIDTH-1 downto 0);

  signal WRAW64DW512LW8BS1BM16_inst_bcd_clk                         : std_logic;
  signal WRAW64DW512LW8BS1BM16_inst_bcd_reset                       : std_logic;

  signal WRAW64DW512LW8BS1BM16_inst_mst_wreq_valid                  : std_logic;
  signal WRAW64DW512LW8BS1BM16_inst_mst_wreq_ready                  : std_logic;
  signal WRAW64DW512LW8BS1BM16_inst_mst_wreq_addr                   : std_logic_vector(BUS_ADDR_WIDTH-1 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_mst_wreq_len                    : std_logic_vector(BUS_LEN_WIDTH-1 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_mst_wdat_valid                  : std_logic;
  signal WRAW64DW512LW8BS1BM16_inst_mst_wdat_ready                  : std_logic;
  signal WRAW64DW512LW8BS1BM16_inst_mst_wdat_data                   : std_logic_vector(BUS_DATA_WIDTH-1 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_mst_wdat_strobe                 : std_logic_vector(BUS_DATA_WIDTH/8-1 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_mst_wdat_last                   : std_logic;

  signal WRAW64DW512LW8BS1BM16_inst_bsv_wreq_valid  : std_logic_vector(0 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_bsv_wreq_ready  : std_logic_vector(0 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_bsv_wreq_addr   : std_logic_vector(BUS_ADDR_WIDTH-1 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_bsv_wreq_len    : std_logic_vector(BUS_LEN_WIDTH-1 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_bsv_wdat_valid  : std_logic_vector(0 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_bsv_wdat_ready  : std_logic_vector(0 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_bsv_wdat_data   : std_logic_vector(BUS_DATA_WIDTH-1 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_bsv_wdat_strobe : std_logic_vector(BUS_DATA_WIDTH/8-1 downto 0);
  signal WRAW64DW512LW8BS1BM16_inst_bsv_wdat_last   : std_logic_vector(0 downto 0);

begin
  Kernel_Nucleus_inst : Kernel_Nucleus
    generic map (
      INDEX_WIDTH                       => INDEX_WIDTH,
      TAG_WIDTH                         => TAG_WIDTH,
      STRINGWRITE_STRING_BUS_ADDR_WIDTH => BUS_ADDR_WIDTH
    )
    port map (
      kcd_clk                         => Kernel_Nucleus_inst_kcd_clk,
      kcd_reset                       => Kernel_Nucleus_inst_kcd_reset,
      mmio_awvalid                    => Kernel_Nucleus_inst_mmio_awvalid,
      mmio_awready                    => Kernel_Nucleus_inst_mmio_awready,
      mmio_awaddr                     => Kernel_Nucleus_inst_mmio_awaddr,
      mmio_wvalid                     => Kernel_Nucleus_inst_mmio_wvalid,
      mmio_wready                     => Kernel_Nucleus_inst_mmio_wready,
      mmio_wdata                      => Kernel_Nucleus_inst_mmio_wdata,
      mmio_wstrb                      => Kernel_Nucleus_inst_mmio_wstrb,
      mmio_bvalid                     => Kernel_Nucleus_inst_mmio_bvalid,
      mmio_bready                     => Kernel_Nucleus_inst_mmio_bready,
      mmio_bresp                      => Kernel_Nucleus_inst_mmio_bresp,
      mmio_arvalid                    => Kernel_Nucleus_inst_mmio_arvalid,
      mmio_arready                    => Kernel_Nucleus_inst_mmio_arready,
      mmio_araddr                     => Kernel_Nucleus_inst_mmio_araddr,
      mmio_rvalid                     => Kernel_Nucleus_inst_mmio_rvalid,
      mmio_rready                     => Kernel_Nucleus_inst_mmio_rready,
      mmio_rdata                      => Kernel_Nucleus_inst_mmio_rdata,
      mmio_rresp                      => Kernel_Nucleus_inst_mmio_rresp,
      StringWrite_String_valid        => Kernel_Nucleus_inst_StringWrite_String_valid,
      StringWrite_String_ready        => Kernel_Nucleus_inst_StringWrite_String_ready,
      StringWrite_String_dvalid       => Kernel_Nucleus_inst_StringWrite_String_dvalid,
      StringWrite_String_last         => Kernel_Nucleus_inst_StringWrite_String_last,
      StringWrite_String_length       => Kernel_Nucleus_inst_StringWrite_String_length,
      StringWrite_String_count        => Kernel_Nucleus_inst_StringWrite_String_count,
      StringWrite_String_chars_valid  => Kernel_Nucleus_inst_StringWrite_String_chars_valid,
      StringWrite_String_chars_ready  => Kernel_Nucleus_inst_StringWrite_String_chars_ready,
      StringWrite_String_chars_dvalid => Kernel_Nucleus_inst_StringWrite_String_chars_dvalid,
      StringWrite_String_chars_last   => Kernel_Nucleus_inst_StringWrite_String_chars_last,
      StringWrite_String_chars        => Kernel_Nucleus_inst_StringWrite_String_chars,
      StringWrite_String_chars_count  => Kernel_Nucleus_inst_StringWrite_String_chars_count,
      StringWrite_String_unl_valid    => Kernel_Nucleus_inst_StringWrite_String_unl_valid,
      StringWrite_String_unl_ready    => Kernel_Nucleus_inst_StringWrite_String_unl_ready,
      StringWrite_String_unl_tag      => Kernel_Nucleus_inst_StringWrite_String_unl_tag,
      StringWrite_String_cmd_valid    => Kernel_Nucleus_inst_StringWrite_String_cmd_valid,
      StringWrite_String_cmd_ready    => Kernel_Nucleus_inst_StringWrite_String_cmd_ready,
      StringWrite_String_cmd_firstIdx => Kernel_Nucleus_inst_StringWrite_String_cmd_firstIdx,
      StringWrite_String_cmd_lastIdx  => Kernel_Nucleus_inst_StringWrite_String_cmd_lastIdx,
      StringWrite_String_cmd_ctrl     => Kernel_Nucleus_inst_StringWrite_String_cmd_ctrl,
      StringWrite_String_cmd_tag      => Kernel_Nucleus_inst_StringWrite_String_cmd_tag
    );

  Kernel_StringWrite_inst : Kernel_StringWrite
    generic map (
      INDEX_WIDTH                           => INDEX_WIDTH,
      TAG_WIDTH                             => TAG_WIDTH,
      STRINGWRITE_STRING_BUS_ADDR_WIDTH     => BUS_ADDR_WIDTH,
      STRINGWRITE_STRING_BUS_DATA_WIDTH     => BUS_DATA_WIDTH,
      STRINGWRITE_STRING_BUS_LEN_WIDTH      => BUS_LEN_WIDTH,
      STRINGWRITE_STRING_BUS_BURST_STEP_LEN => BUS_BURST_STEP_LEN,
      STRINGWRITE_STRING_BUS_BURST_MAX_LEN  => BUS_BURST_MAX_LEN
    )
    port map (
      bcd_clk                            => Kernel_StringWrite_inst_bcd_clk,
      bcd_reset                          => Kernel_StringWrite_inst_bcd_reset,
      kcd_clk                            => Kernel_StringWrite_inst_kcd_clk,
      kcd_reset                          => Kernel_StringWrite_inst_kcd_reset,
      StringWrite_String_valid           => Kernel_StringWrite_inst_StringWrite_String_valid,
      StringWrite_String_ready           => Kernel_StringWrite_inst_StringWrite_String_ready,
      StringWrite_String_dvalid          => Kernel_StringWrite_inst_StringWrite_String_dvalid,
      StringWrite_String_last            => Kernel_StringWrite_inst_StringWrite_String_last,
      StringWrite_String_length          => Kernel_StringWrite_inst_StringWrite_String_length,
      StringWrite_String_count           => Kernel_StringWrite_inst_StringWrite_String_count,
      StringWrite_String_chars_valid     => Kernel_StringWrite_inst_StringWrite_String_chars_valid,
      StringWrite_String_chars_ready     => Kernel_StringWrite_inst_StringWrite_String_chars_ready,
      StringWrite_String_chars_dvalid    => Kernel_StringWrite_inst_StringWrite_String_chars_dvalid,
      StringWrite_String_chars_last      => Kernel_StringWrite_inst_StringWrite_String_chars_last,
      StringWrite_String_chars           => Kernel_StringWrite_inst_StringWrite_String_chars,
      StringWrite_String_chars_count     => Kernel_StringWrite_inst_StringWrite_String_chars_count,
      StringWrite_String_bus_wreq_valid  => Kernel_StringWrite_inst_StringWrite_String_bus_wreq_valid,
      StringWrite_String_bus_wreq_ready  => Kernel_StringWrite_inst_StringWrite_String_bus_wreq_ready,
      StringWrite_String_bus_wreq_addr   => Kernel_StringWrite_inst_StringWrite_String_bus_wreq_addr,
      StringWrite_String_bus_wreq_len    => Kernel_StringWrite_inst_StringWrite_String_bus_wreq_len,
      StringWrite_String_bus_wdat_valid  => Kernel_StringWrite_inst_StringWrite_String_bus_wdat_valid,
      StringWrite_String_bus_wdat_ready  => Kernel_StringWrite_inst_StringWrite_String_bus_wdat_ready,
      StringWrite_String_bus_wdat_data   => Kernel_StringWrite_inst_StringWrite_String_bus_wdat_data,
      StringWrite_String_bus_wdat_strobe => Kernel_StringWrite_inst_StringWrite_String_bus_wdat_strobe,
      StringWrite_String_bus_wdat_last   => Kernel_StringWrite_inst_StringWrite_String_bus_wdat_last,
      StringWrite_String_cmd_valid       => Kernel_StringWrite_inst_StringWrite_String_cmd_valid,
      StringWrite_String_cmd_ready       => Kernel_StringWrite_inst_StringWrite_String_cmd_ready,
      StringWrite_String_cmd_firstIdx    => Kernel_StringWrite_inst_StringWrite_String_cmd_firstIdx,
      StringWrite_String_cmd_lastIdx     => Kernel_StringWrite_inst_StringWrite_String_cmd_lastIdx,
      StringWrite_String_cmd_ctrl        => Kernel_StringWrite_inst_StringWrite_String_cmd_ctrl,
      StringWrite_String_cmd_tag         => Kernel_StringWrite_inst_StringWrite_String_cmd_tag,
      StringWrite_String_unl_valid       => Kernel_StringWrite_inst_StringWrite_String_unl_valid,
      StringWrite_String_unl_ready       => Kernel_StringWrite_inst_StringWrite_String_unl_ready,
      StringWrite_String_unl_tag         => Kernel_StringWrite_inst_StringWrite_String_unl_tag
    );

  WRAW64DW512LW8BS1BM16_inst : BusWriteArbiterVec
    generic map (
      BUS_ADDR_WIDTH  => BUS_ADDR_WIDTH,
      BUS_DATA_WIDTH  => BUS_DATA_WIDTH,
      BUS_LEN_WIDTH   => BUS_LEN_WIDTH,
      NUM_SLAVE_PORTS => 1,
      ARB_METHOD      => "RR-STICKY",
      MAX_OUTSTANDING => 4,
      RAM_CONFIG      => "",
      SLV_REQ_SLICES  => true,
      MST_REQ_SLICE   => true,
      MST_DAT_SLICE   => true,
      SLV_DAT_SLICES  => true
    )
    port map (
      bcd_clk         => WRAW64DW512LW8BS1BM16_inst_bcd_clk,
      bcd_reset       => WRAW64DW512LW8BS1BM16_inst_bcd_reset,
      mst_wreq_valid  => WRAW64DW512LW8BS1BM16_inst_mst_wreq_valid,
      mst_wreq_ready  => WRAW64DW512LW8BS1BM16_inst_mst_wreq_ready,
      mst_wreq_addr   => WRAW64DW512LW8BS1BM16_inst_mst_wreq_addr,
      mst_wreq_len    => WRAW64DW512LW8BS1BM16_inst_mst_wreq_len,
      mst_wdat_valid  => WRAW64DW512LW8BS1BM16_inst_mst_wdat_valid,
      mst_wdat_ready  => WRAW64DW512LW8BS1BM16_inst_mst_wdat_ready,
      mst_wdat_data   => WRAW64DW512LW8BS1BM16_inst_mst_wdat_data,
      mst_wdat_strobe => WRAW64DW512LW8BS1BM16_inst_mst_wdat_strobe,
      mst_wdat_last   => WRAW64DW512LW8BS1BM16_inst_mst_wdat_last,
      bsv_wreq_valid  => WRAW64DW512LW8BS1BM16_inst_bsv_wreq_valid,
      bsv_wreq_ready  => WRAW64DW512LW8BS1BM16_inst_bsv_wreq_ready,
      bsv_wreq_len    => WRAW64DW512LW8BS1BM16_inst_bsv_wreq_len,
      bsv_wreq_addr   => WRAW64DW512LW8BS1BM16_inst_bsv_wreq_addr,
      bsv_wdat_valid  => WRAW64DW512LW8BS1BM16_inst_bsv_wdat_valid,
      bsv_wdat_strobe => WRAW64DW512LW8BS1BM16_inst_bsv_wdat_strobe,
      bsv_wdat_ready  => WRAW64DW512LW8BS1BM16_inst_bsv_wdat_ready,
      bsv_wdat_last   => WRAW64DW512LW8BS1BM16_inst_bsv_wdat_last,
      bsv_wdat_data   => WRAW64DW512LW8BS1BM16_inst_bsv_wdat_data
    );

  wr_mst_wreq_valid                         <= WRAW64DW512LW8BS1BM16_inst_mst_wreq_valid;
  WRAW64DW512LW8BS1BM16_inst_mst_wreq_ready <= wr_mst_wreq_ready;
  wr_mst_wreq_addr                          <= WRAW64DW512LW8BS1BM16_inst_mst_wreq_addr;
  wr_mst_wreq_len                           <= WRAW64DW512LW8BS1BM16_inst_mst_wreq_len;
  wr_mst_wdat_valid                         <= WRAW64DW512LW8BS1BM16_inst_mst_wdat_valid;
  WRAW64DW512LW8BS1BM16_inst_mst_wdat_ready <= wr_mst_wdat_ready;
  wr_mst_wdat_data                          <= WRAW64DW512LW8BS1BM16_inst_mst_wdat_data;
  wr_mst_wdat_strobe                        <= WRAW64DW512LW8BS1BM16_inst_mst_wdat_strobe;
  wr_mst_wdat_last                          <= WRAW64DW512LW8BS1BM16_inst_mst_wdat_last;

  Kernel_Nucleus_inst_kcd_clk                             <= kcd_clk;
  Kernel_Nucleus_inst_kcd_reset                           <= kcd_reset;

  Kernel_Nucleus_inst_mmio_awvalid                        <= mmio_awvalid;
  mmio_awready                                            <= Kernel_Nucleus_inst_mmio_awready;
  Kernel_Nucleus_inst_mmio_awaddr                         <= mmio_awaddr;
  Kernel_Nucleus_inst_mmio_wvalid                         <= mmio_wvalid;
  mmio_wready                                             <= Kernel_Nucleus_inst_mmio_wready;
  Kernel_Nucleus_inst_mmio_wdata                          <= mmio_wdata;
  Kernel_Nucleus_inst_mmio_wstrb                          <= mmio_wstrb;
  mmio_bvalid                                             <= Kernel_Nucleus_inst_mmio_bvalid;
  Kernel_Nucleus_inst_mmio_bready                         <= mmio_bready;
  mmio_bresp                                              <= Kernel_Nucleus_inst_mmio_bresp;
  Kernel_Nucleus_inst_mmio_arvalid                        <= mmio_arvalid;
  mmio_arready                                            <= Kernel_Nucleus_inst_mmio_arready;
  Kernel_Nucleus_inst_mmio_araddr                         <= mmio_araddr;
  mmio_rvalid                                             <= Kernel_Nucleus_inst_mmio_rvalid;
  Kernel_Nucleus_inst_mmio_rready                         <= mmio_rready;
  mmio_rdata                                              <= Kernel_Nucleus_inst_mmio_rdata;
  mmio_rresp                                              <= Kernel_Nucleus_inst_mmio_rresp;

  Kernel_Nucleus_inst_StringWrite_String_unl_valid        <= Kernel_StringWrite_inst_StringWrite_String_unl_valid;
  Kernel_StringWrite_inst_StringWrite_String_unl_ready    <= Kernel_Nucleus_inst_StringWrite_String_unl_ready;
  Kernel_Nucleus_inst_StringWrite_String_unl_tag          <= Kernel_StringWrite_inst_StringWrite_String_unl_tag;

  Kernel_StringWrite_inst_bcd_clk                         <= bcd_clk;
  Kernel_StringWrite_inst_bcd_reset                       <= bcd_reset;

  Kernel_StringWrite_inst_kcd_clk                         <= kcd_clk;
  Kernel_StringWrite_inst_kcd_reset                       <= kcd_reset;

  Kernel_StringWrite_inst_StringWrite_String_valid        <= Kernel_Nucleus_inst_StringWrite_String_valid;
  Kernel_Nucleus_inst_StringWrite_String_ready            <= Kernel_StringWrite_inst_StringWrite_String_ready;
  Kernel_StringWrite_inst_StringWrite_String_dvalid       <= Kernel_Nucleus_inst_StringWrite_String_dvalid;
  Kernel_StringWrite_inst_StringWrite_String_last         <= Kernel_Nucleus_inst_StringWrite_String_last;
  Kernel_StringWrite_inst_StringWrite_String_length       <= Kernel_Nucleus_inst_StringWrite_String_length;
  Kernel_StringWrite_inst_StringWrite_String_count        <= Kernel_Nucleus_inst_StringWrite_String_count;
  Kernel_StringWrite_inst_StringWrite_String_chars_valid  <= Kernel_Nucleus_inst_StringWrite_String_chars_valid;
  Kernel_Nucleus_inst_StringWrite_String_chars_ready      <= Kernel_StringWrite_inst_StringWrite_String_chars_ready;
  Kernel_StringWrite_inst_StringWrite_String_chars_dvalid <= Kernel_Nucleus_inst_StringWrite_String_chars_dvalid;
  Kernel_StringWrite_inst_StringWrite_String_chars_last   <= Kernel_Nucleus_inst_StringWrite_String_chars_last;
  Kernel_StringWrite_inst_StringWrite_String_chars        <= Kernel_Nucleus_inst_StringWrite_String_chars;
  Kernel_StringWrite_inst_StringWrite_String_chars_count  <= Kernel_Nucleus_inst_StringWrite_String_chars_count;

  Kernel_StringWrite_inst_StringWrite_String_cmd_valid    <= Kernel_Nucleus_inst_StringWrite_String_cmd_valid;
  Kernel_Nucleus_inst_StringWrite_String_cmd_ready        <= Kernel_StringWrite_inst_StringWrite_String_cmd_ready;
  Kernel_StringWrite_inst_StringWrite_String_cmd_firstIdx <= Kernel_Nucleus_inst_StringWrite_String_cmd_firstIdx;
  Kernel_StringWrite_inst_StringWrite_String_cmd_lastIdx  <= Kernel_Nucleus_inst_StringWrite_String_cmd_lastIdx;
  Kernel_StringWrite_inst_StringWrite_String_cmd_ctrl     <= Kernel_Nucleus_inst_StringWrite_String_cmd_ctrl;
  Kernel_StringWrite_inst_StringWrite_String_cmd_tag      <= Kernel_Nucleus_inst_StringWrite_String_cmd_tag;

  WRAW64DW512LW8BS1BM16_inst_bcd_clk                      <= bcd_clk;
  WRAW64DW512LW8BS1BM16_inst_bcd_reset                    <= bcd_reset;

  WRAW64DW512LW8BS1BM16_inst_bsv_wreq_valid(0)                            <= Kernel_StringWrite_inst_StringWrite_String_bus_wreq_valid;
  WRAW64DW512LW8BS1BM16_inst_bsv_wreq_len(BUS_LEN_WIDTH-1 downto 0)       <= Kernel_StringWrite_inst_StringWrite_String_bus_wreq_len;
  WRAW64DW512LW8BS1BM16_inst_bsv_wreq_addr(BUS_ADDR_WIDTH-1 downto 0)     <= Kernel_StringWrite_inst_StringWrite_String_bus_wreq_addr;
  WRAW64DW512LW8BS1BM16_inst_bsv_wdat_valid(0)                            <= Kernel_StringWrite_inst_StringWrite_String_bus_wdat_valid;
  WRAW64DW512LW8BS1BM16_inst_bsv_wdat_strobe(BUS_DATA_WIDTH/8-1 downto 0) <= Kernel_StringWrite_inst_StringWrite_String_bus_wdat_strobe;
  WRAW64DW512LW8BS1BM16_inst_bsv_wdat_last(0)                             <= Kernel_StringWrite_inst_StringWrite_String_bus_wdat_last;
  WRAW64DW512LW8BS1BM16_inst_bsv_wdat_data(BUS_DATA_WIDTH-1 downto 0)     <= Kernel_StringWrite_inst_StringWrite_String_bus_wdat_data;
  Kernel_StringWrite_inst_StringWrite_String_bus_wreq_ready               <= WRAW64DW512LW8BS1BM16_inst_bsv_wreq_ready(0);
  Kernel_StringWrite_inst_StringWrite_String_bus_wdat_ready               <= WRAW64DW512LW8BS1BM16_inst_bsv_wdat_ready(0);

end architecture;