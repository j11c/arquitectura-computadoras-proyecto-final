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
		salida	: out std_logic_vector(11 downto 0);
		halted	: out std_logic
	);
end computadora_didactica;

architecture arq1 of computadora_didactica is

	component CPU is
		port(
            clk         : in  std_logic;                          -- Reloj general
            instr     : in  std_logic_vector(9 downto 0);      -- Instrucción
            inp     : in  std_logic_vector(11 downto 0);     -- Entrada de datos del exterior
            data_in    : in std_logic_vector(11 downto 0);     -- Salida y entrada de datos memoria
            data_out: out std_logic_vector(11 downto 0);     -- Salida y entrada de datos memoria
            PAddr     : out std_logic_vector(9 downto 0);      -- Dirección de memoria del programa
            DAddr     : out std_logic_vector(9 downto 0);      -- Dirección de memoria de datos
            RW         : out std_logic;                          -- Escritura o Lectura Memoria de Datos
            --await    : out std_logic;                        -- Awaiting External input
            halted    : out std_logic;                        -- Signals when CPU is halted
            outp     : out std_logic_vector(11 downto 0)      -- Salida de datos al exterior
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
            clk     : in  std_logic;
            RW      : in  std_logic;
            addr    : in  std_logic_vector(9 downto 0);
            din     : in  std_logic_vector(11 downto 0);
            dout    : out std_logic_vector(11 downto 0)
        );
	end component;

	signal instruction, programAddress, dataAddress : std_logic_vector(9 downto 0) := (others => '0');
	signal cpu_data_out, cpu_data_in : std_logic_vector(11 downto 0) := (others => '0');
	signal dataMemoryRW : std_logic := '0';
	
begin

	U0_CPU : CPU port map (
		clk	 	=> clk,
		instr 	=> instruction,
		inp 	=> entrada,
		data_in	=> cpu_data_in,
		data_out=> cpu_data_out,
		PAddr 	=> programAddress,
		DAddr 	=> dataAddress,
		RW 		=> dataMemoryRW,
		halted	=> halted,
		outp 	=> salida
	);

	U1_PM : memoriaPrograma port map (
		addr => programAddress,
		data => instruction
	);

	U2_DM : memoriaDatos port map (
		clk	 => clk,
		RW	 => dataMemoryRW,
		addr => dataAddress,
		din  => cpu_data_out,
		dout => cpu_data_in
	);

end arq1;
