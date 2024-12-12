program install;
{
Auteur: Patrick Pr‚martin.
Date: 26/05/1993.
Langage: Turbo Pascal 6.0
But: Installation du logiciel de protection.
}

uses
    _var,
    f_who,
    f_user,
    f_log;

procedure modif_autoexec;
var
   f1, f2 : text;
   ch : string;
begin
  assign (f1, 'C:\AUTOEXEC.BAT');
  {$i-}
  reset (f1);
  {$i+}
  if (ioresult <> 0)
  then
    halt (ioresult);
  {endif}

  assign (f2, 'C:\AUTOEXEC.$$$');
  {$i-}
  rewrite (f2);
  {$i+}
  if (ioresult <> 0)
  then
    halt (ioresult);
  {endif}

  while not eof (f1) do
    begin
      readln (f1, ch);
      writeln (f2, ch);
    end;
  {endwhile}
  close (f1);
  writeln (f2, 'SET PATH=%PATH%;C:\OSPASWRD');
  writeln (f2, 'LOGIN.EXE');
  close (f2);
end; { modif_autoexec }

var
   profil : t_profil;

begin
  add_log (INSTALL_ON, profil, profil);

  { Cr‚ation de l'utilisateur ROOT. }
  profil.name := 'ROOT';
  profil.password := '';
  profil.security := HIGH_LEVEL;
  add_user (profil);

  { Cr‚ation de l'utilisateur QSECOFR. }
  profil.name := 'QSECOFR';
  profil.password := 'QSECOFR';
  profil.security := HIGH_LEVEL;
  add_user (profil);

  save_profil;

  set_who (profil);

  modif_autoexec;

  add_log (INSTALL_ON, profil, profil);
end.
