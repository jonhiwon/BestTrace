#!/bin/bash

# install BestTrace
echo -e "开始下载BestTrace\n"

if [ ! -f "besttrace" ]; then
    arch=$(uname -m)
    if [ "${arch}" == "x86_64" ]; then
        curl -sL -o besttrace https://github.com/BaeKey/BestTrace/raw/master/besttrace
    elif [ "${arch}" == "aarch64" ]; then
        curl -sL -o besttrace https://github.com/BaeKey/BestTrace/raw/master/besttracearm
    else 
        echo -e "暂未支持\n"
    fi
fi
chmod +x besttrace

## start to use BestTrace

next() {
    printf "%-70s\n" "-" | sed 's/\s/-/g'
}

clear
next

ip_list=(219.141.136.12 202.106.50.1 221.179.155.161 202.96.209.133 210.22.97.1 211.136.112.200 14.215.116.1 211.95.193.97 211.136.20.204 58.60.188.222 210.21.196.6 120.196.165.24)
ip_addr=(北京电信 北京联通 北京移动 上海电信 上海联通 上海移动 广州电信 广州联通 广州移动 深圳电信 深圳联通 深圳移动)

echo -e "开始测试,请稍等...\n"

for i in {0..11}; do
    echo -e "\e[34m ${ip_addr[$i]}\n \e[0m"
    ./besttrace -q 1 ${ip_list[$i]} | grep -v "*"  | tee ./testlog
    
    # judgement
    grep -q "59\.43\." ./testlog
	if [ $? == 0 ];then
		grep -q "202\.97\."  ./testlog
		if [ $? == 0 ];then
		echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:\033[1;32m电信CN2 GT\033[0m"
		else
		echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:\033[1;31m电信CN2 GIA\033[0m"
		fi
	else
		grep -q "202\.97\."  ./testlog
		if [ $? == 0 ];then
			grep -q "219\.158\." ./testlog
			if [ $? == 0 ];then
			echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:\033[1;33m联通169\033[0m"
			else
			echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:\033[1;34m电信163\033[0m"
			fi
		else
			grep -q "219\.158\."  ./testlog
			if [ $? == 0 ];then
				grep -q "219\.158\.113\." ./testlog
				if [ $? == 0 ];then
				echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:\033[1;33m联通AS4837\033[0m"
				else
				echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:\033[1;33m联通169\033[0m"
				fi
			else				
				grep -q "203\.160\."  ./testlog
				if [ $? == 0 ];then
					grep -q "218\.105\." ./testlog
					if [ $? == 0 ];then
					echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:\033[1;33m联通9929\033[0m"
					else
					echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:\033[1;33m联通香港\033[0m"
					fi
				else				
					grep -q "223\.120\."  ./testlog
					if [ $? == 0 ];then
					echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:\033[1;35m移动CMI\033[0m"
					else
						grep -q "221\.183\."  ./testlog
						if [ $? == 0 ];then
						echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:\033[1;35m移动cmi\033[0m"
						else
						echo -e "目标:${ip_addr[i]}[${ip_list[i]}]\t回程线路:其他"
						fi
					fi
				fi
			fi
		fi
	fi
    next
done

# clear
rm -f testlog
rm -f besttrace
