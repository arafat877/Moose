library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPU is

	port(
		clk : in std_logic;
		reset : in std_logic;
		cpu_out : out std_logic_vector(31 downto 0)
	);

end CPU;

architecture Behavioral of CPU is

-- components declaration

component Program_Counter is
	port(	
		clk : in std_logic; -- clock signal
		reset : in std_logic;
		pc_input : in std_logic_vector( 31 downto 0);
		pc_output : out std_logic_vector( 31 downto 0)
	);
end component;

component Register_Bank is
	port(
	     clk : in std_logic;
		  reset : in std_logic;
        read_reg1 : in std_logic_vector( 4 downto 0);
        read_reg2 : in std_logic_vector ( 4 downto 0);
        write_reg : in std_logic_vector ( 4 downto 0);
        write_data : in std_logic_vector ( 31 downto 0);
        read_data1 : out std_logic_vector ( 31 downto 0);
        read_data2 : out std_logic_vector ( 31 downto 0);
        reg_write : in std_logic
	);
end component;

component ImmGen is
	port(
		instruction : in std_logic_vector( 31 downto 0);
		output : out std_logic_vector( 11 downto 0)
	);
end component;

component Control_Unit is
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
end component;

component ALU_control is
    port(
        clk : in std_logic;
		  reset : in std_logic;
        instruction : in std_logic_vector ( 31 downto 0);
        ALUOp : in std_logic_vector ( 1 downto 0);
        alu_opcode : out std_logic_vector ( 3 downto 0 )  
    );
end component;

component ALU is 
port(  
	 clk : in std_logic;
	 reset : in std_logic;
    opcode : in std_logic_vector( 3 downto 0);
    input1 : in std_logic_vector ( 31 downto 0);
    input2 : in std_logic_vector ( 31 downto 0);
    output : out std_logic_vector ( 31 downto 0);
    zero : out std_logic := '0' -- zero flag
 );
end component;

component MUX_2to1 is 
    port(
        input1 : in std_logic_vector( 31 downto 0);
        input2 : in std_logic_vector ( 31 downto 0);
        output : out std_logic_vector ( 31 downto 0);
        sel : in std_logic
    );
end component;

component Inst_Memory is
	port(
		clk : in std_logic;
		read_address  : in std_logic_vector( 31 downto 0);
		mem_output : out std_logic_vector( 31 downto 0)
	);
end component;

component Data_memory is
	port(
		clk : in std_logic;
		write_data : in std_logic_vector( 31 downto 0);
		address : in std_logic_vector( 31 downto 0);
		MemRead : in std_logic;
		MemWrite : in std_logic;
		read_data : out std_logic_vector( 31 downto 0)
	);
end component;

component Adder is
	port(
		input1 : in std_logic_vector( 31 downto 0);
		input2 : in std_logic_vector( 31 downto 0);
		output : out std_logic_vector( 31 downto 0)
	);
end component;


-- Signals declaration
signal pc_input : std_logic_vector(31 downto 0);
signal pc_output : std_logic_vector(31 downto 0);
signal instruction : std_logic_vector( 31 downto 0);
signal Write_Data : std_logic_vector( 31 downto 0);
signal Read_Data1 : std_logic_vector( 31 downto 0);
signal Read_Data2 : std_logic_vector( 31 downto 0);
signal imm_gen_out : std_logic_vector(11 downto 0);
signal Branch, MemRead, MemtoReg, MemWrite, ALUSrc, Reg_write : std_logic;
signal ALUOp : std_logic_vector(1 downto 0);
signal alu_opcode : std_logic_vector( 3 downto 0);
signal alu_output : std_logic_vector( 31 downto 0);
signal zero : std_logic;
signal zeroes : std_logic_vector(19 downto 0) := (others => '0');
signal mux1_out : std_logic_vector(31 downto 0);
signal mux2_out : std_logic_vector(31 downto 0);
signal Mux1_input1 : std_logic_vector( 31 downto 0);
signal Data_mem_out : std_logic_vector(31 downto 0);
signal Branch_and_zero : std_logic;
signal imm_shifted : std_logic_vector( 31 downto 0);
signal adder_output : std_logic_vector( 31 downto 0);
signal add4_output : std_logic_vector( 31 downto 0);

begin

Mux1_input1 <= zeroes & imm_gen_out;
Branch_and_zero <= Branch and zero;
imm_shifted <= Mux1_input1(30 downto 0) & '0'; 

Prog_Cntr : Program_Counter port map(clk,reset,pc_input,pc_output);
Instruction_Memory : Inst_Memory port map(clk,pc_output,instruction);
Regs : Register_Bank port map(clk,reset,instruction(19 downto 15), instruction(24 downto 20), instruction(11 downto 7), Write_Data, Read_Data1, Read_Data2, Reg_write);
Immediate_Generation : ImmGen port map(instruction,imm_gen_out);
Cntrl : Control_Unit port map(instruction(6 downto 0) , Branch, MemRead, MemtoReg, MemWrite, ALUSrc, Reg_write, ALUOp);
ALUCntrl : ALU_control port map(clk, reset, instruction, ALUOp, alu_opcode);
Mux1 : Mux_2to1 port map(Mux1_input1, Read_Data2, mux1_out, ALUSrc );
ALUnit : ALU port map(clk, reset, alu_opcode, Read_Data1, mux1_out ,alu_output,zero );
DataMem : Data_memory port map(clk, Read_Data2, alu_output, MemRead, MemWrite, Data_mem_out);
Mux2 : Mux_2to1 port map(Data_mem_out, alu_output, Write_Data, MemtoReg);
Adder_component : Adder port map(imm_shifted, pc_output, adder_output);
Adder_component2 : Adder port map(pc_output, "00000000000000000000000000000100" ,add4_output);
Mux3 : Mux_2to1 port map(adder_output, add4_output, pc_input, Branch_and_zero);


	CPU_process : process(clk)
	begin
	
		if rising_edge(clk) then
			cpu_out <= alu_output;
		end if;
		
	end process;


end Behavioral;

