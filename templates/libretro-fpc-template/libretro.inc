//-------------------------------------------------------------------------
//
//  libretro.inc
//  - Include file for __PROJNAME__ project.
//    __RATitle__
//
//  Template file.
//  - Copy to your project folder and name it to libretro.inc
//  - Generated with Libretro-FPC template:
//    https://github.com/tednilsen/Libretro-FPC
//
//-------------------------------------------------------------------------

{$MACRO ON}

// define libretro header version, min v1.70 (107000) / max v1.10.03 (110003)
{$DEFINE RETRO_VERSION := 110003}

// define to include audio
{$DEFINE RETRO_AUDIO}

// define to include joypad
{$DEFINE RETRO_JOYPAD}

// define to include cpu features
{$DEFINE RETRO_CPU}

// define to include language features
{.$DEFINE RETRO_LANGUAGE}

// define to use TRetro_key = cint, undefined TRetro_key = enumeration
{$DEFINE RETRO_KEYTYPE_INTEGER}

// define to include retro colors
{$DEFINE RETRO_COLOR}

// define the pixel-format to use (max define 1, none for autoselect)
{$DEFINE RETRO_COLOR_RGB565}
{.$DEFINE RETRO_COLOR_XRGB8888}

// define color palettes to include, multi-choice
{$DEFINE RETRO_COLOR_PALETTE_BIG}    // include * Big color palette
{.$DEFINE RETRO_COLOR_PALETTE_VGA}    // include * VGA color palette
{.$DEFINE RETRO_COLOR_PALETTE_CBM}    // include * VIC-II / C64 color palette
{.$DEFINE RETRO_COLOR_PALETTE_CPC}    // include * Amstrad CPC color palette
{.$DEFINE RETRO_COLOR_PALETTE_MSX}    // include * Microsoft MSX color palette
{.$DEFINE RETRO_COLOR_PALETTE_ZX}     // include * ZX Spectrum color palette

// define to typecast the RETRO_COLOR_PALETTE (if any defined)
{.$DEFINE RETRO_COLOR_TYPECAST}

// XRGB8888 color X component (alpha, e.g: $FF000000)
{$DEFINE m8888X := $00000000}

//--------------------------------------------
//  * automatic macros, no need to edit *
//--------------------------------------------

// libretro headers calling
{$DEFINE RETRO_CALLCONV := cdecl}
{$DEFINE RETRO_API := cdecl}

// if too high version defined, set to latest
{$IF RETRO_VERSION > 110003}
  {$DEFINE RETRO_VERSION := 110003}
{$ENDIF}

// if no version defined, set to latest
{$IF RETRO_VERSION < 107000}
  {$DEFINE RETRO_VERSION := 110003}
{$ENDIF}

// if no color defined, autoselect
{$IFDEF RETRO_COLOR} {$IFNDEF RETRO_COLOR_RGB565} {$IFNDEF RETRO_COLOR_XRGB8888}
  {$IFDEF CPUARM}
    {$DEFINE RETRO_COLOR_RGB565}
  {$ELSE}
    {$DEFINE RETRO_COLOR_XRGB8888}
  {$ENDIF}
{$ENDIF} {$ENDIF} {$ENDIF}
