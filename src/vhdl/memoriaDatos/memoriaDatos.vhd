-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    20/11/2025 18:26:21
-- Project Name:   memoriaDatos
-- Module Name:    memoriaDatos.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity memoriaDatos is
    port(
        clk     : in  std_logic;
        RW      : in  std_logic;
        addr    : in  std_logic_vector(9 downto 0);
        din     : in  std_logic_vector(11 downto 0);
        dout    : out std_logic_vector(11 downto 0)
    );
end memoriaDatos;

architecture arq1 of memoriaDatos is

    type mem_type is array (0 to 1023) of std_logic_vector(11 downto 0);
    signal RAM : mem_type := (others => x"000");

begin

    process(clk)
    begin
        if falling_edge(clk) then
            if RW = '1' then
                RAM(to_integer(unsigned(addr))) <= din; -- write
            end if;
        end if;
    end process;

    dout <= RAM(to_integer(unsigned(addr))); -- read always active

end arq1;

--entity memoriaDatos is
--	port(
--		clk	 : in  std_logic;
--		RW	 : in  std_logic;
--		addr : in  std_logic_vector(9 downto 0);
--        data : inout std_logic_vector(11 downto 0)
--	);
--end memoriaDatos;

--architecture arq1 of memoriaDatos is

--	type mem_type is array (0 to 1023) of std_logic_vector(11 downto 0);
--	signal RAM : mem_type := (others => x"000");
--	signal temp_data : std_logic_vector(11 downto 0) := (others => '0');

--begin

--    process(clk, RW, addr)
--    begin
--		temp_data <= RAM(to_integer(unsigned(addr)));
--        if falling_edge(clk) then
--            if RW = '1' then -- Write
--                RAM(to_integer(unsigned(addr))) <= data;
--				data <= (others => 'Z');
--			else -- Read
--				data <= temp_data;
--            end if;
--        end if;
--    end process;

--end arq1;
