LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY divider IS
	PORT(clkin:IN STD_LOGIC;
		key1:in std_LOGIC;
		key2:in std_LOGIC;
		clk_1ms:OUT STD_LOGIC:='0';
		clk_100ms:OUT STD_LOGIC:='0');
END divider;
ARCHITECTURE clk_div_behavior OF divider IS
	SIGNAL counter1:integer:=0;
	SIGNAL counter2:integer:=0;
	SIGNAL temp1:STD_LOGIC:='0';
	SIGNAL temp2:STD_LOGIC:='0';
	signal co1:integer:=1;
	signal co2:integer:=60;
	signal key2_tmp:std_LOGIC;
	signal model:integer:=0;
	signal trigger:std_LOGIC;
BEGIN

	process(key1)
	begin
		if(key1'event and key1='1')then
			model<=model+1;
			if(model>=2 or model<0)then
				model<=0;
			end if;
		end if;
	end process;
	
	
	process(key2)
	begin
		if(key2_tmp='1')then
			trigger<='0';
			key2_tmp<='0';
		elsif(key2'event and key2='1')then
			trigger<='1';
			key2_tmp<='1';
		end if;
	end process;


	
	process(clkin)
	begin
		IF(clkin'EVENT AND clkin='1')THEN
		
			if(co1=0)then co1<=1;end if;
			if(co2=0)then co2<=60;end if;
			
			
			if(model=1 and trigger='1' and co1>0)then
				counter2<=24999999;
				co1<=co1-1;
			elsif(model=2 and trigger='1' and co2>0)then
				counter2<=24999999;
				co2<=co2-1;
			elsif(model=0)then
				counter2<=counter2+1;
			end if;
			
			
			IF(counter2=24999999)THEN    --24999999    
				counter2<=0;
				temp2<=NOT temp2;
			end if;
		end if;
	end process;
	

	process(clkin)
	begin
		IF(clkin'EVENT AND clkin='1')THEN
			IF(counter1=49999)THEN        
				counter1<=0;
				temp1<=NOT temp1;
			ELSE
				counter1<=counter1+1;
			END	IF;
		END IF;
	END PROCESS;
	
	
	clk_1ms<=temp1;
	clk_100ms<=temp2;
	
END clk_div_behavior;