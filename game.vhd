----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2020 19:24:20
-- Design Name: 
-- Module Name: game - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity game is
    Port ( clk: in std_logic;
           btn: in std_logic_vector(3 downto 0);
           sw: in std_logic_vector(3 downto 0); 
           try: out std_logic_vector(3 downto 0):="0000";
           GGOn: out boolean;
           random: in unsigned(9 downto 0);
           pixelX, pixelY: in std_logic_vector(9 downto 0);
           assetTop: in unsigned(9 downto 0);
           assetTopOut: out unsigned(9 downto 0);
           assetLeftOut: out unsigned(9 downto 0);
           assetOutlineOn: in std_logic;
           enemyOnOut: out std_logic;
           leftSevenD, righSevenD: out std_logic_vector(7 downto 0);
           rgb: in std_logic_vector(7 downto 0);
           vgaRed: out std_logic_vector(2 downto 0); 
           vgaGreen: out std_logic_vector(2 downto 0);
           vgaBlue: out std_logic_vector(1 downto 0);
           HS, VS: in std_logic;
           Hsync, Vsync: out std_logic;
           btnE0out,btnE1out: out std_logic;
           buttonE0P,buttonE1P: in std_logic;           
           rst: out std_logic
   );
end game;

architecture Behavioral of game is


constant BITS_OF_DEBOUNCE_TIMER: natural := 18;
signal debounceCounterValue, debounceCounterValueNext: unsigned( BITS_OF_DEBOUNCE_TIMER - 1 downto 0) := (others=>'0');
signal pixX, pixY: unsigned(9 downto 0);

type FSMstate is (gameInitial, gamePlaying);
signal fsmReg, fsmN: FSMstate;
signal butonE0, btnE0N: std_logic;
signal butonE1, btnE1N: std_logic;
signal upReg, upRegN: unsigned(4 downto 0) := "00000";
signal downReg, downRegN: unsigned(4 downto 0) := "00000";
signal assetDelay, assetDelayNext: unsigned(20 downto 0):= to_unsigned(0,21);
signal tryNum, tryNext: unsigned (3 downto 0);
signal leftSevenSegDataNext: std_logic_vector(7 downto 0) := (others=>'0');
signal rightSevenSegDataNext: std_logic_vector(7 downto 0) := (others=>'0');
signal scLeft, scLeftN, scRight, scRightN: unsigned (3 downto 0);
signal highScore, highScoreN: unsigned (7 downto 0);
signal assetTopNext, assetTopTemp, assetTopTemp2: unsigned(9 downto 0):= to_unsigned(200,10);
signal column1X, column1Y: unsigned (pixelX'range) := (others => '1');
signal column2X, column2Y: unsigned (pixelX'range) := (others => '1');
signal column3X, column3Y: unsigned (pixelX'range) := (others => '1');
signal column4X, column4Y: unsigned (pixelX'range) := (others => '1');
signal column1XN, column1YN: unsigned (9 downto 0) := (others => '1');
signal column2XN, column2YN: unsigned (9 downto 0):= (others => '1');
signal column3XN, column3YN: unsigned (9 downto 0):= (others => '1');
signal column4XN, column4YN: unsigned (9 downto 0):= (others => '1');
signal assetLeft: unsigned(9 downto 0);
signal enemyOn: std_logic;
signal crashMoment: std_logic;
signal swt: integer;
signal column1On, column2On, column3On, column4On, actionOn: std_logic := '0';    
signal dlyN, dly: Natural := 0; 




begin

pixX <= unsigned(pixelX);
pixY <= unsigned(pixelY);

process(clk, btn)
begin
    rst <='0';
    if btn(3)='1' then
        rst <= '1';
        dly <= 0;
        fsmReg <= gameInitial;
        assetTopTemp2 <= to_unsigned(200,10);
        assetDelay <= (others=>'0');
        scLeft <= (others => '0');
        scRight <= (others => '0');
        column1X <= (others => '0');
        column2X <= (others => '0');
        column3X <= (others => '0');
        column4X <= (others => '0');
        tryNum <= (others => '0');
        highScore <= (others => '0');
        GGon <= false;
    elsif (clk'event and clk='1') then
        Hsync <= HS;
        Vsync <= VS;
        vgaRed <= rgb(7 downto 5);
        vgaGreen <= rgb(4 downto 2);
        vgaBlue <= rgb(1 downto 0);
        assetTopTemp2 <= assetTopNext;
        assetDelay <= assetDelayNext;
        leftSevenD <= leftSevenSegDataNext;
        righSevenD <= rightSevenSegDataNext;
        fsmReg <= fsmN;
        debounceCounterValue <= debounceCounterValueNext;
        butonE0 <= btnE0N;
        butonE1 <= btnE1N;
        if buttonE0P='1' then
            GGon <= false;
            upReg <= "00111";  
        else
            upReg <= upRegN;
        end if;
        if buttonE1P='1' then
            GGon <= false;
            downReg <= "00111";
        else 
            downReg <= downRegN;
        end if;
        
        dly <= dlyN;
        column1X <= column1XN;
        column2X <= column2XN;
        column3X <= column3XN;
        column4X <= column4XN;
        column1Y <= column1YN;
        column2Y <= column2YN;
        column3Y <= column3YN;
        column4Y <= column4YN;
        scRight <= scRightN;
        scLeft <= scLeftN;
        tryNum <= tryNext;        
        highScore <= highScoreN;
        


        if sw(0) = '1' then
            swt <= 0;
        elsif sw(1) = '1' then
            swt <= 10;
        elsif sw(2) = '1' then
            swt <= 25;
        elsif sw(3) = '1' then
            swt <= 50;
        else
            swt <= 0;
        end if;
        
        if (crashMoment = '1' or (scLeft = 9 and scRight = 9)) then
            GGon <= true;
        end if;
        
    

  
        
    end if;
end process;

assetTopOut <= assetTopTemp2;

debounceCounterValueNext <= debounceCounterValue + 1;

btnE1N <= '1' when (btn(1)='1' and debounceCounterValue = 0) else
                              '0' when (btn(1)='0' and debounceCounterValue = 0) else
                            butonE1;
btnE1out<=butonE1;					

btnE0N <= '1' when (btn(0)='1' and debounceCounterValue = 0) else
                              '0' when (btn(0)='0' and debounceCounterValue = 0) else
                            butonE0;
btnE0out<=butonE0;
	 
actionOn <= '1' when dly = 200000 else '0';       
dlyN <= 0 when dly > 200000 else dly + 1;



column1On <= '1' when column1X <= (639+79) and column1X > 0 else '0';
column2On <= '1' when column2X <= (639+79) and column2X > 0 else '0';
column3On <= '1' when column3X <= (639+79) and column3X > 0 else '0';
column4On <= '1' when column4X <= (639+79) and column4X > 0 else '0';





enemyOn <= '1' when     (column1On='1' and (pixX >= column1X and pixX <column1X+50 and pixY >= column1Y and pixY < column1Y+200+swt)) or
                       (column2On='1' and (pixX >= column2X and pixX <column2X+50 and pixY >= column2Y and pixY < column2Y+200+swt)) or
                       (column3On='1' and (pixX >= column3X and pixX <column3X+50 and pixY >= column3Y and pixY < column3Y+200+swt)) or
                       (column4On='1' and (pixX >= column4X and pixX <column4X+50 and pixY >= column4Y and pixY < column4Y+200+swt))

                else '0';
enemyOnOut<=enemyOn;

crashMoment <= '1' when assetOutlineOn='1' and ( enemyOn='1') else '0';



	process(assetDelay, buttonE0P, upReg, downReg)
	begin
		if assetDelay=0 then
			if upReg/="00000" then
				upRegN <= '0' & upReg(4 downto 1);  
			else
				upRegN <= upReg;
			end if;
			if downReg/="00000" then
			    downRegN <= '0' & downReg(4 downto 1);
			else
                downRegN <= downReg;			    
			end if;
		else
			upRegN <= upReg;
			downRegN <= downReg;
		end if;
	end process;

	assetDelayNext <= assetDelay+10;
	assetTopTemp <= to_unsigned(200,10) when (fsmReg=gameInitial and (buttonE0P='1' or buttonE1P='1')) else
						  (assetTopTemp2 - upReg + downReg ) when assetDelay=0 and fsmReg/=gameInitial  
						  else assetTopTemp2;
						  

	assetTopNext <= assetTopTemp when (assetTopTemp>=0 and assetTopTemp<418) else  
							assetTop;
							
							
	assetLeft <= to_unsigned(100,10);
	assetLeftOut<= assetLeft;
	

    process (fsmReg, buttonE0P, buttonE1P, crashMoment, column1X, column2X, column3X, column4X, actionOn, 
             column1On, column2On, column3On, random, column1Y, column2Y, column3Y, column4Y) 
    begin

        fsmN <= fsmReg;
        column1XN <= column1X;
        column2XN <= column2X;
        column3XN <= column3X;
        column4XN <= column4X;
        column1YN <= column1Y;
        column2YN <= column2Y;
        column3YN <= column3Y;
        column4YN <= column4Y;
        
        case fsmReg is
            when gameInitial =>
                if (buttonE0P = '1' or buttonE1P= '1') then
                    fsmN <= gamePlaying;
                    column1XN <= to_unsigned((638+79), 10);        
                    column2XN <= (others => '1');
                    column3XN <= (others => '1');
                    column4XN <= (others => '1');
                    column1YN <= random;
                else
                    fsmN <= gameInitial;
                end if;
            when gamePlaying =>
                    if actionOn = '1' then
                        if column1On = '1' then
                            column1XN <= column1X - 1; 
                        end if;
                        if column2On = '1' then
                            column2XN <= column2X - 1;
                        end if;
                        if column3On = '1' then
                            column3XN <= column3X - 1;
                        end if;
                        if column4On = '1' then
                            column4XN <= column4X - 1;
                        end if;
                    end if;
                    
                    if column4X = 500 then    
                        column1XN <= to_unsigned((638+79), 10);
                        column1YN <= random;
                    end if;
                    if column3X = 500 then
                        column4XN <= to_unsigned((630+79),10);
                        column4YN <= random;
                    end if;
                    if column2X = 500 then
                        column3XN <= to_unsigned((638+79), 10);
                        column3YN <= random;
                    end if;
                    if column1X = 500 then
                        column2XN <= to_unsigned((638+79), 10);
                        column2YN <= random;
                    end if;
                    if crashMoment = '1' or (scLeft = 9 and scRight = 9) then
                        fsmN <= gameInitial;
                    else
                        fsmN <= gamePlaying;
                    end if;
        end case;
    end process;
    
tryNext <= tryNum+1 when (fsmReg=gameInitial and (buttonE0P='1' or buttonE1P='1')) else tryNum;                  
scLeftN <= scLeft + 1 when (assetLeft = column1X or assetLeft = column2X or assetLeft = column3X or assetLeft = column4X) and actionOn = '1' else  
                        (others => '0') when (fsmReg=gameInitial and (buttonE0P='1'or buttonE1P='1' )) or scLeft = 10 else
                        scLeft;
scRightN <= scRight + 1 when scLeft = 10 else
                        (others => '0') when (fsmReg=gameInitial and (buttonE0P='1' or buttonE1P='1' )) else
                        scRight;
highScoreN <= (scRight & scLeft) when ((scRight&scLeft) > highScore and crashMoment='1') else highScore;


leftSevenSegDataNext <= std_logic_vector(highScore);
try <= std_logic_vector(tryNum);
rightSevenSegDataNext <= std_logic_vector(scRight & scLeft);

end Behavioral;
