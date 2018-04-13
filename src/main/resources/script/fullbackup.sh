# vim /root/DBFullyBak.sh //添加以下内容
#!/bin/bash
# Program
#    use mysqldump to Fully backup mysql data per week!
# History
#    2013-04-27 guo     first
# Path
#    ....
BakDir=/home/jtang/mysql/backup/full
LogFile=/home/jtang/mysql/backup/bak.log
Date=`date +%Y%m%d`
Begin=`date +"%Y年%m月%d日 %H:%M:%S"`
cd $BakDir
DumpFile=$Date.sql
#GZDumpFile=$Date.sql.tgz
mysqldump -ujtang -pjtang123 --quick recordms --flush-logs --delete-master-logs --single-transaction > $DumpFile
#/bin/tar czvf $GZDumpFile $DumpFile
#/bin/rm $DumpFile
Last=`date +"%Y年%m月%d日 %H:%M:%S"`
echo 开始:$Begin 结束:$Last $DumpFile succ >> $LogFile
cd $BakDir/daily
rm -f *