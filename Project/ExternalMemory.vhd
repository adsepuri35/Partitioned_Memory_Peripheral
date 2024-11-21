-- ExternalMemory.VHD
-- 2024.10.22
--
-- This SCOMP peripheral provides one 16-bit word of external memory for SCOMP.
-- Any value written to this peripheral can be read back.

LIBRARY IEEE;
LIBRARY LPM;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE LPM.LPM_COMPONENTS.ALL;

ENTITY ExternalMemory IS
    PORT(
        RESETN,
        CS,
        IO_WRITE : IN    STD_LOGIC;
        IO_DATA  : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ExternalMemory;

ARCHITECTURE a OF ExternalMemory IS
    SIGNAL SAVED : STD_LOGIC_VECTOR(15 DOWNTO 0);

    BEGIN

    -- Use Intel LPM IP to create tristate drivers
    IO_BUS: lpm_bustri
        GENERIC MAP (
        lpm_width => 16
    )
    PORT MAP (
        enabledt => CS AND NOT(IO_WRITE), -- when SCOMP reads
        data     => SAVED,  -- provide this value
        tridata  => IO_DATA -- driving the IO_DATA bus
    );

    PROCESS
    BEGIN
        WAIT UNTIL RISING_EDGE(CS);
            IF IO_WRITE = '1' THEN -- If SCOMP is writing,
                SAVED <= IO_DATA;  -- sample the input on the rising edge of CS
            END IF;
    END PROCESS;

END a;