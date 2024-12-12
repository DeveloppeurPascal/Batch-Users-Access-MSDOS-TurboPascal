program dlt_user;
{
Auteur: Patrick Pr‚martin.
Date: 29/05/1993.
Langage: Turbo Pascal 6.0
But: Suppression d'utilisateurs.
}

uses
    u_ger_chaine,
    _var,
    f_log,
    f_who,
    f_user;

var
   who,
   profil : t_profil;
   i : integer;

begin
  get_who (who);
  if (who.name = '')
  then
    halt (1)
  else
    if (who.security <> HIGH_LEVEL)
    then
      begin
        writeln ('Commande non autoris‚e.');
        halt (1);
      end;
    {endif}
  {endif}
  if (paramcount < 1)
  then
    begin
      writeln ('DLTUSER User_1 User_2 ...');
      writeln;
      writeln ('     permet de supprimer des profils pour chaque ''User_n'' sp‚cifi‚.');
      writeln;
      halt (0);
    end;
  {endif}
  load_profil;
  for i := 1 to paramcount do
    begin
      profil.name := set_maj_chaine (paramstr (i));
      profil.password := profil.name;
      get_user (profil.name, profil);
      if (profil.name <> '')
      then
        begin
          del_user (profil);
          add_log (USER_DLT, who, profil);
          writeln (profil.name, ' supprim‚.');
        end
      else
        begin
          profil.name := profil.password;
          add_log (ERR_DLT, who, profil);
          writeln (profil.name, ' n''existe pas !');
        end;
      {endif}
    end;
  {endfor}
  save_profil;
end.
