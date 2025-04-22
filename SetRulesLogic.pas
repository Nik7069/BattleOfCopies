unit SetRulesLogic;

interface

uses
  Vcl.Graphics;

procedure AddNewPlayer;
procedure AddNewRules;
procedure LoadPrompts;

type
  TPlayer = Record
    Name: String;
    Prompt: String;
    id, copyid: Integer;
    Score: Integer;
    BitmapOrig, BitmapCopy: TBitmap;
  End;

type
  TPlayersList = array of TPlayer;
  TPromptsList = array of String;

var
  PlayersList: TPlayersList;
  PromptsList: TPromptsList;
  CountPlayers, CountSeconds: Integer;

implementation

uses
  Main, PanelsLogic, VoteLogic, GameLogic, System.SysUtils, Vcl.Dialogs;

var
  iName: Integer;

procedure ShuffleFirstN(var SomeList: TPromptsList; N: Integer);
var
  i, r: Integer;
  temp: String;
begin
  for i := 0 to N-1 do
  begin
    r := Random(Length(SomeList)-i) + i;
    temp := SomeList[i];
    SomeList[i] := SomeList[r];
    SomeList[r] := temp;
  end;
end;

procedure AddNewRules;
var
  IndexPlayers: Integer;
begin
  IndexPlayers := MainForm.ComboPlayers.ItemIndex;
  CountSeconds := StrToIntDef(MainForm.ComboSeconds.Text, -1);

  if CountPlayers > Length(PromptsList) then
  begin
    ShowMessage('Игроков больше чем уникальных заданий. Добавьте больше тем или уменьшите кол-во игроков');
  end
  else if IndexPlayers = -1 then
  begin
    ShowMessage('Вы ввели неверное количество игроков, их должно быть от ' + IntToStr(MinPlayers) + ' до ' + IntToStr(MaxPlayers));
  end
  else if (CountSeconds < MinSeconds) or (CountSeconds > MaxSeconds) then
  begin
    ShowMessage('Вы ввели неверное количество секунд, их должно быть от ' + IntToStr(MinSeconds) + ' до ' + IntToStr(MaxSeconds));
  end
  else
  begin
    CountPlayers := StrToInt(MainForm.ComboPlayers.Items[MainForm.ComboPlayers.ItemIndex]);

    SetLength(PlayersList, CountPlayers);
    ShuffleFirstN(PromptsList, CountPlayers);
    MainForm.lbPlayerNum.Caption := 'Игрок № [1/' + IntToStr(CountPlayers) + ']';

    iName := 0;
    ShowPanel(MainForm.pnlSetNames);
  end;

end;

procedure AddNewPlayer;
var
  NewPlayer: TPlayer;
  i: Integer;
  SameName: Boolean;
begin
  NewPlayer.Name := Trim(MainForm.NameInput.Text);
  SameName := false;
//  for i := Low(PlayersList) to iName-1 do
//  begin
//    if PlayersList[i].Name = NewPlayer.Name then
//      SameName := true;
//  end;

  i := Low(PlayersList);
  while (not SameName) and (i < iName) do
  begin
    if PlayersList[i].Name = NewPlayer.Name then
      SameName := true;
    Inc(i);
  end;


  if (not SameName) and (NewPlayer.Name <> '') then
  begin
    NewPlayer.id := iName;
    NewPlayer.Prompt := PromptsList[iName];
    NewPlayer.BitmapOrig := TBitmap.Create;
    NewPlayer.BitmapCopy := TBitmap.Create;
    NewPlayer.Score := 0;
    PlayersList[iName] := NewPlayer;
    MainForm.NameInput.Clear;

    Inc(iName);

    MainForm.lbPlayerNum.Caption := 'Игрок № [' + IntToStr(iName+1) + '/' + IntToStr(CountPlayers) + ']';

    if iName = CountPlayers then
    begin
      iName := 0;
//      VoteStart;
      StartGame;
    end;
  end
  else
  begin
    ShowMessage('Вы ввели уже используемое/некорректное имя. Введите другой псевдоним');
  end;

end;



procedure LoadPrompts;
var
  myFile: TextFile;
  prompt: String;
  OldLength: Integer;
begin

  try
    AssignFile(myFile, 'prompts\prompts.txt');
    Reset(myFile);
    while (not EOF(myFile)) do begin
      Readln(myFile, prompt);
      prompt := Trim(UTF8ToString(prompt));
      if prompt <> '' then
      begin
        OldLength := Length(PromptsList);
        SetLength(PromptsList, OldLength+1);
        PromptsList[OldLength] := prompt;
      end;

    end;
    closeFile(myFile);
  except
    showMessage('Файл с заданиями не найден, переустановите программу');
  end;

end;



function GetTopPlayers(Players: TPlayersList): TPlayersList;
var
  MaxScore: Integer;
  i, len: Integer;
begin

  len := Length(Players);

  if len > 1 then

  begin
    MaxScore := Players[0].Score;

    SetLength(Result, 1);
    Result[i] := Players[i];

    i := 1;
    while (i < len) and (Players[i].Score = MaxScore) do
    begin
      SetLength(Result, i+1);
      Result[i] := Players[i];
      Inc(i);
    end;
  end;
end;






//procedure NextStep;
//begin
//  ShowPanel(MainForm.pnlGame);
//end;

end.
