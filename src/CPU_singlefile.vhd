library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPU_SINGLEFILE is

	port(
		clk : in std_logic;
		inst_mem_out : in std_logic_vector(31 downto 0);
		izlaz : out std_logic_vector( 31 downto 0)	
	);

end CPU_SINGLEFILE;

architecture Behavioral of CPU_SINGLEFILE is

-- pipeline registers
signal IF_ID_register : std_logic_vector( 95 downto 0);
signal ID_EX_register : std_logic_vector( 216 downto 0);
signal EX_MEM_register : std_logic_vector( 138 downto 0);
signal MEM_WB_register : std_logic_vector(65 downto 0);

-- interphase signals
signal  RegWrite :   std_logic;
signal Write_Data : std_logic_vector( 31 downto 0);
signal Branch_control : std_logic := '1'; -- DEFAULT


-- signals for controling Program counter
signal Program_counter : std_logic_vector( 63 downto 0) := (others => '0');
signal next_address : std_logic_vector( 63 downto 0) := (others => '0');

-- Definition and init of register bank
type bank is array ( 0 to 31) of std_logic_vector( 31 downto 0);
--signal reg_bank : bank := (others =>(others => '0'));
signal reg_bank : bank := (others =>"00000000000000000000000000000001"); -- for testing

-- Memory
type memory is array ( 0 to 1023) of std_logic_vector( 31 downto 0);
signal Data_Memory : memory := (others =>( others => '0'));

begin 

	FETCH_process : process(clk, Program_counter)
	
	variable pc_new : std_logic_vector( 63 downto 0) := (others => '0');
	
	begin
		
	 pc_new := std_logic_vector(unsigned(Program_counter) + to_unsigned(4,64));
		
		if rising_edge(clk) then
			
			case  Branch_control is 
				when '1' => Program_counter <= next_address;
				when '0' => Program_counter <= pc_new;
				when others => Program_counter <= (others => '0');
			end case;
		
			IF_ID_register( 31 downto 0) <= inst_mem_out;
			IF_ID_register( 95 downto 32) <= Program_counter;
			
		end if;

	
	end process;
	
	DECODE_process : process(clk , IF_ID_register)
	
	variable rs1 : std_logic_vector( 4 downto 0);
	variable rs2 : std_logic_vector( 4 downto 0);
	variable rd : std_logic_vector( 4 downto 0);
	variable read_data1 : std_logic_vector( 31 downto 0); 
	variable read_data2 : std_logic_vector( 31 downto 0);  
	variable Branch :     std_logic;	
	variable MemRead :    std_logic;
	variable MemtoReg :   std_logic;
	variable MemWrite :   std_logic;
	variable ALUSrc :     std_logic;
	variable ALUOp :      std_logic_vector ( 1 downto 0);
	variable Imm_Gen_out: std_logic_vector( 63 downto 0) := (others => '0');
	variable alu_opcode : std_logic_vector( 3 downto 0) := "0000";
	variable imm_gen_shifted : std_logic_vector( 63 downto 0);
	variable RegWrite_tmp : std_logic := '0';
	
	begin	
	
	if rising_edge(clk)  then
			
			read_data1 := reg_bank( to_integer(unsigned( IF_ID_register(19 downto 15) )));
			read_data2 := reg_bank( to_integer(unsigned( IF_ID_register(24 downto 20) )));
			
			if RegWrite = '1' then
				 reg_bank( to_integer(unsigned( IF_ID_register(11 downto 7) ))) <= Write_Data;
			end if;
			
		
		case IF_ID_register(6 downto 0) is
		
			when "0110011" => -- R type ( Registe-Register)
					 Branch := '0';
                MemRead := '0';
                MemtoReg := '0';
					ALUOp := "10";
               MemWrite := '0';
               ALUSrc := '0';
               RegWrite_tmp := '1';
		   when "0010011" => -- I type ( Immediate )
				    Branch := '0';
                MemRead := '1';
                MemtoReg := '1';
                ALUOp := "10";
                MemWrite := '0';
                ALUSrc := '1';
                RegWrite_tmp := '1';
					 Imm_Gen_out := "0000000000000000000000000000000000000000000000000000" & IF_ID_register(31 downto 20);
			when "0000011" => -- ld
				    Branch := '0';
                MemRead := '1';
                MemtoReg := '1';
					ALUOp := "00";
               MemWrite := '0';
               ALUSrc := '1';
               RegWrite_tmp := '1';
					Imm_Gen_out := "0000000000000000000000000000000000000000000000000000" & IF_ID_register(31 downto 20);
			when "0100011" => -- sd
				    Branch := '0';
                MemRead := '0';
                MemtoReg := '1';
					ALUOp := "00";
               MemWrite := '1';
               ALUSrc := '1';
               RegWrite_tmp := '0';
					Imm_Gen_out := "0000000000000000000000000000000000000000000000000000" & IF_ID_register(31 downto 25) & IF_ID_register(11 downto 7);
			when others =>
					Branch := '0';
					MemRead := '0';
					MemtoReg := '0';
					ALUOp := "00";
					MemWrite := '0';
					ALUSrc := '0';
					RegWrite_tmp := '0';
		end case;
		
	-- Instruction decoding
	case ALUOp is 
				
				when "00" => -- add
					alu_opcode := "0010";
				when "01" => -- sub
					alu_opcode := "0110";
				when "10" => -- custom
						case IF_ID_register(14 downto 12) is
									when "000" =>
										if ID_EX_register(30) = '0' then
											alu_opcode := "0010"; -- add
										else
											alu_opcode := "0110"; -- sub
										end if;
		
									when "110" =>
										alu_opcode := "0001"; -- or
									when "111" =>
										alu_opcode := "0000"; -- and
									when others => 
										alu_opcode := "ZZZZ";							
						end case;
				when "11" => -- left for expansion
					alu_opcode := "ZZZZ";
				when others =>
					alu_opcode := "ZZZZ";
			end case;
			
			-- Next address calculation
				
			imm_gen_shifted := std_logic_vector(unsigned(Imm_Gen_out) sll 1);
			
			ID_EX_register( 3 downto 0) <= alu_opcode;
			ID_EX_register(35 downto 4) <= read_data1;
			ID_EX_register(67 downto 36) <= read_data2;
			ID_EX_register(72 downto 68) <= IF_ID_register(19 downto 15); -- rs1
			ID_EX_register(77 downto 73) <= IF_ID_register(24 downto 20); -- rs2
			ID_EX_register(82 downto 78) <= IF_ID_register(11 downto 7); -- rd
			ID_EX_register(83) <= Branch;
			ID_EX_register(84) <= MemRead;
			ID_EX_register(85) <= MemtoReg;
			ID_EX_register(86) <= MemWrite;
			ID_EX_register(87) <= RegWrite_tmp;
			ID_EX_register(151 downto 88) <= imm_gen_shifted;
			ID_EX_register(152) <= ALUSrc;
			ID_EX_register(216 downto 153) <= IF_ID_register( 95 downto 32); -- program counter
			
			
			end if;
			
		end process;
			
			
		EXECUTE_process : process( clk, ID_EX_register)	
		
		variable alu_input1 : std_logic_vector( 31 downto 0);
		variable alu_input2 : std_logic_vector( 31 downto 0);
		variable alu_input2_temp : std_logic_vector( 31 downto 0);
		variable alu_output : std_logic_vector( 31 downto 0);
		variable zero : std_logic := '0';
		variable new_address : std_logic_vector(63 downto 0);

		begin
		
			if rising_edge(clk) then
			
			new_address := std_logic_vector(unsigned(ID_EX_register(151 downto 88)) + unsigned(ID_EX_register(216 downto 153)));
			
				alu_input1 := ID_EX_register(35 downto 4);
				
				case ID_EX_register(152) is 
					when '0' => alu_input2 := ID_EX_register(67 downto 36); -- rs2
					when '1' => alu_input2 := 	ID_EX_register(119 downto 88); -- immediate( low 32 bits)
					when others =>  alu_input2 := (others => '0');
				end case;
			
				case id_ex_register(3 downto 0) is	
					when "0000" => alu_output := alu_input1 and alu_input2; -- and
					when "0001" => alu_output := alu_input1 or alu_input2; -- or
					when "0010" => alu_output := std_logic_vector(unsigned(alu_input1) + unsigned(alu_input2));-- add
					when "0110" =>
						alu_output := std_logic_vector(unsigned(alu_input1) - unsigned(alu_input2)); -- sub
							if unsigned(alu_input1) = unsigned(alu_input2) then -- zero flag generation
								zero := '1';
							else
								zero := '0';
							end if;
					when others => alu_output := (others => '0');
							
			end case;
			
			end if;
			
			EX_MEM_register( 63 downto 0) <= new_address;
			EX_MEM_register(64) <= zero;
			EX_MEM_register(96 downto 65) <= alu_output;
			EX_MEM_register(128 downto 97) <= ID_EX_register(67 downto 36); -- read_data2
			EX_MEM_register(133 downto 129) <= ID_EX_register(82 downto 78);
			EX_MEM_register(134) <= ID_EX_register(83); -- Branch
			EX_MEM_register(135) <= ID_EX_register(84); -- MemRead
			EX_MEM_register(136) <= ID_EX_register(85); -- MemtoReg
			EX_MEM_register(137) <= ID_EX_register(86); -- MemWrite
			EX_MEM_register(138) <= ID_EX_register(87); -- RegWrite
			
		
		end process;
		
		
			MEMORY_process : process(clk, ex_mem_register)
	begin
	
		if rising_edge(clk) then
		
			next_address <= 	EX_MEM_register( 63 downto 0);
			Branch_control <= EX_MEM_register(134) and EX_MEM_register(64);
		
			if EX_MEM_register(137) = '1' then -- write
				Data_memory( to_integer( unsigned( EX_MEM_register(96 downto 65)))) <= 	EX_MEM_register(128 downto 97);
    		end if;
			
			if EX_MEM_register(135) = '1' then -- read
				 mem_wb_register( 31 downto 0) <= Data_memory( to_integer( unsigned( EX_MEM_register(96 downto 65)))); 
			else 
				 mem_wb_register( 31 downto 0)  <= (others => '0');
			end if;
		
			mem_wb_register(65) <= ex_mem_register(136); -- MemtoReg
			mem_wb_register(64) <= ex_mem_register(138); -- RegWrite
			mem_wb_register( 63 downto 32) <= EX_MEM_register(96 downto 65);

		end if;			
	
	end process;
	
	WRITEBACK_process : process( clk , mem_wb_register)
	
	begin
	
		if rising_edge(clk) then
		
				case mem_wb_register(65) is -- MemtoReg
					when '1' => Write_Data <= mem_wb_register( 31 downto 0); --from memory
					when '0' => Write_Data <= mem_wb_register( 63 downto 32); -- alu_output
					when others => Write_Data <= (others => '0');
				end case;
				
				case mem_wb_register(64) is
					when '1' => RegWrite <= '1';
					when '0' => RegWrite <= '0';
					when others => RegWrite <= '0';
 				end case;
		
		izlaz <= mem_wb_register( 63 downto 32);
		
		end if;
	
	end process;
		
			
end Behavioral;