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
		reset : in std_logic;
		pc_input : in std_logic_vector( 31 downto 0);
		pc_output : out std_logic_vector( 31 downto 0)
	);

end Program_Counter;

architecture Behavioral of Program_Counter is

begin

	pc_process : process(clk)
	begin
        if rising_edge(clk) then
		  
			if reset = '1' then
					pc_output  <= (others => '0');
			  else 
				  pc_output <= pc_input;
			  end if;
        end if;
	end process;

end Behavioral;

