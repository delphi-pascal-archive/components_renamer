object FDepart: TFDepart
  Left = 255
  Top = 130
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Components Renamer'
  ClientHeight = 354
  ClientWidth = 603
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 66
    Height = 16
    Caption = 'Source file:'
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 137
    Height = 16
    Caption = 'Available components:'
  end
  object Label3: TLabel
    Left = 176
    Top = 64
    Width = 134
    Height = 16
    Caption = 'Selected components:'
  end
  object LB_Dispo2: TListBox
    Left = 20
    Top = 98
    Width = 301
    Height = 199
    Hint = 'Clic droit pour s'#1081'lectionner'
    ItemHeight = 16
    MultiSelect = True
    ParentShowHint = False
    ShowHint = True
    Sorted = True
    TabOrder = 8
    Visible = False
    OnMouseDown = LB_DispoMouseDown
  end
  object LB_Dispo: TListBox
    Left = 8
    Top = 88
    Width = 161
    Height = 257
    Hint = 'Clic droit pour s'#1081'lectionner'
    ItemHeight = 16
    MultiSelect = True
    ParentShowHint = False
    ShowHint = True
    Sorted = True
    TabOrder = 1
    OnMouseDown = LB_DispoMouseDown
  end
  object LB_Sel: TListBox
    Left = 176
    Top = 88
    Width = 161
    Height = 217
    Hint = 
      'Clic droit pour supprimer '#13#10'NB : Les composants sont renomm'#1081's da' +
      'ns l'#39'ordre de la liste'#13#10'CRTL + Up ou CTRL + Down Pour les organi' +
      'ser'
    ItemHeight = 16
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnKeyDown = LB_SelKeyDown
    OnMouseDown = LB_SelMouseDown
  end
  object ED_FicheEC: TEdit
    Left = 8
    Top = 32
    Width = 441
    Height = 25
    TabOrder = 0
  end
  object BTN_Search: TBitBtn
    Left = 456
    Top = 32
    Width = 33
    Height = 25
    Cursor = crHandPoint
    Caption = '...'
    TabOrder = 7
    OnClick = BTN_SearchClick
  end
  object BTN_Quitter: TBitBtn
    Left = 344
    Top = 320
    Width = 249
    Height = 25
    Cursor = crHandPoint
    Caption = 'Exit'
    TabOrder = 4
    OnClick = BTN_QuitterClick
  end
  object BTN_Ouvrir: TBitBtn
    Left = 496
    Top = 32
    Width = 97
    Height = 26
    Cursor = crHandPoint
    Caption = 'Open'
    TabOrder = 5
    OnClick = BTN_OuvrirClick
  end
  object BTN_Vider: TBitBtn
    Left = 176
    Top = 320
    Width = 161
    Height = 25
    Cursor = crHandPoint
    Caption = 'Clear'
    TabOrder = 6
    OnClick = BTN_ViderClick
  end
  object GroupBox1: TGroupBox
    Left = 344
    Top = 80
    Width = 249
    Height = 153
    Caption = ' Components rename '
    TabOrder = 3
    object Label4: TLabel
      Left = 16
      Top = 32
      Width = 36
      Height = 16
      Caption = 'Prefix:'
    end
    object Label5: TLabel
      Left = 16
      Top = 64
      Width = 51
      Height = 16
      Caption = 'Number:'
    end
    object ED_Pref: TEdit
      Left = 80
      Top = 24
      Width = 153
      Height = 25
      TabOrder = 0
    end
    object ED_Num: TEdit
      Left = 80
      Top = 56
      Width = 153
      Height = 25
      TabOrder = 1
      Text = '1'
      OnKeyPress = ED_NumKeyPress
    end
    object CKB_svg: TCheckBox
      Left = 16
      Top = 88
      Width = 217
      Height = 17
      Hint = 
        'Une sauvegarde du fichier est enregistr'#1081' dans le sous dossier "S' +
        'VG" de l'#39'application'
      Caption = 'Make a backup'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 2
    end
    object BTN_Ren: TButton
      Left = 16
      Top = 113
      Width = 217
      Height = 24
      Cursor = crHandPoint
      Caption = 'Rename'
      TabOrder = 3
      OnClick = BTN_RenClick
    end
  end
  object BTN_SVG: TButton
    Left = 344
    Top = 280
    Width = 249
    Height = 25
    Cursor = crHandPoint
    Caption = 'Saving'
    TabOrder = 9
    OnClick = BTN_SVGClick
  end
  object BTN_Proj: TButton
    Left = 344
    Top = 246
    Width = 249
    Height = 27
    Cursor = crHandPoint
    Caption = 'Project documents'
    TabOrder = 10
    OnClick = BTN_ProjClick
  end
  object OD_PAS: TOpenDialog
    FileName = '*.pas'
    Left = 88
    Top = 16
  end
end
