unit CustomImageButton;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.ImgList, Winapi.Messages, Winapi.Windows, System.SysUtils;


type
  TCustomImageButton = class(TGraphicControl)
  private
    FImageList: TCustomImageList;  // Хранилище изображений
    FNormalIndex: Integer;  // Индекс обычного состояния
    FHoverIndex: Integer;   // Индекс при наведении
    FDownIndex: Integer;    // Индекс при нажатии
    FCaption: string;  // Текст кнопки
    FIsPressed: Boolean; // Флаг состояния нажатия
    procedure SetImageList(const Value: TCustomImageList);
    procedure SetNormalIndex(const Value: Integer);
    procedure SetHoverIndex(const Value: Integer);
    procedure SetDownIndex(const Value: Integer);
    procedure SetCaption(const Value: string);
  protected
    procedure Paint; override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WM_LButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WM_LButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ImageList: TCustomImageList read FImageList write SetImageList;
    property NormalIndex: Integer read FNormalIndex write SetNormalIndex default -1;
    property HoverIndex: Integer read FHoverIndex write SetHoverIndex default -1;
    property DownIndex: Integer read FDownIndex write SetDownIndex default -1;
    property Caption: string read FCaption write SetCaption;
    property Font;
    property OnClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TCustomImageButton]);
end;

{ TCustomImageButton }

constructor TCustomImageButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 160;
  Height := 85;
  FNormalIndex := -1;
  FHoverIndex := -1;
  FDownIndex := -1;
  FCaption := 'Button';
  FIsPressed := False;
  ControlStyle := ControlStyle - [csOpaque];  // Убираем фон кнопки
end;

procedure TCustomImageButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomImageButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomImageButton.WM_LButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  FIsPressed := True;
  Invalidate;
end;

procedure TCustomImageButton.WM_LButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  FIsPressed := False;
  Invalidate;
  Click;
end;

procedure TCustomImageButton.Paint;
var
  ImgIndex: Integer;
  TextX, TextY: Integer;
begin
  // Определяем текущее состояние кнопки
  if FIsPressed and (FDownIndex <> -1) then
    ImgIndex := FDownIndex
  else if (FHoverIndex <> -1) and PtInRect(ClientRect, ScreenToClient(Mouse.CursorPos)) then
    ImgIndex := FHoverIndex
  else
    ImgIndex := FNormalIndex;

  // Отрисовываем фоновое изображение
  if (FImageList <> nil) and (ImgIndex >= 0) then
    FImageList.Draw(Canvas, 0, 0, ImgIndex)
  else
  begin
    Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(ClientRect);
  end;

  // Отрисовываем текст по центру кнопки
  Canvas.Font := Font;
  Canvas.Brush.Style := bsClear;
  TextX := (Width - Canvas.TextWidth(FCaption)) div 2;
  TextY := (Height - Canvas.TextHeight(FCaption)) div 2;
  Canvas.TextOut(TextX, TextY, FCaption);
end;

procedure TCustomImageButton.SetCaption(const Value: string);
begin
  FCaption := Value;
  Invalidate;
end;

procedure TCustomImageButton.SetImageList(const Value: TCustomImageList);
begin
  FImageList := Value;
  Invalidate;
end;

procedure TCustomImageButton.SetNormalIndex(const Value: Integer);
begin
  FNormalIndex := Value;
  Invalidate;
end;

procedure TCustomImageButton.SetHoverIndex(const Value: Integer);
begin
  FHoverIndex := Value;
  Invalidate;
end;

procedure TCustomImageButton.SetDownIndex(const Value: Integer);
begin
  FDownIndex := Value;
  Invalidate;
end;

end.

procedure Register;
begin
  RegisterComponents('Samples', [TCustomImageButton]);
end;

