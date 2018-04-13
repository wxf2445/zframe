@echo off
@echo ###################################################################
@echo # RAR backup script to backups.
@echo # BACKUP FOR Mysql City to City(WINDOWS) 
@echo ###################################################################
 
set PATH=C:\Program Files\WINRAR;%PATH%
set MYSQLPATH=C:\Program Files\MySQL\MySQL Server 5.0
set BAKPATH=d:\mysql_bak

mkdir %BAKPATH%\data
 
%MYSQLPATH%\bin\mysqldump -u%1 -p%2 --single-transaction --default-character-set=utf8 --flush-logs --master-data=2 --delete-master-logs spirit_beast > %BAKPATH%\data\spirit_beast%date:~0,10%.sql
%MYSQLPATH%\bin\mysqldump -u%1 -p%2 --single-transaction --default-character-set=utf8 --flush-logs --master-data=2 --delete-master-logs quartz_event > %BAKPATH%\data\quartz_event%date:~0,10%.sql
rar a -ag %BAKPATH%\full\ %BAKPATH%\data\*.sql

rmdir /s /q %BAKPATH%\data\

@echo  %date% %time% full bakup finish >> C:/mysqlbakup.log