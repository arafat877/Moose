library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_memory is

	port(
		
		clk : in std_logic;
		write_data : in std_logic_vector( 31 downto 0);
		address : in std_logic_vector( 31 downto 0);
		MemRead : in std_logic;
		MemWrite : in std_logic;
		read_data : out std_logic_vector( 31 downto 0)
		
	);

end Data_memory;

architecture Behavioral of Data_memory is

type Memory_Content is array ( 0 to 255) of std_logic_vector(31 downto 0);
signal mem : Memory_Content := (others => (others => '0'));

begin

	memProc : process(clk)
	begin
	
	if MemWrite = '1' then
		mem(to_integer(unsigned(address))) <= write_data;
	elsif memRead = '1' then
		read_data <= mem(to_integer(unsigned(address)));
	elsif MemWrite = '0' and MemWrite = '0' then
		read_data <= (others => '0');
	end if;
	
	end process;


end Behavioral;

