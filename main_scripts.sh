#!/bin/bash

read -p "Would you like to schedule the Apache log monitoring scripts to run hourly in crontab? (yes/no) If you choose "no," they will run once and provide the output.:" value

folder_name=`pwd`

read_variable()
{
        read -p "enter the log file name:" log_file_name
        file_name=$log_file_name
        read -p "enter the email id:" email_id
        email="$email_id"
}


if [[ "$value" == "yes" ]]
then
	read_variable
	crontab -l > crontab_new
	chmod +x $folder_name/apache_log_monitor.sh
	grep apache_log_monitor.sh crontab_new
	if [[ $? != 0 ]]
	then
		echo "0 */1 * * * $folder_name/apache_log_monitor.sh $file_name $email " >> crontab_new
		crontab crontab_new
		echo "adding in the crontab"
	else
		echo "already present in the crontab, so exiting"
		exit 1
	fi

	rm crontab_new
elif [[ "$value" == "no" ]]
then	
        
	read_variable
	bash -x $folder_name/apache_log_monitor.sh $file_name $email
else
	echo "exiting"
	exit 1
fi

