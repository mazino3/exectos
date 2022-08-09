/**
 * PROJECT:         ExectOS
 * COPYRIGHT:       See COPYING.md in the top level directory
 * FILE:            xtldr/xtldr.c
 * DESCRIPTION:     UEFI XT Bootloader
 * DEVELOPERS:      Rafal Kupiec <belliash@codingworkshop.eu.org>
 */

#include <xtbl.h>


/* EFI Image Handle */
EFI_HANDLE EfiImageHandle;

/* EFI System Table */
PEFI_SYSTEM_TABLE EfiSystemTable;

/* Serial port configuration */
CPPORT EfiSerialPort;

/**
 * Writes a character to the serial console.
 *
 * @param Character
 *        The integer promotion of the character to be written.
 *
 * @return This routine does not return any value.
 *
 * @since XT 1.0
 */
VOID
BlComPortPutChar(IN USHORT Character)
{
    USHORT Buffer[2];

    /* Write character to the serial console */
    Buffer[0] = Character;
    Buffer[1] = 0;

    HlComPortPutByte(&EfiSerialPort, Buffer[0]);
}

/**
 * This routine is the entry point of the XT EFI boot loader.
 *
 * @param ImageHandle
 *        Firmware-allocated handle that identifies the image.
 *
 * @param SystemTable
 *        Provides the EFI system table.
 *
 * @return This routine returns status code.
 *
 * @since XT 1.0
 */
EFI_STATUS
BlStartXtLoader(IN EFI_HANDLE ImageHandle,
                IN PEFI_SYSTEM_TABLE SystemTable)
{
    EFI_STATUS Status;

    /* Set the system table and image handle */
    EfiImageHandle = ImageHandle;
    EfiSystemTable = SystemTable;

    Status = HlInitializeComPort(&EfiSerialPort, 1, 0);
    if(Status != STATUS_SUCCESS)
    {
        BlEfiPrint(L"Failed to initialize serial console");
    }

    /* Initialize EFI console */
    Status = BlConsoleInitialize();
    if(Status != STATUS_EFI_SUCCESS) {
        /* TODO: Display error message on the serial console */
        /* Temporarily return error code */
        return STATUS_EFI_INCOMPATIBLE_VERSION;
    }

    /* Infinite bootloader loop */
    for(;;);

    /* Return success */
    return STATUS_EFI_SUCCESS;
}
