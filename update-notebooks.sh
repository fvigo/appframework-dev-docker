#!/bin/bash
# Update AppFramework Jupyter Notebooks
cd /opt/panbackup
sudo rm -rf pancloud-tutorial-bak
sudo mv pancloud-tutorial pancloud-tutorial-bak
sudo git clone https://github.com/PaloAltoNetworks/pancloud-tutorial
sudo rm -rf $HOME/work/*.ipynb
cp -a pancloud-tutorial/*.ipynb $HOME/work
