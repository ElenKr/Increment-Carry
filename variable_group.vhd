library ieee;
use ieee.std_logic_1164.all;

entity variable_group is
generic (m:integer:=5);
port ( a, b : in std_logic_vector(m-1 downto 0);
	g_prin: in std_logic;
	sum : out std_logic_vector (m-1 downto 0);
	g_current: out std_logic;
	cout: out std_logic);
end variable_group;
	
architecture my_arch of variable_group is

component bit_prop_gen is
port ( a, b :in std_logic;
	p, g: out std_logic);
end component;

component Sum_logic is
port ( p, g : in std_logic;
	sum: out std_logic);
end component;

signal gik, pik,  pin, gin, ggrey: std_logic_vector (m-1 downto 0);


begin

	generate_pg:
	for i in 0 to m-1 generate
		bit_i: bit_prop_gen port map( a(i), b(i), pin(i), gin(i));
	end generate;
	
	gik(0)<=g_prin;
	--pik(0)<='0';
	pik(0)<=pin(0);
	-- black cell
	generate_pggroup:
	for i in 1 to m-1 generate
		gik(i)<=gin(i) or(pin(i) and gik(i-1));
		pik(i)<=pin(i) and pik(i-1);
	end generate;
	

	--grey cell
	generate_greycell:
	for i in 0 to m-1 generate
		ggrey(i)<=gin(i) or ( pin(i) and g_prin); --gin
	end generate;
	
	--carry 
	cout<= ggrey(m-1) or ( g_prin and pik(m-1));
	g_current<=ggrey(m-1);
	
	
	--Sum logic
	sum(0)<=(a(0) xor b(0)) xor g_prin;
	generate_sumlogic:
	for i in 1 to m-1 generate
		sum_i: Sum_logic port map (pin(i), ggrey(i-1), sum(i));
	end generate;
end my_arch;