	----------------------------------------------------------------------------------
	-- Company: 
	-- Engineer: 
	-- 
	-- Create Date:    16:10:34 11/05/2021 
	-- Design Name: 
	-- Module Name:    RISC_V_CONTROL_UNIT - Behavioral 
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

	entity RISC_V_CONTROL_UNIT is
	Port(
	     zero                  : in  std_logic;
		  --clk                   : in  std_logic;
		  funct_7_5             : in  std_logic; --BIT 5 of funct7(ie BIT 30 of the instruction)
		  funct_3               : in  std_logic_vector(2 downto 0);
		  opcode                : in  std_logic_vector(6 downto 0);
		  pc_src                : out std_logic;
		  result_src            : out std_logic_vector(1 downto 0);
		  dm_write_enable       : out std_logic;
		  alu_control           : out std_logic_vector(3 downto 0);
		  alu_src               : out std_logic;
		  imm_src_sel           : out std_logic_vector(2 downto 0);
		  reg_file_write_enable : out std_logic	  
	     );
	end RISC_V_CONTROL_UNIT;
	
	

	architecture Behavioral of RISC_V_CONTROL_UNIT is
	
	component m_decoder
	Port (
			opcode                : in  std_logic_vector(6 downto 0);
			branch ,jump          : out std_logic;
			result_src            : out std_logic_vector(1 downto 0);
			dm_write_enable       : out std_logic;
			alu_src               : out std_logic;
			imm_src_sel           : out std_logic_vector(2 downto 0);
			reg_file_write_enable : out std_logic;
			alu_op                : out std_logic_vector(1 downto 0)
			);
	end component;
	
	component a_decoder
	Port (
			funct_3     : in  std_logic_vector(2 downto 0);
			op_and_f7   : in  std_logic_vector(1 downto 0);
			alu_op      : in  std_logic_vector(1 downto 0);
			alu_control : out std_logic_vector(3 downto 0)	
			);
	end component;
   
	
	signal branch : std_logic;
	signal jump   : std_logic;
	signal alu_op : std_logic_vector(1 downto 0);
	signal con    : std_logic_vector(1 downto 0);

	begin	
	
	con <= opcode(5)&funct_7_5;
	--PC SRC AND GATE
   pc_src <= (zero and branch) or jump;
	
	
	--MAIN DECODER
	Main_Decoder : m_decoder 
	Port map (
		opcode                => opcode,
		branch                => branch,
		result_src            => result_src,
		dm_write_enable       => dm_write_enable,
		alu_src               => alu_src,
		imm_src_sel           => imm_src_sel,
		reg_file_write_enable => reg_file_write_enable,
		alu_op                => alu_op,
		jump                  => jump
	       	);
				
	---ALU DECODER
	ALU_Decoder : a_decoder
	Port map (
		op_and_f7      => con,
		funct_3        => funct_3,
		alu_op         => alu_op,
		alu_control    => alu_control
		);
	  
	end Behavioral;