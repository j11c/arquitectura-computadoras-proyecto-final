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
		clk	 	: in  std_logic; 					 	-- Reloj general
		instr 	: in  std_logic_vector(9 downto 0);  	-- Instrucción
		inp 	: in  std_logic_vector(11 downto 0); 	-- Entrada de datos del exterior
		data_in	: in std_logic_vector(11 downto 0); 	-- Salida y entrada de datos memoria
		data_out: out std_logic_vector(11 downto 0); 	-- Salida y entrada de datos memoria
		PAddr 	: out std_logic_vector(9 downto 0);  	-- Dirección de memoria del programa
		DAddr 	: out std_logic_vector(9 downto 0);  	-- Dirección de memoria de datos
		RW 		: out std_logic; 					 	-- Escritura o Lectura Memoria de Datos
		--await	: out std_logic;						-- Awaiting External input
		halted	: out std_logic;						-- Signals when CPU is halted
		outp 	: out std_logic_vector(11 downto 0)  	-- Salida de datos al exterior
	);
end CPU;

architecture arq1 of CPU is

	-- ======================
	-- Componentes Especiales 
	-- ======================

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

	component UnidadControl is
		port(
			clk 	: in std_logic;
			instr 	: in std_logic_vector(9 downto 0);
			ctrl 	: out std_logic_vector(12 downto 0)
		);
	end component;

	component ALU is
		port(
			M0 	 : in  std_logic_vector(11 downto 0); -- Fuente
			M1 	 : in  std_logic_vector(11 downto 0); -- Destino
			COOP : in  std_logic_vector(3 downto 0);
			modo : in  std_logic_vector(1 downto 0);
			outp : out std_logic_vector(11 downto 0);
			NFZF : out std_logic_vector(1 downto 0)
		);
	end component;

	component RWIO is
		port(
            RW      : in std_logic;
            din     : in std_logic_vector(11 downto 0);
            dout    : out std_logic_vector(11 downto 0);
            bus_in  : in  std_logic_vector(11 downto 0);
            bus_out : out std_logic_vector(11 downto 0)
        );
	end component;

	-- ======================
	-- 		 Registros
	-- ======================

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

	-- ======================
	-- 	    Multiplexores
	-- ======================

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

	component Mux4_1 is
		port(
			SEL  : in  std_logic_vector(1 downto 0);
			A0   : in  std_logic_vector(11 downto 0);
			A1   : in  std_logic_vector(11 downto 0);
			A2   : in  std_logic_vector(11 downto 0);
			A3   : in  std_logic_vector(11 downto 0);
			S    : out std_logic_vector(11 downto 0)
		);
	end component;

	component Mux2_1 is
	    port(
			SEL  : in  std_logic;
			A0   : in  std_logic_vector(9 downto 0);
			A1   : in  std_logic_vector(9 downto 0);
			S    : out std_logic_vector(9 downto 0)
		);
	end component;

	-- ======================
	-- 	       Señales
	-- ======================

	-- Salidas registros 12 bits
	signal A_out, B_out, C_out, D_out, OutReg_out 	: std_logic_vector(11 downto 0) := (others => '0');
	signal MBR_out 						: std_logic_vector(11 downto 0) := (others => '0');

	-- Salidas registros 10 bits
	signal PMA_out, IR_out, MAR_out, pc_out : std_logic_vector(9 downto 0);

	-- Salidas multiplexores 12 bits
	signal M0_out, M1_out, MMBR_out : std_logic_vector(11 downto 0) := (others => '0');

	-- Salidas multiplexores 10 bits
	signal MMAR_out : std_logic_vector(9 downto 0);

	-- Bus de datos
	signal data_bus, memory_data, RWIO_out : std_logic_vector(11 downto 0) := (others => '0');

	-- Flag
	signal NFZF : std_logic_vector(1 downto 0) := (others => '0');
	
	-- CPU halt control: Program Counter Enable <= '0' when HALT
	signal halt, pc_enable : std_logic := '0';

	-- Control: Bus
	signal control_bus : std_logic_vector(12 downto 0) := (others => '0');

	-- Control: indices de señales
	constant BIT_LDOUT 	: integer := 11;
	constant BIT_LDPC 	: integer := 10;
	constant BIT_INCPC 	: integer := 9;
	constant BIT_LDPMA 	: integer := 8;
	constant BIT_LDIR 	: integer := 7;
	constant BIT_LDMBR 	: integer := 6;
	constant BIT_LDMAR 	: integer := 5;
	constant BIT_RW 	: integer := 4;
	constant BIT_LDA 	: integer := 3;
	constant BIT_LDB 	: integer := 2;
	constant BIT_LDC 	: integer := 1;
	constant BIT_LDD 	: integer := 0;

	-- Control: multiplexores
	signal MUX0_SEL, MUX1_SEL, MMBR_SEL : std_logic_vector(2 downto 0) := (others => '0');
	signal MMAR_SEL : std_logic := '0';

	-- Control: Auxiliar MMBR_SEL para entrada externa
	signal externalInput : std_logic := '0'; -- se pone en 1 cuando el COOP es IN (11000)

	-- Entrada MMBR: Dato Inmediato
	signal immediate_input : std_logic_vector(11 downto 0) := (others => '0');

	-- LDPC Override signal
	signal loadPC : std_logic := '0';
	
	-- RWIO
	signal rwio_dout : std_logic_vector(11 downto 0) := (others => '0');

begin

	-- CPU ENABLE/DISABLE
	halt <= '1' when IR_out(9 downto 6) = "1111" else '0'; -- HALT AHORA ES 1111
	pc_enable <= control_bus(BIT_INCPC) AND NOT(halt);

	-- LDPC Override
	loadPC <= '1' when IR_out(9 downto 4) = "110100" AND control_bus(BIT_LDPC) = '1' 				 else -- JMP
			  '1' when IR_out(9 downto 4) = "110101" AND NFZF = "10" AND control_bus(BIT_LDPC) = '1' else -- JLT
			  '1' when IR_out(9 downto 4) = "110110" AND NFZF = "00" AND control_bus(BIT_LDPC) = '1' else -- JGT
			  '1' when IR_out(9 downto 4) = "110111" AND NFZF = "01" AND control_bus(BIT_LDPC) = '1' else -- JEQ
			  '0';

	-- Bit auxiliar para selección MMBR: Activado cuando COOP es IN (11000)
	with IR_out(9 downto 5) select 
		externalInput <= '1' when "11000",
						 '0' when others;

	-- Señales de selección de los multiplexores
	MUX0_SEL <= IR_out(4) & IR_out(1 downto 0);
	MUX1_SEL <= "0" & IR_out(3 downto 2);
	MMBR_SEL <= "0" & externalInput & (IR_out(5) NAND IR_out(4));
	
	with IR_out(9 downto 6) select
		MMAR_SEL <= '1' when "1110",
					'0' when others;
	
	-- Build immediate input
	immediate_input <= IR_out(1 downto 0) & instr;

	-- CPU Outputs
	pAddr <= PMA_out;
	DAddr <= MAR_out;
	data_out <= rwio_dout;
	RW <= control_bus(BIT_RW);
	halted <= halt;
	outp <= OutReg_out;

	-- ======================
	-- Componentes Especiales 
	-- ======================

	PC : ProgramCounter port map (
		clk 	 => clk,
		reset 	 => '0',
		enable 	 => pc_enable,
		load 	 => loadPC, 
		jmp_addr => instr,
		pc_out 	 => pc_out
	);

	CU : UnidadControl port map (
		clk  => clk,
		instr => IR_out,
		ctrl => control_bus -- señales de control
	);

	UAL : ALU port map (
		M0 	 => M0_out,
		M1 	 => M1_out,
		COOP => IR_out(9 downto 6),
		modo => IR_out(5 downto 4),
		outp => data_bus,
		NFZF => NFZF
	);

	URWIO : RWIO port map (
		RW 		=> control_bus(BIT_RW),
		din     => data_in,
		dout 	=> rwio_dout, -- memory_data,
		bus_in 	=> data_bus,
		bus_out => RWIO_out
	);

	-- ======================
	-- 		 Registros
	-- ======================

	PMA : reg10 port map (
		CLK 	 => clk,
		LOAD 	 => control_bus(BIT_LDPMA),
		dato_in  => pc_out,
		dato_out => PMA_out
	);

	IR : reg10 port map (
		CLK 	 => clk,
		LOAD 	 => control_bus(BIT_LDIR),
		dato_in  => instr,
		dato_out => IR_out
	);

	MAR : reg10 port map (
		CLK 	 => clk,
		LOAD 	 => control_bus(BIT_LDMAR),
		dato_in  => MMAR_out,
		dato_out => MAR_out
	);

	MBR : reg12 port map (
		CLK 	 => clk,
		LOAD 	 => control_bus(BIT_LDMBR), -- Falta cambiar esta señal y modificar la unidad de control para que espere una entrada (que sea diferente de x"FFF")
		dato_in  => MMBR_out,
		dato_out => MBR_out
	);

	A : reg12 port map (
		CLK 	 => clk,
		LOAD 	 => control_bus(BIT_LDA),
		dato_in  => data_bus,
		dato_out => A_out
	);

	B : reg12 port map (
		CLK 	 => clk,
		LOAD 	 => control_bus(BIT_LDB),
		dato_in  => data_bus,
		dato_out => B_out
	);

	C : reg12 port map (
		CLK 	 => clk,
		LOAD 	 => control_bus(BIT_LDC),
		dato_in  => data_bus,
		dato_out => C_out
	);

	D : reg12 port map (
		CLK 	 => clk,
		LOAD 	 => control_bus(BIT_LDD),
		dato_in  => data_bus,
		dato_out => D_out
	);

	OutReg : reg12 port map (
		CLK 	 => clk,
		LOAD 	 => control_bus(BIT_LDOUT),
		dato_in  => data_bus,
		dato_out => OutReg_out
	);

	-- ======================
	-- 	    Multiplexores
	-- ======================

	MMAR : Mux2_1 port map (
		SEL => MMAR_SEL,
		A0  => instr,
		A1  => data_bus(9 downto 0),
		S	=> MMAR_out
	);

	MMBR : Mux8_1 port map (
		SEL => MMBR_SEL,
		A0  => immediate_input,
		A1  => RWIO_out,
		A2  => inp,
		A3  => inp,
		A4  => x"000",
		A5  => x"000",
		A6  => x"000",
		A7  => x"000",
		S   => MMBR_out
	);

	M0 : Mux8_1 port map ( -- Fuente
		SEL => MUX0_SEL,
		A0  => A_out,
		A1  => B_out,
		A2  => C_out,
		A3  => D_out,
		A4  => MBR_out,
		A5  => MBR_out,
		A6  => MBR_out,
		A7  => MBR_out,
		S   => M0_out
	);

	M1 : Mux8_1 port map ( -- Destino
		SEL => MUX1_SEL,
		A0  => A_out,
		A1  => B_out,
		A2  => C_out,
		A3  => D_out,
		A4  => x"000",
		A5  => x"000",
		A6  => x"000",
		A7  => x"000",
		S   => M1_out
	);

end arq1;
