library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;
	
entity CLOCK_BASE is
port
(
	RESET			:in std_logic;
	CLK				:in std_logic;
	TESTMODE		:in std_logic;
	LOAD 			:in std_logic;
	TIME_ENABLE		:in std_logic;
	SEL_HOURS		:in std_logic;
	SEL_MINUTES		:in std_logic;
	SEL_SECONDS		:in std_logic;
	DATA_IN			:in std_logic_vector(5 downto 0);
	
	SECONDS_OUT		:out std_logic_vector(5 downto 0);
	MINUTES_OUT		:out std_logic_vector(5 downto 0);
	HOURS_OUT		:out std_logic_vector(4 downto 0)
);
end CLOCK_BASE;
	
architecture CLOCK_BASE_ARC of CLOCK_BASE is
	signal TC_TIMEBASE :std_logic;
	signal Q_TC        :std_logic_vector(27 downto 0);
	signal Q_SECONDS   :std_logic_vector(5 downto 0);
	signal Q_MINUTES   :std_logic_vector(5 downto 0);
	signal Q_HOURS     :std_logic_vector(4 downto 0);
begin
	-- Time based generator
	p1:process
	begin
		wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_TC <= (others => '0');
			TC_TIMEBASE <= '0';
		elsif (TIME_ENABLE = '0') then  --If the user set the time reset the Q_TC  
													--so the counting will reset
			Q_TC <= (others => '0');
			TC_TIMEBASE <= '0';
			
		else --When the user set the time stop the time-base generator
			if ((TESTMODE ='0') and (Q_TC < 99999999)) then
					Q_TC <= Q_TC + 1;
					TC_TIMEBASE <= '0';
					
			elsif ((TESTMODE ='1') and (Q_TC < 9))  then
					Q_TC <= Q_TC + 1;
					TC_TIMEBASE <= '0';
					
			else
				Q_TC <= (others => '0');
				TC_TIMEBASE <= '1';
			end if;
		end if;
	end process;
	
	--Seconds counter
	p2:process
	begin
		wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_SECONDS <= (others => '0');
					
		elsif (LOAD ='1') and (SEL_SECONDS ='1')then
			Q_SECONDS <=DATA_IN(5 downto 0);
			
		elsif (TIME_ENABLE = '1') then --When the user set the time stop the the seconds's counter
			if (TC_TIMEBASE = '1') then
				if (Q_SECONDS < 59) then
				
					Q_SECONDS <= Q_SECONDS + 1;
					
				else
					Q_SECONDS <= (others => '0');
					
				end if;
			end if;
		end if;
	end process;
	SECONDS_OUT <= Q_SECONDS;
	
	--Minutes counter
	p3:process
	begin
		wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_MINUTES <= (others => '0');
			
		elsif (LOAD ='1') and (SEL_MINUTES ='1')then
			Q_MINUTES <=DATA_IN(5 downto 0);
			
		elsif (TIME_ENABLE = '1') then --When the user set the time stop the the minutes's counter
			if ((TC_TIMEBASE = '1')and (Q_SECONDS = 59)) then
				if (Q_MINUTES < 59) then
					Q_MINUTES <= Q_MINUTES + 1;
				else
					Q_MINUTES <= (others => '0');
				end if;
			end if;
		end if;
	end process;
	MINUTES_OUT <= Q_MINUTES;
	
	--Hours counter
	p4:process
	begin
		wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_HOURS <= (others => '0');
			
		elsif (LOAD ='1') and (SEL_HOURS ='1')then
			Q_HOURS <=DATA_IN(4 downto 0);
			
		elsif (TIME_ENABLE = '1') then --When the user set the time stop the the hours's counter
			if ((TC_TIMEBASE = '1')and (Q_SECONDS = 59) and (Q_MINUTES = 59)) then
				if (Q_HOURS < 23) then
					Q_HOURS <= Q_HOURS + 1;
				else
					Q_HOURS <= (others => '0');
				end if;
			end if;
		end if;
	end process;
	HOURS_OUT <= Q_HOURS;
	
end CLOCK_BASE_ARC;
