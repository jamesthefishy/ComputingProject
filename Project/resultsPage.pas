unit resultsPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Data.Win.ADODB, neuralnetwork, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, globalvalues;

type
  TfrmResultsPage = class(TForm)
    btnBackToMenu: TButton;
    tblSongProperties: TADOTable;
    DataSource1: TDataSource;
    tblSongRecommendations: TADOTable;
    grdProperties: TDBGrid;
    lblCaption1: TLabel;
    lblReturnCode: TLabel;
    lblTitle: TLabel;
    shpEntryBackGroundLeft: TShape;
    lblSong1Name: TLabel;
    lblSong2Name: TLabel;
    lblSong3Name: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    DBGrid1: TDBGrid;
    DataSource2: TDataSource;
    procedure btnBackToMenuClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmResultsPage: TfrmResultsPage;

implementation

uses mainmenu, Winapi.ShellApi;

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
  topconfidenceids: array [1 .. 3] of string;
  columnsTotal, i, recordstocheck: integer;
  confidence: real;
  topconfidencevalues: array [1 .. 3] of real;
  topconfidencenames: array [1 .. 4] of string;
begin

  if recallflag = False then
  begin
    grdProperties.Enabled := True;
    columnsTotal := grdProperties.DataSource.DataSet.RecordCount;
    recordstocheck := round(columnsTotal * 0.88);
    DataSource1.DataSet.First;
    for i := 1 to recordstocheck do
    begin
      // showmessage(DataSource1.DataSet.FieldByName('ID').AsString);
      confidence := neuralnetwork.songtest(DataSource1.DataSet.FieldByName('ID')
        .AsString); // runs procedure to find confidence value
      grdProperties.DataSource.DataSet.Next;
      if confidence > topconfidencevalues[1] then
      begin
        topconfidencevalues[1] := confidence;
        topconfidenceids[1] := (DataSource1.DataSet.FieldByName('ID').AsString);
        topconfidencenames[1] := (DataSource1.DataSet.FieldByName('Song Name')
          .AsString);
      end
      else if confidence > topconfidencevalues[2] then
      begin
        topconfidencevalues[2] := confidence;
        topconfidenceids[2] := (DataSource1.DataSet.FieldByName('ID').AsString);
        topconfidencenames[2] := (DataSource1.DataSet.FieldByName('Song Name')
          .AsString);
      end
      else if confidence > topconfidencevalues[3] then
      begin
        topconfidencevalues[3] := confidence;
        topconfidenceids[3] := (DataSource1.DataSet.FieldByName('ID').AsString);
        topconfidencenames[3] := (DataSource1.DataSet.FieldByName('Song Name')
          .AsString);
      end;
      // Above finds top 3 confidence values

    end;

    lblSong1Name.Caption := ('1: ' + topconfidencenames[1]);
    // Updates the UI to feature recommended songs
    lblSong2Name.Caption := ('2: ' + topconfidencenames[2]);
    lblSong3Name.Caption := ('3: ' + topconfidencenames[3]);

    tblSongRecommendations.Open;
    showmessage('1');
    tblSongRecommendations.Edit;
    showmessage('2');
    tblSongRecommendations.Insert;
    showmessage('3');
    tblSongRecommendations.FieldByName('Song1ID').AsString :=
      topconfidenceids[1];
    showmessage('4');

    tblSongRecommendations.FieldByName('Song2ID').AsString :=
      topconfidenceids[2];
    showmessage('5');
    tblSongRecommendations.FieldByName('Song3ID').AsString :=
      topconfidenceids[3];
    showmessage('6');
    try
      tblSongRecommendations.Post;
      // Table for recalling users recommended songs
      showmessage('7');
    except
      showmessage('Error with the recommended songs table');
    end;
    lblReturnCode.Caption := inttostr(tblSongRecommendations.RecordCount);
    // updates the user to give a number to be able to recall their recommendations
    tblSongRecommendations.Close;
    globalvalues.SongId1 := topconfidenceids[1];

    globalvalues.playSongId2 := topconfidenceids[2];

    globalvalues.playSongId3 := topconfidenceids[3];

  end

  else // only runs when the user is recalling past results
  begin
    DataSource2.DataSet.First;    //Locates the correct entry in the database
    for i := 1 to strtoint(frmMainmenu.edtCodeEntry.Text) do
    begin
      DataSource2.DataSet.Next;
    end;

    topconfidencenames[1] := DataSource2.DataSet.FieldByName('Song1Id')
      .AsString;   //Gets the Id required
    topconfidencenames[2] := DataSource2.DataSet.FieldByName('Song2Id')
      .AsString;       //Gets the Id required
    topconfidencenames[3] := DataSource2.DataSet.FieldByName('Song3Id')
      .AsString;    //Gets the Id required

      globalvalues.SongId1 := topconfidenceids[1];

    globalvalues.playSongId2 := topconfidenceids[2];

    globalvalues.playSongId3 := topconfidenceids[3];


    lblReturnCode.Caption := frmMainmenu.edtCodeEntry.Text;
    lblSong1Name.Caption := ('1: ' + topconfidencenames[1]);
    // Updates the UI to feature recommended songs
    lblSong2Name.Caption := ('2: ' + topconfidencenames[2]);
    lblSong3Name.Caption := ('3: ' + topconfidencenames[3]);

    //Sets up the play buttons to open the correct page on click
  end;

end;

procedure TfrmResultsPage.Image1Click(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('https://open.spotify.com/embed/track/' +
    globalvalues.SongId1), '', '', SW_SHOWNORMAL);
  // Opens the spotify page of the song
end;

procedure TfrmResultsPage.Image2Click(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('https://open.spotify.com/embed/track/' +
    globalvalues.playSongId2), '', '', SW_SHOWNORMAL);
  // Opens the spotify page of the song
end;

procedure TfrmResultsPage.Image3Click(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('https://open.spotify.com/embed/track/' +
    globalvalues.playSongId3), '', '', SW_SHOWNORMAL);
  // Opens the spotify page of the song
end;

end.
