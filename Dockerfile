FROM jupyter/base-notebook

LABEL maintainer = "Data Science <datascience@digitalhouse.com>"

#CMD ["/bin/bash", "useradd", "--disabled-password", "--create-home", "--shell", "/bin/bash", "-u", "1001", "-U", "100", "DS-DH-2018"]

ENV NB_USER=DS-DH-2018\
	NB_UID=1001

ENV HOME=/home/$NB_USER

USER root

RUN useradd -ms /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    fix-permissions $HOME && \
	fix-permissions $CONDA_DIR


USER $NB_USER

RUN mkdir /home/$NB_USER/notebooks && \
	fix-permissions /home/$NB_USER

#RUN conda install --yes 'numpy' 
# 'scipy'\
# 'statsmodels'\
# 'sklearn'

#RUN conda install --yes 'matplotlib' 'seaborn'

USER $NB_USER
WORKDIR $HOME

CMD ["bash"]