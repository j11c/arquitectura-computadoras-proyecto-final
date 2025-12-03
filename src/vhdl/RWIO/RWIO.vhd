-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    28/11/2025 13:24:51
-- Project Name:   RWIO
-- Module Name:    RWIO.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity RWIO is
    port(
        RW      : in std_logic;
        din     : in std_logic_vector(11 downto 0);
        dout    : out std_logic_vector(11 downto 0);
        bus_in  : in  std_logic_vector(11 downto 0);
        bus_out : out std_logic_vector(11 downto 0)
    );
end RWIO;

architecture arq1 of RWIO is
begin
    bus_out <= din;
    
    dout <= bus_in when RW='1' else (others => 'Z');

end arq1;

--entity RWIO is
--    port( 
--		RW : in std_logic;
--		data 	: inout std_logic_vector(11 downto 0);
--		bus_in 	: in 	std_logic_vector(11 downto 0);
--		bus_out : out 	std_logic_vector(11 downto 0)
--	);
--end RWIO;

--architecture arq1 of RWIO is
--begin

--	process(data, RW, bus_in)
--	begin
--		if RW = '0' then
--			bus_out <= data;
--			data <= (others => 'Z');
--		else
--			data <= bus_in;
--		end if;
--	end process;

--end arq1;
