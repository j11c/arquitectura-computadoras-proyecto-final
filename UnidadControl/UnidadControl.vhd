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
		clk 	: in std_logic;
		instr 	: in std_logic_vector(9 downto 0);
		ctrl 	: out std_logic_vector(12 downto 0)
	);
end UnidadControl;

architecture arq1 of UnidadControl is

	-- Estructuras de memorias
	type memOper2Param is array(0 to 512) of std_logic_vector(19 downto 0);
	type memOper1Param is array(0 to 512) of std_logic_vector(19 downto 0);
	type memIndirecto is array(0 to 512) of std_logic_vector(19 downto 0);

	-- Contenidos
	signal Oper2Param : memOper2Param := (others => x"00000");
	signal Saltos 	  : memOper2Param := (others => x"00000");
	signal Oper1Param : memOper1Param := (others => x"00000");
	signal Indirecto  : memIndirecto  := (others => x"00000");

	signal control_signals : std_logic_vector(19 downto 0) := (others => '0');
	signal microCounter : unsigned(2 downto 0) := (others => '0');
	signal addr : std_logic_vector(8 downto 0) := (others => '0');
	signal coop : std_logic_vector(3 downto 0) := (others => '0');
	
begin
	
	coop <= instr(9 downto 6);
	addr <= instr(5 dwonto 0) & std_logic_vector(microCounter);
	
	with coop select control_signals <= 
		Oper2Param(to_integer(unsigned(addr))) when "0001",
		Oper2Param(to_integer(unsigned(addr))) when "0010",
		Oper2Param(to_integer(unsigned(addr))) when "0011",
		Oper2Param(to_integer(unsigned(addr))) when "0100",
		Oper2Param(to_integer(unsigned(addr))) when "0101",
		Oper2Param(to_integer(unsigned(addr))) when "0110",
		Oper2Param(to_integer(unsigned(addr))) when "1000",
		Oper2Param(to_integer(unsigned(addr))) when "1001",
		Oper1Param(to_integer(unsigned(addr))) when "0000",
		Oper1Param(to_integer(unsigned(addr))) when "0111",
		Oper1Param(to_integer(unsigned(addr))) when "1010",
		Oper1Param(to_integer(unsigned(addr))) when "1011",
		Saltos(to_integer(unsigned(addr))) when "1101",
		Indirecto(to_integer(unsigned(addr))) when "1110",
		x"00000" when others;

	process (clk, Instr, control_signals, addr)
	begin
		ctrl <= control_signals;
		if rising_edge(clk) then
			microCounter + 1;
		end if;
	end process;

end arq1;
