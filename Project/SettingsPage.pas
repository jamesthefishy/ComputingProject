unit SettingsPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmSettings = class(TForm)
    lblTitle: TLabel;
    btnBackToMenu: TButton;
    edtAccessCodeEntry: TEdit;
    lblAccessCodeInstruct: TLabel;
    btnAccessCodeSubmit: TButton;
    procedure btnBackToMenuClick(Sender: TObject);
    procedure OnShow(Sender: TObject);
    procedure btnAccessCodeSubmitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettings: TfrmSettings;

implementation

uses
 MainMenu,Winapi.ShellApi;
{$R *.dfm}

procedure TfrmSettings.btnAccessCodeSubmitClick(Sender: TObject);
begin
FrmMainMenu.OAuth2Authenticator1.AccessToken:= edtAccessCodeEntry.Text;
end;

procedure TfrmSettings.btnBackToMenuClick(Sender: TObject);
begin
frmSettings.hide;
frmMainMenu.Show;
end;

procedure TfrmSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;

end;

procedure TfrmSettings.OnShow(Sender: TObject);
begin
//Self.OAuth2Authenticator1.AccessToken:=
ShellExecute(0, 'OPEN', PChar('https://accounts.spotify.com/authorize?client_id=e7b2c8f2ecf04736be11b1cb493cdd9d&redirect_uri=http://localhost:9090/&scope=user-read-private%20user-read-email&response_type=token&state=123'), '', '', SW_SHOWNORMAL);

end;

end.
