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
     signal funct7 : std_logic;

begin

    funct3 <= instruction(14 downto 0);
    funct7 <= instruction(30);
    
    alu_control : process( funct3 , funct7, ALUOp)
    begin
     
        if (ALUOp = "00") or (ALUOp = "01") then -- R and I type instruction  
     
            case funct3 is 
                
                when "000" => 
                    if funct7 = '0' then
                        alu_opcode <= "0000"; -- add
                    else
                        alu_opcode <= "0001"; -- sub
                    end if;
                        
                when "001" => alu_opcode <= "0010"; -- sll
                when "010" => alu_opcode <= "0011"; -- slt
                when "011" => alu_opcode <= "0100"; -- sltu
                when "100" => alu_opcode <= "0101"; -- xor
                when "101" =>
                    if funct7 = '0' then
                        alu_opcode <= "0110"; -- srl
                    else
                        alu_opcode <= "0111"; -- sra
                    end if;
                    
                when "110" => alu_opcode <= "1000"; -- or
                when "111" => alu_opcode <= "1001"; -- and
              
            end case;
            
       end if;
        
    end process;

end Behavioral;
