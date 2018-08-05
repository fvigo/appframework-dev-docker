FROM jupyter/base-notebook:latest

LABEL maintainer="Palo Alto Networks <techbizdev@paloaltonetworks.com>"

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    git \
    curl \
    gcc \
    linux-libc-dev \
    libc6-dev \   
    vim \
    netcat \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER root

WORKDIR $HOME

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-all.sh"]

# Install latest pancloud library
RUN pip install pancloud

# Install latest apiexplorer
WORKDIR /opt
RUN git clone https://github.com/PaloAltoNetworks/apiexplorer.git
WORKDIR /opt/apiexplorer
RUN pip install -r requirements.txt

# Force an update of pancloud to the latest version (workaround)
RUN pip install -U pancloud

# Prepare DB and credential dirs
RUN mkdir /opt/apiexplorerdb
RUN chown $NB_USER:$NB_GID /opt/apiexplorerdb
RUN fix-permissions /opt/apiexplorerdb

RUN mkdir /opt/pancloud
RUN chown $NB_USER:$NB_GID /opt/pancloud
RUN fix-permissions /opt/pancloud

# Prepare copy of existing pancloud and apiexplorer dir in case a copy script is launched
RUN mkdir /opt/panbackup
RUN cp -a /opt/conda/lib/python3.6/site-packages/pancloud /opt/panbackup
RUN cp -a /opt/apiexplorer /opt/panbackup

# Prepare AppFramework Jupyter Notebooks
WORKDIR /opt/panbackup
RUN git clone https://github.com/PaloAltoNetworks/pancloud-tutorial
RUN cp -a pancloud-tutorial/*.ipynb $HOME/work
RUN chown -R $NB_USER:$NB_GID $HOME/work
RUN fix-permissions $HOME/work
WORKDIR $HOME

# Copy startup scripts
COPY prep-host-dirs.sh /usr/local/bin/
COPY prep-host-notebooks.sh /usr/local/bin/
COPY start-apiexplorer.sh /usr/local/bin/
COPY start-all.sh /usr/local/bin/
COPY update-pancloud.sh /usr/local/bin/
COPY update-apiexplorer.sh /usr/local/bin/
COPY update-notebooks.sh /usr/local/bin/
COPY update-all.sh /usr/local/bin/

# pancloud and apiexplorer env vars
ENV PAN_CREDENTIALS_DBFILE=/opt/pancloud/credentials.json
ENV APIEXPLORER_SKIP_REDIRECT_TO_CSP yes

# Prepare sudoers
RUN echo "$NB_USER        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers


# Expose port 5000 for apiexplorer and 8888 for notebooks
EXPOSE 5000 8888
WORKDIR $HOME

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
