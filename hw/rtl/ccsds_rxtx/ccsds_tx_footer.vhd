-------------------------------
---- Project: EurySPACE CCSDS RX/TX with wishbone interface
---- Design Name: ccsds_tx_footer
---- Version: 1.0.0
---- Description:
---- TBD
-------------------------------
---- Author(s):
---- Guillaume REMBERT
-------------------------------
---- Licence:
---- MIT
-------------------------------
---- Changes list:
---- 2016/02/28: initial release
---- 2016/10/21: rework
-------------------------------
--TODO: operationnal control field not done
--TODO: security trailer not done

--[OPT] SECURITY TRAILER
--[OPT] TRANSFER FRAME TRAILER (2 to 6 octets)
--       \ [OPT] OPERATIONAL CONTROL FIELD => 4 octets
--       \ [OPT] Frame error control field => 2 octets

-- libraries used
library ieee;
use ieee.std_logic_1164.all;

--=============================================================================
-- Entity declaration for ccsds_tx / unitary tx footer inputs and outputs
--=============================================================================
entity ccsds_tx_footer is
  generic(
    CCSDS_TX_FOOTER_DATA_LENGTH: integer; -- in Bytes
    CCSDS_TX_FOOTER_LENGTH: integer -- in Bytes
  );
  port(
    clk_i: in std_logic;
    rst_i: in std_logic;
    nxt_i: in std_logic;
    busy_o: out std_logic;
    data_i: in std_logic_vector(CCSDS_TX_FOOTER_DATA_LENGTH*8-1 downto 0);
    data_o: out std_logic_vector(CCSDS_TX_FOOTER_LENGTH*8-1 downto 0);
    data_valid_o: out std_logic
  );
end ccsds_tx_footer;

--=============================================================================
-- architecture declaration / internal components and connections
--=============================================================================
architecture rtl of ccsds_tx_footer is
  component ccsds_rxtx_crc is
    generic(
      CCSDS_RXTX_CRC_LENGTH: integer;
      CCSDS_RXTX_CRC_DATA_LENGTH: integer
    );
    port(
      clk_i: in std_logic;
      rst_i: in std_logic;
      nxt_i: in std_logic;
      busy_o: out std_logic;
      data_i: in std_logic_vector(CCSDS_RXTX_CRC_DATA_LENGTH*8-1 downto 0);
      data_o: out std_logic_vector(CCSDS_RXTX_CRC_LENGTH*8-1 downto 0);
      data_valid_o: out std_logic
    );
  end component;
-- internal variable signals
-- components instanciation and mapping
  begin
  tx_footer_crc_0: ccsds_rxtx_crc
    generic map(
      CCSDS_RXTX_CRC_DATA_LENGTH => CCSDS_TX_FOOTER_DATA_LENGTH,
      CCSDS_RXTX_CRC_LENGTH => CCSDS_TX_FOOTER_LENGTH
    )
    port map(
      clk_i => clk_i,
      rst_i => rst_i,
      nxt_i => nxt_i,
      busy_o => busy_o,
      data_i => data_i,
      data_o => data_o,
      data_valid_o => data_valid_o
    );
-- internal processing

end rtl;
