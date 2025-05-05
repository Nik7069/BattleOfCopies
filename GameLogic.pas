unit GameLogic;

interface

uses
  Winapi.Windows, Vcl.Graphics, System.SysUtils;

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
procedure HidePaintBox(hide: Boolean);
procedure SetUndoBitmap;

var
  pbTime: Integer;

implementation

uses
  Main, System.Classes, SetRulesLogic, PanelsLogic, VoteLogic;


const
  WaitPromptTimeLength = 3000;
  RememberTimeLength = 5000;
  UndoLimit = 100;

type
  TUndoBuffer = array[0..UndoLimit-1] of TBitmap;

var
  MyColor: TColor;
  Size: Integer = 6;
  MClick: Boolean;
  Bitmap: TBitmap;
  CurrentPlayer: TPlayer;
  CurrentPlayerNum, CurrentOrigNum: Integer;
  pbMax, pbStartTime: Integer;
  IsPaintOriginal: Boolean;
  RoundNum: Integer;
  OnTimerFinish: TProc;

  UndoBuffer: TUndoBuffer;
  UndoIndex: Integer = 0;
  CanUndo: Boolean = false;

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

procedure SaveUndoBitmap;
var
  bmp: TBitmap;
begin
  if CanUndo then
  begin
    UndoIndex := (UndoIndex + 1) mod UndoLimit;
    if Assigned(UndoBuffer[UndoIndex]) then
      UndoBuffer[UndoIndex].Free;

    bmp := TBitmap.Create;
    bmp.Assign(Bitmap);

    UndoBuffer[UndoIndex] := bmp;
  end;

end;


procedure SetUndoBitmap;
var
  NextIndex, PrevIndex: Integer;
begin
  if CanUndo then
  begin
    PrevIndex := (UndoIndex - 1 + UndoLimit) mod UndoLimit;

    if Assigned(UndoBuffer[PrevIndex]) then
    begin
      Bitmap.Assign(UndoBuffer[PrevIndex]);
      LoadPaint;

      NextIndex := UndoIndex;
      if Assigned(UndoBuffer[NextIndex]) then
      begin
        UndoBuffer[NextIndex].Free;
        UndoBuffer[NextIndex] := nil;
      end;

      UndoIndex := PrevIndex;
    end;
  end;
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
  SaveUndoBitmap;
end;

procedure StartTimerPB(Duration: Integer; AfterProc: TProc);
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

procedure NextPlayerWaitPrompt(
  const PromptCaption, TempCaption, Hint: string;
  AfterProc: TProc);
begin
  HidePaintBox(true);

  MainForm.txtCurrentPrompt.Caption := PromptCaption;
  MainForm.txtCurrentPromptTemp.Caption := TempCaption;
  MainForm.txtPaintHint.Caption := Hint;

  StartTimerPB(WaitPromptTimeLength, AfterProc);
end;


procedure NextPlayerGame;
begin

  CleanBitmap(Bitmap);
  LoadPaint;

  HidePaintBox(false);

  If IsPaintOriginal then
  begin
    MainForm.txtPaintHint.Caption := 'Нарисуйте это!';
  end
  else
  begin
    MainForm.txtPaintHint.Caption := '';
  end;

  CanUndo := true;
  SaveUndoBitmap;

  StartTimerPB(CountSeconds*1000, AfterGame);

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

  CanUndo := false;

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
  MainForm.btnBack.Visible := false;
  MainForm.btnFinish.Visible := false;

  CurrentOrigNum := (CurrentPlayerNum+1) mod CountPlayers;
  PlayersList[CurrentOrigNum].copyid := CurrentPlayerNum;

  Bitmap.Assign(PlayersList[CurrentOrigNum].BitmapOrig);
  LoadPaint;
  MainForm.pbDraw.Enabled := false;

  StartTimerPB(RememberTimeLength, procedure
  begin
    NextPlayerWaitPrompt(
      'Нарисуйте все что запомнили',
      'Приготовьтесь нарисовать это',
      'Вспомните все детали!',
      NextPlayerGame
    );
  end);
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

  MainForm.btnBack.Visible := not hide;
  MainForm.btnFinish.Visible := not hide;
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
  if IsPaintOriginal then
  begin
    NextPlayerWaitPrompt(
      CurrentPlayer.Prompt,
      CurrentPlayer.Prompt,
      'Приготовьтесь это нарисовать!',
      NextPlayerGame
    );
  end
  else
  begin
    NextPlayerWaitPrompt(
      'Запомните данный рисунок',
      'Приготовьтесь запомнить рисунок',
      'Запомните все детали!',
      NextPlayerRemember
    );
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
