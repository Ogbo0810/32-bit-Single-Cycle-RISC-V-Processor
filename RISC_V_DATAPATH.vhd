	----------------------------------------------------------------------------------
	-- Company: 
	-- Engineer: 
	-- 
	-- Create Date:    21:09:24 11/03/2021 
	-- Design Name: 
	-- Module Name:    RISC_V_DATAPATH - Behavioral 
	-- Project Name: 
	-- Target Devices: 
	-- Tool versions: 
	-- Description: 
	--
	-- Dependencies: 
	--
	-- Revision: 
	-- Revision 0.01 - File Created
	-- Additional Comments: 
	--
	----------------------------------------------------------------------------------
	library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;

	-- Uncomment the following library declaration if using
	-- arithmetic functions with Signed or Unsigned values
	--use IEEE.NUMERIC_STD.ALL;

	-- Uncomment the following library declaration if instantiating
	-- any Xilinx primitives in this code.
	--library UNISIM;
	--use UNISIM.VComponents.all;

	entity RISC_V_DATAPATH is
		Port (
		      pc_src, alu_src, clk, reset    : in  std_logic;
				result_src                     : in  std_logic_vector(1 downto 0);
				dm_write_enble, reg_file_enable: in  std_logic;
				alu_control                    : in  std_logic_vector(3 downto 0);
				imm_src_sel                    : in  std_logic_vector(2 downto 0);
				zero                           : out std_logic;
				funct_7_5                      : out std_logic; ----
				funct_3                        : out std_logic_vector (2 downto 0);
				opcode                         : out std_logic_vector (6 downto 0);
				dm_write_address               : out std_logic_vector (31 downto 0);
				dm_write_data                  : out std_logic_vector (31 downto 0)
				);
				
	end RISC_V_DATAPATH;

	architecture Behavioral of RISC_V_DATAPATH is
	
	--2 input multiplexer
	component mux_2
	Port(
		data_in_1, data_in_2 : in  std_logic_vector(31 downto 0);
		sel                  : in  std_logic;
		data_out             : out std_logic_vector(31 downto 0)
		);
	end component;

   --3 input multiplexer
	component mux_3
	Port(
		data_in_1: in  std_logic_vector(31 downto 0);
		data_in_2: in  std_logic_vector(31 downto 0);
		data_in_3: in  std_logic_vector(31 downto 0);
		sel      : in  std_logic_vector(1 downto 0);
		data_out : out std_logic_vector(31 downto 0)
		);
	end component;
	
	--ALU
	component ALU
	Port(
		data_in_1  : in  std_logic_vector(31 downto 0);
		data_in_2  : in  std_logic_vector(31 downto 0);
		data_out   : out std_logic_vector(31 downto 0);
		alu_control: in std_logic_vector (3 downto 0);
		zero       : out std_logic
     	  );
	end component;
	
	--PC + 4
	component PCPlus4
	Port (
	      data_in : in  std_logic_vector(31 downto 0);
			data_out: out std_logic_vector(31 downto 0)
	      );
	end component;
	
	
	--PC + Target
	component PCTarget
	Port (
	      data_in_1 : in  std_logic_vector(31 downto 0);
			data_in_2 : in  std_logic_vector(31 downto 0);
			data_out  : out std_logic_vector(31 downto 0)
	      );
	end component;
	
	--Data Memory
	component data_memory
	Port (
	      clk           : in  std_logic;
			write_enable  : in  std_logic;
			address       : in  std_logic_vector(31 downto 0);
			write_data    : in  std_logic_vector (31 downto 0);
			read_data     : out std_logic_vector (31 downto 0)
	      );
	end component;
	
	--Sign Extender
	component extender
	Port (
			imm_src_sel : in std_logic_vector(2 downto 0);
			data_in     : in  std_logic_vector(24 downto 0);
			data_out    : out std_logic_vector(31 downto 0)
			);
	end component;
	
	--Instruction Memory
	component instruction_m
	Port (
         --clk       : in std_logic;
         im_address  : in  std_logic_vector(4 downto 0);
         instruction : out std_logic_vector (31 downto 0)
         );
	end component;
	
	
	--Program Counter
	component program_counter
	Port(
		clk,reset      : in  std_logic;
		d              : in  std_logic_vector(31 downto 0);
		q              : out std_logic_vector(31 downto 0)
	     );
	end component;
	
	
	--Register File 32 Bit
	component register_file_32
	Port (
	clk,write_enable: in  std_logic;
	read_address_1  : in  std_logic_vector(4 downto 0);
	read_address_2  : in  std_logic_vector(4 downto 0);
	write_address   : in  std_logic_vector(4 downto 0);
	write_data      : in  std_logic_vector(31 downto 0);
	read_data_1     : out std_logic_vector(31 downto 0);
	read_data_2     : out std_logic_vector(31 downto 0)
	);
	end component;
	
	
	
	--SIGNALS
	signal plus4       : std_logic_vector(31 downto 0);
	signal plus_target : std_logic_vector(31 downto 0);
	signal pc_next     : std_logic_vector(31 downto 0);
	signal pc          : std_logic_vector(31 downto 0);
	signal instr       : std_logic_vector(31 downto 0);
	signal result      : std_logic_vector(31 downto 0);
	signal imm_ext     : std_logic_vector(31 downto 0);
	signal write_data  : std_logic_vector(31 downto 0);---------
	signal src_A       : std_logic_vector(31 downto 0);
	signal src_B       : std_logic_vector(31 downto 0);
	--signal zero_flag   : std_logic;
	signal alu_result  : std_logic_vector(31 downto 0);
	signal read_data   : std_logic_vector(31 downto 0);
	
	
	
	begin
	
	--PC MULTIPLEXER
	PC_MUX : mux_2 
	port map(
	         data_in_1 => plus4,
				data_in_2 => plus_target,
		      sel       => pc_src,
		      data_out  => pc_next
				);
   
	--PROGRAM COUNTER
	P_C : program_counter
	port map (
	          clk   => clk,
		       reset => reset,
		       d     => pc_next,
		       q     => pc
	          );
				 
	--INSTRUCTION MEMORY
	Instruction_Memory : instruction_m
	port map (
	          im_address  => pc(6 downto 2),
             instruction => instr 
		       );
				 
	--PCPlus4 ADDER
	Plus4_Adder : PCPlus4 
	port map(
	         data_in  => pc, 
			   data_out => plus4
	         );
	
	
	--REGISTER FILE
	Register_File : register_file_32
	port map (
	          clk             => clk,
				 write_enable    => reg_file_enable,				 
	          read_address_1  => instr(19 downto 15),
	          read_address_2  => instr(24 downto 20), 
	          write_address   => instr(11 downto 7), 
	          write_data      => result,
	          read_data_1     => src_A, 
	          read_data_2     => write_data 
	          );
				 
	--SIGN EXTENDER
	Sign_Extender : extender
	port map (
	          imm_src_sel => imm_src_sel,
			    data_in         => instr(31 downto 7), 
			    data_out        => imm_ext 
	          );
				 
	--SRC_B MULTIPLEXER
	Src_B_mux : mux_2
	port map(
	         data_in_1 => write_data,
				data_in_2 => imm_ext,
		      sel       => alu_src,
		      data_out  => src_B
	         );
				
	--ALU
	ALU_TOTAL : ALU
	port map (
	          data_in_1  => src_A, 
		       data_in_2  => src_B,				 
		       data_out   => alu_result,				 
		       alu_control=> alu_control,
		       zero       => zero 
	          );
				 
	--PlusTarget Adder
	PlusTarget_Adder : PCTarget
	port map (
	          data_in_1 => pc, 
			    data_in_2 => imm_ext, 
			    data_out  => plus_target 
	          );
				 
	--DATA MEMORY
	Data_Memory_Total : data_memory
	port map (
	          clk           => clk, 
			    write_enable  => dm_write_enble, 
			    address       => alu_result, 
			    write_data    => write_data, 
			    read_data     => read_data 
	          );
	dm_write_address  <= alu_result;
	dm_write_data  <= write_data;
	
	--RESULT MULTIPLEXER
	Result_Multiplexer : mux_3 
	port map (
	          data_in_1=> alu_result,				 
		       data_in_2=> read_data, 
		       data_in_3=> plus4, 
		       sel      => result_src, 
		       data_out => result 
	          );
				 
	--CONNECTING TO CONTROL UNIT
	funct_7_5 <= instr(30);
	opcode <= instr(6 downto 0);
	funct_3 <= instr(14 downto 12);

	end Behavioral;

