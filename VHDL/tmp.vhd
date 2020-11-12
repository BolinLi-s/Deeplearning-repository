library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity shiyan4 is
  port(clk_0 : in std_logic;  --系统时钟
       k1: in std_logic;  --选择按键
		 k2: in std_logic;  -- +1按键
       clk_1 : buffer std_logic := '1';  --输出1ms时钟
		 clk_2 : buffer std_logic := '1';  ----输出0.1s时钟
		 sel: buffer std_logic_vector(1 downto 0) := "00");  --判断当前选中的对象（00正常计数，01选中分钟，10选中小时）
end shiyan4;

architecture shiyan4_arch of shiyan4 is
   	signal t1 :integer := 25000;  --2*25000=50M/1KHz
		signal t2 :integer := 2500000;--2*2500000=50M/10Hz
		signal n: integer := 120;
		signal b: std_logic := '0';
begin  
	process(clk_0,k1,  k2)
		begin
			if clk_0'event and clk_0 = '1' then  --上升沿
			  b <= not b;
			  if t1 > 0 then
				     t1 <= t1 - 1;
			  else
			    clk_1 <= not clk_1;   --输出翻转
				 t1 <= 25000;
			  end if;
			--  进行加一操作
			if sel = "01" then   --选中分钟
			 	 clk_2 <= '0';    --暂停计数
				 if k2 = '0' then 
					  clk_2 <= '1';
				 else clk_2 <= '0';
				 end if;
			elsif sel = "10" then   --选中小时
				 if k2 = '0' then    --给分钟的个位六十个脉冲
					 if n > 0 then    
						   clk_2 <= b;
							n <= n - 1;
					 else
						   clk_2 <= '0';
					 end if;
				 else
					 clk_2 <= '0';    --暂停计数
					 n <= 120;
				 end if; 
			else                    --正常计数
			    if t2 > 0 then
				    t2 <= t2 - 1;
			    else
			       clk_2 <= not clk_2;
				    t2 <= 2500000;
			    end if;
			 end if;
			end if; 		
        end process;
        
	process(k1)             --进行选择
	begin
	   if k1'event and k1 = '0' then
		   if sel /= "10" then
			       sel <= sel + '1';
			 else sel <= "00";
			end if;
		 else 
			 sel <= sel;
		end if;
	end process;
end shiyan4_arch;
