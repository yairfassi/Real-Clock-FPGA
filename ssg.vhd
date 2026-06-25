library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;
	
entity SSG is
port
(
	CLK				:in std_logic;
	RESET 			:in std_logic;
	TESTMODE		:in std_logic;
	Q_MINUTES		:in std_logic_vector(5 downto 0);
	Q_SECONDS 		:in std_logic_vector(5 downto 0);
	LED_OUT			:out std_logic_vector(7 downto 0);
	ANODE_ACTIVATE 	:out std_logic_vector(3 downto 0)
);
end SSG;	

architecture SSG_ARC of SSG is
	component BIN_TO_SSG
	port(
		BINARY_VALUE	:in std_logic_vector(5 downto 0);
		TENS_SSG 		:out std_logic_vector(7 downto 0);
		DIGIT_SSG 		:out std_logic_vector(7 downto 0)
	);
	end component;
	
	signal ACTIVATING_COUNTER :std_logic_vector(1 downto 0);
	signal Q_TC         :std_logic_vector(18 downto 0);
	signal TENS_MIN 	: std_logic_vector(7 downto 0);
	signal DIGIT_MIN 	: std_logic_vector(7 downto 0);
	signal TENS_SEC 	: std_logic_vector(7 downto 0);
	signal DIGIT_SEC 	: std_logic_vector(7 downto 0);
begin
	P0:process
	begin
		wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_TC <= (others => '0');
			ACTIVATING_COUNTER <= "00";
		elsif ((TESTMODE ='0') and (Q_TC < 399999)) then
			Q_TC <= Q_TC + 1;
				
		elsif ((TESTMODE ='1') and (Q_TC < 2))  then
			Q_TC <= Q_TC + 1;	
		else
			Q_TC <= (others => '0');
			ACTIVATING_COUNTER <= ACTIVATING_COUNTER + 1;
		end if;
	end process;
	
	U0: BIN_TO_SSG
	port map(
		BINARY_VALUE => Q_MINUTES,
		TENS_SSG => TENS_MIN(7 downto 0),
		DIGIT_SSG => DIGIT_MIN(7 downto 0)
	);
	
	U1:BIN_TO_SSG
	port map(
		BINARY_VALUE => Q_SECONDS,
		TENS_SSG => TENS_SEC(7 downto 0),
		DIGIT_SSG => DIGIT_SEC(7 downto 0)
	); 
	
	P1: process(ACTIVATING_COUNTER, TENS_MIN, DIGIT_MIN, TENS_SEC, DIGIT_SEC)
	begin
		case ACTIVATING_COUNTER is
			when "00" =>
				ANODE_ACTIVATE <= "0111"; 
				LED_OUT <= TENS_MIN;
			when "01" =>
				ANODE_ACTIVATE <= "1011";
				LED_OUT <= DIGIT_MIN;			
			when "10" =>
				ANODE_ACTIVATE <= "1101"; 
				LED_OUT <= TENS_SEC;
			when "11" =>
				ANODE_ACTIVATE <= "1110"; 
				LED_OUT <= DIGIT_SEC;	
			when OTHERS => 
				ANODE_ACTIVATE <= "1111"; 
				LED_OUT <= "11111111";
			end case;
	end process;

end SSG_ARC;