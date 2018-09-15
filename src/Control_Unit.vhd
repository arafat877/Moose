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
                ALUOp <= "10";
                MemWrite <= '0';
                ALUSrc <= '0';
                RegWrite <= '1';
            when "0000011" => -- I type Instruction
                Branch <= '0';
                MemRead <= '1';
                MemtoReg <= '1';
                ALUOp <= "00";
                MemWrite <= '0';
                ALUSrc <= '1';
                RegWrite <= '1';
            when "0100011" => -- S type Instruction
                Branch <= '0';
                MemRead <= '0';
                MemtoReg <= 'X';
                ALUOp <= "00";
                MemWrite <= '1';
                ALUSrc <= '1';
                RegWrite <= '0';  
            when "1100011" => -- SB type Instruction
                Branch <= '1';
                MemRead <= '0';
                MemtoReg <= 'X';
                ALUOp <= "01";
                MemWrite <= '0';
                ALUSrc <= '0';
                RegWrite <= '0';    
           when others =>
               Branch <= 'X';
               MemRead <= 'X';
               MemtoReg <= 'X';
               ALUOp <= "XX";
               MemWrite <= 'X';
               ALUSrc <= 'X';
               RegWrite <= 'X';                   
                
                
        end case;
        
      
    
    end process;

end Behavioral;

