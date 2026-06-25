library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;
	
entity BIN_TO_SSG is
port
(
	BINARY_VALUE	:in std_logic_vector(5 downto 0);
	TENS_SSG 		:out std_logic_vector(7 downto 0);
	DIGIT_SSG 		:out std_logic_vector(7 downto 0)
);
end BIN_TO_SSG;

architecture BIN_TO_SSG_ARC of BIN_TO_SSG is
begin
	process(BINARY_VALUE)
	begin
		case BINARY_VALUE is
			-- 00 to 09 (Tens: 0, Ones: 0-9)
			when "000000" => TENS_SSG <= "00000011"; DIGIT_SSG <= "00000011"; -- Decimal 0
			when "000001" => TENS_SSG <= "00000011"; DIGIT_SSG <= "10011111"; -- Decimal 1
			when "000010" => TENS_SSG <= "00000011"; DIGIT_SSG <= "00100101"; -- Decimal 2
			when "000011" => TENS_SSG <= "00000011"; DIGIT_SSG <= "00001101"; -- Decimal 3
			when "000100" => TENS_SSG <= "00000011"; DIGIT_SSG <= "10011001"; -- Decimal 4
			when "000101" => TENS_SSG <= "00000011"; DIGIT_SSG <= "01001001"; -- Decimal 5
			when "000110" => TENS_SSG <= "00000011"; DIGIT_SSG <= "01000001"; -- Decimal 6
			when "000111" => TENS_SSG <= "00000011"; DIGIT_SSG <= "00011111"; -- Decimal 7
			when "001000" => TENS_SSG <= "00000011"; DIGIT_SSG <= "00000001"; -- Decimal 8
			when "001001" => TENS_SSG <= "00000011"; DIGIT_SSG <= "00001001"; -- Decimal 9
			
			-- 10 to 19 (Tens: 1, Ones: 0-9)
			when "001010" => TENS_SSG <= "10011111"; DIGIT_SSG <= "00000011"; -- Decimal 10
			when "001011" => TENS_SSG <= "10011111"; DIGIT_SSG <= "10011111"; -- Decimal 11
			when "001100" => TENS_SSG <= "10011111"; DIGIT_SSG <= "00100101"; -- Decimal 12
			when "001101" => TENS_SSG <= "10011111"; DIGIT_SSG <= "00001101"; -- Decimal 13
			when "001110" => TENS_SSG <= "10011111"; DIGIT_SSG <= "10011001"; -- Decimal 14
			when "001111" => TENS_SSG <= "10011111"; DIGIT_SSG <= "01001001"; -- Decimal 15
			when "010000" => TENS_SSG <= "10011111"; DIGIT_SSG <= "01000001"; -- Decimal 16
			when "010001" => TENS_SSG <= "10011111"; DIGIT_SSG <= "00011111"; -- Decimal 17
			when "010010" => TENS_SSG <= "10011111"; DIGIT_SSG <= "00000001"; -- Decimal 18
			when "010011" => TENS_SSG <= "10011111"; DIGIT_SSG <= "00001001"; -- Decimal 19
			
			-- 20 to 29 (Tens: 2, Ones: 0-9)
			when "010100" => TENS_SSG <= "00100101"; DIGIT_SSG <= "00000011"; -- Decimal 20
			when "010101" => TENS_SSG <= "00100101"; DIGIT_SSG <= "10011111"; -- Decimal 21
			when "010110" => TENS_SSG <= "00100101"; DIGIT_SSG <= "00100101"; -- Decimal 22
			when "010111" => TENS_SSG <= "00100101"; DIGIT_SSG <= "00001101"; -- Decimal 23
			when "011000" => TENS_SSG <= "00100101"; DIGIT_SSG <= "10011001"; -- Decimal 24
			when "011001" => TENS_SSG <= "00100101"; DIGIT_SSG <= "01001001"; -- Decimal 25
			when "011010" => TENS_SSG <= "00100101"; DIGIT_SSG <= "01000001"; -- Decimal 26
			when "011011" => TENS_SSG <= "00100101"; DIGIT_SSG <= "00011111"; -- Decimal 27
			when "011100" => TENS_SSG <= "00100101"; DIGIT_SSG <= "00000001"; -- Decimal 28
			when "011101" => TENS_SSG <= "00100101"; DIGIT_SSG <= "00001001"; -- Decimal 29
			
			-- 30 to 39 (Tens: 3, Ones: 0-9)
			when "011110" => TENS_SSG <= "00001101"; DIGIT_SSG <= "00000011"; -- Decimal 30
			when "011111" => TENS_SSG <= "00001101"; DIGIT_SSG <= "10011111"; -- Decimal 31
			when "100000" => TENS_SSG <= "00001101"; DIGIT_SSG <= "00100101"; -- Decimal 32
			when "100001" => TENS_SSG <= "00001101"; DIGIT_SSG <= "00001101"; -- Decimal 33
			when "100010" => TENS_SSG <= "00001101"; DIGIT_SSG <= "10011001"; -- Decimal 34
			when "100011" => TENS_SSG <= "00001101"; DIGIT_SSG <= "01001001"; -- Decimal 35
			when "100100" => TENS_SSG <= "00001101"; DIGIT_SSG <= "01000001"; -- Decimal 36
			when "100101" => TENS_SSG <= "00001101"; DIGIT_SSG <= "00011111"; -- Decimal 37
			when "100110" => TENS_SSG <= "00001101"; DIGIT_SSG <= "00000001"; -- Decimal 38
			when "100111" => TENS_SSG <= "00001101"; DIGIT_SSG <= "00001001"; -- Decimal 39
			
			-- 40 to 49 (Tens: 4, Ones: 0-9)
			when "101000" => TENS_SSG <= "10011001"; DIGIT_SSG <= "00000011"; -- Decimal 40
			when "101001" => TENS_SSG <= "10011001"; DIGIT_SSG <= "10011111"; -- Decimal 41
			when "101010" => TENS_SSG <= "10011001"; DIGIT_SSG <= "00100101"; -- Decimal 42
			when "101011" => TENS_SSG <= "10011001"; DIGIT_SSG <= "00001101"; -- Decimal 43
			when "101100" => TENS_SSG <= "10011001"; DIGIT_SSG <= "10011001"; -- Decimal 44
			when "101101" => TENS_SSG <= "10011001"; DIGIT_SSG <= "01001001"; -- Decimal 45
			when "101110" => TENS_SSG <= "10011001"; DIGIT_SSG <= "01000001"; -- Decimal 46
			when "101111" => TENS_SSG <= "10011001"; DIGIT_SSG <= "00011111"; -- Decimal 47
			when "110000" => TENS_SSG <= "10011001"; DIGIT_SSG <= "00000001"; -- Decimal 48
			when "110001" => TENS_SSG <= "10011001"; DIGIT_SSG <= "00001001"; -- Decimal 49
			
			-- 50 to 59 (Tens: 5, Ones: 0-9)
			when "110010" => TENS_SSG <= "01001001"; DIGIT_SSG <= "00000011"; -- Decimal 50
			when "110011" => TENS_SSG <= "01001001"; DIGIT_SSG <= "10011111"; -- Decimal 51
			when "110100" => TENS_SSG <= "01001001"; DIGIT_SSG <= "00100101"; -- Decimal 52
			when "110101" => TENS_SSG <= "01001001"; DIGIT_SSG <= "00001101"; -- Decimal 53
			when "110110" => TENS_SSG <= "01001001"; DIGIT_SSG <= "10011001"; -- Decimal 54
			when "110111" => TENS_SSG <= "01001001"; DIGIT_SSG <= "01001001"; -- Decimal 55
			when "111000" => TENS_SSG <= "01001001"; DIGIT_SSG <= "01000001"; -- Decimal 56
			when "111001" => TENS_SSG <= "01001001"; DIGIT_SSG <= "00011111"; -- Decimal 57
			when "111010" => TENS_SSG <= "01001001"; DIGIT_SSG <= "00000001"; -- Decimal 58
			when "111011" => TENS_SSG <= "01001001"; DIGIT_SSG <= "00001001"; -- Decimal 59
			
			-- Default fallback case (Turns off all display segments)
			when others   => TENS_SSG <= "11111111"; DIGIT_SSG <= "11111111"; 
		end case;
	end process;
end BIN_TO_SSG_ARC;	
