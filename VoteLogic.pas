unit VoteLogic;

interface

//uses
  //Winapi.Windows, Vcl.Graphics;

uses
  Vcl.StdCtrls, SetRulesLogic;

procedure VoteStart;
procedure CalculatePoints;
procedure LoadPaintVote1;
procedure LoadPaintVote2;

type
  Card = record
    Player: TPlayer;
    LabelCard: TLabel;
  end;

  TVoteCardsList = array of Card;

var
  IsVoting: boolean = false;
  VoteCardsList: TVoteCardsList;

implementation

uses
  Main, System.Classes,Vcl.Controls, PanelsLogic, Vcl.ExtCtrls, Vcl.Graphics, GameLogic;

var
  CurrentOriginalNum: Integer;
  CurrentOriginal: TPlayer;
  VoteOfs, LenPVL: Integer;
  BitmapVoteList: array of TBitmap;


procedure LoadPaintVote1;
begin
  MainForm.PaintVote1.Canvas.Draw(0, 0, BitmapVoteList[0]);
end;

procedure LoadPaintVote2;
begin
  MainForm.PaintVote2.Canvas.Draw(0, 0, BitmapVoteList[1]);
end;


procedure CreateNewCard(Player: TPlayer; VotersCount: Integer);
var
  NewCard: Card;
begin
  NewCard.LabelCard := TLabel.Create(MainForm);
  NewCard.LabelCard.Parent := MainForm.fpVoteUsers;
  NewCard.LabelCard.Caption := Player.Name;
  NewCard.LabelCard.Width := 120;
  NewCard.LabelCard.Height := 40;
  NewCard.LabelCard.Color := clBtnHighLight;
  NewCard.LabelCard.Transparent := false;
  NewCard.LabelCard.Alignment := taCenter;
  NewCard.LabelCard.Layout := tlCenter;

  NewCard.Player := Player;


  VoteCardsList[VotersCount] := NewCard;
end;


procedure NextPlayerVote;
var
  i: Integer;
  VotersCount: Integer;
begin

  CurrentOriginal := PlayersList[CurrentOriginalNum];
//  CurrentOriginal.copyid := (CurrentOriginalNum+1) mod CountPlayers;
  MainForm.txtPromptVote.Caption := CurrentOriginal.Prompt;

  VoteOfs := Random(LenPVL);

  BitmapVoteList[VoteOfs].Assign(CurrentOriginal.BitmapOrig);
  BitmapVoteList[(VoteOfs+1) mod LenPVL].Assign(PlayersList[CurrentOriginal.copyid].BitmapCopy);

  LoadPaintVote1;
  LoadPaintVote2;

  for i := 0 to High(VoteCardsList) do
  begin
    if Assigned(VoteCardsList[i].LabelCard) then
    begin
      VoteCardsList[i].LabelCard.Free;
      VoteCardsList[i].LabelCard := nil;
    end;
  end;
    


  SetLength(VoteCardsList, CountPlayers - LenPVL);

  VotersCount := 0;

  for i := 0 to CountPlayers - 1 do
  begin
    if (CurrentOriginalNum <> i) and (CurrentOriginal.copyid <> i) then
    begin
      CreateNewCard(PlayersList[i], VotersCount);
      Inc(VotersCount);
    end;
  end;



end;

procedure VoteStart;
begin
  IsVoting := true;

  LenPVL := 2;
  SetLength(BitmapVoteList, LenPVL);

  MainForm.PaintVote1.Enabled := false;
  BitmapVoteList[0] := TBitmap.Create;

  MainForm.PaintVote2.Enabled := false;
  BitmapVoteList[1] := TBitmap.Create;

  CurrentOriginalNum := 0;
  ShowPanel(MainForm.pnlVote);
  NextPlayerVote;
end;

procedure CalculatePoints;
begin
  Inc(CurrentOriginalNum);
  if CurrentOriginalNum = CountPlayers then
  begin
    ShowPanel(MainForm.pnlMenu);
    IsVoting := false;
  end
  else
  begin
    NextPlayerVote;
  end;
end;

end.
