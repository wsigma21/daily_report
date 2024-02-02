#!/bin/bash

# 累計時間数を記録しているテキストファイルのパスを指定
total_time_text_file_name="total_time.txt"

# テキストファイルが空でないかチェック
if [ ! -s $total_time_text_file_name ]; then
    echo "$total_time_text_file_name に累計時間数をhhmm形式で記載してから実行してください"
    exit
fi

# 累計学習時間の読み取り
read read_total_time < $total_time_text_file_name
time1=$(echo $read_total_time | cut -dh -f1 | sed 's/^0\+\([1-9][0-9]*\)$/\1/')
min1=$(echo $read_total_time | cut -dh -f2 | cut -dm -f1 | sed 's/^0\+\([1-9][0-9]*\)$/\1/')

# 引数チェック
if [ -z $1 ]; then
    echo "第一引数として今日の学習時間数をhhmm形式で入力してください"
    exit
fi

# 引数から今日の学習時間と分を抽出
time2=$(echo $1 | cut -dh -f1 | sed 's/^0\+\([1-9][0-9]*\)$/\1/')
min2=$(echo $1 | cut -dh -f2 | cut -dm -f1 | sed 's/^0\+\([1-9][0-9]*\)$/\1/')


# 時間と分を合計
total_time=$((time1 + time2))
total_min=$((min1 + min2))

# 分が60以上の場合は時間に補正
if [ $total_min -ge 60 ]; then
    total_time=$((total_time + total_min / 60))
    total_min=$((total_min % 60))
fi

# 結果を表示
result="$(printf %02d $total_time)h$(printf %02d $total_min)m"
echo $result

# 結果をファイルに保存
echo $result > $total_time_text_file_name