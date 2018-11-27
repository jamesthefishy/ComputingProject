unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.DB, Data.Win.ADODB, REST.Authenticator.OAuth,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer;

type
  TfrmMainMenu = class(TForm)
    lblTitle: TLabel;
    shpEntryBackGroundLeft: TShape;
    shpEntryBackhroundRight: TShape;
    edtSongEntry1: TEdit;
    edtSongEntry3: TEdit;
    edtSongEntry2: TEdit;
    edtCodeEntry: TEdit;
    lblInstructionsRight1: TLabel;
    lblInstructionsLeft1: TLabel;
    Label1: TLabel;
    lblInstructionsLeft2: TLabel;
    lblInstructionsLeft3: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RESTClient: TRESTClient;
    RESTIdRequest: TRESTRequest;
    RESTResponse1: TRESTResponse;
    btnPriorUse: TButton;
    btnSongsSearch: TButton;
    btnSettings: TButton;
    MemoContent: TMemo;
    LinkControlToFieldContent: TLinkControlToField;
    BindingsList1: TBindingsList;
    OAuth2Authenticator1: TOAuth2Authenticator;
    ADOTable1: TADOTable;
    ADOQuery1: TADOQuery;
    IdHTTPServer1: TIdHTTPServer;
    procedure btnSongsSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

  uses
  Winapi.ShellApi;

{$R *.dfm}

procedure TfrmMainMenu.btnSongsSearchClick(Sender: TObject);
var
  i: Integer;
  Song2,Song1,Song3: string;
begin
  Song1:=edtSongEntry1.Text;//More managable variable names
  Song2:=edtSongEntry2.Text;
  Song3:=edtSongEntry3.Text;
//  Self.OAuth2Authenticator1.AccessToken:=
  ShellExecute(0, 'OPEN', PChar('https://accounts.spotify.com/authorize?client_id=e7b2c8f2ecf04736be11b1cb493cdd9d&redirect_uri=http://example.com/callback/&scope=user-read-private%20user-read-email&response_type=token&state=123'), '', '', SW_SHOWNORMAL);


  //First Song
  Song1  := stringreplace(Song1, ' ', '+',[rfReplaceAll, rfIgnoreCase]);
  //Search cannot include spaces so replaces them with +
  RESTIdRequest.Params[0].Value:='?type=track&q='+Song1;    //removed search?type=track&q= to test
  //Sets up the search parameters
  RESTIdRequest.Execute;//Runs the search
  showmessage(RESTIdRequest.Params[0].Value);//Dummy Test Stub   #




  {  //Second Song
  Song2  := stringreplace(Song2, ' ', '+',[rfReplaceAll, rfIgnoreCase]);
  //Search cannot include spaces so replaces them with +
  RESTIdRequest.Params[0].Value:=Song2;    //removed search?type=track&q= to test
  //Sets up the search parameters
  RESTIdRequest.Execute;//Runs the search
  showmessage(RESTIdRequest.Params[0].Value);//Dummy Test Stub


    //Third Song
  Song3  := stringreplace(Song3, ' ', '+',[rfReplaceAll, rfIgnoreCase]);
  //Search cannot include spaces so replaces them with +
  RESTIdRequest.Params[0].Value:=Song3;    //removed search?type=track&q= to test
  //Sets up the search parameters
  RESTIdRequest.Execute;//Runs the search
  showmessage(RESTIdRequest.Params[0].Value);//Dummy Test Stub
  }
  end;

end.
