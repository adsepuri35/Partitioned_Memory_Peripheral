library ieee;
library altera_mf;
library lpm;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use altera_mf.altera_mf_components.all;
use lpm.lpm_components.all;

entity MEMORY_PERIPHERAL is
    port(
        clock      : in    std_logic;  
        resetn     : in    std_logic;  
        IO_WRITE   : in    std_logic;  
        CS_R_W_ADDRESS : in    std_logic;  -- Chip select for address register (0x70)
		  CS_R_W_DATA	: in std_logic;
        CS_PERMISSION    : in    std_logic;  -- Chip select for setting permission (0x73)
        IO_DATA    : inout std_logic_vector(15 downto 0)  -- Bidirectional data bus
    );
end MEMORY_PERIPHERAL;

architecture a of MEMORY_PERIPHERAL is
    -- Internal signals
    signal R_W_ADDRESS : std_logic_vector(15 downto 0);  -- Address register
    signal READ_MEM : std_logic_vector(15 downto 0);     -- Data read from memory
    signal WRITE_MEM : std_logic_vector(15 downto 0);    -- Data to be written to memory
    signal PERM : std_logic := '0';  -- Permission bit, default to normal permissions (0)
    signal mem_wren : std_logic;  -- Write enable for memory
    signal access_allowed : std_logic;  -- Signal to check if access is allowed

begin
--    -- Main memory instance using altsyncram
--    main_memory: altsyncram
--    generic map (
--        operation_mode => "SINGLE_PORT",
--        width_a => 16,
--        widthad_a => 16,
--        numwords_a => 65536,  -- 2^16 memory locations
--        lpm_type => "altsyncram",
--        outdata_reg_a => "UNREGISTERED",
--        init_file => "UNUSED",
--        intended_device_family => "Cyclone V"
--    )
--    port map (
--        wren_a => mem_wren,
--        address_a => R_W_ADDRESS,
--        clock0 => clock,
--        data_a => WRITE_MEM,
--        q_a => READ_MEM
--    );
--
--    -- Permission checking logic
--    access_allowed <= '1' when (R_W_ADDRESS(15) = '0') or (PERM = '1') else '0';
--
--    -- Control logic
--    process(clock, resetn)
--    begin
--        if resetn = '0' then
--            -- Reset all registers and control signals
--            R_W_ADDRESS <= (others => '0');
--            WRITE_MEM <= (others => '0');
--            mem_wren <= '0';
--            PERM <= '0';  -- Reset to normal permissions
--        elsif rising_edge(clock) then
--            mem_wren <= '0';  -- Default: no write operation
--            
--            if IO_WRITE = '1' then
--                if CS_ADDRESS = '1' then
--                    -- Set the address for subsequent read/write operations
--                    R_W_ADDRESS <= IO_DATA;
--                elsif CS_WRITE_MEM = '1' and access_allowed = '1' then
--                    -- Write data to memory at the previously set address if access is allowed
--                    WRITE_MEM <= IO_DATA;
--                    mem_wren <= '1';  -- Enable write to memory
--                elsif CS_PERM = '1' then
--                    -- Set permission level
--                    if IO_DATA = "0000000000000001" then
--                        PERM <= '1';
--                    else
--                        PERM <= '0';
--                    end if;
--                end if;
--            end if;
--        end if;
--    end process;

    -- Output logic for read operations
    IO_DATA <= READ_MEM;

end a;