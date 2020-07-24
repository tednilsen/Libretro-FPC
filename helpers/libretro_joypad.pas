unit libretro_joypad;

//-------------------------------------------------------------------------
//
//  libretro_joypad.pas
//  - Part of Libretro-FPC package.
//    https://github.com/tednilsen/Libretro-FPC
//
//-------------------------------------------------------------------------

{$INCLUDE libretro.inc}
{$MODESWITCH AdvancedRecords}

interface

uses
  ctypes, libretro;

type

  //=====================================================================================
  //  TRetro_Joypad
  //=====================================================================================
  TRetro_Joypad   = bitpacked record
  const
    BTN_B         = RETRO_DEVICE_ID_JOYPAD_B;
    BTN_Y         = RETRO_DEVICE_ID_JOYPAD_Y;
    BTN_SELECT    = RETRO_DEVICE_ID_JOYPAD_SELECT;
    BTN_START     = RETRO_DEVICE_ID_JOYPAD_START;
    BTN_UP        = RETRO_DEVICE_ID_JOYPAD_UP;
    BTN_DOWN      = RETRO_DEVICE_ID_JOYPAD_DOWN;
    BTN_LEFT      = RETRO_DEVICE_ID_JOYPAD_LEFT;
    BTN_RIGHT     = RETRO_DEVICE_ID_JOYPAD_RIGHT;
    BTN_A         = RETRO_DEVICE_ID_JOYPAD_A;
    BTN_X         = RETRO_DEVICE_ID_JOYPAD_X;
    BTN_L         = RETRO_DEVICE_ID_JOYPAD_L;
    BTN_R         = RETRO_DEVICE_ID_JOYPAD_R;
    BTN_L2        = RETRO_DEVICE_ID_JOYPAD_L2;
    BTN_R2        = RETRO_DEVICE_ID_JOYPAD_R2;
    BTN_L3        = RETRO_DEVICE_ID_JOYPAD_L3;
    BTN_R3        = RETRO_DEVICE_ID_JOYPAD_R3;
    MASK_ALL      = $FFFF;  // * Button Mask All
    MASK_B        = $0001;  // * Button Mask B
    MASK_Y        = $0002;  // * Button Mask Y
    MASK_SELECT   = $0004;  // * Button Mask Select
    MASK_START    = $0008;  // * Button Mask Start
    MASK_UP       = $0010;  // * Button Mask Up
    MASK_DOWN     = $0020;  // * Button Mask Down
    MASK_LEFT     = $0040;  // * Button Mask Left
    MASK_RIGHT    = $0080;  // * Button Mask Right
    MASK_A        = $0100;  // * Button Mask A
    MASK_X        = $0200;  // * Button Mask X
    MASK_L        = $0400;  // * Button Mask L
    MASK_R        = $0800;  // * Button Mask R
    MASK_L2       = $1000;  // * Button Mask L2
    MASK_R2       = $2000;  // * Button Mask R2
    MASK_L3       = $4000;  // * Button Mask L3
    MASK_R3       = $8000;  // * Button Mask R3
    MASK_AB       = MASK_B or MASK_A;           // * Button Mask AB
    MASK_XY       = MASK_Y or MASK_X;           // * Button Mask XY
    MASK_LR       = MASK_LEFT or MASK_RIGHT;    // * Button Mask LR
    MASK_UD       = MASK_UP or MASK_DOWN;       // * Button Mask UD
    MASK_ABXY     = MASK_AB or MASK_XY;         // * Button Mask ABXY
    MASK_LRUD     = MASK_LR or MASK_UD;         // * Button Mask LRUD
  var
    procedure   Initialize(const joyMask: cuint32 = MASK_ALL);
    procedure   Update(cb: TRetro_input_state_t; port, index: cuint);
    procedure   UpdateButtons(cb: TRetro_input_state_t; port, index: cuint);
    procedure   UpdateAnalog(cb: TRetro_input_state_t; port, index: cuint);
    procedure   ClearAnalog; inline;            // Clear analog values
    function    ButtonAny: Boolean; inline;     // Any button down?
    function    DPad: Boolean; inline;          // Button down on D-Pad?
    function    DPadUD: Boolean; inline;        // Button down on D-Pad U/D?
    function    DPadLR: Boolean; inline;        // Button down on D-Pad L/R?
    function    ABXY: Boolean; inline;          // Button down on ABXY?
    function    ButtonsDown: cint; inline;      // How many buttons are down

    case integer of
      0: (Buttons      : cuint32;       // * Joypad Buttons
          Mask         : cuint32;       // * Button enabled Mask
          AnalogXY     : cuint32;       // * Analog X+Y
          AnalogZW     : cuint32);      // * Analog Z+W
      1: (BtnLo, BtnHi : cuint16;
          MskLo, MskHi : cuint16;
          AnalogX      : cint16;        // * Analog X
          AnalogY      : cint16;        // * Analog Y
          AnalogZ      : cint16;        // * Analog Z
          AnalogW      : cint16);       // * Analog W
      2: (Button       : bitpacked array [0..31] of boolean;    // * Joypad Buttons
          MaskBit      : bitpacked array [0..31] of boolean);   // * Button enabled Mask
      3: (B            : boolean;       // * Joypad Index:  0   Button: B
          Y            : boolean;       // * Joypad Index:  1   Button: Y
          Select       : boolean;       // * Joypad Index:  2   Button: Select
          Start        : boolean;       // * Joypad Index:  3   Button: Start
          Up           : boolean;       // * Joypad Index:  4   Button: Up
          Down         : boolean;       // * Joypad Index:  5   Button: Down
          Left         : boolean;       // * Joypad Index:  6   Button: Left
          Right        : boolean;       // * Joypad Index:  7   Button: Right
          A            : boolean;       // * Joypad Index:  8   Button: A
          X            : boolean;       // * Joypad Index:  9   Button: X
          L            : boolean;       // * Joypad Index: 10   Button: L
          R            : boolean;       // * Joypad Index: 11   Button: R
          L2           : boolean;       // * Joypad Index: 12   Button: L2
          R2           : boolean;       // * Joypad Index: 13   Button: R2
          L3           : boolean;       // * Joypad Index: 14   Button: L3
          R3           : boolean);      // * Joypad Index: 15   Button: R3
	end;
  PRetro_Joypad = ^TRetro_Joypad;

const

  RETRO_JOYPAD_DEFAULT : TRetro_Joypad = (
    Buttons  : $0;
    Mask     : TRetro_Joypad.MASK_ALL;   // all buttons enabled by default
    AnalogXY : $0;
    AnalogZW : $0;
  );


implementation


//=====================================================================================
//  TRetro_Joypad
//=====================================================================================
procedure TRetro_Joypad.Initialize(const joyMask: cuint32);
begin
  Self := RETRO_JOYPAD_DEFAULT;
  Mask := joyMask;
end;

procedure TRetro_Joypad.Update(cb: TRetro_input_state_t; port, index: cuint);
var btn: cint;
begin
  for btn := BTN_B to BTN_R3 do
    if (Mask and (1 shl btn)) <> 0 then
      Button[btn] := Boolean(cb(port, RETRO_DEVICE_JOYPAD, index, btn));
  AnalogX := cb(port, RETRO_DEVICE_ANALOG, index, RETRO_DEVICE_ID_ANALOG_X);
  AnalogY := cb(port, RETRO_DEVICE_ANALOG, index, RETRO_DEVICE_ID_ANALOG_Y);
  AnalogZ := cb(port, RETRO_DEVICE_ANALOG, index, RETRO_DEVICE_ID_ANALOG_X + 2);
  AnalogW := cb(port, RETRO_DEVICE_ANALOG, index, RETRO_DEVICE_ID_ANALOG_Y + 2);
end;

procedure TRetro_Joypad.UpdateButtons(cb: TRetro_input_state_t; port, index: cuint);
var btn: cint;
begin
  for btn := BTN_B to BTN_R3 do
    if (Mask and (1 shl btn)) <> 0 then
      Button[btn] := Boolean(cb(port, RETRO_DEVICE_JOYPAD, index, btn));
end;

procedure TRetro_Joypad.UpdateAnalog(cb: TRetro_input_state_t; port, index: cuint);
begin
  AnalogX := cb(port, RETRO_DEVICE_ANALOG, index, RETRO_DEVICE_ID_ANALOG_X);
  AnalogY := cb(port, RETRO_DEVICE_ANALOG, index, RETRO_DEVICE_ID_ANALOG_Y);
  AnalogZ := cb(port, RETRO_DEVICE_ANALOG, index, RETRO_DEVICE_ID_ANALOG_X + 2);
  AnalogW := cb(port, RETRO_DEVICE_ANALOG, index, RETRO_DEVICE_ID_ANALOG_Y + 2);
end;

procedure TRetro_Joypad.ClearAnalog;
begin
  AnalogXY := 0;
  AnalogZW := 0;
end;

function TRetro_Joypad.ButtonAny: Boolean;
begin
  Result := BtnLo <> 0;
end;

function TRetro_Joypad.DPad: Boolean;
begin
  Result := (MASK_LRUD and BtnLo) <> 0;
end;

function TRetro_Joypad.DPadUD: Boolean;
begin
  Result := (MASK_UD and BtnLo) <> 0;
end;

function TRetro_Joypad.DPadLR: Boolean;
begin
  Result := (MASK_LR and BtnLo) <> 0;
end;

function TRetro_Joypad.ABXY: Boolean;
begin
  Result := (MASK_ABXY and BtnLo) <> 0;
end;

function TRetro_Joypad.ButtonsDown: cint;
var btn: cint;
begin
  Result := 0;
  for btn := BTN_B to BTN_R3 do
    if Button[btn] then Inc(Result);
end;

end.

