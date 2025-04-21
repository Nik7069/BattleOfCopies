unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,

  // Мои юниты
  GameLogic, PanelsLogic, SetRulesLogic, VoteLogic, Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    pnlGame: TPanel;
    PaintBox1: TPaintBox;
    pnlMenu: TPanel;
    btnStart: TButton;
    pnlSetRules: TPanel;
    btnSetRules: TButton;
    ComboPlayers: TComboBox;
    ComboSeconds: TComboBox;
    pnlSetNames: TPanel;
    btnSetName: TButton;
    NameInput: TEdit;
    CurrentPrompt: TStaticText;
    CustomPB: TPanel;
    ProgressPB: TLabel;
    pnlWaitReady: TPanel;
    btnReady: TButton;
    txtReadyPlayer: TStaticText;
    txtAreReady: TStaticText;
    pnlVote: TPanel;
    txtPromptVote: TStaticText;
    Timer2: TTimer;
    PaintVote1: TPaintBox;
    PaintVote2: TPaintBox;
    btnEndVote: TButton;
    fpVoteUsers: TFlowPanel;
    fpPaintVote1: TFlowPanel;
    fpPaintVote2: TFlowPanel;
    lbPlayersHint: TLabel;
    lbSecondsHint: TLabel;
    lbPlayerNum: TLabel;
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnSetRulesClick(Sender: TObject);
    procedure btnSetNameClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnReadyClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure btnEndVoteClick(Sender: TObject);
    procedure PaintVote1Paint(Sender: TObject);
    procedure PaintVote2Paint(Sender: TObject);
    procedure ToSelectCardClick(Sender: TObject);
    procedure PaintVoteClick(Sender: TObject);
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
    for i := 3 to 8 do
      ComboPlayers.Items.Add(IntToStr(i));
  end;
  ComboPlayers.ItemIndex := 0;


  begin
    for i := 2 to 12 do
      ComboSeconds.Items.Add(IntToStr(i*10));
  end;
  ComboSeconds.ItemIndex := 4;




end;

procedure TMainForm.ToSelectCardClick(Sender: TObject);
begin
  SelectCard(Sender);
end;

procedure TMainForm.btnEndVoteClick(Sender: TObject);
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
  ShowPanel(pnlSetRules);
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  ShowPanel(pnlGame);
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  ShowPanel(pnlMenu);
end;

procedure TMainForm.btnSetRulesClick(Sender: TObject);
begin
  AddNewRules;
end;

procedure TMainForm.btnSetNameClick(Sender: TObject);
begin
  AddNewPlayer;
end;

procedure TMainForm.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PaintMouseDown(X, Y);
end;

procedure TMainForm.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PaintMouseMove(X, Y);
end;

procedure TMainForm.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PaintMouseUp;
end;

procedure TMainForm.PaintBox1Paint(Sender: TObject);
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

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  GameTimer;
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
  RememberTimer;
end;

end.
