unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,

  REST.Client,

  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.DB, Data.Win.ADODB,
  REST.Authenticator.OAuth,
  GlobalValues, ResultsPage, REST.Types, Data.Bind.Components,
  Data.Bind.ObjectScope, IPPeerClient, Vcl.WinXCtrls;

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
    RESTResponse: TRESTResponse;
    btnPriorUse: TButton;
    btnSongsSearch: TButton;
    btnSettings: TButton;
    OAuth2Authenticator1: TOAuth2Authenticator;
    tblSongProperties: TADOTable;
    RESTPropertiesRequest: TRESTRequest;
    tblChosenSongs: TADOTable;
    Label4: TLabel;
    tblRecommendedSongs: TADOTable;
    ActivityIndicator1: TActivityIndicator;

    procedure btnSongsSearchClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  backgroundprocess1 = class(TThread)
  private

  public

    procedure Execute(); override;

  end;

  backgroundprocess2 = class(TThread)
  private

  public

    procedure Execute(); override;

  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

uses
  Winapi.ShellApi, SettingsPage, neuralnetwork;

{$R *.dfm}

procedure backgroundprocess1.Execute();

begin
  neuralnetwork.train(SongID1, SongId2, SongId3);
      frmResultsPage.Show;
    frmMainMenu.Hide;

end;

procedure backgroundprocess2.Execute();
begin
  neuralnetwork.train(SongID1, SongId2, SongId3);
end;


procedure TfrmMainMenu.btnSongsSearchClick(Sender: TObject);
// Attempting to make it multithreaded due to the program crashing after long workload
var

  i, k: Integer;
  position, j: Integer;
  dbsendtempreal: real;
  flag: boolean;
  Song2, Song1, Song3, response, dbsendtemp: string;
  test: char;
  properties, dbfields: array of string;
begin
  properties := ['danceability', 'energy', 'speechiness', 'acousticness',
    'valence', 'tempo', 'time_signature'];
  dbfields := ['Danceability', 'Energy', 'Speechiness', 'Acousticness',
    'Valence', 'Tempo', 'Time Signature'];
  Song1 := frmMainMenu.edtSongEntry1.Text; // More managable variable names
  Song2 := frmMainMenu.edtSongEntry2.Text;
  Song3 := frmMainMenu.edtSongEntry3.Text;
  SongID1 := '';
  SongId2 := '';
  SongId3 := '';

  // First Song

  frmMainMenu.RESTIdRequest.Resource := '//search?q=' + Song1 +
    '&type=track&limit=1';
  // Sets up the search parameters
  frmMainMenu.RESTIdRequest.Execute; // Runs the search

  // The song ID is always followed by "is_local"
  // http://www.delphibasics.co.uk/RTL.asp?Name=ansipos
  position := ansipos('is_local', frmMainMenu.RESTResponse.Content);
  // Finds the position of the id

  response := frmMainMenu.RESTResponse.Content;

  for i := 0 to 21 do // Adds each character of the id to the string.
  begin
    test := response[(position - 32 + i)];
    // id starts 32 characters after the pos of 'is_local'
    SongID1 := SongID1 + test;
  end;
  // showmessage(SongId1);
  frmMainMenu.RESTPropertiesRequest.Resource := 'audio-features/' + SongID1;

  // Requests the audio features of the song.
  frmMainMenu.RESTPropertiesRequest.Execute;
  // End of Requests for song 1
  // Send To database

  frmMainMenu.tblSongProperties.Open;

  if (frmMainMenu.tblSongProperties.Locate('ID', SongID1, []) = False) then
  begin
    frmMainMenu.tblSongProperties.Edit;
    frmMainMenu.tblSongProperties.Insert;

    // Only adds to song properties table if not already there

    frmMainMenu.tblSongProperties.FieldByName('ID').AsString := SongID1;
    frmMainMenu.tblSongProperties.FieldByName('Song Name').AsString := Song1;

    for i := 0 to 5 do
    begin
      dbsendtemp := '';
      response := frmMainMenu.RESTResponse.Content;
      // showmessage(properties[i]);
      position := ansipos(properties[i], response);
      // showmessage(inttostr(position));
      k := length(properties[i]);
      j := 0;
      repeat
        dbsendtemp := dbsendtemp + response[position + j + k + 4];
        j := j + 1;
      until (response[position + j + k + 4] = ',') or
        (response[position + j + k + 4] = '}');
      // showmessage(dbsendtemp);
      dbsendtempreal := strtofloat(dbsendtemp);
      // showmessage(dbfields[i]);
      if strtofloat(dbsendtemp) <> 0 then
      begin
        frmMainMenu.tblSongProperties.FieldByName(dbfields[i]).AsFloat :=
          dbsendtempreal;
      end
      else
        flag := True

    end;
    //showmessage(frmMainMenu.RESTResponse.Content);
    if flag = False then
    begin
      try
        frmMainMenu.tblSongProperties.Post;
        //showmessage('song 1 success');

      except
        showmessage('Error Writing to the song properties table');

      end;
    end
    else
      showmessage('There is a problem with one of your search terms');

  end;

  frmMainMenu.tblSongProperties.Close;
  flag := False;










  // SECOND Song

  frmMainMenu.RESTIdRequest.Resource := '//search?q=' + Song2 +
    '&type=track&limit=1';
  // Sets up the search parameters
  frmMainMenu.RESTIdRequest.Execute; // Runs the search
  // The song ID is always followed by "is_local"
  position := ansipos('is_local', frmMainMenu.RESTResponse.Content);
  // Finds the position of the id
  response := frmMainMenu.RESTResponse.Content;
  for i := 0 to 21 do // Adds each character of the id to the string.
  begin
    test := response[(position - 32 + i)];
    // id starts 32 characters after the pos of 'is_local'
    SongId2 := SongId2 + test;
  end;
  // showmessage(SongId2);
  frmMainMenu.RESTPropertiesRequest.Resource := 'audio-features/' + SongId2;
  // Requests the audio features of the song.
  frmMainMenu.RESTPropertiesRequest.Execute;
  // End of Requests for song 1
  // Send To database

  frmMainMenu.tblSongProperties.Open;
  if (frmMainMenu.tblSongProperties.Locate('ID', SongId2, []) = False) then
  begin // Only adds to song properties table if not already there

    frmMainMenu.tblSongProperties.Edit;
    frmMainMenu.tblSongProperties.Insert;
    frmMainMenu.tblSongProperties.FieldByName('ID').AsString := SongId2;
    frmMainMenu.tblSongProperties.FieldByName('Song Name').AsString := Song2;

    for i := 0 to 5 do
    begin
      dbsendtemp := '';
      response := frmMainMenu.RESTResponse.Content;
      // showmessage(properties[i]);
      position := ansipos(properties[i], response);
      // showmessage(inttostr(position));
      k := length(properties[i]);
      j := 0;
      repeat
        dbsendtemp := dbsendtemp + response[position + j + k + 4];
        j := j + 1;
      until (response[position + j + k + 4] = ',') or
        (response[position + j + k + 4] = '}');
      // showmessage(dbsendtemp);
      dbsendtempreal := strtofloat(dbsendtemp);
      // showmessage(dbfields[i]);
      if strtofloat(dbsendtemp) <> 0 then
      begin
        frmMainMenu.tblSongProperties.FieldByName(dbfields[i]).AsFloat :=
          dbsendtempreal;
      end
      else
        flag := True

    end;
    //showmessage(frmMainMenu.RESTResponse.Content);
    if flag = False then
    begin
      try
        frmMainMenu.tblSongProperties.Post;
        //showmessage('song 2 success');
      except
        showmessage('Error Writing to the song properties table');

      end;
    end
    else
      showmessage('There is a problem with one of your search terms');

  end;
  frmMainMenu.tblSongProperties.Close;
  flag := False;



  // THIRD Song

  frmMainMenu.RESTIdRequest.Resource := '//search?q=' + Song3 +
    '&type=track&limit=1';
  // Sets up the search parameters
  frmMainMenu.RESTIdRequest.Execute; // Runs the search
  // The song ID is always followed by "is_local"
  // http://www.delphibasics.co.uk/RTL.asp?Name=ansipos
  position := ansipos('is_local', frmMainMenu.RESTResponse.Content);
  // Finds the position of the id
  response := frmMainMenu.RESTResponse.Content;
  for i := 0 to 21 do // Adds each character of the id to the string.
  begin
    test := response[(position - 32 + i)];
    // id starts 32 characters after the pos of 'is_local'
    SongId3 := SongId3 + test;
  end;
  // showmessage(SongID3);
  frmMainMenu.RESTPropertiesRequest.Resource := 'audio-features/' + SongId3;
  // Requests the audio features of the song.
  frmMainMenu.RESTPropertiesRequest.Execute;
  // End of Requests for song 2
  // Send To database
  frmMainMenu.tblSongProperties.Open;

  if (frmMainMenu.tblSongProperties.Locate('ID', SongId3, []) = False) then
  begin // Only adds to song properties table if not already there

    frmMainMenu.tblSongProperties.Edit;
    frmMainMenu.tblSongProperties.Insert;
    //showmessage(frmMainMenu.RESTResponse.Content);
    frmMainMenu.tblSongProperties.FieldByName('ID').AsString := SongId3;
    frmMainMenu.tblSongProperties.FieldByName('Song Name').AsString := Song3;

    for i := 0 to 5 do
    begin
      dbsendtemp := '';
      response := frmMainMenu.RESTResponse.Content;
      // showmessage(properties[i]);
      position := ansipos(properties[i], response);
      // showmessage(inttostr(position));
      k := length(properties[i]);
      j := 0;
      repeat
        dbsendtemp := dbsendtemp + response[position + j + k + 4];
        j := j + 1;
      until (response[position + j + k + 4] = ',') or
        (response[position + j + k + 4] = '}');
      // showmessage(dbsendtemp);
      dbsendtempreal := strtofloat(dbsendtemp);
      // showmessage(dbfields[i]);
      if strtofloat(dbsendtemp) <> 0 then
      begin
        frmMainMenu.tblSongProperties.FieldByName(dbfields[i]).AsFloat :=
          dbsendtempreal;
      end
      else
        flag := True

    end;
    //showmessage(frmMainMenu.RESTResponse.Content);
    if flag = False then
    begin
      try
        frmMainMenu.tblSongProperties.Post;
        //showmessage('song 3 success');
      except
        showmessage('Error Writing to the song properties table');

      end;
    end
    else
      showmessage('There is a problem with one of your search terms');

    frmMainMenu.tblSongProperties.Close;
  end;
  flag := False;
  frmMainMenu.tblChosenSongs.Open;
  frmMainMenu.tblChosenSongs.Edit;
  frmMainMenu.tblChosenSongs.Insert;

  frmMainMenu.tblChosenSongs.FieldByName('Song1ID').AsString := SongID1;
  frmMainMenu.tblChosenSongs.FieldByName('Song2ID').AsString := SongId2;
  frmMainMenu.tblChosenSongs.FieldByName('Song3ID').AsString := SongId3;
  try
    frmMainMenu.tblChosenSongs.Post;

    // Background thread to prevent crash
    backgroundprocess1.Create(False);


  except
    showmessage('Error with the chosen songs table');
  end;

end;

procedure TfrmMainMenu.btnSettingsClick(Sender: TObject);
begin
  frmSettings.Show;
  frmMainMenu.Hide;
end;

procedure TfrmMainMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TfrmMainMenu.FormCreate(Sender: TObject);
begin
  tblChosenSongs.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\james\Desktop\Project\ProjectDB.accdb;Persist Security Info=False';
  tblSongProperties.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\james\Desktop\Project\ProjectDB.accdb;Persist Security Info=False';


   //Connection string at home vs at school
   //tblChosenSongs.ConnectionString :=
   //'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Project\Project\Projectdb.accdb;Persist Security Info=False';
   //tblSongProperties.ConnectionString :=
   //'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Project\Project\Projectdb.accdb;Persist Security Info=False';


end;

end.
