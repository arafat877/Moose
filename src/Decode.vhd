--------------
-- Module name: Fetch
-- Fetch module is used for fetching istruction from memory
-- Bit width : 32
--------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Decode is

	port(
	
		clk : in std_logic; -- clock signal
		from_fetch : in std_logic_vector ( 31 downto 0); -- received from fetch cycle
		to_execute : out std_logic_vector ( 31 downto 0); -- parse to execute phase
		register_a : out std_logic_vector ( 4 downto 0);
		register_b : out std_logic_vector ( 4 downto 0);
		reg_command : out std_logic_vector ( 1 downto 0);
		latch : out std_logic
	);
	
end Decode;

architecture Behavioral of Decode is

signal internal_state : std_logic_vector( 31 downto 0);
signal command : std_logic_vector ( 6 downto 0);
signal rega, regb : std_logic_vector ( 4 downto 0);

begin

	decode_cycle : process(clk)
	begin
	
		if rising_edge(clk) then
			internal_state <= from_fetch;
			command <= internal_state( 6 downto 0);
			register_a <= internal_state (19 downto 15);
			register_b <= internal_state (24 downto 20);
			reg_command <= "10";
				
			
		end if;
		
		latch <= clk;
	
	end process;

end Behavioral;

