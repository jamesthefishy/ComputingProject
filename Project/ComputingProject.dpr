program ComputingProject;

uses
  Vcl.Forms,
  MainMenu in 'MainMenu.pas' {frmMainMenu},
  SettingsPage in 'SettingsPage.pas' {frmSettings};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.Run;
end.
