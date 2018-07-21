library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_control is
    
    port(
        
        instruction : in std_logic_vector ( 31 downto 0);
        ALUOp : in std_logic_vector ( 1 downto 0);
        alu_opcode : out std_logic_vector ( 3 downto 0 )  
    );
    
end ALU_control;

architecture Behavioral of ALU_control is

     signal funct3 : std_logic_vector ( 2 downto 0);
     signal funct7 : std_logic_vector (6 downto 0);

begin

    funct3 <= instruction(14 downto 0);
    funct7 <= instruction(31 downto 25);
    
    alu_control : process( funct3 , funct7, ALUOp)
    begin
        
        case ALUOp is 
            
            when "00" => alu_opcode <= "0000"; -- add is for load and store Instructions
            when "01" => alu_opcode <= "0001"; -- sub is for branching
            when "10" =>
                
                case funct3 is
                    
                    when "000"=>
                        case funct7 is
                            when "0000000" => alu_opcode <= "0001"; -- add
                            when "0100000" => alu_opcode <= "0010"; -- sub
                        end case;
                    when "001" => alu_opcode <= "0011";
                    when "010" => alu_opcode <= "0100";
                    when "011" => alu_opcode <= "0101";
                    when "100" => alu_opcode <= "0110";
                    when "101" =>
                        case funct7 is
                            when "0000000" => alu_opcode <= "0111";
                            when "0100000" => alu_opcode <= "1000";
                        end case;
                   when "110" => alu_opcode <= "1001";
                   when "111" => alu_opcode <= "1011";
                        
                    
                end case;
                
                
            
        end case;
        
        
    end process;

end Behavioral;
