library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  

entity sevenSegment is
generic(DIVIDING_BITS: natural := 15);  
	port(
	clk: in std_logic;
	pointcontrol: out std_logic; 
    anodd: out std_logic_vector(3 downto 0);  	
	datadisp: in std_logic_vector(15 downto 0);  
	first: in std_logic_vector(3 downto 0); 
	decimalin: in std_logic_vector(3 downto 0);  
	segmnt: out std_logic_vector(6 downto 0)  
	);
end sevenSegment;

architecture Behavioral of sevenSegment is
    signal dcdsig: std_logic_vector(3 downto 0);
	signal cvalue: std_logic_vector(DIVIDING_BITS-1 downto 0) := (others=>'0'); 
	signal anodeS: std_logic_vector(1 downto 0);
	
begin
	process(clk)
	begin
		if (clk'event and clk='1') then
			cvalue <= std_logic_vector(unsigned(cvalue) + 1);
		end if;
	end process;
			
	anodeS <= cvalue(DIVIDING_BITS-1 downto DIVIDING_BITS-2);
	

	
	with anodeS select  
		dcdsig <=
			datadisp(3 downto 0) when "00",
			datadisp(7 downto 4) when "01",
			datadisp(11 downto 8) when "10",
			datadisp(15 downto 12) when others;
	
	
    with anodeS select
        anodd <=
            "111" & first(0) when "00",  
            "11" & first(1) & '1' when "01",
            '1' & first(2) & "11" when "10",
            first(3) & "111" when others;
            
            
	with anodeS select  
		pointcontrol <=
			not decimalin(0) when "00",
			not decimalin(1) when "01",
			not decimalin(2) when "10",
			not decimalin(3) when others;
			
	with dcdsig select  
	segmnt <= 	"1000000" when "0000",  
				"1111001" when "0001",  
				"0100100" when "0010",  
				"0110000" when "0011",  
				"0011001" when "0100",  
				"0010010" when "0101",  
				"0000010" when "0110",  
				"1111000" when "0111",  
				"0000000" when "1000",  
				"0010000" when "1001",  
				"0001000" when "1010",  
				"0000011" when "1011",  
				"1000110" when "1100",  
				"0100001" when "1101",  
				"0000110" when "1110",  
				"0001110" when others;  
	
end Behavioral;
