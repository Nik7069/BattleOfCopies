unit GameLogic;

interface

uses
  Unit1;

implementation

var
  Bitmap: TBitmap;
  MClick: Boolean;

procedure CreateBitmap;
begin
  Bitmap := TBitmap.Create;
  Bitmap.SetSize(Form1.PaintBox1.Width, Form1.PaintBox1.Height);
  Bitmap.Canvas.Pen.Color := clRed;
  Bitmap.Canvas.Brush.Color := clRed;
  Bitmap.Canvas.Pen.Width := Size;
end;

procedure PaintMouseMove(X, Y: Integer);
begin
  if MClick then
  begin

    Bitmap.Canvas.LineTo(X, Y);
    LoadPaint;
  end;
end;

end.
