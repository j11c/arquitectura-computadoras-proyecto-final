-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    20/11/2025 13:45:11
-- Project Name:   UnidadControl
-- Module Name:    UnidadControl_tb.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para signed, unsigned

entity UnidadControl_tb is
end    UnidadControl_tb;

architecture Testbench of UnidadControl_tb is

   -- Component Declaration for the Unit Under Test (UUT)
   component UnidadControl
	port(
		clk 	: in std_logic;
		instr 	: in std_logic_vector(9 downto 0);
		ctrl 	: out std_logic_vector(12 downto 0)
	);
   end component;

   -- Select an architecture if needed (default is last one analyzed).
   --for uut: UnidadControl use entity WORK.UnidadControl(arq1);

   -- Inputs/Outputs
   signal instr : std_logic_vector(9 downto 0) := (others => '0');
   signal ctrl : std_logic_vector(12 downto 0);

   -- Clock (uncomment if needed)
   -- Sustituir <clock> por el nombre de puerto apropiado
   signal   clk : std_logic := '0';
   constant clock_period : time := 50 ns;
   signal   clock_on : boolean := true;

begin

   -- Instantiate the Unit Under Test (UUT)
   uut: UnidadControl port map ( 
		clk => clk,
		instr => instr,
		ctrl => ctrl
   );

-- Clock process (uncomment if needed)
-- Descomentar en caso de requerir senial de reloj
-- Sustituir <clock> por el nombre de puerto apropiado
clock_process : process
begin
   while (clock_on) loop
      clk <= '0';
      wait for clock_period/2;
      clk <= '1';
      wait for clock_period/2;
   end loop;
   --assert (false) report ("Finished") severity error;
   -- Wait forever
   wait;
 end process;

-- Stimulus process
stim_proc: process
begin
   -- hold reset state for 100 ns
   instr <= "1001110000";
   wait for 100 ns;

   ---------------------------------------------------------
   -- insert stimulus here
   ---------------------------------------------------------

   -- Test case 1
   wait for 1000 ns;
   -- assert (<condition>) report "Error case 1" severity error;

   -- Test case 2
   -- ... Asignaciones a seniales de entrada ...
   wait for 100 ns;
   -- assert (<condition>) report "Error case 2" severity error;

   -- Stop clock
   clock_on <= false;
   -- Wait forever
   wait;

end process;

end Testbench;
