unit libretro_helpers;

//-------------------------------------------------------------------------
//
//  libretro_helpers.pas
//  - Part of Libretro-FPC package.
//    https://github.com/tednilsen/Libretro-FPC
//
//-------------------------------------------------------------------------

{$INCLUDE libretro.inc}
{$MODESWITCH AdvancedRecords}
{$MODESWITCH TypeHelpers}

interface

uses
  ctypes, libretro;

const

  RETRO_VIDEO_ROTATION_0   = 0;                       // rotates screen by 0 degrees cc
  RETRO_VIDEO_ROTATION_90  = 1;                       // rotates screen by 90 degrees cc
  RETRO_VIDEO_ROTATION_180 = 2;                       // rotates screen by 180 degrees cc
  RETRO_VIDEO_ROTATION_270 = 3;                       // rotates screen by 270 degrees cc

  RETRO_VIDEO_ASPECT_1x1   =  1.0 / 1.0;              // video aspect ratio 1:1
  RETRO_VIDEO_ASPECT_1x2   =  1.0 / 2.0;              // video aspect ratio 1:2
  RETRO_VIDEO_ASPECT_4x3   =  4.0 / 3.0;              // video aspect ratio 4:3
  RETRO_VIDEO_ASPECT_16x9  = 16.0 / 9.0;              // video aspect ratio 16:9
  RETRO_VIDEO_ASPECT_16x10 = 16.0 / 10.0;             // video aspect ratio 16:10
  RETRO_VIDEO_ASPECT_9x16  =  9.0 / 16.0;             // video aspect ratio 9:16
  RETRO_VIDEO_ASPECT_10x16 = 10.0 / 16.0;             // video aspect ratio 10:16

type

  //=====================================================================================
  //  TRA_Callback
  //=====================================================================================
  TRetro_Callback = record
    environment        : TRetro_environment_t;        // callback retro_set_environment
    video_refresh      : TRetro_video_refresh_t;      // callback retro_set_video_refresh
    audio_sample       : TRetro_audio_sample_t;       // callback retro_set_audio_sample
    audio_sample_batch : TRetro_audio_sample_batch_t; // callback retro_set_audio_sample_batch
    input_poll         : TRetro_input_poll_t;         // callback retro_set_input_poll
    input_state        : TRetro_input_state_t;        // callback retro_set_input_state
  end;
  PRetro_Callback = ^TRetro_Callback;

  {$IFDEF RETRO_CPU}
  TStringArray = array of string;

  //=====================================================================================
  //  TRetro_CPU_Features
  //  * Get SIMD CPU features based on bit-mask
  //=====================================================================================
  TRetro_CPU_Features = bitpacked record
    function  ToString: TStringArray;
    case integer of
      0: (SIMD_SSE,
          SIMD_SSE2,
          SIMD_VMX,
          SIMD_VMX128,
          SIMD_AVX,
          SIMD_NEON,
          SIMD_SSE3,
          SIMD_SSSE3,
          SIMD_MMX,
          SIMD_MMXEXT,
          SIMD_SSE4,
          SIMD_SSE42,
          SIMD_AVX2,
          SIMD_VFPU,
          SIMD_PS,
          SIMD_AES,
          SIMD_VFPV3,
          SIMD_VFPV4,
          SIMD_POPCNT,
          SIMD_MOVBE,
          SIMD_CMOV,
          SIMD_ASIMD: boolean);
      1: (Mask: cuint64);
      2: (Bit: bitpacked array [0..63] of boolean);
  end;
  PRetro_CPU_Features = ^TRetro_CPU_Features;
  {$ENDIF RETRO_CPU}

  {$IFDEF RETRO_FRAMEBUFFER}
  //=====================================================================================
  //  TRetro_framebuffer_Helper
  //=====================================================================================
  TRetro_framebuffer_Helper = record helper for TRetro_framebuffer
    procedure     Clear; inline;
  end;
  {$ENDIF RETRO_FRAMEBUFFER}

  //=====================================================================================
  //  TRetro_input_descriptor_Helper
  //=====================================================================================
  TRetro_input_descriptor_Helper = record helper for TRetro_input_descriptor
    procedure     SetInput(const port, device, index, id: cuint; desc: PChar);
	end;

  //=====================================================================================
  //  TRetro_system_info_Helper
  //=====================================================================================
  TRetro_system_info_Helper = record helper for TRetro_system_info
    procedure     Clear; inline;
  end;

  //=====================================================================================
  //  TRetro_system_av_info_Helper
  //=====================================================================================
  TRetro_system_av_info_Helper = record helper for TRetro_system_av_info
    procedure     Clear; inline;
  end;

  //=====================================================================================
  //  TRetro_pixel_format_Helper
  //=====================================================================================
  TRetro_pixel_format_Helper = type helper for TRetro_pixel_format
    function      ToByteSize: cint; inline;
  end;

  {$IFDEF RETRO_LANGUAGE}
  //=====================================================================================
  //  TRetro_language_Helper
  //=====================================================================================
  TRetro_language_Helper = type helper for TRetro_language
    function      ToString: string; inline;
  end;
  {$ENDIF RETRO_LANGUAGE}

  //=====================================================================================
  //  TRetro_perf_counter_helper
  //=====================================================================================
  TRetro_perf_counter_helper = type helper for TRetro_perf_counter
    procedure     Initialize(id: PChar);
    procedure     ClearCounters; inline;
  end;


const

  RETRO_CALLBACK_DEFAULT : TRetro_Callback = (
    environment        : nil;
    video_refresh      : nil;
    audio_sample       : nil;
    audio_sample_batch : nil;
    input_poll         : nil;
    input_state        : nil;
  );

  { TRetro_system_info_Helper DEFAULT values }
  RETRO_SYSTEM_INFO_DEFAULT : TRetro_system_info = (
    library_name            : nil;
    library_version         : nil;
    valid_extensions        : nil;
    need_fullpath           : False;
    block_extract           : False;
  );

  RETRO_PERF_COUNTER_DEFAULT : TRetro_perf_counter = (
    ident      : nil;
    start      : 0;
    total      : 0;
    call_cnt   : 0;
    registered : False;
  );

  RETRO_PERF_CALLBACK_DEFAULT : TRetro_perf_callback = (
    get_time_usec    : nil;
    get_cpu_features : nil;
    get_perf_counter : nil;
    perf_register    : nil;
    perf_start       : nil;
    perf_stop        : nil;
    perf_log         : nil;
  );

  {$IFDEF RETRO_FRAMEBUFFER}
  RETRO_FRAMEBUFFER_DEFAULT : TRetro_framebuffer = (
    data         : nil;
    width        : 0;
    height       : 0;
    pitch        : 0;
    format       : {$IFDEF CPU386} RETRO_PIXEL_FORMAT_XRGB8888 {$ELSE} RETRO_PIXEL_FORMAT_RGB565 {$ENDIF};
    access_flags : 0;
    memory_flags : 0;
  );
  {$ENDIF RETRO_FRAMEBUFFER}


implementation


const

  PIXEL_FORMAT_BYTESIZE : array [0..3] of cint = (
    2, 4, 2, 4
  );

  {$IFDEF RETRO_LANGUAGE}
  RETRO_LANGUAGE_STR : array [0..23] of string = (
    'English', 'Japanese', 'French', 'Spanish', 'German', 'Italian', 'Dutch',
    'Portuguese Brazil', 'Portuguese Portugal', 'Russian', 'Korean', 'Chinese Traditional',
    'Chinese Simplified', 'Esperanto', 'Polish', 'Vietnamese', 'Arabic', 'Greek',
    'Turkish', 'Slovak', 'Persian', 'Hebrew', 'Asturian', 'Last'
  );
  {$ENDIF RETRO_LANGUAGE}

  {$IFDEF RETRO_CPU}
  {* String ID values for SIMD CPU features *}
  RETRO_SIMD_STR : array [0..21] of string = (
    'SSE', 'SSE2', 'VMX', 'VMX128', 'AVX', 'NEON', 'SSE3', 'SSSE3',
    'MMX', 'MMXEXT', 'SSE4', 'SSE42', 'AVX2', 'VFPU', 'PS', 'AES',
    'VFPV3', 'VFPV4', 'POPCNT', 'MOVBE', 'CMOV', 'ASIMD'
  );
  {$ENDIF RETRO_CPU}


{$IFDEF RETRO_CPU}
//=====================================================================================
//  TRetro_CPU_Features
//=====================================================================================
function TRetro_CPU_Features.ToString: TStringArray;
var count: integer = 0;
    i: integer;
begin
  for i := 0 to High(RETRO_SIMD_STR) do
    if (Mask and (1 shl i)) > 0 then begin
      SetLength(Result{%H-}, count+1);
      Result[count] := RETRO_SIMD_STR[i];
      Inc(count);
    end;
end;
{$ENDIF RETRO_CPU}

{$IFDEF RETRO_FRAMEBUFFER}
//=====================================================================================
//  TRetro_framebuffer_Helper
//=====================================================================================
procedure TRetro_framebuffer_Helper.Clear;
begin
  Self := RETRO_FRAMEBUFFER_DEFAULT;
end;
{$ENDIF RETRO_FRAMEBUFFER}

//=====================================================================================
//  TRetro_input_descriptor_Helper
//=====================================================================================
procedure TRetro_input_descriptor_Helper.SetInput(const port, device, index, id: cuint; desc: PChar);
begin
  Self.port        := port;
  Self.device      := device;
  Self.index       := index;
  Self.id          := id;
  Self.description := desc;
end;

//=====================================================================================
//  TRetro_system_av_info_Helper
//=====================================================================================
procedure TRetro_system_av_info_Helper.Clear;
begin
  FillDWord(Self, SizeOf(TRetro_system_av_info) shr 2, 0);
end;

//=====================================================================================
//  TRetro_system_info_Helper
//=====================================================================================
procedure TRetro_system_info_Helper.Clear;
begin
  Self := RETRO_SYSTEM_INFO_DEFAULT;
end;

//=====================================================================================
//  TRetro_pixel_format_Helper
//=====================================================================================
function TRetro_pixel_format_Helper.ToByteSize: cint;
begin
  Result := PIXEL_FORMAT_BYTESIZE[cint(Self)];
end;

{$IFDEF RETRO_LANGUAGE}
//=====================================================================================
//  TRetro_language_Helper
//=====================================================================================
function TRetro_language_Helper.ToString: string;
begin
  Result := RETRO_LANGUAGE_STR[cint(Self)];
end;
{$ENDIF RETRO_LANGUAGE}

//=====================================================================================
//  TRetro_perf_counter_helper
//=====================================================================================
procedure TRetro_perf_counter_helper.Initialize(id: PChar);
begin
  Self  := RETRO_PERF_COUNTER_DEFAULT;
  ident := id;
end;

procedure TRetro_perf_counter_helper.ClearCounters;
begin
  start := 0;
  total := 0;
  call_cnt := 0;
end;

end.

