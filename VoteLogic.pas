unit VoteLogic;

interface

//uses
  //Winapi.Windows, Vcl.Graphics;

procedure VoteStart;
procedure CalculatePoints;
procedure LoadPaintVote1;
procedure LoadPaintVote2;

var
  IsVoting: boolean = false;

implementation

uses
  Main, PanelsLogic, SetRulesLogic, Vcl.ExtCtrls, Vcl.Graphics, GameLogic;

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



procedure NextPlayerVote;
var
  i: Integer;
begin

  CurrentOriginal := PlayersList[CurrentOriginalNum];
  MainForm.txtPromptVote.Caption := CurrentOriginal.Prompt;

  VoteOfs := Random(LenPVL);

  BitmapVoteList[VoteOfs].Assign(CurrentOriginal.BitmapOrig);
  BitmapVoteList[(VoteOfs+1) mod LenPVL].Assign(PlayersList[CurrentOriginal.copyid].BitmapCopy);

  LoadPaintVote1;
  LoadPaintVote2;

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
