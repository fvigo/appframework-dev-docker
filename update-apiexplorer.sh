#!/bin/bash

# Install latest apiexplorer (overwrite)
cd /opt
sudo rm -rf apiexplorer-bak
sudo mv apiexplorer apiexplorer-bak
sudo git clone https://github.com/PaloAltoNetworks/apiexplorer.git

# Do not update packages if needed (as a developer might override pancloud)
#cd /opt/apiexplorer
#sudo env "PATH=$PATH" pip install -r requirements.txt

# back it up
sudo rm -rf /opt/panbackup/apiexplorer/*
sudo cp -a /opt/apiexplorer/* /opt/panbackup/apiexplorer/


