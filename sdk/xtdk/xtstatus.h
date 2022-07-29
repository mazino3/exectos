/**
 * PROJECT:         ExectOS
 * COPYRIGHT:       See COPYING.md in the top level directory
 * FILE:            sdk/xtdk/xtstatus.h
 * DESCRIPTION:     Status code definitions for the XT API
 * DEVELOPERS:      Rafal Kupiec <belliash@codingworkshop.eu.org>
 */

#ifndef __XTDK_XTSTATUS_H
#define __XTDK_XTSTATUS_H


/* EFI status code definitions */
#define STATUS_EFI_SUCCESS                                                 (EFI_ERROR_MASK & 0x00)
#define STATUS_EFI_LOAD_ERROR                                              (EFI_ERROR_MASK | 0x01)
#define STATUS_EFI_INVALID_PARAMETER                                       (EFI_ERROR_MASK | 0x02)
#define STATUS_EFI_UNSUPPORTED                                             (EFI_ERROR_MASK | 0x03)
#define STATUS_EFI_BAD_BUFFER_SIZE                                         (EFI_ERROR_MASK | 0x04)
#define STATUS_EFI_BUFFER_TOO_SMALL                                        (EFI_ERROR_MASK | 0x05)
#define STATUS_EFI_NOT_READY                                               (EFI_ERROR_MASK | 0x06)
#define STATUS_EFI_DEVICE_ERROR                                            (EFI_ERROR_MASK | 0x07)
#define STATUS_EFI_WRITE_PROTECTED                                         (EFI_ERROR_MASK | 0x08)
#define STATUS_EFI_OUT_OF_RESOURCES                                        (EFI_ERROR_MASK | 0x09)
#define STATUS_EFI_VOLUME_CORRUPTED                                        (EFI_ERROR_MASK | 0x0A)
#define STATUS_EFI_VOLUME_FULL                                             (EFI_ERROR_MASK | 0x0B)
#define STATUS_EFI_NO_MEDIA                                                (EFI_ERROR_MASK | 0x0C)
#define STATUS_EFI_MEDIA_CHANGED                                           (EFI_ERROR_MASK | 0x0D)
#define STATUS_EFI_NOT_FOUND                                               (EFI_ERROR_MASK | 0x0E)
#define STATUS_EFI_ACCESS_DENIED                                           (EFI_ERROR_MASK | 0x0F)
#define STATUS_EFI_NO_RESPONSE                                             (EFI_ERROR_MASK | 0x10)
#define STATUS_EFI_NO_MAPPING                                              (EFI_ERROR_MASK | 0x11)
#define STATUS_EFI_TIMEOUT                                                 (EFI_ERROR_MASK | 0x12)
#define STATUS_EFI_NOT_STARTED                                             (EFI_ERROR_MASK | 0x13)
#define STATUS_EFI_ALREADY_STARTED                                         (EFI_ERROR_MASK | 0x14)
#define STATUS_EFI_ABORTED                                                 (EFI_ERROR_MASK | 0x15)
#define STATUS_EFI_ICMP_ERROR                                              (EFI_ERROR_MASK | 0x16)
#define STATUS_EFI_TFTP_ERROR                                              (EFI_ERROR_MASK | 0x17)
#define STATUS_EFI_PROTOCOL_ERROR                                          (EFI_ERROR_MASK | 0x18)
#define STATUS_EFI_INCOMPATIBLE_VERSION                                    (EFI_ERROR_MASK | 0x19)
#define STATUS_EFI_SECURITY_VIOLATION                                      (EFI_ERROR_MASK | 0x1A)
#define STATUS_EFI_CRC_ERROR                                               (EFI_ERROR_MASK | 0x1B)
#define STATUS_EFI_END_OF_MEDIA                                            (EFI_ERROR_MASK | 0x1C)
#define STATUS_EFI_END_OF_FILE                                             (EFI_ERROR_MASK | 0x1F)
#define STATUS_EFI_INVALID_LANGUAGE                                        (EFI_ERROR_MASK | 0x20)
#define STATUS_EFI_COMPROMISED_DATA                                        (EFI_ERROR_MASK | 0x21)
#define STATUS_EFI_IP_ADDRESS_CONFLICT                                     (EFI_ERROR_MASK | 0x22)
#define STATUS_EFI_HTTP_ERROR                                              (EFI_ERROR_MASK | 0x23)

#endif /* __XTDK_XTSTATUS_H */