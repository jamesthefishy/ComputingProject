object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'frmSettings'
  ClientHeight = 610
  ClientWidth = 810
  Color = 13021861
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = OnShow
  DesignSize = (
    810
    610)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    Left = 205
    Top = 49
    Width = 440
    Height = 45
    Alignment = taCenter
    Anchors = []
    Caption = 'Song Suggestion Service'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -40
    Font.Name = 'Roboto Lt'
    Font.Style = []
    ParentFont = False
    Layout = tlBottom
  end
  object lblAccessCodeInstruct: TLabel
    Left = 205
    Top = 120
    Width = 414
    Height = 13
    Caption = 
      'From the webpage that is loaded when this was opened copy the co' +
      'de as seen below:'
  end
  object btnBackToMenu: TButton
    Left = 683
    Top = 528
    Width = 78
    Height = 49
    Cursor = crHandPoint
    Caption = 'Back'
    Style = bsCommandLink
    TabOrder = 0
    OnClick = btnBackToMenuClick
  end
  object edtAccessCodeEntry: TEdit
    Left = 209
    Top = 192
    Width = 410
    Height = 21
    TabOrder = 1
    Text = 'edtAccessCodeEntry'
  end
  object btnAccessCodeSubmit: TButton
    Left = 368
    Top = 232
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Submit'
    TabOrder = 2
    OnClick = btnAccessCodeSubmitClick
  end
end
