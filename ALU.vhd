----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:34:39 11/03/2021 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is 

	Port(
		data_in_1  : in  std_logic_vector(31 downto 0);
		data_in_2  : in  std_logic_vector(31 downto 0);
		data_out   : out std_logic_vector(31 downto 0);
		alu_control: in std_logic_vector (3 downto 0);
		zero       : out std_logic
     	  );
end ALU;

architecture Behavioral of ALU is

signal result  : std_logic_vector(31 downto 0);

begin
	
	
	--  with opcode select
	--  
	--  data_out <= data_in_1 and data_in_2 when "000",
	--	            data_in_1 or  data_in_2  when "001",
	--					std_logic_vector (unsigned(data_in_1) + unsigned(data_in_2)) when "010",
	--					std_logic_vector (unsigned(data_in_1) - unsigned(data_in_2)) when "011",
	--					data_in_1 xor  data_in_2  when "100",
	--					std_logic_vector (shift_left(unsigned(data_in_1)),to_integer (unsigned(data_in_2(4 downto 0))))  when "101",
	--					std_logic_vector (shift_right(unsigned(data_in_1)),to_integer (unsigned(data_in_2(4 downto 0))))  when "110",
	--					x"00000000" when others;
						

	process(data_in_1, data_in_2, alu_control)
		begin
			case alu_control is
			
				when "0001" => --ADDITION
				result <= std_logic_vector (unsigned(data_in_1) + unsigned(data_in_2));
				
				when "0010" => --SUBTRACTION
				result <= std_logic_vector (unsigned(data_in_1) - unsigned(data_in_2));
				
				when "0011" => -- AND
				result <= data_in_1 and data_in_2;
				
				when "0100" => -- OR
				result <= data_in_1 or data_in_2;
				
				when "0101" => -- XOR
				result <= data_in_1 xor data_in_2;
				
				when "0110" => -- SHIFT_LEFT
				result <= std_logic_vector(shift_left(unsigned(data_in_1),to_integer(unsigned(data_in_2(4 downto 0)))));
				
				when "0111" => -- SHIFT_RIGHT
				result <= std_logic_vector (shift_right(unsigned(data_in_1),to_integer(unsigned(data_in_2(4 downto 0)))));
				
				when "1000" => -- SET ON LESS THAN
					if (data_in_1 < data_in_2) then
						result <= x"00000001";
					else
						result <= x"00000000";
					end if;
						
				when "1001" => -- NOR
				result <= data_in_1 nor data_in_2;
				
				when others => -- NO OPERATION
				result <= x"00000000";	
			
			end case;       
		end process;
						
	data_out <= result;
	
	zero <= '1' when result = x"00000000" else	--zero = 1 when (data_in_1 = data_in_2)
	         '0';
		
		

end Behavioral;

