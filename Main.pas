unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,

  // Мои юниты
  GameLogic, PanelsLogic, SetRulesLogic, VoteLogic, Vcl.ComCtrls, Vcl.Grids;

const
  MinPlayers = 3;
  MaxPlayers = 8;
  MinSeconds = 10;
  MaxSeconds = 120;

type
  TMainForm = class(TForm)
    tGame: TTimer;
    btnBack: TButton;
    btnFinish: TButton;
    pnlGame: TPanel;
    pbDraw: TPaintBox;
    pnlMenu: TPanel;
    btnStart: TButton;
    pnlSetRules: TPanel;
    btnSetRules: TButton;
    ComboPlayers: TComboBox;
    ComboSeconds: TComboBox;
    pnlSetNames: TPanel;
    btnSetName: TButton;
    NameInput: TEdit;
    txtCurrentPrompt: TStaticText;
    CustomPB: TPanel;
    ProgressPB: TLabel;
    pnlWaitReady: TPanel;
    btnReady: TButton;
    txtReadyPlayer: TStaticText;
    txtAreReady: TStaticText;
    pnlVote: TPanel;
    txtPromptVote: TStaticText;
    PaintVote1: TPaintBox;
    PaintVote2: TPaintBox;
    btnEndVote: TButton;
    fpVoteUsers: TFlowPanel;
    fpPaintVote1: TFlowPanel;
    fpPaintVote2: TFlowPanel;
    lbPlayersHint: TLabel;
    lbSecondsHint: TLabel;
    lbPlayerNum: TLabel;
    txtCurrentPromptTemp: TStaticText;
    txtPaintHint: TStaticText;
    spnlSetRules: TPanel;
    spnlSetNames: TPanel;
    spnlWaitReady: TPanel;
    txtOrigOrCopyPV1: TStaticText;
    txtOrigOrCopyPV2: TStaticText;
    pnlWinTable: TPanel;
    fpWinTable: TFlowPanel;
    txtEndOfGame: TStaticText;
    spnlWinTable: TPanel;
    txtExitToMenu: TButton;
    procedure pbDrawMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbDrawMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbDrawMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure btnBackClick(Sender: TObject);
    procedure btnFinishClick(Sender: TObject);
    procedure pbDrawPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnSetRulesClick(Sender: TObject);
    procedure btnSetNameClick(Sender: TObject);
    procedure tGameTimer(Sender: TObject);
    procedure btnReadyClick(Sender: TObject);
    procedure btnShowOrigAndCopyClick(Sender: TObject);
    procedure btnCalculatePointsClick(Sender: TObject);
    procedure PaintVote1Paint(Sender: TObject);
    procedure PaintVote2Paint(Sender: TObject);
    procedure ToSelectCardClick(Sender: TObject);
    procedure PaintVoteClick(Sender: TObject);
    procedure txtExitToMenuClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses PointConverter;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
//  CreateBitmap;
  Randomize;

  begin
    for i := MinPlayers to MaxPlayers do
      ComboPlayers.Items.Add(IntToStr(i));
  end;
  ComboPlayers.ItemIndex := 0;


  begin
    for i := MinSeconds div 10 to MaxSeconds div 10 do
      ComboSeconds.Items.Add(IntToStr(i*10));
  end;
  ComboSeconds.ItemIndex := 4;




end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Ord('Z')) and (ssCtrl in Shift) then
  begin
    SetUndoBitmap;
  end;
end;

procedure TMainForm.ToSelectCardClick(Sender: TObject);
begin
  SelectCard(Sender);
end;

procedure TMainForm.txtExitToMenuClick(Sender: TObject);
begin
  ShowPanel(MainForm.pnlMenu);
end;

procedure TMainForm.btnShowOrigAndCopyClick(Sender: TObject);
begin
  ShowOrigAndCopy;
end;

procedure TMainForm.btnCalculatePointsClick(Sender: TObject);
begin
  CalculatePoints;
end;

procedure TMainForm.btnReadyClick(Sender: TObject);
begin
  PlayerIsReady;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  LoadPrompts;
end;

procedure TMainForm.btnBackClick(Sender: TObject);
begin
  SetUndoBitmap;
end;

procedure TMainForm.btnFinishClick(Sender: TObject);
begin
  pbTime := -1;
end;

procedure TMainForm.btnSetRulesClick(Sender: TObject);
begin
  AddNewRules;
end;

procedure TMainForm.btnSetNameClick(Sender: TObject);
begin
  AddNewPlayer;
end;

procedure TMainForm.pbDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PaintMouseDown(X, Y);
end;

procedure TMainForm.pbDrawMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PaintMouseMove(X, Y);
end;

procedure TMainForm.pbDrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PaintMouseUp;
end;

procedure TMainForm.pbDrawPaint(Sender: TObject);
begin
  LoadPaint;
end;

procedure TMainForm.PaintVoteClick(Sender: TObject);
begin
  PaintVoteSelect(Sender);
end;

procedure TMainForm.PaintVote1Paint(Sender: TObject);
begin
  LoadPaintVote(BallotList[0].PaintVote, BallotList[0].Bitmap);
end;

procedure TMainForm.PaintVote2Paint(Sender: TObject);
begin
  LoadPaintVote(BallotList[1].PaintVote, BallotList[1].Bitmap);
end;

procedure TMainForm.tGameTimer(Sender: TObject);
begin
  GameTimer;
end;

end.
