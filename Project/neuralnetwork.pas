unit neuralnetwork;

interface

procedure train(songID1, SongId2, SongId3: string);
function sigmoid(inputvalue: real): real;
function songtest(testsongId:string):real;

implementation

uses Mainmenu, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants,
  System.Classes, Vcl.Graphics, dialogs, math, GlobalValues;

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
  i, j, k, l, m, c: integer;
  inputlayer, hiddenlayer1: array [0 .. 6] of real;

  hiddenlayer2: array [0 .. 2] of real;

  trendflags1: array [0 .. 48] of char;
  // Does changing this value have a positive or negative effect #
  changefoundflag: boolean;
  trendflags2: array [0 .. 20] of char;
  compoutputvalue1, compoutputvalue2, compoutputvalue3: real;
  dbfields: array of string;
begin
  dbfields := ['Danceability', 'Energy', 'Speechiness', 'Acousticness',
    'Valence', 'Tempo', 'Time Signature']; // For iterating through field names
  frmMainmenu.tblSongProperties.Active := False;
  // Refresh Table to make sure it has up to date data
  frmMainmenu.tblSongProperties.Active := True;
  Repeat
  begin
    Repeat
    begin
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
          Randomize;
          biasmask1[i] := (randomrange(-100000, 100000) / 500000);
          // Generates a random number
          // between -1 and 1
        end;

        for i := 35 to 41 do
        begin
          Randomize;
          biasmask1[i] := (randomrange(-100000, 100000) / 30000000);
          // Generated bias for this value accomodates for the fact that the tempo
          // is around 200x larger than other values

        end;

        for i := 42 to 48 do // Initialise bias mask 1 with random function
        begin
          Randomize;
          biasmask1[i] := (randomrange(-100000, 100000) / 500000);
          // Generates a random number
          // between -1 and 1
        end;

        for i := 0 to 20 do // Initialise bias mask 2 with random function
        begin
          Randomize;
          biasmask2[i] := (randomrange(-100000, 100000) / 250000);
          // Generates a random number
          // between -1 and 1
        end;

        for i := 0 to 2 do // Initialise bias mask 3 with random function
        begin
          Randomize;
          biasmask3[i] := (randomrange(-100000, 100000) / 250000);
          // Generates a random number
          // between -1 and 1
        end;
        // ------------------------------------------------------------------------------
        // ---Song1-------
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

        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
        // ------------------------------------------------------------------------------
        // ---Song2-------
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

        outputvalue2 := 0;

        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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

        // ------------------------------------------------------------------------------
        // ---Song3-------

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

        outputvalue3 := 0;

        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
        frmMainmenu.Memo1.Lines.Add(floattostr(sigmoid(outputvalue2)));
        frmMainmenu.Memo1.Lines.Add(floattostr(sigmoid(outputvalue3)));

        //

      end;
      Until (sigmoid(outputvalue1) > sigmoid(outputvalue3)) and
        (sigmoid(outputvalue2) > sigmoid(outputvalue3));
      // ------------------------------------------------------------------------------


      // Run CHecks for the first layer

      for c := 0 to 48 do
      begin
        biasmask1[c] := biasmask1[c] + (0.05);
        // Make a change to each bias and see how it affects outputs
        // Runs values through again for each song:
        frmMainmenu.tblSongProperties.Locate('ID', songID1, []);
        // ------------------------------------------------------------------------------
        // ---Song1-------
        // Wipes hidden layer values
        for j := 0 to 6 do
        begin
          hiddenlayer1[j] := 0
        end;
        for j := 0 to 2 do
        begin
          hiddenlayer2[j] := 0
        end;
        compoutputvalue1 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue1 := compoutputvalue1 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        // ---Song2-------
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
        compoutputvalue2 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue2 := compoutputvalue2 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        // ---Song3-------
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
        compoutputvalue3 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue3 := compoutputvalue3 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        if ((compoutputvalue1 - outputvalue1) > 0) or
          ((compoutputvalue2 - outputvalue2) > 0) and
          ((compoutputvalue3 - outputvalue3) < 0) then
        // does shifting this value up have a positive change
        begin
          trendflags1[c] := '+';
          changefoundflag := True;
        end
        else
          trendflags1[c] := 'n';
        frmMainmenu.Memo1.Lines.Add(trendflags1[c]);
        biasmask2[c] := biasmask2[c] - (0.05);
        // Sets bias back to original value
        // ------------------------------------------------------------------------------
        // Try the reducing the bias
        biasmask1[c] := biasmask1[c] - (0.05);
        // Make a change to each bias and see how it affects outputs
        // Runs values through again for each song:
        frmMainmenu.tblSongProperties.Locate('ID', songID1, []);
        // ------------------------------------------------------------------------------
        // ---Song1-------
        // Wipes hidden layer values
        for j := 0 to 6 do
        begin
          hiddenlayer1[j] := 0
        end;
        for j := 0 to 2 do
        begin
          hiddenlayer2[j] := 0
        end;
        compoutputvalue1 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue1 := compoutputvalue1 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        // ---Song2-------
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
        compoutputvalue2 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue2 := compoutputvalue2 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        // ---Song3-------
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
        compoutputvalue3 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue3 := compoutputvalue3 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        if ((compoutputvalue1 - outputvalue1) > 0) or
          ((compoutputvalue2 - outputvalue2) > 0) and
          ((compoutputvalue3 - outputvalue3) < 0) then
        // does shifting this value up have a positive change
        begin
          trendflags1[c] := '-';
          changefoundflag := True;
        end
        else
          trendflags1[c] := 'n';
        frmMainmenu.Memo1.Lines.Add(trendflags1[c]);
        biasmask2[c] := biasmask2[c] + (0.05)
        // Sets bias back to original value
      end;
      // ------------------------------------------------------------------------------
      // Run CHecks for the second layer
      for c := 0 to 20 do
      begin
        biasmask2[c] := biasmask2[c] + (0.05);
        // Make a change to each bias and see how it affects outputs
        // Runs values through again for each song:
        frmMainmenu.tblSongProperties.Locate('ID', songID1, []);
        // ------------------------------------------------------------------------------
        // ---Song1-------
        // Wipes hidden layer values
        for j := 0 to 6 do
        begin
          hiddenlayer1[j] := 0
        end;
        for j := 0 to 2 do
        begin
          hiddenlayer2[j] := 0
        end;
        compoutputvalue1 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue1 := compoutputvalue1 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        // ---Song2-------
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
        compoutputvalue2 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue2 := compoutputvalue2 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        // ---Song3-------
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
        compoutputvalue3 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue3 := compoutputvalue3 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        if ((compoutputvalue1 - outputvalue1) > 0) or
          ((compoutputvalue2 - outputvalue2) > 0) and
          ((compoutputvalue3 - outputvalue3) < 0) then
        // does shifting this value up have a positive change
        begin
          trendflags2[c] := '+';
          changefoundflag := True;
        end
        else
          trendflags2[c] := 'n';
        frmMainmenu.Memo1.Lines.Add(trendflags2[c]);
        biasmask2[c] := biasmask2[c] - (0.05);
        // Setting the bias back to original
        // Try the reducing the bias

        biasmask2[c] := biasmask2[c] - (0.05);
        // Make a change to each bias and see how it affects outputs
        // Runs values through again for each song:
        frmMainmenu.tblSongProperties.Locate('ID', songID1, []);
        // ------------------------------------------------------------------------------
        // ---Song1-------
        // Wipes hidden layer values
        for j := 0 to 6 do
        begin
          hiddenlayer1[j] := 0
        end;
        for j := 0 to 2 do
        begin
          hiddenlayer2[j] := 0
        end;
        compoutputvalue1 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue1 := compoutputvalue1 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        // ---Song2-------
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
        compoutputvalue2 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue2 := compoutputvalue2 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        // ---Song3-------
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
        compoutputvalue3 := 0;
        for j := 0 to 6 do
        begin
          for k := 0 to 6 do
          begin
            hiddenlayer1[j] := hiddenlayer1[j] +
              (inputlayer[k] * biasmask1[7 * j]);
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
          compoutputvalue3 := compoutputvalue3 +
            (hiddenlayer2[l] * biasmask3[l]);
        end;
        // ------------------------------------------------------------------------------
        if ((compoutputvalue1 - outputvalue1) > 0) or
          ((compoutputvalue2 - outputvalue2) > 0) and
          ((compoutputvalue3 - outputvalue3) < 0) then
        // does shifting this value up have a positive change
        begin
          trendflags2[c] := '-';
          changefoundflag := True;
        end
        else
          trendflags2[c] := 'n';
        frmMainmenu.Memo1.Lines.Add(trendflags2[c]);
        biasmask2[c] := biasmask2[c] + (0.05)
      end;
      // ------------------------------------------------------------------------------
    end;
    Until changefoundflag = True;

    // Now apply the changes found to work out well
    // ------------------------------------------------------------------------------
    for c := 0 to 48 do
    begin
      if trendflags1[c] = '+' then
      begin
        biasmask1[c] := biasmask1[c] + (0.05)
      end;
      if trendflags1[c] = '-' then
      begin
        biasmask1[c] := biasmask1[c] - (0.05)
      end;

    end;
    // ------------------------------------------------------------------------------
    for c := 0 to 20 do
    begin
      if trendflags2[c] = '+' then
      begin
        biasmask2[c] := biasmask2[c] + (0.05)
      end;
      if trendflags2[c] = '-' then
      begin
        biasmask2[c] := biasmask2[c] - (0.05)
      end;

    end;
    // ------------------------------------------------------------------------------

    // Final run to get baseline values that the network gives:

    // ------------------------------------------------------------------------------
    // ---Song1-------
    // Wipes hidden layer values
    frmMainmenu.tblSongProperties.Locate('ID', songID1, []);

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

    outputvalue1 := 0;

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
      outputvalue1 := outputvalue1 + (hiddenlayer2[l] * biasmask3[l]);
    end;
    // ------------------------------------------------------------------------------
    // ---Song2-------
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

    outputvalue2 := 0;

    for j := 0 to 6 do
    begin
      for k := 0 to 6 do
      begin
        hiddenlayer1[j] := hiddenlayer1[j] + (inputlayer[k] * biasmask1[7 * j]);
      end;
    end;

    for j := 0 to 2 do
    begin
      for k := 0 to 6 do
      begin
        hiddenlayer2[j] := hiddenlayer2[j] +
          (hiddenlayer1[k] * biasmask2[7 * j]);
      end;
    end;

    for l := 0 to 2 do
    begin
      outputvalue2 := outputvalue2 + (hiddenlayer2[l] * biasmask3[l]);
    end;

    // ------------------------------------------------------------------------------
    // ---Song3-------

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

    outputvalue3 := 0;

    for j := 0 to 6 do
    begin
      for k := 0 to 6 do
      begin
        hiddenlayer1[j] := hiddenlayer1[j] + (inputlayer[k] * biasmask1[7 * j]);
      end;
    end;

    for j := 0 to 2 do
    begin
      for k := 0 to 6 do
      begin
        hiddenlayer2[j] := hiddenlayer2[j] +
          (hiddenlayer1[k] * biasmask2[7 * j]);
      end;
    end;

    for l := 0 to 2 do
    begin
      outputvalue3 := outputvalue3 + (hiddenlayer2[l] * biasmask3[l]);

    end;
    // ------------------------------------------------------------------------------

  end;
  Until (sigmoid(outputvalue1) > sigmoid(outputvalue3)) and
    (sigmoid(outputvalue2) > sigmoid(outputvalue3));

  showmessage('1:' + floattostr(sigmoid(outputvalue1)) + ' 2:' +
    floattostr(sigmoid(outputvalue2)) + ' 3:' +
    floattostr(sigmoid(outputvalue3)));

  outputvalue1 := (sigmoid(outputvalue1));
  outputvalue2 := (sigmoid(outputvalue2));
  outputvalue3 := (sigmoid(outputvalue3));
  // ==============================================================================

end;

function songtest(testsongID: string): real;
var
  dbfields: array of string;
  i, j, k, l: integer;
  inputlayer, hiddenlayer1: array [0 .. 6] of real;
  outputvalue: real;
  hiddenlayer2: array [0 .. 2] of real;
  confidence: real;
begin
  // Feed song Id into trained network
  frmMainmenu.tblSongProperties.Locate('ID', testsongID, []);
  dbfields := ['Danceability', 'Energy', 'Speechiness', 'Acousticness',
    'Valence', 'Tempo', 'Time Signature'];
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

  outputvalue := 0;

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
      hiddenlayer2[j] := hiddenlayer2[j] + (hiddenlayer1[k] * biasmask2[7 * j]);
    end;
    // showmessage(floattostr(hiddenlayer1[j]));
  end;

  for l := 0 to 2 do
  begin
    outputvalue := outputvalue + (hiddenlayer2[l] * biasmask3[l]);
  end;
  outputvalue := sigmoid(outputvalue);
  //
  // Confidence Calculation
  //
  if outputvalue <= (outputvalue3+0.01) then
    confidence := 0;
  if (outputvalue > outputvalue1) and (outputvalue > outputvalue2) then
  begin
    if outputvalue1 > outputvalue2 then
    begin
      confidence := 0.5 + (outputvalue - outputvalue1) / 2 *
        (outputvalue2 - outputvalue3);
      if confidence > 1 then
        confidence := 1;
    end;
    if outputvalue2 > outputvalue1 then
    begin
      confidence := 0.5 + (outputvalue - outputvalue2) / 2 *
        (outputvalue1 - outputvalue3);
      if confidence > 1 then
        confidence := 1;
    end;

  end;
  if (outputvalue < outputvalue1) and (outputvalue > outputvalue2) then
  begin
    confidence := 0.2 + ((outputvalue1 - outputvalue) / (outputvalue1 - outputvalue2))
  end;
  if (outputvalue < outputvalue2) and (outputvalue > outputvalue1) then
  begin
   confidence :=  0.2 + ((outputvalue2 - outputvalue) / (outputvalue2 - outputvalue1))
  end;

  result := confidence
end;

end.
