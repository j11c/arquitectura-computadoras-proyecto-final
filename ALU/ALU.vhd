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
		clk  : in  std_logic;
		M0 	 : in  std_logic_vector(11 downto 0); -- Fuente
		M1 	 : in  std_logic_vector(11 downto 0); -- Destino
		COOP : in  std_logic_vector(3 downto 0);
		modo : in  std_logic_vector(1 downto 0);
		outp : out std_logic_vector(11 downto 0);
		NFZF : out std_logic_vector(1 downto 0)
	);
end ALU;

architecture arq1 of ALU is
	signal temp_outp : unsigned(11 downto 0) := (others => '0');
	signal temp_nfzf : std_logic_vector(1 downto 0) := "00";
	signal mul_temp : std_logic_vector(23 downto 0) := (others => '0');
begin

	--mul_temp <= std_logic_vector(

--	process(clk)
--	   variable mul_temp : std_logic_vector(23 downto 0) := (others => '0');
--	begin
--		if rising_edge(clk) then
--			case COOP is
--				when x"0" => -- HALT (Parar ejecucion)
--					-- No hace algo
--
--				when x"1" => -- ADD (Suma)
--					temp_outp <= unsigned(M1) + unsigned(M0);
--
--				when x"2" => -- SUB (Resta)
--					temp_outp <= unsigned(M1) - unsigned(M0);
--				
--				when x"3" => -- MUL (Multiplicacion)
--					temp_outp <= unsigned(M1) * unsigned(M0);
--
--				when x"4" => -- DIV (Division)
--					temp_outp <= unsigned(M1) / unsigned(M0);
--
--				when x"5" => -- AND (Bitwise AND)
--					temp_outp <= unsigned(M1 AND M0);
--
--				when x"6" => -- OR (Bitwise OR)
--					temp_outp <= unsigned(M1 OR M0);
--
--				when x"7" => -- NOT (Bitwise NOT)
--					temp_outp <= unsigned(NOT M1);
--
--				when x"8" => -- CMP (Comparar)
--					-- Las flags se actualizan abajo del case
--					null;
--
--				when x"9" => -- LOAD (Cargar datos)
--					temp_outp <= unsigned(M0);
--
--				when x"A" => -- INC (Incrementar), DEC (Decrementar)
--					if modo(1) = '0' then
--						temp_outp <= unsigned(M1) + 1;
--					else
--						temp_outp <= unsigned(M1) - 1;
--					end if;
--					
--				when x"B" => -- SHL (Shift Left), SHR (Shift Right)
--					if modo(1) = '0' then
--						temp_outp <= unsigned( M1(10 downto 0) ) & '0';
--					else
--						temp_outp <= '0' & unsigned( M1(11 downto 1) );
--					end if;
--
--				when x"C" => -- in out
--					temp_outp <= unsigned(M0);
--
--				when x"D" => -- JMP
--					null;
--
--				when x"E" => -- LOAD INDIRECTO
--					temp_outp <= unsigned(M0); -- Valor viene de memoria
--
--				when x"F" => -- NOP
--					null;
--
--				when others =>
--					null;
--			end case;
--			 -- **Actualizar flags para TODAS las operaciones (excepto HALT/JMP/NOP)**
--            if COOP = x"8" then
--                -- CMP: comparar M1 vs M0 (no usa temp_outp)
--                if M1 < M0 then
--                    temp_nfzf <= "10"; -- NF=1, ZF=0
--                elsif M1 = M0 then
--                    temp_nfzf <= "01"; -- NF=0, ZF=1
--                else
--                    temp_nfzf <= "00"; -- NF=0, ZF=0
--                end if;
--            elsif COOP /= x"0" and COOP /= x"C" and COOP /= x"D" and COOP /= x"F" then
--                -- Operaciones que modifican temp_outp (ADD, SUB, MUL, etc.)
--                if temp_outp = 0 then
--                    temp_nfzf <= "01"; -- ZF=1
--                elsif temp_outp(11) = '1' then
--                    temp_nfzf <= "10"; -- NF=1 (negativo en complemento a 2)
--                else
--                    temp_nfzf <= "00"; -- positivo
--                end if;
--            end if;
--		end if;
--	end process;

	outp <= std_logic_vector(temp_outp);
	NFZF <= temp_nfzf;

end arq1;
