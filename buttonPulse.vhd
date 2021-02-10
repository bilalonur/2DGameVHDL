library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity btnPLS is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           btn,btn2 : in  STD_LOGIC;
           btnPLS, btnPLS2 : out  STD_LOGIC);
end btnPLS;

architecture stateArchitecture of btnPLS is
	type stt is (first, waiting, pulseStart, pulseStart2);
	signal cstate, nstate: stt;
begin

	process(clk, reset)
	begin
		if reset='1' then 
			cstate <= first;
		elsif clk'event and clk='1' then
			cstate <= nstate;
		end if;
	end process;

	process (cstate, btn, btn2)
	begin
	   	btnPLS <= '0';
        btnPLS2 <= '0';
		nstate <= cstate;
		
		case cstate is
			when waiting =>
                if btn='1'  then
                else
                    nstate <= first;
                end if;
                if btn2='1' then
                else
                   nstate <= first;
                end if;		
			when first =>
				if (btn='0')  then
					nstate <= first;
				else
					nstate <= pulseStart;
				end if;
				if (btn2='0') then

				else
				    nstate <= pulseStart2;
				end if;
				
			when pulseStart2 =>
                btnPLS2 <= '1';
                nstate <= waiting;	
                		
			when pulseStart =>
				btnPLS <= '1';
				nstate <= waiting;

		end case;
	end process;
	
end stateArchitecture;