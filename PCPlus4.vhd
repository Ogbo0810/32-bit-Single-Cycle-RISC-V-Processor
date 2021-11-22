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

entity PCPlus4 is
	Port (
	      data_in : in  std_logic_vector(31 downto 0);
			data_out: out std_logic_vector(31 downto 0)
	      );
end PCPlus4;

architecture Behavioral of PCPlus4 is

begin
	data_out <= std_logic_vector(unsigned(data_in) + 4 );

end Behavioral;

