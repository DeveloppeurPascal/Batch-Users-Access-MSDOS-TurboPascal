unit f_who;
{
Auteur: Patrick Pr‚martin
Langage: Turbo Pascal 6.0
Date: 26/05/1993
But: Gestion du fichier indicant quel est l'utilisateur en cours, et son niveau
     de s‚curit‚.
}
interface

uses
    _var;

type
    r_who = t_profil;

    file_who = file of r_who;

procedure get_who (var res : r_who);
procedure set_who (who : r_who);

implementation
procedure get_who (var res : r_who);
var
   f : file_who;
   n : integer;
begin
  assign (f, 'C:\OSPASWRD\WHO.DTA');
  {$i-}
  reset (f);
  {$i+}
  n := ioresult;
  if (n <> 0)
  then
    begin
      writeln ('Erreur sur fichier WHO.DTA, contactez votre fournisseur.');
      writeln ('Routine: GET_WHO,', n);
      res.name := '';
      res.password := '';
      res.security := LOW_LEVEL;
    end
  else
    begin
      read (f, res);
      close (f);
    end;
  {endif}
end; { get_who }

procedure set_who (who : r_who);
var
   f : file_who;
   n : integer;
begin
  assign (f, 'C:\OSPASWRD\WHO.DTA');
  {$i-}
  rewrite (f);
  {$i+}
  n := ioresult;
  if (n <> 0)
  then
    begin
      writeln ('Erreur sur fichier WHO.DTA, contactez votre fournisseur.');
      writeln ('Routine: SET_WHO,', n);
      halt (1);
    end;
  {endif}
  write (f, who);
  close (f);
end; { set_who }

end.
