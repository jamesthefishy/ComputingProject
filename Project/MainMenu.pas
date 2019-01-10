unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.DB, Data.Win.ADODB, REST.Authenticator.OAuth,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer, IdContext, Soap.InvokeRegistry, Soap.Rio, Soap.SOAPHTTPClient,
  IdHTTP, IdTCPConnection, IdTCPClient, System.JSON, REST.Types, Vcl.ComCtrls,
  GlobalValues;

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
    DataSource1: TDataSource;
    tblChosenSongs: TADOTable;
    Label4: TLabel;
    Memo1: TMemo;

    procedure btnSongsSearchClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);


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
neuralnetwork.train(SongID1,SongId2,SongId3);
end;

procedure backgroundprocess2.Execute();
begin
neuralnetwork.train(SongID1,SongId2,SongId3);
end;


procedure TfrmMainMenu.btnSongsSearchClick(Sender: TObject); //Attempting to make it multithreaded due to the program crashing after long workload
var
  i, k: Integer;
  position, j: Integer;
  dbsendtempreal: real;
  flag: boolean;
  Song2, Song1, Song3, response, dbsendtemp: string;
  SongId1, SongID2, SongID3: string;
  test: char;
  properties, dbfields: array of string;
begin
  properties := ['danceability', 'energy', 'speechiness', 'acousticness',
    'valence', 'tempo', 'time_signature'];
  dbfields := ['Danceability', 'Energy', 'Speechiness', 'Acousticness',
    'Valence', 'Tempo', 'Time Signature'];
  Song1 := frmMainmenu.edtSongEntry1.Text; // More managable variable names
  Song2 := frmMainmenu.edtSongEntry2.Text;
  Song3 := frmMainmenu.edtSongEntry3.Text;
  SongId1 := '';
  SongID2 := '';
  SongID3 := '';

  // First Song

  frmMainmenu.RESTIdRequest.Resource := '//search?q=' + Song1 + '&type=track&limit=1';
  // Sets up the search parameters
  frmMainmenu.RESTIdRequest.Execute; // Runs the search

  // The song ID is always followed by "is_local"
  // http://www.delphibasics.co.uk/RTL.asp?Name=ansipos
  position := ansipos('is_local', frmMainmenu.RESTResponse.Content);
  // Finds the position of the id

  response := frmMainmenu.RESTResponse.Content;

  for i := 0 to 21 do // Adds each character of the id to the string.
  begin
    test := response[(position - 32 + i)];
    // id starts 32 characters after the pos of 'is_local'
    SongId1 := SongId1 + test;
  end;
  // showmessage(SongId1);
  frmMainmenu.RESTPropertiesRequest.Resource := 'audio-features/' + SongId1;

  // Requests the audio features of the song.
  frmMainmenu.RESTPropertiesRequest.Execute;
  // End of Requests for song 1
  // Send To database

  frmMainmenu.tblSongProperties.Open;

  if (frmMainmenu.tblSongProperties.Locate('ID', SongId1, []) = False) then
  begin
    frmMainmenu.tblSongProperties.Edit;
    frmMainmenu.tblSongProperties.Insert;

    // Only adds to song properties table if not already there

    frmMainmenu.tblSongProperties.FieldByName('ID').AsString := SongId1;
    frmMainmenu.tblSongProperties.FieldByName('Song Name').AsString := Song1;

    for i := 0 to 5 do
    begin
      dbsendtemp := '';
      response := frmMainmenu.RESTResponse.Content;
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
        frmMainmenu.tblSongProperties.FieldByName(dbfields[i]).AsFloat := dbsendtempreal;
      end
      else
        flag := True

    end;
    showmessage(frmMainmenu.RESTResponse.Content);
    if flag = False then
    begin
      try
        frmMainmenu.tblSongProperties.Post;
        showmessage('song 1 success');

      except
        showmessage('Error Writing to the song properties table');

      end;
    end
    else
      showmessage('There is a problem with one of your search terms');

  end;

  frmMainmenu.tblSongProperties.Close;
  flag := False;










  // SECOND Song

  frmMainmenu.RESTIdRequest.Resource := '//search?q=' + Song2 + '&type=track&limit=1';
  // Sets up the search parameters
  frmMainmenu.RESTIdRequest.Execute; // Runs the search
  // The song ID is always followed by "is_local"
  position := ansipos('is_local', frmMainmenu.RESTResponse.Content);
  // Finds the position of the id
  response := frmMainmenu.RESTResponse.Content;
  for i := 0 to 21 do // Adds each character of the id to the string.
  begin
    test := response[(position - 32 + i)];
    // id starts 32 characters after the pos of 'is_local'
    SongID2 := SongID2 + test;
  end;
  // showmessage(SongId2);
  frmMainmenu.RESTPropertiesRequest.Resource := 'audio-features/' + SongID2;
  // Requests the audio features of the song.
  frmMainmenu.RESTPropertiesRequest.Execute;
  // End of Requests for song 1
  // Send To database

  frmMainmenu.tblSongProperties.Open;
  if (frmMainmenu.tblSongProperties.Locate('ID', SongID2, []) = False) then
  begin // Only adds to song properties table if not already there

    frmMainmenu.tblSongProperties.Edit;
    frmMainmenu.tblSongProperties.Insert;
    frmMainmenu.tblSongProperties.FieldByName('ID').AsString := SongID2;
    frmMainmenu.tblSongProperties.FieldByName('Song Name').AsString := Song2;

    for i := 0 to 5 do
    begin
      dbsendtemp := '';
      response := frmMainmenu.RESTResponse.Content;
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
        frmMainmenu.tblSongProperties.FieldByName(dbfields[i]).AsFloat := dbsendtempreal;
      end
      else
        flag := True

    end;
    showmessage(frmMainmenu.RESTResponse.Content);
    if flag = False then
    begin
      try
        frmMainmenu.tblSongProperties.Post;
        showmessage('song 2 success');
      except
        showmessage('Error Writing to the song properties table');

      end;
    end
    else
      showmessage('There is a problem with one of your search terms');

  end;
  frmMainmenu.tblSongProperties.Close;
  flag := False;



  // THIRD Song

  frmMainmenu.RESTIdRequest.Resource := '//search?q=' + Song3 + '&type=track&limit=1';
  // Sets up the search parameters
  frmMainmenu.RESTIdRequest.Execute; // Runs the search
  // The song ID is always followed by "is_local"
  // http://www.delphibasics.co.uk/RTL.asp?Name=ansipos
  position := ansipos('is_local', frmMainmenu.RESTResponse.Content);
  // Finds the position of the id
  response := frmMainmenu.RESTResponse.Content;
  for i := 0 to 21 do // Adds each character of the id to the string.
  begin
    test := response[(position - 32 + i)];
    // id starts 32 characters after the pos of 'is_local'
    SongID3 := SongID3 + test;
  end;
  //showmessage(SongID3);
  frmMainmenu.RESTPropertiesRequest.Resource := 'audio-features/' + SongID3;
  // Requests the audio features of the song.
  frmMainmenu.RESTPropertiesRequest.Execute;
  // End of Requests for song 2
  // Send To database
  frmMainmenu.tblSongProperties.Open;

  if (frmMainmenu.tblSongProperties.Locate('ID', SongID3, []) = False) then
  begin // Only adds to song properties table if not already there

    frmMainmenu.tblSongProperties.Edit;
    frmMainmenu.tblSongProperties.Insert;
    showmessage(frmMainmenu.RESTResponse.Content);
    frmMainmenu.tblSongProperties.FieldByName('ID').AsString := SongID3;
    frmMainmenu.tblSongProperties.FieldByName('Song Name').AsString := Song3;

    for i := 0 to 5 do
    begin
      dbsendtemp := '';
      response := frmMainmenu.RESTResponse.Content;
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
        frmMainmenu.tblSongProperties.FieldByName(dbfields[i]).AsFloat := dbsendtempreal;
      end
      else
        flag := True

    end;
    showmessage(frmMainmenu.RESTResponse.Content);
    if flag = False then
    begin
      try
        frmMainmenu.tblSongProperties.Post;
        showmessage('song 3 success');
      except
        showmessage('Error Writing to the song properties table');

      end;
    end
    else
      showmessage('There is a problem with one of your search terms');

    frmMainmenu.tblSongProperties.Close;
  end;
  flag := False;
  frmMainmenu.tblChosenSongs.Open;
  frmMainmenu.tblChosenSongs.Edit;
  frmMainmenu.tblChosenSongs.Insert;

  frmMainmenu.tblChosenSongs.FieldByName('Song1ID').AsString := SongId1;
  frmMainmenu.tblChosenSongs.FieldByName('Song2ID').AsString := SongID2;
  frmMainmenu.tblChosenSongs.FieldByName('Song3ID').AsString := SongID3;
  try
    frmMainmenu.tblChosenSongs.Post;

    //Threading test:

    backgroundprocess1.Create(False);
    //neuralnetwork.train(SongId1,SongId2,SongId3);
  except
    showmessage('Error with the chosen songs table');
  end;

end;

procedure TfrmMainMenu.btnSettingsClick(Sender: TObject);
begin
  frmSettings.Show;
  frmMainMenu.Hide;
end;


procedure TfrmMainMenu.FormCreate(Sender: TObject);
begin
//tblChosenSongs.ConnectionString:='Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\james\Documents\GitHub\ComputingProject\Project\ProjectDB.accdb;Persist Security Info=False';
//tblSongProperties.ConnectionString:='Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\james\Documents\GitHub\ComputingProject\Project\ProjectDB.accdb;Persist Security Info=False';


  // Connection string at home vs at school
  tblChosenSongs.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Project\Project\Projectdb.accdb;Persist Security Info=False';
  tblSongProperties.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Project\Project\Projectdb.accdb;Persist Security Info=False';

end;

end.



