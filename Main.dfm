object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 507
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object pnlVote: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 507
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanelVote'
    ShowCaption = False
    TabOrder = 5
    Visible = False
    ExplicitWidth = 623
    ExplicitHeight = 490
    object PaintVote1: TPaintBox
      Left = 59
      Top = 72
      Width = 210
      Height = 297
      Color = clBtnFace
      ParentColor = False
      OnClick = PaintVoteClick
      OnPaint = PaintVote1Paint
    end
    object PaintVote2: TPaintBox
      Left = 361
      Top = 72
      Width = 210
      Height = 297
      OnClick = PaintVoteClick
      OnPaint = PaintVote2Paint
    end
    object txtPromptVote: TStaticText
      Left = 280
      Top = 32
      Width = 84
      Height = 19
      Caption = 'CurrentPrompt'
      TabOrder = 0
    end
    object btnEndVote: TButton
      Left = 280
      Top = 329
      Width = 75
      Height = 25
      Caption = 'End vote'
      TabOrder = 1
      OnClick = btnEndVoteClick
    end
    object fpVoteUsers: TFlowPanel
      Left = 59
      Top = 439
      Width = 512
      Height = 50
      BevelOuter = bvNone
      TabOrder = 2
    end
    object fpPaintVote1: TFlowPanel
      Left = 59
      Top = 375
      Width = 215
      Height = 50
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 3
    end
    object fpPaintVote2: TFlowPanel
      Left = 361
      Top = 375
      Width = 215
      Height = 50
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 4
    end
  end
  object pnlMenu: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 507
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanelMenu'
    ShowCaption = False
    TabOrder = 1
    ExplicitWidth = 623
    ExplicitHeight = 490
    object btnStart: TButton
      Left = 267
      Top = 229
      Width = 88
      Height = 25
      Caption = #1053#1072#1095#1072#1090#1100' '#1080#1075#1088#1091
      TabOrder = 0
      OnClick = btnStartClick
    end
  end
  object pnlSetRules: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 507
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanelMenu'
    ShowCaption = False
    TabOrder = 2
    Visible = False
    ExplicitWidth = 623
    ExplicitHeight = 490
    object lbPlayersHint: TLabel
      Left = 161
      Top = 163
      Width = 116
      Height = 15
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1080#1075#1088#1086#1082#1086#1074':'
    end
    object lbSecondsHint: TLabel
      Left = 93
      Top = 229
      Width = 186
      Height = 15
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1077#1082#1091#1085#1076' '#1085#1072' '#1088#1080#1089#1086#1074#1072#1085#1080#1077':'
    end
    object btnSetRules: TButton
      Left = 240
      Top = 312
      Width = 115
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100' '#1087#1088#1072#1074#1080#1083#1072
      TabOrder = 0
      OnClick = btnSetRulesClick
    end
    object ComboPlayers: TComboBox
      Left = 288
      Top = 160
      Width = 78
      Height = 23
      TabOrder = 1
      Text = '3'
    end
    object ComboSeconds: TComboBox
      Left = 288
      Top = 224
      Width = 78
      Height = 23
      TabOrder = 2
      Text = '60'
    end
  end
  object pnlSetNames: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 507
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanelSetNames'
    ShowCaption = False
    TabOrder = 3
    Visible = False
    ExplicitWidth = 623
    ExplicitHeight = 490
    object lbPlayerNum: TLabel
      Left = 232
      Top = 155
      Width = 197
      Height = 38
      Alignment = taCenter
      AutoSize = False
      Caption = #1048#1075#1088#1086#1082' '#8470' [1/3]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -28
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnSetName: TButton
      Left = 282
      Top = 273
      Width = 91
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100' '#1080#1084#1103
      TabOrder = 0
      OnClick = btnSetNameClick
    end
    object NameInput: TEdit
      Left = 267
      Top = 224
      Width = 121
      Height = 23
      TabOrder = 1
      TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1087#1089#1077#1074#1076#1086#1085#1080#1084
    end
  end
  object pnlWaitReady: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 507
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanelWaitReady'
    ShowCaption = False
    TabOrder = 4
    Visible = False
    ExplicitWidth = 623
    ExplicitHeight = 490
    object btnReady: TButton
      Left = 288
      Top = 360
      Width = 75
      Height = 25
      Caption = 'Im ready!'
      TabOrder = 0
      OnClick = btnReadyClick
    end
    object txtReadyPlayer: TStaticText
      Left = 75
      Top = 134
      Width = 504
      Height = 49
      Alignment = taCenter
      AutoSize = False
      Caption = 'Player'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object txtAreReady: TStaticText
      Left = 288
      Top = 199
      Width = 85
      Height = 19
      Caption = 'Are you ready?!'
      TabOrder = 2
    end
  end
  object pnlGame: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 507
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanelGame'
    ShowCaption = False
    TabOrder = 0
    Visible = False
    ExplicitWidth = 623
    ExplicitHeight = 490
    DesignSize = (
      629
      507)
    object pbDraw: TPaintBox
      Left = 207
      Top = 57
      Width = 210
      Height = 297
      OnMouseDown = pbDrawMouseDown
      OnMouseMove = pbDrawMouseMove
      OnMouseUp = pbDrawMouseUp
      OnPaint = pbDrawPaint
    end
    object Button2: TButton
      Left = 496
      Top = 232
      Width = 75
      Height = 25
      Caption = 'Button2'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 496
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 1
      OnClick = Button1Click
    end
    object txtCurrentPrompt: TStaticText
      Left = 207
      Top = 24
      Width = 210
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'CurrentPrompt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object CustomPB: TPanel
      Left = 115
      Top = 452
      Width = 400
      Height = 30
      Anchors = []
      BevelOuter = bvNone
      Color = clWhite
      Ctl3D = True
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 3
      ExplicitLeft = 112
      ExplicitTop = 436
      object ProgressPB: TLabel
        Left = 0
        Top = 0
        Width = 400
        Height = 30
        Alignment = taCenter
        AutoSize = False
        BiDiMode = bdRightToLeft
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        Transparent = False
        WordWrap = True
      end
    end
    object txtCurrentPromptTemp: TStaticText
      Left = 161
      Top = 177
      Width = 304
      Height = 112
      Alignment = taCenter
      AutoSize = False
      Caption = 'CurrentPrompt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -28
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object txtPaintHint: TStaticText
      Left = 48
      Top = 375
      Width = 523
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'Hint'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
  object tGame: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tGameTimer
    Left = 552
    Top = 8
  end
end
