unit libretro_color;

//-------------------------------------------------------------------------
//
//  libretro_color.pas
//  - Part of Libretro-FPC package.
//    https://github.com/tednilsen/Libretro-FPC
//
//-------------------------------------------------------------------------

{$INCLUDE libretro_color.inc}
{$MODESWITCH AdvancedRecords}
{$MODESWITCH TypeHelpers}

interface

uses
  libretro;

type

  //=====================================================================================
  //  TColorTone
  //  - Color tones in bits, e.g. cr4 = 16 colortones, cr6 = 64 colortones
  //=====================================================================================
  TColorTone = (ct1, ct2, ct3, ct4, ct5, ct6, ct7, ct8);

  {$IFDEF RETRO_COLOR_RGB565}
  //=====================================================================================
  // TRGB565
  // This pixel format is the recommended format to use if a 15/16-bit
  // format is desired as it is the pixel format that is typically
  // available on a wide range of low-power devices.
  //
  // It is also natively supported in APIs like OpenGL ES.
  //=====================================================================================
  TRGB565             = uint16;
  PRGB565             = ^TRGB565;

  TRGB565Entry        = bitpacked record
    case integer of
      0: (B           : $0..$1F;
          G           : $0..$3F;
          R           : $0..$1F);
      1: (RGB         : TRGB565);
      2: (Color       : TRGB565);
      3: (U8          : packed array [0..1] of uint8);
  end;
  PRGB565Entry        = ^TRGB565Entry;
  {$ENDIF RETRO_COLOR_RGB565}


  {$IFDEF RETRO_COLOR_XRGB8888}
  //=====================================================================================
  // TXRGB8888
  //=====================================================================================
  TXRGB8888           = uint32;
  PXRGB8888           = ^TXRGB8888;

  TXRGB8888Entry      = packed record
    case integer of
      0: (B, G, R, X  : uint8);
      1: (XR, GB      : uint16);
      2: (XRGB        : TXRGB8888);
      3: (Color       : TXRGB8888);
      4: (RGB         : $0..$FFFFFF);
      5: (U8          : packed array [0..3] of uint8);
	end;
  PXRGB8888Entry      = ^TXRGB8888Entry;
  {$ENDIF RETRO_COLOR_XRGB8888}


  {$IFDEF RETRO_COLOR_RGB565}
  //-----------------------------------------------------------------------
  //  TRGB565Helper
  //-----------------------------------------------------------------------
  TRGB565Helper = type helper for TRGB565
  const
    SIZE_BYTE           = 2;
    SIZE_WORD           = 1;
    QUAD_DIV            = 4;
    QUAD_SHR            = 2;

    RETRO_PIXEL_FORMAT  = RETRO_PIXEL_FORMAT_RGB565;

    MASK_X              = $0000;
    MASK_R              = $F800;
    MASK_G              = $07E0;
    MASK_B              = $001F;
    MASK_RGB            = $FFFF;

    MAX_X               = $00;
    MAX_R               = $1F;
    MAX_G               = $3F;
    MAX_B               = $1F;

    FADE_MUL            = $1000;
    FADE_SHB            = 12;

    //  color macros
    {$IFDEF RETRO_COLOR_DEFINE}
      {$INCLUDE libretro_color_palettes.inc}
    {$ENDIF}

    procedure     Value(const Rc, Gc, Bc: uint8); overload;
    procedure     Value(const Rc, Gc, Bc: single); overload;
    function      ToQuad: uint64; inline;
    procedure     Fill(dst: PRGB565; const count: SizeInt); inline;
    procedure     FillQ(dst: PRGB565; const count: SizeInt); inline;
    function      MaxRc(const C: uint32): uint32; inline;
    function      MaxGc(const C: uint32): uint32; inline;
    function      MaxBc(const C: uint32): uint32; inline;
    procedure     Fade(const F: uint32);              // 100% = FADE_MUL | 50% | safe only for fade
    function      ToFade(const F: uint32): TRGB565;   // 100% = FADE_MUL | 50% | safe only for fade
    procedure     Flash(const F: uint32);             // 100% = FADE_MUL | 50% | F = $1800 : 150%
    function      ToFlash(const F: uint32): TRGB565;  // 100% = FADE_MUL | 50% | F = $1800 : 150%
    function      Grayscale: uint32; inline;
    procedure     Gray;
    function      ToGray: TRGB565;
    procedure     Invert;
    function      ToInvert: TRGB565;
    procedure     ToneQ(const ct: TColorTone); inline;
    function      ToToneQ(const ct: TColorTone): TRGB565; inline;
    procedure     GBR;
    function      ToGBR: TRGB565;
    procedure     BRG;
    function      ToBRG: TRGB565;
    procedure     GRB;
    function      ToGRB: TRGB565;
    procedure     BGR;
    function      ToBGR: TRGB565;
    procedure     RBG;
    function      ToRBG: TRGB565;
    {$IFDEF RETRO_COLOR_XRGB8888}
    function      ToXRGB8888: TXRGB8888; inline;
    {$ENDIF RETRO_COLOR_XRGB8888}
  end;
  {$ENDIF RETRO_COLOR_RGB565}

  {$IFDEF RETRO_COLOR_XRGB8888}
  //-----------------------------------------------------------------------
  //  TXRGB8888Helper
  //-----------------------------------------------------------------------
  TXRGB8888Helper = type helper for TXRGB8888
  const
    SIZE_BYTE           = 4;
    SIZE_WORD           = 2;
    QUAD_DIV            = 2;
    QUAD_SHR            = 1;

    RETRO_PIXEL_FORMAT  = RETRO_PIXEL_FORMAT_XRGB8888;

    MASK_X              = $FF000000;
    MASK_R              = $00FF0000;
    MASK_G              = $0000FF00;
    MASK_B              = $000000FF;
    MASK_RGB            = $00FFFFFF;

    MAX_X               = $FF;
    MAX_R               = $FF;
    MAX_G               = $FF;
    MAX_B               = $FF;

    FADE_MUL            = $1000;
    FADE_SHB            = 12;

    //  color macros
    {$IFDEF RETRO_COLOR_DEFINE}
      {$INCLUDE libretro_color_palettes.inc}
    {$ENDIF}

    procedure     Value(const Rc, Gc, Bc, Xc: uint8); overload;
    procedure     Value(const Rc, Gc, Bc: uint8); overload;
    procedure     Value(const Rc, Gc, Bc, Xc: single); overload;
    procedure     Value(const Rc, Gc, Bc: single); overload;
    function      ToQuad: uint64; inline;
    procedure     Fill(dst: PXRGB8888; const count: SizeInt); inline;
    procedure     FillQ(dst: PXRGB8888; const count: SizeInt); inline;
    function      MaxRc(const C: uint32): uint32; inline;
    function      MaxGc(const C: uint32): uint32; inline;
    function      MaxBc(const C: uint32): uint32; inline;
    procedure     Fade(const F: uint32);                // F = $10000 : 100% | F = $8000 : 50% | safe only for fade
    function      ToFade(const F: uint32): TXRGB8888;   // F = $10000 : 100% | F = $8000 : 50% | safe only for fade
    procedure     Flash(const F: uint32);               // F = $10000 : 100% | F = $8000 : 50% | F = $18000 : 150%
    function      ToFlash(const F: uint32): TXRGB8888;  // F = $10000 : 100% | F = $8000 : 50% | F = $18000 : 150%
    function      Grayscale: uint32; inline;
    procedure     Gray;
    function      ToGray: TXRGB8888;
    procedure     Invert;
    function      ToInvert: TXRGB8888;
    procedure     ToneQ(const ct: TColorTone); inline;
    function      ToToneQ(const ct: TColorTone): TXRGB8888; inline;
    procedure     GBR;
    function      ToGBR: TXRGB8888;
    procedure     BRG;
    function      ToBRG: TXRGB8888;
    procedure     GRB;
    function      ToGRB: TXRGB8888;
    procedure     BGR;
    function      ToBGR: TXRGB8888;
    procedure     RBG;
    function      ToRBG: TXRGB8888;
    {$IFDEF RETRO_COLOR_RGB565}
    function      ToRGB565: TRGB565; inline;
    {$ENDIF RETRO_COLOR_RGB565}
  end;
  {$ENDIF RETRO_COLOR_XRGB8888}


implementation


// grayscale color-weight values
{$DEFINE mGRAY_R := 5216389}   // Grayscale component R weight
{$DEFINE mGRAY_G := 8648216}   // Grayscale component G weight
{$DEFINE mGRAY_B := 2945507}   // Grayscale component B weight
{$DEFINE mGRAY_M := $800000}   // Grayscale component Middle weight

{$IFDEF RETRO_COLOR_XRGB8888}
const
  TONEQ_8888 : array [0..7] of TXRGB8888 = (
    $80808080, $C0C0C0C0, $E0E0E0E0, $F0F0F0F0, $F8F8F8F8, $FCFCFCFC, $FEFEFEFE, $FFFFFFFF );
{$ENDIF}

{$IFDEF RETRO_COLOR_RGB565}
const
  TONEQ_565 : array [0..7] of TRGB565 = (
    $8410, $C618, $E71C, $F79E, $FFDF, $FFFF, $FFFF, $FFFF );
{$ENDIF}

{$IFDEF RETRO_COLOR_XRGB8888} {$IFDEF RETRO_COLOR_RGB565}

const

  LUT_5_BIT : array [0..$1F] of uint8 = (
    $00, $08, $10, $19, $21, $29, $31, $3A, $42, $4A, $52, $5A, $63, $6B, $73, $7B,
    $84, $8C, $94, $9C, $A5, $AD, $B5, $BD, $C5, $CE, $D6, $DE, $E6, $EF, $F7, $FF );

  LUT_6_BIT : array [0..$3F] of uint8 = (
    $00, $04, $08, $0C, $10, $14, $18, $1C, $20, $24, $28, $2D, $31, $35, $39, $3D,
    $41, $45, $49, $4D, $51, $55, $59, $5D, $61, $65, $69, $6D, $71, $75, $79, $7D,
    $82, $86, $8A, $8E, $92, $96, $9A, $9E, $A2, $A6, $AA, $AE, $B2, $B6, $BA, $BE,
    $C2, $C6, $CA, $CE, $D2, $D7, $DB, $DF, $E3, $E7, $EB, $EF, $F3, $F7, $FB, $FF );

{$ENDIF RETRO_COLOR_RGB565} {$ENDIF RETRO_COLOR_XRGB8888}


{$IFDEF RETRO_COLOR_RGB565}

function Max1F(const C: uint32): uint32; inline;
begin
  if C < $1F then Result := C else Result := $1F;
end;

function Max3F(const C: uint32): uint32; inline;
begin
  if C < $3F then Result := C else Result := $3F;
end;

//=====================================================================================
//  TRGB565Helper
//=====================================================================================

procedure TRGB565Helper.Value(const Rc, Gc, Bc: uint8);
var S: TRGB565Entry absolute Self;
begin
  S.B := Bc shr 3;
  S.G := Gc shr 2;
  S.R := Rc shr 3;
end;

procedure TRGB565Helper.Value(const Rc, Gc, Bc: single);
var S: TRGB565Entry absolute Self;
begin
  S.B := Round(Bc * MAX_B);
  S.G := Round(Gc * MAX_G);
  S.R := Round(Rc * MAX_R);
end;

function TRGB565Helper.ToQuad: uint64;
begin
  Result := Self or (uint32(Self) shl 16) or (uint64(Self) shl 32) or (uint64(Self) shl 48);
end;

procedure TRGB565Helper.Fill(dst: PRGB565; const count: SizeInt);
begin
  FillWord(dst^, count, TRGB565(Self));
end;

procedure TRGB565Helper.FillQ(dst: PRGB565; const count: SizeInt);
begin
  FillQWord(dst^, count shr QUAD_SHR, TRGB565(Self).ToQuad);
end;

function TRGB565Helper.MaxRc(const C: uint32): uint32;
begin
  Result := Max1F(C);
end;

function TRGB565Helper.MaxGc(const C: uint32): uint32;
begin
  Result := Max3F(C);
end;

function TRGB565Helper.MaxBc(const C: uint32): uint32;
begin
  Result := Max1F(C);
end;

// F = $1000 : 100% | F = $800 : 50% | safe only for fade
procedure TRGB565Helper.Fade(const F: uint32);
var S: TRGB565Entry absolute Self;
begin
  S.B := (S.B * F) shr FADE_SHB;
  S.G := (S.G * F) shr FADE_SHB;
  S.R := (S.R * F) shr FADE_SHB;
end;

// F = $1000 : 100% | F = $800 : 50% | safe only for fade
function TRGB565Helper.ToFade(const F: uint32): TRGB565;
var S: TRGB565Entry absolute Self;
var R: TRGB565Entry absolute Result;
begin
  R.B := (S.B * F) shr FADE_SHB;
  R.G := (S.G * F) shr FADE_SHB;
  R.R := (S.R * F) shr FADE_SHB;
end;

// F = $1000 : 100% | F = $800 : 50% | F = $1800 : 150% | F = $2000 : 200%
procedure TRGB565Helper.Flash(const F: uint32);
var S: TRGB565Entry absolute Self;
begin
  S.B := MaxBc((S.B * F) shr FADE_SHB);
  S.G := MaxGc((S.G * F) shr FADE_SHB);
  S.R := MaxRc((S.R * F) shr FADE_SHB);
end;

// F = $1000 : 100% | F = $800 : 50% | F = $1800 : 150% | F = $2000 : 200%
function TRGB565Helper.ToFlash(const F: uint32): TRGB565;
var S: TRGB565Entry absolute Self;
var R: TRGB565Entry absolute Result;
begin
  R.B := MaxBc((S.B * F) shr FADE_SHB);
  R.G := MaxGc((S.G * F) shr FADE_SHB);
  R.R := MaxRc((S.R * F) shr FADE_SHB);
end;

function TRGB565Helper.Grayscale: uint32;
var S: TRGB565Entry absolute Self;
begin
  Result := uint32(S.R * mGRAY_R * 2) + uint32(S.G * mGRAY_G) + uint32(S.B * mGRAY_B * 2) + mGRAY_M;
end;

procedure TRGB565Helper.Gray;
var S: TRGB565Entry absolute Self;
    sc: uint32;
begin
  sc  := Grayscale shr 24;
  S.B := sc shr 1;
  S.G := sc;
  S.R := sc shr 1;
end;

function TRGB565Helper.ToGray: TRGB565;
var R: TRGB565Entry absolute Result;
    sc: uint32;
begin
  sc  := Grayscale shr 24;
  R.B := sc shr 1;
  R.G := sc;
  R.R := sc shr 1;
end;

procedure TRGB565Helper.Invert;
var S: TRGB565Entry absolute Self;
begin
  S.B := MAX_B - S.B;
  S.G := MAX_G - S.G;
  S.R := MAX_R - S.R;
end;

function TRGB565Helper.ToInvert: TRGB565;
var S: TRGB565Entry absolute Self;
    R: TRGB565Entry absolute Result;
begin
  R.B := MAX_B - S.B;
  R.G := MAX_G - S.G;
  R.R := MAX_R - S.R;
end;

procedure TRGB565Helper.ToneQ(const ct: TColorTone);
begin
  Self := Self and TONEQ_565[integer(ct)];
end;

function TRGB565Helper.ToToneQ(const ct: TColorTone): TRGB565;
begin
  Result := Self and TONEQ_565[integer(ct)];
end;

procedure TRGB565Helper.GBR;
var S: TRGB565Entry absolute Self;
    Rc: uint8;
begin
  Rc  := S.R;
  S.R := S.G shr 1;
  S.G := S.B shl 1;
  S.B := Rc;
end;

function TRGB565Helper.ToGBR: TRGB565;
var S: TRGB565Entry absolute Self;
    R: TRGB565Entry absolute Result;
begin
  R.B := S.R;
  R.G := S.B shl 1;
  R.R := S.G shr 1;
end;

procedure TRGB565Helper.BRG;
var S: TRGB565Entry absolute Self;
    T: TRGB565Entry;
begin
  T.RGB := Self;
  S.B := T.G shr 1;
  S.G := T.R shl 1;
  S.R := T.B;
end;

function TRGB565Helper.ToBRG: TRGB565;
var S: TRGB565Entry absolute Self;
    R: TRGB565Entry absolute Result;
begin
  R.B := S.G shr 1;
  R.G := S.R shl 1;
  R.R := S.B;
end;

procedure TRGB565Helper.GRB;
var S: TRGB565Entry absolute Self;
    Rc: uint8;
begin
  Rc  := S.R;
  S.R := S.G shr 1;
  S.G := Rc  shl 1;
end;

function TRGB565Helper.ToGRB: TRGB565;
var S: TRGB565Entry absolute Self;
    R: TRGB565Entry absolute Result;
begin
  R.RGB := S.RGB;
  R.G   := S.R;
  R.R   := S.G;
end;

procedure TRGB565Helper.BGR;
var S: TRGB565Entry absolute Self;
    Rc: uint8;
begin
  Rc    := S.R;
  S.R   := S.B;
  S.B   := Rc;
end;

function TRGB565Helper.ToBGR: TRGB565;
var S: TRGB565Entry absolute Self;
    R: TRGB565Entry absolute Result;
begin
  R.RGB := S.RGB;
  R.B   := S.R;
  R.R   := S.B;
end;

procedure TRGB565Helper.RBG;
var S: TRGB565Entry absolute Self;
    Gc: uint8;
begin
  Gc  := S.G;
  S.G := S.B;
  S.B := Gc;
end;

function TRGB565Helper.ToRBG: TRGB565;
var S: TRGB565Entry absolute Self;
    R: TRGB565Entry absolute Result;
begin
  R.RGB := S.RGB;
  R.B   := S.G;
  R.G   := S.B;
end;

{$IFDEF RETRO_COLOR_XRGB8888}
function TRGB565Helper.ToXRGB8888: TXRGB8888; inline;
var S: TRGB565Entry absolute Self;
    R: TXRGB8888Entry absolute Result;
begin
  Result := Result {%H-}xor Result;
  R.R := LUT_5_BIT[S.R];
  R.G := LUT_6_BIT[S.G];
  R.B := LUT_5_BIT[S.B];
end;
{$ENDIF RETRO_COLOR_XRGB8888}

{$ENDIF RETRO_COLOR_RGB565}


{$IFDEF RETRO_COLOR_XRGB8888}

function MaxFF(const C: uint32): uint32; inline;
begin
  if C < $FF then Result := C else Result := $FF;
end;

//=====================================================================================
//  TXRGB8888Helper
//=====================================================================================

procedure TXRGB8888Helper.Value(const Rc, Gc, Bc, Xc: uint8);
var S: TXRGB8888Entry absolute Self;
begin
  S.B := Bc;
  S.G := Gc;
  S.R := Rc;
  S.X := Xc;
end;

procedure TXRGB8888Helper.Value(const Rc, Gc, Bc: uint8);
var S: TXRGB8888Entry absolute Self;
begin
  S.B := Bc;
  S.G := Gc;
  S.R := Rc;
end;

procedure TXRGB8888Helper.Value(const Rc, Gc, Bc, Xc: single);
var S: TXRGB8888Entry absolute Self;
begin
  S.B := Round(Bc * MAX_B);
  S.G := Round(Gc * MAX_G);
  S.R := Round(Rc * MAX_R);
  S.X := Round(Xc * MAX_X);
end;

procedure TXRGB8888Helper.Value(const Rc, Gc, Bc: single);
var S: TXRGB8888Entry absolute Self;
begin
  S.B := Round(Bc * MAX_B);
  S.G := Round(Gc * MAX_G);
  S.R := Round(Rc * MAX_R);
end;

function TXRGB8888Helper.ToQuad: uint64;
begin
  Result := Self or (uint64(Self) shl 32);
end;

procedure TXRGB8888Helper.Fill(dst: PXRGB8888; const count: SizeInt);
begin
  FillDWord(dst^, count, TXRGB8888(Self));
end;

procedure TXRGB8888Helper.FillQ(dst: PXRGB8888; const count: SizeInt);
begin
  FillQWord(dst^, count shr QUAD_SHR, TXRGB8888(Self).ToQuad);
end;

function TXRGB8888Helper.MaxRc(const C: uint32): uint32;
begin
  Result := MaxFF(C);
end;

function TXRGB8888Helper.MaxGc(const C: uint32): uint32;
begin
  Result := MaxFF(C);
end;

function TXRGB8888Helper.MaxBc(const C: uint32): uint32;
begin
  Result := MaxFF(C);
end;

// F = $1000 : 100% | F = $800 : 50% | safe only for fade
procedure TXRGB8888Helper.Fade(const F: uint32);
var S: TXRGB8888Entry absolute Self;
begin
  S.B := (S.B * F) shr FADE_SHB;
  S.G := (S.G * F) shr FADE_SHB;
  S.R := (S.R * F) shr FADE_SHB;
end;

// F = $1000 : 100% | F = $800 : 50% | safe only for fade
function TXRGB8888Helper.ToFade(const F: uint32): TXRGB8888;
var S: TXRGB8888Entry absolute Self;
var R: TXRGB8888Entry absolute Result;
begin
  R.B := (S.B * F) shr FADE_SHB;
  R.G := (S.G * F) shr FADE_SHB;
  R.R := (S.R * F) shr FADE_SHB;
end;

// F = $1000 : 100% | F = $800 : 50% | F = $1800 : 150% | F = $2000 : 200%
procedure TXRGB8888Helper.Flash(const F: uint32);
var S: TXRGB8888Entry absolute Self;
begin
  S.B := MaxBc((S.B * F) shr FADE_SHB);
  S.G := MaxGc((S.G * F) shr FADE_SHB);
  S.R := MaxRc((S.R * F) shr FADE_SHB);
end;

// F = $1000 : 100% | F = $800 : 50% | F = $1800 : 150% | F = $2000 : 200%
function TXRGB8888Helper.ToFlash(const F: uint32): TXRGB8888;
var S: TXRGB8888Entry absolute Self;
var R: TXRGB8888Entry absolute Result;
begin
  R.B := MaxBc((S.B * F) shr FADE_SHB);
  R.G := MaxGc((S.G * F) shr FADE_SHB);
  R.R := MaxRc((S.R * F) shr FADE_SHB);
end;

function TXRGB8888Helper.Grayscale: uint32;
var S: TXRGB8888Entry absolute Self;
begin
  Result := uint32(S.B * mGRAY_B) + uint32(S.G * mGRAY_G) + uint32(S.R * mGRAY_R) + mGRAY_M;
end;

procedure TXRGB8888Helper.Gray;
var S: TXRGB8888Entry absolute Self;
    sc: uint32;
begin
  sc  := Grayscale shr 24;
  S.B := sc;
  S.G := sc;
  S.R := sc;
end;

function TXRGB8888Helper.ToGray: TXRGB8888;
var S: TXRGB8888Entry absolute Self;
    R: TXRGB8888Entry absolute Result;
    sc: uint32;
begin
  sc  := Grayscale shr 24;
  R.B := sc;
  R.G := sc;
  R.R := sc;
  R.X := S.X;
end;

procedure TXRGB8888Helper.Invert;
var S: TXRGB8888Entry absolute Self;
begin
  S.B := MAX_B - S.B;
  S.G := MAX_G - S.G;
  S.R := MAX_R - S.R;
end;

function TXRGB8888Helper.ToInvert: TXRGB8888;
var S: TXRGB8888Entry absolute Self;
    R: TXRGB8888Entry absolute Result;
begin
  R.B := MAX_B - S.B;
  R.G := MAX_G - S.G;
  R.R := MAX_R - S.R;
  R.X := S.X;
end;

procedure TXRGB8888Helper.ToneQ(const ct: TColorTone);
begin
  Self := Self and TONEQ_8888[integer(ct)];
end;

function TXRGB8888Helper.ToToneQ(const ct: TColorTone): TXRGB8888;
begin
  Result := Self and TONEQ_8888[integer(ct)];
end;

procedure TXRGB8888Helper.GBR;
var S: TXRGB8888Entry absolute Self;
    T: uint8;
begin
  T   := S.R;
  S.R := S.G;
  S.G := S.B;
  S.B := T;
end;

function TXRGB8888Helper.ToGBR: TXRGB8888;
var S: TXRGB8888Entry absolute Self;
var R: TXRGB8888Entry absolute Result;
begin
  R.B := S.R;
  R.G := S.B;
  R.R := S.G;
end;

procedure TXRGB8888Helper.BRG;
var S: TXRGB8888Entry absolute Self;
    T: TXRGB8888Entry;
begin
  T.XRGB := Self;
  S.B := T.G;
  S.G := T.R;
  S.R := T.B;
end;

function TXRGB8888Helper.ToBRG: TXRGB8888;
var S: TXRGB8888Entry absolute Self;
    R: TXRGB8888Entry absolute Result;
begin
  R.B := S.G;
  R.G := S.R;
  R.R := S.B;
end;

procedure TXRGB8888Helper.GRB;
var S: TXRGB8888Entry absolute Self;
    T: uint8;
begin
  T   := S.R;
  S.R := S.G;
  S.G := T;
end;

function TXRGB8888Helper.ToGRB: TXRGB8888;
var S: TXRGB8888Entry absolute Self;
    R: TXRGB8888Entry absolute Result;
begin
  R.B := S.B;
  R.G := S.R;
  R.R := S.G;
end;

procedure TXRGB8888Helper.BGR;
var S: TXRGB8888Entry absolute Self;
    T: uint8;
begin
  T   := S.R;
  S.R := S.B;
  S.B := T;
end;

function TXRGB8888Helper.ToBGR: TXRGB8888;
var S: TXRGB8888Entry absolute Self;
    R: TXRGB8888Entry absolute Result;
begin
  R.B := S.R;
  R.G := S.G;
  R.R := S.B;
end;

procedure TXRGB8888Helper.RBG;
var S: TXRGB8888Entry absolute Self;
    T: uint8;
begin
  T   := S.G;
  S.G := S.B;
  S.B := T;
end;

function TXRGB8888Helper.ToRBG: TXRGB8888;
var S: TXRGB8888Entry absolute Self;
    R: TXRGB8888Entry absolute Result;
begin
  R.B := S.G;
  R.G := S.B;
  R.R := S.R;
end;

{$IFDEF RETRO_COLOR_RGB565}
function TXRGB8888Helper.ToRGB565: TRGB565;
var S: TXRGB8888Entry absolute Self;
    R: TRGB565Entry absolute Result;
begin
  R.R := S.R shr 3;
  R.G := S.G shr 2;
  R.B := S.B shr 3;
end;
{$ENDIF RETRO_COLOR_RGB565}

{$ENDIF RETRO_COLOR_XRGB8888}


end.


