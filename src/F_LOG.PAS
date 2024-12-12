unit f_log;
{
Auteur: Patrick Pr‚martin.
Date: 24/05/1993.
      26/05/1993.
Langage: Turbo Pascal 6.0
But: Gestion du fichier d'historique (LOG.TXT).
}
interface

uses
    _var;

type
    file_log = text;

procedure add_log (code : t_code; profil_1, profil_2 : t_profil);

implementation
uses
    u_date,
    u_time;

procedure add_log (code : t_code; profil_1, profil_2 : t_profil);
var
   f : file_log;
   n : integer;
begin
  assign (f, 'C:\OSPASWRD\LOG.TXT');
  {$i-}
  append (f);
  {$i+}
  n := ioresult;
  if (n = 2) { File not found }
  then
    begin
      {$i-}
      rewrite (f);
      {$i+}
      n := ioresult;
    end;
  {endif}
  if (n <> 0)
  then
    begin
      writeln ('Erreur sur fichier LOG.DTA, contactez votre fournisseur.');
      writeln ('Routine: ADD_LOG,', n);
      halt (1);
    end;
  {endif}
  {$i-}
  case code of
    USER_CRT : writeln (f, 'Cr‚ation de ', profil_2.name, ' par ',
                       profil_1.name, ' le ', get_date_chaine, ' … ', get_time_chaine, '.');
    USER_MAJ : writeln (f, 'Modification de ', profil_2.name, ' par ',
                       profil_1.name, ' le ', get_date_chaine, ' … ', get_time_chaine, '.');
    USER_DLT : writeln (f, 'Suppression de ', profil_2.name, ' par ', profil_1.name, ' le ',
                       get_date_chaine, ' … ', get_time_chaine, '.');
    LOG_IN : writeln (f, 'Connection de ', profil_1.name, ' le ', get_date_chaine, ' … ', get_time_chaine, '.');
    LOG_OUT : writeln (f, 'D‚connection de ', profil_1.name, ' le ', get_date_chaine, ' … ', get_time_chaine, '.');
    INSTALL_ON : writeln (f, 'Installation du logiciel le ', get_date_chaine, ' … ', get_time_chaine, '.');
    INSTALL_OFF : writeln (f, 'Fin de l''installation le ', get_date_chaine, ' … ', get_time_chaine, '.');
    ERR_CRT : writeln (f, 'Cr‚ation de ', profil_2.name, ' par ', profil_1.name, ' impossible !');
    ERR_MAJ : writeln (f, 'Modification de ', profil_2.name, ' par ', profil_1.name, ' impossible !');
    ERR_DLT : writeln (f, 'Suppression de ', profil_2.name, ' par ', profil_1.name, ' impossible !');
  end;
  {$i+}
  if (n <> 0)
  then
    begin
      writeln ('Erreur sur fichier LOG.DTA, contactez votre fournisseur.');
      writeln ('Routine: ADD_LOG,', n);
      halt (1);
    end;
  {endif}
  close (f);
end; { add_log }

end.
