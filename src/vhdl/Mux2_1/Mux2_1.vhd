-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    20/11/2025 13:46:52
-- Project Name:   Mux2_1
-- Module Name:    Mux2_1.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity Mux2_1 is
    port(
		SEL  : in  std_logic;
        A0   : in  std_logic_vector(9 downto 0);
        A1   : in  std_logic_vector(9 downto 0);
        S    : out std_logic_vector(9 downto 0)
    );
end Mux2_1;

architecture arq1 of Mux2_1 is
begin

	with SEL select
		S <= A0 when '0',
			 A1 when '1',	
			 x"000" when others;

end arq1;
