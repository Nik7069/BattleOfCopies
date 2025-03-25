unit GameLogic;

interface

procedure LoadPaint;
procedure CreateBitmap;
procedure PaintMouseDown(X, Y: Integer);
procedure PaintMouseMove(X, Y: Integer);
procedure PaintMouseUp;
procedure StartGame;
procedure GameTimerEnd;

implementation

uses
  Main, Vcl.Graphics, SetRulesLogic, PanelsLogic;

var
  MyColor: TColor;
  Size: Integer = 8;
  MClick: Boolean;
  Bitmap: TBitmap;
  CurrentPlayer: TPlayer;
  CurrentPlayerNum: Integer;

procedure LoadPaint;
begin
  MainForm.PaintBox1.Canvas.Draw(0, 0, Bitmap);
end;

procedure CreateBitmap;
begin
  Bitmap := TBitmap.Create;
  Bitmap.SetSize(MainForm.PaintBox1.Width, MainForm.PaintBox1.Height);
  Bitmap.Canvas.Pen.Color := clRed;
  Bitmap.Canvas.Brush.Color := clRed;
  Bitmap.Canvas.Pen.Width := Size;
end;

procedure PaintMouseDown(X, Y: Integer);
begin
  MClick := true;

  Bitmap.Canvas.MoveTo(X, Y);
  Bitmap.Canvas.LineTo(X, Y);

  LoadPaint;
end;

procedure PaintMouseMove(X, Y: Integer);
begin
  if MClick then
  begin
    Bitmap.Canvas.LineTo(X, Y);
    LoadPaint;
  end;
end;

procedure PaintMouseUp;
begin
  MClick := false;
end;


procedure NextPlayerGame;
begin
  CurrentPlayer := PlayersList[CurrentPlayerNum];
  MainForm.CurrentPrompt.Caption := CurrentPlayer.Prompt;

  MainForm.Timer1.Interval := CountSeconds*100;
  MainForm.Timer1.Enabled := True;
end;

procedure StartGame;
begin
  CurrentPlayerNum := 0;
  NextPlayerGame;
end;

procedure GameTimerEnd;
begin
  Inc(CurrentPlayerNum);
  if CurrentPlayerNum = CountPlayers then
  begin
    ShowPanel(MainForm.pnlMenu);
  end
  else
  begin
    NextPlayerGame;
  end;

end;


end.
