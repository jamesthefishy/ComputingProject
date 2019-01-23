unit resultsPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Data.Win.ADODB,neuralnetwork;

type
  TfrmResultsPage = class(TForm)
    btnBackToMenu: TButton;
    grdProperties: TDBGrid;
    tblSongProperties: TADOTable;
    DataSource1: TDataSource;
    procedure btnBackToMenuClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);

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
procedure TfrmResultsPage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
application.Terminate;
end;

procedure TfrmResultsPage.FormCreate(Sender: TObject);
var
columnsTotal,i,recordstocheck:integer;

begin
grdProperties.Enabled:=True;
columnsTotal:=grdProperties.DataSource.DataSet.RecordCount;
recordstocheck:=round(columnsTotal*0.37);

for i := 1 to recordstocheck do
begin
  DataSource1.DataSet.First;
  showmessage(floattostr(neuralnetwork.songtest(DataSource1.DataSet.FieldByName('ID').AsString)));
  dataSource1.DataSet.Next;

end;
end;




end.
