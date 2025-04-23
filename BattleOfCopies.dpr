program BattleOfCopies;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  PointConverter in 'PointConverter.pas',
  GameLogic in 'GameLogic.pas',
  PanelsLogic in 'PanelsLogic.pas',
  SetRulesLogic in 'SetRulesLogic.pas',
  VoteLogic in 'VoteLogic.pas',
  WinLogic in 'WinLogic.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
