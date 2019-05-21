library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_control is
    
    port(
        clk : in std_logic;
		  reset : in std_logic;
        instruction : in std_logic_vector ( 31 downto 0);
        ALUOp : in std_logic_vector ( 1 downto 0);
        alu_opcode : out std_logic_vector ( 3 downto 0 )  
    );
    
end ALU_control;

architecture Behavioral of ALU_control is

begin

    alu_control : process(clk)
    begin
        
	 if rising_edge(clk) then
    
			  case ALUOp is 
					
					when "00" => alu_opcode <= "0010"; -- add is for load and store Instructions
					when "01" => alu_opcode <= "0110"; -- sub is for branching
					when "10" =>
							
							case instruction(14 downto 12) is
							
								when "000" =>
									
									if instruction(30) = '0' then
										alu_opcode <= "0010"; -- add
									else
										alu_opcode <= "0110"; -- sub
									end if;
								
								when "110" =>
									alu_opcode <= "0001"; -- or
								when "111" =>
									alu_opcode <= "0000"; -- and
								when others => 
									alu_opcode <= "ZZZZ";
								
							end case;
					when others => alu_opcode <= "ZZZZ";
					end case;
					
		end if;
    end process;

end Behavioral;
