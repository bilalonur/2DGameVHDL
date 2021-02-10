library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity topModule is
	port(
		clk: in std_logic;
		btn: in std_logic_vector(3 downto 0); 
		sw: in std_logic_vector(3 downto 0);
		try: inout std_logic_vector(3 downto 0);
		Hsync: out std_logic;
		Vsync: out std_logic;
		vgaRed: out std_logic_vector(2 downto 0); 
		vgaGreen: out std_logic_vector(2 downto 0);
		vgaBlue: out std_logic_vector(1 downto 0);
		anodd: out std_logic_vector(3 downto 0);
		segmnt: out std_logic_vector(6 downto 0);
		pointcontrol: out std_logic
	);
end topModule;

architecture Behavioral of topModule is
    
	signal pixelX, pixelY: std_logic_vector(9 downto 0);
	signal pixX, pixY: unsigned(9 downto 0);
	signal blank: std_logic;
	signal lastColumn: std_logic;
	signal lastRow: std_logic;
	signal rgb: std_logic_vector(7 downto 0);
	signal rst: std_logic;
	signal HS: std_logic;
	signal VS: std_logic;
    signal GGon: boolean;	
	signal random: unsigned (pixelX'range) := (others => '0');
	signal clkE: std_logic;
    signal assetTop: unsigned(9 downto 0):= to_unsigned(200,10);
    signal assetLeft: unsigned(9 downto 0):= to_unsigned(100,10);
    signal assetOutlineOn,  enemyOn: std_logic;
    signal assetOutlineRgb, enemyRgb: std_logic_vector(7 downto 0);
    signal datadisp: std_logic_vector(15 downto 0);
    signal decimalin: std_logic_vector(3 downto 0);
    signal first: std_logic_vector(3 downto 0);
    signal righSevenD: std_logic_vector(7 downto 0);
    signal leftSevenD: std_logic_vector(7 downto 0);
    signal butonE0, buttonE0P, butonE1, buttonE1P: std_logic;
    
begin


vgaTimer: entity work.vgaTiming
           port map(clk=>clkE, reset=>rst, HS=>HS, VS=>VS, pixelX=>pixelX, pixelY=>pixelY, blank=>blank,
					lastColumn=>lastColumn, lastRow=>lastRow);

clkDivider: entity work.clkDivider
              port map (clock=>clk, clkDivided=>clkE, reset=>rst);

game: entity work.game
                   port map( clk => clkE, btn=>btn, btnE0out=>butonE0, buttonE0P=>buttonE0P, 
                             btnE1out=>butonE1, buttonE1P=>buttonE1P, 
                             random=>random,pixelX=>pixelX,pixelY=>pixelY, assetTop=>assetTop, 
                             assetTopOut=>assetTop, assetLeftOut=>assetLeft, GGon => GGon, 
                             assetOutlineOn=>assetOutlineOn, 
                             sw=>sw, try=>try,
                             enemyOnOut=>enemyOn, leftSevenD=>leftSevenD, 
                             righSevenD=>righSevenD, rgb=>rgb, vgaRed=>vgaRed, 
                             vgaGreen=>vgaGreen, vgaBlue=>vgaBlue, HS=>HS, VS=>VS, Hsync=>Hsync, Vsync=>Vsync, 
                             rst=>rst);

scoreDisplay: entity work.sevenSegment
              port map(clk=>clkE, datadisp=>datadisp, decimalin=>decimalin, first=>first, segmnt=>segmnt, pointcontrol=>pointcontrol, anodd=>anodd);
                         
btnPLS: entity work.btnPLS
                    port map (btn=>butonE0, btn2=>butonE1, clk=>clkE, reset=>rst, btnPLS=>buttonE0P, btnPLS2=>buttonE1P);

numberGenerator: entity work.random
                                     port map( pixelX=>pixelX, randomOut=>random, clk=>clkE, pixX=>pixX, pixY=>pixY);

drawModule: entity work.drawModule
                                  port map( blank=>blank, GGon=>GGon, assetTop=>assetTop, assetLeft=>assetLeft, assetOutlineOnOut=>assetOutlineOn, 
                                            enemyOn=>enemyOn, assetOutlineRgbOut=>assetOutlineRgb, 
                                            enemyRgbOut=>enemyRgb, 
                                            pixelX=>pixelX, pixelY => pixelY, rgb=>rgb);      
      first <= "0000";  
      decimalin <= "0100";
      pixX <= unsigned(pixelX);
      pixY <= unsigned(pixelY);
      datadisp <= leftSevenD & righSevenD;
  
 end Behavioral;