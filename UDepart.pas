unit UDepart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, clipbrd, ShellApi, FileCtrl;

type
  TFDepart = class(TForm)
    Label1: TLabel;
    LB_Dispo: TListBox;
    Label2: TLabel;
    LB_Sel: TListBox;
    Label3: TLabel;
    ED_FicheEC: TEdit;
    BTN_Search: TBitBtn;
    BTN_Quitter: TBitBtn;
    BTN_Ouvrir: TBitBtn;
    BTN_Vider: TBitBtn;
    OD_PAS: TOpenDialog;
    LB_Dispo2: TListBox;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    ED_Pref: TEdit;
    Label5: TLabel;
    ED_Num: TEdit;
    CKB_svg: TCheckBox;
    BTN_Ren: TButton;
    BTN_SVG: TButton;
    BTN_Proj: TButton;
    procedure BTN_QuitterClick(Sender: TObject);
    procedure LB_DispoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BTN_ViderClick(Sender: TObject);
    procedure LB_SelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BTN_SearchClick(Sender: TObject);
    procedure BTN_OuvrirClick(Sender: TObject);
    procedure ED_NumKeyPress(Sender: TObject; var Key: Char);
    procedure BTN_RenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LB_SelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTN_SVGClick(Sender: TObject);
    procedure BTN_ProjClick(Sender: TObject);

    function RemplaceStr(Cible, Extrait, Remplacement : string) : string;
    procedure FormCreate(Sender: TObject);

  private
  {------------------------}
    PrS_Rep,
    PrS_RepSVG,
    PrS_PasFile,
    PrS_DfmFile,
    PrS_FicheEC  : string;
  {------------------------}
    PrSL_PasF,
    PrSL_DfmF    : TStrings;
  {------------------------}


  public
    { Déclarations publiques }
  end;

var
  FDepart: TFDepart;

implementation

{$R *.DFM}

procedure TFDepart.FormCreate(Sender: TObject);
begin
     PrS_FicheEC := ParamStr(1);
end;

procedure TFDepart.FormActivate(Sender: TObject);
begin
     PrS_Rep    := ExtractFilePath(Application.ExeName);
     PrS_RepSVG := PrS_Rep + 'SVG\';
     if not DirectoryExists(PrS_RepSVG)
        then ForceDirectories(PrS_RepSVG);
     PrSL_PasF  := TStringList.Create;
     PrSL_DfmF  := TStringList.Create;
     if PrS_FicheEC <> '' then begin
        ED_FicheEC.Text := PrS_FicheEC;
        BTN_Ouvrir.Click;
     End;
end;

procedure TFDepart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     PrSL_PasF.Free;
     PrSL_DfmF.Free;
end;

procedure TFDepart.BTN_QuitterClick(Sender: TObject);
begin
     Close;
end;

procedure TFDepart.LB_DispoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   i : integer;
begin
     if Button = mbRight then begin
        For i := 0 to LB_Dispo.Items.Count - 1 do begin
            if LB_Dispo.Selected[i] then begin
               if LB_Sel.Items.IndexOf(LB_Dispo2.Items.Strings[i]) = -1
                  then LB_Sel.Items.Add(LB_Dispo2.Items.Strings[i]);
            End;
        End;
     End;
end;

procedure TFDepart.BTN_ViderClick(Sender: TObject);
begin
     LB_Sel.Items.Clear;
end;

procedure TFDepart.LB_SelKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
{------------------------}
   i,
   LI_Ix,
   LI_Pos    : Integer;
{------------------------}
   LS_Clip,
   LS_Compo,
   LS_EltSup : string;
{------------------------}
begin
     // Insertion des composants par CTRL + V à partir d'un CTRL + C sur une fiche
     if (GetKeyState(VkKeyScan('v')) < 0)
        and (GetKeyState(VK_CONTROL) < 0) then begin
        // recup texte du presse papier
        LS_Clip := clipboard.AsText;
        LI_Pos  := Pos('object', LS_Clip);
        // tant qu'on trouve des object ...
        while LI_Pos <> 0 do begin
              LS_Clip  := Copy(LS_Clip, LI_Pos + 7, Length(LS_Clip));
              // recuperation du nom du composant
              LS_Compo := Copy(LS_Clip, 1, Pos(':', LS_Clip) - 1);
              // et ajout dans la liste
              if (LB_Sel.Items.IndexOf(LS_Compo) = -1)
                 and (LB_Dispo2.Items.IndexOf(LS_Compo) <> -1)
                 then LB_Sel.Items.Add(Copy(LS_Clip, 1, Pos(':', LS_Clip) - 1));
              LI_Pos   := Pos('object', LS_Clip);
        End;
     End;
     if (GetKeyState(vk_down) < 0)
        and (GetKeyState(VK_CONTROL) < 0)
        then begin
        // Deplacer un element vers le bas
        LI_Ix := LB_Sel.ItemIndex;
        if LI_Ix < (LB_Sel.Items.Count - 1) then begin
           LS_EltSup := LB_Sel.Items.Strings[LI_Ix];
           LB_Sel.Items.Delete(LI_Ix);
           LB_Sel.Items.Insert(LI_Ix + 1, LS_EltSup);
           LB_Sel.ItemIndex := LI_Ix;
        End;
     End;
     if (GetKeyState(vk_up) < 0)
        and (GetKeyState(VK_CONTROL) < 0)
        then begin
        LI_Ix := LB_Sel.ItemIndex;
        if LI_Ix > 0 then begin
           LS_EltSup := LB_Sel.Items.Strings[LI_Ix - 1];
           LB_Sel.Items.Delete(LI_Ix - 1);
           LB_Sel.Items.Insert(LI_Ix, LS_EltSup);
           LB_Sel.ItemIndex := LI_Ix;
        End;
     End;
end;

procedure TFDepart.LB_SelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   LI_Ix : Integer;
begin
     if Button = mbRight then begin
        LI_Ix := LB_Sel.ItemIndex;
        if LI_Ix <> -1
           then LB_Sel.Items.Delete(LI_Ix);
     End;
end;

procedure TFDepart.BTN_SearchClick(Sender: TObject);
begin
     if OD_PAS.Execute
        then ED_FicheEC.Text := OD_PAS.FileName;
end;

procedure TFDepart.BTN_OuvrirClick(Sender: TObject);
var
{------------------------}
   i, j       : integer;
{------------------------}
   LS_Excl1,
   LS_Excl2,
   LS_Compo1,
   LS_Compo2  : string;
{------------------------}
   LSL_Excl   : TStrings;
{------------------------}
   LB_Nada    : Boolean;
{------------------------}
begin
     LB_Dispo.Items.Clear;
     LB_Dispo2.Items.Clear;
     LB_Sel.Items.Clear;
     PrS_PasFile := ED_FicheEC.Text;
     PrS_DfmFile := ChangeFileExt(PrS_PasFile, '.dfm');
     PrSL_PasF.Clear;
     PrSL_DfmF.Clear;
     if FileExists(PrS_PasFile)
        and FileExists(PrS_DfmFile) then begin
        LSL_Excl := TStringList.Create;
        // Chargement des fichiers
        PrSL_PasF.LoadFromFile(PrS_PasFile);
        PrSL_DfmF.LoadFromFile(PrS_DfmFile);
        // Recherche exclusion (tform)
        For i := 0 to PrSL_PasF.Count - 1 do begin
            if Pos('= class(TForm)', PrSL_PasF.Strings[i]) <> 0 then Begin
               LS_Excl1 := Copy(PrSL_PasF.Strings[i], 0, Pos('=', PrSL_PasF.Strings[i]) - 1);
               // Pour sortir les espaces
               LS_Excl2 := '';
               For j := 1 to Length(LS_Excl1) do begin
                   if LS_Excl1[j] <> ' '
                      then LS_Excl2 := LS_Excl2 + LS_Excl1[j];
               End;
               LSL_Excl.Add(LS_Excl2);
            End;
        End;
        // Recherche des composants
        For i := 0 to PrSL_DfmF.Count - 1 do begin
            if Pos('object', PrSL_DfmF.Strings[i]) <> 0 then begin
               // Recup du nom du composant
               LS_Compo1 := Copy(PrSL_DfmF.Strings[i], Pos('object', PrSL_DfmF.Strings[i]) + 7, Length(PrSL_DfmF.Strings[i]));
               LS_Compo2 := Copy(LS_Compo1, 1, Pos(':', LS_Compo1) - 1);
               // Verification exclusions
               LB_Nada := False;
               For j := 0 to LSL_Excl.Count - 1 do begin
                   if Pos(LSL_Excl.Strings[j], LS_Compo1) <> 0 then begin
                      LB_Nada := True;
                      break;
                   End;
               End;
               if not LB_Nada then begin
                  // Ajout dans la liste avec la classe
                  LB_Dispo.Items.Add(LS_Compo1);
                  // Ajout dans la liste sans la classe
                  LB_Dispo2.Items.Add(LS_Compo2);
               End;
            End;
        End;
        LSL_Excl.Free;
     end
     else Showmessage('Un fichier dfm ou pas est manquant');
end;

procedure TFDepart.ED_NumKeyPress(Sender: TObject; var Key: Char);
begin
     // Controle saisie entier
     if not (key in ['1'..'9', #8, '0', #13])
        then key := #0;
end;

procedure TFDepart.BTN_RenClick(Sender: TObject);
var
{------------------------}
   i, j,
   LI_OffSet,
   LI_REC    : integer;
{------------------------}
   LS_NSVG,
   LS_CRen   : string;
{------------------------}
begin
     // contrôles
     if ED_Pref.Text = '' then begin
        Showmessage('Veuillez saisir un préfixe');
        Exit; // >>> SORTIE
     end;
     if ED_Num.Text = '' then begin
        Showmessage('Veuillez saisir un numéro de départ');
        Exit; // >>> SORTIE
     End;
     if not CKB_svg.Checked then begin
        if MessageDlg('Attention ! Vous ne voulez pas faire de sauvegarde... ce n''est pas prudent (faudra pas se plaindre après).'+ #13#10 + 'Continuer ?', mtConfirmation, [mbYes,mbNo], 0) = mrNo
           then Exit; // >>> SORTIE
     End;
     if LB_Sel.Items.Count = 0 then begin
        Showmessage('Il n''y a rien à renommer');
        Exit; // >>> SORTIE
     End;
     // Sauvegarde fichier modifié
     if CKB_svg.Checked then Begin
        i := 1;
        while FileExists(PrS_RepSVG + ExtractFileName(ChangeFileExt(PrS_PasFile, '.pas'+ IntToStr(i))))
              do Inc(i);
        LS_NSVG := PrS_RepSVG + ExtractFileName(ChangeFileExt(PrS_PasFile, '.pas'+ IntToStr(i)));
        CopyFile(PChar(PrS_PasFile), PChar(LS_NSVG), False);
        LS_NSVG := PrS_RepSVG + ExtractFileName(ChangeFileExt(PrS_DfmFile, '.dfm'+ IntToStr(i)));
        CopyFile(PChar(PrS_DfmFile), PChar(LS_NSVG), False);
     End;
     LI_OffSet := StrToInt(ED_Num.Text);
     For i := 0 to LB_Sel.Items.Count - 1 do begin
         LI_REC := LI_OffSet + i;
         // Creation des noms de remplacement
         LS_CRen := ED_Pref.Text + IntToStr(LI_REC);
         // Recherche dans les .pas et .dfm
         For j := 0 to PrSL_PasF.Count - 1 do begin
             if Pos(LB_Sel.Items.Strings[i], PrSL_PasF.Strings[j]) <> 0
                then PrSL_PasF.Strings[j] := RemplaceStr(PrSL_PasF.Strings[j], LB_Sel.Items.Strings[i], LS_CRen);
         End;
         For j := 0 to PrSL_DfmF.Count - 1 do begin
             if Pos(LB_Sel.Items.Strings[i], PrSL_DfmF.Strings[j]) <> 0
                then PrSL_DfmF.Strings[j] := RemplaceStr(PrSL_DfmF.Strings[j], LB_Sel.Items.Strings[i], LS_CRen);
         End;
         PrSL_PasF.SaveToFile(PrS_PasFile);
         PrSL_DfmF.SaveToFile(PrS_DfmFile);
     end;
     LB_Sel.Items.Clear;
     Showmessage('Modifications enregistrées');
end;

procedure TFDepart.BTN_SVGClick(Sender: TObject);
begin
     ShellExecute(Handle, 'open', PChar(PrS_RepSVG), nil, nil, SW_NORMAL);
end;

procedure TFDepart.BTN_ProjClick(Sender: TObject);
begin
     ShellExecute(Handle, 'open', PChar(ExtractFilePath(PrS_PasFile)), nil, nil, SW_NORMAL);
end;

function TFDepart.RemplaceStr(Cible, Extrait, Remplacement : string) : string;
var
{------------------------}
   LI_Pos,
   LI_LenExt : Integer;
{------------------------}
   LS_Cible  : string;
{------------------------}
begin
     LS_Cible  := Cible;
     Result    := '';
     LI_LenExt := Length(Extrait);
     while Pos(Extrait, LS_Cible) <> 0 do begin
           LI_Pos   := Pos(Extrait, LS_Cible);
           Result   := Result + Copy(LS_Cible, 1, Pos(Extrait, LS_Cible) -1) + Remplacement;
           LS_Cible := Copy(LS_Cible, Pos(Extrait, LS_Cible) + LI_LenExt, Length(LS_Cible));
     End;
     Result := Result + LS_Cible;
end;


end.
