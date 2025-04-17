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
  iName: Integer = 0;

procedure ShuffleFirstN(var SomeList: TPromptsList; N: Integer);
var
  i, r: Integer;
  temp: String;
begin
  Randomize;
  for i := 0 to N-1 do
  begin
    r := Random(Length(SomeList)-i) + i;
    temp := SomeList[i];
    SomeList[i] := SomeList[r];
    SomeList[r] := temp;
  end;
end;

procedure AddNewRules;
begin
  CountPlayers := StrToInt(MainForm.ComboPlayers.Items[MainForm.ComboPlayers.ItemIndex]);
  CountSeconds := StrToInt(MainForm.ComboSeconds.Items[MainForm.ComboSeconds.ItemIndex]) ;

  if CountPlayers <= Length(PromptsList) then
  begin
    SetLength(PlayersList, CountPlayers);
    ShuffleFirstN(PromptsList, CountPlayers);
    ShowPanel(MainForm.pnlSetNames);
  end
  else
  begin
    ShowMessage('Игроков больше чем уникальных заданий. Добавьте больше тем или уменьшите кол-во игроков');
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
    PlayersList[iName] := NewPlayer;
    MainForm.NameInput.Clear;


    Inc(iName);
    if iName = CountPlayers then
    begin
      iName := 0;
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
