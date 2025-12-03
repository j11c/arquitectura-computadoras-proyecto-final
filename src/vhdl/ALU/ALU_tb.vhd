-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    16/10/2025 18:22:06
-- Project Name:   ALU
-- Module Name:    ALU_tb.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para signed, unsigned

entity ALU_tb is
end    ALU_tb;

architecture Testbench of ALU_tb is

   -- Component Declaration for the Unit Under Test (UUT)
   component ALU
	port(
		clk  : in  std_logic;
		M0 	 : in  std_logic_vector(3 downto 0);
		M1 	 : in  std_logic_vector(3 downto 0);
		COOP : in  std_logic_vector(2 downto 0);
		-- load : out std_logic_vector(3 downto 0); 
		outp : out std_logic_vector(3 downto 0)
		-- future ALU will need to give flags NFZF (Negative Flag / Zero Flag)
	);
   end component;

   -- Select an architecture if needed (default is last one analyzed).
   --for uut: ALU use entity WORK.ALU(arq1);

   -- Inputs/Outputs
   signal M0, M1, outp : std_logic_vector(3 downto 0) := (others => '0');
   signal COOP : std_logic_vector(2 downto 0) := (others => '0');

   -- Clock (uncomment if needed)
   -- Sustituir <clock> por el nombre de puerto apropiado
   signal   clk : std_logic := '0';
   constant clock_period : time := 50 ns;
   signal   clock_on : boolean := true;

begin

   -- Instantiate the Unit Under Test (UUT)
   uut: ALU port map ( 
		clk => clk,
		coop => COOP,
		M0 => M0,
		M1 => M1,
		outp => outp
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
   wait for 100 ns;

   ---------------------------------------------------------
   -- insert stimulus here
   ---------------------------------------------------------

   -- Test case 1
   M0 <= "1010";
   M1 <= "1110";
   COOP <= "000";
   wait for 100 ns;
   -- assert (<condition>) report "Error case 1" severity error;

   -- Test case 2
   M0 <= "1010";
   M1 <= "1110";
   COOP <= "001";
   wait for 100 ns;
   -- assert (<condition>) report "Error case 2" severity error;

   -- Test case 3
   M0 <= "1010";
   M1 <= "1110";
   COOP <= "010";
   wait for 100 ns;

   -- Test case 4
   M0 <= "0001";
   M1 <= "1110";
   COOP <= "011";
   wait for 100 ns;

   -- Test case 5
   M0 <= "1010";
   M1 <= "1110";
   COOP <= "100";
   wait for 100 ns;

   -- Test case 6
   M0 <= "1010";
   M1 <= "1110";
   COOP <= "101";
   wait for 100 ns;

   -- Test case 7
   M0 <= "1010";
   M1 <= "1110";
   COOP <= "110";
   wait for 100 ns;

   -- Test case 8
   M0 <= "1010";
   M1 <= "1110";
   COOP <= "111";
   wait for 100 ns;

   -- Stop clock
   clock_on <= false;
   -- Wait forever
   wait;

end process;

end Testbench;
