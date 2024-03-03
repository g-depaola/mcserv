#!/bin/bash

script_dir=$(dirname $0)

# Update and upgrade repositories.
apt update && apt upgrade -y
# Install Java
apt install openjdk-17-jre-headless -y

# Create server directory
mkdir minecraft_server
cd minecraft_server

# Make scripts executable
sudo chmod u+x ${script_dir}/start_server.sh && sudo chmod u+x ${script_dir}/update_eula.sh && sudo chmod u+x ${script_dir}/update_server_properties.sh

# Download server .jar file
wget https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

# Execute start_server.sh
bash .${script_dir}/start_server.sh

# Update EULA
bash .${script_dir}/update_eula.sh

# Execute start_server.sh
bash .${script_dir}/start_server.sh