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
  IdHTTP, IdTCPConnection, IdTCPClient, System.JSON, REST.Types;

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
    MemoContent: TMemo;
    LinkControlToFieldContent: TLinkControlToField;
    BindingsList1: TBindingsList;
    OAuth2Authenticator1: TOAuth2Authenticator;
    tblSongProperties: TADOTable;
    ADOQuery1: TADOQuery;
    RESTPropertiesRequest: TRESTRequest;
    DataSource1: TDataSource;
    tblChosenSongs: TADOTable;
    procedure btnSongsSearchClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

uses
  Winapi.ShellApi, SettingsPage, neuralnetwork;

{$R *.dfm}

procedure TfrmMainMenu.btnSettingsClick(Sender: TObject);
begin
  frmSettings.Show;
  frmMainMenu.Hide;
end;

procedure TfrmMainMenu.btnSongsSearchClick(Sender: TObject);
var
  i, k: Integer;
  // Jsonvariables
  position, j: Integer;
  dbsendtempreal: real;
  flag: boolean;
  Song2, SongId1, SongID2, SongID3, Song1, Song3, response, dbsendtemp: string;
  test: char;
  properties, dbfields: array of string;
begin
  properties := ['danceability', 'energy', 'speechiness', 'acousticness',
    'valence', 'tempo', 'time_signature'];
  dbfields := ['Danceability', 'Energy', 'Speechiness', 'Acousticness',
    'Valence', 'Tempo', 'Time Signature'];
  Song1 := edtSongEntry1.Text; // More managable variable names
  Song2 := edtSongEntry2.Text;
  Song3 := edtSongEntry3.Text;
  SongId1 := '';
  SongID2 := '';
  SongID3 := '';

  // First Song

  RESTIdRequest.Resource := '//search?q=' + Song1 + '&type=track&limit=1';
  // Sets up the search parameters
  RESTIdRequest.Execute; // Runs the search

  // The song ID is always followed by "is_local"
  // http://www.delphibasics.co.uk/RTL.asp?Name=ansipos
  position := ansipos('is_local', RESTResponse.Content);
  // Finds the position of the id

  response := RESTResponse.Content;

  for i := 0 to 21 do // Adds each character of the id to the string.
  begin
    test := response[(position - 32 + i)];
    // id starts 32 characters after the pos of 'is_local'
    SongId1 := SongId1 + test;
  end;
  // showmessage(SongId1);
  RESTPropertiesRequest.Resource := 'audio-features/' + SongId1;

  // Requests the audio features of the song.
  RESTPropertiesRequest.Execute;
  // End of Requests for song 1
  // Send To database

  tblSongProperties.Open;

  if (tblSongProperties.Locate('ID', SongId1, []) = False) then
  begin
    tblSongProperties.Edit;
    tblSongProperties.Insert;

    // Only adds to song properties table if not already there

    tblSongProperties.FieldByName('ID').AsString := SongId1;
    tblSongProperties.FieldByName('Song Name').AsString := Song1;

    for i := 0 to 5 do
    begin
      dbsendtemp := '';
      response := RESTResponse.Content;
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
        tblSongProperties.FieldByName(dbfields[i]).AsFloat := dbsendtempreal;
      end
      else
        flag := True

    end;
    showmessage(RESTResponse.Content);
    if flag = False then
    begin
      try
        tblSongProperties.Post;
        showmessage('song 1 success');
      except
        showmessage('Error Writing to the song properties table');

      end;
    end
    else
      showmessage('There is a problem with one of your search terms');

  end;
  tblSongProperties.Close;
  flag := False;

  // SECOND Song

  RESTIdRequest.Resource := '//search?q=' + Song2 + '&type=track&limit=1';
  // Sets up the search parameters
  RESTIdRequest.Execute; // Runs the search
  // The song ID is always followed by "is_local"
  position := ansipos('is_local', RESTResponse.Content);
  // Finds the position of the id
  response := RESTResponse.Content;
  for i := 0 to 21 do // Adds each character of the id to the string.
  begin
    test := response[(position - 32 + i)];
    // id starts 32 characters after the pos of 'is_local'
    SongID2 := SongID2 + test;
  end;
  // showmessage(SongId2);
  RESTPropertiesRequest.Resource := 'audio-features/' + SongID2;
  // Requests the audio features of the song.
  RESTPropertiesRequest.Execute;
  // End of Requests for song 1
  // Send To database

  tblSongProperties.Open;
  if (tblSongProperties.Locate('ID', SongID2, []) = False) then
  begin // Only adds to song properties table if not already there

    tblSongProperties.Edit;
    tblSongProperties.Insert;
    tblSongProperties.FieldByName('ID').AsString := SongID2;
    tblSongProperties.FieldByName('Song Name').AsString := Song2;

    for i := 0 to 5 do
    begin
      dbsendtemp := '';
      response := RESTResponse.Content;
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
        tblSongProperties.FieldByName(dbfields[i]).AsFloat := dbsendtempreal;
      end
      else
        flag := True

    end;
    showmessage(RESTResponse.Content);
    if flag = False then
    begin
      try
        tblSongProperties.Post;
        showmessage('song 1 success');
      except
        showmessage('Error Writing to the song properties table');

      end;
    end
    else
      showmessage('There is a problem with one of your search terms');

  end;
  tblSongProperties.Close;
  flag := False;



  // THIRD Song

  RESTIdRequest.Resource := '//search?q=' + Song3 + '&type=track&limit=1';
  // Sets up the search parameters
  RESTIdRequest.Execute; // Runs the search
  // The song ID is always followed by "is_local"
  // http://www.delphibasics.co.uk/RTL.asp?Name=ansipos
  position := ansipos('is_local', RESTResponse.Content);
  // Finds the position of the id
  response := RESTResponse.Content;
  for i := 0 to 21 do // Adds each character of the id to the string.
  begin
    test := response[(position - 32 + i)];
    // id starts 32 characters after the pos of 'is_local'
    SongID3 := SongID3 + test;
  end;
  showmessage(SongID3);
  RESTPropertiesRequest.Resource := 'audio-features/' + SongID3;
  // Requests the audio features of the song.
  RESTPropertiesRequest.Execute;
  // End of Requests for song 2
  // Send To database
  tblSongProperties.Open;

  if (tblSongProperties.Locate('ID', SongID3, []) = False) then
  begin // Only adds to song properties table if not already there

    tblSongProperties.Edit;
    tblSongProperties.Insert;
    showmessage(RESTResponse.Content);
    tblSongProperties.FieldByName('ID').AsString := SongID3;
    tblSongProperties.FieldByName('Song Name').AsString := Song3;

    for i := 0 to 5 do
    begin
      dbsendtemp := '';
      response := RESTResponse.Content;
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
        tblSongProperties.FieldByName(dbfields[i]).AsFloat := dbsendtempreal;
      end
      else
        flag := True

    end;
    showmessage(RESTResponse.Content);
    if flag = False then
    begin
      try
        tblSongProperties.Post;
        showmessage('song 1 success');
      except
        showmessage('Error Writing to the song properties table');

      end;
    end
    else
      showmessage('There is a problem with one of your search terms');




    tblSongProperties.Close;
  end;
  flag := False;
  tblChosenSongs.Open;
  tblChosenSongs.Edit;
  tblChosenSongs.Insert;

  tblChosenSongs.FieldByName('Song1ID').AsString := SongId1;
  tblChosenSongs.FieldByName('Song2ID').AsString := SongID2;
  tblChosenSongs.FieldByName('Song3ID').AsString := SongID3;
  try
    tblChosenSongs.Post;
  except
    showmessage('Error with the chosen songs table');
  end;
end;

procedure TfrmMainMenu.FormCreate(Sender: TObject);
begin
  { tblChosenSongs.ConnectionString:='Provider=Microsoft.ACE.OLEDB.16.0;Data Source=C:\Users\james\Desktop\ComputingProject-master\Projec\ProjectDB.accdb;Persist Security Info=False';
    tblSongProperties.ConnectionString:='Provider=Microsoft.ACE.OLEDB.16.0;Data Source=C:\Users\james\Desktop\ComputingProject-master\Projec\ProjectDB.accdb;Persist Security Info=False';
  }

  // Connection string at home vs at school
  tblChosenSongs.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Project\Project\Projectdb.accdb;Persist Security Info=False';
  tblSongProperties.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=N:\Computing Project\Project\Projectdb.accdb;Persist Security Info=False';

end;

end.
