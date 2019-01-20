program ComputingProject;

uses
  Vcl.Forms,
  MainMenu in 'MainMenu.pas' {frmMainMenu},
  SettingsPage in 'SettingsPage.pas' {frmSettings},
  neuralnetwork in 'neuralnetwork.pas',
  GlobalValues in 'GlobalValues.pas',
  resultsPage in 'resultsPage.pas' {frmResultsPage};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.CreateForm(TfrmResultsPage, frmResultsPage);
  Application.Run;
end.
