library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Inst_Memory is

	port(
		
		clk : in std_logic;
		read_address  : in std_logic_vector( 31 downto 0);
		mem_output : out std_logic_vector( 31 downto 0)
	
	);

end Inst_Memory;

architecture Behavioral of Inst_Memory is

type Memory_Content is array ( 0 to 255) of std_logic_vector(31 downto 0);
signal mem : Memory_Content := (others => (others => '0'));

begin

-- testing
mem(0)  <= "00000000000000000000000100000011"; -- load reg2,%0
mem(4)  <= "00000000000000000000000010000011"; -- load reg1,%0
mem(8)  <= "00000000001000001000000110110011"; -- add reg3,reg1,reg2
--mem(12) <= "00000000001100001000000000100011"; -- store reg3,[imm+reg1]
--------

--signal_1 <= std_logic_vector(unsigned(read_address) + to_unsigned(1,32));
--signal_2 <= std_logic_vector(unsigned(read_address) + to_unsigned(2,32));
--signal_3 <= std_logic_vector(unsigned(read_address) + to_unsigned(3,32));

	mem_proc : process(clk)
	begin
		
		if rising_edge(clk) then
			
			mem_output <= mem(to_integer(unsigned(read_address)));
			
		end if;
		
	end process;


end Behavioral;

