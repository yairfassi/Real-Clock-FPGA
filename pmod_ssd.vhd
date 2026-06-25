library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;
	
entity PMOD_SSD is
port
(
	CLK					:in std_logic;
	RESET 				:in std_logic;
	TESTMODE			:in std_logic;
	Q_HOURS				:in std_logic_vector(4 downto 0);
	LED_OUT_SSD			:out std_logic_vector(6 downto 0);
	CATHODE_ACTIVATE_SSD 	:out std_logic
);
end PMOD_SSD;	

architecture PMOD_SSD_ARC of PMOD_SSD is
	component BIN_TO_SSG_SSD
	port(
		BINARY_VALUE_SSD	:in std_logic_vector(4 downto 0);
		TENS_SSG_SSD 			:out std_logic_vector(6 downto 0);
		DIGIT_SSG_SSD 			:out std_logic_vector(6 downto 0)
	);
	end component;
	
	signal ACTIVATING_COUNTER_SSD 	:std_logic;
	signal Q_TC        				:std_logic_vector(18 downto 0);
	signal TENS_HOURS 				:std_logic_vector(6 downto 0);
	signal DIGIT_HOURS 				:std_logic_vector(6 downto 0);
	
begin
	P0:process
	begin
		wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_TC <= (others => '0');
			ACTIVATING_COUNTER_SSD <= '0';
		elsif ((TESTMODE ='0') and (Q_TC < 399999)) then
			Q_TC <= Q_TC + 1;
				
		elsif ((TESTMODE ='1') and (Q_TC < 2))  then
			Q_TC <= Q_TC + 1;

		else
			Q_TC <= (others => '0');
			ACTIVATING_COUNTER_SSD <= not(ACTIVATING_COUNTER_SSD);
		end if;
	end process;
	
	U0: BIN_TO_SSG_SSD
	port map(
		BINARY_VALUE_SSD => Q_HOURS(4 downto 0),
		TENS_SSG_SSD => TENS_HOURS(6 downto 0),
		DIGIT_SSG_SSD => DIGIT_HOURS(6 downto 0)
	);
	
	P1: process(ACTIVATING_COUNTER_SSD,TENS_HOURS,DIGIT_HOURS)
	begin
		case ACTIVATING_COUNTER_SSD is
			when '1' =>
				LED_OUT_SSD <= TENS_HOURS;
			when '0' =>
				LED_OUT_SSD <= DIGIT_HOURS;			
			when OTHERS => 
				LED_OUT_SSD <= "0000000";
			end case;
			CATHODE_ACTIVATE_SSD <=ACTIVATING_COUNTER_SSD;
	end process;
end PMOD_SSD_ARC;