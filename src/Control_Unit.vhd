--------------
-- Module name: Control Unit
-- Control Unit is used to decode instructions and send parameters to ALU so instruction can be executed
-- Bit width : 32
--------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is

	port(
		
		clk : in std_logic; -- clock signal
		instruction_word : in std_logic_vector ( 31 downto 0); -- size of instruction word is specified in RISC V datasheet
		pc_command  : out std_logic_vector ( 1 downto 0); -- command for program counter
		alu_command : out std_logic_vector ( 3 downto 0); -- output from ALU
		alu_flags : in std_logic_vector ( 3 downto 0); -- flags from alu ( used for jump commands )
		reg_command : out std_logic_vector ( 1 downto 0); -- command for register bank
		reg_address : out std_logic_vector ( 4 downto 0) -- address for register in register bank
	
		
		
	);

end Control_Unit;

architecture Behavioral of Control_Unit is
	
begin

--------------
----------
-- Process name: cu_process
-- Purpose: Fetching, Decoding and Executing instruction
-- Outcome: Instructoin is executed and result is stored in one of registers
----------
--------------

	cu_proces : process (clk)
	begin
	
	
	
	end process;

end Behavioral;

