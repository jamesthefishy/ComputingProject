unit resultsPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmResultsPage = class(TForm)
    btnBackToMenu: TButton;
    procedure btnBackToMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmResultsPage: TfrmResultsPage;

implementation

uses mainmenu;

{$R *.dfm}

procedure TfrmResultsPage.btnBackToMenuClick(Sender: TObject);
begin

  frmMainmenu.Show;
  frmResultsPage.hide;

end;

end.
