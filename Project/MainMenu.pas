unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

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
    procedure btnSongsSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

{$R *.dfm}

procedure TfrmMainMenu.btnSongsSearchClick(Sender: TObject);
var
  i: Integer;
  Song2,Song1,Song3: string;
begin
  Song1:=edtSongEntry1.Text;//More managable variable names
  Song2:=edtSongEntry2.Text;
  Song3:=edtSongEntry3.Text;


  //First Song
  Song1  := stringreplace(Song1, ' ', '+',[rfReplaceAll, rfIgnoreCase]);
  //Search cannot include spaces so replaces them with +
  RESTIdRequest.Params[0].Value:='search?type=track&q='+Song1;
  //Sets up the search parameters
  RESTIdRequest.Execute;//Runs the search
  showmessage(RESTIdRequest.Params[0].Value);//Dummy Test Stub   #


    //Second Song
  Song2  := stringreplace(Song2, ' ', '+',[rfReplaceAll, rfIgnoreCase]);
  //Search cannot include spaces so replaces them with +
  RESTIdRequest.Params[0].Value:='search?type=track&q='+Song2;
  //Sets up the search parameters
  RESTIdRequest.Execute;//Runs the search
  showmessage(RESTIdRequest.Params[0].Value);//Dummy Test Stub


    //Third Song
  Song3  := stringreplace(Song3, ' ', '+',[rfReplaceAll, rfIgnoreCase]);
  //Search cannot include spaces so replaces them with +
  RESTIdRequest.Params[0].Value:='search?type=track&q='+Song3;
  //Sets up the search parameters
  RESTIdRequest.Execute;//Runs the search
  showmessage(RESTIdRequest.Params[0].Value);//Dummy Test Stub
end;

end.
