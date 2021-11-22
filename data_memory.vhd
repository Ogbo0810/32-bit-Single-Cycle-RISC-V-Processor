----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:09:12 11/03/2021 
-- Design Name: 
-- Module Name:    data_memory - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_memory is 
	Port (
	      clk           : in  std_logic;
			write_enable  : in  std_logic;
			address       : in  std_logic_vector(31 downto 0);
			write_data    : in  std_logic_vector (31 downto 0);
			read_data     : out std_logic_vector (31 downto 0)
	      );
	end data_memory;

	
architecture Behavioral of data_memory is

	type dm_type is array (0 to 15) of std_logic_vector(31 downto 0);
 
	signal dm : dm_type := (
                           others =>(others => '0')
							      );


begin
 
	process(clk)
		begin
			if(rising_edge(clk)) then
				IF (write_enable = '1')then
					dm(to_integer(unsigned(address(5 downto 2)))) <= write_data;
				END IF;
			end if;
		end process;

read_data <= dm(to_integer(unsigned(address(5 downto 2))));


end Behavioral;

