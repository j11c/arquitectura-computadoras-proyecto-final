-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    20/11/2025 13:34:28
-- Project Name:   CPU
-- Module Name:    CPU.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity CPU is
	port(
		clk	 	: in  std_logic; 					 -- Reloj general
		instr 	: in  std_logic_vector(9 downto 0);  -- Instrucción
		inp 	: in  std_logic_vector(11 downto 0); -- Entrada de datos del exterior
		PAddr 	: out std_logic_vector(9 downto 0);  -- Dirección de memoria del programa
		DAddr 	: out std_logic_vector(9 downto 0);  -- Dirección de memoria de datos
		RW 		: out std_logic_vector; 			 -- Escritura o Lectura Memoria de Datos
		outp 	: out std_logic_vector(11 downto 0)  -- Salida de datos al exterior
	);
end CPU;

architecture arq1 of CPU is

	component ALU is
		port(
			clk  : in  std_logic;
			M0 	 : in  std_logic_vector(11 downto 0); -- Fuente
			M1 	 : in  std_logic_vector(11 downto 0); -- Destino
			COOP : in  std_logic_vector(3 downto 0);
			modo : in  std_logic_vector(1 downto 0);
			outp : out std_logic_vector(11 downto 0);
			NFZF : out std_logic_vector(1 downto 0)
		);
	end component;

	component reg12 is
		port( 
			CLK		: in  std_logic;
			LOAD	: in  std_logic;
			dato_in	: in  std_logic_vector(11 downto 0);
			dato_out: out std_logic_vector(11 downto 0)
		);
	end component;

	component reg10 is
		port( 
			CLK		: in  std_logic;
			LOAD	: in  std_logic;
			dato_in	: in  std_logic_vector(9 downto 0);
			dato_out: out std_logic_vector(9 downto 0)
		);
	end component;

	component ProgramCounter is
		port(
			clk      : in  std_logic;
			reset    : in  std_logic;
			enable   : in  std_logic;
			load     : in  std_logic;
			jmp_addr : in  std_logic_vector(9 downto 0);
			pc_out   : out std_logic_vector(9 downto 0)
		);
	end component;

	component Mux8_1 is
	    port(
			SEL  : in  std_logic_vector(2 downto 0);
			A0   : in  std_logic_vector(11 downto 0);
			A1   : in  std_logic_vector(11 downto 0);
			A2   : in  std_logic_vector(11 downto 0);
			A3   : in  std_logic_vector(11 downto 0);
			A4   : in  std_logic_vector(11 downto 0);
			A5   : in  std_logic_vector(11 downto 0);
			A6   : in  std_logic_vector(11 downto 0);
			A7   : in  std_logic_vector(11 downto 0);
			S    : out std_logic_vector(11 downto 0)
		);
	end component;

	component Mux2_1 is
	    port(
			SEL  : in  std_logic;
			A0   : in  std_logic_vector(11 downto 0);
			A1   : in  std_logic_vector(11 downto 0);
			S    : out std_logic_vector(11 downto 0)
		);
	end component;

	component UnidadControl is
		port(
			clk : in std_logic;
			ctrl : out std_logic_vector(19 downto 0)
		);
	end component;

	-- Señales

begin

	PC : ProgramCounter port map (
		clk 	 => open,
		reset 	 => open,
		enable 	 => open,
		load 	 => open,
		jmp_addr => open,
		pc_out 	 => open
	);

	PMA : reg10 port map (
		CLK 	 => open,
		LOAD 	 => open,
		dato_in  => open,
		dato_out => open
	);

	IR : reg10 port map (
		CLK 	 => open,
		LOAD 	 => open,
		dato_in  => open,
		dato_out => open
	);

	A : reg12 port map (
		CLK 	 => open,
		LOAD 	 => open,
		dato_in  => open,
		dato_out => open
	);

	B : reg12 port map (
		CLK 	 => open,
		LOAD 	 => open,
		dato_in  => open,
		dato_out => open
	);

	C : reg12 port map (
		CLK 	 => open,
		LOAD 	 => open,
		dato_in  => open,
		dato_out => open
	);

	D : reg12 port map (
		CLK 	 => open,
		LOAD 	 => open,
		dato_in  => open,
		dato_out => open
	);

	M0 : Mux8_1 port map (
		A0 => open,
		A1 => open,
		A2 => open,
		A3 => open,
		A4 => open,
		A5 => open,
		A6 => open,
		A7 => open,
		S  => open
	);

	M1 : Mux8_1 port map (
		A0 => open,
		A1 => open,
		A2 => open,
		A3 => open,
		A4 => open,
		A5 => open,
		A6 => open,
		A7 => open,
		S  => open
	);

	UAL : ALU port map (
		M0 	 => open,
		M1 	 => open,
		COOP => open,
		modo => open,
		outp => open,
		NFZF => open
	);

	CU : UnidadControl port map (
		clk  => open,
		ctrl => open
	);

end arq1;
