-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    20/11/2025 09:52:44
-- Project Name:   ProgramCounter
-- Module Name:    ProgramCounter.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity ProgramCounter is
    port(
        clk      : in  std_logic;
        reset    : in  std_logic;
        enable   : in  std_logic;
        load     : in  std_logic;
        jmp_addr : in  std_logic_vector(9 downto 0);
        pc_out   : out std_logic_vector(9 downto 0)
    );
end ProgramCounter;

architecture arq1 of ProgramCounter is
    signal pc_reg : unsigned(9 downto 0) := (others => '0'); -- direccion inicial (0)
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                pc_reg <= (others => '0'); 		-- reset a direccion inicial
            elsif load = '1' then
                pc_reg <= unsigned(jmp_addr);	-- saltos
            elsif enable = '1' then
                pc_reg <= pc_reg + 1;       	-- avance normal
            end if;
        end if;
    end process;

    pc_out <= std_logic_vector(pc_reg);

end arq1;
