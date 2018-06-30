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
		pc_input : in std_logic_vector( 31 downto 0);
		pc_output : out std_logic_vector( 31 downto 0)
	);

end Program_Counter;

architecture Behavioral of Program_Counter is

	signal pc_current : std_logic_vector( 31 downto 0); -- signal for holding internal state of counter

begin

	pc_process : process(clk)
	begin
        if rising_edge(clk) then
           pc_current <= pc_input;
           pc_output <= pc_current;
        end if;
	end process;

end Behavioral;

