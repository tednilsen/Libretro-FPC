//-------------------------------------------------------------------------
//  libretro_color.inc
//  - Part of Libretro-FPC package.
//    https://github.com/tednilsen/Libretro-FPC
//
//  * automatic macros, no need to edit *
//
//-------------------------------------------------------------------------

{$INCLUDE libretro.inc}

// if no color defined, autoselect
{$IFNDEF RETRO_COLOR_RGB565} {$IFNDEF RETRO_COLOR_XRGB8888}
  {$IFDEF CPUARM}
    {$DEFINE RETRO_COLOR_RGB565}
  {$ELSE}
    {$DEFINE RETRO_COLOR_XRGB8888}
  {$ENDIF}
{$ENDIF} {$ENDIF}

// include predefined colors?
{$IFDEF RETRO_COLOR_PALETTE_BIG}   {$DEFINE RETRO_COLOR_DEFINE}  {$ENDIF}
{$IFDEF RETRO_COLOR_PALETTE_VGA}   {$DEFINE RETRO_COLOR_DEFINE}  {$ENDIF}
{$IFDEF RETRO_COLOR_PALETTE_CBM}   {$DEFINE RETRO_COLOR_DEFINE}  {$ENDIF}
{$IFDEF RETRO_COLOR_PALETTE_CPC}   {$DEFINE RETRO_COLOR_DEFINE}  {$ENDIF}
{$IFDEF RETRO_COLOR_PALETTE_MSX}   {$DEFINE RETRO_COLOR_DEFINE}  {$ENDIF}
{$IFDEF RETRO_COLOR_PALETTE_ZX}    {$DEFINE RETRO_COLOR_DEFINE}  {$ENDIF}

