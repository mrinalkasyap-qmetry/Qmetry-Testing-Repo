library IEEE;
use IEEE.std_logic_1164.all;
entity P_GENERATOR is
port ( CLK : in std_ulogic;
RESET : in std_ulogic;
TRIG : in std_ulogic;
PULSE : out std_ulogic);
end P_GENERATOR;
architecture STATE_MACHINE of P_GENERATOR is
type PULSEGEN_STATE_TYPE is (IDLE, GEN_PULSE_A, GEN_PULSE_B,
END_PULSE, RETRIGGER); -- enumeration type
-- declaration.
signal CURRENT_STATE, NEXT_STATE: PULSEGEN_STATE_TYPE;
signal COUNT : integer range 0 to 31;
constant WIDTH : integer range 0 to 31 := 4;
begin
STATE_MACH_PROC : process (CURRENT_STATE, TRIG, COUNT) -- sensitivity list.
begin
case CURRENT_STATE is -- case-when statement specifies the following set of
-- statements to execute based on the value of
-- CURRENT_SIGNAL
when IDLE => if TRIG='1' then
NEXT_STATE <= GEN_PULSE_A;
end if;
when GEN_PULSE_A => if COUNT = WIDTH then
NEXT_STATE <= END_PULSE;
elsif TRIG='0' then
NEXT_STATE <= GEN_PULSE_B;
end if;
when END_PULSE => if TRIG ='1' then
NEXT_STATE <= IDLE;
end if;
when GEN_PULSE_B => if TRIG = '1' then
NEXT_STATE <= RETRIGGER;
elsif COUNT=WIDTH then
NEXT_STATE <= IDLE;
end if;
when RETRIGGER => NEXT_STATE <= GEN_PULSE_A;
when OTHERS => NEXT_STATE <= NEXT_STATE;
end case;
end process STATE_MACH_PROC;
PULSE_PROC : process (CLK, RESET) -- sensitivity list
begin
if RESET = '1' then
PULSE <= '0';
COUNT <= 0;
CURRENT_STATE <= IDLE;
elsif (clk='1' and clk'event) then -- clk'event is event attribute of clk to
-- determine if a clock has transitioned
CURRENT_STATE <= NEXT_STATE;
case NEXT_STATE is
when IDLE => PULSE <= '0';
COUNT <= 0;
when GEN_PULSE_A => PULSE <= '1';
COUNT <= COUNT + 1;
EE 595 EDA / ASIC Design Lab
Example 2
Pulse Generator (cont’d)
when END_PULSE => PULSE <= '0';
COUNT <= 0;
when GEN_PULSE_B => PULSE <= '1';
COUNT <= COUNT + 1;
when RETRIGGER => COUNT <= 0;
when OTHERS => COUNT <= COUNT;
end case;
end if;
end process PULSE_PROC;
end STATE_MACHINE;
entity STATE_MACHINE_TB is
end STATE_MACHINE_TB;
library IEEE;
use IEEE.std_logic_1164.all;
architecture ARC_STATE_MACHINE_TB of STATE_MACHINE_TB is
component P_GENERATOR
port ( CLK : in std_ulogic;
RESET : in std_ulogic;
TRIG : in std_ulogic;
PULSE : out std_ulogic);
end component;
signal CLK : std_ulogic;
signal RESET : std_ulogic;
signal TRIG : std_ulogic;
signal PULSE : std_ulogic;
begin
U1: P_GENERATOR
port map( CLK, RESET,TRIG,PULSE);
CREATE_CLOCK: process (clk)
begin
if clk <= 'U' then clk <= '0' after 1 ns;
else clk <= not clk after 1 ns;
end if;
end process CREATE_CLOCK;
CREATE_PULSE: process (TRIG)
begin
TRIG <= '0' after 10 ns,
'1' after 15 ns,
'0' after 20 ns;
end process CREATE_PULSE;
end ARC_STATE_MACHINE_TB;
configuration CFG_STATE_MACHINE of STATE_MACHINE_TB is
for ARC_STATE_MACHINE_TB
end for;
end CFG_STATE_MACHINE;
