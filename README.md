# Application Framework Hackaton Docker Image

This Docker Image is useful to easily develop with Application Framework

It includes the following:
- A base ubuntu (18.04) Image
- Jupyter notebooks
- Python 3.6
- Misc dev tools (curl, wget, vim, gcc, git)
- pancloud (latest)
- apiexplorer (latest)

By default the container will run the following services:
- Jupyter notebooks (listening on port 8888)
- apiexplorer (listening on port 5000)

By default the container runs both Jupyter Notebooks (on port 8888) and API Explorer (on port 5000): you can run both at the same time, or each separately (see the examples below)

Just run the container:
```
docker run --rm -p 8888:8888 -p 5000:5000 -it fvigo/appframework-dev:latest
```

You can also run a bash in interactive mode by running:
`docker run --rm -it fvigo/appframework-dev:latest /bin/bash`

You can run API Explorer in Debug mode by adding the `-e APIEXPLORER_DEBUG=yes` to the command line (it will still run on port 5000 without SSL)

The system is configured to share the credentials between pancloud and the notebooks, using a a common credentials file (`/opt/pancloud/credentials.json`)

You can mount the following host volumes to override the default behavior:
- /opt/pancloud (to override the credentials.json credentials cache file) [**Note**: this directory must be writable by UID 1000 on the host]
- /opt/conda/lib/python3.6/site-packages/pancloud to override the pancloud version or modify it
- /opt/apiexplorer to override the apiexplorer version or modify it
- /opt/apiexplorerdb to override the api explorer DB settings (instance_id, users, etc) [**Note**: this directory must be writable by UID 1000 on the host]
- /home/developer/work to override the Jupyter Notebook location

You can override multiple volumes at the same time by using -v multiple times

*Note*: if you want override the pancloud and apiexplorer folders with empty directories on the host, you can run the prep-hostdirs.sh script that will copy the existing versions to the empty host dir that you can later modify (see example later). If you want to override the notebooks, run the prep-host-notebooks.sh script.

## Examples

### Override the credentials path with the default of your host (~/config/pancloud/credentials.json)
```
host~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/.config/pancloud:/opt/pancloud --it fvigo/appframework-dev:latest
```
### Override the API Explorer DB path with a local folder on your host (~/apiexplorerdb)
```
host~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/apiexplorerdb:/opt/apiexplorerdb --it fvigo/appframework-dev:latest
```
### Override the apiexplorer with the latest version you download from Github
```
host:~$ git clone https://github.com/PaloAltoNetworks/apiexplorer.git
host:~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/apiexplorer:/opt/apiexplorer -it fvigo/appframework-dev:latest
```
### Override the pancloud with the latest version you download from Github
```
host:~$ git clone https://github.com/PaloAltoNetworks/pancloud.git
host:~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/pancloud/pancloud:/opt/conda/lib/python3.6/site-packages/pancloud -it fvigo/appframework-dev:latest 
```
### Override the apiexplorer with the latest version you download from Github
```
host:~$ git clone https://github.com/PaloAltoNetworks/apiexplorer.git
host:~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/apiexplorer:/opt/apiexplorer -it fvigo/appframework-dev:latest
```
### Copy existing pancloud and apiexplorer to empty host directories
```
host:~$ docker run --rm -v $HOME/pancloud-dev:/opt/conda/lib/python3.6/site-packages/pancloud -v $HOME/apiexplorer-dev:/opt/apiexplorer -it fvigo/appframework-dev:latest /usr/local/bin/prep-host-dirs.sh
```
### Override the Jupyter Notebooks location to your $HOME/notebooks directory
```
host:~$ run --rm -p 8888:8888 -p 5000:5000 -v $HOME/notebooks:/home/developer/work -it fvigo/appframework-dev:latest /usr/local/bin/prep-host-notebooks.sh
```
### Copy existing notebooks in a empty host directory
```
host:~$ run --rm -p 8888:8888 -p 5000:5000 -v $HOME/notebooks:/home/developer/work -it fvigo/appframework-dev:latest /usr/local/bin/prep-host-dirs.sh
```
### Run a shell inside the container
```
host:~$ docker run --rm -it fvigo/appframework-dev:latest /bin/bash
```
### Run the container (starting both Jupyter Notebook and API explorer)
```
host:~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/pancloud-dev:/opt/conda/lib/python3.6/site-packages/pancloud -v $HOME/apiexplorer-dev:/opt/apiexplorer -v $HOME/apiexplorerdb:/opt/apiexplorerdb -v $HOME/.config/credentials:/opt/pancloud -it fvigo/appframework-dev:latest
```
### Starting only the Jupyter Notebook
```
docker run --rm -p 8888:8888 -it fvigo/appframework-dev:latest start-notebook.sh
```
### Starting only API Explorer
```
docker run --rm -p 5000:5000 -it fvigo/appframework-dev:latest apiexplorer.sh
```
### Start only API explorer in debug mode
```
docker run --rm -p 5000:5000 -e APIEXPLORER_DEBUG=yes -it fvigo/appframework-dev:latest apiexplorer.sh
```
# Application Framework Hackaton Docker Image

This Docker Image is useful to easily develop with Application Framework

It includes the following:
- A base ubuntu (18.04) Image
- Jupyter notebooks
- Python 3.6
- Misc dev tools (curl, wget, vim, gcc, git)
- pancloud (latest)
- apiexplorer (latest)

By default the container will run the following services:
- Jupyter notebooks (listening on port 8888)
- apiexplorer (listening on port 5000)

By default the container runs both Jupyter Notebooks (on port 8888) and API Explorer (on port 5000): you can run both at the same time, or each separately (see the examples below)

Just run the container:
```
docker run --rm -p 8888:8888 -p 5000:5000 -it fvigo/appframework-dev:latest
```

You can also run a bash in interactive mode by running:
`docker run --rm -it fvigo/appframework-dev:latest /bin/bash`

You can run API Explorer in Debug mode by adding the `-e APIEXPLORER_DEBUG=yes` to the command line (it will still run on port 5000 without SSL)

The system is configured to share the credentials between pancloud and the notebooks, using a a common credentials file (`/opt/pancloud/credentials.json`)

You can mount the following host volumes to override the default behavior:
- /opt/pancloud (to override the credentials.json credentials cache file) [**Note**: this directory must be writable by UID 1000 on the host]
- /opt/conda/lib/python3.6/site-packages/pancloud to override the pancloud version or modify it
- /opt/apiexplorer to override the apiexplorer version or modify it
- /opt/apiexplorerdb to override the api explorer DB settings (instance_id, users, etc) [**Note**: this directory must be writable by UID 1000 on the host]
- /home/developer/work to override the Jupyter Notebook location

You can override multiple volumes at the same time by using -v multiple times

*Note*: if you want override the pancloud and apiexplorer folders with empty directories on the host, you can run the prep-hostdirs.sh script that will copy the existing versions to the empty host dir that you can later modify (see example later). If you want to override the notebooks, run the prep-host-notebooks.sh script.

## Examples

### Override the credentials path with the default of your host (~/config/pancloud/credentials.json)
```
host~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/.config/pancloud:/opt/pancloud --it fvigo/appframework-dev:latest
```
### Override the API Explorer DB path with a local folder on your host (~/apiexplorerdb)
```
host~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/apiexplorerdb:/opt/apiexplorerdb --it fvigo/appframework-dev:latest
```
### Override the apiexplorer with the latest version you download from Github
```
host:~$ git clone https://github.com/PaloAltoNetworks/apiexplorer.git
host:~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/apiexplorer:/opt/apiexplorer -it fvigo/appframework-dev:latest
```
### Override the pancloud with the latest version you download from Github
```
host:~$ git clone https://github.com/PaloAltoNetworks/pancloud.git
host:~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/pancloud/pancloud:/opt/conda/lib/python3.6/site-packages/pancloud -it fvigo/appframework-dev:latest 
```
### Override the apiexplorer with the latest version you download from Github
```
host:~$ git clone https://github.com/PaloAltoNetworks/apiexplorer.git
host:~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/apiexplorer:/opt/apiexplorer -it fvigo/appframework-dev:latest
```
### Copy existing pancloud and apiexplorer to empty host directories
```
host:~$ docker run --rm -v $HOME/pancloud-dev:/opt/conda/lib/python3.6/site-packages/pancloud -v $HOME/apiexplorer-dev:/opt/apiexplorer -it fvigo/appframework-dev:latest /usr/local/bin/prep-host-dirs.sh
```
### Override the Jupyter Notebooks location to your $HOME/notebooks directory
```
host:~$ run --rm -p 8888:8888 -p 5000:5000 -v $HOME/notebooks:/home/developer/work -it fvigo/appframework-dev:latest /usr/local/bin/prep-host-notebooks.sh
```
### Copy existing notebooks in a empty host directory
```
host:~$ run --rm -p 8888:8888 -p 5000:5000 -v $HOME/notebooks:/home/developer/work -it fvigo/appframework-dev:latest /usr/local/bin/prep-host-dirs.sh
```
### Run a shell inside the container
```
host:~$ docker run --rm -it fvigo/appframework-dev:latest /bin/bash
```
### Run the container (starting both Jupyter Notebook and API explorer)
```
host:~$ docker run --rm -p 8888:8888 -p 5000:5000 -v $HOME/pancloud-dev:/opt/conda/lib/python3.6/site-packages/pancloud -v $HOME/apiexplorer-dev:/opt/apiexplorer -v $HOME/apiexplorerdb:/opt/apiexplorerdb -v $HOME/.config/credentials:/opt/pancloud -it fvigo/appframework-dev:latest
```
### Starting only the Jupyter Notebook
```
docker run --rm -p 8888:8888 -it fvigo/appframework-dev:latest start-notebook.sh
```
### Starting only API Explorer
```
docker run --rm -p 5000:5000 -it fvigo/appframework-dev:latest apiexplorer.sh
```
### Start only API explorer in debug mode
```
docker run --rm -p 5000:5000 -e APIEXPLORER_DEBUG=yes -it fvigo/appframework-dev:latest apiexplorer.sh
```

