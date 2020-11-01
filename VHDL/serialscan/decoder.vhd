library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity decoder is
port(clr: in std_logic;
		clk: in std_logic;
		bi: in std_logic_vector(3 downto 0):="0000";
		a: out std_logic:='0';
		b: out std_logic:='0';
		c: out std_logic:='0';
		d: out std_logic:='0';
		e: out std_logic:='0';
		f: out std_logic:='0';
		g: out std_logic:='0';
		n1,n2,n3,n4:out std_logic);
end decoder;

architecture display of decoder is
	signal s:std_logic_vector(6 downto 0);
	signal sel:integer:=0;
begin
	process(bi, clr)
	
	begin
		if clr = '0' then
			s<=(others =>'0');
		else
			case bi is				
				when "0000" => s <= B"100_0000";
				when "0001" => s <= B"111_1001";
				when "0010" => s <= B"010_0100";
				when "0011" => s <= B"011_0000";
				when "0100" => s <= B"001_1001";
				when "0101" => s <= B"001_0010";
				when "0110" => s <= B"000_0010";
				when "0111" => s <= B"101_1000";
				when "1000" => s <= B"000_0000";
				when "1001" => s <= B"001_0000";
				when others => s <= (others => '1');
			end case;
		end if;
	end process;
	
	process(clk)
	begin
		if(clk'event and clk='1') then
			if(sel=3)then
				sel<=0;
				n1<='0';
				n2<='1';
				n3<='1';
				n4<='1';
			elsif(sel=0)then
				sel<=1;
				n1<='1';
				n2<='0';
				n3<='1';
				n4<='1';
				
			elsif(sel=1)then
				sel<=2;
				n1<='1';
				n2<='1';
				n3<='0';
				n4<='1';
			elsif(sel=2)then
				sel<=3;
				n1<='1';
				n2<='1';
				n3<='1';
				n4<='0';
			end if;
		end if;
	end process;
	a <= s(0);
	b <= s(1);
	c <= s(2);
	d <= s(3);
	e <= s(4);
	f <= s(5);
	g <= s(6);
end display;
				

