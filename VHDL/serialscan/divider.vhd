LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY divider IS
	PORT(clkin:IN STD_LOGIC;
		clk_1ms:OUT STD_LOGIC:='0';
		clk_100ms:OUT STD_LOGIC:='0');
END divider;
ARCHITECTURE clk_div_behavior OF divider IS
	SIGNAL counter1:integer:=0;
	SIGNAL counter2:integer:=0;
	SIGNAL temp1:STD_LOGIC:='0';
	SIGNAL temp2:STD_LOGIC:='0';
BEGIN
	PROCESS(clkin)
	BEGIN
		IF(clkin'EVENT AND clkin='1')THEN
			IF(counter1=49)THEN        
				counter1<=0;
				temp1<=NOT temp1;
			ELSE
				counter1<=counter1+1;
			END	IF;
		END IF;
	END PROCESS;
	
	PROCESS(clkin)
	BEGIN
		IF(clkin'EVENT AND clkin='1')THEN
			IF(counter2=24999999)THEN    --24999999    
				counter2<=0;
				temp2<=NOT temp2;
			ELSE
				counter2<=counter2+1;
			END	IF;
		END IF;
	END PROCESS;
	
	clk_1ms<=temp1;
	clk_100ms<=temp2;
	
END clk_div_behavior;