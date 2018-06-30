library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Add_4 is

    port(
        input : in std_logic_vector ( 31 downto 0);
        output : out std_logic_vector ( 31 downto 0)
    );

end Add_4;

architecture Behavioral of Add_4 is

begin

    output <= std_logic_vector(unsigned(input)+4);

end Behavioral;
