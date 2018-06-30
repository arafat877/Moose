library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX_2to1 is
    
    port(
        
        input1 : in std_logic_vector( 31 downto 0);
        input2 : in std_logic_vector ( 31 downto 0);
        output : out std_logic_vector ( 31 downto 0);
        sel : in std_logic
        
    );
    
end MUX_2to1;

architecture Behavioral of MUX_2to1 is

begin

    output <= input1 when ( sel = '1' ) else input2;
 
end Behavioral;
