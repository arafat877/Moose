--------------
-- Module name: ALU
-- ALU stands for Arithmetic and logic unit and It's the part of CPU that does all the calculations
-- Bit width : 32
--------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is

  port(       
        opcode : in std_logic_vector( 4 downto 0)
	);
  
end ALU;

architecture Behavioral of ALU is
begin

    

end Behavioral;

