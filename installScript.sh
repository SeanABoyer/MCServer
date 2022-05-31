password=$1
startLog () {
    log_message=$1
    date=$(date '+%d/%m/%Y %H:%M:%S')
    echo "[$date][Starting] $log_message"
}
finishLog () {
    log_message=$1
    date=$(date '+%d/%m/%Y %H:%M:%S')
    echo "[$date][Completed] $log_message"
}

startLog "Updating System"
sudo dpkg --add-architecture i386
sudo apt-get update -y
sudo apt-get upgrade -y
finishLog "Updating System"

startLog "Installing Packages"
sudo apt-get install curl wget file tar bzip2 gzip unzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat openjdk-17-jre lib32gcc-s1 lib32stdc++6 libsdl2-2.0-0:i386 -y
finishLog "Installing Packages"

startLog "Creating User and Changing User"
sudo useradd mcserver -p $password -m
sudo chown -R mcserver:mcserver /home/mcserver
finishLog "Creating User and Changing User"

startLog "Download linuxgsm.sh install server"
sudo -H -u mcserver bash -c "cd ~ && wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh mcserver "
sudo -H -u mcserver bash -c "cd ~ && yes | ./mcserver install"
finishLog "Download linuxgsm.sh and install server"

startLog "Config server"
#Reduce Max Players to 10 players.
sudo -H -u mcserver bash -c "cd ~ && sed -i 's/max-players=20/max-players=10/g' ./serverfiles/server.properties"
#Change How much Ram the JVM Runs on                                /home/mcserver/lgsm/config-lgsm/mcserver
sudo -H -u mcserver bash -c "cd ~ && echo 'javaram="3072"' >> ./lgsm/config-lgsm/mcserver/common.cfg"
finishLog "Config server"

startLog "Start server"
sudo -H -u mcserver bash -c "cd ~ && ./mcserver start"
finishLog "Start server"
