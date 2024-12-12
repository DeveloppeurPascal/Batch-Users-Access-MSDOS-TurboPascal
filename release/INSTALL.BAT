@echo off

rem INSTALL.BAT
rem Auteur: Patrick Pr‚martin
rem Date: 26/05/1993, 29/05/1993.
rem Langage: MS-DOS BATCH

if exist c:\ospaswrd\install.bat goto fin2

echo Installation de l'utilitaire de protection.
echo ÿ

c: >nul
if errorlevel 1 goto fin
cd \ >nul
if errorlevel 1 goto fin

echo Cr‚ation du r‚pertoire C:\OSPASWRD
md OSPASWRD >nul
if errorlevel 1 goto fin
attrib +h c:\ospaswrd. >nul
if errorlevel 1 goto fin
cd OSPASWRD >nul
if errorlevel 1 goto fin

echo Duplication des programmes.
copy a:install.bat >nul
if errorlevel 1 goto fin
copy a:instal.exe >nul
if errorlevel 1 goto fin
copy a:login.exe >nul
if errorlevel 1 goto fin
copy a:logout.exe >nul
if errorlevel 1 goto fin
copy a:chgpaswd.exe >nul
if errorlevel 1 goto fin
copy a:edt_log.bat >nul
if errorlevel 1 goto fin
copy a:crtuser.exe >nul
if errorlevel 1 goto fin
copy a:dltuser.exe >nul
if errorlevel 1 goto fin
copy a:qui.exe >nul
if errorlevel 1 goto fin

echo Cr‚ation des fichiers de donn‚es.
copy c:\autoexec.bat autoexec.old >nul
if errorlevel 1 goto fin
copy c:\autoexec.bat c:\autoexec.bak >nul
if errorlevel 1 goto fin
attrib +r *.*
instal.exe
if errorlevel 1 goto fin
if exist c:\autoexec.$$$ attrib -r c:\autoexec.bat >nul
if errorlevel 1 goto fin
if exist c:\autoexec.$$$ del c:\autoexec.bat >nul
if errorlevel 1 goto fin
if exist c:\autoexec.$$$ ren c:\autoexec.$$$ autoexec.bat >nul
if errorlevel 1 goto fin

logout.exe

:fin
echo Une erreur s'est produite, contactez votre fournisseur.
:fin2
echo on
