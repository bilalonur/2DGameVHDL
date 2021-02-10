library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity clkDivider is
port ( clock,reset: in std_logic;
       clkDivided: out std_logic);
end clkDivider;
  
architecture behavioral of clkDivider is

signal temprorary : std_logic := '0';  
signal cntt: integer:=1;
  
begin
  
process(clock,reset)
begin
if(reset = '1') then
cntt <= 1;
temprorary <= '0';
elsif(clock'event and clock = '1') then
cntt <= cntt + 1;
if (cntt = 2) then
temprorary <= NOT temprorary;
cntt <= 1;
end if;
end if;
clkDivided <= temprorary;
end process;

end behavioral;