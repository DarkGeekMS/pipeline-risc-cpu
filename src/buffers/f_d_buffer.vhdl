library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity f_d_buffer is
    port (
        clk             : in std_logic;

        in_flush        : in std_logic;
        in_instr        : in std_logic_vector(31 downto 0);
        in_next_adr     : in std_logic_vector(31 downto 0);
        in_inc_pc       : in std_logic_vector(31 downto 0);
        in_hashed_adr   : in std_logic_vector(3 downto 0);
        in_interrupt    : in std_logic;
        in_reset        : in std_logic;

        out_instr       : out std_logic_vector(31 downto 0);
        out_next_adr    : out std_logic_vector(31 downto 0);
        out_inc_pc      : out std_logic_vector(31 downto 0);
        out_hashed_adr  : out std_logic_vector(3 downto 0);
        out_interrupt   : out std_logic
    );
end entity;

architecture rtl of f_d_buffer is
    signal instr       : std_logic_vector(31 downto 0);
    signal next_adr    : std_logic_vector(31 downto 0);
    signal inc_pc      : std_logic_vector(31 downto 0);
    signal hashed_adr  : std_logic_vector(3 downto 0);
    signal interrupt   : std_logic;

begin
    process (in_flush, in_instr, in_next_adr, in_inc_pc, in_hashed_adr, in_interrupt, in_reset)
    begin
        if in_flush = '1' or in_reset = '1' then
            instr       <= (others => '0');
            next_adr    <= (others => '0');
            inc_pc      <= (others => '0');
            hashed_adr  <= (others => '0');
            interrupt   <= '0';
        else
            instr       <= in_instr;
            next_adr    <= in_next_adr;
            inc_pc      <= in_inc_pc;
            hashed_adr  <= in_hashed_adr;
            interrupt   <= in_interrupt;
        end if;
    end process;

    process (clk)
    begin
        if rising_edge(clk) then
            out_instr       <= instr;
            out_next_adr    <= next_adr;
            out_inc_pc      <= inc_pc;
            out_hashed_adr  <= hashed_adr;
            out_interrupt   <= interrupt;
        end if;
    end process;
end architecture;