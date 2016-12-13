-- TRAFFIC LIGHTS CONTROLLER
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity traffic is
	port(
		clk : in STD_LOGIC;
		-- red1 represents red light of 1st traffic light
		-- similarily other lights are represented
		red1 : out STD_LOGIC;
		yellow1 : out STD_LOGIC;
		green1 : out STD_LOGIC;
		red2 : out STD_LOGIC;
		yellow2 : out STD_LOGIC;
		green2 : out STD_LOGIC;
		red3 : out STD_LOGIC;
		yellow3 : out STD_LOGIC;
		green3 : out STD_LOGIC;
		red4 : out STD_LOGIC;
		yellow4 : out STD_LOGIC;
		green4 : out STD_LOGIC
	     );
end entity traffic;

architecture trafficA of traffic is
type state_type is (s0, s1, s2, s3, s4, s5,s6,s7); -- defined state for each combination possible
signal state : state_type := s0; -- initial state is s0
signal count : integer := 0; -- represents time
		signal lights: std_logic_vector(11 downto 0); -- a vector that represents a state
begin
	STATEpro : process(state)
		begin	
			case state is
				when s0 => lights <= "001100100100";
				when s1 => lights <= "010100100100";
				when s2 => lights <= "100001100100";
				when s3 => lights <= "100010100100";
				when s4 => lights <= "100100001100";
				when s5 => lights <= "100100010100";
				when s6 => lights <= "100100100001";
				when s7 => lights <= "100100100010";
				when others => lights <= lights;
			end case;
		end process;
	LT : process(clk)
		
	     begin
		
		case count is
			when 0 => state <= s0; count <= count + 1;
			when 20 => state <= s1; count <= count + 1; -- 1st green ends
			when 25 => state <= s2; count <= count + 1; -- 1st yellow ends
			when 45 => state <= s3; count <= count + 1; -- 2nd green ends
			when 50 => state <= s4; count <= count + 1; -- 2nd yellow ends
			when 70 => state <= s5; count <= count + 1; -- 3rd green ends
			when 75 => state <= s6; count <= count + 1; -- 3rd yellow ends
			when 95 => state <= s7; count <= count + 1; -- 4th green ends
			when 100 => count <= 0;-- 4th yellow ends
			when others => count <= count + 1;
		end case;
		-- each bit of state vector represents state of each light i.e. 0 or 1
		-- green4 is represented by last bit i.e. 0th bit ( LSB )
		-- red1 is represented by first bit i.e. 11th bit ( MSB )
		green4 <= lights(0);
		yellow4 <= lights(1);
		red4 <= lights(2);
		green3 <= lights(3);
		yellow3 <= lights(4);
		red3 <= lights(5);
		green2 <= lights(6);
		yellow2 <= lights(7);
		red2 <= lights(8);
		green1 <= lights(9);
		yellow1 <= lights(10);
		red1 <= lights(11);
	     end process;

end architecture trafficA;
