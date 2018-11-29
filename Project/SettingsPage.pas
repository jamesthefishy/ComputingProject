unit SettingsPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmSettings = class(TForm)
    lblTitle: TLabel;
    btnBackToMenu: TButton;
    procedure btnBackToMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettings: TfrmSettings;

implementation

uses
 MainMenu;
{$R *.dfm}

procedure TfrmSettings.btnBackToMenuClick(Sender: TObject);
begin
frmSettings.hide;
frmMainMenu.Show;
end;

end.
