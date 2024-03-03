### mcserv

# Administrative scripts for MC server.
How to use this repository:
1. Clone repository to server.
2. Navigate to repo directory.
3. Run command: ```sudo chmod u+x initial_setup.sh```
4. Execute the script: ```./initial_setup.sh```
5. Stop the server with the "stop" command and execute the script: ```./update_server_properties``` to change the server properties from defaults. Running the command with no arguments displays the usage information.
6. Kick back and relax B)

Run ```./start_server.sh``` to start the server manually. This script can be modified to change the memory allocation for the server.
