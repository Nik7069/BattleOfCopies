unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MX, MY, PMX, PMY: Integer;
  MyColor: TColor;
  Size: Integer = 8;
  MClick: Boolean;
  Bitmap: TBitmap;
  BitmapE: TBitmap;
  Dest, Source: TRect;

implementation

uses PointConverter;

{$R *.dfm}

procedure LoadPaint;
begin
   Form1.PaintBox1.Canvas.Draw(0, 0, Bitmap);

     PointConverter.SetFieldRect(Rect(0, 0, Form1.ClientWidth, Form1.ClientHeight));
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  BitmapE := TBitmap.Create;
  BitmapE.Width := PaintBox1.Width;
  BitmapE.Height := PaintBox1.Height;
  Dest := Rect(0, 0, BitmapE.Width, BitmapE.Height);
  Source := Rect(0, 0, PaintBox1.Width, PaintBox1.Height);
  BitmapE.Canvas.CopyRect(Dest, PaintBox1.Canvas, Source);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form1.Panel1.Visible := false;
  Dest := Rect(0, 0, Bitmap.Width, Bitmap.Height);
  PaintBox1.Canvas.CopyRect(Dest, Bitmap.Canvas, Dest);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Bitmap := TBitmap.Create;
  Bitmap.SetSize(PaintBox1.Width, PaintBox1.Height);
//  Bitmap.Canvas.Brush.Color := clWhite;
//  Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));

end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MClick := true;

  Bitmap.Canvas.Pen.Color := clRed;
  Bitmap.Canvas.Brush.Color := clRed;
  Bitmap.Canvas.Pen.Width := Size;
  Bitmap.Canvas.PolyLine([Point(X, Y), Point(X, Y)]);

    LoadPaint;

end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PMX := MX;
  PMY := MY;
  MX := X;
  MY := Y;

  if MClick then
  begin
    Bitmap.Canvas.Pen.Color := clRed;
    Bitmap.Canvas.Brush.Color := clRed;
    Bitmap.Canvas.Pen.Width := Size;
    Bitmap.Canvas.PolyLine([Point(PMX, PMY), Point(MX, MY)]);
  end;

  LoadPaint;

end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MClick := false;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin

  LoadPaint;

end;

end.
