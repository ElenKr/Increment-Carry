library ieee;
use ieee.std_logic_1164.all;

entity bit_prop_gen is
port ( a, b :in std_logic;
	p, g: out std_logic);
end bit_prop_gen;

architecture my_arch of bit_prop_gen is

begin

	p<= a xor b;
	g<= a and b;

end my_arch;

