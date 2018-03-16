--------------
-- Module name: Fetch
-- Fetch module is used for fetching istruction from memory
-- Bit width : 32
--------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fetch is

	port(
	
		clk : in std_logic; -- clock signal
		instruction : in std_logic_vector ( 31 downto 0); -- instruction word from memory
		pc_command : out std_logic_vector ( 1 downto 0); -- used for loading value into program counter
		to_decode : out std_logic_vector ( 31 downto 0 ); -- instruction opcode that is sent to decode cycle
		latch : out std_logic
	);

end Fetch;

architecture Behavioral of Fetch is

	signal instruction_reg : std_logic_vector ( 31 downto 0);

begin

	fetch_cycle : process (clk)
	begin
		
		if rising_edge(clk) then
			
				instruction_reg <= instruction; -- instruction is stored in instruction_reg
				to_decode <= instruction_reg;
				pc_command <= "01"; -- Program Counter advances to next address
		
		end if;
		
			latch <= clk;
	
	end process;


end Behavioral;

