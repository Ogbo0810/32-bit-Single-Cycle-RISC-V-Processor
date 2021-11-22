----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:14:39 10/22/2021 
-- Design Name: 
-- Module Name:    mux_2 - Behavioral 
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

	entity mux_3 is 
		Port(
		data_in_1: in  std_logic_vector(31 downto 0);
		data_in_2: in  std_logic_vector(31 downto 0);
		data_in_3: in  std_logic_vector(31 downto 0);
		sel      : in  std_logic_vector(1 downto 0);
		data_out : out std_logic_vector(31 downto 0)
		);
	end mux_3;

	architecture Behavioral of mux_3 is

	begin

		process(data_in_1, data_in_2, data_in_3,sel )
			begin
				if    (sel = "00") then
					data_out <= data_in_1;
				elsif (sel = "01") then
					data_out <= data_in_2;
				elsif (sel = "10") then
					data_out <= data_in_3;
				else 
					data_out <= x"00000000"; 
				end if;
			end process;

	end Behavioral;

