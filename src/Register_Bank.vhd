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
	    clk : in std_logic;
        read_reg1 : in std_logic_vector( 4 downto 0);
        read_reg2 : in std_logic_vector ( 4 downto 0);
        write_reg : in std_logic_vector ( 4 downto 0);
        write_data : in std_logic_vector ( 31 downto 0);
        read_data1 : out std_logic_vector ( 31 downto 0);
        read_data2 : out std_logic_vector ( 31 downto 0);
        reg_write : in std_logic
	);

end Register_Bank;

architecture Behavioral of Register_Bank is

-- Reigster bank is implemented as array of 32 std_logic_vectors of length 32 bits

	type bank is array ( 0 to 31) of std_logic_vector( 31 downto 0);
	signal reg_bank : bank;

begin

    reg_process : process(clk)
    begin
    
        if rising_edge(clk) then 
            
            read_data1 <= reg_bank( to_integer(unsigned( read_reg1 )));
            read_data2 <= reg_bank( to_integer(unsigned( read_reg2 )));
                 
            if reg_write = '1' then
                reg_bank( to_integer(unsigned( write_reg ))) <= write_data;
            end if;
                 
        end if;
   
    end process;
   

end Behavioral;
