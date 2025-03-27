unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,

  // Мои юниты
  GameLogic, PanelsLogic, SetRulesLogic;

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
    Button3: TButton;
    ComboPlayers: TComboBox;
    ComboSeconds: TComboBox;
    pnlSetNames: TPanel;
    Button4: TButton;
    NameInput: TEdit;
    CurrentPrompt: TStaticText;
    CustomPB: TPanel;
    ProgressPB: TLabel;
    pnlWaitReady: TPanel;
    btnReady: TButton;
    txtReadyPlayer: TStaticText;
    txtAreReady: TStaticText;
    pnlVote: TPanel;
    PaintVote1: TPaintBox;
    StaticText1: TStaticText;
    Timer2: TTimer;
    PaintVote2: TPaintBox;
    PaintVote3: TPaintBox;
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
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnReadyClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
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
begin
//  CreateBitmap;
end;

procedure TMainForm.btnReadyClick(Sender: TObject);
begin
  PlayerIsReady;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  LoadPrompts;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  ShowPanel(pnlGame);
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  ShowPanel(pnlMenu);
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
  AddNewRules;
end;

procedure TMainForm.Button4Click(Sender: TObject);
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

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  GameTimer;
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
  RememberTimer;
end;

end.
