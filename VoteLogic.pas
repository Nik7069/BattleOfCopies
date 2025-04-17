unit VoteLogic;

interface

//uses
  //Winapi.Windows, Vcl.Graphics;


uses
  Vcl.StdCtrls, SetRulesLogic, Vcl.Graphics, Vcl.ExtCtrls;

procedure VoteStart;
procedure CalculatePoints;
procedure LoadPaintVote(PaintVote: TPaintBox; Bitmap: TBitmap);
procedure SelectCard(Sender: TObject);
procedure PaintVoteSelect(Sender: TObject);

const
  UnSlctColor = clWebSnow;
  SlctColor = clSkyBlue;

type
  TCard = record
    Player: TPlayer;
    LabelCard: TLabel;
    SelectedId: Integer;
  end;

  TBallot = record
    Bitmap: TBitmap;
    PaintVote: TPaintBox;
    Player: TPlayer;
  end;

  TVoteCardsList = array of TCard;

var
  IsVoting: boolean = false;
  VoteCardsList: TVoteCardsList;
  SelectedCard: TLabel;
  BallotList: array of TBallot;
  BitmapVoteList: array of TBitmap;
  PaintVoteList: array of TPaintBox;

implementation

uses
  Main, System.Classes, Vcl.Controls, Vcl.Dialogs, System.SysUtils,
  PanelsLogic, GameLogic;

var
  CurrentOriginalNum: Integer;
  CurrentOriginal: TPlayer;
  VoteOfs, LenPVL: Integer;


procedure LoadPaintVote(PaintVote: TPaintBox; Bitmap: TBitmap);
begin
  PaintVote.Canvas.Draw(0, 0, Bitmap);
end;


procedure CreateNewCard(Player: TPlayer; VotersCount: Integer);
var
  NewCard: TCard;
begin
  NewCard.LabelCard := TLabel.Create(MainForm);

  // Label
  with NewCard.LabelCard do
  begin
    Parent := MainForm.fpVoteUsers;
    Caption := Player.Name;
    Width := 102;
    Height := 35;
    Color := UnSlctColor;
    Transparent := false;
    Alignment := taCenter;
    Layout := tlCenter;
    AlignWithMargins := true;
    OnClick := MainForm.ToSelectCardClick;
  end;

  // Margins
  with NewCard.LabelCard.Margins do
  begin
    Top := 0;
    Left := 0;
    Bottom := 4;
    Right := 4;
  end;

  NewCard.SelectedId := -1;

  NewCard.Player := Player;


  VoteCardsList[VotersCount] := NewCard;
end;


procedure SelectCard(Sender: TObject);
var
  Card: TLabel;
begin

  if Assigned(SelectedCard) then
    SelectedCard.Color := UnSlctColor;

  Card := Sender as TLabel;
  Card.Color := SlctColor;
  SelectedCard := Card;
end;

procedure PaintVoteSelect(Sender: TObject);
var
  PaintVote: TPaintBox;
  i, j: Integer;
begin
  if Assigned(SelectedCard) then
  begin
    PaintVote := Sender as TPaintBox;

    i := 0;
    while (i <= 1) and (PaintVoteList[i] <> PaintVote) do
      Inc(i);

    if i <= 1 then
    begin
      j := 0;
      while (j <= High(VoteCardsList)) and
      (VoteCardsList[j].LabelCard <> SelectedCard) do
        Inc(j);

      if j <= High(VoteCardsList) then
      begin
        VoteCardsList[j].SelectedId := i;
        VoteCardsList[j].LabelCard.Color := UnSlctColor;
        if i = 0 then

          VoteCardsList[j].LabelCard.Parent := MainForm.fpPaintVote1
        else
          VoteCardsList[j].LabelCard.Parent := MainForm.fpPaintVote2;
      end;
    end;

  end;
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

  CleanBitmap(BitmapVoteList[(VoteOfs+1) mod LenPVL]);
  BitmapVoteList[(VoteOfs+1) mod LenPVL].SetSize(MainForm.PaintBox1.Width, MainForm.PaintBox1.Height);

  CleanBitmap(BitmapVoteList[VoteOfs]);
  BitmapVoteList[VoteOfs].SetSize(MainForm.PaintBox1.Width, MainForm.PaintBox1.Height);

  LoadPaintVote(PaintVoteList[0], BitmapVoteList[0]);
  LoadPaintVote(PaintVoteList[1], BitmapVoteList[1]);

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
  SetLength(PaintVoteList, LenPVL);
  SetLength(BallotList, LenPVL);

  PaintVoteList[0] := MainForm.PaintVote1;
  PaintVoteList[1] := MainForm.PaintVote2;

  //MainForm.PaintVote1.Enabled := false;
  BitmapVoteList[0] := TBitmap.Create;

  //MainForm.PaintVote2.Enabled := false;
  BitmapVoteList[1] := TBitmap.Create;

  CurrentOriginalNum := 0;
  ShowPanel(MainForm.pnlVote);
  NextPlayerVote;
end;

procedure CalculatePoints;
var
  i: Integer;
  Card: TCard;
begin

  for i := 0 to High(VoteCardsList) do
  begin
    Card := VoteCardsList[i];
    if Card.SelectedId > -1 then
    begin
      if Card.SelectedId = VoteOfs then
      begin
        Card.Player.Score := Card.Player.Score + 100;
      end
//      else
//      begin
//        Card.SelectedId
//      end;
    end;

  end;



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
