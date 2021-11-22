----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:44:21 11/03/2021 
-- Design Name: 
-- Module Name:    PCPlus4 - Behavioral 
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

entity PCTarget is
	Port (
	      data_in_1 : in  std_logic_vector(31 downto 0);
			data_in_2 : in  std_logic_vector(31 downto 0);
			data_out  : out std_logic_vector(31 downto 0)
	      );
end PCTarget;

architecture Behavioral of PCTarget is

begin
	data_out <= std_logic_vector(unsigned(data_in_1) + unsigned(data_in_2) );

end Behavioral;

