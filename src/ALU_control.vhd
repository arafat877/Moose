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
        
        case ALUOp is 
            
            when "00" => alu_opcode <= "0000"; -- add is for load and store Instructions
            when "01" => alu_opcode <= "0001"; -- sub is for branching
            when "10" =>
                
            
        end case;
        
        
    end process;

end Behavioral;
