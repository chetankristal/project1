# Task1
Creating this repo with an intent to make Kubernetes easy for begineers. This is a work-in-progress repo.

## Part1
Instructions on running the scripts for the task 

    checkout the gihub code:-
    git clone https://github.com/chetankristal/project1.git
    

There are mainly two scripts
  1) apache_log_monitor.sh
  2) main_scripts.sh

Run the scripts main_scripts.sh with this command:- bash main_scripts.sh and follow the instructions. For example, check the below
<img width="1298" alt="image" src="https://github.com/chetankristal/project1/assets/90678840/333f778c-04dc-4cf2-8ec1-efd2240bb41e">


    
## Part2
. As time passes, the log files for your application have piled up, and the machine is running out of storage. Briefly describe how you would resolve this in a short paragraph, taking into consideration that:
• On rare occasions, logs up to 3 months old are required for troubleshooting/investigations 

Solution:- We will examine recent log patterns to investigate whether there has been a sudden increase in log volume or not. We will also check that at the application's level have we enabled debug mode to trace certain issues, or if the daily log sizes have grown after the recent deployment. 

For the immediate fix, I will utilize the 'find' command to identify files older than 90 days, or maybe less. Subsequently, I will upload these files to S3 and promptly remove them from the server.
            
• Audit requirements dictate that logs are to be kept for at least 7 years • The machine is currently storing 6 months’ worth of logs, and would run out of  storage within the week. Increasing storage is not an option within the next 12 months  

Solution:- Now I will use the logrotate utility to implement and manage log files by rotating and compressing them, will keep the log of 90 days on the server and older logs can be uploaded in S3 and we will apply a lifecycle policy to transition logs to Amazon S3 Glacier for long-term storage and Any logs that are older than 7 years will be subject to deletion.


# Task2

. Forked the repo 
    https://github.com/chetankristal/one2onetool.git
. Created a CI and CD pipeline in Jenkins using pipeline script for two branches staging and release
    a) Production pipeline scripts :-  https://github.com/chetankristal/project1/blob/main/jenkins_file/prod.jenkinsfile
        ![image](https://github.com/chetankristal/project1/assets/90678840/e8669cda-9c6b-4e69-9efd-97e9255efc17)
    b) Staging pipeline scripts :- https://github.com/chetankristal/project1/blob/main/jenkins_file/staging.jenkinsfile
        ![image](https://github.com/chetankristal/project1/assets/90678840/5b46207b-de25-4480-87f9-35d509f90f80)

An architecture diagram of CI and CD
![image](https://github.com/chetankristal/project1/assets/90678840/37dc84b9-f98f-4d8a-a873-89eb38bbbfc5)
