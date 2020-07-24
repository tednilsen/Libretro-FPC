library __PROJNAME__;

//-------------------------------------------------------------------------
//
//  __PROJNAME__.lpr
//    __RATitle__
//
//  - Generated with Libretro-FPC template:
//    https://github.com/tednilsen/Libretro-FPC
//
//-------------------------------------------------------------------------

{$INCLUDE libretro.inc}         // <--- edit "libretro.inc" for configuration!

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
  LIB_NAME            = 'template';                     // library name
  LIB_VERSION         = 'v0.0';                         // library version
  LIB_EXTENSIONS      = nil;                            // library accepted extensions
  LIB_NEED_FULLPATH   = False;                          // library need fullpath
  LIB_BLOCK_EXTRACT   = False;                          // library block archive extraction

  // libretro video
  VIDEO_WIDTH         = 384;                            // video width
  VIDEO_HEIGHT        = 256;                            // video height
  VIDEO_FPS           = 60;                             // video fps
  VIDEO_REGION        = RETRO_REGION_NTSC;              // video region
  VIDEO_ASPECT        = RETRO_VIDEO_ASPECT_4x3;         // video aspect-ratio
  VIDEO_ROTATION      = RETRO_VIDEO_ROTATION_0;         // video rotation
  VIDEO_AREAL         = VIDEO_WIDTH * VIDEO_HEIGHT;     // video areal

  {$IFDEF RETRO_AUDIO}
  // libretro audio
  AUDIO_ENABLE        = True;                           // audio enable / disable
  AUDIO_RATE          = 44100;                          // audio sample-rate
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

  {$IFDEF RETRO_JOYPAD}
  // init joypad with default
  Joypad.Initialize;
  {$ENDIF RETRO_JOYPAD}

  // init audio
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
var colClear: mCOLOR = mCOLOR.clGreen;
{$IFDEF RETRO_AUDIO}
    smpBuf: PRetro_AudioSample;
{$ENDIF RETRO_AUDIO}
begin

  // poll input
  RaCb.input_poll();
  {$IFDEF RETRO_JOYPAD}
  Joypad.Update(RaCb.input_state, 0, 0);
  {$ENDIF RETRO_JOYPAD}

  // clear video frame
  colClear.FillQ(@RaVideo[0,0], VIDEO_AREAL);

  //...mainloop...

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
    // render audio frames
    RaCb.audio_sample_batch(pcint16(smpBuf), AUDIO_SPF);
  end;
  {$ENDIF RETRO_AUDIO}

  // video refresh
  RaCb.video_refresh(@RaVideo, VIDEO_WIDTH, VIDEO_HEIGHT, VIDEO_WIDTH * mCOLOR.SIZE_BYTE);

end;

// ----------------------------------------------------------------------------
//  RA callback: retro_reset
//  * Resets the current game.
// ----------------------------------------------------------------------------
procedure retro_reset; RETRO_API;
begin
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


