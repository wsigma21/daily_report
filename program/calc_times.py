import sys
import textfile

def main(todays_time):
    # 記録用ファイルのパスを指定
    log_file = 'log.txt'
    # 最新の累計時間をファイルから取得
    f = open(log_file, 'r')
    current_total = f.readline()
    # ファイルが空なら0h0m扱い
    if not current_total:
      current_total = "0h0m"
    f.close()

    # 時刻補正
    hours1, minutes1 = time_correction(current_total)
    hours2, minutes2 = time_correction(todays_time)

    # 学習時間を足す
    total_hours = hours1 + hours2
    total_minutes = minutes1 + minutes2

    # 60分以上なら時間に補正
    if total_minutes >= 60:
        total_hours += total_minutes // 60
        total_minutes %= 60

    # 結果を表示
    result = f"{total_hours:02d}h{total_minutes:02d}m"
    print(result)

    # 結果をファイルの先頭に書き出し
    textfile.insert(log_file, result+'\n', line=0)

def time_correction(time_entered):
    """
    時刻補正用関数

    :param time_entered : "1h02m"のような時刻を表す文字列
    :type time_entered: string
    :returns 時間数と分数
    :rtype: tuple
    """
    # hがなければ0hを追加
    if not "h" in time_entered:
        time_entered = '0h' + time_entered
    # mがなければ0mを追加
    elif not "m" in time_entered:
        time_entered = time_entered + '0m'
    hours = int(time_entered.split('h')[0])
    minutes = int(time_entered.split('h')[1].split('m')[0])
    return hours, minutes

if __name__ == '__main__':
    # 引数チェック
    args = sys.argv
    if len(args) <= 1:
        print("Enter today's study time in a format such as '1h02m'.")
    elif len(args) > 2:
        print("Too many arguments")
    else:
        main(args[1])
