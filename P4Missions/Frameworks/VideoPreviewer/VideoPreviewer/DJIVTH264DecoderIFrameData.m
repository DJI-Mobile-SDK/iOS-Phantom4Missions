//
//  DJIVTH264DecoderIFrameData.m
//
//  Copyright (c) 2013 DJI. All rights reserved.
//


#import "DJIVTH264DecoderIFrameData.h"
#import "H264VTDecode.h"

static const uint8_t g_idr_inspire_1280_720[] = {0x00, 0x00, 0x00, 0x3F, 0x65, 0x88, 0x84, 0x0E, 0x7F, 0xCE, 0xB2, 0xDC, 0x5F, 0xF4, 0xFC, 0x67, 0xC4, 0xE3, 0x77, 0xD0, 0x04, 0x65, 0x67, 0x40, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x01, 0x7C, 0xB4, 0x89, 0x39, 0x43, 0xCB, 0xD2, 0x8A, 0x57, 0x45, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x01, 0x11, 0xED, 0x80, 0x00, 0x8C, 0x51, 0x80, 0x00, 0xE0, 0x2F, 0x00, 0x01, 0x5E, 0x00, 0x0B, 0x78, 0x00, 0x00, 0x00, 0x47, 0x65, 0x00, 0xF0, 0x88, 0x84, 0x0E, 0x7F, 0xCE, 0xB3, 0x04, 0x01, 0xF5, 0x8F, 0xFF, 0xF3, 0x53, 0x56, 0x41, 0x97, 0x6E, 0x19, 0xBE, 0xB0, 0xC7, 0x77, 0x8C, 0x69, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x87, 0xB8, 0x39, 0x20, 0x5A, 0x70, 0xE1, 0x0F, 0x8C, 0x0F, 0xCD, 0xC8, 0x56, 0x00, 0x00, 0x03, 0x00, 0x00, 0x10, 0x7C, 0x00, 0x04, 0xA8, 0x00, 0x13, 0x2B, 0x78, 0x00, 0x0E, 0x00, 0x00, 0x69, 0xC0, 0x00, 0x00, 0x00, 0x42, 0x65, 0x00, 0x78, 0x22, 0x21, 0x03, 0x9F, 0xCE, 0xB3, 0x04, 0x00, 0xC8, 0xE7, 0xFF, 0xF9, 0xCE, 0x6A, 0xDB, 0x0B, 0xBF, 0x4C, 0xE1, 0xA2, 0x1A, 0xFD, 0x60, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x27, 0x7D, 0x51, 0xF9, 0x0B, 0x3B, 0x6D, 0x5D, 0x60, 0x00, 0x00, 0x03, 0x00, 0x00, 0x29, 0x80, 0x00, 0xBD, 0xDB, 0x80, 0x00, 0x9F, 0x80, 0x04, 0x2A, 0xD4, 0x00, 0x05, 0xBC, 0x00, 0x00, 0x00, 0x42, 0x65, 0x00, 0x2D, 0x08, 0x88, 0x40, 0xE7, 0xCE, 0xB3, 0x04, 0x00, 0x5C, 0xF1, 0xFF, 0xFE, 0x78, 0xA6, 0xAD, 0xB0, 0xBB, 0xF4, 0xCE, 0x1A, 0x21, 0xAF, 0xD6, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x02, 0x77, 0xD5, 0x1F, 0x90, 0xB3, 0xB6, 0xD5, 0xD6, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x02, 0x98, 0x00, 0x08, 0xF8, 0x00, 0x22, 0xA0, 0x00, 0x9D, 0x00, 0x05, 0x0C, 0x00, 0x00, 0x00, 0x42, 0x65, 0x00, 0x3C, 0x08, 0x88, 0x40, 0xE7, 0xCE, 0xB3, 0x04, 0x00, 0x5C, 0xF1, 0xFF, 0xFE, 0x78, 0xA6, 0xAD, 0xB0, 0xBB, 0xF4, 0xCE, 0x1A, 0x21, 0xAF, 0xD6, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x02, 0x77, 0xEA, 0xF5, 0xC5, 0xF0, 0x7E, 0xDA, 0xB7, 0xF2, 0xE0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x69, 0x80, 0x01, 0x7E, 0x00, 0x07, 0x58, 0x00, 0x20, 0x20, 0x01, 0x0F, 0x00, 0x00, 0x00, 0x44, 0x65, 0x00, 0x12, 0xC2, 0x22, 0x10, 0x39, 0xFF, 0xCE, 0xB3, 0x04, 0x00, 0x43, 0x79, 0xFF, 0xFE, 0x79, 0x26, 0xAC, 0x9E, 0x06, 0x1D, 0xBA, 0xF6, 0x76, 0x56, 0x3C, 0xE7, 0x97, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x47, 0x36, 0xA5, 0x11, 0xC5, 0x45, 0xD2, 0xB6, 0xAE, 0xB0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x22, 0xD8, 0x00, 0x0A, 0xB8, 0x00, 0x23, 0xE0, 0x00, 0x8A, 0x80, 0x04, 0x04, 0x00, 0x00, 0x00, 0x46, 0x65, 0x00, 0x16, 0x82, 0x22, 0x10, 0x39, 0xFF, 0xCE, 0xB3, 0x04, 0x00, 0x43, 0x79, 0xFF, 0xFE, 0x79, 0x26, 0xAC, 0x9E, 0x06, 0x1D, 0xBA, 0xF6, 0x76, 0x56, 0x3C, 0xE7, 0x97, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x47, 0x36, 0xA5, 0x11, 0xC5, 0x45, 0xD2, 0xB6, 0xAE, 0xB0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x23, 0xA2, 0xA0, 0x00, 0x01, 0x8C, 0x00, 0x05, 0xF8, 0x00, 0x1D, 0x60, 0x00, 0xD3, 0x80, 0x00, 0x00, 0x00, 0x3B, 0x65, 0x00, 0x1A, 0x42, 0x22, 0x10, 0x39, 0xFF, 0xCE, 0xB3, 0x04, 0x00, 0x32, 0x38, 0xFF, 0xFF, 0x3D, 0x73, 0x56, 0x18, 0xBA, 0x7F, 0x34, 0xF7, 0x3A, 0xB1, 0xE7, 0x3C, 0xB8, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x01, 0x4A, 0x12, 0x91, 0xC5, 0x45, 0xD2, 0xB6, 0xAE, 0xB0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x22, 0xD8, 0x00, 0x0F, 0x88};

static const uint8_t g_idr_phantom3_1280_720[] = {0x00, 0x00, 0x00, 0x52, 0x25, 0xB8, 0x21, 0x7F, 0xB7, 0x95, 0x55, 0x64, 0xD2, 0xFF, 0xF8, 0x49, 0x59, 0xF6, 0x04, 0x27, 0x9C, 0xA5, 0xF6, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x08, 0x28, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x01, 0x64, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x72, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x41, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x32, 0x40, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x5A, 0x40, 0x00, 0x00, 0x00, 0x54, 0x25, 0x00, 0xF0, 0xB8, 0x20, 0x4F, 0xF2, 0x83, 0x60, 0xE4, 0xDF, 0xC0, 0xF4, 0x81, 0x88, 0xD0, 0xDA, 0xFC, 0xAE, 0x47, 0xC7, 0x7E, 0x62, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0xB6, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x0A, 0x04, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x04, 0xD4, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x03, 0x24, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x05, 0xA4, 0x00, 0x00, 0x00, 0x54, 0x25, 0x00, 0x78, 0x2E, 0x08, 0x13, 0xF2, 0x83, 0x60, 0xE4, 0xDF, 0xC0, 0xF4, 0x81, 0x88, 0xD0, 0xDA, 0xFC, 0xAE, 0x47, 0xC7, 0x7E, 0x62, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0xB6, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x0A, 0x04, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x04, 0xD4, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x03, 0x24, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x05, 0xA4, 0x00, 0x00, 0x00, 0x55, 0x25, 0x00, 0x2D, 0x0B, 0x82, 0x04, 0xFF, 0xF2, 0x83, 0x60, 0xE4, 0xDF, 0xC0, 0xF4, 0x81, 0x88, 0xD0, 0xDA, 0xFC, 0xAE, 0x47, 0xC7, 0x7E, 0x62, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0xB6, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x0A, 0x04, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x04, 0xD4, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x03, 0x24, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x05, 0xA4, 0x00, 0x00, 0x00, 0x55, 0x25, 0x00, 0x3C, 0x0B, 0x82, 0x04, 0xFF, 0xF2, 0x83, 0x60, 0xE4, 0xDF, 0xC0, 0xF4, 0x81, 0x88, 0xD0, 0xDA, 0xFC, 0xAE, 0x47, 0xC7, 0x7E, 0x62, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0xB6, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x0A, 0x04, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x04, 0xD4, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x03, 0x24, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x05, 0xA4, 0x00, 0x00, 0x00, 0x55, 0x25, 0x00, 0x12, 0xC2, 0xE0, 0x81, 0x3F, 0xF2, 0x83, 0x60, 0xE4, 0xDF, 0xC0, 0xF4, 0x81, 0x88, 0xD0, 0xDA, 0xFC, 0xAE, 0x47, 0xC7, 0x7E, 0x62, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0xB6, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x0A, 0x04, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x04, 0xD4, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x03, 0x24, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x05, 0xA4, 0x00, 0x00, 0x00, 0x55, 0x25, 0x00, 0x16, 0x82, 0xE0, 0x81, 0x3F, 0xF2, 0x83, 0x60, 0xE4, 0xDF, 0xC0, 0xF4, 0x81, 0x88, 0xD0, 0xDA, 0xFC, 0xAE, 0x47, 0xC7, 0x7E, 0x62, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0xB6, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x0A, 0x04, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x04, 0xD4, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x03, 0x24, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x05, 0xA4, 0x00, 0x00, 0x00, 0x3A, 0x25, 0x00, 0x1A, 0x42, 0xE0, 0x81, 0x3F, 0xF2, 0x83, 0x60, 0xE4, 0xDF, 0xC0, 0xF4, 0x81, 0x88, 0xD0, 0xDA, 0xFC, 0xAE, 0x47, 0xC7, 0x7E, 0x62, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0xB6, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x10, 0x70};

static const uint8_t g_idr_phantom3_960_720[] = {0x00, 0x00, 0x00, 0x43, 0x25, 0xB8, 0x21, 0xFF, 0xDA, 0x8D, 0xE9, 0x70, 0x18, 0x53, 0xFC, 0x17, 0x4D, 0x4E, 0x14, 0xBE, 0x4D, 0x82, 0xF3, 0x75, 0xE0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x03, 0xC0, 0x80, 0x00, 0x00, 0x03, 0x00, 0x19, 0x28, 0x00, 0x00, 0x03, 0x00, 0x01, 0x4E, 0x80, 0x00, 0x00, 0x03, 0x00, 0x1A, 0xB8, 0x00, 0x00, 0x03, 0x00, 0x03, 0x92, 0x00, 0x00, 0x03, 0x00, 0x01, 0x6F, 0x00, 0x00, 0x00, 0x46, 0x25, 0x00, 0xB4, 0xB8, 0x20, 0x7F, 0xF6, 0x62, 0x8E, 0x75, 0xFF, 0x99, 0x61, 0x1A, 0xF2, 0xD8, 0xF2, 0xF2, 0xB3, 0x64, 0xE6, 0x83, 0x80, 0x49, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x52, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x02, 0x77, 0x80, 0x00, 0x00, 0x03, 0x00, 0x22, 0xD0, 0x00, 0x00, 0x03, 0x00, 0x03, 0x57, 0x00, 0x00, 0x03, 0x00, 0x00, 0x72, 0x40, 0x00, 0x00, 0x03, 0x00, 0x2D, 0xE0, 0x00, 0x00, 0x00, 0x46, 0x25, 0x00, 0x5A, 0x2E, 0x08, 0x1F, 0xF6, 0x62, 0x8E, 0x75, 0xFF, 0x99, 0x61, 0x1A, 0xF2, 0xD8, 0xF2, 0xF2, 0xB3, 0x64, 0xE6, 0x83, 0x80, 0x49, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x52, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x02, 0x77, 0x80, 0x00, 0x00, 0x03, 0x00, 0x22, 0xD0, 0x00, 0x00, 0x03, 0x00, 0x03, 0x57, 0x00, 0x00, 0x03, 0x00, 0x00, 0x72, 0x40, 0x00, 0x00, 0x03, 0x00, 0x2D, 0xE0, 0x00, 0x00, 0x00, 0x47, 0x25, 0x00, 0x21, 0xCB, 0x82, 0x07, 0xFF, 0xF6, 0x62, 0x8E, 0x75, 0xFF, 0x99, 0x61, 0x1A, 0xF2, 0xD8, 0xF2, 0xF2, 0xB3, 0x64, 0xE6, 0x83, 0x80, 0x49, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x52, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x02, 0x77, 0x80, 0x00, 0x00, 0x03, 0x00, 0x22, 0xD0, 0x00, 0x00, 0x03, 0x00, 0x03, 0x57, 0x00, 0x00, 0x03, 0x00, 0x00, 0x72, 0x40, 0x00, 0x00, 0x03, 0x00, 0x2D, 0xE0, 0x00, 0x00, 0x00, 0x47, 0x25, 0x00, 0x2D, 0x0B, 0x82, 0x07, 0xFF, 0xF6, 0x62, 0x8E, 0x75, 0xFF, 0x99, 0x61, 0x1A, 0xF2, 0xD8, 0xF2, 0xF2, 0xB3, 0x64, 0xE6, 0x83, 0x80, 0x49, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x52, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x02, 0x77, 0x80, 0x00, 0x00, 0x03, 0x00, 0x22, 0xD0, 0x00, 0x00, 0x03, 0x00, 0x03, 0x57, 0x00, 0x00, 0x03, 0x00, 0x00, 0x72, 0x40, 0x00, 0x00, 0x03, 0x00, 0x2D, 0xE0, 0x00, 0x00, 0x00, 0x47, 0x25, 0x00, 0x38, 0x4B, 0x82, 0x07, 0xFF, 0xF6, 0x62, 0x8E, 0x75, 0xFF, 0x99, 0x61, 0x1A, 0xF2, 0xD8, 0xF2, 0xF2, 0xB3, 0x64, 0xE6, 0x83, 0x80, 0x49, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x52, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x02, 0x77, 0x80, 0x00, 0x00, 0x03, 0x00, 0x22, 0xD0, 0x00, 0x00, 0x03, 0x00, 0x03, 0x57, 0x00, 0x00, 0x03, 0x00, 0x00, 0x72, 0x40, 0x00, 0x00, 0x03, 0x00, 0x2D, 0xE0, 0x00, 0x00, 0x00, 0x47, 0x25, 0x00, 0x10, 0xE2, 0xE0, 0x81, 0xFF, 0xF6, 0x62, 0x8E, 0x75, 0xFF, 0x99, 0x61, 0x1A, 0xF2, 0xD8, 0xF2, 0xF2, 0xB3, 0x64, 0xE6, 0x83, 0x80, 0x49, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x52, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x02, 0x77, 0x80, 0x00, 0x00, 0x03, 0x00, 0x22, 0xD0, 0x00, 0x00, 0x03, 0x00, 0x03, 0x57, 0x00, 0x00, 0x03, 0x00, 0x00, 0x72, 0x40, 0x00, 0x00, 0x03, 0x00, 0x2D, 0xE0, 0x00, 0x00, 0x00, 0x34, 0x25, 0x00, 0x13, 0xB2, 0xE0, 0x81, 0xFF, 0xF6, 0x62, 0x8E, 0x75, 0xFF, 0x99, 0x61, 0x1A, 0xF2, 0xD8, 0xF2, 0xF2, 0xB3, 0x64, 0xE6, 0x83, 0x80, 0x49, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x52, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x02, 0x77, 0x80, 0x00, 0x00, 0x03, 0x00, 0x3A, 0x60};

static const uint8_t g_idr_phantom4_1280_720[] = {0x00, 0x00, 0x00, 0x4A, 0x25, 0xB0, 0x20, 0x04, 0xCA, 0x6F, 0x00, 0x52, 0x2B, 0xC0, 0x65, 0x3F, 0xFF, 0x10, 0x42, 0x7B, 0x98, 0x11, 0x23, 0x6E, 0xCD, 0x91, 0x7E, 0x34, 0xF4, 0xDF, 0x5C, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0xA8, 0x39, 0x31, 0xDD, 0xBA, 0xCB, 0xC6, 0xDA, 0xD7, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x01, 0xAC, 0x00, 0x04, 0xE4, 0x00, 0x11, 0xF0, 0x00, 0x3B, 0x80, 0x01, 0x08, 0x00, 0x05, 0x90, 0x00, 0x23, 0x80, 0x01, 0x81, 0x00, 0x00, 0x00, 0x67, 0x25, 0x00, 0x5A, 0x2C, 0x08, 0x01, 0x02, 0x32, 0x9B, 0xF2, 0x83, 0x60, 0xFD, 0x41, 0xFF, 0x7F, 0x03, 0x8A, 0x3F, 0xEC, 0xF4, 0xAF, 0x16, 0x41, 0xD5, 0x06, 0x2E, 0xD9, 0x7F, 0x4C, 0x4D, 0x0F, 0x73, 0x14, 0xA9, 0xEB, 0x40, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x02, 0xB7, 0x9F, 0xB7, 0x62, 0x71, 0x10, 0x1C, 0x3A, 0x41, 0xD6, 0x4F, 0x70, 0x00, 0x00, 0x03, 0x00, 0x00, 0x0A, 0x6C, 0x28, 0x12, 0xC0, 0x00, 0x12, 0xDB, 0x65, 0xFD, 0x00, 0x00, 0xD3, 0x2D, 0xE5, 0xF0, 0x00, 0x27, 0xC7, 0x23, 0x00, 0x00, 0x05, 0xFE, 0xF2, 0x70, 0x00, 0x10, 0x44, 0xCE, 0x40, 0x00, 0x57, 0xEA, 0xC2, 0x00, 0x12, 0xD0, 0x00, 0x00, 0x00, 0x5C, 0x25, 0x00, 0x2D, 0x0B, 0x02, 0x00, 0x4C, 0xA6, 0x00, 0x52, 0x1B, 0x2F, 0xFF, 0x0F, 0x10, 0xF9, 0x8B, 0xEE, 0x9C, 0xE6, 0x51, 0xE2, 0xFA, 0x57, 0xDE, 0x41, 0xDE, 0x73, 0x1A, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x09, 0x9B, 0x49, 0x7A, 0xC5, 0xA6, 0x0B, 0xFC, 0x5B, 0x8D, 0x22, 0x90, 0x00, 0x00, 0x03, 0x00, 0x00, 0x08, 0x18, 0x35, 0xC3, 0xB0, 0x00, 0x1E, 0x9E, 0xB2, 0x2E, 0x00, 0x03, 0x58, 0xCD, 0xEF, 0x00, 0x01, 0x5F, 0x93, 0xE0, 0x80, 0x00, 0x27, 0x6F, 0x27, 0x00, 0x00, 0x86, 0x3A, 0x90, 0x00, 0x04, 0x1D, 0xAA, 0xC0, 0x02, 0x1E, 0x00, 0x00, 0x00, 0x5D, 0x25, 0x00, 0x10, 0xE2, 0xC0, 0x80, 0x13, 0x29, 0xBF, 0x00, 0x52, 0x1B, 0x2F, 0xFF, 0x0F, 0x10, 0xF9, 0x8B, 0xEE, 0x9C, 0xE6, 0x51, 0xE2, 0xFA, 0x57, 0xDE, 0x41, 0xDE, 0x73, 0x1A, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x09, 0x9B, 0x49, 0x7A, 0xC5, 0xA6, 0x0B, 0xFC, 0x5B, 0x8D, 0x22, 0x90, 0x00, 0x00, 0x03, 0x00, 0x00, 0x08, 0x18, 0x35, 0xC3, 0xB0, 0x00, 0x1E, 0x9E, 0xB2, 0x2E, 0x00, 0x03, 0x58, 0xCD, 0xEF, 0x00, 0x01, 0x5F, 0x93, 0xE0, 0x80, 0x00, 0x27, 0x6F, 0x27, 0x00, 0x00, 0x86, 0x3A, 0x90, 0x00, 0x04, 0x1D, 0xAA, 0xC0, 0x02, 0x1E, 0x00, 0x00, 0x00, 0x5D, 0x25, 0x00, 0x16, 0x82, 0xC0, 0x80, 0x13, 0x29, 0xBF, 0x00, 0x52, 0x1B, 0x2F, 0xFF, 0x0F, 0x10, 0xF9, 0x8B, 0xEE, 0x9C, 0xE6, 0x51, 0xE2, 0xFA, 0x57, 0xDE, 0x41, 0xDE, 0x73, 0x1A, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x09, 0x9B, 0x49, 0x7A, 0xC5, 0xA6, 0x0B, 0xFC, 0x5B, 0x8D, 0x22, 0x90, 0x00, 0x00, 0x03, 0x00, 0x00, 0x08, 0x18, 0x35, 0xC3, 0xB0, 0x00, 0x1E, 0x9E, 0xB2, 0x2E, 0x00, 0x03, 0x58, 0xCD, 0xEF, 0x00, 0x01, 0x5F, 0x93, 0xE0, 0x80, 0x00, 0x27, 0x6F, 0x27, 0x00, 0x00, 0x86, 0x3A, 0x90, 0x00, 0x04, 0x1D, 0xAA, 0xC0, 0x02, 0x1E};

static const uint8_t g_idr_OsmoNo368_640_368[] = {0x00, 0x00, 0x00, 0x3C, 0x25, 0xB8, 0x20, 0x37, 0xFA, 0x60, 0x52, 0x7F, 0xF5, 0x39, 0xD8, 0x05, 0x0F, 0x60, 0xCB, 0xFE, 0xF6, 0x4B, 0xF4, 0x9B, 0x61, 0x8A, 0xC5, 0x98, 0x95, 0x1A, 0xBB, 0x3B, 0xD1, 0x45, 0x01, 0x12, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x01, 0x2E, 0x76, 0x4B, 0x8B, 0xE7, 0xBF, 0xD0, 0x00, 0x0A, 0x00, 0x0C, 0xD0, 0x74, 0x85, 0x60, 0x71, 0x40, 0x00, 0x00, 0x00, 0x3D, 0x25, 0x01, 0xE2, 0xE0, 0x80, 0x4B, 0xFA, 0x7E, 0x0B, 0xB9, 0xFC, 0xA3, 0x14, 0xFC, 0xD4, 0x6F, 0xFB, 0xEE, 0x73, 0xF3, 0x16, 0xE4, 0x87, 0x33, 0xCE, 0xE1, 0x49, 0xB5, 0x62, 0xE3, 0xF1, 0x55, 0x22, 0xF1, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x22, 0xD2, 0xF6, 0x50, 0xA9, 0x72, 0x22, 0xD0, 0x00, 0x18, 0x80, 0x17, 0xF0, 0xC1, 0x08, 0x98, 0xC0, 0x80, 0x00, 0x00, 0x00, 0x3E, 0x25, 0x00, 0xF0, 0xB8, 0x20, 0x12, 0xFF, 0xFA, 0x7E, 0x0B, 0xB9, 0xFC, 0xA3, 0x14, 0xFC, 0xD4, 0x6F, 0xFB, 0xEE, 0x73, 0xF3, 0x16, 0xE4, 0x87, 0x33, 0xCE, 0xE1, 0x49, 0xB5, 0x62, 0xE3, 0xF1, 0x55, 0x22, 0xF1, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x22, 0xD2, 0xF6, 0x50, 0xA9, 0x72, 0x22, 0xD0, 0x00, 0x18, 0x80, 0x17, 0xF0, 0xC1, 0x08, 0x98, 0xC0, 0x80, 0x00, 0x00, 0x00, 0x3C, 0x25, 0x00, 0x5A, 0x2E, 0x08, 0x04, 0xBF, 0xFA, 0x7E, 0x0B, 0xB9, 0xFC, 0xA3, 0x14, 0xFC, 0xD4, 0x6F, 0xFB, 0xEE, 0x73, 0xF3, 0x16, 0xE4, 0x87, 0x33, 0xCE, 0xE1, 0x49, 0xB5, 0x62, 0xE3, 0xF1, 0x55, 0x22, 0xF1, 0x80, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x22, 0xD2, 0xF6, 0x50, 0xA9, 0x72, 0x22, 0xD0, 0x00, 0x18, 0x80, 0x17, 0xF0, 0xC1, 0x0D, 0x98};

static const uint8_t g_idr_OsmoNo368_960_720[] = {0x00, 0x00, 0x00, 0x49, 0x25, 0xB8, 0x20, 0xFF, 0xEB, 0x08, 0x6B, 0x38, 0x0C, 0x5B, 0xFC, 0x0F, 0x73, 0x90, 0xFD, 0xD8, 0x3F, 0x0C, 0x50, 0x04, 0x12, 0x27, 0xD5, 0x83, 0x66, 0x4E, 0x11, 0x94, 0xE7, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x7A, 0x77, 0x09, 0xCD, 0x81, 0x2A, 0x00, 0x00, 0x1C, 0x80, 0x06, 0xE8, 0x02, 0xB0, 0x01, 0x16, 0x00, 0x9C, 0x80, 0x6B, 0x00, 0x45, 0xC0, 0x2F, 0x00, 0x2D, 0xC0, 0x22, 0x00, 0x4D, 0x40, 0x00, 0x00, 0x00, 0x4C, 0x25, 0x00, 0x5A, 0x2E, 0x08, 0x09, 0xFF, 0xF8, 0x80, 0xD6, 0x7D, 0xF3, 0xC0, 0x6B, 0xCA, 0x07, 0xFB, 0xE6, 0xFF, 0x8E, 0x6C, 0xC6, 0x44, 0x86, 0x16, 0xF0, 0x45, 0x52, 0x4F, 0x7F, 0xD9, 0x35, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x21, 0x3A, 0xC9, 0xAF, 0xA6, 0x50, 0x40, 0x00, 0x02, 0x7A, 0x00, 0x7D, 0x00, 0x26, 0x80, 0x11, 0x20, 0x07, 0x58, 0x04, 0x14, 0x02, 0xC0, 0x02, 0x2E, 0x01, 0x7A, 0x01, 0x70, 0x02, 0x6A, 0x00, 0x00, 0x00, 0x4C, 0x25, 0x00, 0x2D, 0x0B, 0x82, 0x02, 0x7F, 0xF8, 0x80, 0xD6, 0x7D, 0xF3, 0xC0, 0x6B, 0xCA, 0x07, 0xFB, 0xE6, 0xFF, 0x8E, 0x6C, 0xC6, 0x44, 0x86, 0x16, 0xF0, 0x45, 0x52, 0x4F, 0x7F, 0xD9, 0x35, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x21, 0x3A, 0xC9, 0xAF, 0xA6, 0x50, 0x40, 0x00, 0x02, 0x7A, 0x00, 0x7D, 0x00, 0x26, 0x80, 0x11, 0x20, 0x07, 0x58, 0x04, 0x14, 0x02, 0xC0, 0x02, 0x2E, 0x01, 0x7A, 0x01, 0x70, 0x02, 0x6A, 0x00, 0x00, 0x00, 0x46, 0x25, 0x00, 0x10, 0xE2, 0xE0, 0x80, 0x9F, 0xF8, 0x80, 0xD6, 0x7D, 0xF3, 0xC0, 0x6B, 0xCA, 0x07, 0xFB, 0xE6, 0xFF, 0x8E, 0x6C, 0xC6, 0x44, 0x86, 0x16, 0xF0, 0x45, 0x52, 0x4F, 0x7F, 0xD9, 0x35, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x21, 0x3A, 0xC9, 0xAF, 0xA6, 0x50, 0x40, 0x00, 0x02, 0x7A, 0x00, 0x7D, 0x00, 0x26, 0x80, 0x11, 0x20, 0x07, 0x58, 0x04, 0x14, 0x02, 0xC0, 0x03, 0xF6};

static const uint8_t g_idr_OsmoNo368_1280_720[] = {0x00, 0x00, 0x00, 0x52, 0x25, 0xB8, 0x20, 0xFF, 0xEB, 0x08, 0x6B, 0x38, 0x1B, 0xFF, 0xF3, 0x44, 0xDF, 0x26, 0xE1, 0x5D, 0x83, 0xF0, 0xC5, 0x00, 0x41, 0x22, 0x7D, 0x58, 0x36, 0x64, 0xE1, 0x19, 0x4E, 0x70, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x23, 0x12, 0x67, 0xEF, 0x48, 0xA9, 0x00, 0x00, 0x03, 0x00, 0x61, 0xC0, 0x00, 0xE1, 0x00, 0x02, 0xBA, 0x00, 0x08, 0xD8, 0x00, 0x27, 0x40, 0x00, 0xD8, 0x00, 0x04, 0x70, 0x00, 0x17, 0xC0, 0x00, 0xBC, 0x00, 0x04, 0x40, 0x00, 0x4D, 0x40, 0x00, 0x00, 0x00, 0x55, 0x25, 0x00, 0x78, 0x2E, 0x08, 0x08, 0xFF, 0xF7, 0x81, 0x2D, 0x3C, 0xBB, 0xA8, 0xCB, 0x68, 0x40, 0x19, 0xDE, 0x89, 0x19, 0xAD, 0x3B, 0x88, 0x90, 0xC2, 0xA3, 0x09, 0xC5, 0x28, 0x90, 0x7D, 0xAE, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x57, 0x52, 0x1B, 0x10, 0xF1, 0x77, 0x00, 0x00, 0x03, 0x00, 0x39, 0x40, 0x00, 0x86, 0x00, 0x01, 0x57, 0x00, 0x04, 0x7C, 0x00, 0x11, 0x50, 0x00, 0x4E, 0x80, 0x01, 0x64, 0x00, 0x08, 0xE0, 0x00, 0x2F, 0x80, 0x01, 0x78, 0x00, 0x13, 0x50, 0x00, 0x00, 0x00, 0x55, 0x25, 0x00, 0x3C, 0x0B, 0x82, 0x02, 0x3F, 0xF7, 0x81, 0x2D, 0x3C, 0xBB, 0xA8, 0xCB, 0x68, 0x40, 0x19, 0xDE, 0x89, 0x19, 0xAD, 0x3B, 0x88, 0x90, 0xC2, 0xA3, 0x09, 0xC5, 0x28, 0x90, 0x7D, 0xAE, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x57, 0x52, 0x1B, 0x10, 0xF1, 0x77, 0x00, 0x00, 0x03, 0x00, 0x39, 0x40, 0x00, 0x86, 0x00, 0x01, 0x57, 0x00, 0x04, 0x7C, 0x00, 0x11, 0x50, 0x00, 0x4E, 0x80, 0x01, 0x64, 0x00, 0x08, 0xE0, 0x00, 0x2F, 0x80, 0x01, 0x78, 0x00, 0x13, 0x50, 0x00, 0x00, 0x00, 0x4D, 0x25, 0x00, 0x16, 0x82, 0xE0, 0x80, 0x8F, 0xF7, 0x81, 0x2D, 0x3C, 0xBB, 0xA8, 0xCB, 0x68, 0x40, 0x19, 0xDE, 0x89, 0x19, 0xAD, 0x3B, 0x88, 0x90, 0xC2, 0xA3, 0x09, 0xC5, 0x28, 0x90, 0x7D, 0xAE, 0xC0, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x00, 0x57, 0x52, 0x1B, 0x10, 0xF1, 0x77, 0x00, 0x00, 0x03, 0x00, 0x39, 0x40, 0x00, 0x86, 0x00, 0x01, 0x57, 0x00, 0x04, 0x7C, 0x00, 0x11, 0x50, 0x00, 0x4E, 0x80, 0x01, 0x64, 0x00, 0x10, 0x10};

int loadPrebuildIframePrivate(uint8_t* buffer, int in_buffer_size, PrebuildIframeInfo info){
    uint8_t *data = NULL;
    size_t dataSize = 0;
    
    switch (info.encoder_type) {
        case H264EncoderType_DM365_phamtom3x:
        case H264EncoderType_DM368_inspire:
        case H264EncoderType_DM368_longan:
            data = (uint8_t *)g_idr_inspire_1280_720;
            dataSize = sizeof(g_idr_inspire_1280_720);
            break;
        case H264EncoderType_A9_phantom3c: // H264EncoderType_A9_phantom3s is equal to 3c
            if (info.frame_width == 1280
                && info.frame_height == 720) {
                data = (uint8_t *)g_idr_phantom3_1280_720;
                dataSize = sizeof(g_idr_phantom3_1280_720);
            }
            else if(info.frame_height == 720
                    && info.frame_width == 960){
                data = (uint8_t *)g_idr_phantom3_960_720;
                dataSize = sizeof(g_idr_phantom3_960_720);
                memcpy(buffer, g_idr_phantom3_960_720, sizeof(g_idr_phantom3_960_720));
                return sizeof(g_idr_phantom3_960_720);
            }
            else {
                NSLog(@"Frame size is unknown. ");
            }
            break;
        case H264EncoderType_1860_phantom4x:
            data = (uint8_t *)g_idr_phantom4_1280_720;
            dataSize = sizeof(g_idr_phantom4_1280_720);
            break;
        case H264EncoderType_A9_OSMO_NO_368:
            if (info.frame_width == 1280
                && info.frame_height == 720) {
                data = (uint8_t *)g_idr_OsmoNo368_1280_720;
                dataSize = sizeof(g_idr_OsmoNo368_1280_720);
            }
            else if(info.frame_height == 720
                    && info.frame_width == 960){
                data = (uint8_t *)g_idr_OsmoNo368_960_720;
                dataSize = sizeof(g_idr_OsmoNo368_960_720);
            }
            else if(info.frame_height == 368
                    && info.frame_width == 640){
                data = (uint8_t *)g_idr_OsmoNo368_640_368;
                dataSize = sizeof(g_idr_OsmoNo368_640_368);
            }
            else {
                NSLog(@"Frame size is unknown. ");
            }
            break;
        default:
            break;
    }
    
    if (data != NULL && dataSize != 0) {
        memcpy(buffer, data, dataSize);
        return (int)dataSize;
    }
    
    return 0;
}
