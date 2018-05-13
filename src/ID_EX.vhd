library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ID_EX is
	
	port(
		from_decode  : in std_logic_vector( 8 downto 0);
		reg_a 	: in std_logic_vector( 31 downto 0);
		reg_b 	: in std_logic_vector( 31 downto 0);
		enable   : in std_logic;
      clk      : in std_logic;
      reset    : in std_logic;
		data_out : out std_logic_vector( 74 downto 0)
	);
	
end ID_EX;

architecture Behavioral of ID_EX is

  signal current_state, next_state : std_logic_vector( 74 downto 0);

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
      next_state(8 downto 0) <= from_decode;
		next_state(40 downto 9) <= reg_b;
		next_state(73 downto 42 ) <= reg_a;	
    else
      next_state <= current_state;
    end if;
  end process;

  data_out <= current_state;

end Behavioral;
