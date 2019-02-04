unit resultsPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Data.Win.ADODB, neuralnetwork;

type
  TfrmResultsPage = class(TForm)
    btnBackToMenu: TButton;
    grdProperties: TDBGrid;
    tblSongProperties: TADOTable;
    DataSource1: TDataSource;
    Memo1: TMemo;
    procedure btnBackToMenuClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

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

procedure TfrmResultsPage.FormShow(Sender: TObject);
var
  columnsTotal, i, recordstocheck: integer;
  confidence:real;
  topconfidencevalues:array[1..3] of real;
  topconfidenceids:array[1..3] of string;
  topconfidencenames:array[1..3] of string;
begin
  memo1.Clear;
  grdProperties.Enabled := True;
  columnsTotal := grdProperties.DataSource.DataSet.RecordCount;
  recordstocheck := round(columnsTotal * 0.37);
  DataSource1.DataSet.First;
  for i := 1 to recordstocheck do
  begin
    //showmessage(DataSource1.DataSet.FieldByName('ID').AsString);
    confidence:=neuralnetwork.songtest(DataSource1.DataSet.FieldByName('ID').AsString);
    grdProperties.DataSource.DataSet.Next;
    if confidence > topconfidencevalues[1] then
    begin
    topconfidencevalues[1]:=confidence;
    topconfidenceids[1]:=(DataSource1.DataSet.FieldByName('ID').AsString);
    topconfidencenames[1]:=(DataSource1.DataSet.FieldByName('Song Name').AsString);
    end
    else if confidence > topconfidencevalues[2] then
    begin
    topconfidencevalues[2]:=confidence;
    topconfidenceids[2]:=(DataSource1.DataSet.FieldByName('ID').AsString);
    topconfidencenames[2]:=(DataSource1.DataSet.FieldByName('Song Name').AsString);
    end
    else if confidence > topconfidencevalues[3] then
    begin
    topconfidencevalues[3]:=confidence;
    topconfidenceids[3]:=(DataSource1.DataSet.FieldByName('ID').AsString);
    topconfidencenames[3]:=(DataSource1.DataSet.FieldByName('Song Name').AsString);
    end;


  end;

  Memo1.lines.Add('1: '+ topconfidencenames[1] + ' - https://open.spotify.com/embed/track/'+topconfidenceids[1]
  +floattostr(topconfidencevalues[1]));
  Memo1.lines.Add('2: '+ topconfidencenames[2] + ' - https://open.spotify.com/embed/track/'+topconfidenceids[2]
  +floattostr(topconfidencevalues[2]));
  Memo1.lines.Add('3: '+ topconfidencenames[3] + ' - https://open.spotify.com/embed/track/'+topconfidenceids[3]
  +floattostr(topconfidencevalues[3]));

end;

end.
