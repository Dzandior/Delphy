unit SettingsManagerUnit;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles;

type
  TDifficultyLevel = (dlEasy, dlMedium, dlHard);

  TGameSettings = record
    MusicVolume: Integer;
    EffectsVolume: Integer;
    MasterVolume: Integer;
    ClickSoundEnabled: Boolean;
    Difficulty: TDifficultyLevel;
  end;

procedure LoadSettings(var Settings: TGameSettings; const FileName: string);
procedure SaveSettings(const Settings: TGameSettings; const FileName: string);

function DifficultyToStr(ADifficulty: TDifficultyLevel): string;
function StrToDifficulty(const S: string): TDifficultyLevel;

implementation

const
  SECTION_Sound = 'Sound';
  SECTION_Game = 'Game';

procedure LoadSettings(var Settings: TGameSettings; const FileName: string);
var
  Ini: TIniFile;
begin
  // Значения по умолчанию
  Settings.MusicVolume := 80;
  Settings.EffectsVolume := 80;
  Settings.MasterVolume := 80;
  Settings.ClickSoundEnabled := True;
  Settings.Difficulty := dlMedium;

  if not FileExists(FileName) then
    Exit;

  Ini := TIniFile.Create(FileName);
  try
    Settings.MusicVolume := Ini.ReadInteger(SECTION_Sound, 'MusicVolume', Settings.MusicVolume);
    Settings.EffectsVolume := Ini.ReadInteger(SECTION_Sound, 'EffectsVolume', Settings.EffectsVolume);
    Settings.MasterVolume := Ini.ReadInteger(SECTION_Sound, 'MasterVolume', Settings.MasterVolume);
    Settings.ClickSoundEnabled := Ini.ReadBool(SECTION_Sound, 'ClickSoundEnabled', Settings.ClickSoundEnabled);
    Settings.Difficulty := StrToDifficulty(Ini.ReadString(SECTION_Game, 'Difficulty', DifficultyToStr(Settings.Difficulty)));
  finally
    Ini.Free;
  end;
end;

procedure SaveSettings(const Settings: TGameSettings; const FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  try
    Ini.WriteInteger(SECTION_Sound, 'MusicVolume', Settings.MusicVolume);
    Ini.WriteInteger(SECTION_Sound, 'EffectsVolume', Settings.EffectsVolume);
    Ini.WriteInteger(SECTION_Sound, 'MasterVolume', Settings.MasterVolume);
    Ini.WriteBool(SECTION_Sound, 'ClickSoundEnabled', Settings.ClickSoundEnabled);
    Ini.WriteString(SECTION_Game, 'Difficulty', DifficultyToStr(Settings.Difficulty));
  finally
    Ini.Free;
  end;
end;

function DifficultyToStr(ADifficulty: TDifficultyLevel): string;
begin
  case ADifficulty of
    dlEasy: Result := 'Easy';
    dlMedium: Result := 'Medium';
    dlHard: Result := 'Hard';
  else
    Result := 'Medium';
  end;
end;

function StrToDifficulty(const S: string): TDifficultyLevel;
begin
  if SameText(S, 'Easy') then
    Exit(dlEasy)
  else if SameText(S, 'Hard') then
    Exit(dlHard)
  else
    Exit(dlMedium);
end;

end.
