-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    30/11/2025 10:21:36
-- Project Name:   computadora_didactica
-- Module Name:    computadora_didactica.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity computadora_didactica is
	port( 
		clk		: in std_logic;
		entrada : in std_logic_vector(11 downto 0);
		salida	: out std_logic_vector(11 downto 0)
	);
end computadora_didactica;

architecture arq1 of computadora_didactica is

	component CPU is
		port(
			clk	 	: in  std_logic; 					 	-- Reloj general
			instr 	: in  std_logic_vector(9 downto 0);  	-- Instrucción
			inp 	: in  std_logic_vector(11 downto 0); 	-- Entrada de datos del exterior
			data	: inout std_logic_vector(11 downto 0); 	-- Salida y entrada de datos memoria
			PAddr 	: out std_logic_vector(9 downto 0);  	-- Dirección de memoria del programa
			DAddr 	: out std_logic_vector(9 downto 0);  	-- Dirección de memoria de datos
			RW 		: out std_logic;		 			 	-- Escritura o Lectura Memoria de Datos
			outp 	: out std_logic_vector(11 downto 0)  	-- Salida de datos al exterior
		);
	end component;

	component memoriaPrograma is
		port( 
			addr : in  std_logic_vector(9 downto 0);
			data : out std_logic_vector(9 downto 0)
		);
	end component;

	component memoriaDatos is
		port(
			clk	 : in  std_logic;
			RW	 : in  std_logic;
			addr : in  std_logic_vector(9 downto 0);
			data : inout std_logic_vector(11 downto 0)
		);
	end component;

	signal instruction, programAddress, dataAddress : std_logic_vector(9 downto 0) := (others => '0');
	signal data : std_logic_vector(11 downto 0) := (others => '0');
	signal dataMemoryRW : std_logic := '0';
	
begin

	U0 : CPU port map (
		clk	 	=> clk,
		instr 	=> instruction,
		inp 	=> entrada,
		data	=> data,
		PAddr 	=> programAddress,
		DAddr 	=> dataAddress,
		RW 		=> dataMemoryRW,
		outp 	=> salida
	);

	U1 : memoriaPrograma port map (
		addr => programAddress,
		data => instruction
	);

	U2 : memoriaDatos port map (
		clk	 => clk,
		RW	 => dataMemoryRW,
		addr => dataAddress,
		data => data
	);

end arq1;
