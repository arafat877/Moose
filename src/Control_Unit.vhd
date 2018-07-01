library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is

	port(
	   
	   instruction : in std_logic_vector ( 6 downto 0);
	   Branch : out std_logic;	
	   MemeRead : out std_logic;
	   MemtoReg : out std_logic;
	   MemWrite : out std_logic;
	   ALUSrc : out std_logic;
	   RegWrite : out std_logic;
	   ALUOp : out std_logic_vector ( 1 downto 0)
	);

end Control_Unit;

architecture Behavioral of Control_Unit is
	
begin
	

end Behavioral;

