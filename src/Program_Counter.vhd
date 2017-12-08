--------------
-- Module name: Program Counter
-- Program counter is used for holding the address of next instruction to be executed
-- Bit width : 32
--------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Program_Counter is
	
	port(
	
		clk : in std_logic; -- clock signal
		pc_in : in std_logic_vector( 31 downto 0) ; -- input for Program Counter ( connected to internal bus)
		pc_out : out std_logic_vector( 31 downto 0) :=  (others => '0'); -- output of program counter ( connected to address bus)
		pc_command : in std_logic_vector (1 downto 0) -- command for program counter
	);

end Program_Counter;

architecture Behavioral of Program_Counter is

	signal pc_internal_state : unsigned( 31 downto 0) :=  (others => '0'); -- signal for holding internal state of counter

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
						pc_internal_state <= (others => '0');
				end if;
			
				
			
				case pc_command is 
				
				when "00" => pc_internal_state <=  (others => '0'); -- Program Counter is reseted
				when  "01" => pc_internal_state <= pc_internal_state + 1;-- count
				when "10" => pc_out <= std_logic_vector(pc_internal_state);  -- output pc_internal_state
				when "11" => pc_internal_state <= unsigned(pc_in);  -- load Program Counter
				when others => pc_internal_state <= ( others => 'Z'); -- when any other state it's high impedance
				
				end case;
				
			end if;
		
		end process;


end Behavioral;

