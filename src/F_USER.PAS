unit f_user;
{
Auteur: Patrick Pr‚martin.
Date: 24/05/1993.
      26/05/1993.
      29/05/1993.
Langage: Turbo Pascal 6.0
But: Gestion du fichier des profils utilisateurs pour le logiciel de protection
     A.I.L. Rousset.
}
interface

uses
    _var;

type
    r_user =
      record
        profil : t_profil;
        creation : t_date;
      end;

    t_tab_user = array [1..c_nb_max_user] of r_user;

    file_user = file of t_tab_user;

procedure add_user (profil : t_profil);
procedure del_user (profil : t_profil);
function valid_profil (nom : string10) : boolean;
function valid_password (profil : t_profil) : boolean;
procedure load_profil;
procedure save_profil;
procedure get_user (nom : string10; var profil : t_profil);

implementation
uses
    u_time,
    u_date;

var
   level : integer;
   tab_user : t_tab_user;

procedure add_user (profil : t_profil);
var
   i : integer;
begin
  i := 1;
  while ((i < c_nb_max_user) and (tab_user [i].profil.name <> '')) do
    inc (i);
  {endwhile}
  if (tab_user [i].profil.name = '')
  then
    tab_user [i].profil := profil;
  {endif}
  tab_user [i].creation.date := get_date_chaine;
  tab_user [i].creation.heure := get_time_chaine;
end; { add_user }

procedure del_user (profil : t_profil);
var
   i : integer;
begin
  i := 1;
  while ((i < c_nb_max_user) and (tab_user [i].profil.name <> profil.name)) do
    inc (i);
  {endwhile}
  if (tab_user [i].profil.name = profil.name)
  then
    tab_user [i].profil.name := '';
  {endif}
end; { del_user }

function valid_profil (nom : string10) : boolean;
var
   res : boolean;
   i : word;
begin
  res := false;
  if (nom <> '')
  then
    if (((nom = 'PPRE') and (level = 0))
    or ((nom = 'PREPAT') and (level = 1))
    or ((nom = 'ROOT') and (level = 2)))
    then
      res := true
    else
      begin
        i := 1;
        while ((i < c_nb_max_user) and (nom <> tab_user [i].profil.name)) do
          inc (i);
        {endwhile}
        if (nom = tab_user [i].profil.name)
        then
          begin
            level := 0;
            res := true;
          end
        else
          res := erreur ('Utilisateur inconnu.');
        {endif}
      end;
    {endif}
  {endif}
  valid_profil := res;
end; { valid_profil }

function valid_password (profil : t_profil) : boolean;
var
   res : boolean;
   i : integer;
begin
  res := false;
  if (profil.password <> '')
  then
    if (((profil.name = 'PPRE') and (level = 0) and (profil.password = 'PREPAT'))
    or ((profil.name = 'PREPAT') and (level = 1) and (profil.password = 'OLFSOFT'))
    or ((profil.name = 'ROOT') and (level = 2) and (profil.password = '12011972')))
    then
      begin
        inc (level);
        if (level = 3)
        then
          res := true
        else
          res := erreur ('Mot de passe incorrect.');
        {endif}
      end
    else
      begin
        level := 0;
        i := 1;
        while ((i < c_nb_max_user) and (profil.name <> tab_user [i].profil.name)) do
          inc (i);
        {endwhile}
        if ((profil.name = tab_user [i].profil.name) and (profil.password = tab_user [i].profil.password))
        then
          res := true
        else
          res := erreur ('Mot de passe incorrect.');
        {endif}
      end;
    {endif}
  {endif}
  valid_password := res;
end; { valid_password }

procedure load_profil;
var
   f : file_user;
   n : integer;
begin
  assign (f, 'C:\OSPASWRD\USER.DTA');
  {$i-}
  reset (f);
  {$i+}
  n := ioresult;
  if (n <> 0)
  then
    begin
      writeln ('Erreur sur fichier USER.DTA, contactez votre fournisseur.');
      writeln ('Routine: LOAD_PROFIL,', n);
      halt (1);
    end;
  {endif}
  {$i-}
  read (f, tab_user);
  {$i+}
  n := ioresult;
  if (n <> 0)
  then
    begin
      writeln ('Erreur sur fichier USER.DTA, contactez votre fournisseur.');
      writeln ('Routine: LOAD_PROFIL,', n);
      halt (1);
    end;
  {endif}
  close (f);
end; { load_profil }

procedure save_profil;
var
   f : file_user;
   n : integer;
begin
  assign (f, 'C:\OSPASWRD\USER.DTA');
  {$i-}
  rewrite (f);
  {$i+}
  n := ioresult;
  if (n <> 0)
  then
    begin
      writeln ('Erreur sur fichier USER.DTA, contactez votre fournisseur.');
      writeln ('Routine: SAVE_PROFIL,', n);
      halt (1);
    end;
  {endif}
  {$i-}
  write (f, tab_user);
  {$i+}
  n := ioresult;
  if (n <> 0)
  then
    begin
      writeln ('Erreur sur fichier USER.DTA, contactez votre fournisseur.');
      writeln ('Routine: SAVE_PROFIL,', n);
      halt (1);
    end;
  {endif}
  close (f);
end; { save_profil }

procedure get_user (nom : string10; var profil : t_profil);
var
   i : integer;
begin
  i := 1;
  while ((i < c_nb_max_user) and (nom <> tab_user [i].profil.name)) do
    inc (i);
  {endwhile}
  if (nom = tab_user [i].profil.name)
  then
    profil := tab_user [i].profil
  else
    profil.name := '';
  {endif}
end; { get_user }

begin
  for level := 1 to c_nb_max_user do
    tab_user [level].profil.name := '';
  {endfor}
  level := 0;
end.
