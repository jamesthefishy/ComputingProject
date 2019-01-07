unit neuralnetwork;

interface

procedure train(songID1, SongId2, SongId3: string);
function sigmoid(inputvalue: real): real;

implementation

uses Mainmenu, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants,
  System.Classes, Vcl.Graphics, dialogs, math;





// ==============================================================================
function sigmoid(inputvalue: real): real;
// This function takes the input value and converts it into a decimal
// value in the range 0 to 1 no matter the input value (Logistic function)
begin
  result := (1 / (1 + (Power(exp(1.0), (-inputvalue)))));
end;
// Will use this so normalise the values returned by neural networks
// 1 being a desired value and 0 suggesting no correlation
// ==============================================================================





// ==============================================================================
procedure train(songID1, SongId2, SongId3: string);
var
  i, j, k, l, m: integer;
  inputlayer, hiddenlayer1: array [0 .. 6] of real;
  biasmask1: array [0 .. 48] of real;
  hiddenlayer2: array [0 .. 2] of real;
  biasmask2: array [0 .. 20] of real;
  biasmask3: array [0 .. 2] of real;
  outputvalue1, outputvalue2, outputvalue3: real;
  dbfields: array of string;
begin
  dbfields := ['Danceability', 'Energy', 'Speechiness', 'Acousticness',
    'Valence', 'Tempo', 'Time Signature']; // For iterating through field names
  frmMainmenu.tblSongProperties.Active := False;
  // Refresh Table to make sure it has up to date data
  frmMainmenu.tblSongProperties.Active := True;
  Repeat
  begin

    frmMainmenu.tblSongProperties.Locate('ID', songID1, []);

    // Initialisation
    // Addresses only the correct song ID
    for i := 0 to 6 do // Initialise the input layer with values from DB
    begin
      inputlayer[i] := frmMainmenu.tblSongProperties.FieldByName
        (dbfields[i]).AsFloat;
    end;

    for i := 0 to 34 do // Initialise bias mask 1 with random function
    begin
      biasmask1[i] := (randomrange(-100000, 100000) / 2500000);
      // Generates a random number
      // between -1 and 1
    end;

    for i := 35 to 41 do
    begin
      biasmask1[i] := (randomrange(-100000, 100000) / 30000000);
      // Generated bias for this value accomodates for the fact that the tempo
      // is around 200x larger than other values

    end;

    for i := 42 to 48 do // Initialise bias mask 1 with random function
    begin
      biasmask1[i] := (randomrange(-100000, 100000) / 7000000);
      // Generates a random number
      // between -1 and 1
    end;

    for i := 0 to 20 do // Initialise bias mask 2 with random function
    begin
      biasmask2[i] := (randomrange(-100000, 100000) / 120000);
      // Generates a random number
      // between -1 and 1
    end;

    for i := 0 to 2 do // Initialise bias mask 3 with random function
    begin
      biasmask3[i] := (randomrange(-100000, 100000) / 200000);
      // Generates a random number
      // between -1 and 1
    end;


    // Wipes hidden layer values

    for j := 0 to 6 do
    begin
      hiddenlayer1[j] := 0
    end;
    for j := 0 to 2 do
    begin
      hiddenlayer2[j] := 0
    end;

    outputvalue1 := 0;


    // All initialised

    // -----------------------------------

    // First Run Calculations

    for j := 0 to 6 do
    begin
      for k := 0 to 6 do
      begin
        hiddenlayer1[j] := hiddenlayer1[j] + (inputlayer[k] * biasmask1[7 * j]);
      end;
      // showmessage(floattostr(hiddenlayer1[j]));
    end;

    for j := 0 to 2 do
    begin
      for k := 0 to 6 do
      begin
        hiddenlayer2[j] := hiddenlayer2[j] +
          (hiddenlayer1[k] * biasmask2[7 * j]);
      end;
      // showmessage(floattostr(hiddenlayer1[j]));
    end;
    outputvalue1 := 0;
    for l := 0 to 2 do
    begin
      outputvalue1 := outputvalue1 + (hiddenlayer2[l] * biasmask3[l]);
    end;

    ///

    ///

    frmMainmenu.tblSongProperties.Locate('ID', SongId3, []);

    // Initialisation
    // Addresses only the correct song ID
    for i := 0 to 6 do // Initialise the input layer with values from DB
    begin
      inputlayer[i] := frmMainmenu.tblSongProperties.FieldByName
        (dbfields[i]).AsFloat;
    end;

    for j := 0 to 6 do
    begin
      hiddenlayer1[j] := 0
    end;
    for j := 0 to 2 do
    begin
      hiddenlayer2[j] := 0
    end;

    outputvalue2 := 0;


    // All initialised

    // -----------------------------------

    // First Run Calculations

    for j := 0 to 6 do
    begin
      for k := 0 to 6 do
      begin
        hiddenlayer1[j] := hiddenlayer1[j] + (inputlayer[k] * biasmask1[7 * j]);
      end;
      // showmessage(floattostr(hiddenlayer1[j]));
    end;

    for j := 0 to 2 do
    begin
      for k := 0 to 6 do
      begin
        hiddenlayer2[j] := hiddenlayer2[j] +
          (hiddenlayer1[k] * biasmask2[7 * j]);
      end;
      // showmessage(floattostr(hiddenlayer1[j]));
    end;

    for l := 0 to 2 do
    begin
      outputvalue2 := outputvalue2 + (hiddenlayer2[l] * biasmask3[l]);
    end;

    ///

    frmMainmenu.tblSongProperties.Locate('ID', SongId2, []);

    // Initialisation
    // Addresses only the correct song ID
    for i := 0 to 6 do // Initialise the input layer with values from DB
    begin
      inputlayer[i] := frmMainmenu.tblSongProperties.FieldByName
        (dbfields[i]).AsFloat;
    end;

    for j := 0 to 6 do
    begin
      hiddenlayer1[j] := 0
    end;
    for j := 0 to 2 do
    begin
      hiddenlayer2[j] := 0
    end;

    outputvalue3 := 0;


    // All initialised

    // -----------------------------------

    // First Run Calculations

    for j := 0 to 6 do
    begin
      for k := 0 to 6 do
      begin
        hiddenlayer1[j] := hiddenlayer1[j] + (inputlayer[k] * biasmask1[7 * j]);
      end;
      // showmessage(floattostr(hiddenlayer1[j]));
    end;

    for j := 0 to 2 do
    begin
      for k := 0 to 6 do
      begin
        hiddenlayer2[j] := hiddenlayer2[j] +
          (hiddenlayer1[k] * biasmask2[7 * j]);
      end;
      // showmessage(floattostr(hiddenlayer1[j]));
    end;

    for l := 0 to 2 do
    begin
      outputvalue3 := outputvalue3 + (hiddenlayer2[l] * biasmask3[l]);
    end;
    frmMainmenu.Memo1.Lines.Add(floattostr(sigmoid(outputvalue1)));
    frmMainmenu.Memo1.Lines.Add(floattostr(sigmoid(outputvalue3)));
    frmMainmenu.Memo1.Lines.Add(floattostr(sigmoid(outputvalue2)));

    //

  end;
  Until (sigmoid(outputvalue1) >= (0.70)) and (sigmoid(outputvalue3) >= (0.70))
    and (sigmoid(outputvalue2) <= (0.70));
  showmessage(floattostr(((sigmoid(outputvalue1)))));

  showmessage(floattostr(((sigmoid(outputvalue3)))));
  showmessage(floattostr(((sigmoid(outputvalue2)))));
end;

// ==============================================================================

end.
