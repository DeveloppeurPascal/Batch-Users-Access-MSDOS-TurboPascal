program login;
{
Auteur: Patrick Pr‚martin.
Date: 24/05/1993.
      26/05/1993.
Langage: Turbo Pascal 6.0
But: Saisie d'un mot de passe pour acc‚der ensuite au DOS.
}
uses
    crt,
    u_code_clavier,
    u_curseur,
    _var,
    f_who,
    f_user,
    f_log;

var
   c : char;
   profil : t_profil;
   ch : string;
   x, y : word;
   ok1, ok2, fin : boolean;

begin
  load_profil;
  textcolor (lightgray);
  textbackground (black);
  clrscr;
  curseur_pave;
  fin := false;
  repeat
    ok1 := false;
    ok2 := false;
    repeat
      repeat
        writeln;
        write ('Login: ');
        x := wherex; y := wherey;
        profil.name := '';
        repeat
          c := readkey;
          case c of
            'a'..'z',
            'A'..'Z',
            '0'..'9' :
              begin
                profil.name := profil.name + upcase (c);
                gotoxy (x, y);
                write (profil.name);
              end;
            touche_backspace :
              begin
                curseur_milieu;
                profil.name := copy (profil.name, 1, length (profil.name)-1);
                gotoxy (x, y);
                write (profil.name, ' ');
                gotoxy (x, y);
                write (profil.name);
                curseur_pave;
              end;
          end;
        until ((c = touche_return) or (length (profil.name) > 9));
        ok1 := valid_profil (profil.name);
      until ok1;
      writeln;
      write ('Password: ');
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
      until ((c = touche_return) or (length (profil.password) > 9));
      ok2 := valid_password (profil);
    until ok2;
    fin := true;
  until fin;
  writeln;
  get_user (profil.name, profil);
  add_log (LOG_IN, profil, profil);
  set_who (profil);
  curseur_bas;
end.
