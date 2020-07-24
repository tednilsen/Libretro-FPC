library libretro_welcome;

//-------------------------------------------------------------------------
//
//  libretro_welcome.lpr
//    Libretro Welcome
//
//  - Generated with Libretro-FPC template:
//    https://github.com/tednilsen/Libretro-FPC
//
//-------------------------------------------------------------------------

{$INCLUDE libretro.inc}         // <--- edit "libretro.inc" for configuration!
{$MODESWITCH AdvancedRecords}

uses
  ctypes,
  libretro, libretro_helpers
  {$IFDEF RETRO_COLOR}, libretro_color {$ENDIF}
  {$IFDEF RETRO_JOYPAD}, libretro_joypad {$ENDIF}
  {$IFDEF RETRO_AUDIO}, libretro_audio {$ENDIF};

  // -------------------------------------
  {$IFDEF RETRO_COLOR_XRGB8888}
    {$DEFINE mCOLOR := TXRGB8888}
  {$ELSE}
    {$DEFINE mCOLOR := TRGB565}
  {$ENDIF}
  // -------------------------------------

const

  // libretro library
  LIB_NAME            = 'LibretroFPC Welcome';          // library name
  LIB_VERSION         = 'v0.7';                         // library version
  LIB_EXTENSIONS      = nil;                            // library accepted extensions
  LIB_NEED_FULLPATH   = False;                          // library need fullpath
  LIB_BLOCK_EXTRACT   = False;                          // library block archive extraction

  // libretro video
  VIDEO_WIDTH         = 384;                            // video width
  VIDEO_HEIGHT        = 216;                            // video height
  VIDEO_FPS           = 60;                             // video fps
  VIDEO_REGION        = RETRO_REGION_NTSC;              // video region
  VIDEO_ASPECT        = RETRO_VIDEO_ASPECT_16x9;        // video aspect-ratio
  VIDEO_ROTATION      = RETRO_VIDEO_ROTATION_0;         // video rotation
  VIDEO_AREAL         = VIDEO_WIDTH * VIDEO_HEIGHT;     // video areal

  {$IFDEF RETRO_AUDIO}
  // libretro audio
  AUDIO_ENABLE        = True;                           // audio enable / disable
  AUDIO_RATE          = 48000;                          // audio sample-rate
  AUDIO_SPF           = AUDIO_RATE div VIDEO_FPS;       // audio samples pr. frame
  {$ENDIF RETRO_AUDIO}

  // game rom settings
  GAME_ROM_REQUIRED   = False;                          // game requires roms

// ----------------------------------------------------------------------------

type

  TRaVideo = packed array [0..VIDEO_HEIGHT-1, 0..VIDEO_WIDTH-1] of mCOLOR;

// ----------------------------------------------------------------------------

var

  RaCb                : TRetro_Callback;

  RaVideo             : TRaVideo;
  RaVideoRotation     : cint = VIDEO_ROTATION;

  {$IFDEF RETRO_AUDIO}
  RaAudio             : TRetro_AudioBuffer;
  RaAudioEnable       : boolean = AUDIO_ENABLE;
  AudioSwitch         : boolean = False;
  {$ENDIF RETRO_AUDIO}

  {$IFDEF RETRO_JOYPAD}
  Joypad              : TRetro_Joypad;
  {$ENDIF RETRO_JOYPAD}

  {$IFDEF RETRO_CPU}
type
  TStringArray        = array of string;
var
  RaCPU               : TRetro_CPU_Features = (Mask : 0);
  RaCPUString         : TStringArray = ('');
  {$ENDIF RETRO_CPU}

// ----------------------------------------------------------------------------

const

  BLOCK_SIZE_MAX    = 12;
  BLOCK_SIZE_MIN    = 1;
  GAME_SPEED        = 3;
  BLOCKSIZE_DELTA   = BLOCK_SIZE_MAX - BLOCK_SIZE_MIN;

  ENEMY_MAX         = 24;
  SPAWN_DELAY       = VIDEO_FPS * 3;
  SPAWN_INVADER     = 4;

  DISTORT_MODES     = 14;
  DISTORT_SPEED     = 700;

  FLASH_SPEED       = $C00;

  SHOW_MSG          = True;

  // -----------------------------------

  FONT        : packed array [0..6015] of Byte = {$INCLUDE font_kong.inc}
  FONT_W      = 8;
  FONT_H      = 8;
  CHAR_FIRST  : Char = '!';
  CHAR_LAST   : Char = '~';
  CHAR_COUNT  = 94;

type

  TFont8x8    = packed array [0..FONT_W-1, 0..FONT_H-1] of Byte;
  PFont8x8    = ^TFont8x8;
  TFontArray  = packed array [0..CHAR_COUNT-1] of TFont8x8;

  TSprite11x8 = packed array [0..7, 0..10] of Byte;
  PSprite11x8 = ^TSprite11x8;

const

  SPR_W = 11;
  SPR_H = 8;
  SPR_CRAB : array [0..1] of TSprite11x8 = (
   ((0,0,1,0,0,0,0,0,1,0,0),
    (0,0,0,1,0,0,0,1,0,0,0),
    (0,0,1,1,1,1,1,1,1,0,0),
    (0,1,1,0,1,1,1,0,1,1,0),
    (1,1,1,1,1,1,1,1,1,1,1),
    (1,0,1,1,1,1,1,1,1,0,1),
    (1,0,1,0,0,0,0,0,1,0,1),
    (0,0,0,1,1,0,1,1,0,0,0)),
   ((0,0,1,0,0,0,0,0,1,0,0),
    (1,0,0,1,0,0,0,1,0,0,1),
    (1,0,1,1,1,1,1,1,1,0,1),
    (1,1,1,0,1,1,1,0,1,1,1),
    (0,1,1,1,1,1,1,1,1,1,1),
    (0,0,1,1,1,1,1,1,1,1,0),
    (0,0,1,0,0,0,0,0,1,0,0),
    (0,1,0,0,0,0,0,0,0,1,0)));

  MSG_TEXT : array [0..12] of ansistring = (
    'R',
    '  E',
    '    T',
    '      R',
    '        O',
    '          A',
    '            R',
    '              C',
    '                H',
    'Welcome to RetroArch',
    'Here are the Libretro headers for FPC',
    'Press some buttons on your gamepad',
    'Check out the templates to get started...'
  );

  COLOR_MAX = 35;
  COLOR_RND : array [0..COLOR_MAX] of mCOLOR = (
    mCOLOR.clRed, mCOLOR.clGreen, mCOLOR.clBlue, mCOLOR.clYellow, mCOLOR.clCyan, mCOLOR.clWhite,
    mCOLOR.clOrange, mCOLOR.clMagenta, mCOLOR.clAliceBlue, mCOLOR.clCyan, mCOLOR.clSalmon,
    mCOLOR.clDodgerBlue, mCOLOR.clHoneyDew, mCOLOR.clHotPink, mCOLOR.clLemonChiffon,
    mCOLOR.clOliveDrab, mCOLOR.clSeaGreen, mCOLOR.clSpringgreen, mCOLOR.clThistle,
    mCOLOR.clViolet, mCOLOR.clWhitesmoke, mCOLOR.clYellowgreen, mCOLOR.clChocolate,
    mCOLOR.clBrown, mCOLOR.clIndianRed, mCOLOR.clMediumSlateBlue, mCOLOR.clMediumTurquoise,
    mCOLOR.clPurple, mCOLOR.clGray, mCOLOR.clDarkRed, mCOLOR.clDarkGreen, mCOLOR.clDarkBlue,
    mCOLOR.clDarkYellow, mCOLOR.clDarkMagenta, mCOLOR.clDarkCyan, mCOLOR.clDarkOrange
  );

  {$IFDEF RETRO_AUDIO}
  // audio samples
  SAMPLES: {$I samples.inc}
  {$ENDIF RETRO_AUDIO}

type

  TXYPoint = packed record
    case integer of
      0: (X, Y: cint);
      1: (W, H: cint);
  end;

  TXYRect = packed record
    function  ClipScreen(out dst: TXYRect): boolean; overload;
    case integer of
      0: (X, Y, W, H: cint);
      1: (XY, WH: TXYPoint);
  end;

  TEnemyType = (etBlock, etCrab);

  TEnemy = packed record
    procedure Reset(const et: TEnemyType = etBlock);
    procedure Update;
    procedure Draw;
    {$IFDEF RETRO_AUDIO}
    procedure ProcessAudio(const buffer: PRetro_AudioSample);
    {$ENDIF RETRO_AUDIO}
    case integer of
    0: (R: TXYRect;
        Speed: TXYPoint;
        Color: mCOLOR;
        FlashAmp, FlashSpd: uint32;
        Flash: Boolean;
        InFront: boolean;
        EnemyType: TEnemyType;
        SmpIdx: integer;
        SmpPos: integer);
    1: (X, Y, W, H: integer);
    2: (XY, WH: TXYPoint);
  end;

var

  RaMsg: TRetro_message;
  RaMsgShow: boolean = SHOW_MSG;

  FrameCounter: cardinal = 1;
  FrameEven: boolean = True;

  Distort: integer;
  DistortTimer: cardinal;

  Enemy: array [0..ENEMY_MAX-1] of TEnemy;
  EnemyCount: integer = 0;

  {$IFDEF RETRO_CPU}
const
  XYP_ZERO : TXYPoint = (X : 0; Y : 0);
  {$ENDIF RETRO_CPU}

// --------------------------------------------------------------------

function TXYRect.ClipScreen(out dst: TXYRect): boolean;
begin

  if X >= 0 then begin
    dst.X := X;
    if (X + W) > VIDEO_WIDTH
      then dst.W := VIDEO_WIDTH - X
      else dst.W := W;
  end else begin
    dst.X := 0;
    dst.W := X + W;
  end;

  if dst.W > 0 then begin
    if Y >= 0 then begin
      dst.Y := Y;
      if (Y + H) > VIDEO_HEIGHT
        then dst.H := VIDEO_HEIGHT - Y
        else dst.H := H;
    end else begin
      dst.Y := 0;
      dst.H := Y + H;
    end;
    Result := dst.H > 0;

  end else Result := False;

end;

// --------------------------------------------------------------------

procedure TextOut(const txt: string; xy: TXYPoint; const color: mCOLOR);
var dstR, clpR: TXYRect;
    srcM: PFont8x8;
    dstP: ^mCOLOR;
    dx, dy, srcY, srcH: integer;
    c: Char;
    b: Byte absolute c;
    FONT_FIRST: Byte absolute CHAR_FIRST;
    FONT_LAST: Byte absolute CHAR_LAST;
begin
  dstR.XY := xy;
  dstR.W  := FONT_W;
  dstR.H  := FONT_H;
  for c in txt do begin
    if (b >= FONT_FIRST) and (b <= FONT_LAST) then begin
      // clpR = clip to RaVideo
      if dstR.ClipScreen(clpR) then begin
        dstP := @RaVideo[clpR.Y, clpR.X];
        srcY := clpR.Y - dstR.Y;
        srcH := clpR.H + srcY;
        srcM := @TFontArray(FONT)[(b - FONT_FIRST)];
        for dy := srcY to srcH - 1 do begin
          for dx := 0 to clpR.W - 1 do
            if srcM^[dy][dx] > 0 then dstP[dx] := color;
          Inc(dstP, VIDEO_WIDTH);
        end;
      end;
    end;
    inc(dstR.X, FONT_W);
  end;
end;

procedure TextCenter(const txt: string; col, row: integer; const color: mCOLOR);
var xy: TXYPoint;
begin
  xy.X := (VIDEO_WIDTH - Length(txt) * FONT_W) shr 1 + col * FONT_W;
  xy.Y := (VIDEO_HEIGHT - FONT_H) shr 1 + row * FONT_H;
  TextOut(txt, xy, color);
end;

// --------------------------------------------------------------------

procedure TEnemy.Reset(const et: TEnemyType);
begin
  EnemyType := et;
  case EnemyType of
    etBlock:
      begin
        W := BLOCK_SIZE_MIN + Random(BLOCKSIZE_DELTA+1);
        H := W;
      end;
    etCrab:
      begin
        W := SPR_W;
        H := SPR_H;
      end;
  end;
  X := Random(VIDEO_WIDTH  - W);
  Y := Random(VIDEO_HEIGHT - H);
  repeat
    Speed.X := Random(GAME_SPEED + 1);
    Speed.Y := Random(GAME_SPEED + 1);
  until ((Speed.X <> 0) or (Speed.Y <> 0));
  if Random(100) and $1 = 0 then
    Speed.X := -Speed.X;
  if Random(100) and $1 = 0 then
    Speed.Y := -Speed.Y;
  Color     := COLOR_RND[Random(COLOR_MAX+1)];
  SmpIdx    := Random({$IFDEF RETRO_AUDIO}Length(SAMPLES){$ELSE}99{$ENDIF});
  SmpPos    := 0;
  FlashAmp  := mCOLOR.FADE_MUL;
  FlashSpd  := mCOLOR.FADE_MUL;
  InFront   := Boolean(Random(2));
end;

procedure TEnemy.Update;
begin

  X := X + Speed.X;
  if (X < 0) or (X + W >= VIDEO_WIDTH) then begin
    Speed.X := -Speed.X;
    Flash   := True;
  end;

  Y := Y + Speed.Y;
  if (Y < 0) or (Y + H >= VIDEO_HEIGHT) then begin
    Speed.Y := -Speed.Y;
    Flash := True;
  end;

  if Flash then begin
    Flash    := False;
    Color    := COLOR_RND[Random(COLOR_MAX+1)];
    FlashAmp := mCOLOR.FADE_MUL div 4 + Random(mCOLOR.FADE_MUL * 6);
    FlashSpd := FLASH_SPEED + Random(mCOLOR.FADE_MUL - FLASH_SPEED);
    InFront  := not InFront;
    SmpIdx   := Random({$IFDEF RETRO_AUDIO}Length(SAMPLES){$ELSE}99{$ENDIF});
    SmpPos   := 0;
  end else begin
    FlashAmp := (FlashAmp * FlashSpd) shr mCOLOR.FADE_SHB;
  end;

end;

procedure TEnemy.Draw;
var dstR: TXYRect;
    dstP: ^mCOLOR;
    srcM : PSprite11x8;
    dx, dy, srcY, srcH: integer;
    col: mCOLOR;
begin

  // dstR = dst clip to RaVideo
  if R.ClipScreen(dstR) then begin

    // color fx
    col := Color.ToFlash(FlashAmp);

    // dstP = dst RaVideo pointer
    dstP := @RaVideo[dstR.Y, dstR.X];

    case EnemyType of
      etBlock:
        begin
          for dy := 0 to dstR.H - 1 do begin
            col.Fill(@dstP[0], dstR.W);
            Inc(dstP, VIDEO_WIDTH);
          end;
        end;
      else
        begin
          // srcY = source bitmap offset
          srcY := dstR.Y - R.Y;
          srcH := dstR.H + srcY - 1;
          srcM := @SPR_CRAB[cint(FrameEven)][0][dstR.X - R.X];
          for dy := srcY to srcH do begin
            for dx := 0 to dstR.W - 1 do
              if srcM^[dy][dx] = 1 then dstP[dx] := col;
            Inc(dstP, VIDEO_WIDTH);
          end;
        end;
    end;
  end;
end;

{$IFDEF RETRO_AUDIO}
procedure TEnemy.ProcessAudio(const buffer: PRetro_AudioSample);
var buf: PRetro_AudioSampleEntry absolute buffer;
    i: integer;
    smp: cint16;
begin
  if SmpPos < Length( SAMPLES[SmpIdx] ) then begin
    for i := 0 to AUDIO_SPF - 1 do begin
      smp := cint8(SAMPLES[SmpIdx][SmpPos]) * 128;
      smp := SarSmallint(smp + buf[i].L);
      // write audio-buffer
      buf[i].L := smp;
      buf[i].R := smp;
      // next sample
      Inc(SmpPos);
      // end of sample?
      if SmpPos >= Length(SAMPLES[SmpIdx]) then
        break;
    end;
  end;
end;
{$ENDIF RETRO_AUDIO}


//=============================================================================


// ----------------------------------------------------------------------------
//  RA callback: retro_api_version
//  * Must return RETRO_API_VERSION.
//    Used to validate ABI compatibility when the API is revised.
// ----------------------------------------------------------------------------
function retro_api_version: cuint; RETRO_API;
begin
  Result := libretro.RETRO_API_VERSION;
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_init
//  * Library global initialization
// ----------------------------------------------------------------------------
procedure retro_init; RETRO_API;
begin
  Randomize;
  EnemyCount := 0;
  Distort := 0;
  DistortTimer := Random(VIDEO_FPS*2) + VIDEO_FPS*2;
  {$IFDEF RETRO_JOYPAD}
  Joypad.Initialize;
  {$ENDIF RETRO_JOYPAD}
  {$IFDEF RETRO_AUDIO}
  if RaAudioEnable then RaAudio.Initialize(AUDIO_SPF shl 1);
  {$ENDIF RETRO_AUDIO}
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_deinit
//  * Library global deinitialization
// ----------------------------------------------------------------------------
procedure retro_deinit; RETRO_API;
begin
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_set_controller_port_device
//  * Sets device to be used for player 'port'.
//  * By default, RETRO_DEVICE_JOYPAD is assumed to be plugged into all available ports.
//  * Setting a particular device type is not a guarantee that libretro cores
//    will only poll input based on that particular device type. It is only a
//    hint to the libretro core when a core cannot automatically detect the
//    appropriate input device type on its own. It is also relevant when a
//    core can change its behavior depending on device type.
//
//  * As part of the core's implementation of retro_set_controller_port_device,
//    the core should call RETRO_ENVIRONMENT_SET_INPUT_DESCRIPTORS to notify the
//    frontend if the descriptions for any controls have changed as a
//    result of changing the device type.
// ----------------------------------------------------------------------------
procedure retro_set_controller_port_device(port, device: cuint32); RETRO_API;
begin
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_get_system_info
//  * Gets statically known system info. Pointers provided in *info
//  * Must be statically allocated.
//  * Can be called at any time, even before retro_init().
// ----------------------------------------------------------------------------
procedure retro_get_system_info(info: PRetro_system_info); RETRO_API;
begin
  info^.library_name     := LIB_NAME;
  info^.library_version  := LIB_VERSION;
  info^.valid_extensions := LIB_EXTENSIONS;
  info^.need_fullpath    := LIB_NEED_FULLPATH;
  info^.block_extract    := LIB_BLOCK_EXTRACT;
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_get_system_av_info
//  * Gets information about system audio/video timings and geometry.
//  * Can be called only after retro_load_game() has successfully completed.
//  * NOTE: The implementation of this function might not initialize every
//    variable if needed.
//  * E.g. geom.aspect_ratio might not be initialized if core doesn't
//    desire a particular aspect ratio.
// ----------------------------------------------------------------------------
procedure retro_get_system_av_info(info: PRetro_system_av_info); RETRO_API;
var pixel_format: TRetro_pixel_format = mCOLOR.RETRO_PIXEL_FORMAT;
begin

  info^.geometry.base_width   := VIDEO_WIDTH;
  info^.geometry.base_height  := VIDEO_HEIGHT;
  info^.geometry.max_width    := VIDEO_WIDTH;
  info^.geometry.max_height   := VIDEO_HEIGHT;
  info^.geometry.aspect_ratio := VIDEO_ASPECT;
  info^.timing.fps            := VIDEO_FPS;
  info^.timing.sample_rate    := {$IFDEF RETRO_AUDIO} AUDIO_RATE {$ELSE} 0 {$ENDIF};

  RaCb.environment(RETRO_ENVIRONMENT_SET_PIXEL_FORMAT, @pixel_format);

end;

// ----------------------------------------------------------------------------
//  RA callback: retro_run
//  * Runs the game for one video frame.
//  * During retro_run(), input_poll callback must be called at least once.
//
//  * If a frame is not rendered for reasons where a game "dropped" a frame,
//    this still counts as a frame, and retro_run() should explicitly dupe
//    a frame if GET_CAN_DUPE returns true.
//    In this case, the video callback can take a NULL argument for data.
// ----------------------------------------------------------------------------
procedure retro_run; RETRO_API;

  procedure DrawColors;
  var ty: cint;
      {$IFDEF RETRO_JOYPAD}
      btn, ax, ay, az, aw: cint;
      {$ENDIF RETRO_JOYPAD}

    procedure Text(const txt: string; col: mCOLOR);
    begin
      // color distortion mode
      case Distort of
        1: col.Gray;
        2: col.Invert;
        3: col.BGR;
        4: col.RBG;
        5: col.GRB;
        6: col.BRG;
        7: col.GBR;
        8: col := col.ToBGR.ToInvert;
        9: col := col.ToRBG.ToInvert;
       10: col := col.ToGRB.ToInvert;
       11: col := col.ToBRG.ToInvert;
       12: col := col.ToGBR.ToInvert;
       13: col.ToneQ(ct2);
       14: col.ToneQ(ct3);
      end;
      TextCenter(txt, 0, ty, col);
      Inc(ty);
    end;

  begin
    {$IFDEF RETRO_JOYPAD}
    ax := SarSmallint(Joypad.AnalogX);
    ay := SarSmallint(Joypad.AnalogY);
    az := SarSmallint(Joypad.AnalogZ);
    aw := SarSmallint(Joypad.AnalogW);
    btn := Joypad.ButtonsDown;
    if (ax <> 0) then Inc(btn);
    if (ay <> 0) then Inc(btn);
    if (az <> 0) then Inc(btn);
    if (aw <> 0) then Inc(btn);
    if btn = 0 then begin
    {$ENDIF RETRO_JOYPAD}
      ty := -9;
      Text('Bl@ck',       mCOLOR.clBlack);
      Text('White',       mCOLOR.clWhite);
      Text('Gray',        mCOLOR.clGray);
      Text('Red',         mCOLOR.clRed);
      Text('DarkRed',     mCOLOR.clDarkRed);
      Text('Green',       mCOLOR.clGreen);
      Text('DarkGreen',   mCOLOR.clDarkGreen);
      Text('Blue',        mCOLOR.clBlue);
      Text('DarkBlue',    mCOLOR.clDarkBlue);
      Text('Yellow',      mCOLOR.clYellow);
      Text('DarkYellow',  mCOLOR.clDarkYellow);
      Text('Magenta',     mCOLOR.clMagenta);
      Text('DarkMagenta', mCOLOR.clDarkMagenta);
      Text('Cyan',        mCOLOR.clCyan);
      Text('DarkCyan',    mCOLOR.clDarkCyan);
      Text('Orange',      mCOLOR.clOrange);
      Text('DarkOrange',  mCOLOR.clDarkOrange);
    {$IFDEF RETRO_JOYPAD}
    end else begin
      ty := (btn shr 1) - btn;
      if Joypad.B      then Text('Button B',      mCOLOR.clGreen);
      if Joypad.Y      then Text('Button Y',      mCOLOR.clBlue);
      if Joypad.Select then Text('Button SELECT', mCOLOR.clSilver);
      if Joypad.Start  then Text('Button START',  mCOLOR.clWhite);
      if Joypad.Up     then Text('Button UP',     mCOLOR.clDarkGreen);
      if Joypad.Down   then Text('Button DOWN',   mCOLOR.clDarkBlue);
      if Joypad.Left   then Text('Button LEFT',   mCOLOR.clDarkRed);
      if Joypad.Right  then Text('Button RIGHT',  mCOLOR.clDarkYellow);
      if Joypad.A      then Text('Button A',      mCOLOR.clRed);
      if Joypad.X      then Text('Button X',      mCOLOR.clYellow);
      if Joypad.L      then Text('Button L',      mCOLOR.clMagenta);
      if Joypad.R      then Text('Button R',      mCOLOR.clCyan);
      if Joypad.L2     then Text('Button L2',     mCOLOR.clDarkMagenta);
      if Joypad.R2     then Text('Button R2',     mCOLOR.clDarkCyan);
      if Joypad.L3     then Text('Button L3',     mCOLOR.clOrange);
      if Joypad.R3     then Text('Button R3',     mCOLOR.clDarkOrange);
      if (ax <> 0)     then Text(HexStr(ax, 4),   mCOLOR.clGreen);
      if (ay <> 0)     then Text(HexStr(ay, 4),   mCOLOR.clBlue);
      if (az <> 0)     then Text(HexStr(az, 4),   mCOLOR.clRed);
      if (aw <> 0)     then Text(HexStr(aw, 4),   mCOLOR.clYellow);
    end;
    {$ENDIF RETRO_JOYPAD}
    if FrameEven then
      TextCenter('* Welcome to Libretro for FPC *',  0,   9, mCOLOR.clDarkGray);
  end;

  {$IF RETRO_VERSION >= 188}
  procedure displayMsg(const index, frames: cuint);
  begin
    RaMsg.msg      := @MSG_TEXT[index][1];
    RaMsg.frames   := frames;
    RaCb.environment(RETRO_ENVIRONMENT_SET_MESSAGE, @RaMsg);
  end;
  {$ENDIF}

var i: integer;
    xy: TXYPoint;
    colClear: mCOLOR = mCOLOR.clBlack;
    et: TEnemyType = etBlock;
{$IFDEF RETRO_AUDIO}
    smpBuf: PRetro_AudioSample;
{$ENDIF RETRO_AUDIO}
{$IF RETRO_VERSION >= 188}
const QSEC = VIDEO_FPS div 4;
      FSEC = VIDEO_FPS div 5;
{$ENDIF}
begin

  // poll input
  RaCb.input_poll();
  {$IFDEF RETRO_JOYPAD}
  Joypad.Update(RaCb.input_state, 0, 0);
  {$ENDIF RETRO_JOYPAD}

  // clear video frame
  colClear.FillQ(@RaVideo[0,0], VIDEO_AREAL);

  //...mainloop...

  // update even odd second
  FrameEven := FrameCounter mod (2 * VIDEO_FPS) <= VIDEO_FPS;

  // update enemy
  for i := 0 to EnemyCount - 1 do begin
    Enemy[i].Update;
    // draw enemy in background
    if not Enemy[i].InFront then Enemy[i].Draw;
  end;

  // update distort / grayscreen
  if DistortTimer = 0 then begin
    if Random(1000) >= DISTORT_SPEED
      then Distort := Random(DISTORT_MODES+1)
      else Distort := 0;
    DistortTimer := Random(VIDEO_FPS*2) + 1;
  end else Dec(DistortTimer);

  // draw text in the middle
  DrawColors;

  // draw enemy front
  for i := 0 to EnemyCount - 1 do
    if Enemy[i].InFront then Enemy[i].Draw;

  // print cpu features
  {$IFDEF RETRO_CPU}
  if (FrameCounter and $20 >= $20) and (FrameCounter and $1 = 1) then begin
    xy := XYP_ZERO;
    for i := 0 to High(RaCPUString) do begin
      TextOut(RaCPUString[i], xy, mCOLOR.clDarkOrchid);
      Inc(xy.Y, FONT_H);
    end;
  end;
  {$ENDIF RETRO_CPU}

  {$IF RETRO_VERSION >= 188}
  // show enviroment message
  if RaMsgShow then
    case (FrameCounter mod (60 * VIDEO_FPS)) of
      QSEC      *  0: displayMsg( 0, FSEC);
      QSEC      *  1: displayMsg( 1, FSEC);
      QSEC      *  2: displayMsg( 2, FSEC);
      QSEC      *  3: displayMsg( 3, FSEC);
      QSEC      *  4: displayMsg( 4, FSEC);
      QSEC      *  5: displayMsg( 5, FSEC);
      QSEC      *  6: displayMsg( 6, FSEC);
      QSEC      *  7: displayMsg( 7, FSEC);
      QSEC      *  8: displayMsg( 8, FSEC);
      VIDEO_FPS *  5: displayMsg( 9, VIDEO_FPS * 4);
      VIDEO_FPS * 15: displayMsg(10, VIDEO_FPS * 5);
      VIDEO_FPS * 25: displayMsg(11, VIDEO_FPS * 5);
      VIDEO_FPS * 35: displayMsg(12, VIDEO_FPS * 5);
    end;
  {$ENDIF}

  // spawn enemy
  if EnemyCount < ENEMY_MAX then
    if FrameCounter mod (SPAWN_DELAY) = 0 then begin
      // every SPAWN_INVADER is an invader
      if EnemyCount mod SPAWN_INVADER = 0 then et := etCrab;
      Enemy[EnemyCount].Reset(et);
      Inc(EnemyCount);
    end;

  {$IFDEF RETRO_AUDIO}
  // ...play audio...
  if RaAudioEnable then begin
    // switch between 2 sample-buffers
    if not AudioSwitch
      then smpBuf := @RaAudio[0]
      else smpBuf := @RaAudio[AUDIO_SPF];
    AudioSwitch := not AudioSwitch;
    // clear audio buffer
    FillDWord(smpBuf[0], AUDIO_SPF, $00000000);
    // ...process audio...
    for i := 0 to EnemyCount - 1 do
      Enemy[i].ProcessAudio(smpBuf);
    // render audio frames
    RaCb.audio_sample_batch(pcint16(smpBuf), AUDIO_SPF);
  end;
  {$ENDIF RETRO_AUDIO}

  Inc(FrameCounter);

  // video refresh
  RaCb.video_refresh(@RaVideo, VIDEO_WIDTH, VIDEO_HEIGHT, VIDEO_WIDTH * mCOLOR.SIZE_BYTE);

end;

// ----------------------------------------------------------------------------
//  RA callback: retro_reset
//  * Resets the current game.
// ----------------------------------------------------------------------------
procedure retro_reset; RETRO_API;
begin
  FrameCounter  := 0;
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_load_game
//  * Return true to indicate successful loading and false to indicate load failure.
// ----------------------------------------------------------------------------
function retro_load_game(const game: PRetro_game_info): boolean; RETRO_API;
begin
  Result := True;
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_load_game_special
//  * Loads a "special" kind of game. Should not be used, except in extreme cases.
// ----------------------------------------------------------------------------
function retro_load_game_special(gameType: cuint32; info: PRetro_game_info; numInfo: SizeUInt): boolean; RETRO_API;
begin
  Result := retro_load_game(info);
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_get_region
//  * Gets region of game.
// ----------------------------------------------------------------------------
function retro_get_region: cuint; RETRO_API;
begin
  Result := VIDEO_REGION;
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_unload_game
//  * Unloads the currently loaded game. Called before retro_deinit(void).
// ----------------------------------------------------------------------------
procedure retro_unload_game; RETRO_API;
begin
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_serialize
//  * Serializes internal state. If failed, or size is lower than
//    retro_serialize_size(), it should return false, true otherwise.
// ----------------------------------------------------------------------------
function retro_serialize(data: pointer; size: SizeUInt): boolean; RETRO_API;
begin
  Result := True;
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_unserialize
// ----------------------------------------------------------------------------
function retro_unserialize(const data: pointer; size: SizeUInt): boolean; RETRO_API;
begin
  Result := True;
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_serialize_size
//  * Returns the amount of data the implementation requires to serialize
//    internal state (save states).
//  * Between calls to retro_load_game() and retro_unload_game(), the
//    returned size is never allowed to be larger than a previous returned
//    value, to ensure that the frontend can allocate a save state buffer once.
// ----------------------------------------------------------------------------
function retro_serialize_size: SizeUInt; RETRO_API;
begin
  Result := 0;
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_cheat_reset
// ----------------------------------------------------------------------------
procedure retro_cheat_reset; RETRO_API;
begin
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_cheat_set
// ----------------------------------------------------------------------------
procedure retro_cheat_set(index: cuint32; enabled: boolean; const code: PChar); RETRO_API;
begin
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_get_memory_data
//  * Gets region of memory.
// ----------------------------------------------------------------------------
function retro_get_memory_data(id: cuint): pointer; RETRO_API;
begin
  Result := nil;
end;

// ----------------------------------------------------------------------------
//  RA callback: retro_get_memory_size
//  * Gets region of memory.
// ----------------------------------------------------------------------------
function retro_get_memory_size(id: cuint): csize_t; RETRO_API;
begin
  Result := 0;
end;


//=============================================================================
//  RA Set Callbacks
//
//  RA set_callback: retro_set_environment
//  * Sets callbacks. retro_set_environment() is guaranteed to be called
//    before retro_init().
//
//  * The rest of the set_* functions are guaranteed to have been called
//    before the first call to retro_run() is made.
//
//=============================================================================


// ----------------------------------------------------------------------------
//  RA set_callback: retro_set_environment
//    * guaranteed to be called before retro_init().
// ----------------------------------------------------------------------------
procedure retro_set_environment(callback: TRetro_environment_t); RETRO_API;
const rom_game: cbool = not GAME_ROM_REQUIRED;
{$IFDEF RETRO_CPU}
var   cb_perf: TRetro_perf_callback;
{$ENDIF RETRO_CPU}
begin
  RaCb.environment := callback;
  // core does or does not require a rom
  RaCb.environment(RETRO_ENVIRONMENT_SET_SUPPORT_NO_GAME, @rom_game);
  // video rotation
  RaCb.environment(RETRO_ENVIRONMENT_SET_ROTATION, @RaVideoRotation);
  {$IFDEF RETRO_CPU}
  // * performance callback, get cpu features
  cb_perf := RETRO_PERF_CALLBACK_DEFAULT;
  if RaCb.environment(RETRO_ENVIRONMENT_GET_PERF_INTERFACE, @cb_perf) then begin
    if cb_perf.get_cpu_features <> nil
      then RaCPU.Mask := cb_perf.get_cpu_features();
    RaCPUString := RaCPU.ToString;
  end;
  {$ENDIF RETRO_CPU}
end;

// ----------------------------------------------------------------------------
//  RA set_callback: retro_set_video_refresh
// ----------------------------------------------------------------------------
procedure retro_set_video_refresh(callback: TRetro_video_refresh_t); RETRO_API;
begin
  RaCb.video_refresh := callback;
end;

// ----------------------------------------------------------------------------
//  RA set_callback: retro_set_audio_sample
// ----------------------------------------------------------------------------
procedure retro_set_audio_sample(callback: TRetro_audio_sample_t); RETRO_API;
begin
  RaCb.audio_sample := callback;
end;

// ----------------------------------------------------------------------------
//  RA set_callback: retro_set_audio_sample_batch
// ----------------------------------------------------------------------------
procedure retro_set_audio_sample_batch(callback: TRetro_audio_sample_batch_t); RETRO_API;
begin
  RaCb.audio_sample_batch := callback;
end;

// ----------------------------------------------------------------------------
//  RA set_callback: retro_set_input_poll
// ----------------------------------------------------------------------------
procedure retro_set_input_poll(callback: TRetro_input_poll_t); RETRO_API;
begin
  RaCb.input_poll := callback;
end;

// ----------------------------------------------------------------------------
//  RA set_callback: retro_set_input_state
// ----------------------------------------------------------------------------
procedure retro_set_input_state(callback: TRetro_input_state_t); RETRO_API;
begin
  RaCb.input_state := callback;
end;

//=====================================================================================
//  RA library exports
//=====================================================================================

exports

  retro_set_environment,
  retro_set_video_refresh,
  retro_set_audio_sample,
  retro_set_audio_sample_batch,
  retro_set_input_poll,
  retro_set_input_state,
  retro_init,
  retro_deinit,
  retro_api_version,
  retro_get_system_info,
  retro_get_system_av_info,
  retro_set_controller_port_device,
  retro_reset,
  retro_run,
  retro_serialize_size,
  retro_serialize,
  retro_unserialize,
  retro_cheat_reset,
  retro_cheat_set,
  retro_load_game,
  retro_load_game_special,
  retro_unload_game,
  retro_get_region,
  retro_get_memory_data,
  retro_get_memory_size;

begin
end.


