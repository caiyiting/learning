#!/bin/bash
 
LOG_FILE=/var/log/wtmp
if [[ -n $1 ]];
then
    LOG_FILE=$1
fi
 
TMP_ULOG=/tmp/ulog.$$
TMP_USERS=/tmp/users.$$
TMP_USERINFO=/tmp/userinfo.$$
SECONDS_OF_ONE_DAY=86400
TMP_0_SECONDS="00:00"
USER_ONLINE_TIME_TMP_FILE=/tmp/user_online_time.txt
 
printf "%-4s %-10s %-10s %-6s %-8s\n" "Rank" "User" "Start" "Logins" "Usage hours";
last -f $LOG_FILE | head -n -2 | grep -v reboot | grep -v 'still logged in' > $TMP_ULOG 
cat $TMP_ULOG | cut -d ' ' -f1 | sort | uniq > $TMP_USERS 
(
while read USER;
do
    grep ^$USER $TMP_ULOG > $TMP_USERINFO   #纪录用户所有登录信息的临时文件
     
    SECONDS=0
    while read USER_ONLINE_TIME;
    do
        if [ "$USER_ONLINE_TIME" != "$TMP_0_SECONDS" ];
        then
            echo $USER_ONLINE_TIME > $USER_ONLINE_TIME_TMP_FILE
            CHECK_ONLINE_DAY=`grep '+' $USER_ONLINE_TIME_TMP_FILE | wc -l`
            if [ $CHECK_ONLINE_DAY -gt 0 ];  #获取用户在线天数
            then
                COUNT_ONLINE_DAY=$(echo $USER_ONLINE_TIME | cut -d '+' -f1)
                ONLINE_DAY_SECONDS=`expr $SECONDS_OF_ONE_DAY \* $COUNT_ONLINE_DAY`
                USER_ONLINE_TIME=$(echo $USER_ONLINE_TIME | cut -d '+' -f1)
            else
                ONLINE_DAY_SECONDS=0
            fi
 
            TMP_SECONDS=$(date -d $USER_ONLINE_TIME +%s 2> /dev/null)
            SECONDS_0=$(date -d $TMP_0_SECONDS +%s 2> /dev/null)
            let TMP_SECONDS=TMP_SECONDS-SECONDS_0  #去掉取秒时的基准数
            let TMP_SECONDS=TMP_SECONDS+ONLINE_DAY_SECONDS
            let SECONDS=SECONDS+TMP_SECONDS
        fi
    done < <(cat $TMP_USERINFO | awk '{print $NF}' | tr -d ')(')
 
    #获取用户最早登陆时间，具体取第几列字段，要看具体环境
    FIRST_LOG=$(tail -n 1 $TMP_USERINFO | awk '{print $5, $6}') 
    NLOGINS=$(cat $TMP_USERINFO | wc -l)
    HOURS=$(echo "$SECONDS / 60.0" | bc)
    printf "%-10s %-10s %-6s %-8s\n" "$USER" "$FIRST_LOG" "$NLOGINS" "$HOURS"
done < $TMP_USERS
) | sort -nrk 4 | awk '{printf("%-4s %s\n", NR, $0)}' #以总登陆时间做逆序排序，并行首添加序号
 
rm $TMP_USERS $TMP_USERINFO $TMP_ULOG
