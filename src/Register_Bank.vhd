--------------
-- Module name: Register Bank
-- Register Bank is used to store value of all 32 registers of YAK CPU
-- It's implemented as array of 32 bit registers
-- Bit width : 32
--------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Register_Bank is

	port(
		
		clk : in std_logic; -- clock signal
		reg_address : in std_logic_vector ( 4 downto 0); -- address of register in bank ( there are 32 registers)
		reg_data : inout std_logic_vector ( 31 downto 0) := (others => 'Z'); -- data to write to register or read from it
		reg_command : in std_logic_vector ( 1 downto 0)  -- command for regiter bank
	
	);

end Register_Bank;

architecture Behavioral of Register_Bank is

-- Reigster bank is implemented as array of 32 std_logic_vectors of length 32 bits

	type bank is array ( 0 to 31) of std_logic_vector( 31 downto 0);
	signal reg_bank : bank;

begin

--------------
----------
-- Process name: reg_process
-- Purpose: Accesses register bank to read data from register or write data to register
-- Outcome: Change of register values
----------
--------------

	reg_process : process (clk)
	begin
			
		if rising_edge(clk) then 
		
			case reg_command  is 
			
			when "01" => reg_bank(to_integer(unsigned(reg_address))) <= reg_data; -- load register
			when "10" => reg_data <= reg_bank(to_integer(unsigned(reg_address))); -- read register
			when others => reg_data <= (others => 'Z'); --when no command is sent reg_data is on high impedance
				
			end case;
		
		end if;
	
	end process;


end Behavioral;

