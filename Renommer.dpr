program Renommer;

uses
  Forms,
  UDepart in 'UDepart.pas' {FDepart};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFDepart, FDepart);
  Application.Run;
End.
