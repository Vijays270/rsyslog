##PROJECT - MONITOR THE REMOTE SERVER LOG (rsyslog-remote system log)

##FOR THIS PROJECT-WE NEED TO CONFIGURE THE MAIN SERVER AND CLIENT SERVER, WITH THE REQUIRED CONFIGURATION 

##MAIN SERVER - WHICH WILL MONITOR THE CLIENT SERVER (REMOTE SERVER) 
##CLIENT SERVER - SERVER WHICH LOGS WHOULD BE TRANSFER TO MAIN SERVER 




# Rsyslog configuration on server 

##command checks if the rsyslog package is installed on your system. If rsyslog is installed, it will display the package name and version. If it is not installed, it will indicate that the package is not installed.
rpm -q rsyslog or yum install rsyslog 


##command will display the current status of the rsyslog service, including whether it is active (running) or inactive (stopped).
systemctl status rsyslog

##command ensures that the rsyslog service starts automatically when the system boots. It does not start the service immediately but sets it to start at boot time.
systemctl enable rsyslog

##command to start rsyslog
systemctl start rsyslog 

## command ensures that the rsyslog service starts automatically when the system boots. It does not start the service immediately but sets it to start at boot time.
systemctl status rsyslog 

## command is necessary to gain the required permissions to edit system configuration files.
vi /etc/rsyslog.conf

##un-comment the lines starting with module and input, to start the port service 514
#Load the imudp Module:
#Find a suitable place in the configuration file to load the imudp module. It’s usually placed near the top of the file with other module loads.

# Include all config files in /etc/rsyslog.d/
include(file="/etc/rsyslog.d/*.conf" mode="optional")  

# Provides UDP syslog reception
# for parameters see http://www.rsyslog.com/doc/imudp.html
module(load="imudp") # needs to be done just once                (UNCOMMENTED-UDP)  
input(type="imudp" port="514")                                   (UNCOMMENTED-UDP)

# Provides TCP syslog reception
# for parameters see http://www.rsyslog.com/doc/imtcp.html
module(load="imtcp") # needs to be done just once                (UNCOMMENTED-TCP)
input(type="imtcp" port="514")                                   (UNCOMMENTED-TCP)

##command to restart rsyslog
systemctl restart rsyslog                                        (AFTER-CONFIGURATION) 



#configure firewalld

#List All Firewall Rules
firewall-cmd --list-all

#To add port 514 for TCP and make the change permanent (survives firewall restarts)
firewall-cmd --permanent --add-port=514/tcp

#to add port 514 for UDP and make the change permanent 
firewall-cmd --permanent --add-port=514/udp

#To apply the changes made with the --permanent flag, you need to reload the firewall
firewall-cmd --reload 


#client side configration 

##command checks if the rsyslog package is installed on your system. If rsyslog is installed, it will display the package name and version. If it is not installed, it will indicate that the package is not installed.
rpm -q rsyslog 

##command will display the current status of the rsyslog service, including whether it is active (running) or inactive (stopped).
systemctl status rsyslog

##command ensures that the rsyslog service starts automatically when the system boots. It does not start the service immediately but sets it to start at boot time.
systemctl enable rsyslog 

##command to start rsyslog
systemctl start rsyslog

##command will display the current status of the rsyslog service, including whether it is active (running) or inactive (stopped)
systemctl  status rsyslog




#rsyslog configuration and firewall configuration on client server



##un comment the lines starting with module and input, to start the port service 514

# Include all config files in /etc/rsyslog.d/
vi /etc/rsylog.conf

include(file="/etc/rsyslog.d/*.conf" mode="optional")

# Provides UDP syslog reception
# for parameters see http://www.rsyslog.com/doc/imudp.html
module(load="imudp") # needs to be done just once
input(type="imudp" port="514")

# Provides TCP syslog reception
# for parameters see http://www.rsyslog.com/doc/imtcp.html
module(load="imtcp") # needs to be done just once
input(type="imtcp" port="514")


##To refresh the configurations
systemctl restart rsyslog


#add the server	IP as the last line of  /etc/rsyslog.conf
vi /etc/rsylog.conf
*.*@@160.56.45.60

#Restart the rsyslog Service:
#To apply the changes, restart the rsyslog service
systemctl restart rsyslog 



##server side :-

# Now check the log message of server b in  server 
systemctl restart rsyslog 


#Monitor Logs in Real-Time: Once you execute the command, tail will start showing the last 10 lines of /var/log/secure. As new lines are added to the file (e.g., when someone logs in or runs a sudo command), they will appear in your terminal.

tail -f /var/log/secure 





