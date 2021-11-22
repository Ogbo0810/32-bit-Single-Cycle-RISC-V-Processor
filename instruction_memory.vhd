----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:58:27 11/02/2021 
-- Design Name: 
-- Module Name:    instruction_memory - Behavioral 
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

entity instruction_m is

--Generic (
--B : integer := 32;
--N : integer := 5
--);

Port (
--clk       : in std_logic;
im_address  : in  std_logic_vector(4 downto 0);
instruction : out std_logic_vector(31 downto 0)
);


end instruction_m;


architecture Behavioral of instruction_m is

type IM_type is array (0 to 31) of
std_logic_vector(31 downto 0);

signal IM : IM_type  := (
									0 =>  x"00800093",
									1 =>  x"00900113",
									2 =>  x"ffb10193",
									3 =>  x"0021c233",
									4 =>  x"002272b3",
									5 =>  x"00328333",
									6 =>  x"003323b3",
									7 =>  x"40720433",
									8 =>  x"00842123",
									9 =>  x"00f02483",--
									10 => x"0084f513",
									11 => x"00b56513",
									12 => x"00554593",
									13 => x"00f5a613",
									14 => x"feb600e3",
									15 => x"008001ef",
									16 => x"00b670b3",
									17 => x"00b621a3",
									18 => x"00108063",
								 others => (others => '0')
								 );
																
		

begin

process(im_address, IM)
  begin
    --if (rising_edge(clk)) then
	   instruction <= IM(to_integer(unsigned(im_address(4 downto 0))));
	 --end if;
end process;

end Behavioral;

