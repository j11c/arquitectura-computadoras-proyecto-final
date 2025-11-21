-------------------------------------------------------------------------------
--
-- Company : CETYS Universidad
-- Engineer: Cesar Emiliano Ahumada Meza
-- 
-- Create Date:    16/10/2025 17:58:37
-- Project Name:   Mux8_1
-- Module Name:    Mux8_1_tb.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para signed, unsigned

entity Mux8_1_tb is
end    Mux8_1_tb;

architecture Testbench of Mux8_1_tb is

   component Mux8_1
      port(
         E : in std_logic_vector(7 downto 0);
         S : out std_logic;
         SEL : in std_logic_vector(2 downto 0)
      );
   end component;

   -- Inputs/Outputs
   signal E : std_logic_vector(7 downto 0) := (others => '0');
   signal SEL : std_logic_vector(2 downto 0) := (others => '0');
   signal S : std_logic;


begin
   -- Instantiate the Unit Under Test (UUT)
   uut: Mux8_1 port map (
      E => E,
      S => S,
      SEL => SEL
   );


stim_proc: process
begin
   -- hold reset state for 100 ns
   wait for 100 ns;

   E <= "10101010";

   SEL <= "000";
   wait for 100 ns;
   
   SEL <= "001";
   wait for 100 ns;
   
   SEL <= "010";
   wait for 100 ns;
   
   SEL <= "011";
   wait for 100 ns;
   
   SEL <= "100";
   wait for 100 ns;
   
   SEL <= "101";
   wait for 100 ns;
   
   SEL <= "110";
   wait for 100 ns;
   
   SEL <= "111";
   wait for 100 ns;
   
   E <= "01010101";
   
   SEL <= "000";
   wait for 100 ns;
   
   SEL <= "011";
   wait for 100 ns;
   
   SEL <= "111";
   wait for 100 ns;

   wait;

end process;

end Testbench;
