--------------
-- Module name: ALU
-- ALU stands for Arithmetic and logic unit and It's the part of CPU that does all the calculations
-- Bit width : 32
--------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is

  port(
        
        clk : in std_logic;
        func3 : in std_logic_vector(2 downto 0);
        func7_2bit : in std_logic;
        rs1 : in std_logic_vector(31 downto 0);
        rs2 : in std_logic_vector(31 downto 0);
        imm : in std_logic_vector(31 downto 0);
        inst_type : in std_logic; -- 1 for R type, 0 for I type
        res : out std_logic_vector(31 downto 0)
       
		
	);
  
end ALU;

architecture Behavioral of ALU is
begin

   alu_process : process(clk)
   begin
   
   if inst_type = '1' then -- R type instruction
    
        case func3 is
        
            when "000" => 
                
                if func7_2bit = '1' then
                    res <= std_logic_vector(unsigned(rs1)+unsigned(rs2));
                else 
                    res <= std_logic_vector(unsigned(rs1)-unsigned(rs2));
                end if;
                
            when "001" => -- sll
            when "010" => --slt
            when "011" => -- sltu
            when "100" => res <= rs1 xor rs2;
            when "101" =>
                if func7_2bit = 0 then -- srl
                
                else -- sra
                
                end if;
                
            when "110" => res <= rs1 or rs2;
            when "111" => res <= rs1 and rs2;
                
                
        
        end case;    
    
    else if inst_type = '0' then -- I type
    
    
   end if;
    
   
   end process;


end Behavioral;

