library ieee;
use ieee.std_logic_1164.all;

entity Pipeline_Register_tb is
  
end entity Pipeline_Register_tb;

architecture Behavioral of Pipeline_Register_tb is

  signal data_in  : std_logic_vector(31 downto 0);
  signal enable   : std_logic;
  signal clk      : std_logic;
  signal reset    : std_logic;
  signal data_out : std_logic_vector(31 downto 0);

begin  -- architecture Behavioral

  Pipeline_Register_1: entity work.Pipeline_Register
    port map (
      data_in  => data_in,
      enable   => enable,
      clk      => clk,
      reset    => reset,
      data_out => data_out);

  clk_gen: process is
  begin  -- process clk_gen
    clk <= '0', '1' after 10 ns;
    wait for 20 ns;
  end process clk_gen;

  stim_gen: process is
  begin  -- process stim_gen
    enable <= '1', '0' after 200 ns;
    reset  <= '1', '0' after 15 ns, '1' after 280 ns, '0' after 300 ns;
    data_in <= x"00000008", x"0000000a" after 25 ns, x"0000007f" after 45 ns, x"00001000" after 65 ns, x"ffff0000" after 210 ns;
    wait;
  end process stim_gen;

end architecture Behavioral;
