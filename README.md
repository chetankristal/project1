# Task1

## Part1
Instructions on running the scripts for the task 

    checkout the GitHub code in home directory:-
    git clone https://github.com/chetankristal/project1.git
    

There are mainly two scripts
  1) apache_log_monitor.sh
  2) main_scripts.sh
  3) update_creds.sh

Run the scripts main_scripts.sh with this command:- bash main_scripts.sh and follow the instructions. For example, check the below
<img width="1298" alt="image" src="https://github.com/chetankristal/project1/assets/90678840/333f778c-04dc-4cf2-8ec1-efd2240bb41e">

Note:- Due to security best practices SMTP creds are saved in the secret manager in JSON format, and will use API calls to get the secret will use while sending email.
    
## Part2
. As time passes, the log files for your application have piled up, and the machine is running out of storage. Briefly describe how you would resolve this in a short paragraph, taking into consideration that:
• On rare occasions, logs up to 3 months old are required for troubleshooting/investigations 
• Audit requirements dictate that logs are to be kept for at least 7 years 
• The machine is currently storing 6 months’ worth of logs, and would run out of  storage within the week. Increasing storage is not an option within the next 12 months 


Solution:- We will analyze recent log patterns to investigate if there's been an unexpected surge in log volume or any adjustments like enabling debug mode at the application level or if the daily log sizes have grown after the recent deployment.

For immediate resolution, I'll employ the 'find' command to locate files older than 90 days, or possibly less, and subsequently upload them to an Amazon S3 bucket before removing them from the server.

Additionally, we'll implement a log rotation strategy using the logrotate utility. This will entail compressing and managing log files, retaining them on the server for 90 days, and transferring older logs to Amazon S3 for archival. We'll also establish a lifecycle policy to transition logs to Amazon S3 Glacier for long-term storage, ensuring logs older than 7 years are eventually purged.



# Task2

. Forked the repo 
    https://github.com/chetankristal/one2onetool.git
. Created a CI and CD pipeline in Jenkins using pipeline script for two branches staging and release

a) Production pipeline scripts :-  https://github.com/chetankristal/one2onetool/blob/release/prod.jenkinsfile
![image](https://github.com/chetankristal/project1/assets/90678840/05c3e7e3-d119-4998-b59e-437d486f518d)




b) Staging pipeline scripts :- https://github.com/chetankristal/one2onetool/blob/staging/staging.jenkinsfile
![image](https://github.com/chetankristal/project1/assets/90678840/f4e6c25a-5662-4b6e-81dc-9f85d401b54b)



An architecture diagram of CI and CD

![iage](https://github.com/chetankristal/project1/assets/90678840/37dc84b9-f98f-4d8a-a873-89eb38bbbfc5)
