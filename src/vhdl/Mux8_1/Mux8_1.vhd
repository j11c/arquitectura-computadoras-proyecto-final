-------------------------------------------------------------------------------
--
-- Company : CETYS Universidad
-- Engineer: Cesar Emiliano Ahumada Meza
-- 
-- Create Date:    16/10/2025 17:58:37
-- Project Name:   Mux8_1
-- Module Name:    Mux8_1.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity Mux8_1 is
    port(
		SEL  : in  std_logic_vector(2 downto 0);
        A0   : in  std_logic_vector(11 downto 0);
        A1   : in  std_logic_vector(11 downto 0);
        A2   : in  std_logic_vector(11 downto 0);
        A3   : in  std_logic_vector(11 downto 0);
        A4   : in  std_logic_vector(11 downto 0);
        A5   : in  std_logic_vector(11 downto 0);
        A6   : in  std_logic_vector(11 downto 0);
        A7   : in  std_logic_vector(11 downto 0);
        S    : out std_logic_vector(11 downto 0)
    );
end Mux8_1;

architecture arq1 of Mux8_1 is
begin
    
	with SEL select
		S <= A0 when "000",
			 A1 when "001",	
			 A2 when "010",
			 A3 when "011",
			 A4 when "100",
			 A5 when "101",
			 A6 when "110",
			 A7 when "111",
			 x"000" when others;

end arq1;
