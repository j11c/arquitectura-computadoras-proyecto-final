-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    20/11/2025 09:52:45
-- Project Name:   ProgramCounter
-- Module Name:    ProgramCounter_tb.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para signed, unsigned

entity ProgramCounter_tb is
end    ProgramCounter_tb;

architecture Testbench of ProgramCounter_tb is

   -- Component Declaration for the Unit Under Test (UUT)
   component ProgramCounter
	port(
        clk      : in  std_logic;
        reset    : in  std_logic;
        enable   : in  std_logic;
        load     : in  std_logic;
        jmp_addr : in  std_logic_vector(9 downto 0);
        pc_out   : out std_logic_vector(9 downto 0)
    );
   end component;

   -- Select an architecture if needed (default is last one analyzed).
   --for uut: ProgramCounter use entity WORK.ProgramCounter(arq1);

   -- Inputs/Outputs
   signal reset, enable, load : std_logic := '0';
   signal jmp_addr, pc_out : std_logic_vector(9 downto 0) := (others => '0');

   -- Clock (uncomment if needed)
   -- Sustituir <clock> por el nombre de puerto apropiado
   signal   clk : std_logic := '0';
   constant clock_period : time := 50 ns;
   signal   clock_on : boolean := true;

begin

   -- Instantiate the Unit Under Test (UUT)
   uut: ProgramCounter port map ( 
		clk => clk,
		reset => reset,
		enable => enable,
		load => load,
		jmp_addr => jmp_addr,
		pc_out => pc_out
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
   reset <= '1';
   wait for 100 ns;
   reset <= '0';

   ---------------------------------------------------------
   -- insert stimulus here
   ---------------------------------------------------------

   -- Test case 1
   enable <= '1';
   wait for 100 ns;
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
