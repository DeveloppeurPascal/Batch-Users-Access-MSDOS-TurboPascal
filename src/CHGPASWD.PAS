program change_password;
{
Auteur: Patrick Pr‚martin.
Date: 29/05/1993
Langage: Turbo Pascal 6.0
But: Modification du mot de passe d'un utilisateur.
     Si un paramˆtre est pass‚, il y a modif du mot de passe de l'utilisateur en
     question. Si aucun paramˆtre n'est pass‚, il y a modif du mot de passe de
     l'utilisateur en cours.
}

uses
    crt,
    u_code_clavier,
    u_curseur,
    u_ger_chaine,
    f_log,
    f_who,
    f_user,
    _var;

var
   who, who2 : r_who;
   profil : t_profil;
   ch : string;
   x, y : word;
   c : char;

begin
  curseur_pave;
  get_who (who);
  who2 := who;
  load_profil;
  if (paramcount > 0)
  then
    begin
      if (who.security = high_level)
      then
        get_user (copy (set_maj_chaine(paramstr (1)), 1, 10), profil);
      {endif}
    end
  else
    profil := who;
  {endif}

  textcolor (lightgray);
  textbackground (black);
  writeln ('Modification du mot de passe de ', profil.name);
  { Saisie de l'ancien mot de passe. }
  if (who.name = profil.name)
  then
    begin
      write ('Ancien mot de passe: ');
      x := wherex; y := wherey;
      ch := '';
      profil.password := '';
      repeat
        c := readkey;
        case c of
          'a'..'z',
          'A'..'Z',
          '0'..'9' :
            begin
              profil.password := profil.password + upcase (c);
              ch := ch + '*';
              gotoxy (x, y);
              write (ch);
            end;
          touche_backspace :
            begin
              curseur_milieu;
              profil.password := copy (profil.password, 1, length (profil.password)-1);
              ch := copy (ch, 1, length (ch)-1);
              gotoxy (x, y);
              write (ch, ' ');
              gotoxy (x, y);
              write (ch);
              curseur_pave;
            end;
        end;
      until (((c = touche_return) or (length (profil.password) > 9)) and (profil.password <> ''));
      if (profil.password <> who.password)
      then
        begin
          add_log (ERR_MAJ, who, profil);
          writeln;
          writeln ('Mot de passe erron‚.');
          curseur_on;
          halt (1);
        end;
      {endif}
    end;
  {endif}

  { Saisie du nouveau mot de passe }
  writeln;
  write ('Nouveau mot de passe: ');
  x := wherex; y := wherey;
  profil.password := '';
  ch := '';
  repeat
    c := readkey;
    case c of
      'a'..'z',
      'A'..'Z',
      '0'..'9' :
        begin
          profil.password := profil.password + upcase (c);
          ch := ch + '*';
          gotoxy (x, y);
          write (ch);
        end;
      touche_backspace :
        begin
          curseur_milieu;
          profil.password := copy (profil.password, 1, length (profil.password)-1);
          ch := copy (ch, 1, length (ch)-1);
          gotoxy (x, y);
          write (ch, ' ');
          gotoxy (x, y);
          write (ch);
          curseur_pave;
        end;
    end;
  until (((c = touche_return) or (length (profil.password) > 9)) and (profil.password <> ''));
  who.password := profil.password;

  { Confirmation du nouveau mot de passe }
  writeln;
  write ('Confirmation du nouveau mot de passe: ');
  x := wherex; y := wherey;
  profil.password := '';
  ch := '';
  repeat
    c := readkey;
    case c of
      'a'..'z',
      'A'..'Z',
      '0'..'9' :
        begin
          profil.password := profil.password + upcase (c);
          ch := ch + '*';
          gotoxy (x, y);
          write (ch);
        end;
      touche_backspace :
        begin
          curseur_milieu;
          profil.password := copy (profil.password, 1, length (profil.password)-1);
          ch := copy (ch, 1, length (ch)-1);
          gotoxy (x, y);
          write (ch, ' ');
          gotoxy (x, y);
          write (ch);
          curseur_pave;
        end;
    end;
  until (((c = touche_return) or (length (profil.password) > 9)) and (profil.password <> ''));
  if (who.password <> profil.password)
  then
    begin
      add_log (ERR_MAJ, who, profil);
      writeln;
      writeln ('Mot de passe non modifi‚, erreur de frappe...');
    end
  else
    begin
      del_user (profil);
      add_user (profil);
      add_log (USER_MAJ, who, profil);
      writeln;
      writeln ('Mot de passe modifi‚.');
    end;
  {endif}
  if (who2.name = who.name)
  then
    set_who (who);
  {endif}
  save_profil;
  curseur_on;
end.
