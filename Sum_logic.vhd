library ieee;
use ieee.std_logic_1164.all;

entity Sum_logic is
port ( p, g : in std_logic;
	sum: out std_logic);
end Sum_logic;

architecture my_arch of Sum_logic is

begin

	sum<=p xor g;
end my_arch;
