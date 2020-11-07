library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnt3 is
	port(clk:in std_logic;
			clr:in std_logic:='1';
			key1:in std_logic;
			key2:in std_logic;
			data:out std_logic_vector(3 downto 0);
			co:out std_logic);
end cnt3;

architecture behavior of cnt3 is
signal tmp:std_logic;
signal cnt:std_logic_vector(3 downto 0);
signal model:integer;
signal key2_tmp:std_logic;
signal key2_trigger:std_logic;
begin

	process(key1)
	begin
		if(key1'event and key1='1') then
			model<=model+1;
		end if;
		if model=3 then
			model<=0;
		end if;
	end process;
	
	
	
	process(clk,clr)
	begin
		if( clr='0') then
			cnt<="0000";
			tmp<='0';
		
		elsif(clk'event and clk='1' and model=2)then
			if(cnt="0010")then
				cnt<="0000";
				tmp<='1';
			else
				cnt<=cnt+1;
				tmp<='0';
			end if;
			
		elsif(clk'event and clk='1' and model=0)then
			if(cnt="0010")then
				cnt<="0000";
				tmp<='1';
			else
				cnt<=cnt+1;
				tmp<='0';
			end if;
		end if;
	end process;
	
	co<=tmp;
	data<=cnt;
end behavior;
		