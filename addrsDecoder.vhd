library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;

entity TIME_SEL is
port
(
	ADDRS				:in std_logic_vector(1 downto 0);
	TIME_ENABLE			:out std_logic;
	SEL_HOURS			:out std_logic;
	SEL_MINUTES			:out std_logic;
	SEL_SECONDS			:out std_logic
);
end TIME_SEL;	

architecture TIME_SEL_ARC of TIME_SEL is
begin
	TIME_ENABLE <= '1' when (ADDRS ="00") else '0';
	SEL_HOURS 	<= '1' when (ADDRS ="01") else '0';
	SEL_MINUTES <= '1' when (ADDRS ="10") else '0';
	SEL_SECONDS <= '1' when (ADDRS ="11") else '0';
end TIME_SEL_ARC;