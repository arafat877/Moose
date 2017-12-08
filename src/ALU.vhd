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
    alu_output : out std_logic_vector ( 31 downto 0) -- output from the alu
	
	);
  
end ALU;

architecture Behavioral of ALU is

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
        when "0001" => alu_output <= std_logic_vector(signed(alu_input_a) + signed(alu_input_b)); -- a + b 
		  when "0010" => alu_output <= std_logic_vector(signed(alu_input_a) - signed(alu_input_b)); -- a - b 
        when "0011" => alu_output <= alu_input_a or alu_input_b; -- a or b
        when "0100" => alu_output <= alu_input_a and alu_input_b; -- a and b
        when "0101" => alu_output <= alu_input_a xor alu_input_b; -- a xor b
		  when "0110" => alu_output <= not alu_input_a; -- invert a
		  when others => alu_output <= (others => 'Z');	-- not a legal command
      end case;
      
    end if;
    
  end process;
  

end Behavioral;

