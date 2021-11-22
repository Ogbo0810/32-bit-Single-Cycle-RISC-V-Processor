-----------------------------------------------------------------------------
	library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
--	use IEEE.NUMERIC_STD_UNSIGNED.ALL;
	use IEEE.NUMERIC_STD.ALL;

	-- Uncomment the following library declaration if using
	-- arithmetic functions with Signed or Unsigned values
	

	-- Uncomment the following library declaration if instantiating
	-- any Xilinx primitives in this code.
	--library UNISIM;
	--use UNISIM.VComponents.all;

	entity TB_RISC_V_TOTAL is
	end ;

	architecture test of TB_RISC_V_TOTAL is

	COMPONENT RISC_V_TOTAL
		Port (
				clk                :  in std_logic;
				reset              :  in std_logic;
				dm_write_address	 :  out std_logic_vector (31 downto 0);
			   dm_write_data		 :  out std_logic_vector (31 downto 0);
				dm_write_enable    :  out std_logic				
	    );
	END COMPONENT;
	

				signal reset, clk         : std_logic;
				signal dm_write_address	  : std_logic_vector (31 downto 0);
			   signal dm_write_data		  : std_logic_vector (31 downto 0);
				signal dm_write_enable    : std_logic; 


	begin
	
--	--Port mapping to the processor
--	TEST_BENCH : RISC_V_TOTAL 
--	Port map (
--          	clk                => clk_sig,
--				reset              => reset_sig,
--				dm_write_address	 => dm_write_address_sig,
--			   dm_write_data		 =>  dm_write_data_sig,
--				dm_write_enable    =>  dm_write_enable_sig				
--	);
--	
--	
--	clk_sig <= clk;
--	reset_sig <= reset;
--	dm_write_address_sig <= dm_write_address;
--	dm_write_data_sig <= dm_write_data;
--	dm_write_enable_sig <= dm_write_enable;


	RISC_V_TOP: RISC_V_TOTAL port map(clk, reset,  dm_write_address, dm_write_data, dm_write_enable);
	
	
	-- Generate clock to with 20ns period
	process
		begin
			clk <= '1';
			wait for 10ns;
			clk <= '0';
			wait for 10ns;
		end process;
		
		
	-- Generate reset for 22ns
	process
		begin
			reset <= '1';
			wait for 22ns;
			reset <= '0';
			wait;
		end process;
		
		
	-- Checking that the processor executes your example code
	
	process(clk)
		begin
			if (clk'event and clk = '0' and dm_write_enable = '1') then
				if (to_integer(unsigned(dm_write_address)) = 4 and to_integer(unsigned(dm_write_data)) = 14)  then
				
					report "Simulation success" severity failure;
				elsif (unsigned(dm_write_address) = 4 and dm_write_data /= 14) then
				
					report "Simulation failed" severity failure;
				end if;
			end if;
		end process;
		      
	end;

