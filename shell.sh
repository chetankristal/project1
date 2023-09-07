#!/bin/bash

read -p "do you want to add the apache log monitor  scripts in crontab to execute every hour , ans should be in yes or no [yes/no]:  " value

folder_name=./

read_variable()
{
        read -p "enter the log file name:" log_file_name
        file_name=$log_file_name
        read -p "enter the email id:" email_id
        email=$email_id
}


if [[ "$value" == "yes" ]]
then
#	read -p "enter the log file name:" log_file_name
#	file_name=$log_file_name
#	read -p "enter the email id:" email_id
#	email=$email_id
	read_variable
	crontab -l > crontab_new
	chmod +x $folder_name/apache_log_monitor.sh
	grep apache_log_monitor.sh crontab_new
	if [[ $? == 0 ]]
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
        
#	read -p "enter the log file name:" log_file_name
#        file_name=$log_file_name
#        read -p "enter the email id:" email_id
#        email=$email_id
	read_variable
	bash $folder_name/apache_log_monitor.sh $file_name $email
else
	echo "exiting"
	exit 1
fi

