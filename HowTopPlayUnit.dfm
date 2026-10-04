object HowToPlayForm: THowToPlayForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'TowerDefense'
  ClientHeight = 740
  ClientWidth = 1120
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  ShowInTaskBar = True
  OnCreate = FormCreate
  TextHeight = 15
  object ImageBackground: TImage
    Left = 0
    Top = 0
    Width = 1120
    Height = 740
    Align = alClient
    Stretch = True
    ExplicitLeft = 272
    ExplicitTop = 192
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object BtnBack: TCustomImageButton
    Left = 480
    Top = 600
    Width = 160
    Height = 85
    ImageList = MainMenuForm.ImageList1
    NormalIndex = 0
    HoverIndex = 1
    DownIndex = 2
    Caption = #1058#1080#1090#1088#1099' '#1074#1099#1081#1090#1080
    OnClick = BtnBackClick
  end
  object Label1: TLabel
    Left = 508
    Top = 36
    Width = 173
    Height = 69
    AutoSize = False
    Caption = #1058#1080#1090#1088#1099' '#1090#1077#1089#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
end
