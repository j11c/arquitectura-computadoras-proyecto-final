-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    20/11/2025 13:33:39
-- Project Name:   reg10
-- Module Name:    reg10.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity reg10 is
	port( 
		CLK		: in  std_logic;
		LOAD	: in  std_logic;
		dato_in	: in  std_logic_vector(9 downto 0);
		dato_out: out std_logic_vector(9 downto 0)
	);
end reg10;

architecture arq1 of reg10 is
	signal temp: std_logic_vector(3 downto 0) := x"0";
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
