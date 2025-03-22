unit SetRulesLogic;

interface

procedure AddNewPlayer;
procedure AddNewRules;

type
  TPlayer = Record
    Name: String;
  End;

type
  TPlayersList = array of TPlayer;

var
  PlayerList: TPlayersList;

implementation

uses
  Main, PanelsLogic, System.SysUtils, Vcl.Dialogs;

var
  CountPlayers, CountSeconds: Integer;
  iName: Integer = 0;

procedure AddNewRules;
begin
  CountPlayers := StrToInt(MainForm.ComboPlayers.Items[MainForm.ComboPlayers.ItemIndex]);
  CountSeconds := StrToInt(MainForm.ComboSeconds.Items[MainForm.ComboSeconds.ItemIndex]);
  ShowPanel(MainForm.pnlSetNames);

  SetLength(PlayerList, CountPlayers);
end;

procedure AddNewPlayer;
var
  NewPlayer: TPlayer;
  i: Integer;
  SameName: Boolean;
begin
  NewPlayer.Name := MainForm.NameInput.Text;
  SameName := false;
  for i := Low(PlayerList) to iName-1 do
  begin
    if PlayerList[i].Name = NewPlayer.Name then
      SameName := true;
  end;

  if not SameName then
  begin
    PlayerList[iName] := NewPlayer;
    MainForm.NameInput.Clear;
    Inc(iName);
    if iName = CountPlayers then
    begin
      iName := 0;
      ShowPanel(MainForm.pnlGame);
    end;
  end
  else
  begin
    ShowMessage('Игрок с таким псевдонимом уже зарегистрирован, введите другое имя');
  end;

end;

//procedure NextStep;
//begin
//  ShowPanel(MainForm.pnlGame);
//end;

end.
