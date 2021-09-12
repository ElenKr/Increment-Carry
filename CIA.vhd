library ieee;
use ieee.std_logic_1164.all;

entity CIA is
port ( a, b :in std_logic_vector (15 downto 0);
	cin : in std_logic;
	sum: out std_logic_vector (15 downto 0);
	co: out std_logic);
end CIA;

architecture my_arch of CIA is

component variable_group is
generic (m:integer:=2);
port ( a, b : in std_logic_vector(m-1 downto 0);
	g_prin: in std_logic;
	sum : out std_logic_vector (m-1 downto 0);
	g_current: out std_logic;
	cout: out std_logic);
end component;

component Sum_logic is
port ( p, g : in std_logic;
	sum: out std_logic);
end component;

signal g0: std_logic;
signal g_group, cout : std_logic_vector (4 downto 0);

begin
	
	sum(0)<=(a(0) xor b(0)) xor cin;
	g0<=(a(0) and b(0)) or ((a(0) xor b(0)) and cin);
	sum(1)<=(a(1) xor b(1)) xor g0;
	g_group(0)<=(a(1) and b(1) ) or ( (a(1) xor b(1)) and g0);
	cout(0)<=g_group(0);
	group1:  variable_group generic map (2) port  map ( a(3 downto 2), b(3 downto 2), g_group(0), sum(3 downto 2), g_group(1), cout(1));	
	group2:  variable_group generic map (3) port map ( a(6 downto 4), b(6 downto 4), g_group(1), sum(6 downto 4), g_group(2), cout(2));
	group3:  variable_group generic map (4) port map ( a(10 downto 7), b(10 downto 7), g_group(2), sum(10 downto 7), g_group(3), cout(3));
	group4:  variable_group generic map (5) port map ( a(15 downto 11), b(15 downto 11), g_group(3), sum(15 downto 11), g_group(4), cout(4));
	co<=cout(4);
	
end my_arch;
