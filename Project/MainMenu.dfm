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
  OnCreate = FormCreate
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
    Left = 528
    Top = 256
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
    Left = 568
    Top = 282
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
    Left = 169
    Top = 446
    Width = 129
    Height = 35
    Caption = 'Get Recommendations'
    TabOrder = 5
    OnClick = btnSongsSearchClick
  end
  object btnSettings: TButton
    Left = 704
    Top = 504
    Width = 50
    Height = 49
    Caption = 'Settings'
    TabOrder = 6
    OnClick = btnSettingsClick
  end
  object MemoContent: TMemo
    Left = 423
    Top = 472
    Width = 259
    Height = 105
    TabOrder = 7
  end
  object RESTClient: TRESTClient
    Authenticator = OAuth2Authenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://api.spotify.com/v1'
    ContentType = 'application/json'
    Params = <>
    HandleRedirects = True
    Left = 256
    Top = 16
  end
  object RESTIdRequest: TRESTRequest
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    AcceptEncoding = 'True'
    Client = RESTClient
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'pattern'
      end>
    Resource = 'v1/search?q='
    Response = RESTResponse
    Timeout = 0
    SynchronizedEvents = False
    Left = 312
    Top = 16
  end
  object RESTResponse: TRESTResponse
    ContentType = 'application/json'
    Left = 376
    Top = 16
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 28
    Top = 557
    object LinkControlToFieldContent: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = RESTResponse
      FieldName = 'Content'
      Control = MemoContent
      Track = False
    end
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    AccessToken = 
      'BQA96-zYmM4SeJXEokcOZG79ISnRYQasGIQFRkxMWocM03etCGPRLIO9VkUTyF1u' +
      'RCj_pSf1lKyODO6ugK2xpQWUWrOTQzt7SnobNthI-qaMsEHIcxfyBvbjwgQgwJmy' +
      'AkDh18lXzL3i-LFcKcmxlgr1NVXqfk6xUYsq5Q'
    AccessTokenEndpoint = 'https://accounts.spotify.com/api/token'
    AuthorizationEndpoint = 'https://accounts.spotify.com/authorize'
    ClientID = 'e7b2c8f2ecf04736be11b1cb493cdd9d'
    ClientSecret = '39fbedb9146e440dae30c9b8a85fad61'
    RedirectionEndpoint = 'www.google.com'
    ResponseType = rtTOKEN
    Left = 64
    Top = 72
  end
  object tblSongProperties: TADOTable
    Active = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Proje' +
      'ct\Project\Projectdb.accdb;Persist Security Info=False'
    CursorType = ctStatic
    TableName = 'tblSongProperties'
    Left = 56
    Top = 8
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 752
    Top = 16
  end
  object RESTPropertiesRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 456
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = tblSongProperties
    Left = 152
    Top = 72
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
