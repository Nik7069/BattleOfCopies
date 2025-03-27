unit GameLogic;

interface

uses
  Winapi.Windows, Vcl.Graphics;

procedure LoadPaint;
procedure CreateBitmap;
procedure PaintMouseDown(X, Y: Integer);
procedure PaintMouseMove(X, Y: Integer);
procedure PaintMouseUp;
procedure StartGame;
procedure GameTimer;
procedure PlayerIsReady;
procedure NextPlayerWait;
procedure CleanBitmap(var CleanThisBM: TBitmap);

implementation

uses
  Main, System.Classes, SetRulesLogic, PanelsLogic;

var
  MyColor: TColor;
  Size: Integer = 8;
  MClick: Boolean;
  Bitmap: TBitmap;
  CurrentPlayer: TPlayer;
  CurrentPlayerNum: Integer;
  pbTime, pbMax, pbStartTime: Integer;

procedure LoadPaint;
begin
  MainForm.PaintBox1.Canvas.Draw(0, 0, Bitmap);
end;

procedure CleanBitmap(var CleanThisBM: TBitmap);
begin
  CleanThisBM.Canvas.Brush.Color := clWhite;
  CleanThisBM.Canvas.FillRect(Rect(0, 0, CleanThisBM.Width, CleanThisBM.Height));
end;

procedure CreateBitmap;
begin
  Bitmap := TBitmap.Create;
  Bitmap.SetSize(MainForm.PaintBox1.Width, MainForm.PaintBox1.Height);
  Bitmap.Canvas.Pen.Color := clBlack;
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
  ShowPanel(MainForm.pnlGame);
  MainForm.CurrentPrompt.Caption := CurrentPlayer.Prompt;

  CleanBitmap(Bitmap);
  LoadPaint;

  // Прогресс бар "падает"
  pbMax := MainForm.CustomPB.Width;
  // pbMax - заполнен / 0 - пустой
  MainForm.ProgressPB.Width := pbMax;

  pbStartTime := GetTickCount;

  pbTime := CountSeconds*100;
  MainForm.Timer1.Interval := 1; // Любое значение, лучше < 50 для плавности
  MainForm.Timer1.Enabled := True;
end;

procedure NextPlayerWait;
begin
  ShowPanel(MainForm.pnlWaitReady);
  CurrentPlayer := PlayersList[CurrentPlayerNum];
  MainForm.txtReadyPlayer.Caption := CurrentPlayer.Name;
end;

procedure StartGame;
begin
  CreateBitmap;
  CurrentPlayerNum := 0;
  NextPlayerWait;
end;

procedure PlayerIsReady;
begin
  NextPlayerGame;
end;

procedure GameTimer;
var ElapsedTime: Integer;
begin

  ElapsedTime := GetTickCount - pbStartTime;

  // pbMax - Round... - опустошается / Round... - заполняется
  MainForm.ProgressPB.Width := pbMax - Round(pbMax * ElapsedTime / pbTime);

  if ElapsedTime >= pbTime then
  begin
    MainForm.Timer1.Enabled := False;

    CurrentPlayer.Bitmap.Assign(Bitmap);

    Inc(CurrentPlayerNum);
    if CurrentPlayerNum = CountPlayers then
    begin
      CurrentPlayer.Bitmap := Bitmap;
      ShowPanel(MainForm.pnlMenu);
    end
    else
    begin
      NextPlayerWait;
    end;
  end;
end;


end.
