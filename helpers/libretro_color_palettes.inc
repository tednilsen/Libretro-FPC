//-------------------------------------------------------------------------
//
//  libretro_color_palettes.inc
//  - Part of Libretro-FPC package.
//    https://github.com/tednilsen/Libretro-FPC
//
//-------------------------------------------------------------------------

{$IFDEF RETRO_COLOR_RGB565}

  {$IFDEF RETRO_COLOR_TYPECAST}
    {$DEFINE mCASTTYPE := : TRGB565 =}
  {$ELSE}
    {$DEFINE mCASTTYPE := =}
  {$ENDIF}

  {$IFDEF RETRO_COLOR_PALETTE_BIG}
  clBlack                mCASTTYPE $0000;
  clDimGray              mCASTTYPE $39E7;
  clGray                 mCASTTYPE $7BEF;
  clWhite                mCASTTYPE $FFFF;
  clMaroon               mCASTTYPE $7800;
  clGreen                mCASTTYPE $03E0;
  clOlive                mCASTTYPE $7BE0;
  clNavy                 mCASTTYPE $000F;
  clPurple               mCASTTYPE $780F;
  clTeal                 mCASTTYPE $03EF;
  clRed                  mCASTTYPE $F800;
  clLime                 mCASTTYPE $07E0;
  clYellow               mCASTTYPE $FFE0;
  clBlue                 mCASTTYPE $001F;
  clMagenta              mCASTTYPE $F81F;
  clCyan                 mCASTTYPE $07FF;
  clAliceBlue            mCASTTYPE $F7DF;
  clAntiqueWhite         mCASTTYPE $FF5A;
  clAquamarine           mCASTTYPE $7FFA;
  clAzure                mCASTTYPE $F7FF;
  clBeige                mCASTTYPE $F7BB;
  clBisque               mCASTTYPE $FF38;
  clBlancheDalmond       mCASTTYPE $FF59;
  clBlueViolet           mCASTTYPE $895C;
  clBrown                mCASTTYPE $A145;
  clBurlyWood            mCASTTYPE $DDD0;
  clCadetblue            mCASTTYPE $5CF4;
  clChartReuse           mCASTTYPE $7FE0;
  clChocolate            mCASTTYPE $D343;
  clCoral                mCASTTYPE $FBEA;
  clCornFlowerBlue       mCASTTYPE $64BD;
  clCornSilk             mCASTTYPE $FFDB;
  clCrimson              mCASTTYPE $D8A7;
  clDarkBlue             mCASTTYPE $0011;
  clDarkYellow           mCASTTYPE $8C40;
  clDarkCyan             mCASTTYPE $0451;
  clDarkGoldenRod        mCASTTYPE $BC21;
  clDarkGray             mCASTTYPE $AD55;
  clDarkGreen            mCASTTYPE $0320;
  clDarkKhaki            mCASTTYPE $BDAD;
  clDarkMagenta          mCASTTYPE $8811;
  clDarkOliveGreen       mCASTTYPE $5345;
  clDarkOrange           mCASTTYPE $8A20;
  clDarkOrchid           mCASTTYPE $9999;
  clDarkRed              mCASTTYPE $8800;
  clDarkSalmon           mCASTTYPE $ECAF;
  clDarkSeaGreen         mCASTTYPE $8DF1;
  clDarkSlateBlue        mCASTTYPE $49F1;
  clDarkSlateGray        mCASTTYPE $2A69;
  clDarkTurquoise        mCASTTYPE $067A;
  clDarkViolet           mCASTTYPE $901A;
  clDeepPink             mCASTTYPE $F8B2;
  clDeepSkyBlue          mCASTTYPE $05FF;
  clDodgerBlue           mCASTTYPE $1C9F;
  clFireBrick            mCASTTYPE $B104;
  clFloralWhite          mCASTTYPE $FFDE;
  clGainsBoro            mCASTTYPE $DEFB;
  clGhostWhite           mCASTTYPE $FFDF;
  clGold                 mCASTTYPE $FEA0;
  clGoldenRod            mCASTTYPE $DD24;
  clGreenYellow          mCASTTYPE $AFE5;
  clHoneyDew             mCASTTYPE $F7FE;
  clHotPink              mCASTTYPE $FB56;
  clIndianRed            mCASTTYPE $CAEB;
  clIndigo               mCASTTYPE $4810;
  clIvory                mCASTTYPE $FFFE;
  clKhaki                mCASTTYPE $F731;
  clLavender             mCASTTYPE $E73F;
  clLavenderBlush        mCASTTYPE $FF9E;
  clLawnGreen            mCASTTYPE $7FE0;
  clLemonChiffon         mCASTTYPE $FFD9;
  clLightBlue            mCASTTYPE $AEDC;
  clLightCoral           mCASTTYPE $F410;
  clLightCyan            mCASTTYPE $E7FF;
  clLightGoldenRodYellow mCASTTYPE $FFDA;
  clLightGreen           mCASTTYPE $9772;
  clLightGray            mCASTTYPE $D69A;
  clLightPink            mCASTTYPE $FDB8;
  clLightSalmon          mCASTTYPE $FD0F;
  clLightSeagreen        mCASTTYPE $2595;
  clLightSkyblue         mCASTTYPE $867F;
  clLightSlategray       mCASTTYPE $7453;
  clLightSteelblue       mCASTTYPE $B63B;
  clLightYellow          mCASTTYPE $FFFC;
  clLtGray               mCASTTYPE $C618;
  clMedGray              mCASTTYPE $A514;
  clDkGray               mCASTTYPE $8410;
  clMoneyGreen           mCASTTYPE $C6F8;
  clLegacySkyBlue        mCASTTYPE $A65E;
  clCream                mCASTTYPE $FFDE;
  clLimeGreen            mCASTTYPE $3666;
  clLinen                mCASTTYPE $FF9C;
  clMediumAquamarine     mCASTTYPE $6675;
  clMediumBlue           mCASTTYPE $0019;
  clMediumOrchid         mCASTTYPE $BABA;
  clMediumPurple         mCASTTYPE $939B;
  clMediumSeaGreen       mCASTTYPE $3D8E;
  clMediumSlateBlue      mCASTTYPE $7B5D;
  clMediumSpringGreen    mCASTTYPE $07D3;
  clMediumTurquoise      mCASTTYPE $4E99;
  clMediumVioletRed      mCASTTYPE $C0B0;
  clMidnightBlue         mCASTTYPE $18CE;
  clMintCream            mCASTTYPE $F7FF;
  clMistyRose            mCASTTYPE $FF3C;
  clMoccasin             mCASTTYPE $FF36;
  clNavajoWhite          mCASTTYPE $FEF5;
  clOldLace              mCASTTYPE $FFBC;
  clOliveDrab            mCASTTYPE $6C64;
  clOrange               mCASTTYPE $FC00;
  clOrangeRed            mCASTTYPE $FA20;
  clOrchid               mCASTTYPE $DB9A;
  clPaleGoldenRod        mCASTTYPE $EF55;
  clPaleGreen            mCASTTYPE $9FD3;
  clPaleTurquoise        mCASTTYPE $AF7D;
  clPaleVioletred        mCASTTYPE $DB92;
  clPapayaWhip           mCASTTYPE $FF7A;
  clPeachPuff            mCASTTYPE $FED7;
  clPeru                 mCASTTYPE $CC27;
  clPlum                 mCASTTYPE $DD1B;
  clPowderBlue           mCASTTYPE $B71C;
  clRosyBrown            mCASTTYPE $BC71;
  clRoyalBlue            mCASTTYPE $435C;
  clSaddleBrown          mCASTTYPE $8A22;
  clSalmon               mCASTTYPE $FC0E;
  clSandyBrown           mCASTTYPE $F52C;
  clSeaGreen             mCASTTYPE $2C4A;
  clSeaShell             mCASTTYPE $FFBD;
  clSienna               mCASTTYPE $A285;
  clSilver               mCASTTYPE $C618;
  clSkyblue              mCASTTYPE $867D;
  clSlateBlue            mCASTTYPE $6AD9;
  clSlateGray            mCASTTYPE $7412;
  clSnow                 mCASTTYPE $FFDF;
  clSpringgreen          mCASTTYPE $07EF;
  clSteelblue            mCASTTYPE $4416;
  clTan                  mCASTTYPE $D5B1;
  clThistle              mCASTTYPE $DDFB;
  clTomato               mCASTTYPE $FB08;
  clTurquoise            mCASTTYPE $471A;
  clViolet               mCASTTYPE $EC1D;
  clWheat                mCASTTYPE $F6F6;
  clWhitesmoke           mCASTTYPE $F7BE;
  clYellowgreen          mCASTTYPE $9E66;
  {$ENDIF RETRO_COLOR_PALETTE_BIG}

  // VGA color palette
  {$IFDEF RETRO_COLOR_PALETTE_VGA}
  clVgaBlack             mCASTTYPE $0000;
  clVgaGray              mCASTTYPE $8410;
  clVgaSilver            mCASTTYPE $C618;
  clVgaWhite             mCASTTYPE $FFFF;
  clVgaMaroon            mCASTTYPE $8000;
  clVgaRed               mCASTTYPE $F800;
  clVgaPurple            mCASTTYPE $8010;
  clVgaFuchsia           mCASTTYPE $F81F;
  clVgaGreen             mCASTTYPE $0400;
  clVgaLime              mCASTTYPE $07E0;
  clVgaOlive             mCASTTYPE $8400;
  clVgaYellow            mCASTTYPE $FFE0;
  clVgaNavy              mCASTTYPE $0010;
  clVgaBlue              mCASTTYPE $001F;
  clVgaTeal              mCASTTYPE $0410;
  clVgaAqua              mCASTTYPE $07FF;
  {$ENDIF RETRO_COLOR_PALETTE_VGA}

  // VIC-II / C64 color palette
  {$IFDEF RETRO_COLOR_PALETTE_CBM}
  clCbmBlack             mCASTTYPE $0000;
  clCbmWhite             mCASTTYPE $FFFF;
  clCbmRed               mCASTTYPE $69A5;
  clCbmCyan              mCASTTYPE $7536;
  clCbmPurple            mCASTTYPE $69F0;
  clCbmGreen             mCASTTYPE $5C68;
  clCbmBlue              mCASTTYPE $314F;
  clCbmYellow            mCASTTYPE $BE2D;
  clCbmOrange            mCASTTYPE $6A64;
  clCbmBrown             mCASTTYPE $41C0;
  clCbmLightRed          mCASTTYPE $9B2B;
  clCbmDarkGrey          mCASTTYPE $4228;
  clCbmGrey              mCASTTYPE $6B6D;
  clCbmLightGreen        mCASTTYPE $9E90;
  clCbmLightBlue         mCASTTYPE $6AF6;
  clCbmLightGrey         mCASTTYPE $94B2;
  {$ENDIF RETRO_COLOR_PALETTE_CBM}

  // Amstrad CPC color palette
  {$IFDEF RETRO_COLOR_PALETTE_CPC}
  clCpcBlack             mCASTTYPE $0000;
  clCpcBlue              mCASTTYPE $200F;
  clCpcBrightBlue        mCASTTYPE $501F;
  clCpcRed               mCASTTYPE $7800;
  clCpcMagenta           mCASTTYPE $780F;
  clCpcMauve             mCASTTYPE $901F;
  clCpcBrightRed         mCASTTYPE $F002;
  clCpcPurple            mCASTTYPE $F010;
  clCpcBrightMagenta     mCASTTYPE $F81F;
  clCpcGreen             mCASTTYPE $0C21;
  clCpcCyan              mCASTTYPE $2410;
  clCpcSkyBlue           mCASTTYPE $539F;
  clCpcYellow            mCASTTYPE $7C21;
  clCpcWhite             mCASTTYPE $8410;
  clCpcPastelBlue        mCASTTYPE $939F;
  clCpcOrange            mCASTTYPE $F402;
  clCpcPink              mCASTTYPE $F410;
  clCpcPastelMagenta     mCASTTYPE $FB9F;
  clCpcBrightGreen       mCASTTYPE $1FE3;
  clCpcSeaGreen          mCASTTYPE $2FF0;
  clCpcBrightCyan        mCASTTYPE #57FF;
  clCpcLime              mCASTTYPE $7FE3;
  clCpcPastelGreen       mCASTTYPE $87F0;
  clCpcPastelCyan        mCASTTYPE $97FF;
  clCpcBrightYellow      mCASTTYPE $F7E4;
  clCpcPastelYellow      mCASTTYPE $FFF0;
  clCpcBrightWhite       mCASTTYPE $FFFF;
  {$ENDIF RETRO_COLOR_PALETTE_CPC}

  // Microsoft MSX color palette
  {$IFDEF RETRO_COLOR_PALETTE_MSX}
  clMsxTransparent       mCASTTYPE $0000;
  clMsxBlack             mCASTTYPE $0000;
  clMsxMediumGreen       mCASTTYPE $3DC9;
  clMsxLightGreen        mCASTTYPE $768F;
  clMsxDarkBlue          mCASTTYPE $5ABC;
  clMsxLightBlue         mCASTTYPE $83BE;
  clMsxDarkRed           mCASTTYPE $BAEA;
  clMsxCyan              mCASTTYPE $66DD;
  clMsxMediumRed         mCASTTYPE $DB2B;
  clMsxLightRed          mCASTTYPE $FC4F;
  clMsxDarkYellow        mCASTTYPE $CE0B;
  clMsxLightYellow       mCASTTYPE $DE90;
  clMsxDarkGreen         mCASTTYPE $3D08;
  clMsxMagenta           mCASTTYPE $B336;
  clMsxGrey              mCASTTYPE $CE79;
  clMsxWhite             mCASTTYPE $FFFF;
  {$ENDIF RETRO_COLOR_PALETTE_MSX}

  // ZX Spectrum color palette
  {$IFDEF RETRO_COLOR_PALETTE_ZX}
  clZxBlack              mCASTTYPE $0000;
  clZxBlue               mCASTTYPE $401F;
  clZxRed                mCASTTYPE $F964;
  clZxMagenta            mCASTTYPE $F81F;
  clZxGreen              mCASTTYPE $07E6;
  clZxCyan               mCASTTYPE $07FF;
  clZxYellow             mCASTTYPE $FFE7;
  clZxWhite              mCASTTYPE $FFFF;
  clZxDarkBlack          mCASTTYPE $0000;
  clZxDarkBlue           mCASTTYPE $3018;
  clZxDarkRed            mCASTTYPE $C903;
  clZxDarkMagenta        mCASTTYPE $D019;
  clZxDarkGreen          mCASTTYPE $0665;
  clZxDarkCyan           mCASTTYPE $0659;
  clZxDarkYellow         mCASTTYPE $C666;
  clZxDarkWhite          mCASTTYPE $CE79;
  {$ENDIF RETRO_COLOR_PALETTE_ZX}

{$ENDIF RETRO_COLOR_RGB565}

{$IFDEF RETRO_COLOR_XRGB8888}

  {$IFDEF RETRO_COLOR_TYPECAST}
    {$DEFINE mCASTTYPE := : TXRGB8888 = }
  {$ELSE}
    {$DEFINE mCASTTYPE := = }
  {$ENDIF}

  // Big color palette
  {$IFDEF RETRO_COLOR_PALETTE_BIG}
  clBlack                mCASTTYPE $000000 or m8888X;
  clDimGray              mCASTTYPE $3F3F3F or m8888X;
  clGray                 mCASTTYPE $7F7F7F or m8888X;
  clWhite                mCASTTYPE $FFFFFF or m8888X;
  clMaroon               mCASTTYPE $7F0000 or m8888X;
  clGreen                mCASTTYPE $007F00 or m8888X;
  clOlive                mCASTTYPE $7F7F00 or m8888X;
  clNavy                 mCASTTYPE $00007F or m8888X;
  clPurple               mCASTTYPE $7F007F or m8888X;
  clTeal                 mCASTTYPE $007F7F or m8888X;
  clRed                  mCASTTYPE $FF0000 or m8888X;
  clLime                 mCASTTYPE $00FF00 or m8888X;
  clYellow               mCASTTYPE $FFFF00 or m8888X;
  clBlue                 mCASTTYPE $0000FF or m8888X;
  clMagenta              mCASTTYPE $FF00FF or m8888X;
  clCyan                 mCASTTYPE $00FFFF or m8888X;
  clAliceBlue            mCASTTYPE $F0F8FF or m8888X;
  clAntiqueWhite         mCASTTYPE $FAEBD7 or m8888X;
  clAquamarine           mCASTTYPE $7FFFD4 or m8888X;
  clAzure                mCASTTYPE $F0FFFF or m8888X;
  clBeige                mCASTTYPE $F5F5DC or m8888X;
  clBisque               mCASTTYPE $FFE4C4 or m8888X;
  clBlancheDalmond       mCASTTYPE $FFEBCD or m8888X;
  clBlueViolet           mCASTTYPE $8A2BE2 or m8888X;
  clBrown                mCASTTYPE $A52A2A or m8888X;
  clBurlyWood            mCASTTYPE $DEB887 or m8888X;
  clCadetblue            mCASTTYPE $5F9EA0 or m8888X;
  clChartReuse           mCASTTYPE $7FFF00 or m8888X;
  clChocolate            mCASTTYPE $D2691E or m8888X;
  clCoral                mCASTTYPE $FF7F50 or m8888X;
  clCornFlowerBlue       mCASTTYPE $6495ED or m8888X;
  clCornSilk             mCASTTYPE $FFF8DC or m8888X;
  clCrimson              mCASTTYPE $DC143C or m8888X;
  clDarkBlue             mCASTTYPE $00008B or m8888X;
  clDarkYellow           mCASTTYPE $8B8B00 or m8888X;
  clDarkCyan             mCASTTYPE $008B8B or m8888X;
  clDarkGoldenRod        mCASTTYPE $B8860B or m8888X;
  clDarkGray             mCASTTYPE $A9A9A9 or m8888X;
  clDarkGreen            mCASTTYPE $006400 or m8888X;
  clDarkKhaki            mCASTTYPE $BDB76B or m8888X;
  clDarkMagenta          mCASTTYPE $8B008B or m8888X;
  clDarkOliveGreen       mCASTTYPE $556B2F or m8888X;
  clDarkOrange           mCASTTYPE $884400 or m8888X;
  clDarkOrchid           mCASTTYPE $9932CC or m8888X;
  clDarkRed              mCASTTYPE $8B0000 or m8888X;
  clDarkSalmon           mCASTTYPE $E9967A or m8888X;
  clDarkSeaGreen         mCASTTYPE $8FBC8F or m8888X;
  clDarkSlateBlue        mCASTTYPE $483D8B or m8888X;
  clDarkSlateGray        mCASTTYPE $2F4F4F or m8888X;
  clDarkTurquoise        mCASTTYPE $00CED1 or m8888X;
  clDarkViolet           mCASTTYPE $9400D3 or m8888X;
  clDeepPink             mCASTTYPE $FF1493 or m8888X;
  clDeepSkyBlue          mCASTTYPE $00BFFF or m8888X;
  clDodgerBlue           mCASTTYPE $1E90FF or m8888X;
  clFireBrick            mCASTTYPE $B22222 or m8888X;
  clFloralWhite          mCASTTYPE $FFFAF0 or m8888X;
  clGainsBoro            mCASTTYPE $DCDCDC or m8888X;
  clGhostWhite           mCASTTYPE $F8F8FF or m8888X;
  clGold                 mCASTTYPE $FFD700 or m8888X;
  clGoldenRod            mCASTTYPE $DAA520 or m8888X;
  clGreenYellow          mCASTTYPE $ADFF2F or m8888X;
  clHoneyDew             mCASTTYPE $F0FFF0 or m8888X;
  clHotPink              mCASTTYPE $FF69B4 or m8888X;
  clIndianRed            mCASTTYPE $CD5C5C or m8888X;
  clIndigo               mCASTTYPE $4B0082 or m8888X;
  clIvory                mCASTTYPE $FFFFF0 or m8888X;
  clKhaki                mCASTTYPE $F0E68C or m8888X;
  clLavender             mCASTTYPE $E6E6FA or m8888X;
  clLavenderBlush        mCASTTYPE $FFF0F5 or m8888X;
  clLawnGreen            mCASTTYPE $7CFC00 or m8888X;
  clLemonChiffon         mCASTTYPE $FFFACD or m8888X;
  clLightBlue            mCASTTYPE $ADD8E6 or m8888X;
  clLightCoral           mCASTTYPE $F08080 or m8888X;
  clLightCyan            mCASTTYPE $E0FFFF or m8888X;
  clLightGoldenRodYellow mCASTTYPE $FAFAD2 or m8888X;
  clLightGreen           mCASTTYPE $90EE90 or m8888X;
  clLightGray            mCASTTYPE $D3D3D3 or m8888X;
  clLightPink            mCASTTYPE $FFB6C1 or m8888X;
  clLightSalmon          mCASTTYPE $FFA07A or m8888X;
  clLightSeagreen        mCASTTYPE $20B2AA or m8888X;
  clLightSkyblue         mCASTTYPE $87CEFA or m8888X;
  clLightSlategray       mCASTTYPE $778899 or m8888X;
  clLightSteelblue       mCASTTYPE $B0C4DE or m8888X;
  clLightYellow          mCASTTYPE $FFFFE0 or m8888X;
  clLtGray               mCASTTYPE $C0C0C0 or m8888X;
  clMedGray              mCASTTYPE $A0A0A4 or m8888X;
  clDkGray               mCASTTYPE $808080 or m8888X;
  clMoneyGreen           mCASTTYPE $C0DCC0 or m8888X;
  clLegacySkyBlue        mCASTTYPE $A6CAF0 or m8888X;
  clCream                mCASTTYPE $FFFBF0 or m8888X;
  clLimeGreen            mCASTTYPE $32CD32 or m8888X;
  clLinen                mCASTTYPE $FAF0E6 or m8888X;
  clMediumAquamarine     mCASTTYPE $66CDAA or m8888X;
  clMediumBlue           mCASTTYPE $0000CD or m8888X;
  clMediumOrchid         mCASTTYPE $BA55D3 or m8888X;
  clMediumPurple         mCASTTYPE $9370DB or m8888X;
  clMediumSeaGreen       mCASTTYPE $3CB371 or m8888X;
  clMediumSlateBlue      mCASTTYPE $7B68EE or m8888X;
  clMediumSpringGreen    mCASTTYPE $00FA9A or m8888X;
  clMediumTurquoise      mCASTTYPE $48D1CC or m8888X;
  clMediumVioletRed      mCASTTYPE $C71585 or m8888X;
  clMidnightBlue         mCASTTYPE $191970 or m8888X;
  clMintCream            mCASTTYPE $F5FFFA or m8888X;
  clMistyRose            mCASTTYPE $FFE4E1 or m8888X;
  clMoccasin             mCASTTYPE $FFE4B5 or m8888X;
  clNavajoWhite          mCASTTYPE $FFDEAD or m8888X;
  clOldLace              mCASTTYPE $FDF5E6 or m8888X;
  clOliveDrab            mCASTTYPE $6B8E23 or m8888X;
  clOrange               mCASTTYPE $FF8000 or m8888X;
  clOrangeRed            mCASTTYPE $FF4500 or m8888X;
  clOrchid               mCASTTYPE $DA70D6 or m8888X;
  clPaleGoldenRod        mCASTTYPE $EEE8AA or m8888X;
  clPaleGreen            mCASTTYPE $98FB98 or m8888X;
  clPaleTurquoise        mCASTTYPE $AFEEEE or m8888X;
  clPaleVioletred        mCASTTYPE $DB7093 or m8888X;
  clPapayaWhip           mCASTTYPE $FFEFD5 or m8888X;
  clPeachPuff            mCASTTYPE $FFDAB9 or m8888X;
  clPeru                 mCASTTYPE $CD853F or m8888X;
  clPlum                 mCASTTYPE $DDA0DD or m8888X;
  clPowderBlue           mCASTTYPE $B0E0E6 or m8888X;
  clRosyBrown            mCASTTYPE $BC8F8F or m8888X;
  clRoyalBlue            mCASTTYPE $4169E1 or m8888X;
  clSaddleBrown          mCASTTYPE $8B4513 or m8888X;
  clSalmon               mCASTTYPE $FA8072 or m8888X;
  clSandyBrown           mCASTTYPE $F4A460 or m8888X;
  clSeaGreen             mCASTTYPE $2E8B57 or m8888X;
  clSeaShell             mCASTTYPE $FFF5EE or m8888X;
  clSienna               mCASTTYPE $A0522D or m8888X;
  clSilver               mCASTTYPE $C0C0C0 or m8888X;
  clSkyblue              mCASTTYPE $87CEEB or m8888X;
  clSlateBlue            mCASTTYPE $6A5ACD or m8888X;
  clSlateGray            mCASTTYPE $708090 or m8888X;
  clSnow                 mCASTTYPE $FFFAFA or m8888X;
  clSpringgreen          mCASTTYPE $00FF7F or m8888X;
  clSteelblue            mCASTTYPE $4682B4 or m8888X;
  clTan                  mCASTTYPE $D2B48C or m8888X;
  clThistle              mCASTTYPE $D8BFD8 or m8888X;
  clTomato               mCASTTYPE $FF6347 or m8888X;
  clTurquoise            mCASTTYPE $40E0D0 or m8888X;
  clViolet               mCASTTYPE $EE82EE or m8888X;
  clWheat                mCASTTYPE $F5DEB3 or m8888X;
  clWhitesmoke           mCASTTYPE $F5F5F5 or m8888X;
  clYellowgreen          mCASTTYPE $9ACD32 or m8888X;
  {$ENDIF RETRO_COLOR_PALETTE_BIG}

  // VGA color palette
  {$IFDEF RETRO_COLOR_PALETTE_VGA}
  clVgaBlack             mCASTTYPE $000000 or m8888X;
  clVgaGray              mCASTTYPE $808080 or m8888X;
  clVgaSilver            mCASTTYPE $C0C0C0 or m8888X;
  clVgaWhite             mCASTTYPE $FFFFFF or m8888X;
  clVgaMaroon            mCASTTYPE $800000 or m8888X;
  clVgaRed               mCASTTYPE $FF0000 or m8888X;
  clVgaPurple            mCASTTYPE $800080 or m8888X;
  clVgaFuchsia           mCASTTYPE $FF00FF or m8888X;
  clVgaGreen             mCASTTYPE $008000 or m8888X;
  clVgaLime              mCASTTYPE $00FF00 or m8888X;
  clVgaOlive             mCASTTYPE $808000 or m8888X;
  clVgaYellow            mCASTTYPE $FFFF00 or m8888X;
  clVgaNavy              mCASTTYPE $000080 or m8888X;
  clVgaBlue              mCASTTYPE $0000FF or m8888X;
  clVgaTeal              mCASTTYPE $008080 or m8888X;
  clVgaAqua              mCASTTYPE $00FFFF or m8888X;
  {$ENDIF RETRO_COLOR_PALETTE_VGA}

  // VIC-II / C64 color palette
  {$IFDEF RETRO_COLOR_PALETTE_CBM}
  clCbmBlack             mCASTTYPE $000000 or m8888X;
  clCbmWhite             mCASTTYPE $FFFFFF or m8888X;
  clCbmRed               mCASTTYPE $68372B or m8888X;
  clCbmCyan              mCASTTYPE $70A4B2 or m8888X;
  clCbmPurple            mCASTTYPE $6F3D86 or m8888X;
  clCbmGreen             mCASTTYPE $588D43 or m8888X;
  clCbmBlue              mCASTTYPE $352879 or m8888X;
  clCbmYellow            mCASTTYPE $B8C76F or m8888X;
  clCbmOrange            mCASTTYPE $6F4F25 or m8888X;
  clCbmBrown             mCASTTYPE $433900 or m8888X;
  clCbmLightRed          mCASTTYPE $9A6759 or m8888X;
  clCbmDarkGrey          mCASTTYPE $444444 or m8888X;
  clCbmGrey              mCASTTYPE $6C6C6C or m8888X;
  clCbmLightGreen        mCASTTYPE $9AD284 or m8888X;
  clCbmLightBlue         mCASTTYPE $6C5EB5 or m8888X;
  clCbmLightGrey         mCASTTYPE $959595 or m8888X;
  {$ENDIF RETRO_COLOR_PALETTE_CBM}

  // Amstrad CPC color palette
  {$IFDEF RETRO_COLOR_PALETTE_CPC}
  clCpcBlack             mCASTTYPE $000000 or m8888X;
  clCpcBlue              mCASTTYPE $24007F or m8888X;
  clCpcBrightBlue        mCASTTYPE $5200FD or m8888X;
  clCpcRed               mCASTTYPE $7A0004 or m8888X;
  clCpcMagenta           mCASTTYPE $7F007F or m8888X;
  clCpcMauve             mCASTTYPE $9000FD or m8888X;
  clCpcBrightRed         mCASTTYPE $F40011 or m8888X;
  clCpcPurple            mCASTTYPE $F60081 or m8888X;
  clCpcBrightMagenta     mCASTTYPE $FE00FE or m8888X;
  clCpcGreen             mCASTTYPE $088408 or m8888X;
  clCpcCyan              mCASTTYPE $278080 or m8888X;
  clCpcSkyBlue           mCASTTYPE $5371FD or m8888X;
  clCpcYellow            mCASTTYPE $7B840C or m8888X;
  clCpcWhite             mCASTTYPE $808080 or m8888X;
  clCpcPastelBlue        mCASTTYPE $9171FE or m8888X;
  clCpcOrange            mCASTTYPE $F48316 or m8888X;
  clCpcPink              mCASTTYPE $F78081 or m8888X;
  clCpcPastelMagenta     mCASTTYPE $FE70FE or m8888X;
  clCpcBrightGreen       mCASTTYPE $1BFF1B or m8888X;
  clCpcSeaGreen          mCASTTYPE $2FFF82 or m8888X;
  clCpcBrightCyan        mCASTTYPE $57FFFE or m8888X;
  clCpcLime              mCASTTYPE $7DFF1D or m8888X;
  clCpcPastelGreen       mCASTTYPE $82FF82 or m8888X;
  clCpcPastelCyan        mCASTTYPE $93FFFF or m8888X;
  clCpcBrightYellow      mCASTTYPE $F5FF23 or m8888X;
  clCpcPastelYellow      mCASTTYPE $F8FF84 or m8888X;
  clCpcBrightWhite       mCASTTYPE $FFFFFF or m8888X;
  {$ENDIF RETRO_COLOR_PALETTE_CPC}

  // Microsoft MSX color palette
  {$IFDEF RETRO_COLOR_PALETTE_MSX}
  clMsxTransparent       mCASTTYPE $000000 or m8888X;
  clMsxBlack             mCASTTYPE $010101 or m8888X;
  clMsxMediumGreen       mCASTTYPE $3EB849 or m8888X;
  clMsxLightGreen        mCASTTYPE $74D07D or m8888X;
  clMsxDarkBlue          mCASTTYPE $5955E0 or m8888X;
  clMsxLightBlue         mCASTTYPE $8076F1 or m8888X;
  clMsxDarkRed           mCASTTYPE $B95E51 or m8888X;
  clMsxCyan              mCASTTYPE $65DBEF or m8888X;
  clMsxMediumRed         mCASTTYPE $DB6559 or m8888X;
  clMsxLightRed          mCASTTYPE $FF897D or m8888X;
  clMsxDarkYellow        mCASTTYPE $CCC35E or m8888X;
  clMsxLightYellow       mCASTTYPE $DED087 or m8888X;
  clMsxDarkGreen         mCASTTYPE $3AA241 or m8888X;
  clMsxMagenta           mCASTTYPE $B766B5 or m8888X;
  clMsxGrey              mCASTTYPE $CCCCCC or m8888X;
  clMsxWhite             mCASTTYPE $FFFFFF or m8888X;
  {$ENDIF RETRO_COLOR_PALETTE_MSX}

  // ZX Spectrum color palette
  {$IFDEF RETRO_COLOR_PALETTE_ZX}
  clZxBlack              mCASTTYPE $000000 or m8888X;
  clZxBlue               mCASTTYPE $4300FA or m8888X;
  clZxRed                mCASTTYPE $FF2F21 or m8888X;
  clZxMagenta            mCASTTYPE $FF00FB or m8888X;
  clZxGreen              mCASTTYPE $00FF35 or m8888X;
  clZxCyan               mCASTTYPE $00FCFD or m8888X;
  clZxYellow             mCASTTYPE $F9FF3F or m8888X;
  clZxWhite              mCASTTYPE $FFFFFF or m8888X;
  clZxDarkBlack          mCASTTYPE $000000 or m8888X;
  clZxDarkBlue           mCASTTYPE $3300C7 or m8888X;
  clZxDarkRed            mCASTTYPE $CF2318 or m8888X;
  clZxDarkMagenta        mCASTTYPE $D300C8 or m8888X;
  clZxDarkGreen          mCASTTYPE $00CD28 or m8888X;
  clZxDarkCyan           mCASTTYPE $00C9CA or m8888X;
  clZxDarkYellow         mCASTTYPE $C6CF30 or m8888X;
  clZxDarkWhite          mCASTTYPE $CCCCCC or m8888X;
  {$ENDIF RETRO_COLOR_PALETTE_ZX}

{$ENDIF RETRO_COLOR_XRGB8888}

{$UNDEF mCASTTYPE}

