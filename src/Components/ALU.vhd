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
		  reset : in std_logic;
        opcode : in std_logic_vector( 3 downto 0);
        input1 : in std_logic_vector ( 31 downto 0);
        input2 : in std_logic_vector ( 31 downto 0);
        output : out std_logic_vector ( 31 downto 0);
        zero : out std_logic := '0' -- zero flag
        );
  
end ALU;

architecture Behavioral of ALU is
begin

    alu_process : process(clk)
    begin
    
	 if rising_edge(clk) then
	 
		if reset = '1' then
			output <= (others => '0');
			zero <= '0';
		else
	 
			  case opcode is
					
					when "0000" => output <= input1 and input2; -- and
					when "0001" => output <= input1 or input2; -- or
					when "0010" => output <= std_logic_vector(unsigned(input1) + unsigned(input2));-- add
					when "0110" =>
						output <= std_logic_vector(unsigned(input1) - unsigned(input2)); -- sub
							if unsigned(input1) = unsigned(input2) then -- zero flag generation
								zero <= '1';
							else
								zero <= '0';
							end if;
					when others => output <= (others => 'Z');
						
			  end case;
		end if;
	 end if;
	 
    end process;
    

end Behavioral;

