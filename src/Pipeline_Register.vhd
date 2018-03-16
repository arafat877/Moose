
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Pipeline_Register is
	
	port(
		
		data_in : in std_logic_vector( 31 downto 0);
		enable : in std_logic;
		data_out : out std_logic_vector( 31 downto 0)
	
	);
	
end Pipeline_Register;

architecture Behavioral of Pipeline_Register is

	signal internal_state : std_logic_vector ( 31 downto 0);

begin
	
	internal_state <= data_in when enable = '1' else internal_state;
	data_out <= internal_state;


end Behavioral;

