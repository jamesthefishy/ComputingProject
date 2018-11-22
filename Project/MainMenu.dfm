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
  DesignSize = (
    810
    610)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    Left = 205
    Top = 49
    Width = 437
    Height = 48
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
    Top = 128
    Width = 393
    Height = 441
    Brush.Color = 14471111
    Pen.Color = 14471111
    Shape = stRoundSquare
  end
  object shpEntryBackhroundRight: TShape
    Left = 448
    Top = 160
    Width = 337
    Height = 281
    Brush.Color = 14471111
    Pen.Color = 14471111
    Shape = stRoundSquare
  end
  object lblInstructionsRight1: TLabel
    Left = 504
    Top = 176
    Width = 219
    Height = 24
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
    Width = 309
    Height = 24
    Alignment = taCenter
    Anchors = []
    Caption = 'Please enter 3 songs that you enjoy'
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
    Width = 239
    Height = 24
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
    Width = 335
    Height = 24
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
    Width = 154
    Height = 24
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
    Left = 520
    Top = 280
    Width = 187
    Height = 20
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
    Left = 560
    Top = 302
    Width = 105
    Height = 20
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
    Left = 64
    Top = 392
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
    Top = 328
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
    Caption = 'Search'
    TabOrder = 4
  end
  object btnSongsSearch: TButton
    Left = 160
    Top = 446
    Width = 129
    Height = 35
    Caption = 'Get Recommendations'
    TabOrder = 5
    OnClick = btnSongsSearchClick
  end
  object btnSettings: TButton
    Left = 688
    Top = 504
    Width = 50
    Height = 49
    Caption = 'Settings'
    TabOrder = 6
  end
  object MemoContent: TMemo
    Left = 311
    Top = 487
    Width = 320
    Height = 82
    TabOrder = 7
  end
  object RESTClient: TRESTClient
    Authenticator = OAuth2Authenticator1
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    BaseURL = 'https://api.spotify.com/v1/search'
    ContentType = 'json/application'
    Params = <>
    HandleRedirects = True
    Left = 728
    Top = 16
  end
  object RESTIdRequest: TRESTRequest
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    Client = RESTClient
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'pattern'
      end>
    Resource = 'v1/search'
    Response = RESTResponse1
    Timeout = 0
    SynchronizedEvents = False
    Left = 728
    Top = 72
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json, application/json'
    Left = 728
    Top = 120
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 28
    Top = 557
    object LinkControlToFieldContent: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = RESTResponse1
      FieldName = 'Content'
      Control = MemoContent
      Track = False
    end
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    AccessToken = 
      'BQBSkQYXwS2Qiomdt5FMpBha--OzQKC3i-wmSKhT0Ie1F2m2EK66i2MqJCSUslfZ' +
      'vnkvo0bZ50XEaP_tSrY_EutWHKjX5OvcolwOmoP1cp8Px7HNeX1lMkkKi-mxCjNt' +
      'bUyNs_MeCjRVkUBmwP9RZQnfqMNgGCTL'
    AccessTokenEndpoint = 'https://accounts.spotify.com/api/token'
    AuthorizationEndpoint = 'https://accounts.spotify.com/authorize'
    ClientID = 'd986b0d4e2640a4a4d6d0d82e25e567'
    ClientSecret = 'e73b70f7489f40649ca2b7b7eddf0232'
    RedirectionEndpoint = 'www.google.com'
    Left = 624
    Top = 104
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Proje' +
      'ct\Project\Projectdb.accdb;Persist Security Info=False'
    TableName = 'tblChosenSongs'
    Left = 32
    Top = 24
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 96
    Top = 24
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    Left = 80
    Top = 104
  end
end
