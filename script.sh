#!/bin/bash

##實現顯示指定包名APP的ERROR以上級別的日誌，建議崩潰之後，重新開啓此腳本
show_error_log(){
	#先清空屏幕日誌
	adb logcat -c
	echo 請輸入包名
	read package_name

	pid=`adb shell ps | grep $package_name | awk '{print $2}'`
	
	adb logcat -v time  *:E | grep -E --color=auto $pid
}

start_drozer(){
	adb forward tcp:31415 tcp:31415
	drozer console connect
}

show_v_log(){
	echo 請輸入包名
	read package_name

	pid=`adb shell ps | grep $package_name | awk '{print $2}'`
	#先清空屏幕日誌
	adb logcat -c
	adb logcat -v time  *:V | grep -E --color=auto $pid
}

chmod_file_and_subfile(){
	echo 请输入文件夹路径
	read file_path
	sudo chmod 777 -R $file_path
}

start_uml_util(){
	cd /home/yee/tools/SOFTWARE/astah
	sh astah 
}

#顯示指定標籤的所有級別日誌
show_log_with_tag(){
	echo 請輸入tag
	read tag
	
	adb logcat -c
	adb logcat -v time -s $tag
}


release_install_sixfoot(){
	cd /home/yee/dev/git_repo/xingzongex
	#/home/yee/tools/sdk此路径需要是sdk所在路径!也就是说需要将此jar包放在sdk目录中,而不能放在随便一个位置
	export ANT_OPTS="-javaagent:/home/yee/tools/sdk/nbs.newlens.class.rewriter.jar"
	ant clean release install
}

isTingyunEncoded(){
	echo 判断听云是否成功嵌入
	adb logcat -v time -s NBSAgent:V
}

options=(error debug tag tingyun all drozer ant_install_sixfoot chmod_file uml_util)

echo "显示什么?"
select choice in ${options[*]}; do
  break;
done
echo You have selected $choice

case "$choice" in
	${options[0]})
		show_error_log
		;;
	${options[1]})
	
		;;
	${options[2]})
		show_log_with_tag
		;;
	${options[3]})
		isTingyunEncoded
		;;
	${options[4]})
		show_v_log
		;;
	${options[5]})
		start_drozer
		;;
	${options[6]})
		release_install_sixfoot
		;;
	${options[7]})
		chmod_file_and_subfile
		;;
	${options[8]})
		start_uml_util
		;;		
	*)
		echo invalid option
		;;
esac
# scribes.desktop
