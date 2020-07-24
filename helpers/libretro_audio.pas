unit libretro_audio;

//-------------------------------------------------------------------------
//
//  libretro_audio.pas
//  - Part of Libretro-FPC package.
//    https://github.com/tednilsen/Libretro-FPC
//
//-------------------------------------------------------------------------

{$MODESWITCH AdvancedRecords}
{$MODESWITCH TypeHelpers}

interface

uses
  ctypes;

type

  //=====================================================================================
  //  TRetro_AudioSample
  //    * RA audio samples are signed 16-bit native endian.
  //=====================================================================================
  TRetro_AudioSample = cuint32;
  PRetro_AudioSample = ^TRetro_AudioSample;

  TRetro_AudioSampleEntry = packed record
    case integer of
      0: (L     : cint16;                             // audio Left channel
          R     : cint16);                            // audio Right channel
      1: (Left  : cint16;                             // audio Left channel
          Right : cint16);                            // audio Right channel
      2: (Vec   : packed array [0..1] of cint16);     // audio Left + Right channel
      3: (LR    : cuint32);                           // audio Left + Right channel
  end;
  PRetro_AudioSampleEntry = ^TRetro_AudioSampleEntry;

  //=====================================================================================
  //  TRetro_AudioBuffer
  //=====================================================================================
  TRetro_AudioBuffer = packed array of TRetro_AudioSample;
  PRetro_AudioBuffer = ^TRetro_AudioBuffer;

  //=====================================================================================
  //  TRetro_AudioBuffer_Helper
  //=====================================================================================
  TRetro_AudioBuffer_Helper = type helper for TRetro_AudioBuffer
    procedure   Initialize(const buffer_size: cint);
    procedure   Clear; inline;
	end;


implementation


//=====================================================================================
//  TRetro_AudioBuffer_Helper
//=====================================================================================

procedure TRetro_AudioBuffer_Helper.Clear;
begin
  FillDWord(Self[0], SizeOf(Self), $00000000);
end;

procedure TRetro_AudioBuffer_Helper.Initialize(const buffer_size: cint);
begin
  SetLength(Self, buffer_size);
  Self.Clear;
end;

end.

