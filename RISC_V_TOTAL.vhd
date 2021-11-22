	----------------------------------------------------------------------------------
	-- Company: 
	-- Engineer: 
	-- 
	-- Create Date:    11:56:30 11/10/2021 
	-- Design Name: 
	-- Module Name:    RISC_V_TOTAL - Behavioral 
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

	entity RISC_V_TOTAL is 
	
	Port (
				clk   : in std_logic;
				reset : in std_logic;
				dm_write_address	 :  out std_logic_vector (31 downto 0);
			   dm_write_data		 :  out std_logic_vector (31 downto 0);
				dm_write_enable    :  out std_logic				
	);
	end RISC_V_TOTAL;

	architecture Behavioral of RISC_V_TOTAL is

	COMPONENT RISC_V_CONTROL_UNIT
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
	END COMPONENT;


	COMPONENT RISC_V_DATAPATH
	Port (
					pc_src, alu_src, clk, reset    : in  std_logic;
					result_src                     : in  std_logic_vector(1 downto 0);
					dm_write_enble, reg_file_enable: in  std_logic;
					alu_control                    : in  std_logic_vector(3 downto 0);
					imm_src_sel                    : in  std_logic_vector(2 downto 0);
					zero                           : out std_logic;
					funct_7_5                      : out std_logic;
					funct_3                        : out std_logic_vector (2 downto 0);
					opcode                         : out std_logic_vector (6 downto 0);
					dm_write_address      		    : out std_logic_vector (31 downto 0);
					dm_write_data                  : out std_logic_vector (31 downto 0)
					);
	END COMPONENT;

	        signal pc_src                :  std_logic;
			  signal result_src            :  std_logic_vector(1 downto 0);
			  signal dm_write_enable_sig   :  std_logic;
			  signal alu_control           :  std_logic_vector(3 downto 0);
			  signal alu_src               :  std_logic;
			  signal imm_src_sel           :  std_logic_vector(2 downto 0);
			  signal reg_file_write_enable :  std_logic;
			  signal zero                  :  std_logic;
			  signal funct_7_5             :  std_logic;
			  signal funct_3               :  std_logic_vector (2 downto 0);
			  signal opcode                :  std_logic_vector (6 downto 0);
			  --signal dm_write_address		 :  std_logic_vector (31 downto 0);
			  --signal dm_write_data		 :  std_logic_vector (31 downto 0);
	begin
   
	dm_write_enable <= dm_write_enable_sig;
	  
	CONTROL_UNIT : RISC_V_CONTROL_UNIT
	Port map (
			  zero                  => zero,
			  --clk                   => clk,
			  funct_7_5             => funct_7_5,
			  funct_3               => funct_3,
			  opcode                => opcode,
			  pc_src                => pc_src,
			  result_src            => result_src,
			  dm_write_enable       => dm_write_enable_sig,
			  alu_control           => alu_control,
			  alu_src               => alu_src,
			  imm_src_sel           => imm_src_sel,
			  reg_file_write_enable => reg_file_write_enable
	
	         );

	
	DATAPATH : RISC_V_DATAPATH
	Port map (
	            clk                            => clk,
					reset                          => reset,
	            pc_src                         => pc_src,
					alu_src                        => alu_src,
					result_src                     => result_src,
					dm_write_enble                 => dm_write_enable_sig,
					reg_file_enable                => reg_file_write_enable,
					alu_control                    => alu_control,
					imm_src_sel                    => imm_src_sel, --(1 DOWNTO 0),
					zero                           => zero,
					funct_7_5                      => funct_7_5,
					funct_3                        => funct_3,
					opcode                         => opcode,
					dm_write_data						 => dm_write_data,
					dm_write_address					 => dm_write_address
	          );

	end Behavioral;

