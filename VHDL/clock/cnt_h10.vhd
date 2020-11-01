library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnt_h10 is
	port(clk:in std_logic;
			clr:in std_logic;
			data:out std_logic_vector(3 downto 0);
			rst:out std_logic;
			co:out std_logic:='0');
end cnt_h10;

architecture behavior of cnt_h10 is
signal tmp:std_logic;
signal cnt:std_logic_vector(3 downto 0):="0011";
signal co_count:integer;
signal tmp_rst:std_logic;
begin
	process(clk,clr)
	begin
		if( clr='0') then
			cnt<="0000";
			tmp<='0';
			co_count<=0;
		
		elsif(clk'event and clk='1')then
			
			if(cnt="1001")then
				cnt<="0000";
				tmp<='1';
				co_count<=co_count+1;
			elsif(cnt="0011" and co_count=2)then
				cnt<="0000";
				co_count<=0;
				tmp_rst<='0';
			else
				cnt<=cnt+1;
				tmp<='0';
				tmp_rst<='1';
			end if;
		end if;
	end process;
	
	co<=tmp;
	data<=cnt;
	rst<=tmp_rst;
	
end behavior;
		