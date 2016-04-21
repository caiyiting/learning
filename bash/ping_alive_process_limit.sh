#!/bin/bash
THREAD_NUM=20 #允许的进程数

#定义描述符为9的管道
mkfifo tmp
exec 9<>tmp

#预先写入指定数量的换行符，一个换行符代表一个进程
for ((i=0;i<$THREAD_NUM;i++))
do
    echo -ne "\n" 1>&9
done

for ip in 192.168.18.{1..255}
do
{
    #进程控制
    read -u 9
    { 
    ping $ip -c2 &> /dev/null
    if [ $? -eq 0 ];
    then
        echo $ip is alive
    fi  
    echo -ne "\n" 1>&9
    }&
}
done
wait
echo "completed"
rm temp
