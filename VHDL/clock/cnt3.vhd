library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnt3 is
	port(clk:in std_logic;
			clr:in std_logic:='1';
			data:out std_logic_vector(3 downto 0);
			co:out std_logic);
end cnt3;

architecture behavior of cnt3 is
signal tmp:std_logic;
signal cnt:std_logic_vector(3 downto 0):="0010";
begin
	process(clk,clr)
	begin
		if( clr='0') then
			cnt<="0000";
			tmp<='0';
		
		elsif(clk'event and clk='1')then
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
		