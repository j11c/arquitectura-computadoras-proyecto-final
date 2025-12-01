-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    20/11/2025 09:17:15
-- Project Name:   reg12
-- Module Name:    reg12.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity reg12 is
	port( 
		CLK		: in  std_logic;
		LOAD	: in  std_logic;
		dato_in	: in  std_logic_vector(11 downto 0);
		dato_out: out std_logic_vector(11 downto 0)
	);
end reg12;

architecture arq1 of reg12 is
	signal temp: std_logic_vector(11 downto 0) := (others =>'0');
begin

	process (CLK)
	begin
		if rising_edge(CLK) then
			if LOAD = '1' then
				temp <= dato_in;
			end if;
		end if;
	end process;

	dato_out <= temp;

end arq1;
