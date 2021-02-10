library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vgaTiming is

	port(
		clk, reset: in std_logic;
		HS, VS: out std_logic;
		pixelX, pixelY: out std_logic_vector(9 downto 0);
		lastColumn, lastRow, blank: out std_logic
	);
end vgaTiming;

architecture arch of vgaTiming is
	signal horizontalPixelCounter: unsigned(9 downto 0);  --to cntt to 800
	signal horizontalPixelCounterNext: unsigned(9 downto 0);
	signal verticalPixelCounter: unsigned(9 downto 0);  --to cntt to 521
	signal verticalPixelCounterNext: unsigned(9 downto 0);
begin

	process(clk, reset)
	begin
		if (reset='1') then
			horizontalPixelCounter <= (others=>'0');
			verticalPixelCounter <= (others=>'0');
		elsif (clk'event and clk='1') then
			horizontalPixelCounter <= horizontalPixelCounterNext;
			verticalPixelCounter <= verticalPixelCounterNext;
		end if;
	end process;

	
	horizontalPixelCounterNext <= (others=>'0') when (horizontalPixelCounter = 799) else  --0 is first pixel 639 is last pixel
											horizontalPixelCounter + 1;
											
	verticalPixelCounterNext <= (others=>'0') when (verticalPixelCounter = 520 and horizontalPixelCounter = 799) else  --0 is first row 479 is last row
											verticalPixelCounter + 1 when (horizontalPixelCounter = 799) else
											verticalPixelCounter;
											
	HS <= '0' when (horizontalPixelCounter > 639+16 and horizontalPixelCounter < 800-48) else '1';
	VS <= '0' when (verticalPixelCounter > 479+10 and verticalPixelCounter < 521-29) else '1';
	
	pixelX <= std_logic_vector(horizontalPixelCounter);
	pixelY <= std_logic_vector(verticalPixelCounter);
											
	lastColumn <= '1' when horizontalPixelCounter = 639 else '0';
	lastRow <= '1' when verticalPixelCounter = 479 else '0';
	
	blank <= '1' when (horizontalPixelCounter >= 640 or verticalPixelCounter >= 480) else '0';
	
end arch;
