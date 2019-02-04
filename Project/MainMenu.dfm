object frmMainMenu: TfrmMainMenu
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Music Recommendation'
  ClientHeight = 610
  ClientWidth = 810
  Color = 13021861
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
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
  object shpEntryBackGroundLeft: TShape
    Left = 24
    Top = 136
    Width = 393
    Height = 441
    Brush.Color = 14471111
    Pen.Color = 14471111
    Shape = stRoundSquare
  end
  object shpEntryBackhroundRight: TShape
    Left = 448
    Top = 176
    Width = 337
    Height = 281
    Brush.Color = 14471111
    Pen.Color = 14471111
    Shape = stRoundSquare
  end
  object lblInstructionsRight1: TLabel
    Left = 504
    Top = 176
    Width = 220
    Height = 23
    Alignment = taCenter
    Anchors = []
    Caption = 'Would you like to recall a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -20
    Font.Name = 'Roboto Lt'
    Font.Style = []
    ParentFont = False
    Layout = tlBottom
  end
  object lblInstructionsLeft1: TLabel
    Left = 64
    Top = 176
    Width = 314
    Height = 23
    Alignment = taCenter
    Anchors = []
    Caption = 'Please enter 2 songs that you enjoy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -20
    Font.Name = 'Roboto Lt'
    Font.Style = []
    ParentFont = False
    Layout = tlBottom
  end
  object Label1: TLabel
    Left = 499
    Top = 206
    Width = 235
    Height = 23
    Alignment = taCenter
    Anchors = []
    Caption = 'previous recommendation?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -20
    Font.Name = 'Roboto Lt'
    Font.Style = []
    ParentFont = False
    Layout = tlBottom
  end
  object lblInstructionsLeft2: TLabel
    Left = 56
    Top = 206
    Width = 329
    Height = 23
    Alignment = taCenter
    Anchors = []
    Caption = 'and would like your recommendations'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -20
    Font.Name = 'Roboto Lt'
    Font.Style = []
    ParentFont = False
    Layout = tlBottom
  end
  object lblInstructionsLeft3: TLabel
    Left = 144
    Top = 236
    Width = 159
    Height = 23
    Alignment = taCenter
    Anchors = []
    Caption = 'to be based upon:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -20
    Font.Name = 'Roboto Lt'
    Font.Style = []
    ParentFont = False
    Layout = tlBottom
  end
  object Label2: TLabel
    Left = 528
    Top = 256
    Width = 188
    Height = 19
    Alignment = taCenter
    Anchors = []
    Caption = 'Enter the code given from'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -17
    Font.Name = 'Roboto Lt'
    Font.Style = []
    ParentFont = False
    Layout = tlBottom
  end
  object Label3: TLabel
    Left = 568
    Top = 282
    Width = 108
    Height = 19
    Alignment = taCenter
    Anchors = []
    Caption = 'your prior use:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -17
    Font.Name = 'Roboto Lt'
    Font.Style = []
    ParentFont = False
    Layout = tlBottom
  end
  object Label4: TLabel
    Left = 128
    Top = 403
    Width = 196
    Height = 23
    Alignment = taCenter
    Anchors = []
    Caption = 'And 1 song you dislike'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -20
    Font.Name = 'Roboto Lt'
    Font.Style = []
    ParentFont = False
    Layout = tlBottom
  end
  object edtSongEntry1: TEdit
    Left = 64
    Top = 266
    Width = 313
    Height = 32
    Color = 13021861
    Constraints.MinHeight = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object edtSongEntry3: TEdit
    Left = 65
    Top = 440
    Width = 313
    Height = 32
    Color = 13021861
    Constraints.MinHeight = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object edtSongEntry2: TEdit
    Left = 64
    Top = 336
    Width = 313
    Height = 32
    Color = 13021861
    Constraints.MinHeight = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtCodeEntry: TEdit
    Left = 504
    Top = 328
    Width = 225
    Height = 32
    Color = 13021861
    Constraints.MinHeight = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5123625
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object btnPriorUse: TButton
    Left = 584
    Top = 376
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Search'
    TabOrder = 4
  end
  object btnSongsSearch: TButton
    Left = 161
    Top = 494
    Width = 129
    Height = 35
    Cursor = crHandPoint
    Caption = 'Get Recommendations'
    TabOrder = 5
    OnClick = btnSongsSearchClick
  end
  object btnSettings: TButton
    Left = 704
    Top = 504
    Width = 50
    Height = 49
    Cursor = crHandPoint
    Caption = 'Settings'
    TabOrder = 6
    OnClick = btnSettingsClick
  end
  object Memo1: TMemo
    Left = 467
    Top = 471
    Width = 209
    Height = 115
    Lines.Strings = (
      'Memo1')
    TabOrder = 7
  end
  object RESTClient: TRESTClient
    Authenticator = OAuth2Authenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://api.spotify.com/v1'
    ContentType = 'application/json'
    Params = <>
    Left = 264
    Top = 8
  end
  object RESTIdRequest: TRESTRequest
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    AcceptEncoding = 'True'
    Client = RESTClient
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'pattern'
      end>
    Resource = 'v1/search?q='
    Response = RESTResponse
    Timeout = 0
    SynchronizedEvents = False
    Left = 320
    Top = 8
  end
  object RESTResponse: TRESTResponse
    ContentType = 'application/json'
    Left = 376
    Top = 8
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    AccessToken = 
      'BQDKun-BXfXDZGNerW57LVSzHLnpqEFFfTvi1uhli6Lbeb0-ip523jVwIrXQk8qH' +
      '4m8NffRjOR_SrSniVDcqHXDGPGKE9JrkpbOGadt9R_Ej1gbj0bfbqjEg4_b0JTar' +
      'zRt-ldnYrOBXDYUuJCUUwPd_2UbAaHTQAx72oQ'
    AuthCode = 
      'BQBeRDPUpb2Ionw35wbylOR7LsnrH83PJSc8V0Qy_9keuE-ttyJzNmGpbbSDgKC9' +
      '9ql6KrCjlGdJzGtlivq5fv2KSOPwk4Kc5H_0ccS-pwW1lJHisnBdS2Te_t5Z8rc1' +
      '-oe2jqGfmhH3m5il9pUH3IhEFmYKliXEs7lIUA'
    AuthorizationEndpoint = 'https://accounts.spotify.com/authorize'
    ClientID = 'e7b2c8f2ecf04736be11b1cb493cdd9d'
    ClientSecret = '39fbedb9146e440dae30c9b8a85fad61'
    RedirectionEndpoint = 'www.google.com'
    ResponseType = rtTOKEN
    Left = 64
    Top = 72
  end
  object tblSongProperties: TADOTable
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Proje' +
      'ct\Project\Projectdb.accdb;Persist Security Info=False'
    CursorType = ctStatic
    TableName = 'tblSongProperties'
    Left = 56
    Top = 8
  end
  object RESTPropertiesRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 440
    Top = 8
  end
  object tblChosenSongs: TADOTable
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Proje' +
      'ct\Project\Projectdb.accdb;Persist Security Info=False'
    CursorType = ctStatic
    TableName = 'tblChosenSongs'
    Left = 144
    Top = 8
  end
end
