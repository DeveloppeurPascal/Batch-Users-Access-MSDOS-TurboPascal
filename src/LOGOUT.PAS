program logout;
{
Auteur: Patrick Pr‚martin
Date: 26/05/1993.
      27/05/1993.
      29/05/1993.
Langage: Turbo Pascal 6.0
But: D‚connection d'une session commenc‚e par LOGIN.
}

{$m 4000, 0, 0}

uses
    dos,
    _var,
    f_who,
    f_log;

var
   who : r_who;

begin
  get_who (who);
  add_log (LOG_OUT, who, who);
  who.name := '';
  set_who (who);
  swapvectors;
  exec ('C:\OSPASWRD\LOGIN.EXE','');
  swapvectors;
end.
