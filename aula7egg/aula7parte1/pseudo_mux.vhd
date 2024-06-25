-- pseudo_mux - A Finite State Machine that mimics the behavior of mux
-- Copyright (C) 2018  Digital Systems Group - UFMG
-- 
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, see <https://www.gnu.org/licenses/>.
--

library IEEE;
use IEEE.std_logic_1164.all;

entity pseudo_mux is
    port 
	 (
        RESET   : in    std_logic;
        CLOCK   : in    std_logic;
        S       : in    std_logic;
        A,B,C,D : in    std_logic;
        Q       : out   std_logic
    );
end pseudo_mux;

	-----------------------------------------

architecture Moore_TPM of pseudo_mux is
	-- Declaracoes
		type estado is (SA,SB,SC,SD);
		signal estado_atual, proximo_estado : estado;
	
begin
	-----------------------------------------
	sequencial:
		process(CLOCK, RESET) is
		-- Declaracoes
		begin
			if(RESET = '1') then
				estado_atual <= SA;
			
			elsif(rising_edge(CLOCK)) then
				estado_atual <= proximo_estado;
			
			end if;
		end process;
		
   -----------------------------------------
	combinacional:
		process(estado_atual,S,A,B,C,D)
		-- Declaracoes
		begin
			case estado_atual is
				when SA => 
					Q <= A;
					if(S='1') then
						proximo_estado <= SB;
					else
						proximo_estado <= SA;
					end if;
					
				when SB => 
					Q <= B;
					if(S='1') then
						proximo_estado <= SC;
					else
						proximo_estado <= SB;
					end if;
					
				when SC => 
					Q <= C;
					if(S='1') then
						proximo_estado <= SD;
					else
						proximo_estado <= SC;
					end if;
					
				when SD => 
					Q <= D;
					if(S='1') then
						proximo_estado <= SA;
					else
						proximo_estado <= SD;
					end if;
			end case;
		end process;
end Moore_TPM;