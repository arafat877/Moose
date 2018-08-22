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

     signal funct3 : std_logic_vector ( 2 downto 0);
     signal funct7 : std_logic_vector (6 downto 0);

begin

    alu_control : process(clk)
    begin
        
	 if rising_edge(clk) then
	 
		if reset = '1' then
			alu_opcode <= "0000";
			funct3 <= "000";
			funct7 <= "0000000";
		else
    		   funct3 <= instruction(14 downto 12);
				funct7 <= instruction(31 downto 25);
    
			  case ALUOp is 
					
					when "00" => alu_opcode <= "0010"; -- add is for load and store Instructions
					when "01" => alu_opcode <= "0110"; -- sub is for branching
					when "10" =>
							
							case funct3 is
							
								when "000" =>
									with funct7(5) select alu_opcode <=
										"0010" when "0", -- add
										"0110" when "1"; -- sub
								when "110" =>
									alu_opcode <= "0001";
								when "111" =>
									alu_opcode <= "0000";
							
							end case;
					when others => alu_opcode <= "ZZZZ";
					end case;
		end if;
	 end if;
    end process;

end Behavioral;
