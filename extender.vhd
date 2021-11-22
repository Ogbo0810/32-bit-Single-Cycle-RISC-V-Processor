----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:16:50 11/03/2021 
-- Design Name: 
-- Module Name:    extender - Behavioral 
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

entity extender is 
	Port (
			imm_src_sel : in std_logic_vector(2 downto 0);
			data_in     : in  std_logic_vector(24 downto 0);
			data_out    : out std_logic_vector(31 downto 0)
			);
	end extender;

architecture Behavioral of extender is

signal sig  : std_logic_vector(19 downto 0);
signal sig1 : std_logic_vector(11 downto 0);
	
begin
--data_out <= (others => data_in(24)) & data_in;
	sig <= (others =>  data_in(24));
	sig1 <= (others => data_in(24));
	process(data_in, imm_src_sel, sig, sig1)
	begin
		case (imm_src_sel) is 
			-- I-TYPE
			when "000" => 
				data_out <=  sig & data_in(24 downto 13);
				
			-- S-Type
			when "001" =>
				data_out <=  sig & data_in(24 downto 18) &  data_in(4 downto 0);
				
			-- B-Type
			when "010" =>
				data_out <=  sig & data_in(0) & data_in(23 downto 18) &  data_in(4 downto 1) & '0';
				
				
			-- J-Type
			when "011" =>
				data_out <=  sig1 & data_in(12 downto 5) & data_in(13) & data_in(23 downto 14) & '0';
				
		   -- U-Type
			--when "100" =>
			--	data_out <=  sig1 & data_in(24 downto 5);
				
			-- NO OPERATION
			when others => 
				data_out <=  (others => '0');
			
		end case;		
	end process;



end Behavioral;

