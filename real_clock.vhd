library IEEE;
	use IEEE.std_logic_1164.all;

entity REAL_CLOCK is
port(
	CLK					:in std_logic;
	RESET 				:in std_logic;
	TESTMODE			:in std_logic;
	LOAD				:in std_logic;
	ADDRS				:in std_logic_vector(1 downto 0);
	DATA_IN				:in std_logic_vector(5 downto 0);
	LED_OUT				:out std_logic_vector(7 downto 0);
	ANODE_ACTIVATE 		:out std_logic_vector(3 downto 0);
	LED_OUT_SSD			:out std_logic_vector(6 downto 0);
	CATHODE_ACTIVATE_SSD 	:out std_logic
);
end REAL_CLOCK;

architecture REAL_CLOCK_ARC of REAL_CLOCK is
-- Components declaretion
	component TIME_SEL
	port(
		ADDRS				:in std_logic_vector(1 downto 0);
		TIME_ENABLE			:out std_logic;
		SEL_HOURS			:out std_logic;
		SEL_MINUTES			:out std_logic;
		SEL_SECONDS			:out std_logic
	);
	end component;
	
	component CLOCK_BASE
	port(
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
	end component;
	
	component SSG_INTERFACE
	port(
		CLK					:in std_logic;
		RESET 				:in std_logic;
		TESTMODE			:in std_logic;
		SECONDS_OUT			:in std_logic_vector(5 downto 0);
		MINUTES_OUT			:in std_logic_vector(5 downto 0);
		HOURS_OUT			:in std_logic_vector(4 downto 0);
		LED_OUT				:out std_logic_vector(7 downto 0);
		ANODE_ACTIVATE 		:out std_logic_vector(3 downto 0);
		LED_OUT_SSD			:out std_logic_vector(6 downto 0);
		CATHODE_ACTIVATE_SSD:out std_logic
	);
	end component;
	
	--Internal Siganls
	signal SECONDS_OUT	:std_logic_vector(5 downto 0);
	signal MINUTES_OUT	:std_logic_vector(5 downto 0);
	signal HOURS_OUT	:std_logic_vector(4 downto 0);
	signal TIME_ENABLE	:std_logic;
	signal SEL_HOURS	:std_logic;
	signal SEL_MINUTES	:std_logic;
	signal SEL_SECONDS	:std_logic;
begin

--component instantiation
	TIM:TIME_SEL
	port map(
		ADDRS	=>	ADDRS(1 downto 0),
		TIME_ENABLE	=> 	TIME_ENABLE,
		SEL_HOURS	=>	SEL_HOURS,
		SEL_MINUTES	=> 	SEL_MINUTES,
		SEL_SECONDS	=>	SEL_SECONDS	
	);
	CLK_BASE: CLOCK_BASE
	port map(
		CLK 		=> CLK,
		RESET 		=> RESET,
		TESTMODE 	=> TESTMODE,
		LOAD		=> LOAD,
		DATA_IN		=> DATA_IN(5 downto 0),
		TIME_ENABLE => TIME_ENABLE,
		SEL_HOURS 	=> SEL_HOURS,
		SEL_MINUTES => SEL_MINUTES,
		SEL_SECONDS => SEL_SECONDS,
		SECONDS_OUT => SECONDS_OUT(5 downto 0),
		MINUTES_OUT => MINUTES_OUT(5 downto 0),
		HOURS_OUT 	=> HOURS_OUT(4 downto 0)
	);
	
	SSG_INT: SSG_INTERFACE
	port map(
		CLK				=> CLK,
		RESET 			=> RESET,
		TESTMODE		=> TESTMODE,
		SECONDS_OUT		=> SECONDS_OUT(5 downto 0),
		MINUTES_OUT		=> MINUTES_OUT(5 downto 0),
		HOURS_OUT		=> HOURS_OUT(4 downto 0),
		LED_OUT			=> LED_OUT(7 downto 0),
		ANODE_ACTIVATE 	=> ANODE_ACTIVATE(3 downto 0),
		LED_OUT_SSD		=> LED_OUT_SSD(6 downto 0),
		CATHODE_ACTIVATE_SSD => CATHODE_ACTIVATE_SSD
	);
	
end REAL_CLOCK_ARC;