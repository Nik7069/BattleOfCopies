unit PanelsLogic;

interface

uses
  Vcl.ExtCtrls;

procedure ShowPanel(Panel: TPanel);

implementation

uses Main;

procedure ShowPanel(Panel: TPanel);
begin
  // All panels
  MainForm.pnlGame.Visible := False;
  MainForm.pnlMenu.Visible := False;
  MainForm.pnlSetRules.Visible := False;
  MainForm.pnlSetNames.Visible := False;
  MainForm.pnlWaitReady.Visible := False;
  MainForm.pnlVote.Visible := False;
  MainForm.pnlWinTable.Visible := False;



  Panel.Visible := True;
  Panel.BringToFront;
end;

end.
