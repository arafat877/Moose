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
        opcode : in std_logic_vector( 4 downto 0);
        input1 : in std_logic_vector ( 31 downto 0);
        input2 : in std_logic_vector ( 31 downto 0);
        output : out std_logic_vector ( 31 downto 0);
        zero : out std_logic -- zero flag
        );
  
end ALU;

architecture Behavioral of ALU is
begin

    alu_process : process(opcode)
    begin
    
        case opcode is
            
           when "0000"=> output <= std_logic_vector( unsigned(input1) + unsigned(input2));
           when "0001"=>
                
                output <=  std_logic_vector( unsigned(input1) - unsigned(input2));
                    if( unsigned(input1) - unsigned(input2) ) = 0 then
                        zero <= '1';
                    end if;
                
           when "0010"=> output <= std_logic_vector(shift_left(unsigned(input1),to_integer(unsigned(input2)) ) );
           when "0011"=> 
           when "0100"=>
           when "0101"=>
           when "0110"=> output <= std_logic_vector(shift_right(unsigned(input1),to_integer(unsigned(input2)) ) );
           when "0111"=>
           when "1000"=>
           when "1001"=>
           when "1010"=>
           when "1011"=>
           when "1100"=>
           when "1101"=>
           when "1110"=>
           when "1111"=>
                         
            
        end case;
    
    end process;
      
    

end Behavioral;

