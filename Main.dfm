object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object pnlMenu: TPanel
    Left = -17
    Top = 0
    Width = 641
    Height = 441
    BevelOuter = bvNone
    Caption = 'PanelMenu'
    ShowCaption = False
    TabOrder = 1
    object btnStart: TButton
      Left = 288
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
  end
  object pnlSetRules: TPanel
    Left = -17
    Top = 0
    Width = 641
    Height = 441
    BevelOuter = bvNone
    Caption = 'PanelMenu'
    ShowCaption = False
    TabOrder = 2
    Visible = False
    object Button3: TButton
      Left = 288
      Top = 360
      Width = 75
      Height = 25
      Caption = 'Launch'
      TabOrder = 0
      OnClick = Button3Click
    end
    object ComboPlayers: TComboBox
      Left = 288
      Top = 160
      Width = 145
      Height = 23
      ItemIndex = 0
      TabOrder = 1
      Text = '3'
      Items.Strings = (
        '3'
        '4'
        '5'
        '6'
        '7'
        '8')
    end
    object ComboSeconds: TComboBox
      Left = 288
      Top = 224
      Width = 145
      Height = 23
      ItemIndex = 0
      TabOrder = 2
      Text = '60'
      Items.Strings = (
        '60'
        '120'
        '180')
    end
  end
  object pnlSetNames: TPanel
    Left = -17
    Top = 0
    Width = 641
    Height = 441
    BevelOuter = bvNone
    Caption = 'PanelSetNames'
    ShowCaption = False
    TabOrder = 3
    Visible = False
    object Button4: TButton
      Left = 288
      Top = 360
      Width = 75
      Height = 25
      Caption = 'Launch'
      TabOrder = 0
      OnClick = Button4Click
    end
    object NameInput: TEdit
      Left = 264
      Top = 200
      Width = 121
      Height = 23
      TabOrder = 1
      TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1087#1089#1077#1074#1076#1086#1085#1080#1084
    end
  end
  object pnlGame: TPanel
    Left = 0
    Top = 0
    Width = 641
    Height = 441
    BevelOuter = bvNone
    Caption = 'PanelGame'
    ShowCaption = False
    TabOrder = 0
    Visible = False
    DesignSize = (
      641
      441)
    object PaintBox1: TPaintBox
      Left = 48
      Top = 72
      Width = 417
      Height = 289
      OnMouseDown = PaintBox1MouseDown
      OnMouseMove = PaintBox1MouseMove
      OnMouseUp = PaintBox1MouseUp
      OnPaint = PaintBox1Paint
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
    object CurrentPrompt: TStaticText
      Left = 208
      Top = 32
      Width = 84
      Height = 19
      Caption = 'CurrentPrompt'
      TabOrder = 2
    end
    object CustomPB: TPanel
      Left = 120
      Top = 391
      Width = 400
      Height = 30
      Anchors = []
      BevelOuter = bvNone
      Color = clCream
      Ctl3D = True
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 3
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
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 520
    Top = 32
  end
end
