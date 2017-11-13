--------------
-- Module name: Program Counter
-- Program counter is used for holding the address of next instruction to be executed
-- Bit width : 32
--------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Program_Counter is
	
	port(
	
		clk : in std_logic; -- clock signal
		pc_in : in std_logic_vector( 31 downto 0) ; -- input for Program Counter ( connected to internal bus)
		pc_out : out std_logic_vector( 31 downto 0) := "00000000000000000000000000000000"  ; -- output of program counter ( connected to address bus)
		pc_command : in std_logic_vector (1 downto 0) -- command for program counter
	);

end Program_Counter;

architecture Behavioral of Program_Counter is

	signal pc_internal_state : unsigned( 31 downto 0) := "00000000000000000000000000000000"; -- signal for holding internal state of counter

begin

--------------
----------
-- Process name: count_process
-- Purpose: Determines what should Program Counter do according to pc_command signal
-- Outcome: Change of pc_out or pc_internal_state signals
----------
--------------
		count_process : process(clk)
		begin
		
			if rising_edge(clk) then
			
				if pc_internal_state = integer'high then -- If counter reaches max valuse It's reseted to 0
						pc_internal_state <= "00000000000000000000000000000000";
				end if;
			
				
			
				if pc_command = "00" then -- Program Counter is reseted
					
					pc_internal_state <= "00000000000000000000000000000000";
					
				elsif pc_command = "01" then -- count
					
					pc_internal_state <= pc_internal_state + 1;
					
				elsif pc_command = "10" then -- output pc_internal_state
					
					pc_out <= std_logic_vector(pc_internal_state);
					
				elsif pc_command = "11" then -- load Program Counter
					
					pc_internal_state <= unsigned(pc_in);
					
				end if;
				
				
			end if;
		
		end process;


end Behavioral;

