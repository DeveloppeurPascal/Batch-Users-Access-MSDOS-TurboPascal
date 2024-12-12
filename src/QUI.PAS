program qui;
{
Auteur: Patrick Pr‚martin.
Date: 26/05/1993.
Langage: Turbo Pascal 6.0
But: Affichage du nom de l'utilisateur en cours.
}

uses
    _var,
    f_who;

var
   who : r_who;

begin
  get_who (who);
  writeln (who.name);
end.
