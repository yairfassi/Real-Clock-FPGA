library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;
	
entity BIN_TO_SSG_SSD is
port
(
	BINARY_VALUE_SSD	:in std_logic_vector(4 downto 0);
	TENS_SSG_SSD 		:out std_logic_vector(6 downto 0);
	DIGIT_SSG_SSD 		:out std_logic_vector(6 downto 0)
);
end BIN_TO_SSG_SSD;

architecture BIN_TO_SSG_SSD_ARC of BIN_TO_SSG_SSD is
begin
	process(BINARY_VALUE_SSD)
	begin
		case BINARY_VALUE_SSD is
			-- 00 to 09 (Tens: 0, Ones: 0-9)
			when "00000" => TENS_SSG_SSD <= "1111110"; DIGIT_SSG_SSD <= "1111110"; -- Decimal 0
			when "00001" => TENS_SSG_SSD <= "1111110"; DIGIT_SSG_SSD <= "0110000"; -- Decimal 1
			when "00010" => TENS_SSG_SSD <= "1111110"; DIGIT_SSG_SSD <= "1101101"; -- Decimal 2
			when "00011" => TENS_SSG_SSD <= "1111110"; DIGIT_SSG_SSD <= "1111001"; -- Decimal 3
			when "00100" => TENS_SSG_SSD <= "1111110"; DIGIT_SSG_SSD <= "0110011"; -- Decimal 4
			when "00101" => TENS_SSG_SSD <= "1111110"; DIGIT_SSG_SSD <= "1011011"; -- Decimal 5
			when "00110" => TENS_SSG_SSD <= "1111110"; DIGIT_SSG_SSD <= "1011111"; -- Decimal 6
			when "00111" => TENS_SSG_SSD <= "1111110"; DIGIT_SSG_SSD <= "1110000"; -- Decimal 7
			when "01000" => TENS_SSG_SSD <= "1111110"; DIGIT_SSG_SSD <= "1111111"; -- Decimal 8
			when "01001" => TENS_SSG_SSD <= "1111110"; DIGIT_SSG_SSD <= "1111011"; -- Decimal 9
			
			-- 10 to 19 (Tens: 1, Ones: 0-9)
			when "01010" => TENS_SSG_SSD <= "0110000"; DIGIT_SSG_SSD <= "1111110"; -- Decimal 10
			when "01011" => TENS_SSG_SSD <= "0110000"; DIGIT_SSG_SSD <= "0110000"; -- Decimal 11
			when "01100" => TENS_SSG_SSD <= "0110000"; DIGIT_SSG_SSD <= "1101101"; -- Decimal 12
			when "01101" => TENS_SSG_SSD <= "0110000"; DIGIT_SSG_SSD <= "1111001"; -- Decimal 13
			when "01110" => TENS_SSG_SSD <= "0110000"; DIGIT_SSG_SSD <= "0110011"; -- Decimal 14
			when "01111" => TENS_SSG_SSD <= "0110000"; DIGIT_SSG_SSD <= "1011011"; -- Decimal 15
			when "10000" => TENS_SSG_SSD <= "0110000"; DIGIT_SSG_SSD <= "1011111"; -- Decimal 16
			when "10001" => TENS_SSG_SSD <= "0110000"; DIGIT_SSG_SSD <= "1110000"; -- Decimal 17
			when "10010" => TENS_SSG_SSD <= "0110000"; DIGIT_SSG_SSD <= "1111111"; -- Decimal 18
			when "10011" => TENS_SSG_SSD <= "0110000"; DIGIT_SSG_SSD <= "1111011"; -- Decimal 19
			
			-- 20 to 23 (Tens: 2, Ones: 0-3)
			when "10100" => TENS_SSG_SSD <= "1101101"; DIGIT_SSG_SSD <= "1111110"; -- Decimal 20
			when "10101" => TENS_SSG_SSD <= "1101101"; DIGIT_SSG_SSD <= "0110000"; -- Decimal 21
			when "10110" => TENS_SSG_SSD <= "1101101"; DIGIT_SSG_SSD <= "1101101"; -- Decimal 22
			when "10111" => TENS_SSG_SSD <= "1101101"; DIGIT_SSG_SSD <= "1111001"; -- Decimal 23
			
			-- Default fallback case (Turns off all segments for values 24 to 31)
			when others  => TENS_SSG_SSD <= "0000000"; DIGIT_SSG_SSD <= "0000000"; 
		end case;
	end process;
end BIN_TO_SSG_SSD_ARC;	
