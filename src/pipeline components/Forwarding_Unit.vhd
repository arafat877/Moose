library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Forwarding_Unit is

port(
	
	EX_MEM_RegisterRd : in std_logic_vector(31 downto 0);
	MEM_WB_RegisterRd : in std_logic_vector(31 downto 0);
	EX_MEM_RegWrite : in std_logic;
	MEM_WB_RegWrite : in std_logic;
	rs1 : in std_logic_vector( 31 downto 0);
	rs2 : in std_logic_vector( 31 downto 0);
	ForwardA : out std_logic_vector( 1 downto 0);
	ForwardB : out std_logic_vector( 1 downto 0)
);

end Forwarding_Unit;

architecture Behavioral of Forwarding_Unit is

begin

	forward : process
	begin
	
	--EX hazard
	
		if EX_MEM_RegWrite = '1' and  EX_MEM_RegisterRd /= std_logic_vector(to_unsigned(0,32)) and EX_MEM_RegisterRd /= rs1 then
			ForwardA <= "10";
		end if;
		
		if EX_MEM_RegWrite = '1' and EX_MEM_RegisterRd /= std_logic_vector(to_unsigned(0,32)) and EX_MEM_RegisterRd /= rs2 then
			ForwardB <= "10";
		end if;
	
	--MEM hazard
		if MEM_WB_RegWrite = '1' and MEM_WB_RegisterRD /= std_logic_vector(to_unsigned(0,32)) and not(EX_MEM_RegWrite = '1' and (EX_MEM_RegisterRd /= std_logic_vector(to_unsigned(0,32)) and (EX_MEM_RegisterRd = rs1)) and (MEM_WB_RegisterRd = rs1)) then
			ForwardA <= "01";
		end if;
		
		if MEM_WB_RegWrite = '1' and MEM_WB_RegisterRD /= std_logic_vector(to_unsigned(0,32)) and not(EX_MEM_RegWrite = '1' and (EX_MEM_RegisterRd /= std_logic_vector(to_unsigned(0,32)) and (EX_MEM_RegisterRd = rs2)) and (MEM_WB_RegisterRd = rs2)) then
			ForwardB <= "01";
		end if;
	
	
	end process;


end Behavioral;

