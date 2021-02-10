library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity drawModule is
    Port ( blank: in std_logic;
           GGon: in boolean;
           assetTop, assetLeft: in unsigned(9 downto 0);
           assetOutlineOnOut: out std_logic;
           enemyOn: in std_logic;
           assetOutlineRgbOut: out std_logic_vector(7 downto 0);
           enemyRgbOut: out std_logic_vector(7 downto 0);
           pixelX: in std_logic_vector(9 downto 0);
           pixelY: in std_logic_vector(9 downto 0);
           rgb: out std_logic_vector(7 downto 0));
end drawModule;

architecture Behavioral of drawModule is

signal pixX, pixY: unsigned(9 downto 0);
signal backRgb: std_logic_vector(7 downto 0);
signal GG_rgb: std_logic_vector(7 downto 0);
signal GG_on: std_logic;


signal assetOutlineOn: std_logic;
signal assetOutlineRgb: std_logic_vector(7 downto 0);
signal enemyRgb: std_logic_vector(7 downto 0);

begin

pixX <= unsigned(pixelX);
pixY <= unsigned(pixelY);
      
assetOutlineOnOut <= assetOutlineOn;
assetOutlineRgbOut <= assetOutlineRgb; 
enemyRgbOut <= enemyRgb;




-- asset karakteri draw
      assetOutlineOn <= '1' when
                    pixX >= assetLeft and pixX <assetLeft+50 and 
                    pixY >= assetTop and pixY < assetTop+50
                    else '0';

      
      GG_on <= '1' when GGon and
               ((pixX>=280 and pixX<=310 and pixY>=215 and pixY<=220) or
               (pixX>=280 and pixX<=285 and pixY>=215 and pixY<=265) or
               (pixX>=280 and pixX<=310 and pixY>=260 and pixY<=265) or
               (pixX>=305 and pixX<=310 and pixY>=235 and pixY<=265) or
               (pixX>=300 and pixX<=310 and pixY>=235 and pixY<=245) or
               (pixX>=330 and pixX<=360 and pixY>=215 and pixY<=220) or
               (pixX>=330 and pixX<=335 and pixY>=215 and pixY<=265) or
               (pixX>=330 and pixX<=360 and pixY>=260 and pixY<=265) or
               (pixX>=355 and pixX<=360 and pixY>=235 and pixY<=265) or
               (pixX>=350 and pixX<=360 and pixY>=235 and pixY<=245))
               else '0';
      
      assetOutlineRgb <= "11100000";  --kirmizi


--renkler rgb
	enemyRgb <= "00010110";		
    backRgb <= "00101101";
    GG_rgb <= "11100000";
    
    rgb <= (others=>'0')     when blank='1' else
               GG_rgb        when GG_on='1' else
               enemyRgb            when enemyOn='1' else
               assetOutlineRgb when assetOutlineOn='1' else
               backRgb; 
end Behavioral;