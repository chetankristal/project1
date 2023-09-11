#!/bin/bash

rm -rf /tmp/ssmtp.conf.template

cp ssmtp.conf.template /tmp/ssmtp.conf.template

secret_manager_arn=arn:aws:secretsmanager:ap-south-1:431350620989:secret:smtp_credentials-Zn2mms

if [ -z "${secret_manager_arn}" ] || [ "${secret_manager_arn}" == "null" ]; then >&2 echo "Secret Manager ARN Details not found"; exit 1; fi

region=$(echo ${secret_manager_arn} | cut -d':' -f4)
extra=""
if [[ -z "${region}" ]]; then >&2 echo "Invalid SECRET_MANAGER_ARN Format"
else extra="--region ${region}"; fi

aws secretsmanager get-secret-value --secret-id ${secret_manager_arn} ${extra} | jq .SecretString -r > /tmp/secret_manager_output.json

smtpServer=$(cat /tmp/secret_manager_output.json | jq .smtpServer -r)
if [ -z "${smtpServer}" ]; then >&2 echo "Host not Found"; exit 1; fi


smtpPort=$(cat /tmp/secret_manager_output.json | jq .smtpPort -r)
if [ -z "${smtpPort}" ]; then >&2 echo "Host not Found"; exit 1; fi


smtpUser=$(cat /tmp/secret_manager_output.json | jq .smtpUser -r)
if [ -z "${smtpUser}" ]; then >&2 echo "Username not Found"; exit 1; fi

smtpPassword=$(cat /tmp/secret_manager_output.json | jq .smtpPassword -r)
if [ -z "${smtpPassword}" ]; then >&2 echo "Password not Found"; exit 1; fi


smtpFromLineOverride=$(cat /tmp/secret_manager_output.json | jq .smtpFromLineOverride -r)
if [ -z "${smtpFromLineOverride}" ]; then >&2 echo "Password not Found"; exit 1; fi

smtpSTARTTLS=$(cat /tmp/secret_manager_output.json | jq .smtpSTARTTLS -r)
if [ -z "${smtpSTARTTLS}" ]; then >&2 echo "Password not Found"; exit 1; fi

echo FromLineOverride=$smtpFromLineOverride >>/tmp/ssmtp.conf.template
echo AuthUser=$smtpUser >>/tmp/ssmtp.conf.template
echo AuthPass=$smtpPassword >>/tmp/ssmtp.conf.template
echo mailhub=$smtpServer:$smtpPort >>/tmp/ssmtp.conf.template
echo UseSTARTTLS=$smtpSTARTTLS >>/tmp/ssmtp.conf.template

cat /tmp/ssmtp.conf.template

cat /tmp/secret_manager_output.json

sudo cp -rf /tmp/ssmtp.conf.template /etc/ssmtp/ssmtp.conf


rm -rf /tmp/ssmtp.conf.template /tmp/secret_manager_output.json
