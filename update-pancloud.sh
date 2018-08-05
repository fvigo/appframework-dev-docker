#!/bin/bash

# Update pancloud
sudo env "PATH=$PATH" pip install pancloud -U

# Back it up
sudo rm -rf /opt/panbackup/pancloud/*
sudo cp -a /opt/conda/lib/python3.6/site-packages/pancloud/* /opt/panbackup

