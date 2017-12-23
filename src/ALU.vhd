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

    clk : in std_logic; -- clock input
    alu_input_a : in std_logic_vector (31 downto 0); -- first alu input
    alu_input_b : in std_logic_vector (31 downto 0); -- second alu input
    alu_command : in std_logic_vector (3 downto 0); -- command for alu
    alu_output : out std_logic_vector ( 31 downto 0); -- output from the alu
	 alu_flags : inout std_logic_vector ( 3 downto 0) --flags ( to store additional information about output of operation)
		
		-- flags(0) - zero flag
		-- flags(1) - carry flag
		-- flags(2) - signed flag
		-- flags(3) - overflow flag
		
	);
  
end ALU;

architecture Behavioral of ALU is
	
	signal alu_output_resized : std_logic_vector (32 downto 0) := (others => '0');

begin

--------------
----------
-- Process name: alu_process
-- Purpose: Does the instruction specified by alu_command
-- Outcome: Change of alu_output signal
----------
--------------

  alu_process : process(clk)
  begin

    if rising_edge(clk) then

      case alu_command is

        when "0000" => alu_output <= (others => '0'); -- alu does nothing ( NOP )
        when "0001" => 
			
			alu_output <= std_logic_vector(signed(alu_input_a) + signed(alu_input_b)); -- a + b 
			alu_output_resized <= std_logic_vector(signed('0' & alu_input_a) + signed('0' & alu_input_b)); -- first bit of this vector is carry flag
			alu_flags(1) <= alu_output_resized(32); -- set carry flag to MSB of alu_output_resized			
				
		  when "0010" => 
		  
		  alu_output <= std_logic_vector(signed(alu_input_a) - signed(alu_input_b)); -- a - b 
				if signed(alu_input_a) - signed(alu_input_b) = 0 then
					alu_flags(0) <= '1';
				else 
					alu_flags(0) <= '0';
				end if;
			
		  when "0011" => alu_output <= alu_input_a or alu_input_b; -- a or b
        when "0100" => alu_output <= alu_input_a and alu_input_b; -- a and b
        when "0101" => alu_output <= alu_input_a xor alu_input_b; -- a xor b
		  when "0110" => alu_output <= not alu_input_a; -- invert a
		  when others => alu_output <= (others => 'Z');	-- not a legal command
      end case;
      
    end if;
    
  end process;
  

end Behavioral;

