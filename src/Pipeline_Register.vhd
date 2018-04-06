library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Pipeline_Register is
	
	port(
		data_in  : in std_logic_vector( 31 downto 0);
		enable   : in std_logic;
    clk      : in std_logic;
    reset    : in std_logic;
		data_out : out std_logic_vector( 31 downto 0)
	);
	
end Pipeline_Register;

architecture Behavioral of Pipeline_Register is

  signal current_state, next_state : std_logic_vector( 31 downto 0);
	signal internal_state            : std_logic_vector( 31 downto 0);

begin
	process (clk, reset) is
  begin  -- process
    if reset = '1' then
      current_state <= (others => '0');
    elsif rising_edge(clk) then
      current_state <= next_state;
    end if;
  end process;

  process (clk, enable) is
  begin  -- process
    if enable = '1' then
      next_state <= data_in;
    else
      next_state <= current_state;
    end if;
  end process;

  data_out <= current_state;

end Behavioral;
