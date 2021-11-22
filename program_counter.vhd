	----------------------------------------------------------------------------------
	-- Company: 
	-- Engineer: 
	-- 
	-- Create Date:    20:21:05 11/01/2021 
	-- Design Name: 
	-- Module Name:    program_counter - Behavioral 
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
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use IEEE.STD_LOGIC_ARITH.ALL;

	-- Uncomment the following library declaration if using
	-- arithmetic functions with Signed or Unsigned values
	use IEEE.NUMERIC_STD.ALL;

	-- Uncomment the following library declaration if instantiating
	-- any Xilinx primitives in this code.
	--library UNISIM;
	--use UNISIM.VComponents.all;

	entity program_counter is 
	Port(
		clk,reset      : in  std_logic;
		d              : in  std_logic_vector(31 downto 0);
		q              : out std_logic_vector(31 downto 0)
	     );
	end program_counter;


	architecture Behavioral of program_counter is


	begin

	process(clk,reset)
	  begin
			 if(reset = '1') then
				q <= "00000000000000000000000000000000";
			 elsif(rising_edge(clk)) then
				q <= d;
			 end if;
			 
	  end process;
		
	end Behavioral;

