----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:04:36 07/30/2021 
-- Design Name: 
-- Module Name:    reg_32bit - Behavioral 
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

entity reg_32bit is port (
clk,reset,load: in std_logic;
d             : in std_logic_vector(31 downto 0);
q             : out std_logic_vector(31 downto 0)
);
end reg_32bit;

architecture Behavioral of reg_32bit is 

begin

process(clk,reset)
     begin
      if(reset = '1') then
		   q <= "00000000000000000000000000000000";
		 elsif(rising_edge(clk)) then
		   IF (load = '1') THEN
			q <= d;
			END IF;
		 end if;
       end process;
end Behavioral;

