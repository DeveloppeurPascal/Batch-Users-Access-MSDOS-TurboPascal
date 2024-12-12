unit _var;
{
Auteur: Patrick Pr‚martin.
Date: 24/05/1993.
      26/05/1993.
      29/05/1993.
Langage: Turbo Pascal 6.0
But: Description des variables et types de donn‚es.
}
interface

const
     c_nb_max_user = 1000;

type
    string10 = string [10];

    t_code = (USER_CRT, USER_MAJ, USER_DLT, LOG_IN, LOG_OUT, INSTALL_ON, INSTALL_OFF,
              ERR_CRT, ERR_MAJ, ERR_DLT);

    t_securite = (HIGH_LEVEL, MEDIUM_LEVEL, LOW_LEVEL);

    t_profil =
      record
        name : string10;
        password : string10;
        security : t_securite;
      end;

    t_date =
     record
       date : string10;
       heure : string10;
     end;

function erreur (msg : string) : boolean;

implementation

uses
    crt;

function erreur (msg : string) : boolean;
begin
  writeln;
  textcolor (red);
  write (msg);
  textcolor (lightgray);
  writeln;
  erreur := false;
end; { erreur }

begin
  checkbreak := false;
  directvideo := false;
end.
