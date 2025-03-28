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
procedure RememberTimer;
procedure PlayerIsReady;
procedure NextPlayerWait;
procedure CleanBitmap(var CleanThisBM: TBitmap);

implementation

uses
  Main, System.Classes, SetRulesLogic, PanelsLogic, VoteLogic;

var
  MyColor: TColor;
  Size: Integer = 8;
  MClick: Boolean;
  Bitmap: TBitmap;
  CurrentPlayer: TPlayer;
  CurrentPlayerNum, CurrentOrigNum: Integer;
  pbTime, pbMax, pbStartTime: Integer;
  IsPaintOriginal: Boolean;
  RoundNum: Integer;

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
  if IsPaintOriginal then
  begin
    MainForm.CurrentPrompt.Caption := CurrentPlayer.Prompt;
  end
  else
  begin
    MainForm.CurrentPrompt.Caption := 'Write this paint now!';
  end;

  CleanBitmap(Bitmap);
  LoadPaint;
  MainForm.PaintBox1.Enabled := true;

  // Прогресс бар "падает"
  pbMax := MainForm.CustomPB.Width;
  // pbMax - заполнен / 0 - пустой
  MainForm.ProgressPB.Width := pbMax;

  pbStartTime := GetTickCount;

  pbTime := CountSeconds*100;
  MainForm.Timer1.Interval := 1; // Любое значение, лучше < 50 для плавности
  MainForm.Timer1.Enabled := True;
end;

procedure NextPlayerRemember;
begin

  CurrentOrigNum := (CurrentPlayerNum+1) mod CountPlayers;
  PlayersList[CurrentOrigNum].copyid := CurrentPlayerNum;

  Bitmap.Assign(PlayersList[CurrentOrigNum].BitmapOrig);
  LoadPaint;
  MainForm.PaintBox1.Enabled := false;

  pbMax := MainForm.CustomPB.Width;
  MainForm.ProgressPB.Width := pbMax;

  pbStartTime := GetTickCount;

  pbTime := CountSeconds*1000 div 10;
  MainForm.Timer2.Interval := 1; // Любое значение, лучше < 50 для плавности
  MainForm.Timer2.Enabled := True;

  MainForm.CurrentPrompt.Caption := 'Remember this paint!';
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
  RoundNum := 0;
  IsPaintOriginal := true;
  NextPlayerWait;
end;

procedure PlayerIsReady;
begin
  if not IsPaintOriginal then
  begin
    NextPlayerRemember;
//    ShowPanel(MainForm.pnlGame);
  end
  else
  begin
    NextPlayerGame;
//    ShowPanel(MainForm.pnlGame);
  end;

  ShowPanel(MainForm.pnlGame);
end;

procedure RememberTimer;
var ElapsedTime: Integer;
begin
  ElapsedTime := GetTickCount - pbStartTime;

  MainForm.ProgressPB.Width := pbMax - Round(pbMax * ElapsedTime / pbTime);

  if ElapsedTime >= pbTime then
  begin
    MainForm.Timer2.Enabled := False;
    NextPlayerGame;
  end;
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

    if IsPaintOriginal then
    begin
      CurrentPlayer.BitmapOrig.Assign(Bitmap);
    end
    else
    begin
      CurrentPlayer.BitmapCopy.Assign(Bitmap);
    end;

    Inc(CurrentPlayerNum);
    if CurrentPlayerNum = CountPlayers then
    begin
      CurrentPlayerNum := 0;
      if not IsPaintOriginal then
      begin
        VoteStart;
        Inc(RoundNum);
      end;

      IsPaintOriginal := not IsPaintOriginal;
    end;

    if not IsVoting then
    begin
      NextPlayerWait;
    end

  end;
end;


end.
