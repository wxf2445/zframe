@echo off
@echo ###################################################################
@echo # RAR backup script to backups.
@echo # BACKUP FOR Mysql City to City(WINDOWS)
@echo ###################################################################

set PATH=C:\Program Files\WINRAR;%PATH%
set MYSQLPATH=C:\Program Files\MySQL\MySQL Server 5.0
set BAKPATH=d:\mysql_bak
set USERNAME=root
set PASSWORD=1234567890

rem 请注意选择备份方式，屏蔽其他不需要的(前面加 rem 即可)
rem 使用mysqldump 方式备份
mkdir %BAKPATH%\data
%MYSQLPATH%\bin\mysqladmin -u%USERNAME% -p%PASSWORD% flush-logs
xcopy /e /c /h /y %MYSQLPATH%\data\mysql-bin.* %BAKPATH%\data
rar a -ag %BAKPATH%\diff\ %BAKPATH%\data\mysql-bin.*
rmdir /s /q %BAKPATH%\data\

@echo  %date% %time% dIncremental bakup finish >> C:/mysqlbakup.log