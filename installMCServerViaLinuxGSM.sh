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
sudo apt-get update -y
finishLog "Updating System"

startLog "Installing Packages"
sudo apt-get install software-properties-common -y
sudo apt-add-repository contrib
sudo apt-add-repository non-free
sudo dpkg --add-architecture i386
sudo apt update -y
echo steam steam/question select "I AGREE" | sudo debconf-set-selections
echo steam steam/license note '' | sudo debconf-set-selections
sudo apt install curl wget file tar bzip2 gzip unzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat openjdk-17-jre -y
finishLog "Installing Packages"

startLog "Creating User and Changing User"
sudo useradd mcserver -p $password -m
sudo chown -R mcserver:mcserver /home/mcserver
finishLog "Creating User and Changing User"

startLog "Download linuxgsm.sh and install server"
sudo -H -u mcserver bash -c "cd ~ && wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh mcserver && yes | ./mcserver install && ./mcserver start"
finishLog "Download linuxgsm.sh and install server"