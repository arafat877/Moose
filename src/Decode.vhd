library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Decode is

	port(

		clk : in std_logic; -- clock signal
		from_fetch : in std_logic_vector ( 31 downto 0); -- received from fetch cycle

		to_execute : out std_logic_vector ( 31 downto 0); -- parse to execute phase
		register_a : out std_logic_vector ( 4 downto 0); -- first parameter
		register_b : out std_logic_vector ( 4 downto 0); -- second parameter
		reg_command : out std_logic_vector ( 1 downto 0); -- command for reigster bank
		latch : out std_logic 
	);

end Decode;

architecture Behavioral of Decode is

signal internal_state : std_logic_vector( 31 downto 0);
signal command : std_logic_vector ( 6 downto 0);
signal alu_command : std_logic_vector ( 3 downto 0);
signal result_destination :std_logic_vector ( 4 downto 0);

begin

	decode_cycle : process(clk)
	begin

		if rising_edge(clk) then
			internal_state <= from_fetch;
			command <= internal_state( 6 downto 0);
			register_a <= internal_state (19 downto 15);
			register_b <= internal_state (24 downto 20);
			result_destination <= internal_state (11 downto 7); 
			reg_command <= "10";

			if command(4)='0' then -- pure arithmetic instructions

				alu_command <= command(3 downto 0); -- alu command is set to 4 lower bits of command signal
				
			else -- mov instructions 

				register_b <= (others => '0');
				alu_command <= '0001';

			end if;

			to_execute(3 downto 0) <= alu_command;
			to_execute(8 downto 4) <= result_destination;

		end if;

		latch <= clk;

	end process;

end Behavioral;
