library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnt10 is
	port(clk:in std_logic;
			clr:in std_logic;
			key1:in std_logic;
			key2:in std_logic;
			data:out std_logic_vector(3 downto 0);
			co:out std_logic:='0');
end cnt10;

architecture behavior of cnt10 is
signal tmp:std_logic;
signal cnt:std_logic_vector(3 downto 0):="0011";
signal key2_trigger:std_logic;
signal model:integer;
signal key2_tmp:std_logic;
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
	
	
	process(key2)
	begin
		if(key2_tmp='1')then 
			key2_trigger<='0';
			key2_tmp<='0';
		elsif(key2'event and key2='1' and model =1) then 
			if(key2_trigger='0')then
				key2_trigger<='1';
				key2_tmp<='1';
			end if;
		end if;
	end process;
	
	
	process(clk,clr)
	begin
		if( clr='0') then
			cnt<="0000";
			tmp<='0';
			
		elsif(key2_trigger='1')then
			if(cnt="1001")then
				cnt<="0000";
				tmp<='1';
			else
				cnt<=cnt+1;
				tmp<='0';
			end if;
			
		elsif(clk'event and clk='1'and model=0)then
			if(cnt="1001")then
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
		