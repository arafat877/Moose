library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hazard_Detection_Unit is

port(
	
	ID_EX_MemRead : in std_logic;
	ID_EX_RegisterRd : in std_logic_vector( 31 downto 0);
	IF_ID_RegisterRs1 : in std_logic_vector( 31 downto 0);
	IF_ID_RegisterRs2 : in std_logic_vector( 31 downto 0);
	stall : out std_logic

);

end Hazard_Detection_Unit;

architecture Behavioral of Hazard_Detection_Unit is

begin

	hazard_detection : process
	begin
	
		if ID_EX_MemRead = '1' and (( ID_EX_RegisterRd = IF_ID_RegisterRs1) or (ID_EX_RegisterRd = IF_ID_RegisterRs2)) then
			stall <= '1';
		else
			stall <= '0';
		end if;
	
	end process;

end Behavioral;

