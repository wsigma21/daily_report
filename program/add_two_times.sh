#!/bin/bash

# 引数があるかチェック
if [ -z $1 ]; then
    echo "第一引数として累計学習時間数をhhmm形式で入力してください"
    exit
fi

if [ -z $2 ]; then
    echo "第二引数として今日の時間数をhhmm形式で入力してください"
    exit
fi

# 引数から時間と分を抽出
time1=$(echo $1 | cut -dh -f1 | sed 's/^0\+\([1-9][0-9]*\)$/\1/')
min1=$(echo $1 | cut -dh -f2 | cut -dm -f1 | sed 's/^0\+\([1-9][0-9]*\)$/\1/')
time2=$(echo $2 | cut -dh -f1 | sed 's/^0\+\([1-9][0-9]*\)$/\1/')
min2=$(echo $2 | cut -dh -f2 | cut -dm -f1 | sed 's/^0\+\([1-9][0-9]*\)$/\1/')

# 時間と分を合計
total_time=$((time1 + time2))
total_min=$((min1 + min2))

# 分が60以上の場合は時間に補正
if [ $total_min -ge 60 ]; then
    total_time=$((total_time + total_min / 60))
    total_min=$((total_min % 60))
fi

# 結果を表示
echo "$(printf %02d $total_time)h$(printf %02d $total_min)m"