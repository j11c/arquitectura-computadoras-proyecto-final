-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    20/11/2025 13:45:11
-- Project Name:   UnidadControl
-- Module Name:    UnidadControl.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity UnidadControl is
	port(
		clk : in std_logic;
		ctrl : out std_logic_vector(19 downto 0)
	);
end UnidadControl;

architecture arq1 of UnidadControl is
begin

end arq1;
