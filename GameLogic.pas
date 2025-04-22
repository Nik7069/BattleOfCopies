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
procedure NextPlayerWaitReady;
procedure CleanBitmap(var CleanThisBM: TBitmap);
procedure AfterGame;
procedure NextPlayerWaitPrompt3;
procedure HidePaintBox(hide: Boolean);

implementation

uses
  Main, System.Classes, SetRulesLogic, PanelsLogic, VoteLogic;


type
  TProcedure = procedure;

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
  OnTimerFinish: TProcedure;



procedure LoadPaint;
begin
  MainForm.pbDraw.Canvas.Draw(0, 0, Bitmap);
end;

procedure CleanBitmap(var CleanThisBM: TBitmap);
begin
  CleanThisBM.Canvas.Brush.Color := clWhite;
  CleanThisBM.Canvas.FillRect(Rect(0, 0, CleanThisBM.Width, CleanThisBM.Height));
end;

procedure CreateBitmap;
begin
  Bitmap := TBitmap.Create;
  Bitmap.SetSize(MainForm.pbDraw.Width, MainForm.pbDraw.Height);
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

procedure StartTimerPB(Duration: Integer; AfterProc: TProcedure);
begin
  pbStartTime := GetTickCount;
  pbTime := Duration;

  // Прогресс бар "падает"
  pbMax := MainForm.CustomPB.Width;
  // pbMax - заполнен / 0 - пустой
  MainForm.ProgressPB.Width := pbMax;

  OnTimerFinish := AfterProc;

  MainForm.tGame.Interval := 1;  // Любое значение, лучше < 50 для плавности
  MainForm.tGame.Enabled := True;
end;


procedure NextPlayerGame;
begin
  if IsPaintOriginal then
  begin
    MainForm.txtCurrentPrompt.Caption := CurrentPlayer.Prompt;
  end
  else
  begin
    MainForm.txtCurrentPrompt.Caption := 'Нарисуйте это по памяти!';
  end;

  CleanBitmap(Bitmap);
  LoadPaint;

  HidePaintBox(false);

  MainForm.txtPaintHint.Caption := 'Нарисуйте это!';

  StartTimerPB(CountSeconds*100, AfterGame);

end;

procedure AfterGame;
begin
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
    NextPlayerWaitReady;
  end
end;

procedure NextPlayerRemember;
begin

  HidePaintBox(false);

  CurrentOrigNum := (CurrentPlayerNum+1) mod CountPlayers;
  PlayersList[CurrentOrigNum].copyid := CurrentPlayerNum;

  Bitmap.Assign(PlayersList[CurrentOrigNum].BitmapOrig);
  LoadPaint;
  MainForm.pbDraw.Enabled := false;

  MainForm.txtCurrentPrompt.Caption := 'Запомни этот рисунок!';

  StartTimerPB(CountSeconds*100, NextPlayerWaitPrompt3);
end;

procedure NextPlayerWaitReady;
begin
  ShowPanel(MainForm.pnlWaitReady);
  CurrentPlayer := PlayersList[CurrentPlayerNum];
  MainForm.txtReadyPlayer.Caption := CurrentPlayer.Name;
end;

procedure HidePaintBox(hide: Boolean);
begin
  MainForm.pbDraw.Enabled := not hide;
  MainForm.txtCurrentPrompt.Visible := not hide;
  MainForm.pbDraw.Visible := not hide;
  MainForm.txtCurrentPromptTemp.Visible := hide;
end;


procedure NextPlayerWaitPrompt1;
begin
  HidePaintBox(true);

  MainForm.txtCurrentPrompt.Caption := CurrentPlayer.Prompt;
  MainForm.txtCurrentPromptTemp.Caption := CurrentPlayer.Prompt;
  MainForm.txtPaintHint.Caption := 'Приготовьтесь рисовать по данному заданию!';

  StartTimerPB(3000, NextPlayerGame);
end;


procedure NextPlayerWaitPrompt2;
begin

  HidePaintBox(true);

  MainForm.txtCurrentPrompt.Caption := 'Запомните данный рисунок!';
  MainForm.txtCurrentPromptTemp.Caption := 'Приготовьтесь запомнить рисунок!';
  MainForm.txtPaintHint.Caption := 'Вам нужно будет его перерисовать!';


  StartTimerPB(3000, NextPlayerRemember);
end;

procedure NextPlayerWaitPrompt3;
begin
  HidePaintBox(true);

  MainForm.txtCurrentPrompt.Caption := 'Нарисуйте это!';
  MainForm.txtCurrentPromptTemp.Caption := 'Приготовьтесь нарисовать это!';
  MainForm.txtPaintHint.Caption := 'Вам нужно вспомнить все детали';

  StartTimerPB(3000, NextPlayerGame);
end;

procedure StartGame;
begin
  CreateBitmap;
  CurrentPlayerNum := 0;
  RoundNum := 0;
  IsPaintOriginal := true;
  NextPlayerWaitReady;
end;

procedure PlayerIsReady;
begin
  if not IsPaintOriginal then
  begin
    NextPlayerWaitPrompt2;
    //NextPlayerRemember;
  end
  else
  begin
    NextPlayerWaitPrompt1;
   // NextPlayerGame;
  end;

  ShowPanel(MainForm.pnlGame);
end;



procedure GameTimer;
var ElapsedTime: Integer;
begin
  ElapsedTime := GetTickCount - pbStartTime;
  MainForm.ProgressPB.Width := pbMax - Round(pbMax * ElapsedTime / pbTime);

  if ElapsedTime >= pbTime then
  begin
    MainForm.tGame.Enabled := False;

    if Assigned(OnTimerFinish) then
      OnTimerFinish();
  end;
end;



end.
