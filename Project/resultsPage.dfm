object frmResultsPage: TfrmResultsPage
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'frmResultsPage'
  ClientHeight = 610
  ClientWidth = 810
  Color = 13021861
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnBackToMenu: TButton
    Left = 675
    Top = 528
    Width = 94
    Height = 49
    Cursor = crHandPoint
    Caption = 'Home'
    Style = bsCommandLink
    TabOrder = 0
    OnClick = btnBackToMenuClick
  end
  object grdProperties: TDBGrid
    Left = 216
    Top = 160
    Width = 417
    Height = 369
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object tblSongProperties: TADOTable
    Active = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Proje' +
      'ct\Project\Projectdb.accdb;Persist Security Info=False'
    CursorType = ctStatic
    TableName = 'tblSongProperties'
    Left = 424
    Top = 72
  end
  object DataSource1: TDataSource
    DataSet = tblSongProperties
    Left = 600
    Top = 88
  end
end
