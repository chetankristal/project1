#!/bin/bash

#check the number of arguments

if [ $# == 2 ]
then
	echo "Number of argument is correct"
else
	echo "bash <script name> <filename for check error> <email id>"
	exit 1
fi


log_directory=.
file_name=$1
email_id=$2

number_of_failure()
{
	if [ -f "$1"/"$2" ];
	then

		echo "File is exist"
	else

		echo "File is not exist, exiting"
		exit 1	
	fi

	#checking the number of failure 4XX and 5XX
	number_0f_5xx=`grep -iR 'HTTP/1.[0-1]\" 5[0-9][0-9]' "$1"/$2 |wc -l`
	number_0f_4xx=`grep -iR 'HTTP/1.[0-1]\" 4[0-9][0-9]' "$1"/$2 |wc -l`

	cum_error=$(expr $number_0f_4xx + $number_0f_5xx)
        echo cummalative error are $cum_error >error.txt
        echo number_0f_5xx is $number_0f_5xx >>error.txt
        echo number_0f_4xx is $number_0f_4xx >>error.txt

	return $cum_error

}

sending_mail()
{
	echo "ssmtp is installed and credentials are setup in the below ssmtp.conf location"
	if [ $cum_error >100 ]
		then
			echo "errors are more than 100, send email"
			cat error.txt | mail -s "more number of error in apache" $1
		#	cat error.txt | mailx -v -r "chetan11may@gmail.com" -s "more number of error in apache"  -S smtp="email-smtp.ap-southeast-1.amazonaws.com:587" -S smtp-use-starttls -S smtp-auth=login -S smtp-auth-user="<>" -S smtp-auth-password="<>" -S nss-config-dir=/etc/pki/nssdb/ -S ssl-verify=ignore chetan11may@gmail.com

	fi
}



number_of_failure $log_directory $file_name
echo "total number of failure are $?"

sending_mail $email_id
