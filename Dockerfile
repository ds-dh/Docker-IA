FROM dsdh/docker-ds

LABEL maintainer = "Data Science <datascience@digitalhouse.com>"


ENV NB_USER=IA-DH-2018\
	NB_UID=1002

ENV HOME=/home/$NB_USER

USER root

RUN useradd -ms /bin/bash -N -u $NB_UID $NB_USER  && \
    mkdir -p $CONDA_DIR && \
    chown -R $NB_USER:$NB_GID $CONDA_DIR && \
    fix-permissions $HOME && \
	fix-permissions $CONDA_DIR && \
	echo "$NB_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/notebook &&\
	mkdir /home/$NB_USER/notebooks && \
	fix-permissions /home/$NB_USER && \
	usermod -aG sudo $NB_USER

RUN pip_libs='tensorflow \
keras' \
&& pip install --upgrade $pip_libs 

USER $NB_USER
WORKDIR $HOME

CMD ["start-notebook.sh", "--NotebookApp.token=''", "--allow-root"]