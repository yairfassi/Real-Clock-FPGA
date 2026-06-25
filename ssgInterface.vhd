library IEEE;
	use IEEE.std_logic_1164.all;

entity SSG_INTERFACE is
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
end SSG_INTERFACE;

architecture SSG_INTERFACE_ARC of SSG_INTERFACE is
-- Components declaretion
	component SSG
	port(
		CLK				:in std_logic;
		RESET 			:in std_logic;
		TESTMODE		:in std_logic;
		Q_MINUTES		:in std_logic_vector(5 downto 0);
		Q_SECONDS 		:in std_logic_vector(5 downto 0);
		LED_OUT			:out std_logic_vector(7 downto 0);
		ANODE_ACTIVATE 	:out std_logic_vector(3 downto 0)
	);
	end component;
	
	component PMOD_SSD
	port(
		CLK					:in std_logic;
		RESET 				:in std_logic;
		TESTMODE			:in std_logic;
		Q_HOURS				:in std_logic_vector(4 downto 0);
		LED_OUT_SSD			:out std_logic_vector(6 downto 0);
		CATHODE_ACTIVATE_SSD 	:out std_logic
	);
	end component;

begin
--component instantiation
	SSG_UNIT: SSG
	port map(
		CLK 			=> CLK,
		RESET 			=> RESET,
		TESTMODE 		=> TESTMODE,
		Q_MINUTES 		=> MINUTES_OUT(5 downto 0), 
		Q_SECONDS 		=> SECONDS_OUT(5 downto 0), 
		LED_OUT 		=> LED_OUT(7 downto 0),
		ANODE_ACTIVATE 	=> ANODE_ACTIVATE(3 downto 0)
	);
	
	PMOD: PMOD_SSD
	port map(
		CLK 				=> CLK,
		RESET 				=> RESET,
		TESTMODE 	=> TESTMODE,
		Q_HOURS 			=> HOURS_OUT(4 downto 0),
		LED_OUT_SSD 		=> LED_OUT_SSD(6 downto 0),
		CATHODE_ACTIVATE_SSD 	=> CATHODE_ACTIVATE_SSD
	);
end SSG_INTERFACE_ARC;