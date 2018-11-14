program ComputingProject;

uses
  Vcl.Forms,
  MainMenu in 'MainMenu.pas' {frmMainMenu};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.Run;
end.
