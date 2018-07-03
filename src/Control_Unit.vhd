library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is

	port(
	   
	   opcode : in std_logic_vector ( 6 downto 0);
	   Branch : out std_logic;	
	   MemRead : out std_logic;
	   MemtoReg : out std_logic;
	   MemWrite : out std_logic;
	   ALUSrc : out std_logic;
	   RegWrite : out std_logic;
	   ALUOp : out std_logic_vector ( 1 downto 0)
	);

end Control_Unit;

architecture Behavioral of Control_Unit is
	
begin

    control_unit : process ( opcode )
    begin
    
        case opcode is 
        
            when "0110011" =>  -- R type Instruction
                Branch <= '0';
                MemRead <= '0';
                MemtoReg <= '0';
                ALUOp <= "00";
                MemWrite <= '0';
                ALUSrc <= '0';
                RegWrite <= '1';
                
                
        end case;
        
      
    
    end process;

end Behavioral;

