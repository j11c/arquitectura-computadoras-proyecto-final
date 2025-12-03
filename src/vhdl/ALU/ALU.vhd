-------------------------------------------------------------------------------
--
-- Company : Universidad Miguel Hernandez
-- Engineer: joshi
-- 
-- Create Date:    16/10/2025 18:22:05
-- Project Name:   ALU
-- Module Name:    ALU.vhd
-- Description:
--
-- Additional Comments:
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  -- Para std_logic
use IEEE.numeric_std.all;     -- Para unsigned

entity ALU is
	port(
		M0 	 : in  std_logic_vector(11 downto 0); -- Fuente
		M1 	 : in  std_logic_vector(11 downto 0); -- Destino
		COOP : in  std_logic_vector(3 downto 0);
		modo : in  std_logic_vector(1 downto 0);
		outp : out std_logic_vector(11 downto 0);
		NFZF : out std_logic_vector(1 downto 0)
	);
end ALU;

architecture arq1 of ALU is
	signal temp_outp, temp_inc_dec, temp_shl_shr : unsigned(11 downto 0) := (others => '0');
	signal temp_nfzf 	: std_logic_vector(1 downto 0) := "00";
	signal mul_result 	: unsigned(23 downto 0) := (others => '0');
	--signal half_mul_result : unsigned(11 downto 0) := (others => '0');
begin

	-- Precalculations
	mul_result 	 <= unsigned(M1) * unsigned(M0);
	--half_mul_result <= mul_result(11 downto 0);
	temp_inc_dec <= unsigned(M1) + 1 when modo(1)='0' else 
					unsigned(M1) - 1;
	temp_shl_shr <= unsigned(M1(10 downto 0) & '0')   when modo(1) = '0' else
                 	unsigned('0' & M1(11 downto 1));

	-- ALU OUT select
    with COOP select
   	   temp_outp <= x"000" 						when "0000", -- HALT
                	unsigned(M1) + unsigned(M0) when "0001", -- ADD
                	unsigned(M1) - unsigned(M0) when "0010", -- SUB
                	mul_result(11 downto 0)     when "0011", -- MUL
                	unsigned(M1) / unsigned(M0)	when "0100", -- DIV
                	unsigned(M1 AND M0) 		when "0101", -- AND
                	unsigned(M1 OR M0) 			when "0110", -- OR
                	unsigned(NOT M1) 			when "0111", -- NOT
                	x"000"				 		when "1000", -- CMP
                	unsigned(M0)	 			when "1001", -- LOAD
                	temp_inc_dec 				when "1010", -- INC/DEC
                	temp_shl_shr 				when "1011", -- SHL/SHR
                	unsigned(M0) 				when "1100", -- IN/OUT
                	x"000" 						when "1101", -- JMP/JLT/JGT/JEQ
                	unsigned(M0) 				when "1110", -- ILOAD
                	x"000" 						when "1111", -- NOP
                	x"000" 						when others;

	NFZF <= "01" when temp_outp = x"000"  else -- NF=0, ZF=1
				 "10" when temp_outp(11) = '1' else -- NF=1, ZF=0
				 "00";

	outp <= std_logic_vector(temp_outp);

end arq1;
